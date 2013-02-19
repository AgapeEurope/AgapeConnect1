Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports UK.StaffLink

Namespace DotNetNuke.Modules.StaffLinks
    Partial Class StaffLinks
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            hfPortalId.Value = Me.PortalId
        End Sub
        Protected Sub btnUploadLink_Click(sender As Object, e As EventArgs) Handles btnUploadLink.Click
            lblError.Visible = False
            Dim d As New StaffLinkDataContext
            Dim thisURL As String = ""
            Dim onSite As Integer = -5
            If ddlSiteChoice.SelectedIndex = 0 Then
                thisURL = DotNetNuke.Common.Globals.NavigateURL(ddlSitePageList.SelectedValue)
                onSite = ddlSitePageList.SelectedValue
            ElseIf ddlSiteChoice.SelectedIndex = 1 Then
                thisURL = tbPageURL.Text
            End If
            Dim q = From c In d.Agape_Staff_Links Where c.LinkName = tbLinkName.Text Or c.LinkURL = thisURL
            If q.Count > 0 Then
                lblError.Text = "*You have already entered a link with the same name/URL please change this and try again."
                lblError.Visible = True
            Else
                Dim insert As New UK.StaffLink.Agape_Staff_Link
                insert.LinkName = tbLinkName.Text
                insert.LinkURL = thisURL
                Dim r = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Descending Select c.SortOrder
                If r.Count > 0 Then
                    insert.SortOrder = r.First + 1
                Else
                    insert.SortOrder = 1
                End If
                insert.NewWindow = cbNewWindow.Checked
                insert.TabId = onSite
                d.Agape_Staff_Links.InsertOnSubmit(insert)
                d.SubmitChanges()
                gvLinks.DataBind()
            End If
        End Sub
        Public Sub gvLinks_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvLinks.RowCommand

        End Sub
        Public Function IsItSite(ByVal linkId As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = linkId
            If q.Count > 0 Then
                If q.First.TabId > 0 Then
                    out = "On Site: "
                Else
                    out = "Off Site: "
                End If
            End If

            Return out
        End Function
        Public Function outputURL(ByVal linkId As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = linkId
            If q.Count > 0 Then
                If q.First.TabId > 0 Then
                    Dim r = From c In d.Tabs Where c.TabID = q.First.TabId
                    If r.Count > 0 Then
                        out = r.First.TabName
                    End If
                Else
                    out = q.First.LinkURL
                End If
            End If

            Return out
        End Function
    End Class
End Namespace

