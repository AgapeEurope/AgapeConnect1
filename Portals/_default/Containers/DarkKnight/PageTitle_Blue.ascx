<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="ICON" Src="~/Admin/Containers/Icon.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="c_DNN6 c_DNN6_Header">
    <h1 class="Title Blue"><dnn:TITLE runat="server" id="dnnTITLE" /><img src="<%=ContainerPath%>Images/Title-BG-Blue.png" class="TitleBar" alt="" /></h1>
    <div id="ContentPane" runat="server"></div>
</div>