Imports iTextSharp

Imports iTextSharp.text
Imports System.IO
Imports System.Linq


Imports iTextSharp.text.pdf
Partial Class DesktopModules_Give_OutputPdf
    Inherits System.Web.UI.Page


    Private Sub LoadPdf()
        Dim d As New AgapeStaff.AgapeStaffDataContext
        Dim q = From c In d.Agape_Main_Give_SOs Where c.SOID = CInt(Request.QueryString("SOID"))
        If q.Count > 0 Then

            Dim objUser = UserController.GetUserById(0, q.First.UserId)

            Response.Clear()
            'Response.AddHeader("Accept-Header", objMemoryStream.Length.ToString())
            Response.ClearHeaders()
            Response.ClearContent()


            Response.ContentType = "application/pdf"


            Dim pdfTemplate As String = Server.MapPath("/Portals/0/GAOnline.pdf")

            'Dim newFile As String = Server.MapPath("/Portals/0/GANew" & UserId & ".pdf")


            Dim pdfReader As New PdfReader(pdfTemplate)

            Dim pdfStamper As New PdfStamper(pdfReader, Response.OutputStream)


            Dim pdfFormFields As AcroFields = pdfStamper.AcroFields

            pdfFormFields.SetField("Firstname", objUser.FirstName)
            pdfFormFields.SetField("Lastname", objUser.LastName)
            pdfFormFields.SetField("Reference", q.First.Reference)
            pdfFormFields.SetField("Accountno", q.First.AccountNo)
            pdfFormFields.SetField("SortCode", q.First.SortCode(0) & q.First.SortCode(1) & "-" & q.First.SortCode(2) & q.First.SortCode(3) & "-" & q.First.SortCode(4) & q.First.SortCode(5))
            pdfFormFields.SetField("Amount", q.First.Amount.Value.ToString("0.00"))
            pdfFormFields.SetField("Address1", objUser.Profile.GetPropertyValue("Street"))
            pdfFormFields.SetField("Address2", objUser.Profile.GetPropertyValue("Unit"))
            pdfFormFields.SetField("City", objUser.Profile.GetPropertyValue("City"))
            pdfFormFields.SetField("County", objUser.Profile.GetPropertyValue("County"))
            pdfFormFields.SetField("Postcode", objUser.Profile.GetPropertyValue("PostalCode"))

            pdfFormFields.SetField("Phone", objUser.Profile.GetPropertyValue("Telephone"))

            pdfFormFields.SetField("Monthly", IIf(q.First.Frequency = 1, "Yes", "0"))
            pdfFormFields.SetField("Quaterly", IIf(q.First.Frequency = 3, "Yes", "0"))
            pdfFormFields.SetField("Yearly", IIf(q.First.Frequency = 12, "Yes", "0"))

            pdfFormFields.SetField("StartDay", Day(q.First.StartDate).ToString("d2"))
            pdfFormFields.SetField("StartMonth", Month(q.First.StartDate).ToString("d2"))
            pdfFormFields.SetField("StartYear", (Year(q.First.StartDate) - 2000).ToString("d2"))


            pdfStamper.FormFlattening = False


            ' close the pdf

            pdfStamper.Close()


            Response.OutputStream.Flush()
        End If


    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadPdf()
    End Sub
End Class
