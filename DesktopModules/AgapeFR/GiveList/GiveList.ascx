<%@ Control Language="VB" AutoEventWireup="false" CodeFile="GiveList.ascx.vb" Inherits="DotNetNuke.Modules.AgapeFR.GiveList.GiveList" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="cc2" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Src="../GiveInfo/GiveInfo.ascx" TagName="frGiveInfo" TagPrefix="uc1" %>
<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<style type="text/css">
    .StaffImage
    {
        width: 75px;
        border-style: solid;
        border-color: #909090;
        border-width: thin;
        margin-right: 10px;
    }
    
    .StaffPanel
    {
        background-color: #EEE;
        margin: 1px;
        padding: 3px;
        width: 300px;
    }
    
    a .StaffPanel:hover
    {
        background-color: #CACACA;
    }
    .DataListPanel
    {
        width: 650px;
    }
    .LastName
    {
        text-transform: uppercase;
        margin-bottom: 2px;
    }
</style>
<div align="left" style="font-size: 10pt;">
    <div style="width: 700px; float: left;">
        <asp:DataList ID="dlGiveListStaff" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
            CellSpacing="7" RepeatLayout="Table" CssClass="DataListPanel">
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GiveToURL(eval("StaffId")) %>'>
                    <div class="StaffPanel">
                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image1" runat="server" CssClass="StaffImage" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(eval("StaffId")) %>' />
                                </td>
                                <td align="left" style="width: 100%">
                                    <div class="AgapeH4 LastName">
                                        <asp:Label ID="Label2" runat="server" Text='<%# eval("User.LastName") %>'></asp:Label>
                                    </div>
                                    <div>
                                        <asp:Label ID="Label1" runat="server" CssClass="FirstName" Text='<%# getFirstNames(Eval("StaffId")) %>'></asp:Label>
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
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# GiveToURL(eval("CostCenterID")) %>'>
                    <div class="StaffPanel">
                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image1" runat="server" CssClass="StaffImage" ImageUrl='<%#   GetPhotoURL(Eval("PhotoId")) %>' /> 
                                </td>
                                <td align="left" style="width: 100%">
                                    <div class="AgapeH4 LastName">
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
    <div style="float: right; font-size: 10pt;">
        <div>
            <uc1:frGiveInfo ID="FrGiveInfo1" runat="server" />
        </div>
    </div> --%>
  
</div>
