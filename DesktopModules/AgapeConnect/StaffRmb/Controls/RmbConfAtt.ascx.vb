﻿
Partial Class controls_RmbConfProv
    Inherits Entities.Modules.PortalModuleBase
    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        Dim FileName As String = System.IO.Path.GetFileNameWithoutExtension(Me.AppRelativeVirtualPath)
        If Not (Me.ID Is Nothing) Then
            'this will fix it when its placed as a ChildUserControl 
            Me.LocalResourceFile = Me.LocalResourceFile.Replace(Me.ID, FileName)
        Else
            ' this will fix it when its dynamically loaded using LoadControl method 
            Me.LocalResourceFile = Me.LocalResourceFile & FileName & ".ascx.resx"
            Dim Locale = System.Threading.Thread.CurrentThread.CurrentCulture.Name
            Dim AppLocRes As New System.IO.DirectoryInfo(Me.LocalResourceFile.Replace(FileName & ".ascx.resx", ""))
            If Locale = PortalSettings.CultureCode Then
                'look for portal varient
                If AppLocRes.GetFiles(FileName & ".ascx.Portal-" & PortalId & ".resx").Count > 0 Then
                    Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", "Portal-" & PortalId & ".resx")
                End If
            Else

                If AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".Portal-" & PortalId & ".resx").Count > 0 Then
                    'lookFor a CulturePortalVarient
                    Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", Locale & ".Portal-" & PortalId & ".resx")
                ElseIf AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".resx").Count > 0 Then
                    'look for a CultureVarient
                    Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", Locale & ".resx")
                ElseIf AppLocRes.GetFiles(FileName & ".ascx.Portal-" & PortalId & ".resx").Count > 0 Then
                    'lookFor a PortalVarient
                    Me.LocalResourceFile = Me.LocalResourceFile.Replace("resx", "Portal-" & PortalId & ".resx")
                End If
            End If
        End If
    End Sub

    Public Sub Initialize(ByVal settings As Hashtable)

        If settings("NoReceipt") = 0 Then
            If settings("VatAttrib") = False And settings("ElectonicReceipts") = False Then
                'receipts are always required (and no VAT issues) so don't ask... Just assume receipts

                ddlVATReceipt.SelectedValue = 1
                ReceiptLine.Visible = False

            End If
            ddlVATReceipt.Items(3).Enabled = False
        Else
            hfNoReceiptLimit.Value = settings("NoReceipt")
            Dim _LIMIT As String = StaffBrokerFunctions.GetSetting("Currency", PortalId) & settings("NoReceipt")
            ddlVATReceipt.Items(3).Text = DotNetNuke.Services.Localization.Localization.GetString("NoReceipt.Text", LocalResourceFile).Replace("[LIMIT]", _LIMIT)
            ttlReceipt.Text = DotNetNuke.Services.Localization.Localization.GetString("lblReceipt.Text", LocalResourceFile)
            ttlReceipt.HelpText = DotNetNuke.Services.Localization.Localization.GetString("lblReceipt.Help", LocalResourceFile).Replace("[LIMIT]", _LIMIT)
            ReceiptLine.Visible = True
            ddlVATReceipt.Items(3).Enabled = True
        End If

        ddlVATReceipt.Items(0).Enabled = settings("VatAttrib")
        ddlVATReceipt.Items(2).Enabled = settings("ElectronicReceipts") Or ddlVATReceipt.SelectedValue = 2
    End Sub
    Public Property ReceiptType() As Integer
        Get
            Return ddlVATReceipt.SelectedValue
        End Get
        Set(ByVal value As Integer)
            ddlVATReceipt.SelectedValue = value
        End Set
    End Property
    Public Property Comment() As String
        Get
            Return tbDesc.Text
        End Get
        Set(ByVal value As String)
            tbDesc.Text = value
        End Set
    End Property
    Public Property theDate() As Date
        Get
            Return CDate(dtDate.Text)
        End Get
        Set(ByVal value As Date)
            If value = Nothing Then
                dtDate.Text = Today.ToShortDateString
            Else
                dtDate.Text = value
            End If
        End Set
    End Property
    Public Property VAT() As Boolean
        Get
            Return (ddlVATReceipt.SelectedValue = 0)
        End Get
        Set(ByVal value As Boolean)
            If value = True Then
                ddlVATReceipt.SelectedValue = 0
            Else
                ddlVATReceipt.SelectedValue = 1
            End If


        End Set
    End Property

    Public Property Amount() As Double
        Get
            Return Double.Parse(tbAmount.Text, New CultureInfo("en-US").NumberFormat)
        End Get
        Set(ByVal value As Double)
            tbAmount.Text = value.ToString("n2", New CultureInfo("en-US"))
        End Set
    End Property
    Public Property Spare1() As String
        Get
            Return Nothing
        End Get
        Set(ByVal value As String)

        End Set
    End Property
    Public Property Spare2() As String
        Get
            Return Nothing
        End Get
        Set(ByVal value As String)

        End Set
    End Property
    Public Property Spare3() As String
        Get
            Return Nothing
        End Get
        Set(ByVal value As String)

        End Set
    End Property
    Public Property Spare4() As String
        Get
            Return Nothing
        End Get
        Set(ByVal value As String)

        End Set
    End Property
    Public Property Spare5() As String
        Get
            Return Nothing
        End Get
        Set(ByVal value As String)

        End Set
    End Property
    Public Property Receipt() As Boolean
        Get
            Return ddlVATReceipt.SelectedValue >= 0
        End Get
        Set(ByVal value As Boolean)
            If value = False Then
                ddlVATReceipt.SelectedValue = -1
            End If
        End Set
    End Property
    Public Property ErrorText() As String
        Get
            Return ""
        End Get
        Set(ByVal value As String)
            ErrorLbl.Text = value
        End Set
    End Property
    Public Property Taxable() As Boolean
        Get
            Return False
        End Get
        Set(ByVal value As Boolean)
           
        End Set
    End Property

    Public Function ValidateForm(ByVal userId As Integer) As Boolean
        If tbDesc.Text = "" Then
            ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("Description.Error", LocalResourceFile)
            Return False
        End If
        Try
            Dim theDate As Date = dtDate.Text
            If theDate > Today Then
                ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("OldDate.Error", LocalResourceFile)
                Return False
            End If
        Catch ex As Exception
            ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("Date.Error", LocalResourceFile)
            Return False
        End Try

        Try
            Dim theAmount As Double = Double.Parse(tbAmount.Text, New CultureInfo("en-US").NumberFormat)
            If Amount <= 0 Then
                ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("Amount.Error", LocalResourceFile)
                Return False
            End If
            If ddlVATReceipt.SelectedValue = "-1" And theAmount > CDbl(hfNoReceiptLimit.Value) Then
                ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("AmountRec.Error", LocalResourceFile).Replace("[LIMIT]", StaffBrokerFunctions.GetSetting("Currency", PortalId) & hfNoReceiptLimit.Value)
                ddlVATReceipt.SelectedValue = 1
                Return False
            End If
        Catch ex As Exception
            ErrorLbl.Text = DotNetNuke.Services.Localization.Localization.GetString("Amount.Error", LocalResourceFile)
            Return False
        End Try
        ErrorLbl.Text = ""
        Return True
    End Function

End Class


