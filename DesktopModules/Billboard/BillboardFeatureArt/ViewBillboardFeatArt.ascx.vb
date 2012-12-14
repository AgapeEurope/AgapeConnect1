Imports System.Linq

Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.HtmlControls
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports DotNetNuke
Imports DotNetNuke.Security
Imports System.Collections.Generic
Imports System.Collections.Specialized
Imports System.Reflection
Imports System.Math
Imports System.Net
Imports System.IO
Imports System.Drawing.Image
Imports System.Drawing
Imports DotNetNuke.Modules.BillboardFeatureArt.ViewEventArgs
Imports DotNetNuke.Modules.FeatArchive.ArchEventArgs
Imports Billboard


Namespace DotNetNuke.Modules.BillboardFeatureArt
    Partial Class ViewBillboardFeatArt
        Inherits Entities.Modules.PortalModuleBase
        Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Me.Load
            If Not Page.IsPostBack Then
                fillPlace()
                Dim t As Type = btnMain.GetType()
                Dim sb As System.Text.StringBuilder = New System.Text.StringBuilder()
                sb.Append("<script language='javascript'>")
                sb.Append("setUpMyFeat();")
                sb.Append("</script>")
                ScriptManager.RegisterStartupScript(btnMain, t, "popupAdd2", sb.ToString, False)
                Dim d As New Billboard.BillboardDataContext
                Dim q = From c In d.Agape_Billboard_Features Where c.Current = True
                If q.Count > 0 Then
                    imgMain.ImageUrl = "~/DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & q.First.BillboardPhotoId & "&Size=125"
                    lblTitle.Text = q.First.Headline
                    lblType.text = (From c In d.Agape_Billboard_Feature_Types Where c.TypeNumber = q.First.FeatType Select c.TypeName).First
                    lblMainText.Text = ((BillboardFunctions.StripBillTags(q.First.StoryText)).ToString.Substring(0, Math.Min(CStr(BillboardFunctions.StripBillTags(q.First.StoryText)).Length, 190))) & "...<span style=""color:#0670A3; font-weight:bold;"">&#123;Read More&#125;</span>"
                    hfFeatureId.Value = q.First.BillboardFeatureId
                Else
                    lblError.Text = "There was no Feature Article found."
                    lblError.Visible = True
                End If
                pnlMainContent.Visible = True

            End If
        End Sub
        Protected Sub btnMain_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMain.Click
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillFeatTabId

            If q.Count > 0 Then
                If Not (q.First Is Nothing) Then
                    Response.Redirect(NavigateURL(CInt(q.First)) & "?FeatId=" & hfFeatureId.Value & "&Mode=1")
                End If
            End If
            'Response.Redirect(EditUrl("ViewFeat") & "?FeatId=" & hfFeatureId.Value & "&Mode=1")
        End Sub
        Public Sub fillPlace()
            Dim d As New Billboard.BillboardDataContext
            Dim s = From c In d.Agape_Billboard_Features Where c.Current = False And c.Visible = True
            If Not s.Count > 0 Then
                phPanes.Controls.Add(New LiteralControl("<div class=""Bill_H5"">There are no archived Feature Articles to view.</div>"))
            Else
                Dim q = From c In d.Agape_Billboard_Feature_Types Where 1 = 1 Order By c.TypeNumber
                For Each Type In q
                    Dim r = From c In d.Agape_Billboard_Features Where c.FeatType = Type.TypeNumber And c.Current = False And c.Visible = True And c.Sent = True Select c
                    phChoices.Controls.Add(New LiteralControl("<a class=""typeChoice"" href="""" id=""choose" & Type.TypeNumber & """ onclick=""showThis(" & Type.TypeNumber & "); return false;"">" & Type.TypeName & "</a><br/><br/>"))
                    Dim pane As String = ""
                    pane &= "<div id=""pane" & Type.TypeNumber & """ class=""openFirst"" style=""width:400px;""><Table>"
                    If r.Count > 0 Then
                        For Each feat In r
                            pane &= "<tr style=""cursor:pointer;"" onClick=""goThereFeat(" & feat.BillboardFeatureId & "); return false;""><td><div class=""Bill_Photo"" style=""height:60px; width:60px;""><img alt="""" src=""../../DesktopModules/Billboard/GetBillboardImage.aspx?PhotoId=" & feat.BillboardPhotoId & "&Size=60""></img></div></td>"
                            pane &= "<td><table style=""width:100%;""><tr><td class=""Bill_H5"" style=""text-align:left;"">" & feat.Headline & "</td><td class=""Bill_SubTitle"" style=""text-align:right;"">" & feat.StoryDate & "</td></tr>"
                            pane &= "<tr><td class=""Bill_Text_Main"" style=""font-size:7pt;"" colspan=""2"">" & (BillboardFunctions.StripBillTags(feat.StoryText).ToString.Substring(0, Math.Min(CStr(BillboardFunctions.StripBillTags(feat.StoryText)).Length, 150))) & "...<span style=""color:#0670A3; font-weight:bold;"">&lt;&#47;Read More&gt;</span></td></tr></table></td></tr>"
                            pane &= "<tr class=""dotBottom""><td colspan=""2""></td></tr>"
                        Next
                    Else
                        pane &= "<tr><td><div class=""Bill_H5"">There are no archived Feature Articles in this section.</div></td></tr>"
                    End If
                    phPanes.Controls.Add(New LiteralControl(pane & "</table></div>"))
                    'phArrows.Controls.Add(New LiteralControl("<img style=""padding-top:4px; padding-bottom:4px; alt="""" class=""rightArrow"" src=""../../images/Billboard/rightArrow.gif"" id=""rightArrow" & Type.TypeNumber & """ width=""20px""></img><br/><br/>"))
                Next

            End If
        End Sub
        Protected Sub lbFalseFeat_Click(sender As Object, e As System.EventArgs) Handles lbFalseFeat.Click
            Dim d As New BillboardDataContext
            Dim q = From c In d.Agape_Billboard_Globals Where 1 = 1 Select c.BillFeatTabId

            If q.Count > 0 Then
                If Not (q.First Is Nothing) Then
                    Response.Redirect(NavigateURL(CInt(q.First)) & "?FeatId=" & hfGoThere.Value & "&Mode=1")
                End If
            End If
            'Response.Redirect(EditUrl("ViewFeat") & "?FeatId=" & hfGoThere.Value & "&Mode=1")
        End Sub
    End Class
End Namespace