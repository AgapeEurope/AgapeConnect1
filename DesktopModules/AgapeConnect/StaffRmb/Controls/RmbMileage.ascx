<%@ Control Language="VB" AutoEventWireup="false" CodeFile="RmbMileage.ascx.vb" Inherits="controls_Mileage" ClassName="controls_Mileage"  %>
<%@ Register assembly="DotNetNuke" namespace="DotNetNuke.UI.WebControls" tagprefix="cc1" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>


<asp:HiddenField ID="hfAddStaffRate" runat="server" />
<asp:HiddenField ID="hfCanAddPass" runat="server" />
<div class="Agape_SubTitle"> <asp:HiddenField ID="hfNoReceiptLimit" runat="server" Value="0" />
    <asp:Label ID="Label2" runat="server" Font-Italic="true" ForeColor="Gray" resourcekey="Explanation"></asp:Label>
</div><br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<table style="font-size:9pt; ">
<tr>
    <td ><b><dnn:label id="Label4"  runat="server" controlname="tbDesc" ResourceKey="lblDesc"  /></b></td>
    <td colspan="2"><asp:TextBox ID="tbDesc" runat="server" Width="450px"></asp:TextBox></td>
</tr>
<tr>
    <td><b><dnn:label id="Label3" runat="server" controlname="dtDate"  ResourceKey="lblDate" /></b></td>
    <td colspan="2">
      
        <asp:TextBox ID="dtDate" runat="server" Width="90px" class="datepicker"></asp:TextBox>
       
        
    </td>
</tr>
    <tr>
        <td>
            <b>
                <dnn:Label ID="lblDistance" runat="server" ControlName="tbMiles"   />
            </b>
        </td>
        <td>
            <asp:TextBox ID="tbMiles" runat="server" Width="90px" class="numeric"></asp:TextBox>
        </td>
</tr>

<tr id="pnlVehicle" runat="server">
    <td><b><dnn:label id="lblTitle" runat="server" controlname="ddlVehicleType"  resourcekey="lblVehicle" /></b></td>
    <td>
        <asp:DropDownList ID="ddlVehicleType" runat="server" AutoPostBack="true" >
           
        </asp:DropDownList>
       <%-- <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true">
            <asp:ListItem Value="0.40" ResourceKey="Car">Car</asp:ListItem>
            <asp:ListItem  Value="0.24" ResourceKey="Motercycle">Motercycle</asp:ListItem>
            <asp:ListItem Value="0.20" ResourceKey="Bicycle">Bicycle (not in Cyclescheme)</asp:ListItem>
        </asp:DropDownList>--%>
    </td>
    
</tr>

   

<tr  id="VatRow" runat="server">
    <td  ><b><dnn:label id="Label5" runat="server" controlname="ddlVATReceipt" ResourceKey="lblReceipt" width="120px"  /></b></td>
    <td>
        <asp:DropDownList ID="ddlVATReceipt" runat="server" AutoPostBack="True">
            <asp:ListItem ResourceKey="Yes" >Yes</asp:ListItem>
            <asp:ListItem  ResourceKey="No" Selected="True">No</asp:ListItem>
        </asp:DropDownList><br />
      
        <asp:DropDownList ID="ddlCarType" runat="server">
        <asp:ListItem Value="P1" >Petrol - less then 1400cc</asp:ListItem>
        <asp:ListItem Value="P2"  >Petrol - 1401 to 2000cc</asp:ListItem>
        <asp:ListItem Value="P3" >Petrol - More than 2000cc</asp:ListItem>
        <asp:ListItem Value="D1" >Diesel - less then 1400cc</asp:ListItem>
        <asp:ListItem Value="D2" >Diesel - 1401 to 2000cc</asp:ListItem>
        <asp:ListItem Value="D3" >Diesel - More than 2000cc</asp:ListItem>
        <asp:ListItem Value="L1" >LPG - less then 1400cc</asp:ListItem>
        <asp:ListItem Value="L2" >LPG - 1401 to 2000cc</asp:ListItem>
        <asp:ListItem Value="L3" >LPG - More than 2000cc</asp:ListItem>
           
        </asp:DropDownList>

    </td>
    <td>  <asp:Label ID="lblLess" runat="server" Font-Size="8pt" ResourceKey="lblVatInfo" >
* If you fill up your car before your trip, and you have a VAT receipt we can claim some of the VAT back.</asp:Label>
</td>
</tr>

<tr id="PassengersRow" runat="server">
    <td><b><dnn:label id="Label6" runat="server" controlname="ddlStaff" ResourceKey="lblStaff"  text="How many staff<br />passengers did you take?" HelpText="You get an additional 5p for every staff passenger that you take. The passenger must be on the UK payroll - so interns and children do not count (sorry!). Interns also cannot claim additional allowance for staff passengers." /></b></td>
    <td>
        <asp:DropDownList ID="ddlStaff" runat="server" AutoPostBack="true" >
            <asp:ListItem Value="0" >None</asp:ListItem>
            <asp:ListItem Value="1" >1</asp:ListItem>
            <asp:ListItem Value="2" >2</asp:ListItem>
            <asp:ListItem Value="3" >3</asp:ListItem>
            <asp:ListItem Value="4" >4</asp:ListItem>
            <asp:ListItem Value="5" >5</asp:ListItem>
            <asp:ListItem Value="6" >6</asp:ListItem>
            <asp:ListItem Value="7" >7</asp:ListItem>
            <asp:ListItem Value="8" >8</asp:ListItem>
       
       </asp:DropDownList>
    </td>
    <td>  <asp:Label ID="Label1" runat="server" Font-Size="8pt" >
* Note: Interns and staff children do not count as staff.</asp:Label>
</td>
</tr>
<tr id="pnlStaff" runat="server">
    <td><b><dnn:label id="Label7" runat="server" controlname="DDL1"  text="Who did you take?" HelpText="If the person you are looking for does not appear in the list - this is probably because they are not on the UK payroll. You can only claim additional milage for staff on the UK payroll. If you believe that someone is missing from this list, please contact someone in HR." /></b></td>
    <td>
       <div id="pnlDDL1" runat="server"> <asp:DropDownList ID="DDL1" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL2" runat="server"> <asp:DropDownList ID="DDL2" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL3" runat="server"> <asp:DropDownList ID="DDL3" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL4" runat="server"> <asp:DropDownList ID="DDL4" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL5" runat="server"> <asp:DropDownList ID="DDL5" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL6" runat="server"> <asp:DropDownList ID="DDL6" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL7" runat="server"> <asp:DropDownList ID="DDL7" runat="server" ></asp:DropDownList></div>
       <div id="pnlDDL8" runat="server"> <asp:DropDownList ID="DDL8" runat="server" ></asp:DropDownList></div>
    </td>
   
</tr>

</table>
 <asp:Label ID="ErrorLbl" runat="server" Font-Size="9pt" ForeColor="Red" />
</ContentTemplate>
<Triggers>
    <asp:AsyncPostBackTrigger  ControlID="ddlStaff" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger  ControlID="ddlVehicleType" EventName="SelectedIndexChanged" />
    <asp:AsyncPostBackTrigger  ControlID="ddlVATReceipt" EventName="SelectedIndexChanged" />
    <asp:PostBackTrigger ControlID="dtDate" />
</Triggers>

</asp:UpdatePanel>
