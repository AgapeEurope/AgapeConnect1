Imports Microsoft.VisualBasic
Imports Cart
Imports System.Linq
Imports System.Data.Linq
Imports MembershipProvider = DotNetNuke.Security.Membership.MembershipProvider

#Region "Modules defining constant values"

' List of values for ItemType field of CartContent
Public Module ItemType
    Public Const Donation As Integer = 0
    Public Const Resource As Integer = 1
    Public Function GetName(ByVal ItemTypeNumber As Integer) As String
        Select Case ItemTypeNumber
            Case 0 : Return "Donation"
            Case 1 : Return "Resource"
            Case Else : Return "Unknown"
        End Select
    End Function

End Module

' List of values for DestinationType field of Donation
Public Module DestinationType
    Public Const Staff As Integer = 0
    Public Const Department As Integer = 1
    Public Const Project As Integer = 2
    Public Function GetName(ByVal DestinationTypeNumber As Integer) As String
        Select Case DestinationTypeNumber
            Case 0 : Return "Staff"
            Case 1 : Return "Department"
            Case 2 : Return "Project"
            Case Else : Return "Unknown"
        End Select
    End Function

End Module

' List of values for OrderState field of Cart
Public Module OrderState
    Public Const Unprocessed As Integer = 0 'a cart is created but before user is at payment screen
    Public Const Submitted As Integer = 1 'Credit order submitted but before payment is received. If payment goes through credit card : status before we get confirmation from credit card company
    Public Const Completed As Integer = 2
    Public Const Canceled As Integer = 3 'order not shipped out or completed
    Public Const Returned As Integer = 4
End Module

' List of possible actions for CartEditAddress page
Public Module EditAddressActions
    Public Const ModifyBillingAddress As String = "0"
    Public Const ModifyShippingAddress As String = "1"
    Public Const NewBillingAddress As String = "2"
    Public Const NewShipingAddress As String = "3"
    Public Function GetName(ByVal ActionNumber As String) As String
        Select Case ActionNumber
            Case "0" : Return "ModifyBillingAddress"
            Case "1" : Return "ModifyShippingAddress"
            Case "2" : Return "NewBillingAddress"
            Case "3" : Return "NewShippingAddress"
            Case Else : Return "Unknown"
        End Select
    End Function
End Module

#End Region ' Modules defining constant values

Public Class CartFunctions

#Region "Class data structures"

    Structure CartTotals
        Public NetTotal As Double
        Public SubItemTotals As Dictionary(Of Integer, SubItemTotal)
        Public VATTotal As Double?
        Public ShipVAT As Double?
        Public ShipCost As Double?
        Public GrandTotal As Double
        Public NoDispatchable As Boolean
        Public ItemCount As Integer
    End Structure

    Structure SubItemTotal
        Public ItemType As Integer
        Public ItemTypeName As String
        Public Total As Double
        Public TotalVat As Double
        Public ItemCount As Integer
        Public NoDiscount As Boolean
    End Structure

#End Region ' Class data structures

#Region "Get cart or infos from cart"

    Public Shared Function GetCartID(ByVal UserID As Integer, ByVal AnonId As String) As Integer

        Dim d As New Cart.CartDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

        ' Get cart from anonymous user cookie
        Dim anonCart = (From c In d.FR_Carts Where c.AnonID = AnonId And c.PortalID = PS.PortalId And c.OrderState = OrderState.Unprocessed)

        If UserID <> -1 Then
            ' User is connected

            ' Get cart from connected user ID
            Dim connectedCart = From c In d.FR_Carts Where c.UserID = UserID And c.PortalID = PS.PortalId And c.OrderState = OrderState.Unprocessed

            If connectedCart.Count > 0 And anonCart.Count = 0 Then
                ' Cart found for connected user and not for anonymous user

                ' => Set AnonID to current anonymous cookie and return found cart
                connectedCart.First.AnonID = AnonId
                d.SubmitChanges()
                Return connectedCart.First.CartID


            ElseIf anonCart.Count > 0 And connectedCart.Count = 0 Then
                ' Cart found for anonymous user and not for connected user

                ' => Set UserID on cart and return found cart
                anonCart.First.UserID = UserID
                d.SubmitChanges()
                Return anonCart.First.CartID

            ElseIf anonCart.Count = 0 And connectedCart.Count = 0 Then
                ' No cart found

                ' => Insert new cart with AnonID and UserID + Return new cart
                Dim Insert As New Cart.FR_Cart()
                Insert.UserID = UserID
                Insert.AnonID = AnonId
                Insert.PortalID = PS.PortalId
                Insert.PayMethod = 0
                Insert.MerchantFee = 0
                Insert.CreditFee = 0
                Insert.Date = Now
                Insert.OrderState = 0
                Insert.ShipCost = 0
                Insert.CreditNote = False
                d.FR_Carts.InsertOnSubmit(Insert)
                d.SubmitChanges()
                Return Insert.CartID

            Else ' anonCart.Count > 0 And connectedCart.Count > 0
                ' Carts found for connected user and anonymous user

                If connectedCart.First.CartID = anonCart.First.CartID Then
                    ' Carts for connected user and anonymous user are the same cart (same CartID)
                    ' => Return cart
                    Return connectedCart.First.CartID

                Else
                    ' Carts for connected user and anonymous user are different (different CartID)

                    If connectedCart.First.Date > anonCart.First.Date Then
                        ' Cart of connected user is latest

                        ' => Set AnonID on connected cart + Delete anon cart (and linked CartContents + Donations) + Return cart of connected user
                        connectedCart.First.AnonID = AnonId
                        d.FR_Carts.DeleteOnSubmit(anonCart.First)
                        d.SubmitChanges()
                        Return connectedCart.First.CartID

                    Else
                        ' Anon cart is latest

                        ' => Set UserID on anon cart + Delete cart of connected user (and linked CartContents + Donations) + Return anon cart
                        anonCart.First.UserID = UserID
                        d.FR_Carts.DeleteOnSubmit(connectedCart.First)
                        d.SubmitChanges()
                        Return anonCart.First.CartID

                    End If
                End If
            End If
        Else
            ' User is anonymous

            If anonCart.Count > 0 Then
                ' Cart found for anonymous user

                ' => Return found cart
                Return anonCart.First.CartID

            Else
                ' No cart found for anonymous user

                ' => Insert new cart with AnonID + Return new cart
                Dim Insert As New Cart.FR_Cart()
                Insert.UserID = -1
                Insert.AnonID = AnonId
                Insert.PortalID = PS.PortalId
                Insert.PayMethod = 0
                Insert.MerchantFee = 0
                Insert.CreditFee = 0
                Insert.Date = Now
                Insert.OrderState = 0
                Insert.ShipCost = 0
                Insert.CreditNote = False
                d.FR_Carts.InsertOnSubmit(Insert)
                d.SubmitChanges()
                Return Insert.CartID

            End If
        End If
    End Function

    Public Shared Function GetCartContents(ByVal UserID As Integer, ByVal AnonID As String) As IQueryable(Of Cart.FR_Cart_Content)

        Dim d As New CartDataContext
        Dim theCartId = GetCartID(UserID, AnonID)

        Dim theCartContents = From c In d.FR_Carts Where c.CartID = theCartId Select c.FR_Cart_Contents

        Return theCartContents.First.AsQueryable

    End Function

    Public Shared Function GetCartContents(ByVal CartID As Integer) As IQueryable(Of Cart.FR_Cart_Content)

        Dim d As New CartDataContext

        Dim theCartContents = From c In d.FR_Carts Where c.CartID = CartID Select c.FR_Cart_Contents

        Return theCartContents.First.AsQueryable

    End Function

    Public Shared Function GetCartTotals(ByVal CartID As Integer) As CartTotals

        Dim d As New Cart.CartDataContext
        Dim theCart = From c In d.FR_Carts Where c.CartID = CartID
        Dim rtn As New CartTotals

        If theCart.Count > 0 Then
            rtn.NetTotal = (From c In theCart.First.FR_Cart_Contents Select c.Quantity * c.Cost).Sum
            Dim q = From c In theCart.First.FR_Cart_Contents Group By c.ItemType Into Group

            rtn.SubItemTotals = New Dictionary(Of Integer, SubItemTotal)

            For Each row In q
                Dim totalForItemType As New SubItemTotal()
                totalForItemType.ItemType = row.ItemType
                totalForItemType.ItemTypeName = ItemType.GetName(row.ItemType)
                totalForItemType.Total = (From c In row.Group Select (c.Quantity * c.Cost)).Sum
                totalForItemType.TotalVat = (From c In row.Group Select (c.Quantity * c.Tax)).Sum
                totalForItemType.ItemCount = (From c In row.Group Select c.CartContentID).Count
                totalForItemType.NoDiscount = (From c In row.Group Where Not ((c.DiscountAmt Is Nothing Or c.DiscountAmt = 0) And (c.DiscountPercent Is Nothing Or c.DiscountPercent = 0))).Count = 0

                rtn.SubItemTotals.Add(row.ItemType, totalForItemType)
            Next

            rtn.VATTotal = (From c In theCart.First.FR_Cart_Contents Select c.Quantity * c.Tax).Sum
            rtn.ShipVAT = theCart.First.ShipVAT
            rtn.ShipCost = theCart.First.ShipCost
            rtn.GrandTotal = rtn.NetTotal + rtn.ShipCost + IIf(rtn.VATTotal Is Nothing, 0, rtn.VATTotal) + IIf(rtn.ShipVAT Is Nothing, 0, rtn.ShipVAT)
            rtn.NoDispatchable = (From c In theCart.First.FR_Cart_Contents Where c.Dispatchable = True).Count = 0
            rtn.ItemCount = (From c In theCart.First.FR_Cart_Contents).Count

        End If
        Return rtn
    End Function

    Public Shared Function GetCartItemPictureURL(ByVal TheItemID As Integer, ByVal TheItemType As Integer) As String

        Dim rtn As String = ""

        If TheItemType = ItemType.Donation Then ' Handle donations
            rtn = StaffBrokerFunctions.GetStaffJointPhoto(TheItemID)
        Else ' Handle other item types
            'DAVID: Cart - Handle pictures for non-donation items
        End If

        Return rtn

    End Function

    Public Shared Function GetCartItemLink(ByVal TheItemID As Integer, ByVal TheItemType As Integer) As String

        Dim rtn As String = ""

        If TheItemType = ItemType.Donation Then ' Handle donations
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim mc As New DotNetNuke.Entities.Modules.ModuleController
            Dim m = mc.GetModuleByDefinition(PS.PortalId, "frPresentationPage")
            If Not m Is Nothing Then
                If Not m.TabID = Nothing Then
                    rtn = NavigateURL(m.TabID) & "?giveto=" & StaffBrokerFunctions.GetStaffProfileProperty(TheItemID, "givingshortcut")
                    'DAVID: Cart - Handle link for Dept and Project
                End If
            End If
        Else ' Handle other item types
            'DAVID: Cart - Handle link for non-donation items
        End If

        Return rtn

    End Function

#End Region 'Get cart or infos from cart

#Region "Add content to cart"

    Public Shared Function AddToCart(ByVal UserID As Integer, ByVal AnonID As String, ByVal ItemName As String, ByVal ItemType As Integer, ByVal ItemRef As Integer, ByVal Quantity As Integer, ByVal Cost As Double, ByVal Tax As Double, ByVal DiscountAmt As Double, ByVal DiscountPercent As Double, ByVal Dispatchable As Boolean, ByVal Details As String) As Integer

        Dim cartID As Integer = -1
        cartID = GetCartID(UserID, AnonID)

        Dim d As New Cart.CartDataContext

        Dim insert As New Cart.FR_Cart_Content()
        insert.CartID = cartID
        insert.Quantity = Quantity
        insert.ItemName = ItemName
        insert.ItemType = ItemType
        insert.ItemRef = ItemRef
        insert.Cost = Cost
        insert.Tax = Tax
        insert.DiscountAmt = DiscountAmt
        insert.DiscountPercent = DiscountPercent
        insert.Dispatchable = Dispatchable
        insert.Details = Details
        d.FR_Cart_Contents.InsertOnSubmit(insert)
        d.SubmitChanges()

        UpdateCartDeliveryCostAndDate(cartID)

        Return insert.CartContentID

    End Function

    Public Shared Function AddDonationToCart(ByVal UserID As Integer, ByVal AnonID As String, ByVal ItemName As String, ByVal DestinationType As Integer, ByVal DestinationID As Integer, ByVal Amount As Double, ByVal Comment As String) As Integer

        ' Add the donation to the donations table
        Dim d As New Cart.CartDataContext
        Dim insert As New Cart.FR_Donations
        insert.DestinationID = DestinationID
        insert.DestinationType = DestinationType
        insert.Comment = Comment
        d.FR_Donations.InsertOnSubmit(insert)

        ' Add the donation to the cart contents table
        Dim cartcontentid = CartFunctions.AddToCart(UserID, AnonID, ItemName, ItemType.Donation, DestinationID, 1, Amount, 0, 0, 0, False, "")

        ' Set CartContentID in the donations table
        insert.CartContentID = cartcontentid
        d.SubmitChanges()

        Return cartcontentid

    End Function

#End Region 'Add content to cart

#Region "Modify cart or content in cart"

    Public Shared Sub UpdateCartDateToNow(ByVal CartID As Integer)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID

        If q.Count > 0 Then
            q.First.Date = Now
            d.SubmitChanges()
        End If

    End Sub

    Public Shared Sub UpdateCartDeliveryCostAndDate(ByVal CartID As Integer)

        'DAVID: Cart - Delivery cost should be calculated by the Resource Center

        Dim d As New Cart.CartDataContext
        Dim theCart = From c In d.FR_Carts Where c.CartID = CartID

        If theCart.Count > 0 Then

            ' Update ShipCost
            Dim NoDispatchable = (From c In theCart.First.FR_Cart_Contents Where c.Dispatchable = True).Count = 0
            If NoDispatchable Then
                ' No shipping cost if no dispatchable items in the cart
                theCart.First.ShipCost = 0
            Else
                ' 4€ fixed price per default
                theCart.First.ShipCost = 4
            End If

            ' Update ShipVAT
            Dim VATTotal = (From c In theCart.First.FR_Cart_Contents Select c.Quantity * c.Tax).Sum
            If (VATTotal = 0 Or theCart.First.ShipCost = 0) Then
                ' No tax on shipping if no shipping cost or no taxable items in the cart
                theCart.First.ShipVAT = 0
            Else
                'DAVID: Cart - Shipping VAT cost calculation rules to be coded here
                ' 19,6% of shipping cost per default (rounded to 2 decimals)
                theCart.First.ShipVAT = Math.Round(CDbl(theCart.First.ShipCost * 0.196), 2)
            End If

            ' Set cart date to now
            theCart.First.Date = Now

            d.SubmitChanges()

        End If

    End Sub

    Public Shared Sub UpdateCartItemQuantity(ByVal CartContentID As Integer, ByVal Quantity As Integer)

        Dim d As New Cart.CartDataContext
        Dim theCartItem = From c In d.FR_Cart_Contents Where c.CartContentID = CartContentID

        If theCartItem.Count > 0 Then
            theCartItem.First.Quantity = Quantity
            d.SubmitChanges()
            UpdateCartDeliveryCostAndDate(theCartItem.First.CartID)
        End If

    End Sub

    Public Shared Sub UpdateCartItemCost(ByVal CartContentID As Integer, ByVal Cost As Integer)

        Dim d As New Cart.CartDataContext
        Dim theCartItem = From c In d.FR_Cart_Contents Where c.CartContentID = CartContentID

        If theCartItem.Count > 0 Then
            theCartItem.First.Cost = Cost
            d.SubmitChanges()
            UpdateCartDeliveryCostAndDate(theCartItem.First.CartID)
        End If

    End Sub

    Public Shared Sub SubmitOrder(ByVal CartID As Integer)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID And c.OrderState = OrderState.Unprocessed

        If q.Count > 0 Then
            q.First.OrderState = OrderState.Submitted
            d.SubmitChanges()
        End If


    End Sub

    Public Shared Sub CompleteOrder(ByVal CartID As Integer)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID And c.OrderState = OrderState.Submitted


        If q.Count > 0 Then
            q.First.OrderState = OrderState.Completed
            d.SubmitChanges()
        End If

    End Sub

    Public Shared Sub CancelOrder(ByVal CartID As Integer)

        Dim d As New Cart.CartDataContext
        Dim AllowedStates() As Integer = {OrderState.Unprocessed, OrderState.Submitted, OrderState.Completed}

        Dim q = From c In d.FR_Carts Where c.CartID = CartID And AllowedStates.Contains(c.OrderState)

        If q.Count > 0 Then
            q.First.OrderState = OrderState.Canceled
            d.SubmitChanges()
        End If


    End Sub

    Public Shared Sub ReturnOrder(ByVal CartID As Integer)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID And (c.OrderState = OrderState.Completed)

        If q.Count > 0 Then
            q.First.OrderState = OrderState.Returned
            d.SubmitChanges()
        End If

    End Sub

#End Region 'Modify cart or content in cart

#Region "Delete cart or content in cart"

    Public Shared Sub DeleteCartItem(ByVal CartContentID As Integer)

        Dim d As New Cart.CartDataContext
        Dim theCartItem = From c In d.FR_Cart_Contents Where c.CartContentID = CartContentID
        Dim rtn As New CartTotals

        If theCartItem.Count > 0 Then
            Dim theCartID = theCartItem.First.CartID
            d.FR_Cart_Contents.DeleteOnSubmit(theCartItem.First)
            d.SubmitChanges()
            UpdateCartDeliveryCostAndDate(theCartID)
        End If

    End Sub

    Public Shared Sub EmptyCart(ByVal theCart As FR_Cart)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = theCart.CartID

        If q.Count > 0 Then
            If q.First.OrderState = OrderState.Unprocessed Then
                d.FR_Cart_Contents.DeleteAllOnSubmit(q.First.FR_Cart_Contents)
                q.First.Date = Now
                d.SubmitChanges()
                UpdateCartDeliveryCostAndDate(theCart.CartID)
            End If

        End If

    End Sub

#End Region 'Delete cart or content in cart

#Region "Addresses functions"

    Public Shared Function GetCartShippingAddress(ByVal CartID As Integer) As FR_Cart_AddressBook
        Dim rtn As FR_Cart_AddressBook = Nothing
        Dim d As New Cart.CartDataContext
        Dim theAddressBookID = From c In d.FR_Carts Where c.CartID = CartID Select c.ShipAddressBookID
        If theAddressBookID.Count > 0 Then
            Dim theAddress = From c In d.FR_Cart_AddressBook Where theAddressBookID.First IsNot Nothing And c.AddressBookID = theAddressBookID.First
            If theAddress.Count > 0 Then
                rtn = theAddress.First
            End If
        End If
        Return rtn
    End Function

    Public Shared Function GetCartBillingAddress(ByVal CartID As Integer) As FR_Cart_AddressBook
        Dim rtn As FR_Cart_AddressBook = Nothing
        Dim d As New Cart.CartDataContext
        Dim theAddressBookID = From c In d.FR_Carts Where c.CartID = CartID Select c.BillAddressBookID
        If theAddressBookID.Count > 0 Then
            Dim theAddress = From c In d.FR_Cart_AddressBook Where theAddressBookID.First IsNot Nothing And c.AddressBookID = theAddressBookID.First
            If theAddress.Count > 0 Then
                rtn = theAddress.First
            End If
        End If
        Return rtn
    End Function

    Public Shared Function GetUserAddresses(ByVal UserID As Integer) As IQueryable(Of FR_Cart_AddressBook)

        Dim d As New Cart.CartDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim rtn = (From c In d.FR_Cart_AddressBook Where c.UserID = UserID And UserID <> -1).ToList

        Return rtn

    End Function

    Public Shared Function GetUserProfilAddress(ByVal UserID As Integer) As FR_Cart_AddressBook

        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim rtn As New FR_Cart_AddressBook
        Dim theUser = UserController.GetUserById(PS.PortalId, UserID)

        rtn.AddressBookID = -1
        rtn.UserID = UserID
        rtn.FullName = theUser.DisplayName
        rtn.Address1 = theUser.Profile.Street
        rtn.Address2 = theUser.Profile.Unit
        rtn.City = theUser.Profile.City
        rtn.Region = theUser.Profile.Region
        rtn.Country = theUser.Profile.Country
        rtn.PostalCode = theUser.Profile.PostalCode
        rtn.Phone = theUser.Profile.Telephone
        rtn.Mobile = theUser.Profile.Cell

        Return rtn

    End Function

    Public Shared Sub SaveAddressToProfile(ByVal theAddress As FR_Cart_AddressBook)

        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim theUser = UserController.GetUserById(PS.PortalId, theAddress.UserID)

        theUser.DisplayName = theAddress.FullName
        theUser.Profile.Street = theAddress.Address1
        theUser.Profile.Unit = theAddress.Address2
        theUser.Profile.City = theAddress.City
        theUser.Profile.Region = theAddress.Region
        theUser.Profile.Country = theAddress.Country
        theUser.Profile.PostalCode = theAddress.PostalCode
        theUser.Profile.Telephone = theAddress.Phone
        theUser.Profile.Cell = theAddress.Mobile

        MembershipProvider.Instance().UpdateUser(theUser)

    End Sub

    Public Shared Function SaveAddressToAddressBook(ByVal theAddress As FR_Cart_AddressBook) As Integer

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Cart_AddressBook Where c.AddressBookID = theAddress.AddressBookID And theAddress.AddressBookID <> -1

        If q.Count > 0 Then                                 'edit existing address
            q.First.UserID = theAddress.UserID
            q.First.FullName = theAddress.FullName
            q.First.Address1 = theAddress.Address1
            q.First.Address2 = theAddress.Address2
            q.First.City = theAddress.City
            q.First.Region = theAddress.Region
            q.First.Country = theAddress.Country
            q.First.PostalCode = theAddress.PostalCode
            q.First.Phone = theAddress.Phone
            q.First.Mobile = theAddress.Mobile
            d.SubmitChanges()
            Return theAddress.AddressBookID
        Else                                                'insert new address
            theAddress.AddressBookID = -1
            d.FR_Cart_AddressBook.InsertOnSubmit(theAddress)
            d.SubmitChanges()
            Return theAddress.AddressBookID
        End If

    End Function

    Public Shared Function CloneAddress(ByVal theAddress As FR_Cart_AddressBook) As FR_Cart_AddressBook

        theAddress.AddressBookID = -1 'In order to create a new address in the address book table

        Return theAddress

    End Function

    Public Shared Sub UpdateCartBillingAddress(ByVal CartID As Integer, ByVal theAddress As FR_Cart_AddressBook)

        Dim billingAddressId = SaveAddressToAddressBook(theAddress)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID

        If q.Count > 0 Then
            q.First.BillAddressBookID = billingAddressId
            d.SubmitChanges()
        End If

    End Sub

    Public Shared Sub UpdateCartShippingAddress(ByVal CartID As Integer, ByVal theAddress As FR_Cart_AddressBook)

        Dim shippingAddressId = SaveAddressToAddressBook(theAddress)

        Dim d As New Cart.CartDataContext
        Dim q = From c In d.FR_Carts Where c.CartID = CartID

        If q.Count > 0 Then
            q.First.ShipAddressBookID = shippingAddressId
            d.SubmitChanges()
        End If

    End Sub

    'Compare main attributes of 2 addresses
    Public Shared Function sameAddresses(address1 As FR_Cart_AddressBook, address2 As FR_Cart_AddressBook) As Boolean

        If address1 Is Nothing And address2 Is Nothing Then
            Return True
        End If

        If (address1 Is Nothing And Not address2 Is Nothing) Or (Not address1 Is Nothing And address2 Is Nothing) Then
            Return False
        End If

        If address1.FullName <> address2.FullName Then
            Return False
        End If

        If address1.Address1 <> address2.Address1 Then
            Return False
        End If

        If address1.Address2 <> address2.Address2 Then
            Return False
        End If

        If address1.City <> address2.City Then
            Return False
        End If

        If address1.Country <> address2.Country Then
            Return False
        End If

        If address1.Mobile <> address2.Mobile Then
            Return False
        End If

        If address1.Phone <> address2.Phone Then
            Return False
        End If

        If address1.PostalCode <> address2.PostalCode Then
            Return False
        End If

        If address1.Region <> address2.Region Then
            Return False
        End If

        Return True

    End Function

#End Region 'Addresses functions

#Region "Other info initialization"

    Public Shared Function CreateLogin(ByVal EmailAddress As String, ByVal FirstName As String, ByVal LastName As String) As UserInfo

        Dim d As New Cart.CartDataContext
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim UserName As String = EmailAddress & PS.PortalId
        Dim theUser = UserController.GetUserByName(PS.PortalId, UserName)

        If theUser Is Nothing Then
            theUser = StaffBrokerFunctions.CreateUser(PS.PortalId, EmailAddress, FirstName, LastName)
        End If
        Return theUser

    End Function

#End Region 'Other info initialization


End Class