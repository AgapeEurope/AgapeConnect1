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

Imports GR_NET
Imports gr_mapping
Namespace DotNetNuke.Modules.AgapeConnect
    Partial Class GlobalProfile
        Inherits Entities.Modules.PortalModuleBase



        Public filters As String = ""
        Dim gr As GR

        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            gr = New GR(StaffBrokerFunctions.GetSetting("gr_api_key", PortalId), "http://192.168.2.1:3000/")

            Dim ministries = gr.GetEntities("ministry", "")

        End Sub


        Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

            filters = ""
            If Not String.IsNullOrEmpty(tbFirstNameSearch.Text) Then
                filters &= "&filters[first_name]=" & tbFirstNameSearch.Text
            End If
            If Not String.IsNullOrEmpty(tbLastNameSearch.Text) Then
                filters &= "&filters[last_name]=" & tbLastNameSearch.Text
            End If
           
            If Not String.IsNullOrEmpty(tbEmailSearch.Text) Then
                filters &= "&filters[email_address][email]=" & tbEmailSearch.Text
            End If
            If Not String.IsNullOrEmpty(tbAdvancedSearch.Text) Then
                filters &= "&" & tbAdvancedSearch.Text
            End If
            Dim people = gr.GetEntities("person", filters)
            rpResults.DataSource = From c In people Select FirstName = c.GetPropertyValue("first_name"), LastName = c.GetPropertyValue("last_name"), c.ID

            rpResults.DataBind()
            lblTest.Text = people.First.ToJson()
            'Session("gr_user_results") = people

        End Sub
    End Class
End Namespace
