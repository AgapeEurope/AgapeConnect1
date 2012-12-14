Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports StaffBrokerFunctions
Imports Stories
Imports DotNetNuke.Services.FileSystem
Namespace DotNetNuke.Modules.AgapeConnect.Stories
    Partial Class ContentRotator
        Inherits Entities.Modules.PortalModuleBase
        'Adding Stories Translation
        Dim d As New StoriesDataContext

        Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
            Dim addTitle = MyBase.Actions.Add(GetNextActionID, "AgapeConnect", "AgapeConnect", "", "", "", "", True, SecurityAccessLevel.Edit, True, False)
            addTitle.Actions.Add(GetNextActionID, "Story Settings", "StorySettings", "", "action_settings.gif", EditUrl("StorySettings"), False, SecurityAccessLevel.Edit, True, False)
            addTitle.Actions.Add(GetNextActionID, "New Story", "NewStory", "", "add.gif", EditUrl("AddEditStory"), False, SecurityAccessLevel.Edit, True, False)

        End Sub


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Request.QueryString("StoryId") <> "" Then
                Response.Redirect(EditUrl("ViewStory") & "?StoryId=" & Request.QueryString("StoryId"))
            End If

            If Not String.IsNullOrEmpty(Request.Form("StoryLink")) Then
                'Register a click for this story
                Dim theCache = From c In d.AP_Stories_Module_Channel_Caches Where c.CacheId = CInt(Request.Form("StoryLink"))

                If theCache.Count > 0 Then
                    theCache.First.Clicks += 1
                End If
                d.SubmitChanges()
                Return
            End If


            If Not Page.IsPostBack Then
                If String.IsNullOrEmpty(Session("Long")) Or String.IsNullOrEmpty(Session("Lat")) Then
                    Dim ls As New LookupService(Server.MapPath("~/App_Data/GeoLiteCity.dat"), LookupService.GEOIP_STANDARD)
                    ' Dim l As Location = ls.getRegion(Request.ServerVariables("remote_addr"))

                    Dim l As Location = ls.getLocation("80.193.180.102")   '(Solihill)
                    Session("Long") = l.longitude
                    Session("Lat") = l.latitude
                End If

                Dim lg = Session("Long")
                Dim lt = Session("Lat")


                If Settings("NumberOfStories") = "" Then
                    Dim objModules As New Entities.Modules.ModuleController
                    objModules.UpdateTabModuleSetting(TabModuleId, "NumberOfStories", 10)
                    SynchronizeModule()
                End If
                Dim localFactor As Double = 1

                ' Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId Order By CDbl(c.Precal) * (1.0 + (CDbl(c.Clicks) * CDbl(Settings("WeightPopular")))) * (1.0 - Math.Max(1.0, (Math.Acos(Math.Sin(lt * Math.PI / 180.0) * Math.Sin(c.Latitude * Math.PI / 180.0) + Math.Cos(lt * Math.PI / 180.0) * Math.Cos(c.Latitude * Math.PI / 180.0) * Math.Cos(((lg - c.Longitude) * Math.PI / 180.0)))) * 0.006909 / (Math.PI * 180.0))) Descending

                'Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId Order By CDbl(c.Precal) * (1.0 + (CDbl(c.Clicks) * CDbl(Settings("WeightPopular")))) * CDbl(CDbl(1.0) - CDbl(Math.Max(CDbl(1.0), CDbl((Math.Acos(Math.Sin(lt * Math.PI / 180.0) * Math.Sin(CDbl(c.Latitude) * Math.PI / 180.0) + Math.Cos(lt * Math.PI / 180.0) * Math.Cos(CDbl(c.Latitude) * Math.PI / 180.0) * Math.Cos(((CDbl(lg) - CDbl(c.Longitude)) * Math.PI / 180.0))))) * 0.006909 / (Math.PI * 180.0)))) Descending
                Dim deg2Rad As Double = Math.PI / CDbl(180.0)
                Dim G As Double = 0.8
                Dim P As Double = 0.8
                If Settings("WeightRegional") <> "" Then
                    G = Double.Parse(Settings("WeightRegional"), New CultureInfo(""))

                End If
                If Settings("WeightLocal") <> "" Then
                    G = Double.Parse(Settings("WeightPopular"), New CultureInfo(""))
                End If
                'Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId Order By CDbl(c.Precal) * (CDbl(1.0 + (c.Clicks * P))) * (1.0 + (G * (1.0 - CDbl(CDbl(Math.Min(200, ((Math.Acos(CDbl(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(c.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(c.Latitude))) * CDbl(Math.Cos(deg2Rad * (lg - CDbl(c.Longitude)))))) / CDbl(Math.PI) * 180.0) * 1.1515 * 60.0)) / 200.0)))) / 2.0 Descending
                Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId Order By CDbl(c.Precal) * (CDbl(1.0 + (c.Clicks * P))) * (1.0 + (G * (CDbl(1.0) - CDbl(CDbl(Math.Min(CDbl(200), ((Math.Acos(CDbl(Math.Sin(CDbl(deg2Rad) * CDbl(lt))) * CDbl(Math.Sin(deg2Rad * CDbl(c.Latitude))) + CDbl(Math.Cos(CDbl(deg2Rad) * CDbl(lt))) * CDbl(Math.Cos(CDbl(deg2Rad) * CDbl(c.Latitude))) * CDbl(Math.Cos(CDbl(deg2Rad) * (CDbl(lg) - CDbl(c.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60.0))) / CDbl(200.0))))) / CDbl(2.0) Descending
                '  Dim culture = CultureInfo.CurrentCulture.Name.ToLower

                'q = q.Where(Function(c) (CultureInfo.CurrentCulture.Name.ToLower.Contains(c.Langauge.ToLower) Or c.Langauge.ToLower.Contains(CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower)))
                'q = q.Where(Function(c) culture = c.Langauge.ToLower)


                Dim out As String = ""

                For Each row In q.Take(CInt(Settings("NumberOfStories")))
                    Try
                        If (CultureInfo.CurrentCulture.Name.ToLower.Contains(row.Langauge.ToLower) Or row.Langauge.ToLower.Contains(CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower)) Then



                            '  Dim Photo = FileManager.Instance.GetFile(row.PhotoId)
                            ' Dim PhotoURL = FileManager.Instance.GetUrl(Photo)

                            '   Dim distanceWeight = (CDbl(1.0) + ((CDbl(1.0) - CDbl(Math.Max(CDbl(200), CDbl((CDbl(Math.Acos(Math.Sin(deg2Rad * CDbl(lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * CDbl(lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))) / Math.PI * CDbl(180.0)) * CDbl(1.1515)))) / CDbl(200.0))) / CDbl(2.0)))
                            '   Dim distanceMiles = StoryFunctions.distance(lt, lg, row.Latitude, row.Longitude) ' (CDbl(1.0) + (G * (CDbl(1.0) - (Math.Min(200, ((Math.Acos(Math.Sin(deg2Rad * (lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * (lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (lg - CDbl(row.Longitude))))) / Math.PI * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)) / CDbl(200))))) / CDbl(2)

                            'Dim PreCal = CDbl(row.Precal) * (CDbl(1.0) + (G * (CDbl(1.0) - (Math.Min(200, ((CDbl(Math.Acos(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)) / CDbl(200))))) / CDbl(2)
                            'Dim PreCal = ((CDbl(Math.Acos(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60)


                            'Dim PreCal = CDbl(row.Precal) * (CDbl(1 + (row.Clicks * P))) * (1.0 + (G * (1.0 - (CDbl(Math.Min(200, ((Math.Acos(CDbl(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(row.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(row.Latitude))) * CDbl(Math.Cos(deg2Rad * (lg - CDbl(row.Longitude)))))) / CDbl(Math.PI) * 180.0) * 1.1515 * 60.0)) / 200.0)))) / 2.0


                            '  Dim dist As Double = CDbl(Math.Sin(deg2Rad * lt)) * CDbl(Math.Sin(deg2Rad * (row.lat))) + Math.Cos(deg2Rad(lat1)) * Math.Cos(deg2Rad(lat2)) * Math.Cos(deg2Rad(theta))



                            'StoryFunctions.distance(lt, lg, row.Latitude, row.Longitude) ' CDbl((CDbl(Math.Acos(Math.Sin(deg2Rad * CDbl(lt)) * Math.Sin(deg2Rad * CDbl(row.Latitude)) + Math.Cos(deg2Rad * CDbl(lt)) * Math.Cos(deg2Rad * CDbl(row.Latitude)) * Math.Cos(deg2Rad * (CDbl(lg) - CDbl(row.Longitude)))) / Math.PI * CDbl(180.0)) * CDbl(1.1515)))


                            Dim target = "_blank"
                            If row.Link.Contains(PortalSettings.DefaultPortalAlias) Then
                                target = "_self"
                            End If
                            out &= "<a href=""javascript: registerClick(" & row.CacheId & "); window.open('" & row.Link & "', '" & target & "');"" > "
                            out &= "<img src=""" & row.ImageId & """ style=""width: 420px; height: " & CInt((420 * row.ImageHeight) / row.ImageWidth) & "px;"" data-thumb=""" & row.ImageId & """ alt=""" & row.Headline & """  title=""" & row.Headline & """ /></a>"
                        End If
                    Catch ex As Exception

                    End Try

                Next

                ltStories.Text = out
            End If
        End Sub




    End Class
End Namespace
