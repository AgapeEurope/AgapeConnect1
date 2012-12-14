Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports DotNetNuke.Modules.BillboardLink.EditLinkArgs
Imports Billboard


Namespace DotNetNuke.Modules.BillboardLink
    Partial Class ViewBillboardLink
        Inherits Entities.Modules.PortalModuleBase
        Dim d As New Billboard.BillboardDataContext
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'editLink.Initialise(Me.UserId, 1)
            If Not Page.IsPostBack Then
                SetDatasource()
                GridView1.DataBind()
            End If
            CreateLinks()
            FillArchive()
        End Sub
        Public Sub LoadPopup()
            Dim t As Type = btnEdit.GetType()
            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
            sb.Append("<script language='javascript'>")
            sb.Append("showEditLink();")
            sb.Append("</script>")
            ScriptManager.RegisterStartupScript(btnEdit, t, "popupAdd1", sb.ToString, False)
        End Sub
        Public Sub CreateLinks()
            'Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Links Where c.Visible = True Order By c.LinkDate Descending Take 5
            If q.Count > 0 Then
                Dim phOut As String = ""
                For Each link In q
                    phOut = phOut & "<div class=""Bill_Text_Side""><a style="" font-weight:bold;"" href=""" & link.LinkURL & """ Title=""" & link.LinkDesc & """ Target=""_blank"">" & link.LinkTitle & "</a></div>"
                    phOut = phOut & "<div class=""Bill_Text_Side"" style=""font-weight:normal; font-size:7pt; text-align:justify !important;"">" & link.LinkDesc & "</div><br/>"
                Next
                phMainContent.Controls.Add(New LiteralControl(phOut))
            Else
                lblOutput.Text = "There are currently no visible links"
                lblOutput.Visible = True
            End If
        End Sub
        'Protected Sub editLink_MyEvent(ByVal sender As Object, ByVal e As EditLinkArgs) Handles editLink.MyEvent
        Public Sub TheEvent()

            phMainContent.Controls.Clear()
            phAllLinks.Controls.Clear()
            CreateLinks()
            FillArchive()

        End Sub
        Public Sub FillArchive()
            'Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Links Where c.Visible = True Order By c.LinkDate Descending
            If q.Count > 0 Then

                Dim phOut As String = ""
                For Each link In q
                    phOut = phOut & "<div class=""Bill_Text_Main""><a style=""font-size:10pt; font-weight:bold;"" href=""" & link.LinkURL & """ Title=""" & link.LinkDesc & """ Target=""_blank"">" & link.LinkTitle & "</a></div>"
                    phOut = phOut & "<div class=""Bill_Text_Main"" style=""font-weight:normal; font-size:7pt;"">" & link.LinkDesc & "</div><br/>"
                Next
                phAllLinks.Controls.Add(New LiteralControl(phOut))
            Else
                lblAllLinksOut.Text = "There are currently no visible links"
                lblAllLinksOut.Visible = True
            End If

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
                        Dim t As Type = GridView1.GetType()
                        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                        sb.Append("<script language='javascript'>")
                        sb.Append("$('.theTicks').hide(); $('#" & IMG.ClientID & "').show();  setTimeout(function () { $('#" & IMG.ClientID & "').fadeOut(350); }, 5000);")
                        sb.Append("</script>")
                        ScriptManager.RegisterStartupScript(GridView1, t, "popupAdd1", sb.ToString, False)
                        'IMG.Visible = True
                        TheEvent()
                        'OnEvent(New EditLinkArgs(-3))


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
                        TheEvent()
                        'OnEvent(New EditLinkArgs(-3))
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
            Dim q = From c In d.Agape_Billboard_Links Where c.Author = Me.UserId Order By c.LinkDate Descending Select c

            If q.Count > 0 Then
                GridView1.DataSource = q
            Else
                lblGVError.Text = "You haven't uploaded any links so you can't edit them."
                lblGVError.Visible = True
                GridView1.Visible = False
            End If


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
            ElseIf r.Count > 0 Then
                lblErrorMsg.Text = "Your link must have a different URL and title from all the other links."
                lblErrorMsg.Visible = True
            Else
                lblErrorMsg.Visible = False
                Try
                    Dim insert As New Billboard.Agape_Billboard_Link
                    insert.Author = CInt(Me.UserId)
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

                    ClearFields()
                    SetDatasource()
                    GridView1.DataBind()

                    TheEvent()
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

    End Class
End Namespace
