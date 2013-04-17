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
                If String.IsNullOrEmpty(value) Then 'Staff list per default if no param in request
                    value = "Staff"
                End If
                Return value
            End Get
        End Property
#End Region

        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            Dim d As New StaffBrokerDataContext

            Select Case ListType
                Case "Staff"

                    Dim ListItems = From c In d.AP_StaffBroker_Staffs Where c.PortalId = PortalId And c.AP_StaffBroker_StaffProfiles.Where(Function(x) x.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "CanReceiveDonations" And x.PropertyValue = "True").Count > 0 _
                    And c.AP_StaffBroker_StaffProfiles.Where(Function(x) x.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "UnNamedStaff" And x.PropertyValue = "True").Count = 0 _
                    And c.AP_StaffBroker_StaffProfiles.Where(Function(x) x.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "givingshortcut" And Not (x.PropertyValue Is Nothing Or x.PropertyValue.Equals(""))).Count > 0 _
                    Select c.StaffId, c.User.LastName, c.DisplayName, _
                    GivingShortcut = c.AP_StaffBroker_StaffProfiles.Where(Function(x) x.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "givingshortcut").FirstOrDefault.PropertyValue, _
                    JointPhoto = c.AP_StaffBroker_StaffProfiles.Where(Function(x) x.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "JointPhoto").FirstOrDefault.PropertyValue
                    Order By LastName

                    'And (s.User.LastName Like "*" & SearchText & "*") _ 'A ajouter pour recherche

                    dlGiveListStaff.DataSource = ListItems
                    dlGiveListStaff.DataBind()

                Case "Dept"
                    Dim ListItems = From s In d.AP_StaffBroker_Departments _
                                    Where s.CanGiveTo = "True" _
                                    And s.PortalId = PortalId And Not s.IsProject _
                                    Select s.CostCenterId, s.Name, s.GivingShortcut, s.PhotoId
                                    Order By Name

                    dlGiveListDept.DataSource = ListItems
                    dlGiveListDept.DataBind()


                Case "Project"
                    Dim ListItems = From s In d.AP_StaffBroker_Departments _
                                    Where s.CanGiveTo = "True" _
                                    And s.PortalId = PortalId And s.IsProject _
                                    Select s.CostCenterId, s.Name, s.GivingShortcut, s.PhotoId
                                    Order By Name

                    dlGiveListDept.DataSource = ListItems
                    dlGiveListDept.DataBind()

                Case Else


            End Select
        End Sub

        Public Function GiveToURL(ByVal GivingShortcut As String) As String

            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frGiveView")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Return (NavigateURL(x.TabID, "", "giveto=" + GivingShortcut))
                End If
            End If
            'No link if frGiveView page not found
            Return ""
        End Function

        '      Private Sub btnSearch_click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        '         SearchText = TbSearch.Text
        '        TbSearch.Text = ""
        '   End Sub
    End Class




End Namespace



