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
Imports Cart
Imports Give
Imports StaffBrokerFunctions

Namespace DotNetNuke.Modules.AgapeFR.GiveView
    Partial Class GiveView
        Inherits Entities.Modules.PortalModuleBase

#Region "Page Events"
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
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load

            'Translate the page
            SetTranslate()
            'add the css to pick up fields from client side
            AddCSS()
            'check if the user's logged in
            If Me.UserId > 0 Then
                hfLoggedIn.Value = "True"
                btnGoBank.Visible = True
                btnGoUserBank.Visible = False
                'Read in fields if logged in
                Dim objUser As DotNetNuke.Entities.Users.UserInfo = DotNetNuke.Entities.Users.UserController.GetUserById(PortalId, Me.UserId)
                TxtFirstName.Text = objUser.FirstName
                TxtLastName.Text = objUser.LastName
                TxtEmail.Text = objUser.Email
                TxtTelephone.Text = objUser.Profile.Telephone
                TxtMobile.Text = objUser.Profile.Cell
                TxtStreet1.Text = objUser.Profile.Street
                TxtStreet2.Text = objUser.Profile.Unit
                TxtCity.Text = objUser.Profile.City
                TxtRegion.Text = objUser.Profile.Region
                TxtPostCode.Text = objUser.Profile.PostalCode
                cboCountry.SelectedValue = objUser.Profile.Country
                'lblPassword.Visible = False
                'tbPassword.Visible = False
                login.Style("Display") = "none"
            Else
                hfLoggedIn.Value = "False"
                btnGoBank.Visible = False
                btnGoUserBank.Visible = True
            End If

            'Find the giving type and display the title of the page
            ShowProject.Value = 0
            If Request.QueryString("giveto") <> "" Then
                Dim dBroke As New StaffBrokerDataContext
                Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.AP_StaffBroker_StaffProfiles.Where(Function(p) (p.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "GivingShortcut")).First.PropertyValue = Request.QueryString("giveto"))

                'first try staff
                If staff.Count > 0 Then
                    'Detect if UnNamed - if so use giving shortcut instead
                    If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                        Title.Text = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
                    Else
                        Title.Text = ConvertDisplayToSensible(staff.First.DisplayName)
                        hfUserId1.Value = staff.First.UserId1
                    End If
                    theImage1.ImageUrl = StaffBrokerFunctions.GetStaffJointPhoto(staff.First.StaffId)
                    Dim GiveText = GetStaffProfileProperty(staff.First.StaffId, "GivingText")
                    RowId.Value = staff.First.StaffId
                    DonationType.Value = "Staff"
                    Return
                End If

                'Second Try Department/Ministry
                Dim Dept = From c In dBroke.AP_StaffBroker_Departments Where c.GivingShortcut = Request.QueryString("giveto")
                If Dept.Count > 0 Then
                    Title.Text = Dept.First.Name
                    DonationType.Value = "Dept"
                    RowId.Value = Dept.First.CostCenterId
                    Return
                Else
                    badquery()
                End If
            Else
                badquery()
            End If

        End Sub
        Protected Sub badquery()
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = StaffBrokerFunctions.GetSetting("GivingTabId", PortalId)
            If Not x = "" Then
                Response.Redirect(NavigateURL(CInt(x)))
            End If
        End Sub
        Private Sub SetTranslate()
            rblFrequency.Items.Item(0).Text = Translate("ListFreqZero")
            rblFrequency.Items.Item(1).Text = Translate("ListFreqOne")
            rblFrequency.Items.Item(2).Text = Translate("ListFreqTwo")
            rblFrequency.Items.Item(3).Text = Translate("ListFreqThree")
            rblFrequency.Items.Item(4).Text = Translate("ListFreqFour")
            rblLogType.Items.Item(0).Text = Translate("ListLogZero")
            rblLogType.Items.Item(1).Text = Translate("ListLogOne")
            rblLogType.Items.Item(2).Text = Translate("ListLogTwo")
            lblWantGive.Text = Translate("WantGive")
            Dim giveName As String = ""
            If Request.QueryString("giveto") <> "" Then
                Dim dBroke As New StaffBrokerDataContext
                Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.AP_StaffBroker_StaffProfiles.Where(Function(p) (p.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "GivingShortcut")).First.PropertyValue = Request.QueryString("giveto"))
                If staff.Count > 0 Then
                    If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                        giveName = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
                    Else
                        giveName = ConvertDisplayToSensible(staff.First.DisplayName)
                    End If
                End If
            End If
            giveName = ChangeName(giveName)
            hfGiveToName.Value = giveName
            lblTo.Text = GetSetting("Currency", PortalId) & " " & Translate("To") & " " & giveName
            rblMethod.Items.Item(0).Text = Translate("rblMethZero")
            rblMethod.Items.Item(1).Text = Translate("rblMethOne")
            rblMethod.Items.Item(2).Text = Translate("rblMethTwo")
            lblOneOffChoose.Text = Translate("OneOffPre")
            btnCarte.Text = Translate("AddToCart")
            btnCheckout.Text = Translate("Checkout")
            lblAddedToCart.Text = Translate("AddedToCart")
            LblEmail.Text = Translate("eMail")
            LblFirstName.Text = Translate("FirstName")
            LblLastName.Text = Translate("LastName")
            LblMobile.Text = Translate("Mobile")
            LblTelephone.Text = Translate("Telephone")
            LblStreet1.Text = Translate("Street1")
            LblStreet2.Text = Translate("Street2")
            LblCity.Text = Translate("City")
            LlbCountry.Text = Translate("Country")
            LblRegion.Text = Translate("Region")
            LblPostCode.Text = Translate("PostCode")
            lblBank.Text = Translate("Bank")
            lblBankStreet1.Text = Translate("BankSt1")
            lblBankStreet2.Text = Translate("BankSt2")
            lblBankCity.Text = Translate("BankCity")
            lblBankPostal.Text = Translate("BankPostal")
            lblBankAcc.Text = Translate("BankAcc")
            lblBankInfo.Text = Translate("BankInfo")
            lblPassword.Text = Translate("Password")
            lblUserName.Text = Translate("UserName")
            btnTheKey.Text = Translate("TheKey")
            btnUserLogin.Text = Translate("UserLogin")
            btnGoBank.Text = Translate("GoBank")
            btnGoUserBank.Text = Translate("GoBank")
        End Sub
        Private Sub AddCSS()
            rblFrequency.CssClass = rblFrequency.CssClass & " rbFreq"
            rblLogType.CssClass = rblLogType.CssClass & " rblLog"
            tbAmount.CssClass = tbAmount.CssClass & " tbAmt"
            rblMethod.CssClass = rblMethod.CssClass & " rblMeth"

        End Sub
#End Region
#Region "Functions"
        Private Function ChangeName(ByVal inName As String) As String
            If inName.IndexOf("&") > 0 Then
                inName = inName.Replace("&", Translate("NameAnd"))
            End If
            Return inName
        End Function
        Public Function ConvertDisplayToSensible(ByVal CurrentDisp As String) As String
            Dim Output As String = ""

            If CurrentDisp.IndexOf(",") > -1 And CurrentDisp.Contains(",") Then
                Output = CurrentDisp.Substring(CurrentDisp.IndexOf(",") + 2) & " " & CurrentDisp.Substring(0, CurrentDisp.IndexOf(","))
            Else
                Output = CurrentDisp
            End If

            Return Output
        End Function
        Public Function Translate(ByVal ResourceString As String) As String
            Return DotNetNuke.Services.Localization.Localization.GetString(ResourceString & ".Text", LocalResourceFile)
        End Function
        'Private Function CreateUser(ByVal Surname As String, ByVal Forname As String, ByVal Tel As String, ByVal Email As String) As String
        '    'Dim objUser As New DotNetNuke.Entities.Users.UserInfo
        '    'objUser.FirstName = "Chris:"
        '    'objUser.LastName = "Carter"
        '    'objUser.DisplayName = objUser.FirstName & " " & objUser.LastName
        '    'objUser.Username = "thesunisoftenout@googlemail.com"
        '    'objUser.Email = "thesunisoftenout@googlemail.com"
        '    'DotNetNuke.Entities.Users.UserController.CreateUser(objUser)
        '    'Return "Fine"
        'End Function
        Private Function GetUniqueCode() As String

            Dim allChars As String = "ABCDEFGHJKLMNPQRTVWXYZ2346789"

            Dim GotUniqueCode As Boolean = False
            Dim uniqueCode As String = ""
            Dim str As New System.Text.StringBuilder
            Dim xx As Integer
            While Not GotUniqueCode


                str = New System.Text.StringBuilder
                For i As Byte = 1 To 6 'length of req key

                    Randomize()
                    xx = Rnd() * (Len(allChars) - 1) 'number of rawchars
                    str.Append(allChars.Trim.Chars(xx))
                Next

                uniqueCode = str.ToString

                GotUniqueCode = isUniqueCode(uniqueCode)

            End While

            Return uniqueCode

        End Function
        Private Function isUniqueCode(ByVal code As String) As Boolean
            Dim d As New GiveDataContext
            Dim count = (From c In d.Agape_Give_BankTransfers Where c.Reference = code).Count
            Return IIf(count = 0, True, False)
        End Function
#End Region
#Region "Buttons"
        ' TODO Changer les valeurs DonationType en utilisant les constantes CartFunctions.DonationType
        Protected Sub btnCheckout_Click(sender As Object, e As System.EventArgs) Handles btnCheckout.Click

            If tbAmount.Text = "" Then
                lblOOError.Text = "Please enter an amount into the box."
                lblOOError.Visible = True
                theHiddenTabIndex.Value = 1
            Else
                lblOOError.Visible = False
                If DonationType.Value = "Staff" Then
                    DonateToStaff()
                ElseIf DonationType.Value = "Dept" Then
                ElseIf DonationType.Value = "Project" Then
                    DonateToProject()
                End If
                Dim mc As New DotNetNuke.Entities.Modules.ModuleController
                Dim x = mc.GetModuleByDefinition(PortalId, "frCart")
                If Not x Is Nothing Then
                    If Not x.TabID = Nothing Then
                        Response.Redirect(NavigateURL(x.TabID))
                    End If
                End If
            End If
        End Sub
        Protected Sub btnCarte_Click(sender As Object, e As System.EventArgs) Handles btnCarte.Click
            If tbAmount.Text = "" Then
                lblOOError.Text = "Please enter an amount into the box."
                lblOOError.Visible = True
                theHiddenTabIndex.Value = 1
            Else
                lblOOError.Visible = False
                If DonationType.Value = "Staff" Then
                    DonateToStaff()
                ElseIf DonationType.Value = "Dept" Then
                ElseIf DonationType.Value = "Project" Then
                    DonateToProject()
                End If
                hfDonBasket.Value = 1
            End If
        End Sub
        Protected Sub btnBio_Click(sender As Object, e As System.EventArgs) Handles btnBio.Click
            Dim shortcut = Request.QueryString("giveto")
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim x = mc.GetModuleByDefinition(PortalId, "frPresentationPage")
            If Not x Is Nothing Then
                If Not x.TabID = Nothing Then
                    Response.Redirect(NavigateURL(x.TabID) & "?giveto=" & shortcut)
                End If
            End If
        End Sub

        Private Sub DonateToStaff()

            'TODO Texte à traduire pour le titre
            CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, "Donation to " & hfGiveToName.Value, DestinationType.Staff, CInt(RowId.Value), CInt(tbAmount.Text), theDonationComment.Text)

        End Sub
        Private Sub DonateToDept()

            'TODO Texte à traduire pour le titre
            'CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, "Donation to " & givetoName.Text, DestinationType.Department, CInt(RowId.Value), CInt(Ammount.Text), theDonationComment.Text)

        End Sub
        Private Sub DonateToProject()

            'TODO Texte à traduire pour le titre
            'CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, "Donation to " & givetoName.Text, DestinationType.Project, CInt(RowId.Value), CInt(Ammount.Text), theDonationComment.Text)

        End Sub
        Protected Sub btnGoUserBank_Click(sender As Object, e As EventArgs) Handles btnGoUserBank.Click

            'Dim objUserInfo As New UserInfo()
            'objUserInfo.FirstName = TxtFirstName.Text
            'objUserInfo.LastName = TxtLastName.Text
            'objUserInfo.DisplayName = TxtFirstName.Text & " " & TxtLastName.Text
            'objUserInfo.Username = TxtEmail.Text
            'objUserInfo.PortalID = PortalId
            'objUserInfo.Membership.Password = UserController.GeneratePassword(9)
            'objUserInfo.Email = TxtEmail.Text
            'Dim objUserCreateStatus = UserController.CreateUser(objUserInfo)
            'If objUserCreateStatus = Security.Membership.UserCreateStatus.Success Then
            'UserController.UserLogin(PortalSettings.PortalId, objUserInfo, PortalSettings.PortalName, DotNetNuke.Services.Authentication.AuthenticationLoginBase.GetIPAddress(), False)
            'SetProfileProperty("Street", objUserInfo.UserID, tbAddress1.Text)
            'SetProfileProperty("Unit", objUserInfo.UserID, tbAddress2.Text)
            'SetProfileProperty("County", objUserInfo.UserID, tbCounty.Text)
            'SetProfileProperty("City", objUserInfo.UserID, tbCity.Text)
            'SetProfileProperty("PostalCode", objUserInfo.UserID, tbPostCode.Text)
            'SetProfileProperty("Title", objUserInfo.UserID, tbTitle.Text)
            'Else
            'lblRegisterError.Text = "Unable to create account: " & objUserCreateStatus.ToString
            'lblRegisterError.Visible = True
            'End If
        End Sub
        Protected Sub btnGoBank_Click(sender As Object, e As EventArgs) Handles btnGoBank.Click
            If tbAmount.Text = 0 Or tbAmount.Text = "" Then
                lblOOError.Text = Translate("AmtError")
                lblOOError.Visible = True
            Else
                Dim d As New GiveDataContext
                Dim q = From c In d.Agape_Give_DonationTypes Where c.DonationTypeName = DonationType.Value Select c.DonationTypeNumber
                If q.Count > 0 Then
                    Dim insert As New Agape_Give_BankTransfer
                    insert.DonationType = q.First
                    insert.DonorId = Me.UserId
                    insert.Reference = GetUniqueCode()
                    hfUniqueRef.Value = insert.Reference
                    insert.Amount = tbAmount.Text
                    insert.BankCity = tbBankCity.Text
                    insert.BankName = tbBank.Text
                    insert.BankPostal = tbBankPostal.Text
                    insert.BankStreet1 = tbBankStreet1.Text
                    insert.BankStreet2 = tbBankStreet2.Text
                    insert.Frequency = rblFrequency.SelectedValue
                    'TODO create give message box for Vierment
                    insert.GiveMessage = ""
                    insert.Status = 0
                    insert.TypeId = RowId.Value
                    d.Agape_Give_BankTransfers.InsertOnSubmit(insert)
                    d.SubmitChanges()
                End If

            End If


        End Sub
#End Region








        'TRENT: eat a cookie
        'Protected Sub downloadPDF_Click(sender As Object, e As System.EventArgs) Handles downloadPDF.Click

        'End Sub

        'Protected Sub btnSOContinue_Click(sender As Object, e As System.EventArgs) Handles btnSOContinue.Click
        '    'Validate
        '    If tbAccNum.Text = "" Or tbSOAmount.Text = "" Or tbSort1.Text = "" Or tbSort2.Text = "" Or tbSort3.Text = "" Then
        '        lblSOError.Text = "Please make sure all of the boxes are filled in."
        '        lblSOError.Visible = True
        '        theHiddenTabIndex.Value = 0
        '    Else
        '        'Create the SO
        '        lblSOError.Visible = False
        '        Session("SortCode") = tbSort1.Text & tbSort2.Text & tbSort3.Text
        '        Session("Amount") = CDbl(tbSOAmount.Text)
        '        Session("Frequency") = CInt(rblFrequency.SelectedValue)
        '        Session("AccountNo") = tbAccNum.Text
        '        Session("GiveToType") = CStr(DonationType.Value)
        '        Session("RefId") = CInt(RowId.Value)
        '        Session("StartDate") = CDate(dtStartDate.Text)
        '        Session("SOGUID") = Guid.NewGuid().ToString
        '        Response.Redirect(EditUrl("SOLogin"))
        '    End If
        'End Sub

    End Class
End Namespace