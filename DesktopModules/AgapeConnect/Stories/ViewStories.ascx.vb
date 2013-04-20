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
    Partial Class ViewStories
        Inherits Entities.Modules.PortalModuleBase
        'Adding Stories Translation
        Dim d As New StoriesDataContext
        Dim theControl As Object

        Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
            Dim addTitle = New Entities.Modules.Actions.ModuleAction(GetNextActionID, "AgapeConnect", "AgapeConnect", "", "", "", "", True, SecurityAccessLevel.Edit, True, False)

            addTitle.Actions.Add(GetNextActionID, "Story Settings", "StorySettings", "", "action_settings.gif", EditUrl("StorySettings"), False, SecurityAccessLevel.Edit, True, False)
            addTitle.Actions.Add(GetNextActionID, "Story Mixer", "StoryMixer", "", "action_settings.gif", EditUrl("Mixer"), False, SecurityAccessLevel.Edit, True, False)

            addTitle.Actions.Add(GetNextActionID, "New Story", "NewStory", "", "add.gif", EditUrl("AddEditStory"), False, SecurityAccessLevel.Edit, True, False)
            MyBase.Actions.Insert(0, addTitle)
        End Sub


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            If Request.QueryString("StoryId") <> "" Then
                If String.IsNullOrEmpty(Settings("ViewTab")) Or Settings("ViewTab") = 0 Then
                    Response.Redirect(EditUrl("ViewStory") & "?StoryId=" & Request.QueryString("StoryId"))
                Else
                    Response.Redirect(NavigateURL(CInt(Settings("ViewTab"))) & "?StoryId=" & Request.QueryString("StoryId") & "&origTabId=" & TabId & "&origModId=" & ModuleId)
                End If

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



                If String.IsNullOrEmpty(Settings("StoryControlId")) Then
                    If d.AP_Stories_Controls.Count > 0 Then
                        LoadStoryControl(d.AP_Stories_Controls.First.Location)
                    End If
                Else
                    Dim dControl = From c In d.AP_Stories_Controls Where c.StoryControlId = CInt(Settings("StoryControlId"))

                    If dControl.Count > 0 Then
                        LoadStoryControl(dControl.First.Location)
                    End If

                End If

            End If
        End Sub


        Private Sub LoadStoryControl(ByVal URL As String)
            If String.IsNullOrEmpty(Session("Long")) Or String.IsNullOrEmpty(Session("Lat")) Then
                Dim ls As New LookupService(Server.MapPath("~/App_Data/GeoLiteCity.dat"), LookupService.GEOIP_STANDARD)

                ' Dim l As Location = ls.getRegion(Request.ServerVariables("remote_addr"))
                Dim l As Location = ls.getLocation("80.193.180.102")   '(Solihill) Hard Coded as LocalHost cannot be resolved to a location. Replace with above line when going live!

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
                P = Double.Parse(Settings("WeightPopular"), New CultureInfo(""))
            End If
            'Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId Order By CDbl(c.Precal) * (CDbl(1.0 + (c.Clicks * P))) * (1.0 + (G * (1.0 - CDbl(CDbl(Math.Min(200, ((Math.Acos(CDbl(Math.Sin(deg2Rad * (lt))) * CDbl(Math.Sin(deg2Rad * CDbl(c.Latitude))) + CDbl(Math.Cos(deg2Rad * CDbl(lt))) * CDbl(Math.Cos(deg2Rad * CDbl(c.Latitude))) * CDbl(Math.Cos(deg2Rad * (lg - CDbl(c.Longitude)))))) / CDbl(Math.PI) * 180.0) * 1.1515 * 60.0)) / 200.0)))) / 2.0 Descending
            Dim q = From c In d.AP_Stories_Module_Channel_Caches Where c.AP_Stories_Module_Channel.AP_Stories_Module.TabModuleId = TabModuleId And Not c.Block Order By CDbl(c.Precal) * (CDbl(1.0 + (c.Clicks * P))) * (1.0 + (G * (CDbl(1.0) - CDbl(CDbl(Math.Min(CDbl(200), ((Math.Acos(CDbl(Math.Sin(CDbl(deg2Rad) * CDbl(lt))) * CDbl(Math.Sin(deg2Rad * CDbl(c.Latitude))) + CDbl(Math.Cos(CDbl(deg2Rad) * CDbl(lt))) * CDbl(Math.Cos(CDbl(deg2Rad) * CDbl(c.Latitude))) * CDbl(Math.Cos(CDbl(deg2Rad) * (CDbl(lg) - CDbl(c.Longitude)))))) / CDbl(Math.PI) * CDbl(180.0)) * CDbl(1.1515) * CDbl(60.0))) / CDbl(200.0))))) / CDbl(2.0) Descending
            Dim culture = CultureInfo.CurrentCulture.Name.ToLower
            'Dim culture2 = CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower
            'q = q.Where(Function(c) (CultureInfo.CurrentCulture.Name.ToLower.Contains(c.Langauge.ToLower) Or c.Langauge.ToLower.Contains(CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower)))
            q = q.Where(Function(c) CultureInfo.CurrentCulture.TwoLetterISOLanguageName.ToLower = c.Langauge.Substring(0, 2))


            phStoryControl.Controls.Clear()
            theControl = LoadControl(URL)

            theControl.ID = "theControl"
            phStoryControl.Controls.Add(theControl)
            Dim ucType As Type = theControl.GetType()

            ucType.GetMethod("Initialize").Invoke(theControl, New Object() {q.Take(CInt(Settings("NumberOfStories"))), Settings})

        End Sub


    End Class



End Namespace
