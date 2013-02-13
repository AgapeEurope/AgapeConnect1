Imports DotNetNuke

Namespace DotNetNuke.Modules.AgapeFR.Cart
    Partial Class CartLogin
        Inherits Entities.Modules.PortalModuleBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            ' Init shared resource file
            LocalResourceFile = ApplicationPath + "/DesktopModules/AgapeFR/Cart/App_LocalResources/CartSharedResources.resx"

            'If user already connected => redirect to cart summary page
            If Not UserId = -1 Then
                Response.Redirect(EditUrl("CartSummary"))
            End If
        End Sub

   
    End Class
End Namespace

