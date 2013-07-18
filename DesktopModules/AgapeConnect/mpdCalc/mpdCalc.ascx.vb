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
        Public LastSection As Integer = 0

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If (Not String.IsNullOrEmpty(Request.QueryString("sb"))) Then
                StaffBudId = Request.QueryString("sb")
            End If
            If Not Page.IsPostBack Then

                pnlInsert.Visible = IsEditMode()




                Dim d As New MPDDataContext()
                Dim theForm = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId
                Dim staff = StaffBrokerFunctions.GetStaffMember(UserId)
                lblBudYear.Text = Today.Year & "-" & Today.Year + 1
                If theForm.Count > 0 Then

                    Dim bud = From c In theForm.First.AP_mpdCalc_StaffBudgets Where c.StaffBudgetId = StaffBudId
                    If bud.Count > 0 Then

                        itemCurrent.Monthly = bud.First.CurrentSupportLevel.Value.ToString("F0", New CultureInfo("en-US"))
                        lblStatus.Text = StaffRmb.RmbStatus.StatusName(bud.First.Status)
                        lblBudYear.Text = bud.First.BudgetYearStart & "-" & (bud.First.BudgetYearStart + 1)
                        If bud.First.Status <> StaffRmb.RmbStatus.Draft And bud.First.Status <> StaffRmb.RmbStatus.Cancelled Then
                            cbCompliance.Enabled = False
                            cbCompliance.Checked = True
                            btnSubmit.Enabled = True
                        End If
                        staff = StaffBrokerFunctions.GetStaffbyStaffId(bud.First.StaffId)

                    End If


                    lblStaffName.Text = staff.DisplayName


                    If (theForm.First.AP_mpdCalc_Sections.Count > 0) Then
                        LastSection = theForm.First.AP_mpdCalc_Sections.Max(Function(c) c.Number)
                    End If
                    rpSections.DataSource = theForm.First.AP_mpdCalc_Sections.OrderBy(Function(c) c.Number)
                    rpSections.DataBind()





                    ddlInsertOrder.DataSource = (From c In theForm.First.AP_mpdCalc_Sections Select c.Number + 1)
                    ddlInsertOrder.DataBind()


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

        Private Sub SaveBudget()
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

        Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
            SaveBudget()

        End Sub
        Public Function GetMaxQuestionNumber(ByVal questions As System.Data.Linq.EntitySet(Of MPD.AP_mpdCalc_Question)) As Integer
            If questions.Count = 0 Then
                Return 1
            Else
                Return questions.Max(Function(c) c.QuestionNumber) + 1
            End If
        End Function



        Protected Sub btnInsertSection_Click(sender As Object, e As EventArgs) Handles btnInsertSection.Click
            Dim d As New MPD.MPDDataContext

            Dim def = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId And c.PortalId = PortalId
            If def.Count > 0 Then
                Dim i As Integer = 1
                For Each row In def.First.AP_mpdCalc_Sections.OrderBy(Function(c) c.Number)
                    If ddlInsertOrder.SelectedValue = i Then
                        'insert
                        
                        i += 1
                    End If
                    row.Number = i
                    i += 1
                Next
                Dim insert As New MPD.AP_mpdCalc_Section
                insert.mpdDefId = def.First.mpdDefId
                insert.Name = tbInsertSectionName.Text
                insert.TotalMode = "monthly"
                insert.Number = ddlInsertOrder.SelectedValue
                d.AP_mpdCalc_Sections.InsertOnSubmit(insert)
                d.SubmitChanges()
                ReloadPage()
            End If

        End Sub
        Private Sub ReloadPage()
            Response.Redirect(EditUrl("mpdCalc") & "?sb=" & StaffBudId)
        End Sub

        Protected Sub rpSections_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles rpSections.ItemCommand
            If e.CommandName = "EditSectionTitle" Then

                Dim d As New MPD.MPDDataContext
                Dim q = From c In d.AP_mpdCalc_Sections Where c.SectionId = CInt(e.CommandArgument) And c.AP_mpdCalc_Definition.PortalId = PortalId

                If q.Count > 0 Then
                    Dim Title As TextBox = rpSections.Items(e.Item.ItemIndex).FindControl("tbSectionName")
                    q.First.Name = Title.Text
                    d.SubmitChanges()
                    Response.Redirect(NavigateURL())
                End If
            ElseIf e.CommandName = "UP" Then
                Dim d As New MPD.MPDDataContext

                Dim q = From c In d.AP_mpdCalc_Sections Where c.SectionId = CInt(e.CommandArgument) And c.AP_mpdCalc_Definition.PortalId = PortalId


                If q.Count > 0 Then
                    Dim i As Integer = 1
                    Dim NewViewOrder = Math.Max(q.First.Number - 1, 1)


                    For Each row In q.First.AP_mpdCalc_Definition.AP_mpdCalc_Sections.Where(Function(c) c.SectionId <> q.First.SectionId).OrderBy(Function(c) c.Number)
                        If NewViewOrder = i Then
                            'skip if current index

                            i += 1
                        End If
                        row.Number = i
                        i += 1
                    Next
                    q.First.Number = NewViewOrder

                    d.SubmitChanges()
                    Response.Redirect(NavigateURL())
                End If

            ElseIf e.CommandName = "DOWN" Then
                Dim d As New MPD.MPDDataContext

                Dim q = From c In d.AP_mpdCalc_Sections Where c.SectionId = CInt(e.CommandArgument) And c.AP_mpdCalc_Definition.PortalId = PortalId


                If q.Count > 0 Then
                    Dim i As Integer = 1
                    Dim NewViewOrder = Math.Min(q.First.Number + 1, q.First.AP_mpdCalc_Definition.AP_mpdCalc_Sections.Max(Function(c) c.Number))
                  

                    For Each row In q.First.AP_mpdCalc_Definition.AP_mpdCalc_Sections.Where(Function(c) c.SectionId <> q.First.SectionId).OrderBy(Function(c) c.Number)
                        If NewViewOrder = i Then
                            'skip if current index

                            i += 1
                        End If
                        row.Number = i
                        i += 1
                    Next
                    
                    q.First.Number = NewViewOrder


                    d.SubmitChanges()
                    ReloadPage()
                End If
            End If
        End Sub

        Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            SaveBudget()
        End Sub
    End Class
End Namespace
