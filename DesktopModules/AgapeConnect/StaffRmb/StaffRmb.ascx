﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="StaffRmb.ascx.vb" Inherits="DotNetNuke.Modules.StaffRmbMod.ViewStaffRmb" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<%@ Register src="Controls/StaffAdvanceRmb.ascx" tagname="StaffAdvanceRmb" tagprefix="uc1" %>

<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<script src="/js/jquery.watermarkinput.js" type="text/javascript"></script>
<script type="text/javascript">



    (function ($, Sys) {
        function setUpMyTabs() {
            var stop = false;
            
            $('.hlCur').click(function() { var tempValue=$('.rmbAmount').val();  $('.ddlCur').change();$('.rmbAmount').val(tempValue); $('.divCur').show(); $('#' + this.id).hide();  });
            $('.currency').keyup(function() { calculateXRate();});
            $('.ddlCur').change(function() { 


                var ToCur= $("#<%= hfAccountingCurrency.ClientId %>").attr('value') ;
                var FromCur = $('#' + this.id).val();
                var jsonCall= "/MobileCAS/MobileCAS.svc/ConvertCurrency?FromCur=" + FromCur + "&ToCur=" + ToCur;
               $('.rmbAmount').val('');
                 $("#<%= hfExchangeRate.ClientId %>").attr('value', -1);
                $.getJSON( jsonCall ,function(x) {
                    
                    $("#<%= hfExchangeRate.ClientId %>").attr('value', x);
                        //now need to convert any value in the TextBox
                        calculateXRate();
 
                })      
    
            });
           

           //Advance Currency Coverter
            $('.hlCurAdv').click(function() { var tempValue=$('.advAmount').val();  $('.ddlCurAdv').change();$('.rmbAmountAdv').val(tempValue); $('.divCurAdv').show(); $('#' + this.id).hide();  });
            $('.currencyAdv').keyup(function() { calculateXRateAdv();});
            $('.ddlCurAdv').change(function() { 


                var ToCur= $("#<%= hfAccountingCurrency.ClientId %>").attr('value') ;
                var FromCur = $('#' + this.id).val();
                var jsonCall= "/MobileCAS/MobileCAS.svc/ConvertCurrency?FromCur=" + FromCur + "&ToCur=" + ToCur;
               $('.advAmount').val('');
                 $("#<%= hfExchangeRate.ClientId %>").attr('value', -1);
                $.getJSON( jsonCall ,function(x) {
                    
                    $("#<%= hfExchangeRate.ClientId %>").attr('value', x);
                        //now need to convert any value in the TextBox
                        calculateXRateAdv();
 
                })      
    
            });

            
            $("#accordion h3").click(function (event) {
                if (stop) {
                    event.stopImmediatePropagation();
                    event.preventDefault();
                    stop = false;
                }
            });
            $("#accordion").accordion({
			    header: "> div > h3",
			    active: <%= getSelectedTab() %>,
                navigate: false
           });


            $("#divSplitPopup").dialog({
                autoOpen: false,
                height: 400,
                width: 500,
                modal: true,
                title: '<%= Translate("SplitTransaction") %>',
                close: function () {
                   // allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divSplitPopup").parent().appendTo($("form:first"));

            $("#divAdvanceReq").dialog({
                autoOpen: false,
                height: 500,
                width: 650,
                modal: true,
                title: '<%= Translate("AdvanceRequest") %>',
                close: function () {
                  //  allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divAdvanceReq").parent().appendTo($("form:first"));

            $("#divSignin").dialog({
                autoOpen: false,
                height: 500,
                width: 750,
                modal: true,
                title: '<%= Translate("AddEditRmb") %>',
                close: function () {
                  //  allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divSignin").parent().appendTo($("form:first"));

            $("#divSignin2").dialog({
                autoOpen: false,
                height: 350,
                width: 600,
                modal: true,
                title: '<%= Translate("CreateRmb") %>',
                close: function () {
                  //  allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divSignin2").parent().appendTo($("form:first"));

            $("#divSignin3").dialog({
                autoOpen: false,
                height: 400,
                width: 600,
                modal: true,
                close: function () {
                   // allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divSignin3").parent().appendTo($("form:first"));

            $("#divDownload").dialog({
                autoOpen: false,
                height: 350,
                width: 500,
                modal: true,
                title: '<%= Translate("BatchedRmbs") %>',
                close: function () {
                  //  allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divDownload").parent().appendTo($("form:first"));
            $("#divAccountWarning").dialog({
                autoOpen: false,
                height: 150,
                width: 500,
                modal: true,
                title: '<%= Translate("AccountWarning")%>',
                close: function () {
                    //  allFields.val("").removeClass("ui-state-error");
                }
              });
            $("#divAccountWarning").parent().appendTo($("form:first"));

            

              $("#divSuggestedPayments").dialog({
                autoOpen: false,
                height: 235,
                width: 625,
                modal: true,
                title: '<%= Translate("SuggestedPayments") %>',
                close: function () {
                  //  allFields.val("").removeClass("ui-state-error");
                }
            });
            $("#divSuggestedPayments").parent().appendTo($("form:first"));






            $('.aButton').button();
           
            $('.Excel').button({ icons: { primary: 'myExcel'} });


            var pickerOpts = {
                dateFormat: '<%= GetDateFormat() %>'
            };


            $('.datepicker').datepicker(pickerOpts);

            $('.numeric').numeric();
            $('.Description').Watermark('<%= Translate("Description") %>');
            $('.Amount').Watermark('<%= Translate("Amount") %>');





        }









        $(document).ready(function () {
            setUpMyTabs();
                  

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyTabs();



            });
        });








    } (jQuery, window.Sys));

    function GetAccountBalance(jsonQuery){
 
     $.getJSON(jsonQuery, function(json){
      
            var amountString = '<%=StaffBrokerFunctions.GetSetting("Currency", PortalId)  %>' + json ;
                $("#<%= lblAccountBalance.ClientId %>").html(amountString) ;
             $("#<%= AccBal.ClientId %>").html(amountString) ;
            
            });

}
 function GetAdvanceBalance(jsonQuery){
     $.getJSON(jsonQuery, function(json){
            var amountString = '<%=StaffBrokerFunctions.GetSetting("Currency", PortalId)  %>' + json ;
                $("#<%= lblAdvanceBalance.ClientId %>").html(amountString) ;
             $("#<%= AdvBal.ClientId %>").html(amountString) ;
            
            });

}




    function closePopup()  {$("#divSignin").dialog("close");}
    function closePopup2() {$("#divSignin2").dialog("close");}
    function closePopup3() {$("#divSignin3").dialog("close");}
    function closePopupSplit() {$("#divSplitPopup").dialog("close");}
    function closePopupDownload() {$("#divDownload").dialog("close");}
    function closePopupAccountWarning() {$("#divAccountWarning").dialog("close");}

    
   function closeSuggestedPayments() {$("#divSuggestedPayments").dialog("close");}
   
   function closeAdvanceReq()  {$("#divAdvanceReq").dialog("close");}

   function selectIndex(tabIndex) {
       
        $("#accordion").accordion("activate", tabIndex);
        
        return false;
    }

    function enableAddLine() {
        document.getElementById("addLinebtn").disabled = "";
        return False;
    }
    function disableAddLine() {
        document.getElementById("addLinebtn").disabled = "disabled";
        return False;
    }

    
    
    function showPopup()  {$("#divSignin").dialog("open");return false;}
    function showPopup2() {$("#divSignin2").dialog("open"); return false; }
    function showPopup3() {$("#divSignin3").dialog("open"); return false; }
     function showPopupSplit() {$("#divSplitPopup").dialog("open"); return false; }
     function showDownload() { $("#divDownload").dialog("open"); return false; }
     function showAccountWarning() { $("#divAccountWarning").dialog("open"); return false; }

     
     function showSuggestedPayments() {$("#divSuggestedPayments").dialog("open"); return false; }
    function showAdvanceReq()  {$("#divAdvanceReq").dialog("open");return false;}

    function calculateXRate() {
    var xRate = $("#<%= hfExchangeRate.ClientId %>").attr('value');
                var inCur=$('.currency').val() ;
              if(parseFloat(xRate) <0)
              {
                $('.rmbAmount').val('');
                return;
              }
                
                 if(inCur.length>0){
                     $('.rmbAmount').val( (parseFloat(xRate) * parseFloat(inCur)).toFixed(2));
                     
                     }
    }
    function calculateXRateAdv() {
    var xRate = $("#<%= hfExchangeRate.ClientId %>").attr('value');
                var inCur=$('.currencyAdv').val() ;
              if(parseFloat(xRate) <0)
              {
                $('.advAmount').val('');
                return;
              }
                
                 if(inCur.length>0){
                     $('.advAmount').val( (parseFloat(xRate) * parseFloat(inCur)).toFixed(2));
                     
                     }
    }
    

    function setXRate(xRate){
     $("#<%= hfExchangeRate.ClientId %>").val(xRate );

    }

    function calculateTotal() {
        var total = 0.00;

        $(".Amount").each(function() {
            if (!isNaN(this.value) && this.value.length != 0) {total += parseFloat(this.value);}
        });
       
        var orig = $("#<%= lblOriginalAmt.ClientId %>").html();
       
       if(total== parseFloat(orig.substring(0,orig.Length)))
       {
            $("#<%= btnOK.ClientId %>").button('enable');
        }
        else
        {
            $("#<%= btnOK.ClientId %>").button('disable');
          
        }
    }


</script>
<style type="text/css">
       .AgapeWarning
    {
        display: block;
        margin-bottom: 5px;
        padding: 3px;
    }
    
    .AdvRequest
    {
        background-color:#E2CB9A;
border-bottom-style: dashed;
border-width: 2px ;
padding: 5px 5px 5px 5px;
        
    }
    
    .myExcel
    {
        width: 16px;
        height: 16px;
        background-image: url('/DesktopModules/AgapeConnect/StaffRmb/Images/Excel_icon.gif') !important;
    }
    
    .hdrTitle
    {
        white-space: nowrap;
        color: Gray;
    }
    .hdrValue
    {
    }
    .AcPane
    {
        height: 280px;
    }
</style>
<div style="text-align: center; width: 100%;" >
 <asp:Label ID="lblError" runat="server" class="ui-state-error ui-corner-all" 
                Style="padding: 3px; margin-top: 3px; display: inline-block; width: 50%;" Visible ="false" ></asp:Label>
                </div>
<asp:Panel ID="pnlEverything" runat="server">



<div style="padding-bottom: 5px;">
    <asp:Label ID="Label2" runat="server" CssClass="AgapeH2" resourcekey="RmbTitle" Visible="false"></asp:Label></div>
<asp:HiddenField ID="hfPortalId" runat="server" Value="-1" />
<asp:HiddenField ID="hfAccountingCurrency" runat="server" Value="USD" />
<asp:HiddenField ID="hfExchangeRate" runat="server" Value="1"   />
    

<table width="100%">
    <tr valign="top">
        <td>
            <div align="center" width="100%" >
                <input id="btmNewRmb" type="button" onclick="showPopup2();" class="aButton"  value='<%= Translate("btnNew") %>'
                    style="margin-bottom: 5px; font-weight: bold; min-width: 220px;" />
            </div>
            <div id="accordion" >
                <div>
                    <h3>
                        <a href="#" id="Tab0" class="AcHdr">
                            <asp:Label ID="Label5" runat="server" Font-Bold="true" ResourceKey="Draft"></asp:Label></a></h3>
                    <div id="DraftPane" class="AcPane">
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>
                             <asp:Label ID="lblHighlight" runat="server" class="ui-state-highlight ui-corner-all"
                Style="padding: 3px; display: block;" resourcekey="AccountsMode" Visible="false"></asp:Label>
                <asp:Label ID="lblErrors" runat="server" class="ui-state-error ui-corner-all"
                Style="padding: 3px; margin-top: 3px; display: block; " Visible ="false" ></asp:Label>
                                <asp:DataList ID="dlPending" runat="server" Width="100%">
                                    <ItemStyle CssClass="dnnGridItem" />
                                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                    <ItemTemplate>
                                   
                                        <table width="100%" >
                                            <tr valign="middle">
                                                <td>
                                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' />
                                                </td>
                                                <td width="100%" align="left" >

                                                    <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>'
                                                        CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Width="100%" BorderStyle="Solid"
                                                        BorderColor="#CCCCCC" BorderWidth="1px" Font-Bold="true" Font-Size="9pt" Visible='<%# IsSelected(Eval("RmbNo")) %>' ></asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>'
                                                        CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" Width="100%"
                                                        Visible='<%# Not IsSelected(Eval("RmbNo"))  %>'></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="dlPending" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div>
                    <h3>
                        <a href="#" id="Tab1" class="aLink">
                            <asp:Panel ID="pnlSubmitted" runat="server">
                            
                            <asp:Label ID="Label6" runat="server" Font-Bold="true" ResourceKey="Submitted"></asp:Label>
                            <asp:Label ID="lblSubmittedCount" runat="server" Font-Bold="true"></asp:Label>
                        </asp:Panel>
                        </a>
                        
                        </h3>
                        <div ID="SubmittedPane">
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <asp:TreeView ID="tvAllSubmitted" runat="server" NodeIndent="10">
                                    </asp:TreeView>
                                    <asp:Panel ID="pnlSubmittedView" runat="server">
                                        <asp:Label ID="Label10" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="RmbsToApprove" Style="font-size: 8pt;"></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlToApprove" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:DataList ID="dlAdvToApprove" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Bold="true" Font-Size="9pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Size="10pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"),Eval("UserId"),  Eval("RequestDate"))  %>' 
                                                                Visible='<%# Not IsAdvSelected(Eval("AdvanceId"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <div style="width: 100%; border-bottom: dashed 1px black;">
                                            &nbsp;
                                        </div>
                                        <asp:Label ID="Label11" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="YourRmbs" Style="font-size: 8pt;"></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlSubmitted" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:DataList ID="dlAdvSubmitted" runat="server" Width="100%">
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Bold="true" Font-Size="9pt" 
                                                                Text='<%# GetAdvTitle(Eval("LocalAdvanceId"),  Eval("RequestDate"))  %>' 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Size="10pt" 
                                                                Text='<%# GetAdvTitle(Eval("LocalAdvanceId"),  Eval("RequestDate"))  %>' 
                                                                Visible='<%# Not IsAdvSelected(Eval("AdvanceId"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </asp:Panel>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="dlToApprove" />
                                    <asp:PostBackTrigger ControlID="dlSubmitted" />
                                    <asp:PostBackTrigger ControlID="dlAdvSubmitted" />
                                    <asp:PostBackTrigger ControlID="dlAdvToApprove" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                       
                            
                </div>
                <div>
                    <h3>

                        <a href="#" id="Tab2" class="aLink" >
                        <asp:Panel ID="pnlToProcess" runat="server">

                            <asp:Label ID="Label7" runat="server" Font-Bold="true" ResourceKey="Approved"></asp:Label>
                             <asp:Label ID="lblToProcess" runat="server" Font-Bold="true"></asp:Label>
                        </asp:Panel> 
                    </a>
                       
                        </h3>
                        <div ID="ApprovedPane">
                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                <ContentTemplate>
                                    <asp:Panel ID="pnlApprovedAcc" runat="server">
                                        <asp:Label ID="Label12" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="Receipts" 
                                            Style="font-size: 8pt;  color: Gray; font-style: italic; "></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlReceipts" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>'></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <div style="width: 100%; border-bottom: dashed 1px black;">
                                            &nbsp;
                                        </div>
                                        <asp:Label ID="Label13" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="NoReceipts" 
                                            Style="font-size: 8pt; color: Gray; font-style: italic;"></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlNoReceipts" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RMBNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>'></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:DataList ID="dlAdvNoReceipts" runat="server" Width="100%">
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Bold="true" Font-Size="9pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>'></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Size="10pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# Not IsAdvSelected(Eval("AdvanceId"))  %>'></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:Panel ID="pnlPendingDownload" runat="server">
                                            <div style="width: 100%; border-bottom: dashed 1px black;">
                                                &nbsp;
                                            </div>
                                            <asp:Label ID="Label14" runat="server" class="Agape_SubTitle" 
                                                ResourceKey="PendingDownload" 
                                                Style="font-size: 8pt;  color: Gray; font-style: italic;"></asp:Label>
                                            <br />
                                            <asp:DataList ID="dlPendingDownload" runat="server" Width="100%">
                                                <ItemStyle CssClass="dnnGridItem" />
                                                <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                                <ItemTemplate>
                                                    <table width="100%">
                                                        <tr valign="middle">
                                                            <td>
                                                                <asp:Image ID="Image2" runat="server" 
                                                                    ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                            </td>
                                                            <td align="left" width="100%">
                                                                <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                    CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                    Font-Size="9pt" 
                                                                    Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                    Visible='<%# IsSelected(Eval("RmbNo")) %>'></asp:LinkButton>
                                                                <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                    CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                    Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                    Visible='<%# Not IsSelected(Eval("RmbNo"))  %>'></asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                    Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <asp:DataList ID="dlAdvPendingDownload" runat="server" Width="100%">
                                                <ItemTemplate>
                                                    <table width="100%">
                                                        <tr valign="middle">
                                                            <td>
                                                                <asp:Image ID="Image2" runat="server" 
                                                                    ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                            </td>
                                                            <td align="left" width="100%">
                                                                <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                    CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                    Font-Bold="true" Font-Size="9pt" 
                                                                    Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                    Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>'></asp:LinkButton>
                                                                <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                    CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                    Font-Size="10pt" 
                                                                    Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                    Visible='<%# Not IsAdvSelected(Eval("AdvanceId"))  %>'></asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                    Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </asp:Panel>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlApprovedView" runat="server">
                                        <asp:Label ID="Label15" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="YourRmbs" Style="font-size: 8pt;"></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlApproved" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:DataList ID="dlAdvApproved" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Bold="true" Font-Size="9pt" 
                                                                Text='<%# GetAdvTitle( Eval("LocalAdvanceId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Size="10pt" 
                                                                Text='<%# GetAdvTitle(Eval("LocalAdvanceId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("AdvanceId"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <div style="width: 100%; border-bottom: dashed 1px black;">
                                            &nbsp;
                                        </div>
                                        <asp:Label ID="Label16" runat="server" class="Agape_SubTitle" 
                                            ResourceKey="TeamRmbs" Style="font-size: 8pt;"></asp:Label>
                                        <br />
                                        <asp:DataList ID="dlTeamApproved" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" 
                                                                Font-Size="9pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" 
                                                                Text='<%# GetRmbTitleTeam(Eval("RID"), Eval("UserId"), Eval("RmbDate"))  %>' 
                                                                Visible='<%# Not IsSelected(Eval("RmbNo"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:DataList ID="dlAdvTeamApproved" runat="server" Width="100%">
                                            <ItemStyle CssClass="dnnGridItem" />
                                            <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                            <ItemTemplate>
                                                <table width="100%">
                                                    <tr valign="middle">
                                                        <td>
                                                            <asp:Image ID="Image2" runat="server" 
                                                                ImageUrl='<%# GetProfileImage(Eval("UserId")) %>' Width="35px" />
                                                        </td>
                                                        <td align="left" width="100%">
                                                            <asp:LinkButton ID="LinkButton3" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Bold="true" Font-Size="9pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' Width="100%"></asp:LinkButton>
                                                            <asp:LinkButton ID="LinkButton2" runat="server" 
                                                                CommandArgument='<%# Eval("AdvanceId") %>' CommandName="GotoAdvance" 
                                                                Font-Size="10pt" 
                                                                Text='<%# GetAdvTitleTeam(Eval("LocalAdvanceId"), Eval("UserId"), Eval("RequestDate"))  %>' 
                                                                Visible='<%# Not IsAdvSelected(Eval("AdvanceId"))  %>' Width="100%"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" 
                                                                Visible='<%# IsAdvSelected(Eval("AdvanceId")) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </asp:Panel>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="dlTeamApproved" />
                                    <asp:PostBackTrigger ControlID="dlApproved" />
                                    <asp:PostBackTrigger ControlID="dlReceipts" />
                                    <asp:PostBackTrigger ControlID="dlNoReceipts" />
                                    <asp:PostBackTrigger ControlID="dlAdvSubmitted" />
                                    <asp:PostBackTrigger ControlID="dlAdvToApprove" />
                                    <asp:PostBackTrigger ControlID="dlAdvApproved" />
                                    <asp:PostBackTrigger ControlID="dlAdvTeamApproved" />
                                    <asp:PostBackTrigger ControlID="dlAdvPendingDownload" />
                                    <asp:PostBackTrigger ControlID="dlPendingDownload" />
                                    <asp:PostBackTrigger ControlID="dlAdvNoReceipts" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                      
                </div>
                <div>
                    <h3>
                        <a href="#" class="aLink">
                       

                           <asp:Label ID="Label8" runat="server" Font-Bold="true" ResourceKey="Processed"></asp:Label>
                          

                        </a>
                   </h3>
                    <div id="ProcessedPane">
                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                            <ContentTemplate>
                                <asp:TreeView ID="tvProcessed" runat="server" NodeIndent="10">
                                </asp:TreeView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="tvProcessed" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div>
                    <h3>
                        <a href="#" class="aLink">
                            <asp:Label ID="Label9" runat="server" Font-Bold="true" ResourceKey="Cancelled"></asp:Label></a></h3>
                    <div id="CancelledPane">
                        <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                            <ContentTemplate>
                                <asp:DataList ID="dlCancelled" runat="server" Width="100%">
                                    <ItemStyle CssClass="dnnGridItem" />
                                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                                    <ItemTemplate>
                                        <table width="100%">
                                            <tr valign="middle">
                                                <td width="100%">
                                                    <asp:LinkButton ID="LinkButton3" runat="server" Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>'
                                                        CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Bold="true" Font-Size="9pt"
                                                        Visible='<%# IsSelected(Eval("RmbNo")) %>'></asp:LinkButton>
                                                    <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# GetRmbTitle(Eval("UserRef"), Eval("RID"), Eval("RmbDate"))  %>'
                                                        CommandArgument='<%# Eval("RmbNo") %>' CommandName="Goto" Font-Size="10pt" Visible='<%# Not IsSelected(Eval("RmbNo"))  %>'></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/action_right.gif" Visible='<%# IsSelected(Eval("RmbNo")) %>' />
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="dlCancelled" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </td>
        <td width="100%" style="padding-left: 20px;">
            

           
           <asp:Panel ID="pnlSplash" runat="server" Visible="false">

<asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
         
                <asp:Literal runat="server" ID="ltSplash"></asp:Literal>
            </asp:Panel>
                
            
           
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="pnlMain" runat="server"  CssClass="ui-widget ui-widget-content ui-corner-all" >

                      <div class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" >
                        <div style="width: 100%; vertical-align: middle; font-size: 20pt; font-weight : bold; border-width:2pt; border-bottom-style: solid;   ">
                            <asp:Image ID="imgAvatar" runat="server" Width="50px" ImageUrl="/images/no_avatar.gif" style="float: left; margin-right: 5px; border-width:2pt; border-style: solid;"   />

                            <asp:Label ID="Label17" runat="server" resourcekey="Reimbursement" style="float: left; margin-right: 5px; "></asp:Label>
                            <asp:Label ID="lblRmbNo" runat="server" style="float: left; margin-right: 5px;"></asp:Label>:
                            <asp:DropDownList ID="ddlChargeTo" runat="server" AutoPostBack="true" Style="float: right; font-size: small;">
                            </asp:DropDownList>
                        </div>
                        <asp:Label ID="lblStatus" runat="server" Style="  float: left;  font-style: italic;"></asp:Label>
                      
                        <asp:Label ID="lblAccountBalance" runat="server" Style="float: right;  font-style: italic; margin-right: 3px;"  Text="searching..."></asp:Label>
                        <asp:Label ID="ttlAccountBalance" runat="server" Style="float: right;  margin-right: 3px;
                            font-style: italic;" resourceKey="AccountBalance"></asp:Label> 
                          <asp:HiddenField ID="hfAccountBalance" runat="server"  />
                        <div style="clear: both;">
                        </div> 
                        </div> 
                        <div style=" margin-top: 10px; padding: 10px;">
                        <table width="100%">
                            <tr class="Agape_SubTitle">
                                <td class="hdrTitle">
                                    <asp:Label ID="Label18" runat="server" resourcekey="SubmittedOn"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:Label ID="lblSubmittedDate" runat="server"></asp:Label>
                                </td>
                                <td class="hdrTitle">
                                    <asp:Label ID="Label19" runat="server" resourcekey="ApprovedOn"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:Label ID="lblApprovedDate" runat="server"></asp:Label>
                                </td>
                                <td class="hdrTitle">
                                    <asp:Label ID="Label20" runat="server" resourcekey="ProcessedOn"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:Label ID="lblProcessedDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="Agape_SubTitle">
                                <td class="hdrTitle">
                                    <asp:Label ID="Label21" runat="server" resourcekey="SubmittedBy"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:Label ID="lblSubBy" runat="server"></asp:Label>
                                </td>
                                <td rowspan="2" valign="top" style="color: Gray;">
                                    <asp:Label ID="ttlWaitingApp" runat="server" resourcekey="AwaitingApproval"></asp:Label>
                                    <asp:Label ID="ttlApprovedBy" runat="server" resourcekey="ApprovedBy" Visible="false"></asp:Label>
                                </td>
                                <td class="hdrValue" rowspan="2" valign="top">
                                    <asp:Label ID="lblApprovedBy" runat="server"></asp:Label>
                                </td>
                                <td class="hdrTitle">
                                    <asp:Label ID="Label22" runat="server" resourcekey="ProcessedBy"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:Label ID="lblProcessedBy" runat="server"></asp:Label>
                                </td>
                            </tr>
                            
                            

                            <tr class="Agape_SubTitle">
                                <td class="hdrTitle">
                                    <asp:Label ID="Label23" runat="server" resourcekey="YourRef"></asp:Label>
                                </td>
                                <td class="hdrValue">
                                    <asp:TextBox ID="tbYouRef" runat="server" Width="150px"></asp:TextBox>
                                </td>
                                <td id="pnlPeriodYear" runat="server" colspan="2" style="white-space: nowrap; color: Gray;">
                                    <asp:Label ID="Label24" runat="server" resourcekey="Period"></asp:Label>
                                    <asp:DropDownList ID="ddlPeriod" runat="server" Width="70px" Enabled="false" Font-Size="X-Small">
                                        <asp:ListItem Text="Default" Value="" />
                                        <asp:ListItem Text="Jan" Value="1" />
                                        <asp:ListItem Text="Feb" Value="2" />
                                        <asp:ListItem Text="Mar" Value="3" />
                                        <asp:ListItem Text="Apr" Value="4" />
                                        <asp:ListItem Text="May" Value="5" />
                                        <asp:ListItem Text="Jun" Value="6" />
                                        <asp:ListItem Text="Jul" Value="7" />
                                        <asp:ListItem Text="Aug" Value="8" />
                                        <asp:ListItem Text="Sep" Value="9" />
                                        <asp:ListItem Text="Oct" Value="10" />
                                        <asp:ListItem Text="Nov" Value="11" />
                                        <asp:ListItem Text="Dec" Value="12" />
                                    </asp:DropDownList>
                                    <asp:Label ID="Label25" runat="server" resourcekey="Year"></asp:Label>
                                    <asp:DropDownList ID="ddlYear" runat="server" Width="70px" Font-Size="X-Small" Enabled="false" >
                                        <asp:ListItem Text="Default" Value="" ></asp:ListItem>
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td colspan="2" style="font-size: 8pt; width: 33%;">
                                    <fieldset>
                                        <legend class="AgapeH4">
                                            <asp:Label ID="ttlYourComments" runat="server" resourcekey="YourComments" Visible="false" /><asp:Label
                                                ID="ttlUserComments" runat="server" Text="User's Comments" /></legend>
                                        <asp:Label ID="lbComments" runat="server" Height="60px" Visible="false"></asp:Label>
                                        <asp:TextBox ID="tbComments" runat="server" Height="55px" TextMode="MultiLine" Width="100%"></asp:TextBox>
                                    </fieldset>
                                </td>
                                <td colspan="2" style="font-size: 8pt; width: 33%;">
                                    <fieldset>
                                        <legend class="AgapeH4">
                                            <asp:Label ID="Label26" runat="server" resourcekey="ApproversComments"></asp:Label></legend>
                                        <asp:Label ID="lblApprComments" runat="server" Height="60px"></asp:Label>
                                        <asp:TextBox ID="tbApprComments" runat="server" Height="55px" TextMode="MultiLine"
                                            Width="100%" Visible="false"></asp:TextBox>
                                    </fieldset>
                                </td>
                                <td colspan="2" style="font-size: 8pt; width: 33%;">
                                    <fieldset>
                                        <legend class="AgapeH4">
                                            <asp:Label ID="Label27" runat="server" resourcekey="AccountsComments"></asp:Label></legend>
                                        <asp:Label ID="lblAccComments" runat="server" Height="60px"></asp:Label>
                                        <asp:TextBox ID="tbAccComments" runat="server" Height="35px" TextMode="MultiLine" Width="100%"
                                            Visible="false"></asp:TextBox>
                                            <asp:CheckBox ID="cbMoreInfo" runat="server" AutoPostBack="true" resourcekey="btnMoreInfo"  />
                                    </fieldset>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Button ID="addLinebtn2" runat="server" resourcekey="btnAddExpenseItem" class="aButton" />
                        <asp:Button ID="btnSubmit" runat="server" resourcekey="btnSubmit" class="aButton" />
                        <asp:Button ID="btnSave" runat="server" resourcekey="btnSave" class="aButton" />
                        <asp:Button ID="btnApprove" runat="server" resourcekey="btnApprove" class="aButton" />
                        <asp:Button ID="btnPrint" runat="server" resourcekey="btnPrint" class="aButton" />
                        <asp:Button ID="btnProcess" runat="server" resourcekey="btnProcess" class="aButton" />
                        <asp:Button ID="btnUnProcess" runat="server" resourcekey="btnUnProcess" class="aButton" />
                        <asp:Button ID="btnCancel" runat="server" resourcekey="btnCancel" class="aButton" />
                        <asp:LinkButton ID="btnDownload" runat="server">
                            <div style="vertical-align: middle; float: right; padding-top: 8px;">
                                <img src="/DesktopModules/AgapeConnect/StaffRmb/Images/Excel_icon.gif" alt="" />
                                <asp:Label ID="lblDownload" runat="server" resourcekey="btnDownload"></asp:Label>
                            </div>
                            <div style="clear: both;">
                            </div>
                        </asp:LinkButton>
                        
                            
                           
                        <%-- <button class="Excel" title="Download" >
            <asp:Label ID="Label3" runat="server" Text="Download"></asp:Label>
        </button>--%>
                        <br />
                        <br />
                        <asp:Label ID="lblTest" runat="server" Text="Label" Visible="false"></asp:Label>
                        <div style="padding: 0 20px 0 20px;">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="RmbLineNo"
                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" ShowFooter="True" >
                            <RowStyle CssClass="dnnGridItem" />
                            <AlternatingRowStyle CssClass="dnnGridAltItem" />
                            <Columns>
                                <asp:TemplateField HeaderText="TransDate" SortExpression="TransDate">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server"   Text='<%# Bind("TransDate") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" CssClass='<%# IIF(Eval("OutOfDate"), "ui-state-highlight ui-corner-all","") %>' ToolTip='<%# IIF(Eval("OutOfDate"),Translate("OutOfDate"),"") %>' Text='<%# Bind("TransDate", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Line Type" SortExpression="LineType" ItemStyle-Width="150px">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("LineType") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" CssClass='<%# IIF(IsWrongType(Eval("CostCenter"), Eval("LineType")), "ui-state-error ui-corner-all","") %>' ToolTip='<%# IIF(IsWrongType(Eval("CostCenter"), Eval("LineType")),Translate("lblWrongType"),"") %>' Text='<%# GetLocalTypeName(Eval("AP_Staff_RmbLineType.LineTypeId") )%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="Comment" SortExpression="Comment" >
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblComment" runat="server" Text='<%#  Eval("Comment")  %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalAmount" runat="server" Font-Bold="True" Text="Total:"></asp:Label>
                                    <asp:Panel ID="pnlRemBal1" runat="server" Visible='<%# Settings("ShowRemBal") = "True" %>'>
                                        <asp:Label ID="lblRemainingBalance" runat="server" Font-Size="XX-Small"   Text="Estimated Remaining Balance:"></asp:Label>
                                    </asp:Panel>
                                    </FooterTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <FooterStyle HorizontalAlign="Right" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Amount" SortExpression="GrossAmount" ItemStyle-Width="75px">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmount" runat="server" CssClass='<%# IIF(Eval("LargeTransaction"), "ui-state-highlight ui-corner-all","") %>' ToolTip='<%# IIF(Eval("LargeTransaction"),Translate("LargeTransaction"),"") %>' Text='<%#  Eval("GrossAmount", "{0:F2}") & IIF(Eval("Taxable")=True, "*", "") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%# StaffBrokerFunctions.GetSetting("Currency", PortalId) & GetTotal(Eval("RmbNo")).ToString("F2") %>'></asp:Label>
                                     <asp:Panel ID="pnlRemBal2" runat="server"  Visible='<%# Settings("ShowRemBal") = "True"%>'>
                                        <asp:Label ID="lblRemainingBalance" runat="server" Font-Size="xx-small" Text='<%# GetRemainingBalance()%>'></asp:Label>
                                    </asp:Panel>
                                    </FooterTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <FooterStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ReceiptNo" HeaderText="Receipt No" SortExpression="ReceiptNo"
                                    HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75px">
                                    <HeaderStyle ForeColor="White"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="10px" ItemStyle-Wrap="false">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton5" runat="server" CommandName="myEdit" Visible='<%# CanEdit(Eval("AP_Staff_Rmb.Status"))  %>'
                                            CommandArgument='<%# Eval("RmbLineNo") %>' resourcekey="Edit"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton6" runat="server" CommandName="mySplit" Visible='<%# (CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.Processed and CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.DownloadFailed and CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.PendingDownload)  and IsAccounts()  %>'
                                            CommandArgument='<%# Eval("RmbLineNo") %>' resourcekey="Split"></asp:LinkButton>
                                      <asp:LinkButton ID="LinkButton7" runat="server" CommandName="myDefer" ToolTip="Moves this transaction to a new 'Pending' Reimbursement." Visible='<%# (CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.Processed and CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.DownloadFailed and CInt(Eval("AP_Staff_Rmb.Status"))<>StaffRmb.rmbStatus.PendingDownload)  and IsAccounts()  %>'
                                        CommandArgument='<%# Eval("RmbLineNo") %>' resourcekey="Defer" Text="Defer"></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="" ItemStyle-Width="10px" ItemStyle-Wrap="false">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton4" runat="server" CommandName="myDelete" Visible='<%# CanEdit(Eval("AP_Staff_Rmb.Status")) %>'
                                            CommandArgument='<%# Eval("RmbLineNo") %>' resourcekey="Delete"></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle ForeColor="White" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle CssClass="ui-widget-header dnnGridFooter acGridHeader" />
                            <HeaderStyle CssClass="ui-widget-header dnnGridHeader acGridHeader" />
                            <PagerStyle CssClass="dnnGridPager" />
                            <SelectedRowStyle CssClass="dnnFormError" />
                        </asp:GridView>
                        
                        <asp:Panel ID="pnlTaxable" runat="server" Visible="false">
                            <asp:Label ID="Label28" runat="server" Font-Italic="true" resourcekey="Taxable"></asp:Label>
                        </asp:Panel>
                        </div>


                        <div style="margin-top: 15px;"  >
                        <fieldset id="pnlAdvance" runat="server" visible="false" style="float: left;">
                            <legend><span class="AgapeH4">Pay Off Advance</span> </legend>
                            <asp:Label ID="ttlAdvanceBalance" runat="server" ForeColor="Gray" resourcekey="AdvanceBalance"></asp:Label>
                            &nbsp;
                            <asp:Label ID="lblAdvanceBalance" runat="server" ForeColor="Gray" Text="searching..."></asp:Label>
                            <table>
                                <tr>
                                    <td>
                                        <%--<asp:DropDownList ID="ddlAdvanceOption" runat="server">
                            <asp:ListItem Selected="True" Value="0.00">Do not pay off advance</asp:ListItem>
                            <asp:ListItem Value="-1.00">Pay off as much as possible</asp:ListItem>
                            <asp:ListItem Value="1.00">Pay upto specified amount (enter here--->):</asp:ListItem>
                        </asp:DropDownList>--%>
                                        <dnn:Label ID="Label3" runat="server" ControlName="tbAdvanceAmount" ResourceKey="PayOff" />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbAdvanceAmount" runat="server" class="numeric"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSaveAdv" runat="server" resourcekey="btnSave" Font-Size="8pt"
                                            CommandName="Save" class="aButton" />
                                </tr>
                            </table>
                            <asp:Label ID="lblAdvError" runat="server" ForeColor="Red"></asp:Label>
                        </fieldset>
                        
                        <fieldset id="pnlError" runat="server" visible="false" style="margin-top: 15px; " >
                        <legend>
                          <asp:Label ID="Label44" runat="server" CssClass="AgapeH4" ResourceKey="lblErrorMessage"></asp:Label>
                        </legend>
                            <asp:Label ID="lblWrongType" runat="server" class="ui-state-error ui-corner-all"
                Style="padding: 3px; margin-top: 5px; display: block; " resourceKey="lblWrongTypes">


                            </asp:Label>
                        <asp:Label ID="lblErrorMessage" runat="server" class="ui-state-error ui-corner-all"
                Style="padding: 3px; margin-top: 5px; display: block; " ></asp:Label>
                          
                        </fieldset>
                        <div style="clear: both;" />
                        </div>



                        <asp:LinqDataSource ID="RmbLineDS" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EnableDelete="True" OrderBy="RmbLineNo" TableName="AP_Staff_RmbLines" Where="RmbNo == @RmbNo"
                            EnableInsert="True" EnableUpdate="True" EntityTypeName="">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfRmbNo" Name="RmbNo" PropertyName="Value" Type="Int64" />
                            </WhereParameters>
                        </asp:LinqDataSource>





                        </div>





                    </asp:Panel>
                 
                        <asp:Panel ID="pnlMainAdvance" runat="server" Visible="false"   CssClass="ui-widget ui-widget-content ui-corner-all"  >
                        <div class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" >
                         <div style="width: 100%; vertical-align: middle; font-size: 20pt; margin:3px 5px 3px 3px ; font-weight : bold; border-width:2pt; border-bottom-style: solid;  ">
                            <asp:Image ID="imgAdvAvatar" runat="server" Width="50px" ImageUrl="/images/no_avatar.gif" style="float: left; color: White ; margin-right: 5px; border-width:2pt; border-style: solid;"   />

                            <asp:Label ID="Label42" runat="server" resourcekey="Advance" style="float: left;  margin-right: 3px; color: White;"></asp:Label>
                            <asp:Label ID="lblAdvanceId" runat="server" style="float: left; color: White;"></asp:Label>:
                           
                        </div>
                       
                        <asp:Label ID="lblAdvStatus" runat="server" Style=" font-size: small; float: left;"></asp:Label>
                        <asp:Label ID="AdvBal" runat="server"  Style="font-size: small; float: right; font-style: italic; margin-right: 3px;"></asp:Label>
                          <asp:Label ID="lblAdvBal" runat="server" ResourceKey="AdvanceBalance" Style="font-size: small; float: right;  font-style: italic; margin-right: 3px;"></asp:Label>
                        <asp:Label ID="AccBal" runat="server" Style="font-size: small; float: right; font-style: italic; margin-right: 15px;"></asp:Label>
                        <asp:Label ID="lblAccBal" runat="server" ResourceKey="AccountBalance" Style="font-size: small; float: right; font-style: italic; margin-right: 3px;"></asp:Label>
                       

                       <div style="clear: both; "  ></div>
                       </div>
                        <div style="font-size: large ; margin-top: 10px; padding: 10px;">
                        <asp:Label ID="lblAdv1" runat="server" Font-Italic="true" ></asp:Label>
                          <table cellpadding="5px" style="width: 100%; margin: 10px 30px 0px 30px;  ">
                            <tr valign="top">
                                <td style="width: 200px ;">
                                    <asp:Label ID="lblAdvAmout" runat="server" ResourceKey="Amount" Font-Bold="true"></asp:Label>
                                     (<asp:Label ID="lblAdvCur" runat="server" Font-Bold="true" > </asp:Label>):
                                </td>
                                <td style="width: 500px">
                                   
                                    <asp:TextBox ID="AdvAmount" runat="server" enabled="false"></asp:TextBox>
                                </td>
                                <td rowspan="4" style="width: 200px;">
                                    <table style="color: Gray; font-size: x-small;">
                                       
                                        <asp:Panel ID="pnlAdvPeriodYear" runat="server" Visible="false">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label41" runat="server" resourcekey="Period" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td >
                                                    <asp:DropDownList ID="ddlAdvPeriod" runat="server" Width="70px" Enabled="false">
                                                        <asp:ListItem Text="Default" Value="" />
                                                        <asp:ListItem Text="Jan" Value="1" />
                                                        <asp:ListItem Text="Feb" Value="2" />
                                                        <asp:ListItem Text="Mar" Value="3" />
                                                        <asp:ListItem Text="Apr" Value="4" />
                                                        <asp:ListItem Text="May" Value="5" />
                                                        <asp:ListItem Text="Jun" Value="6" />
                                                        <asp:ListItem Text="Jul" Value="7" />
                                                        <asp:ListItem Text="Aug" Value="8" />
                                                        <asp:ListItem Text="Sep" Value="9" />
                                                        <asp:ListItem Text="Oct" Value="10" />
                                                        <asp:ListItem Text="Nov" Value="11" />
                                                        <asp:ListItem Text="Dec" Value="12" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblAdvYear" runat="server" resourcekey="Year" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlAdvYear" runat="server" Width="70px"  Enabled="false">
                                                        <asp:ListItem Text="Default" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </asp:Panel>
                                    </table>
                                    
                               
                                </td>
                            </tr>
                            <tr valign="top"  style="height: 175px; min-height: 175px;">
                                <td>
                                    <asp:Label ID="lblAdvReason" runat="server" ResourceKey="AdvReason" Font-Bold="true"></asp:Label>:
                                </td>
                                <td   class="ui-widget ui-widget-content ui-corner-all" style="width: 100%px; padding:7px 7px 7px 7px;">
                                    <asp:Label ID="AdvReason" runat="server" Font-Italic="true" Font-Size="Medium"  ></asp:Label>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Label ID="AdvDate" runat="server" Font-Italic="true" Font-Size="small" ForeColor="Gray" style="float: right; text-align: right; "  ></asp:Label>

                                   
                                   <div style="clear: both;"></div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="left" style="font-size: small; padding-top: 20px; ">
                                    <asp:Label ID="lblAdvErr" runat="server" CssClass="AgapeErrror" ></asp:Label>
                                    <asp:Button ID="btnAdvApprove" runat="server"   ResourceKey="btnApprove" CssClass="aButton" />
                                    <asp:Button ID="btnAdvReject" runat="server"   ResourceKey="btnReject" CssClass="aButton" />
                                    <asp:Button ID="btnAdvSave" runat="server" ResourceKey="btnSave" CssClass="aButton" />
                                    <asp:Button ID="btnAdvCancel" runat="server"  ResourceKey="btnCancel" CssClass="aButton" />
                                    <asp:Button ID="btnAdvProcess" runat="server"  ResourceKey="btnProcess" CssClass="aButton" />
                                    <asp:Button ID="btnAdvUnProcess" runat="server"  ResourceKey="btnUnProcess" CssClass="aButton" />
                                    <asp:LinkButton ID="btnAdvDownload" runat="server" >
                            <div style="vertical-align: middle; float: right; padding-top: 8px; margin-right: 20px">
                                <img src="/DesktopModules/AgapeConnect/StaffRmb/Images/Excel_icon.gif" alt="" />
                                <asp:Label ID="Label40" runat="server" resourcekey="btnDownload"></asp:Label>
                            </div>
                            <div style="clear: both;">
                            </div>
                        </asp:LinkButton>
                                </td>
                            </tr>

                          </table>
                          </div>
                        </asp:Panel>
                    
              


                    <asp:HiddenField ID="hfRmbNo" runat="server" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnCancel" EventName="Click" />
                    <asp:PostBackTrigger ControlID="btnDownload" />
                    <asp:PostBackTrigger ControlID="btnAdvDownload" />
                    
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
</table>
<asp:UpdateProgress ID="UpdateProgress3" runat="server" DisplayAfter="0" DynamicLayout="true"
    AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <asp:Image ID="updating3" ImageUrl="~/Images/progressbar2.gif" runat="server" /></ProgressTemplate>
</asp:UpdateProgress>

<div id="divSignin" class="ui-widget">
    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div align="left">
                    <asp:Label ID="PopupTitle" runat="server" resourcekey="NewLineTitle" CssClass="AgapeH2"></asp:Label><br />
                    <br />
                    <table style="font-size: 9pt" width="100%">
                        <tr valign="top">
                            <td style="white-space: nowrap;">
                                <b>
                                    <dnn:Label ID="Label4" runat="server" ControlName="ddlLineTypes" ResourceKey="LineTypes" />
                                </b>
                            </td>
                            <td width="100%">
                                <asp:DropDownList ID="ddlLineTypes" runat="server" DataTextField="LocalName" DataValueField="LineTypeId"
                                 AppendDataBoundItems="true"    AutoPostBack="true">
                                </asp:DropDownList>
                                  <asp:Label ID="lblIncType" runat="server" CssClass="ui-state-error ui-corner-all" Text="Incompatible Type" Visible="false"></asp:Label>

                                <div id="manualCodes" runat="server" style="float: right;">
                                    <asp:DropDownList ID="ddlAccountCode" runat="server" Width="60px" DataSourceID="dsAccountCodes"
                                        DataTextField="DisplayName" DataValueField="AccountCode" Enabled="false">
                                    </asp:DropDownList>

                                  
                                    <asp:LinqDataSource ID="dsAccountCodes" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                                        EntityTypeName="" Select="new (AccountCode,  AccountCode + ' ' + '-' + ' ' + AccountCodeName  as DisplayName )"
                                        TableName="AP_StaffBroker_AccountCodes" OrderBy="AccountCode" Where="PortalId == @PortalId">
                                        <WhereParameters>
                                            <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                                Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                    <asp:DropDownList ID="ddlCostcenter" runat="server" Width="90px" Enabled="false"
                                        DataSourceID="dsCostCenters" DataTextField="DisplayName" DataValueField="CostCentreCode"
                                        AppendDataBoundItems="true">
                                        <asp:ListItem Text="" Value="" />
                                    </asp:DropDownList>
                                    <asp:LinqDataSource ID="dsCostCenters" runat="server" ContextTypeName="StaffBroker.StaffBrokerDataContext"
                                        EntityTypeName="" OrderBy="CostCentreCode" Select="new (CostCentreCode,CostCentreCode + ' ' + '-' + ' ' + CostCentreName as DisplayName)"
                                        TableName="AP_StaffBroker_CostCenters" Where="PortalId == @PortalId">
                                        <WhereParameters>
                                            <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                                Type="Int32" />
                                        </WhereParameters>
                                    </asp:LinqDataSource>
                                </div>
                                <div style="clear: both;">
                                    &nbsp;</div>
                            </td>
                        </tr>
                    </table>
                    <asp:PlaceHolder ID="phLineDetail" runat="server"></asp:PlaceHolder>
                    <br />
                    <asp:Button ID="btnAddLine" runat="server" resourcekey="btnEnter" CommandName="Save"
                        class="aButton" />
                    <input type="button" value='<%= Translate("btnCancel") %>' onclick="closePopup();"
                        class="aButton" />
                    <br />
                    <br />
                    <fieldset id="pnlAccountsOptions" runat="server">
                        <legend>
                            <asp:Label ID="Label31" runat="server" resourcekey="AccountsOnly"></asp:Label></legend>
                        <table>
                              <tr>
                                <td>
                                        <asp:Label ID="Label43" runat="server" resourcekey="OverideTax"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlOverideTax" runat="server">
                                            <asp:ListItem Value="0" resourcekey="Default"></asp:ListItem>
                                            <asp:ListItem Value="1" resourcekey="ForceTaxable"></asp:ListItem>
                                            <asp:ListItem Value="2" resourcekey="ForceNonTaxable"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                              </tr>


                            <asp:Panel ID="pnlVAT" runat="server">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label29" runat="server" resourcekey="RecoverVAT"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="cbRecoverVat" runat="server" />
                                    </td>
                                </tr>
                                <tr id="pnlVatOveride" runat="server">
                                    <td>
                                        <asp:Label ID="Label30" runat="server" resourcekey="RecoverVATRate"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="tbVatRate" runat="server" Width="50" CssClass="numeric"></asp:TextBox>
                                    </td>
                                </tr>
                            </asp:Panel>
                        </table>
                    </fieldset>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddlLineTypes" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="btnAddLine" EventName="Click" />
                <%--  <asp:AsyncPostBackTrigger ControlID="btnPrint"  EventName="Click" />--%>
                <asp:PostBackTrigger ControlID="btnPrint" />
              <%--  <asp:PostBackTrigger ControlID="btnDownloadBatch" />
                <asp:PostBackTrigger ControlID="btnSuggestedPayments" />--%>
                <%--  <asp:PostBackTrigger ControlID="btnAddLine" />--%>
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" DynamicLayout="true"
            AssociatedUpdatePanelID="UpdatePanel2">
            <ProgressTemplate>
                <asp:Image ID="updating1" ImageUrl="~/Images/progressbar2.gif" runat="server" /></ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</div>

<div id="divAdvanceReq" class="ui-widget">
    <uc1:StaffAdvanceRmb ID="StaffAdvanceRmb1" runat="server" />
    <div style="text-align: center; width: 100%;">
        <asp:Button ID="btnAdvanceRequest" runat="server" resourcekey="btnAdvanceRequest" class="aButton" />
         <input id="Button1" type="button" value='<%= Translate("btnCancel") %>' onclick="closeAdvanceReq();"
                    class="aButton" />
    </div>
</div>

<div id="divSignin2" class="ui-widget">
    <%-- New Rmb--%>
    <div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <div class="AgapeH2">
                    <asp:Label ID="Label32" runat="server" resourcekey="btnNew"></asp:Label></div>
                <table width="100%">
                    <tr class="Agape_SubTitle">
                        <td width="60px">
                            <asp:Label ID="Label33" runat="server" resourcekey="YourRef"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tbNewYourRef" runat="server" Width="150px"></asp:TextBox>
                        </td>
                        <td width="70px">
                            Charge To:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlNewChargeTo" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr valign="top">
                        <td style="font-size: 8pt; width: 33%;">
                            <fieldset>
                                <legend class="AgapeH4">
                                    <asp:Label ID="Label34" runat="server" resourcekey="YourComments"></asp:Label></legend>
                                <asp:TextBox ID="tbNewComments" runat="server" Height="100" TextMode="MultiLine"
                                    Width="100%"></asp:TextBox>
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnCreate" runat="server" resourcekey="btnCreate" UseSubmitBehavior="false"
                    class="aButton" />
                <input id="btnCancel2" type="button" value='<%= Translate("btnCancel") %>' onclick="closePopup2();"
                    class="aButton" />
                <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0" DynamicLayout="true"
                    AssociatedUpdatePanelID="UpdatePanel3">
                    <ProgressTemplate>
                        <asp:Image ID="updating2" ImageUrl="~/Images/progressbar2.gif" runat="server" /></ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
            <Triggers>
               <%-- <asp:AsyncPostBackTrigger ControlID="btnCreate" EventName="Click" />--%>
                <asp:PostBackTrigger ControlID="btnCreate" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
<div id="divSignin3" class="ui-widget">
    <%--Not Used?--%>
    <div>
        <br />
        <b>There is not enough money in the RC to cover this Reimbursement. Processing this expense may result in a negative account balance. Do you wish to
            continue?</b><br />
        <br />
        <div width="100%" align="center">
            <asp:ImageButton ID="ImageButton2" runat="server" OnClientClick="closePopup3();"
                ImageUrl="~/images/ButtonImages/Cancel.gif" onmouseover="this.src='../images/ButtonImages/Cancel_f2.gif';"
                onmouseout="this.src='../images/ButtonImages/Cancel.gif';" class="aButton" AlternateText="Cancel"
                ToolTip="Cancel" />
            <span onclick="closePopup3()">
                <asp:HyperLink ID="blockedLink" runat="server" Target="_blank" ImageUrl="~/images/ButtonImages/ContinueS.gif"></asp:HyperLink></span>
        </div>
    </div>
</div>






<asp:Label ID="lblDefatulSettings" runat="server" ForeColor="Red" resourcekey="DefaultSettings"></asp:Label>
<div id="divSplitPopup" class="ui-widget">
    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
        <ContentTemplate>
            <div align="center">
                <fieldset>
                    <legend class="AgapeH4">
                        <asp:Label ID="Label35" runat="server" resourcekey="OriginalTrans"></asp:Label></legend>
                    <table width="100%">
                        <tr valign="middle">
                            <td width="100%">
                                <asp:Label ID="lblOriginalDesc" runat="server" Width="100%"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblOriginalAmt" runat="server" Width="100px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset>
                    <legend class="AgapeH4">
                        <asp:Label ID="Label36" runat="server" resourcekey="SplitIno"></asp:Label></legend>
                    <asp:HiddenField ID="hfRows" runat="server" Value="1" />
                    <asp:HiddenField ID="hfSplitLineId" runat="server" Value="-1" />
                    <asp:Table ID="tblSplit" runat="server" Width="100%">
                        <asp:TableRow>
                            <asp:TableCell Width="100%">
                                <asp:TextBox ID="tbSplitDesc" runat="server" Width="100%" CssClass="Description"></asp:TextBox>
                            </asp:TableCell>
                            <asp:TableCell>
                                <asp:TextBox ID="tbSplitAmt" runat="server" Width="100px" CssClass="Amount numeric"></asp:TextBox>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <div style="text-align: left; width: 100%;">
                        <asp:LinkButton ID="btnSplitAdd" runat="server" resourcekey="btnSplitAdd"></asp:LinkButton><br />
                    </div>
                </fieldset>
                <br />
                <br />
                <asp:Button ID="btnOK" runat="server" resourcekey="btnOK" class="aButton" Enabled="false" />
                <input id="btnCancel1" type="button" value='<%= Translate("btnCancel") %>' onclick="closePopupSplit();"
                    class="aButton" />
                <asp:Label ID="lblSplitError" runat="server" ForeColor="Red" resourcekey="SplitError"
                    Visible="false"></asp:Label>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnSplitAdd" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnOK" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</div>
<div id="divDownload" class="ui-widget">
    <asp:Label ID="Label37" runat="server" Font-Bold="true" resourcekey="MarkProcessed"></asp:Label><br />
    <br />
    <asp:Label ID="Label38" runat="server" Font-Italic="true" resourcekey="MarkProcessed"></asp:Label>
    <br />
    <br />
    <div width="100%" style="text-align: center">
        <asp:Button ID="btnMarkProcessed" runat="server" resourcekey="btnYes" class="aButton" />
        <asp:Button ID="btnDontMarkProcessed" runat="server" resourcekey="btnNo" class="aButton" />
    </div>
</div>
    <div id="divAccountWarning" class="ui-widget">
    <asp:Label ID="Label46" runat="server" Font-Bold="true" resourcekey="lblAccountWarning"></asp:Label>
    <br />
    <br />
    <div width="100%" style="text-align: center">
        <asp:Button ID="btnAccountWarningYes" runat="server" resourcekey="btnYes" class="aButton" />
      
        <input id="Button5" type="button" value='<%= Translate("btnNo")%>' onclick="closePopupAccountWarning();"
                    class="aButton" />
        
    </div>
</div>



</asp:Panel>

<br />

<div style="text-align: left">
<a onclick="showAdvanceReq();">
    <asp:Label ID="Label39" runat="server" ResourceKey="btnAdvReq" class="AgapeLink"></asp:Label>
</a>

    <asp:Label ID="lblMovedMenu" runat="server" Font-Size="XX-Small" Font-Italic="true" ForeColor="Gray" Text="If you are looking for Settings or Suggested Payments, these links have moved. Click the faint Manage Button at the top left of this module (over the New Reimbursment button). "></asp:Label>

&nbsp<%--; &nbsp;
<asp:LinkButton ID="btnSettings" runat="server" resourcekey="btnSettings"></asp:LinkButton>
&nbsp; &nbsp;
<asp:LinkButton ID="btnDownloadBatch" runat="server" resourcekey="btnDownloadBatch"
    OnClientClick="showDownload();">Download Batched Reimbursments</asp:LinkButton> &nbsp; &nbsp;
    
<asp:LinkButton ID="btnShowSuggestedPayments" OnClientClick="showSuggestedPayments();" runat="server" resourcekey="SuggestedPayments">Suggested Payments</asp:LinkButton>--%>
<br />

</div>


<div id="divSuggestedPayments" class="ui-widget">
    <table border="0" cellpadding="10" cellspacing="0">
        <tr>
            <td>

           
                <table>
                    <tr>
                        <td><dnn:Label ID="lblSalaries" runat="server" ControlName="cbSalaries" ResourceKey="cbSalaries" /></td>
                        <td><asp:CheckBox ID="cbSalaries" runat="server" /></td>
                    </tr>
                     <tr>
                        <td><dnn:Label ID="lblExpenses" runat="server" ControlName="cbExpenses" ResourceKey="cbExpenses" /></td>
                        <td><asp:CheckBox ID="cbExpenses" runat="server" Checked="true" /></td>
                    </tr>
                    <tr>
                        <td>
                            <dnn:Label ID="Label45" runat="server" ControlName="ddlBankAccount" ResourceKey="lblBankAccount" />
                        </td>
                        <td>
                        
                        <asp:DropDownList ID="ddlBankAccount" runat="server"  Width="60px" DataSourceID="dsAccountCodes2"
                            DataTextField="DisplayName" DataValueField="AccountCode">
                        </asp:DropDownList>
                        <asp:LinqDataSource ID="dsAccountCodes2" runat="server" ContextTypeName="StaffRmb.StaffRmbDataContext"
                            EntityTypeName="" Select="new (AccountCode,  AccountCode + ' ' + '-' + ' ' + AccountCodeName  as DisplayName )"
                            TableName="AP_StaffBroker_AccountCodes" OrderBy="AccountCode" Where="PortalId == @PortalId &amp;&amp; AccountCodeType == @AccountCodeType">
                            <WhereParameters>
                                <asp:ControlParameter ControlID="hfPortalId" DefaultValue="-1" Name="PortalId" PropertyName="Value"
                                    Type="Int32" />
                                <asp:Parameter DefaultValue="1" Name="AccountCodeType" Type="Byte" />
                            </WhereParameters>
                        </asp:LinqDataSource>
                        </td>
                    </tr>
                </table>
             


    <br />
    <br />
    <div width="100%" style="text-align: center">
        <asp:Button ID="btnSuggestedPayments" runat="server" resourcekey="btnDownload" class="aButton" OnClientClick="closeSuggestedPayments();" />
       
        <input id="Button2" type="button" value='<%= Translate("btnCancel") %>' onclick="closeSuggestedPayments();"
                    class="aButton" />
    </div>

      </td>
            <td style="border-left: 1px dashed #AAA;">
             <iframe width="300" height="169" src="https://www.youtube.com/embed/PEaTnZrpxfs?rel=0&wmode=transparent" frameborder="0" allowfullscreen></iframe>
   
            </td>
        </tr>
    </table>
</div>