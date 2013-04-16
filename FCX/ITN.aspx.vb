Imports System.Net
Imports System.IO

<Serializable>
Class DonationBatch

    Public UniqueBatchRef As String

    Public Status As Integer
    Public StatusDesc As String
    Public ITN As String
    Public Received As String
    Public Downloaded As String
    Public Donations() As Dictionary(Of String, String)

End Class

Partial Class FCX_ITN
    Inherits System.Web.UI.Page





    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim objEventLog As New DotNetNuke.Services.Log.EventLog.EventLogController
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

        Try

       

            objEventLog.AddLog("IPN Received", "TP1", PS, 1, Log.EventLog.EventLogController.EventLogType.ADMIN_ALERT)

            Dim sr As New StreamReader(Request.InputStream)

            Dim data = sr.ReadToEnd()




            Dim batch As DonationBatch = Newtonsoft.Json.JsonConvert.DeserializeObject(Of DonationBatch)(data)
            Dim d As New Give.GiveDataContext
            Dim dc As New Cart.CartDataContext
            Dim Status As Integer
            If batch.Status = BatchStatus.Downloaded Then
                Status = OrderState.Downlaoded
            ElseIf batch.Status = BatchStatus.DownloadError Then
                Status = OrderState.ErrorDownloading
            End If
            If Not Status = Nothing Then


                For Each row In batch.Donations
                    Dim uniqueRef = row("UniqueTrxRef")
                    If uniqueRef.StartsWith("G") Then
                        Dim q = From c In dc.FR_Donations Where uniqueRef.Replace("G", "").TrimStart("0") = c.DonationID
                        If q.Count > 0 Then
                            q.First.FR_Cart_Content.FR_Cart.OrderState = Status
                        End If
                        dc.SubmitChanges()

                    ElseIf uniqueRef.StartsWith("V") Then
                        Dim q = From c In d.Agape_Give_BankTransfers Where uniqueRef.Replace("V", "").TrimStart("0") = c.VirId
                        If q.Count > 0 Then
                            q.First.Status = Status
                        End If
                        d.SubmitChanges()
                    End If



                   
                Next



            End If
            objEventLog.AddLog("IPN Received", batch.Received, PS, 1, Log.EventLog.EventLogController.EventLogType.ADMIN_ALERT)

        Catch ex As Exception
            objEventLog.AddLog("IPN Deleted", ex.Message, PS, 1, Log.EventLog.EventLogController.EventLogType.ADMIN_ALERT)

        End Try


    End Sub
End Class
