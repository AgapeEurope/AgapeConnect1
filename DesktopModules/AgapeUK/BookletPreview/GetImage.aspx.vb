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
Partial Class DesktopModules_FullStory_GetImage
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) _
            Handles Me.Load
      
        Try

        
           


            Dim d As New BookletDataContext

            Dim img = (From c In d.Agape_Main_BookletImages Where c.ModuleId = Request.QueryString("ModuleId") And c.ViewOrder = Request.QueryString("ViewOrder") Select c).Single
           

            Dim b As Byte() = img.PageImage.ToArray



            Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream(b)
            Dim thumbnail As System.Drawing.Image = System.Drawing.Image.FromStream(ms)
          
            thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)

            'Next
        Catch ex As Exception
            Dim original As System.Drawing.Image = Bitmap.FromFile(Server.MapPath("images/No Image.jpg"))
        original.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)
        End Try



    End Sub


   
End Class
