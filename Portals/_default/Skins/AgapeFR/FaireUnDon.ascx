<%@ Control Language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="Header" Src="~/Portals/_default/Skins/AgapeFR/controls/Header.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Footer" Src="~/Portals/_default/Skins/AgapeFR/controls/Footer.ascx" %>

<script type="text/javascript">
    jQuery(function ($) {

        // Init tabs with first tab selected
        $('#ongletsdon').dnnTabs({ selected: 0 });

        // Set first tab title for current selected list
        $('#onglet1').html("<%=CurrentTabTitle%>");

        // Set current selected list as a blue arrow on left menu
        $('#LeftMenu<%=ListType%>').addClass("selected");

    });
</script>  

<script runat="server">
    
    Public ReadOnly Property ListType As String
        Get
            Dim value As String = Request.QueryString.Get("givetype")
            If String.IsNullOrEmpty(value) Then 'Staff list per default if no param in request
                value = GiveType.Staff
            End If
            Return value
        End Get
    End Property
    
    Dim CurrentTabTitle As String
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        'Needed for the dnnTabs to work
        DotNetNuke.Framework.jQuery.RequestDnnPluginsRegistration()
        
        Select Case ListType
            Case GiveType.Dept
                CurrentTabTitle = "Nos minist&egrave;res"

            Case GiveType.Project
                CurrentTabTitle = "Nos projets"

            Case Else 'Staff per default
                CurrentTabTitle = "Nos missionnaires"

        End Select

    End Sub

</script>

<dnn:Header runat="server" ID="dnnHeader" />

<div id="bannerbar" class="bar">
	<div id="BannerContainer" class="centeredbox">
        <div id="BannerPane" class="BannerPane" runat="server">
		</div>
	</div>
</div>	
<div id="bar3" class="bar">
	<div id="ContentContainer" class="centeredbox">
        <div id="TopPane" class="TopPane" runat="server">
		</div>
        <div class="LeftMenu">
            <div id="TopImg">
		    </div>
            <div class="LeftMenuPane">
                <a id="LeftMenu0" href="/simpliquer/faireundon.aspx?givetype=0#ContentContainer" target="_self">
                    <div>
                        <h1>Soutenir un missionnaire</h1>
                        <h2>Ou une famille.</h2>
                    </div>
                </a>
                <a id="LeftMenu1" href="/simpliquer/faireundon.aspx?givetype=1#ContentContainer" target="_self">
                    <div>
                        <h1>Soutenir un minist&egrave;re</h1>
                        <h2>Et une &eacute;quipe.</h2>
                    </div>
                </a>
                <a id="LeftMenu2" href="/simpliquer/faireundon.aspx?givetype=2#ContentContainer" target="_self">
                    <div>
                        <h1>Soutenir un projet</h1>
                        <h2>Ou un &eacute;v&eacute;nement.</h2>
                    </div>
                </a>
                <div id="BottomImg">
		        </div>
            </div>
		</div>
        <div class="CenterPane">
            <div id="ongletsdon">
                <ul>
                    <li><a id="onglet1" href="#1"></a></li>
                    <li><a href="#2">Pourquoi donner ?</a></li>
                    <li><a href="#3">Moyens de paiement</a></li>
                    <li><a href="#4">D&eacute;duction fiscale</a></li>
                    <li><a href="#5">Infos l&eacute;gales</a></li>
                </ul>
                <div id="1" class="dnnClear">
                    <div id="ContentPane" class="ListPane" runat="server"></div>
                </div>
                <div id="2" class="dnnClear">
                    <div id="Tab2Pane" runat="server"></div>
                </div>
                <div id="3" class="dnnClear">
                    <div id="Tab3Pane" runat="server"></div>
                </div>
                <div id="4" class="dnnClear">
                    <div id="Tab4Pane" runat="server"></div>
                </div>
                <div id="5" class="dnnClear">
                    <div id="Tab5Pane" runat="server"></div>
                </div>
            </div> 
        </div>       
        <div id="BottomPane" class="BottomPane" runat="server">
		</div>
	</div>
</div>	

<dnn:Footer runat="server" ID="dnnFooter" />