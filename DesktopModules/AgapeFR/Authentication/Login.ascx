<%@ Control Language="C#" Inherits="DotNetNuke.Modules.AgapeFR.Authentication.Login" AutoEventWireup="false" CodeFile="Login.ascx.cs" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<%@ Register TagPrefix="cas" TagName="CasAuth" Src="~/DesktopModules/AgapeFR/Authentication/CasAuth.ascx" %>
<%@ Register TagPrefix="reg" TagName="Register" Src="~/DesktopModules/AgapeFR/Authentication/Register.ascx" %>
<script type="text/javascript">

    (function ($, Sys) {
        function setUpMyObjects() {

            $('.aButton').button();

            $('.rbLoginMode').click(function () {
                loginModeChanged();
            });
        }

        function loginModeChanged() {
            if ($('.rbLoginMode input:radio:checked').val() == 1) {
                // DNN Login
                hide3modesdivs();
                $('#dnnLogin').show();
            }
            else if ($('.rbLoginMode input:radio:checked').val() == 2) {
                // New DNN registration
                hide3modesdivs();
                $('#dnnRegister').show();
            }
            else if ($('.rbLoginMode input:radio:checked').val() == 3) {
                // Staff Login
                hide3modesdivs();
                $('#staffLogin').show();
            }
        }

        function hide3modesdivs() {
            $('#dnnLogin').hide();
            $('#dnnRegister').hide();
            $('#staffLogin').hide();
        }

        $(document).ready(function () {
            setUpMyObjects();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                setUpMyObjects();

            });
        });
    }(jQuery, window.Sys));


</script>
<style type="text/css">
    .bubble {
         background-color: #6495ed;
         border-radius: 15px;
         padding: 10px;
     }
    #login {
        width: 500px;
        overflow: auto;
    }
    #loginMode {
        /*float: left;*/
        padding-bottom: 30px;
    }
    #dnnLogin {
    }
    #dnnRegister {
        display: none;
    }
    #staffLogin {
        display: none;
    }
</style>
<div id="login" class="bubble">
    <div id="loginMode">
        <asp:RadioButtonList ID="rbLoginMode" runat="server" CssClass="rbLoginMode">
            <asp:ListItem Value="1" Selected="True">J'ai un compte sur ce site.</asp:ListItem>
            <asp:ListItem Value="2">Je n'ai pas de compte, je souhaite en créer un.</asp:ListItem>
            <asp:ListItem Value="3">J'ai un compte équipier avec Agapé France.</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <div id="dnnLogin">
        <div class="dnnForm dnnLoginService dnnClear">
            <div class="dnnFormItem">
                <asp:label id="plUsername" AssociatedControlID="txtUsername" runat="server" CssClass="dnnFormLabel" />
                <asp:textbox id="txtUsername" runat="server" />
            </div>
            <div class="dnnFormItem">
                <asp:label id="plPassword" AssociatedControlID="txtPassword" runat="server" resourcekey="Password" CssClass="dnnFormLabel" />
                <asp:textbox id="txtPassword" textmode="Password" runat="server" />
            </div>
            <p><asp:LinkButton id="cmdLogin" resourcekey="cmdLogin" cssclass="dnnPrimaryAction" runat="server" CausesValidation="False" /></p>
        </div>
        <div class="dnnLoginRememberMe"><asp:checkbox id="chkCookie" resourcekey="Remember" runat="server" /></div>
        <div><asp:label id="lblLogin" runat="server" /></div>
        <div class="dnnLoginActions">
            <ul class="dnnActions dnnClear">             
                <li id="liPassword" runat="server"><asp:HyperLink ID="passwordLink" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdPassword" /></li>
            </ul>
        </div>
    </div>
    <div id="dnnRegister">
        <reg:Register ID="Register1" runat="server" />
    </div>
    <div id="staffLogin">
            <cas:CasAuth ID="CasAuth1" runat="server" />
    </div>
</div>

