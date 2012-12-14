<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditAnnouncement.ascx.vb" Inherits="controls_Billboard_EditAnnouncement" ClassName="controls_Billboard_EditAnnouncement" %>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillCSS/jquery-ui-1.8.18.custom.css" />
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<asp:HiddenField ID="hfNowLessMonth" runat="server" />
<asp:HiddenField ID="hfThisUser" runat="server" />
<asp:HiddenField ID="hfFileAttach" runat="server" />
<asp:HiddenField ID="hfFileSize" runat="server" />


<script type="text/javascript">

 (function ($, Sys) {
        function setUpMyTabs() {
            var stop = false;
            $("#divEditAnn").dialog({
                autoOpen: false,
                height: 500,
                width: 600,
                modal: true,
                show: 'fade',
                hide: 'fade',
                dialogClass: 'dialogWithDropShadow',
                title: '<div class="closeEl"><a style="cursor:pointer;" onclick="return false;"><img onclick="closeLinke()" src="/images/Billboard/BlueCross.gif" title="Close Window" alt="Close" /></a></div><br/><div class="Bill_H3">Edit Announcement</div>',
                open: function (event, ui) {
                    $('.ui-dialog-titlebar-close').hide();
                    
                    $('body').css({ 'overflow': 'hidden' });
                }
            });
            $("#divEditAnn").parent().appendTo($("form:first"));
        }
        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    } (jQuery, window.Sys));

    function showEditAnn() { $("#divEditAnn").dialog("open");return false;}
    function closeLinke() {
        $('body').css({ 'overflow': 'auto' });
        $("#divEditAnn").dialog("close");
        return false;
    }
    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
</script>

<style type="text/css">
.BackBlue
{
    background-color:#CCFFFF;
}
.BackClear
{
    background-color:transparent;
}
.BackYellow
{
    background-color:#FFFF99;
}
.BackGreen
{
    background-color:#CCFFCC;
}

img.btn_closee {
	float: right;
	margin: -5px -5px 0 0;
}
    .dialogWithDropShadow
    {
        -webkit-box-shadow: 0px 0px 20px #000;
        -moz-box-shadow: 0px 0px 20px #000;
        box-shadow: 0px 0px 20px #000;
    }
    .closeEl
    {
        position: absolute;
        right: .3em;
        top: 50%;
        width: 19px;
        margin: -25px 0 0 0;
        padding: 1px;
        height: 18px;
    }
    .padInner
    {
        margin: 5px 10px 10px 5px;
    }
</style>

<fieldset>
<legend class="Bill_H4">Add New Announcement</legend>
<table>
<tr>
<td style="font-size:10pt;">Announcement Title:</td>
<td>
    <asp:TextBox ID="tbTitle" runat="server" MaxLength="150" Width="300px" onkeyup='textCounter(this, this.form.remLenAnn, 150);' 
                onkeydown="textCounter(this, this.form.remLenAnn, 150);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenAnn" size="3" maxlength="3" value="150" /> characters left
    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" 
        ErrorMessage="Required Field" ControlToValidate="tbTitle"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td width="100px" style="font-size:10pt;">Announcement Text:

</td>
<td>
    <asp:TextBox ID="tbText" runat="server" Rows="5" TextMode="MultiLine" 
        Width="300px" MaxLength="500" onkeyup='textCounter(this, this.form.remLenAnn2, 500);' 
                onkeydown="textCounter(this, this.form.remLenAnn2, 500);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenAnn2" size="3" maxlength="3" value="500" /> characters left
    <asp:RequiredFieldValidator ID="rfvText" runat="server" ErrorMessage="Required Field" ControlToValidate="tbText"></asp:RequiredFieldValidator>
</td>



</tr>
<tr>
<td></td>
<td>
    <div style="font-size:7pt;">
        To make text bold place <b>[b]</b> before it and <b>[/b]</b> after it.<br /> To 
        make text italic place <b>[i]</b> before it and <b>[/i]</b> after it.<br /> To 
        make text underlined place <b>[ul]</b> before it and <b>[/ul]</b> after it.<br />
    </div>
</td>
</tr>
<tr>
<td style="font-size:10pt;">File Attachment:<br />
    <asp:Label ID="Label5" runat="server" Font-Size="7pt" ForeColor="Blue"
    Text="Please don't upload any<br/>images as attachments."></asp:Label>
</td>
<td>
    <asp:FileUpload ID="fuAttachment" runat="server" /><%--&nbsp;
    <asp:Button ID="btnAttach" runat="server" Text="Add Attachment" CausesValidation="false" />--%><br />
    <asp:Label ID="lblAttachOut" runat="server" Visible="false"></asp:Label>
</td>
</tr>
<tr>
<td style="font-size:10pt;">Make Visible?:</td>
<td>
    <asp:CheckBox ID="cbVisible" runat="server" checked ="true"/>
</td>
</tr>
<tr>
<td colspan="2" align="center">
    <asp:Button ID="btnAdd" runat="server" Text="Add Announcement" />
</td>
</tr>
</table>
</fieldset>

<br />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<fieldset>
<legend class="Bill_H4">Previous Announcements</legend>
    <asp:Panel ID="pnlTable" runat="server">
<table>
<tr>
<td width="700px">
 <asp:GridView ID="gvAnnouncements" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="AnnouncementId" DataSourceID="dsAnnouncements" 
        EnableModelValidation="True" Font-Names="verdana" Font-size="7pt" 
        AllowPaging="True" PageSize="10">
        <Columns>
            <asp:TemplateField HeaderText="Title" SortExpression="AnnouncementTitle">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("AnnouncementTitle") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Text" SortExpression="AnnouncementText">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Billboard.BillboardFunctions.BillHtml(Eval("AnnouncementText")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Visible" SortExpression="Visible">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Visible") %>' 
                        Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sent" SortExpression="Current">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Sent") %>' 
                        Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Uploader" SortExpression="Uploader">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# DisplayThisName(Eval("Uploader")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Attachment" SortExpression="Attachment">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Visible='<%# AttachVis(Eval("AnnouncementId")) %>' Text='<%# Eval("FileAttach") & TestBytes(Eval("AnnouncementId")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="MyEdit" Text="Edit" CommandArgument='<%# Eval("AnnouncementId") %>'></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="MyDelete" Text="Delete" CommandArgument='<%# Eval("AnnouncementId") %>' Visible='<%# ButtonEnabled3(Eval("AnnouncementId")) %>'></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</td>
<td valign="top">
<asp:Panel ID="pnlKey" runat="server">
<table style="font-size:7pt; font-family:Verdana;">
<tr>
<td class="Bill_H5" colspan="2">
Key:
</td>
</tr>
<tr style="height: 20px">
<td>
Visible/Un-sent (Current):&nbsp;
</td>
<td class="BackClear" style="border: 1pt solid #000000">
&nbsp;&nbsp;&nbsp;
</td>
</tr>
<tr style="height: 20px">
<td>
Invisible/Un-sent (Editing):&nbsp;
</td>
<td class="BackBlue" style="border: 1pt solid #000000">
&nbsp;&nbsp;&nbsp;
</td>
</tr>
<tr>
<td style="height: 20px">
Visible/Sent (Archive/Current):&nbsp;
</td>
<td class="BackYellow" style="border: 1pt solid #000000">
&nbsp;&nbsp;&nbsp;
</td>
</tr>
<tr style="height: 20px">
<td>
Invisible/Sent (Removed from Archive):&nbsp;
</td>
<td class="BackGreen" style="border: 1pt solid #000000">
&nbsp;&nbsp;&nbsp;
</td>
</tr>
</table>
</asp:Panel>
</td>
</tr>
</table>
   
    
<br />
    <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
    <asp:LinqDataSource ID="dsAnnouncements" runat="server" 
        ContextTypeName="Billboard.BillboardDataContext" EnableUpdate="False" 
        OrderBy="AnnouncementDate desc, AnnouncementTitle" TableName="Agape_Billboard_Announcements">
    </asp:LinqDataSource>
    </asp:Panel>
    </fieldset>
    </ContentTemplate>
<Triggers>
<%--<asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />--%>
<asp:PostBackTrigger ControlID="btnAdd" />
</Triggers>
</asp:UpdatePanel>

<br />
<br />
        
  
<%--    <div id="editAnnInner" style="overflow:hidden; padding-right:5px;">--%>
<div id="divEditAnn">
  <asp:UpdatePanel ID="upEditAnn" runat="server">
        <ContentTemplate>  
        <div class="Agape_Sub_Title">
            <asp:Label ID="lblAuthorDate" runat="server"></asp:Label>
        </div><br />
            <asp:Label ID="lblEditError" runat="server" visible="false" ForeColor="Red"></asp:Label>
        <table>
        <tr>
        <td>
        Edit Announcement Title:
        </td>
        <td>
            <asp:TextBox ID="tbEditTitle" runat="server" Width="250px" MaxLength="150" onkeyup='textCounter(this, this.form.remLenAnn3, 150);' 
                onkeydown="textCounter(this, this.form.remLenAnn3, 150);" onselect="textCounter(this, this.form.remLenAnn3, 500);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenAnn3" size="3" maxlength="3" value="150" /> characters left
        </td>
        </tr>
        <tr>
        <td>
        Edit Announcement Text:
        </td>
        <td>
        <asp:TextBox ID="tbEditText" runat="server" Width="250px" TextMode="MultiLine" Rows="8" MaxLength="500" onkeyup='textCounter(this, this.form.remLenAnn4, 500);' 
                onkeydown="textCounter(this, this.form.remLenAnn4, 500);" onselect="textCounter(this, this.form.remLenAnn4, 500);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenAnn4" size="3" maxlength="3" value="500" /> characters left
        </td>
        </tr>
        <tr>
<td></td>
<td>
<div style="font-size:7pt;">
To make text bold place <b>[b]</b> before it and <b>[/b]</b> after it.<br />
To make text italic place <b>[i]</b> before it and <b>[/i]</b> after it.<br />
To make text underlined place <b>[ul]</b> before it and <b>[/ul]</b> after it.<br />
</div>
</td>
</tr>
        <tr>
        <td>
        Attachment:<br />
        <asp:Label ID="Label6" runat="server" Font-Size="7pt" ForeColor="Blue"
    Text="Please don't upload any<br/>images as attachments."></asp:Label>
        </td>
        <td>
       <asp:Label ID="lblCurrentAttach" runat="server"></asp:Label>
        <asp:FileUpload ID="fuEditAttach" runat="server"/>&nbsp;<%--<asp:Button ID="btnEditAttach"
            runat="server" Text="Add Attachment" CausesValidation="false" />--%><br />
            <asp:Button ID="btnDeleteAttach" runat="server" Text="Delete Attachment" CausesValidation="false" /><br />
            <asp:Label ID="lblEditAttach" runat="server" visible="false"></asp:Label>
        </td>
        </tr>
        <tr>
        <td>Make Visible?:</td>
        <td>
            <asp:CheckBox ID="cbEditVisible" runat="server" />
        </td>
        </tr>
        <tr>
        <td colspan="2" align="center">
           
           <asp:ImageButton ID="btnUpdateEdit" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Update1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Update2.gif';" CausesValidation="false"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Update1.gif';" AlternateText="Update Announcement" ToolTip="Update Announcement"/>
            <%--<asp:LinkButton ID="btnUpdateEdit" runat="server" CausesValidation="false">Update</asp:LinkButton>--%>
        </td>
        </tr>
        </table>
    <asp:HiddenField ID="hfEditAnnId" runat="server" />
    </ContentTemplate>
        <Triggers>
        <%--<asp:AsyncPostBackTrigger ControlID="btnEditAttach" EventName="Click" />--%>
        <asp:AsyncPostBackTrigger ControlID="btnDeleteAttach" EventName="Click" />
        <asp:PostBackTrigger ControlID="btnUpdateEdit" />
        </Triggers>
        </asp:UpdatePanel>
    <%--</div>--%>
    
    
</div>
        
