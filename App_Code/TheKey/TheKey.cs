using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Text;
using System.IO;
/// <summary>
/// Summary description for TheKey
/// </summary>
public class TheKey
{

    public string ServiceTicket { 
get ; set; }
    public TheKey()
    {
    }

    public TheKey(string Username, string Password, string TargetService)
	{
        string service = "https://www.agapeconnect.me";
        string postData = "service=" + service + "&username=" + Username + "&password=" + Password;
        string restServer = "https://thekey.me/cas/v1/tickets/";
        WebRequest request = WebRequest.Create(restServer);
        byte[] byteArray = Encoding.UTF8.GetBytes(postData);


        request.ContentLength = byteArray.Length;
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";

        Stream datastream = request.GetRequestStream();
        datastream.Write(byteArray, 0, byteArray.Length);
        datastream.Close();

        WebResponse response = request.GetResponse();

        restServer = response.Headers.GetValues("Location")[0];


        postData = "service=" + TargetService;
        request = WebRequest.Create(restServer);
        byteArray = Encoding.UTF8.GetBytes(postData);
        request.ContentLength = byteArray.Length;
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";

        datastream = request.GetRequestStream();
        datastream.Write(byteArray, 0, byteArray.Length);
        datastream.Close();

        response = request.GetResponse();

        response.Headers.GetValues("location");
        datastream = response.GetResponseStream();
        StreamReader reader = new StreamReader(datastream);


        ServiceTicket = reader.ReadToEnd();
	}
}