/*Disable any notification in the admin area*/
jQuery(document).ready(function(e) {
	jQuery('#ts_dis_plg').click(
		function (e) { 
			e.preventDefault();
			jQuery.ajax({
				type: "POST",
				url: ajaxurl ,
				data:'action=delplgnot',
				success:function(data){
					jQuery('.ts_plug_title,.re_plug').slideUp();
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR, textStatus, errorThrown);
				}
			});
		}
	);
});