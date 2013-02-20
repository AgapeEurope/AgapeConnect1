<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Setting_ManagerList.ascx.cs" Inherits="DNNGo.Modules.DNNGallery.Setting_ManagerList" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<div class="article_list_setting">
    <div class="search_article">
        <h2 class="setting_page_title"><%=ViewTitle("lblSearchContentTitle", "Search Content")%></h2>
        <table width="600" id="tbControl" runat="server">
            <tr>
                <td >
                    <div class="form_field">
                        <h4><%=ViewTitle("lblTitle", "Title", "txtTitle")%>:</h4>
                        <asp:TextBox ID="txtTitle" runat="server" Width="150px" CssClass="input_text"> </asp:TextBox>
                        <asp:Button ID="lbSearch" runat="server" CssClass="input_button" resourcekey="lbSearch"
                        OnClick="lbSearch_Click"></asp:Button>
                        <asp:Button ID="lbCancel" runat="server" CssClass="input_button" resourcekey="lbCancel"
                        OnClick="lbCancel_Click"></asp:Button>
                    </div>
                </td>
            </tr>
    
        </table>
    </div>
    <div class="article_list">
        <h2 class="setting_page_title"><%=ViewTitle("lblContentListTitle", "Content List")%></h2>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <dnn:PagingControl ID="ctlPagingControl2" Width="100%" runat="server"></dnn:PagingControl>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvArticleList" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvArticleList_RowDataBound"
                        Width="100%" CellPadding="0" cellspacing="0" border="0" CssClass="table table-bordered table-striped"  GridLines="none" >
                        <RowStyle CssClass="td_row" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" HeaderStyle-Width="50" /> 
                            <asp:BoundField DataField="Title" HeaderText="Title" /> 
                             <asp:TemplateField HeaderText="Picture" HeaderStyle-Width="110">
                                <ItemTemplate>
                                     <asp:Image ID="imgPicture" runat="server" style="max-width:100px; max-height:100px;" />  
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="LastTime" HeaderText="Time"  HeaderStyle-Width="120" /> 
                            <asp:BoundField DataField="LastUser" HeaderText="User" HeaderStyle-Width="50" /> --%>
                            <asp:BoundField DataField="Status" HeaderText="Status" HeaderStyle-Width="50" /> 
                            <asp:TemplateField HeaderText="Sort" HeaderStyle-Width="80">
                                <ItemTemplate>
                                       <asp:ImageButton CssClass="CommandButton" ID="imgbutUp"  
                                            runat="server" ImageUrl="~/images/up.gif" OnClick="ImgbutSort_Click" BorderStyle="none"  />
                                        &nbsp;&nbsp;
                                       <asp:ImageButton CssClass="CommandButton" ID="imgbutDn"  
                                            runat="server" ImageUrl="~/images/dn.gif" OnClick="ImgbutSort_Click" BorderStyle="none"   />
                                        </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action" HeaderStyle-Width="80">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbEdit" runat="server" ToolTip="Edit" OnCommand="imbEdit_Command"
                                                    ImageUrl="~/images/edit.gif" />
                                    <asp:ImageButton ID="imbDelete" runat="server" ToolTip="Delete" OnCommand="imbDelete_Command"
                                                    ImageUrl="~/images/delete.gif" />
                                    
                                </ItemTemplate>
                                <HeaderStyle></HeaderStyle>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings Visible="False" />
                        <FooterStyle  />
                        <PagerStyle  />
                        <SelectedRowStyle  />
                        <HeaderStyle  />
                        <AlternatingRowStyle CssClass="alternating_row"  />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <dnn:PagingControl ID="ctlPagingControl" Width="100%" runat="server"></dnn:PagingControl>
                </td>
            </tr>
        </table>
    </div>
</div>
