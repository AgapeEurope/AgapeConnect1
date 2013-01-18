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

Namespace DotNetNuke.Modules.FullStory


    Partial Class ViewFullStory
        Inherits Entities.Modules.PortalModuleBase
        Public IsBoosted As Boolean = False
        Public IsBlocked As Boolean = False
        Public location As String = ""
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Dim d As New StoriesDataContext
            Dim r = (From c In d.AP_Stories Where c.StoryId = Request.QueryString("StoryID")).First
            Dim thecache = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = r.TabModuleId And c.Link.EndsWith("StoryId=" & r.StoryId)

            If Not String.IsNullOrEmpty(Request.Form("Boosted")) Then

                If thecache.Count > 0 Then
                    thecache.First.Block = CBool(Request.Form("Blocked"))
                    If Not thecache.First.Block Then

                        If CBool(Request.Form("Boosted")) Then
                            If Not thecache.First.BoostDate Is Nothing Then
                                If thecache.First.BoostDate < Today Then
                                    thecache.First.BoostDate = Today.AddDays(7)

                                End If
                            Else
                                thecache.First.BoostDate = Today.AddDays(7)

                            End If
                        Else
                            thecache.First.BoostDate = Nothing
                        End If
                    Else
                        thecache.First.BoostDate = Nothing
                    End If
                    d.SubmitChanges()
                End If
                Return
            End If



            If String.IsNullOrEmpty(Request.QueryString("StoryID")) Then
                PagePanel.Visible = False
                NotFoundLabel.Visible = True

            Else

                '!!!!!!!btnEdit.Visible = IsEditable
                '!!!!!!!btnNew.Visible = IsEditable

                If Me.UserInfo.IsSuperUser And IsEditable() Then
                    'SuperPowers.Visible = True
                End If


                PagePanel.Visible = True
                NotFoundLabel.Visible = False
                StoryIdHF.Value = Request.QueryString("StoryId")

                Dim sv As String = StaffBrokerFunctions.GetTemplate("StoryView", PortalId)
               



                ReplaceField(sv, "[HEADLINE]", r.Headline)
                location = r.Latitude.Value.ToString(New CultureInfo("")) & ", " & r.Longitude.Value.ToString(New CultureInfo(""))
                ReplaceField(sv, "[MAP]", " <div id=""map_canvas""></div>")

                ReplaceField(sv, "[STORYTEXT]", r.StoryText)
                Dim thePhoto = DotNetNuke.Services.FileSystem.FileManager.Instance.GetFile(r.PhotoId)


                ReplaceField(sv, "[IMAGEURL]", DotNetNuke.Services.FileSystem.FileManager.Instance.GetUrl(thePhoto))


                ReplaceField(sv, "[AUTHOR]", r.Author)
                ReplaceField(sv, "[DATE]", r.StoryDate.ToString("d MMM yyyy"))
                ReplaceField(sv, "[RSSURL]", "/DesktopModules/AgapeConnect/Stories/Feed.aspx?channel=" & TabModuleId)
                ReplaceField(sv, "[SAMPLE]", r.TextSample)
                ReplaceField(sv, "[SUBTITLE]", r.Subtitle)
                ReplaceField(sv, "[FIELD1]", r.Field1)
                ReplaceField(sv, "[FIELD2]", r.Field2)
                ReplaceField(sv, "[FIELD3]", r.Field3)

                PhotoIdHF.Value = r.PhotoId



                If Not r.TranslationGroup Is Nothing Then

                    'TranslationGroupHF.Value = r.TranslationGroup
                    SuperPowers.TranslationGroupId = r.TranslationGroup

                    Dim Translist = From c In d.AP_Stories Where c.TranslationGroup = r.TranslationGroup And c.PortalID = r.PortalID And c.StoryId <> r.StoryId Select c.Language, c.StoryId

                    If Translist.Count > 0 Then
                        Dim Flags As String = "<div style=""width: 100%;""><i>This story is also available in:</i> <div style=""margin: 4px 0 12px 0;"">"


                        For Each row In Translist
                            Dim Lang = GetLanguageName(row.Language)
                            Flags &= "<a href=""" & NavigateURL() & "?StoryId=" & row.StoryId & """ target=""_self""><span title=""" & Lang & """><img  src=""" & GetFlag(row.Language) & """ alt=""" & Lang & """  /></span></a>"

                        Next

                        Flags &= "</div> </div>"


                        ReplaceField(sv, "[LANGUAGES]", Flags)
                    End If


                End If
                ReplaceField(sv, "[LANGUAGES]", "")

                ltStory1.Text = sv.Substring(0, sv.IndexOf("[SUPERPOWERS]"))

                ltStory2.Text = sv.Substring(sv.IndexOf("[SUPERPOWERS]") + 13)


                If IsEditable Then
                    SuperPowers.Visible = True
                    If thecache.Count > 0 Then

                        SuperPowers.CacheId = thecache.First.CacheId
                        SuperPowers.SuperEditor = UserInfo.IsSuperUser
                        SuperPowers.EditUrl = EditUrl("AddEditStory")
                        SuperPowers.PortalId = PortalId
                        SuperPowers.SetControls()

                    End If

                End If


                'Get Current Channel 



                'If thecache.Count > 0 Then
                '    If thecache.First.Block Then
                '        lblPowerStatus.Text = "This story has been blocked, and won't appear in the channel feed."
                '        IsBlocked = True
                '    ElseIf Not thecache.First.BoostDate Is Nothing Then
                '        If thecache.First.BoostDate >= Today Then
                '            IsBoosted = True
                '            lblPowerStatus.Text = "Boosted until " & thecache.First.BoostDate.Value.ToString("dd MMM yyyy")

                '        End If
                '    End If
                'End If



            End If





        End Sub

        Private Sub ReplaceField(ByRef sv As String, ByVal fieldName As String, ByVal fieldValue As String)
            If Not String.IsNullOrEmpty(fieldValue) Then
                sv = sv.Replace(fieldName, fieldValue)
            Else
                sv = sv.Replace(fieldName, "")
            End If

        End Sub

        'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        '    Response.Redirect(EditUrl("AddEditStory") & "?StoryID=" & Request.QueryString("StoryID"))

        'End Sub


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







        'Protected Sub btnNew_Click(sender As Object, e As System.EventArgs) Handles btnNew.Click
        '    Response.Redirect(EditUrl("AddEditStory"))
        'End Sub

        'Protected Sub btnTranslate_Click(sender As Object, e As EventArgs) Handles btnTranslate.Click
        '    Dim tg As Integer
        '    If String.IsNullOrEmpty(TranslationGroupHF.Value) Then
        '        'generate new Translation group
        '        Dim d As New StoriesDataContext
        '        Dim maxTransGroupId = d.AP_Stories.Where(Function(x) x.PortalID = PortalId And Not String.IsNullOrEmpty(x.TranslationGroup))
        '        If maxTransGroupId.Count = 0 Then
        '            tg = 1
        '        Else
        '            tg = maxTransGroupId.Max(Function(x) x.TranslationGroup)
        '        End If
        '    Else
        '        tg = CInt(TranslationGroupHF.Value)
        '    End If
        '    Response.Redirect(EditUrl("AddEditStory") & "?tg=" & tg)
        'End Sub
    End Class
End Namespace