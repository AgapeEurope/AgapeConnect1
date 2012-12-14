Imports System.Linq
Imports Billboard
Imports System.Web.UI
Imports DotNetNuke

Partial Class DesktopModules_Billboard_controls_ArtArchive
    Inherits System.Web.UI.UserControl
    Dim ThisMode As Integer = 1
    Dim ThisUser As Integer = -1
    Dim ThisEdit As String = ""
    Dim ThisView As String = ""
    Public Sub Initialise(ByVal Mode As Integer, Optional ByVal ThisUserId As Integer = -1, Optional ByVal thisEditURL As String = "", Optional ByVal thisViewURL As String = "")
        ThisMode = Mode
        hfMode.Value = Mode
        ThisUser = ThisUserId
        hfUserId.Value = ThisUserId
        ThisEdit = thisEditURL
        hfEdit.Value = thisEditURL
        ThisView = thisViewURL
        hfView.Value = thisViewURL
        If Mode = 1 Then
            pnlKey.Visible = False
        Else
            pnlKey.Visible = True
        End If
        dlMain.DataSource = GetData()
        dlMain.DataBind()
    End Sub
    Public Function GetData() As Object

        If hfMode.Value = "" Or hfMode.Value Is Nothing Then
            ThisMode = 1
        Else
            ThisMode = hfMode.Value
        End If

        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Articles Where 1 = 0 Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
        If ThisMode = 1 Then
            If CInt(hfUserId.Value) > -1 Then
                q = From c In d.Agape_Billboard_Articles Where c.Current = False And c.Sent = True And c.Visible = True Or c.Author = CInt(hfUserId.Value) Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
                Dim r = From c In q Where c.Visible = False
                If r.Count > 0 Then
                    pnlSmallKey.Visible = True
                End If
            ElseIf CInt(hfUserId.Value = -3) Then
                q = From c In d.Agape_Billboard_Articles Where 1 = 1 Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
                Dim r = From c In q Where c.Visible = False
                If r.Count > 0 Then
                    pnlSmallKey.Visible = True
                End If
            End If
        ElseIf ThisMode = 2 Then
            q = From c In d.Agape_Billboard_Articles Where 1 = 1 Select c.Headline, c.Visible, c.StoryDate, c.BillboardPhotoId, c.BillbaordArticleId, c.Sent, c.Author, c.StoryText, c.AuthorName
            pnlKey.Visible = True
        End If
        If q.Count = 0 Then
            lblEmpty.Visible = True
        End If
        Return q
    End Function
    Public Function IsVisible(Optional ByVal ThisArtId As Integer = -1) As Boolean
        Dim Out As Boolean = False

        If hfMode.Value = "" Or hfMode.Value Is Nothing Then
            ThisMode = 1
        Else
            ThisMode = hfMode.Value
        End If

        If hfMode.Value = 2 Or hfUserId.Value = -3 Then
            Out = True
        ElseIf hfMode.Value = 1 Then
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Articles Where c.BillbaordArticleId = ThisArtId And c.Author = CInt(hfUserId.Value)
            If q.Count > 0 Then
                Out = True
            End If
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
    Public Function ColourMeGray(ByVal ThisVisible As Boolean, ByVal ThisSent As Boolean) As String
        Dim Out As String = ""

        If ThisMode = 1 Then
            If ThisVisible Then
                Out = "BackClear"
            Else
                Out = "BackYellow"
            End If
        Else
            If ThisVisible And Not ThisSent Then
                Out = "BackClear"
            ElseIf Not ThisVisible And Not ThisSent Then
                Out = "BackBlue"
            ElseIf ThisVisible And ThisSent Then
                Out = "BackYellow"
            ElseIf Not ThisVisible And ThisSent Then
                Out = "BackGreen"
            End If
        End If



        Return Out
    End Function
    Public Function CleanText(ByVal ThisText As String) As String
        Dim Out = ""

        Out = Billboard.BillboardFunctions.StripBillTags(ThisText)
        Out = Out.Substring(0, Math.Min(500, Out.Length)) & "..."

        Return Out
    End Function

    Public Delegate Sub MyEventHandler(ByVal sender As Object, ByVal e As ArtArchEventArgs)
    Public Event MyEvent As MyEventHandler
    Protected Overridable Sub OnEvent(ByVal e As ArtArchEventArgs)
        RaiseEvent MyEvent(Me, e)
    End Sub

    Protected Sub dlMain_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlMain.ItemCommand
        If e.CommandName = "MyEdit" Then
            Try
                OnEvent(New ArtArchEventArgs(CInt(e.CommandArgument) * -1, hfMode.Value))
            Catch ex As Exception
                lblControlError.Text = ex.Message
                lblControlError.Visible = True
            End Try

        ElseIf e.CommandName = "GoTo" Then
            Try
                OnEvent(New ArtArchEventArgs(CInt(e.CommandArgument), hfMode.Value))
            Catch ex As Exception
                lblControlError.Text = ex.Message
                lblControlError.Visible = True
            End Try

        End If
    End Sub
End Class
Public Class ArtArchEventArgs
    Inherits EventArgs
    Private ReadOnly DoSomething As Integer
    Private ReadOnly ThisMode As Integer
    Public Sub New(ByVal Switch As Integer, ByVal Mode As Integer)
        Me.DoSomething = Switch
        Me.ThisMode = Mode
    End Sub
    Public ReadOnly Property Switch() As Integer
        Get
            Return DoSomething
        End Get
    End Property
    Public ReadOnly Property Mode() As Integer
        Get
            Return ThisMode
        End Get
    End Property
End Class