Imports DotNetNuke
Imports System.Web.UI
Imports System.Linq


Namespace DotNetNuke.Modules.AgapeFR.Cart

    Partial Class CartSettings
        Inherits Entities.Modules.ModuleSettingsBase

#Region "Base Method Implementations"

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            Try

                If (Page.IsPostBack = False) Then

                    If CType(TabModuleSettings("EnableVAT"), String) <> "" Then
                        cbEnableVAT.Checked = CType(TabModuleSettings("EnableVAT"), Boolean)
                    End If

                End If

            Catch exc As Exception           'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try

        End Sub

#End Region

        'TODO Cart: Add settings for VAT rate, shipping costs...

        Protected Sub SaveBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaveBtn.Click

            Dim objModules As New Entities.Modules.ModuleController
            objModules.UpdateTabModuleSetting(TabModuleId, "EnableVAT", cbEnableVAT.Checked)
            ' refresh cache
            Entities.Modules.ModuleController.SynchronizeModule(TabModuleId)
            Response.Redirect(NavigateURL())

        End Sub


        Protected Sub CancelBtn_Click(sender As Object, e As System.EventArgs) Handles CancelBtn.Click
            Response.Redirect(NavigateURL())
        End Sub
    End Class

End Namespace

