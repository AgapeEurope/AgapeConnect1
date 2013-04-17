<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveList.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveList.GiveList" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<style type="text/css">
    .GiveList .StaffImage
    {
        width: 75px;
        border-style: solid;
        border-color: #909090;
        border-width: thin;
        margin-right: 10px;
    }
    
    .GiveList  .StaffPanel
    {
        background-color: #EEE;
        margin: 1px;
        padding: 3px;
        width: 300px;
    }
    
    .GiveList  a .StaffPanel:hover
    {
        background-color: #CACACA;
    }
    .GiveList  .DataListPanel
    {
        width: 650px;
    }
</style>
<div align="left" style="font-size: 10pt;" class="GiveList">
    <div style="width: 700px; float: left;">
        <asp:DataList ID="dlGiveListStaff" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
            CellSpacing="7" RepeatLayout="Table" CssClass="DataListPanel">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GiveToURL(eval("GivingShortcut")) %>'>
                    <div class="StaffPanel">
                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image1" runat="server" CssClass="StaffImage" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhotoByFileId(Eval("StaffId"), Eval("JointPhoto"))%>' />
                                </td>
                                <td align="left" style="width: 100%">
                                    <div class="AgapeH5">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("DisplayName")%>'></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:HyperLink>
            </ItemTemplate>
        </asp:DataList>
        <asp:DataList ID="dlGiveListDept" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
            CellSpacing="7" RepeatLayout="Table" CssClass="DataListPanel">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GiveToURL(Eval("GivingShortcut"))%>'>
                    <div class="StaffPanel">
                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image1" runat="server" CssClass="StaffImage" ImageUrl='<%# StaffBrokerFunctions.GetDeptPhotoByFileId(Eval("PhotoId"))%>' /> 
                                </td>
                                <td align="left" style="width: 100%">
                                    <div class="AgapeH5">
                                        <asp:Label ID="Label2" runat="server" Text='<%# eval("Name") %>'></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:HyperLink>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <%--  <div style="float: right; font-size: 10pt;">
       <asp:textbox ID="TbSearch" runat="server"></asp:textbox>
    <asp:Button ID="btnSearch" runat="server" Text="Search" />
     </div> 
 --%>
  
</div>
