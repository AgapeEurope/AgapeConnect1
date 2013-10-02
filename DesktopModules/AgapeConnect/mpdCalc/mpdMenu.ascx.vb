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

       
        Dim myBudgets As IQueryable(Of AP_mpdCalc_StaffBudget)

     
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'Verify that there is a tabmoduleid - otherwise create it from the null portalid template
            Dim d As New MPDDataContext

            Dim q = From c In d.AP_mpdCalc_Definitions Where c.PortalId = PortalId

            If q.Count = 0 Then
                CreateNewBudgetDefinition()
            End If

            LoadMenu()
            lblEditMode.Visible = IsEditMode()
            lblViewMode.Visible = Not IsEditMode()
        End Sub

        Private Sub CreateNewBudgetDefinition()
            Dim d As New MPDDataContext
            Dim q = From c In d.AP_mpdCalc_Definitions Where c.PortalId = -1

            If q.Count > 0 Then
                Dim insertDef As New AP_mpdCalc_Definition
                insertDef.ActiveFromYear = q.First.ActiveFromYear
                insertDef.AssessmentRate = q.First.AssessmentRate
                insertDef.Complience = q.First.Complience
                insertDef.ShowComplience = q.First.ShowComplience
                insertDef.PortalId = PortalId
                insertDef.TabModuleId = TabModuleId
                d.AP_mpdCalc_Definitions.InsertOnSubmit(insertDef)
                d.SubmitChanges()
                For Each s In q.First.AP_mpdCalc_Sections
                    Dim insertSec As New AP_mpdCalc_Section
                    insertSec.Name = s.Name
                    insertSec.Number = s.Number
                    insertSec.TotalMode = s.TotalMode
                    insertSec.mpdDefId = insertDef.mpdDefId
                    d.AP_mpdCalc_Sections.InsertOnSubmit(insertSec)
                    d.SubmitChanges()
                    For Each row In s.AP_mpdCalc_Questions
                        Dim insertq As New AP_mpdCalc_Question
                        insertq.AccountCode = row.AccountCode
                        insertq.Fixed = row.Fixed
                        insertq.Formula = row.Formula
                        insertq.Help = row.Help
                        insertq.Max = row.Max
                        insertq.Min = row.Min
                        insertq.Name = row.Name
                        insertq.QuestionNumber = row.QuestionNumber
                        insertq.Rate1 = row.Rate1
                        insertq.Rate2 = row.Rate2
                        insertq.Rate3 = row.Rate3
                        insertq.Rate4 = row.Rate4
                        insertq.SectionId = insertSec.SectionId
                        insertq.TaxSystem = row.TaxSystem
                        insertq.Threshold1 = row.Threshold1
                        insertq.Threshold2 = row.Threshold2
                        insertq.Threshold3 = row.Threshold3
                        insertq.Type = row.Type
                        d.AP_mpdCalc_Questions.InsertOnSubmit(insertq)
                    Next
                    d.SubmitChanges()
                Next
            End If
        End Sub

        Public Sub LoadMenu()
            Dim d As New MPDDataContext
            'ddlNewYear.Items.Add(New ListItem((Today.Year - 1) & " - " & (Today.Year), Today.Year - 1))
            'ddlNewYear.Items.Add(New ListItem((Today.Year) & " - " & (Today.Year + 1), Today.Year))
            'ddlNewYear.Items.Add(New ListItem((Today.Year + 1) & " - " & (Today.Year + 2), Today.Year + 1))
            'ddlNewYear.SelectedIndex = 1

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


                    myBudgets = From c In d.AP_mpdCalc_StaffBudgets
                                  Where c.AP_mpdCalc_Definition.PortalId = PortalId And c.StaffId = Staff.StaffId
                                  Order By c.Status, c.BudgetPeriodStart Descending




                    rpMyBudgets.DataSource = myBudgets
                    rpMyBudgets.DataBind()

                    Dim team = StaffBrokerFunctions.GetTeam(UserId).Select(Function(c) c.AP_StaffBroker_Staffs.StaffId)

                    Dim toApprove = (From c In d.AP_mpdCalc_StaffBudgets
                             Where team.Contains(c.StaffId) And c.AP_mpdCalc_Definition.PortalId = PortalId And (c.Status = StaffRmb.RmbStatus.Submitted Or c.Status = StaffRmb.RmbStatus.Approved)
                           Order By c.Status, c.BudgetPeriodStart Descending).ToList




                    rpTeamBudgets.DataSource = toApprove
                    rpTeamBudgets.DataBind()


                    Dim activeBudgets As New ArrayList()
                    For Each row In team
                        Dim ActiveBudget = From c In d.AP_mpdCalc_StaffBudgets
                              Where c.AP_mpdCalc_Definition.PortalId = PortalId And c.StaffId = row And c.Status = StaffRmb.RmbStatus.Processed
                                Order By c.BudgetPeriodStart Descending

                        If ActiveBudget.Count > 0 Then
                            activeBudgets.Add(ActiveBudget.First)
                        End If
                    Next
                    rpActiveBudgets.DataSource = activeBudgets
                    rpActiveBudgets.DataBind()


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

                    'Dim team = StaffBrokerFunctions.GetTeam(UserId).Select(Function(c) c.AP_StaffBroker_Staffs.StaffId)

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

        Public Function getExpired(ByVal Status As Integer, ByVal staffBudgetId As Integer) As String
            If Status <> StaffRmb.RmbStatus.Processed Then
                Return ""
            Else
                Dim mycompleted = From c In myBudgets Where c.Status = StaffRmb.RmbStatus.Processed Order By c.BudgetYearStart Descending

                Dim getNext As Boolean = False

                For Each row In mycompleted
                    If getNext = True Then
                        Dim dt = New Date(CInt(Left(row.BudgetPeriodStart, 4)), CInt(Right(row.BudgetPeriodStart, 2)), 1).AddMonths(-1)

                        Return dt.ToString("MMM yyyy")
                    End If
                    If row.StaffBudgetId = staffBudgetId Then
                        getNext = True

                    End If

                Next


                Return "current"

            End If
        End Function

        Protected Sub btnCreateNewBudget_Click(sender As Object, e As EventArgs) Handles btnCreateNewBudget.Click
            Dim d As New MPDDataContext
            Dim def = From c In d.AP_mpdCalc_Definitions Where c.PortalId = PortalId And c.TabModuleId = TabModuleId
            If def.Count > 0 Then
                Dim insert As New MPD.AP_mpdCalc_StaffBudget
                insert.StaffId = StaffBrokerFunctions.GetStaffMember(UserId).StaffId
                insert.DefinitionId = def.First.mpdDefId
                insert.BudgetYearStart = 2013 'ddlNewYear.SelectedValue
                insert.Status = StaffRmb.RmbStatus.Draft
                d.AP_mpdCalc_StaffBudgets.InsertOnSubmit(insert)
                d.SubmitChanges()
                Response.Redirect(EditUrl("mpdCalc") & "?sb=" & insert.StaffBudgetId)


            End If

        End Sub
    End Class
End Namespace
