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

            //Startup Routine
            $('.monthly').each(function() { setMinMax($(this)); });
            $('.yearly').each(function() {setMinMax($(this))});
            $('.monthly.net').each(function() {
                var f = $(this).siblings("input['type'='hidden']").val();

                f = f.replace(/\{NET}/g, $(this).val());
                f=replaceTags(f);
               
                $(this).parent().find(".net-tax-month").text(eval(f).toFixed(0));

                $(this).parent().parent().siblings().find('.net-tax-year').text((eval(f) * 12.0).toFixed(0));
                   
                $(this).siblings('.net-tax').find("input[type=hidden]").val(eval(f).toFixed(0)); 
            });
            
            handleFormulas();

            $('.sectionTotal').each(function () {
                calculateSectionTotal($(this).parent().parent().parent().parent());
            });



            //Event Handlers
            $('.monthly').keyup(function () {
                //SetValidation
                setMinMax($(this));



                if ($(this).val().length > 0)
                    $(this).parent().parent().siblings().find('.yearly').val((parseFloat($(this).val()) * 12).toFixed(0));



                handleFormulas();
                if ($(this).hasClass('net')) {
                    var f = $(this).siblings("input['type'='hidden']").val();

                    f = f.replace(/\{NET}/g, $(this).val());
                    f=replaceTags(f);
                    // console.log(f)
                    // alert(f);
                    $(this).parent().find(".net-tax-month").text(eval(f).toFixed(0));

                    $(this).parent().parent().siblings().find('.net-tax-year').text((eval(f) * 12.0).toFixed(0));
                   
                    $(this).siblings('.net-tax').find("input[type=hidden]").val(eval(f).toFixed(0));

                }
                calculateSectionTotal($(this).parent().parent().parent().parent().parent().parent());
                
            });





            $('.yearly').keyup(function () {
                setMinMax($(this));
                var monthly = $(this).parent().parent().siblings().find('.monthly');
                if ($(this).val().length > 0)
                    $(monthly).val((parseFloat($(this).val()) / 12).toFixed(0));


                if ($(this).hasClass('net')) {
                    var f = $(monthly).siblings("input['type'='hidden']").val();

                    f = f.replace("{NET}", $(monthly).val());

                    $(monthly).parent().find(".net-tax-month").text(eval(f).toFixed(0));

                    $(this).parent().find(".net-tax-year").text((eval(f) * 12.0).toFixed(0));
                    $(monthly).parent().find(".net-tax-month").siblings("input['type'='hidden']").val(eval(f).toFixed(0));

                }
                calculateSectionTotal($(this).parent().parent().parent().parent().parent().parent());

            });

         


            $('#<%= cbCompliance.ClientID%>').change(function () {

                if (this.checked)
                    $('#<%= btnSubmit.ClientID%>').removeAttr("disabled");
                else
                    $('#<%= btnSubmit.ClientID%>').attr("disabled", "disabled");
            });



            $('.mpd-tax-detail input').keyup(function () {
                
                var ddl = $(this).parent().parent().parent().parent().parent().find('.mpd-tax-mode');
                var m = $(ddl).val();
                
                var f = '';
                if (m == 'FIXED_RATE') {
                    var r = $(ddl).siblings('.mpd-tax-rate').find('.rate').val();
                    f = '(({NET}*12) / ( ( 100 / ' + r + ' ) -1 ))/12';
                    $(ddl).parent().find('.tax-formula').text(f);
                    $(ddl).parent().find('.tax-formula').siblings("input['type'='hidden']").val(f);
                }
                else if (m == 'FIXED_AMOUNT') {
                    f = $(ddl).siblings('.mpd-tax-fixed').find('.fixed').val();
                    $(ddl).parent().find('.tax-formula').text(f);
                    $(ddl).parent().find('.tax-formula').siblings("input['type'='hidden']").val(f);
                }
                else if (m == 'ALLOWANCE') {
                    //TODO: Generate Allowance Formula
                    // $(this).siblings('.mpd-tax-allowance').show();
                    var r = $(ddl).siblings('.mpd-tax-allowance').find('.rate').val();
                    var th = $(ddl).siblings('.mpd-tax-allowance').find('.threshold').val();
                    f = 'Math.max((({NET}*12)-' + th + '/ ( ( 100 / ' + r + ' ) -1 ),0)/12';
                    $(ddl).parent().find('.tax-formula').text(f);
                    $(ddl).parent().find('.tax-formula').siblings("input['type'='hidden']").val(f);

                }
                else if (m == 'BANDS') {
                  
                    var r1 = $(ddl).siblings('.mpd-tax-bands').find('.rate1').val();
                    
                    var th1 = $(ddl).siblings('.mpd-tax-bands').find('.threshold1').val();
                    var r2 = $(ddl).siblings('.mpd-tax-bands').find('.rate2').val();
                    var th2 = $(ddl).siblings('.mpd-tax-bands').find('.threshold2').val();
                    var r3 = $(ddl).siblings('.mpd-tax-bands').find('.rate3').val();
                    var th3 = $(ddl).siblings('.mpd-tax-bands').find('.threshold3').val();
                    var r4 = $(ddl).siblings('.mpd-tax-bands').find('.rate4').val();
                    

                    if (r1 != '') {
                        if (th1 == '')
                            f = r1!=0 ?  '({NET}*12) / ( ( 100 / ' + r1 + ' ) -1 )' : '0 ';
                        else {
                            f = r1!=0 ?  'Math.max(Math.min(({NET}*12) / ( ( 100 / ' + r1 + ' ) -1 ),(' + th1 + ')/( ( 100 / ' + r1 + ' ) -1 )),0) ' : '0';
                            if (r2 != '') {
                                if (th2 == '')
                                    f +=  r2!=0 ? ' + Math.max( (({NET}*12) - ' + th1 + ') / ( ( 100 / ' + r2 + ' ) -1 ),0) ' : '';
                                else {
                                    f += r2 != 0 ? ' + Math.max(Math.min((({NET}*12) - ' + th1 + ') / ( ( 100 / ' + r2 + ' ) -1 ),( ' + th2 + ' - ' + th1 + ')/( ( 100 / ' + r2 + ' ) -1 )),0) ' : '';
                                    if (r3 != '') {
                                        if (th3 == '')
                                            f += r3!=0 ? ' + Math.max( (({NET}*12) - ' + th2 + ') / ( ( 100 / ' + r3 + ' ) -1 ),0) ' : '';
                                        else {
                                            f += r3 != 0 ? ' + Math.max(Math.min((({NET}*12)- ' + th2 + ') / ( ( 100 / ' + r3 + ' ) -1 ),( ' + th3 + ' - ' + th2 + ')/( ( 100 / ' + r3 + ' ) -1 )),0) ' : '';
                                            if (r4 != '') {
                                               
                                                f += r4!=0 ?  ' + Math.max( (({NET}*12) - ' + th3 + ') / ( ( 100 / ' + r4 + ' ) -1 ),0) ': '';
                                              
                                            }

                                        }
                                    }

                                }
                            }
                        }
                    }
                    f = '(' + f + ')/12';


                    $(ddl).parent().find('.tax-formula').text(f);
                    $(ddl).parent().find('.tax-formula').siblings("input['type'='hidden']").val(f);
                }
                else if (m == 'Custom') {
                    //Do Validation?
                    $(this).siblings("input['type'='hidden']").val(f);
                }

                

            })

            $('.mpd-edit-mode').change(function () {
                
                
                var m = $(this).val();
                $(this).parent().parent().parent().parent().parent().siblings().find('.mpd-edit-mode-detail').hide();
                $(this).parent().parent().parent().parent().parent().siblings().find('.mpd-edit-mode-detail').find('.mpd-tax-mode').change()
                if (m == 'CALCULATED') {
                    $(this).parent().parent().parent().parent().parent().siblings().find('.mpd-edit-formula').show();
                }
                else if (m == 'NET_MONTH' || m == 'NET_YEAR') {
                    $(this).parent().parent().parent().parent().parent().siblings().find('.mpd-edit-net').show();
                }
                
            });

            $('.mpd-tax-mode').change(function () {
                $(this).parent().find('.tax-formula').attr('readonly', 'readonly');
                
                var m = $(this).val();
               
                $(this).siblings('.mpd-tax-detail').hide();
                if (m == 'FIXED_RATE') {
                    $(this).siblings('.mpd-tax-rate').show();
                    $(this).parent().find('.tax-formula').text('');
                    $(this).parent().find('.tax-formula').siblings("input['type'='hidden']").val('');
                    $(this).siblings('.mpd-tax-rate').find('.rate').keyup();
                }
                else if (m == 'FIXED_AMOUNT') {
                    $(this).siblings('.mpd-tax-fixed').show();
                    $(this).parent().find('.tax-formula').text('')
                    $(this).parent().find('.tax-formula').siblings("input['type'='hidden']").val('');
                    $(this).siblings('.mpd-tax-fixed').find('.fixed').keyup();
                }
                else if (m == 'ALLOWANCE') {
                    $(this).siblings('.mpd-tax-allowance').show();
                    $(this).parent().find('.tax-formula').text('')
                    $(this).parent().find('.tax-formula').siblings("input['type'='hidden']").val('');
                    $(this).siblings('.mpd-tax-allowance').find('.rate').keyup();
                }
                else if (m == 'BANDS') {
                    $(this).siblings('.mpd-tax-bands').show();
                    $(this).parent().find('.tax-formula').text('')
                    $(this).parent().find('.tax-formula').siblings("input['type'='hidden']").val('');
                    $(this).siblings('.mpd-tax-bands').find('.rate1').keyup();
                }
                else if (m == 'Custom') {
                    $(this).siblings('.tax-custom-help').show();
                    $(this).parent().find('.tax-formula').removeAttr('readonly');
                    
                }


            });

            $('.edit-cancel').click(function () {
                $('.mpd-edit').hide("slow");
                $('.btn-edit').show();
                $('.btn-insert').show();
            });

            $('.btn-edit,.btn-insert').click(function () {
                
                $('.mpd-edit').hide("slow");

                $(this).parent().parent().siblings('.mpd-edit').find('.mpd-edit-mode').change();


                $(this).parent().parent().siblings('.mpd-edit').show("slow");


               

                $('.btn-edit,.btn-insert').show();
               
                $(this).hide();
            });

            $('.btn-section-insert').click(function(){
                $('.mpd-section-insert').show("slow") ;
                $(this).hide();
            });
            $('.insert-cancel').click(function () {
                $('.mpd-section-insert').hide("slow");
                $('.btn-section-insert').show();
               
            });
            $('.btn-edit-section').click(function(){
                $(this).siblings('.mpd-edit-section').show();
                $(this).siblings('.mpd-section-title').hide();
                $(this).hide();
            });
            $('.btn-edit-section-cancel').click(function(){
                $(this).parent().siblings('.btn-edit-section').show();
                $(this).parent().siblings('.mpd-section-title').show();
                $(this).parent().hide();
            });
        });
        
      


        //alert(replaceTags('Age: {AGE}; Age2: {AGE2}; StaffType: {STAFFTYPE}; IsCouple: {ISCOUPLE};'));
    }(jQuery, window.Sys));


    function calculateSectionTotal(section) {
        var sum = 0.0;
        section.find('.yearly').each(function (i, n) {
            if ($(n).val().length > 0)
                sum += parseFloat($(n).val().replace(/\,/g, ''))

        });
        section.find('.net-tax-year').each(function (i, n) {
            if ($(n).text().length > 0)
                sum += parseFloat($(n).text().replace(/\,/g, ''))

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


    function handleFormulas() {
        $('.calculated').each(function () {
            //Go through each formula and refresh the values
            var f = $(this).siblings("input['type'='hidden']").val();
            f=replaceTags(f);
            console.log(f);
            $(this).val(eval(f).toFixed(0));



            if ($(this).val().length > 0)
                $(this).parent().parent().siblings().find('.yearly').val((parseFloat($(this).val()) * 12).toFixed(0));

            calculateSectionTotal($(this).parent().parent().parent().parent().parent());

        });
    }
    function replaceTags(f) {
        //Replace ItemValue Taxs {1.1}
        if(f==undefined)
            return '';
        $('.version-number').each(function () {
            var v = $(this).parent().find('.monthly').val();
            if( v != undefined && $(this).text() != undefined)
            {
                v = v == '' ? 0 : v;
                

                f = f.replace(new RegExp('{' + $(this).text() + '}','g'), v);
            }
             
        });
      
        //Replace Age Tag {AGE}
        var age = <%= Age1%> ;
     
        if(age>0) f = f.replace(/{AGE}/g, age);
        
        if ('<%= IsCouple() %>' == 'True'){
            var age2 = <%= Age2%> ;
            if(age2>0) f = f.replace(/{AGE2}/g, age2);
        }
        
        f = f.replace(/{STAFFTYPE}/g, '<%=StaffType %>');
        f = f.replace(/{ISCOUPLE}/g, '<%=IsCouple %>');
        
        f = f.replace(/{AGE}/g, '');
        f = f.replace(/{AGE2}/g, '');
        f = f.replace(/{STAFFTYPE}/g, '');
        f = f.replace(/{ISCOUPLE}/g, '');
        f = f.replace(/\{.*\}/g, '0');

        return f;
    }

    function setMinMax(m){
        var min = $(m).attr('data-min');
        var max = $(m).attr('data-max');

        min = replaceTags(min);
        max = replaceTags(max);
        if (min=='') $(m).removeAttr('min');
        else $(m).attr('min',eval(min));
                

           
        if (max=='') $(m).removeAttr('max');
        else $(m).attr('max',eval(max));
       
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

    .btn-edit {
        position: absolute;
        right: 8px;
    }

    .btn-insert {
        font-style: italic;
        text-align: center;
        position: relative;
        top: -0.8em;
        background-color: #F5F5F5;
    }

    .mpd-insert {
        width: 100%;
        text-align: center;
        border-top: 1pt dashed gainsboro;
    }

    .btn-insert-section {
        font-style: italic;
        text-align: center;
        position: relative;
        top: -0.8em;
        background-color: #F5F5F5;
    }

    .mpd-insert-section {
        width: 100%;
        text-align: center;
        border-top: 1pt dashed gainsboro;
        border-bottom: 1pt dashed gainsboro;
        margin-bottom: 5px;
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

    .net-tax {
        font-size: small;
        color: gray;
        font-style: italic;
    }

    .mpd-edit {
        margin-top: 10px;
    }

    .comment {
        font-size: x-small;
        font-weight: bold;
    }

    .exFormula {
        width: 100%;
        text-align: center;
        font-family: 'Courier New';
        font-size: small;
    }

    .valid, .invalid {
        margin-top: 5px;
        float: right;
    }

    .mpd-section-total {
        border-top: 1pt solid gainsboro;
    }

    .control-group.mpd-insert-mode {
        margin-bottom: 0 !important;
    }

    .mpd-btn-order {
        float: right;
        padding: 12px 4px 12px 4px;
    }

    .btn-edit-section {
        margin: 24px 0 0 5px;
        float: left;
    }
</style>

<asp:HiddenField ID="hfAssessment" runat="server" Value="0.0" />




<div id="formRoot" class="form-horizontal">

    <asp:Repeater ID="rpSections" runat="server">

        <ItemTemplate>

            <asp:ImageButton ID="ImageButton1" runat="server" class="mpd-btn-order" ImageUrl="~/images/action_up.gif" CommandName="UP" CommandArgument='<%# Eval("SectionId")%>'  Visible='<%# Eval("Number") > 1 And IsEditMode()%>' formnovalidate />
            <asp:ImageButton ID="ImageButton2" runat="server" class="mpd-btn-order" ImageUrl="~/images/action_down.gif" CommandName="DOWN" CommandArgument='<%# Eval("SectionId")%>' Visible='<%# Eval("Number")< LastSection  And IsEditMode()%>' formnovalidate />
            <div class="mpd-section-title" style="float: left;">
                <h3>
                    <asp:Label ID="lblSectionName" runat="server" Text='<%# Eval("Name")%>'></asp:Label></h3>
            </div>

            <asp:HyperLink ID="btnEditSectionName" runat="server" CssClass="btn-edit-section" Visible='<%# IsEditMode%>'>Edit</asp:HyperLink>
            <div class="mpd-edit-section" style="display: none">
                <asp:TextBox ID="tbSectionName" runat="server" Font-Size="X-Large" Font-Bold="true" Width="300px" Text='<%# Eval("Name")%>'></asp:TextBox>
                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("SectionId")%>' CommandName="EditSectionTitle" formnovalidate>Save</asp:LinkButton>
                &nbsp; &nbsp;
                    <a href="#" class="btn-edit-section-cancel">Cancel</a>
            </div>

           
            <div style="clear: both;" />
            </h3>
             
            <div class="well">

                <asp:Repeater ID="rpItems" runat="server" DataSource='<%# CType(Eval("AP_mpdCalc_Questions"), System.Data.Linq.EntitySet(Of MPD.AP_mpdCalc_Question)).OrderBy(Function (c) c.QuestionNumber)%>'>

                    <ItemTemplate>
                        <uc1:mpdItem runat="server" ID="theMpdItem" SectionId='<%# Eval("SectionId")%>' QuestionId='<%# Eval("QuestionId")%>' Mode='<%# Eval("Type")%>'
                            Formula='<%# Eval("Formula")%>' ItemName='<%# GetName(Eval("QuestionId"),Eval("Name"))%>' Help='<%# Eval("Help")%>'
                            Monthly='<%# GetAnswer(Eval("QuestionId"))%>'
                            ItemId='<%# Eval("AP_mpdCalc_Section.Number") & "." & Eval("QuestionNumber")%>' TaxSystem='<%# Eval("TaxSystem")%>'
                            Threshold1='<%# CType(Eval("Threshold1"), Nullable(Of Decimal))%>' Threshold2='<%# CType(Eval("Threshold2"), Nullable(Of Decimal))%>' Threshold3='<%# CType(Eval("Threshold3"), Nullable(Of Decimal))%>'
                            Rate1='<%# CType(Eval("Rate1"), Nullable(Of Double))%>' Rate2='<%#  CType(Eval("Rate2"), Nullable(Of Double))%>' Rate3='<%# CType(Eval("Rate3"), Nullable(Of Double))%>' Rate4='<%#  CType(Eval("Rate4"), Nullable(Of Double))%>'
                            Fixed='<%# Eval("Fixed")%>' Min='<%# Eval("Min")%>' Max='<%# Eval("Max")%>' />
                    </ItemTemplate>

                </asp:Repeater>

                <uc1:mpdItem runat="server" ID="mpdItem14" SectionId='<%# Eval("SectionId")%>' QuestionId='-1' Mode='INSERT' Formula='' ItemName='' Help='' ItemId='<%# Eval("Number") & "." & GetMaxQuestionNumber(Eval("AP_mpdCalc_Questions"))%>' TaxSystem='FIXED_RATE' Min='0' />

                <uc1:mpdTotal runat="server" ID="totSection1" ItemName="Total Salary & Payroll" Bold="True" IsSectionTotal="True" />
            </div>
        </ItemTemplate>

    </asp:Repeater>

    <asp:Panel ID="pnlInsert" runat="server" Visible="false">
        <div class="mpd-insert-section">
            <asp:HyperLink ID="hlInsert" runat="server" CssClass="btn-section-insert">Insert New Section</asp:HyperLink>
        </div>
        <asp:Panel ID="Panel1" runat="server" class="mpd-section-insert well" Style="display: none;">
            <div class="control-group span5">
                <label class="control-label" style="width: 160px">Section Title</label>
                <div class="controls">
                    <asp:TextBox ID="tbInsertSectionName" runat="server" placeholder="Section Title" ValidationGroup="insertSection" required="required"></asp:TextBox>

                </div>
            </div>
            <div class="control-group span4">
                <label class="control-label" style="width: 160px">Display at index:</label>
                <div class="controls">
                    <asp:DropDownList ID="ddlInsertOrder" runat="server" Width="110px" AppendDataBoundItems="true">
                        <asp:ListItem Text="1 - Top" Value="1"></asp:ListItem>

                    </asp:DropDownList>
                </div>
            </div>
            <div class="control-group span3">
                <asp:Button ID="btnInsertSection" runat="server" Text="Insert" CssClass="btn btn-primary" formnovalidate />
                &nbsp;&nbsp;
            <input type="button" id="insert-cancel" class="btn insert-cancel" value="Cancel" />
            </div>
        </asp:Panel>


    </asp:Panel>

    <div class="well">
        <asp:Label ID="lblPercentage" runat="server" class="percentage" Text=""></asp:Label>
        <uc1:mpdTotal runat="server" ID="totSubTotal" ItemName="SubTotal" Bold="false" Mode="monthly" IsSubtotal="True" />
        <uc1:mpdTotal runat="server" ID="totAssessment" ItemName="Assessment (12%)" Bold="false" Mode="monthly" IsAssessment="True" />
        <uc1:mpdTotal runat="server" ID="totGoal" ItemName="MPD Goal" Bold="True" Mode="monthly" IsMPDGoal="True" />
        <uc1:mpdItem runat="server" ID="itemCurrent" ItemName="Current Support Level" ItemId="" Help="" Mode="BASIC_MONTH" IsCurrentSupport="True" />

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
