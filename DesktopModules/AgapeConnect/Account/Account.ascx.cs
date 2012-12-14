using System;
using System.Linq;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using MinistryViewDS;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using System.Xml;

namespace DotNetNuke.Modules.Account
{
    using DotNetNuke.Entities.Modules;
    using MinistryViewDS;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Data;

    public partial class AccountReport : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        
       
        DateTime _startDate, _endDate;
       



        public String _googleGraph = "";
        private Dictionary<string, string> _accountCodes = new Dictionary<string, string>();
        private Dictionary<string, string> _donorCodes = new Dictionary<string, string>();

        private  dynamicTnT.TntMPDDataServerWebService dTnT = new dynamicTnT.TntMPDDataServerWebService();
        private dynamicTnT.FinancialAccount[] tntAccounts;
        private  dynamicTnT.Designation[] tntDesignations;
        private dynamicTnT.FinancialTransaction[] tntTransactions;
        private dynamicTnT.Gift[] donations;

        private double avgIncome = 0.0;
           private double avgExpense = 0.0;
        private double avgBalance = 0.0 ;
        private Boolean overlap2 = false;



        public string GetMonth(int offset)
        {
            DateTime theDate = _endDate.AddMonths(offset);

            return theDate.ToString("MMM yy");
        }
        public string getGoogleData()
        {


            return _googleGraph;
        }
        protected void Page_Load(object sender, EventArgs e)
         {
             _startDate = FirstDayOfMonthFromDateTime(DateTime.Today.AddMonths(-12));
             _endDate = LastDayOfMonthFromDateTime(DateTime.Today);
             if (!Page.IsPostBack)
             {
                //First Load Countries From Thads Search

                 DSPortalsService.DSPortalsSoapClient dsw = new DSPortalsService.DSPortalsSoapClient();
                 var ssoGUID = UserInfo.Profile.GetPropertyValue("ssoGUID");
                 var resp = dsw.GetPortalsForUserJson(ssoGUID ).Distinct();
               var thisInstance = StaffBrokerFunctions.GetSetting("DataserverURL", PortalId);

           //    MyCountries.Items.Add(new ListItem("South Africa", "https://tntdataserver.com/dataserver/rsa/dataquery/dataqueryservice.asmx"));


                 foreach (DSPortalsService.DataserverPortal  p in resp.OrderByDescending(x => x.InstanceUri.Contains(thisInstance)).ThenBy(y => y.InstanceName ))
                 {
                      MyCountries.Items.Add(new ListItem(p.InstanceName , p.InstanceUri ));
                  
                 }


                //MyCountries.Items.Add(new ListItem("devtest","https://tntdataserver.eu/dataserver/devtest/dataquery/dataqueryservice.asmx"));
                //MyCountries.Items.Add(new ListItem("AgapeAOA","https://tntdataserver.eu/dataserver/AgapeAOA/dataquery/dataqueryservice.asmx"));
                
                 
                
                
                 ////
                 MyCountries_SelectedIndexChanged(this, null);


             }



          //   InitializeValues();
        }

        protected void ReloadTablesAndGraphs()
        {
           


            if (dTnT.Url != MyCountries.SelectedValue)
            {
                dTnT.Url = MyCountries.SelectedValue;
                dTnT.Discover();
            }
            string sessionId = (string)Session["TnT-" + MyCountries.SelectedItem.Text];
            if (string.IsNullOrEmpty(sessionId))
            {
                string service =  dTnT.GetServiceName();
                string pt = getPT(service);
                string UserName;
                bool IsReg;
                sessionId = dTnT.Login(service, pt, true, out UserName, out IsReg);
                Session.Add("TnT-" + MyCountries.SelectedItem.Text, sessionId);
            }

            tntTransactions = dTnT.GetFinancialTransactions(sessionId, MyProfiles.SelectedValue, _startDate, _endDate, (MyAccounts.SelectedValue == "All Accounts" ? "" : MyAccounts.SelectedValue), false, out tntAccounts);
            StartingBalance.Text = tntAccounts.Sum(x => x.BeginningBalance).ToString("0");
            EndingBalance.Text = tntAccounts.Sum(x => x.EndingBalance).ToString("0");

             donations = dTnT.GetGiftsReceived(sessionId, MyProfiles.SelectedValue, _startDate, _endDate, (MyAccounts.SelectedValue == "All Accounts" ? "" : MyAccounts.SelectedValue));



            DataTable IncomeTable;
            IncomeTable = SummaryTable(true, true, Translate("lblIncome"));
            gvIncome.DataSource = IncomeTable;
            gvIncome.DataBind();
            SetColumnWidth(ref gvIncome, System.Drawing.Color.Blue, true);

            DataTable IncomeGLSummaryTable;
            IncomeGLSummaryTable = SummaryTable(true, false);
            gvIncomeGLSummary.DataSource = IncomeGLSummaryTable;
            gvIncomeGLSummary.DataBind();
            SetColumnWidth(ref gvIncomeGLSummary, System.Drawing.Color.Black);


            DataTable DonationsTable;
            DonationsTable = SummaryTable(false, false, "", true);
            

            gvDonationSummary.DataSource = DonationsTable;
            gvDonationSummary.DataBind();
            SetColumnWidth(ref gvDonationSummary,  System.Drawing.Color.Black);



            DataTable ExpensesTable;
            ExpensesTable = SummaryTable(false, true, Translate("lblExpenses"));
            if ((ExpensesTable != null) && (ExpensesTable.Rows.Count != 0))
                gvExpenses.DataSource = ExpensesTable;
            gvExpenses.DataBind();
            SetColumnWidth(ref gvExpenses, System.Drawing.Color.Red, true);


            DataTable ExpensesGLSummaryTable;
            ExpensesGLSummaryTable = SummaryTable(false, false);
            if ((ExpensesGLSummaryTable != null) && (ExpensesGLSummaryTable.Rows.Count != 0))
                gvExpensesGLSummary.DataSource = ExpensesGLSummaryTable;
            gvExpensesGLSummary.DataBind();
            SetColumnWidth(ref gvExpensesGLSummary, System.Drawing.Color.Black);

            DataTable BalanceTable = new DataTable();

            BalanceTable.Columns.Add("Balance");
            DateTime i = _startDate;
            while (i < _endDate.AddMonths(0))
            {
                BalanceTable.Columns.Add(i.Year.ToString() + " - " + i.Month.ToString());
                i = i.AddMonths(1);
            }
            i = _startDate;
            double balCounter =  Convert.ToDouble(StartingBalance.Text);
            BalanceTable.Rows.Add();
            _googleGraph = "";

            avgBalance = 0.0;

            foreach (DataColumn col in BalanceTable.Columns)
            {
                int index = BalanceTable.Columns.IndexOf(col);
                if (index == 0) BalanceTable.Rows[0][col.ColumnName] = Translate("lblBalance");
                else
                {

                    balCounter += DecodeNumberString((string)IncomeTable.Rows[0][index]) - DecodeNumberString((string)ExpensesTable.Rows[0][index]);
                    if (index > 6 && index <13 )
                    {
                        avgBalance += balCounter/6.0;
                        
                    }

                    BalanceTable.Rows[0][index] =  FormatNumber( balCounter);
                  //  _googleGraph += "data.addRow(['" + GetMonth(index - 13) + "', " + DecodeNumberString((string)IncomeTable.Rows[0][index]) + ", " + (BalanceTable.Columns.IndexOf(col) == 13 ?  avgIncome.ToString() : "") + ",'', " + DecodeNumberString((string)ExpensesTable.Rows[0][index]) + ", " + (BalanceTable.Columns.IndexOf(col) == 13 ? avgExpense.ToString() : "") + ",'',  " + (BalanceTable.Columns.IndexOf(col) == 13 ? Math.Round( avgBalance).ToString() : "") + ", '',  " + DecodeNumberString((string)BalanceTable.Rows[0][index]) + "]);" + Environment.NewLine;
                    _googleGraph += "data.addRow(['" + GetMonth(index - 13) + "', " + DecodeNumberString((string)IncomeTable.Rows[0][index]) + ", " + ((index > 6 && (BalanceTable.Columns.IndexOf(col) < 13)) ? avgIncome.ToString() : "") + "," + (index == 12 ? "'" + Translate("lblAvgIncome") + FormatNumber(avgIncome) + "'" : "''") + ", false, " + DecodeNumberString((string)ExpensesTable.Rows[0][index]) + ", " + DecodeNumberString((string)BalanceTable.Rows[0][index]) + "]);" + Environment.NewLine;

                }
            }
            

            if ((BalanceTable != null) && (BalanceTable.Rows.Count != 0))
            {
                gvBalance.DataSource = BalanceTable;
                gvBalance.DataBind();

                SetColumnWidth(ref gvBalance, (System.Drawing.Color)System.Drawing.ColorTranslator.FromHtml("#FF9900"), true);
            }


            saveTransactions();
            





        }

        public string Translate(String ResourceString)
        {
            return DotNetNuke.Services.Localization.Localization.GetString(ResourceString + ".Text", LocalResourceFile );
        }

   
        
        private void saveTransactions()
        {
            string data = "[";
            foreach (dynamicTnT.FinancialTransaction  transaction in tntTransactions)
            {
            
                data += @"{""AC"": """ + transaction.GLAccountCode + @""","
                     + @"""Am"": """ + (transaction.GLAccountIsIncome ? transaction.Amount.ToString("0.00") : (-transaction.Amount).ToString("0.00")) + @""","
                     + @"""De"": """ + Server.HtmlEncode(System.Text.RegularExpressions.Regex.Replace(transaction.Description, @"\r\n?|\n", " ")) + @""","
                    + @"""Me"": """  + @""","
                     
                     + @"""Dt"": """ + transaction.TransactionDate.ToShortDateString() + @""","
                     + @"""Pe"": """ + transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month + @"""}," + Environment.NewLine;
            
            }
            foreach (dynamicTnT.Gift transaction in donations )
            {

                data += @"{""AC"": """ + transaction.DonorCode  + @""","
                     + @"""Am"": """ + (transaction.Amount ) + @""","
                     + @"""De"": """ + Server.HtmlEncode(System.Text.RegularExpressions.Regex.Replace(transaction.DonorName, @"\r\n?|\n", " ")) + @""","
                      + @"""Me"": """ + Server.HtmlEncode(System.Text.RegularExpressions.Regex.Replace( transaction.PaymentMethodCode, @"\r\n?|\n", " ")) + @""","
                    
                     + @"""Dt"": """ + transaction.GiftDate .ToShortDateString() + @""","
                     + @"""Pe"": """ + transaction.GiftDate.Year + " - " + transaction.GiftDate.Month + @"""}," + Environment.NewLine;

            }



            data = data.TrimEnd('\r', '\n',',');
            hfTransactions.Value = data + "]";
        }

        private void SetColumnWidth(ref GridView gv, System.Drawing.Color color, Boolean isTitle = false)
        {
            if (gv.Rows.Count > 0)
            {
                foreach (TableCell col in gv.Rows[0].Cells)
                {
                    col.Width = Unit.Percentage(6.2);

                }
                gv.Rows[0].Cells[0].Width = Unit.Percentage(19.4);
                if (isTitle)
                {
                    gv.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Left;
                    gv.Rows[0].Cells[0].Font.Bold = true;
                }
                gv.Rows[0].Cells[0].ForeColor = color;
           
                foreach (TableRow row in gv.Rows)
                {
                    row.Cells[row.Cells.Count - 1].Font.Bold = true;

                }

            }

        }

       

        public DataTable SummaryTable(bool IsIncome, bool IsIE, string title = "", bool IsDonations = false)
        {
            int counter = 0;
            string currentGl = string.Empty;
            string columnZeroName = string.Empty;

            IList<FinancialTransaction> transactions;

            DateTime i = _startDate;

            DataTable returnTable = new DataTable();
            //returnTable.Columns.Add(title);
            if (IsIE)
            {

                columnZeroName = title;
                returnTable.Columns.Add(columnZeroName);
                transactions = GetIESummaryTransactions(IsIncome);
            }
            else if(IsDonations)
            {
                columnZeroName = "Donor";
                returnTable.Columns.Add(columnZeroName);
                transactions = GetDonationTransactions(IsIncome);
            }
            else
            {
                columnZeroName = "GL Description";
                returnTable.Columns.Add(columnZeroName);
                transactions = GetGLSummaryTransactions(IsIncome);
            }

           


            returnTable.Rows.Add();

            while (i < _endDate.AddMonths(0))
            {
                string period = i.Year.ToString() + " - " + i.Month.ToString();
                returnTable.Columns.Add(period);
               

                 



                i = i.AddMonths(1);
            }

            InitializeRowForDataTable(returnTable, 0, title, columnZeroName);
            if (transactions == null || transactions.Count == 0)
            {
                return returnTable ;
            }
            if (IsIE)
            {
                DateTime sixMonthsAgo = DateTime.Today.AddMonths(-6);
                DateTime MonthStart = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                sixMonthsAgo = new DateTime(sixMonthsAgo.Year, sixMonthsAgo.Month, 1);

                double avg = (double)transactions.Where(x => (x.TransactionDate >= sixMonthsAgo) && (x.TransactionDate<MonthStart)).Select(x => x.Amount).Sum() / 6.0;
                avg = Math.Round(avg);
                if (IsIncome) avgIncome = avg;
                else avgExpense = avg;

               

                SetIESummary(transactions, returnTable);

            }
            else if (IsDonations)
            {
                SetDonationSummary(ref counter, ref currentGl, transactions, returnTable, columnZeroName);
            }
            else
            {
                SetGLSummary(ref counter, ref currentGl, transactions, returnTable, columnZeroName);
            }

            return returnTable;
        }

        public string getPointSizeForAvg(int order)
        {
            double offset = Math.Max(Math.Max(avgIncome, avgExpense), avgBalance) / 20.0;
            if (order == 2)
            {
               if (Math.Abs(avgIncome - avgExpense) < offset)
                    return "10";
            }
            if (order == 3)
            {
                if ((Math.Abs(avgBalance - avgExpense) < offset) || (Math.Abs(avgBalance - avgIncome) < offset))
                {
                    overlap2 = true;
                    return overlap2 ? "5" : "10";
                }
               

            }
            return "15";
        }

        private void SetGLSummary(ref int counter, ref string currentGl, IList<FinancialTransaction> transactions, DataTable returnTable, string columnZeroName)
        {
            IList<FinancialTransaction> t = transactions.OrderBy(orderGl => orderGl.GLAccountDescription).ToList<FinancialTransaction>();

            currentGl = t.First().GLAccountDescription;
            if (t.First().GLAccountCode != null) _accountCodes.Add(Server.HtmlEncode(currentGl), t.First().GLAccountCode);
            InitializeRowForDataTable(returnTable, counter, currentGl, columnZeroName);

            foreach (FinancialTransaction transaction in t)
            {
                if (!currentGl.StartsWith(transaction.GLAccountDescription) )
                {
                    //Adds a row
                    returnTable.Rows.Add();
                   
                    currentGl = transaction.GLAccountDescription;
                    if(transaction.GLAccountCode != null) _accountCodes.Add(Server.HtmlEncode(currentGl), transaction.GLAccountCode );
                    counter++;
                    InitializeRowForDataTable(returnTable, counter, currentGl, columnZeroName);
                }

                returnTable.Rows[counter][(transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month).ToString()] =
                    FormatNumber((double)(transaction.Amount));
                    
                    //decimal.Round(transaction.Amount, 0 , MidpointRounding.AwayFromZero );
            }
        }

        private Double DecodeNumberString(string inputString)
        {
            if(inputString.EndsWith("M"))
                return (Convert.ToDouble(inputString.TrimEnd('M')))* 1000000;
            if(inputString.EndsWith("K"))
                return (Convert.ToDouble(inputString.TrimEnd('K'))) * 1000;
            else
                return (Convert.ToDouble(inputString));

        }

        private string FormatNumber(double inputNumber)
        {
            
            double num =Math.Abs(inputNumber);
            
            if (num >= 1000000)
                return (num / 1000000).ToString("0.#") + "M";
            if (num >= 100000)
                return (num / 1000).ToString("#,0") + "K";
            if (num >= 10000) 
                return (num / 1000D).ToString("0.#") + "K";
  


         return num.ToString("#,0");



        }

        private void SetDonationSummary(ref int counter, ref string currentDonor, IList<FinancialTransaction> transactions, DataTable returnTable, string columnZeroName)
        {
            IList<FinancialTransaction> t = transactions.OrderBy(orderGl => orderGl.GLAccountDescription).ToList<FinancialTransaction>();
                
                //donations.OrderBy(x => x.DonorName).ThenBy(x => x.GiftDate).ToList<dynamicTnT.Gift>();
            var currentDonorCode = t.First().GLAccountCode ;

            currentDonor= t.First().GLAccountDescription  ;

            if (currentDonor != null) _donorCodes.Add(currentDonorCode, Server.HtmlEncode(currentDonor) );
           
            InitializeRowForDataTable(returnTable, counter,  currentDonorCode, columnZeroName);

            foreach (FinancialTransaction gift in t)
            {
                if (!(currentDonorCode== gift.GLAccountCode ) )
                {
                    //Adds a row
                    returnTable.Rows.Add();

                    currentDonor = gift.GLAccountDescription ;
                    currentDonorCode = gift.GLAccountCode ;


                   
                        if((!_donorCodes.ContainsKey(currentDonorCode)&&(currentDonor != null))) _donorCodes.Add(currentDonorCode, Server.HtmlEncode(currentDonor));
                    
                   
           
                   // if (gift. != null) _accountCodes.Add(Server.HtmlEncode(currentGl), transaction.GLAccountCode);
                    counter++;
                    InitializeRowForDataTable(returnTable, counter, currentDonorCode, columnZeroName);

                }

                returnTable.Rows[counter][(gift.FiscalYear + " - " + gift.FiscalPeriod).ToString()] = FormatNumber((double)(gift.Amount)); // decimal.Round(gift.Amount, 0, MidpointRounding.AwayFromZero);
            }

            //Now put a total at the bottom
            returnTable.Rows.Add();
            InitializeRowForDataTable(returnTable, counter+1, "Total", columnZeroName);
            DateTime i = _startDate;
            while (i < _endDate.AddMonths(0))
            {
                var amount = (from c in t where c.FiscalYear == i.Year && c.FiscalPeriod == i.Month  select c.Amount).Sum();
                returnTable.Rows[counter + 1][i.Year.ToString() + " - " + i.Month.ToString()] = FormatNumber((double)(amount)); // decimal.Round(amount, 0, MidpointRounding.AwayFromZero);
                i = i.AddMonths(1);
            }
        }

        public void SetIESummary(IList<FinancialTransaction> transactions, DataTable returnTable)
        {
            foreach (FinancialTransaction transaction in transactions)
            {
                returnTable.Rows[0][returnTable.Columns.IndexOf((transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month).ToString())] = FormatNumber((double)(transaction.Amount)); //decimal.Round(transaction.Amount, 0, MidpointRounding.AwayFromZero);
            }
        }

        private static void InitializeRowForDataTable(DataTable returnTable, int counter, string currentGl, string columnZeroName)
        {
            foreach (DataColumn c in returnTable.Columns)
            {
                returnTable.Rows[counter][c.ColumnName.ToString()] = 0;
            }

            if (!string.IsNullOrEmpty(columnZeroName))
            {
                returnTable.Rows[counter][columnZeroName] = currentGl;
            }
        }

        public IList<FinancialTransaction> GetGLSummaryTransactions(bool IsIncome)
        {
            IList<FinancialTransaction> returnTransactions = null;

            if (tntTransactions != null)
            {
               
               // _dataserverAccounts.ProfileCode= MyProfiles.SelectedValue ;

                returnTransactions = tntTransactions.Where(isInc => isInc.GLAccountIsIncome == IsIncome)
                       .GroupBy(g => new { g.GLAccountDescription, g.FiscalYear, g.FiscalPeriod })
                         .Select(group => new FinancialTransaction
                         {
                             Amount = group.Sum(s => s.Amount * (IsIncome ? 1 : -1)),
                             FiscalPeriod = group.First().FiscalPeriod,
                             FiscalYear = group.First().FiscalYear,
                             GLAccountDescription = group.First().GLAccountDescription,
                             TransactionDate = group.First().TransactionDate,
                             GLAccountCode = group.First().GLAccountCode
                         })
                         .ToList();
            }
            
            return returnTransactions;
        }


        public IList<FinancialTransaction> GetDonationTransactions(bool IsIncome)
        {
            IList<FinancialTransaction> returnTransactions = null;
       
            if (donations != null)
            {

                // _dataserverAccounts.ProfileCode= MyProfiles.SelectedValue ;

                returnTransactions = donations.GroupBy(g => new{ g.DonorCode, g.GiftDate.Year, g.GiftDate.Month})
                    .Select(group => new FinancialTransaction 
                    {
                        Amount = group.Sum(s => s.Amount),
                         FiscalPeriod = group.First().GiftDate.Month ,
                        FiscalYear = group.First().GiftDate.Year,
                             GLAccountDescription = group.First().DonorName ,
                             TransactionDate = group.First().GiftDate ,
                             GLAccountCode = group.First().DonorCode  
                     }).ToList();

               
            }
            
            return returnTransactions;
        }

        public IList<FinancialTransaction> GetIESummaryTransactions(bool IsIncome)
        {
            IList<FinancialTransaction> returnList = null;

            if (tntTransactions != null)
            {
                returnList = tntTransactions.Where(isInc => isInc.GLAccountIsIncome == IsIncome)
                       .GroupBy(g => new { g.FiscalYear, g.FiscalPeriod })
                         .Select(group => new FinancialTransaction
                         {
                             Amount = group.Sum(s => s.Amount) * (IsIncome ? 1 : -1),
                             FiscalPeriod = group.First().FiscalPeriod,
                             FiscalYear = group.First().FiscalYear,
                             TransactionDate = group.First().TransactionDate
                         })
                         .ToList();
            }

            return returnList;
        }

        private static DataTable CreateTableForDataGrid(DateTime beginDate, DateTime endDate, bool IsIncome, IList<FinancialTransaction> ft, DataTable returnTable)
        {
            if (!((ft == null) || (ft.Count == 0)))
            {
                int currentPeriod, currentYear;

                currentPeriod = ft.First().FiscalPeriod;
                currentYear = ft.First().FiscalYear;

                List<FinancialTransaction> dsTransactions;

                DateTime i = beginDate;
                int c = 0;

                while (i < endDate.AddMonths(0))
                {
                    returnTable.Columns.Add(i.Year.ToString() + "-" + i.Month.ToString());

                    dsTransactions = ft.Where(j => ((j.GLAccountIsIncome == IsIncome) && (j.TransactionDate.Month == i.Month) && (j.TransactionDate.Year == i.Year))).ToList();

                    if (dsTransactions.Count > 0)
                    {
                        returnTable.Rows.Add(dsTransactions.Sum(incAmount => incAmount.Amount));
                    }
                    else
                    {
                        returnTable.Rows.Add(0);
                    }

                    i = i.AddMonths(1);
                    c++;
                }
            }

            return returnTable;
        }

        private string getPT(string ServiceName)
        {
           
            string pt = "";
            if (!string.IsNullOrEmpty((string)Session["pgtId"]))
            {
                 pt= GetProxyTicketFromCAS(ServiceName, (string)Session["pgtId"]);
                if (!String.IsNullOrEmpty(pt))
                 return pt;
            }

            string pgtiou = UserController.GetUserById(PortalId , UserId).Profile.GetPropertyValue("GCXPGTIOU");
            string pgt = "";
            if (!string.IsNullOrEmpty(pgtiou))
            {
                try
                {
                    pgt = new theKeyProxyTicket.PGTCallBackSoapClient().RetrievePGTCallback("CASAUTH", "thecatsaysmeow3", pgtiou);
                    HttpContext.Current.Session.Add("pgtId", pgt);
                }
                catch {}

            }
             pt = GetProxyTicketFromCAS(ServiceName,  pgt);

            Session.Add("PT-" + MyCountries.SelectedItem.Text, pt);
            return pt;

        }


        private string GetProxyTicketFromCAS(string targetService, string _pgt)
        {
            string pt = string.Empty;
            string server = "https://thekey.me/cas/";
            
            string validateurl = server + "proxy?targetService=" + targetService + "&pgt=" + _pgt.Trim().ToString();


            System.IO.Stream s;

            try
            {
                System.Net.WebClient wc = new System.Net.WebClient();
                s = wc.OpenRead(validateurl);
            }
            catch (Exception e)
            {
                // error
               return pt;
            }

            StreamReader streamReader = new StreamReader(s);

            XmlDocument doc = new XmlDocument();
            doc.Load(streamReader);
            XmlNamespaceManager NamespaceMgr = new XmlNamespaceManager(doc.NameTable);
            NamespaceMgr.AddNamespace("cas", "http://www.yale.edu/tp/cas");

            XmlNode SuccessNode = doc.SelectSingleNode("/cas:serviceResponse/cas:proxySuccess", NamespaceMgr);

            if (!(SuccessNode == null))
            {
                XmlNode ProxyTicketNode = SuccessNode.SelectSingleNode("./cas:proxyTicket", NamespaceMgr);
                if (!(ProxyTicketNode == null))
                    return ProxyTicketNode.InnerText;
            }

            return pt;
        }

        

        
        protected void PopulateDropdowns() { 
        
        
        
        
        }
        protected void MyCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            if (dTnT.Url != MyCountries.SelectedValue)
            {
                dTnT.Url = MyCountries.SelectedValue;
                dTnT.Discover();
            }
            string sessionId= (string) Session["TnT-" + MyCountries.SelectedItem.Text];
            if(string.IsNullOrEmpty(sessionId))
            {

                string service = dTnT.GetServiceName();//"https://tntdataserver.eu/dataserver/uk/dataquery/DataQueryService2.asmx"; 
                string pt = getPT(service);
                string UserName; 
                bool IsReg ;
                try
                {
                    sessionId = dTnT.Login(service, pt, true, out UserName, out IsReg);
                }
                catch (Exception ex)
                {
                    if (ex.Message.Contains("facebook"))
                    {
                        

                        

                        Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(PortalSettings.LoginTabId) + "?returnurl=" + DotNetNuke.Common.Globals.NavigateURL() + "&renew=true");
                        
                    }
                    throw;
                }





                
                Session.Add("TnT-" + MyCountries.SelectedItem.Text, sessionId);
            }
            try
            {
                var Profiles = from c in dTnT.GetStaffProfiles(sessionId) orderby c.Code == "" descending, c.Code ascending select c;

                MyProfiles.DataSource = Profiles;
                MyProfiles.DataTextField = "Description";
                MyProfiles.DataValueField = "Code";

                MyProfiles.DataBind();
            }
            catch (Exception ex)
            {
                if (ex.Message.Contains("The session has expired."))
                {

                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(PortalSettings.LoginTabId) + "?returnurl=" + DotNetNuke.Common.Globals.NavigateURL() + "&renew=true");
                }
                throw;
            }

            
          


            if (MyProfiles.Items.Count > 0) MyProfiles.SelectedIndex = 0;
            else MyProfiles.ClearSelection() ;
            MyProfiles_SelectedIndexChanged(this, null);
        }

        protected void MyProfiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (MyProfiles.Items.Count == 0)
                return;
            if (dTnT.Url != MyCountries.SelectedValue)
            {
                dTnT.Url = MyCountries.SelectedValue;
                dTnT.Discover();
            }
            string sessionId = (string)Session["TnT-" + MyCountries.SelectedItem.Text];
            if (string.IsNullOrEmpty(sessionId))
            {
                string service = dTnT.GetServiceName();
                string pt = getPT(service);
                string UserName;
                bool IsReg;
                sessionId = dTnT.Login(service, pt, true, out UserName, out IsReg);
                Session.Add("TnT-" + MyCountries.SelectedItem.Text, sessionId);
            }
            bool IsTrans;
         
             tntDesignations = dTnT.GetStaffProfileSummary(sessionId, (string)MyProfiles.SelectedValue, out tntAccounts, out IsTrans);
             //Session.Add("tntAccounts", tntAccounts);
             //Session.Add("tntDesignations", tntDesignations);
            MyAccounts.DataSource = tntAccounts;
             MyAccounts.DataTextField = "Description";
             MyAccounts.DataValueField = "Code";


            
             


             MyAccounts.Visible = true;
             MyAccounts.DataBind();
             MyAccounts.Items.Insert( 0, "All Accounts");
             if (MyAccounts.Items.Count > 0) MyAccounts.SelectedIndex = 0;
             else MyAccounts.ClearSelection();

             MyAccounts_SelectedIndexChanged(this, null);

        }

        protected void MyAccounts_SelectedIndexChanged(object sender, EventArgs e)
        {
           
            ReloadTablesAndGraphs();
        }

        private DateTime FirstDayOfMonthFromDateTime(DateTime dateTime)
        {
            return new DateTime(dateTime.Year, dateTime.Month, 1);
        }

        private DateTime LastDayOfMonthFromDateTime(DateTime dateTime)
        {
            DateTime firstDayOfTheMonth = new DateTime(dateTime.Year, dateTime.Month, 1);
            return firstDayOfTheMonth.AddMonths(1).AddDays(-1);
        }

        protected void gvExpensesGLSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            DateTime i = _startDate;
            Boolean firstColumn = true;
            //Get GLAccount for this Row...

            string AccountCode = "";
            string AccountName = "";
            foreach (TableCell cell in e.Row.Cells)
            {
                if(!firstColumn)
                {
                    string per = i.ToString("MMM yy");
                    cell.Attributes["onClick"] = "displayDetail('" + AccountCode + "','" + i.Year.ToString() + " - " + i.Month.ToString() + "','" + AccountName + "&nbsp; &nbsp; &nbsp; <i>" + per + "</i>');"; 
                    cell.CssClass = "CellHover";
                    i=i.AddMonths(1);
                }
                else {
                    if (!_accountCodes.Keys.Contains(cell.Text)) 
                        return;
                    AccountCode = Convert.ToString(_accountCodes[cell.Text]);
                    AccountName = cell.Text;
                    firstColumn=false;
                }
            }
        }



        protected void gvDonationSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            DateTime i = _startDate;
            Boolean firstColumn = true;
            //Get GLAccount for this Row...

            string DonorCode = "";
            string DonorName = "";
            foreach (TableCell cell in e.Row.Cells)
            {
                if (!firstColumn)
                {
                    string per = i.ToString("MMM yy");
                    cell.Attributes["onClick"] = "displayDetail('" + DonorCode + "','" + i.Year.ToString() + " - " + i.Month.ToString() + "','" + DonorName + "&nbsp; &nbsp; &nbsp; <i>" + per + "</i>');"; 
                    cell.CssClass = "CellHover";
                    i = i.AddMonths(1);
                }
                else
                {
                    
                    try
                    {
                        if (cell.Text == "Total")
                        {
                            e.Row.Font.Bold = true;
                        }

                        if (!_donorCodes.Keys.Contains(cell.Text))
                            return;
                        DonorCode =cell.Text;
                        DonorName = _donorCodes[cell.Text];
                        cell.Text = DonorName + "<div class=\"PVKEY\">(" + DonorCode + ")</div>";
                        firstColumn = false;
                    }
                    catch (Exception)
                    {

                    }
                }
            }
        }


        protected void gvIncomeGLSummary_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            DateTime i = _startDate;
            Boolean firstColumn = true;
            //Get GLAccount for this Row...

            string AccountCode = "";
            string AccountName = "";
            foreach (TableCell cell in e.Row.Cells)
            {
                if (!firstColumn)
                {
                    string per = i.ToString("MMM yy");
                    cell.Attributes["onClick"] = "displayDetail('" + AccountCode + "','" + i.Year.ToString() + " - " + i.Month.ToString() + "','" + AccountName + "&nbsp; &nbsp; &nbsp; <i>" + per + "</i>');";
                    cell.CssClass = "CellHover";
                    i = i.AddMonths(1);
                }
                else
                {
                    


                    cell.Text = Server.HtmlDecode(cell.Text);
                    if (!_accountCodes.Keys.Contains(cell.Text))
                        return;
                    AccountCode = Convert.ToString(_accountCodes[cell.Text]);
                    AccountName = cell.Text;
                    firstColumn = false;
                }
            }
        }

}
}

