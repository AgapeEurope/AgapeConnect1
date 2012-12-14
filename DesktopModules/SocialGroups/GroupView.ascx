<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupView.ascx.cs" Inherits="DotNetNuke.Modules.Groups.GroupView" %>
<asp:Literal ID="litOutput" runat="server" />
<%if (Request.IsAuthenticated) { %>
<script type="text/javascript">
    jQuery(document).ready(function ($) {
        $('#JoinGroup-<%=GroupId %>').click(function (event) {
            event.preventDefault();
            var groupId = $(this).attr('id').replace('JoinGroup-', '');
            groupJoin(groupId);
        });
        $('#LeaveGroup-<%=GroupId %>').click(function (event) {
            event.preventDefault();
            var groupId = $(this).attr('id').replace('LeaveGroup-', '');
            groupLeave(groupId);

        });
        function groupLeave(id){
           var data = {};
            data.roleId = id;
            groupPost('LeaveGroup',data,groupLeaveComplete,id)
        }
        function groupLeaveComplete(result, id){
            window.location.href= window.location.href;
        }
        function groupJoin(id) {
            var data = {};
            data.roleId = id;
            groupPost('JoinGroup',data,groupJoinComplete,id)
        };
        function groupJoinComplete(result, id) {
            if (result.URL != '' && typeof(result.URL) != 'undefined') {
                window.location.href = result.URL;
            }else{
                $('#JoinGroup-' + id).text('<%=LocalizeString("Pending")%>')
                    .removeClass('dnnTertiaryAction')
                    .addClass('dnnDisabled')
                    .unbind('click')
                    .click(function(event){event.preventDefault});
            }
        }
        function groupPost(method,data,callback,groupId) {
            var sf = $.ServicesFramework(<%=ModuleId %>);
            sf.getAntiForgeryProperty(data);
            
            $.ajax({
                type: "POST",
                url: sf.getServiceRoot('SocialGroups') + "ModerationService.ashx/" + method,
                beforeSend: sf.setModuleHeaders,
                data: data,
                success: function (data) {
                    if (typeof (callback) != "undefined") {
                        callback(data,groupId);
                    }
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });
        };
    });
</script>
<%} %>