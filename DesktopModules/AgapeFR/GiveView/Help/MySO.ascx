<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MySO.ascx.vb" Inherits="DotNetNuke.Modules.Give.MyGiving" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<script type="text/javascript">
    function closePopup() {
        document.getElementById("divSignin").style.display = "none";
        objDiv = document.getElementById("divg");
        objDiv.style.display = "none";
        return false;
    }
   

    function showPopup() {
        try {
            
            document.getElementById("divSignin").style.display = "block";
            objDiv = document.getElementById("divg");
            objDiv.style.display = "block";
            objDiv.style.width = document.body.scrollWidth;
            objDiv.style.height = document.body.scrollHeight;
            fnSetDivSigninLeft("divSignin");
            
        }
        catch (e) {
            alert(e);
        }
        return false
    }
    function showPopup2() {
        try {

            document.getElementById("divSignin2").style.display = "block";
            objDiv = document.getElementById("divg");
            objDiv.style.display = "block";
            objDiv.style.width = document.body.scrollWidth;
            objDiv.style.height = document.body.scrollHeight;
            fnSetDivSigninLeft("divSignin2");

        }
        catch (e) {
            alert(e);
        }
        return false
    }
    
    function fnSetDivSigninLeft(oElement) {
        var DivWidth = parseInt(document.getElementById(oElement).offsetWidth, 10);
        var DivHeight = parseInt(document.getElementById(oElement).offsetHeight, 10);

        var ScrollTop = 100;

//        try {
//             ScrollTop = parseInt(document.getElementById("ScrollTop").value, 10);
//        }
//        catch (e) {
//            alert("hello" & e);
//        }
 



        document.getElementById(oElement).style.left = (document.body.offsetWidth / 2) - (DivWidth / 2) ;
        document.getElementById(oElement).style.top = (document.body.offsetHeight / 2) - (DivHeight / 2) + ScrollTop ;
        
        return false;
    }
    function Tab(currentField, nextField) {
        // Determine if the current field's max length has been reached.

        if (currentField.value.length == currentField.maxLength) {
            // Retreive the next field in the tab sequence, and give it the focus.

            document.getElementById(nextField).focus();
        }
    }
</script>

<style type="text/css">

 .graydiv  
   {  
    position: absolute;  
    background-color: #5B5B5B;  
    left: 0px;  
    top: 0px;  
    z-index: 10000;  
    display: none;  
   }  
  
   .ModalBackground  
   {  
    background-color: black;  
    filter: alpha(opacity=70);  
    opacity: 0.7;  
   }  

</style>
<span class="Agape_SubTitle">
This page shows all of your Online donations and standing orders. If you have a question about a donation or standing order that has not been setup
through this website, please contact the Agap&eacute; Office on 0121 765 4404. </span>

<br /><br />
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<asp:HiddenField ID="hfUserId" runat="server"  />

<div class="Agape_Red_H3" style="margin-bottom: 5px;">Standing Orders:</div>
<asp:GridView ID="gvSO" runat="server" AutoGenerateColumns="False"  Font-Size="10pt"
    DataKeyNames="SOID" DataSourceID="MyStandingOrders" CellPadding="4" 
    ForeColor="#333333" GridLines="None" AllowSorting="True">
    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    <EmptyDataTemplate>
        <i>There are no standing orders to display...</i>
    </EmptyDataTemplate>
    <EmptyDataRowStyle CssClass="Agape_SubTitle" />
    <Columns>
        <asp:TemplateField HeaderText="Give To" SortExpression="RefId" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RefId") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Font-Bold="true" Text='<%# getGiveTo(Eval("RefId"), Eval("GivetoType")) %>'></asp:Label>
            </ItemTemplate>

<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Amount" SortExpression="Amount"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Amount", "{0:c}") & " <i>" &  getFreq(Eval("Frequency")) & "</i>" %>'></asp:Label>
            </ItemTemplate>

<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:TemplateField>
        <asp:CheckBoxField DataField="GiftAid" HeaderText="Gift Aid"   HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
            SortExpression="GiftAid" >
<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:CheckBoxField>
        <asp:BoundField DataField="StartDate" HeaderText="Start Date"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
            SortExpression="StartDate" DataFormatString="{0:dd/MM/yyyy}" >
<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:BoundField DataField="EndDate" HeaderText="End Date"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
            SortExpression="EndDate" DataFormatString="{0:dd/MM/yyyy}" >
<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:BoundField DataField="Reference" HeaderText="Bank Ref"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
            SortExpression="Reference" >
<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:BoundField DataField="LastPaidDate" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true"
            HeaderText="Last Payment" SortExpression="LastPaidDate" >
<HeaderStyle ForeColor="White"></HeaderStyle>
        </asp:BoundField>
        <asp:TemplateField HeaderText="Status" SortExpression="Status"  HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" ItemStyle-Width="60px">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Status") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Gray" Visible='<%# (Eval("Status")=0) %>'></asp:Label>
                <asp:Label ID="Label4" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Orange" Visible='<%# (Eval("Status")=1) %>'></asp:Label>
                <asp:Label ID="Label5" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Green"  Visible='<%# (Eval("Status")=2) %>'></asp:Label>
                <asp:Label ID="Label6" runat="server" Text='<%# getStatus(Eval("Status")) %>' Font-Bold="true" ForeColor="Red" Visible='<%# (Eval("Status")=3) %>'></asp:Label>
            </ItemTemplate>

<HeaderStyle ForeColor="White"></HeaderStyle>
            <ItemStyle Width="60px" />
        </asp:TemplateField>
         <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" style="white-space: nowrap;" Width="100px"
                    CommandName="myEdit" Text="Edit" Visible='<%# (Eval("Status")<>3) %>'  CommandArgument='<%# Eval("SOID") %>' ></asp:LinkButton>
                    <br />
                     <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                    CommandName="myCancel" Text="Delete" Visible='<%# (Eval("Status")<>3) %>'  CommandArgument='<%# Eval("SOID") %>' ></asp:LinkButton>
            </ItemTemplate>

        </asp:TemplateField>
     
       
    </Columns>
    <FooterStyle BackColor="#660000" Font-Bold="True" ForeColor="White"  />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center"  />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <HeaderStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>
<asp:LinqDataSource ID="MyStandingOrders" runat="server" 
    ContextTypeName="AgapeStaff.AgapeStaffDataContext" EnableUpdate="True" 
    OrderBy="SetupDate" TableName="Agape_Main_Give_SOs" 
    Where="UserId == @UserId">
    <WhereParameters>
        <asp:ControlParameter ControlID="hfUserId" Name="UserId" PropertyName="Value" 
            Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>


<br /><br />

<div class="Agape_Red_H3" style="margin-bottom: 5px;">One-Off Donations:</div>
<asp:GridView ID="gvDonations" runat="server" CellPadding="4" ForeColor="#333333"    Font-Size="10pt"
        GridLines="None" AutoGenerateColumns="False" >
    <EmptyDataTemplate>
        <i>There are no donations to display...</i>
    </EmptyDataTemplate>
    <EmptyDataRowStyle CssClass="Agape_SubTitle" />
    
    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    <Columns>
        <asp:BoundField DataField="DonName" HeaderText="Give To" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" ItemStyle-Font-Bold="true" />
         <asp:BoundField DataField="Value" DataFormatString="{0:c}" 
            HeaderText="Amount" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" />
        <asp:BoundField DataField="GiftDate" HeaderText="Gift Date" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" DataFormatString="{0:dd/MM/yyyy}"  />
       
        <asp:CheckboxField DataField="GiftAid" HeaderText="Gift Aid" HeaderStyle-ForeColor="White" HeaderStyle-Font-Bold="true" />
    </Columns>
    <FooterStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <HeaderStyle BackColor="#660000" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
  
</asp:GridView>
<asp:LinqDataSource ID="DonationsDS" runat="server" 
    ContextTypeName="Resources.ResourcesDataContext" 
    TableName="Agape_Main_Donations">
</asp:LinqDataSource>
</ContentTemplate>
<Triggers>
   
    <asp:PostBackTrigger ControlID="gvSO" />
</Triggers>

</asp:UpdatePanel>

<div id="divg" class="ModalBackground graydiv">  
</div>  

<div id="divSignin" style="border: '1px soild green'; display: none; z-index: 100002;  
    width: 550px; position: absolute;">  
<div style=" position: static; height:300px;width:500px;background-color:White;border:solid 1px lightyellow; padding: 20px;">  

<div class="Agape_Red_H2">Thank You!</div>
<p>  
Thank you for letting us know that you are stopping this standing order - we will update our records accordingly. <span class="Agape_Red_H5">To stop the standing order, you must contact your
bank.</span> (Unlike Direct Debits, standing orders can only be changed/cancelled by the account holder). 
</p> 
<p> 
We really appreciate the support that you have given. Thank you for partnering with us to help fulfill the Great Commission.
</p>
<p><span class="Agape_Red_H5">Are you sure that you would like to cancel this standing order?</span></p>

     <%--      <asp:ImageButton ID="btnCreate" runat="server" ImageUrl="~/images/ButtonImages/ContinueS.gif"    OnClientClick="closePopup"
         onmouseover = "this.src='/images/ButtonImages/ContinueS_f2.gif';"
                                                onmouseout="this.src='/images/ButtonImages/ContinueS.gif';" AlternateText="Continue" ToolTip="Continue"    />
--%>
<div width="100%" align="center">
 <asp:Button ID="btnNo" runat="server" Text="No" OnClientClick="closePopup"  />
    <asp:Button ID="btnYes" runat="server" Text="Yes"  />
   </div>
    
</div>
</div>


<div id="divSignin2" style="border: '1px soild green'; display: none; z-index: 100002;  
    width: 550px; position: absolute;">  
<div style=" position: static; height:500px;width:500px;background-color:White;border:solid 1px lightyellow; padding: 20px;">  

<div class="Agape_Red_H2">Edit Standing Order</div>
<table >
    <tr>
        <td>Give To:</td>    
        <td><asp:Label ID="lblGiveTo" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr>
        <td>Sort Code:</td>    
        <td>
        <asp:TextBox ID="tbSort1" runat="server" Width="30px" MaxLength="2" ></asp:TextBox>-<asp:TextBox ID="tbSort2" runat="server" Width="30px" MaxLength="2"></asp:TextBox>-<asp:TextBox ID="tbSort3" runat="server" Width="30px" MaxLength="2"></asp:TextBox>
                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="tbSort1" FilterType="Numbers" >  </cc1:FilteredTextBoxExtender>
                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server" TargetControlID="tbSort2" FilterType="Numbers" >  </cc1:FilteredTextBoxExtender>
                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server" TargetControlID="tbSort3" FilterType="Numbers" >  </cc1:FilteredTextBoxExtender>
        </td>
    </tr>
    <tr>
        <td>Account No:</td>    
        <td><asp:TextBox ID="tbAccountNo" runat="server" Text=""></asp:TextBox></td>
    </tr>
    <tr>
        <td>Reference:</td>    
        <td><asp:TextBox ID="tbRef" runat="server" Text=""></asp:TextBox></td>
    </tr>
    <tr>
        <td>Amount:</td>    
        <td><asp:TextBox ID="tbSOAmount" runat="server"   Width="90px" ></asp:TextBox>
             <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" 
                    TargetControlID="tbSOAmount" ValidChars="0123456789.">
            </cc1:FilteredTextBoxExtender>
            <asp:HiddenField ID="hfSOID" runat="server" />
                <asp:DropDownList ID="ddlFrequency" runat="server">
                    <asp:ListItem Value="1">Monthly</asp:ListItem>
                    <asp:ListItem Value="3">Quarterly</asp:ListItem>
                    <asp:ListItem Value="12">Annually</asp:ListItem>
                </asp:DropDownList></td>
    </tr>
  
</table><br /><br />
<p>
    Use this form to let us know that you are changing the amount/frequency of your giving -we will amend our records accordingly.
    <span class="Agape_Red_H5">You will need to contact your bank (or use online banking) to change the standing order.</span> Please make sure that you use the same Reference,
    as this allows us to ensure that your gift is allocated to the right staff member/ministry. If you have any questions, please do not hesitate to call us on 0121 765 4404.
   
</p>
<p>
    Thank you for your continued support in helping to fulfil the Great Commission.
</p><br />

<div width="100%" align="center">
           <asp:ImageButton ID="EditBtn" runat="server" ImageUrl="~/images/ButtonImages/ContinueS.gif"    
         onmouseover = "this.src='/images/ButtonImages/ContinueS_f2.gif';"
                                                onmouseout="this.src='/images/ButtonImages/ContinueS.gif';" AlternateText="Continue" ToolTip="Continue"    />
                                                  <asp:ImageButton ID="btnCancel1" runat="server" OnClientClick ="closePopup2();" ImageUrl="~/images/ButtonImages/Cancel.gif"   
                            onmouseover = "this.src='/images/ButtonImages/Cancel_f2.gif';"
                                                onmouseout="this.src='/images/ButtonImages/Cancel.gif';" AlternateText="Cancel" ToolTip="Cancel"    /></div>
</div>
</div>