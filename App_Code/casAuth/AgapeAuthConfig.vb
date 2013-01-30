Namespace DotNetNuke.Modules.AgapeFR.Authentication

    <Serializable()> _
    Public Class AgapeAuthConfig
#Region "Private Members"

        Private _Enabled As Boolean = True
        Private _portalId As Integer

        Private Const CACHEKEY As String = "Authentication.Agape"
        Private Const ENABLED_SETTING_KEY As String = "AgapeAuth_Enabled"

#End Region

#Region "Constructor(s)"

        Protected Sub New(ByVal portalID As Integer)
            _portalId = portalID

            Try
                Dim setting As String = Null.NullString
                If PortalController.GetPortalSettingsDictionary(portalID).TryGetValue(ENABLED_SETTING_KEY, setting) Then
                    _Enabled = Boolean.Parse(setting)
                End If
                setting = Null.NullString
            Catch
            End Try
        End Sub

#End Region

#Region "Public Properties"

        Public Property Enabled() As Boolean
            Get
                Return _Enabled
            End Get
            Set(ByVal value As Boolean)
                _Enabled = value
            End Set
        End Property

        <Browsable(False)> _
        Public Property PortalId() As Integer
            Get
                Return _portalId
            End Get
            Set(ByVal Value As Integer)
                _portalId = Value
            End Set
        End Property
#End Region

#Region "Public SHared Methods"

        Public Shared Sub ClearConfig(ByVal portalId As Integer)
            Dim key As String = CACHEKEY + "_" + portalId.ToString()
            DataCache.RemoveCache(key)
        End Sub

        Public Shared Function GetConfig(ByVal portalId As Integer) As AgapeAuthConfig

            Dim key As String = CACHEKEY + "_" + portalId.ToString()
            Dim config As AgapeAuthConfig = CType(DataCache.GetCache(key), AgapeAuthConfig)

            If config Is Nothing Then
                config = New AgapeAuthConfig(portalId)
                DataCache.SetCache(key, config)
            End If
            Return config
        End Function

        Public Shared Sub UpdateConfig(ByVal config As AgapeAuthConfig)
            PortalController.UpdatePortalSetting(config.PortalId, ENABLED_SETTING_KEY, config.Enabled.ToString())
            ClearConfig(config.PortalId)
        End Sub

#End Region

    End Class

End Namespace

