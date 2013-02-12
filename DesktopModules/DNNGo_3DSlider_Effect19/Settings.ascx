<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<dnn:sectionhead id="dshSettings" cssclass="Head" runat="server" section="tbSettings"
    resourcekey="dshSettings" includerule="True" />
<table id="tbSettings" runat="Server" cellspacing="0" cellpadding="2" border="0" width="100%"
    summary="ModuleName1 Settings Design Table">
    <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblGame_ID" runat="server" controlname="txtGame_ID" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtGame_ID" Width="300px" CssClass="NormalTextBox :required :number"></asp:TextBox>
        </td>
    </tr>
   
    <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblType" runat="server" controlname="txtType" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtType" Width="300px" CssClass="NormalTextBox :required"></asp:TextBox>
        </td>
    </tr>



     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblLeague" runat="server" controlname="txtLeague" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtLeague" Width="300px" CssClass="NormalTextBox :required"></asp:TextBox>
        </td>
    </tr>

          <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblXmlUrl" runat="server" controlname="txtXmlUrl" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtXmlUrl" Width="300px" CssClass="NormalTextBox :required"></asp:TextBox>
        </td>
    </tr>

     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblInterval_1" runat="server" controlname="txtInterval_1" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtInterval_1" Width="300px" CssClass="NormalTextBox :required :number"></asp:TextBox>
        </td>
    </tr>
     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblInterval_2" runat="server" controlname="txtInterval_2" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtInterval_2" Width="300px" CssClass="NormalTextBox :required :number"></asp:TextBox>
        </td>
    </tr>
     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblInterval_3" runat="server" controlname="txtInterval_3" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtInterval_3" Width="300px" CssClass="NormalTextBox :required :number"></asp:TextBox>
        </td>
    </tr>
     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblNoGameText" runat="server" controlname="txtNoGameText" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtNoGameText" Width="300px" CssClass="NormalTextBox :required"></asp:TextBox>
        </td>
    </tr>



</table>
 
<p style="text-align: center;">
    <asp:LinkButton CssClass="CommandButton" ID="cmdUpdate" resourcekey="cmdUpdate" runat="server"
        BorderStyle="none" Text="Update" OnClick="cmdUpdate_Click"></asp:LinkButton>&nbsp;
    <asp:LinkButton CssClass="CommandButton" ID="cmdCancel" resourcekey="cmdCancel" runat="server"
        BorderStyle="none" Text="Cancel" CausesValidation="False" OnClick="cmdCancel_Click"></asp:LinkButton>&nbsp;
</p>
     <!--
     <tr>
        <td class="SubHead" width="200" valign="top">
            <dnn:label id="lblSeason" runat="server" controlname="txtSeason" suffix=":">
            </dnn:label>
        </td>
        <td valign="bottom">
            <asp:TextBox runat="server" ID="txtSeason" Width="300px" CssClass="NormalTextBox :required"></asp:TextBox>
        </td>
    </tr>
    -->