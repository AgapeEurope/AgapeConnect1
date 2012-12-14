Imports DotNetNuke
Imports System.Web.UI
Imports System.Xml.Linq
Imports System.Linq
Imports UK.Booklet
Imports System.Drawing

Namespace DotNetNuke.Modules.Booklet

    Partial Class Settings
        Inherits DotNetNuke.Entities.Modules.PortalModuleBase

#Region "Base Method Implementations"
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
            Try
                If Not Page.IsPostBack Then
                    Dim d As New BookletDataContext
                    Dim q = (From c In d.Agape_Main_Booklets Where c.ModuleId = Me.ModuleId Select c).Single
                    Width.Text = q.Width

                    ModuleHF.Value = ModuleId
                    GridView1.DataBind()

                End If
            Catch ex As Exception

            End Try

        End Sub
       



#End Region
        

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

        

        Protected Sub AddPage()
            Dim s As String = FileUpload1.FileName

            Dim ext As String = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower()
            Dim allowedExtensions As String() = {".jpg", ".gif", ".png", "jpeg"}
            Dim FileOK As Boolean = False
            For i As Integer = 0 To allowedExtensions.Length - 1
                If ext = allowedExtensions(i) Then
                    FileOK = True
                End If
            Next

            If FileOK Then
                Dim SelectFile, thumbnail As System.Drawing.Image
                SelectFile = System.Drawing.Image.FromStream(FileUpload1.PostedFile.InputStream)


                Try
                    Dim height As Integer

                    height = SelectFile.Height * 800 / SelectFile.Width
                    thumbnail = ResizeImage(SelectFile, 800)
                    Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream()
                    Dim ImageBytes As Byte()
                    Using (ms)
                        thumbnail.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
                        ImageBytes = ms.ToArray()
                    End Using



                    Dim d As New BookletDataContext

                    d.Agape_Main_Booklet_AddPage(ImageBytes, ModuleId, CDbl(800 / height))

                    GridView1.DataBind()






                Catch ex As Exception

                End Try

            End If



        End Sub

        Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
            If FileUpload1.HasFile Then
                AddPage()

            End If

        End Sub

        Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
           



        End Sub

        Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
            Dim d As New BookletDataContext
            If e.CommandName = "Promote" Then

                d.Agape_Main_Booklet_Promote(CInt(e.CommandArgument))
            ElseIf e.CommandName = "Demote" Then

                d.Agape_Main_Booklet_Demote(CInt(e.CommandArgument))
            End If
            GridView1.DataBind()
           
        End Sub

        Protected Sub GridView1_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView1.RowDeleted
            Dim d As New BookletDataContext
            d.Agape_Main_Booklet_ReOrder(ModuleId)
            GridView1.DataBind()
        End Sub

        Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateButton.Click
            Dim d As New BookletDataContext
            Dim q = (From c In d.Agape_Main_Booklets Where c.ModuleId = Me.ModuleId Select c).Single
            q.Width = Width.Text
            d.SubmitChanges()


          



        End Sub

        Protected Sub ReturnButon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ReturnButon.Click
            Response.Redirect(NavigateURL())

        End Sub
    End Class

End Namespace

