﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Account.ascx.cs" Inherits="DotNetNuke.Modules.Account.AccountReport" %>
<link href="../../../Portals/_default/Skins/AgapeBlue/flick/jquery-ui-1.8.18.custom.css"
    rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script src="../../../Scripts/linq.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript" >
    google.load("visualization", "1", { packages: ["corechart"] });
     google.setOnLoadCallback(function() { drawVisualization() });
    $(function () {
        $("#accordion").accordion({
            autoHeight: false,
            navigation: true,
            collapsible: true,
            active: false
        });
       
        $("#divTransDetail").dialog({
                autoOpen: false,
                height: 300,
                width: 400,
                modal: true,
                title: "Transaction Detail",
                close: function () {
                    allFields.val("").removeClass("ui-state-error");
                }
            });
        $("#divTransDetail").parent().appendTo($("form:first"));


    });

     function drawVisualization() {
      
                // create and populate the data table.
                var data = new google.visualization.DataTable();
                data.addColumn('string', 'period');
                data.addColumn('number', 'Income');
                data.addColumn('number', 'Expenses');
                data.addColumn('number', 'Balance');
                <%= getGoogleData() %>
   
                // create and draw the visualization.
                var chart = new google.visualization.LineChart(document.getElementById("IncExpGraph"));
                chart.draw(data,  {chartArea:{left:70,top:10,width:805,height:360}, legend: { position: 'in' }, pointSize: 5, vAxis:{gridLines: {color: '#333',format:'#,###'}}, hAxis:{font: 'Arial Bold'} });
               
            }

            function displayDetail(accountCode, period, title)
            {
                
                var data =  jQuery.parseJSON(unescape( document.getElementById('<%= hfTransactions.ClientID %>').value));
               
                var output = "<h5 style=\"margin: 0;\">" + title + "</h5><br /><table cellpadding=\"4px\" style=\"margin: 0;\"><tr><td><b>Date</b></td><td><b>Description</b></td><td><b>Amount</b></td></tr>";
               
                 Enumerable.From(data).Where(function(x) {return x.AC == accountCode && x.Pe==period } ).ForEach(function(i)
                 {
                  output += "<tr><td>" + i.Dt + "</td><td>" + i.De + "</td><td>" + i.Am +"</td></tr>" ;
                 });
      
            output += "</table>";
              
                $('#DetailTable').html(output);
                $("#divTransDetail").dialog("open");
            }
	</script>


    <style type="text/css">
    .CellHover
    {
        cursor: pointer;
    }
    </style>
<div align="center" style="display: none">        
    <div>
        <asp:Label ID="btnHome" runat="server" class="">Home</asp:Label>
        <asp:Label ID="lblFinancial" runat="server" class="">Accounts</asp:Label>
    </div>
    <div><asp:Label ID="lbltest" runat="server" Visible="true"></asp:Label></div>
    <div><asp:Label ID="lblDate" runat="server" class=""></asp:Label></div>
    <div><asp:Label ID="lblCostCenter" runat="server" class="" ></asp:Label></div>
    </div>
   
   <table width="100%">
    <tr valign="top" >
        <td style="width: 100%">
            <div style="text-align:left">    
                <div style="width:auto">          
                    <div><b>Country:</b><br />
                        <asp:DropDownList ID="MyCountries" runat="server" AutoPostBack="true" Font-Bold="true" style="margin-bottom: 10px;"
                            Width="100%" Font-Size="8pt" OnSelectedIndexChanged="MyCountries_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div><b>Profile:</b> <br />
                        <asp:DropDownList ID="MyProfiles" runat="server" AutoPostBack="true" Width="100%" style="margin-bottom: 10px;"
                            Font-Size="8pt" OnSelectedIndexChanged="MyProfiles_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div><b>Responsibility   Centre: </b><br />
                        <asp:DropDownList ID="MyAccounts" runat="server" AutoPostBack="true" Width="100%" style="margin-bottom: 10px;"
                         Font-Size="8pt" OnSelectedIndexChanged="MyAccounts_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>  
            </div>
            <fieldset>
            <h5>Please note this is a very early draft!!!</h5>
            </fieldset>
        </td>
        <td ><div id="IncExpGraph" style="width: 875px; height: 400px;"></div></td>
    </tr>
   
   </table>
   
   


   

    <div id="accordion">
        <h3><a href="#Income">   
        <asp:GridView ID="gvIncome" runat="server" 
                ShowHeader="False" GridLines="None" CellPadding="0" Width="100%" >
            <RowStyle BorderStyle="None" HorizontalAlign="Right" />
        
        </asp:GridView></a></h3>
        <div style="margin:0px 0px 0px 0px ;padding:5px 6px 5px 29px">
            <asp:GridView ID="gvIncomeGLSummary" runat="server"  ShowHeader="False" 
                GridLines="None" RowStyle-BorderStyle="None" CellPadding="0" Width="100%" 
                onrowdatabound="gvIncomeGLSummary_RowDataBound"  >
                <AlternatingRowStyle BackColor="White" />
                
                <RowStyle BackColor="#EFF3FB" BorderStyle="None" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            
        
            </asp:GridView>
        </div>
      
        <h3><a href="#Expenses"><asp:GridView ID="gvExpenses" AutoGenerateColumns="true" runat="server" ShowHeader="False" GridLines="None" CellPadding="0" Width="100%"  >
        <RowStyle BorderStyle="None" HorizontalAlign="Right" />
        </asp:GridView></a></h3>
        <div  style="margin:0px 0px 0px 0px ;padding:5px 6px 5px 29px">
            <asp:GridView ID="gvExpensesGLSummary" runat="server" ShowHeader="False" 
                GridLines="None" CellPadding="0" Width="100%" 
                onrowdatabound="gvExpensesGLSummary_RowDataBound" >
                <AlternatingRowStyle BackColor="White" />
                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                
            </asp:GridView>

        </div>
        <h3><a href="#Balance"><asp:GridView ID="gvBalance" AutoGenerateColumns="true" runat="server" ShowHeader="False" GridLines="None" CellPadding="0" Width="100%"  >
        <RowStyle BorderStyle="None" HorizontalAlign="Right" />
        </asp:GridView></a></h3>
        <div>
           
        </div>
    </div>
    <div style="color:Gray; font-size: smaller;"> Starting Balance: <asp:Label ID="StartingBalance" runat="server" /> &nbsp; &nbsp;
    Ending Balance: <asp:Label ID="EndingBalance" runat="server" /></div>


<asp:HiddenField ID="hfTransactions" runat="server" />
<div id="divTransDetail" >
    <div id="DetailTable">
    </div>
</div>