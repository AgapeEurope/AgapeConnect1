<%@ Control Language="C#" AutoEventWireup="false" Inherits="DesktopModules.Admin.Console.Settings" CodeFile="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnConsole dnnClear">
	<div class="dnnFormItem">
		<dnn:label id="Label1" runat="server" ControlName="ParentTab" ResourceKey="Mode" Suffix=":" />
		<asp:DropDownList ID="modeList" runat="server" AutoPostBack="True">
		    <asp:ListItem Value="Normal" ResourceKey="Normal" />
		    <asp:ListItem Value="Profile" ResourceKey="Profile" />
		    <asp:ListItem Value="Group" ResourceKey="Group" />
		</asp:DropDownList>
	</div>
	<div id="parentTabRow" runat="server" class="dnnFormItem">
		<dnn:label id="lblParentTab" runat="server" ControlName="ParentTab" ResourceKey="ParentTab" Suffix=":" />
		<asp:DropDownList ID="ParentTab" runat="server" AutoPostBack="True" />
	</div>
	<div id="includeParentRow" runat="server" class="dnnFormItem">
		<dnn:label id="lblIncludeParent" runat="server" ControlName="IncludeParent" ResourceKey="IncludeParent" Suffix=":" />
		<asp:Checkbox ID="IncludeParent" runat="server" />
	</div>
    <div id="tabVisibilityRow" runat="server" class="dnnFormItem">
		<dnn:label id="tabsLabel" runat="server" ControlName="groupTabs" /><br/>
        <asp:Repeater ID="tabs" runat="server">
            <ItemTemplate>
	            <div>
		            <asp:label id="tabLabel" runat="server" CssClass="dnnTooltip"></asp:label>
	                <asp:HiddenField id="tabPath" runat="server"></asp:HiddenField>
	                <asp:DropDownList ID="tabVisibility" runat="server" />
	            </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
	<div class="dnnFormItem">
		<dnn:label id="lblDefaultSize" runat="server" ControlName="DefaultSize" ResourceKey="DefaultSize" Suffix=":" />
		<asp:DropDownList ID="DefaultSize" runat="server" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="lblAllowResize" runat="server" ControlName="AllowResize" ResourceKey="AllowResize" Suffix=":" />
		 <asp:Checkbox ID="AllowResize" runat="server" Checked="true" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="lblDefaultView" runat="server" ControlName="DefaultView" ResourceKey="DefaultView" Suffix=":" />
		<asp:DropDownList ID="DefaultView" runat="server" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="lblAllowViewChange" runat="server" ControlName="AllowViewChange" ResourceKey="AllowViewChange" Suffix=":" />
		<asp:Checkbox ID="AllowViewChange" runat="server" Checked="true" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="lblShowTooltip" runat="server" ControlName="ShowTooltip" ResourceKey="ShowTooltip" Suffix=":" />
		<asp:Checkbox ID="ShowTooltip" runat="server" Checked="true" />
	</div>
	<div class="dnnFormItem">
		<dnn:label id="lblConsoleWidth" runat="server" ControlName="ConsoleWidth" ResourceKey="ConsoleWidth" Suffix=":" />
		<asp:TextBox ID="ConsoleWidth" runat="server" Text="" />
	</div>
</div>