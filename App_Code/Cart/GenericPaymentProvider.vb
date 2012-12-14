
Namespace DotNetNuke.Modules.AgapeFR.Cart.Payment

    ' Generic payment provider control to inherite from for any payment control
    Public MustInherit Class GenericPaymentProvider
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase

#Region "Properties and constants"

        'Amount to pay for
        Public Const AmountPropertyName As String = "Amount"
        Protected _Amount As Double
        Property Amount() As Double
            Get
                Return _Amount
            End Get
            Set(ByVal value As Double)
                _Amount = value
            End Set
        End Property

        'The order ID
        Public Const OrderIdPropertyName As String = "OrderId"
        Protected _OrderId As String
        Public Property OrderId() As String
            Get
                Return _OrderId
            End Get
            Set(ByVal value As String)
                _OrderId = value
            End Set
        End Property

        'The payment transaction ID
        Public Const TransactionIdPropertyName As String = "TransactionId"
        Protected _TransactionId As String
        Public Property TransactionId() As String
            Get
                Return _TransactionId
            End Get
            Set(ByVal value As String)
                _TransactionId = value
            End Set
        End Property

        'Type of call to the control (Request or Response for exemple)
        Public Const CallTypePropertyName As String = "CallType"
        Public Const CallTypeParamKey As String = "CallType"
        Protected _CallType As String
        Public Property CallType() As String
            Get
                Return _CallType
            End Get
            Set(ByVal value As String)
                _CallType = value
            End Set
        End Property

        'URL to return to after processing the payment
        Public Const ReturnURLPropertyName As String = "ReturnURL"
        Protected _ReturnURL As String
        Public Property ReturnURL() As String
            Get
                Return _ReturnURL
            End Get
            Set(ByVal value As String)
                _ReturnURL = value
            End Set
        End Property

        'Name of initialization method
        Public Const InitializeMethodName As String = "Initialize"

#End Region

#Region "Methods"

        'Initialization of the control
        Public MustOverride Sub Initialize()

#End Region

    End Class

End Namespace