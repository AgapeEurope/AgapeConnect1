<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Create.ascx.cs" Inherits="DotNetNuke.Modules.Groups.Create" %>
<% if (CanCreate) { %>
<div class="dnnForm  DnnModule-groupsWizard">
    <div class="content">
        <fieldset class="group-wizard-step-1 wizardGroup" id="step1">
            <h2 class="WizardStepTitle">
                <span id="" class="Head"><strong><%= LocalizeString("CreateGroup.Text")%></strong></span>
            </h2>
            <div class="wizardStepBody">
                <div class="dnnFormItem dnnFormHelp dnnClear">
                    <p class="dnnFormRequired">
                        <span><%=LocalizeString("RequiredFields.Text")%></span></p>
                </div>
                <div class="dnnFormItem">
                    <label id="" for="">
                        <%=LocalizeString("GroupName.Text")%></label>
                        <asp:TextBox ID="txtGroupName" runat="server" MaxLength="50" class="dnnFormRequired" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtGroupName" 
                CssClass="dnnFormMessage dnnFormError" ResourceKey="GroupName.Required" />
                        <asp:Label id="reqGroupName" runat="server" CssClass="dnnFormMessage dnnFormError" resourcekey="GroupNameInvalid" Visible="false" />
                </div>
                <!--close dnnFormItem-->
                <div class="dnnFormItem">
                    <label id="" for="">
                        <%=LocalizeString("Description.Text")%></label>
                        <asp:TextBox ID="txtDescription" Columns="20" Rows="2" TextMode="MultiLine" runat="server" />               
                </div>
                <!--close dnnFormItem-->
                <div class="dnnFormItem">
                    <label id="" for="">
                        <%=LocalizeString("GroupPicture.Text")%></label>
                    <div class="thumb">
                        <span>
                            <img src="<%=Page.ResolveUrl("~/DesktopModules/SocialGroups/Images/") %>sample-group-profile.jpg" alt="Group Thumbnail" />
                            <%--<a href="#" class="removeThumb"><%=LocalizeString("Remove.Text")%></a>--%> </span>
                        <p><%=LocalizeString("GroupPicture.Help")%>
                            </p>
                        <br />
                        <asp:FileUpload ID="inpFile" runat="server" />
                  
                    </div>
                </div>
                <!--close dnnFormItem-->
                <hr />
                <div class="dnnFormItem">
                    <label id="" for="">
                        <%=LocalizeString("Accessibility.Text")%></label>
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdAccessTypePublic" GroupName="AccessType" runat="server" Checked="true" /><strong><%=LocalizeString("Public.Text")%></strong> <%=LocalizeString("Public.Help")%>
                            </td>
                        </tr>
                        <tr id="trMem">
                            <td><div style="margin-left:16px;font-size:11px;"><asp:CheckBox ID="chkMemberApproved" runat="server" /><%=LocalizeString("MembersMustBeApproved") %></div></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:RadioButton ID="rdAccessTypePrivate" GroupName="AccessType" runat="server" /><strong><%=LocalizeString("Private.Text")%></strong> <%=LocalizeString("Private.Help")%>
                            </td>
                        </tr>
                    </table>
                </div>
                <!--close dnnFormItem-->
                <ul class="dnnActions dnnClear">
                    <li><asp:LinkButton ID="btnCreate" runat="server" CssClass="dnnPrimaryAction" Text="Create Group" resourcekey="CreateGroupButton" /> </li>
                    <li><asp:LinkButton ID="btnCancel" runat="server" CssClass="dnnSecondaryAction" Text="Cancel" resourcekey="Cancel" CausesValidation="False" /></li>
                </ul>
                <!--close dnnActions-->
            </div>
            <!--close wizardStepBody-->
        </fieldset>
      
    </div>
    <!--close content-->
</div>
<!--close dnnForm DnnModule-Groups-Creation-->
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
<% } %>