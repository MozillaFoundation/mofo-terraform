(function ($, root, undefined) {
	
	$(function () {
		
		'use strict';

		var menuItems = $(".inpage-nav").find("a");

		// Anchors corresponding to menu items
		var scrollItems = menuItems.map(function(){
			var href = $(this).attr("href");
			var aName = href.substr(1);
			var item = $('a[name ="'+aName+'"]');
			if (item.length) { return item; }
		});


		// Bind click handler to menu items
		// so we can get a fancy scroll animation
		menuItems.click(function(e){
			var href = $(this).attr("href");
			var aName = href.substr(1);
			var sectionOffset = $('a[name ="'+aName+'"]').offset().top;

			$('html, body').stop().animate({ 
				scrollTop: sectionOffset - 24
			}, 850);

			e.preventDefault();
		});

		// Bind to scroll
		$(window).scroll(function() {

		    // Get container scroll position
		    var fromTop = $(this).scrollTop() + 230;
		   
		    // Get id of current scroll item
		    var cur = scrollItems.map(function() {
		   	
				if ($(this).offset().top < fromTop) {
					return this;
				}

		    });
		    // Get the id of the current element
		    cur = cur[cur.length-1];

		    if (typeof cur !== 'undefined') {
			    var curName = $(cur).attr('name');
			    if( ($(cur).offset().top < fromTop) ) {
			   		$("span.title-el").removeClass("current");
			   		$('a[href="#'+curName+'"] span.title-el').addClass("current");
				}
			}
			else {
				// if scroll not in range of sub section, remove highlights from inpage nav
				$("span.title-el").removeClass("current");
			}
           
		});


		var bottom = $( ".copy p" ).last().offset().top;
		console.log("h2 bototm: " + bottom);

		// inpage nav stick to bottom of div
		window.addEventListener('scroll', function(e) {

			// console.log( $(window).scrollTop() );

  	// 		if ($(window).scrollTop() > bottom) {
   //    			$('.inpage-nav').removeClass('fixed-bottom');
   //  		}

   //  		if ($(window).scrollTop() < bottom) {
   //    			$('.inpage-nav').addClass('fixed-bottom');
      			
   //  		}

  		});


	});
	
})(jQuery, this);
