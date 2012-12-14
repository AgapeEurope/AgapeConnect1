Imports System.Linq
Imports DotNetNuke.Modules.ViewArticle.ArtArchEventArgs
Imports Billboard

Namespace DotNetNuke.Modules.BillboardArt
    Partial Class ViewBillboardArt
        Inherits Entities.Modules.PortalModuleBase
        Dim gridTest As Integer = 1
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not (Request.QueryString("ArtId") Is Nothing) Then
                Response.Redirect(EditUrl("EditArt") & "?ArtId=" & Request.QueryString("ArtId") & "&Mode=" & Request.QueryString("Mode"))
            End If
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillArtTabId

            If q.Count > 0 Then
                If Not (q.First Is Nothing) Then
                    viewArt.Initialise(NavigateURL(CInt(q.First)))
                    'viewArt.Initialise(EditUrl("ViewArt"))
                End If
            End If

            'If UserInfo.IsInRole("BillboardEditor") Or UserInfo.IsSuperUser Then
            '    artArch1.Initialise(1, -3, EditUrl("EditArt"), EditUrl("ViewArt"))
            'Else
            '    artArch1.Initialise(1, Me.UserId, EditUrl("EditArt"), EditUrl("ViewArt"))
            'End If
            dlMain.DataSource = GetData()
            dlMain.DataBind()
        End Sub
        Public Function GetData() As Object

            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Articles Where 1 = 0 Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName

            If CInt(Me.UserId) > -1 And Not (UserInfo.IsInRole("BillboardEditor")) Then
                q = From c In d.Agape_Billboard_Articles Where c.Current = False And c.Sent = True And c.Visible = True Or c.Author = CInt(Me.UserId) Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
                Dim r = From c In q Where c.Visible = False
                If r.Count > 0 Then
                    pnlSmallKey.Visible = True
                End If
            Else
                q = From c In d.Agape_Billboard_Articles Where 1 = 1 Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
                Dim r = From c In q Where c.Visible = False
                If r.Count > 0 Then
                    pnlSmallKey.Visible = True
                End If
            End If

            If q.Count = 0 Then
                lblEmpty.Visible = True
            End If
            Return q
        End Function
        Public Function IsVisible(Optional ByVal ThisArtId As Integer = -1) As Boolean
            Dim Out As Boolean = False

            If UserInfo.IsInRole("BillboardEditor") Or Me.UserId = -1 Then
                Out = True
            Else
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = ThisArtId And c.Author = CInt(Me.UserId)
                If q.Count > 0 Then
                    Out = True
                End If
            End If
            Return Out
        End Function
        Public Function ColourMeGray(ByVal ThisVisible As Boolean, ByVal ThisSent As Boolean) As String
            Dim Out As String = ""

            If ThisVisible Then
                Out = "BackClear"
            Else
                Out = "BackYellow"
            End If

            Return Out
        End Function
        Public Function UnderLabelText(ByVal ThisArtId As Integer) As String
            Dim Out As String = ""

            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = ThisArtId Select c

            If q.Count > 0 Then
                If q.First.AuthorName = "" Or q.First.AuthorName Is Nothing Then
                    Dim r = From c In d.Users Where c.UserID = q.First.Author
                    If r.Count > 0 Then
                        Out = r.First.DisplayName & ", " & CDate(q.First.StoryDate).ToString("dd/MMM/yyyy")
                    Else
                        Out = CDate(q.First.StoryDate).ToString("dd/MMM/yyyy")
                    End If
                Else
                    Out = q.First.AuthorName & ", " & CDate(q.First.StoryDate).ToString("dd/MMM/yyyy")
                End If
            End If


            Return Out
        End Function
        Public Function CleanText(ByVal ThisText As String) As String
            Dim Out = ""

            Out = Billboard.BillboardFunctions.StripBillTags(ThisText)
            Out = Out.Substring(0, Math.Min(200, Out.Length)) & "..."

            Return Out
        End Function
        Protected Sub dlMain_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlMain.ItemCommand
            If e.CommandName = "MyEdit" Then
                Response.Redirect(EditUrl("EditArt") & "?ArtId=" & (CInt(e.CommandArgument)) & "&Mode=1")
            ElseIf e.CommandName = "GoTo" Then
                Try
                    Dim Mode As Integer = 1
                    Dim Owner As Boolean = False
                    Dim d As New Billboard.BillboardDataContext
                    Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = CInt(e.CommandArgument)
                    If q.Count > 0 Then
                        If q.First.Author = Me.UserId Then
                            Owner = True
                        End If
                    End If
                    If UserInfo.IsInRole("BillboardEditor") Or Me.UserId = -1 Or Owner Then
                        Mode = 2
                    End If

                    Dim r = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillArtTabId

                    If r.Count > 0 Then
                        If Not (r.First Is Nothing) Then
                            Response.Redirect(NavigateURL(CInt(r.First)) & "?ArtId=" & e.CommandArgument & "&Mode=" & Mode)
                        End If
                    End If
                    'Response.Redirect(EditUrl("ViewArt") & "?ArtId=" & e.CommandArgument & "&Mode=" & Mode)
                Catch ex As Exception
                    lblTest.Text = ex.Message
                    lblTest.Visible = True
                End Try
            End If
        End Sub
        Protected Sub btnNewArt_Click(sender As Object, e As System.EventArgs) Handles btnNewArt.Click
            Response.Redirect(EditUrl("EditArt") & "?ArtId=-1" & "&Mode=2")
        End Sub

        Protected Sub dlMain_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlMain.ItemDataBound
            e.Item.ID = "rowTest" & gridTest
            gridTest += 1
        End Sub
    End Class
End Namespace