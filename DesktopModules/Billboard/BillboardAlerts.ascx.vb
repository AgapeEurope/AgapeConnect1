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
Imports DotNetNuke.Entities.Modules
Imports DotNetNuke.Security
Imports Billboard
Imports StaffBroker


Namespace DotNetNuke.Modules.Billboard
    Partial Class BillboardAlerts
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            Dim ShowReminder As Boolean = False

            'look for reminders
            Dim Reminders As String = BillboardFunctions.CreateReminders(Me.UserId)
            If Not (Reminders = "" Or Reminders Is Nothing Or Reminders = "There are no reminders for you this week.") Then
                phMain.Controls.Add(New LiteralControl(Reminders))
            Else
                'If there are no reminders for this staff member then hide the module
                ContainerControl.Visible = False
            End If
        End Sub
#Region "Rules"
        Public Function CreateReminders() As Boolean
            Dim ShowReminder As Boolean = False

            'Dim staff As New AgapeStaff.AgapeStaffDataContext
            'Dim bill As New BillboardDataContext
            'Dim full As New FullStory.FullStoryDataContext
            'Dim broke As New StaffBroker.StaffBrokerDataContext

            Try
                'You have reimbursements to approve
                Dim rmbCount As Integer = 0
                'Dim q = From c In staff.Agape_Staff_Rmbs Where c.Status = 2 And c.CostCenter.Substring(3) <> "X"
                'For Each rmb In q
                '    Dim r = From c In broke.AP_StaffBroker_LeaderMetas Where (c.LeaderId = Me.UserId Or c.DelegateId = Me.UserId) And c.UserId = rmb.UserId
                '    If r.Count > 0 Then
                '        rmbCount = rmbCount + 1
                '    End If
                'Next

                'Dim s = From c In staff.Agape_Staff_Rmbs Where c.Status = 2 And c.CostCenter.Substring(3) = "X"
                'For Each rmb In s
                '    Dim t = From c In broke.AP_StaffBroker_Departments Where (c.CostCentreManager = Me.UserId Or c.CostCentreDelegate = Me.UserId) And c.CostCentre = rmb.CostCenter
                '    'Dim t = From c In (AgapeStaffFunctions.GetAllManagers((From c In staff.Agape_Main_AvailableCostCentres Where c.CostCentreCode = rmb.CostCenter).First.AvailableCostCentreId)) Where c.UserID = Me.UserId
                '    If t.Count > 0 Then
                '        rmbCount = rmbCount + 1
                '    End If
                'Next

                'If rmbCount > 0 Then
                '    ShowReminder = True
                '    Dim HL As New HyperLink
                '    HL.Text = "You have " & rmbCount & " reimbursements to approve."
                '    HL.Font.Size = 7
                '    If full.Agape_Main_GlobalDatas.Count > 0 Then
                '        HL.NavigateUrl = NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.RmbTabId))
                '    End If
                '    phMain.Controls.Add(HL)
                '    phMain.Controls.Add(New LiteralControl("<br/>"))
                'End If

                'You have budgets to approve
                'Dim u = From c In staff.Agape_Staff_Budgets Where c.Approver = Me.UserId
                'If u.Count > 0 Then
                '    phMain.Controls.Add(New LiteralControl("<br/>"))
                '    Dim HL As New HyperLink
                '    HL.Text = "You have " & u.Count & " budgets to approve."
                '    HL.Font.Size = 7
                '    If full.Agape_Main_GlobalDatas.Count > 0 Then
                '        HL.NavigateUrl = NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.BudgetTabId))
                '    End If
                '    phMain.Controls.Add(HL)
                '    phMain.Controls.Add(New LiteralControl("<br/>"))
                'End If

                'You have yet to submit a budget
                'If CDate(Now()).Month > 6 Then
                '    Dim v = From c In staff.Agape_Staff_Budgets Order By c.StartYear Descending Where c.StaffId = StaffBrokerFunctions.GetStaffMember(Me.UserId).StaffId
                '    If v.First.StartYear <> Now().Year Or v.Count = 0 Then
                '        phMain.Controls.Add(New LiteralControl("<br/>"))
                '        Dim HL As New HyperLink
                '        If Now().Month = 6 And Now().Day < 15 Then
                '            HL.Text = "You need to submit a new budget by 15th June."
                '        Else
                '            HL.Text = "Your budget is overdue. Go and do it now."
                '        End If
                '        HL.Font.Size = 7
                '        If full.Agape_Main_GlobalDatas.Count > 0 Then
                '            HL.NavigateUrl = NavigateURL(CInt(full.Agape_Main_GlobalDatas.First.BudgetTabId))
                '        End If
                '        phMain.Controls.Add(HL)
                '        phMain.Controls.Add(New LiteralControl("<br/>"))
                '    End If
                'End If


            Catch ex As Exception
                lblError.Text = ex.Message
                lblError.Visible = True
                ShowReminder = True
            End Try

            Return ShowReminder
        End Function
#End Region
    End Class
End Namespace

