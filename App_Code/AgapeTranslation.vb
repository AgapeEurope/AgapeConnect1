Imports Microsoft.VisualBasic
Imports DotNetNuke.Entities.Portals.PortalSettings

Public Class AgapeTranslation

    Public Shared Sub [InitLocalResourceFile](Page As Entities.Modules.PortalModuleBase)
        ' Init translation resource file
        Dim FileName As String = System.IO.Path.GetFileNameWithoutExtension(Page.AppRelativeVirtualPath)
        If (Not (Page.ID Is Nothing)) Then
            'this will fix it when its placed as a ChildUserControl 
            Page.LocalResourceFile = Page.LocalResourceFile.Replace(Page.ID, FileName)
        Else
            ' this will fix it when its dynamically loaded using LoadControl method 
            Page.LocalResourceFile = Page.LocalResourceFile & FileName & ".ascx.resx"
            Dim Locale = System.Threading.Thread.CurrentThread.CurrentCulture.Name
            Dim AppLocRes As New System.IO.DirectoryInfo(Page.LocalResourceFile.Replace(FileName & ".ascx.resx", ""))
            If Locale = Page.PortalSettings.CultureCode Then
                'look for portal varient
                If AppLocRes.GetFiles(FileName & ".ascx.Portal-" & Page.PortalSettings.PortalId & ".resx").Count > 0 Then
                    Page.LocalResourceFile = Page.LocalResourceFile.Replace("resx", "Portal-" & Page.PortalSettings.PortalId & ".resx")
                End If
            Else

                If AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".Portal-" & Page.PortalSettings.PortalId & ".resx").Count > 0 Then
                    'lookFor a CulturePortalVarient
                    Page.LocalResourceFile = Page.LocalResourceFile.Replace("resx", Locale & ".Portal-" & Page.PortalSettings.PortalId & ".resx")
                ElseIf AppLocRes.GetFiles(FileName & ".ascx." & Locale & ".resx").Count > 0 Then
                    'look for a CultureVarient
                    Page.LocalResourceFile = Page.LocalResourceFile.Replace("resx", Locale & ".resx")
                ElseIf AppLocRes.GetFiles(FileName & ".ascx.Portal-" & Page.PortalSettings.PortalId & ".resx").Count > 0 Then
                    'lookFor a PortalVarient
                    Page.LocalResourceFile = Page.LocalResourceFile.Replace("resx", "Portal-" & Page.PortalSettings.PortalId & ".resx")
                End If
            End If
        End If
    End Sub

End Class

