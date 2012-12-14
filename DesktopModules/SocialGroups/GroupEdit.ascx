<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupEdit.ascx.cs" Inherits="DotNetNuke.Modules.Groups.GroupEdit" %>
<div class="dnnForm  DnnModule-groupsWizard">
    <div class="dnnFormItem dnnFormHelp dnnClear">
        <p class="dnnFormRequired">
            <span>
                <%=LocalizeString("RequiredFields.Text")%></span></p>
    </div>
    <div class="dnnFormItem">
        <label id="" for="">
            <%=LocalizeString("GroupName.Text")%></label>
        <asp:Literal ID="litGroupName" runat="server" />
    </div>
    <div class="dnnFormItem">
        <label id="Label1" for="">
            <%=LocalizeString("Description.Text")%></label>
        <asp:TextBox ID="txtDescription" Columns="20" Rows="2" TextMode="MultiLine" runat="server" />
    </div>
    <div class="dnnFormItem">
        <label id="Label2" for="">
            <%=LocalizeString("GroupPicture.Text")%></label>
        <div class="thumb">
            <span>
                <img id="imgGroup" runat="server" width="50" src=""
                    alt="Group Thumbnail" />
                <%--<a href="#" class="removeThumb"><%=LocalizeString("Remove.Text")%></a>--%>
            </span>
            <p>
                <%=LocalizeString("GroupPicture.Help")%>
            </p>
            <br />
            <asp:FileUpload ID="inpFile" runat="server" />
        </div>
    </div>

    <div class="dnnFormItem">
        <label id="Label3" for="">
            <%=LocalizeString("Accessibility.Text")%></label>
        <table>
            <tr>
                <td>
                    <asp:RadioButton ID="rdAccessTypePublic" GroupName="AccessType" runat="server" Checked="true" /><strong><%=LocalizeString("Public.Text")%></strong>
                    <%=LocalizeString("Public.Help")%>
                </td>
            </tr>
            <tr id="trMem">
                <td>
                    <div style="margin-left: 16px; font-size: 11px;">
                        <asp:CheckBox ID="chkMemberApproved" runat="server" /><%=LocalizeString("MembersMustBeApproved") %></div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButton ID="rdAccessTypePrivate" GroupName="AccessType" runat="server" /><strong><%=LocalizeString("Private.Text")%></strong>
                    <%=LocalizeString("Private.Help")%>
                </td>
            </tr>
        </table>
    </div>
    <!--close dnnFormItem-->
    <ul class="dnnActions dnnClear">
        <li>
            <asp:LinkButton ID="btnSave" runat="server" CssClass="dnnPrimaryAction" Text="Save Group"
                resourcekey="SaveGroupButton" />
        </li>
        <li>
            <asp:LinkButton ID="btnCancel" runat="server" CssClass="dnnSecondaryAction" Text="Cancel"
                resourcekey="Cancel" CausesValidation="False" /></li>
    </ul>
    <!--close dnnActions-->
</div>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#<%=rdAccessTypePublic.ClientID %>').change(function () {
            $('#trMem').show();

        });
        $('#<%=rdAccessTypePrivate.ClientID %>').change(function () {
            $('#trMem').hide();

        });
    });
</script>
