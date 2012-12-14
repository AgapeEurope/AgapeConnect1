<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EditPrayer.ascx.vb" Inherits="DesktopModules_Billboard_controls_EditPrayer" ClassName="DesktopModules_Billboard_controls_EditPrayer"%>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />

<asp:HiddenField ID="hfNowLessMonth" runat="server" />
<asp:HiddenField ID="hfThisUser" runat="server" />

<script type="text/javascript">
    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit)
            field.value = field.value.substring(0, maxlimit);
        else
            countfield.value = maxlimit - field.value.length;
    }
    function postThis() {
        __doPostBack("<%= LinkButton3.UniqueID %>", "");
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
</style>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
<fieldset>
<legend class="Bill_H4">Add New Prayer Request</legend>
<table>
<tr>
<td>Request Title:</td>
<td>
    <asp:TextBox ID="tbTitle" runat="server" MaxLength="150" Width="300px" onkeyup='textCounter(this, this.form.remLenPray, 150);' 
                onkeydown="textCounter(this, this.form.remLenPray, 150);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray" size="3" maxlength="3" value="150" /> characters left
    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" 
        ErrorMessage="Required Field" ControlToValidate="tbTitle"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>Submitted By:</td>
<td>
     <asp:TextBox ID="tbSubmittedBy" runat="server" MaxLength="200" Width="300px" onkeyup='textCounter(this, this.form.remLenPray, 150);' 
                onkeydown="textCounter(this, this.form.remLenPray, 150);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray" size="3" maxlength="3" value="200" /> characters left
                <asp:RequiredFieldValidator ID="rfvSub" runat="server" ErrorMessage="Required Field" ControlToValidate="tbSubmittedBy"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>Request Text:</td>
<td>
    <asp:TextBox ID="tbText" runat="server" Rows="4" TextMode="MultiLine" 
        Width="300px" MaxLength="500" onkeyup='textCounter(this, this.form.remLenPray2, 500);' 
                onkeydown="textCounter(this, this.form.remLenPray2, 500);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray2" size="3" maxlength="3" value="500" /> characters left
    <asp:RequiredFieldValidator ID="rfvText" runat="server" ErrorMessage="Required Field" ControlToValidate="tbText"></asp:RequiredFieldValidator>
</td>
</tr>
<tr>
<td>
<td></td>
<div style="font-size:7pt;">
    <caption>
        To make text bold place <b>[b]</b> before it and <b>[/b]</b> after it.<br /> To make text italic place <b>[i]</b> before it and <b>[/i]</b> after it.<br /> To make text underlined place <b>[ul]</b> before it and <b>[/ul]</b> after it.<br />
    </caption>
</div>
</td>
</tr>
<tr>
<td>Make Visible?:</td>
<td>
    <asp:CheckBox ID="cbVisible" runat="server" checked ="true"/>
</td>
</tr>
<tr>
<td colspan="2" align="center">
    <asp:Button ID="btnAdd" runat="server" Text="Add Prayer Request" />
</td>
</tr>
</table>
</fieldset>
<br />
<fieldset><legend class="Bill_H4">Previous Prayer Requests</legend>
    <asp:LinkButton ID="LinkButton3" runat="server" style="display:none;" CausesValidation="false">LinkButton</asp:LinkButton>


    <asp:Panel ID="pnlTable" runat="server">
    
<table>
<tr>
<td width="700px">
 <asp:GridView ID="gvPrayer" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="BillboardPrayerId" DataSourceID="dsPrayer" AllowPaging="True">
        <Columns>
            <asp:TemplateField HeaderText="Title" SortExpression="AnnouncementTitle" ItemStyle-Font-Size="7pt" ItemStyle-Font-Names="verdana">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("PrayerTitle") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Text" SortExpression="AnnouncementText" ItemStyle-Font-Size="7pt" ItemStyle-Font-Names="verdana">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Billboard.BillboardFunctions.BillHtml(Eval("PrayerText")) %>'></asp:Label>
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
            <asp:TemplateField HeaderText="Submitted By" SortExpression="Uploader" ItemStyle-Font-Size="7pt" ItemStyle-Font-Names="verdana">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# DisplayThisName2(Eval("BillboardPrayerId")) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False" ItemStyle-Font-Size="10pt" ItemStyle-Font-Names="verdana">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="MyEdit" Text="Edit" CommandArgument='<%#Eval("BillboardPrayerId") %>' ></asp:LinkButton><br />
                    <asp:LinkButton ID="LinkButton2" runat="server" Text="Delete" CommandName="MyDelete" CommandArgument='<%# Eval("BillboardPrayerId") %>' CausesValidation="False"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</td>
<td valign="top">
<asp:Panel ID="pnlKey" runat="server">
<table style="font-size:7pt;">
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
    <asp:LinqDataSource ID="dsPrayer" runat="server" 
        ContextTypeName="Billboard.BillboardDataContext" 
        OrderBy="SubmittedDate desc, PrayerTitle" TableName="Agape_Billboard_Prayers" 
            EntityTypeName="" 
            Where="(Current == @Current || Current == @Current1) &amp;&amp; (Sent == @Sent || Sent == @Sent1) &amp;&amp; (Visible == @Visible || Visible == @Visible1)" >
        <WhereParameters>
            <asp:Parameter DefaultValue="True" Name="Current" Type="Boolean" />
            <asp:Parameter DefaultValue="False" Name="Current1" Type="Boolean" />
            <asp:Parameter DefaultValue="True" Name="Sent" Type="Boolean" />
            <asp:Parameter DefaultValue="False" Name="Sent1" Type="Boolean" />
            <asp:Parameter DefaultValue="True" Name="Visible" Type="Boolean" />
            <asp:Parameter DefaultValue="False" Name="Visible1" Type="Boolean" />
        </WhereParameters>
    </asp:LinqDataSource>
    </asp:Panel>
    <asp:Panel ID="pnlEdit" runat="server">
        <div class="Agape_Sub_Title">
            By:&nbsp;<asp:Label ID="lblAuthorDate" runat="server"></asp:Label>
        </div><br />
            <asp:Label ID="lblEditError" runat="server" visible="false" ForeColor="Red"></asp:Label>
        <table>
        <tr>
        <td>
        Edit Request Title:
        </td>
        <td>
            <asp:TextBox ID="tbEditTitle" runat="server" Width="300px" MaxLength="150" onkeyup='textCounter(this, this.form.remLenPray3, 150);' 
                onkeydown="textCounter(this, this.form.remLenPray3, 150);" onselect="textCounter(this, this.form.remLenPray3, 150);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray3" size="3" maxlength="3" value="150" /> characters left
        </td>
        </tr>
        <tr>
        <td>Edit Submitted by:</td>
        <td>
        <asp:TextBox ID="tbEditSub" runat="server" Width="300px" MaxLength="200" onkeyup='textCounter(this, this.form.remLenPray3, 200);' 
                onkeydown="textCounter(this, this.form.remLenPray3, 200);" onselect="textCounter(this, this.form.remLenPray3, 200);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray3" size="3" maxlength="3" value="200" /> characters left
        </td>
        </tr>
        <tr>
        <td>
        Edit Request Text:
        </td>
        <td>
        <asp:TextBox ID="tbEditText" runat="server" Width="300px" TextMode="MultiLine" Rows="5" MaxLength="500" onkeyup='textCounter(this, this.form.remLenPray4, 500);' 
                onkeydown="textCounter(this, this.form.remLenPray4, 500);" onselect="textCounter(this, this.form.remLenPray4, 500);"></asp:TextBox>
                <input readonly="readonly" type="text" name="remLenPray4" size="3" maxlength="3" value="500" /> characters left
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
          <asp:ImageButton ID="btnCancelEdit" runat="server" Height="24px" ImageUrl="~/DesktopModules/Billboard/images/BtnImg/Cancel1.gif"  
                                                onmouseover="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel2.gif';" CausesValidation="false"  
                                                onmouseout="this.src='/DesktopModules/Billboard/images/BtnImg/Cancel1.gif';" AlternateText="Cancel" ToolTip="Cancel"/>
        </td>
        </tr>
        </table>
    <asp:HiddenField ID="hfEditPrayerId" runat="server" />
    </asp:Panel>
    </fieldset>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="LinkButton3" EventName="Click" />
    </Triggers>
    </asp:UpdatePanel>

