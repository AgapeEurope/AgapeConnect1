﻿Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Drawing

Imports DotNetNuke

Imports DotNetNuke.Services.FileSystem


Partial Class DesktopModules_AgapePortal_StaffBroker_acImage
    Inherits System.Web.UI.UserControl '   Inherits Entities.Modules.PortalModuleBase
    Private _FileId As Integer



    <Bindable(True, BindingDirection.TwoWay)> <Browsable(True)> <Category("Common")> <Description("The DotNetNuke FileID")> <DefaultValue(0)> <DesignerSerializationVisibility(DesignerSerializationVisibility.Visible)> _
    Public Property FileId() As Integer
        Get
            Return hfFileId.Value
        End Get
        Set(ByVal value As Integer)
            _FileId = value
            hfFileId.Value = value
        End Set
    End Property

    Private _saveWidth As Integer
    Public Property SaveWidth() As Integer
        Get
            Return _saveWidth
        End Get
        Set(ByVal value As Integer)
            _saveWidth = value
        End Set
    End Property


    Private _Width As Integer
    Public Property Width() As Integer
        Get
            Return _Width
        End Get
        Set(ByVal value As Integer)
            _Width = value
        End Set
    End Property

    'Private _Aspect As Double
    Public Property Aspect() As String
        Get
            Return hfAspect.Value
        End Get
        Set(ByVal value As String)
            '  _Aspect = value
            hfAspect.Value = value.Replace(",", ".")
        End Set
    End Property
    'Public ReadOnly Property CheckAspect() As Boolean
    '    Get
    '        Return Math.Abs((theImage.Width.Value / theImage.Height.Value) - _Aspect) < 0.04
    '    End Get

    'End Property
    Public Function CheckAspect() As Boolean
        _theFile = FileManager.Instance.GetFile(hfFileId.Value)
        Dim rtn As Boolean = Math.Abs((CDbl(_theFile.Width) / CDbl(_theFile.Height)) - Double.Parse(Aspect, New CultureInfo(""))) < 0.04
        If rtn = False And hfW.Value <> "" Then
            btnUpdate_Click(Me, Nothing)
            rtn = Math.Abs((theImage.Width.Value / theImage.Height.Value) - Double.Parse(Aspect, New CultureInfo(""))) < 0.04
        End If
        Return rtn
    End Function

    Private _theFile As IFileInfo
    Private imgExt() As String = {"jpg", "jpeg", "gif", "png", "bmp"}
    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        ' jQuery.RequestDnnPluginsRegistration()
    End Sub
    ' Inherits System.Web.UI.UserControl


    Private Function CreateUniqueName(ByVal theFolder As IFolderInfo, ByVal ext As String) As String
        Dim allChars As String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ123456789"

        Dim GotUniqueCode As Boolean = False
        Dim uniqueCode As String = ""

        Dim str As New System.Text.StringBuilder
        Dim xx As Integer

        While uniqueCode = "" Or FileManager.Instance.FileExists(theFolder, IIf(uniqueCode = "", "X", uniqueCode))
            For i As Byte = 1 To 10 'length of req key
                Randomize()
                xx = Rnd() * (Len(allChars) - 1) 'number of rawchars
                str.Append(allChars.Trim.Chars(xx))
            Next
            uniqueCode = str.ToString & "." & ext
        End While




        Return uniqueCode

    End Function



    Protected Sub btnUpload_Click(sender As Object, e As System.EventArgs) Handles btnUpload.Click
        RaiseEvent Uploaded()
        If FileUpload1.HasFile Then
            Dim Filename As String = FileUpload1.FileName
            Dim ext As String = Filename.Substring(Filename.LastIndexOf(".") + 1)
            If imgExt.Contains(ext.ToLower) Then
                _FileId = hfFileId.Value

                'Find the Folder
                Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
                Dim theFolder As IFolderInfo
                If FolderManager.Instance.FolderExists(PS.PortalId, "_imageCropper") Then
                    theFolder = FolderManager.Instance.GetFolder(PS.PortalId, "_imageCropper")
                Else
                    theFolder = FolderManager.Instance.AddFolder(PS.PortalId, "_imageCropper")
                End If
                If _FileId > 0 Then
                    If (_theFile Is Nothing) Then
                        _theFile = FileManager.Instance.GetFile(_FileId)
                    ElseIf _theFile.FileId <> _FileId Then
                        _theFile = FileManager.Instance.GetFile(_FileId)
                    End If

                    FileManager.Instance.DeleteFile(_theFile)
                End If


                _theFile = FileManager.Instance.AddFile(theFolder, CreateUniqueName(theFolder, ext), FileUpload1.FileContent)
                _FileId = _theFile.FileId

                hfFileId.Value = _theFile.FileId
                theImage.ImageUrl = FileManager.Instance.GetUrl(_theFile)
                theImage.Height = theImage.Width.Value / (CDbl(_theFile.Width) / CDbl(_theFile.Height))

            Else
                'Not image file
                Label1.Text = "* File must end in .jpg, .jpeg, .gif or .png<br />"
            End If
        End If

    End Sub

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.Load
       

        If Not Page.IsPostBack Then
            'Dim sm = DotNetNuke.Framework.AJAX.GetScriptManager(Me.Page)

            'If Not sm Is Nothing Then

            '    sm.RegisterPostBackControl(btnUpload)
            '    sm.RegisterAsyncPostBackControl(btnUpdate)
            '    Page.Form.Attributes.Add("enctype", "multipart/form-data")

            'End If
           
            PreRender()

        End If
    End Sub

    Public Event Updated()
    Public Event Uploaded()
    Private Sub PreRender()
        If _FileId = Nothing Then
            _FileId = 0

        End If
        If _Width = Nothing Then
            _Width = 200
        ElseIf _Width < 200 Then
            Width = 200
        End If
        If Aspect = Nothing Then
            Aspect = 0
        End If
        If SaveWidth = Nothing Then
            SaveWidth = 700
        End If


        hfFileId.Value = _FileId
        Dim _theFile = FileManager.Instance.GetFile(_FileId)
        If _theFile Is Nothing Then
            theImage.ImageUrl = "/images/no_avatar.gif"
            _FileId = 0
            hfFileId.Value = 0
        ElseIf imgExt.Contains(_theFile.Extension.ToLower) Then
            theImage.ImageUrl = FileManager.Instance.GetUrl(_theFile)



        Else
            theImage.ImageUrl = "/images/no_avatar.gif"
            _FileId = 0
            hfFileId.Value = 0
        End If

        theImage.Width = _Width
        If Double.Parse(Aspect, New CultureInfo("")) <> 0 Then
            theImage.Height = _Width / Double.Parse(Aspect, New CultureInfo(""))
        End If
    End Sub

    Public Sub LazyLoad(Optional ByVal Async As Boolean = False, Optional Bound As Boolean = False)
        If Async Then


            Dim sm = DotNetNuke.Framework.AJAX.GetScriptManager(Me.Page)

            If Not sm Is Nothing Then

                sm.RegisterPostBackControl(btnUpload)
                sm.RegisterAsyncPostBackControl(btnUpdate)
                Page.Form.Attributes.Add("enctype", "multipart/form-data")

            End If
        End If
        If Bound Then
            PreRender()
        End If
        'Find the Folder
        Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
        Dim theFolder As IFolderInfo
        If FolderManager.Instance.FolderExists(PS.PortalId, "_imageCropper") Then
            theFolder = FolderManager.Instance.GetFolder(PS.PortalId, "_imageCropper")
        Else
            theFolder = FolderManager.Instance.AddFolder(PS.PortalId, "_imageCropper")
        End If

        _theFile = FileManager.Instance.GetFile(_FileId)


        If Not _theFile Is Nothing Then


            hfFileId.Value = _theFile.FileId
            theImage.ImageUrl = FileManager.Instance.GetUrl(_theFile)
            theImage.Width = _Width
            theImage.Height = theImage.Width.Value / CDbl((CDbl(_theFile.Width) / CDbl(_theFile.Height)))



        Else
            'theImage.Width = 200
            'theImage.Height = 200.0 / Aspect
        End If

        Dim t As Type = Page.GetType()
        Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
        sb.Append("<script language='javascript'>")
        sb.Append(" $('#" & theImage.ClientID() & "').Jcrop({ aspectRatio: " & Aspect & " });")
        sb.Append("</script>")
        ScriptManager.RegisterStartupScript(Page, t, "thePopup", sb.ToString, False)


    End Sub


    Protected Sub btnUpdate_Click(sender As Object, e As System.EventArgs) Handles btnUpdate.Click


        Dim x = hfX.Value
        Dim y = hfY.Value
        Dim w = hfW.Value
        Dim h = hfH.Value
        If x = "" Or y = "" Or w = "" Or h = "" Then
            Return
        End If
        If SaveWidth = Nothing Then
            SaveWidth = 700
        End If
        _FileId = hfFileId.Value
        _theFile = FileManager.Instance.GetFile(_FileId)
        If Not _theFile Is Nothing Then



            Dim filename As String = _theFile.FileName
            Dim ext As String = filename.Substring(filename.LastIndexOf(".") + 1)
            Dim PS = CType(HttpContext.Current.Items("PortalSettings"), PortalSettings)
            Dim theFolder = FolderManager.Instance.GetFolder(PS.PortalId, "_imageCropper")
            Dim FileContent = FileManager.Instance.GetFileContent(_theFile)
            Dim photo = Image.FromStream(FileContent)

            Dim scale = photo.Width / theImage.Width.Value.ToString(New CultureInfo(""))


            Dim newWidth = w * scale
            Dim newHeight = h * scale

            If newWidth > SaveWidth Then
                newHeight = newHeight * CDbl(SaveWidth) / newWidth
                newWidth = SaveWidth

            End If


            Dim result = New Bitmap(newWidth, newHeight, Drawing.Imaging.PixelFormat.Format32bppPArgb)
            result.SetResolution(photo.HorizontalResolution, photo.VerticalResolution)
            Dim g = Graphics.FromImage(result)
            g.InterpolationMode = Drawing2D.InterpolationMode.HighQualityBicubic
            g.DrawImage(photo, New Rectangle(0, 0, newWidth, newHeight), New Rectangle(x * scale, y * scale, w * scale, h * scale), GraphicsUnit.Pixel)

            'photo.Dispose()

            Dim myMemoryStream As New IO.MemoryStream
            result.Save(myMemoryStream, photo.RawFormat)

            result.Dispose()
            photo.Dispose()
            g.Dispose()
            FileContent.Dispose()
            ' result.Save("C:\aLocalSVN\AgapeConnect12\Portals\0\_imageCropper\MHuSGwLYED.jpg")
            If Not _theFile Is Nothing Then
                Try
                    FileManager.Instance.DeleteFile(_theFile)
                Catch ex As Exception

                End Try

            End If

            filename = CreateUniqueName(theFolder, ext)

            _theFile = FileManager.Instance.AddFile(theFolder, filename, myMemoryStream, True)
            _theFile = FileManager.Instance.UpdateFile(_theFile)
            hfFileId.Value = _theFile.FileId

            theImage.ImageUrl = FileManager.Instance.GetUrl(_theFile)
            If Double.Parse(Aspect, New CultureInfo("")) <> 0 Then
                theImage.Height = theImage.Width.Value / Double.Parse(Aspect, New CultureInfo(""))
            End If
            RaiseEvent Updated()
        End If
    End Sub

End Class
