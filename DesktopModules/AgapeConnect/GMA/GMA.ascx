<%@ Control Language="VB" AutoEventWireup="False" CodeFile="GMA.ascx.vb" Inherits="DotNetNuke.Modules.GMA.GMA" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">

    (function ($, Sys) {
        function setUpMyTabs() {


            $('.dropdown-toggle').dropdown()

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
</style>

<asp:HiddenField ID="hfNodeId" runat="server" Value="-1" />
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span2">
            <!--Sidebar content-->

            


            <asp:Repeater ID="rpGmaServers" runat="server" >

                <HeaderTemplate>
                    <ul class="nav nav-list" >
                </HeaderTemplate>
                <ItemTemplate>
                     
                    <li class="nav-header">
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("name")  %>' ></asp:Label>
                       
                    </li >
                      <asp:Repeater ID="rpNodes" runat="server" DataSource='<%# Eval("nodes")  %>'    >

                            <ItemTemplate>
                                 <li <%# IIf(DataBinder.Eval(Container.DataItem, "nodeId") = hfNodeId.value, "class='active'", "")%> >
                                   <a href="#"> <asp:Label ID="Label2" runat="server" Text='<%# Eval("shortName")  %>'></asp:Label></a>
                       
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
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
          
            <div id="navbar-example" class="navbar navbar-static">
              <div class="navbar-inner">
                <div class="container" style="width: auto;">
                  <a class="brand" href="#">ModU</a>
                  <ul class="nav" role="navigation">
                   <li class="active"><a href="#">Staff Reports</a></li>
      <li><a href="#">Director Reports</a></li>
                  </ul>


                   <div class="pagination pull-right">
  <ul>
    <li><a href="#">&laquo;</a></li>
  
    <li><a href="#">1 May 13 to 31 May 13</a></li>
    <li><a href="#" class="disabled">&raquo;</a></li>
  </ul>
</div>

                
                </div>
              </div>
            </div>

        </div>
    </div>
</div>
