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
Imports System.Drawing
Imports UK.Booklet
Partial Class DesktopModules_FullStory_GetImageResize
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) _
            Handles Me.Load
        Dim Size As Integer = Request.QueryString("Size")

        Try





            Dim d As New BookletDataContext

            Dim img = (From c In d.Agape_Main_BookletImages Where c.ModuleId = Request.QueryString("ModuleId") And c.ViewOrder = Request.QueryString("ViewOrder") Select c).Single
            'd.Agape_Main_Story_GetPhoto(Request.QueryString("PhotoId"))

            'For Each r In img

            Dim b As Byte() = img.PageImage.ToArray



            Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream(b)
            Dim profPic As System.Drawing.Image = System.Drawing.Image.FromStream(ms)
            Dim height As Integer = profPic.Height * Size / profPic.Width

            Dim thumbnail As System.Drawing.Image = ResizeImage(profPic, Size)
            thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)

            'Next
        Catch ex As Exception
            Dim original As System.Drawing.Image = Bitmap.FromFile(Server.MapPath("images/No Image.jpg"))
            Dim height As Integer = original.Height * Size / original.Width
            Dim thumbnail As System.Drawing.Image = ResizeImage(original, Size)


            thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
        End Try



    End Sub


    Private Function ResizeImage(ByVal mg As Image, ByVal newSize As Integer) As Image

        Dim ratio As Double = 0D
        Dim myThumbWidth As Double = 0D
        Dim myThumbHeight As Double = 0D
        Dim bp As Bitmap



        ratio = mg.Width / mg.Height
        myThumbWidth = newSize
        myThumbHeight = newSize / ratio

        Dim thumbSize As Size = New Size(CInt(myThumbWidth), CInt(myThumbHeight))
        bp = New Bitmap(CInt(myThumbWidth), CInt(myThumbHeight))


        Dim g As Graphics = Graphics.FromImage(bp)
        g.SmoothingMode = Drawing2D.SmoothingMode.HighQuality
        g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
        g.PixelOffsetMode = Drawing2D.PixelOffsetMode.HighQuality
        Dim rect As Rectangle = New Rectangle(0, 0, thumbSize.Width, thumbSize.Height)
        g.DrawImage(mg, rect, 0, 0, mg.Width, mg.Height, GraphicsUnit.Pixel)
        Return bp
    End Function
End Class
