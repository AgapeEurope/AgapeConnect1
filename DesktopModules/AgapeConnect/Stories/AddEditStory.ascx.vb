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
Imports Stories
Namespace DotNetNuke.Modules.Stories


    Partial Class AddEditStory
        Inherits Entities.Modules.PortalModuleBase


        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            If Settings("Aspect") <> "" Then
                acImage1.Aspect = Double.Parse(Settings("Aspect"), New CultureInfo(""))
            End If




            If Not Page.IsPostBack Then



                Dim mc As New DotNetNuke.Entities.Modules.ModuleController


                Dim allTabs = mc.GetAllTabsModulesByModuleID(ModuleId)

                Dim channels As New Dictionary(Of Integer, String)

                For Each row As DotNetNuke.Entities.Modules.ModuleInfo In allTabs
                    'Check permissions.
                    If DotNetNuke.Security.Permissions.ModulePermissionController.CanEditModuleContent(row) Then
                        Dim name As String = row.ModuleControl.ControlTitle
                        If String.IsNullOrEmpty(name) Then
                            name = row.ParentTab.TabName
                        End If
                        channels.Add(row.TabModuleID, name)
                    End If
                Next

                ddlChannels.DataSource = channels
                ddlChannels.DataTextField = "Value"
                ddlChannels.DataValueField = "Key"
                ddlChannels.DataBind()

                ddlLanguage.DataSource = From c In CultureInfo.GetCultures(CultureTypes.SpecificCultures) Order By c.EnglishName Select Name = c.Name.ToLower, EnglishName = c.EnglishName
                ddlLanguage.DataValueField = "Name"
                ddlLanguage.DataTextField = "EnglishName"
                ddlLanguage.DataBind()



                Dim d As New StoriesDataContext





                If Me.UserInfo.IsSuperUser And IsEditable() Then
                    'SuperPowers.Visible = True
                End If
                PagePanel.Visible = True
                NotFoundLabel.Visible = False
                If Request.QueryString("StoryID") <> "" Then



                    StoryIdHF.Value = Request.QueryString("StoryId")

                    Dim r = (From c In d.AP_Stories Where c.StoryId = Request.QueryString("StoryID")).First

                    If channels.Where(Function(x) x.Key = r.TabModuleId).Count > 0 Then
                        ddlChannels.SelectedValue = r.TabModuleId
                    Else
                        'Look for tab (which you don't have permission for
                        Dim theTab = From c As DotNetNuke.Entities.Modules.ModuleInfo In allTabs Where c.TabModuleID = r.TabModuleId
                        If theTab.Count > 0 Then
                            Dim name As String = theTab.First.ModuleControl.ControlTitle
                            If String.IsNullOrEmpty(name) Then
                                name = theTab.First.ParentTab.TabName
                            End If

                            ddlChannels.Items.Add(New ListItem(r.TabModuleId, name))
                        End If

                        'just use the current tab
                        ddlChannels.SelectedValue = TabModuleId

                    End If




                    Headline.Text = r.Headline
                    ' imgbtnPrint.OnClientClick = "window.open('/DesktopModules/FullStory/PrintStory.aspx?StoryId=" & Request.QueryString("StoryId") & "', '_blank'); "
                    If Me.UserInfo.IsSuperUser Then

                        If Not Page.IsPostBack Then



                            Dim BoostDate As String
                            If r.EditorBoost <= Date.Now Then
                                BoostLabel.Text = "Not currently boosted."
                            Else
                                BoostDate = r.EditorBoost.Value.ToShortDateString()
                                BoostLabel.Text = "Boosted until " & BoostDate
                            End If
                            Editable.Checked = r.Editable

                        End If

                    End If

                    StoryText.Text = r.StoryText
                    Author.Text = r.Author
                    tbLocation.Text = r.Latitude.Value.ToString(New CultureInfo("")) & ", " & r.Longitude.Value.ToString(New CultureInfo(""))

                    StoryDate.Text = r.StoryDate.ToString("dd MMM yyyy")


                    ' Dim thePhoto = DotNetNuke.Services.FileSystem.FileManager.Instance.GetFile(r.PhotoId)
                    '  StoryImage.ImageUrl = DotNetNuke.Services.FileSystem.FileManager.Instance.GetUrl(thePhoto)
                    acImage1.FileId = r.PhotoId
                    PhotoIdHF.Value = r.PhotoId
                    If (From c As ListItem In ddlLanguage.Items Where c.Value = r.Language).Count > 0 Then
                        ddlLanguage.SelectedValue = r.Language
                    Else
                        ddlLanguage.SelectedValue = CultureInfo.CurrentCulture.Name.ToLower
                    End If
                    pnlLanguages.Visible = False
                    If Not String.IsNullOrEmpty(r.TranslationGroup) Then

                        
                        Dim Translist = From c In d.AP_Stories Where c.TranslationGroup = r.TranslationGroup And c.PortalID = r.PortalID And c.StoryId <> r.StoryId Select c.Language, c.StoryId

                        If Translist.Count > 1 Then
                            pnlLanguages.Visible = True
                            dlLanuages.DataSource = Translist
                            dlLanuages.DataBind()

                        End If


                    End If

                Else

                    If String.IsNullOrEmpty(Session("Long")) Or String.IsNullOrEmpty(Session("Lat")) Then
                        Dim ls As New LookupService(Server.MapPath("~/App_Data/GeoLiteCity.dat"), LookupService.GEOIP_STANDARD)
                        ' Dim l As Location = ls.getRegion(Request.ServerVariables("remote_addr"))

                        Dim l As Location = ls.getLocation("80.193.180.102")   '(Solihill)
                        Session("Long") = l.longitude
                        Session("Lat") = l.latitude
                    End If



                    Dim lg As Double = Session("Long")
                    Dim lt As Double = Session("Lat")
                    tbLocation.Text = lt.ToString(New CultureInfo("")) & ", " & lg.ToString(New CultureInfo(""))

                    StoryDate.Text = Today.ToString("dd MMM yyyy")
                    StoryText.Text = "Enter your news here..."

                    Author.Text = UserInfo.DisplayName
                    ddlChannels.SelectedValue = TabModuleId
                    'Headline.Text = CultureInfo.CurrentCulture.TwoLetterISOLanguageName
                    ddlLanguage.SelectedValue = CultureInfo.CurrentCulture.Name.ToLower
                End If

            End If





        End Sub




        Public Function GetLanguageName(ByVal language As String) As String

            Dim thename = CultureInfo.GetCultures(CultureTypes.AllCultures).Where(Function(x) x.Name.ToLower = language.ToLower).Select(Function(x) x.EnglishName & " / " & x.NativeName)
            If thename.Count > 0 Then
                Return thename.First()
            Else
                Return ""
            End If
        End Function

        Public Function GetFlag(ByVal language As String) As String
            If String.IsNullOrEmpty(language) Then
                Return ""
            End If
            If language = "en" Then
                language = "en-GB"

            ElseIf language.Length = 2 Then
                language = language.ToLower & "-" & language.ToUpper

            End If


            Dim flagDir = New DirectoryInfo(Server.MapPath("/images/Flags/"))
            If Not flagDir Is Nothing Then

                Dim flags = flagDir.GetFiles().Where(Function(x) x.Name.ToLower.Contains(language.ToLower))

                If flags.Count = 0 Then
                    Return ""  ' couldn't find flag
                Else
                    Return "/images/Flags/" & flags.First.Name

                End If
            Else
                Return ""
            End If

        End Function




        Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
            Dim d As New StoriesDataContext


            Dim q = From c In d.AP_Stories Where c.StoryId = Request.QueryString("StoryId")

            If q.Count > 0 Then
                q.First.StoryText = StoryText.Text
                q.First.Headline = Headline.Text
                q.First.Author = Author.Text
                Try
                    Dim geoLoc = tbLocation.Text.Split(",")
                    If geoLoc.Count = 2 Then

                        q.First.Latitude = Double.Parse(geoLoc(0).Replace(" ", ""), New CultureInfo(""))
                        q.First.Longitude = Double.Parse(geoLoc(1).Replace(" ", ""), New CultureInfo(""))

                    End If
                Catch ex As Exception

                End Try


                If acImage1.CheckAspect() Then

                    q.First.PhotoId = acImage1.FileId
                    d.SubmitChanges()
                Else
                    Return
                End If
                Response.Redirect(EditUrl("ViewStory") & "?StoryId=" & Request.QueryString("StoryId"))
            Else
                Dim insert As New AP_Story
                insert.Headline = Headline.Text
                insert.Author = Author.Text
                If acImage1.CheckAspect() Then
                    insert.PhotoId = acImage1.FileId
                Else
                    Return
                End If
                insert.StoryDate = Today
                insert.StoryText = StoryText.Text
                insert.PortalID = PortalId
                insert.Sent = False
                insert.RegionId = 0
                insert.Editable = True
                insert.EditorBoost = Today
                insert.IsVisible = True
                insert.UserId = UserId
                insert.TabId = TabId
                insert.Language = ddlLanguage.SelectedValue
                insert.TabModuleId = CInt(ddlChannels.SelectedValue)

                If Request.QueryString("tg") <> "" Then
                    insert.TranslationGroup = Request.QueryString("tg")
                End If


                Try
                    Dim geoLoc = tbLocation.Text.Split(",")
                    If geoLoc.Count = 2 Then

                        insert.Latitude = Double.Parse(geoLoc(0).Replace(" ", ""), New CultureInfo(""))
                        insert.Longitude = Double.Parse(geoLoc(1).Replace(" ", ""), New CultureInfo(""))

                    End If
                Catch ex As Exception

                End Try
                d.AP_Stories.InsertOnSubmit(insert)
                d.SubmitChanges()
                Dim feeds = From c In d.AP_Stories_Module_Channels Where c.URL.EndsWith("?channel=" & insert.TabModuleId)

                For Each row In feeds
                    StoryFunctions.RefreshFeed(row.AP_Stories_Module.TabModuleId, row.ChannelId)
                    StoryFunctions.PrecalAllCaches(row.AP_Stories_Module.TabModuleId)
                Next


                Response.Redirect(EditUrl("ViewStory") & "?StoryId=" & insert.StoryId)
            End If


        End Sub

        Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs) Handles btnCancel.Click
            If Request.QueryString("StoryId") = "" Then
                Response.Redirect(NavigateURL())
            Else
                Response.Redirect(EditUrl("ViewStory") & "?StoryId=" & Request.QueryString("StoryId"))

            End If
        End Sub

        Protected Sub acImage1_Updated() Handles acImage1.Updated
            Dim d As New StoriesDataContext
            Dim q = From c In d.AP_Stories Where c.StoryId = Request.QueryString("StoryId")

            If q.Count > 0 Then

                If acImage1.CheckAspect() Then
                    PhotoIdHF.Value = acImage1.FileId
                    q.First.PhotoId = acImage1.FileId
                    d.SubmitChanges()
                    'If Settings("Aspect") <> "" Then
                    '    acImage1.Aspect = Settings("Aspect")
                    'End If
                    ' acImage1.LazyLoad()
                End If

            End If

        End Sub
    End Class
End Namespace