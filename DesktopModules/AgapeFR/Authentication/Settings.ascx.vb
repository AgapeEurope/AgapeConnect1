Namespace DotNetNuke.Modules.AgapeFR.Authentication

    ''' -----------------------------------------------------------------------------
    ''' <summary>
    ''' Manages the core DNN Authentication settings
    ''' </summary>
    ''' -----------------------------------------------------------------------------
    Partial Class Settings
        Inherits DotNetNuke.Services.Authentication.AuthenticationSettingsBase


        Public Overrides Sub UpdateSettings()
            If SettingsEditor.IsValid AndAlso SettingsEditor.IsDirty Then
                Dim config As AgapeAuthConfig = CType(SettingsEditor.DataSource, AgapeAuthConfig)
                AgapeAuthConfig.UpdateConfig(config)
            End If
        End Sub

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            Try
                Dim config As AgapeAuthConfig = AgapeAuthConfig.GetConfig(PortalId)

                SettingsEditor.DataSource = config
                SettingsEditor.DataBind()

            Catch exc As Exception
                Exceptions.ProcessModuleLoadException(Me, exc)
            End Try

        End Sub
    End Class

End Namespace

