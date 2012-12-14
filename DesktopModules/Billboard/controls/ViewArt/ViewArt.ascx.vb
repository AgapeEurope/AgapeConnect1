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
Imports System.IO
Imports Billboard
Imports DotNetNuke


Partial Class DesktopModules_Billboard_controls_ViewArt_ViewArt
    Inherits DotNetNuke.Entities.Modules.PortalModuleBase

    Dim LinkString As String

    Public Sub Initialise(ByVal ThisLink As String)

        LinkString = ThisLink
        'If Not Page.IsPostBack Then
        Dim i As Integer = 1
        Dim loadScript As String = "<script type=""text/javascript""> var cf = new Crossfader(new Array("
        Dim d As New Billboard.BillboardDataContext
        Dim q = From c In d.Agape_Billboard_Articles Where c.Current = True Order By c.StoryDate Descending
        ProductsPH.Controls.Clear()
        For Each row In q
            AddRow(row, i)
            loadScript = loadScript & "'cf" & i & "', "
            i = i + 1
        Next
        If q.Count = 0 Then
            lblTotal.Visible = False
            lblOf.Visible = False
            pnlButtons.CssClass = ".hideMe"
            'pnlButtons.Visible = False
            ProductsPH.Controls.Add(New LiteralControl("<div class=""Bill_H4"">There are no articles currently</div>"))
        ElseIf q.Count = 1 Then
            pnlButtons.CssClass = "hideMe"
            'pnlButtons.Visible = False
        End If
        lblTotal.Text = i - 1 & ")"

        loadScript = Left(loadScript, loadScript.Length - 2) & "), 500, 9000); </script>"

        loadscriptPH.Controls.Add(New LiteralControl(loadScript))

        'End If



    End Sub

    Public Sub AddRow(ByVal row As Agape_Billboard_Article, ByVal i As Integer)
        Dim link As String = ""
        If row.BillbaordArticleId > -1 Then
            'place popup code here
            'link = "onclick='window.location.href = """ & LinkString & "?ArtId=" & row.BillbaordArticleId & "&Mode=2" & """) '"
            link = LinkString & "?ArtId=" & row.BillbaordArticleId & "&Mode=2"
        End If
        Dim d As New BillboardDataContext
        Dim Author As String = ""
        If row.AuthorName = "" Or row.AuthorName Is Nothing Then
            Author = (From c In d.Users Where c.UserID = CInt(row.Author) Select c.DisplayName).First
        Else
            Author = row.AuthorName
        End If

        ProductsPH.Controls.Add(New LiteralControl("<div class=""cf_element"" style=""height:150"" id=""cf" & i & """>" _
                            & "<a href=" & link & " style=""cursor:pointer; text-decoration:none;""><div class=""thiscontent"">" _
                            & "<div style=""display:block; clear:both; width:550px;""><div style=""width:125px; height:125px; float:left;"" class=""Bill_Photo""><img width=""125"" height=""125"" src=""" & UseImage(row.BillboardPhotoId) & """/></div>" _
                            & "<div style=""width:405px; vertical-align:top; float:right;""><div style=""margin-bottom: 5px;"" class=""Bill_H3"">" & row.Headline & "</div>" _
                            & "<div style=""width:405px; color:#0670A2; font-family:Verdana; font-size:10pt; font-style:italic; text-align:right;"">" & Author & "</div>" _
                            & "<div class=""Bill_Text_Front"" style=""font-size:10pt;"">" & CleanUpText(row.StoryText) & "</div></div>" _
                            & "</div></div></a></div>"))
    End Sub
    Protected Function UseImage(ByVal ThisPhotoId As Integer) As String
        Dim t As New Billboard.BillboardDataContext
        Dim FilePath As String = "/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=-1&Size=125"
        Dim q = From c In t.Agape_Billboard_Photos Where c.BillboardPhotoId = ThisPhotoId

        If q.Count > 0 Then
            FilePath = "/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & ThisPhotoId & "&Size=125"
        End If
        Return FilePath

    End Function
    Public Sub ShowThisArt(ByVal ThisArtId As Integer)
        If ThisArtId > -1 Then
            lblOutput.Text = "This is " & ThisArtId
            lblOutput.Visible = True
        End If
    End Sub
    Public Function CleanUpText(ByVal ThisText As String) As String
        Dim Out As String = ""

        Out = Billboard.BillboardFunctions.StripBillTags(ThisText)
        Out = Out.Substring(0, Math.Min(150, CStr(Billboard.BillboardFunctions.StripBillTags(ThisText)).Length)) & "...<span style=""color:#0670A3; font-weight:bold;"">&#123;Read More&#125;</span>"
        'Out = StripBillTags(ThisText)
        'Out = Out.Substring(0, Math.Min(150, CStr(StripBillTags(ThisText)).Length)) & "...<span style=""color:#0670A3; font-weight:bold;"">&#123;Read More&#125;</span>"

        Return Out
    End Function
    Public Function StripBillTags(ByVal HTML As String) As String
        ' Removes tags from passed HTML

        Dim pattern As String = "<(.|\n)*?>"
        Dim pattern2 As String = "\[.*?]]\]"
        Dim pattern3 As String = "\[.*?]\]"

        Dim s As String = Regex.Replace(HTML, pattern, String.Empty)
        s = Regex.Replace(Regex.Replace(s, pattern2, String.Empty), pattern3, String.Empty)

        If s.LastIndexOf("<") > 0 And s.LastIndexOf("<") > 0 Then
            If s.LastIndexOf("<") > s.LastIndexOf(">") Then
                s = s.Replace(s.Substring(s.LastIndexOf("<")), "")
            End If
        ElseIf s.LastIndexOf(">") > 0 And s.LastIndexOf("<") = Nothing Then
            If s.LastIndexOf("<") > s.LastIndexOf(">") Then
                s = s.Replace(s.Substring(s.LastIndexOf("<")), "")
            End If
        End If
        If s.IndexOf("&") > 0 Then
            s = s.LastIndexOf("&") & ", " & s.LastIndexOf(" ") & ", " & s.LastIndexOf(";")
            'If Not (s.Substring(s.LastIndexOf("&")).IndexOf(" ") > 0 And s.Substring(s.LastIndexOf("&")).IndexOf(";") > 0) Then
            's = "Hello World"
            's = s.Replace(s.Substring(s.LastIndexOf("&")), "")
            'End If
        End If


        Return s

    End Function
End Class


