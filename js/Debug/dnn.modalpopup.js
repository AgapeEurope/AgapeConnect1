(function (window, $) {
    dnnModal = { //global scope
        load: function () {
            //This method prevents the popup from flashing before closing, also redirects the parent window.
            //parent and parent.parent needs to be assign to a varaible for Opera compatibility issues.            
            try {
                if (parent.location.href !== undefined) {

                    var windowTop = parent;
                    var parentTop = windowTop.parent;

                    if (typeof (parentTop.$find) != "undefined") {
                        if (location.href.indexOf('popUp') == -1 || windowTop.location.href.indexOf("popUp") > -1) {
                            
                            var popup = windowTop.$("#iPopUp");
                            var refresh = popup.dialog("option", "refresh");
                            var closingUrl = popup.dialog("option", "closingUrl");

                            if (closingUrl == "")
                            { closingUrl = location.href }

                            if (popup.dialog('isOpen') === true) {
                                popup.dialog("option", {
                                    close: function (event, ui) { dnnModal.closePopUp(refresh, closingUrl); }
                                }).dialog('close');
                            }
                        }
                        else {
                            windowTop.$("#iPopUp").dialog({ title: document.title });
                        }
                    }
                }
            }
            catch (err) {
                return false;
            }
        },
        show: function (url, showReturn, height, width, refresh, closingUrl) {
            var $modal = $("#iPopUp");
            if ($modal.length == 0) {
                $modal = $("<iframe id=\"iPopUp\" src=\"about:blank\" scrolling=\"auto\" frameborder=\"0\"></iframe>");
                $(document).find('html').css('overflow', 'hidden');
                $(document).append($modal);
            }

            var windowTop = parent; //needs to be assign to a varaible for Opera compatibility issues.

            $modal.dialog({
                modal: true,
                autoOpen: true,
                dialogClass: "dnnFormPopup",
                position: "center",
                minWidth: width,
                minHeight: height,
                maxWidth: 1920,
                maxHeight: 1080,
                resizable: true,
                closeOnEscape: true,
                zIndex: 100000,
                refresh: refresh,
                closingUrl: closingUrl,
                close: function (event, ui) { dnnModal.closePopUp(refresh, closingUrl); }
            })
        .width(width - 11)
        .height(height - 11);

            var $dnnToggleMax = $('<a href="#" class="dnnToggleMax"><span>Max</span></a>');
            $('.ui-dialog-title').after($dnnToggleMax);
            $dnnToggleMax.click(function (e) {
                e.preventDefault();

                var $window = $(window),
                $this = $(this),
                newHeight,
                newWidth,
                newPosition;

                if ($modal.data('isMaximized')) {
                    newHeight = $modal.data('height');
                    newWidth = $modal.data('width');
                    newPosition = $modal.data('position');
                    $modal.data('isMaximized', false);
                }
                else {
                    $modal.data('height', $modal.dialog("option", "minHeight"))
                        .data('width', $modal.dialog("option", "minWidth"))
                        .data('position', $modal.dialog("option", "position"));

                    newHeight = $window.height() - 11;
                    newWidth = $window.width() - 11;
                    newPosition = [0, 0];
                    $modal.data('isMaximized', true);
                }

                $this.toggleClass('ui-dialog-titlebar-max');
                $modal.dialog({ height: newHeight, width: newWidth });
                $modal.dialog({ position: 'center' });

            });

            var showLoading = function () {
                var loading = $("<div class=\"dnnLoading\"></div>");
                loading.css({
                    width: $modal.width()
					, height: $modal.height()
                });
                $modal.before(loading);
            };

            var hideLoading = function () {
                $modal.prev(".dnnLoading").remove();
            };

            showLoading();

            $modal[0].src = url;

            $modal.bind("load", function () {
                hideLoading();
            });

            if (showReturn.toString() == "true") {
                return false;
            }
        },
        closePopUp: function (refresh, url) {
            var windowTop = parent; //needs to be assign to a varaible for Opera compatibility issues.
            if (typeof refresh === "undefined") {
                refresh = true;
            }
            if ((typeof url === "undefined") || (url == "")) {
                url = windowTop.location;
            }
            if (refresh.toString() == "true") {
                windowTop.location.href = url;
                $(this).hide();
            }
            else {
                $(this).remove();
            }
        }

    };
    dnnModal.load();
} (window, jQuery))