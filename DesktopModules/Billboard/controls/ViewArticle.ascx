<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewArticle.ascx.vb" Inherits="DesktopModules_Billboard_controls_ViewArticle" ClassName="DesktopModules_Billboard_controls_ViewArticle" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<script type="text/javascript">

    function textCounter1(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }

</script>

<asp:HiddenField ID="hfArtId" runat="server" />
<asp:HiddenField ID="hfThisUser" runat="server" />
<asp:HiddenField ID="hfThisMode" runat="server" />



<asp:Panel ID="pnlMain" runat="server">
<table width="100%">
<tr>
<td align="left">
<img alt="Article" src="/DesktopModules/Billboard/Images/BillArt.gif" />
</td>
<td align="right" style="font-family:Verdana; font-style:italic; color:#0670A2; font-size:12pt; font-weight:bold;">
<asp:Label ID="lblAuthor" runat="server"></asp:Label>
</td>
</tr>
</table>
<div class="Bill_dashed">&nbsp;</div>
<table width="100%">
<tr>
<td valign="top" width="200px">
<div class="Bill_Photo">
    <asp:Image ID="imgMain" runat="server" Width="200px" Height="200px"/>
         </div>
</td>
<td valign="top">
<div style="text-align:left;">
<asp:Label ID="lblHeadline" runat="server" CssClass="Bill_H3"></asp:Label>
</div>
<div style="text-align: right; font-family: verdana; font-size: 8pt; font-style: italic; color: #808080">
    <asp:Label ID="lblSub" runat="server"></asp:Label>
</div>
<div style="clear:both;"><br /></div><div class="Bill_Text_Front"><asp:PlaceHolder ID="phBody" runat="server"></asp:PlaceHolder></div>
</td>
</tr>
</table>
</asp:Panel>
<asp:Label ID="lblErrorUpload" runat="server" ForeColor="Red" Visible="false"></asp:Label>
<div style="clear:both;"></div>
<div class="Bill_dashed">&nbsp;</div>
<asp:Panel ID="pnlComment" runat="server">
<asp:DataList ID="dlCommentList" runat="server">
        <ItemTemplate>
            <table style="border: 1pt solid #C0C0C0" width="100%">
                <asp:Panel ID="Panel1" runat="server" visible='<%# Not(Eval("Abuse")) or ThisIsEditable() %>'>
               
            <tr  style='<%# IIF( Eval("Abuse") , "background-color:#CCCCCC;","")  %>' >
            <td  style="font-family: verdana; font-size: 8pt; color: #0670A2" width="120px">
            <asp:Label ID="User1Label" runat="server" 
                Text='<%# Eval("ThisName") %>' />
            <br />
            <asp:Label ID="CommentDateLabel" runat="server" 
                Text='<%# Eval("CommentDate", "{0:dd/MM/yyyy}") %>' />
            </td>
            <td style="font-family: verdana; font-size: 10pt; color: #808080" width="250px">
            <asp:Label ID="CommentTextLabel" runat="server" 
                Text='<%# Eval("CommentText") %>' />
            </td>
            <td width="100px">
                 <%--<asp:LinkButton ID="LinkButton1" runat="server" style="; white-space: nowrap;" Font-Size="9pt" CommandName="Abuse" 
                     CommandArgument='<%# Eval("BillboardCommentId") %>' Visible='<%# (Not Eval("Abuse")) %>'>Report Abuse</asp:LinkButton>
                     <asp:LinkButton ID="LinkButton2" runat="server" CommandName="RemoveAbuse" style="font-size: 7pt"
                     CommandArgument='<%# Eval("BillboardCommentId") %>' Visible='<%# ( Eval("Abuse") AND ThisIsEditable()) %>'>Reset</asp:LinkButton>--%>
                <asp:LinkButton ID="StoryDeleteButton" runat="server" CommandName="Delete" style="font-size: 7pt"
                    Visible='<%# IsDeleteable(Eval("BillboardCommentId")) %>' Enabled='<%# IsDeleteable(Eval("BillboardCommentId")) %>'  CommandArgument='<%# Eval("BillboardCommentId") %>'>Delete</asp:LinkButton><br />
            </td>
            </tr>
             </asp:Panel>
            </table>
        </ItemTemplate>
    </asp:DataList>
<asp:Panel ID="CommentPanel" runat="server">
<div style="text-align:left;">
<div style="font-family: verdana; font-size: 10pt; color: #808080;">
Enter your own comment:
</div>
<br />
<table>
<tr>
<td>
<asp:TextBox ID="tbCommentText" runat="server" Rows="4" TextMode="MultiLine" 
        Width="300px" MaxLength="200" onkeyup='textCounter1(this, this.form.remLenVArt, 200);' 
                onkeydown="textCounter1(this, this.form.remLenVArt, 200);" onselect="textCounter1(this, this.form.remLenVArt, 200);"></asp:TextBox>
</td>
<td valign="top">
<table>
<tr>
<td valign="bottom" class="Bill_Text_Main" style="font-size:10pt;">
<input readonly="readonly" type="text" name="remLenVArt" size="3" maxlength="3" value="200" /> characters left
</td>
</tr>
</table>
</td>
</tr>
</table>
    <br />
    

         <asp:ImageButton ID="AddCommentButton" runat="server" ImageUrl="~/DesktopModules/Billboard/Images/AddComment1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/AddComment2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/AddComment1.gif';" AlternateText="Add Comment" ToolTip="Add Comment"/>

</div>
</asp:Panel>
</asp:Panel>
<br />
<div style="text-align:left;">
<asp:ImageButton ID="btnEdit" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/Images/BtnImg/EditArticle1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/Images/BtnImg/EditArticle2.gif';"  
                                                onmouseout="this.src='/DesktopModules/Billboard/Images/BtnImg/EditArticle1.gif';" AlternateText="Edit Article" ToolTip="Edit Article"/>
                                                </div>