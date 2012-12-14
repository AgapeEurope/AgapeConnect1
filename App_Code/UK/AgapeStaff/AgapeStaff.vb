Imports Microsoft.VisualBasic
Imports AgapeStaff
Imports System.Linq
Imports DotNetNuke.Services.Mail.Mail
Imports System.Text.RegularExpressions
Imports StaffBrokerFunctions


Public Class AgapeStaffFunctions

    Public Shared Sub SendAgapeMail(ByVal SendFrom As String, ByVal SendTo As String, ByVal Subject As String, ByVal Message As String, ByVal DisplayName As String, Optional ByVal Reim As Boolean = False)

        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim q = StaffBrokerFunctions.GetTemplate("BlankEmail", PS.PortalId)
        '  Dim q = HttpUtility.HtmlDecode((From c In d.AP_StaffBroker_Templates Where c.TemplateName = "BlankEmail" Select c.TemplateHTML).First)
        'If Reim Then
        '    q = q.Replace("[LOGO]", "<img hspace=""7"" alt="""" src=""http://www.agape.org.uk/Portals/0/reimbursementapproval.gif"" />")
        'Else
        '    q = q.Replace("[LOGO]", "")
        'End If
        q = q.Replace("[DISPLAYNAME]", DisplayName & ",<br /><br />" & Message).Replace("[UNSUB]", "")



        SendMail(SendFrom, SendTo, "", Subject, q, "", "HTML", "", "", "", "")

    End Sub

    Public Shared Sub SendAgapeMail(ByVal SendFrom As String, ByVal SendTo As String, ByVal Subject As String, ByVal Message As String, ByVal DisplayName As String, ByVal Attachment As String)
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim q = StaffBrokerFunctions.GetTemplate("BlankEmail", PS.PortalId)

        'Dim d As New Resources.ResourcesDataContext
        'Dim q = HttpUtility.HtmlDecode((From c In d.Agape_Main_EmailTemplates Where c.TemplateName = "BlankEmail" Select c.Template).First)
        q = q.Replace("[DISPLAYNAME]", "Dear" & DisplayName & ",<br /><br />" & Message).Replace("[UNSUB]", "")


        SendMail(SendFrom, SendTo, "donotreply@agape.org.uk", Subject, q, Attachment, "HTML", "", "", "", "")

    End Sub

    'Public Shared Function GetTeam(ByVal LeaderId1 As Integer, ByVal LeaderId2 As Integer, Optional ByVal ExcludeUserAndSpouse As Boolean = False) As IQueryable(Of AgapeStaff.User)
    '    Dim broke As New StaffBrokerFunctions
    '    'Return broke.GetTeam(LeaderId1)

    '    Dim d As New AgapeStaff.AgapeStaffDataContext


    '    Dim q = From c In d.Agape_Staff_Finances Where c.Leader11Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '    Dim r = From c In d.Agape_Staff_Finances Where c.Leader12Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '    Dim u = From c In d.Agape_Staff_Finances Where c.Leader21Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '    Dim v = From c In d.Agape_Staff_Finances Where c.Leader22Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '    Dim y = From c In d.Agape_Staff_Finances Where c.Delegate11Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '    Dim z = From c In d.Agape_Staff_Finances Where c.Delegate12Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '    Dim a = From c In d.Agape_Staff_Finances Where c.Delegate21Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '    Dim e = From c In d.Agape_Staff_Finances Where c.Delegate22Id = LeaderId1 And ((c.UserId1 <> LeaderId1 And c.USerId2 <> LeaderId1 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '    q = q.Union(r)
    '    q = q.Union(u)
    '    q = q.Union(v)
    '    q = q.Union(y)
    '    q = q.Union(z)
    '    q = q.Union(a)
    '    q = q.Union(e)

    '    If LeaderId2 > 0 Then

    '        Dim s = From c In d.Agape_Staff_Finances Where c.Leader11Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '        Dim t = From c In d.Agape_Staff_Finances Where c.Leader12Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '        Dim w = From c In d.Agape_Staff_Finances Where c.Leader21Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '        Dim x = From c In d.Agape_Staff_Finances Where c.Leader22Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '        Dim f = From c In d.Agape_Staff_Finances Where c.Delegate11Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '        Dim g = From c In d.Agape_Staff_Finances Where c.Delegate12Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.UserId1 Select b

    '        Dim h = From c In d.Agape_Staff_Finances Where c.Delegate21Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b

    '        Dim i = From c In d.Agape_Staff_Finances Where c.Delegate22Id = LeaderId2 And ((c.UserId1 <> LeaderId2 And c.USerId2 <> LeaderId2 And ExcludeUserAndSpouse) Or (Not ExcludeUserAndSpouse)) Join b In d.Users On b.UserID Equals c.USerId2 Select b


    '        q = q.Union(s)
    '        q = q.Union(t)
    '        q = q.Union(w)
    '        q = q.Union(x)
    '        q = q.Union(f)
    '        q = q.Union(g)
    '        q = q.Union(h)
    '        q = q.Union(i)

    '    End If

    '    Return From c In q Order By c.LastName
    'End Function

    'Public Shared Function GetActiveLeader(ByVal StaffId As Integer, ByVal Prime As Boolean, Optional ByVal CurrentUser As Integer = -1) As Integer
    '    Dim d As New AgapeStaff.AgapeStaffDataContext
    '    Dim q = From c In d.Agape_Staff_Finances Where c.UserId1 = StaffId Select c
    '    Dim r = From c In d.Agape_Staff_Finances Where c.USerId2 = StaffId Select c

    '    Dim LeaderIdOut As Integer = CurrentUser
    '    If q.Count > 0 Then
    '        If Prime Then
    '            If Not q.First.Delegate11Id Is Nothing Then
    '                LeaderIdOut = q.First.Delegate11Id
    '            ElseIf Not q.First.Leader11Id Is Nothing Then
    '                LeaderIdOut = q.First.Leader11Id
    '            End If
    '        Else
    '            If Not q.First.Delegate12Id Is Nothing Then
    '                LeaderIdOut = q.First.Delegate12Id
    '            ElseIf Not q.First.Leader12Id Is Nothing Then
    '                LeaderIdOut = q.First.Leader12Id
    '            End If
    '        End If
    '    ElseIf r.Count > 0 Then
    '        If Prime Then
    '            If Not r.First.Delegate21Id Is Nothing Then
    '                LeaderIdOut = r.First.Delegate21Id
    '            ElseIf Not r.First.Leader21Id Is Nothing Then
    '                LeaderIdOut = r.First.Leader21Id
    '            End If
    '        Else
    '            If Not r.First.Delegate22Id Is Nothing Then
    '                LeaderIdOut = r.First.Delegate22Id
    '            ElseIf Not r.First.Leader22Id Is Nothing Then
    '                LeaderIdOut = r.First.Leader22Id
    '            End If
    '        End If
    '    Else
    '        LeaderIdOut = CurrentUser
    '    End If

    '    Return LeaderIdOut
    'End Function


    Public Shared Function GetAllLeaders(ByVal Userid As Integer) As IQueryable(Of StaffBroker.User)


        Dim ds As New StaffBroker.StaffBrokerDataContext

        Dim q As IQueryable(Of StaffBroker.User)
        q = From c In ds.AP_StaffBroker_LeaderMetas Join b In ds.Users On c.LeaderId Equals b.UserID Where c.UserId = Userid Select b
        q = q.Union(From c In ds.AP_StaffBroker_LeaderMetas Join b In ds.Users On CInt(c.DelegateId) Equals b.UserID Where c.UserId = Userid Select b)
        
        Return q

    End Function

    Public Shared Function GetStaff(ByVal ParamArray excludes() As String) As IQueryable(Of UK.AgapeStaff.User)
        Dim q = StaffBrokerFunctions.GetStaffExcl(0, excludes)
        Return From c In q Order By c.LastName, c.FirstName

    End Function

   
    Public Shared Function GetAllManagers(ByVal CostCentreIdin As Integer) As IQueryable(Of StaffBroker.User)
        Dim ds As New StaffBroker.StaffBrokerDataContext
        Dim q = From c In ds.AP_StaffBroker_Departments Where c.CostCenterId = CostCentreIdin Join b In ds.Users On c.CostCentreManager Equals b.UserID Select b

        q = q.Union(From c In ds.AP_StaffBroker_Departments Where c.CostCenterId = CostCentreIdin Join b In ds.Users On c.CostCentreDelegate Equals b.UserID Select b)

        Return q
    End Function
    
    Public Shared Function SpouseIsLeader() As IQueryable(Of StaffBroker.User)
        Dim ds As New StaffBroker.StaffBrokerDataContext
        Dim list = From c In ds.AP_StaffBroker_LeaderMetas Where c.LeaderId = c.User.AP_StaffBroker_Staffs.UserId1 _
                   Or c.LeaderId = c.User.AP_StaffBroker_Staffs.UserId2 _
                   Or c.DelegateId = c.User.AP_StaffBroker_Staffs.UserId1 _
                    Or c.DelegateId = c.User.AP_StaffBroker_Staffs.UserId2 Select c.User
        Return list



       

    End Function
    Public Shared Function GetAuthUser() As Integer
        Dim d As New UK.AgapeStaff.AgapeStaffDataContext
        Dim AuthUser As Integer = -1
        Dim r = From c In d.ModuleControls Where c.ControlKey = "RmbSettings" Select c.ModuleDefID
        If r.Count > 0 Then
            Dim s = From c In d.Modules Join b In d.TabModules On c.ModuleID Equals b.ModuleID Where c.ModuleDefID = r.First Select b.TabModuleID
            If s.Count > 0 Then
                Dim objTabAuth = From c In d.TabModuleSettings Where c.TabModuleID = s.First And c.SettingName = "AuthUser" Select c
                If objTabAuth.Count > 0 Then
                    If CType(objTabAuth.First.SettingValue, String) <> "" Then
                        AuthUser = CType(objTabAuth.First.SettingValue, Integer)
                    End If
                End If
            End If
        End If

        Return AuthUser
    End Function
    Public Shared Function CleanUpURL(ByVal InURL As String) As String
        Dim CleanedOut As String = ""

        If Not InURL = "" Then
            CleanedOut = Regex.Replace(InURL, "/[0-9]+/", "/")

            If CleanedOut.IndexOf("http://agapebetasvn/") > -1 Then
                CleanedOut = CleanedOut.Replace("http://agapebetasvn/", "")
            End If
            If CleanedOut.IndexOf("http://www.agape.org.uk/") > -1 Then
                CleanedOut = CleanedOut.Replace("http://www.agape.org.uk/", "")
            End If
            If CleanedOut.IndexOf("/Default.aspx") > 0 Then
                CleanedOut = CleanedOut.Replace("/Default.aspx", "")
            End If
            If CleanedOut.IndexOf(".aspx") > 0 Then
                CleanedOut = CleanedOut.Replace(".aspx", "")
            End If
            If CleanedOut.IndexOf("/default.aspx") > 0 Then
                CleanedOut = CleanedOut.Replace("/default.aspx", "")
            End If

            If CleanedOut.IndexOf("/tabid/") > -1 Then
                CleanedOut = CleanedOut.Replace("/tabid/", "/")
            End If
            If CleanedOut.IndexOf("/tabid") > -1 Then
                CleanedOut = CleanedOut.Replace("/tabid", "")
            End If

            CleanedOut = CleanedOut.Replace("/", " - ")

            CleanedOut = Regex.Replace(CleanedOut, "[A-Z]", " $0")
        End If

        Return CleanedOut
    End Function
    Public Shared Function LookAtUrl(ByVal inURL As String) As String
        If inURL = "" Then
            Return ""
        Else
            Return inURL.Substring(0, 30) & "..."
        End If
    End Function
    'Public Shared Function TidyThisURL(ByVal Link As String) As Integer
    '    Dim DeleteThis As Integer = -3
    '    If Not Link.IndexOf("StoryID=") < 0 Then
    '        Try
    '            Dim d As New FullStory.FullStoryDataContext
    '            Dim ThisStory As Integer = CInt(Link.Substring(Link.IndexOf("=") + 1))
    '            Dim q = From c In d.Agape_Main_Story_Stories Where c.StoryId = ThisStory And c.IsVisible = False
    '            If q.Count > 0 Then
    '                DeleteThis = 1
    '            End If
    '        Catch ex As Exception
    '            DeleteThis = -3
    '        End Try
    '    ElseIf Not Link.IndexOf("ProductID=") < 0 Then
    '        Try
    '            Dim ThisProduct As Integer = CInt(Link.Substring(Link.IndexOf("=") + 1))
    '            Dim f As New Resources.ResourcesDataContext
    '            Dim r = From c In f.CAT_Products Where c.ProductID = ThisProduct And c.Archive = True
    '            If r.Count > 0 Then
    '                DeleteThis = 2
    '            End If
    '        Catch ex As Exception
    '            DeleteThis = -3
    '        End Try
    '    Else
    '        DeleteThis = -3
    '    End If
    '    Return DeleteThis
    'End Function
    Public Shared Function GetBCQuery(ByVal inQueryStory As String, ByVal inQueryProduct As String) As String
        Dim QueryString As String = ""
        If (inQueryStory <> "" Or inQueryProduct <> "") Then
            QueryString = "?"
            If (inQueryStory <> "") Then
                QueryString = QueryString & "StoryId=" & inQueryStory
                If inQueryProduct <> "" Then
                    QueryString = QueryString & "ProductID=" & inQueryProduct
                End If
            ElseIf inQueryProduct <> "" Then
                QueryString = QueryString & "ProductID=" & inQueryProduct
            End If

        End If
        Return QueryString
    End Function
    'Public Shared Function CleanBreadCrumb(ByVal strBreadCrumbs As String, ByVal inQueryProduct As String, ByVal inQueryStory As String, ByVal inQueryTab As String, ByVal inQueryCat As String, ByVal inQueryTeam As String, ByVal inQueryEvent As String) As String
    '    If strBreadCrumbs.IndexOf("Product Page") > 0 Then
    '        Dim d As New Resources.ResourcesDataContext

    '        Dim Product As String = String.Empty
    '        If (inQueryProduct <> "") Then
    '            Try
    '                Product = (From c In d.CAT_Products Where c.ProductID = inQueryProduct Select c.ProductName).First
    '            Catch ex As Exception

    '            End Try
    '        End If


    '        strBreadCrumbs = strBreadCrumbs.Replace("Product Page", Product)

    '    ElseIf strBreadCrumbs.IndexOf("Stories") > 0 Then
    '        Dim fs As New FullStory.FullStoryDataContext
    '        If inQueryStory <> "" Then
    '            Try
    '                Dim Story = From c In fs.Agape_Main_Story_Stories Where c.StoryId = CInt(inQueryStory) Select c.Headline, c.TeamId

    '                If Not Story.First.TeamId = 0 Then
    '                    Dim Team = From c In fs.Agape_Main_Teams Where c.TeamId = Story.First.TeamId Select c.TeamName, c.PageTabId
    '                    strBreadCrumbs = strBreadCrumbs.Replace("<span class=""Breadcrumb"">Stories</span>", "<a href=""" & NavigateURL(CInt(Team.First.PageTabId)) & """ class=""Breadcrumb"">" & Team.First.TeamName & "</a>")
    '                Else
    '                    strBreadCrumbs = strBreadCrumbs.Replace("<span class=""Breadcrumb"">Stories</span>", "<a href=""http://www.agape.org.uk/Default.aspx"" class=""Breadcrumb"">Home</a>")
    '                End If
    '                If Not inQueryTab = "" Then
    '                    strBreadCrumbs = Regex.Replace(strBreadCrumbs, "Stories\/Story.aspx\?StoryId=[0-9]+"" class=""Breadcrumb"">Story", "Default.aspx?TabId=" & inQueryTab & "&StoryId=" & inQueryStory & """ class=""Breadcrumb"">" & Story.First.Headline)
    '                Else
    '                    strBreadCrumbs = Regex.Replace(strBreadCrumbs, "Stories\/Story.aspx\?StoryId=[0-9]+"" class=""Breadcrumb"">Story", "Default.aspx?StoryId=" & inQueryStory & """ class=""Breadcrumb"">" & Story.First.Headline)
    '                End If
    '                'strBreadCrumbs = strBreadCrumbs.Replace("Story", Story.First.Headline)
    '            Catch ex As Exception

    '            End Try

    '        End If

    '    ElseIf strBreadCrumbs.IndexOf("Search the Resource Centre") > 0 And inQueryCat <> "" Then
    '        Dim rdc As New Resources.ResourcesDataContext
    '        Dim CatName As String = ""
    '        If inQueryCat = -60 Then
    '            CatName = "Free Articles"
    '        Else
    '            Try
    '                Dim AdvCat = From c In rdc.CAT_AdvCats Where c.AdvCatID = CInt(inQueryCat)
    '                CatName = AdvCat.First.Title
    '            Catch ex As Exception

    '            End Try
    '        End If
    '        strBreadCrumbs = strBreadCrumbs.Replace("SearchtheResourceCentre.aspx"" class=""Breadcrumb"">Search the Resource Centre", "SearchtheResourceCentre.aspx?Cat=" & inQueryCat & """ class=""Breadcrumb"">" & CatName)

    '    ElseIf strBreadCrumbs.IndexOf("Meet the Team") > 0 Then
    '        Dim b As New FullStory.FullStoryDataContext
    '        If (inQueryTeam <> "") Then
    '            Try
    '                Dim Team = (From c In b.Agape_Main_Teams Where c.TeamId = inQueryTeam Select c.TeamName, c.PageTabId)

    '                strBreadCrumbs = strBreadCrumbs.Replace("<span class=""Breadcrumb"">Ministries</span>", "<a href=""" & NavigateURL(CInt(Team.First.PageTabId)) & """ class=""Breadcrumb"">" & Team.First.TeamName & "</a>")
    '                strBreadCrumbs = strBreadCrumbs.Replace("MeettheTeam.aspx", "MeettheTeam.aspx?TeamId=" & inQueryTeam)
    '            Catch ex As Exception

    '            End Try
    '        End If
    '    ElseIf strBreadCrumbs.IndexOf("What's On") > 0 Then
    '        Dim b As New FullStory.FullStoryDataContext
    '        If (inQueryTeam <> "") Then
    '            Try
    '                Dim Team = (From c In b.Agape_Main_Teams Where c.TeamId = inQueryTeam Select c.TeamName, c.PageTabId)
    '                strBreadCrumbs = strBreadCrumbs.Replace("<span class=""Breadcrumb"">What's On</span>", "<a href=""" & NavigateURL(CInt(Team.First.PageTabId)) & """ class=""Breadcrumb"">" & Team.First.TeamName & "</a>")
    '                If inQueryEvent <> "" Then
    '                    Dim EventName As String = "What's On"
    '                    If inQueryEvent.IndexOf("w") = -1 Then
    '                        Dim NoWeek = From c In b.Agape_Main_Team_WhatsOns Where c.WhatsOnId = CInt(inQueryEvent.Substring(1))
    '                        If NoWeek.Count > 0 Then
    '                            EventName = NoWeek.First.EventName
    '                        End If
    '                    Else
    '                        Dim ThisWeek = From c In b.Agape_Main_Team_WeekEvents Where c.WeekEventId = CInt(inQueryEvent.Substring(1))
    '                        If ThisWeek.Count > 0 Then
    '                            EventName = ThisWeek.First.EventName
    '                        End If
    '                    End If
    '                    strBreadCrumbs = strBreadCrumbs.Replace("WhatsOn.aspx"" class=""Breadcrumb"">What's On", "WhatsOn.aspx?EventId=" & inQueryEvent & "&TeamId=" & inQueryTeam & """ class=""Breadcrumb"">" & EventName)
    '                End If
    '            Catch ex As Exception

    '            End Try
    '        End If

    '    End If
    '    'If you pass a ProductID query string to the Resource Centre Home page it will redirect to the product paqe
    '    'So we need to strip the querystring from the <a href> in the breadcrumb
    '    If strBreadCrumbs.IndexOf("Resource Centre") > 0 Then
    '        strBreadCrumbs = Regex.Replace(strBreadCrumbs, "\?ProductID=[0-9]+"" class=""Breadcrumb"">Resource Centre", """ class=""Breadcrumb"">Resource Centre")
    '    End If
    '    If strBreadCrumbs.IndexOf("casLogin") > 0 Then
    '        strBreadCrumbs = strBreadCrumbs.Replace(">casLogin<", ">Login<")
    '    End If

    '    Return strBreadCrumbs
    'End Function
End Class
