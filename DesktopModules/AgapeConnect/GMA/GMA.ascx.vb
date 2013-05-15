Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security

Imports StaffBroker

Imports StaffBrokerFunctions
Imports GmaServices

Namespace DotNetNuke.Modules.GMA
    Partial Class GMA
        Inherits Entities.Modules.PortalModuleBase

        'Dim dStaff As New AgapeStaffDataContext
        ' Dim dBroke As New StaffBrokerDataContext
        '  Dim d As New DNNProfileDataContextDataContext
        Private gmaServers As New List(Of gmaServer)

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            If Not Page.IsPostBack Then
                gmaServers.Clear()
                Dim insert As New gmaServer
                insert.name = "AgapeConnect"
               
                insert.URL = "http://gma.agapeconnect.me/index.php"
                Dim gma As New GmaServices(insert.URL, UserInfo.Profile.GetPropertyValue("GCXPGTIOU"))

                insert.nodes = gma.GetUserNodes()
                gmaServers.Add(insert)

              

                hfNodeId.Value = gmaServers.First.nodes.First.nodeId

                rpGmaServers.DataSource = From c In gmaServers Select name = c.name, url = c.URL, nodes = (From b In c.nodes Select shortName = b.shortName, nodeId = b.nodeId)

                rpGmaServers.DataBind()
            End If



        End Sub




      
        

    End Class
End Namespace
