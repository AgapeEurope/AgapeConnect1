Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq

Imports DotNetNuke
Imports DotNetNuke.Security
Imports StaffBroker
Imports StaffBrokerFunctions


Namespace DotNetNuke.Modules.AgapeFR.GiveView
    Partial Class HelloWorld
        Inherits Entities.Modules.PortalModuleBase



        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            lblAmount.Text = (Session("Amount"))
            lblSortCode.Text = (Session("SortCode"))
            lblFrequency.Text = (Session("Frequency"))
            lblAccountNo.Text = (Session("AccountNo"))
            lblGiveToType.Text = (Session("GiveToType"))
            lblRefId.Text = (Session("RefId"))
            lblStartDate.Text = (Session("StartDate"))
            lblSOGUID.Text = (Session("SOGUID"))

        End Sub

        Public Shared Function AddSOtoTable(ByVal UserID As Integer, ByVal AnonID As String, ByVal ItemName As String, ByVal DestinationType As Integer, ByVal DestinationID As Integer, ByVal Amount As Double, ByVal Comment As String) As Integer

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

    End Class
End Namespace
