//plugin definition



(function($) {
	$.fn.extend({
		//pass the options variable to the function
		accordion: function(options) {
			var defaults = {
				accordion: 'true',
				speed: 300,
				closedSign: '+',
				openedSign: '-'
			};

			// Extend our default options with those provided.
			var opts = $.extend(defaults, options);
			//Assign current element to variable, in this case is UL element
			var $this = $(this);


			$this.find("li a span.menu_arrow").click(function() {
					//avoid jumping to the top of the page when the href is an #
					var link = false;
					$(this).parent("a").click(function() {
					if(link == false){
							link = true;
							return false;
						}
					});		
				if ($(this).parent().parent().find("ul").size() != 0) {
					if (opts.accordion) {
						//Do nothing when the list is open
						if (!$(this).parent().parent().find("ul").is(':visible')) {
							parents = $(this).parent().parent().parents("ul");
							visible = $this.find("ul:visible");
							visible.each(function(visibleIndex) {
								var close = true;
								parents.each(function(parentIndex) {
									if (parents[parentIndex] == visible[visibleIndex]) {
										close = false;
										return false;
									}
								});
								if (close) {
									if ($(this).parent().parent().find("ul") != visible[visibleIndex]) {
										$(visible[visibleIndex]).slideUp(opts.speed,
										function() {
											$(this).parent("li").find("span.menu_arrow:first").html(opts.closedSign).removeClass().addClass("menu_arrow arrow_opened");
											$(this).siblings("a").removeClass("current");
											$(this).parent("li").removeClass("active");
										});
									}
								}
							});
						}
					}
					if ($(this).parent().parent().find("ul:first").is(":visible")) {
						$(this).parent().parent().find("ul:first").slideUp(opts.speed,
						function() {
							$(this).parent("li").find("span.menu_arrow:first").delay(opts.speed).html(opts.closedSign).removeClass().addClass("menu_arrow arrow_opened");
							$(this).siblings("a").removeClass("current");
							$(this).parent("li").removeClass("active");
						});
					} else {
						$(this).parent().parent().find("ul:first").slideDown(opts.speed,
						function() {
							$(this).parent("li").find("span.menu_arrow:first").delay(opts.speed).html(opts.openedSign).removeClass().addClass("menu_arrow arrow_closed");
							$(this).siblings("a").addClass("current");
							$(this).parent("li").addClass("active");

						});
					}
				}
			});

		}
	});
})(jQuery);