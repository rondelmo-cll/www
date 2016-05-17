
jQuery(document).ready(function($){
	
	var $window = $(window),
        $menu = $('div.menu'),
		$topmenu = $('div.menu-top');
	
	function checkWindowSize() {
		var width = $window.width();
		if ( width < 824 ) {
			return $menu.addClass('nav-mobile');
		}
		$menu.removeClass('nav-mobile');
	}
	
	function topWindowSize() {
		var width = $window.width();
		if ( width < 641 ) {
			return $topmenu.addClass('top-nav-mobile');
		}
		$topmenu.removeClass('top-nav-mobile');
	}
	
	$window
        .resize(checkWindowSize)
        .trigger('checkWindowSize');
		
		
	checkWindowSize();
	
	$window
        .resize(topWindowSize)
        .trigger('topWindowSize');
		
	topWindowSize();
	
	/* prepend menu icon */
	$('div.menu').append('<div id="menu-icon">Menu</div>');
	$('div.menu-top').append('<div id="top-menu-icon">Top Menu</div>');
	
	
	/* toggle nav */
	$("#menu-icon").on("click", function(){
		$("div.menu > ul").slideToggle();
		$(this).toggleClass("active");
	});
	
	$("#top-menu-icon").on("click", function(){
		$("div.top-nav-mobile > ul").slideToggle();
		$(this).toggleClass("active");
	});
	
	/* toggle search box */
	$("#search-icon").on("click", function(){
		$("#search-box-wrap").slideToggle();
	});
	
	$("#close-x").on("click", function(){
		$("#search-box-wrap").slideUp();
	});
	

	/* jquery cycle */
	var $slider = $('.cycle-slideshow');
	$slider.imagesLoaded( function() {
		$('#load-cycle').hide(); /* preloader */
		$slider.slideDown(1000);
	});
	
	var $container = $('#grid-wrap');
	
	$container.masonry({
	  itemSelector : '.grid-box',
	});
	
	$container.imagesLoaded( function() {
	  $container.masonry({
		  itemSelector : '.grid-box',
	  });
	});
	
	$(window).resize(function() {
		$container.masonry({
		  itemSelector : '.grid-box',
		});
	});

});