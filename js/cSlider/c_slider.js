//To the Glory of God
(function ($) {
    var cSlider = function (element, options) {
        // Defaults are below
        var settings = $.extend({}, $.fn.cSlider.defaults, options);

        // Useful variables. Play carefully.
        var vars = {
            currentSlide: 0,
            currentImage: '',
            totalSlides: 0,
            running: false,
            paused: false,
            stop: false,
            controlNavEl: false
        };

        // Get this slider
        var slider = $(element);
        slider.data('c:vars', vars).addClass('cSlider_main');

        //Get the children
        var kids = slider.children();
        kids.each(function () {
            var kiddy = $(this);
            var link = '';
            if (!kiddy.is('img')) {
                if (kiddy.is('a')) {
                    kiddy.addClass('c_imageLink');
                    link = kiddy;
                }
                kiddy = kiddy.find('img:first');
            }

            if (link !== '') {
                link.css('display', 'none');
            }
            kiddy.css('display', 'none');
            vars.totalSlides++;
        });

        //Set the start slide
        if (settings.startSlide > 0) {
            if (settings.startSlide >= vars.totalSlides) {
                settings.startSlide = vars.totalSlides - 1;
            }
            vars.currentSlide = settings.startSlide;
        }

        // Get initial image
        if ($(kids[vars.currentSlide]).is('img')) {
            vars.currentImage = $(kids[vars.currentSlide]);
        } else {
            vars.currentImage = $(kids[vars.currentSlide]).find('img:first');
        }
        
        //Set up the container link
        slider.append($('<a class="c_Linker" href="#">&nbsp;</a>'));
        $('a.c_Linker').attr('href', vars.currentImage.attr('alt'));

        // Set first background
        var sliderImg = $('<img class="c_mainImage" src="#" />');
        sliderImg.attr('src', vars.currentImage.attr('src')).show();
        slider.append(sliderImg);

        var offset = ($(kids[vars.currentSlide]).css('height').replace("px", "") - parseInt(vars.currentImage.css('height').replace("px", ""))) / 2;
        //Line removed as it was causing the image to offset by half
        //$('.c_mainImage').css('top', offset + 'px');

        //Create caption
        slider.append($('<a class="c_caption"></a>'));

        // Process caption function
        var processCaption = function (theseSettings) {
            var cCaption = $('.c_caption', slider);
            if (vars.currentImage.attr('title') != '' && vars.currentImage.attr('title') != undefined) {
                var title = vars.currentImage.attr('title');
                if (cCaption.css('display') == 'block') {
                    setTimeout(function () {
                        cCaption.html(title);
                        cCaption.attr('href', vars.currentImage.attr('alt'));
                    }, theseSettings.animSpeed);
                } else {
                    cCaption.html(title);
                    cCaption.stop().fadeIn(theseSettings.animSpeed);
                }
            } else cCaption.stop().fadeOut(theseSettings.animSpeed);
            return false;
        };

        //Process initial  caption
        processCaption(settings);

        //Making it actually work!
        var timer = 0;
        if (kids.length > 1) {
            timer = setInterval(function () { cRun(slider, kids, settings, false); }, settings.pauseTime);
        }

        // Add Direction nav
        slider.append('<div class="c_directionNav"><a class="c_prevNav">&nbsp;</a><a class="c_nextNav">&nbsp;</a></div>');
        $('.c_directionNav').hide();
        slider.hover(function () {
            $('.c_directionNav', slider).show();
        }, function () {
            $('.c_directionNav', slider).hide();
        });

        $('a.c_prevNav', slider).live('click', function () {
            if (vars.running) {
                return false;
            }
            clearInterval(timer);
            timer = '';
            vars.currentSlide -= 2;
            cRun(slider, kids, settings, 'prev');
            return false;
        });

        $('a.c_nextNav', slider).live('click', function () {
            if (vars.running) {
                return false;
            }
            clearInterval(timer);
            timer = '';
            cRun(slider, kids, settings, 'next');
            return false;
        });
        
        //Add Control Nav
        if (settings.controlNav) {
            vars.controlNavEl = $('<div class="c_controlNav"></div>');
            slider.append(vars.controlNavEl);
            for (var i = 0; i < kids.length; i++) {
                if (settings.controlNavThumbs) {
                    vars.controlNavEl.addClass('c_thumbsEnabled');
                    var kiddy2 = kids.eq(i);
                    if (!kiddy2.is('img')) {
                        kiddy2 = kiddy2.find('img:first');
                    }
                    if (kiddy2.attr('data-thumb')) vars.controlNavEl.append('<a class="c_control" rel="' + i + '"><img src="' + kiddy2.attr('data-thumb') + '" alt="" /></a>');
                } else {
                    vars.controlNavEl.append('<a class="c_control" rel="' + i + '">' + (i + 1) + '</a>');
                }
            }

            //Set initial active link
            $('a:eq(' + vars.currentSlide + ')', vars.controlNavEl).addClass('active');

            $('a', vars.controlNavEl).bind('click', function () {
                if (vars.running) return false;
                if ($(this).hasClass('active')) return false;
                clearInterval(timer);
                timer = '';
                sliderImg.attr('src', vars.currentImage.attr('src'));
                vars.currentSlide = $(this).attr('rel') - 1;
                cRun(slider, kids, settings, 'control');
                return false;
            });
        }
        
        // Event when Animation finishes
        slider.bind('c:animFinished', function () {
            sliderImg.attr('src', vars.currentImage.attr('src'));
            vars.running = false;
            $('a.c_Linker').attr('href', vars.currentImage.attr('alt'));
            // Restart the timer
            if (timer === '' && !vars.paused) {
                timer = setInterval(function () { cRun(slider, kids, settings, false); }, settings.pauseTime);
            }
            // Trigger the afterChange callback
            settings.afterChange.call(this);
        });
        
        // Add fake image for animations
        var createFader = function(thisSlider, theseSettings, theseVars) {
            var sliceHeight = ($('img[src="' + theseVars.currentImage.attr('src') + '"]', thisSlider).not('.c_mainImage,.c_control img').parent().is('a')) ? $('img[src="' + theseVars.currentImage.attr('src') + '"]', thisSlider).not('.c_mainImage,.c_control img').parent().height() : $('img[src="' + theseVars.currentImage.attr('src') + '"]', thisSlider).not('.c_mainImage,.c_control img').height();
            thisSlider.append(
                $('<div class="c_slice"><img src="' + theseVars.currentImage.attr('src') + '" style="position:absolute; width:' + thisSlider.width() + 'px; height:auto; display:block !important; top:0; left:0px;" /></div>').css({
                    left: '0px',
                    width: (thisSlider.width()) + 'px',
                    height: sliceHeight + 'px',
                    opacity: '0',
                    top:'0px'

                })
            );
            $('.c_slice', thisSlider).height(sliceHeight);
        };

        //This runs the animation
        var cRun = function (theSlider, theKids, theSettings, theNudge) {
            // Get our vars
            var theVars = theSlider.data('c:vars');

            // Stop
            if ((!theVars || theVars.stop) && !theNudge) { return false; }

            // Set current background before change
            if (!theNudge) {
                sliderImg.attr('src', theVars.currentImage.attr('src'));
            } else {
                if (theNudge === 'prev') {
                    sliderImg.attr('src', theVars.currentImage.attr('src'));
                }
                if (theNudge === 'next') {
                    sliderImg.attr('src', theVars.currentImage.attr('src'));
                }
            }
            theVars.currentSlide++;
            
            // Sort the ends of the slide show
            if (theVars.currentSlide === theVars.totalSlides) {
                theVars.currentSlide = 0;
            }
            if (theVars.currentSlide < 0) { theVars.currentSlide = (theVars.totalSlides - 1); }
            
            // Set vars.currentImage
            if ($(theKids[theVars.currentSlide]).is('img')) {
                theVars.currentImage = $(theKids[theVars.currentSlide]);
            } else {
                theVars.currentImage = $(theKids[theVars.currentSlide]).find('img:first');
            }

            // Set active links
            if (theSettings.controlNav) {
                $('a', theVars.controlNavEl).removeClass('active');
                $('a:eq(' + theVars.currentSlide + ')', theVars.controlNavEl).addClass('active');
            }

            // Process caption
            processCaption(theSettings);

            // Remove any slices from last transition
            $('.c_slice', theSlider).remove();

            //Run effects
            theVars.running = true;
            var mainSlice;
            createFader(theSlider, theSettings, theVars);
            mainSlice = $('.c_slice', theSlider);
            mainSlice.css({
                'width': theSlider.width() + 'px'
            });
            mainSlice.animate({ opacity: '1.0' }, (theSettings.animSpeed * 2), '', function () { theSlider.trigger('c:animFinished'); });
            return false;
        };
        
        // For debugging
        var trace = function (msg) {
            if (this.console && typeof console.log !== 'undefined') { console.log(msg); }
        };

        // Start / Stop
        this.stop = function () {
            if (!$(element).data('c:vars').stop) {
                $(element).data('c:vars').stop = true;
                trace('Stop Slider');
            }
        };

        this.start = function () {
            if ($(element).data('c:vars').stop) {
                $(element).data('c:vars').stop = false;
                trace('Start Slider');
            }
        };

        return this;
    };
    $.fn.cSlider = function (options) {
        return this.each(function (key, value) {
            var element = $(this);
            // Return early if this element already has a plugin instance
            if (element.data('c_Slider')) { return element.data('c_Slider'); }
            // Pass options to plugin constructor
            var cslider = new cSlider(this, options);
            // Store plugin object in this element's data
            element.data('c_Slider', cslider);
            return false;
        });
    };

    //Default settings
    $.fn.cSlider.defaults = {
        animSpeed: 1000,
        pauseTime: 5000,
        startSlide: 0,
        directionNav: true,
        controlNav: true,
        controlNavThumbs: true,
        afterChange: function () { }
    };

    $.fn._reverse = [].reverse;
})(jQuery);