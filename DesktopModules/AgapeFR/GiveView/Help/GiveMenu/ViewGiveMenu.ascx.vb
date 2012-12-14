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
Imports StaffBrokerFunctions
Imports StaffBroker

Namespace DotNetNuke.Modules.GiveMenu
    Partial Class ViewGiveMenu
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                Dim dStaff As New StaffBrokerDataContext
                Dim allStaff = From c In dStaff.AP_StaffBroker_Staffs Where c.PortalId = PortalId And Not (c.CostCenter Is Nothing Or c.CostCenter = "") Order By c.User.LastName
                staffListBox.DataSource = allStaff
                staffListBox.DataTextField = "DisplayName"
                staffListBox.DataValueField = "StaffId"
                staffListBox.DataBind()

                'populating department box
                Dim alldepartments = From c In dStaff.AP_StaffBroker_Departments Where c.CanGiveTo And c.PortalId = PortalId And Not (c.CostCentre Is Nothing Or c.CostCentre = "") Order By c.Name
                DepDDL.DataSource = alldepartments
                DepDDL.DataTextField = "Name"
                DepDDL.DataValueField = "CostCenterId"
                DepDDL.DataBind()
            End If
           
        End Sub


        'Protected Sub DepButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles DepButton.Click

        '    Dim d As New Resources.ResourcesDataContext
        '    Dim dBroke As New StaffBrokerDataContext
        '    Dim q = From c In dBroke.AP_StaffBroker_Departments Where c.CostCenterId = DepDDL.SelectedValue
        '    'Dim q = From c In d.Agape_Main_AvailableCostCentres Where c.AvailableCostCentreId = DepDDL.SelectedValue
        '    Dim b As New FullStory.FullStoryDataContext
        '    Dim GiveTabId = From c In b.Agape_Main_GlobalDatas Select c.GivingTabId

        '    If q.Count > 0 And GiveTabId.Count > 0 Then
        '        Response.Redirect(NavigateURL(CInt(GiveTabId.First)) & "?giveto=" & q.First.GivingShortcut)
        '    End If
        'End Sub
        'Protected Sub ProjectButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ProjectButton.Click
        '    Dim d As New AgapeStaff.AgapeStaffDataContext
        '    Dim q = From c In d.Agape_Main_Projects Where c.ProjectID = ProjectDDL.SelectedValue
        '    Dim b As New FullStory.FullStoryDataContext
        '    Dim GiveTabId = From c In b.Agape_Main_GlobalDatas Select c.GivingTabId

        '    If q.Count > 0 And GiveTabId.Count > 0 Then
        '        Response.Redirect(NavigateURL(CInt(GiveTabId.First)) & "?giveto=" & q.First.GivingShortcut)
        '    End If
        'End Sub

        'Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        '    'Preselect the right tab/giving target
        '    If Request.QueryString("aid") <> "" Then
        '        Accordion1.SelectedIndex = 2
        '        Try
        '            AppealDDL.SelectedValue = CInt(Request.QueryString("aid"))
        '        Catch ex As Exception

        '        End Try

        '    ElseIf TabId = 205 Then 'this is the give to ministry page
        '        Accordion1.SelectedIndex = 1
        '    End If

        'End Sub

        Protected Sub theStaffButton_Click(sender As Object, e As System.EventArgs) Handles theStaffButton.Click
            Dim shortcut = StaffBrokerFunctions.GetStaffProfileProperty(CInt(staffListBox.SelectedValue), "givingshortcut")
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frDonations")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?giveto=" & shortcut)
                End If
            End If

        End Sub


        Protected Sub theDepButton_Click(sender As Object, e As System.EventArgs) Handles theDepButton.Click
            'Dim shortcut = StaffBrokerFunctions.GetStaffProfileProperty(CInt(DepDDL.SelectedValue), "givingshortcut")
            'Dim shortcut = StaffBrokerFunctions.AP_StaffBroker_Departments(CInt(DepDDL.SelectedValue), "GivingShortcut")

            Dim d As New StaffBrokerDataContext
            Dim theDepartment = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = CInt(DepDDL.SelectedValue) Select c.GivingShortcut
            If theDepartment.Count > 0 Then
                Dim mc As New DotNetNuke.Entities.Modules.ModuleController
                Dim x = mc.GetModuleByDefinition(PortalId, "frDonations")
                If Not x Is Nothing Then
                    If Not x.TabID = Nothing Then
                        Response.Redirect(NavigateURL(x.TabID) & "?giveto=" & theDepartment.First)
                    End If
                End If
            End If
            
        End Sub
    End Class

End Namespace