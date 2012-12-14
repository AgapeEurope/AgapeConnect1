Imports System.Linq
Imports Billboard

Partial Class DesktopModules_Billboard_controls_EditLink

    Inherits System.Web.UI.UserControl
    Dim d As New Billboard.BillboardDataContext
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SetDatasource()
            GridView1.DataBind()
        End If

    End Sub
    Public Sub Initialise(ByVal ThisUserId As Integer, ByVal Mode As Integer)
        hfThisUser.Value = ThisUserId

        hfMode.Value = 1

        GridView1.DataSource = From c In d.Agape_Billboard_Links Where c.Author = hfThisUser.Value Order By c.LinkDate Descending Select c

        GridView1.DataBind()

    End Sub
    Protected Sub btnAddLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddLink.Click
        Dim r = From c In d.Agape_Billboard_Links Where c.LinkURL = tbLinkURL.Text Or c.LinkTitle = tbLinkTitle.Text And c.Visible = True
        If (tbLinkDesc.Text = "" Or tbLinkDesc.Text = Nothing Or tbLinkTitle.Text = "" Or tbLinkTitle.Text = Nothing Or tbLinkURL.Text = "" Or tbLinkURL.Text = Nothing) Then
            lblErrorMsg.Text = "You must have something entered in all of the boxes."
            lblErrorMsg.Visible = True
        ElseIf tbLinkDesc.Text.Length > 150 Then
            lblErrorMsg.Text = "The link Description can't be more than 150 characters long."
            lblErrorMsg.Visible = True
        ElseIf tbLinkURL.Text.Length > 500 Then
            lblErrorMsg.Text = "The link URL can't be more than 500 characters long."
            lblErrorMsg.Visible = True
        ElseIf tbLinkTitle.Text.Length > 100 Then
            lblErrorMsg.Text = "The link Title can't be more than 100 characters long."
            lblErrorMsg.Visible = True
        ElseIf hfThisUser.Value = "" Or hfThisUser.Value = Nothing Then
            lblErrorMsg.Text = "There was an error in loading the module, please contact the system administrator."
            lblErrorMsg.Visible = True
        ElseIf r.Count > 0 Then
            lblErrorMsg.Text = "Your link must have a different URL and title from all the other links."
            lblErrorMsg.Visible = True
        Else
            lblErrorMsg.Visible = False
            Try
                Dim insert As New Billboard.Agape_Billboard_Link
                insert.Author = CInt(hfThisUser.Value)
                insert.Visible = cbVisible.Checked
                If cbVisible.Checked Then
                    insert.Current = True
                    insert.ViewOrder = 1
                Else
                    insert.Current = True
                    insert.ViewOrder = -1
                End If
                insert.Sent = False
                insert.LinkDate = CDate(Now())
                insert.LinkDesc = tbLinkDesc.Text
                insert.LinkTitle = tbLinkTitle.Text
                insert.LinkURL = tbLinkURL.Text
                d.Agape_Billboard_Links.InsertOnSubmit(insert)
                d.SubmitChanges()
                ReOrderLinks()
                ClearFields()
                SetDatasource()
                GridView1.DataBind()
                OnEvent(New EditLinkArgs(-3))
                lblErrorMsg.ForeColor = Color.Green
                lblErrorMsg.Text = "Link Added"
                lblErrorMsg.Visible = True

            Catch ex As Exception
                lblErrorMsg.Font.Bold = False
                lblErrorMsg.ForeColor = Color.Red
                lblErrorMsg.Text = ex.Message
                lblErrorMsg.Visible = True
            End Try
        End If
    End Sub
    Private Sub ClearFields()
        lblErrorMsg.Text = ""
        lblErrorMsg.Visible = False
        tbLinkDesc.Text = ""
        tbLinkTitle.Text = ""
        tbLinkURL.Text = "http://"
        cbVisible.Checked = False
    End Sub
    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearFields()
        SetDatasource()
        GridView1.DataBind()
    End Sub
    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "MyEdit" Then
            Try
                Dim HF As HiddenField
                HF = GridView1.Rows(e.CommandArgument).FindControl("hfLinkId")
                Dim q = From c In d.Agape_Billboard_Links Where c.BillboardLinkId = CInt(HF.Value)
                If q.Count = 1 Then
                    Dim TB As TextBox
                    Dim CB As CheckBox
                    TB = GridView1.Rows(e.CommandArgument).FindControl("tbTitle1")
                    q.First.LinkTitle = TB.Text
                    TB = GridView1.Rows(e.CommandArgument).FindControl("tbDesc1")
                    q.First.LinkDesc = TB.Text
                    TB = GridView1.Rows(e.CommandArgument).FindControl("tbURL1")
                    q.First.LinkURL = TB.Text
                    CB = GridView1.Rows(e.CommandArgument).FindControl("cbVis1")
                    q.First.Visible = CB.Checked
                    d.SubmitChanges()
                    SetDatasource()
                    GridView1.DataBind()
                    Dim IMG As System.Web.UI.WebControls.Image
                    IMG = GridView1.Rows(e.CommandArgument).FindControl("imgTick")
                    IMG.Visible = True

                    OnEvent(New EditLinkArgs(-3))


                Else
                    lblGVError.Text = "More than one problem."
                    lblGVError.Visible = True
                End If
            Catch ex As Exception
                lblGVError.Text = ex.Message
                lblGVError.Visible = True
            End Try
        ElseIf e.CommandName = "MyDelete" Then
            Try
                Dim r = From c In d.Agape_Billboard_Links Where c.BillboardLinkId = CInt(e.CommandArgument)
                If r.Count = 1 Then
                    d.Agape_Billboard_Links.DeleteOnSubmit(r.First)
                    d.SubmitChanges()
                    SetDatasource()
                    GridView1.DataBind()
                    OnEvent(New EditLinkArgs(-3))
                Else
                    lblGVError.Text = "More than one problem."
                    lblGVError.Visible = True
                End If
            Catch ex As Exception
                lblGVError.Text = ex.Message
                lblGVError.Visible = True
            End Try
        End If
    End Sub
    Public Sub SetDatasource()

        GridView1.DataSource = From c In d.Agape_Billboard_Links Where c.Author = hfThisUser.Value Order By c.LinkDate Descending Select c

    End Sub
    Public Sub ReOrderLinks()
        Dim r = From c In d.Agape_Billboard_Links Where c.ViewOrder > -1 Order By c.ViewOrder Ascending, c.LinkDate Descending
        If r.Count > 0 Then
            Dim Counter As Integer = 1
            For Each Link In r
                Link.ViewOrder = Counter
                Counter = Counter + 1
            Next
            d.SubmitChanges()
        End If
    End Sub
    Public Delegate Sub MyEventHandler(ByVal sender As Object, ByVal e As EditLinkArgs)
    Public Event MyEvent As MyEventHandler
    Protected Overridable Sub OnEvent(ByVal e As EditLinkArgs)
        RaiseEvent MyEvent(Me, e)
    End Sub


End Class
Public Class EditLinkArgs
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
