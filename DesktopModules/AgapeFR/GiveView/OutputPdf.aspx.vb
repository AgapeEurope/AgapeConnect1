Imports iTextSharp
Imports iTextSharp.text
Imports System.IO
Imports System.Linq
Imports iTextSharp.text.pdf
Imports Give
Imports DotNetNuke.Common
Imports StaffBroker
Imports StaffBrokerFunctions

Partial Class DesktopModules_Give_OutputPdf
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'check if anyone is logged in
        If Not Request.IsAuthenticated Then
            Dim ps As PortalSettings = Globals.GetPortalSettings
            Response.Redirect(Globals.NavigateURL(ps.LoginTabId, True, ps, "Login", "returnurl=" & Server.UrlEncode(Request.Url.ToString)))
        Else
            Dim d As New GiveDataContext
            Dim soid = Request.QueryString("SOID")
            Dim count = (From c In d.Agape_Give_BankTransfers Where c.Reference = soid).Count
            If count > 0 Then
                Dim q = From c In d.Agape_Give_BankTransfers Where c.Reference = soid
                Dim nowUser As UserInfo = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo
                'be sure correct user is logged in
                If nowUser.UserID = q.First.DonorId Then
                    Dim GiveMeth = q.First.GiveMethod
                    If GiveMeth = 1 Then
                        LoadPdfVirement()
                    ElseIf GiveMeth = 2 Then
                        LoadPdfCheque()
                    End If
                Else
                    'Trent: This needs to redirect to an error page.
                    Response.Redirect("http://www.agapefrance.org")
                End If
            Else
                'Trent: This is another error page.
                Response.Redirect("http://www.agapefrance.org")
            End If

        End If
    End Sub

    Private Sub LoadPdfVirement()
        Dim d As New GiveDataContext
        Dim q = From c In d.Agape_Give_BankTransfers Where c.Reference = Request.QueryString("SOID")
        Dim objUser = UserController.GetUserById(0, q.First.DonorId)
        Response.Clear()
        Response.ClearHeaders()
        Response.ClearContent()
        Response.ContentType = "application/pdf"
        Dim userAddress = objUser.Profile.Street
        If Not objUser.Profile.Unit = "" Then
            userAddress += vbCrLf & objUser.Profile.Unit
        End If
        userAddress += vbCrLf & objUser.Profile.PostalCode & " " & objUser.Profile.City & vbCrLf & objUser.Profile.Country
        Dim theFreq = "Error"
        'TRENT: work on translation
        If q.First.Frequency = 1 Then
            theFreq = " mensuel"
        ElseIf q.First.Frequency = 3 Then
            theFreq = " trimestriel"
        ElseIf q.First.Frequency = 6 Then
            theFreq = " semestriel"
        ElseIf q.First.Frequency = 12 Then
            theFreq = " annuel"
        ElseIf q.First.Frequency = 99 Then
            theFreq = ""
        End If
        Dim soid = q.First.Reference
        Dim theParagraph = "Je, soussigné(e), prie l’établissement tenant mon compte d’effectuer au profit du titulaire du compte d’Agapé France, désigné ci-dessus, un virement" & theFreq & " de " & q.First.Amount.ToString() & "€"
        If q.First.Frequency = 99 Then
            theParagraph += ". Le code pour ce don est " & soid & "."
        Else
            theParagraph += ", à partir du " & Today().ToString("dd/MM/yyyy") & " et jusqu'à résiliation de ma part. Merci d'indiquer cette référence dans le libellé du virement : " & soid & "."
        End If

        Dim pdfTemplate As String = Server.MapPath("/Portals/0/virement.pdf")
        Dim pdfReader As New PdfReader(pdfTemplate)
        Dim pdfStamper As New PdfStamper(pdfReader, Response.OutputStream)
        Dim pdfFormFields As AcroFields = pdfStamper.AcroFields
        pdfFormFields.SetField("LastName", objUser.LastName)
        pdfFormFields.SetField("FirstName", objUser.FirstName)
        pdfFormFields.SetField("Address", userAddress)
        pdfFormFields.SetField("Paragraph", theParagraph)
        pdfFormFields.SetField("IBAN", q.First.acNo)
        pdfFormFields.SetField("Paragraph", theParagraph)
        pdfStamper.FormFlattening = True
        ' close the pdf
        pdfStamper.Close()
        Response.OutputStream.Flush()
    End Sub

    Private Sub LoadPdfCheque()
        Dim d As New GiveDataContext
        Dim q = From c In d.Agape_Give_BankTransfers Where c.Reference = Request.QueryString("SOID")
        Dim objUser = UserController.GetUserById(0, q.First.DonorId)
        Response.Clear()
        Response.ClearHeaders()
        Response.ClearContent()
        Response.ContentType = "application/pdf"
        Dim userAddress = objUser.Profile.Street
        If Not objUser.Profile.Unit = "" Then
            userAddress += vbCrLf & objUser.Profile.Unit
        End If
        userAddress += vbCrLf & objUser.Profile.PostalCode & " " & objUser.Profile.City & vbCrLf & objUser.Profile.Country
        Dim theFreq = "Error"
        'TRENT: work on translation
        If q.First.Frequency = 1 Then
            theFreq = " Mensuelle"
        ElseIf q.First.Frequency = 3 Then
            theFreq = " Trimestrielle"
        ElseIf q.First.Frequency = 6 Then
            theFreq = " Semestrielle"
        ElseIf q.First.Frequency = 12 Then
            theFreq = " Annuelle"
        ElseIf q.First.Frequency = 99 Then
            theFreq = ""
        End If
        Dim soid = q.First.Reference
        Dim theRecip As String = ""
        Dim dBroke As New StaffBrokerDataContext
        'Find the staff name.
        If q.First.DonationType = DestinationType.Staff Then
            Dim staff = From c In dBroke.AP_StaffBroker_Staffs Where (c.StaffId = q.First.TypeId)
            'Detect if UnNamed - if so use giving shortcut instead
            If GetStaffProfileProperty(staff.First.StaffId, "UnNamedStaff") = "True" Then
                theRecip = GetStaffProfileProperty(staff.First.StaffId, "GivingShortcut")
            Else
                theRecip = ChangeName(staff.First.DisplayName)
            End If
        End If
        If q.First.DonationType = DestinationType.Department Or q.First.DonationType.Value = DestinationType.Project Then
            Dim Dept = From c In dBroke.AP_StaffBroker_Departments Where (c.CostCenterId = q.First.TypeId)
            If Dept.Count > 0 Then
                theRecip = Dept.First.Name
            End If
        End If
        Dim theParagraph = "Je vais envoyer un chèque" & theFreq & " de " & q.First.Amount.ToString() & "€. La référence pour ce don est : " & soid & ". Le destinataire est " & theRecip & " ."

        Dim pdfTemplate As String = Server.MapPath("/Portals/0/cheque.pdf")
        Dim pdfReader As New PdfReader(pdfTemplate)
        Dim pdfStamper As New PdfStamper(pdfReader, Response.OutputStream)
        Dim pdfFormFields As AcroFields = pdfStamper.AcroFields
        pdfFormFields.SetField("LastName", objUser.LastName)
        pdfFormFields.SetField("FirstName", objUser.FirstName)
        pdfFormFields.SetField("Address", userAddress)
        pdfFormFields.SetField("Paragraph", theParagraph)
        pdfStamper.FormFlattening = True
        ' close the pdf
        pdfStamper.Close()
        Response.OutputStream.Flush()
    End Sub
    Private Function ChangeName(ByVal inName As String) As String
        If inName.IndexOf("&") > 0 Then
            inName = inName.Replace("&", "et")
        End If
        Return inName
    End Function

End Class