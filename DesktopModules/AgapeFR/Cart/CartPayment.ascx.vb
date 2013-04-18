Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports StaffBrokerFunctions
Imports Cart
Imports ApiPayment
Imports ApiPayment.Web
Imports ApiPayment.Common
Imports System.IO


Namespace DotNetNuke.Modules.AgapeFR.Cart
    Partial Class CartPayment
        Inherits Entities.Modules.PortalModuleBase

#Region "Properties and constants"

        'Path of the control to be loaded (specified in the request when the payment provider calls back the page)
        Protected Const PaymentProviderPathParamKey As String = "PPP"
        Protected ReadOnly Property PaymentProviderPath() As String
            Get
                Return Request.Params(PaymentProviderPathParamKey)
            End Get
        End Property

#End Region

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            ' Make sure no control remains displayed on the page
            PhPaymentMethods.Controls.Clear()

            If Not String.IsNullOrEmpty(PaymentProviderPath) Then
                ' Load requested payment provider
                LoadPaymentProvider(PaymentProviderPath)
            Else
                'TODO: Cart - Load here any other Payment Provider

                ' Load Scellius payment provider
                LoadPaymentProvider("/DesktopModules/AgapeFR/Cart/PaymentProviders/ScelliusPayment.ascx")
            End If
        End Sub

        Protected Sub LoadPaymentProvider(ByVal TheControlPath As String)
            ' Init the control and add it to the placeholder
            Dim theControl As Object = LoadControl(TheControlPath)
            Dim theControlType As Type = theControl.GetType()
            theControl.ID = theControlType.Name
            PhPaymentMethods.Controls.Add(theControl)

            ' Set the control needed properties
            theControlType.GetProperty(Payment.GenericPaymentProvider.ReturnURLPropertyName).SetValue(theControl, EditUrl(PaymentProviderPathParamKey, HttpUtility.UrlEncode(TheControlPath), "CartPayment"), Nothing)

            ' Init the control
            theControlType.GetMethod(Payment.GenericPaymentProvider.InitializeMethodName).Invoke(theControl, Nothing)

        End Sub

    End Class
End Namespace
