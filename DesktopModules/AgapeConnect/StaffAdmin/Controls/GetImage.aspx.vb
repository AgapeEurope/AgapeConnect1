﻿Imports DotNetNuke
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

Partial Class DesktopModules_FullStory_GetImage
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) _
            Handles Me.Load

        Dim Size As Integer = Request.QueryString("Size")



        Dim d As New StaffBroker.StaffBrokerDataContext

        Dim img = From c In d.AP_Images Where c.ImageId = Request.QueryString("ImageId")
        If img.Count > 0 Then

      
            Try
                Dim b As Byte() = img.First.Content.ToArray
                Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream(b)
                Dim profPic As System.Drawing.Image = System.Drawing.Image.FromStream(ms)
                Dim height As Integer = profPic.Height * Size / profPic.Width

                Dim thumbnail As System.Drawing.Image = ResizeImage(profPic, Size)
                thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
            Catch ex As Exception
                Response.WriteFile("No Image.jpg")
            End Try
        Else
            Response.WriteFile("No Image.jpg")
        End If




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
