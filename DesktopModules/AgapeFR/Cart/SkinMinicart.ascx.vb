
Namespace DotNetNuke.UI.Skins.Controls.Agape

    Public MustInherit Class SkinMinicart
        Inherits UI.Skins.SkinObjectBase

#Region "Properties"

        'Cart ID
        Protected Property TheCartID As Integer
            Get
                Dim obj = Session("TheCartID")
                If obj Is Nothing Then
                    Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value
                    Dim userID = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo().UserID
                    obj = CartFunctions.GetCartID(userID, anonCookieValue)
                End If
                Return obj
            End Get
            Private Set(ByVal value As Integer)
                Session("TheCartID") = value
            End Set
        End Property

#End Region

#Region "Event Handlers"

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

            Dim theCartTotals As CartFunctions.CartTotals = CartFunctions.GetCartTotals(TheCartID)

            'LblMinicartText.Text = Translate("Cart")
            LblMinicartText.Text = theCartTotals.ItemCount
        End Sub

        Protected Sub BtnCart_Click(sender As Object, e As EventArgs) Handles BtnCart.Click
            'Init link to cart page
            Dim cartPageLink As String = ""
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalController.GetCurrentPortalSettings().PortalId, "frCart")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    cartPageLink = (NavigateURL(x.TabID))
                End If
            End If

            If (Not String.IsNullOrEmpty(cartPageLink)) Then
                Response.Redirect(cartPageLink)
            End If
        End Sub

#End Region

        Public Function Translate(ByVal ResourceString As String) As String
            ' Use shared resource file
            'DAVID: Cart - Use Jon's translation code
            Dim localResourceFile As String = ApplicationPath + "/DesktopModules/AgapeFR/Cart/App_LocalResources/CartSharedResources.resx"

            Return DotNetNuke.Services.Localization.Localization.GetString(ResourceString & ".Text", LocalResourceFile)

        End Function

    End Class
End Namespace
