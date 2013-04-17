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
Imports DotNetNuke.Common.Lists
Imports MembershipProvider = DotNetNuke.Security.Membership.MembershipProvider
Imports DotNetNuke.Services.Mail
Imports DotNetNuke.Services.FileSystem

Namespace DotNetNuke.Modules.AgapeFR.GiveView
    Partial Class GiveView
        Inherits Entities.Modules.PortalModuleBase
        Public loggedin As Boolean
        Public givename As String

#Region "Page Events"
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'Translate the page
            SetTranslate()
            Dim ctlEntry As ListController = New ListController
            cboCountry.DataSource = ctlEntry.GetListEntryInfoItems("Country")
            cboCountry.DataBind()
            doncontinue.Style("Display") = "none"
            summaryDon.Style("Display") = "none"
            confirmation.Visible = False
            pleasewait.Style("Display") = "none"
            If Not Me.IsPostBack Then
                'add the css to pick up fields from client side
                AddCSS()
                'check if the user is logged in
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
                    Dim mycountry As String = "FR"
                    Dim lc As New Lists.ListController
                    If Not objUser.Profile.Country Is Nothing Then
                        Dim c = lc.GetListEntryInfoItems("Country").Where(Function(x) objUser.Profile.Country.EndsWith(x.Text)).Select(Function(x) x.Value)
                        mycountry = c.First
                    End If
                    cboCountry.SelectedValue = mycountry
                    thelogincont.Style("Display") = "none"
                Else
                    loggedin = False
                End If
                'Find the giving type and display the title of the page
                If Request.QueryString("giveto") <> "" Then
                    Dim dBroke As New StaffBrokerDataContext
                    Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.AP_StaffBroker_StaffProfiles.Where(Function(p) (p.AP_StaffBroker_StaffPropertyDefinition.PropertyName = "GivingShortcut")).First.PropertyValue = Request.QueryString("giveto"))
                    'first try staff
                    If staff.Count > 0 Then
                        'Detect if UnNamed - if so use giving shortcut instead
                        If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                            givename = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
                        Else
                            givename = ChangeName(staff.First.DisplayName)
                        End If
                        Title.Text = givename
                        ViewState("imageurl") = StaffBrokerFunctions.GetStaffJointPhoto(staff.First.StaffId)
                        theImage1.ImageUrl = ViewState("imageurl")
                        RowId.Value = staff.First.StaffId
                        DonationType.Value = DestinationType.Staff
                        hfGiveToName.Value = givename
                        lblTo.Text = GetSetting("Currency", PortalId) & " " & Translate("To") & " " & givename
                        Return
                    End If
                    'Second Try Department/Ministry
                    Dim Dept = From c In dBroke.AP_StaffBroker_Departments Where c.GivingShortcut = Request.QueryString("giveto")
                    If Dept.Count > 0 Then
                        givename = Dept.First.Name
                        Title.Text = givename
                        ViewState("imageurl") = StaffBrokerFunctions.GetDeptPhoto(Dept.First.CostCenterId)
                        theImage1.ImageUrl = ViewState("imageurl")
                        DonationType.Value = DestinationType.Department
                        RowId.Value = Dept.First.CostCenterId
                        hfGiveToName.Value = givename
                        lblTo.Text = GetSetting("Currency", PortalId) & " " & Translate("To") & " " & givename
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
        Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
            Page.Title = "Agapé - " & Title.Text

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
            lblFrequency.Text = Translate("lblFrequency")
            rblMethod.Items.Item(0).Text = Translate("rblMethZero")
            rblMethod.Items.Item(1).Text = Translate("rblMethOne")
            rblMethod.Items.Item(2).Text = Translate("rblMethTwo")
            lblOneOffChoose.Text = Translate("OneOffPre")
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
            lblIBAN.Text = Translate("IBAN")
            lblBankInfo.Text = Translate("BankInfo")
            btnFinishDon.Text = Translate("btnFinishDon")
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
            lblSumTextBankIBAN.Text = Translate("IBAN")
            lblLinkPDF.Text = Translate("lblLinkPDF")
            btnNoScriptGo.Text = Translate("btnFinishDon")
            ValFreq.ErrorMessage = Translate("ValFreq")
            ValAmt.ErrorMessage = Translate("ValAmt")
            ValAmtRange.ErrorMessage = Translate("ValAmtRange")
            ValFirstName.ErrorMessage = Translate("ValFirstName")
            ValLastName.ErrorMessage = Translate("ValLastName")
            ValEmail.ErrorMessage = Translate("ValEmail")
            ValEmailExp.ErrorMessage = Translate("ValEmailExp")
            ValConfEmail.ErrorMessage = Translate("ValConfEmail")
            ValConfEmailComp.ErrorMessage = Translate("ValConfEmail")
            ValMobileExp.ErrorMessage = Translate("ValMobileExp")
            ValTelephoneExp.ErrorMessage = Translate("ValTelephoneExp")
            ValStreet1.ErrorMessage = Translate("ValStreet1")
            ValPostCode.ErrorMessage = Translate("ValPostCode")
            ValPostCodeExp.ErrorMessage = Translate("ValPostCodeExp")
            ValCity.ErrorMessage = Translate("ValCity")
            ValMethod.ErrorMessage = Translate("ValMethod")
            ValSumDon.HeaderText = Translate("ValSumDon")
            ValSumBank.HeaderText = Translate("ValSumDon")
            ValIBAN.ErrorMessage = Translate("ValIBAN")
        End Sub
        Private Sub AddCSS()
            rblFrequency.CssClass = rblFrequency.CssClass & " rbFreq"
            tbAmount.CssClass = tbAmount.CssClass & " tbAmt"
            rblMethod.CssClass = rblMethod.CssClass & " rblMeth"
        End Sub
#End Region
#Region "Functions"
        'validate a given validationgroup
        Private Function IsGroupValid(ByVal valgroup As String) As String
            Page.Validate(valgroup)
            Dim validator As BaseValidator
            For Each validator In Page.GetValidators(valgroup)
                If Not validator.IsValid Then
                    Return False
                End If
            Next
            Return True
        End Function
        Private Function ChangeName(ByVal inName As String) As String
            If inName.IndexOf("&") > 0 Then
                inName = inName.Replace("&", Translate("NameAnd"))
            End If
            Return inName
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
        Protected Sub GoBank()
            Dim d As New GiveDataContext
            Dim insert As New Agape_Give_BankTransfer
            insert.PortalID = PortalId
            insert.DonationType = DonationType.Value
            insert.DonorId = Me.UserId
            insert.Reference = GetUniqueCode()
            hfUniqueRef.Value = insert.Reference
            insert.Amount = tbAmount.Text
            Dim selFreq As Integer = rblFrequency.SelectedValue
            insert.Frequency = selFreq
            insert.SetupDate = Now
            'GiveMethod 1 for virement, 2 for cheque
            insert.GiveMethod = rblMethod.SelectedIndex
            insert.acNo = tbIBAN.Text
            insert.GiveMessage = theDonationComment.Text
            insert.Status = 0
            insert.TypeId = RowId.Value
            d.Agape_Give_BankTransfers.InsertOnSubmit(insert)
            d.SubmitChanges()
            UpdateUser()
            Try
                'Create the Donor Email                
                Dim pdflink As String = ("/DesktopModules/AgapeFR/GiveView/OutputPdf.aspx?SOID=" & insert.Reference)
                Dim theFreq As String = ""
                If selFreq = 99 Then '99 is single donation
                    theFreq = ""
                ElseIf selFreq = 1 Then 'every one month
                    theFreq = Translate("FreqParaZero")
                ElseIf selFreq = 3 Then 'every three months
                    theFreq = Translate("FreqParaOne")
                ElseIf selFreq = 6 Then 'every six months
                    theFreq = Translate("FreqParaTwo")
                ElseIf selFreq = 12 Then 'every twelve months
                    theFreq = Translate("FreqParaThree")
                End If
                Dim reciptemplate As String = ""
                Dim donortemplate As String = ""
                If rblMethod.SelectedIndex = 1 Then 'virement
                    lblConfCheque.Visible = False
                    reciptemplate = "RecipVirementMail." & DotNetNuke.Entities.Portals.PortalController.GetPortalDefaultLanguage(PortalId)
                    donortemplate = "DonorVirementMail." & CultureInfo.CurrentCulture().ToString
                ElseIf rblMethod.SelectedIndex = 2 Then 'cheque
                    lblConfVirement.Visible = False
                    donortemplate = "DonorChequeMail." & CultureInfo.CurrentCulture().ToString
                    reciptemplate = "RecipChequeMail." & DotNetNuke.Entities.Portals.PortalController.GetPortalDefaultLanguage(PortalId)


                End If
                Dim message = Translate("NoMessage")
                If Not theDonationComment.Text = "" Then
                    message = theDonationComment.Text
                End If
                Dim mailbody = StaffBrokerFunctions.GetTemplate(donortemplate, PortalId)
                mailbody = mailbody.Replace("[NAME]", TxtFirstName.Text & " " & TxtLastName.Text).Replace("[FREQ]", theFreq).Replace("[AMOUNT]", tbAmount.Text).Replace("[RECIP]", Title.Text).Replace("[MESSAGE]", message).Replace("[PDFLINK]", pdflink).Replace("[IMAGEURL]", "sso/GetLogo.aspx")
                Dim recip As String = TxtEmail.Text
                Dim sender As String = "compta@agapefrance.org"
                Dim mailsubject As String = Translate("donoremailsubject")
                'Send the Donor Email
                SendConfirmationEmail(sender, recip, mailsubject, mailbody)
                'Set up donation recipient address
                recip = String.Empty
                'If donation to department or project, get manager email.
                If DonationType.Value = DestinationType.Department Or DonationType.Value = DestinationType.Project Then
                    Dim dBroke As New StaffBrokerDataContext
                    Dim dept As AP_StaffBroker_Department
                    dept = StaffBrokerFunctions.GetDeptByGivingShortcut(Request.QueryString("giveto"))
                    If Not dept Is Nothing Then
                        Dim deptmanageremail As String = String.Empty
                        Dim deptdelegateemail As String = String.Empty
                        If dept.CostCentreManager IsNot Nothing Then
                            Dim deptmanagerid As Integer? = dept.CostCentreManager
                            Dim deptmanager = DotNetNuke.Entities.Users.UserController.GetUserById(PortalId, deptmanagerid)
                            deptmanageremail = deptmanager.Email
                        End If
                        If dept.CostCentreDelegate IsNot Nothing Then
                            Dim deptdelegateid As Integer? = dept.CostCentreDelegate()
                            Dim deptdelegate = DotNetNuke.Entities.Users.UserController.GetUserById(PortalId, deptdelegateid)
                            deptdelegateemail = deptdelegate.Email
                        End If
                        recip = deptmanageremail & IIf(String.IsNullOrEmpty(deptdelegateemail), String.Empty, ", " & deptdelegateemail)
                    End If
                End If
                'If donation to staff, get staff email
                Dim staff As AP_StaffBroker_Staff
                If DonationType.Value = DestinationType.Staff Then
                    staff = GetStaffbyStaffId(RowId.Value)
                    Dim staffEmail1 As String = String.Empty
                    Dim staffEmail2 As String = String.Empty
                    If staff.User IsNot Nothing Then
                        staffEmail1 = staff.User.Email
                    End If
                    If staff.User2 IsNot Nothing Then
                        staffEmail2 = staff.User2.Email
                    End If
                    recip = staffEmail1 & IIf(String.IsNullOrEmpty(staffEmail2), String.Empty, ", " & staffEmail2)
                End If
                If Not String.IsNullOrEmpty(recip) Then
                    'mailsubject = Translate("recipemailsubject")
                    Dim lang = DotNetNuke.Entities.Portals.PortalController.GetPortalDefaultLanguage(PortalId)
                    mailsubject = DotNetNuke.Services.Localization.Localization.GetString("recipemailsubject.Text", LocalResourceFile, language:=lang)
                    mailbody = StaffBrokerFunctions.GetTemplate(reciptemplate, PortalId)
                    Dim donoraddress As String = TxtFirstName.Text & " " & TxtLastName.Text & "<br />" & TxtStreet1.Text & "<br />" & IIf(TxtStreet2.Text = "", "", TxtStreet2.Text & "<br />") & cboCountry.SelectedItem.Text & IIf(TxtTelephone.Text = "", "", "<br />" & TxtTelephone.Text) & IIf(TxtMobile.Text = "", "", "<br />" & TxtMobile.Text)
                    mailbody = mailbody.Replace("[LOGO]", "sso/GetLogo.aspx").Replace("[MESSAGE]", message).Replace("[ADDRESS]", donoraddress).Replace("[NAME]", Title.Text).Replace("[FREQ]", theFreq).Replace("[AMOUNT]", tbAmount.Text)
                    SendConfirmationEmail(sender, recip, mailsubject, mailbody)
                Else
                    AgapeLogger.Warn(Me.UserId, "No staff or manager/delegate email to send donation notification to.(staffid/deptid='" & RowId.Value & "')")
                End If
                HyperLink1.NavigateUrl = pdflink
            Catch e As Exception
                AgapeLogger.Warn(Me.UserId, "the email did not work." & e.ToString)
            End Try
            hfSONextStep.Value = rblMethod.SelectedIndex
            confirmation.Visible = True
            freqchoose.Visible = False
            amtchoose.Visible = False
            contact.Visible = False
            methchoose.Visible = False
            virement.Visible = False
            noscriptconf.Visible = False
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
            theUser.Profile.Country = cboCountry.SelectedItem.Text
            theUser.Profile.Region = TxtRegion.Text
            theUser.Profile.PostalCode = TxtPostCode.Text
            MembershipProvider.Instance().UpdateUser(theUser)
        End Sub
        Protected Sub SendConfirmationEmail(sender As String, recip As String, mailsubject As String, mailbody As String)
            DotNetNuke.Services.Mail.Mail.SendMail(sender, recip, "", mailsubject, mailbody, "", "HTML", "", "", "", "")
        End Sub
#End Region
#Region "Buttons"
        Protected Sub btnFinishDon_Click(sender As Object, e As EventArgs) Handles btnFinishDon.Click
            If rblMethod.SelectedIndex = "0" Then 'credit card
                CartDonation()
            ElseIf rblMethod.SelectedIndex = "1" Then 'bank transfer
                If IsGroupValid("Bank") Then
                    GoBank()
                End If
            Else 'cheque
                GoBank()
            End If
        End Sub
        Protected Sub btnNoScriptGo_Click(sender As Object, e As EventArgs) Handles btnNoScriptGo.Click
            If rblMethod.SelectedIndex = "0" Then 'credit card
                CartDonation()
            ElseIf rblMethod.SelectedIndex = "1" Then 'bank transfer
                If IsGroupValid("Bank") Then
                    GoBank()
                End If
            Else 'cheque
                GoBank()
            End If
        End Sub
        Protected Sub CartDonation()
            If DonationType.Value = DestinationType.Staff Then
                DonateToStaff()
            ElseIf DonationType.Value = DestinationType.Department Then
                DonateToDept()
            ElseIf DonationType.Value = DestinationType.Project Then
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
            CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, Translate("ccDonTo") & hfGiveToName.Value, DestinationType.Staff, CInt(RowId.Value), CInt(tbAmount.Text), theDonationComment.Text)
        End Sub
        Private Sub DonateToDept()
            CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, Translate("ccDonTo") & hfGiveToName.Value, DestinationType.Department, CInt(RowId.Value), CInt(tbAmount.Text), theDonationComment.Text)
        End Sub
        Private Sub DonateToProject()
            'TODO Texte à traduire pour le titre
            'CartFunctions.AddDonationToCart(UserId, Request.Cookies(".ASPXANONYMOUS").Value, "Donation to " & givetoName.Text, DestinationType.Project, CInt(RowId.Value), CInt(Ammount.Text), theDonationComment.Text)
        End Sub
#End Region

    End Class
End Namespace