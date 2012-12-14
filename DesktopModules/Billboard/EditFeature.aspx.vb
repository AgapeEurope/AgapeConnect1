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
Imports Billboard
Imports System.Drawing.Image
Imports System.Drawing

Partial Class DesktopModules_Billboard_EditFeature
    Inherits System.Web.UI.Page
    Private ThisUserId As Integer
    Private ThisFeatureArt As Integer


    Protected Sub btnSaveButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveButton.Click

        'Check for Errors
        Dim NoErrors As Boolean = True
        If String.IsNullOrEmpty(tbHeadline.Text) Then
            lblErrorLabelHeadline.Visible = True
            lblErrorStarHeadline.Visible = True
            NoErrors = False
        Else
            lblErrorLabelHeadline.Visible = False
            lblErrorStarHeadline.Visible = False
        End If
        If String.IsNullOrEmpty(tbStoryText.RichText.Text) Then
            lblErrorLabelStoryText.Visible = True
            lblErrorStarStoryText.Visible = True
            NoErrors = False
        Else
            lblErrorLabelStoryText.Visible = False
            lblErrorStarStoryText.Visible = False
        End If

        'If no errors, save the file
        If NoErrors Then
            Dim IsCurrent As Boolean = False
            Dim d As New Billboard.BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Features Where c.Current = True And c.Visible = True And c.Sent = False
            If q.Count > 0 Then
                IsCurrent = True
            End If
            If CInt(hfFeatureArtId.Value) = -1 Then
                If cbVisibleCheck.Checked And IsCurrent Then
                    Dim t As Type = btnSaveButton.GetType()
                    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                    sb.Append("<script language='javascript'>")
                    sb.Append("alert(""There is already a visible, unsent feature article. You can only have one current feature article. If you wish this article to be the current article then make the other unsent feature article invisible first."")")
                    sb.Append("</script>")
                    ScriptManager.RegisterStartupScript(btnSaveButton, t, "msgAdd1", sb.ToString, False)
                Else
                    UpdateFile(False)
                End If
            Else
                Dim r = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = CInt(hfFeatureArtId.Value)
                If r.Count > 0 Then
                    If cbVisibleCheck.Checked And r.First.Visible = False And r.First.Current = False And IsCurrent Then
                        Dim t As Type = btnSaveButton.GetType()
                        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                        sb.Append("<script language='javascript'>")
                        sb.Append("alert(""There is already a visible, unsent feature article. You can only have one current feature article. If you wish this article to be the current article then make the other unsent feature article invisible first."")")
                        sb.Append("</script>")
                        ScriptManager.RegisterStartupScript(btnSaveButton, t, "msgAdd3", sb.ToString, False)
                    Else
                        UpdateFile(True)
                    End If
                End If
            End If
        End If

    End Sub
    Private Sub UpdateFile(ByVal Previous As Boolean)
        If Previous Then
            'Previously written article
            Try
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = CInt(hfFeatureArtId.Value)
                Dim s = From c In d.Agape_Billboard_TempPhotos Where c.UserId = CInt(hfUserId.Value)
                If q.Count > 0 Then
                    'Save the story
                    If Not (s.Count > 0 And icImageCropper1.CroppedImage Is Nothing) Then
                        Dim ThisVisible As Boolean = q.First.Visible
                        Dim ThisCurrent As Boolean = q.First.Current
                        Dim ThisSent As Boolean = q.First.Sent

                        q.First.Visible = cbVisibleCheck.Checked
                        q.First.Headline = tbHeadline.Text
                        q.First.StoryText = tbStoryText.RichText.Text
                        If cbVisibleCheck.Checked Then
                            q.First.StoryDate = CDate(Now())
                        End If

                        If s.Count > 0 And Not icImageCropper1.CroppedImage Is Nothing Then
                            Dim r = From c In d.Agape_Billboard_TempPhotos Select c.TempPhotoData, c.UserId Where UserId = CInt(hfUserId.Value)
                            Dim img As Byte() = r.First.TempPhotoData.ToArray
                            Dim X As Integer = icImageCropper1.CroppingRect.X
                            Dim Y As Integer = icImageCropper1.CroppingRect.Y
                            Dim IWidth As Integer = icImageCropper1.CroppingRect.Width
                            Dim IHeight As Integer = icImageCropper1.CroppingRect.Height
                            Dim ImageBytes As Byte() = Billboard.BillboardFunctions.CropImageFromCropper(img, X, Y, IWidth, IHeight)

                            Dim t = From c In d.Agape_Billboard_Photos Where c.BillboardPhotoId = q.First.BillboardPhotoId Select c
                            If t.Count > 0 Then
                                t.First.PhotoData = ImageBytes
                            End If
                        End If

                        d.SubmitChanges()

                        'Current Rules
                        If (Not cbVisibleCheck.Checked) And ThisVisible = True And ThisCurrent = True And ThisSent = False Then
                            Dim Old = From c In d.Agape_Billboard_Features Where c.Sent = True And c.Visible = True Order By c.StoryDate Descending
                            If Old.Count > 0 Then
                                Try
                                    Billboard.BillboardFunctions.SetToCurrent(CInt(Old.First.BillboardFeatureId))
                                Catch ex As Exception
                                    lblSaving.Text = ex.Message
                                    lblSaving.Visible = True
                                    Return
                                End Try
                            End If
                        End If
                        If cbVisibleCheck.Checked And ThisVisible = False And ThisSent = False Then
                            Billboard.BillboardFunctions.SetToCurrent(CInt(q.First.BillboardFeatureId))
                        End If

                        'CHANGE OVER TO VIEW MODE
                        Dim u As Type = btnSaveButton.GetType
                        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                        sb.Append("<script language='javascript'>")
                        sb.Append("opener.location.search='?FaId=" & q.First.BillboardFeatureId & "';")
                        sb.Append("self.close();")
                        sb.Append("</script>")
                        ScriptManager.RegisterStartupScript(btnSaveButton, u, "popupAdd2", sb.ToString, False)
                        'OnEvent(New TheseEditEventArgs(q.First.BillboardFeatureId))
                        'lblSaving.ForeColor = Color.Green
                        'lblSaving.Visible = True
                        'lblSaving.Text = "Story Saved"

                    Else
                        'No Photo
                        lblSaving.Text = "You need to insert a photo to be cropped and crop it."
                        lblSaving.Visible = True
                        lblErrorPhoto.Text = "You need to insert a photo to be cropped and crop it."
                        lblErrorPhoto.Visible = True
                    End If
                Else
                    'Problem loading the previous story
                    lblSaving.Text = "There was a problem saving the article."
                    lblSaving.Visible = False
                End If

            Catch ex As Exception
                lblSaving.Text = ex.Message
                lblSaving.Visible = True
            End Try

        Else
            'Previously unwritten article
            Try
                Dim d As New Billboard.BillboardDataContext
                Dim insertFeature As New Billboard.Agape_Billboard_Feature

                'Save the story
                If Not icImageCropper1.CroppedImage Is Nothing Then
                    insertFeature.Headline = tbHeadline.Text
                    insertFeature.StoryText = tbStoryText.RichText.Text
                    insertFeature.StoryDate = CDate(Now())

                    Dim r = From c In d.Agape_Billboard_TempPhotos Select c.TempPhotoData, c.UserId Where UserId = CInt(hfUserId.Value)
                    Dim img As Byte() = r.First.TempPhotoData.ToArray
                    Dim X As Integer = icImageCropper1.CroppingRect.X
                    Dim Y As Integer = icImageCropper1.CroppingRect.Y
                    Dim IWidth As Integer = icImageCropper1.CroppingRect.Width
                    Dim IHeight As Integer = icImageCropper1.CroppingRect.Height
                    Dim ImageBytes As Byte() = Billboard.BillboardFunctions.CropImageFromCropper(img, X, Y, IWidth, IHeight)
                    Dim insertPhoto As New Billboard.Agape_Billboard_Photo
                    insertPhoto.PhotoData = ImageBytes
                    d.Agape_Billboard_Photos.InsertOnSubmit(insertPhoto)
                    d.SubmitChanges()

                    insertFeature.BillboardPhotoId = insertPhoto.BillboardPhotoId
                    d.Agape_Billboard_Features.InsertOnSubmit(insertFeature)
                    d.SubmitChanges()

                    'Current scenarios
                    If Not cbVisibleCheck.Checked Then
                        insertFeature.Current = False
                        insertFeature.Sent = False
                        insertFeature.Visible = False
                        d.SubmitChanges()
                    ElseIf cbVisibleCheck.Checked Then
                        Dim s = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = insertFeature.BillboardFeatureId
                        If s.Count > 0 Then
                            s.First.Visible = True
                            s.First.Sent = False
                        End If
                        d.SubmitChanges()
                        Billboard.BillboardFunctions.SetToCurrent(CInt(insertFeature.BillboardFeatureId))
                    End If

                    'CHANGE OVER TO VIEW MODE
                    Dim v As Type = btnSaveButton.GetType
                    Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                    sb.Append("<script language='javascript'>")
                    sb.Append("opener.location.search='?FaId=" & insertFeature.BillboardFeatureId & "';")
                    sb.Append("self.close();")
                    sb.Append("</script>")
                    ScriptManager.RegisterStartupScript(btnSaveButton, v, "popupAdd1", sb.ToString, False)
                    'OnEvent(New TheseEditEventArgs(insertFeature.BillboardFeatureId))
                    'lblSaving.ForeColor = Color.Green
                    'lblSaving.Visible = True
                    'lblSaving.Text = "Story Saved"


                Else
                    'No Photo
                    lblSaving.Text = "You need to insert a photo to be cropped and crop it."
                    lblSaving.Visible = True
                    lblErrorPhoto.Text = "You need to insert a photo to be cropped and crop it."
                    lblErrorPhoto.Visible = True
                End If

            Catch ex As Exception
                lblSaving.Text = ex.Message
                lblSaving.Visible = True
            End Try

        End If

    End Sub
    Protected Sub btnPhoto1Button_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPhoto1Button.Click

        If fuFileUpload2.HasFile Then
            Dim fileExtension As String
            Dim SelectFile, thumbnail As System.Drawing.Image
            Dim FileOK As Boolean = False
            fileExtension = System.IO.Path.GetExtension(fuFileUpload2.FileName).ToLower()
            Dim allowedExtensions As String() = {".jpg", ".gif", ".png", "jpeg"}
            For i As Integer = 0 To allowedExtensions.Length - 1
                If fileExtension = allowedExtensions(i) Then
                    FileOK = True
                End If
            Next

            If FileOK Then
                Try
                    SelectFile = System.Drawing.Image.FromStream(fuFileUpload2.PostedFile.InputStream)
                    thumbnail = ResizeImage(SelectFile, 400)
                    Dim ms As System.IO.MemoryStream = New System.IO.MemoryStream()
                    Dim ImageBytes As Byte()
                    Using (ms)
                        thumbnail.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg)
                        ImageBytes = ms.ToArray()
                    End Using

                    Dim d As New Billboard.BillboardDataContext
                    Dim insertTempPhoto As New Billboard.Agape_Billboard_TempPhoto
                    insertTempPhoto.UserId = hfUserId.Value
                    insertTempPhoto.TempPhotoData = ImageBytes
                    d.Agape_Billboard_TempPhotos.InsertOnSubmit(insertTempPhoto)
                    d.SubmitChanges()
                    icImageCropper1.ImageUrl = "/DesktopModules/Billboard/GetTempBillboardImage.aspx?UserId=" & hfUserId.Value & "&Size=400&Mode=2"
                    lblErrorPhoto.Text = "FileUploaded!"
                    lblErrorPhoto.Visible = True
                Catch ex As Exception
                    lblErrorPhoto.Text = "File could not be uploaded: " & ex.Message
                    lblErrorPhoto.Visible = True
                End Try
            Else
                lblErrorPhoto.Text = "Invalid file. Please select a jpg, jpeg, gif or png file."
                lblErrorPhoto.Visible = True
            End If
        Else
            lblErrorPhoto.Text = "Couldn't get file."
            lblErrorPhoto.Visible = True
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
    Protected Sub DeleteButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeleteButton.Click

        Dim d As New Billboard.BillboardDataContext
        Dim r = From c In d.Agape_Billboard_TempPhotos Where c.UserId = CInt(hfUserId.Value)
        For Each photo In r
            d.Agape_Billboard_TempPhotos.DeleteOnSubmit(photo)
        Next

        If Not CInt(hfFeatureArtId.Value) = -1 Then
            Dim q = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = CInt(hfFeatureArtId.Value)
            If q.Count > 0 Then
                Dim IsCurrent As Boolean = False
                If q.First.Current = True Then
                    IsCurrent = True
                End If
                d.Agape_Billboard_Features.DeleteAllOnSubmit(q)
                d.SubmitChanges()

                If IsCurrent Then
                    Dim Old = From c In d.Agape_Billboard_Features Where c.Sent = True And c.Visible = True Order By c.StoryDate Descending
                    If Old.Count > 0 Then
                        Billboard.BillboardFunctions.SetToCurrent(Old.First.BillboardFeatureId)
                    End If
                End If
            End If
        End If

        'redirect to archive
        Dim t As Type = btnDeleteButton.GetType
        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
        sb.Append("<script language='javascript'>")
        sb.Append("self.close();")
        sb.Append("opener.location.search='?FaId=-1';")
        sb.Append("</script>")
        ScriptManager.RegisterStartupScript(btnDeleteButton, t, "popupAdd", sb.ToString, False)
        'OnEvent(New TheseEditEventArgs(-2))
        'lblSaving.ForeColor = Color.Green
        'lblSaving.Visible = True
        'lblSaving.Text = "Story Deleted"
        'SetToNew()

    End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Try
                ThisUserId = CInt(Request.QueryString("UId"))
                hfUserId.Value = ThisUserId
                Dim FeatureArtId As Integer = -1
                If Not Request.QueryString("FAId") Is Nothing Or Request.QueryString("FAId") = "" Or Request.QueryString("FAId") = 0 Then
                    FeatureArtId = CInt(Request.QueryString("FAId"))
                End If
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_TempPhotos Where c.UserId = ThisUserId
                For Each photo In q
                    d.Agape_Billboard_TempPhotos.DeleteOnSubmit(photo)
                Next
                d.SubmitChanges()
                If Not FeatureArtId = -1 Then

                    Dim r = From c In d.Agape_Billboard_Features Where c.BillboardFeatureId = FeatureArtId Select c
                    If r.Count > 0 Then
                        tbHeadline.Text = r.First.Headline
                        tbStoryText.Text = r.First.StoryText
                        cbVisibleCheck.Checked = r.First.Visible
                        icImageCropper1.ImageUrl = "/DesktopModules/Billboard/GetTempBillboardImage.aspx?UserId=" & ThisUserId & "&Size=400&Mode=1&PhotoId=" & r.First.Agape_Billboard_Photo.BillboardPhotoId
                    Else
                        lblErrorUpload.Text = "There was no Feature Article found for the following ID: " & FeatureArtId
                        lblErrorUpload.Visible = True
                        pnlContent.Visible = False
                    End If
                    ThisFeatureArt = FeatureArtId
                    hfFeatureArtId.Value = FeatureArtId
                Else
                    btnSaveButton.Text = "Save"
                    btnDeleteButton.Visible = False
                    tbHeadline.Text = ""
                    tbStoryText.RichText.Text = ""
                    cbVisibleCheck.Checked = False
                    icImageCropper1.ImageUrl = "/DesktopModules/Billboard/GetBillboardImage.aspx?Size=400"
                    lblErrorPhoto.Visible = False
                    lblErrorUpload.Visible = False
                    hfFeatureArtId.Value = -1
                End If
                If ThisUserId = -1 Then
                    pnlContent.Visible = False
                    lblErrorUpload.Text = "This control has not been loaded correctly."
                    lblErrorUpload.Visible = True
                Else
                    pnlContent.Visible = True
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub
    Public Sub SetToNew()
        btnSaveButton.Text = "Save"
        btnDeleteButton.Visible = False
        tbHeadline.Text = ""
        tbStoryText.RichText.Text = ""
        cbVisibleCheck.Checked = False
        icImageCropper1.ImageUrl = "/DesktopModules/Billboard/GetBillboardImage.aspx?Size=400"
        lblErrorPhoto.Visible = False
        lblErrorUpload.Visible = False
        hfFeatureArtId.Value = -1
    End Sub
End Class









