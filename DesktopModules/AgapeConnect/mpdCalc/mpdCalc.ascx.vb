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
    Partial Class mpdCalc
        Inherits Entities.Modules.PortalModuleBase

        Private _age1 As Integer = 0
        Public Property Age1() As Integer
            Get
                Return _age1
            End Get
            Set(ByVal value As Integer)
                _age1 = value
            End Set
        End Property

        Private _age2 As Integer = 0
        Public Property Age2() As Integer
            Get
                Return _age2
            End Get
            Set(ByVal value As Integer)
                _age2 = value
            End Set
        End Property

        Private _isCouple As Boolean = False
        Public Property IsCouple() As Boolean
            Get
                Return _isCouple
            End Get
            Set(ByVal value As Boolean)
                _isCouple = value
            End Set
        End Property

        Private _staffType As String = ""
        Public Property StaffType() As String
            Get
                Return _staffType
            End Get
            Set(ByVal value As String)
                _staffType = value
            End Set
        End Property


        Private StaffBudId As Integer = -1
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then



                Dim d As New MPDDataContext()
                Dim theForm = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId
                If theForm.Count > 0 Then
                    Dim staffId = StaffBrokerFunctions.GetStaffMember(UserId).StaffId
                    Dim bud = From c In theForm.First.AP_mpdCalc_StaffBudgets Where c.StaffId = staffId And c.BudgetYearStart = Today.Year
                    If bud.Count > 0 Then
                        StaffBudId = bud.First.StaffBudgetId
                        itemCurrent.Monthly = bud.First.CurrentSupportLevel.Value.ToString("F0", CultureInfo.InvariantCulture)
                    End If
                    rpSections.DataSource = theForm.First.AP_mpdCalc_Sections
                    rpSections.DataBind()

                    hfAssessment.Value = theForm.First.AssessmentRate
                    If theForm.First.ShowComplience Then
                        cbCompliance.Text = theForm.First.Complience
                    End If
                    cbCompliance.Visible = theForm.First.ShowComplience
                    Age1 = 20
                    Age2 = 22
                    IsCouple = True
                    StaffType = "COOL"




                End If

            End If


        End Sub


        Public Function GetAnswer(ByVal QuestionId As Integer) As String
            If (StaffBudId > 0) Then
                Dim d As New MPDDataContext

                Dim q = From c In d.AP_mpdCalc_Answers Where c.QuestionId = QuestionId And c.StaffBudgetId = StaffBudId

                If q.Count > 0 Then
                    Return q.First.Value.Value.ToString("n2", New CultureInfo("en-US"))
                End If
            End If
            Return ""
        End Function
        Public Function GetName(ByVal QuestionId As Integer, ByVal DefName As String) As String
            If Not String.IsNullOrEmpty(DefName) Then
                Return DefName
            End If
            If (StaffBudId > 0) Then
                Dim d As New MPDDataContext

                Dim q = From c In d.AP_mpdCalc_Answers Where c.QuestionId = QuestionId And c.StaffBudgetId = StaffBudId

                If q.Count > 0 Then
                    Return "!!" & q.First.Name
                End If
            End If
            Return ""
        End Function

        Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
            Dim d As New MPD.MPDDataContext

            Dim def = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId And c.PortalId = PortalId
            If def.Count > 0 Then
                Dim staffId = StaffBrokerFunctions.GetStaffMember(UserId).StaffId
                Dim bud = From c In d.AP_mpdCalc_StaffBudgets Where c.StaffId = staffId And c.DefinitionId = def.First.mpdDefId And c.BudgetYearStart = Today.Year
                Dim budId As Integer = -1
                If bud.Count = 0 Then
                    'insert new Staff Budget
                    Dim insert = New MPD.AP_mpdCalc_StaffBudget
                    insert.DefinitionId = def.First.mpdDefId
                    insert.StaffId = staffId
                    insert.BudgetYearStart = Today.Year
                    insert.CurrentSupportLevel = itemCurrent.Monthly
                    insert.SubmittedOn = Now
                    insert.Status = StaffRmb.RmbStatus.Submitted
                    d.AP_mpdCalc_StaffBudgets.InsertOnSubmit(insert)
                    d.SubmitChanges()
                    budId = insert.StaffBudgetId
                Else
                    bud.First.CurrentSupportLevel = itemCurrent.Monthly

                    budId = bud.First.StaffBudgetId

                End If

                d.AP_mpdCalc_Answers.DeleteAllOnSubmit(d.AP_mpdCalc_Answers.Where(Function(c) c.StaffBudgetId = budId))


                For Each s In rpSections.Items
                    Dim rp As Repeater = s.FindControl("rpItems")
                    For Each q In rp.Items
                        Dim m As mpdItem = q.FindControl("theMpdItem")

                        Dim insert As New MPD.AP_mpdCalc_Answer
                        insert.QuestionId = m.QuestionId
                        insert.Value = m.Monthly
                        insert.Name = m.ItemName
                        insert.Tax = m.Tax
                        insert.StaffBudgetId = budId

                        d.AP_mpdCalc_Answers.InsertOnSubmit(insert)



                    Next
                Next


                d.SubmitChanges()


            End If




        End Sub
    End Class
End Namespace
