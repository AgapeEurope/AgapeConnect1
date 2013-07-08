Imports DotNetNuke

Imports DotNetNuke.Services.FileSystem
Imports System.Drawing.Imaging
Imports System.Drawing
Imports System.IO


Partial Class DesktopModules_AgapeConnect_StaffRmb_ReceiptEditor
    Inherits System.Web.UI.Page
    Private imgExt() As String = {"jpg", "jpeg", "gif", "png", "bmp"}

    Protected Sub CheckFolderPermissions(ByVal PortalId As Integer, ByVal theFolder As IFolderInfo, ByVal theUserId As Integer)
        Try

       
        Dim rc As New DotNetNuke.Security.Roles.RoleController

        Dim pc As New Permissions.PermissionController
        Dim w As Permissions.PermissionInfo = pc.GetPermissionByCodeAndKey("SYSTEM_FOLDER", "WRITE")(0)
        Dim r As Permissions.PermissionInfo = pc.GetPermissionByCodeAndKey("SYSTEM_FOLDER", "READ")(0)
        FolderManager.Instance.SetFolderPermission(theFolder, w.PermissionID, Nothing, theUserId)
        FolderManager.Instance.SetFolderPermission(theFolder, w.PermissionID, rc.GetRoleByName(PortalId, "Accounts Team").RoleID)

        ' If Not (Permissions.FolderPermissionController.HasFolderPermission(PortalId, theFolder.FolderPath, "READ")) Then
        FolderManager.Instance.SetFolderPermission(theFolder, w.PermissionID, Nothing, UserController.GetCurrentUserInfo.UserID)
        For Each row In StaffBrokerFunctions.GetLeaders(UserController.GetCurrentUserInfo.UserID, True).Distinct()


            FolderManager.Instance.SetFolderPermission(theFolder, w.PermissionID, Nothing, row)
        Next
        'End If


        Catch ex As Exception

        End Try

    End Sub

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


                Dim fm = FolderMappingController.Instance.GetFolderMapping(PS.PortalId, "Secure")


                If Not FolderManager.Instance.FolderExists(PS.PortalId, "_RmbReceipts/") Then
                    Dim f1 = FolderManager.Instance.AddFolder(fm, "_RmbReceipts")
                    Dim rc As New DotNetNuke.Security.Roles.RoleController

                    Dim pc As New Permissions.PermissionController

                    Dim w As Permissions.PermissionInfo = pc.GetPermissionByCodeAndKey("SYSTEM_FOLDER", "WRITE")(0)
                    FolderManager.Instance.SetFolderPermission(f1, w.PermissionID, rc.GetRoleByName(PS.PortalId, "Accounts Team").RoleID)
                End If


                Dim theFolder As IFolderInfo
                If FolderManager.Instance.FolderExists(PS.PortalId, "_RmbReceipts/" & theRmb.UserId) Then
                    theFolder = FolderManager.Instance.GetFolder(PS.PortalId, "_RmbReceipts/" & theRmb.UserId)
                Else

                    theFolder = FolderManager.Instance.AddFolder(fm, "_RmbReceipts/" & theRmb.UserId)
                End If


                CheckFolderPermissions(PS.PortalId, theFolder, theRmb.UserId)
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



                Dim _theFile = FileManager.Instance.AddFile(theFolder, "R" & RmbNo & "L" & RmbLine & ".jpg", myMemoryStream, True)


                Dim _FileId = _theFile.FileId




                myMemoryStream.Dispose()
                imgReceipt.ImageUrl = FileManager.Instance.GetUrl(_theFile)
                lblError.Text = imgReceipt.ImageUrl
                hlimg.NavigateUrl = imgReceipt.ImageUrl
                hlimg.Visible = True
                btnRotateLeft.Visible = True
                btnRotatRight.Visible = True
                If newWidth / newHeight < 500 / 250 Then
                    imgReceipt.Height = New Unit(250)
                    imgReceipt.Width = New Unit(250 * newWidth / newHeight)
                Else
                    imgReceipt.Width = New Unit(500)
                    imgReceipt.Height = New Unit(500 / (newWidth / newHeight))
                End If
                imgReceipt.Visible = True


            Else
                'Not image file
                lblError.Text = "* File must end in .jpg, .jpeg, .gif or .png<br />"
            End If


        End If



    End Sub
   
    Protected Sub btnRotateLeft_Click(sender As Object, e As EventArgs) Handles btnRotateLeft.Click
        Rotate(False)
    End Sub
    Private Sub Rotate(ByVal Right As Boolean)
        Dim RmbNo As String = Request.QueryString("RmbNo")
        Dim RmbLine As String = Request.QueryString("RmbLine")
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim d As New StaffRmb.StaffRmbDataContext
        Dim theRmb = (From c In d.AP_Staff_Rmbs Where c.PortalId = PS.PortalId And c.RMBNo = RmbNo).First


        Dim theFolder As IFolderInfo = FolderManager.Instance.GetFolder(PS.PortalId, "_RmbReceipts/" & theRmb.UserId)

        Dim theFile = FileManager.Instance.GetFile(theFolder, "R" & RmbNo & "L" & RmbLine & ".jpg")

       
        Dim img = New Bitmap(theFile.PhysicalPath & ".resources")
        'Dim img = New Bitmap(FileManager.Instance.GetFileContent(theFile))


        If (Right) Then
            img.RotateFlip(RotateFlipType.Rotate90FlipNone)
        Else
            img.RotateFlip(RotateFlipType.Rotate270FlipNone)
        End If
        Dim newWidth = img.Width
        Dim newHeight = img.Height

        Dim myMemoryStream As New IO.MemoryStream
        img.Save(myMemoryStream, ImageFormat.Jpeg)

        img.Dispose()

        'If Not theFile Is Nothing Then
        '    Try
        '        FileManager.Instance.DeleteFile(theFile)
        '    Catch ex As Exception
        '        lblError.Text = ex.ToString
        '    End Try

        'End If


        Dim _theFile = FileManager.Instance.AddFile(theFolder, theFile.FileName, myMemoryStream, True)
        'Dim _theFile = FileManager.Instance.UpdateFile(theFile, myMemoryStream)
        Dim Version = 1
        If imgReceipt.ImageUrl.Contains("&v=") Then
            Version = imgReceipt.ImageUrl.Substring(imgReceipt.ImageUrl.IndexOf("&v=") + 3)
        End If

        imgReceipt.ImageUrl = FileManager.Instance.GetUrl(_theFile) & "&v=" & Version

        hlimg.NavigateUrl = imgReceipt.ImageUrl
        hlimg.Visible = True
        btnRotateLeft.Visible = True
        btnRotatRight.Visible = True
        If newWidth / newHeight < 500 / 250 Then
            imgReceipt.Height = New Unit(250)
            imgReceipt.Width = New Unit(250 * newWidth / newHeight)
        Else
            imgReceipt.Width = New Unit(500)
            imgReceipt.Height = New Unit(500 / (newWidth / newHeight))
        End If
        myMemoryStream.Dispose()
    End Sub

    Protected Sub btnRotatRight_Click(sender As Object, e As EventArgs) Handles btnRotatRight.Click
        Rotate(True)
    End Sub

    
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim RmbNo As String = Request.QueryString("RmbNo")
        Dim RmbLine As String = Request.QueryString("RmbLine")
        If (RmbLine <> "New") Then
            Try
                Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
                Dim d As New StaffRmb.StaffRmbDataContext
                Dim theRmbLine = (From c In d.AP_Staff_RmbLines Where c.AP_Staff_Rmb.PortalId = PS.PortalId And c.RmbLineNo = RmbLine)
               
                Dim theRmb = (From c In d.AP_Staff_Rmbs Where c.PortalId = PS.PortalId And c.RMBNo = RmbNo).First


                Dim theFolder As IFolderInfo = FolderManager.Instance.GetFolder(PS.PortalId, "_RmbReceipts/" & theRmb.UserId)

                CheckFolderPermissions(PS.PortalId, theFolder, theRmb.UserId)


                If theRmbLine.Count > 0 Then

                    Dim theFile = FileManager.Instance.GetFile(theRmbLine.First.ReceiptImageId)

                    imgReceipt.ImageUrl = FileManager.Instance.GetUrl(theFile)
                    hlimg.NavigateUrl = imgReceipt.ImageUrl
                    hlimg.Visible = True
                    btnRotateLeft.Visible = True
                    btnRotatRight.Visible = True
                    Dim newWidth = theFile.Width
                    Dim newHeight = theFile.Height
                    If newWidth / newHeight < 500 / 250 Then
                        imgReceipt.Height = New Unit(250)
                        imgReceipt.Width = New Unit(250 * newWidth / newHeight)
                    Else
                        imgReceipt.Width = New Unit(500)
                        imgReceipt.Height = New Unit(500 / (newWidth / newHeight))
                    End If

                    'lblError.Text = imgReceipt.Width.Value & " - " & imgReceipt.Height.Value
                End If
            Catch ex As Exception

            End Try
        End If
      



    End Sub
End Class
