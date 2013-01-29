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
'Imports Staffweb
'Imports Resources
'Imports FullStory
Imports DotNetNuke
Imports DotNetNuke.Security
'Imports CATALooK
Imports StaffBroker
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeFR.GiveList
    Partial Class GiveList
        Inherits Entities.Modules.PortalModuleBase
        Dim SearchText As String

#Region "Properties"

        Public ReadOnly Property ListType As String
            Get
                Dim value As String = Request.QueryString.Get("givetype")
                If String.IsNullOrEmpty(value) Then

                    Select Case TabController.CurrentPage.TabName
                        Case "Permanents"
                            value = "Staff"

                        Case "Ministères"
                            value = "Dept"

                        Case "Projets"
                            value = "Project"

                    End Select

                End If
                Return value
            End Get
        End Property
#End Region

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            Dim d As New StaffBrokerDataContext
            
            Select Case ListType
                Case "Staff"
                    Dim IncList() As String = {"National Staff", "National Staff, Overseas"}
                    Dim ListItems As System.Linq.IOrderedQueryable
                    'MAY : get search capabilites working

                    ListItems = From s In d.AP_StaffBroker_Staffs _
                                Where (s.User.LastName Like "*" & SearchText & "*") And IncList.Contains(s.AP_StaffBroker_StaffType.Name) _
                                And s.PortalId = PortalId _
                                And Not (From sp In d.AP_StaffBroker_StaffProfiles _
                                Join spd In d.AP_StaffBroker_StaffPropertyDefinitions On spd.StaffPropertyDefinitionId Equals sp.StaffPropertyDefinitionId _
                                Where spd.PropertyName = "UnNamedStaff" And sp.PropertyValue = "True" Select sp.StaffId).Contains(s.StaffId) _
                                Order By s.User.LastName

                    dlGiveListStaff.DataSource = ListItems
                    dlGiveListStaff.DataBind()

                Case "Dept"
                    Dim ListItems = From s In d.AP_StaffBroker_Departments _
                                    Where s.CanGiveTo = "True" _
                                    And s.PortalId = PortalId And Not s.IsProject

                    dlGiveListDept.DataSource = ListItems
                    dlGiveListDept.DataBind()


                Case "Project"
                    Dim ListItems = From s In d.AP_StaffBroker_Departments _
                                    Where s.CanGiveTo = "True" _
                                    And s.PortalId = PortalId And s.IsProject

                    dlGiveListDept.DataSource = ListItems
                    dlGiveListDept.DataBind()

                Case Else


            End Select
        End Sub

        Public Function GetPhotoURL(ByVal PhotoId As Integer?) As String
            If Not PhotoId Is Nothing Then
                Dim _theFile = DotNetNuke.Services.FileSystem.FileManager.Instance.GetFile(PhotoId)
                If Not _theFile Is Nothing Then
                    Return DotNetNuke.Services.FileSystem.FileManager.Instance.GetUrl(_theFile)
                Else
                    Return "/images/no_avatar.gif"

                End If
            Else
                Return "/images/no_avatar.gif"

            End If


        End Function

        Public Function GiveToURL(ByVal DataId As Integer) As String

            Dim shortcut As String = ""

            If ListType = "Staff" Then
                shortcut = StaffBrokerFunctions.GetStaffProfileProperty(DataId, "givingshortcut")

            ElseIf ListType = "Dept" Then
                shortcut = StaffBrokerFunctions.GetDeptGiveToURL(PortalId, DataId)

            ElseIf ListType = "Project" Then
                shortcut = StaffBrokerFunctions.GetDeptGiveToURL(PortalId, DataId)
            End If


            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveView")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Return (NavigateURL(x.TabID, "", "giveto=" + shortcut))
                End If
            End If
            'MAY : change this url
            Return "http://www.agapefrance.org"
        End Function

        Public Function getFirstNames(ByVal StaffId As Integer) As String
            Dim theStaff = StaffBrokerFunctions.GetStaffbyStaffId(StaffId)
            If Not theStaff Is Nothing Then


                If theStaff.UserId2 > 0 Then
                    Return theStaff.User.FirstName & " et " & theStaff.User2.FirstName
                Else
                    Return theStaff.User.FirstName
                End If
            Else

                Return ""
            End If

        End Function

        '      Private Sub btnSearch_click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        '         SearchText = TbSearch.Text
        '        TbSearch.Text = ""
        '   End Sub
    End Class




End Namespace



