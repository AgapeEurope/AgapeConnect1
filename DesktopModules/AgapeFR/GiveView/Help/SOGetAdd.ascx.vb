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

Imports System.Linq
Imports AgapeStaff






Namespace DotNetNuke.Modules.Give

    Partial Class SOGetAdd
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            
        End Sub



       
        Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRegister.Click
            'UserInfo.Profile.InitialiseProfile(PortalId, True)

            SetProfileProperty("Street", UserId, tbAddress1.Text)
            SetProfileProperty("Unit", UserId, tbAddress2.Text)
            SetProfileProperty("County", UserId, tbCounty.Text)
            SetProfileProperty("City", UserId, tbCity.Text)
            SetProfileProperty("PostalCode", UserId, tbPostCode.Text)


            Response.Redirect(EditUrl("SO"))

        End Sub
        Private Sub SetProfileProperty(ByVal PropertyName As String, ByVal UserId As Integer, ByVal Value As String)
            Dim p As New DNNProfile.DNNProfileDataContextDataContext

            Dim Prop = From c In p.UserProfiles Where c.ProfilePropertyDefinition.PropertyName = PropertyName And c.ProfilePropertyDefinition.PortalID = 0 And c.UserID = UserId Select c
            Response.Write(Prop.Count)
            If Prop.Count > 0 Then
                Prop.First.PropertyValue = Value

            Else
                Dim insert As New DNNProfile.UserProfile()
                insert.UserID = UserId
                insert.PropertyDefinitionID = (From c In p.ProfilePropertyDefinitions Where c.PropertyName = PropertyName And c.PortalID = 0 Select c.PropertyDefinitionID).First
                insert.PropertyValue = Value
                insert.Visibility = 2
                insert.LastUpdatedDate = Now
                p.UserProfiles.InsertOnSubmit(insert)

            End If
            p.SubmitChanges()
        End Sub
    End Class
End Namespace
