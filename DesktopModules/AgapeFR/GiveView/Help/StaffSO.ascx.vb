Imports DotNetNuke
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Math
Imports System.Net
Imports System.IO
Imports System.Text
Imports System.Net.Mail
Imports System.Collections.Specialized

Imports System.Linq
Imports AgapeStaff
Imports StaffBroker
Imports StaffBrokerFunctions






Namespace DotNetNuke.Modules.Give

    Partial Class StaffDonations
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            Dim d As New AgapeStaffDataContext
            Dim dBroke As New StaffBrokerDataContext
            Dim staff = GetStaffMember(UserId)
            'Dim q = From c In d.Agape_Staff_Finances Where c.UserId1 = UserId Or c.USerId2 = UserId Select c.UserId1, c.USerId2, c.StaffFinanceId, c.FamilyId
            If Not staff Is Nothing Then
                hfUserId.Value = staff.UserId1
                hfUserId2.Value = staff.UserId2
                hfStaffFinanceId.Value = staff.StaffId


                Dim r = From c In d.Agape_Main_Give_PPlans Where (c.StaffFinanceId = hfStaffFinanceId.Value) And c.Status < 3 Select Monthly = CDbl((c.Amount / c.Frequency) * (1 - (CInt(c.GiftAid) * 0.25)))
                Dim s = From c In d.Agape_Main_Give_PPlans Where (c.StaffFinanceId = hfStaffFinanceId.Value) And c.Status = 2 Select Monthly = CDbl((c.Amount / c.Frequency) * (1 - (CInt(c.GiftAid) * 0.25)))

                lblActive.Text = r.Sum.ToString("£0.00")
                lblDonorCount.Text = r.Count

                'lblActive.Text = (From c In d.Agape_Main_Give_PPlans Where (c.StaffFinanceId = hfStaffFinanceId.Value) And c.Status < 3 And Not c.GiftAid Select CInt(c.GiftAid)).First


                'Dim t = From c In d.Agape_Staff_Budgets Where c.FamilyId1 = q.First.FamilyId
                'If t.Count > 0 Then
                '    Dim objModules As New Entities.Modules.ModuleController


                '    Dim totalBudget As Double = t.First.GrossSalary + t.First.Pension '+ ((t.First.Conference1Cost _
                '    '+ t.First.Conference2Cost + t.First.Conference3Cost + t.First.Conference4Cost + t.First.Conference5Cost _
                '    '+ t.First.Conference6Cost + t.First.Conference7Cost + t.First.Conference8Cost) / 12)
                '    totalBudget += ((Math.Max((t.First.GrossSalary * 12) - CDbl(objModules.GetModuleSettings(1779)("NIThreshold")), 0)) * CDbl(objModules.GetModuleSettings(1779)("NIRate")) / 100).ToString("n0")


                '    Dim SubTot As Double = (t.First.Printing + t.First.Postage + t.First.Literature + t.First.PublicTransport + t.First.CarMileage _
                '               + t.First.Subsistence + t.First.PhoneCalls + t.First.MobilePhone + t.First.PhoneRental + t.First.Entertaining + t.First.Other)
                '    totalBudget += SubTot * 1.1
                '    totalBudget += t.First.Transfers
                '    totalBudget *= 8 / 7
                '    lblBudget.Text = objModules.GetTabModuleSettings(3072)("NIThreshold")

                'End If
            End If
        End Sub

        Public Function GetUserName(ByVal UId As Integer) As String
            Return UserController.GetUserById(PortalId, UId).FirstName & " " & UserController.GetUserById(PortalId, UId).LastName
        End Function
        Public Function getStatus(ByRef Status As Integer) As String
            Select Case Status
                Case 0
                    Return "Pending"
                Case 1
                    Return "Waiting for 1st payment"
                Case 2
                    Return "Active"
                Case Else
                    Return "Cancelled"
            End Select

        End Function
        Public Function getStatusColor(ByRef Status As Integer) As String
            Return "#660000"
            Select Case Status
                Case 0
                    Return "Blue"
                Case 1
                    Return "Yellow"
                Case 2
                    Return "Green"
                Case Else
                    Return "Red"
            End Select

        End Function
        Public Function getFreq(ByRef Frequency As Integer) As String
            Select Case Frequency
                Case 1
                    Return "Monthly"
                Case 3
                    Return "Quarterly"
                Case 12
                    Return "Yearly"
                Case Else
                    Return "every " & Frequency & " months"
            End Select

        End Function
    End Class


End Namespace
