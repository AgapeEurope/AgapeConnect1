<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_Effects.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_Effects" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<h2 class="setting_page_title"><%=ViewTitle("lblModuleTitle", "Effect List")%></h2>
<div class="form_field">
    <asp:TextBox ID="txtTitle" runat="server" Width="180px" CssClass="input_text"></asp:TextBox>
    <asp:Button ID="lbSearch" runat="server" CssClass="input_button2" resourcekey="lbSearch"
                OnClick="lbSearch_Click"></asp:Button>
</div>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td>
            <asp:GridView ID="gvEffectList" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvEffectList_RowDataBound"
                Width="100%" CellPadding="0"  GridLines="none" cellspacing="0" border="0" CssClass="table table-bordered table-striped">
                <RowStyle CssClass="Normal" />
                <Columns>
                     <asp:TemplateField HeaderText="Effect Information">
                        <ItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td rowspan="3" style=" width:350px;  padding:0px 10px 0px 0px; background:none; border:none;">
                                         <asp:Image runat="server" style="width:350px;" ID="imgPicture" />
                                    </td>
                                    <td style="background:none; padding:0px; border:none;">
                                        <asp:Label runat="server" ID="labName" Font-Bold="true"></asp:Label> &nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:HyperLink ID="hlThemeName" runat="server" ></asp:HyperLink>  
                                     </td>
                                </tr>
                                <tr>
                                    <td style="background:none; padding:0px; border:none;"><asp:Label runat="server" ID="labDescription"></asp:Label></td>
                                 
                                </tr>
                                 <tr>
                                    <td style="background:none; padding:0px; border:none;">
                                        <asp:Label runat="server" ID="labVersion"></asp:Label> 
                                          &nbsp;&nbsp;&nbsp;&nbsp;
                                          <asp:Literal runat="server" ID="LiDemoUrl"></asp:Literal>
                                         
                                       
                                    </td>
                                </tr>
                                 
                            </table>
                        </ItemTemplate>
                        <HeaderStyle></HeaderStyle>
                    </asp:TemplateField>
                    
                     <asp:TemplateField HeaderText="Action"  HeaderStyle-Width="120">
                        <ItemTemplate>
                            <asp:LinkButton CssClass="CommandButton" ID="btnApply" runat="server" BorderStyle="none" Text="Apply Effect"  OnClick="btnApply_Click"></asp:LinkButton>
                            <%--<asp:ImageButton ID="imbEdit" runat="server" ToolTip="Edit" OnCommand="imbEdit_Command" ImageUrl="~/images/edit.gif" />--%>
                        </ItemTemplate>
                        <HeaderStyle ></HeaderStyle>
                    </asp:TemplateField>
                </Columns>
                <PagerSettings Visible="False" />
                <FooterStyle  />
                <PagerStyle  />
                <SelectedRowStyle  />
                <HeaderStyle  />
            </asp:GridView>

            <div class="full_version_title" id="full_version_title" runat="server" visible="false">
                 <%=ViewTitle("lblFullVersionTitle", "The module you are using is just a single effect version.")%> <br/>
                 <%=ViewTitle("lblFullVersionContent", "If you need more effects,Please purchase the <a href='http://www.dnngo.net/DNNStore/tabid/58/CategoryID/105/List/0/Level/a/ProductID/468/Default.aspx' target='_blank'>DNNGo.DNNGallery</a> to own all amazing effects!")%>
             </div>
        </td>
    </tr>
    <tr>
        <td>
            <dnn:PagingControl ID="ctlPagingControl" Width="100%" runat="server"  Visible="false"></dnn:PagingControl>
        </td>
    </tr>
</table>
