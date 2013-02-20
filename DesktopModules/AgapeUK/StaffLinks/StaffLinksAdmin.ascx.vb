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
            If Not Page.IsPostBack Then
                hfPortalId.Value = Me.PortalId
                redoSort()
            End If
        End Sub
        Protected Sub btnUploadLink_Click(sender As Object, e As EventArgs) Handles btnUploadLink.Click
            lblError.Visible = False
            Dim d As New StaffLinkDataContext
            Dim thisURL As String = ""
            Dim onSite As Integer = -5
            If ddlSiteChoice.SelectedIndex = 0 Then
                thisURL = NavigateURL(CInt(ddlSitePageList.SelectedValue))
                onSite = ddlSitePageList.SelectedValue
            ElseIf ddlSiteChoice.SelectedIndex = 1 Then
                thisURL = tbPageURL.Text
            End If
            Dim q = From c In d.Agape_Staff_Links Where c.LinkName = tbLinkName.Text Or c.LinkURL = thisURL
            If q.Count > 0 Then
                lblError.Text = "*You have already entered a link with the same name/URL please change this and try again."
                lblError.Visible = True
                CleanUp()
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
                CleanUp()
            End If
        End Sub
#Region "Sub Functions"
        Private Sub CleanUp()
            tbLinkName.Text = ""
            ddlSiteChoice.SelectedIndex = 0
            cbNewWindow.Checked = False
        End Sub
        Private Sub redoSort()
            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Ascending
            Dim counter As Integer = 1
            For Each link In q
                link.SortOrder = counter
                d.SubmitChanges()
                counter += 1
            Next
            gvLinks.DataBind()
        End Sub
#End Region
#Region "Grid View Stuff"
        Public Sub gvLinks_RowCommand(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvLinks.RowCommand
            Dim d As New StaffLinkDataContext
            If e.CommandName = "MyDelete" Then
                Try
                    Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = CInt(e.CommandArgument)
                    If q.Count = 1 Then
                        d.Agape_Staff_Links.DeleteOnSubmit(q.First)
                        d.SubmitChanges()
                        gvLinks.DataBind()
                    End If
                    redoSort()
                Catch ex As Exception

                End Try
            ElseIf e.CommandName = "MyUpdate" Then
                lblGVError.Visible = False
                Try
                    Dim thisRow As System.Web.UI.WebControls.GridViewRow = gvLinks.Rows(CInt(e.CommandArgument))
                    Dim thisLink = CType(thisRow.FindControl("hfLinkId"), HiddenField).Value
                    Dim w = From c In d.Agape_Staff_Links Where c.StaffLinkId = CInt(thisLink)
                    If w.Count = 1 Then
                        Dim linkName As String = CType(thisRow.FindControl("tbLinkName"), TextBox).Text
                        Dim linkURL As String = ""
                        Dim onSite As Integer = -5
                        Dim newWindow As Boolean = False
                        Dim cb As New CheckBox
                        cb = CType(thisRow.FindControl("cbNewWindow"), CheckBox)
                        newWindow = cb.Checked
                        Dim siteChoice As DropDownList = CType(thisRow.FindControl("gvDdlChoice"), DropDownList)
                        If siteChoice.SelectedValue = 0 Then
                            Dim pageChoice As DropDownList = CType(thisRow.FindControl("gvDdlOnSite"), DropDownList)
                            linkURL = NavigateURL(CInt(pageChoice.SelectedValue))
                            onSite = pageChoice.SelectedValue
                        ElseIf siteChoice.SelectedValue = 1 Then
                            linkURL = CType(thisRow.FindControl("gvTbOffSite"), TextBox).Text
                        End If
                        Dim tester = From c In d.Agape_Staff_Links Where (c.LinkURL = linkURL Or c.LinkName = linkName) And c.StaffLinkId <> w.First.StaffLinkId
                        If tester.Count = 0 And linkName <> "" And linkURL <> "" Then
                            w.First.LinkName = linkName
                            w.First.LinkURL = linkURL
                            w.First.NewWindow = newWindow
                            w.First.TabId = onSite
                            d.SubmitChanges()
                            gvLinks.EditIndex = -1
                            gvLinks.DataBind()
                        ElseIf tester.Count > 0 Then
                            lblGVError.Text = "You cannot have a link with the same name or URL as another link."
                            lblGVError.Visible = True
                        ElseIf linkName = "" Then
                            lblGVError.Text = "You must have a name entered for the link."
                            lblGVError.Visible = True
                        ElseIf linkURL = "" Then
                            lblGVError.Text = "You must have a valid URL for the link."
                            lblGVError.Visible = True
                        End If
                    Else
                        lblGVError.Text = "There was an error retrieving this link from the database."
                        lblGVError.Visible = True
                    End If
                Catch ex As Exception
                    lblGVError.Text = ex.Message
                    lblGVError.Visible = True
                End Try
            ElseIf e.CommandName = "Promote" Then
                Try
                    redoSort()
                    Dim r = From c In d.Agape_Staff_Links Where c.StaffLinkId = CInt(e.CommandArgument)
                    If r.Count = 1 Then
                        If r.First.SortOrder > 1 Then
                            Dim oldNum = r.First.SortOrder
                            Dim s = From c In d.Agape_Staff_Links Where c.SortOrder = (oldNum - 1)
                            If s.Count = 1 Then
                                s.First.SortOrder = oldNum
                                r.First.SortOrder = oldNum - 1
                                d.SubmitChanges()
                                gvLinks.DataBind()
                            End If
                        End If
                    End If
                Catch ex As Exception

                End Try
            ElseIf e.CommandName = "Demote" Then
                Try
                    redoSort()
                    Dim t = From c In d.Agape_Staff_Links Where c.StaffLinkId = CInt(e.CommandArgument)
                    Dim u = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Descending Select c.SortOrder
                    If t.Count = 1 Then
                        If t.First.SortOrder < u.First Then
                            Dim oldNum = t.First.SortOrder
                            Dim v = From c In d.Agape_Staff_Links Where c.SortOrder = (oldNum + 1)
                            If v.Count = 1 Then
                                v.First.SortOrder = oldNum
                                t.First.SortOrder = oldNum + 1
                                d.SubmitChanges()
                                gvLinks.DataBind()
                            End If
                        End If
                    End If
                Catch ex As Exception

                End Try
            End If
        End Sub
#End Region
#Region "Functions"
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
        Public Function isOnSite(ByVal linkId As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = linkId
            If q.Count > 0 Then
                If Not (q.First.TabId > 0) Then
                    out = "display:none;"
                Else
                    out = "display:inline; width:200px !important;"
                End If
            End If

            Return out
        End Function
        Public Function isOffSite(ByVal linkId As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = linkId
            If q.Count > 0 Then
                If Not (q.First.TabId > 0) Then
                    out = "display:inline; width:200px !important;"
                Else
                    out = "display:none;"
                End If
            End If

            Return out
        End Function
        Public Function gvSiteChoice(ByVal linkId As Integer) As Integer
            Dim out As Integer = 0

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where c.StaffLinkId = linkId
            If q.Count > 0 Then
                If Not (q.First.TabId > 0) Then
                    out = 1
                Else
                    out = 0
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
        Public Function upOrGrey(ByVal thisSort As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Ascending
            If q.Count > 1 Then
                If thisSort = q.First.SortOrder Then
                    out = "~/images/upGREY.gif"
                Else
                    out = "~/images/up.gif"
                End If
            Else
                out = "~/images/upGREY.gif"
            End If

            Return out
        End Function
        Public Function dnOrGrey(ByVal thisSort As Integer) As String
            Dim out As String = ""

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Descending
            If q.Count > 1 Then
                If thisSort = q.First.SortOrder Then
                    out = "~/images/dnGREY.gif"
                Else
                    out = "~/images/dn.gif"
                End If
            Else
                out = "~/images/dnGREY.gif"
            End If

            Return out
        End Function
        Public Function upEnabled(ByVal thisSort As Integer) As Boolean
            Dim out As Boolean = True

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Ascending
            If q.Count > 1 Then
                If thisSort = q.First.SortOrder Then
                    out = False
                Else
                    out = True
                End If
            Else
                out = False
            End If

            Return out
        End Function
        Public Function dnEnabled(ByVal thisSort As Integer) As Boolean
            Dim out As Boolean = True

            Dim d As New StaffLinkDataContext
            Dim q = From c In d.Agape_Staff_Links Where 1 = 1 Order By c.SortOrder Descending
            If q.Count > 1 Then
                If thisSort = q.First.SortOrder Then
                    out = False
                Else
                    out = True
                End If
            Else
                out = False
            End If

            Return out
        End Function
#End Region

        Protected Sub gvLinks_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvLinks.RowCancelingEdit
            lblGVError.Visible = False
        End Sub
    End Class
End Namespace

