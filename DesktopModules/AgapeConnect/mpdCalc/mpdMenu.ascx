<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdMenu.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdMenu" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/staffTreeview.ascx" TagPrefix="uc1" TagName="staffTreeview" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/BudgetTile.ascx" TagPrefix="uc1" TagName="BudgetTile" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/MenuDetail.ascx" TagPrefix="uc1" TagName="MenuDetail" %>





<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">


    (function ($, Sys) {



        $(document).ready(function () {
            $('.numeric').numeric();


            $('.aButton').button();
            $("#accordion").accordion({
                header: "> div > h3",
                navigate: false
            });

            $('.sLevel').each(function (c) {
                console.log($(this).attr("data-value"));
                $('.' + $(this).attr("data-value")).text(' (' + $(this).text() + ')');
            });

            <%= IIf(IsEditable, " $('.myTab').hide();", "")%>
           

           
        });

    }(jQuery, window.Sys));








</script>
<style type="text/css">
    .detail-button {
        font-size: large;
        margin-bottom: 5px;
        padding: 10px;
    }
    .AcPane {
        height: 280px;
    }

    .mpd-year {
        margin-top: 10px;
    }

    .mpd-menu-tvtitle {
        font-size: large;
        font-weight: bold;
        font-style: italic;
    }

    .alert-expired {
        color: #999999;
        background-color: #EEEEEE;
        border-color: #DDDDDD;
    }

        .alert-expired h4 {
            color: #999999;
        }

    a .tile:hover {
        border-width: 3px;
    }

    .nav li {
        list-style: none;
    }
    .tile {
        width:83%;
       
    }
       
</style>



<div class="container-fluid">

    <div class="tabbable tabs-left">
        <ul class="nav nav-tabs">
            <li class="active">

                <a id="myTabTitle" href="#myTab<%= StaffId %>"  data-toggle="tab" class="myTab">
                    Your MPD Budgets

                </a>
            </li>
            <asp:Repeater ID="rpTeam" runat="server">
                <ItemTemplate>
                    <li>

                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "#Tab" & Eval("StaffId")%>' data-toggle="tab">

                            <asp:Label ID="lblDisplayName" runat="server" Text='<%# Eval("DisplayName")%>'  ></asp:Label>
                            <asp:Label ID="lblSupportlevel" runat="server"  CssClass='<%# "sl" & Eval("StaffId")%>'></asp:Label>
                        <asp:HiddenField ID="hfStaffId" runat="server" Value='<%# Eval("StaffId")%>' />
                        </asp:HyperLink>
                    </li>
                </ItemTemplate>
            </asp:Repeater>

        </ul>
        <div class="tab-content">
            <div class="tab-pane active myTab" id="myTab<%= StaffId %>">
                         <uc1:MenuDetail runat="server" ID="myMenuDetail"   />
                    </div>
            <asp:Repeater ID="rpMenuDetail" runat="server">
                <ItemTemplate>
                    <asp:Literal ID="Literal1" runat="server" Text='<%# "<div id=""Tab" & Eval("StaffId") & """  class=""tab-pane"">"%>'></asp:Literal>
                   
                        
                
                    <uc1:MenuDetail runat="server" ID="MenuDetail" MpdDefId='<%# mpdDefId%>' PortalId='<%#PortalId %>' EditUrl='<%#EditUrl("mpdCalc") %>'   DisplayName='<%# Eval("DisplayName")%>'   StaffId='<%# Eval("StaffId")%>' />
                    
                    
                    
                    </div>
                    


                </ItemTemplate>
            </asp:Repeater>



        </div>
    </div>







</div>
</div>






<div style="clear: both;"></div>
<div class="row-fluid">
    <div class="span4">
    </div>
    <div class="span8">
        <div class="well">
            This section will contain useful information on:
            <ul>
                <li><b>YouTube video walkthough</b> - how to submit a budget</li>
                <li><b>Why Budget?</b> (video or short motivational text)</li>
                <li><b>MPD tips</b> - links to several of the best MPD resources</li>
                <li>Possibly an <b>MPD dashboard</b>, showing actual versus budget graphs for your personal R/C (or for members of your team)</li>
            </ul>

        </div>
        <div class="alert alert-info">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            <strong>Heads up!</strong>
            <asp:Label ID="lblEditMode" runat="server" Text="Label"> You are currently in Edit Mode. This allows you to edit/process other people's budgets and customise the MPD budget Form.
                To return to normal mode, select "View Mode" (top right).
            </asp:Label>
            <asp:Label ID="lblViewMode" runat="server" Text="Label"> You are currently in View Mode - what you see is exaclty what your users will see. 
                 If you want to edit/process other people's budgets or edit the MPD form, you will need to be in "Edit Mode" top right.
            </asp:Label>

        </div>
    </div>
</div>



