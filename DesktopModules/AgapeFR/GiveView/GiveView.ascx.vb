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
Imports System.ComponentModel
Imports System.Drawing
Imports System.Text
Imports System.Windows.Forms
Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports Cart
Imports Give
Imports StaffBrokerFunctions
Imports MembershipProvider = DotNetNuke.Security.Membership.MembershipProvider

Namespace DotNetNuke.Modules.AgapeFR.GiveView
    Partial Class GiveView
        Inherits Entities.Modules.PortalModuleBase
        Public loggedin As Boolean


#Region "Page Events"
        Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
            Page.Title = "Agapé - " & Title.Text
        End Sub
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'Translate the page
            SetTranslate()
            'Hide Add to Cart Button - should be optional.
            btnCarte.Visible = False
            If Not Me.IsPostBack Then
                'add the css to pick up fields from client side
                AddCSS()
                'check if the user's logged in
                If Me.UserId > 0 Then
                    loggedin = True
                    'Read in fields if logged in
                    Dim objUser As DotNetNuke.Entities.Users.UserInfo = DotNetNuke.Entities.Users.UserController.GetUserById(PortalId, Me.UserId)
                    TxtFirstName.Text = objUser.FirstName
                    TxtLastName.Text = objUser.LastName
                    TxtEmail.Text = objUser.Email
                    TxtConfEmail.Text = objUser.Email
                    TxtTelephone.Text = objUser.Profile.Telephone
                    TxtMobile.Text = objUser.Profile.Cell
                    TxtStreet1.Text = objUser.Profile.Street
                    TxtStreet2.Text = objUser.Profile.Unit
                    TxtCity.Text = objUser.Profile.City
                    TxtRegion.Text = objUser.Profile.Region
                    TxtPostCode.Text = objUser.Profile.PostalCode
                    cboCountry.SelectedValue = objUser.Profile.Country
                    'thelogincont.Style("Display") = "none"
                Else
                    loggedin = False
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
                        ViewState("imageurl") = StaffBrokerFunctions.GetStaffJointPhoto(staff.First.StaffId)
                        theImage1.ImageUrl = ViewState("imageurl")
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
            End If
            theImage1.ImageUrl = ViewState("imageurl")
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
            lblWantGive.Text = Translate("WantGive")
            lblCreditCard.Text = Translate("lblCreditCard")
            lblCheque.Text = Translate("lblCheque")
            lblFrequency.Text = Translate("lblFrequency")
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
            LblConfEmail.Text = Translate("ConfeMail")
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
            lblIBAN.Text = Translate("IBAN")
            lblBankInfo.Text = Translate("BankInfo")
            btnGoBank.Text = Translate("GoBank")
            lblSummaryLeft.Text = Translate("lblSummaryLeft")
            lblSummaryRight.Text = Translate("lblSummaryRight")
            lblSummaryInfo1.Text = Translate("lblSummaryInfo")
            lblSumTextFirst.Text = Translate("FirstName")
            lblSumTextLast.Text = Translate("LastName")
            lblSumTextStreet1.Text = Translate("Street1")
            lblSumTextStreet2.Text = Translate("Street2")
            lblSumTextCity.Text = Translate("City")
            lblSumTextCountry.Text = Translate("Country")
            lblSumTextRegion.Text = Translate("Region")
            lblSumTextPostal.Text = Translate("PostCode")
            lblSumTextEmail.Text = Translate("eMail")
            lblSumTextMobile.Text = Translate("Mobile")
            lblSumTextPhone.Text = Translate("Telephone")
            lblSumTextBankName.Text = Translate("Bank")
            lblSumTextBankAddress1.Text = Translate("BankSt1")
            lblSumTextBankAddress2.Text = Translate("BankSt2")
            lblSumTextBankPostal.Text = Translate("BankPostal")
            lblSumTextBankCity.Text = Translate("BankCity")
            lblSumTextBankIBAN.Text = Translate("IBAN")
            lblLinkPDF.Text = Translate("lblLinkPDF")
        End Sub
        Private Sub AddCSS()
            rblFrequency.CssClass = rblFrequency.CssClass & " rbFreq"
            tbAmount.CssClass = tbAmount.CssClass & " tbAmt"
            rblMethod.CssClass = rblMethod.CssClass & " rblMeth"

        End Sub

        Protected Sub Page_Unload(sender As Object, e As EventArgs) Handles Me.Unload
            Dim blah As String = "vide"
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
                lblOOError.Text = Translate("AmtError")
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
                UpdateUser()
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
                    Response.Redirect(NavigateURL(x.TabID, "", "giveto=" + shortcut))
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
                    insert.acNo = tbIBAN.Text
                    'TODO create give message box for Virement
                    insert.GiveMessage = "Default Give Message!"
                    insert.Status = 0
                    insert.TypeId = RowId.Value
                    d.Agape_Give_BankTransfers.InsertOnSubmit(insert)
                    d.SubmitChanges()
                    UpdateUser()
                    HyperLink1.NavigateUrl = ("/DesktopModules/AgapeFR/GiveView/OutputPdf.aspx?SOID=" & insert.Reference)
                    hfSONextStep.Value = 1
                Else
                    lblOOError.Text = "No donation type in the db"
                    lblOOError.Visible = True
                End If
            End If
        End Sub
        Protected Sub UpdateUser()
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim theUser = UserController.GetUserById(PS.PortalId, UserId)
            theUser.FirstName = TxtFirstName.Text
            theUser.LastName = TxtLastName.Text
            theUser.Email = TxtEmail.Text
            theUser.Profile.Cell = TxtMobile.Text
            theUser.Profile.Telephone = TxtTelephone.Text
            theUser.Profile.Street = TxtStreet1.Text
            theUser.Profile.Unit = TxtStreet2.Text
            theUser.Profile.City = TxtCity.Text
            'theUser.Profile.Country = cboCountry.SelectedValue
            theUser.Profile.Region = TxtRegion.Text
            theUser.Profile.PostalCode = TxtPostCode.Text
            MembershipProvider.Instance().UpdateUser(theUser)
        End Sub
#End Region



    End Class
End Namespace