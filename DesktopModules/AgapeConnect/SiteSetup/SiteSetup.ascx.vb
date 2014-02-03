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

Imports GMA
Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class SiteSetup
        Inherits Entities.Modules.PortalModuleBase
      

        Dim d As New StaffBroker.StaffBrokerDataContext

        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            lblSiteName.Text = PortalSettings.PortalName
            cbSiteName.Checked = True
            If PortalSettings.LogoFile.Contains("ACLogo") Then
                lblCustomLogo.Text = "You have successfully customised the Site Logo"

            End If

            If Not String.IsNullOrEmpty(StaffBrokerFunctions.GetSetting("LastPump", PortalId)) Then


                'Check for account codes and R/C's
                cbAcDatalinks.Checked = True
                lblAcDatalinks.Text = "Connected"

            End If
            Dim dr As New StaffRmb.StaffRmbDataContext
            If dr.AP_StaffBroker_AccountCodes.Where(Function(c) c.PortalId = PortalId).Count() + dr.AP_StaffBroker_CostCenters.Where(Function(c) c.PortalId = PortalId).Count() > 5 Then
                lblAcDatalinks.Text = "Connected"
                cbAccountCodes.Checked = True
            End If
            If StaffBrokerFunctions.GetSetting("NonDynamics", PortalId) = True Then
                cbDynamics.Checked = True
                cbAcDatalinks.Checked = True
                cbAccountCodes.Checked = True
                lblAcDatalinks.Text = "Not Applicable"
                lblAccountCodes.Text = "Not Applicable"
            End If

            ddlAccountingCurrency.SelectedValue = StaffBrokerFunctions.GetSetting("AcccountingCurrency", PortalId)
            ddlLocalCurrency.SelectedValue = StaffBrokerFunctions.GetSetting("LocalCurrency", PortalId)
            tbCurrencySymbol.Text = StaffBrokerFunctions.GetSetting("Currency", PortalId)

            '   Dim ds As New StaffBroker.StaffBrokerDataContext
            Dim staff = From c In d.AP_StaffBroker_Staffs Where c.PortalId = PortalId
            Dim bulkstaff As String = "To upload multiple staff you will find it easier to use the bulk upload tool. You will need to know each staff members ""TheKey"" email address, and the RC of their Staff Account (if they have one)."

            If staff.Count = 0 Then

                lblStaff.Text = "There only appears to be " & staff.Count & "staff accounts setup. " & bulkstaff
            Else
                lblStaff.Text = "You appear to have setup some staff accounts successfully. When you are done, mark as complete."
            End If

            Dim reprel = (From c In d.AP_StaffBroker_LeaderMetas Where c.User.AP_StaffBroker_Staffs.PortalId = PortalId).Count
            If reprel < 5 Then
                lblLeadership.Text = "You do not appear to have setup your leadersthip relationships yet. This can be done from the third tab, on the Staff Admin page."
            Else
                lblLeadership.Text = "You appear to have setup some leadership relationships. When you are done, mark as complete."
            End If


            Dim Depts = (From c In d.AP_StaffBroker_Departments Where c.PortalId = PortalId).Count

            If Depts > 0 Then
                lblDepartments.Text = "You have setup some departments. When you are done, mark as complete. "
            End If
        End Sub

        Public Function GetProgressForSection(ByVal Section As Integer) As Integer


            Dim score = From c In d.AP_Setup_Checklists Where c.PortalId = PortalId And c.SectionNumber = Section
            If score.Count > 0 Then


                Return (score.Where(Function(c) c.Complete).Count / score.Count) * 100


            Else
                Return 0

            End If
        End Function

        Public Sub VerifyDefinition()

            

        End Sub

        Public Sub AddEditSection(ByVal Section As Integer, ByVal Name As Integer)

            Dim q = From c In d.AP_Setup_Checklists Where c.PortalId = PortalId And c.SectionNumber = Section And c.Name = Name

            If q.Count = 0 Then

                Dim insert As New StaffBroker.AP_Setup_Checklist

            End If
        End Sub

    End Class
End Namespace
