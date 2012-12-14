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

#Region "Properties"
        Protected theControl As Object

        'Cart ID
        Public Property TheCartID As Integer
            Get
                Dim obj = Session("TheCartID")
                If obj Is Nothing Then
                    Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value
                    obj = CartFunctions.GetCartID(UserId, anonCookieValue)
                End If
                Return obj
            End Get
            Private Set(ByVal value As Integer)
                Session("TheCartID") = value
            End Set
        End Property

#End Region

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            'If Not Me.IsPostBack Then

            '    ' Make sure no control remains displayed on the page
            '    PhPaymentMethods.Controls.Clear()

            '    ' Create Scellius payment control
            '    theControl = LoadControl("/DesktopModules/AgapeFR/Cart/PaymentProviders/ScelliusPayment.ascx")
            '    theControl.ID = "ScelliusPayment"
            '    PhPaymentMethods.Controls.Add(theControl)

            '    Dim theCartTotals As CartFunctions.CartTotals = CartFunctions.GetCartTotals(TheCartID)

            '    ' Set the control needed properties
            '    Dim theControlType As Type = theControl.GetType()
            '    theControlType.GetProperty(Payment.GenericPaymentProvider.AmountPropertyName).SetValue(theControl, theCartTotals.GrandTotal, Nothing)
            '    theControlType.GetProperty(Payment.GenericPaymentProvider.OrderIdPropertyName).SetValue(theControl, TheCartID.ToString, Nothing)
            '    theControlType.GetProperty(Payment.GenericPaymentProvider.TransactionIdPropertyName).SetValue(theControl, TheCartID.ToString, Nothing)
            '    theControlType.GetProperty(Payment.GenericPaymentProvider.CallTypePropertyName).SetValue(theControl, Request.Params.Get(Payment.GenericPaymentProvider.CallTypeParamKey), Nothing)
            '    theControlType.GetProperty(Payment.GenericPaymentProvider.ReturnURLPropertyName).SetValue(theControl, EditUrl("CartPayment"), Nothing)

            '    ' Init the control
            '    theControlType.GetMethod(Payment.GenericPaymentProvider.InitializeMethodName).Invoke(theControl, Nothing)

            'End If
        End Sub

    End Class
End Namespace
