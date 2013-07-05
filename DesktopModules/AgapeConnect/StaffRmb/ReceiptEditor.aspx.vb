Imports DotNetNuke

Imports DotNetNuke.Services.FileSystem
Imports System.Drawing.Imaging
Imports System.Drawing
Imports System.IO


Partial Class DesktopModules_AgapeConnect_StaffRmb_ReceiptEditor
    Inherits System.Web.UI.Page
    Private imgExt() As String = {"jpg", "jpeg", "gif", "png", "bmp"}
    Protected Sub btnUploadReceipt_Click(sender As Object, e As EventArgs) Handles btnUploadReceipt.Click
        If fuReceipt.HasFile Then
            Dim Filename As String = fuReceipt.FileName
            Dim ext As String = Filename.Substring(Filename.LastIndexOf(".") + 1)
            If imgExt.Contains(ext.ToLower) Then
                Dim d As New StaffRmb.StaffRmbDataContext

                Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)

                Dim RmbNo As String = Request.QueryString("RmbNo")
                Dim RmbLine As String = Request.QueryString("RmbLine")
                Dim theRmb = (From c In d.AP_Staff_Rmbs Where c.PortalId = PS.PortalId And c.RMBNo = RmbNo).First




                Dim theFolder As IFolderInfo
                If FolderManager.Instance.FolderExists(PS.PortalId, "_RmbReceipts\" & theRmb.UserId) Then
                    theFolder = FolderManager.Instance.GetFolder(PS.PortalId, "_RmbReceipts\" & theRmb.UserId)
                Else
                    theFolder = FolderManager.Instance.AddFolder(PS.PortalId, "_RmbReceipts\" & theRmb.UserId)
                End If
                Dim img = New Bitmap(fuReceipt.FileContent)
                Dim newWidth = 1000

                Dim Quality = 72
                If (Not img.HorizontalResolution = Nothing) Then
                    newWidth = img.Width * Quality / img.HorizontalResolution
                End If
                If (img.Width > 1000) Then
                    newWidth = 1000
                End If

                Dim newHeight = newWidth / (img.Width / img.Height)

                Dim result = New Bitmap(newWidth, newHeight, Drawing.Imaging.PixelFormat.Format32bppPArgb)
                result.SetResolution(img.HorizontalResolution, img.VerticalResolution)
                Dim g = Graphics.FromImage(result)
                g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic


                g.DrawImage(img, New Rectangle(0, 0, newWidth, newHeight), New Rectangle(0, 0, img.Width, img.Height), GraphicsUnit.Pixel)

                Dim myMemoryStream As New IO.MemoryStream
                '  Dim codecInfo = ImageUtils.GetEncoderInfo("Jpeg")


                '  Dim parameters As EncoderParameters = New EncoderParameters(1)
                '  parameters.Param(0) = New EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 10L)

                result.Save(myMemoryStream, ImageFormat.Jpeg)
                result.Dispose()
                g.Dispose()



                Dim _theFile = FileManager.Instance.AddFile(theFolder, CreateUniqueName(theFolder, "R" & RmbNo & "L" & RmbLine), myMemoryStream, True)
                Dim _FileId = _theFile.FileId




                myMemoryStream.Dispose()
                imgReceipt.ImageUrl = FileManager.Instance.GetUrl(_theFile)
                imgReceipt.Visible = True


            Else
                'Not image file
                lblError.Text = "* File must end in .jpg, .jpeg, .gif or .png<br />"
            End If


        End If



    End Sub
    Private Function CreateUniqueName(ByVal theFolder As IFolderInfo, Prefix As String) As String
        Dim allChars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ123456789"

        Dim GotUniqueCode As Boolean = False
        Dim uniqueCode As String = ""

        Dim str As New System.Text.StringBuilder
        Dim xx As Integer

        While uniqueCode = "" Or FileManager.Instance.FileExists(theFolder, IIf(uniqueCode = "", "X", uniqueCode))
            For i As Byte = 1 To 5 'length of req key
                Randomize()
                xx = Rnd() * (Len(allChars) - 1) 'number of rawchars
                str.Append(allChars.Trim.Chars(xx))
            Next
            uniqueCode = Prefix & "-" & str.ToString & ".jpg"
        End While




        Return uniqueCode

    End Function
    Protected Sub btnRotateLeft_Click(sender As Object, e As EventArgs) Handles btnRotateLeft.Click
        Dim RmbNo As String = Request.QueryString("RmbNo")
        Dim RmbLine As String = Request.QueryString("RmbLine")
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim d As New StaffRmb.StaffRmbDataContext
        Dim theRmb = (From c In d.AP_Staff_Rmbs Where c.PortalId = PS.PortalId And c.RMBNo = RmbNo).First


        Dim theFolder As IFolderInfo = FolderManager.Instance.GetFolder(PS.PortalId, "_RmbReceipts\" & theRmb.UserId)

        Dim theFile = FolderManager.Instance.GetFiles(theFolder, False).Where(Function(c) c.FileName.Contains("R" & RmbNo & "L" & RmbLine & "-")).First()
      

        Dim img = New Bitmap(Server.MapPath(FileManager.Instance.GetUrl(theFile)))
        img.RotateFlip(RotateFlipType.Rotate90FlipNone)

        '  Dim result = New Bitmap(img.Height, img.Width, Drawing.Imaging.PixelFormat.Format32bppPArgb)
        ' result.SetResolution(img.VerticalResolution, img.HorizontalResolution)
        ' Dim g = Graphics.FromImage(result)
        ' g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
      
        '   g.TranslateTransform(img.Height / 2, img.Width / 2)
        '   g.RotateTransform(90)
        '  g.TranslateTransform(-img.Height / 2, -img.Width / 2)

        '  g.DrawImage(img, points)
        '  g.DrawImage(img, New Point(0, 0))
        ' g.DrawImage(img, New Rectangle(0, 0, img.Width, img.Height), New Rectangle(0, 0, img.Width, img.Height), GraphicsUnit.Pixel)
        Dim myMemoryStream As New IO.MemoryStream
        img.Save(myMemoryStream, ImageFormat.Jpeg)
        '  result.Dispose()
        img.Dispose()
        ' g.Dispose()
  

        ' result.Save("C:\aLocalSVN\AgapeConnect12\Portals\0\_imageCropper\MHuSGwLYED.jpg")
        If Not theFile Is Nothing Then
            Try
                FileManager.Instance.DeleteFile(theFile)
            Catch ex As Exception
                lblError.Text = ex.ToString
            End Try

        End If

      
        '  Dim codecInfo = ImageUtils.GetEncoderInfo("Jpeg")


        '  Dim parameters As EncoderParameters = New EncoderParameters(1)
        '  parameters.Param(0) = New EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 10L)



        'Dim _theFile = FileManager.Instance.UpdateFile(theFile, myMemoryStream)
        Dim _theFile = FileManager.Instance.AddFile(theFolder, CreateUniqueName(theFolder, "R" & RmbNo & "L" & RmbLine), myMemoryStream, True)
        imgReceipt.ImageUrl = FileManager.Instance.GetUrl(_theFile)
        myMemoryStream.Dispose()
    End Sub
    Private Function RotatePoint(ByVal p As Point, ByVal angle As Double) As Point

        Dim x As Integer = p.X * Math.Cos(angle) + p.Y * Math.Sin(angle)
        Dim y As Integer = -p.X * Math.Sin(angle) + p.Y * Math.Cos(angle)

        Return New Point(x, y)

    End Function
End Class
