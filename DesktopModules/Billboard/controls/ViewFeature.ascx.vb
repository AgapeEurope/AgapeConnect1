Imports Billboard
Imports System.Linq
Imports System.Web.UI
Imports DotNetNuke

Partial Class DesktopModules_Billboard_controls_ViewFeature
    Inherits System.Web.UI.UserControl

    Public Sub Initialise(ByVal FeatureId As Integer, ByVal Mode As Integer, ByVal ThisUser As Integer)
        If Mode = 2 Then
            btnEdit.Visible = True
        Else
            btnEdit.Visible = False
        End If
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = FeatureId Select c
        If q.Count > 0 Then
            pnlMain.Visible = True
            lblErrorUpload.Visible = False
            If q.First.Visible = False And Mode = 1 Then
                lblErrorUpload.Text = "You cannot view this article."
                lblErrorUpload.Visible = True
                pnlMain.Visible = False
            ElseIf q.First.Visible = False And Mode = 2 Then
                lblErrorUpload.Text = "This article is currently invisible."
                lblErrorUpload.Visible = True
                pnlMain.Visible = True
            End If
            Dim s = From c In d.Agape_Billboard_Comments Join b In d.Users On c.AuthorId Equals b.UserID Where 1 = 0 Select c.Abuse, c.AuthorId, c.BillboardCommentId, c.CommentDate, c.CommentText, c.CommentType, ThisName = (b.DisplayName)
            Try
                lblFeatType.Text = (From c In d.Agape_Billboard_Feature_Types Where c.TypeNumber = q.First.FeatType Select c.TypeName).First
                lblHeadline.Text = q.First.Headline
                lblSub.Text = CDate(q.First.StoryDate).ToString("dd MMM yyyy")
                phBody.Controls.Add(New LiteralControl(q.First.StoryText))
                imgMain.ImageUrl = "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & q.First.BillboardPhotoId & "&Size=200"
                hfFeatureId.Value = q.First.BillboardFeatureId
                hfMode.Value = Mode
                hfThisUser.Value = ThisUser
                Dim r = From c In d.Agape_Billboard_Comments Join b In d.Users On c.AuthorId Equals b.UserID Where c.CommentType = 1 And c.ArticleId = FeatureId Select c.Abuse, c.AuthorId, c.BillboardCommentId, c.CommentDate, c.CommentText, c.CommentType, ThisName = (b.DisplayName)
                If r.Count > 0 Then
                    dlCommentList1.DataSource = r
                    dlCommentList1.DataBind()
                Else
                    dlCommentList1.DataSource = s
                    dlCommentList1.DataBind()
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
            insertComment.CommentType = 1
            insertComment.ArticleId = hfFeatureId.Value
            d.Agape_Billboard_Comments.InsertOnSubmit(insertComment)
            d.SubmitChanges()
            tbCommentText.Text = ""
            Initialise(hfFeatureId.Value, hfMode.Value, hfThisUser.Value)
        Else
            lblErrorUpload.Text = "You must insert some text to add a comment."
            lblErrorUpload.Visible = True
            Initialise(hfFeatureId.Value, hfMode.Value, hfThisUser.Value)
        End If
    End Sub
    Protected Sub dlCommentList1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlCommentList1.ItemCommand
        If e.CommandName = "Delete" Then
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument) Select c
            If q.Count = 1 Then
                d.Agape_Billboard_Comments.DeleteOnSubmit(q.First)
                d.SubmitChanges()
            End If
            Initialise(hfFeatureId.Value, hfMode.Value, hfThisUser.Value)
            'ElseIf e.CommandName = "Abuse" Then
            '    Dim d As New Billboard.BillboardDataContext
            '    Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument)
            '    If q.Count = 1 Then
            '        q.First.Abuse = True
            '        d.SubmitChanges()
            '        SendAbuseEmail(e.CommandArgument)
            '    End If
            '    Initialise(hfFeatureId.Value, hfMode.Value, hfThisUser.Value)
            'ElseIf e.CommandName = "RemoveAbuse" Then
            '    Dim d As New Billboard.BillboardDataContext
            '    Dim q = From c In d.Agape_Billboard_Comments Where c.BillboardCommentId = CInt(e.CommandArgument)
            '    If q.Count = 1 Then
            '        q.First.Abuse = False
            '        d.SubmitChanges()
            '    End If
            '    Initialise(hfFeatureId.Value, hfMode.Value, hfThisUser.Value)
        End If
    End Sub
    'Protected Sub SendAbuseEmail(ByVal CommentId As Integer)
    '    Dim d As New Billboard.BillboardDataContext
    '    Dim ArticleName As String
    '    Dim q = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = hfFeatureId.Value Select c.Headline
    '    If q.Count > 0 Then
    '        ArticleName = CStr(q.First)
    '    Else
    '        ArticleName = "There has been an error in the comment system."
    '    End If

    '    Dim AbuseComment As String
    '    Dim r = From c In d.Agape_Billboard_Comments Where c.ArticleId = hfFeatureId.Value And c.BillboardCommentId = CommentId Select c.CommentText
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
    '    Dim BillSuper = From c In d.Users Join b In d.UserRoles On c.UserID Equals b.UserID Join a In d.Roles On b.RoleID Equals a.RoleID Where a.RoleName = "BillboardEditor" Select c.DisplayName, c.Email
    '    For Each editor In BillSuper
    '        DotNetNuke.Services.Mail.Mail.SendMail("donotreply@agape.org.uk", editor.Email, "", "Agape Website Abusive Comment", EmailText, "", "HTML", "", "", "", "")
    '    Next

    'End Sub
    Public Delegate Sub MyEventHandler(ByVal sender As Object, ByVal e As ViewEventArgs)
    Public Event MyEvent As MyEventHandler

    Private Sub btnEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        Try
            OnEvent(New ViewEventArgs(CInt(hfFeatureId.Value)))
        Catch ex As Exception
            lblErrorUpload.Text = ex.Message
            lblErrorUpload.Visible = True
        End Try
    End Sub
    Protected Overridable Sub OnEvent(ByVal e As ViewEventArgs)
        RaiseEvent MyEvent(Me, e)
    End Sub


End Class
Public Class ViewEventArgs
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



