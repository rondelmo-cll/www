function init(){
	$('#all').button('toggle');
	$('.btn').click(function (e) {
		  e.preventDefault(); 
		  
		  switch ($(this).html()) {
		  case 'All':
			  polarity(pol);
		    break;
		  case 'Before':
			  modify_pol('ombb');
			    break;
		  case 'Between':
			  modify_pol('ptbm');
			    break;
		  case 'After':
			  modify_pol('amab');
			    break;			    
		  }
		  
		})
}


function polarity(pol){
	var tot_phrs = pol.length/3;
	$('#tot_phrs').text(tot_phrs);
	pos_neg(pol, tot_phrs);
}

function pos_neg(pol, tot_phrs){
	var period;
	var giorno;
	var phr_pol;
	var positive = 0;
	var negative = 0;
	for(i = 0; i < pol.length; i+=3 ){
		period = pol[i];
		giorno = pol[i+1];
		phr_pol = pol[i+2]
		if(phr_pol == 'pos'){
			positive+=1;
		}
		else
			negative+=1;
	}
	var pos = (positive/tot_phrs).toFixed(2);
	var neg = (negative/tot_phrs).toFixed(2);
	var pos_s = pos.toString();
	pos_s = pos_s.substr(2);
	var neg_s = neg.toString();
	neg_s = neg_s.substr(2);
	$('#pos_phrs').text(pos_s + '%');
	$('#neg_phrs').text(neg_s + '%');
}


function modify_pol(p){
	pol = dati.polarity;
	var period;
	var giorno;
	var phr_pol;
	var positive = 0;
	var negative = 0;
	var tot = 0;
	for(i = 0; i < pol.length; i+=3 ){
		period = pol[i];
		giorno = pol[i+1];
		phr_pol = pol[i+2]
		if(period == p){
			tot+=1;
			if(phr_pol == 'pos')
				positive+=1;
			else
				negative+=1;
		}
	}
	var pos = (positive/tot).toFixed(2);
	var neg = (negative/tot).toFixed(2);
	var pos_s = pos.toString();
	pos_s = pos_s.substr(2);
	var neg_s = neg.toString();
	neg_s = neg_s.substr(2);
	$('#tot_phrs').text(tot);
	$('#pos_phrs').text(pos_s + '%');
	$('#neg_phrs').text(neg_s + '%');	
	
}
