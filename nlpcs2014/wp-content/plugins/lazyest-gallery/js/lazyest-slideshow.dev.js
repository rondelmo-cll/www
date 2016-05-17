/*
 jQuery slideshow for Lazyest Gallery
 copyright 2009-2010 Marcel Brinkkemper
 version 1.1
 */

function lg_js_slideshow() {
    jQuery('.lg_loading').each( function() {
      jQuery(this).hide();
    });
    jQuery('.lg_slideshow').each( function() { 
      jQuery(this).children('a').css({opacity: 0.0});
      jQuery(this).children('a').css({visibility: 'visible'});
      var maxWidth = 0; 
      var maxHeight = 0;  
      jQuery(this).children('a').each( function(index, object) {
        var imgWidth = parseInt(jQuery(object).find('img:first').width());
        maxWidth = (imgWidth > maxWidth)? imgWidth : maxWidth;
        var imgHeight = parseInt(jQuery(object).find('img:first').height());
        maxHeight = (imgHeight > maxHeight)? imgHeight : maxHeight;
      })
      jQuery(this).css({width:maxWidth+'px', height:maxHeight+'px'});
      var first = jQuery(this).children('a:first');
      var firstImg = first.find('img');     
      first.css({opacity: 1.0}); 
      var leftPad = ( maxWidth - parseInt( jQuery(this).children('a:first').find('img').width() ) ) / 2;
      var bottomPad = ( maxHeight - parseInt( jQuery(this).children('a:first').find('img').height() ) ) / 2;
      var caption = firstImg.attr('rel');
      if ( !caption ) caption = '';
      if ( caption == ' ' ) { caption = '' };  	
      first.css({opacity: 0.0})
        .addClass('show')
        .animate({opacity: 1.0}, lazyestshow.slideview )
        .css({left: leftPad+'px', bottom:bottomPad+'px'});  
   	  jQuery(this).children('.sscaption').animate({opacity: 0.0}, { queue:false, duration:0 }).animate({height: '0px'}, { queue:true, duration:lazyestshow.captionqueue });
      if ( jQuery(this).attr('id').match('lg_slideshow') && ( caption.length > 0 )  ) {
      jQuery(this).children('.sscaption').css({ width: firstImg.width(), left: leftPad+'px', bottom:bottomPad+'px' });
    	jQuery(this).children('.sscaption').animate({opacity: 0.7},lazyestshow.captionopcty ).animate({height: '100px'},lazyestshow.captionqueue );
    	jQuery(this).children('.sscaption').html(caption);      
      } 
    }); 
  	setInterval('lg_js_gallery_show()', lazyestshow.duration );	
}

function lg_js_gallery_show() {
  jQuery('.lg_slideshow').each( function() {    
    var current = jQuery(this).children('a.show');
  	var next = ((current.next().length) ? ((current.next().hasClass('sscaption'))? jQuery(this).children('a:first') :current.next()) : jQuery(this).children('a:first'));	
  	var nextImg = next.find('img');
    var leftPad = ( parseInt( jQuery(this).width() ) - parseInt( nextImg.width() ) ) / 2;
    var bottomPad = ( parseInt( jQuery(this).height() ) - parseInt( nextImg.height() ) ) / 2;
    var caption = nextImg.attr('rel');  
    if ( !caption ) caption = '';
    if ( caption == ' ' ) { caption = '' };
  	next.css({opacity: 0.0})
  	.addClass('show')
  	.animate({opacity: 1.0}, lazyestshow.slideview )
    .css({left: leftPad+'px', bottom:bottomPad+'px'});
  	current.animate({opacity: 0.0}, lazyestshow.slideview )
  	.removeClass('show');    
   	jQuery(this).children('.sscaption').animate({opacity: 0.0}, { queue:false, duration:0 }).animate({height: '0px'}, { queue:true, duration:lazyestshow.captionqueue });
    if ( jQuery(this).attr('id').match('lg_slideshow') && ( caption.length > 0 ) ) {
      jQuery(this).children('.sscaption').css({ width: nextImg.width(), left: leftPad+'px', bottom:bottomPad+'px' });	
    	jQuery(this).children('.sscaption').animate({opacity: 0.7},lazyestshow.captionopcty ).animate({height: '100px'},lazyestshow.captionqueue );
    	jQuery(this).children('.sscaption').html(caption);      
    }	
  });
}
var lazyest_slideshow = true;
var lazyestCounter = 0;

jQuery(window).load(function() {  
  if(typeof(lazyest_loading) === 'undefined') {
    if ( jQuery('.lg_slideshow').length ) {  
      lg_js_slideshow();
    }
  }
}) ;
