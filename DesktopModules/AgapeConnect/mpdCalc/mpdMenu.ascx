<%@ Control Language="VB" AutoEventWireup="False" CodeFile="mpdMenu.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.mpdMenu" %>
<%@ Register Src="~/controls/labelcontrol.ascx" TagName="labelcontrol" TagPrefix="uc1" %>
<%@ Register Src="~/DesktopModules/AgapeConnect/mpdCalc/controls/staffTreeview.ascx" TagPrefix="uc1" TagName="staffTreeview" %>



<script src="/js/jquery.numeric.js" type="text/javascript"></script>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="/Portals/_default/Skins/AgapeBlue/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">


    (function ($, Sys) {



        $(document).ready(function () {
            $('.numeric').numeric();


            $('.aButton').button();
            $("#accordion").accordion({
                header: "> div > h3",
                navigate: false
            });

        });

    }(jQuery, window.Sys));








</script>
<style type="text/css">
    accordion-heading {
        background-color: blue;
    }

    .accordion {
    }
    .AcPane {
        height: 280px;
    }
</style>


<div class="row-fluid">
    <div id="accordion" class="span4">
        <div>
            <h3>
                <a href="#" id="Tab0" class="AcHdr">Draft</a></h3>
            <div id="DraftPane" class="AcPane">
                <asp:DataList ID="dlPending" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%#Eval("Name") & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                <uc1:staffTreeview runat="server" ID="stDraft" Mode="AllStaff" />
            </div>
        </div>
        <div>
            <h3>
                
                <a href="#" id="A1" class="AcHdr">Submitted</a></h3>
            <div id="SubmittedPane" class="AcPane">
                  
              
                  <asp:Label ID="lblToApprove" runat="server" class="Agape_SubTitle"
                                            ResourceKey="lblToApprove" Style="font-size: 8pt;">Budgets to Approve</asp:Label>
                <asp:DataList ID="dlTeamSubmitted" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# StaffBrokerFunctions.GetStaffbyStaffId(Eval("StaffId")).DisplayName & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

   <div style="width: 100%; border-bottom: dashed 1px black;">
                                            &nbsp;
                                        </div>

                  <asp:Label ID="lblYourSubmitted" runat="server" class="Agape_SubTitle"
                                            ResourceKey="lblYourSubmitted" Style="font-size: 8pt;">Your Budgets</asp:Label>
                <asp:DataList ID="dlMySubmitted" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# StaffBrokerFunctions.GetStaffbyStaffId(Eval("StaffId")).DisplayName & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                   <uc1:staffTreeview runat="server" ID="stSubmitted" Mode="AllStaff" />
            </div>
        </div>
        <div>
            <h3>
                <a href="#" id="A4" class="AcHdr">Approved</a></h3>
            <div id="Div1" class="AcPane">
                <asp:DataList ID="dlMyApproved" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# StaffBrokerFunctions.GetStaffbyStaffId(Eval("StaffId")).DisplayName & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                  <uc1:staffTreeview runat="server" ID="stTeamApproved" Mode="Team" />
                  <uc1:staffTreeview runat="server" ID="stApproved" Mode="AllStaff" />
            </div>
        </div>
        <div>
            <h3>
                <a href="#" id="A2" class="AcHdr">Processed</a></h3>
            <div id="Div2" class="AcPane">
                <asp:DataList ID="dlMyProcessed" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# StaffBrokerFunctions.GetStaffbyStaffId(Eval("StaffId")).DisplayName & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>

                  <uc1:staffTreeview runat="server" ID="stTeamProcessed" Mode="Team" />
                  <uc1:staffTreeview runat="server" ID="stProcessed" Mode="AllStaff" />
            </div>
        </div>
        <div>
            <h3>
                <a href="#" id="A3" class="AcHdr">Cancelled</a></h3>
            <div id="Div3" class="AcPane">
               <asp:DataList ID="dlMyCancelled" runat="server" Width="100%">
                    <ItemStyle CssClass="dnnGridItem" />
                    <AlternatingItemStyle CssClass="dnnGridAltItem" />
                    <ItemTemplate>

                        <table width="100%">
                            <tr valign="middle">
                                <td>
                                    <asp:Image ID="Image2" runat="server" Width="35px" ImageUrl='<%# StaffBrokerFunctions.GetStaffJointPhoto(Eval("StaffId")) %>' />
                                </td>
                                <td align="left">
                                     <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# StaffBrokerFunctions.GetStaffbyStaffId(Eval("StaffId")).DisplayName & " (" & Eval("BudgetYearStart") & ")" %>' NavigateUrl='<%# EditUrl("mpdCalc") & "?sb=" & Eval("StaffBudgetId") %>' ></asp:HyperLink>
                                </td>
                               
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                
                  <uc1:staffTreeview runat="server" ID="stCancelled" Mode="AllStaff" />
            </div>
        </div>
    </div>
</div>
