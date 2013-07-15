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
Imports System.IO
Imports System.Net
Imports DotNetNuke
Imports DotNetNuke.Security

'Imports AgapeStaff
Imports StaffBroker
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class mpdItem
        Inherits Entities.Modules.PortalModuleBase


        'Public Property Amount() As Double
        '    Get
        '        Return Double.Parse(tbAmount.Text, New CultureInfo("en-US").NumberFormat)
        '    End Get
        '    Set(ByVal value As Double)
        '        tbAmount.Text = value.ToString("n2", New CultureInfo("en-US"))
        '    End Set
        'End Property



        Public Property Monthly() As String
            Get
                Return tbMonthly.Text


            End Get
            Set(ByVal value As String)

                If (value <> "") Then
                    tbYearly.Text = (12 * CDbl(value)).ToString("n2", New CultureInfo("en-US"))
                    tbMonthly.Text = CDbl(value).ToString("n2", New CultureInfo("en-US"))
                End If


            End Set
        End Property

        Private _mode As String
        Public Property Mode() As String
            Get
                Return _mode
            End Get
            Set(ByVal value As String)
                _mode = value
                If value.Contains("MONTH") Then
                    tbMonthly.Enabled = True
                ElseIf value.Contains("YEAR") Then
                    tbYearly.Enabled = True
                ElseIf value.Contains("CALCULATED") Then
                    tbMonthly.Attributes("class") &= " calculated"

                End If

                If value.Contains("NET") Then
                    pnlNetTax.Visible = True
                    pnlNetTax2.Visible = True
                    tbMonthly.Attributes("class") &= " net"
                    tbYearly.Attributes("class") &= " net"
                End If


            End Set
        End Property

        Private _formula As String
        Public Property Formula() As String
            Get
                Return _formula
            End Get
            Set(ByVal value As String)
                _formula = value
                hfFormula.Value = value
            End Set
        End Property


        Public Property Yearly() As String
            Get
                Return tbYearly.Text
                'Return Double.Parse(tbYearly.Text, New CultureInfo("en-US").NumberFormat)
            End Get
            Set(ByVal value As String)

                If (value <> "") Then
                    tbMonthly.Text = (CDbl(value) / 12).ToString("n2", New CultureInfo("en-US"))
                    tbYearly.Text = CDbl(value).ToString("n2", New CultureInfo("en-US"))
                End If

            End Set
        End Property

        Public Property IsCurrentSupport() As Boolean
            Get
                Return False
            End Get
            Set(ByVal value As Boolean)
                If value = True Then

                    tbMonthly.Attributes("class") &= " currentSupport"
                   
                    tbYearly.Attributes("style") = "display: none"
                    lblCur2.Visible = False

                End If

            End Set
        End Property
        Public Property ItemName() As String
            Get
                Return lblItemName.Text
            End Get
            Set(ByVal value As String)
                If (value = "") Then
                    lblItemName.Visible = False
                    tbEventName.Visible = True
                Else
                    lblItemName.Text = value
                End If

            End Set
        End Property

        Public Property Help() As String
            Get
                Return lblHelp.Text
            End Get
            Set(ByVal value As String)
                lblHelp.Text = value
            End Set
        End Property
        Public Property ItemId() As String
            Get
                Return lblItemId.Text
            End Get
            Set(ByVal value As String)
                lblItemId.Text = value
            End Set
        End Property

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


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If _mode.Contains("NET_MONTH") Then
                lblCur.Text = "NET"
                lblCur2.Text = "NET"
            Else
                lblCur.Text = StaffBrokerFunctions.GetSetting("Currency", PortalId)
                lblCur2.Text = lblCur.Text

            End If

            btnEdit.Visible = IsEditMode()


        End Sub







        Public Function Translate(ByVal ResourceString As String) As String
            Return DotNetNuke.Services.Localization.Localization.GetString(ResourceString & ".Text", LocalResourceFile)

        End Function





    End Class
End Namespace

