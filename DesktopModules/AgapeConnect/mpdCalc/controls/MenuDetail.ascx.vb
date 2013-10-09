Imports MPD
Partial Class DesktopModules_AgapeConnect_mpdCalc_controls_MenuDetail
    Inherits System.Web.UI.UserControl


    Private _displayName As String
    Public Property DisplayName() As String
        Get
            Return _displayName
        End Get
        Set(ByVal value As String)
            _displayName = value
            lblDisplayName.Text = value
        End Set
    End Property

    Private _portalId As Integer
    Public Property PortalId() As Integer
        Get
            Return _portalId
        End Get
        Set(ByVal value As Integer)
            _portalId = value
            hfPortalId.Value = value
        End Set
    End Property
    Private _mpdDefId As Integer
    Public Property MpdDefId() As Integer
        Get
            Return _mpdDefId
        End Get
        Set(ByVal value As Integer)
            _mpdDefId = value
            hfMpdDefId.Value = value
        End Set
    End Property



    Private _staffId As Integer
    Public Property StaffId() As Integer
        Get
            Return _staffId
        End Get
        Set(ByVal value As Integer)
            _staffId = value
            Dim d As New MPDDataContext
            myBudgets = From c In d.AP_mpdCalc_StaffBudgets
                                  Where c.AP_mpdCalc_Definition.PortalId = PortalId And c.StaffId = StaffId And c.Status <> StaffRmb.RmbStatus.Cancelled
                                  Order By c.BudgetPeriodStart Descending




            rpMyBudgets.DataSource = myBudgets
            rpMyBudgets.DataBind()

            hfStaffId.Value = value

            Dim currentBudget = From c In myBudgets Where (c.Status = StaffRmb.RmbStatus.Processed Or c.Status = StaffRmb.RmbStatus.Approved) And c.BudgetPeriodStart < Today.ToString("yyyyMM")
            If currentBudget.Count > 0 Then
                hfCurrentBudgetId.Value = currentBudget.First.StaffBudgetId
                btnViewCurrentBudget.Visible = True
            End If

        End Set
    End Property

    Private _showCreate As Boolean
    Public Property ShowCreate() As Boolean
        Get
            Return _showCreate
        End Get
        Set(ByVal value As Boolean)
            _showCreate = value
            btnCreateNewBudget.Visible = value
        End Set
    End Property



    Private _editURL As String
    Public Property EditURL() As String
        Get
            Return _editURL
        End Get
        Set(ByVal value As String)
            _editURL = value
            hfEditUrl.Value = value
        End Set
    End Property

    Dim myBudgets As IQueryable(Of AP_mpdCalc_StaffBudget)

   
    Public Function getExpired(ByVal Status As Integer, ByVal staffBudgetId As Integer) As String
        If (Status <> StaffRmb.RmbStatus.Processed And Status <> StaffRmb.RmbStatus.Approved) Then
            Return ""
        Else
            Dim mycompleted = From c In myBudgets Where (c.Status = StaffRmb.RmbStatus.Processed Or c.Status = StaffRmb.RmbStatus.Approved) And c.BudgetPeriodStart < Today.ToString("yyyyMM") Order By c.BudgetYearStart Descending

           

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

        Dim def = (From c In d.AP_mpdCalc_Definitions Where c.mpdDefId = hfMpdDefId.Value).First

        Dim insert As New MPD.AP_mpdCalc_StaffBudget
        insert.StaffId = hfStaffId.Value
        insert.DefinitionId = hfMpdDefId.Value
        insert.BudgetYearStart = Today.Year 'ddlNewYear.SelectedValue
        insert.Status = StaffRmb.RmbStatus.Draft
        Dim FirstBudgetMonth As Integer? = def.FirstBudgetPeriod
        If FirstBudgetMonth Is Nothing Then
            FirstBudgetMonth = 7
        End If
        Dim fpStartDate As Date
        If FirstBudgetMonth <= Today.Month Then
            fpStartDate = New Date(Today.Year, FirstBudgetMonth, 1)
        Else
            fpStartDate = New Date(Today.Year - 1, FirstBudgetMonth, 1)
        End If


        insert.BudgetPeriodStart = fpStartDate.ToString("yyyyMM")




        d.AP_mpdCalc_StaffBudgets.InsertOnSubmit(insert)
        d.SubmitChanges()
        Response.Redirect(hfEditUrl.Value & "?sb=" & insert.StaffBudgetId)


    End Sub



    Protected Sub btnViewReport_Click(sender As Object, e As EventArgs) Handles btnViewReport.Click
        Dim mc As New DotNetNuke.Entities.Modules.ModuleController

        Dim x = mc.GetModuleByDefinition(hfPortalId.Value, "ac_mpdDashboard")
        Response.Redirect(NavigateURL(x.TabID) & "?StaffId=" & hfStaffId.Value)

    End Sub

    Protected Sub btnViewCurrentBudget_Click(sender As Object, e As EventArgs) Handles btnViewCurrentBudget.Click
        Response.Redirect(hfEditUrl.Value & "?sb=" & hfCurrentBudgetId.Value)
    End Sub
End Class
