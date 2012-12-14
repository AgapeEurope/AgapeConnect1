Imports System.Linq
Imports Billboard
Imports DotNetNuke
Imports DotNetNuke.Services.FileSystem
Imports DotNetNuke.Entities.Users

Partial Class DesktopModules_Billboard_controls_Community
    Inherits System.Web.UI.UserControl
    Public Sub Initialise(ByVal ThisUser As Integer, ByVal Mode As Integer)
        If hfChosenComm.Value = "" Or hfChosenComm.Value Is Nothing Then
            hfChosenComm.Value = -1
        End If
        hfThisUser.Value = ThisUser
        If Mode = 1 Then
            hfMode.Value = 1
        ElseIf Mode = 2 Then
            hfMode.Value = 2
        Else
            hfMode.Value = 1
        End If
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Communities Where c.ReplyId = -3 Join b In d.Users On c.AuthorId Equals b.UserID Select c.AuthorId, c.BillboardCommId, c.DateSub, c.ReplyId, c.Text, b.DisplayName Order By DateSub Descending
        accMain.DataSource = q
        accMain.DataBind()
        If q.Count > 0 Then
            lblNoComm.Visible = False
        Else
            lblNoComm.Text = "There are currently no community items."
            lblNoComm.Visible = True
        End If

    End Sub
    Public Function GetCommImage(ByVal CommId As Integer) As String
        Dim Out As String = ""
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = CommId
        If q.Count > 0 Then
            Dim commuser As DotNetNuke.Entities.Users.UserInfo
            If q.First.AuthorId > 1 Then
                commuser = UserController.GetUserById(0, q.First.AuthorId)
                Dim fileid = commuser.Profile.GetPropertyValue("Photo")
                Dim _theFile As IFileInfo = FileManager.Instance.GetFile(fileid)
                Out = FileManager.Instance.GetUrl(_theFile)
            Else
                Out = "~/images/no_avatar.gif"
            End If


            '    Out = "~/DesktopModules/StaffDirectory/GetImage.aspx?size=30&UserId=" & q.First.AuthorId
        End If
        Return Out
    End Function
    Public Function GetReplies(ByVal CommId As Integer) As String
        Dim Out As String = ""
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Communities Where c.ReplyId = CommId

        If Not q.Count = 1 Then
            Out = q.Count & " Replies"
        Else
            Out = "1 Reply"
        End If

        Return Out
    End Function
    Protected Sub hfDeleteThis_ValueChanged(sender As Object, e As System.EventArgs) Handles hfDeleteThis.ValueChanged

    End Sub
    Protected Sub btnNewComm2_Click(sender As Object, e As System.EventArgs) Handles btnNewComm2.Click
        If Not (tbNewComm2.Text = "" Or tbNewComm2.Text Is Nothing) Then
            Dim d As New Billboard.BillboardDataContext
            Dim insert As New Billboard.Agape_Billboard_Community
            insert.AuthorId = hfThisUser.Value
            insert.DateSub = Now()
            insert.ReplyId = -3
            insert.Text = tbNewComm2.Text
            insert.Sent = False
            d.Agape_Billboard_Communities.InsertOnSubmit(insert)
            d.SubmitChanges()
            tbNewComm2.Text = ""
            accMain.DataBind()
            lblNoComm.Visible = False
            UpdatePanel2.Update()

            'Dim t As Type = btnNewComm2.GetType()
            'Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
            'sb.Append("<script language='javascript'>")
            'sb.Append("closeAddLink();")
            'sb.Append("</script>")
            'ScriptManager.RegisterStartupScript(btnNewComm2, t, "popupAdd1", sb.ToString, False)
        End If

    End Sub
    Protected Sub btnRepComm2_Click(sender As Object, e As System.EventArgs) Handles btnRepComm2.Click
        If Not (tbRepComm.Text = "" Or tbRepComm.Text Is Nothing) Then
            Dim d As New Billboard.BillboardDataContext
            Dim insert As New Billboard.Agape_Billboard_Community
            insert.AuthorId = hfThisUser.Value
            insert.DateSub = Now()
            insert.ReplyId = hfChosenComm.Value
            insert.Text = tbRepComm.Text
            d.Agape_Billboard_Communities.InsertOnSubmit(insert)
            d.SubmitChanges()
            tbRepComm.Text = ""
            Dim ThisIndex As Integer
            ThisIndex = hfSelInd.Value
            hfChosenComm.Value = -1
            hfSelInd.Value = -1
            accMain.SelectedIndex = ThisIndex
            accMain.DataBind()
            UpdatePanel2.Update()
        End If
    End Sub
    Protected Sub lbFalse_Click(sender As Object, e As System.EventArgs) Handles lbFalse.Click
        Try
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = CInt(hfDeleteThis.Value) Or c.ReplyId = CInt(hfDeleteThis.Value)
            If q.Count > 0 Then
                For Each item In q
                    d.Agape_Billboard_Communities.DeleteOnSubmit(item)
                    d.SubmitChanges()
                Next
                Dim r = From c In d.Agape_Billboard_Communities Where c.ReplyId = -3 Join b In d.Users On c.AuthorId Equals b.UserID Select c.AuthorId, c.BillboardCommId, c.DateSub, c.ReplyId, c.Text, b.DisplayName Order By DateSub Descending
                accMain.DataSource = r
                accMain.DataBind()
                UpdatePanel2.Update()
            End If
        Catch ex As Exception
            lblTest.Text = ex.Message
            lblTest.Visible = True
        End Try
    End Sub
    Protected Sub accMain_ItemDataBound(sender As Object, e As AjaxControlToolkit.AccordionItemEventArgs) Handles accMain.ItemDataBound
        If e.ItemType = AjaxControlToolkit.AccordionItemType.Content Then
            Dim d As New Billboard.BillboardDataContext
            Dim hfValue As Integer = CType(e.AccordionItem.FindControl("hfThisId"), HiddenField).Value
            Dim dtl As DataList = CType(e.AccordionItem.FindControl("dlChoice"), DataList)
            Dim q = From c In d.Agape_Billboard_Communities Where c.ReplyId = CInt(hfValue) Join b In d.Users On c.AuthorId Equals b.UserID Select c.Text, b.DisplayName, c.DateSub, c.BillboardCommId
            If q.Count > 0 Then
                dtl.DataSource = q
                dtl.DataBind()
            End If
        End If
    End Sub

    Protected Sub accMain_ItemCommand(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs) Handles accMain.ItemCommand
        If e.CommandName = "DeleteThread" Then
            Try
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = CInt(e.CommandArgument) Or c.ReplyId = CInt(e.CommandArgument)
                If q.Count > 0 Then
                    For Each item In q
                        d.Agape_Billboard_Communities.DeleteOnSubmit(item)
                        d.SubmitChanges()
                    Next
                    Dim r = From c In d.Agape_Billboard_Communities Where c.ReplyId = -3 Join b In d.Users On c.AuthorId Equals b.UserID Select c.AuthorId, c.BillboardCommId, c.DateSub, c.ReplyId, c.Text, b.DisplayName Order By DateSub Descending
                    accMain.DataSource = r
                    accMain.DataBind()
                    If r.Count > 0 Then
                        lblNoComm.Visible = False
                    Else
                        lblNoComm.Text = "There are currently no community items."
                        lblNoComm.Visible = True
                    End If
                    UpdatePanel2.Update()
                End If
            Catch ex As Exception
                lblTest.Text = ex.Message
                lblTest.Visible = True
            End Try
        End If
    End Sub
    Public Sub dlChoice_ItemCommand(sender As Object, e As System.Web.UI.WebControls.CommandEventArgs)
        If e.CommandName = "DeleteSubThread" Then
            Try
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = CInt(e.CommandArgument)
                If q.Count > 0 Then
                    Dim Base As Integer = q.First.ReplyId
                    For Each item In q
                        d.Agape_Billboard_Communities.DeleteOnSubmit(item)
                        d.SubmitChanges()
                    Next
                    accMain.DataBind()
                    UpdatePanel2.Update()
                End If
            Catch ex As Exception
                lblTest.Text = ex.Message
                lblTest.Visible = True
            End Try
        End If

    End Sub
    Public Function AllowDelete(ByVal ThisCommId As Integer) As Boolean
        Dim out As Boolean = False
        If hfMode.Value = 2 Then
            out = True
        Else
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = ThisCommId
            If q.Count > 0 Then
                If q.First.ReplyId <> -3 Then
                    Dim r = From c In d.Agape_Billboard_Communities Where c.BillboardCommId = q.First.ReplyId
                    If r.Count > 0 Then
                        If r.First.AuthorId = hfThisUser.Value Then
                            out = True
                        End If
                    End If
                    If q.First.AuthorId = hfThisUser.Value Then
                        out = True
                    End If
                Else
                    If q.First.AuthorId = hfThisUser.Value Then
                        out = True
                    End If
                End If
            End If
        End If
        Return out
    End Function
End Class
