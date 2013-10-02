
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
                Case StaffRmb.RmbStatus.Approved
                    pnlTile.Attributes("class") &= " alert-info"
                    lblStatus.Text = StaffRmb.RmbStatus.StatusName(value)

                Case StaffRmb.RmbStatus.Cancelled
                    pnlTile.Attributes("class") &= " alert-danger"
                    lblStatus.Text = "Cancelled"
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
            If Status = StaffRmb.RmbStatus.Processed And Not value = "current" Then
                pnlTile.Attributes("class") = pnlTile.Attributes("class").Replace("success", "expired")
                lblStatus.Text = "Expired " & value
                lblNote.Text = ""
            End If
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
            lblStaffName.Text = staff.DisplayName

        End Set
    End Property


End Class
