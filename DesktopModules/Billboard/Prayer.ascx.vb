Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports Billboard


Namespace DotNetNuke.Modules.Billboard
    Partial Class Prayer
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                hfOneWeek.Value = DateAdd(DateInterval.Day, -7.0, CDate(Now()))
                hfEditPrayerId.Value = -1
                hfShowRequest.Value = Me.UserId
                hfRequestId.Value = -1
                lblEditError.Text = ""
                lblEditError.Visible = False
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
                If q.Count = 0 Then
                    lblNoPrayer.Visible = True
                    pnlMain.Visible = False
                Else
                    lblNoPrayer.Visible = False
                    pnlMain.Visible = True
                    repPrayer.DataBind()
                    
                End If
                If dlPrayerArc.Items.Count = 0 Then
                    lblNoPrayerArc.Visible = True
                    lblNoPrayerArc.Text = "There are currently no archived prayer requests."
                End If
            End If
            Dim t As Type = repPrayer.GetType()
            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
            sb.Append("<script language='javascript'>")
            sb.Append("$('#Accordion').accordion({ clearStyle: true });")
            sb.Append("</script>")
            ScriptManager.RegisterStartupScript(repPrayer, t, "popupAdd4", sb.ToString, False)
        End Sub
        Public Function ConName(ByVal ThisPrayer As Integer) As String
            Dim Out As String = ""

            Dim d As New BillboardDataContext
            Dim r = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = ThisPrayer
            If r.Count > 0 Then
                If r.First.SubBehalf Is Nothing Then
                    Dim q = From c In d.Users Where c.UserID = r.First.SubmittedBy
                    If q.Count = 1 Then
                        Out = q.First.DisplayName
                    End If
                Else
                    Out = r.First.SubBehalf
                End If


            End If


            Return Out
        End Function
        Public Function ThisIsEditable(ByVal ThisPrayer As Integer) As Boolean
            Dim Out As Boolean = False

            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = ThisPrayer
            If q.Count = 1 Then
                If q.First.SubmittedBy = Me.UserId Then
                    Out = True
                End If
            End If

            Return Out
        End Function

        Protected Sub repPrayer_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles repPrayer.ItemCommand
            If e.CommandName = "ReplyPrayer" Then
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = CInt(e.CommandArgument)
                If q.Count = 1 Then
                    Dim sendTo As String = ""
                    If q.First.SubBehalf Is Nothing Then
                        sendTo = (From c In d.Users Where c.UserID = q.First.SubmittedBy Select c.DisplayName).First
                    Else
                        sendTo = q.First.SubBehalf
                    End If
                    lblMessageTitle.Text = "Send Message to " & sendTo & " about """ & q.First.PrayerTitle & """"
                    lblNameTo.Text = sendTo
                    hfRequestId.Value = CInt(e.CommandArgument)
                End If

                tbMessageTo.Text = ""
                cbAnonymous.Checked = False
                Dim t As Type = repPrayer.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("showMessage();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(repPrayer, t, "popupAdd9", sb.ToString, False)
            ElseIf e.CommandName = "EditPrayer" Then
                btnDeletePrayer.Visible = True
                btnDeletePrayer.Enabled = True
                btnSave.Visible = False
                btnSave.Enabled = False
                btnUpdate.Visible = True
                btnUpdate.Enabled = True
                'lblEditTitle.Text = "Edit Prayer Request"
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = CInt(e.CommandArgument)
                If q.Count = 1 Then
                    tbEditText.Text = q.First.PrayerText
                    tbEditTitle.Text = q.First.PrayerTitle
                    hfEditPrayerId.Value = CInt(e.CommandArgument)
                    Dim t As Type = repPrayer.GetType()
                    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                    sb.Append("<script language='javascript'>")
                    sb.Append("showEditPrayer();")
                    sb.Append("</script>")
                    ScriptManager.RegisterStartupScript(repPrayer, t, "popupAdd1", sb.ToString, False)
                    lblEditError.Visible = False
                Else
                    lblEditError.Text = "There was an error retrieving this prayer request."
                    lblEditError.Visible = True
                End If
            ElseIf e.CommandName = "DeletePrayer" Then
                Try
                    Dim d As New BillboardDataContext
                    Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = CInt(e.CommandArgument)
                    If q.Count = 1 Then
                        d.Agape_Billboard_Prayers.DeleteOnSubmit(q.First)
                        d.SubmitChanges()
                        repPrayer.DataBind()
                        Dim r = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
                        If r.Count = 0 Then
                            lblNoPrayer.Visible = True
                            pnlMain.Visible = False
                        Else
                            lblNoPrayer.Visible = False
                            pnlMain.Visible = True
                            Dim t As Type = repPrayer.GetType()
                            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                            sb.Append("<script language='javascript'>")
                            sb.Append("$('#Accordion').accordion({ clearStyle: true });")
                            sb.Append("</script>")
                            ScriptManager.RegisterStartupScript(repPrayer, t, "popupAdd5", sb.ToString, False)
                        End If
                    End If
                Catch ex As Exception

                End Try
            End If
        End Sub
        Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
            Dim d As New BillboardDataContext
            If (tbEditText.Text <> "" And tbEditTitle.Text <> "") Then
                Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = hfEditPrayerId.Value
                If q.Count = 1 Then
                    q.First.PrayerText = tbEditText.Text
                    q.First.PrayerTitle = tbEditTitle.Text
                End If
                d.SubmitChanges()
                repPrayer.Dispose()
                repPrayer.DataBind()
                Dim t As Type = btnUpdate.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("closeEditPrayer();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(btnUpdate, t, "popupAdd2", sb.ToString, False)
                lblEditError.Text = ""
                lblEditError.Visible = False
                hfEditPrayerId.Value = -1
                Dim r = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
                If r.Count = 0 Then
                    lblNoPrayer.Visible = True
                    pnlMain.Visible = False
                Else
                    lblNoPrayer.Visible = False
                    pnlMain.Visible = True
                End If
            Else
                lblEditError.Text = "Please make sure there is some text for the title and the prayer request."
                lblEditError.Visible = True
            End If
        End Sub
        Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
            If (tbEditText.Text <> "" And tbEditTitle.Text <> "") Then
                Dim d As New BillboardDataContext
                Dim insertPrayer As New Agape_Billboard_Prayer
                insertPrayer.PrayerTitle = tbEditTitle.Text
                insertPrayer.PrayerText = tbEditText.Text
                insertPrayer.Visible = True
                insertPrayer.Current = True
                insertPrayer.SubmittedDate = CDate(Now())
                insertPrayer.SubmittedBy = Me.UserId
                insertPrayer.Sent = False
                d.Agape_Billboard_Prayers.InsertOnSubmit(insertPrayer)
                d.SubmitChanges()
                repPrayer.Dispose()
                repPrayer.DataBind()
                Dim t As Type = btnSave.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("closeEditPrayer();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(btnSave, t, "popupAdd6", sb.ToString, False)
                lblEditError.Text = ""
                lblEditError.Visible = False
                hfEditPrayerId.Value = -1
                Dim s = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
                If s.Count = 0 Then
                    lblNoPrayer.Visible = True
                    pnlMain.Visible = False
                Else
                    lblNoPrayer.Visible = False
                    pnlMain.Visible = True
                End If
            Else
                lblEditError.Text = "Please make sure there is some text for the title and the prayer request."
                lblEditError.Visible = True
            End If
        End Sub
        Protected Sub btnDeletePrayer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeletePrayer.Click
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = hfEditPrayerId.Value
            If q.Count = 1 Then
                d.Agape_Billboard_Prayers.DeleteOnSubmit(q.First)
                d.SubmitChanges()
                Dim t As Type = btnDeletePrayer.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("closeEditPrayer();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(btnDeletePrayer, t, "popupAdd3", sb.ToString, False)
                repPrayer.Dispose()
                repPrayer.DataBind()
                hfEditPrayerId.Value = -1
                lblEditError.Text = ""
                lblEditError.Visible = False
                Dim r = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
                If r.Count = 0 Then
                    lblNoPrayer.Visible = True
                    pnlMain.Visible = False
                Else
                    lblNoPrayer.Visible = False
                    pnlMain.Visible = True
                End If
            End If
        End Sub
        Protected Sub btnSendMessage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendMessage.Click
            If Not tbMessageTo.Text = "" Then
                Dim d As New BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Prayers Where c.BillboardPrayerId = hfRequestId.Value
                If q.Count = 1 Then
                    Dim r = From c In d.Users Where c.UserID = q.First.SubmittedBy
                    If r.Count = 1 Then
                        Try
                            Dim SendFrom As String = "donotreply@agape.org.uk"
                            Dim message As String = "You have received a response to your prayer request titled """ & q.First.PrayerTitle & """<br/><br/>"
                            If cbAnonymous.Checked Then
                                message = message & "The person who wrote this wishes to remain anonymous.<br/><br/>"
                            Else
                                Dim s = From c In d.Users Where c.UserID = Me.UserId
                                If s.Count = 1 Then
                                    message = message & "This is from " & s.First.DisplayName & ":<br/><br/>"
                                    SendFrom = s.First.Email
                                End If
                            End If
                            message = message & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;""" & tbMessageTo.Text & """<br/><br/>"
                            DotNetNuke.Services.Mail.Mail.SendMail(SendFrom, r.First.Email, "", "Reply to """ & q.First.PrayerTitle & """", message, "", "HTML", "", "", "", "")
                            lblErrorMessage.Visible = False
                            Dim t As Type = btnSendMessage.GetType()
                            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                            sb.Append("<script language='javascript'>")
                            sb.Append("closeMessage();")
                            sb.Append("showPopMesg();")
                            sb.Append("</script>")
                            ScriptManager.RegisterStartupScript(btnSendMessage, t, "popupAdd8", sb.ToString, False)
                            'lblMainOutput.Text = "Message sent"
                            'lblMainOutput.Visible = True
                        Catch ex As Exception
                            lblErrorMessage.Text = ex.Message
                            lblErrorMessage.Visible = True
                        End Try
                    End If
                End If
            Else
                lblErrorMessage.Text = "You must enter in some text to send."
                lblErrorMessage.Visible = True
            End If
        End Sub
        Protected Sub btnAddPrayer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddPrayer.Click
            btnDeletePrayer.Visible = False
            btnDeletePrayer.Enabled = False
            btnSave.Visible = True
            btnSave.Enabled = True
            btnUpdate.Visible = False
            btnUpdate.Enabled = False
            'lblEditTitle.Text = "Add New Prayer Request"
            lblTellText.Text = "Add Prayer Text:"
            lblTellTitle.Text = "Add Prayer Title:"
            tbEditText.Text = ""
            tbEditTitle.Text = ""
            Dim t As Type = btnAddPrayer.GetType()
            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
            sb.Append("<script language='javascript'>")
            sb.Append("showEditPrayer();")
            sb.Append("</script>")
            ScriptManager.RegisterStartupScript(btnAddPrayer, t, "popupAdd7", sb.ToString, False)
            lblEditError.Visible = False
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Prayers Where c.Current = True And c.Visible = True
            If q.Count = 0 Then
                lblNoPrayer.Visible = True
                pnlMain.Visible = False
            Else
                lblNoPrayer.Visible = False
                pnlMain.Visible = True
            End If
        End Sub
    End Class
End Namespace
