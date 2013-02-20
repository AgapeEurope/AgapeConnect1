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
function gvChangePanel(linkId) {
    var thisLink = linkId;
    $('.gvOnSite' + thisLink).hide();
    $('.gvOffSite' + thisLink).hide();
    if ($('.gvDdl' + thisLink).val() == 0) {
        $('.gvOnSite' + thisLink).css({ 'display': 'inline', 'width': 200 });
        $('.gvOffSite' + thisLink).hide();
    }
    else {
        $('.gvOnSite' + thisLink).hide();
        $('.gvOffSite' + thisLink).css({ 'display': 'inline', 'width': 200 });
    }
}
</script>
<style type="text/css">
    .gvSelector {
        display: inline;
        width: 100px !important;
    }

    .gvTextBox {
        display: inline;
        width: 200px !important;
    }
</style>
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
            <asp:Button ID="btnUploadLink" runat="server" Text="Add Link" Style="display: none;" />
            <asp:Label ID="lblError" runat="server" Style="color: red;" Visible="false"></asp:Label>
        </fieldset>
        <br />
        <asp:GridView ID="gvLinks" runat="server" AutoGenerateColumns="False" DataSourceID="dsLinks">
            <Columns>
                <asp:TemplateField HeaderText="Sort Order" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButtonTest" CausesValidation="False" Enabled='<%# upEnabled(Eval("SortOrder"))%>' runat="server" CommandArgument='<%#Eval("StaffLinkId")%>' CommandName="Promote">
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# upOrGrey(Eval("SortOrder")) %>' Width="15px" />
                        </asp:LinkButton>
                        <asp:LinkButton ID="LinkButtonTest2" CausesValidation="False" Enabled='<%# dnEnabled(Eval("SortOrder"))%>' runat="server" CommandArgument='<%#Eval("StaffLinkId")%>' CommandName="Demote">
                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# dnOrGrey(Eval("SortOrder")) %>' Width="15px" />
                        </asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Link Name" SortExpression="LinkName">
                    <EditItemTemplate>
                        <asp:TextBox ID="tbLinkName" runat="server" Text='<%# Eval("LinkName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("LinkName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-Width="350px" HeaderText="Link URL" ItemStyle-Width="400px" ItemStyle-Wrap="True" SortExpression="LinkURL">
                    <EditItemTemplate>
                        <asp:HiddenField ID="hfLinkId" runat="server" Value='<%# Eval("StaffLinkId") %>' />
                        <asp:DropDownList ID="gvDdlChoice" runat="server" CssClass='<%# "gvSelector gvDdl" & Eval("StaffLinkId") %>' onchange='<%# "gvChangePanel(" & Eval("StaffLinkId") & "); return false;"%>' SelectedValue='<%#gvSiteChoice(Eval("StaffLinkId"))%>'>
                            <asp:ListItem Value="0">On Site</asp:ListItem>
                            <asp:ListItem Value="1">Not On Site</asp:ListItem>
                        </asp:DropDownList>
                        <div class='<%# "gvOnSite" & Eval("StaffLinkId")%>' style='<%# isOnSite(Eval("StaffLinkId"))%>'>
                            <asp:DropDownList ID="gvDdlOnSite" runat="server" AppendDataBoundItems="True" CssClass="gvTextBox" DataSourceID="dsPages" DataTextField="TabName" DataValueField="TabID" SelectedValue='<%# Eval("TabId") %>' Width="200px">
                                <asp:ListItem Value="-5">Not Selected</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class='<%# "gvOffSite" & Eval("StaffLinkId")%>' style='<%# isOffSite(Eval("StaffLinkId"))%>'>
                            <asp:TextBox ID="gvTbOffSite" runat="server" CssClass="gvTextBox" Text='<%# Eval("LinkURL") %>' Width="200px"></asp:TextBox>
                        </div>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" CssClass="gvSelector" Text='<%# IsItSite(Eval("StaffLinkId")) %>'></asp:Label>
                        <asp:Label ID="Label1" runat="server" CssClass="gvTextBox" Text='<%# outputURL(Eval("StaffLinkId"))%>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="400px" />
                    <ItemStyle Width="400px" Wrap="True" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="New Window" SortExpression="NewWindow">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("NewWindow") %>' Enabled="false" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="cbNewWindow" runat="server" Checked='<%# Eval("NewWindow")%>' Enabled="true" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CausesValidation="False" CommandName="MyUpdate" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        <asp:Label ID="lblUpdateError" runat="server" visible="false" ForeColor="red"></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton><br />
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("StaffLinkId") %>' CausesValidation="False" CommandName="MyDelete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblGVError" runat="server" ForeColor="Red" Visible="false"></asp:Label>
        <asp:LinqDataSource ID="dsLinks" runat="server" ContextTypeName="UK.StaffLink.StaffLinkDataContext" EntityTypeName="" Select="new (LinkName, LinkURL, NewWindow, StaffLinkId, SortOrder, TabId)" TableName="Agape_Staff_Links" EnableDelete="True" EnableInsert="True" EnableUpdate="True" OrderBy="SortOrder">
        </asp:LinqDataSource>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnUploadLink" />
        <asp:PostBackTrigger ControlID="gvLinks" />
    </Triggers>
</asp:UpdatePanel>
