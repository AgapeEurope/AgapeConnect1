Imports Microsoft.VisualBasic
Imports System
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Xml





Public Class GmaServices
    Public Structure gma_node
        Public nodeId As Integer
        Public shortName As String
    End Structure

    Public Structure gmaServer
        Public name As String
        Public URL As String
        Public nodes As List(Of gma_node)
    End Structure

    Private _endPoint As String
    Private CASHOST As String = "https://thekey.me/cas/"
    Private myCookieContainer As New CookieContainer()
    Public Property EndPoint() As String
        Get
            Return _endPoint
        End Get
        Set(ByVal value As String)
            _endPoint = value
        End Set
    End Property



    Public Sub New(ByVal ServiceURL As String, ByVal PGTIOU As String)
        _endPoint = ServiceURL
        Login(PGTIOU)
    End Sub
    Public Function Login(ByVal PGTIOU As String) As String

        Dim newURL As New Uri("https://agapeconnect.me/MobileCAS/MobileCAS.svc/AuthenticateWithTheKey?username=jon@vellacott.co.uk&password=Iowa2001&targetService=" & HttpContext.Current.Server.UrlEncode("http%3A%2F%2Fgma.agapeconnect.me%2F%3Fq%3Dgmaservices%26destination%3Dgmaservices"))



        Dim PGT = New theKeyProxyTicket.PGTCallBack().RetrievePGTCallback("CASAUTH", "thecatsaysmeow3", PGTIOU)

        Dim service = GetTargetService()
        Dim proxyurl As New Uri(CASHOST & "proxy?" & "targetService=" & service & "&pgt=" & PGT)

        Dim rdr As New StreamReader(New WebClient().OpenRead(proxyurl))
        Dim doc As XmlDocument = New XmlDocument
        doc.Load(rdr)
        Dim NamespaceMgr As XmlNamespaceManager = New XmlNamespaceManager(doc.NameTable)
        NamespaceMgr.AddNamespace("cas", "http://www.yale.edu/tp/cas")


        Dim successNode As XmlNode = doc.SelectSingleNode("/cas:serviceResponse/cas:proxySuccess", NamespaceMgr)

        Dim proxyTicket As XmlNode = successNode.SelectSingleNode("./cas:proxyTicket", NamespaceMgr)

        '        Return proxyTicket.InnerText & "proxyURL: " & proxyurl.AbsoluteUri


        Dim PT = proxyTicket.InnerText
        'Dim PT = TestLogin()


        Dim method = "?q=gmaservices&ticket=" & PT


        Dim authURL = _endPoint & method



        Dim request As HttpWebRequest = DirectCast(WebRequest.Create(authURL), HttpWebRequest)
        request.CookieContainer = myCookieContainer

        Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)
        Dim reader As New StreamReader(response.GetResponseStream())
        Dim json = reader.ReadToEnd()
        Return json
    End Function

    Private Function TestLogin() As String
        Dim newURL As New Uri("https://agapeconnect.me/MobileCAS/MobileCAS.svc/AuthenticateWithTheKey?username=jon@vellacott.co.uk&password=Iowa2001&targetService=" & HttpContext.Current.Server.UrlEncode("http%3A%2F%2Fgma.agapeconnect.me%2F%3Fq%3Dgmaservices%26destination%3Dgmaservices"))

        Dim request As HttpWebRequest = DirectCast(WebRequest.Create(newURL), HttpWebRequest)

        request.CookieContainer = myCookieContainer
        Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)

        Dim reader As New StreamReader(response.GetResponseStream())
        Dim json = reader.ReadToEnd()
        Dim jss = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim dict As Dictionary(Of String, String) = jss.Deserialize(Of Dictionary(Of String, String))(json)
        Return dict("ProxyTicket")
    End Function

    Private Function GetTargetService() As String
        Dim method = "?q=gmaservices"

        Dim request As HttpWebRequest = DirectCast(WebRequest.Create(_endPoint & method), HttpWebRequest)

        request.AllowAutoRedirect = False

        Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)
        If response.StatusCode = HttpStatusCode.Redirect Then
            Dim redr = response.Headers("Location")
            Return redr.Substring(redr.IndexOf("service=") + 8)


        End If
        Return ""
    End Function



    Public Function GetUserNodes() As List(Of gma_node)


        Dim method = "?q=gmaservices/gma_node"





        Dim request As HttpWebRequest = DirectCast(WebRequest.Create(_endPoint & method), HttpWebRequest)
        request.CookieContainer = myCookieContainer

        Dim response As HttpWebResponse = DirectCast(request.GetResponse(), HttpWebResponse)
        Dim reader As New StreamReader(response.GetResponseStream())
        Dim json = reader.ReadToEnd()

        Dim jss = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim dict = jss.Deserialize(Of Object)(json)

        If dict("success") = "true" Then
            Dim Nodes As New List(Of gma_node)
            For Each row In dict("data")("nodeList")
                Dim insert As New gma_node
                insert.nodeId = row("nodeId")
                insert.shortName = row("shortName")
                Nodes.Add(insert)
            Next
            Return Nodes

        End If

        Return Nothing
    End Function



End Class
