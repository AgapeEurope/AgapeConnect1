Imports DotNetNuke
Imports System.Web.UI
Imports System.Linq

Imports StaffRmb



Namespace DotNetNuke.Modules.Account

    Partial Class AccountSettings
        Inherits Entities.Modules.ModuleSettingsBase

#Region "Base Method Implementations"
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            Try

                hfPortalId.Value = PortalId
                If (Page.IsPostBack = False) Then



                    If CType(TabModuleSettings("ReportsTo"), String) <> "" Then
                        cbReportsTo.Checked = CType(TabModuleSettings("ReportsTo"), Boolean)

                    End If

                End If



            Catch exc As Exception           'Module failed to load
                ProcessModuleLoadException(Me, exc)
            End Try



        End Sub


#End Region


        Protected Sub SaveBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaveBtn.Click
            Dim objModules As New Entities.Modules.ModuleController
            
            objModules.UpdateTabModuleSetting(TabModuleId, "ReportsTo", cbReportsTo.Checked)

            ' refresh cache
            SynchronizeModule()
            Response.Redirect(NavigateURL())
        End Sub


        Protected Sub CancelBtn_Click(sender As Object, e As System.EventArgs) Handles CancelBtn.Click
            Response.Redirect(NavigateURL())
        End Sub
    End Class

End Namespace

