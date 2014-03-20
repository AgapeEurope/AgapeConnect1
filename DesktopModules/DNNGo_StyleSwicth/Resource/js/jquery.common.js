var DNNGo = {
    split: function (str, separator) {
        return str.split(separator);
    },
    setCookie: function (_name, _value, _PortalId) {
        jQuery.cookie(_name, _value, { expires: 30, path: '/' });
        jQuery.post(Resource_Ajax, { name: 'ck_' + _name, value: _value, PortalId: _PortalId });
    },
    getCookie: function (_name) {
        return jQuery.cookie(_name);
    },
    setStyle: function (name, style_value, color) {
        jQuery('#div_style_' + name).html(style_value.replace(/\{0\}/g, color));
    },
    eachColorPicker: function (Element) {
        jQuery(Element).each(function (i, n) {
            var $a, b, c, d;
            $a = this;
            b = jQuery(this).attr('data-name');
            c = jQuery(this).attr('data-value');
            jQuery(this).css("backgroundColor", jQuery(this).val());
            jQuery(this).ColorPicker({
                onSubmit: function (hsb, hex, rgb, el) {
                    jQuery(el).val('#' + hex).ColorPickerHide();
                },
                onBeforeShow: function () {
                    jQuery(this).ColorPickerSetColor(this.value);
                },
                onChange: function (hsb, hex, rgb) {
                    jQuery($a).val('#' + hex).css('backgroundColor', '#' + hex);
                    DNNGo.setStyle(b, c, '#' + hex);
                    DNNGo.setCookie(b, '#' + hex, PortalId);
                }
            });
        });
    },
    eachStyleList: function (Element) {
        jQuery(Element).each(function (i, n) {
            var $a, b, c;
            $a = this;
            b = jQuery(this).attr('data-name');
            c = jQuery(this).attr('data-value');
            jQuery(this).find('a').each(function (x, y) {
                jQuery(this).click(function () {
                    jQuery("#hidden_" + b).val(jQuery(this).attr("data-value"));
                    jQuery(c).attr("class", jQuery(this).attr("data-value"));
                    DNNGo.setCookie(b, jQuery(this).attr("data-value"), PortalId);
                });

            });
        });
    },
    eachCssList: function (Element) {
        jQuery(Element).each(function (i, n) {
            var $a, b, c;
            $a = this;
            b = jQuery(this).attr('data-name');
            //c = jQuery(this).attr('data-href');
            jQuery(this).find('a').each(function (x, y) {
                jQuery(this).click(function () {
                    jQuery("#hidden_" + b).val(jQuery(this).attr("data-value"));
                    jQuery('#DNNGo_StyleSwitch_CSS_'+b).attr("href", jQuery(this).attr("data-value"));
                    DNNGo.setCookie(b, jQuery(this).attr('data-href'), PortalId);
                });

            });
        });
    },
    eachSliderBox: function (Element) {
        jQuery(Element).each(function (i, n) {
            var a, b, c, d, e;
            a = jQuery(this).attr('data-name');
            b = jQuery(this).val();
            c = parseInt(jQuery(this).attr('data-min'));
            d = parseInt(jQuery(this).attr('data-max'));
            e = jQuery(this).attr('data-value');
   
            jQuery("#slider_" + a).slider({
                value: b,
                min: c,
                max: d,
                step: 1,
                slide: function (event, ui) {
                    jQuery("#slider_amount_" + a).val(+ui.value);
                    DNNGo.setStyle(a, e, ui.value);
                    DNNGo.setCookie(a, ui.value, PortalId);
                }
            });
        });
    },
    hideMenu: function ($) {
        $('#styler_slider').stop(false, true).animate({ left: '-220px' }, 400, 'easeOutExpo', function () {
            if ($('#styler_toggler').hasClass('styler_toggler_off')) {
                $('#styler_toggler').removeClass('styler_toggler_off').addClass('styler_toggler_on');
            } else {
                $('#styler_toggler').removeClass('styler_toggler_on').addClass('styler_toggler_off');
            }
        });
    },
    showMenu: function ($) {
        $('#styler_slider').stop(false, true).animate({ left: '0px' }, 400, 'easeOutExpo', function () {
            if ($('#styler_toggler').hasClass('styler_toggler_off')) {
                $('#styler_toggler').removeClass('styler_toggler_off').addClass('styler_toggler_on');
            } else {
                $('#styler_toggler').removeClass('styler_toggler_on').addClass('styler_toggler_off');
            }
        });
    },
    ExpansionMenuStatus: function ($) {
        var MenuStatus = DNNGo.getCookie("MenuStatus");
        if (MenuStatus == 'true') {
            DNNGo.showMenu($);
        }

    }



};