﻿using System;
using System.Linq;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using MinistryViewDS;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Script.Services;

namespace DotNetNuke.Modules.Account
{
    using DotNetNuke.Entities.Modules;
    using MinistryViewDS;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Data;

    public partial class AccountReport : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        private int _userId;
        private int _portalID;
        private string _ssoGuid, _pgtId;
        DateTime _startDate, _endDate;
        MinistryViewDSServices _tnt = new MinistryViewDSServices();
        myAccounts _myAccounts = new myAccounts();
        DSAccount _dataserverAccounts;
        public String _googleGraph = "";
        private Dictionary<string, string> _accountCodes = new Dictionary<string, string>();
             
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
             InitializeValues();
        }


        protected void ReloadTablesAndGraph()
        {

            _dataserverAccounts = GetAccounts(_startDate, _endDate, MyCountries.SelectedValue, MyProfiles.SelectedValue, MyAccounts.SelectedValue);
         
            if (_dataserverAccounts != null )
            {
                DataTable IncomeTable;
                IncomeTable = SummaryTable(true, true, "Income");
                
                    gvIncome.DataSource = IncomeTable;
                    gvIncome.DataBind();

                    SetColumnWidth(ref gvIncome, System.Drawing.Color.Blue, true);
               

                DataTable IncomeGLSummaryTable;
                IncomeGLSummaryTable = SummaryTable(true, false);
                
                    gvIncomeGLSummary.DataSource = IncomeGLSummaryTable;
                    gvIncomeGLSummary.DataBind();

                    SetColumnWidth(ref gvIncomeGLSummary, System.Drawing.Color.Black);
               

                DataTable ExpensesTable;
                ExpensesTable = SummaryTable(false, true, "Expenses");
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
                


                if (_dataserverAccounts.FinancialAccount != null )
                {



                    StartingBalance.Text = _dataserverAccounts.FinancialAccount.Where(a => (a.Code == MyAccounts.SelectedValue || MyAccounts.SelectedValue == "All Accounts")).Sum(b => b.BeginningBalance).ToString("0.00");

                    EndingBalance.Text = _dataserverAccounts.FinancialAccount.Where(a => (a.Code == MyAccounts.SelectedValue || MyAccounts.SelectedValue == "All Accounts")).Sum(b => b.EndingBalance).ToString("0.00");

                    DataTable BalanceTable = new DataTable();

                    BalanceTable.Columns.Add("Balance");
                    DateTime i = _startDate;
                    while (i < _endDate.AddMonths(0))
                    {
                        BalanceTable.Columns.Add(i.Year.ToString() + " - " + i.Month.ToString());
                        i = i.AddMonths(1);
                    }
                    i = _startDate;
                    double balCounter = Convert.ToDouble(StartingBalance.Text);
                    BalanceTable.Rows.Add();


                    foreach (DataColumn col in BalanceTable.Columns)
                    {
                        int index = BalanceTable.Columns.IndexOf(col);
                        if (BalanceTable.Columns.IndexOf(col) == 0) BalanceTable.Rows[0][col.ColumnName] = "Balance";
                        else
                        {

                            balCounter += Convert.ToDouble(IncomeTable.Rows[0][index]) - Convert.ToDouble(ExpensesTable.Rows[0][index]);
                            BalanceTable.Rows[0][index] = balCounter;
                            _googleGraph += "data.addRow(['" + GetMonth(index-13) + "', " + (string)IncomeTable.Rows[0][index] + ", " + (string)ExpensesTable.Rows[0][index] + ", " + (string)BalanceTable.Rows[0][index] + "]);" + Environment.NewLine;

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


            }
        }

        
        private void saveTransactions()
        {
            string data = "[";
            foreach (FinancialTransaction transaction in _dataserverAccounts.Transactions)
            {
               // int AC = -1;
              //  if (!transaction.GLAccountIsIncome && _accountCodes.Keys.Contains(transaction.GLAccountCode ) AC = _accountCodes[transaction.GLAccountDescription];
                    

                data += @"{""AC"": """ + transaction.GLAccountCode + @""","
                    + @"""Am"": """ + (transaction.GLAccountIsIncome ? transaction.Amount.ToString("0.00") : (-transaction.Amount).ToString("0.00"))  + @""","
                    + @"""De"": """ + Server.HtmlEncode(transaction.Description) + @""","
                    + @"""Dt"": """ + transaction.TransactionDate.ToShortDateString() + @""","
                    + @"""Pe"": """ + transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month + @"""}," + Environment.NewLine;
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

        private void InitializeValues()
        {
           
            _userId = UserId;
            _portalID =PortalId;
            _ssoGuid = UserController.GetUserById(_portalID, _userId).Profile.GetPropertyValue("ssoGUID");
            //Make this customizable in the future. 
            //If values are not assigned, 13 month report.
            _startDate = FirstDayOfMonthFromDateTime(DateTime.Today.AddMonths(-12));
            _endDate = LastDayOfMonthFromDateTime(DateTime.Today);

            IdentifyViaGCXTNT();

            if (!IsPostBack)
            {
                if (_myAccounts != null) { PopulateDropdowns(); }
            }
           
           // _dataserverAccounts = GetAccounts(_startDate, _endDate, MyCountries.SelectedValue, MyProfiles.SelectedValue, MyAccounts.SelectedValue);
        }

        private void IdentifyViaGCXTNT()
        {
            if ((Session["TntSummary"] == null) || ((myAccounts)Session["TntSummary"]).Countries  == null)
            {
                string pgtiou = UserController.GetUserById(_portalID, _userId).Profile.GetPropertyValue("GCXPGTIOU");

                if (!string.IsNullOrEmpty(pgtiou)  )
                {
                    try
                    {
                        _pgtId = new theKeyProxyTicket.PGTCallBackSoapClient().RetrievePGTCallback("CASAUTH", "thecatsaysmeow3", pgtiou);
                    }
                    catch (Exception e)
                    {
                        _pgtId = string.Empty;
                    }

                    if (!string.IsNullOrEmpty(_pgtId))
                    {
                        _myAccounts = _tnt.GetSummary(_pgtId, _ssoGuid);
                        if (_myAccounts.Status == true)
                            Session["TntSummary"] = _myAccounts;
                        else
                        {
                            //PGT TICKET HAS EXPIRED!!! Need to re-authenticate...

                           Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(PortalSettings.LoginTabId) + "?returnurl=" + DotNetNuke.Common.Globals.NavigateURL());


                        }
                    }
                }
            }
            else
            {

                _myAccounts = ((myAccounts)Session["TntSummary"]);
            }
        }

        private DSAccount GetAccounts(DateTime startDate, DateTime endDate, string selectedCountry, string selectedProfile, string selectedAccount)
        {
            if (selectedAccount == "All Accounts")
            {
                return new DSAccount(selectedCountry, _ssoGuid, null, startDate, endDate, selectedProfile);

            }
            else
            {
                return new DSAccount(selectedCountry, _ssoGuid, selectedAccount, startDate, endDate, selectedProfile);
            }
        }

        public DataTable SummaryTable(bool IsIncome, bool IsIE, string title = "")
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
            else
            {
                columnZeroName = "GL Description";
                returnTable.Columns.Add(columnZeroName);
                transactions = GetGLSummaryTransactions(IsIncome);
            }

          

            returnTable.Rows.Add();

            while (i < _endDate.AddMonths(0))
            {
                returnTable.Columns.Add(i.Year.ToString() + " - " + i.Month.ToString());

                i = i.AddMonths(1);
            }

            InitializeRowForDataTable(returnTable, 0, title, columnZeroName);
            if (transactions == null || transactions.Count == 0)
            {
                return returnTable ;
            }
            if (IsIE)
            {
                SetIESummary(transactions, returnTable);
            }
            else
            {
                SetGLSummary(ref counter, ref currentGl, transactions, returnTable, columnZeroName);
            }

            return returnTable;
        }

        private void SetGLSummary(ref int counter, ref string currentGl, IList<FinancialTransaction> transactions, DataTable returnTable, string columnZeroName)
        {
            IList<FinancialTransaction> t = transactions.OrderBy(orderGl => orderGl.GLAccountDescription).ToList<FinancialTransaction>();

            currentGl = t.First().GLAccountDescription;
            if (t.First().GLAccountCode != null) _accountCodes.Add(currentGl, t.First().GLAccountCode);
            InitializeRowForDataTable(returnTable, counter, currentGl, columnZeroName);

            foreach (FinancialTransaction transaction in t)
            {
                if (!currentGl.StartsWith(transaction.GLAccountDescription) )
                {
                    //Adds a row
                    returnTable.Rows.Add();
                   
                    currentGl = transaction.GLAccountDescription;
                    if(transaction.GLAccountCode != null) _accountCodes.Add(currentGl, transaction.GLAccountCode );
                    counter++;
                    InitializeRowForDataTable(returnTable, counter, currentGl, columnZeroName);
                }

                returnTable.Rows[counter][(transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month).ToString()] = decimal.Round(transaction.Amount, 2, MidpointRounding.ToEven);
            }
        }

        public void SetIESummary(IList<FinancialTransaction> transactions, DataTable returnTable)
        {
            foreach (FinancialTransaction transaction in transactions)
            {
                returnTable.Rows[0][returnTable.Columns.IndexOf((transaction.TransactionDate.Year + " - " + transaction.TransactionDate.Month).ToString())] = decimal.Round(transaction.Amount, 2, MidpointRounding.ToEven);
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

            if (_dataserverAccounts.Transactions != null)
            {
               
                _dataserverAccounts.ProfileCode= MyProfiles.SelectedValue ;

                returnTransactions = _dataserverAccounts.Transactions.Where(isInc => isInc.GLAccountIsIncome == IsIncome)
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

        public IList<FinancialTransaction> GetIESummaryTransactions(bool IsIncome)
        {
            IList<FinancialTransaction> returnList = null;

            if (_dataserverAccounts.Transactions != null)
            {
                returnList = _dataserverAccounts.Transactions.Where(isInc => isInc.GLAccountIsIncome == IsIncome)
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

        private void PopulateDropdowns()
        {
            if (_myAccounts != null)
            {
                MyCountries.Visible = true;
                MyCountries.DataSource = _myAccounts.Countries;
                MyCountries.DataTextField = "Name";
                MyCountries.DataValueField = "URL";
                MyCountries.DataBind();


                MyCountries.SelectedValue = StaffBrokerFunctions.GetSetting("https://tntdataserver.eu/dataserver/devtest/dataquery/dataqueryservice.asmx",PortalId);

                MyCountries_SelectedIndexChanged(this, null);
            }
        }

        protected void MyCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            MyProfiles.Visible = true;
            MyProfiles.DataSource = _myAccounts.Countries.Where(c => c.URL == MyCountries.SelectedValue).First().Profiles.OrderBy(a => a.ProfileCode);
            MyProfiles.DataTextField = "ProfileName";
            MyProfiles.DataValueField = "ProfileCode";
            MyProfiles.DataBind();
            if (MyProfiles.Items.Count > 0) MyProfiles.SelectedIndex = 0;
            else MyProfiles.ClearSelection() ;
            MyProfiles_SelectedIndexChanged(this, null);
        }

        protected void MyProfiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            MyAccounts.Visible = true;
            MyAccounts.DataSource = _myAccounts
                .Countries.Where(c => c.URL == MyCountries.SelectedValue).First()
                .Profiles.Where(p => p.ProfileCode == MyProfiles.SelectedValue).First().Accounts;
            MyAccounts.DataTextField = "Description";
            MyAccounts.DataValueField = "AccountID";
            MyAccounts.DataBind();
           
            MyAccounts.Items.Insert(0, "All Accounts");
            MyAccounts.SelectedIndex = 0;
            MyAccounts_SelectedIndexChanged(this, null);
        }

        protected void MyAccounts_SelectedIndexChanged(object sender, EventArgs e)
        {
            ReloadTablesAndGraph();
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
                    if (!_accountCodes.Keys.Contains(Server.HtmlDecode( cell.Text))) 
                        return;
                    AccountCode = Convert.ToString(_accountCodes[Server.HtmlDecode(cell.Text)]);
                    AccountName = cell.Text;
                    firstColumn=false;
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
                    if (!_accountCodes.Keys.Contains(Server.HtmlDecode(cell.Text)))
                        return;
                    AccountCode = Convert.ToString(_accountCodes[Server.HtmlDecode(cell.Text)]);
                    AccountName = cell.Text;
                    firstColumn = false;
                }
            }
        }
}
}

