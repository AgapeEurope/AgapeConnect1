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
                
                Dim ds As New StaffBroker.StaffBrokerDataContext


                pnlInsert.Visible = IsEditMode()




                Dim d As New MPDDataContext()
                Dim theForm = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId
                Dim Staff = StaffBrokerFunctions.GetStaffMember(UserId)


                If theForm.Count > 0 Then

                    If IsEditMode() Then
                        pnlAdmin.Visible = True

                        tbComplience.Text = theForm.First.Complience
                        If Not String.IsNullOrEmpty(theForm.First.Compensation) Then
                            If theForm.First.Compensation.StartsWith("%") Then
                                tbCompensation.Text = theForm.First.Compensation.Trim("%")
                                ddlCompensationType.SelectedValue = "Percentage"
                            Else
                                tbCompensation.Text = theForm.First.Compensation
                                ddlCompensationType.SelectedValue = "Formula"
                            End If
                        End If
                        If Not String.IsNullOrEmpty(theForm.First.Assessment) Then
                            If theForm.First.Assessment.StartsWith("%") Then
                                tbAssessment.Text = theForm.First.Assessment.Trim("%")
                                ddlAssessmentType.SelectedValue = "Percentage"

                            Else
                                tbAssessment.Text = theForm.First.Assessment
                                ddlAssessmentType.SelectedValue = "Formula"
                            End If
                        End If
                        tbDataserverURL.Text = StaffBrokerFunctions.GetSetting("DataserverURL", PortalId)



                        Dim staffTypes = From c In ds.AP_StaffBroker_StaffTypes Where c.PortalId = PortalId Select c.Name, Value = c.StaffTypeId

                        cblStaffTypes.Items.Clear()
                        cblStaffTypes.DataSource = staffTypes
                        cblStaffTypes.DataTextField = "Name"
                        cblStaffTypes.DataValueField = "Value"

                        cblStaffTypes.DataBind()
                        If Not String.IsNullOrEmpty(theForm.First.StaffTypes) Then


                            Dim selectedTypes = theForm.First.StaffTypes.Split(";")

                            For Each row As ListItem In cblStaffTypes.Items
                                If selectedTypes.Contains(row.Value) Then
                                    row.Selected = True

                                End If
                            Next
                        End If
                    End If





                    Dim bud = From c In theForm.First.AP_mpdCalc_StaffBudgets Where c.StaffBudgetId = StaffBudId
                    If bud.Count > 0 Then
                        If Not bud.First.CurrentSupportLevel Is Nothing Then
                            itemCurrent.Monthly = bud.First.CurrentSupportLevel.Value.ToString("F0", New CultureInfo("en-US"))
                        End If

                        Dim FirstBudgetMonth As Integer? = bud.First.AP_mpdCalc_Definition.FirstBudgetPeriod
                        If FirstBudgetMonth Is Nothing Then
                            FirstBudgetMonth = 7

                        End If
                        Dim fpStartDate As Date
                        If FirstBudgetMonth <= Today.Month Then
                            fpStartDate = New Date(Today.Year, FirstBudgetMonth, 1)
                        Else
                            fpStartDate = New Date(Today.Year - 1, FirstBudgetMonth, 1)
                        End If

                        For i As Integer = -1 To 1
                            ddlStartPeriod.Items.Add(New ListItem(fpStartDate.AddYears(i).ToString("MMM yyyy"), fpStartDate.AddYears(i).ToString("yyyyMM")))
                        Next
                        ddlStartPeriod.Items.Clear()
                        ddlStartPeriod.Items.Add(New ListItem("Last Year: " & fpStartDate.AddYears(-1).ToString("MMMM yyyy"), fpStartDate.AddYears(-1).ToString("yyyyMM")))
                        ddlStartPeriod.Items.Add(New ListItem("This Year: " & fpStartDate.AddYears(0).ToString("MMMM yyyy"), fpStartDate.AddYears(0).ToString("yyyyMM")))
                        ddlStartPeriod.Items.Add(New ListItem("Next Year: " & fpStartDate.AddYears(1).ToString("MMMM yyyy"), fpStartDate.AddYears(1).ToString("yyyyMM")))

                        ddlStartPeriod.Items.Add(New ListItem("Custom (Please specify):", ""))

                        ddlStartPeriod.SelectedIndex = 1


                        ddlYear.Items.Clear()
                        ddlYear.Items.Add(New ListItem(fpStartDate.AddYears(-1).ToString("yyyy"), fpStartDate.AddYears(-1).ToString("yyyy")))
                        ddlYear.Items.Add(New ListItem(fpStartDate.AddYears(0).ToString("yyyy"), fpStartDate.AddYears(0).ToString("yyyy")))
                        ddlYear.Items.Add(New ListItem(fpStartDate.AddYears(1).ToString("yyyy"), fpStartDate.AddYears(1).ToString("yyyy")))




                        Select Case bud.First.Status
                            Case StaffRmb.RmbStatus.Draft
                                btnSubmit.Visible = True
                                btnCancel.Visible = False
                            Case StaffRmb.RmbStatus.Submitted
                                btnApprove.Visible = Staff.StaffId <> bud.First.StaffId
                            Case StaffRmb.RmbStatus.Approved
                                btnProcess.Visible = IsEditMode()
                            Case StaffRmb.RmbStatus.Processed
                                btnCancel.Visible = False
                            Case StaffRmb.RmbStatus.Cancelled
                                btnSubmit.Visible = True
                                btnCancel.Visible = False
                        End Select


                        lblStatus.Text = StaffRmb.RmbStatus.StatusName(bud.First.Status)
                        Dim dt = New Date(CInt(Left(bud.First.BudgetPeriodStart, 4)), CInt(Right(bud.First.BudgetPeriodStart, 2)), 1)

                        If ddlStartPeriod.Items.FindByValue(bud.First.BudgetPeriodStart) Is Nothing Then
                            ddlStartPeriod.SelectedValue = ""
                            ddlPeriod.SelectedValue = dt.Month

                            ddlYear.SelectedValue = dt.Year
                            customDate.Attributes.CssStyle.Remove("display")
                        Else
                            ddlPeriod.SelectedValue = bud.First.BudgetPeriodStart

                        End If

                        If bud.First.Status <> StaffRmb.RmbStatus.Draft And bud.First.Status <> StaffRmb.RmbStatus.Cancelled Then
                            cbCompliance.Enabled = False
                            cbCompliance.Checked = True
                            btnSubmit.Enabled = True
                        End If
                        Staff = StaffBrokerFunctions.GetStaffbyStaffId(bud.First.StaffId)

                    End If


                    lblStaffName.Text = Staff.DisplayName
                    IsCouple = Staff.UserId2 > 0
                    StaffType = Staff.AP_StaffBroker_StaffType.Name

                    If (theForm.First.AP_mpdCalc_Sections.Count > 0) Then
                        LastSection = theForm.First.AP_mpdCalc_Sections.Max(Function(c) c.Number)
                    End If
                    rpSections.DataSource = theForm.First.AP_mpdCalc_Sections.OrderBy(Function(c) c.Number)
                    rpSections.DataBind()





                    ddlInsertOrder.DataSource = (From c In theForm.First.AP_mpdCalc_Sections Select c.Number + 1)
                    ddlInsertOrder.DataBind()


                    hfAssessment.Value = theForm.First.Assessment
                    hfCompentation.Value = theForm.First.Compensation


                    If theForm.First.ShowComplience Then
                        cbCompliance.Text = theForm.First.Complience

                    End If
                    cbCompliance.Visible = theForm.First.ShowComplience
                    Age1 = 20
                    Age2 = 22






                End If

            End If


        End Sub


        Private Sub set_if(ByRef prop As Object, ByVal value As Object)
            If Not value Is Nothing Then
                prop = value
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

        Private Sub SaveBudget(Optional ByVal ToStatus As Integer = -1)
            Dim d As New MPD.MPDDataContext

            Dim def = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId And c.PortalId = PortalId
            If def.Count > 0 Then

                Dim bud = From c In d.AP_mpdCalc_StaffBudgets Where c.StaffBudgetId = CInt(Request.QueryString("sb")) ' And c.BudgetYearStart = Today.Year
                Dim budId As Integer = -1
                If bud.Count > 0 Then
                   
                    bud.First.CurrentSupportLevel = itemCurrent.Monthly
                    bud.First.TotalBudget = hfMpdGoal.Value
                    bud.First.BudgetPeriodStart = IIf(ddlStartPeriod.SelectedValue = "", New Date(ddlYear.SelectedValue, ddlPeriod.SelectedValue, 1).ToString("yyyyMM"), ddlStartPeriod.SelectedValue)
                    bud.First.BudgetYearStart = Left(bud.First.BudgetPeriodStart, 4)
                    If ToStatus >= 0 Then
                        bud.First.Status = ToStatus
                        Select Case (ToStatus)
                            Case StaffRmb.RmbStatus.Submitted
                                bud.First.SubmittedOn = Now
                            Case StaffRmb.RmbStatus.Approved
                                bud.First.ApprovedOn = Now
                                bud.First.ApprovedBy = UserId

                            Case StaffRmb.RmbStatus.Processed
                                bud.First.ProcessedOn = Now
                                bud.First.ProcessedBy = UserId
                        End Select



                    End If
                    budId = bud.First.StaffBudgetId

                End If

                d.AP_mpdCalc_Answers.DeleteAllOnSubmit(d.AP_mpdCalc_Answers.Where(Function(c) c.StaffBudgetId = budId))


                For Each s In rpSections.Items
                    Dim rp As Repeater = s.FindControl("rpItems")
                    For Each q In rp.Items
                        Dim m As mpdItem = q.FindControl("theMpdItem")

                        Dim insert As New MPD.AP_mpdCalc_Answer
                        insert.QuestionId = m.QuestionId
                        If m.Monthly = 0 Then

                            insert.Value = m.Yearly / 12
                        Else
                            insert.Value = m.Monthly
                        End If


                        insert.Name = m.ItemName
                        insert.Tax = m.Tax
                        insert.StaffBudgetId = budId

                        d.AP_mpdCalc_Answers.InsertOnSubmit(insert)



                    Next
                Next


                d.SubmitChanges()
                Response.Redirect(Request.Url.ToString)

            End If


        End Sub

        Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
            SaveBudget(StaffRmb.RmbStatus.Submitted)

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
                    ReloadPage()
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
                    ReloadPage()
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
            ElseIf e.CommandName = "DeleteSection" Then
                Dim d As New MPD.MPDDataContext

                Dim q = From c In d.AP_mpdCalc_Sections Where c.SectionId = CInt(e.CommandArgument) And c.AP_mpdCalc_Definition.PortalId = PortalId


                Dim defid = q.First.mpdDefId

                d.AP_mpdCalc_Sections.DeleteAllOnSubmit(q)
                d.SubmitChanges()
                
                Dim i As Integer = 1
               

                For Each row In d.AP_mpdCalc_Sections.Where(Function(c) c.mpdDefId = defid).OrderBy(Function(c) c.Number)

                    row.Number = i
                    i += 1
                Next

               

                d.SubmitChanges()

                ReloadPage()
            End If
        End Sub

        Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            SaveBudget()
        End Sub

        Protected Sub btnApprove_Click(sender As Object, e As EventArgs) Handles btnApprove.Click
            SaveBudget(StaffRmb.RmbStatus.Approved)
        End Sub
      
        Protected Sub btnProcess_Click(sender As Object, e As EventArgs) Handles btnProcess.Click
            SaveBudget(StaffRmb.RmbStatus.Processed)
        End Sub

        Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
            SaveBudget(StaffRmb.RmbStatus.Cancelled)
        End Sub

        Protected Sub btnBack_Click(sender As Object, e As EventArgs) Handles btnBack.Click
            Response.Redirect(NavigateURL())
        End Sub

        Protected Sub btnUpdateConfig_Click(sender As Object, e As EventArgs) Handles btnUpdateConfig.Click
            Dim d As New MPDDataContext()
            Dim theForm = From c In d.AP_mpdCalc_Definitions Where c.TabModuleId = TabModuleId

            If theForm.Count > 0 Then
                Dim st = ""
                For Each row As ListItem In cblStaffTypes.Items
                    If row.Selected Then
                        st &= row.Value & ";"
                    End If


                Next
                theForm.First.StaffTypes = st

                If ddlAssessmentType.SelectedValue = "Percentage" Then
                    theForm.First.Assessment = "%" & tbAssessment.Text.Trim("%")
                Else
                    theForm.First.Assessment = tbAssessment.Text
                End If
                If ddlCompensationType.SelectedValue = "Percentage" Then
                    theForm.First.Compensation = "%" & tbCompensation.Text.Trim("%")
                Else
                    theForm.First.Compensation = tbCompensation.Text
                End If

                theForm.First.Complience = tbComplience.Text
                theForm.First.ShowComplience = tbComplience.Text.Trim(" ").Length > 0




                d.SubmitChanges()
                StaffBrokerFunctions.SetSetting("DataserverURL", tbDataserverURL.Text, PortalId)

                Response.Redirect(Request.Url.ToString())
            End If
        End Sub

        Protected Sub btnTestDataserver_Click(sender As Object, e As EventArgs) Handles btnTestDataserver.Click
            Dim resp = tntWebUsers.TestDataserverConnection(tbDataserverURL.Text)
            imgOK.Visible = False
            imgWarning.Visible = False
            pnlWarning.Visible = False

            If resp.connectionSuccess And resp.hasTrustedUser Then
                imgOK.Visible = True
            Else
                imgWarning.Visible = True
                pnlWarning.Visible = True
                If resp.connectionSuccess Then
                    lblWarning.Text = "The URL appears to be correct. However the trusted user, allowing this site to access your dataserver, has not been setup. You will need to setup ""trusteduser@agapeconnect.me"" in tntDataserver. For help, please contact ThadHoskins@agapeeurope.org. "
                Else
                    lblWarning.Text = resp.ErrorMessage
                End If
            End If
        End Sub
    End Class
End Namespace
