<%@ Control Language="VB" AutoEventWireup="false" CodeFile="List1.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.Stories.List1" %>
<script src="/js/jquery.nivo.slider.js" type="text/javascript"></script>
<link href="/DesktopModules/AgapeConnect/Stories/themes/default/default.css" rel="stylesheet" type="text/css" media="screen" />
<link href="/js/nivo-slider.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript">
    (function ($, Sys) {
        function setUpMyTabs() {







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
        var target="_blank"
        if( l.indexOf("<%= PortalSettings.DefaultPortalAlias %>")>=0)
            target="_self"

        window.open(l, target);
        
   }

</script>

<style type="text/css">
   .seachImage {
        width: 80px;
        border: 1pt solid black;
    }
    .dnnGridItem:hover, .dnnGridAltItem:hover  {
        border: 2px solid Blue;
    }
    .dnnGridItem, .dnnGridAltItem {
        border: 2px solid transparent;
    }

</style>



<asp:DataList runat="server" ID="dlStories" AllowPaging="true" BorderStyle="None" CellSpacing="1"  ShowHeader="False" GridLines="None" PagerStyle-Visible="false">
    <ItemStyle CssClass="dnnGridItem" HorizontalAlign="Left" VerticalAlign="Top"  />
        <AlternatingItemStyle CssClass="dnnGridAltItem" />
        <FooterStyle CssClass="dnnGridFooter" />
    <ItemTemplate>

        <asp:HyperLink ID="lnkLink" runat="server" CssClass="CommandButton"  NavigateUrl='<%# "javascript: registerClick(" & DataBinder.Eval(Container.DataItem, "CacheId") & ", """ &   CStr(DataBinder.Eval(Container.DataItem, "Link")) & """); "%>'   >
          	   
            <table>
                <tr valign="top">
                    <td>
                        <asp:Image ID="imgImage" runat="server" ImageUrl='<%# Eval("ImageId")  %>' CssClass="seachImage" />


                    </td>

                    <td width="100%">
                        <asp:Label ID="HyperLink1" runat="server" CssClass="AgapeH4" Text='<%# Eval("Headline")%>' />
                        
                        <br />

                        <asp:Panel ID="Panel1" runat="server" CssClass="Agape_Story_subtitle" >
                           <asp:Label ID="Label5" runat="server" CssClass="Normal" Text='<%# Eval("StoryDate")%>'  />


                            <br />
                        </asp:Panel>

                        <asp:Label ID="Label3" runat="server" CssClass="Normal" Text='<%# Eval("Description") + "<br>"%>' />

                    </td>
                </tr>
            </table>



        </asp:HyperLink>


    </ItemTemplate>

</asp:DataList>