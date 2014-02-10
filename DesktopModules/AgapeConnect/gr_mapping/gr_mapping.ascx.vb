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

Imports GR_NET.GR.NET
Imports gr_mapping
Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class gr_mapping
        Inherits Entities.Modules.PortalModuleBase




        Dim gr As GR


        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            tbApiKey.Text = StaffBrokerFunctions.GetSetting("gr_api_key", PortalId)

            Dim d As New gr_mappingDataContext
            Dim mappings = From c In d.gr_mappings Where c.PortalId = PortalId

            gvMappings.DataSource = mappings
            gvMappings.DataBind()



            If Not tbApiKey.Text = "" Then
                gr = New GR(tbApiKey.Text, "https://gr.stage.uscm.org/")
                Dim leaves = From c In gr.GetFlatEntityLeafList("person") Select Name = c.GetDotNotation, c.ID Order By Name


                gr_entity_types.DataSource = leaves
                gr_entity_types.DataTextField = "Name"
                gr_entity_types.DataValueField = "ID"
                gr_entity_types.DataBind()
            End If


        End Sub


    End Class
End Namespace
