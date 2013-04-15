Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports FCX
Imports System.Text.RegularExpressions.Regex
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://agapeconnect.me/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FCX_API
    Inherits System.Web.Services.WebService


    Structure TrxResponse
        Public Status As String
        Public Message As String
        Public ErrorCode As String
    End Structure
    Structure Prop
        Public Name As String
        Public Value As String

    End Structure

    Structure Donation
        Public Donor As Donor
        Public Value As String
        Public Amount As Double
        Public GiftDate As DateTime
        Public GlobalDonorcode As String
        Public PaymentType As String
        Public DesigId As String
        Public PaymentProcessor As String
        Public PaymentProcessorTrxId As String
        Public Other() As Prop

    End Structure
    Structure Donor
        Public DonorId As String
        Public Title As String
        Public FirstName As String
        Public MiddleName As String
        Public LastName As String
        Public SpouseFirstName As String
        Public SpouseMiddleName As String
        Public Email As String


        Public StreetAddress As String
        Public City As String
        Public State As String
        Public Zip As String
        Public Country As String

        Public MobilePhone As String
        Public Phone As String

        Public Other() As Prop

    End Structure

    Structure Batch
        Public UniqueBatRef As String
        Public Ledger As String
        Public Description As String
        Public Status As Integer
        Public StatusDesc As String
        Public Transactions() As FinancialTransaction
        Public Received As DateTime
        Public Downloaded As DateTime
        Public ITNSent As Boolean
        Public BatchId_READONLY As Integer?
    End Structure

    Structure FinancialTransaction
        Public UniqueTRXRef As String
        Public Account As String
        Public RC As String
        Public Amount As Double
        Public Description As String
        Public TrxDate As DateTime

        Public optionalCalendarMonth As Integer?
        Public optionalCalendarYear As Integer?
        Public TransactionId_READONLY As Integer?

    End Structure



    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    


    <WebMethod()> _
    Public Function TestWhiteList(ByVal WhilstList As String) As String
        Dim sender = HttpContext.Current.Request.UrlReferrer.AbsoluteUri()
        Dim ipAddress = HttpContext.Current.Request.ServerVariables("remote_addr")
        Return ValidateWhiteList(WhilstList, sender, ipAddress)

    End Function

    <WebMethod()> _
    Public Function AddFinanicialTransactions(ByVal ApiKey As Guid, ByVal UniqueBatRef As String, ByVal Ledger As String, ByVal Description As String, ByVal Transactions() As FinancialTransaction) As TrxResponse
        Dim rtn As New TrxResponse

        Dim developer = Authenticate(ApiKey, rtn)
        If developer Is Nothing Then
            Return rtn
        End If
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim d As New FCXDataContext
        'Validate that BatchId is Unique
        If d.FCX_API_FinBats.Where(Function(x) x.DeveloperId = developer.DeveloperId And x.UniqueBatchRef = UniqueBatRef And x.FCX_API_Key.PortalId = PS.PortalId).Count() > 0 Then
            rtn.Status = "FAILED"
            rtn.Message = "A batch with ID" & UniqueBatRef & " has already beend added. All batches must have a unique batch Id"
            rtn.ErrorCode = "BATCHREF_NOT_UNIQUE"
            Return rtn
        End If

        'Validate that all Transactions are unique
        'For Each row In Transactions
        '    If Transactions.Where(Function(x) x.UniqueTRXRef = row.UniqueTRXRef).Count > 1 Then
        '        rtn.Status = "FAILED"
        '        rtn.Message = "All transaction must have a unique id (within the batch). A duplicate transaction has been found for ID '" & row.TransactionId_READONLY & "'."
        '        rtn.ErrorCode = @
        '        Return rtn
        '    End If
        'Next

        'Validate that the Batch is Balanced
        If Transactions.Sum(Function(x) x.Amount) <> 0 Then
            rtn.Status = "FAILED"
            rtn.Message = "This batch does not balance. All transactions must sum to zero (exactly). This batch is out by " & Transactions.Sum(Function(x) x.Amount)
            rtn.ErrorCode = "BATCH_NOT_BALANCED"
            Return rtn
        End If
       



        Dim insert As New FCX_API_FinBat
        insert.DeveloperId = developer.DeveloperId
        insert.Ledger = Ledger
        insert.Description = Description
        insert.Status = BatchStatus.Received
        insert.UniqueBatchRef = UniqueBatRef
        d.FCX_API_FinBats.InsertOnSubmit(insert)
        d.SubmitChanges()
        For Each row In Transactions
            Dim trx = New FCX_API_FinTran
            trx.Account = row.Account
            trx.Amount = row.Amount
            trx.Description = row.Description
            trx.FinBatId = insert.FinBatId
            trx.R_C = row.RC
            trx.TrxDate = row.TrxDate
            If Not row.optionalCalendarMonth Is Nothing Then
                trx.Month = row.optionalCalendarMonth
            End If
            If Not row.optionalCalendarYear Is Nothing Then
                trx.Year = row.optionalCalendarYear
            End If
            trx.UniqueTrxRef = row.UniqueTRXRef
            d.FCX_API_FinTrans.InsertOnSubmit(trx)

        Next
        d.SubmitChanges()

        rtn.Status = "SUCCESS"
        rtn.Message = ""

        Return (rtn)
    End Function
  


    <WebMethod()> _
    Public Function AddDonation(ByVal ApiKey As Guid, ByVal UniqueRef As String, ByVal DonorId As String, ByVal Description As String, ByVal Transactions() As FinancialTransaction) As TrxResponse
        'Dim rtn As New TrxResponse

        'Dim developer = Authenticate(ApiKey, rtn)
        'If developer Is Nothing Then
        '    Return rtn
        'End If
        'Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        'Dim d As New FCXDataContext
        ''Validate that BatchId is Unique
        'If d.FCX_API_FinBats.Where(Function(x) x.DeveloperId = developer.DeveloperId And x.UniqueBatchRef = UniqueBatRef And x.FCX_API_Key.PortalId = PS.PortalId).Count() > 0 Then
        '    rtn.Status = "FAILED"
        '    rtn.Message = "A batch with ID" & UniqueRef & " has already beend added. All batches must have a unique batch Id"
        '    Return rtn
        'End If

        ''Validate that all Transactions are unique
        'For Each row In Transactions
        '    If Transactions.Where(Function(x) x.UniqueTRXRef = row.UniqueTRXRef).Count > 1 Then
        '        rtn.Status = "FAILED"
        '        rtn.Message = "All transaction must have a unique id (within the batch). A duplicate transaction has been found for ID '" & row.TransactionId_READONLY & "'."
        '        Return rtn
        '    End If
        'Next

        'Dim insert As New FCX_API_FinBat
        'insert.DeveloperId = developer.DeveloperId
        'insert.Ledger = Ledger
        'insert.Description = Description
        'insert.Status = BatchStatus.Received
        'insert.UniqueBatchRef = UniqueBatRef
        'd.FCX_API_FinBats.InsertOnSubmit(insert)
        'd.SubmitChanges()
        'For Each row In Transactions
        '    Dim trx = New FCX_API_FinTran
        '    trx.Account = row.Account
        '    trx.Amount = row.Amount
        '    trx.Description = row.Description
        '    trx.FinBatId = insert.FinBatId
        '    trx.R_C = row.RC
        '    trx.TrxDate = row.TrxDate
        '    If Not row.optionalCalendarMonth Is Nothing Then
        '        trx.Month = row.optionalCalendarMonth
        '    End If
        '    If Not row.optionalCalendarYear Is Nothing Then
        '        trx.Year = row.optionalCalendarYear
        '    End If
        '    trx.UniqueTrxRef = row.UniqueTRXRef
        '    d.FCX_API_FinTrans.InsertOnSubmit(trx)

        'Next
        'd.SubmitChanges()

        'rtn.Status = "SUCCESS"
        'rtn.Message = ""

        'Return (rtn)
    End Function




    <WebMethod()> _
    Public Function GetStatusOfBatch(ByVal ApiKey As String, ByVal UniqueBatRef As String) As TrxResponse
        Dim rtn As New TrxResponse
        Dim developer = Authenticate(New Guid(ApiKey), rtn)
        If developer Is Nothing Then
            Return rtn
        End If
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim d As New FCXDataContext
        Dim q = From c In d.FCX_API_FinBats Where c.FCX_API_Key.DeveloperId = developer.DeveloperId And c.FCX_API_Key.PortalId = PS.PortalId And c.UniqueBatchRef = UniqueBatRef

        If q.Count > 0 Then
            rtn.Status = BatchStatus.Name(q.First.Status)
            rtn.Message = q.First.StatusDesc
        Else
            rtn.Status = "ERROR"
            rtn.Message = "Batch Not Found"
            rtn.ErrorCode = "BATCH_NOT_FOUND"
        End If
        Return rtn
    End Function

    <WebMethod()> _
    Public Function UndoBatch(ByVal ApiKey As String, ByVal UniqueBatRef As String) As TrxResponse
        Dim rtn As New TrxResponse
        Dim developer = Authenticate(New Guid(ApiKey), rtn)
        If developer Is Nothing Then
            Return rtn
        End If
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim d As New FCXDataContext
        Dim q = From c In d.FCX_API_FinBats Where c.FCX_API_Key.DeveloperId = developer.DeveloperId And c.FCX_API_Key.PortalId = PS.PortalId And c.UniqueBatchRef = UniqueBatRef

        If q.Count > 0 Then
            'UNDO the batch here
            q.First.Status = BatchStatus.Undo
            rtn.Status = "SUCCESS"
            rtn.Message = "The batch will be deleted (if unprocessed) or reversed. You will be notified via the ITN."

        Else
            rtn.Status = "ERROR"
            rtn.Message = "Batch Not Found"
            rtn.ErrorCode = "BATCH_NOT_FOUND"
        End If
        Return rtn
    End Function




    Private Function Authenticate(ByVal ApiKey As Guid, ByRef rtn As TrxResponse) As FCX_API_Key
        Dim d As New FCXDataContext
        Dim q = d.FCX_API_Keys.Where(Function(x) x.API_KEY = ApiKey)

        If q.Count > 0 Then
            If q.First.Active Then
                'Check Whitelist
                Dim sender = HttpContext.Current.Request.UrlReferrer.AbsoluteUri()
                Dim ipAddress = HttpContext.Current.Request.ServerVariables("remote_addr")
                If ValidateWhiteList(q.First.WhiteList, sender, ipAddress) Then
                    Return q.First
                Else
                    rtn.Status = "FAILED"
                    rtn.Message = "Request denied"
                    rtn.ErrorCode = "FAILED_AUTHENTICATION"
                    Return Nothing
                End If
            Else
                rtn.Status = "FAILED"
                rtn.Message = "INVALID_APIKEY"
                Return Nothing
            End If
        Else
            rtn.Status = "FAILED"
            rtn.Message = "API-Key not recognized"
            rtn.ErrorCode = "INVALID_APIKEY"
            Return Nothing
        End If

    End Function




    Private Function ValidateWhiteList(ByVal WhiteList As String, ByVal url As String, ByVal ip As String) As Boolean


        Dim w = WhiteList.Split(",")
        For Each row In w

            If Regex.IsMatch(url, row.Trim(",").Trim(" ").Replace(".", "\.").Replace("*", ".*") & ".*") Then
                Return True

            ElseIf row.Trim(",").Trim(" ") = ip Then
                Return True
            End If

        Next
        Return False
    End Function




End Class





Public Class BatchStatus
    Public Const Received As Integer = 1
    Public Const ReceivedWithValidationError As Integer = 2
    Public Const Downloading As Integer = 3
    Public Const DownloadError As Integer = 4
    Public Const Downloaded As Integer = 5
    Public Const Undo As Integer = 6
    Public Const Undone As Integer = 7

    Public Const OtherError As Integer = 8

    Public Shared Function Name(ByVal BatchStatusNo As Integer) As String
        Select Case BatchStatusNo
            Case 1 : Return "Received"
            Case 2 : Return "ReceivedWithValidationError"
            Case 3 : Return "Downloading"
            Case 4 : Return "DownloadError"
            Case 5 : Return "Downloaded"
            Case 6 : Return "Undo"
            Case 7 : Return "Undone"

            Case Else : Return "OtherError"

        End Select
    End Function
End Class

