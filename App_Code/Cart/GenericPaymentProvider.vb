
Namespace DotNetNuke.Modules.AgapeFR.Cart.Payment

    ''' <summary>
    ''' Generic payment provider control to inherite from for any payment control
    ''' </summary>
    ''' <remarks></remarks>
    Public MustInherit Class GenericPaymentProvider
        Inherits Entities.Modules.PortalModuleBase

#Region "Properties and constants"

        'Cart ID
        ReadOnly Property TheCartID As Integer
            Get
                Dim obj = Session("TheCartID")
                If obj Is Nothing Then
                    Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value
                    obj = CartFunctions.GetCartID(UserId, anonCookieValue)
                    Session("TheCartID") = obj
                End If
                Return obj
            End Get
        End Property

        'Amount to pay for
        Public Const AmountPropertyName As String = "OrderAmount"
        Protected _Amount As Double = 0.0
        ReadOnly Property Amount() As Double
            Get
                If _Amount.Equals(0.0) Then
                    _Amount = CartFunctions.GetCartTotals(TheCartID).GrandTotal
                End If
                Return _Amount
            End Get
        End Property

        'The order ID
        Public Const OrderIdPropertyName As String = "OrderId"
        ReadOnly Property OrderId() As String
            Get
                Return TheCartID
            End Get
        End Property

        'Type of call: Request or Response
        Public Const CallTypeRequest As String = "Request"
        Public Const CallTypeResponse As String = "Response"
        Public Const CallTypeParamKey As String = "CallType"
        ReadOnly Property CallType() As String
            Get
                Return IIf(String.IsNullOrEmpty(Request.Params(CallTypeParamKey)), CallTypeRequest, Request.Params(CallTypeParamKey))
            End Get
        End Property

        'Name of initialization method
        Public Const InitializeMethodName As String = "Initialize"

        'URL to return to after processing the payment
        Public Const ReturnURLPropertyName As String = "PaymentReturnURL"
        Protected _PaymentReturnURL As String
        Public Property PaymentReturnURL() As String
            Get
                Return _PaymentReturnURL
            End Get
            Set(ByVal value As String)
                _PaymentReturnURL = value
            End Set
        End Property

#End Region

#Region "Methods"

        'Initialization of the control
        Public MustOverride Sub Initialize()

#End Region

    End Class

End Namespace