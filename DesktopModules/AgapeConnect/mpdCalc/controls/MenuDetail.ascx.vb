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
                                  Where c.AP_mpdCalc_Definition.PortalId = PortalId And c.StaffId = StaffId
                                  Order By c.Status, c.BudgetPeriodStart Descending




            rpMyBudgets.DataSource = myBudgets
            rpMyBudgets.DataBind()


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
        End Set
    End Property

    Dim myBudgets As IQueryable(Of AP_mpdCalc_StaffBudget)

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


End Class
