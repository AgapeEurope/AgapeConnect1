<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdDashboard.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdDashboard" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>

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
    </script>
<div id="mapchart" style="width: 100%; height: 500px;"></div>


    