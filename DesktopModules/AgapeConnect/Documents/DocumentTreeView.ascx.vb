Imports System
Imports System.Collections
Imports System.Configuration
Imports System.Data
Imports System.Linq
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports Documents
Imports DotNetNuke.Services.FileSystem
Namespace DotNetNuke.Modules.AgapeDocuments
    Partial Class DocumentTreeview
        Inherits Entities.Modules.PortalModuleBase
        Dim d As New DocumentsDataContext
        Dim rc As New DotNetNuke.Security.Roles.RoleController
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load


            If Not Page.IsPostBack() Then


                Dim r = From c In d.AP_Documents_Docs Where c.AP_Documents_Folder.PortalId = PortalId Order By c.DisplayName Group By c.Author Into Group
                TreeView1.Nodes.Clear()
                For Each row In r
                    Dim insertNode = New TreeNode("<span class=""tbLinkText"" style=""color:" & GetForeColor() & """>" & row.Author & "</span>")

                    TreeView1.Nodes.Add(insertNode)
                    For Each doc In row.Group
                        insertNode.ChildNodes.Add(New TreeNode("<span class=""ToolboxLink"" style=""color:" & GetForeColor() & """>" & doc.DisplayName & "</span>", doc.DocId, "", GetFileUrl(doc.DocId, doc.FileId), "_blank"))
                    Next

                Next


                TreeView1.ExpandImageUrl = "images/Arrow" & GetBulletName() & "R.gif"
                TreeView1.CollapseImageUrl = "images/Arrow" & GetBulletName() & "D.gif"


                AddButton.Visible = IsEditable
                EditBtn.Visible = IsEditable
            End If

        End Sub


        Public Sub LoadTree(ByVal StartNode As AP_Documents_Folder)



            tvFolders.Nodes.Clear()
            UserRoles = rc.GetUserRoles(PortalId, UserId)

            Dim rootNode As New TreeNode()

            AddSubFolders(StartNode.ParentFolder, rootNode)

            tvFolders.Nodes.Add(rootNode.ChildNodes(0))


        End Sub





        Public Function GetFileUrl(ByVal DocId As Integer, ByVal FileId As Integer) As String
            If FileId = -2 Then
                Dim theDoc = From c In d.AP_Documents_Docs Where c.DocId = DocId

                Select Case theDoc.First.LinkType
                    Case 0, 2
                        Return theDoc.First.LinkValue
                    Case 1
                        Return "http://www.youtube.com"
                    Case 3
                        Return NavigateURL(CInt(theDoc.First.LinkValue))
                End Select
            End If

            Dim theFile = FileManager.Instance.GetFile(FileId)
            If Not theFile Is Nothing Then
                Dim rtn = EditUrl("DocumentViewer") ' FileManager.Instance.GetUrl(theFile)

                If rtn.Contains("?") Then
                    rtn &= "&DocId=" & DocId
                Else
                    rtn &= "?DocId=" & DocId
                End If
                Return rtn
            Else
                Return EditUrl("DocumentViewer") & "?DocId=" & DocId
            End If
        End Function

        'Public Function GetDocument(ByVal FileId As Integer, ByVal URL As String, ByVal LinkType As String) As String
        '    If LinkType = "F" Then
        '        Dim ImageFileId As Integer = Integer.Parse(FileId)
        '        Dim objFileController As New DotNetNuke.Services.FileSystem.FileController
        '        Dim objImageInfo As DotNetNuke.Services.FileSystem.FileInfo = objFileController.GetFileById(ImageFileId, PortalId)
        '        Return PortalSettings.HomeDirectory & objImageInfo.Folder & objImageInfo.FileName
        '    Else
        '        Return URL
        '    End If




        'End Function

        Protected Function GetFileIcon(ByVal FileId As Integer?, ByVal LinkType As Integer, Optional IconId As Integer? = -1) As String


            If FileId Is Nothing Then
                Return "images/folder.png"
            End If
            Dim Path As String = "images/"
            Dim theFile = FileManager.Instance.GetFile(FileId)
            If Not IconId Is Nothing And IconId > 0 Then
                Return FileManager.Instance.GetUrl(FileManager.Instance.GetFile(IconId))
            End If

            If FileId = -2 Then
                Select Case LinkType
                    Case 0 : Return Path & "URL.png"
                    Case 1 : Return Path & "YouTube.png"
                    Case 2 : Return Path & "GoogleDoc.png"
                    Case 3 : Return Path & "Url.png"

                End Select
            End If

            If Not theFile Is Nothing Then



                Select Case theFile.Extension
                    Case "gif"
                        Return Path & "GIF.png"
                    Case "bmp"
                        Return Path & "BMP.png"
                    Case "doc"
                        Return Path & "DOC.png"
                    Case "jpg"
                        Return Path & "JPG.png"
                    Case "mov"
                        Return Path & "MOV.png"
                    Case "mp3"
                        Return Path & "MP3.png"
                    Case "mp4"
                        Return Path & "MP4.png"
                    Case "mpg"
                        Return Path & "MPG.png"
                    Case "pdf"
                        Return Path & "PDF.png"

                    Case "png"
                        Return Path & "PNG.png"
                    Case "psd"
                        Return Path & "PSD.png"
                    Case "tiff"
                        Return Path & "TIFF.png"
                    Case "txt"
                        Return Path & "TXT.png"
                    Case "wav"
                        Return Path & "WAV.png"
                    Case "zip"
                        Return Path & "ZIP.png"


                    Case Else
                        Return Path & "Blank.png"

                End Select

            End If
            Return "images/Blank.png"


        End Function

        

        Protected Sub AddButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles AddButton.Click
            Response.Redirect(EditUrl("Add"))

        End Sub

        Protected Sub EditBtn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles EditBtn.Click
            Response.Redirect(EditUrl("Layout"))
        End Sub

        Public Function GetForeColor() As String
            Dim ParentSkin = DotNetNuke.UI.Skins.Skin.GetParentSkin(Me).ToString

            If ParentSkin.IndexOf("win") > 0 Then
                Return "#28686E"
            ElseIf ParentSkin.IndexOf("build") > 0 Then
                Return "#86bb41"
            ElseIf ParentSkin.IndexOf("send") > 0 Then
                Return "#8c3b3b"
            ElseIf ParentSkin.IndexOf("maps") > 0 Then
                Return "#876c49"
            ElseIf ParentSkin.IndexOf("coaching") > 0 Then
                Return "#f1a519"
            ElseIf ParentSkin.IndexOf("everyone") > 0 Then
                Return "#1f594f"
            End If


            Return "#28686E"


        End Function
        Public Function GetBulletName() As String
            Dim ParentSkin = DotNetNuke.UI.Skins.Skin.GetParentSkin(Me).ToString

            If ParentSkin.IndexOf("win") > 0 Then
                Return "Win"
            ElseIf ParentSkin.IndexOf("build") > 0 Then
                Return "Build"
            ElseIf ParentSkin.IndexOf("send") > 0 Then
                Return "Send"
            ElseIf ParentSkin.IndexOf("maps") > 0 Then
                Return "Maps"
            ElseIf ParentSkin.IndexOf("coaching") > 0 Then
                Return "Coaching"
            ElseIf ParentSkin.IndexOf("everyone") > 0 Then
                Return "Everyone"
            End If


            Return "Win"


        End Function

        Protected Sub TreeView1_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TreeView1.SelectedNodeChanged
            If TreeView1.SelectedNode.Depth = 0 Then
                TreeView1.SelectedNode.ToggleExpandState()
            End If
        End Sub
    End Class
End Namespace
