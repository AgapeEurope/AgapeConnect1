Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

Imports DotNetNuke
Imports DotNetNuke.Security
Imports DotNetNuke.Instrumentation
Imports DotNetNuke.UI.Skins.Controls.ModuleMessage
Imports StaffBroker
Imports StaffBrokerFunctions
Imports Cart


Namespace DotNetNuke.Modules.AgapeFR.Cart
    Partial Class Cart
        Inherits Entities.Modules.PortalModuleBase

        Protected TheCartTotals As CartFunctions.CartTotals

        Protected StrCurrencyAmountsPattern As String = "0.00"

        ' Label patterns
        Protected StrSectionTotalLabelPattern As String
        Protected StrVATLabelPattern As String

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            ' Init shared resource file
            LocalResourceFile = ApplicationPath + "/DesktopModules/AgapeFR/Cart/App_LocalResources/CartSharedResources.resx"

            ' Load label translations
            StrSectionTotalLabelPattern = LocalizeString("SectionTotalLabel")
            StrVATLabelPattern = LocalizeString("VATLabel")

            If Not Me.IsPostBack Then

                ' Set "Settings" link visible only to users having the right to edit the page
                btnSettings.Visible = IsEditable

                LoadCart()

            End If

        End Sub

        ' Initialize data and view for the cart
        Protected Sub LoadCart()

            'DAVID: Cart - Check where prices should be updated (to handle different prices when the user logs in)

            ' Retrieve the Cookie for anonymous user (when user is not logged in)
            Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value

            ' Get CartId and store it in session
            Dim cartID = CartFunctions.GetCartID(UserId, anonCookieValue)
            Session("TheCartID") = cartID

            ' Load the list of cart contents
            Dim theCartContents = CartFunctions.GetCartContents(cartID)

            ' Initialize the cart totals
            TheCartTotals = CartFunctions.GetCartTotals(cartID)

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

        End Sub

        Protected Sub UpdateSection(sender As Object, e As System.Web.UI.WebControls.GridViewCommandEventArgs)

            Dim itemName = CType(CType(sender, GridView).Rows(CInt(e.CommandArgument)).FindControl("LblItemName"), Label).Text
            Dim cartContentId = CType(CType(sender, GridView).Rows(CInt(e.CommandArgument)).FindControl("hfCartContentId"), HiddenField).Value

            If e.CommandName = "UpdateQuantity" Then

                Dim newQuantityText = CType(CType(sender, GridView).Rows(CInt(e.CommandArgument)).FindControl("TbQuantity"), TextBox).Text

                Try

                    Dim newQuantity = CInt(newQuantityText)

                    If newQuantity = 0 Then
                        ' Delete the CartItem in database
                        CartFunctions.DeleteCartItem(cartContentId)
                        ' Display result message
                        AddModuleMessage(LocalizeString("DeletedItemMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)
                    Else

                        ' Update the quantity for the CartItem into database
                        CartFunctions.UpdateCartItemQuantity(cartContentId, newQuantity)
                        ' Display result message
                        AddModuleMessage(LocalizeString("UpdatedItemMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)

                    End If

                Catch ex As Exception
                    'Display error message
                    AddModuleMessage(LocalizeString("InvalidQuantityMsg"), ModuleMessageType.RedError)
                    AgapeLogger.Warn(UserId, "Error while trying to update 'Quantity' with value '" + newQuantityText + "' in cart: itemName='" + itemName + "' / cartContentId='" + cartContentId + "' - " + ex.StackTrace)
                End Try

            ElseIf e.CommandName = "UpdateDonationAmount" Then

                Dim newAmountText = CType(CType(sender, GridView).Rows(CInt(e.CommandArgument)).FindControl("TbDonationAmount"), TextBox).Text

                Try

                    Dim newAmount = CInt(newAmountText)

                    If newAmount = 0 Then
                        ' Delete the CartItem in database
                        CartFunctions.DeleteCartItem(cartContentId)
                        ' Display result message
                        AddModuleMessage(LocalizeString("DeletedItemMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)
                    Else

                        ' Update the cost for the CartItem into database
                        CartFunctions.UpdateCartItemCost(cartContentId, newAmount)
                        ' Display result message
                        AddModuleMessage(LocalizeString("UpdatedItemMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)

                    End If

                Catch ex As Exception
                    ' Display error message
                    AddModuleMessage(LocalizeString("InvalidAmountMsg"), ModuleMessageType.RedError)
                    AgapeLogger.Warn(UserId, "Error while trying to update 'Cost' with value '" + newAmountText + "' in cart: itemName='" + itemName + "' / cartContentId='" + cartContentId + "' - " + ex.Message)
                End Try

            ElseIf e.CommandName = "DeleteContent" Then

                Try
                    ' Delete the CartItem in the database
                    CartFunctions.DeleteCartItem(cartContentId)
                    ' Display result message
                    AddModuleMessage(LocalizeString("DeletedItemMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)
                Catch ex As Exception
                    ' Display error message
                    AddModuleMessage(LocalizeString("DeleteItemErrorMsg").Replace("[itemName]", itemName), ModuleMessageType.GreenSuccess)
                    AgapeLogger.Warn(UserId, "Error while trying to delete item in cart: itemName='" + itemName + "' / cartContentId='" + cartContentId + "' - " + ex.Message)
                End Try

            End If

            ' Update the view
            LoadCart()

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


        Protected Sub BtnFinalize_Click(sender As Object, e As System.EventArgs) Handles BtnFinalize.Click
            Response.Redirect(EditUrl("CartLogin"))
        End Sub

        Protected Sub btnSettings_Click(sender As Object, e As System.EventArgs) Handles btnSettings.Click
            Response.Redirect(EditUrl("CartSettings"))
        End Sub

        Protected Sub AddModuleMessage(message As String, type As ModuleMessageType)
            UI.Skins.Skin.AddModuleMessage(Me, message, type)
        End Sub
    End Class
End Namespace
