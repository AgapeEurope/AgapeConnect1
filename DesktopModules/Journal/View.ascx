<%@ Control language="C#" Inherits="DotNetNuke.Modules.Journal.View" AutoEventWireup="false"  Codebehind="View.ascx.cs" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<%@ Register Namespace="DotNetNuke.Modules.Journal.Controls" Assembly="DotNetNuke.Modules.Journal" TagPrefix="dnnj" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<div id="userFileManager"></div>

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/Journal/scripts/jquery.iframe-transport.js" />
<dnn:DnnJsInclude runat="server" PathNameAlias="SharedScripts" FilePath="knockout.js" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/Journal/scripts/jquery.fileupload.js" Priority="101"/>
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/Journal/scripts/jquery.dnnUserFileUpload.js" Priority="102" />
<dnn:DnnJsInclude runat="server" FilePath="~/Resources/Shared/Components/UserFileManager/UserFileManager.js" Priority="105"></dnn:DnnJsInclude>
<dnn:DnnCssInclude runat="server" FilePath="~/Resources/Shared/Components/UserFileManager/UserFileManager.css"></dnn:DnnCssInclude>

<% if (ShowEditor) {  %>
<div class="journalTools">
    <div id="journalEditor">
        <div id="journalClose"></div>
        <textarea id="journalContent"></textarea>
        <div id="tbar">
            <span id="tbar-perm"></span>
            <% if (AllowFiles) {  %>
            <span id="tbar-attach"></span>
            <% } %>
            <% if (AllowPhotos) {  %>
            <span id="tbar-photo"></span>
            <%}%>
        <div class="securityMenu dnnClear">
                <div class="handle"></div>
                <ul>
                    <li><b><%= LocalizeString("WhoWillSee.Text") %></b></li>
                    <li><input type="radio" name="privacy" value="E" checked="checked" /><%= LocalizeString("Everyone.Text") %></li>
                    <li><input type="radio" name="privacy" value="C" /><%= LocalizeString("Community.Text") %></li>
                    <li><input type="radio" name="privacy" value="F" /><%= LocalizeString("Friends.Text") %></li>
                    <li><input type="radio" name="privacy" value="U" /><%= LocalizeString("Private.Text") %></li>
                </ul>
                
                
                
                
            </div>

        </div>
         
        <a href="#" id="btnShare"><%= LocalizeString("Share.Text") %></a>
        <div id="journalPlaceholder"><%= LocalizeString("SharePlaceHolder.Text") %></div>
        
        <div class="dnnClear"></div>
    </div>
    <div id="journalOptionArea">
      
        <% if (AllowFiles || AllowPhotos) { %>
        <div class="fileUploadArea">
            <div class="jpa" id="tbar-attach-Area">
                <span id="tbar-photoText"><%= LocalizeString("SelectPhoto.Text") %></span> 
                <span id="tbar-fileText"><%= LocalizeString("SelectFile.Text") %></span> <a href="#" id="photoFromSite"><%= LocalizeString("BrowseFromSite.Text") %></a> <span>|</span> 
                <span class="browser-upload-btn"><%= LocalizeString("UploadFromLocal.Text") %><input type="file" name="files[]" /></span>
            </div>
            <div id="itemUpload">
                <div class="fileupload-error dnnFormMessage dnnFormValidationSummary" style="display:none;"></div>
                <div class="progress_bar_wrapper">
                        <div class="progress_context" style="margin:10px 0px; display:none;">
                            <div class="upload_file_name" style="margin-top:5px; margin-bottom:-5px;"></div>
                            <div class="progress-bar green">
                                <div style="width:0px;">
                                    <span></span> 
                                </div>
                            </div>
                        </div>
                    </div>
                
                <div class="filePreviewArea"></div>
            </div>
        </div>
        <% } %>
        <div class="jpa" id="linkArea">
            <div id="linkClose"></div>
            <div id="imagePreviewer">
                <div id="image">
                    <img src='' />
                </div>
                <span id="imgPrev"><<</span><span id="imgCount">1 <%= LocalizeString("Of.Text") %> 10</span><span id="imgNext">>></span>
            </div>
            <div id="linkInfo">
                <b></b>
                <p></p>
            </div>
            <div class="dnnClear"></div>
        </div>
    </div>
</div>
          <div class="dnnClear"></div>


<%} %>


<div id="journalItems">
<dnnj:JournalListControl ID="ctlJournalList" runat="server"></dnnj:JournalListControl>
</div>
<a href="javascript:void(0)" onclick="getItems();" style="display:none;" id="getMore" class="dnnPrimaryAction"><%= LocalizeString("GetMore.Text") %></a>

<script type="text/javascript">
  <asp:literal id="litScripts" runat="server" />
    $(document).ready(function () {
        var sf = $.ServicesFramework(<%=ModuleId %>);
        var journalServiceBase = sf.getServiceRoot('Journal');
        
        $('.juser').click(function() {
            var uid =  $(this).attr('id').replace('user-', '');
            window.location.href = profilePage.replace('xxx',uid);
        });
        var maxUploadSize = <%= Config.GetMaxUploadSize() %>;
        
        $('.fileUploadArea').dnnUserFileUpload({
            maxFileSize: maxUploadSize,
            serverErrorMessage: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("ServerError.Text")) %>',
            addImageServiceUrl: journalServiceBase + 'FileUpload.ashx/UploadFile',
            callback: function (result) {
                var $previewArea = $('.filePreviewArea');
                if (IsImage(result.extension)) {
                    attachPhoto(result.file_id, result.url, true);
                }else{
                    attachPhoto(result.file_id, result.thumbnail_url, false);
                }
            }
        });
        var jopts = {};
        jopts.maxLength = maxlength;
        jopts.servicesFramework = sf;
        $('body').journalTools(jopts);
        
           $('#userFileManager').userFileManager({
            title: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("Title.Text")) %>',
            cancelText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("Cancel.Text")) %>',
            attachText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("Attach.Text")) %>',
            getItemsServiceUrl: sf.getServiceRoot('InternalServices') + 'UserFile.ashx/GetItems',
            nameHeaderText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("Name.Header")) %>',
            typeHeaderText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("Type.Header")) %>',
            lastModifiedHeaderText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("LastModified.Header")) %>',
            fileSizeText: '<%= DotNetNuke.UI.Utilities.ClientAPI.GetSafeJSString(LocalizeString("FileSize.Header")) %>',
            templatePath: '<%=Page.ResolveUrl("~/Resources/Shared/Components/UserFileManager/Templates/") %>',
            templateName: 'Default',
            templateExtension: '.html',
            attachCallback: function(file) {
                if (IsImage(file.type)) {
                    attachPhoto(file.id, file.thumb_url, true);
                } else {
                    attachPhoto(file.id, file.thumb_url, false);
                }
            }
           });
        
       
        var opts = {};
        opts.textareaSelector = '#journalContent';
        opts.clearPreviewSelector = '#linkClose';
        opts.previewSelector = '#linkArea';
        opts.servicesFramework = $.ServicesFramework(<%=ModuleId %>);

        $('body').previewify(opts);

      
      
     
       
       

    });
  
    function buildLikes(data,journalId){
             var currLike = $('#like-' + journalId).text();
             if (currLike == resxLike) {
                $('#like-' + journalId).fadeOut(function(){
                    $(this).text(resxUnLike).fadeIn();
                    });
             }else{
                $('#like-' + journalId).fadeOut(function() {
                    $(this).text(resxLike).fadeIn();
                });
             }
             $('#jid-' + journalId + ' .likes').fadeOut(function() {
                $(this).empty().append(data.LikeList).fadeIn();
             });
        };
    var commentOpts = {};
    commentOpts.servicesFramework = $.ServicesFramework(<%=ModuleId %>);
    function pluginInit() {
        $('.jcmt').each(function(index){
            $(this).journalComments(commentOpts);
        });
        var rows = $(".journalrow");
        if (rows.length == 20) {
            $("#getMore").show();
        }
        $('a[id^="cmtbtn-"]').click(function (e) {
            e.preventDefault();
            var jid = $(this).attr('id').replace('cmtbtn-', '');
            var cmtarea = $("#jcmt-" + jid + " .cmteditarea");
            var cmtbtn = $("#jcmt-" + jid + " .cmtbtn");
            var cmtbtnlink = $("#jcmt-" + jid + " .cmtbtn a");
            if (cmtarea.css('display') == 'none'){
                cmtarea.show();
                cmtbtnlink.addClass('disabled');
                cmtbtn.show();

            } else {
                
                var cmtedit = $("#jcmt-" + jid + " .cmteditor");
                var plh = $("#jcmt-" + jid + " .editorPlaceholder");
                cmtedit.animate({
                    height: '0'
                }, 400, function () {
                    cmtbtn.hide();
                    cmtbtnlink.addClass('disabled').hide();
                    cmtedit.text('').hide();
                    cmtarea.hide();
                    plh.show();
                });
      
            };
            
        });
        $('a[id^="like-"]').click(function (e) {
            e.preventDefault();
            var jid = $(this).attr('id').replace('like-', '');
            var data = {};
            data.JournalId = jid;
            journalPost('Like',data,buildLikes,jid);
        });
    }
    pluginInit();

    $('.journalitem .jlink img').click(function() {
        var url = $(this).next().find('a').attr('href');
        var vidId = url.substring(url.lastIndexOf('/')+1);
        var frame = $('<iframe frameborder="0" allowfullscreen />')
            .attr('height',315)
            .attr('width',420)
            .attr('src', 'http://www.youtube.com/embed/' + vidId + '?rel=0')
            .css('position','relative')
            .css('z-index','2000')
            .css('height','315px');
        var div = $('<div style="display:none;height:315px;" />');
        div.append(frame);
            
        $(this).before(div);
        frame.load(function(){
            $(this).parent().siblings().hide();
            var p = $(this).parent();
            p.slideDown('fast');
        });
            
    });
       function journalDelete(obj) {
            var p = obj.parentNode;
            var jid = p.id.replace('jid-','');
            //console.log(jid);
            var data = {};
            data.JournalId = jid;
            journalPost('Delete',data,journalRemove,jid)
        };
        function journalRemove(data, jid) {
            $('#jid-' + jid).slideUp(function(){
                $(this).remove();
            });
        };
        function journalPost(method,data,callback,journalId) {
            var sf = $.ServicesFramework(<%=ModuleId %>);
            sf.getAntiForgeryProperty(data);
            
            $.ajax({
                type: "POST",
                url: sf.getServiceRoot('Journal') + "Services.ashx/" + method,
                beforeSend: sf.setModuleHeaders,
                data: data,
                success: function (data) {
                    if (typeof (callback) != "undefined") {
                        callback(data,journalId);
                    }
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });
        };
        function getItems() {
            var sf = $.ServicesFramework(<%=ModuleId %>);
            var rows = $(".journalrow").get();
        
            data = {};
            data.ProfileId = pid;
            data.GroupId = gid;
            data.RowIndex = rows.length + 1;
            data.MaxRows = pagesize;
            sf.getAntiForgeryProperty(data);

            $.ajax({
                type: "POST",
                url: sf.getServiceRoot('Journal') + 'Services.ashx/GetListForProfile',
                beforeSend: sf.setModuleHeaders,
                data: data,
                success: function (data) {
                    if (data.length > 0) {
                        $("#journalItems").append(data);
                          pluginInit();
                        var newRows = $(".journalrow").get();
                        var diff = (newRows.length - rows.length);
                        if (diff < pagesize) {
                            $("#getMore").hide();
                        }
                    }
                    if (typeof (callback) != "undefined") {
                        callback(data);
                    }
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });
        }
</script>
