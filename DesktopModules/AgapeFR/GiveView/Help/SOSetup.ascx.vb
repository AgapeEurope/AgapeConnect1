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
Imports StaffBroker
Imports StaffBrokerFunctions

'Imports iTextSharp.text.pdf

Namespace DotNetNuke.Modules.AgapeFR.GiveView

    Partial Class SOSetup
        Inherits Entities.Modules.ModuleSettingsBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            'Create the So
            If Not Page.IsPostBack Then

                'need to check for an address 
                Dim UI = UserController.GetUserById(PortalId, UserId)

                If (UI.Profile.GetPropertyValue("Street") = "" Or UI.Profile.GetPropertyValue("PostalCode") = "") Then
                    'Need to get address info
                    Response.Redirect(EditUrl("SOGetAdd"))

                End If



                If Session("SOGUID") Is Nothing Then
                    Response.Redirect(NavigateURL(203))

                End If

                Dim da As New AgapeStaffDataContext
                Response.Write(Session("SOGUID"))
                Dim q = From c In da.FR_Give_SO Where c.SoGuid = CStr(Session("SOGUID"))
                If q.Count > 0 Then

                    lblAmount.Text = q.First.Amount.Value.ToString("c2")
                    Select q.First.Frequency
                        Case 12
                            lblFreq.Text = "yearly"
                        Case 3
                            lblFreq.Text = "quartlery"
                        Case 1
                            lblFreq.Text = "monthly"

                        Case Else
                            lblFreq.Text = "every " & q.First.Frequency & " months"
                    End Select
                    lblStart.Text = q.First.StartDate.Value.ToShortDateString


                    Select q.First.GivetoType
                        Case "Staff"
                            Dim staff = GetStaffMember(q.First.RefId)
                            If Not staff Is Nothing Then
                                If staff.UserId2 > 0 Then
                                    lblDonateTo.Text = staff.User.FirstName & " & " & staff.User2.FirstName & " " & staff.User.LastName
                                Else
                                    'lblDonateTo.Text = staff.User.FirstName & " " & staff.User.LastName
                                End If
                            End If
                        Case "XAcc"
                            Dim dBroke As New StaffBrokerDataContext
                            Dim min = From c In dBroke.AP_StaffBroker_Departments Where c.CostCenterId = q.First.RefId Select c.Name
                            Dim min = From c In da.Agape_Main_AvailableCostCentres Where c.AvailableCostCentreId = q.First.RefId Select c.CostCentreName
                            If min.Count > 0 Then
                                lblDonateTo.Text = Min.First
                            End If
                            'Case "Appeal"
                            '    Dim FullDC As New FullStory.FullStoryDataContext
                            '    Dim app = From c In FullDC.Agape_Main_Appeals Where c.AppealId = q.First.RefId Select c.AppealName
                            '    If app.Count > 0 Then
                            '        lblDonateTo.Text = app.First
                            '    End If
                    End Select

                    lblReference.Text = q.First.Reference
                    hfSOID.Value = q.First.SOID


                Else

                    Dim insert As New FR_Give_SO

                    insert.AccountNo = CStr(Session("AccountNo"))
                    insert.Amount = CDbl(Session("Amount"))
                    insert.Frequency = CInt(Session("Frequency"))
                    insert.SortCode = CStr(Session("SortCode"))
                    insert.GivetoType = CStr(Session("GiveToType"))
                    insert.RefId = CInt(Session("RefId"))
                    insert.StartDate = CDate(Session("StartDate"))
                    insert.SetupDate = Today
                    insert.Status = 0
                    insert.UserId = UserId
                    insert.SoGuid = Session("SOGUID")
                    insert.Reference = GetUniqueCode()
                    da.Agape_Main_Give_SOs.InsertOnSubmit(insert)
                    da.SubmitChanges()
                    lblAmount.Text = insert.Amount.Value.ToString("c2")
                    Select insert.Frequency
                        Case 12
                            lblFreq.Text = "yearly"
                        Case 3
                            lblFreq.Text = "quartlery"
                        Case 1
                            lblFreq.Text = "monthly"

                        Case Else
                            lblFreq.Text = "every " & insert.Frequency & " months"
                    End Select
                    lblStart.Text = insert.StartDate.Value.ToShortDateString
                    Dim d As New Resources.ResourcesDataContext
                    Select insert.GivetoType
                        Case "Staff"
                            Dim staff = GetStaffMember(insert.RefId)
                            Dim staff = From c In da.Agape_Staff_Finances Where c.UserId1 = insert.RefId Or c.USerId2 = insert.RefId Select c.DisplayName, c.UserId1, c.USerId2, c.PrimeGetsEmails


                            Dim template = From c In d.Agape_Main_EmailTemplates Where c.TemplateName = "SONotification"

                            If Not staff Is Nothing And template.Count > 0 Then
                                Dim UC As New UserController
                                Dim staffEmail As String = UserController.GetUserById(PortalId, insert.RefId).Email

                                If staff.UserId2 > 0 Then
                                    lblDonateTo.Text = staff.User.FirstName & " & " & staff.User2.FirstName & " " & staff.User.LastName
                                Else
                                    lblDonateTo.Text = staff.User.FirstName & " " & staff.User.LastName
                                End If

                                Dim StaffMessage As String = Server.HtmlDecode(template.First.Template) ' File.ReadAllText(Server.MapPath("/DesktopModules/Give/SONotification.htm"))


                                StaffMessage = StaffMessage.Replace("[STAFFNAME]", lblDonateTo.Text).Replace("[AMOUNT]", lblAmount.Text & " " & lblFreq.Text).Replace("[DONORNAME]", UserInfo.FirstName & " " & UserInfo.LastName).Replace("[DONOREMAIL]", UserInfo.Email)
                                StaffMessage = StaffMessage.Replace("[DONORADDRESS]", UserInfo.Profile.GetPropertyValue("Street") & ", " & UserInfo.Profile.GetPropertyValue("Unit") & "<br />" & UserInfo.Profile.GetPropertyValue("City") & ", " & UserInfo.Profile.GetPropertyValue("County") & "<br />" & UserInfo.Profile.GetPropertyValue("PostalCode"))

                                StaffMessage = StaffMessage.Replace("[START]", lblStart.Text)


                                DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", staffEmail, "donotreply@agape.org.uk", "Notification of standing order", StaffMessage, "", "html", "", "", "", "")





                                'End If



                                'Case "XAcc"
                                'Dim dBroke As New StaffBrokerDataContext
                                'Dim min = From c In dBroke.AP_StaffBroker_Departments Where c.CostCenterId = insert.RefId Select c.Name, c.CostCentreManager
                                'Dim min = From c In da.Agape_Main_AvailableCostCentres Where c.AvailableCostCentreId = insert.RefId Select c.CostCentreName, c.CostCentreManagerLocalId

                                'Dim template = From c In d.Agape_Main_EmailTemplates Where c.TemplateName = "SONotificationXAcc"

                                'If min.Count > 0 And template.Count > 0 Then
                                'lblDonateTo.Text = Min.First.Name

                                'Dim staff = From c In da.Users Where c.UserID = Min.First.CostCentreManager Select c.DisplayName, c.Email
                                'If staff.Count > 0 Then
                                'Dim StaffMessage As String = Server.HtmlDecode(template.First.Template) ' File.ReadAllText(Server.MapPath("/DesktopModules/Give/XAccSONotification.htm"))
                                'StaffMessage = StaffMessage.Replace("[STAFFNAME]", staff.First.DisplayName).Replace("[AMOUNT]", lblAmount.Text & " " & lblFreq.Text).Replace("[DONORNAME]", UserInfo.FirstName & " " & UserInfo.LastName).Replace("[DONOREMAIL]", UserInfo.Email)
                                'StaffMessage = StaffMessage.Replace("[DONORADDRESS]", UserInfo.Profile.GetPropertyValue("Street") & ", " & UserInfo.Profile.GetPropertyValue("Unit") & "<br />" & UserInfo.Profile.GetPropertyValue("City") & ", " & UserInfo.Profile.GetPropertyValue("County") & "<br />" & UserInfo.Profile.GetPropertyValue("PostalCode"))

                                'StaffMessage = StaffMessage.Replace("[START]", lblStart.Text).Replace("[DEPTNAME]", lblDonateTo.Text)



                                'DotNetNuke.Services.Mail.Mail.SendMail("info@agape.org.uk", staff.First.Email, "donotreply@agape.org.uk", "notification of standing order for " & lblDonateTo.Text, StaffMessage, "", "html", "", "", "", "")


                                'End If


                                'End If
                                'Case "Appeal"
                                'Dim FullDC As New FullStory.FullStoryDataContext
                                'Dim app = From c In FullDC.Agape_Main_Appeals Where c.AppealId = insert.RefId Select c.AppealName

                                'Dim template = From c In d.Agape_Main_EmailTemplates Where c.TemplateName = "SONotificationXAcc"

                                'If app.Count > 0 And template.Count > 0 Then
                                'lblDonateTo.Text = app.First

                                'Dim StaffMessage As String = Server.HtmlDecode(template.First.Template) ' File.ReadAllText(Server.MapPath("/DesktopModules/Give/XAccSONotification.htm"))
                                'StaffMessage = StaffMessage.Replace("[STAFFNAME]", "Chris").Replace("[AMOUNT]", lblAmount.Text & " " & lblFreq.Text).Replace("[DONORNAME]", UserInfo.FirstName & " " & UserInfo.LastName).Replace("[DONOREMAIL]", UserInfo.Email)
                                'StaffMessage = StaffMessage.Replace("[DONORADDRESS]", UserInfo.Profile.GetPropertyValue("Street") & ", " & UserInfo.Profile.GetPropertyValue("Unit") & "<br />" & UserInfo.Profile.GetPropertyValue("City") & ", " & UserInfo.Profile.GetPropertyValue("County") & "<br />" & UserInfo.Profile.GetPropertyValue("PostalCode"))

                                'StaffMessage = StaffMessage.Replace("[START]", lblStart.Text).Replace("[DEPTNAME]", lblDonateTo.Text)



                                'DotNetNuke.Services.Mail.Mail.SendMail("ChrisCarter@agape.org.uk", "Chris", "donotreply@agape.org.uk", "notification of standing order for " & lblDonateTo.Text, StaffMessage, "", "html", "", "", "", "")




                                'End If
                                'End Select

                                'lblReference.Text = insert.Reference
                                'hfSOID.Value = insert.SOID
                                CreatePdf()
                                'Send Email

                                'Dim template2 = From c In d.Agape_Main_EmailTemplates Where c.TemplateName = "SOThankYou"
                                'If template2.Count > 0 Then
                                'Dim message As String = Server.HtmlDecode(template2.First.Template) 'System.IO.File.ReadAllText(Server.MapPath("/DesktopModules/Give/EmailTemplate.htm"))
                                'message = message.Replace("[DONORNAME]", UserInfo.DisplayName).Replace("[AMOUNT]", lblAmount.Text & " " & lblFreq.Text).Replace("[RECIPIENT]", lblDonateTo.Text).Replace("[REF]", lblReference.Text).Replace("[START]", lblStart.Text)

                                'DotNetNuke.Services.Mail.Mail.SendMail("Info@agape.org.uk", UserInfo.Email, "donotreply@agape.org.uk", "Thank you for supporting our ministry.", message, Server.MapPath("/Portals/0/Standing Order Form" & UserId & ".pdf"), "HTML", "", "", "", "")

                                'End If
                                Kill(Server.MapPath("/Portals/0/Standing Order Form" & UserId & ".pdf"))

                                'End If





                                'Email the Staff Member 


                                'Email the User


                                HyperLink1.NavigateUrl = "/DesktopModules/Give/SOInstructions.aspx?Amount=" & lblAmount.Text.Replace("£", "") & "&Freq=" & lblFreq.Text & "&Ref=" & lblReference.Text

                                HyperLink2.NavigateUrl = "/DesktopModules/Give/OutputPdf.aspx?SOID=" & hfSOID.Value & "&UserId=" & UserId

                                'End If


                                'LoadPdf()
        End Sub


        Private Sub CreatePdf()
            'Dim d As New AgapeStaff.AgapeStaffDataContext
            'Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = hfSOID.Value
            'If q.Count > 0 Then

            'Dim objUser = UserController.GetUserById(0, q.First.UserId)

            Dim pdfTemplate As String = Server.MapPath("/Portals/0/GAOnline.pdf")


            Dim newFile As String = Server.MapPath("/Portals/0/Standing Order Form" & UserId & ".pdf")



            'Dim pdfReader As New PdfReader(pdfTemplate)

            'Dim pdfStamper As New PdfStamper(pdfReader, New FileStream(newFile, FileMode.Create))


            'Dim pdfFormFields As AcroFields = pdfStamper.AcroFields

            'pdfFormFields.SetField("Firstname", objUser.FirstName)
            'pdfFormFields.SetField("Lastname", objUser.LastName)
            'pdfFormFields.SetField("Reference", q.First.Reference)
            'pdfFormFields.SetField("Accountno", q.First.AccountNo)
            'pdfFormFields.SetField("SortCode", q.First.SortCode)
            'pdfFormFields.SetField("Amount", q.First.Amount.Value.ToString("0.00"))
            'pdfFormFields.SetField("Address1", objUser.Profile.GetPropertyValue("Street"))
            'pdfFormFields.SetField("Address2", objUser.Profile.GetPropertyValue("Unit"))
            'pdfFormFields.SetField("City", objUser.Profile.GetPropertyValue("City"))
            'pdfFormFields.SetField("County", objUser.Profile.GetPropertyValue("County"))
            'pdfFormFields.SetField("Postcode", objUser.Profile.GetPropertyValue("PostalCode"))

            'pdfFormFields.SetField("Phone", objUser.Profile.GetPropertyValue("Telephone"))

            'pdfFormFields.SetField("Monthly", IIf(q.First.Frequency = 1, "Yes", "0"))
            'pdfFormFields.SetField("Quaterly", IIf(q.First.Frequency = 3, "Yes", "0"))
            'pdfFormFields.SetField("Yearly", IIf(q.First.Frequency = 12, "Yes", "0"))

            'pdfFormFields.SetField("StartDay", Day(q.First.StartDate))
            'pdfFormFields.SetField("StartMonth", Month(q.First.StartDate))
            'pdfFormFields.SetField("StartYear", Year(q.First.StartDate) - 2000)


            'pdfStamper.FormFlattening = False


            ' close the pdf

            'pdfStamper.Close()


            'End If


        End Sub



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
            'Dim d As New AgapeStaffDataContext
            'Dim count = (From c In d.Agape_Main_Give_SOs Where c.Reference = code).Count
            'Return IIf(count = 0, True, False)

        End Function



        'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        '    Try


        '        Response.Redirect("/DesktopModules/Give/OutputPdf.aspx?SOID=" & hfSOID.Value & "&UserId=" & UserId)
        '    Catch ex As Exception
        '        Label1.Text = ex.Message

        '    End Try

        'End Sub
    End Class
End Namespace
