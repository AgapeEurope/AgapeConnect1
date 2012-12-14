
Partial Class DesktopModules_Give_SOInstructions
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblAmount.Text = Request.QueryString("Amount")
        lblFreq.Text = Request.QueryString("Freq")
        lblReference.Text = Request.QueryString("Ref")

    End Sub
End Class
