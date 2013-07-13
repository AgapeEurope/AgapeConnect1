<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdCalc.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdCalc" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/mpdItem.ascx" TagPrefix="uc1" TagName="mpdItem" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/mpdTotal.ascx" TagPrefix="uc1" TagName="mpdTotal" %>

<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">



    (function ($, Sys) {



        $(document).ready(function () {
            $('.numeric').numeric();


            $('.aButton').button();




            $('.monthly').keyup(function () {
                if ($(this).val().length > 0)
                    $(this).parent().parent().siblings().find('.yearly').val((parseFloat($(this).val()) * 12).toFixed(0));

                calculateSectionTotal($(this).parent().parent().parent().parent().parent());
            });
            $('.yearly').keyup(function () {
                if ($(this).val().length > 0)
                    $(this).parent().parent().siblings().find('.monthly').val((parseFloat($(this).val()) / 12).toFixed(0));
                calculateSectionTotal($(this).parent().parent().parent().parent());
            });
            $('.sectionTotal').each(function () {
                calculateSectionTotal($(this).parent().parent().parent().parent());
            });
            $('#<%= cbCompliance.ClientID%>').change(function () {

                if (this.checked)
                    $('#<%= btnSubmit.ClientID%>').removeAttr("disabled");
                else
                    $('#<%= btnSubmit.ClientID%>').attr("disabled", "disabled");
            });



        });
    }(jQuery, window.Sys));
    function calculateSectionTotal(section) {
        var sum = 0.0;
        section.find('.yearly').each(function (i, n) {
            if ($(n).val().length > 0)
                sum += parseFloat($(n).val().replace(/\,/g, ''))

        });

        section.find('.section-total-yearly').text(sum.toFixed(0));
        section.find('.section-total-monthly').text((sum / 12).toFixed(0));
        sum = 0.0;
        $('.sectionTotal').each(function (i, n) {
            if ($(n).text().length > 0)
                sum += parseFloat($(n).text().replace(/\,/g, ''))

        });
        var st = (sum / 12)
        $('.subtotal').text(st.toFixed(0));

        var a = parseFloat($('#<%= hfAssessment.ClientId %>').val()) / 100;
         var a1 = (st * a / (1 - a));

         $('.assessment').text(a1.toFixed(0));
         var g = st + a1
         $('.mpdGoal').text(g.toFixed(0));
         var current = parseFloat($('.currentSupport').val().replace(/\,/g, ''));

         var rem = g - current
         $('.remaining').text(rem.toFixed(0));

         var p = current * 100 / g;
         if (p < 5000)
             $('.percentage').text(p.toFixed(1) + '%');
         else
             $('.percentage').text('');
     }


</script>
<style type="text/css">
    .mpdInput {
        width: 70px;
    }

    .mpdColumn {
        text-align: right;
    }

    .mpd-help {
        padding-left: 10px;
    }

    .mpdEdit {
        float: right;
    }

    .version-number {
        width: 20px;
        float: left;
        font-size: small;
        font-weight: bold;
        color: lightgray;
    }

    .form-horizontal .control-label {
        width: 200px;
    }

        .form-horizontal .control-label.conf {
            width: 180px;
            margin-left: 8px;
        }

    .checkbox label {
        display: inline-block;
    }

    .checkboxOuter {
        padding: 20px 80px 20px 80px;
    }

    .form-horizontal .control-group.mpdTotal {
        margin-bottom: 0px;
    }

    .percentage {
        float: right;
        font-size: 56pt;
        margin: 55px 100px 15px 15px;
        font-weight: bold;
        position: absolute;
        right: 50px;
    }
</style>

<asp:HiddenField ID="hfAssessment" runat="server" Value="0.0" />







<div id="formRoot" class="form-horizontal">

    <asp:Repeater ID="rpSections" runat="server">

        <ItemTemplate>
            <h3>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
            </h3>
            <div class="well">

                <asp:Repeater ID="rpItems" runat="server" DataSource='<%# Eval("AP_mpdCalc_Questions")%>'>
                    
                    <ItemTemplate>
                        <uc1:mpdItem runat="server" ID="mpdItem14" Monthly="" ItemName='<%# Eval("Name")%>' ItemId='<%# Eval("AP_mpdCalc_Section.Number") & "." & Eval("QuestionNumber")%>' Help="Please enter Jon's Gross Salary" />
                    </ItemTemplate>
                </asp:Repeater>
           
            <uc1:mpdTotal runat="server" ID="totSection1" ItemName="Total Salary & Payroll" Bold="True" IsSectionTotal="True" />
         </div>
    </ItemTemplate>
        
    </asp:Repeater>

    
    <div class="well">
        <asp:Label ID="lblPercentage" runat="server" class="percentage" Text=""></asp:Label>
        <uc1:mpdTotal runat="server" ID="totSubTotal" ItemName="SubTotal" Bold="false" Mode="monthly" IsSubtotal="True" />
        <uc1:mpdTotal runat="server" ID="totAssessment" ItemName="Assessment (12%)" Bold="false" Mode="monthly" IsAssessment="True" />
        <uc1:mpdTotal runat="server" ID="totGoal" ItemName="MPD Goal" Bold="True" Mode="monthly" IsMPDGoal="True" />
        <uc1:mpdItem runat="server" ID="itemCurrent" ItemName="Current Support Level" ItemId="" Help="" IsCurrentSupport="True" />

        <uc1:mpdTotal runat="server" ID="totRemaining" ItemName="Amount to discover" Bold="false" Mode="monthly" IsRemaining="True" />
        <div style="clear: both" />
        <div class="checkboxOuter">

            <asp:CheckBox ID="cbCompliance" runat="server" CssClass="checkbox" Text="Optional Complience Statement  - e.g. All donaitons that I have received have been forwarded to the National Office." />
        </div>
        <div style="width: 100%; text-align: center;">
            <asp:Button ID="btnSave" runat="server" Text="Save" Font-Size="X-Large" CssClass="btn" />
            &nbsp;&nbsp;
     <asp:Button ID="btnSubmit" runat="server" Text="Submit" Font-Size="X-Large" CssClass="btn btn-primary" Enabled="false" />
        </div>
    </div>

</div>
