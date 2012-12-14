<%@ Control Language="vb" AutoEventWireup="false" CodeFile="BookletSettings.ascx.vb" Inherits="DotNetNuke.Modules.Booklet.Settings" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="2" border="0" summary="StoryMenuBasic Settings Design Table">
  <tr>
    <td><dnn:label id="lblWidth" runat="server" controlname="Width" suffix=":" 
            HelpText="Enter the desired width of the module in pixels. (Pages will resize automatically) " 
            Text="Module Width"></dnn:label>
    </td>
    <td>
        <asp:TextBox ID="Width" runat="server" Width="150px"></asp:TextBox>
         &nbsp; 
        <asp:Button ID="UpdateButton" runat="server" Text="Update" />
        </td>
   </tr>
    <tr>
    <td><dnn:label id="UploadLabel" runat="server" controlname="FileUpload1" suffix=":" 
            HelpText="Select an image to add, then click upload. " 
            Text="Add New Page:"></dnn:label>
    </td>
    <td>
        <asp:FileUpload ID="FileUpload1" runat="server"  /> &nbsp; <asp:Button ID="Button1" runat="server" Text="Upload" />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="BookletImage" DataSourceID="BookletDS">
    <Columns>
        <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                    CommandName="Promote"  Text="Up" 
                    CommandArgument='<%# CInt(Eval("BookletImage")) %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField ShowHeader="False">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                    CommandName="Demote" Text="Down" 
                    CommandArgument='<%# CInt(Eval("BookletImage")) %>'></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Image" SortExpression="BookletId">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("BookletId") %>'></asp:TextBox>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" 
                    
                    ImageUrl='<%# "~/DesktopModules/AgapeUK/BookletPreview/GetImageResize.aspx?Size=150&ModuleId=" & Eval("ModuleId") & "&ViewOrder=" & Eval("ViewOrder") %>' />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowDeleteButton="True" />
    </Columns>
</asp:GridView>
     </td>
   </tr>
    
    
    
</table>

<asp:LinkButton ID="ReturnButon" runat="server">Return</asp:LinkButton>



<asp:HiddenField ID="UploadFile" runat="server" />
<asp:LinqDataSource ID="BookletDS" runat="server" 
    ContextTypeName="UK.Booklet.BookletDataContext" EnableDelete="True" 
    EnableInsert="True" EnableUpdate="True" OrderBy="ViewOrder" 
    TableName="Agape_Main_BookletImages" Where="ModuleId == @ModuleId">
    <WhereParameters>
        <asp:ControlParameter ControlID="ModuleHF" Name="ModuleId" PropertyName="Value" 
            Type="Int32" />
    </WhereParameters>
</asp:LinqDataSource>
<asp:HiddenField ID="ModuleHF" runat="server" />
