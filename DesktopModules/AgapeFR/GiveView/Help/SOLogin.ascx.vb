Imports DotNetNuke
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Math
Imports System.Net
Imports System.IO
Imports System.Text
Imports System.Net.Mail
Imports System.Collections.Specialized
Imports System.Linq
'Imports AgapeStaff

Namespace DotNetNuke.Modules.AgapeFR.GiveView

    Partial Class SOLogin
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not UserId = -1 Then
                Response.Redirect(EditUrl("HelloWorld"))
            End If
        End Sub

        Protected Sub btnSOContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSOContinue.Click
            Response.Redirect("http://localhost:18967/casLogin/tabid/81/language/en-US/Default.aspx?returnurl=%2ffrGiveList%2ffrGiveView%2ftabid%2f172%2fctl%2fSOLogin%2fmid%2f518%2flanguage%2fen-US%2fDefault.aspx")
            'Response.Redirect("http://trentandtara.com")
        End Sub
    End Class
End Namespace