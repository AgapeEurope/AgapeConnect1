Imports System.linq
Imports Billboard

Partial Class DesktopModules_Billboard_controls_ViewArticle
    Inherits System.Web.UI.UserControl

    Public Sub Initialise(ByVal ArticleId As Integer, ByVal Mode As Integer, ByVal ThisUser As Integer)
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = ArticleId Select c
        If q.Count > 0 Then
            If Mode = 2 Or q.First.Author = ThisUser Then
                btnEdit.Visible = True
            Else
                btnEdit.Visible = False
            End If
            pnlMain.Visible = True
            lblErrorUpload.Visible = False
            If q.First.Visible = False And (Mode = 2 Or q.First.Author = ThisUser) Then
                lblErrorUpload.Text = "This article is currently invisible."
                lblErrorUpload.Visible = True
                pnlMain.Visible = True
            ElseIf q.First.Visible = False And Mode = 1 Then
                lblErrorUpload.Text = "You cannot view this article."
                lblErrorUpload.Visible = True
                pnlMain.Visible = False
            End If
            Dim s = From c In d.Agape_Billboard_Comments Join b In d.Users On c.AuthorId Equals b.UserID Where 1 = 0 Select c.Abuse, c.AuthorId, c.BillboardCommentId, c.CommentDate, c.CommentText, c.CommentType, ThisName = (b.DisplayName)
            Try
                lblHeadline.Text = q.First.Headline
                Dim Author As String = ""
                If q.First.AuthorName = "" Or q.First.AuthorName Is Nothing Then
                    Author = (From c In d.Users Where c.UserID = CInt(q.First.Author) Select c.DisplayName).First
                Else
                    Author = q.First.AuthorName
                End If

                lblAuthor.Text = Author
                lblSub.Text = CDate(q.First.StoryDate).ToString("dd MMM yyyy")
                phBody.Controls.Add(New LiteralControl(q.First.StoryText))
                imgMain.ImageUrl = "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & q.First.BillboardPhotoId & "&Size=200"
                hfArtId.Value = q.First.BillbaordArticleId
                hfThisUser.Value = ThisUser
                hfThisMode.Value = Mode
                Dim r = From c In d.Agape_Billboard_Comments Join b In d.Users On c.AuthorId Equals b.UserID Where c.CommentType = 2 And c.ArticleId = ArticleId Select c.Abuse, c.AuthorId, c.BillboardCommentId, c.CommentDate, c.CommentText, c.CommentType, ThisName = (b.DisplayName)
                If r.Count > 0 Then
                    dlCommentList.DataSource = r
                    dlCommentList.DataBind()
                Else
                    dlCommentList.DataSource = s
                    dlCommentList.DataBind()
                End If
            Catch ex As Exception
                lblErrorUpload.Text = ex.Message
                lblErrorUpload.Visible = True
            End Try
        Else
            pnlMain.Visible = False
            lblErrorUpload.Text = "There was an error finding the article to view."
            lblErrorUpload.Visible = True
        End If
    End Sub
    Public Function IsDeleteable(ByVal ThisCommentId As Integer) As Boolean
        Dim Out As Boolean = False

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = ThisCommentId
        If q.Count > 0 Then
            If q.First.AuthorId = hfThisUser.Value Then
                Out = True
            End If
        End If

        Dim ObjUser As UserInfo = UserController.GetUserById(0, hfThisUser.Value)
        If ObjUser.IsInRole("BillboardEditor") Or ObjUser.IsSuperUser() Then
            Out = True
        End If

        Return Out
    End Function
    Public Function ThisIsEditable() As Boolean
        Dim Out As Boolean = False

        Dim ObjUser As UserInfo = UserController.GetUserById(0, hfThisUser.Value)
        If ObjUser.IsInRole("BillboardEditor") Or ObjUser.IsSuperUser() Then
            Out = True
        End If

        Return Out
    End Function
    Protected Sub AddCommentButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddCommentButton.Click
        If Not tbCommentText.Text = "" Then
            Dim d As New Billboard.BillboardDataContext
            Dim insertComment As New Billboard.Agape_Billboard_Comment
            insertComment.Abuse = False
            insertComment.AuthorId = hfThisUser.Value
            insertComment.CommentDate = CDate(Now())
            insertComment.CommentText = tbCommentText.Text
            insertComment.CommentType = 2
            insertComment.ArticleId = hfArtId.Value
            d.Agape_Billboard_Comments.InsertOnSubmit(insertComment)
            d.SubmitChanges()
            tbCommentText.Text = ""
            Initialise(hfArtId.Value, hfThisMode.Value, hfThisUser.Value)
        Else
            lblErrorUpload.Text = "You must insert some text to add a comment."
            lblErrorUpload.Visible = True
            Initialise(hfArtId.Value, hfThisMode.Value, hfThisUser.Value)
        End If
    End Sub
    Protected Sub dlCommentList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlCommentList.ItemCommand
        If e.CommandName = "Delete" Then
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument) Select c
            If q.Count = 1 Then
                d.Agape_Billboard_Comments.DeleteOnSubmit(q.First)
                d.SubmitChanges()
            End If
            Initialise(hfArtId.Value, hfThisMode.Value, hfThisUser.Value)
            'ElseIf e.CommandName = "Abuse" Then
            '    Dim d As New Billboard.BillboardDataContext
            '    Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument)
            '    If q.Count = 1 Then
            '        q.First.Abuse = True
            '        d.SubmitChanges()
            '        SendAbuseEmail(e.CommandArgument)
            '    End If
            '    Initialise(hfArtId.Value, hfThisMode.Value, hfThisUser.Value)
            'ElseIf e.CommandName = "RemoveAbuse" Then
            '    Dim d As New Billboard.BillboardDataContext
            '    Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument)
            '    If q.Count = 1 Then
            '        q.First.Abuse = False
            '        d.SubmitChanges()
            '    End If
            '    Initialise(hfArtId.Value, hfThisMode.Value, hfThisUser.Value)
        End If
    End Sub
    'Protected Sub SendAbuseEmail(ByVal CommentId As Integer)
    '    Dim d As New Billboard.BillboardDataContext
    '    Dim ArticleName As String
    '    Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = hfArtId.Value Select c.Headline
    '    If q.Count > 0 Then
    '        ArticleName = CStr(q.First)
    '    Else
    '        ArticleName = "There has been an error in the comment system."
    '    End If

    '    Dim AbuseComment As String
    '    Dim r = From c In d.Agape_Billboard_Comments Where c.ArticleId = hfArtId.Value And c.BillboardCommentId = CommentId Select c.CommentText
    '    If r.Count > 0 Then
    '        AbuseComment = CStr(r.First)
    '    Else
    '        AbuseComment = ""
    '    End If


    '    Dim EmailText As String = "<b>Abuse Report</b><br/><br/>"
    '    EmailText = EmailText & "Someone has reported the following comment in the <i>" & ArticleName & "</i> article as abusive:<br/><br/>"
    '    EmailText = EmailText & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>" & AbuseComment & "</i><br/><br/>"
    '    EmailText = EmailText & "The comment is currently invisible, please either reinstate the comment or delete it when you can.<br/><br/>"
    '    EmailText = EmailText & "<i>The Agap&eactue; Website</i>"

    '    Dim EmailAddress As String
    '    Dim s = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = hfArtId.Value Select c.Author
    '    If s.Count > 0 Then
    '        Dim t = From c In d.Users Where c.UserID = s.First Select c.Email, c.DisplayName
    '        If t.Count > 0 Then
    '            EmailAddress = t.First.Email
    '            DotNetNuke.Services.Mail.Mail.SendMail("donotreply@agape.org.uk", EmailAddress, "", "Agape Website Abusive Comment", EmailText, "", "HTML", "", "", "", "")
    '        End If
    '    End If

    '    Dim BillSuper = From c In d.Users Join b In d.UserRoles On c.UserID Equals b.UserID Join a In d.Roles On b.RoleID Equals a.RoleID Where a.RoleName = "BillboardEditor" Select c.DisplayName, c.Email
    '    For Each editor In BillSuper
    '        DotNetNuke.Services.Mail.Mail.SendMail("donotreply@agape.org.uk", editor.Email, "", "Agape Website Abusive Comment", EmailText, "", "HTML", "", "", "", "")
    '    Next

    'End Sub
    Public Delegate Sub MyEventHandler(ByVal sender As Object, ByVal e As ViewArtEventArgs)
    Public Event MyEvent As MyEventHandler
    Private Sub btnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        Try
            OnEvent(New ViewArtEventArgs(CInt(hfArtId.Value)))
        Catch ex As Exception
            lblErrorUpload.Text = ex.Message
            lblErrorUpload.Visible = True
        End Try
    End Sub
    Protected Overridable Sub OnEvent(ByVal e As ViewArtEventArgs)
        RaiseEvent MyEvent(Me, e)
    End Sub
End Class
Public Class ViewArtEventArgs
    Inherits EventArgs
    Private ReadOnly DoSomething As Integer
    Public Sub New(ByVal Switch As Integer)
        Me.DoSomething = Switch
    End Sub
    Public ReadOnly Property Switch() As Integer
        Get
            Return DoSomething
        End Get
    End Property
End Class
