Namespace DotNetNuke.Modules.AgapePortal
    Partial Class CasLoginTitle
        Inherits Entities.Modules.PortalModuleBase

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            'Check if login is part of a specific process
            Dim process = Me.Request.Params("process")

            Select Case process
                Case LoginType.CartCheckout : LblTitle.Text = Localization.GetString("LblTitleCartCheckout", LocalResourceFile) 'Cart checkout process
                Case Else : LblTitle.Text = Localization.GetString("LblTitleDefault", LocalResourceFile) 'Default 
            End Select

        End Sub

    End Class
End Namespace
