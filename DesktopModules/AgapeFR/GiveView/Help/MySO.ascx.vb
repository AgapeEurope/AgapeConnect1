Imports DotNetNuke
Imports System.Web.UI
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Math
Imports System.Net
Imports System.IO
Imports System.Text
Imports System.Net.Mail
Imports System.Collections.Specialized

Imports System.Linq
Imports AgapeStaff
Imports StaffBrokerFunctions
Imports StaffBroker


Imports Resources




Namespace DotNetNuke.Modules.Give

    Partial Class MyGiving
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            tbSort1.Attributes("OnKeyUp") = "Tab(this, '" & tbSort2.ClientID & "')"
            tbSort2.Attributes("OnKeyUp") = "Tab(this, '" & tbSort3.ClientID & "')"
            tbSort3.Attributes("OnKeyUp") = "Tab(this, '" & tbAccountNo.ClientID & "')"
            hfUserId.Value = UserId
            Dim dr As New ResourcesDataContext
            Dim dorders = From c In dr.CAT_OrderDetails Where c.CAT_Product.ProductName = "Donations" And c.CAT_Order.CustomerID = UserId

            Dim donations = From c In dorders Join b In dr.Agape_Main_Donations On c.SKU.Substring(1, c.SKU.IndexOf("#") - 1) Equals b.DonationId Where c.SKU.Contains("#") Select b.DonName, b.Value, b.GiftAid, GiftDate = c.CAT_Order.OrderDate




            gvDonations.DataSource = donations
            gvDonations.DataBind()




        End Sub

        Public Function getStatus(ByRef Status As Integer) As String
            Select Case Status
                Case 0
                    Return "Pending"
                Case 1
                    Return "Waiting for 1st payment"
                Case 2
                    Return "Active"
                Case Else
                    Return "Cancelled"
            End Select

        End Function
        Public Function getStatusColor(ByRef Status As Integer) As String
            Return "#660000"
            Select Case Status
                Case 0
                    Return "Blue"
                Case 1
                    Return "Yellow"
                Case 2
                    Return "Green"
                Case Else
                    Return "Red"
            End Select

        End Function
        Public Function getFreq(ByRef Frequency As Integer) As String
            Select Case Frequency
                Case 1
                    Return "Monthly"
                Case 3
                    Return "Quarterly"
                Case 12
                    Return "Yearly"
                Case Else
                    Return "every " & Frequency & " months"
            End Select

        End Function
        Public Function getGiveTo(ByVal RefId As Integer, ByVal GivetoType As String) As String
            Select Case GivetoType
                Case "Staff"
                    Dim d As New AgapeStaffDataContext
                    Dim q = GetStaffMember(RefId)
                    'Dim q = From c In d.Agape_Staff_Finances Where c.UserId1 = RefId Or c.USerId2 = RefId Select c.DisplayName
                    If Not q Is Nothing Then
                        Return q.DisplayName
                    End If

                    Return "Error"
                Case "XAcc"
                    Dim d As New StaffBrokerDataContext
                    Dim q = From c In d.AP_StaffBroker_Departments Where c.CostCenterId = RefId Select c.Name
                    'Dim d As New AgapeStaffDataContext
                    'Dim q = From c In d.Agape_Main_AvailableCostCentres Where c.AvailableCostCentreId = RefId Select c.CostCentreName
                    If q.Count > 0 Then
                        Return q.First
                    End If
                    Return "Error"
                Case "Appeal"
                    Dim d As New FullStory.FullStoryDataContext
                    Dim q = From c In d.Agape_Main_Appeals Where c.AppealId = RefId Select c.AppealName
                    If q.Count > 0 Then
                        Return q.First
                    End If
                    Return "Error"
                Case Else
                    Return ""
            End Select

        End Function

       

        Protected Sub gvSO_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvSO.RowCommand
            If e.CommandName = "myCancel" Then
                Dim d As New AgapeStaffDataContext
                Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = CInt(e.CommandArgument)
                If q.Count > 0 Then
                    'q.First.Status = 3
                    'q.First.EndDate = Today

                    'd.SubmitChanges()
                    'gvSO.DataBind()
                    hfSOID.Value = q.First.SOID
                    'Popup To explain
                    Dim t As Type = gvSO.GetType()
                    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                    sb.Append("<script language='javascript'>")
                    sb.Append("showPopup();")
                    sb.Append("</script>")
                    ScriptManager.RegisterStartupScript(gvSO, t, "popup1", sb.ToString, False)
                End If
            ElseIf e.CommandName = "myEdit" Then

                Dim t As Type = gvSO.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("showPopup2();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(gvSO, t, "popup2", sb.ToString, False)
                Dim d As New AgapeStaffDataContext
                Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = CInt(e.CommandArgument)
                If q.Count > 0 Then
                    lblGiveTo.Text = getGiveTo(q.First.RefId, q.First.GivetoType)
                    tbSOAmount.Text = q.First.Amount.Value.ToString("0.00")
                    ddlFrequency.SelectedValue = q.First.Frequency
                    tbRef.Text = q.First.Reference
                    tbSort1.Text = Left(q.First.SortCode, 2)
                    tbSort2.Text = q.First.SortCode.Substring(2, 2)
                    tbSort3.Text = Right(q.First.SortCode, 2)

                    tbAccountNo.Text = q.First.AccountNo

                    hfSOID.Value = q.First.SOID
                End If



            End If
        End Sub

        Protected Sub EditBtn_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles EditBtn.Click
            Dim d As New AgapeStaffDataContext
            Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = CInt(hfSOID.Value)
            If q.Count > 0 Then
                q.First.Amount = CInt(tbSOAmount.Text)
                q.First.Frequency = CInt(ddlFrequency.SelectedValue)
                q.First.SortCode = tbSort1.Text & tbSort2.Text & tbSort3.Text
                q.First.AccountNo = tbAccountNo.Text
                q.First.Reference = tbRef.Text
                q.First.Changed = True
                d.SubmitChanges()
                gvSO.DataBind()
            End If



        End Sub

        Protected Sub gvDonations_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvDonations.SelectedIndexChanged

        End Sub

        Protected Sub btnYes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnYes.Click
            'Donor cancells standing order

            Dim d As New AgapeStaffDataContext
            Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = CInt(hfSOID.Value)
            q.First.Status = 3
            q.First.EndDate = Today

            d.SubmitChanges()
            gvSO.DataBind()

            Try
                If q.First.GivetoType = "Staff" Then
                    Dim staff = From c In d.Users Where c.UserID = q.First.RefId

                    If staff.Count > 0 Then
                        Dim Add1 = UserInfo.Profile.GetPropertyValue("Street")
                        Dim ADd2 = UserInfo.Profile.GetPropertyValue("Unit")
                        Dim ADd3 = UserInfo.Profile.GetPropertyValue("City")
                        Dim ADd4 = UserInfo.Profile.GetPropertyValue("County")
                        Dim ADd5 = UserInfo.Profile.GetPropertyValue("PostalCode")


                        Dim Message = "<p>We regret to inform you that " & UserInfo.FirstName & " " & UserInfo.LastName & " has cancelled their standing order for your support, via the Agap&eacute; website.</p>"
                        Message = Message & "<p><table style=""font-size: 8pt;"" ><tr><td><b>Donor Name:</b></td><td>" & UserInfo.FirstName & " " & UserInfo.LastName & "</td><tr>"
                        Message = Message & "<tr><td><b>Donor Email:</b></td><td>" & UserInfo.Email & "</td><tr>"
                        Message = Message & "<tr valign=""top""><td><b>Donor Address:</b></td><td>" & IIf(Add1 = "", "", Add1 & "<br/>") _
                           & IIf(ADd2 = "", "", ADd2 & "<br/>") _
                          & IIf(ADd3 = "", "", ADd3 & "<br/>") _
                            & IIf(ADd4 = "", "", ADd4 & "<br/>") _
                            & IIf(ADd5 = "", "", ADd5 & "<br/>") & _
                            "</td><tr>"
                        Message = Message & "<tr><td><b>Amount:</b></td><td>" & q.First.Amount.Value.ToString("£0.00") & "</td><tr></table></p>"

                        Message = Message & UserInfo.FirstName & " " & UserInfo.LastName & " will need to additionally cancel this standing order with their bank for money to stop coming. However we recommend you contact them directly to understand their intentions."

                        Message = Message & "<p>If you have any queries please give the office a ring on 0121 765 4404 (Mon-Fri, 10am-4pm) or email info@agape.org.uk.</p>"

                        AgapeStaffFunctions.SendAgapeMail("donotreply@agape.org.uk", staff.First.Email, "Standing Order has been cancelled", Message, staff.First.FirstName)

                    End If
                End If


            Catch ex As Exception

            End Try

            Dim t As Type = gvSO.GetType()
            Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
            sb.Append("<script language='javascript'>")
            sb.Append("closePopup;")
            sb.Append("</script>")
            ScriptManager.RegisterStartupScript(gvSO, t, "popup", sb.ToString, False)
        End Sub
    End Class
End Namespace
