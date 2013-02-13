Imports DotNetNuke.Entities.Modules

Namespace DotNetNuke.Modules.AgapeFR.Cart

    ' List of possible steps in the checkout process
    Public Enum CartCheckoutSteps
        Login = 0
        Address = 1
        Summary = 2
        Payment = 3
    End Enum

    Public MustInherit Class CartBreadcrumb
        Inherits PortalModuleBase

#Region "Properties"

        'Step number in the checkout process
        Dim _CartCheckoutStep As CartCheckoutSteps
        Public Property CartCheckoutStep() As CartCheckoutSteps
            Get
                Return _CartCheckoutStep
            End Get
            Set(ByVal Value As CartCheckoutSteps)
                _CartCheckoutStep = Value
            End Set
        End Property

#End Region

#Region "Event Handlers"

        Protected Sub Page_Init(sender As Object, e As EventArgs) Handles MyBase.Init
            'Init translation resource file
            AgapeTranslation.InitLocalResourceFile(Me)
        End Sub

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            'Add the steps to be displayed and set the selected step
            Dim item As String
            For Each item In [Enum].GetNames(GetType(CartCheckoutSteps))
                Dim li As ListItem = New ListItem(LocalizeString(item))
                If String.Equals([Enum].GetName(GetType(CartCheckoutSteps), CartCheckoutStep), item) Then
                    li.Attributes.Add("class", "selected")
                End If
                ListCartBreadcrumb.Items.Add(li)
            Next
            ListCartBreadcrumb.DataBind()
        End Sub

#End Region

    End Class
End Namespace
