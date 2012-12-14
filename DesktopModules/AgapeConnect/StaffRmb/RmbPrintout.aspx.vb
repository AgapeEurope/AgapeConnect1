Imports System.Linq
Imports StaffRmb
Partial Class DesktopModules_StaffRmb_RmbPrintout
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim Cur As String = StaffBrokerFunctions.GetSetting("Currency", PS.PortalId)

        Dim d As New StaffRmbDataContext
        Dim dt As New StaffBroker.TemplatesDataContext
        Dim q = From c In d.AP_Staff_Rmbs Where c.RMBNo = Request.QueryString("RmbNo") And c.UserId = Request.QueryString("UID")
        If q.Count > 0 Then
            Dim printout = From c In dt.AP_StaffBroker_Templates Where c.TemplateName = "RmbPrintOut" And c.PortalId = PS.PortalId Select c.TemplateHTML
            Dim output As String = ""
            If printout.Count > 0 Then
                output = Server.HtmlDecode(printout.First)
            End If
            ' Dim output As String = System.IO.File.ReadAllText(Server.MapPath("RmbPrintOut.htm"))

            Dim RmbNoText As String = q.First.RID
            If Request.QueryString("Year") <> "" And Request.QueryString("Period") <> "" Then
                RmbNoText &= "<br /><span style=""font-size: 12pt;"">(Period " & Request.QueryString("Period") & ", " & Request.QueryString("Year").ToString & ")</span>"

            End If

            output = output.Replace("[RMBNO]", RmbNoText)
            If Not q.First.RmbDate Is Nothing Then
                output = output.Replace("[SUBMITTEDDATE]", q.First.RmbDate.Value.ToString("dd/MM/yyyy"))
            Else
                If Request.QueryString("mode") = 1 Then
                    output = output.Replace("[SUBMITTEDDATE]", Today.ToString("dd/MM/yyyy"))
                Else
                    output = output.Replace("[SUBMITTEDDATE]", "")
                End If
            End If
            output = output.Replace("[SUBMITTEDBY]", UserController.GetUserById(q.First.PortalId, q.First.UserId).DisplayName)
            If Not Request.QueryString("Period") Is Nothing And Not Request.QueryString("Year") Is Nothing Then
                output = output.Replace("[POSTED]", "<span class=""Agape_Body_Text"">Year Posted: " & Request.QueryString("Year") & ", Period Posted: " & Request.QueryString("Period") & "</span><br/>")
            Else
                output = output.Replace("[POSTED]", "")
            End If

            If Not q.First.UserRef Is Nothing Then
                output = output.Replace("[YOURREF]", q.First.UserRef)
            End If




            output = output.Replace("[CHARGETO]", GetCostCentreName(q.First.CostCenter, q.First.UserId, q.First.PortalId))
            If q.First.AP_Staff_RmbLines.Count > 0 Then
                output = output.Replace("[RMBTOTAL]", Cur & (From c In q.First.AP_Staff_RmbLines Select c.GrossAmount).Sum().ToString("0.00"))
            Else
                output = output.Replace("[RMBTOTAL]", Cur & "0.00")
            End If

            Dim lines As String = ""

            Dim theLines = From c In q.First.AP_Staff_RmbLines Where c.Receipt = False
            If theLines.Count > 0 Then
                output = output.Replace("[RMBHEADER1]", "<tr class=""Agape_Red_H5""><td>Date</td><td>Type</td><td>Description</td><td>Taxed</td><td>Amount</td><td></td><td></td><td></td></tr>")

                For Each row In theLines
                    lines = lines & "<tr><td>" & row.TransDate.ToString("dd/MM/yyyy") & "</td>"

                    lines = lines & "<td><span style=""color: #AAA;"">" & row.AccountCode & "-</span>" & GetLocalTypeName(row.LineType, PS.PortalId) & "</td>"
                    lines = lines & "<td>" & row.Comment

                    If row.AP_Staff_RmbLineType.TypeName = "Mileage" Then
                        If row.Spare1 > 0 Then


                            'lines += "<br/ ><span class=""Agape_SubTitle"">Passengers: "
                            'For Each person In row.Agape_Staff_RmbLine.AddStaffs
                            '    lines += person.Name & " + "
                            'Next
                            'lines = Left(lines, lines.Length - 3)
                            'lines += "</span>"
                        End If
                    End If

                    lines = lines & "</td>"
                    lines = lines & "<td>" & IIf(row.Taxable, "Yes", "No") & "</td>"
                    lines = lines & "<td>" & Cur & row.GrossAmount.ToString("0.00") & "</td>"
                    lines = lines & "<td>" & "</td>"   ' row.VATCode & "</td>"
                    lines = lines & "<td></td><td></td></tr>"

                Next
            Else
                output = output.Replace("[RMBHEADER1]", "")

            End If



            output = output.Replace("[RMBLINES1]", lines)

            lines = ""


            theLines = From c In q.First.AP_Staff_RmbLines Where c.Receipt = True Order By c.ReceiptNo
            If theLines.Count > 0 Then
                For Each row In theLines

                    lines = lines & "<tr><td>" & row.TransDate.ToShortDateString & "</td>"
                    lines = lines & "<td><span style=""color: #AAA;"">" & row.AccountCode & "-</span>" & GetLocalTypeName(row.LineType, PS.PortalId) & "</td>"
                    lines = lines & "<td>" & row.Comment
                    If row.AP_Staff_RmbLineType.TypeName = "Mileage" Then
                        If row.Spare1 > 0 Then


                            'lines += "<br/ ><span class=""Agape_SubTitle"">Passengers: "
                            'For Each person In row.Agape_Staff_RmbLineAddStaffs
                            '    lines += person.Name & " + "
                            'Next
                            'lines = Left(lines, lines.Length - 3)
                            'lines += "</span>"
                        End If
                    End If

                    lines = lines & "</td>"
                    lines = lines & "<td>" & IIf(row.Taxable, "Yes", "No") & "</td>"
                    lines = lines & "<td>" & Cur & row.GrossAmount.ToString("0.00") & "</td>"
                    lines = lines & "<td>" & IIf(row.VATReceipt, "Yes", "No") & "</td>"
                    lines = lines & "<td>" & "</td>" ' row.VATCode & "</td>"
                    lines = lines & "<td>" & row.ReceiptNo & "</td></tr>"
                Next
                Dim newHeaders As String = " <tr class=""Agape_Red_H5""><td>Date</td><td>Type</td><td>Description</td><td>Taxed</td><td>Amount</td><td>VAT Receipt</td><td>VAT-Code</td><td>Receipt No</td> </tr>"

                output = output.Replace("[RCPTINSTRUCTIONS]", "The following expenses require a receipt. Please attach the receipts to this page (use extra pages if necessary) and number as listed below. Post this form directly to the Agap&eacute; National Office.(Agap&eacute;, 3 Temple Row West, BIRMINGHAM, B2 5NY)")
                output = output.Replace("[RMBLINES2]", newHeaders & lines)
            Else
                output = output.Replace("[RCPTINSTRUCTIONS]", "This reimbursement requires no receipts and you do not need to send any paperwork to Agap&eacute;. This page is for your records only.")
                output = output.Replace("[RMBLINES2]", lines)
            End If







            PlaceHolder1.Controls.Add(New LiteralControl(output))

        End If
    End Sub

    Private Function GetCostCentreName(ByVal CostCentre As String, ByVal UserId As Integer, ByVal PortalId As Integer) As String

        Dim sm = StaffBrokerFunctions.GetStaffMember(UserId)
        'Dim d As New StaffBroker
        If (sm.CostCenter = CostCentre) Then
            Return sm.DisplayName & "(" & CostCentre & ")"
        End If
        Dim d As New StaffBroker.StaffBrokerDataContext
        Dim dept = From c In d.AP_StaffBroker_Departments Where c.CostCentre = CostCentre

        If dept.Count > 0 Then
            Return dept.First.Name & "(" & CostCentre & ")"
        Else
            Return CostCentre
        End If

       


    End Function
    Public Function GetLocalTypeName(ByVal LineTypeId As Integer, ByVal PortalId As Integer) As String
        Dim d As New StaffRmbDataContext
        Dim q = From c In d.AP_StaffRmb_PortalLineTypes Where c.LineTypeId = LineTypeId And c.PortalId = PortalId Select c.LocalName

        If q.Count > 0 Then
            Return q.First
        Else
            Dim r = From c In d.AP_Staff_RmbLineTypes Where c.LineTypeId = LineTypeId Select c.TypeName
            If r.Count > 0 Then
                Return r.First

            Else

                Return "?"
            End If

        End If

    End Function
End Class
