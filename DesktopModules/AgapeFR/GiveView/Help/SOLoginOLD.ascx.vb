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
'Imports AgapeStaff

Namespace DotNetNuke.Modules.AgapeFR.GiveView

    Partial Class SOLogin
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not UserId = -1 Then
                Response.Redirect(EditUrl("SO"))
            End If
            If Not Page.IsPostBack Then
                'Dim d As New DNNProfileDataContextDataContext
                'Dim q = From c In d.Lists Where c.ListName = "PreferredTeam" Order By c.SortOrder Select c.Text, c.Value
                'ddlPrefTeam.DataSource = q
                ddlPrefTeam.DataTextField = "Text"
                ddlPrefTeam.DataValueField = "Value"
                ddlPrefTeam.DataBind()
            End If
        End Sub

        Protected Sub btnSOContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSOContinue.Click

            Dim UserName = tbUsernameLgn.Text
            Dim Password = tbPasswordLgn.Text

            Dim LoginStatus As New DotNetNuke.Security.Membership.UserLoginStatus
            Dim User = UserController.UserLogin(PortalId, UserName, Password, "", "", "", LoginStatus, False)
            If LoginStatus = Security.Membership.UserLoginStatus.LOGIN_SUCCESS Or LoginStatus = Security.Membership.UserLoginStatus.LOGIN_SUPERUSER Or LoginStatus = Security.Membership.UserLoginStatus.LOGIN_INSECUREADMINPASSWORD Or LoginStatus = Security.Membership.UserLoginStatus.LOGIN_INSECUREHOSTPASSWORD Then

                'need to check for an address 

                'If User.Profile.GetPropertyValue("Street") = "" Or User.Profile.GetPropertyValue("PostalCode") = "" Then
                '    'Need to get address info
                '    Response.Redirect(NavigateURL() & "?test=helloworld")
                'End If

                Response.Redirect(EditUrl("SO"))


            Else
                'Dim ErrorLbl As Label = e.Item.FindControl("LoginError")
                lblLoginError.Visible = True
            End If
        End Sub

        Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRegister.Click


            If tbPassword1.Text <> tbPassword2.Text Then
                lblRegisterError.Text = "Passwords do not match"
                lblRegisterError.Visible = True
                Return
            End If
            If UserController.ValidatePassword(tbPassword1.Text) = False Then
                lblRegisterError.Text = "Invalid Password"
                lblRegisterError.Visible = True
                Return
            End If



            Dim objUserInfo As New UserInfo()
            objUserInfo.FirstName = tbFirstName.Text
            objUserInfo.LastName = tbLastName.Text
            objUserInfo.DisplayName = tbFirstName.Text & " " & tbLastName.Text
            objUserInfo.Username = tbUserName.Text
            objUserInfo.PortalID = PortalId
            objUserInfo.Membership.Password = tbPassword1.Text

            objUserInfo.Email = tbEmail.Text
            Dim objUserCreateStatus = UserController.CreateUser(objUserInfo)
            If objUserCreateStatus = Security.Membership.UserCreateStatus.Success Then
                UserController.UserLogin(PortalSettings.PortalId, objUserInfo, PortalSettings.PortalName, DotNetNuke.Services.Authentication.AuthenticationLoginBase.GetIPAddress(), False)

                SetProfileProperty("ENews", objUserInfo.UserID, IIf(cbENews.Checked, "True", "False"))
                SetProfileProperty("MoveMailing", objUserInfo.UserID, IIf(cbMove.Checked, "True", "False"))

                SetProfileProperty("PreferredTeam", objUserInfo.UserID, ddlPrefTeam.SelectedValue)
                SetProfileProperty("Street", objUserInfo.UserID, tbAddress1.Text)
                SetProfileProperty("Unit", objUserInfo.UserID, tbAddress2.Text)
                SetProfileProperty("County", objUserInfo.UserID, tbCounty.Text)
                SetProfileProperty("City", objUserInfo.UserID, tbCity.Text)
                SetProfileProperty("PostalCode", objUserInfo.UserID, tbPostCode.Text)
                SetProfileProperty("Title", objUserInfo.UserID, tbTitle.Text)

                Response.Redirect(EditUrl("SO"))
            Else
                lblRegisterError.Text = "Unable to create account: " & objUserCreateStatus.ToString
                lblRegisterError.Visible = True
            End If

        End Sub
        Private Sub SetProfileProperty(ByVal PropertyName As String, ByVal UserId As Integer, ByVal Value As String)
            'Dim p As New DNNProfile.DNNProfileDataContextDataContext

            'Dim Prop = From c In p.UserProfiles Where c.ProfilePropertyDefinition.PropertyName = PropertyName And c.ProfilePropertyDefinition.PortalID = 0 And c.UserID = UserId Select c
            'Response.Write(Prop.Count)
            'If Prop.Count > 0 Then
            'Prop.First.PropertyValue = Value

            'Else
            'Dim insert As New DNNProfile.UserProfile()
            'insert.UserID = UserId
            'insert.PropertyDefinitionID = (From c In p.ProfilePropertyDefinitions Where c.PropertyName = PropertyName And c.PortalID = 0 Select c.PropertyDefinitionID).First
            'insert.PropertyValue = Value
            'insert.Visibility = 2
            'insert.LastUpdatedDate = Now
            'p.UserProfiles.InsertOnSubmit(insert)

            'End If
            'p.SubmitChanges()
        End Sub
    End Class
End Namespace
