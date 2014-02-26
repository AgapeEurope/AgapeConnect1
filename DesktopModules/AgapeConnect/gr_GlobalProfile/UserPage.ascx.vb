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
    Partial Class gr_mapping_mod
        Inherits Entities.Modules.PortalModuleBase




       
        
        Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then

                LoadForm()
               
            End If
        End Sub
        Private Sub LoadForm()
            Dim gr As GR = New GR(StaffBrokerFunctions.GetSetting("gr_api_key", PortalId), "http://192.168.2.1:3000/")

            Dim thisUser = gr.GetEntity(Request.QueryString("id"))
            Session("gr_user") = thisUser
            If Not thisUser Is Nothing Then

                tbFirstName.Text = thisUser.GetPropertyValue("first_name")
                tbLastName.Text = thisUser.GetPropertyValue("last_name")
                lblTitle.Text = tbLastName.Text & ", " & tbFirstName.Text
                tbEmail.Text = thisUser.GetPropertyValue("email_address.email")
                tbAddress1.Text = thisUser.GetPropertyValue("address.line1")
                tbAddress2.Text = thisUser.GetPropertyValue("address.line2")
                tbCity.Text = thisUser.GetPropertyValue("address.city")
                tbState.Text = thisUser.GetPropertyValue("address.state")
                tbPostalCode.Text = thisUser.GetPropertyValue("address.postal_code")
                tbCountry.Text = thisUser.GetPropertyValue("address.country")



            End If
        End Sub

        Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            Dim thisUser As Entity = Session("gr_user")
            Dim GR = New GR(StaffBrokerFunctions.GetSetting("gr_api_key", PortalId), "http://192.168.2.1:3000/")


            If Not thisUser Is Nothing Then
                Dim person As New Entity()
                person.ID = thisUser.ID
                If tbFirstName.Text <> thisUser.GetPropertyValue("first_name") Then
                    person.AddPropertyValue("first_name", tbFirstName.Text)
                End If
                If tbLastName.Text <> thisUser.GetPropertyValue("last_name") Then
                    person.AddPropertyValue("last_name", tbFirstName.Text)
                End If
                If tbEmail.Text <> thisUser.GetPropertyValue("email_address.email") Then
                    person.AddPropertyValue("email_address.email", tbEmail.Text)
                End If

                If tbAddress1.Text <> thisUser.GetPropertyValue("address.line1") Then
                    person.AddPropertyValue("address.line1", tbAddress1.Text)
                End If
                If tbAddress2.Text <> thisUser.GetPropertyValue("address.line2") Then
                    person.AddPropertyValue("address.line2", tbAddress2.Text)
                End If
                If tbCity.Text <> thisUser.GetPropertyValue("address.city") Then
                    person.AddPropertyValue("address.city", tbCity.Text)
                End If
                If tbState.Text <> thisUser.GetPropertyValue("address.state") Then
                    person.AddPropertyValue("address.state", tbState.Text)
                End If
                If tbPostalCode.Text <> thisUser.GetPropertyValue("address.portal_code") Then
                    person.AddPropertyValue("address.postal_code", tbPostalCode.Text)
                End If
                If tbCountry.Text <> thisUser.GetPropertyValue("address.country") Then
                    person.AddPropertyValue("address.country", tbCountry.Text)
                End If

                Dim resp = GR.UpdateEntity(person, "person")
                ' Response.Redirect(EditUrl() & "?id=" & Request.QueryString("id"))
                LoadForm()
            End If
        End Sub
    End Class
End Namespace
