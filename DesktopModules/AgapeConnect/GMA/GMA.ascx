<%@ Control Language="VB" AutoEventWireup="False" CodeFile="GMA.ascx.vb" Inherits="DotNetNuke.Modules.GMA.GMA" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="/js/jquery.mousewheel.js"></script>
<script src="/js/jquery.numeric.js"></script>
<script type="text/javascript">

    (function ($, Sys) {
       
        function setUpMyTabs() {
            $('.aButton').button();

            //$('.dropdown-toggle').dropdown();
            $('.spinner').spinner({ min: 0 });
            $('.numeric').numeric();
            var selectedTabIndex = $('#<%= theHiddenTabIndex.ClientID  %>').attr('value');
            //alert(selectedTabIndex);
            $('#tabs').tabs({

                activate: function () {
                    
                    var newIdx = $('#tabs').tabs('option', 'active');
                    $('#<%= theHiddenTabIndex.ClientID  %>').val(newIdx);
                },
                active: selectedTabIndex
            });


        }

        $(document).ready(function () {
            setUpMyTabs();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();
            });
        });
    }(jQuery, window.Sys));


</script>
<style type="text/css">
    ul.nav li {
        list-style-type: none;
    }

    .spinner.ui-spinner-input {
        border: none;
        -moz-box-shadow: none;
        -webkit-box-shadow: none;
        box-shadow: none;
        -webkit-transition: none;
        -moz-transition: none;
        -o-transition: none;
        transition: none;
    }

    .pagination ul > li > a[disabled="disabled"] {

        background-color:rgb(221, 221, 221) ;
    }
    .brand {
display: block;
float: left;
padding: 10px 20px 10px;
margin-left: -20px;
font-size: 30px;
font-weight: 200;
color: #777;
text-shadow: 0 1px 0 #fff;
}
</style>

<asp:HiddenField ID="theHiddenTabIndex" runat="server" value="0" ViewStateMode="Enabled" />

<asp:HiddenField ID="hfNodeId" runat="server" Value="-1" />
<asp:HiddenField ID="hfURL" runat="server" Value="" />
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span2">
            <!--Sidebar content-->





            <asp:Repeater ID="rpGmaServers" runat="server">

                <HeaderTemplate>
                    <ul class="nav nav-list">
                </HeaderTemplate>
                <ItemTemplate>

                    <li class="nav-header">
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("name")  %>'></asp:Label>

                    </li>
                    <asp:Repeater ID="rpNodes" runat="server" DataSource='<%# Eval("nodes")  %>' OnItemCommand="rpNodes_ItemCommand">

                        <ItemTemplate>
                            <li <%# IIf(DataBinder.Eval(Container.DataItem, "nodeId") = hfNodeId.value, "class='active'", "")%>>
                                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("shortName")  %>' CommandName="nodeSelected" CommandArgument='<%# Eval("url") & ":::" & Eval("nodeId")  %>'></asp:LinkButton>


                            </li>

                        </ItemTemplate>

                    </asp:Repeater>
                </ItemTemplate>
                <FooterTemplate>
                    </ul>
                </FooterTemplate>
            </asp:Repeater>


        </div>
        <div class="span10">
            <!--Body content-->
            
           
                        <div class="container" style="width: auto;">
                            <div class="brand">ModU</div>
                        </div>
                 

            <div id="tabs">
                <!-- Only required for left/right tabs -->
                <ul >
                    <li><a href="#tab1" >Staff Reports</a></li>
                    <li><a href="#tab2">Director Reports</a></li>
                </ul>

                


                <div class="tab-content">
                    <div class="tab-pane active" id="tab1">
                        <div style="width:100%; text-align: center;">
                        <div class="pagination" style="margin-top:0;">

                                <ul>
                                    <li>
                                        <asp:LinkButton ID="lbPrevPeriod" runat="server">&laquo;</asp:LinkButton>
                                    </li>

                                    <li>
                                        <a style="padding: 0;">
                                        <asp:DropDownList ID="ddlPeriods" runat="server" DataTextField="LabelName" DataValueField="ReportId" AutoPostBack="true" style="margin: 0;"></asp:DropDownList>
                                            </a>

                                    </li>
                                    <li><asp:LinkButton ID="lbNextPeriod" runat="server">&raquo;</asp:LinkButton></li>
                                </ul>



                            </div>
                            </div>
                        <div class="row-fluid">

                            <asp:DataList ID="rpStaffMeasurements" runat="server" Width="100%" CssClass="form-horizontal">
                                <ItemTemplate>
                                    <div class="control-group">
                                        <div class="span4">

                                            <asp:Label ID="lblQuestion" runat="server" Font-Bold="True" Text='<%# Eval("measurementName")%>'></asp:Label>
                                        </div>
                                        <div class="span8">
 <asp:HiddenField ID="hfAnswerType" runat="server" Value='<%# Eval("measurementType") %>' />
                                            <asp:HiddenField ID="hfMeasurementId" runat="server" Value='<%# Eval("measurementId")%>' />
                                            <asp:TextBox ID="tbAnswer" runat="server" Text='<%# Eval("measurementValue")%>' CssClass='<%#IIf(Eval("measurementType") = "numeric", "spinner numeric", "")%>' Enabled='<%# Eval("measurementType") = "numeric"%>' Visible='<%# {"numeric", "calculated"}.Contains(Eval("measurementType"))%>' Width="50px"></asp:TextBox>
                                            <asp:TextBox ID="tbAnswerText" runat="server" Text='<%# Eval("measurementValue")%>'  Visible='<%# Eval("measurementType") = "text"%>' Width="160px" TextMode="MultiLine"></asp:TextBox>

                                        </div>
                                    </div>


                                </ItemTemplate>
                                <FooterTemplate>
                                    <div class="control-group">
                                        <div class="span4"></div>
                                        <div class="span8">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" CommandName="SaveReport" />
                                        </div>
                                    </div>
                                </FooterTemplate>
                            </asp:DataList>
                             

                        </div>
                        
                        

                    </div>


                    <div class="tab-pane" id="tab2">
                       
                        <div style="width:100%; text-align: center;">
                        <div class="pagination" style="margin-top:0;">

                                <ul>
                                    <li>
                                        <asp:LinkButton ID="lbPrevPeriodD" runat="server">&laquo;</asp:LinkButton>
                                    </li>

                                    <li>
                                        <a style="padding: 0;">
                                        <asp:DropDownList ID="ddlPeriodsD" runat="server" DataTextField="LabelName" DataValueField="ReportId" AutoPostBack="true" style="margin: 0;"></asp:DropDownList>
                                            </a>

                                    </li>
                                    <li><asp:LinkButton ID="lbNextPeriodD" runat="server">&raquo;</asp:LinkButton></li>
                                </ul>



                            </div>
                            </div>
                        <div class="row-fluid">

                            <asp:DataList ID="rpDirectorMeasuremts" runat="server" Width="100%" CssClass="form-horizontal">
                                <ItemTemplate>
                                    <div class="control-group">
                                        <div class="span4">

                                            <asp:Label ID="lblQuestion" runat="server" Font-Bold="True" Text='<%# Eval("measurementName")%>'></asp:Label>
                                        </div>
                                        <div class="span8">
                                            <asp:HiddenField ID="hfAnswerType" runat="server" Value='<%# Eval("measurementType") %>' />
                                            <asp:HiddenField ID="hfMeasurementId" runat="server" Value='<%# Eval("measurementId")%>' />
                                            <asp:TextBox ID="tbAnswer" runat="server" Text='<%# Eval("measurementValue")%>' CssClass='<%#IIf(Eval("measurementType") = "numeric", "spinner numeric", "")%>' Enabled='<%# Eval("measurementType") = "numeric"%>' Visible='<%# {"numeric", "calculated"}.Contains(Eval("measurementType"))%>' Width="50px"></asp:TextBox>
                                            <asp:TextBox ID="tbAnswerText" runat="server" Text='<%# Eval("measurementValue")%>'  Visible='<%# Eval("measurementType") = "text"%>' Width="160px" TextMode="MultiLine"></asp:TextBox>

                                        </div>
                                    </div>


                                </ItemTemplate>
                                <FooterTemplate>
                                    <div class="control-group">
                                        <div class="span4"></div>
                                        <div class="span8">
                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn" CommandName="SaveReport" />
                                        </div>
                                    </div>
                                </FooterTemplate>
                            </asp:DataList>
                           




                    </div>
                </div>
            </div>











        </div>
    </div>
</div>
<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>