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
Imports DotNetNuke
Imports DotNetNuke.Security

Imports StaffBroker
Imports UK.AgapeStaff
Imports StaffBrokerFunctions


Namespace DotNetNuke.Modules.StaffDirectory
    Partial Class ViewStaffDirectory
        Inherits Entities.Modules.PortalModuleBase

        Dim dStaff As New AgapeStaffDataContext
        Dim dBroke As New StaffBrokerDataContext
        '    Dim d As New DNNProfileDataContextDataContext

     
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                ' Dim d As 'New DNNProfileDataContextDataContext

                Dim excludelist As String() = {"Ex-Staff", "Foreign Staff", "Other"}
                Dim excludes = From c In dBroke.AP_StaffBroker_Staffs Where excludelist.Contains(c.AP_StaffBroker_StaffType.Name) Select c.UserId1
                Dim excludes2 = From c In dBroke.AP_StaffBroker_Staffs Where excludelist.Contains(c.AP_StaffBroker_StaffType.Name) And c.UserId2 > 0 And Not c.UserId2 Is Nothing Select CInt(c.UserId2)
                excludes = excludes.Union(excludes2)
                Dim allStaff = GetStaff(excludes.ToArray)
                Dim stafflist = From c In allStaff Select DisplayName = (c.LastName & ", " & c.FirstName), UserId = c.UserID Order By DisplayName

                If Request.QueryString("uid") <> "" Then
                    ListBox1.DataSource = From c In stafflist Order By c.DisplayName
                    ListBox1.DataBind()
                    If ListBox1.Items.Count > 0 Then
                        ListBox1.SelectedValue = CInt(Request.QueryString("uid"))
                    Else
                        ContactPanel.Visible = False
                    End If

                ElseIf Request.QueryString("search") <> "" Then
                    ListBox1.DataSource = From c In stafflist Order By c.DisplayName
                    SearchBox.Text = Request.QueryString("search")
                    ListBox1.DataBind()
                    If ListBox1.Items.Count > 0 Then
                        ListBox1.SelectedIndex = 0
                    Else
                        ContactPanel.Visible = False
                    End If
                Else
                    ListBox1.DataSource = stafflist
                    ListBox1.DataBind()
                    If ListBox1.Items.Count > 0 Then
                        ListBox1.SelectedIndex = 0
                    Else
                        ContactPanel.Visible = False
                    End If
                End If
            End If

            If (ListBox1.SelectedValue <> "") Then
                LoadValues()
            End If
        End Sub


        Protected Sub LoadValues()
            Dim objUserInfo = UserController.GetUserById(PortalId, CInt(ListBox1.SelectedValue))
            ' Dim r = From c In d.Users Where c.UserID = CInt(ListBox1.SelectedValue)
            If Not objUserInfo Is Nothing Then
                FirstName.Text = objUserInfo.FirstName
                LastName.Text = objUserInfo.LastName
                Email.Text = objUserInfo.Email
                Email.NavigateUrl = "mailto:" & objUserInfo.Email

                Address.Text = objUserInfo.Profile.GetPropertyValue("Street") & "<br />" _
                  & IIf(objUserInfo.Profile.GetPropertyValue("Unit") = "", "", objUserInfo.Profile.GetPropertyValue("Unit") & "<br />") _
                  & IIf(objUserInfo.Profile.GetPropertyValue("City") = "", "", objUserInfo.Profile.GetPropertyValue("City") & "<br />") _
                  & IIf(objUserInfo.Profile.GetPropertyValue("Region") = "", "", objUserInfo.Profile.GetPropertyValue("Region") & "<br />") _
                  & IIf(objUserInfo.Profile.GetPropertyValue("Country") = "", "", objUserInfo.Profile.GetPropertyValue("Country") & "<br />") _
                  & IIf(objUserInfo.Profile.GetPropertyValue("PostalCode") = "", "", objUserInfo.Profile.GetPropertyValue("PostalCode") & "<br />")

                HomePhone.Text = objUserInfo.Profile.GetPropertyValue("Telephone")
                'WorkPhone.Text = objUserInfo.Profile.GetPropertyValue("WorkPhone")
                MobilePhone.Text = objUserInfo.Profile.GetPropertyValue("Cell")

                If (objUserInfo.Profile.GetPropertyValue("DOB") <> "") Then
                    Dim BDay As Date = objUserInfo.Profile.GetPropertyValue("DOB")
                    Birthday.Text = BDay.Day & " " & BDay.ToString("MMM")
                End If



            End If

           
          
            ProfileImage.ImageUrl = "~/DesktopModules/AgapeUK/StaffDirectory/GetImage.aspx?size=200&UserId=" & CInt(ListBox1.SelectedValue)

            Dim s = GetStaffMember(CInt(ListBox1.SelectedValue))
            'Dim s = From c In dStaff.Agape_Staff_Finances Where c.UserId1 = CInt(ListBox1.SelectedValue) Or c.USerId2 = CInt(ListBox1.SelectedValue)
            FamilyPanel.Visible = False

            If Not s Is Nothing Then
                Dim theOtherUserId = s.UserId2
                If s.UserId2 = CInt(ListBox1.SelectedValue) Then
                    theOtherUserId = s.UserId1
                    JobTitle.Text = GetStaffProfileProperty(s.StaffId, "JobTitle2")
                Else
                    JobTitle.Text = GetStaffProfileProperty(s.StaffId, "JobTitle1")
                End If

                



                If s.UserId2 > 0 Then
                    objUserInfo = UserController.GetUserById(0, theOtherUserId)
                    Spouse.Text = objUserInfo.FirstName
                    FamilyPanel.Visible = True
                ElseIf s.UserId2 = -1 Then

                    Spouse.Text = GetStaffProfileProperty(s.UserId2, "SpouseName")
                    FamilyPanel.Visible = True


                End If

                Dim Children = From c In dBroke.AP_StaffBroker_Childrens Where c.StaffId = s.StaffId Order By c.Birthday

                If Children.Count > 0 Then
                    ChildrenPanel.Visible = True
                    For Each row In Children
                        Dim Age As Integer
                        If DateTime.Today.Month < row.Birthday.Month Or DateTime.Today.Month = row.Birthday.Month And DateTime.Today.Day < row.Birthday.Day Then
                            Age = DateTime.Today.Year - row.Birthday.Year - 1
                        Else
                            Age = DateTime.Today.Year - row.Birthday.Year
                        End If

                        ChildrenPH.Controls.Add(New LiteralControl("<tr><td>" & row.FirstName & "</td><td>" & row.Birthday.ToString("dd MMM") & "</td><td>" & IIf(Age < 21, Age, "") & "</td></tr>"))
                    Next
                Else
                    ChildrenPanel.Visible = False
                End If

            End If

        End Sub


        Protected Sub SearchBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchBtn.Click
            ' Dim d As New DNNProfileDataContextDataContext

            Dim excludelist As String() = {"Ex-Staff", "Foreign Staff", "Other"}
            Dim excludes = From c In dBroke.AP_StaffBroker_Staffs Where excludelist.Contains(c.AP_StaffBroker_StaffType.Name) Select c.UserId1
            Dim excludes2 = From c In dBroke.AP_StaffBroker_Staffs Where excludelist.Contains(c.AP_StaffBroker_StaffType.Name) And c.UserId2 > 0 And Not c.UserId2 Is Nothing Select CInt(c.UserId2)
            excludes = excludes.Union(excludes2)
            Dim allStaff = GetStaff(excludes.ToArray)
            Dim stafflist = From c In allStaff Select DisplayName = (c.LastName & ", " & c.FirstName), UserId = c.UserID Order By DisplayName

            ListBox1.DataSource = stafflist
            ListBox1.DataBind()
            If ListBox1.Items.Count > 0 Then
                ListBox1.SelectedIndex = 0
                LoadValues()
            Else
                ContactPanel.Visible = False
            End If

        End Sub
    End Class
End Namespace
