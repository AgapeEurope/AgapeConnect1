<%@ Control Language="VB" AutoEventWireup="False" CodeFile="gr_mapping.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.gr_mapping" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

Global Registry API Key : <asp:TextBox ID="tbApiKey" runat="server" width ="400px"></asp:TextBox><br />



<asp:GridView ID="gvMappings" runat="server" DataSourceID="dsGR_Mappings"></asp:GridView>



<asp:ListBox ID="gr_entity_types" runat="server" Height="400px"></asp:ListBox>