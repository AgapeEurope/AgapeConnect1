﻿Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker

Partial Class DesktopModules_AgapePortal_StaffBroker_Depts
    Inherits System.Web.UI.UserControl


    Private _UID As Integer
    Public Property UID() As Integer
        Get
            Return _UID
        End Get
        Set(ByVal value As Integer)
            _UID = value

            hfUserId.Value = _UID
        End Set
    End Property


    Dim d As New StaffBrokerDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        If Not Page.IsPostBack Then
            hfUserId.Value = _UID
        End If

    End Sub


    Public Function getDepartments(ByVal UserId As Integer) As IQueryable(Of AP_StaffBroker_Department)
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim depts = From c In d.AP_StaffBroker_Departments Where c.CostCentreManager = UserId And c.PortalId = PS.PortalId Or c.CostCentreDelegate = UserId


        Return depts


    End Function
    
   
    Protected Sub DataList2_ItemCommand(source As Object, e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList2.ItemCommand
        If e.CommandName = "GotoDept" Then
            '  Dim DModId = Entities.Modules.DesktopModuleController.GetDesktopModuleByFriendlyName("acDepartemnts")
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim x = mc.GetModuleByDefinition(PS.PortalId, "acDepartments")
            Response.Redirect(NavigateURL(x.TabID) & "?DeptId=" & e.CommandArgument)
        ElseIf e.CommandName = "RemoveDelegate" Then
            Dim q = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = CInt(e.CommandArgument)
            If q.Count > 0 Then
                q.First.CostCentreDelegate = Nothing
            End If
            d.SubmitChanges()
            DataList2.DataBind()
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            StaffBrokerFunctions.SetSetting("tntFlag", "Dirty", PS.PortalId)

        End If
    End Sub

    Public Function isDelegated(ByVal DeptId As Integer) As Boolean
        Dim q = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = DeptId And Not c.CostCentreDelegate Is Nothing
        Return q.Count > 0
    End Function

    Public Function GetDelegateName(ByVal DeptId As Integer) As String
        Dim q = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = DeptId And Not c.CostCentreDelegate Is Nothing
        If q.Count > 0 Then
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim DelUser = UserController.GetUserById(PS.PortalId, q.First.CostCentreDelegate)

            Return DelUser.FirstName & " " & DelUser.LastName

        End If
        Return ""
    End Function
    Public Function GetLeaderName(ByVal DeptId As Integer) As String
        Dim q = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = DeptId And Not c.CostCentreDelegate Is Nothing
        If q.Count > 0 Then
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim ManUser = UserController.GetUserById(PS.PortalId, q.First.CostCentreManager)

            Return ManUser.FirstName & " " & ManUser.LastName

        End If
        Return ""
    End Function
    Protected Sub btnDelegate_Click(sender As Object, e As System.EventArgs) Handles btnDelegate.Click
        Dim q = From c In d.AP_StaffBroker_Departments Where (CheckBox1.Checked Or c.CostCenterId = CInt(hfDeptId.Value)) And c.CostCentreManager = CInt(hfUserId.Value)
        For Each row In q
            If row.CostCentreDelegate Is Nothing Then
                If ddlDelegate.SelectedIndex = 0 Then
                    row.CostCentreDelegate = Nothing
                Else
                    row.CostCentreDelegate = ddlDelegate.SelectedValue
                End If
            End If
        Next
        d.SubmitChanges()
        DataList2.DataBind()
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        StaffBrokerFunctions.SetSetting("tntFlag", "Dirty", PS.PortalId)

        Dim x As New tntWebUsers()
        x.RefreshWebUsers({CInt(ddlDelegate.SelectedValue)})
    End Sub
End Class
