Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Net
Imports System.IO
' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FCX_TBroker
    Inherits System.Web.Services.WebService

    Structure TrxResponse
        Public DownloadBatches() As FCX_API.Batch
        Public UndoBatches() As FCX_API.Batch

        Public Settings As Settings
        
        Public Status As String
        Public Message As String

    End Structure

    Structure ACUnit
        Public Code As String
        Public Name As String
        Public Type As Integer
    End Structure

    Structure StatusDescription
        Public Status As String
        Public Message As String
        Public RowId As Integer
        Public ActualPeriod As Integer
        Public ActualYear As Integer
        Public BatchId As String
    End Structure

    Structure APBalanceInfo
        Public RC As String
        Public ExpensesPayable As Double 'Payable (including NET taxable exenses)
        Public SpSalaryAdv As Double 'Taxable Expenses
        
    End Structure


    Structure Settings
        Public AccountsPayable As String
        Public SpecialSalaryAdvance As String

    End Structure


    <WebMethod()> _
    Public Function HelloWorld(ByVal ApiKey As Guid) As String
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        If Authenticate(ApiKey, PS.PortalId) = False Then
            Return Nothing
        End If

        Return "HelloWorld"
    End Function


    <WebMethod()> _
    Public Function GetTransactions(ByVal ApiKey As Guid) As TrxResponse


        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        If Authenticate(ApiKey, PS.PortalId) = False Then
            Return Nothing
        End If

        Try

        
        Dim DownloadStatuses() As Integer = {BatchStatus.Received, BatchStatus.Downloading, BatchStatus.DownloadError}
        Dim d As New FCX.FCXDataContext
        Dim batches = From c In d.FCX_API_FinBats Where c.FCX_API_Key.PortalId = PS.PortalId And DownloadStatuses.Contains(c.Status)

        Dim rtn As New TrxResponse
        rtn.DownloadBatches = FormatBatches(batches)
        Dim undo = From c In d.FCX_API_FinBats Where c.FCX_API_Key.PortalId = PS.PortalId And c.Status = BatchStatus.Undo

        rtn.UndoBatches = FormatBatches(undo)
        rtn.Settings = GetSettings()

        If batches.Count + undo.Count = 0 Then
            rtn.Status = "Nothing to do"
        Else
            rtn.Status = "New Data"
        End If


            Return rtn
        Catch ex As Exception
            Dim rtn As New TrxResponse
            rtn.Status = "Error"
            rtn.Message = ex.Message
            Return rtn
        End Try
    End Function

    Private Function FormatBatches(ByVal input As IQueryable(Of FCX.FCX_API_FinBat)) As FCX_API.Batch()
        Dim rtn() As FCX_API.Batch = New FCX_API.Batch(input.Count - 1) {}

        Dim j As Integer = 0
        For Each Batch In input
            Dim newB As New FCX_API.Batch
            newB.Description = Batch.Description
            set_if(newB.Downloaded, Batch.Downloaded)
            newB.ITNSent = Batch.ITN_Sent
            newB.Ledger = Batch.Ledger
            set_if(newB.Received, Batch.Received)
            newB.Status = Batch.Status
            set_if(newB.StatusDesc, Batch.StatusDesc)
            newB.UniqueBatRef = Batch.UniqueBatchRef
            newB.BatchId_READONLY = Batch.FinBatId
            newB.Transactions = New FCX_API.FinancialTransaction(Batch.FCX_API_FinTrans.Count - 1) {}
            Dim i As Integer = 0
            For Each tran In Batch.FCX_API_FinTrans
                Dim newT As New FCX_API.FinancialTransaction
                newT.Account = tran.Account
                newT.Amount = tran.Amount
                newT.Description = tran.Description
                set_if(newT.optionalCalendarMonth, tran.Month)
                set_if(newT.optionalCalendarYear, tran.Year)
                newT.RC = tran.R_C
                newT.UniqueTRXRef = tran.UniqueTrxRef
                newT.TrxDate = tran.TrxDate
                newT.TransactionId_READONLY = tran.FinTransId
                newB.Transactions(i) = newT

                i += 1
            Next
            rtn(j) = newB
            j += 1
        Next

        Return rtn
    End Function


    <WebMethod()> _
    Public Sub UpdateTransactions(ByVal ApiKey As Guid, ByVal Batches() As FCX_API.Batch)
        Dim d As New FCX.FCXDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        If Authenticate(ApiKey, PS.PortalId) = False Then
            Return
        End If


        For Each row In Batches
            'Find the Batch
            Dim theBatch = From c In d.FCX_API_FinBats Where c.FCX_API_Key.PortalId = PS.PortalId And c.FinBatId = row.BatchId_READONLY

            If theBatch.Count > 0 Then
                'update the batch
                theBatch.First.Status = row.Status
                theBatch.First.StatusDesc = row.StatusDesc
                theBatch.First.Downloaded = Now
                theBatch.First.ITN_Sent = False

            End If
        Next
        d.SubmitChanges()


        SendITN()



    End Sub


    'Check and Send unsent ITN
    Private Sub SendITN()
        Dim d As New FCX.FCXDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)


        Dim q = From c In d.FCX_API_FinBats Where c.FCX_API_Key.PortalId = PS.PortalId And c.Status <> BatchStatus.Received And c.ITN_Sent = False
            Group c By c.FCX_API_Key.ITN Into Group Select New With {.ITN = ITN, .CompleteBatches = Group, .Batches = From b In Group Select b.UniqueBatchRef, b.StatusDesc, b.Received, b.Downloaded}

        For Each row In q
            Dim postData As String = row.Batches.ToJson()
            Dim req As HttpWebRequest = WebRequest.Create(row.ITN)

            req.ContentType = "application/json"
            req.ContentLength = postData.Length
            req.Method = "POST"

            Dim writer As New StreamWriter(req.GetRequestStream)

            writer.Write(postData)
            writer.Flush()
            writer.Close()

            For Each bat In row.CompleteBatches
                bat.ITN_Sent = True

            Next
        Next
        d.SubmitChanges()



    End Sub

    <WebMethod()> _
    Public Sub SetAPBalances(ByVal ApiKey As Guid, ByVal Balances As APBalanceInfo())
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        If Authenticate(ApiKey, PS.PortalId) = False Then
            Return
        End If

        Dim d As New StaffBroker.StaffBrokerDataContext
        Dim q = From c In d.AP_Staff_SuggestedPayments Where c.PortalId = PS.PortalId

        d.AP_Staff_SuggestedPayments.DeleteAllOnSubmit(q)
        d.SubmitChanges()

        For Each row In Balances
            Dim insert As New StaffBroker.AP_Staff_SuggestedPayment
            insert.CostCenter = row.RC
            insert.ExpPayable = row.ExpensesPayable
            insert.ExpTaxable = row.SpSalaryAdv
            insert.PortalId = PS.PortalId
            d.AP_Staff_SuggestedPayments.InsertOnSubmit(insert)
        Next

        d.SubmitChanges()
       
    End Sub


    Private Function Authenticate(ByVal ApiKey As Guid, ByVal PortalId As Integer) As Boolean
       


        If StaffBrokerFunctions.GetSetting("TB-KEY", PortalId) = ApiKey.ToString Then
            Dim ip = StaffBrokerFunctions.GetSetting("TB-IP", PortalId)
            Dim ipAddress = HttpContext.Current.Request.ServerVariables("remote_addr")
            If ip.Trim() = "" Or ip.Trim() = ipAddress Then
                Return True
            End If
        End If
        Return False



    End Function


    Private Sub set_if(ByRef setting As Object, ByVal value As Object)
        If value Is Nothing Then
            Return
        Else
            setting = value

        End If
    End Sub

    <WebMethod()> _
    Public Sub TestUpdateBatches(ByVal ApiKey As String)
        SendITN()
    End Sub


    <WebMethod()> _
    Public Sub UpdateAccounts(ByVal ApiKey As Guid, ByVal ccs As ACUnit(), ByVal accs As ACUnit())
        'Update the list of accounts and Cost centres
        Dim d As New FCX.FCXDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        If Authenticate(ApiKey, PS.PortalId) = False Then
            Return
        End If
        AccountRefresh(ccs, accs)



    End Sub
    Private Function GetSettings() As Settings
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim rtn As New Settings
        Dim mc As New DotNetNuke.Entities.Modules.ModuleController
        Dim x = mc.GetModuleByDefinition(PS.PortalId, "acStaffRmb")
        If Not x Is Nothing Then
            Dim r = x.TabModuleSettings
            set_if(rtn.AccountsPayable, r("AccountsPayable"))
            set_if(rtn.SpecialSalaryAdvance, r("TaxAccountsReceivable"))

        End If

        Return rtn

    End Function

    Private Sub AccountRefresh(ByVal ccs As ACUnit(), ByVal accs As ACUnit())

        Dim d As New StaffBroker.StaffBrokerDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim _ccs = From c In d.AP_StaffBroker_CostCenters Where c.PortalId = PS.PortalId

        Dim _accs = From c In d.AP_StaffBroker_AccountCodes Where c.PortalId = PS.PortalId

        For Each row In accs
            Dim theRow = row
            Dim test = From c In _accs Where c.AccountCode = theRow.Code And c.PortalId = PS.PortalId
            If test.Count > 0 Then
                If test.First.AccountCodeName <> theRow.Name Or test.First.AccountCodeType <> theRow.Type Then
                    test.First.AccountCodeName = theRow.Name
                    test.First.AccountCodeType = theRow.Type

                End If
            Else
                Dim insert As New StaffBroker.AP_StaffBroker_AccountCode
                insert.PortalId = PS.PortalId
                insert.AccountCode = theRow.Code
                insert.AccountCodeName = theRow.Name
                insert.AccountCodeType = theRow.Type
                d.AP_StaffBroker_AccountCodes.InsertOnSubmit(insert)
            End If
        Next

        For Each row In ccs
            Dim theRow = row
            Dim test = From c In _ccs Where c.CostCentreCode = theRow.Code And c.PortalId = PS.PortalId
            If test.Count > 0 Then
                If test.First.CostCentreName <> theRow.Name Or test.First.Type <> theRow.Type Then
                    test.First.CostCentreName = theRow.Name
                    test.First.CostCentreName = theRow.Type

                End If
            Else
                Dim insert As New StaffBroker.AP_StaffBroker_CostCenter
                insert.PortalId = PS.PortalId
                insert.CostCentreCode = theRow.Code
                insert.CostCentreName = theRow.Name
                insert.Type = theRow.Type
                d.AP_StaffBroker_CostCenters.InsertOnSubmit(insert)
            End If
        Next

        d.SubmitChanges()
    End Sub


End Class