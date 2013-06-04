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
Imports System.Xml.Linq
Imports System.Linq

Namespace DotNetNuke.Modules.Portals



    Partial Class Overview
        Inherits Entities.Modules.PortalModuleBase




        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            Dim pc As New DotNetNuke.Entities.Portals.PortalController
            If rblSort.SelectedValue = "PortalId" Then
                gvPortals.DataSource = From c As PortalInfo In pc.GetPortals() Order By c.PortalID


            ElseIf rblSort.SelectedValue = "PortalName" Then
                gvPortals.DataSource = From c As PortalInfo In pc.GetPortals() Order By c.PortalName

            End If
            gvPortals.DataBind()

        End Sub
        Public Function GetAliases(ByVal thePortalId As Integer) As String
            Dim PS As New PortalSettings(thePortalId)
            Return PS.DefaultPortalAlias
        End Function
    End Class
End Namespace
