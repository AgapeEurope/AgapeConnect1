Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

Imports DotNetNuke
Imports DotNetNuke.Security
Imports DotNetNuke.Instrumentation
Imports StaffBroker
Imports StaffBrokerFunctions
Imports Cart


Namespace DotNetNuke.Modules.AgapeFR.Cart
    Partial Class CartSummary
        Inherits Entities.Modules.PortalModuleBase

#Region "Properties"

        'Type of address edition to be processed
        Public Property Action As String
            Get
                Dim obj = Session("Action")
                If obj Is Nothing Then
                    'Initialize action depending on param in URL
                    obj = Me.Request.Params("action")
                    If obj Is Nothing Then
                        Exceptions.ProcessModuleLoadException("Invalid call to the control (action missing)", Me, Nothing)
                    End If
                End If
                Return obj
            End Get
            Private Set(ByVal value As String)
                Session("Action") = value
            End Set
        End Property

        'Cart ID
        Public Property TheCartID As Integer
            Get
                Dim obj = Session("TheCartID")
                If obj Is Nothing Then
                    Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value
                    obj = CartFunctions.GetCartID(UserId, anonCookieValue)
                End If
                Return obj
            End Get
            Private Set(ByVal value As Integer)
                Session("TheCartID") = value
            End Set
        End Property

        Protected TheCartTotals As CartFunctions.CartTotals

        Protected StrCurrencyAmountsPattern As String = "0.00"

        ' Label patterns
        Protected StrSectionTotalLabelPattern As String
        Protected StrVATLabelPattern As String

#End Region


        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            'DAVID: Cart - Check where prices should be updated (to handle different prices when the user logs in)

            ' Init shared resource file
            'DAVID: Cart - Improve translation method?
            LocalResourceFile = ApplicationPath + "/DesktopModules/AgapeFR/Cart/App_LocalResources/CartSharedResources.resx"

            'If user not connected => redirect to login page
            If UserId = -1 Then
                Response.Redirect(EditUrl("CartLogin"))
            Else
                ' Load label translations
                StrSectionTotalLabelPattern = LocalizeString("SectionTotalLabel")
                StrVATLabelPattern = LocalizeString("VATLabel")

                If Not Me.IsPostBack Then

                    'If cart is linked to a valid billing address => use it.
                    'Else if address filled in user profil and valid => use it for billing address.
                    'Otherwise => redirect to address edition page to enter billing address
                    Dim cartBillingAddress = CartFunctions.GetCartBillingAddress(TheCartID)
                    If cartBillingAddress Is Nothing Then
                        cartBillingAddress = CartFunctions.GetUserProfilAddress(UserId)
                        'Update cart with new billing address
                        CartFunctions.UpdateCartBillingAddress(TheCartID, cartBillingAddress)
                    End If
                    'If invalid address => Redirect to address edition page
                    'DAVID: Cart - Read required fiels from PortalSettings
                    '   SettingName = "addressstreet", "addresscity", "addresscountry", "addressregion", "addresspostal", "addresstelephone", "addresscell", "addressfax"
                    '   SettingValue = "N" means not required
                    Dim requiredFields = {cartBillingAddress.FullName, cartBillingAddress.Address1, cartBillingAddress.City, cartBillingAddress.PostalCode}
                    If requiredFields.Where(Function(x) x = "").Count > 0 Then
                        Response.Redirect(EditUrl("action", EditAddressActions.ModifyBillingAddress, "CartEditAddress"))
                        Exit Sub
                    End If
                    LblBillingAddress.Text = GetFormattedAddress(cartBillingAddress)

                    ' Initialize the cart totals
                    TheCartTotals = CartFunctions.GetCartTotals(TheCartID)

                    'If cart has shippable items => Show shipping address
                    If TheCartTotals.NoDispatchable Then
                        DivShippingAddressBlock.Visible = False
                        BtnCopyShippingAddress.Visible = False
                    Else
                        DivShippingAddressBlock.Visible = True

                        'If cart is linked to a valid shipping address => use it.
                        'Otherwise => use billing address
                        Dim cartShippingAddress = CartFunctions.GetCartShippingAddress(TheCartID)
                        If cartShippingAddress Is Nothing Then
                            cartShippingAddress = CartFunctions.CloneAddress(cartBillingAddress)
                            CartFunctions.UpdateCartShippingAddress(TheCartID, cartShippingAddress)
                        ElseIf cartShippingAddress.FullName = "" Or cartShippingAddress.Address1 = "" Or cartShippingAddress.City = "" Or cartShippingAddress.PostalCode = "" Then
                            'DAVID: Cart - Read required fiels from PortalSettings
                            ' Invalid address => Use billing address but keep shipping AddressBookID
                            Dim addressbookID = cartShippingAddress.AddressBookID
                            cartShippingAddress = CartFunctions.CloneAddress(cartBillingAddress)
                            cartShippingAddress.AddressBookID = addressbookID
                            CartFunctions.UpdateCartShippingAddress(TheCartID, cartShippingAddress)
                        End If
                        LblShippingAddress.Text = GetFormattedAddress(cartShippingAddress)

                        'If billing and shipping addresses are different => Show links to copy addresses from the other
                        If CartFunctions.sameAddresses(cartShippingAddress, cartBillingAddress) Then
                            BtnCopyShippingAddress.Visible = False
                            BtnCopyBillingAddress.Visible = False
                        Else
                            BtnCopyShippingAddress.Visible = True
                            BtnCopyBillingAddress.Visible = True
                        End If

                    End If

                    ' Load the list of cart contents
                    Dim theCartContents = CartFunctions.GetCartContents(TheCartID)

                    ' Check if the cart is empty
                    If theCartContents.Count > 0 Then

                        ' Display the panel for not empty cart
                        PnlNotEmptyCart.Visible = True
                        PnlEmptyCart.Visible = False

                        ' Initialize the repater to display the different lists
                        Dim theCartContentsByItemType = From c In theCartContents Group By c.ItemType Into Group
                        DrCart.DataSource = theCartContentsByItemType
                        DrCart.DataBind()

                        ' Display delivery cost if dispatchable item(s) in cart
                        If TheCartTotals.NoDispatchable Then
                            TrDeliveryCost.Visible = False
                        Else
                            TrDeliveryCost.Visible = True

                            ' Get and display the gross delivery cost
                            Dim shipGross = CDbl(IIf(TheCartTotals.ShipCost Is Nothing, 0, TheCartTotals.ShipCost)) + CDbl(IIf(TheCartTotals.ShipVAT Is Nothing, 0, TheCartTotals.ShipVAT))
                            Dim shipGrossFormatted = StaffBrokerFunctions.GetFormattedCurrency(PortalId, shipGross.ToString(StrCurrencyAmountsPattern))
                            LblDeliveryGrossAmount.Text = shipGrossFormatted

                            ' Get and display the delivery VAT if not zero
                            If TheCartTotals.ShipVAT <> 0 Then
                                Dim strbuilderShipVAT As New StringBuilder(StrVATLabelPattern)
                                Dim shipVAT = StaffBrokerFunctions.GetFormattedCurrency(PortalId, CDbl(IIf(TheCartTotals.ShipVAT Is Nothing, 0, TheCartTotals.ShipVAT)).ToString(StrCurrencyAmountsPattern))
                                strbuilderShipVAT.Replace("[amount]", shipVAT)
                                LblDeliveryVAT.Text = strbuilderShipVAT.ToString
                            End If
                        End If

                        ' Get and display the gross grand total
                        Dim grandTotalFormatted = StaffBrokerFunctions.GetFormattedCurrency(PortalId, TheCartTotals.GrandTotal.ToString(StrCurrencyAmountsPattern))
                        LblGrandTotalAmount.Text = grandTotalFormatted

                        ' Get and display the grand total VAT if not zero
                        If TheCartTotals.VATTotal <> 0 Then
                            Dim strbuilderGrandTotalVAT As New StringBuilder(StrVATLabelPattern)
                            Dim totalVAT = CDbl(IIf(TheCartTotals.VATTotal Is Nothing, 0, TheCartTotals.VATTotal)) + CDbl(IIf(TheCartTotals.ShipVAT Is Nothing, 0, TheCartTotals.ShipVAT))
                            Dim totalVATFormatted = StaffBrokerFunctions.GetFormattedCurrency(PortalId, totalVAT.ToString(StrCurrencyAmountsPattern))
                            strbuilderGrandTotalVAT.Replace("[amount]", totalVATFormatted)
                            LblGrandTotalVAT.Text = strbuilderGrandTotalVAT.ToString
                        Else
                            LblGrandTotalVAT.Text = ""
                        End If

                    Else
                        ' Display the panel for empty cart
                        PnlEmptyCart.Visible = True
                        PnlNotEmptyCart.Visible = False
                    End If

                End If
            End If
        End Sub

        Protected Sub DrCart_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles DrCart.ItemDataBound

            ' Retrieve controls from the page for the current data repeater iteration
            Dim gvCartSection = CType(e.Item.FindControl("GvCartSection"), GridView)
            Dim hfItemType = CType(e.Item.FindControl("HfItemType"), HiddenField)
            Dim TblSectionTotals = CType(e.Item.FindControl("TblSectionTotals"), HtmlTable)
            Dim LblTotalSectionGrossTitle = CType(e.Item.FindControl("LblTotalSectionGrossTitle"), Label)
            Dim LblTotalSectionGrossAmount = CType(e.Item.FindControl("LblTotalSectionGrossAmount"), Label)
            Dim LblTotalSectionVAT = CType(e.Item.FindControl("LblTotalSectionVAT"), Label)

            If Not hfItemType Is Nothing Then

                ' Get the section sub total infos
                Dim theSectionSubTotal = TheCartTotals.SubItemTotals(hfItemType.Value)

                ' Count number of different item types to be listed on the page
                Dim numberOfSections As Integer = TheCartTotals.SubItemTotals.Count

                ' Handle donations
                If theSectionSubTotal.ItemType = ItemType.Donation Then

                    ' Hide "amount" column
                    gvCartSection.Columns(5).Visible = False
                    ' Hide "unit price" column
                    gvCartSection.Columns(2).Visible = False
                    ' Hide "quantity" column
                    gvCartSection.Columns(4).Visible = False
                    ' Hide "discount" column
                    gvCartSection.Columns(3).Visible = False


                Else ' Handle any other item types

                    ' Hide "donation amount" column
                    gvCartSection.Columns(6).Visible = False

                    ' Hide discount column if no discount to be displayed
                    If theSectionSubTotal.NoDiscount Then
                        gvCartSection.Columns(3).Visible = False
                    End If

                End If

                ' Get and display the section sub totals if more than one section
                If (numberOfSections > 1) Then
                    ' Show the table with totals for the section
                    TblSectionTotals.Visible = True

                    ' Gross total
                    Dim sectionGrossTotal = theSectionSubTotal.Total + theSectionSubTotal.TotalVat
                    Dim sectionGrossTotalFormatted = StaffBrokerFunctions.GetFormattedCurrency(PortalId, sectionGrossTotal.ToString(StrCurrencyAmountsPattern))
                    Dim strbuilderSectionTotal As New StringBuilder(StrSectionTotalLabelPattern)
                    strbuilderSectionTotal.Replace("[section]", LocalizeString(theSectionSubTotal.ItemTypeName & "SectionTitle"))
                    LblTotalSectionGrossTitle.Text = strbuilderSectionTotal.ToString
                    LblTotalSectionGrossAmount.Text = sectionGrossTotalFormatted
                    ' Display VAT total if not zero
                    If theSectionSubTotal.TotalVat <> 0 Then
                        Dim strbuilderSectionTotalVAT As New StringBuilder(StrVATLabelPattern)
                        Dim sectionVAT = StaffBrokerFunctions.GetFormattedCurrency(PortalId, theSectionSubTotal.TotalVat.ToString(StrCurrencyAmountsPattern))
                        strbuilderSectionTotalVAT.Replace("[amount]", sectionVAT)
                        LblTotalSectionVAT.Text = strbuilderSectionTotalVAT.ToString
                    End If
                Else
                    ' Hide the table with totals for the section as there is only one section
                    TblSectionTotals.Visible = False
                End If

            End If

        End Sub

        Protected Function GetFormattedAddress(objAddress As FR_Cart_AddressBook) As String
            Dim rtn As New StringBuilder("")
            Dim newLine As String = "<br />"

            If Not objAddress Is Nothing Then
                'DAVID: Cart - Handle international formatting for addresses
                If Not objAddress.FullName Is Nothing And objAddress.FullName <> "" Then
                    rtn.Append(objAddress.FullName).Append(newLine)
                End If
                If Not objAddress.Address1 Is Nothing And objAddress.Address1 <> "" Then
                    rtn.Append(objAddress.Address1).Append(newLine)
                End If
                If Not objAddress.Address2 Is Nothing And objAddress.Address2 <> "" Then
                    rtn.Append(objAddress.Address2).Append(newLine)
                End If
                If Not objAddress.PostalCode Is Nothing And objAddress.PostalCode <> "" Then
                    rtn.Append(objAddress.PostalCode).Append(" ")
                End If
                If Not objAddress.City Is Nothing And objAddress.City <> "" Then
                    rtn.Append(objAddress.City).Append(newLine)
                End If
                If Not objAddress.Region Is Nothing And objAddress.Region <> "" Then
                    rtn.Append(objAddress.Region).Append(newLine)
                End If
                If Not objAddress.Country Is Nothing And objAddress.Country <> "" Then
                    rtn.Append(objAddress.Country).Append(newLine)
                End If
                If Not objAddress.Phone Is Nothing And objAddress.Phone <> "" Then
                    rtn.Append(objAddress.Phone).Append(newLine)
                End If
                If Not objAddress.Mobile Is Nothing And objAddress.Mobile <> "" Then
                    rtn.Append(objAddress.Mobile).Append(newLine)
                End If
            End If

            Return rtn.ToString
        End Function

        Protected Sub BtnPay_Click(sender As Object, e As System.EventArgs) Handles BtnPay.Click
            Response.Redirect(EditUrl("CartPayment"))
        End Sub

        Protected Sub BtnModifyBillingAddress_Click(sender As Object, e As EventArgs) Handles BtnModifyBillingAddress.Click
            Response.Redirect(EditUrl("action", EditAddressActions.ModifyBillingAddress, "CartEditAddress"))
        End Sub

        Protected Sub BtnModifyShippingAddress_Click(sender As Object, e As EventArgs) Handles BtnModifyShippingAddress.Click
            Response.Redirect(EditUrl("action", EditAddressActions.ModifyShippingAddress, "CartEditAddress"))
        End Sub

        Protected Sub BtnCopyShippingAddress_Click(sender As Object, e As EventArgs) Handles BtnCopyShippingAddress.Click
            Dim cartBillingAddress = CartFunctions.GetCartBillingAddress(TheCartID)
            Dim cartShippingAddress = CartFunctions.GetCartShippingAddress(TheCartID)
            cartShippingAddress.AddressBookID = cartBillingAddress.AddressBookID
            CartFunctions.UpdateCartBillingAddress(TheCartID, cartShippingAddress)

            LblBillingAddress.Text = GetFormattedAddress(cartShippingAddress)
            BtnCopyShippingAddress.Visible = False
            BtnCopyBillingAddress.Visible = False

        End Sub

        Protected Sub BtnCopyBillingAddress_Click(sender As Object, e As EventArgs) Handles BtnCopyBillingAddress.Click
            Dim cartBillingAddress = CartFunctions.GetCartBillingAddress(TheCartID)
            Dim cartShippingAddress = CartFunctions.GetCartShippingAddress(TheCartID)
            cartBillingAddress.AddressBookID = cartShippingAddress.AddressBookID
            CartFunctions.UpdateCartShippingAddress(TheCartID, cartBillingAddress)

            LblShippingAddress.Text = GetFormattedAddress(cartBillingAddress)
            BtnCopyShippingAddress.Visible = False
            BtnCopyBillingAddress.Visible = False

        End Sub
    End Class
End Namespace

