<%@ Control Language="VB" AutoEventWireup="false" CodeFile="List1.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.Stories.List1" %>
<script src="/js/jquery.nivo.slider.js" type="text/javascript"></script>
<link href="/DesktopModules/AgapeConnect/Stories/themes/default/default.css" rel="stylesheet" type="text/css" media="screen" />
<link href="/js/nivo-slider.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyTabs() {


            $(".tagFilter").click(function () {
                var querystring="";
                $(".tagFilter input:checked").each(function(){
                    querystring += $(this).next().text() + ",";

                });
              
                window.location.href = "<%= NavigateURL() & "?tags="%>" + querystring;
            });




        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    }(jQuery, window.Sys));


    function registerClick(c, l) {
        $.ajax({
            type: 'POST', url: "<%= NavigateURL() %>",
            data: ({ StoryLink: c })
        });
        var target = "_blank"
        if (l.indexOf("<%= PortalSettings.DefaultPortalAlias %>") >= 0)
            target = "_self"

        window.open(l, target);

    }

</script>

<style type="text/css">
    .seachImage {
        width: 150px;
        border: 1pt solid black;
        margin-right: 5px;
    }

    .dnnGridItem:hover, .dnnGridAltItem:hover {
        border: 2px solid Blue;
    }

    .dnnGridItem, .dnnGridAltItem {
        border: 2px inset transparent;
    }

    .mynavbar-inner {
        min-height: 30px;
        padding-right: 20px;
        padding-left: 20px;
        padding-top: 5px;
        background-color: #fafafa;
        background-image: -moz-linear-gradient(top, #ffffff, #f2f2f2);
        background-image: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff), to(#f2f2f2));
        background-image: -webkit-linear-gradient(top, #ffffff, #f2f2f2);
        background-image: -o-linear-gradient(top, #ffffff, #f2f2f2);
        background-image: linear-gradient(to bottom, #ffffff, #f2f2f2);
        background-repeat: repeat-x;
        border: 1px solid #d4d4d4;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffffff', endColorstr='#fff2f2f2', GradientType=0);
        -webkit-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
        -moz-box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
        box-shadow: 0 1px 4px rgba(0, 0, 0, 0.065);
    }

    .mynavbar-search .search-query {
        padding: 4px 14px;
        margin-bottom: 0;
        font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-size: 13px;
        font-weight: normal;
        line-height: 1;
        -webkit-border-radius: 15px;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }
</style>




<asp:Repeater ID="dlFilter" runat="server">
    <HeaderTemplate>
        <div class="mynavbar-inner">

            <div class="pull-left">
            </div>
            <div class="row-fluid ">
                <div class="span2">
                    <strong>Filter:</strong>
                </div>
    </HeaderTemplate>
    <ItemTemplate>
        <div class="span2">
          
                <asp:CheckBox ID="cbFilter" runat="server" CssClass="tagFilter" Text='<%# Eval("TagName") %>' Checked='<%# Request.QueryString("tags").Split(",").Contains(Eval("TagName"))%>' />
        
        </div>

    </ItemTemplate>
    <FooterTemplate>
        </div>
</div>
    </FooterTemplate>
</asp:Repeater>








<asp:DataList runat="server" ID="dlStories" AllowPaging="true" BorderStyle="None" CellSpacing="4" CellPadding="4" ShowHeader="False" GridLines="None" PagerStyle-Visible="false">
    <ItemStyle CssClass="dnnGridItem" HorizontalAlign="Left" VerticalAlign="Top" />
    <AlternatingItemStyle CssClass="dnnGridAltItem" />
    <FooterStyle CssClass="dnnGridFooter" />
    <ItemTemplate>

        <asp:HyperLink ID="lnkLink" runat="server" CssClass="CommandButton" NavigateUrl='<%# "javascript: registerClick(" & DataBinder.Eval(Container.DataItem, "CacheId") & ", """ &   CStr(DataBinder.Eval(Container.DataItem, "Link")) & """); "%>'>

            <table>
                <tr valign="top">
                    <td>
                        <asp:Image ID="imgImage" runat="server" ImageUrl='<%# Eval("ImageId")  %>' CssClass="seachImage" />


                    </td>

                    <td width="100%">
                        <asp:Label ID="HyperLink1" runat="server" CssClass="AgapeH4" Style="font-size: medium" Text='<%# Eval("Headline")%>' />

                        <br />

                        <asp:Panel ID="Panel1" runat="server" CssClass="Agape_Story_subtitle">
                            <asp:Label ID="Label5" runat="server" CssClass="Normal" Font-Size="small" Text='<%# GetStoryDateString(Eval("StoryDate"), Eval("GUID"), Eval("Link"))%>' />

                            <br />
                        </asp:Panel>

                        <asp:Label ID="Label3" runat="server" CssClass="Normal" Text='<%# Eval("Description") + "<br>"%>' />

                    </td>
                </tr>
            </table>



        </asp:HyperLink>


    </ItemTemplate>

</asp:DataList>