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
Imports MPD

Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class mpdMenu
        Inherits Entities.Modules.PortalModuleBase

       

        Private d As New MPDDataContext
     
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'HyperLink1.NavigateUrl = EditUrl("mpdCalc") & "?sb=1"

            LoadMenu()
        End Sub

        Public Sub LoadMenu()

            If Not Page.IsPostBack Then

                If IsEditMode() Then
                    stDraft.Status = StaffRmb.RmbStatus.Draft
                    stSubmitted.Status = StaffRmb.RmbStatus.Submitted
                    stProcessed.Status = StaffRmb.RmbStatus.Processed
                    stApproved.Status = StaffRmb.RmbStatus.Approved
                    stCancelled.Status = StaffRmb.RmbStatus.Cancelled
                    stDraft.URL = EditUrl("mpdCalc")
                    stSubmitted.URL = EditUrl("mpdCalc")
                    stProcessed.URL = EditUrl("mpdCalc")
                    stApproved.URL = EditUrl("mpdCalc")
                    stCancelled.URL = EditUrl("mpdCalc")
                    lblToApprove.Visible = False
                    lblYourSubmitted.Visible = False

                Else


                    Dim Staff = StaffBrokerFunctions.GetStaffMember(UserId)


                    Dim myBudgets = From c In d.AP_mpdCalc_StaffBudgets
                                  Where c.AP_mpdCalc_Definition.PortalId = PortalId And c.StaffId = Staff.StaffId
                                 Select c.StaffBudgetId, c.BudgetYearStart, Name = Staff.DisplayName, c.StaffId, c.Status
                    dlPending.DataSource = myBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Draft)
                    dlPending.DataBind()

                    dlMySubmitted.DataSource = myBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Submitted)
                    dlMySubmitted.DataBind()
                    dlMyApproved.DataSource = myBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Approved)
                    dlMyApproved.DataBind()
                    dlMyProcessed.DataSource = myBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Processed)
                    dlMyProcessed.DataBind()
                    dlMyCancelled.DataSource = myBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Cancelled)
                    dlMyCancelled.DataBind()

                    Dim team = StaffBrokerFunctions.GetTeam(UserId).Select(Function(c) c.AP_StaffBroker_Staffs.StaffId)

                    Dim teamBudgets = From c In d.AP_mpdCalc_StaffBudgets
                         Where team.Contains(c.StaffId) And c.AP_mpdCalc_Definition.PortalId = PortalId
                        Select c.StaffBudgetId, c.BudgetYearStart, c.StaffId, c.Status


                    dlTeamSubmitted.DataSource = teamBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Submitted)
                    dlTeamSubmitted.DataBind()
                    ' dlTeamProcessed.DataSource = teamBudgets.Where(Function(c) c.Status = StaffRmb.RmbStatus.Processed)
                    ' dlTeamProcessed.DataBind()
                    stTeamApproved.URL = EditUrl("mpdCalc")
                    stTeamApproved.Status = StaffRmb.RmbStatus.Approved
                    stTeamProcessed.URL = EditUrl("mpdCalc")
                    stTeamProcessed.Status = StaffRmb.RmbStatus.Processed

                End If
            End If


        End Sub



    End Class
End Namespace
