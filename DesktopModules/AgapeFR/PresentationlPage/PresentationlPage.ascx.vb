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
Imports System.Net
Imports System.IO
Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeFR.PresentationlPage
    Partial Class PresentationlPage
        Inherits Entities.Modules.PortalModuleBase

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Request.QueryString("giveto") <> "" Then
                Dim dBroke As New StaffBrokerDataContext
                Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.AP_StaffBroker_StaffProfiles.Where(Function(p) (p.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "GivingShortcut")).First.PropertyValue = Request.QueryString("giveto"))
                'first try staff
                If staff.Count > 0 Then
                    'Detect if UnNamed - if so use giving shortcut instead
                    If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                        Title.Text = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
                    Else
                        Title.Text = ChangeName(staff.First.DisplayName)
                        hfUserId1.Value = staff.First.UserId1
                    End If
                    'Determine if this staff member can receive donations, show button
                    btnGive.Visible = False
                    Dim IncList() As String = {"National Staff", "National Staff, Overseas"}
                    If IncList.Contains(staff.First.AP_StaffBroker_StaffType.Name) Then
                        btnGive.Visible = True
                    End If
                    'Determine if the user logged in is a staff member viewing their own page, show button
                    Dim nowUser As UserInfo = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo
                    btnEditProfile.Visible = False
                    If UserInfo.UserID = staff.First.UserId1 Or UserInfo.UserID = staff.First.UserId2 Then
                        btnEditProfile.Visible = True
                    End If
                    theImage1.ImageUrl = StaffBrokerFunctions.GetStaffJointPhoto(staff.First.StaffId)
                    Dim GiveText = GetStaffProfileProperty(staff.First.StaffId, "GivingText")
                    If GiveText = "" Then
                        GiveTextLbl.Text = Translate("staffpresent")
                    Else
                        GiveTextLbl.Text = Server.HtmlDecode(GiveText)
                    End If
                    RowId.Value = staff.First.StaffId
                    DonationType.Value = "Staff"
                    Return
                End If
                'Second Try Department/Ministry
                Dim Dept = From c In dBroke.AP_StaffBroker_Departments Where c.GivingShortcut = Request.QueryString("giveto")
                If Dept.Count > 0 Then
                    Title.Text = Dept.First.Name
                    GiveTextLbl.Text = Server.HtmlDecode(Dept.First.GivingText)
                    DonationType.Value = "Dept"
                    RowId.Value = Dept.First.CostCenterId
                    btnEditProfile.Visible = False
                    theImage1.ImageUrl = StaffBrokerFunctions.GetDeptPhoto(Dept.First.CostCenterId)
                    Return
                Else
                    badquery()
                End If
            Else
                badquery()
            End If
        End Sub
        Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
            Page.Title = "Agap&eacute; - " & Title.Text
        End Sub
        Private Function ChangeName(ByVal inName As String) As String
            If inName.IndexOf("&") > 0 Then
                inName = inName.Replace("&", Translate("NameAnd"))
            End If
            Return inName
        End Function
        Public Function Translate(ByVal ResourceString As String) As String
            Return DotNetNuke.Services.Localization.Localization.GetString(ResourceString & ".Text", LocalResourceFile)
        End Function
        Protected Sub badquery()
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveList")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID))
                End If
            End If
        End Sub
        Protected Sub btnEditProfile_Click(sender As Object, e As System.EventArgs) Handles btnEditProfile.Click
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "acEditStaffProfile")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?tab=3")
                End If
            End If
        End Sub
        Protected Sub btnGive_Click(sender As Object, e As System.EventArgs) Handles btnGive.Click
            Dim shortcut = Request.QueryString("giveto")
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveView")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?giveto=" & shortcut)
                End If
            End If
        End Sub
    End Class
End Namespace