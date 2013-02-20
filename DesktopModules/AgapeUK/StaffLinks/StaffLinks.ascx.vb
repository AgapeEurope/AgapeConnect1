Imports DotNetNuke.UI.Skins
Imports System.Linq
Imports UK.StaffLink

Namespace DotNetNuke.UI.Skins.Controls
    Public MustInherit Class StaffLinks
        Inherits DotNetNuke.UI.Skins.SkinObjectBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        End Sub
        Public Function whatTarget(ByVal yesNo As Boolean) As String
            Dim out As String = "_self"

            If yesNo Then
                out = "_blank"
            End If

            Return out
        End Function
    End Class
End Namespace
