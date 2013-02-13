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

        'Previous page URL
        Public Property PreviousPage As System.Uri
            Get
                Return ViewState("PreviousPage")
            End Get
            Set(value As System.Uri)
                ViewState("PreviousPage") = value
            End Set
        End Property

        'Type of address edition to be processed
        Public ReadOnly Property Action As String
            Get
                Dim obj = ViewState("Action")
                If obj Is Nothing Then
                    'Initialize action depending on param in URL
                    obj = Me.Request.Params("action")
                    If obj Is Nothing Then
                        Exceptions.ProcessModuleLoadException("Invalid call to the control (action missing)", Me, Nothing)
                    Else
                        ViewState("Action") = obj
                    End If
                End If
                Return obj
            End Get
        End Property

        'Cart ID
        Public ReadOnly Property TheCartID As Integer
            Get
                Dim obj = ViewState("TheCartID")
                If obj Is Nothing Then
                    Dim anonCookieValue As String = Request.Cookies(".ASPXANONYMOUS").Value
                    obj = CartFunctions.GetCartID(UserId, anonCookieValue)
                    ViewState("TheCartID") = obj
                End If
                Return obj
            End Get
        End Property

        'The address being edited
        Dim _editedAddress As FR_Cart_AddressBook
        Public ReadOnly Property EditedAddress As FR_Cart_AddressBook
            Get
                If _editedAddress Is Nothing Then
                    Select Case Action
                        Case EditAddressActions.ModifyBillingAddress : _editedAddress = CartFunctions.GetCartBillingAddress(TheCartID)
                        Case EditAddressActions.ModifyShippingAddress : _editedAddress = CartFunctions.GetCartShippingAddress(TheCartID)
                        Case Else
                            _editedAddress = New FR_Cart_AddressBook
                            _editedAddress.UserID = UserId
                    End Select
                End If
                Return _editedAddress
            End Get
        End Property

#End Region

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

            ValDisplayName.ErrorMessage = Localization.GetString("DisplayNameRequired", LocalResourceFile)
            CbUpdateProfile.Text = Localization.GetString("CbUpdateProfile", LocalResourceFile)

            If Not Me.IsPostBack Then

                'Init previous page URL
                PreviousPage = Request.UrlReferrer

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
            'Redirect to Cart page or CartSummary page depending on the previous page
            If PreviousPage IsNot Nothing Then
                If PreviousPage.ToString.Contains(EditUrl("CartSummary")) Then
                    Response.Redirect(EditUrl("CartSummary"))
                End If
            End If
            Response.Redirect(NavigateURL())

        End Sub
    End Class
End Namespace
