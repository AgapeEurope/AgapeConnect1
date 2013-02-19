<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StaffLinksAdmin.ascx.vb" Inherits="DotNetNuke.Modules.StaffLinks.StaffLinks" %>
<script type="text/javascript">
    (function ($, Sys) {
        function setUpPage() {
            $('.aButton').button();
            $('#onSite').show();
            $('#offSite').hide();
            $('#lblNoText').hide();
            $('#lblNoURL').hide();
        }
        $(document).ready(function () {
            setUpPage();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpPage();
            });
        });
    }(jQuery, window.Sys));
    function choiceMade() {
        var choice = $('.ddlSiteChoice').val();
        if (choice == 1) {
            $('#onSite').show();
            $('#offSite').hide();
        }
        else {
            $('#onSite').hide();
            $('#offSite').show();
        }
    }
    function testUp() {
        $('#lblNoText').hide();
        $('#lblNoURL').hide();
        if ($('.tbLinkName').val() == '') {
            $('#lblNoText').show();
            return false;
        }
        else if ($('.ddlSiteChoice').val() == 2 && $('.tbPageURL').val() == '') {
            $('#lblNoURL').show();
            return false;
        }
        else {
            __doPostBack('<%= btnUploadLink.UniqueID %>', '');
        }
}
</script>
<asp:HiddenField ID="hfPortalId" runat="server" />
<asp:UpdatePanel ID="upAll" runat="server">
    <ContentTemplate>
        <fieldset>
            <legend class="Agape_Orange_H4">Add New Link for Staff Menu</legend>
            <table>
                <tr>
                    <td>
                        <label id="lblLinkName" class="Agape_Blue_H5">Link Name:</label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbLinkName" runat="server" Width="200px" CssClass="tbLinkName"></asp:TextBox>
                    </td>
                    <td>
                        <div style="color: red;" id="lblNoText">*You have to have some text for the link name.</div>
                    </td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">
                        <label id="lblLink" class="Agape_Blue_H5">Link:</label>
                    </td>
                    <td>
                        <select runat="server" class="ddlSiteChoice" id="ddlSiteChoice" onchange="choiceMade(); return false;">
                            <option value="1">Page On Site</option>
                            <option value="2">Page Off Site</option>
                        </select>
                        <div id="onSite">
                            <fieldset>
                                <legend>On Site</legend>
                                <asp:DropDownList ID="ddlSitePageList" runat="server" Width="200px" DataSourceID="dsPages" DataTextField="TabName" DataValueField="TabID"></asp:DropDownList>
                                <asp:LinqDataSource ID="dsPages" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" OrderBy="TabOrder" Select="new (TabID, TabName)" TableName="Tabs" Where="PortalID == @PortalID &amp;&amp; IsDeleted == @IsDeleted &amp;&amp; IsVisible == @IsVisible &amp;&amp; IsSecure == @IsSecure">
                                    <WhereParameters>
                                        <asp:ControlParameter ControlID="hfPortalId" Name="PortalID" PropertyName="Value" Type="Int32" />
                                        <asp:Parameter DefaultValue="False" Name="IsDeleted" Type="Boolean" />
                                        <asp:Parameter DefaultValue="True" Name="IsVisible" Type="Boolean" />
                                        <asp:Parameter DefaultValue="False" Name="IsSecure" Type="Boolean" />
                                    </WhereParameters>
                                </asp:LinqDataSource>
                            </fieldset>
                        </div>
                        <div id="offSite">
                            <fieldset>
                                <legend>Off Site</legend>
                                <asp:TextBox ID="tbPageURL" runat="server" Width="200px" CssClass="tbPageURL" Text="http://"></asp:TextBox>
                            </fieldset>
                        </div>
                    </td>
                    <td>
                        <div id="lblNoURL" style="color: red;">*You have to have a valid URL entered.</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="Agape_Blue_H5">Open in new window?</label>
                    </td>
                    <td colspan="2">
                        <asp:CheckBox ID="cbNewWindow" runat="server" />
                    </td>
                </tr>
            </table>
            <br />
            <input type="button" class="aButton" id="btnPreUpload" value="Add Link" onclick="testUp(); return false;" />
            <asp:Button ID="btnUploadLink" runat="server" Text="Add Link" style="display:none;" />
            <asp:Label ID="lblError" runat="server" style="color:red;" Visible="false"></asp:Label>
        </fieldset><br />
        <asp:GridView ID="gvLinks" runat="server" AutoGenerateColumns="False" DataSourceID="dsLinks">
            <Columns>
                <asp:TemplateField HeaderText="Sort Order"></asp:TemplateField>
                <asp:BoundField DataField="LinkName" HeaderText="Link Name" ReadOnly="True" SortExpression="LinkName" />
                <asp:TemplateField HeaderText="Link URL" SortExpression="LinkURL">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("LinkURL") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# IsItSite(Eval("StaffLinkId")) %>'></asp:Label><asp:Label ID="Label1" runat="server" Text='<%# outputURL(Eval("StaffLinkId"))%>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="NewWindow" HeaderText="New Window" ReadOnly="True" SortExpression="NewWindow" />
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="MyUpdate" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton><br />
                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="MyDelete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:LinqDataSource ID="dsLinks" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" Select="new (LinkName, LinkURL, NewWindow, StaffLinkId, SortOrder, TabId)" TableName="Agape_Staff_Links" EnableDelete="True" EnableInsert="True" EnableUpdate="True" OrderBy="SortOrder">
        </asp:LinqDataSource>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnUploadLink" />
        <asp:PostBackTrigger ControlID="gvLinks" />
    </Triggers>
</asp:UpdatePanel>
