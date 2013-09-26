<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdDashboard.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdDashboard" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("visualization", "1", { packages: ["corechart"] });
        google.load('visualization', '1', { 'packages': ['geochart'] });
       
        google.setOnLoadCallback(drawChart);

     

        function drawChart() {


       


            var data3 = google.visualization.arrayToDataTable([
         ['Country', 'MPD Level'],
         ['Germany', 120],
         ['United States', 96],
         ['Brazil', 25],
         ['Canada', 82],
         ['France', 67],
         ['RU', 43],
         <%= jsonMap %>
            ]);

            var options3 = {enableScrollWheel: true, colors: ['#FF0000', '#ff9b00', '#00FF00'], colorAxis: { minValue:50, maxValue: 110 } };

            var chart3 = new google.visualization.GeoChart(document.getElementById('mapchart'));

            google.visualization.events.addListener(chart3, "regionClick", function (eventData) {
                var countryISO2 = eventData["region"];
                window.location.href = '<%= EditUrl("countryDashboard") & "?country=" %>' + countryISO2;


            });

            chart3.draw(data3, options3);
            

        }

        $(function () {
            $('.countryRow').click(function (c) {
                var iso = $(this).find("input").val();
               
                window.location.href = '<%= EditUrl("countryDashboard") & "?country=" %>' + iso;
            });

        });
    </script>
<i>For this demo, please click on UK - as this is the only country with test data:</i>

<div id="mapchart" style="width: 100%; height: 500px;">
    
</div>

<table width="100%" class="table table-striped table-hover">
    <thead>
    <tr valign="middle">
        <th rowspan="2">Country</th>
        <th colspan="3" align="center">Average Support Level</th>
        <th rowspan="2">Staff with a budget</th>
        <th rowspan="2">Budget vs Expenses</th>
        </tr>
    
   <tr>
       <th>Year</th>
       <th>Quater</th>
       <th>Month</th>
   </tr>
        </thead>
<asp:Repeater ID="rpCountriesSummaryData" runat="server">
    <ItemTemplate>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# EditUrl("countryDashboard") & "?country=" & Eval("ISO")%>'>
    
            <tr class="countryRow">
        <th><asp:HiddenField ID="hfISO" runat="server" Value='<%# Eval("ISO")%>' /><asp:Label ID="lblCountryName" runat="server" Text='<%# Eval("Name") %>' ></asp:Label></th>
        <td><asp:Label ID="lblSupYear" runat="server"  Text='<%# Eval("Year") %>' ></asp:Label></td>
        <td><asp:Label ID="lblSupQuart" runat="server"  Text='<%# Eval("Quarter") %>' ></asp:Label></td>
        <td><asp:Label ID="lblSupMonth" runat="server"  Text='<%# Eval("Month") %>' ></asp:Label></td>
        <td><asp:Label ID="lblBud" runat="server"  Text='<%# Eval("Budget") %>' ></asp:Label></td>
        <td><asp:Label ID="lblAccuracy" runat="server"  Text='<%# Eval("Accuracy") %>' ></asp:Label></td>
                
    </tr>
            </asp:HyperLink>
        </ItemTemplate>
 </asp:Repeater>   </table>


