<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AnnArchive.ascx.vb" Inherits="DesktopModules_Billboard_controls_AnnArchive" ClassName="DesktopModules_Billboard_controls_AnnArchive"%>
<link rel="stylesheet" type="text/css" href="/DesktopModules/Billboard/BillTheme/BillStyle.css" />
<div style="text-align:center;">
<asp:panel ID="pnlArc" runat="server">
    <asp:Label ID="lblEmpty" runat="server" Text="There are no archived announcements currently." CssClass="Bill_H5" Visible="false"></asp:Label><br />
    <asp:DataList ID="dlAnn" runat="server" DataSourceID="dsBillAnn">
        <ItemTemplate>
            <table width="100%" style="text-align:left;">
                <tr>
                <td class="Bill_H4">
                <asp:Label ID="AnnouncementTitleLabel" runat="server" 
                Text='<%# Eval("AnnouncementTitle") %>' />
                </td>
                </tr>
                <tr>
                <td style="font-style:italic; font-family:Verdana; font-size:8pt;">
                posted on:&nbsp;<asp:Label ID="AnnouncementDateLabel" runat="server" 
                Text='<%# Eval("AnnouncementDate", "{0:dd MMM yyyy}") %>' />
                <div style="float:right;">
                    <asp:Label ID="Label1" runat="server" Text='<%# AttachThis(Eval("AnnouncementId")) %>'></asp:Label></div>
                <div style="clear:both;"></div>
                </td>
                </tr>
                <tr>
                <td class="Bill_Text_Main" style="font-size:10pt">
                <br />
                <asp:Label ID="AnnouncementTextLabel" runat="server" 
                Text='<%# Billboard.BillboardFunctions.BillHtml(Eval("AnnouncementText")) %>' />
                </td>
                </tr>
            </table>
            <br />
            <br />
        </ItemTemplate>
    </asp:DataList>
    <asp:LinqDataSource ID="dsBillAnn" runat="server" 
        ContextTypeName="Billboard.BillboardDataContext" OrderBy="AnnouncementDate desc" 
        Select="new (ViewOrder, Sent, Visible, Current, AnnouncementText, AnnouncementDate, AnnouncementTitle, AnnouncementId)" 
        TableName="Agape_Billboard_Announcements" 
        Where="Sent == @Sent &amp;&amp; Current == @Current &amp;&amp; Visible == @Visible">
        <WhereParameters>
            <asp:Parameter DefaultValue="True" Name="Sent" Type="Boolean" />
            <asp:Parameter DefaultValue="False" Name="Current" Type="Boolean" />
            <asp:Parameter DefaultValue="True" Name="Visible" Type="Boolean" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:panel>
</div>