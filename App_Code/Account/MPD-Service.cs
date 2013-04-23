using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
/// <summary>
/// Summary description for MPD_Service
/// </summary>
public static  class MPD_Service
{
    //static string serviceURL = "https://staffweb.cru.org:443/ss/servlet/TntMPDServlet/";


	public struct Donation
    {
        public int account{get;set;}
        public int PeopleId{ get; set; }
        public string DonorName { get; set; }
        public DateTime DonationDate { get; set; }
        public string DonationId { get; set; }
        public string Payment_Method { get; set; }
        public string Amount { get; set; }
        public string FiscalPeriod { get; set; }
        public string MonthName { get; set; }
    }

    public static List<Donation> getDonations(string Username, string Password, string serviceURL, string Action, DateTime DateFrom, DateTime DateTo )
    {

        List<Donation> donations = new List<Donation>();
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(serviceURL);
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        StringBuilder data = new StringBuilder();
        data.Append("Username=" + HttpUtility.UrlEncode(Username));
        data.Append("&Password=" + HttpUtility.UrlEncode(Password));
        data.Append("&Action=" + HttpUtility.UrlEncode(Action));
        data.Append("&DateFrom=" + HttpUtility.UrlEncode(DateFrom.ToString("M/d/yyyy")));
        data.Append("&DateTo=" + HttpUtility.UrlEncode(DateTo.ToString("M/d/yyyy")));
        data.Append("&Order=Date");
        request.ContentLength = data.Length;
        StreamWriter requestWriter = new StreamWriter(request.GetRequestStream(), System.Text.Encoding.ASCII);
        requestWriter.Write(data);
        requestWriter.Close();

        try
        {
            WebResponse webResponse = request.GetResponse();
            Stream webStream = webResponse.GetResponseStream();
            StreamReader responseReader = new StreamReader(webStream);
            string response = responseReader.ReadToEnd();
            Console.Out.WriteLine(response);
            responseReader.Close();

            

            
            CSVHelper csv = new CSVHelper(response,",");
            bool first = true;
            foreach(string[] line in csv)
            {
                if (first) first = false;
                else
                {
                    Donation don = new Donation();
                    don.account = int.Parse(line[0]);
                    don.PeopleId = int.Parse(line[1]);
                    don.DonorName = line[2].Replace("\"", "");
                    IFormatProvider culture = new System.Globalization.CultureInfo("en-US");

                    don.DonationDate = DateTime.Parse(line[3], culture);
                    don.DonationId = line[4];
                    don.Payment_Method = line[6];
                    don.Amount = line[10];
                    don.FiscalPeriod = don.DonationDate.ToString("yyyyMM");
                    don.MonthName = don.DonationDate.ToString("MMM yy");
                    donations.Add(don);
                }
            }
                    




            return donations;
           
        }
        catch (Exception e)
        {
            Console.Out.WriteLine("-----------------");
            Console.Out.WriteLine(e.Message);
            return null;
        }

    }

   
}

public class CSVHelper : List<string[]>
{
    protected string csv = string.Empty;
    protected string separator = ",";

    public CSVHelper(string csv, string separator = "\",\"")
    {
        this.csv = csv;
        this.separator = separator;

        foreach (string line in Regex.Split(csv, System.Environment.NewLine).ToList().Where(s => !string.IsNullOrEmpty(s)))
        {


            string[] values = SplitCSV(line).ToArray();

            for (int i = 0; i < values.Length; i++)
            {
                //Trim values
                values[i] = values[i].Trim(',').Trim('\"');
            }

            this.Add(values);
        }
    }
    public static IEnumerable<string> SplitCSV(string csvString)
    {
        var sb = new StringBuilder();
        bool quoted = false;

        foreach (char c in csvString)
        {
            if (quoted)
            {
                if (c == '"')
                    quoted = false;
                else
                    sb.Append(c);
            }
            else
            {
                if (c == '"')
                {
                    quoted = true;
                }
                else if (c == ',')
                {
                    yield return sb.ToString();
                    sb.Length = 0;
                }
                else
                {
                    sb.Append(c);
                }
            }
        }

        if (quoted)
            throw new ArgumentException("csvString", "Unterminated quotation mark.");

        yield return sb.ToString();
    }
}