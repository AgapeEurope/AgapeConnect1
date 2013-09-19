<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdDashboard.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdDashboard" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("visualization", "1", { packages: ["corechart"] });
        google.load('visualization', '1', { 'packages': ['geochart'] });
        google.setOnLoadCallback(drawChart);

     

        function drawChart() {


            var data2 = google.visualization.arrayToDataTable([
     ['Support Level', 'Percentage Raised'],
      ['No Budget', 3],
     ['<50% Raised', 11],
     ['50-75% Raised', 2],
     ['75-90% Raised', 2],
     ['90-100% Raised', 2],
     ['>100% Raised', 7]
            ]);

            var options2 = {
                title: 'Staff MPD Health',
                pieHole: 0.4, reverseCategories: true,
                slices: [{ color: 'green' }, { color: '#7e870d' }, { color: '#ff9b00' }, { color: '#ff5f08' }, { color: 'red' }, { color: 'grey', offset: 0.1 }]
            };

            var chart2 = new google.visualization.PieChart(document.getElementById('donutchart'));
            chart2.draw(data2, options2);


            var data = google.visualization.arrayToDataTable([
              ['Country', '<50% Raised', '50-75% Raised', '75-90% Raised', '90-100% Raised', '>100% Raised'],
              ['UK', 10, 12, 80, 15, 5 ],
              ['France', 30,20, 60,2, 1],
              ['Ireland', 0, 2,3, 1, 1]


            ]);

            var options = { 
                title: 'Staff MPD Health', isStacked: true, series: [{ color: 'red', visibleInLegend: true }, { color: '#ff5f08', visibleInLegend: true }, { color: '#ff9b00', visibleInLegend: true }, { color: '#7e870d', visibleInLegend: true }, { color: 'green', visibleInLegend: true }],
                vAxis: { title: 'Country', tit  leTextStyle: { color: 'red' } }
            };

            var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
            chart.draw(data, options);


            var data3 = google.visualization.arrayToDataTable([
         ['Country', 'Popularity'],
         ['Germany', 120],
         ['United States', 96],
         ['Brazil', 25],
         ['Canada', 82],
         ['France', 67],
         ['RU', 43],
         <%= jsonMap %>
            ]);

            var options3 = { colors: ['#FF0000', '#ff9b00', '#00FF00'], colorAxis: { minValue:50, maxValue: 110 } };

            var chart3 = new google.visualization.GeoChart(document.getElementById('mapchart'));

            google.visualization.events.addListener(chart3, "regionClick", function (eventData) {
                var countryISO2 = eventData["region"];
                window.location.href = '<%= EditUrl("countryDashboard") & "?country=" %>' + countryISO2;


            });



            chart3.draw(data3, options3);

        

        }
    </script>
<div id="mapchart" style="width: 900px; height: 500px;"></div>
 <div id="donutchart" style="width: 900px; height: 500px;"></div>
<div id="chart_div" style="width: 900px; height: 500px;"></div>

    