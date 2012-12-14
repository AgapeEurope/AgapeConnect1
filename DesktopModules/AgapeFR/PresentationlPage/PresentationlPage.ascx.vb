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
Imports System.Net
Imports System.IO
Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeFR.PresentationlPage
    Partial Class PresentationlPage

        Inherits Entities.Modules.PortalModuleBase


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            'dtStartDate.Text = defDate

            If Request.QueryString("giveto") <> "" Then
                'pnlStandingOrder.Visible = True
                Dim dBroke As New StaffBrokerDataContext
                '  Dim d As New AgapeStaff.AgapeStaffDataContext
                Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.AP_StaffBroker_StaffProfiles.Where(Function(p) (p.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "GivingShortcut")).First.PropertyValue = Request.QueryString("giveto"))
                'Dim staff = From c In d.Agape_Staff_Finances Where c.GivingShortcut = Request.QueryString("giveto")


                'first try staff
                '  Dim staff = From c In d.UserProfiles Where c.ProfilePropertyDefinition.PropertyName = "GivingShortcut" And c.PropertyValue = Request.QueryString("giveto")
                If staff.Count > 0 Then
                    'Detect if UnNamed - if so use giving shortcut instead
                    If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                        Title.Text = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
                    Else
                        Title.Text = ConvertDisplayToSensible(staff.First.DisplayName)
                        hfUserId1.Value = staff.First.UserId1
                    End If
                    'Determine if this staff member can receive donations, show button
                    btnGive.Visible = False
                    Dim IncList() As String = {"National Staff", "National Staff, Overseas"}
                    If IncList.Contains(staff.First.AP_StaffBroker_StaffType.Name) Then
                        btnGive.Visible = True
                    End If
                    'Determine if the user logged in is a staff member viewing their own page, show button
                    Dim nowUser As UserInfo = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo
                    btnEditProfile.Visible = False


                    If UserInfo.UserID = staff.First.UserId1 Or UserInfo.UserID = staff.First.UserId2 Then
                        btnEditProfile.Visible = True
                    End If
                    theImage1.ImageUrl = StaffBrokerFunctions.GetStaffJointPhoto(staff.First.StaffId)

                    'Dim spouseId = From c In d.Agape_StaffWeb_Families Where c.UserId1 = staff.First.UserID Or c.UserId2 = staff.First.UserID Select c.UserId1, c.UserId2
                    'If spouseId.Count > 0 Then
                    '    If spouseId.First.UserId2 >= 0 Then
                    '        If staff.First.UserID = spouseId.First.UserId1 Then
                    '            Dim spouseName = From c In d.Users Where c.UserID = spouseId.First.UserId2 Select c.FirstName
                    '            If spouseName.Count > 0 Then
                    '                Title.Text = staff.First.User.FirstName & " & " & spouseName.First & " " & staff.First.User.LastName
                    '            End If

                    '        Else
                    '            Dim spouseName = From c In d.Users Where c.UserID = spouseId.First.UserId1 Select c.FirstName
                    '            If spouseName.Count > 0 Then
                    '                Title.Text = staff.First.User.FirstName & " & " & spouseName.First & " " & staff.First.User.LastName
                    '            End If
                    '        End If
                    '    Else
                    '        Title.Text = staff.First.User.FirstName & " " & staff.First.User.LastName
                    '    End If
                    'Else
                    '    Title.Text = staff.First.User.FirstName & " " & staff.First.User.LastName
                    'End If
                    Dim GiveText = GetStaffProfileProperty(staff.First.StaffId, "GivingText")

                    'Dim givetext = From c In d.UserProfiles Where c.UserID = staff.First.UserID And c.ProfilePropertyDefinition.PropertyName = "GivingText" Select c.PropertyValue

                    If GiveText = "" Then
                        GiveTextLbl.Text = "Each Agapé staff member develops a support team who regularly pray " _
                   & "for them, encourage them, and give financially towards their salary and the " _
                   & "expenses of their work.  <br /><br />Would you like to give a financial gift to support " _
                   & "the work of this staff member?"
                    Else
                        GiveTextLbl.Text = Server.HtmlDecode(GiveText)
                    End If

                    RowId.Value = staff.First.StaffId


                    'givetoName.Text = Title.Text
                    DonationType.Value = "Staff"

                    Return
                End If

                'Second Try Department/Ministry
                ' Dim ResDC As New ResourcesDataContext
                Dim Dept = From c In dBroke.AP_StaffBroker_Departments Where c.GivingShortcut = Request.QueryString("giveto")
                'Dim Dept = From c In ResDC.Agape_Main_AvailableCostCentres Where c.GivingShortcut = Request.QueryString("giveto")
                If Dept.Count > 0 Then
                    Title.Text = Dept.First.Name
                    'givetoName.Text = Title.Text
                    GiveTextLbl.Text = Server.HtmlDecode(Dept.First.GivingText)
                    DonationType.Value = "Dept"
                    RowId.Value = Dept.First.CostCenterId
                    btnEditProfile.Visible = False
                    theImage1.Visible = False
                    Return

                Else
                    badquery()
                End If
                'Third Try Appeal
                'Dim Appeal = From c In FullDC.Agape_Main_Appeals Where c.GivingShortcut = Request.QueryString("giveto")
                'If Appeal.Count > 0 Then
                '    Title.Text = Appeal.First.AppealName
                '    theImage1.Visible = False
                '    givetoName.Text = Title.Text
                '    GiveTextLbl.Text = Server.HtmlDecode(Appeal.First.GivingText)
                '    DonationType.Value = "Appeal"
                '    RowId.Value = Appeal.First.AppealId
                '    Return
                'End If
                'Fourth Try Project
                'Dim project = From c In d.Agape_Main_Projects Where c.GivingShortcut = Request.QueryString("giveto")
                'If project.Count > 0 Then
                '    If Not Page.IsPostBack Then
                '        ddlProjectMembers.DataSource = From c In project.First.Agape_Main_Projectees Where c.Active Order By c.DisplayName Select c.DisplayName, c.ProjecteeId
                '        ddlProjectMembers.DataTextField = "DisplayName"
                '        ddlProjectMembers.DataValueField = "ProjecteeId"
                '        ddlProjectMembers.DataBind()
                '    End If
                '    Dim r = From c In project.First.Agape_Main_Projectees Where c.Active
                '    If r.Count = 0 Then
                '        lblNoProjectees.Text = "There is currently no-one registered to go on this summer project so you can't donate to anyone. Please check back for more information later."
                '        lblProjectee.Visible = False
                '        ddlProjectMembers.Visible = False
                '        pnlAndTheRest.Visible = False
                '    End If
                '    Title.Text = project.First.ProjectName
                '    theImage1.Visible = False
                '    DonationType.Value = "Project"
                '    RowId.Value = project.First.ProjectID
                '    GiveTextLbl.Text = Server.HtmlDecode(project.First.Description)
                '    pnlStandingOrder.Visible = False
                '    givetoName.Text = project.First.ProjectName
                '    pnlProjectee.Visible = True
                '    lblFamily.InnerHtml = "** Unfortunately we are unable to claim Gift Aid if you are directly related to this Intern/Projectee."
                '    Return
                'End If
                ' Response.Redirect(NavigateURL(returnTab))
            Else
                badquery()
            End If
            '  End If

        End Sub

        'Protected Sub btnSOContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSOContinue.Click
        '    'Validate
        '    If tbAccNum.Text = "" Or tbSOAmount.Text = "" Or tbSort1.Text = "" Or tbSort2.Text = "" Or tbSort3.Text = "" Then
        '        lblSOError.Text = "Please make sure all of the boxes are filled in."
        '        lblSOError.Visible = True
        '    Else
        '        'Create the SO
        '        lblSOError.Visible = False
        '        Session("SortCode") = tbSort1.Text & tbSort2.Text & tbSort3.Text
        '        Session("Amount") = CDbl(tbSOAmount.Text)
        '        Session("Frequency") = CInt(ddlFrequency.SelectedValue)
        '        Session("AccountNo") = tbAccNum.Text
        '        'Session("GiftAid") = IIf(rbSOGA.SelectedValue = 1, True, False)
        '        'Session("Related") = IIf(cbFamily.Checked, True, False)
        '        Session("GiveToType") = CStr(DonationType.Value)
        '        Session("RefId") = CInt(RowId.Value)
        '        Session("StartDate") = CDate(dtStartDate.Text)
        '        Session("SOGUID") = Guid.NewGuid().ToString
        '        Response.Redirect(EditUrl("SOLogin"))
        '    End If

        'End Sub

        Public Function ConvertDisplayToSensible(ByVal CurrentDisp As String) As String
            Dim Output As String = ""

            If CurrentDisp.IndexOf(",") > -1 And CurrentDisp.Contains(",") Then
                Output = CurrentDisp.Substring(CurrentDisp.IndexOf(",") + 2) & " " & CurrentDisp.Substring(0, CurrentDisp.IndexOf(","))
            Else
                Output = CurrentDisp
            End If

            Return Output
        End Function


        Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
            Page.Title = "Agap&eacute; - " & Title.Text
            'Page.Header.InnerHtml = "<link rel=""image_src"" href=""" & & StoryImage.ImageUrl & """ />"

            'CType(Page.Header.FindControl("MetaDescription"), HtmlMeta).Content = Left(FullStoryController.StripTags(GiveTextLbl.Text), 400) & "..."

            'If Not (System.IO.File.Exists(Server.MapPath("/DesktopModules/StaffDirectory/imageCache/img" & CInt(hfUserId1.Value) & ".jpg"))) Then
            '    Dim input As WebRequest = WebRequest.Create(Request.Url.Scheme & "://" & Request.Url.Authority & Request.ApplicationPath & "/DesktopModules/StaffDirectory/GetImage.aspx?UserId=" & hfUserId1.Value & "&size=200")
            '    Dim webResponse As Stream = input.GetResponse().GetResponseStream
            '   Dim original As System.Drawing.Image = Bitmap.FromStream(webResponse)

            '    original.Save(Server.MapPath("/DesktopModules/StaffDirectory/imageCache/img" & CInt(hfUserId1.Value) & ".jpg"), System.Drawing.Imaging.ImageFormat.Jpeg)

            'End If

            'Dim meta As New HtmlMeta
            'meta.Name = "og:image"
            'meta.Content = "http://www.agape.org.uk/DesktopModules/StaffDirectory/imageCache/img" & CInt(hfUserId1.Value) & ".jpg"

            'Page.Header.Controls.AddAt(0, meta)

        End Sub

        Protected Sub badquery()
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveList")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID))
                End If
            End If
        End Sub

        Protected Sub btnEditProfile_Click(sender As Object, e As System.EventArgs) Handles btnEditProfile.Click
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "acEditStaffProfile")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?tab=3")
                End If
            End If
        End Sub

        Protected Sub btnGive_Click(sender As Object, e As System.EventArgs) Handles btnGive.Click
            Dim shortcut = Request.QueryString("giveto")
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveView")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?giveto=" & shortcut)
                End If
            End If
        End Sub
    End Class

End Namespace