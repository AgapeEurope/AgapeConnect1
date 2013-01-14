Imports DotNetNuke
Imports System.Web.UI
Imports System.Linq
Imports System.ServiceModel.Syndication
Imports System.Xml
Imports System.Net
Imports Stories

Imports DotNetNuke.Services.FileSystem


Namespace DotNetNuke.Modules.Stories

    Partial Class StorySettings
        Inherits Entities.Modules.ModuleSettingsBase

        Dim d As New StoriesDataContext
#Region "Base Method Implementations"

        
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
           

        End Sub

       

#End Region


      
    End Class

End Namespace

