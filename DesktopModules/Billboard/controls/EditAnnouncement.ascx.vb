Imports System.Linq
Imports Billboard


Partial Class controls_Billboard_EditAnnouncement
    Inherits System.Web.UI.UserControl
    'Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
    '    'If first time page is submitted and we have file in FileUpload control but not in session 
    '    'Store the values to Session Object 
    '    If Session("FileUploadEdit") Is Nothing And fuEditAttach.HasFile Then
    '        Session("FileUploadEdit") = fuEditAttach
    '    ElseIf Not (Session("FileUploadEdit") Is Nothing) And Not (fuEditAttach.HasFile) Then
    '        'Next time submit and Session has values but FileUpload is Blank 
    '        'Return the values from session to FileUpload   
    '        fuEditAttach = CType(Session("FileUploadEdit"), FileUpload)
    '    ElseIf fuEditAttach.HasFile Then
    '        'Now there could be another sictution when Session has File but user want to change the file 
    '        'In this case we have to change the file in session object 
    '        Session("FileUploadEdit") = fuEditAttach
    '    End If
    'End Sub
    Public Sub Initialise(Optional ByVal ThisUser As Integer = -1)
        
            If Not Page.IsPostBack Then
                hfFileAttach.Value = ""
                hfEditAnnId.Value = -1
                lblAttachOut.Text = ""
            End If
            Dim NowLessMonth As Date
            NowLessMonth = DateAdd(DateInterval.Month, -1.0, Now())
            hfNowLessMonth.Value = NowLessMonth
        'pnlEdit.Visible = False
            pnlTable.Visible = True
            'ClearOld()
            If ThisUser > 0 Then
                hfThisUser.Value = ThisUser
            End If

    End Sub
    Protected Sub btnDeleteAttach_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeleteAttach.Click
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = hfEditAnnId.Value

        If q.Count > 0 Then
            If System.IO.File.Exists(Server.MapPath("~/AnnounceFiles/" & q.First.FileAttach)) Then
                System.IO.File.Delete(Server.MapPath("~/AnnounceFiles/" & q.First.FileAttach))
                q.First.FileAttach = ""
                d.SubmitChanges()

                btnDeleteAttach.Visible = False
                lblCurrentAttach.Visible = False
                fuEditAttach.Visible = True
                gvAnnouncements.DataBind()
            End If
        End If

    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click

        Dim d As New Billboard.BillboardDataContext
        Dim insert As New Agape_Billboard_Announcement

        insert.AnnouncementText = tbText.Text
        insert.AnnouncementTitle = tbTitle.Text
        If cbVisible.Checked Then
            Dim r = From c In d.Agape_Billboard_Announcements Where c.Current = True And c.Sent = False Select c
            If r.Count > 4 Then
                Dim t As Type = btnAdd.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("alert(""You cannot add more than five announcements per week. You will need to make another of the visible, unsent announcements invisible before you can make this announcement visible. This article has been saved, but is not visible."");")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(btnAdd, t, "popupAdd1", sb.ToString, False)
                insert.Visible = False
                insert.Current = False
                insert.ViewOrder = -1
            Else
                insert.Visible = True
                insert.Current = True
                Dim q = From c In d.Agape_Billboard_Announcements Where c.Current = True Order By c.ViewOrder Descending Select c.ViewOrder
                If q.Count = 0 Then
                    insert.ViewOrder = 1
                Else
                    insert.ViewOrder = q.First + 1
                End If
            End If
        Else
            insert.Visible = False
            insert.Current = False
            insert.ViewOrder = -1
        End If
        If fuAttachment.HasFile Then
            If Not (System.IO.File.Exists(Server.MapPath("~/AnnounceFiles/" & fuAttachment.FileName))) Then
                Try
                    If OkAttach(fuAttachment.FileName) Then
                        fuAttachment.SaveAs(Server.MapPath("~/AnnounceFiles/" & fuAttachment.FileName))
                        hfFileAttach.Value = fuAttachment.PostedFile.FileName
                        hfFileSize.Value = fuAttachment.PostedFile.ContentLength
                        If Not (hfFileAttach.Value Is Nothing Or hfFileAttach.Value = "") Then
                            insert.FileAttach = hfFileAttach.Value
                            hfFileAttach.Value = ""
                            insert.FileSize = hfFileSize.Value
                            hfFileSize.Value = ""
                        End If
                    
                    Else
                        lblAttachOut.ForeColor = Color.Red
                        lblAttachOut.Text = "Please don't try and upload images as attachments."
                        lblAttachOut.Visible = True
                    End If
                Catch ex As Exception
                    lblAttachOut.ForeColor = Color.Red
                    lblAttachOut.Text = "<b>Error:</b> " & ex.Message
                    lblAttachOut.Visible = True
                End Try

        Else
            lblAttachOut.ForeColor = Color.Red
            lblAttachOut.Text = "There is already a file with this name on the server, please rename your file and re-upload it."
            lblAttachOut.Visible = True
        End If
        End If
        insert.AnnouncementDate = CDate(Now())
        insert.Uploader = hfThisUser.Value
        insert.Sent = False
        d.Agape_Billboard_Announcements.InsertOnSubmit(insert)
        d.SubmitChanges()
        gvAnnouncements.DataBind()
        hfFileAttach.Value = ""
        tbText.Text = ""
        tbTitle.Text = ""
        cbVisible.Checked = True
        lblAttachOut.Text = ""
        lblAttachOut.Visible = False


    End Sub
    Public Function MakeBytes(ByVal InBytes As Integer) As String
        Dim outPut As String = ""
        If InBytes < 1024 Then
            outPut = InBytes & " bytes"
        ElseIf InBytes < 1048576 And InBytes > 1023 Then
            outPut = CInt(InBytes / 1024) & " kB"
        Else
            outPut = CDbl(InBytes / 1048576).ToString("0.00") & " MB"
        End If
        Return outPut
    End Function
    Public Function TestBytes(ByVal ThisAnnId As Integer) As String
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = ThisAnnId Select c.FileSize

        If q.First Is Nothing Then
            Return ""
        Else
            Return " (" & MakeBytes(q.First) & ")"
        End If
    End Function
    Public Function AttachVis(ByVal AnnId As Integer) As Boolean
        Dim thisOut As Boolean = False
        Dim d As New BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId Select c.FileAttach
        If q.Count > 0 Then
            If Not (q.First = "" Or q.First = Nothing) Then
                thisOut = True
            End If
        End If
        Return thisOut
    End Function
    Protected Sub gvAnnouncements_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvAnnouncements.RowCommand
        Dim d As New Billboard.BillboardDataContext
        If e.CommandName = "MyEdit" Then
            hfFileAttach.Value = ""
            Dim ThisAnnouncementId As Integer = CInt(e.CommandArgument)
            Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = ThisAnnouncementId
            If q.Count > 0 Then
                hfEditAnnId.Value = ThisAnnouncementId
                lblAuthorDate.Text = (From c In d.Users Where c.UserID = q.First.Uploader Select c.DisplayName).First & ", " & CDate(q.First.AnnouncementDate).ToString("dd/MM/yyyy")
                If q.First.Sent = True Then
                    lblEditError.Text = "You can only make this visible or invisble as it has already been sent"
                    lblEditError.Visible = True
                    tbEditText.Enabled = False
                    tbEditTitle.Enabled = False
                Else
                    tbEditText.Enabled = True
                    tbEditTitle.Enabled = True
                    lblEditError.Visible = False
                End If
                tbEditText.Text = q.First.AnnouncementText
                tbEditTitle.Text = q.First.AnnouncementTitle
                cbEditVisible.Checked = q.First.Visible
                If Not (q.First.FileAttach = "" Or q.First.FileAttach Is Nothing) Then
                    lblCurrentAttach.Text = q.First.FileAttach
                    lblCurrentAttach.Visible = True
                    'btnEditAttach.Visible = False
                    fuEditAttach.Visible = False
                    btnDeleteAttach.Visible = True
                Else
                    btnDeleteAttach.Visible = False
                    lblCurrentAttach.Visible = False
                    fuEditAttach.Visible = True
                    'btnEditAttach.Visible = True
                End If
                'pnlEdit.Visible = True
                'pnlTable.Visible = False
                Dim t As Type = gvAnnouncements.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("showEditAnn();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(gvAnnouncements, t, "popupAdd3", sb.ToString, False)
            End If
        ElseIf e.CommandName = "Promote" Then
            Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = CInt(e.CommandArgument)
            If q.Count > 0 Then
                If Not q.First.ViewOrder = 1 Then
                    Dim r = From c In d.Agape_Billboard_Announcements Where c.ViewOrder = q.First.ViewOrder - 1 Select c
                    If r.Count > 0 Then
                        r.First.ViewOrder = q.First.ViewOrder
                    End If
                    q.First.ViewOrder = q.First.ViewOrder - 1
                    d.SubmitChanges()
                End If
                gvAnnouncements.DataBind()
            End If
        ElseIf e.CommandName = "Demote" Then
            Dim s = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = CInt(e.CommandArgument)
            Dim t = From c In d.Agape_Billboard_Announcements Where 1 = 1 Order By c.ViewOrder Descending
            If s.Count > 0 Then
                If Not s.First.ViewOrder = t.First.ViewOrder Then
                    Dim u = From c In d.Agape_Billboard_Announcements Where c.ViewOrder = s.First.ViewOrder + 1 Select c
                    If u.Count > 0 Then
                        u.First.ViewOrder = s.First.ViewOrder
                    End If
                    s.First.ViewOrder = s.First.ViewOrder + 1
                    d.SubmitChanges()
                End If
                gvAnnouncements.DataBind()
            End If
        ElseIf e.CommandName = "MyDelete" Then
            Dim u = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = CInt(e.CommandArgument)
            If u.Count > 0 Then
                If u.First.Visible = False Then
                    If Not (u.First.FileAttach = "" Or u.First.FileAttach Is Nothing) Then
                        If System.IO.File.Exists(Server.MapPath("~/AnnounceFiles/" & u.First.FileAttach)) Then
                            System.IO.File.Delete(Server.MapPath("~/AnnounceFiles/" & u.First.FileAttach))
                        End If
                    End If
                    d.Agape_Billboard_Announcements.DeleteOnSubmit(u.First)
                    d.SubmitChanges()
                    Dim v = From c In d.Agape_Billboard_Announcements Where c.Current = True Order By c.ViewOrder Ascending
                    Dim OrderCount As Integer = 1
                    If v.Count > 0 Then
                        For Each Ann In v
                            Ann.ViewOrder = OrderCount
                            OrderCount = OrderCount + 1
                            d.SubmitChanges()
                        Next
                    End If
                    gvAnnouncements.DataBind()
                End If
            End If
            End If
    End Sub
    Public Sub ClearOld()
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementDate <= DateAdd(DateInterval.Month, -6.0, Now()) Select c
        If q.Count > 0 Then
            For Each OldAnn In q
                OldAnn.Current = 0
                OldAnn.ViewOrder = -1
            Next
            d.SubmitChanges()
            Dim r = From c In d.Agape_Billboard_Announcements Where c.Current = True Order By c.ViewOrder Ascending
            Dim OrderCount As Integer = 1
            If r.Count > 0 Then
                For Each Ann In r
                    Ann.ViewOrder = OrderCount
                    OrderCount = OrderCount + 1
                    d.SubmitChanges()
                Next
            End If
        End If
        gvAnnouncements.DataBind()
    End Sub
    Public Function ButtonEnabled(ByVal AnnId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
        If q.Count > 0 Then
            If q.First.Sent = False Then
                Out = True
            End If
        End If

        Return Out
    End Function
    Public Function ButtonEnabled2(ByVal AnnId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
        Dim r = From c In d.Agape_Billboard_Announcements Where c.Visible = True And c.Sent = False
        If q.Count > 0 And r.Count > 1 Then
            If q.First.Visible = True And q.First.Sent = False Then
                Out = True
            End If
        End If

        Return Out
    End Function
    Public Function ButtonEnabled3(ByVal AnnId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
        If q.Count > 0 Then
            If q.First.Visible = False Then
                Out = True
            End If
        End If

        Return Out
    End Function
    Public Function GreyButton(ByVal AnnId As Integer, ByVal Up As Boolean) As String
        Dim Out As String = ""

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
        Dim r = From c In d.Agape_Billboard_Announcements Where c.Visible = True And c.Sent = False
        If q.Count > 0 Then
            If q.First.Current = True And r.Count > 1 Then
                If Up Then
                    Out = "~/images/up.gif"
                Else
                    Out = "~/images/dn.gif"
                End If
            Else
                If Up Then
                    Out = "~/images/upgrey.gif"
                Else
                    Out = "~/images/dngrey.gif"
                End If
            End If
        End If

        Return Out
    End Function
    Public Function DisplayThisName(ByVal ThisUser As Integer) As String
        Dim Out As String = ""

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Users Where c.UserID = ThisUser
        If q.Count > 0 Then
            Out = q.First.DisplayName
        End If
        
        Return Out
    End Function

    Protected Sub gvAnnouncements_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvAnnouncements.RowDataBound
        Try
            Dim AnnId As Integer = DataBinder.Eval(e.Row.DataItem, "AnnouncementId")
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = AnnId
            If q.Count > 0 Then
                If q.First.Visible Then
                    If q.First.Sent And Not q.First.Current Then
                        e.Row.BackColor = Color.FromArgb(16777113)
                    Else
                        e.Row.BackColor = Color.Transparent
                    End If
                Else
                    If q.First.Sent Then
                        e.Row.BackColor = Color.FromArgb(13434828)
                    Else
                        e.Row.BackColor = Color.FromArgb(13434879)
                    End If
                End If
            End If
        Catch ex As Exception
            lblError.Text = "Error in row colouring: " & ex.Message
            lblError.Visible = True
        End Try
    End Sub
    'Protected Sub btnCancelEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelEdit.Click
    '    'pnlEdit.Visible = False
    '    pnlTable.Visible = True
    'End Sub
    Protected Sub btnUpdateEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateEdit.Click
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Announcements Where c.AnnouncementId = hfEditAnnId.Value
        If q.Count > 0 Then
            Dim VisibleCurrent As Boolean = cbEditVisible.Checked
            Dim TextCurrent As String = tbEditText.Text
            Dim TitleCurrent As String = tbEditTitle.Text
            If (TextCurrent = "" Or TitleCurrent = "") And VisibleCurrent Then
                lblEditError.Text = "Each Announcement must have a title and some text."
                lblEditError.Visible = True
            Else
                If q.First.Visible = False And VisibleCurrent Then
                    If q.First.Sent Then
                        q.First.Current = False
                        q.First.Visible = True
                    Else
                        Dim r = From c In d.Agape_Billboard_Announcements Where c.Current = True And c.Sent = False
                        If r.Count > 4 Then
                            Dim u As Type = btnUpdateEdit.GetType()
                            Dim sb1 As System.Text.StringBuilder = New System.Text.StringBuilder()
                            sb1.Append("<script language='javascript'>")
                            sb1.Append("alert(""You cannot add more than five announcements per week. You will need to make another of the visible, unsent announcements invisible before you can make this announcement visible. This article has been saved, but is not visible."");")
                            sb1.Append("</script>")
                            ScriptManager.RegisterStartupScript(btnUpdateEdit, u, "popupAdd2", sb1.ToString, False)
                            q.First.Visible = False
                            q.First.Current = False
                        Else
                            q.First.Visible = True
                            q.First.Current = True
                            q.First.AnnouncementDate = Now()
                        End If
                    End If
                ElseIf q.First.Visible = True And VisibleCurrent = False Then
                    q.First.Current = False
                    q.First.Visible = False
                End If
                If fuEditAttach.HasFile Then

                    If OkAttach(fuEditAttach.FileName) Then


                        If Not (System.IO.File.Exists(Server.MapPath("~/AnnounceFiles/" & fuEditAttach.FileName))) Then

                            fuEditAttach.SaveAs(Server.MapPath("~/AnnounceFiles/" & fuEditAttach.FileName))
                            'lblAttachOut.ForeColor = Color.Green
                            'lblAttachOut.Text = "File: <i>" & fuAttachment.PostedFile.FileName & "</i> Uploaded successfully"
                            hfFileAttach.Value = fuEditAttach.PostedFile.FileName
                            hfFileSize.Value = fuEditAttach.PostedFile.ContentLength
                            If Not (hfFileAttach.Value Is Nothing Or hfFileAttach.Value = "") Then
                                q.First.FileAttach = hfFileAttach.Value
                                hfFileAttach.Value = ""
                                q.First.FileSize = hfFileSize.Value
                                hfFileSize.Value = ""
                                lblEditAttach.Visible = False
                            End If

                        End If

                    Else
                        lblEditAttach.ForeColor = Color.Red
                        lblEditAttach.Text = "Please don't try and upload an image as an attachment."
                        lblEditAttach.Visible = True
                    End If
                End If
                q.First.AnnouncementText = TextCurrent
                q.First.AnnouncementTitle = TitleCurrent
                'If Not (hfFileAttach.Value = "" Or hfFileAttach.Value Is Nothing) Then
                '    q.First.FileAttach = hfFileAttach.Value
                'End If
                d.SubmitChanges()
                lblError.Visible = False
                gvAnnouncements.DataBind()
                'pnlEdit.Visible = False
                pnlTable.Visible = True
                'Dim t As Type = btnUpdateEdit.GetType()
                'Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                'sb.Append("<script language='javascript'>")
                'sb.Append("closeLink();")
                'sb.Append("</script>")
                'ScriptManager.RegisterStartupScript(btnUpdateEdit, t, "popupAdd5", sb.ToString, False)
            End If
        Else
            lblEditError.Text = "There was an error finding this announcement to save it."
            lblEditError.Visible = True
        End If
    End Sub
    Public Function OkAttach(ByVal atName As String) As Boolean
        Return Not (atName.Contains(".jpg") Or atName.Contains(".png") Or atName.Contains(".gif") Or atName.Contains(".jpeg") Or atName.Contains(".bmp"))
    End Function
    'Protected Sub btnAttach_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAttach.Click
    '    If fuAttachment.HasFile Then
    '        If Not (System.IO.File.Exists(Server.MapPath("~/AnnounceFiles/" & fuAttachment.FileName))) Then
    '            Try
    '                fuAttachment.SaveAs(Server.MapPath("~/AnnounceFiles/" & fuAttachment.FileName))
    '                lblAttachOut.ForeColor = Color.Green
    '                lblAttachOut.Text = "File: <i>" & fuAttachment.PostedFile.FileName & "</i> Uploaded successfully"
    '                hfFileAttach.Value = fuAttachment.PostedFile.FileName
    '            Catch ex As Exception
    '                lblAttachOut.ForeColor = Color.Red
    '                lblAttachOut.Text = "<b>Error:</b> " & ex.Message
    '            End Try
    '            lblAttachOut.Visible = True
    '        Else
    '            lblAttachOut.ForeColor = Color.Red
    '            lblAttachOut.Text = "There is already a file with this name on the server, please rename your file and re-upload it."
    '            lblAttachOut.Visible = True
    '        End If
    '    End If
    'End Sub
    'Protected Sub btnEditAttach_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEditAttach.Click
    '    'If fuEditAttach.HasFile Then
    '    Try
    '        fuEditAttach.SaveAs(Server.MapPath("~/AnnounceFiles/" & fuEditAttach.FileName))
    '        lblEditAttach.ForeColor = Color.Green
    '        lblEditAttach.Text = "File: <i>" & fuEditAttach.PostedFile.FileName & "</i> Uploaded successfully"
    '        hfFileAttach.Value = fuEditAttach.PostedFile.FileName
    '        lblEditAttach.Visible = True
    '    Catch ex As Exception
    '        lblEditAttach.ForeColor = Color.Red
    '        lblEditAttach.Text = "<b>Error:</b> " & ex.Message
    '        lblEditAttach.Visible = True
    '    End Try

    '    'Dim t As Type = btnEditAttach.GetType()
    '    'Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
    '    'sb.Append("<script language='javascript'>")
    '    'sb.Append("closeLink();")
    '    'sb.Append("showEditAnn();")
    '    'sb.Append("</script>")
    '    'ScriptManager.RegisterStartupScript(btnEditAttach, t, "popupAdd6", sb.ToString, False)
    '    'End If
    'End Sub
End Class

