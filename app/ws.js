var dati = null;

$(document).ready(function(){
//	$('#submit').click(function() {
		$.ajax({
			type : 'POST',
			url : 'post.php',
			dataType : 'json',
			data: {
				action : 'init'
			},
			success : function(data){
				
				
				if (data.error === true)
					$('#polarity').text("error");
				else{
					dati = data;
					polarity(data.polarity);
//					$('#frequency').text('Freqency: ' + data.freq);
				}
				
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				
				$('#polarity').text('There was an error.').show(500);
			}
		});

		return false;
//	});
});