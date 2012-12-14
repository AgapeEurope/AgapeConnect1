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
Imports System.Xml.Linq
Imports System.Linq
Imports Billboard
Partial Class DesktopModules_Billboard_GetTempBillboardImage
    Inherits System.Web.UI.Page
    Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) _
            Handles Me.Load

        Dim Size As Integer = Request.QueryString("Size")

        Dim d As New Billboard.BillboardDataContext
        Dim img As Byte()
        If Request.QueryString("Mode") = 1 Then
            Dim u = From c In d.Agape_Billboard_Photos Select c.PhotoData, c.BillboardPhotoId Where BillboardPhotoId = Request.QueryString("PhotoId")
            img = u.First.PhotoData.ToArray
        Else
            Dim u = From c In d.Agape_Billboard_TempPhotos Select c.TempPhotoData, c.UserId Where UserId = Request.QueryString("UserId")
            img = u.First.TempPhotoData.ToArray
        End If





        Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream(img)
        Dim profPic As System.Drawing.Image = System.Drawing.Image.FromStream(ms)
        Dim height As Integer = profPic.Height * Size / profPic.Width

        Dim thumbnail As System.Drawing.Image = profPic.GetThumbnailImage(Size, height, Nothing, IntPtr.Zero)
        thumbnail.Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg)






    End Sub

End Class
