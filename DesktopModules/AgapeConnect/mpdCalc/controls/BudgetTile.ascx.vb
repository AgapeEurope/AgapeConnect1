
Partial Class DesktopModules_AgapeConnect_mpdCalc_controls_BudgetTile
    Inherits System.Web.UI.UserControl


    



    Private _status As Integer
    Public Property Status() As Integer
        Get
            Return _status
        End Get
        Set(ByVal value As Integer)
            _status = value
            Select Case Status
                Case StaffRmb.RmbStatus.Processed
                    pnlTile.Attributes("class") &= " alert-success"

                    lblStatus.Text = "Active"
                    lblNote.Text = "This is your current budget"
                Case StaffRmb.RmbStatus.Submitted
                    pnlTile.Attributes("class") &= " alert-info"
                    lblStatus.Text = StaffRmb.RmbStatus.StatusName(value)
                    lblNote.Text = "Awaiting aprroval"
                Case StaffRmb.RmbStatus.Approved
                    pnlTile.Attributes("class") &= " alert-success"
                    lblStatus.Text = "Active"
                    lblStatus.Text = StaffRmb.RmbStatus.StatusName(value)

                Case StaffRmb.RmbStatus.Cancelled
                    pnlTile.Attributes("class") &= " alert-danger"
                    lblStatus.Text = "Cancelled"
                Case StaffRmb.RmbStatus.Draft
                    pnlTile.Attributes("class") &= " alert-warning"
                    lblStatus.Text = "Draft"
                    lblNote.Text = "This budget has not been submitted"
                Case Else
                    pnlTile.Attributes("class") &= " alert-warning"
                    lblStatus.Text = StaffRmb.RmbStatus.StatusName(value)
            End Select
        End Set
    End Property
    Private _navigateURL As String
    Public Property NavigateURL() As String
        Get
            Return _navigateURL
        End Get
        Set(ByVal value As String)
            _navigateURL = value
            hlTile.NavigateUrl = value
        End Set
    End Property
    Private _expired As String
    Public Property Expired() As String
        Get
            Return _expired
        End Get
        Set(ByVal value As String)
            _expired = value
            If (Status = StaffRmb.RmbStatus.Processed Or Status = StaffRmb.RmbStatus.Approved) And Not value = "current" Then
                If value <> "" Then
                    pnlTile.Attributes("class") = pnlTile.Attributes("class").Replace("success", "expired")
                    lblStatus.Text = "Expired"
                    lblNote.Text = "This budget expired " & value
                Else
                    pnlTile.Attributes("class") = pnlTile.Attributes("class").Replace("success", "info")
                    lblStatus.Text = "Approved"
                    lblNote.Text = "This budget will replace the current budget: " & lblStart.Text
                End If




            End If
        End Set
    End Property

    Private _mpdGoal As Double
    Public Property MpdGoal() As Double
        Get
            Return _mpdGoal
        End Get
        Set(ByVal value As Double)
            _mpdGoal = value
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            lblGoal.Text = StaffBrokerFunctions.GetFormattedCurrency(PS.PortalId, value)
        End Set
    End Property


    Private _from As String
    Public Property From() As String
        Get
            Return _from
        End Get
        Set(ByVal value As String)
            _from = value
            If value.Length = 6 Then
                Dim d = New Date(CInt(Left(value, 4)), CInt(Right(value, 2)), 1)

                lblStart.Text = d.ToString("MMM yyyy")
            End If
            
        End Set
    End Property


    Private _staffId As Integer
    Public Property StaffId() As String
        Get
            Return _staffId
        End Get
        Set(ByVal value As String)
            _staffId = value
            Dim staff = StaffBrokerFunctions.GetStaffbyStaffId(value)
            '  lblStaffName.Text = staff.DisplayName

        End Set
    End Property


End Class
