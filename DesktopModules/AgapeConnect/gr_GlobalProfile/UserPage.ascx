<%@ Control Language="VB" AutoEventWireup="False" CodeFile="UserPage.ascx.vb" Inherits="DotNetNuke.Modules.AgapeConnect.gr_mapping_mod" %>
<link href="/Portals/_default/Skins/AgapeBlue/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<style type="text/css">
    #gp_search .control-label {
        width: 100px;
    }
</style>


<asp:Label ID="lblText" runat="server" Text=""></asp:Label>

<fieldset id="gp_search" class="span6">
    <legend><b>
        <asp:Label ID="lblTitle" runat="server" Font-Size="XX-Large"></asp:Label></b></legend>
    <div id="formRoot" class="form-horizontal">
        <div class="control-group ">
            <label class="control-label">First Name</label>
            <div class="controls">
                <asp:TextBox runat="server" ID="tbFirstName" />
            </div>
        </div>
        <div class="control-group ">
            <label class="control-label">Last Name</label>
            <div class="controls">
                <asp:TextBox runat="server" ID="tbLastName" />
            </div>
        </div>
        <div class="control-group ">
            <label class="control-label">Email</label>
            <div class="controls">
                <asp:TextBox runat="server" ID="tbEmail" />
            </div>
        </div>

        <fieldset>
            <legend><b>Address</b></legend>
            <div class="control-group ">
                <label class="control-label">Address1</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbAddress1" />
                </div>
            </div>
            <div class="control-group ">
                <label class="control-label">Address2</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbAddress2" />
                </div>
            </div>
            <div class="control-group ">
                <label class="control-label">City</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbCity" />
                </div>
            </div>
            <div class="control-group ">
                <label class="control-label">State</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbState" />
                </div>
            </div>
            <div class="control-group ">
                <label class="control-label">PostalCode</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbPostalCode" />
                </div>
            </div>
            <div class="control-group ">
                <label class="control-label">Country</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="tbCountry" />
                </div>
            </div>
        </fieldset>
        <fieldset>
            <legend><b>Assignments</b></legend>
            <div class="control-group ">
                <label class="control-label">Ministry</label>
                <div class="controls">
                    <asp:DropDownList runat="server" ID="ddlMinistry">

                        <asp:ListItem Text="CRU" />
                        <asp:ListItem Text="AgapeUK" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="control-group ">
                <label class="control-label">Role</label>
                <div class="controls">
                    <asp:DropDownList runat="server" ID="ddlRole">
                        <asp:ListItem Text="God" />
                        <asp:ListItem Text="Pleb" />
                    </asp:DropDownList>

                </div>
            </div>
        </fieldset>


    </div>
<asp:Button ID="btnSave" runat="server" Text="Update" CssClass="btn btn-primary" />


</fieldset>


