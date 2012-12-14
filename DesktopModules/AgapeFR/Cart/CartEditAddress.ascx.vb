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
    Partial Class CartEditAddress
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

        'The address being edited
        Public Property EditedAddress As FR_Cart_AddressBook
            Get
                Dim obj As FR_Cart_AddressBook = Session("EditedAddress")
                If obj Is Nothing Then
                    Select Case Action
                        Case EditAddressActions.ModifyBillingAddress : obj = CartFunctions.GetCartBillingAddress(TheCartID)
                        Case EditAddressActions.ModifyShippingAddress : obj = CartFunctions.GetCartShippingAddress(TheCartID)
                        Case Else
                            obj = New FR_Cart_AddressBook
                            obj.UserID = UserId
                    End Select
                End If
                Return obj
            End Get
            Private Set(ByVal value As FR_Cart_AddressBook)
                Session("EditedAddress") = value
            End Set
        End Property

#End Region

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            ValDisplayName.ErrorMessage = Localization.GetString("DisplayNameRequired", LocalResourceFile)
            CbUpdateProfile.Text = Localization.GetString("CbUpdateProfile", LocalResourceFile)

            'Add event handler for "Cancel" button
            'DAVID: Cart - Use VB event to redirect to editurl CartSummary
            BtnCancel.Attributes.Add("onClick", "javascript:history.back(); return false;")

            If Not Me.IsPostBack Then

                'Reset session properties
                Session("Action") = Nothing
                Session("TheCartID") = Nothing
                Session("EditedAddress") = Nothing

                'Initialize title and description
                LblTitle.Text = Localization.GetString(EditAddressActions.GetName(Action) & "Title", LocalResourceFile)
                LblDescription.Text = Localization.GetString(EditAddressActions.GetName(Action) & "Description", LocalResourceFile)

                'Init full name and address
                Dim theAddress = EditedAddress
                If Not theAddress Is Nothing Then
                    TxtDisplayName.Text = theAddress.FullName
                    With DnnAddress
                        .Street = theAddress.Address1
                        .Unit = theAddress.Address2
                        .City = theAddress.City
                        .Region = theAddress.Region
                        .Country = IIf(String.IsNullOrEmpty(theAddress.Country), getDefaultCountry(), theAddress.Country)
                        .Postal = theAddress.PostalCode
                        .Telephone = theAddress.Phone
                        .Cell = theAddress.Mobile
                    End With
                End If

            End If

        End Sub

        Protected Sub BtnContinue_Click(sender As Object, e As System.EventArgs) Handles BtnContinue.Click

            'Update address in address book

            Dim theAddress = EditedAddress
            With theAddress
                .FullName = TxtDisplayName.Text
                .Address1 = DnnAddress.Street
                .Address2 = DnnAddress.Unit
                .City = DnnAddress.City
                .Region = DnnAddress.Region
                .Country = DnnAddress.Country
                .PostalCode = DnnAddress.Postal
                .Phone = DnnAddress.Telephone
                .Mobile = DnnAddress.Cell
            End With

            Select Case Action
                Case EditAddressActions.ModifyBillingAddress : CartFunctions.UpdateCartBillingAddress(TheCartID, theAddress)
                Case EditAddressActions.ModifyShippingAddress : CartFunctions.UpdateCartShippingAddress(TheCartID, theAddress)
                Case Else 'TODO Cart: To be completed with new address process when needed
            End Select

            'Update address in profile if needed
            If CbUpdateProfile.Checked Then
                CartFunctions.SaveAddressToProfile(theAddress)
            End If

            Response.Redirect(EditUrl("CartSummary"))
        End Sub

        ' Get default country from portal default language
        Public Function getDefaultCountry() As String
            Dim lc As New Lists.ListController
            Dim c = lc.GetListEntryInfoItems("Country").Where(Function(x) PortalSettings.DefaultLanguage.EndsWith(x.Value)).Select(Function(x) x.Text)
            If c.Count > 0 Then
                Return c.First
            End If

            'default
            Return "United Kingdom"
        End Function

        Protected Sub BtnCancel_Click(sender As Object, e As EventArgs) Handles BtnCancel.Click

        End Sub
    End Class
End Namespace
