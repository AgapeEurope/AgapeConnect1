Imports iTextSharp
Imports iTextSharp.text
Imports System.IO
Imports System.Linq
Imports iTextSharp.text.pdf
Imports Give
Partial Class DesktopModules_Give_OutputPdf
    Inherits System.Web.UI.Page

    Private Sub LoadPdf()
        Dim d As New GiveDataContext
        Dim q = From c In d.Agape_Give_BankTransfers Where c.Reference = Request.QueryString("SOID")
        Dim nowUser As UserInfo = DotNetNuke.Entities.Users.UserController.GetCurrentUserInfo
        'be sure correct user is logged in
        If nowUser.UserID = q.First.DonorId Then
            If q.Count > 0 Then
                Dim objUser = UserController.GetUserById(0, q.First.DonorId)
                Response.Clear()
                Response.ClearHeaders()
                Response.ClearContent()
                Response.ContentType = "application/pdf"
                Dim userAddress = objUser.Profile.GetPropertyValue("Street")
                If Not objUser.Profile.GetPropertyValue("Unit") = "" Then
                    userAddress += vbCrLf & objUser.Profile.GetPropertyValue("Unit")
                End If
                userAddress += vbCrLf & objUser.Profile.GetPropertyValue("PostalCode") & " " & objUser.Profile.GetPropertyValue("City")
                Dim theFreq = "Error"
                'TRENT: work on translation?
                If q.First.Frequency = 1 Then
                    theFreq = "Mensuellement"
                ElseIf q.First.Frequency = 3 Then
                    theFreq = "Trimestriellement"
                ElseIf q.First.Frequency = 6 Then
                    theFreq = "Semestriellement"
                ElseIf q.First.Frequency = 12 Then
                    theFreq = "Annuellement"
                ElseIf q.First.Frequency = 99 Then
                    theFreq = ""
                End If

                Dim theParagraph = "Je, soussigné(e), prie l’établissement tenant mon compte d’effectuer au profit du titulaire du compte d’Agapé France, désigné ci-dessus, un virement " & theFreq & " de " & q.First.Amount.ToString() & "€"
                If q.First.Frequency = 99 Then
                    theParagraph += "."
                Else
                    theParagraph += ", à partir du " & Today() & " et jusqu'à résiliation de ma part."
                End If
                Dim bankAddress = q.First.BankStreet1
                If Not q.First.BankStreet2 = "" Then
                    bankAddress += vbCrLf & q.First.BankStreet2
                End If
                bankAddress += vbCrLf & q.First.BankPostal & " " & q.First.BankCity

                Dim pdfTemplate As String = Server.MapPath("/Portals/0/virement.pdf")

                'Dim newFile As String = Server.MapPath("/Portals/0/Standing Order Form" & UserId & ".pdf")
                Dim newFile As String = Server.MapPath("/Portals/0/Filled.pdf")

                Dim pdfReader As New PdfReader(pdfTemplate)
                Dim pdfStamper As New PdfStamper(pdfReader, Response.OutputStream)
                'Dim pdfStamper As New PdfStamper(pdfReader, New FileStream(newFile, FileMode.Create))

                Dim pdfFormFields As AcroFields = pdfStamper.AcroFields
                pdfFormFields.SetField("LastName", objUser.LastName)
                pdfFormFields.SetField("FirstName", objUser.FirstName)
                pdfFormFields.SetField("Address", userAddress)
                pdfFormFields.SetField("Paragraph", theParagraph)
                pdfFormFields.SetField("Bank", q.First.BankName)
                pdfFormFields.SetField("BankAddress", bankAddress)
                pdfFormFields.SetField("IBAN", q.First.acNo)
                pdfFormFields.SetField("Paragraph", theParagraph)
                pdfStamper.FormFlattening = True
                ' close the pdf
                pdfStamper.Close()
                'Response.OutputStream.Flush()
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadPdf()
    End Sub
End Class