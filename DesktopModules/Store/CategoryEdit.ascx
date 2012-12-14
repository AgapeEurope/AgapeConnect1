<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CategoryEdit.ascx.cs" Inherits="DotNetNuke.Modules.Store.WebControls.CategoryEdit" targetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx"%>
<table width="100%" border="0" cellspacing="5">
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelCategoryName" runat="server" controlname="txtCategoryName"></dnn:label>
        </td>
        <td class="Normal">
            <asp:TextBox id="txtCategoryName" Runat="server" Width="200" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
            <asp:RequiredFieldValidator id="valReqCategoryName" runat="server" ControlToValidate="txtCategoryName" Display="Dynamic" ErrorMessage="* Category name is required." resourcekey="valReqCategoryName" SetFocusOnError="true"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr id="trSEOName" runat="server" valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelSEOName" runat="server" controlname="txtSEOName"></dnn:label>
        </td>
        <td class="Normal">
            <asp:TextBox id="txtSEOName" Runat="server" Width="200" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
            <asp:RegularExpressionValidator ID="valRegExSEOName" runat="server" ErrorMessage="Invalid character(s)!" ControlToValidate="txtSEOName" SetFocusOnError="True" ValidationExpression="[_a-zA-Z0-9-]*" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr id="trKeywords" runat="server" valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelCategoryKeywords" runat="server" controlname="txtCategoryKeywords"></dnn:label>
        </td>
        <td>
            <asp:TextBox id="txtCategoryKeywords" Runat="server" Width="300" Height="50" MaxLength="1000" TextMode="MultiLine" CssClass="NormalTextBox"></asp:TextBox>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelCategoryDescription" runat="server" controlname="txtDescription"></dnn:label>
        </td>
        <td>
            <asp:TextBox id="txtDescription" Runat="server" Width="350" MaxLength="500" CssClass="NormalTextBox"></asp:TextBox>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelOrder" runat="server" controlname="txtOrder"></dnn:label>
        </td>
        <td class="Normal">
            <asp:TextBox id="txtOrder" Runat="server" Width="35" MaxLength="50" CssClass="NormalTextBox"></asp:TextBox>
            <asp:RequiredFieldValidator id="validatorRequireOrder" runat="server" ControlToValidate="txtOrder" Display="Dynamic" ErrorMessage="* Display Order is required." resourcekey="validatorRequireOrder" SetFocusOnError="true"></asp:RequiredFieldValidator>
            <asp:CompareValidator id="validatorOrder" runat="server" ErrorMessage="* Enter a valid display order." resourcekey="validatorOrder" Type="integer" ControlToValidate="txtOrder" Operator="DataTypeCheck" Display="Dynamic" SetFocusOnError="true"></asp:CompareValidator>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelParentCategory" runat="server" controlname="ddlParentCategory"></dnn:label>
        </td>
        <td class="Normal">
            <asp:DropDownList id="ddlParentCategory" runat="server" CssClass="NormalTextBox"></asp:DropDownList>
            <asp:CustomValidator ID="valCustomParentCategory" runat="server" ControlToValidate="ddlParentCategory" ErrorMessage="Recurse !" OnServerValidate="valCustomParentCategory_ServerValidate" resourcekey="valCustomParentCategory" SetFocusOnError="True"></asp:CustomValidator>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" style="width:150px">
            <dnn:label id="labelArchived" runat="server" controlname="chkArchived"></dnn:label>
        </td>
        <td>
            <asp:CheckBox id="chkArchived" Runat="server" CssClass="NormalTextBox"></asp:CheckBox>
        </td>
    </tr>
    <tr valign="top">
        <td class="SubHead" colspan="2">
            <dnn:label id="labelMessage" runat="server" controlname="txtMessage"></dnn:label>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <dnn:TextEditor id="txtMessage" runat="server" width="500" height="350"></dnn:TextEditor>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <asp:linkbutton id="cmdUpdate" CssClass="CommandButton" runat="server" resourcekey="cmdUpdate" onclick="cmdUpdate_Click">Update</asp:linkbutton>
            <asp:linkbutton id="cmdCancel" CssClass="CommandButton" runat="server" CausesValidation="False" resourcekey="cmdCancel" onclick="cmdCancel_Click">Cancel</asp:linkbutton>
            <asp:linkbutton id="cmdDelete" CssClass="CommandButton" runat="server" CausesValidation="False" Visible="False" resourcekey="cmdDelete" onclick="cmdDelete_Click">Delete</asp:linkbutton>
        </td>
    </tr>
</table>
