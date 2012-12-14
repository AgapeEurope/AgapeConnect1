<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ViewGiveMenu.ascx.vb"
    Inherits="DotNetNuke.Modules.GiveMenu.ViewGiveMenu" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .accordionHeader
    {
        border: 1px solid #2F4F4F;
        color: white;
        background-color: #000000;
        font-family: Arial, Sans-Serif;
        font-size: 12px;
        font-weight: bold;
        padding: 5px;
        margin-top: 5px;
        cursor: pointer;
    }
    
    
    .accordionHeaderSelected
    {
        border: 1px solid #2F4F4F;
        color: white;
        background-color: #660000;
        font-family: Arial, Sans-Serif;
        font-size: 12px;
        font-weight: bold;
        padding: 5px;
        margin-top: 5px;
        cursor: pointer;
    }
    
    
    
    .accordionContent
    {
        background-color: #CCCCCC;
        border: 1px dashed #2F4F4F;
        border-top: none;
        padding: 5px;
        padding-top: 10px;
        text-align: center;
        min-height: 220px;
    }
</style>
<div style="width: 175px;">
    <cc1:Accordion ID="Accordion1" runat="server" SelectedIndex="0" HeaderCssClass="accordionHeader"
        HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent"
        AutoSize="None" FadeTransitions="true" TransitionDuration="250" FramesPerSecond="40"
        RequireOpenedPane="False" SuppressHeaderPostbacks="true" Width="100%">
        <Panes>
            <cc1:AccordionPane ID="StaffPane" runat="server" HeaderCssClass="accordionHeader"
                HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent">
                <Header>
                    Agap&eacute; Staff Member:</Header>
                <Content>
                    <div style="position: relative;">
                        <div align="left">
                            Choose a staff member from the list and press "Donate":</div>
                        <br />
                        <asp:ListBox ID="staffListBox" runat="server" Width="150px" ValidationGroup="Staff"
                            Font-Size="8pt"></asp:ListBox>
                            <asp:RequiredFieldValidator ID="staffRV" runat="server" Display="Dynamic" ControlToValidate="staffListBox"
                            ValidationGroup="Staff" ErrorMessage="Select staff member">Select a ministry</asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <asp:Button ID="theStaffButton" runat="server" Text="Donate" CssClass="aButton" ValidationGroup="Staff"/>
                </Content>
            </cc1:AccordionPane>
            <cc1:AccordionPane ID="MinistryPane" runat="server" HeaderCssClass="accordionHeader"
                HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent">
                <Header>
                    Team:</Header>
                <Content>
                    <div style="position: relative;">
                        <asp:ListBox ID="DepDDL" runat="server" Width="150px" ValidationGroup="Dep"
                            Font-Size="8pt" DataTextField="Name" DataValueField="CostCenterId" Rows="10">
                        </asp:ListBox>
                        <asp:RequiredFieldValidator ID="DepRV" runat="server" Display="Dynamic" ControlToValidate="DepDDL"
                            ValidationGroup="Dep" ErrorMessage="Select staff member">Select a ministry</asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <asp:Button ID="theDepButton" runat="server" Text="Donate" CssClass="aButton" ValidationGroup="Dep"/>

                </Content>
            </cc1:AccordionPane>
            <%--<cc1:AccordionPane id="ProjectPane" runat="server" HeaderCssClass="accordionHeader"
            HeaderSelectedCssClass="accordionHeaderSelected"
            ContentCssClass="accordionContent" >
        <Header>Project:</Header>
        <Content >
        <div  style="position: relative;">
            <asp:ListBox ID="ProjectDDL" runat="server" DataSourceID="ProjectDS" width="150px" Font-Size="8pt"
        DataTextField="ProjectName" DataValueField="ProjectID" ValidationGroup="Project"></asp:ListBox>
        </div>
        <br /><br />
      
       <asp:RequiredFieldValidator ID="ProjectRV" runat="server" Display="Dynamic" ValidationGroup="Project" ControlToValidate="ProjectDDL"  ErrorMessage="Select a project">Select a project</asp:RequiredFieldValidator>
    
        <asp:ImageButton  ID="ProjectButton" runat="server" ImageUrl="~/images/ButtonImages/Donate.gif"   ValidationGroup="Project"
                                                onmouseover="this.src='/images/ButtonImages/DonateH.gif';"  
                                                onmouseout="this.src='/images/ButtonImages/Donate.gif';" AlternateText="Donate" ToolTip="Donate"     />
     <asp:LinqDataSource ID="ProjectDS" runat="server" 
        ContextTypeName="AgapeStaff.AgapeStaffDataContext" 
           TableName="Agape_Main_Projects" 
           Where="Active == @Active &amp;&amp; GivingShortcut != @GivingShortcut" 
           OrderBy="ProjectName">
     <WhereParameters>
         <asp:Parameter DefaultValue="True" Name="Active" Type="Boolean" />
         <asp:Parameter DefaultValue="NULL" Name="GivingShortcut" Type="String" />
     </WhereParameters>
    </asp:LinqDataSource>
   
    <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" 
        TargetControlID="ProjectDDL" 
        PromptText="Type to Search" PromptCssClass="PromptCSS">
    </cc1:ListSearchExtender>
        </Content>
    </cc1:AccordionPane>--%>
        </Panes>
    </cc1:Accordion>
</div>
