(function ($) {
	$.fn.dnnTabs = function (options) {
		var opts = $.extend({}, $.fn.dnnTabs.defaultOptions, options),
        $wrap = this;

		// patch for period in selector - http://jsfiddle.net/9Mst9/2/
		$.ui.tabs.prototype._sanitizeSelector = function (hash) {
			return hash.replace(/:/g, "\\:").replace(/\./g, "\\\.");
		};

		$wrap.each(function () {
			var showEvent = null,
                cookieId;

			if (this.id) {
				cookieId = 'dnnTabs-' + this.id;
				if (opts.selected === -1) {
					var cookieValue = dnn.dom.getCookie(cookieId);
					if (cookieValue) {
						opts.selected = cookieValue;
					}
					if (opts.selected === -1) {
						opts.selected = 0;
					}
				}
			}

			showEvent = (function (cookieId) {
				return function (event, ui) {
					dnn.dom.setCookie(cookieId, ui.index, opts.cookieDays, '/', '', false, opts.cookieMilleseconds);
				}
			})(cookieId);

			$wrap.tabs({
				show: showEvent,
				selected: opts.selected,
				disabled: opts.disabled,
                fx: {
					opacity: opts.opacity,
					duration: opts.duration
				}
			});

			// page validation integration - select tab that contain tripped validators
			if (typeof Page_ClientValidate != "undefined" && $.isFunction(Page_ClientValidate)) {
				$wrap.find(opts.validationTriggerSelector).click(function (e) {
					if (!Page_ClientValidate(opts.validationGroup)) {
						var invalidControl = $wrap.find(opts.invalidItemSelector).eq(0);

						var $parent = invalidControl.closest(".ui-tabs-panel");
						if ($parent.length > 0) {
							var tabId = $parent.attr("id");
							$parent.parent().find("a[href='#" + tabId + "']").click();
						}
					}
				});
			};
		});

		return $wrap;
	};

	$.fn.dnnTabs.defaultOptions = {
		opacity: 'toggle',
		duration: 'fast',
		validationTriggerSelector: '.dnnPrimaryAction',
		validationGroup: '',
		invalidItemSelector: '.dnnFormError[style*="inline"]',
		regionToToggleSelector: 'fieldset',
		selected: -1,
		cookieDays: 0,
		cookieMilleseconds: 120000 // two minutes
	};

})(jQuery);

(function ($) {
    $.fn.dnnConfirm = function (options) {
        var opts = $.extend({}, $.fn.dnnConfirm.defaultOptions, options),
        $wrap = this;

        $wrap.each(function(){
            var $this = $(this),
                defaultAction = $this.attr('href'),
                $dnnDialog;

            if (defaultAction || opts.isButton) {
                $dnnDialog = $("<div class='dnnDialog'></div>").html(opts.text).dialog(opts);
                $this.click(function (e) {

                    if ($dnnDialog.is(':visible')) {
                        $dnnDialog.dialog("close");
                        return true;
                    }

                    e.preventDefault();
                    
                    $dnnDialog.dialog({
                        open: function(e) {
                            $('.ui-dialog-buttonpane').find('button:contains("' + opts.noText + '")').addClass('dnnConfirmCancel');
                        },
                        buttons: [
                        {
                            text: opts.yesText,
                            click: function () {
                                if ($.isFunction(opts.callbackTrue)) {
                                    opts.callbackTrue.call(this);
                                }
                                else {
                                    if (opts.isButton) {
                                        $this.click();
                                    }
                                    else {
                                        $dnnDialog.dialog("close");
                                        window.location.href = defaultAction;
                                    }
                                }
                            }
                        },
                        {
                            text: opts.noText,
                            click: function () {
                                $(this).dialog("close");
                                if ($.isFunction(opts.callbackFalse)) {
                                    opts.callbackFalse.call(this);
                                };
                            }
                        }
                    ]
                    });
                    $dnnDialog.dialog('open');
                });
            }
        });

        return $wrap;
    };

    $.fn.dnnConfirm.defaultOptions = {
        text: 'Are you sure?',
        yesText: 'Yes',
        noText: 'No',
        actionUrl: window.location.href,
        autoOpen: false,
        resizable: false,
        modal: true,
        title: 'Confirm',
        dialogClass: 'dnnFormPopup dnnClear',
        isButton: false
    };

})(jQuery);

(function ($) {
    $.dnnAlert = function (options) {
        var opts = $.extend({}, $.dnnAlert.defaultOptions, options),
        $dnnDialog = $("<div class='dnnDialog'></div>").html(opts.text).dialog(opts);

        $dnnDialog.dialog({
            buttons: [
                {
                    text: opts.okText,
                    click: function () {
                        $(this).dialog("close");
                        if ($.isFunction(opts.callback)) {
                            opts.callback.call(this);
                        };
                        return false;
                    }
                }
            ]
        });
        $dnnDialog.dialog('open');
    }

    $.dnnAlert.defaultOptions = {
        okText: 'Ok',
        autoOpen: false,
        resizable: false,
        modal: true,
        dialogClass: 'dnnFormPopup dnnClear'
    };

})(jQuery);

(function ($) {
    $.fn.dnnPanels = function (options) {
        var opts = $.extend({}, $.fn.dnnPanels.defaultOptions, options),
        $wrap = this;

        $wrap.each(function () {
            var $this = $(this);

            // wire up click event to perform slide toggle
            $this.find(opts.clickToToggleSelector).click(function (e) {
                e.preventDefault();
                var toggle = $(this).toggleClass(opts.toggleClass).parent().next(opts.regionToToggleSelector).slideToggle(function () {
                    var id = $(toggle.context.parentNode).attr("id");
                    dnn.dom.setCookie(id, $(this).is(':visible'), opts.cookieDays, '/', '', false, opts.cookieMilleseconds);
                });
            });

            function collapsePanel($clicker, $region){
                $clicker.removeClass(opts.toggleClass);
                $region.hide();
            }

            function expandPanel($clicker, $region){
                $clicker.addClass(opts.toggleClass);
                $region.show();
            }

            // walk over each selector and expand or collapse as necessary
            $this.find(opts.sectionHeadSelector).each(function (indexInArray, valueOfElement) {
                var $this = $(valueOfElement),
                    elementId = $this.attr("id"),
                    cookieValue = dnn.dom.getCookie(elementId),
                    $clicker = $this.find(opts.clickToToggleIsolatedSelector),
                    $region = $this.next(opts.regionToToggleSelector),
                    $parentSeparator = $this.parents(opts.panelSeparatorSelector),
                    groupPanelIndex = $parentSeparator.find(opts.sectionHeadSelector).index($this)

                if (cookieValue == "false") { // cookie explicitly set to false
                    collapsePanel($clicker, $region);
                }
                else if (cookieValue == "true" || indexInArray === 0) { // cookie set to true OR first panel
                    expandPanel($clicker, $region);
                }
                else if ($parentSeparator.size() > 0 && groupPanelIndex === 0) { // grouping is used & its the first panel in its group
                    expandPanel($clicker, $region);
                }
                else { // nada...
                    collapsePanel($clicker, $region);
                }
            });

            // page validation integration - expand collapsed panels that contain tripped validators
            $this.find(opts.validationTriggerSelector).click(function(e){
                if (typeof Page_ClientValidate != "undefined" && $.isFunction(Page_ClientValidate)) {
                    if (!Page_ClientValidate(opts.validationGroup)) {
                        $this.find(opts.invalidItemSelector).each(function(){
                            var $parent = $(this).closest(opts.regionToToggleSelector);
                            if ($parent.is(':hidden')){
                                $parent.prev(opts.sectionHeadSelector).find(opts.clickToToggleIsolatedSelector).click();
                            }
                        });
                    }
                }
            });

        });

        return $wrap;
    };

    $.fn.dnnPanels.defaultOptions = {
        clickToToggleSelector: 'h2.dnnFormSectionHead a',
        sectionHeadSelector: '.dnnFormSectionHead',
        regionToToggleSelector: 'fieldset',
        toggleClass: 'dnnSectionExpanded',
        clickToToggleIsolatedSelector: 'a',
        validationTriggerSelector: '.dnnPrimaryAction',
        invalidItemSelector: '.dnnFormError[style*="inline"]',
        validationGroup: '',
        panelSeparatorSelector: '.ui-tabs-panel',
        cookieDays: 0,
        cookieMilleseconds: 120000 // two minutes
    };

})(jQuery);

(function ($) {
    $.fn.dnnPreview = function (options) {
        var opts = $.extend({}, $.fn.dnnPreview.defaultOptions, options),
        $wrap = this;

        $wrap.each(function () {
            var $this = $(this);
            $this.find(opts.linkSelector).click(function (e) {
                e.preventDefault();
                var params = "?";
                var skin = $this.find(opts.skinSelector).val();
                var container = $this.find(opts.containerSelector).val();
                if (skin) {
                    params += "SkinSrc=" + skin;
                }
                if (container) {
                    if (skin) {
                        params += "&";
                    }
                    params += "ContainerSrc=" + container;
                }
                if(params != "?"){
                    window.open(encodeURI(opts.baseUrl + params.replace(/.ascx/gi, '')), "skinpreview");    
                }
                else {
                    $.dnnAlert({text: opts.noSelectionMessage, okText: opts.alertOkText, closeText: opts.alertCloseText });
                }
            });
        });

        return $wrap;
    };

    $.fn.dnnPreview.defaultOptions = {
        baseUrl: window.location.protocol + "//" + window.location.host + window.location.pathname,
        linkSelector: 'a.dnnSecondaryAction',
        skinSelector: '',
        containerSelector: '',
        noSelectionMessage: 'Please select a preview option.',
        alertOkText: 'Ok',
        alertCloseText: 'close'
    };

})(jQuery);

(function ($) {
    $.fn.dnnExpandAll = function (options) {
        var opts = $.extend({}, $.fn.dnnExpandAll.defaultOptions, options),
        $elem = this;

        if (($(opts.targetArea).find(opts.targetSelector + ':visible').length ===
            $(opts.targetArea).find(opts.targetSelector + opts.targetExpandedSelector + ':visible').length)
            && !$(this).hasClass('expanded')){
        	$(this).addClass('expanded').text(opts.collapseText);
        }

        $elem.click(function(e){
            e.preventDefault();
            var $this = $(this);    
            if ($this.hasClass('expanded')) {
                $this.removeClass('expanded').text(opts.expandText);
                $(opts.targetArea).find(opts.targetSelector + opts.targetExpandedSelector + ':visible').click();
            }
            else {
                $this.addClass('expanded').text(opts.collapseText);
                $(opts.targetArea).find(opts.targetSelector + ':visible').not(opts.targetExpandedSelector).click();
            }
        });

        return $elem;
    };
    $.fn.dnnExpandAll.defaultOptions = {
        expandText: 'Expand All',
        collapseText: 'Collapse All',
        targetArea: '#dnnHostSettings',
        targetSelector: 'h2.dnnFormSectionHead a',
        targetExpandedSelector: '.dnnSectionExpanded'
    };
})(jQuery);

(function ($) {
    $.fn.dnnTooltip = function (options) {
        var opts = $.extend({}, $.fn.dnnTooltip.defaultOptions, options),
        $wrap = this;

        $wrap.each(function () {
            var $this = $(this);

            $this.click(function(e){
                e.preventDefault();
            });

            $wrap.data("left", $wrap.position().left).data("top", $wrap.position().top);
            
            $this.hoverIntent({
                over: function () {
                    $this.find(opts.helpSelector).show();
                },
                out: function () {
                    if (!$this.hasClass(opts.pinnedClass)) {
                        $this.find(opts.helpSelector).hide();
                    }
                },
                timeout: 200,
                interval: 200
            });

            $this.find(opts.pinSelector).click(function (e) {
                e.preventDefault();
                if ($this.hasClass(opts.pinnedClass)){
                    $this.find(opts.helpSelector).animate({ "left": $wrap.data("left"), "top": $wrap.data("top")}, "fast", function(){
                        $this.removeClass(opts.pinnedClass);
                        $(this).hide().draggable('destroy');
                    });
                }
                else {
                    $this.addClass(opts.pinnedClass);
                    if ($.isFunction($().draggable)) {
                        $this.find(opts.helpSelector).draggable();
                    }
                }
            });
        });

        return $wrap;
    };

    $.fn.dnnTooltip.defaultOptions = {
        pinSelector: 'a.pinHelp',
        helpSelector: '.dnnFormHelpContent',
        pinnedClass: 'dnnTooltipPinned'
    };
})(jQuery);