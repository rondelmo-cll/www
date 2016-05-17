#!/usr/bin/perl
use utf8;
use Encode;
use CGI::Carp('fatalsToBrowser');

if ($ENV{REQUEST_METHOD} eq "GET") {
	print("Content-type: text/html\n\n");
	print(<<"INTRO");
<html>
	<head>
		<title>VENSES: Venice Semantic Evaluation System</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<h1>VENSES: Venice Semantic Evaluation System</h1>
		<form action="venses.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>Venses is a system for recognizing textual entailment developed by Rodolfo Delmonte and can be regarded as a wrapper on top of two subsystems: a reduced version of GETARUN which produces the semantics from complete linguistic representations; a partial robust constituency-based parser.</p>
			<p>Try writing a small text and a shorter hypothesis and the system will tell you if the former entails the latter.</p>
			<p>Text:<br />
				<textarea name="text" rows="5" cols="60"></textarea>
			</p>
			<p>Hypothesis:<br />
				<input name="hypo" size="60" />
			</p>
			<p>
				<input type="submit" name="choice" value="Submit" />
			</p>
			<hr />
			<p>Instead of making up a text yourself, you might want to load one of the RTE Challenge sample texts and its relevant hypothesis to try the system out. Make your choice in the menu below and click on the Load button to have them loaded in the above windows for your use as a template to further improve upon before submission to the system.</p>
			<p>
				<select name="menu">
					<option value="0">--------------------</option>
					<optgroup label="RTE 5 devset">
						<option value="51">01 (true)</option>
						<option value="52">02 (unknown)</option>
						<option value="53">03 (unknown)</option>
						<option value="54">06 (false)</option>
						<option value="55">42 (true)</option>
					</optgroup>
					<optgroup label="RTE 3 testset">
						<option value="31">01 (true)</option>
						<option value="32">02 (true)</option>
						<option value="33">07 (false)</option>
						<option value="34">13 (unknown)</option>
						<option value="35">15 (true)</option>
					</optgroup>
				</select>
				<input type="submit" name="choice" value="Load" />
			</p>
		</form>
	</body>
</html>
INTRO
} else {

#+!"%23%24%25%26'()*%2B%2C-.%2F0123456789%3A%3B<%3D>%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
# !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~
#ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ
#%C0%C1%C2%C3%C4%C5%C6%C7%C8%C9%CA%CB%CC%CD%CE%CF%D0%D1%D2%D3%D4%D5%D6%D7%D8%D9%DA%DB%DC%DD%DE%DF%E0%E1%E2%E3%E4%E5%E6%E7%E8%E9%EA%EB%EC%ED%EE%EF%F0%F1%F2%F3%F4%F5%F6%F7%F8%F9%FA%FB%FC%FD%FE%FF

	read(STDIN, $sentence, $ENV{CONTENT_LENGTH});
	$sentence=decode('UTF-8',$sentence);
	$boundary=$ENV{CONTENT_TYPE};
	$boundary=~s/^multipart\/form-data; boundary=//;
	$sentence=~m/^--$boundary\x0d\x0aContent-Disposition: form-data; name="(.*?)"\x0d\x0a\x0d\x0a(.*?)\x0d\x0a--$boundary\x0d\x0aContent-Disposition: form-data; name="(.*?)"\x0d\x0a\x0d\x0a(.*?)\x0d\x0a--$boundary\x0d\x0aContent-Disposition: form-data; name="(.*?)"\x0d\x0a\x0d\x0a(.*?)\x0d\x0a--$boundary\x0d\x0aContent-Disposition: form-data; name="(.*?)"\x0d\x0a\x0d\x0a(.*?)\x0d\x0a--$boundary--\x0d\x0a$/s;
	$var{$1}=$2;
	$var{$3}=$4;
	$var{$5}=$6;
	$var{$7}=$8;
	if($var{"choice"} eq "Load"){
		if($var{"menu"} eq "51"){$tempa="The disappearance of York University chef Claudia Lawrence is now being treated as suspected murder, North Yorkshire Police said. However detectives said they had not found any proof that the 35-year-old, who went missing on 18 March, was dead. Her father Peter Lawrence made a direct appeal to his daughter to contact him five weeks after she disappeared. His plea came at a news conference held shortly after a 10,000 pounds reward was offered to help find Miss Lawrence. Crimestoppers said the sum they were offering was &quot;significantly higher&quot; than usual because of public interest in the case.";$tempb="Claudia Lawrence is 35 years old.";}
		elsif($var{"menu"} eq "52"){$tempa="Any taxpayer earning over 150,000 pounds will no longer enjoy higher-rate tax relief, which is considered a substantial incentive to save for wealthy workers. From April 2011, anyone who earns 200,000 pounds a year, for example, and pays the typical amount of 6 per cent of their salary into their company pension scheme will lose out on 200 pounds a month or 2,400 pounds a year . Alistair Darling, when he announced the move in the Budget, insisted that just 1.5 per cent of taxpayers - the equivalent of about 450,000 people - would be hit, but experts argued that it would significantly damage the already beleaguered pensions industry, and cause many savers to think twice about investing in a pension.";$tempb="Alistair Darling is chancellor of UK.";}
		elsif($var{"menu"} eq "53"){$tempa="Concerns have been raised that potential leads in the hunt for missing York woman Claudia Lawrence are not being followed up quickly enough. It comes after hotel staff in Malton contacted police after a stranger in the bar expressed satisfaction when asked if the chef was still missing. The incident happened more than three weeks ago and staff said detectives had not yet been in touch. Police said leads were being assessed in a methodical and structured way.";$tempb="Claudia Lawrence resides in Malton.";}
		elsif($var{"menu"} eq "54"){$tempa="But an O2 insider said there had been problems with a companies trying to sell the pass codes. Some people were &quot;bound to have been turned away&quot; because of fraudulent tickets. Led Zeppelin, formed in 1968, were one of the most influential bands of the 1970s with songs such as Whole Lotta Love and Stairway To Heaven. They split in 1980 after the death of the drummer John Bonham. Kenneth Donnell, 25, who was not born in 1980, spent 83,000 pounds on two tickets in a BBC Children in Need auction.";$tempb="The band Led Zeppelin was formed in 1980.";}
		elsif($var{"menu"} eq "55"){$tempa="DENVER - Angie Zapata was a tall woman with striking black hair and eyes who would attract the attention of men, even those who knew she was biologically male. But prosecutors say when Allen Andrade found out, he beat her to death with a fire extinguisher. Her sister discovered her battered body under a blanket in her Greeley apartment last July. Andrade, 32, of Thorton, is scheduled to go on trial Tuesday on charges including first-degree murder and a bias-motivated crime, which could add three years to his prison sentence if convicted.";$tempb="Angie Zapata has been killed with a fire extinguisher.";}
		elsif($var{"menu"} eq "31"){$tempa="Claude Chabrol (born June 24, 1930) is a French movie director and has become well-known in the 40 years since his first film, Le Beau Serge, for his chilling tales of murder, including Le Boucher.";$tempb="Le Beau Serge was directed by Chabrol.";}
		elsif($var{"menu"} eq "32"){$tempa="Claude Chabrol (born June 24 , 1930) is a French movie director and has become well-known in the 40 years since his first film, Le Beau Serge, for his chilling tales of murder, including Le Boucher.";$tempb="Le Boucher was made by a French movie director.";}
		elsif($var{"menu"} eq "33"){$tempa="Sandra Goudie was first elected to Parliament in the 2002 elections, narrowly winning the seat of Coromandel by defeating Labour candidate Max Purnell and pushing incumbent Green MP Jeanette Fitzsimons into third place.";$tempb="Sandra Goudie was defeated by Max Purnell.";}
		elsif($var{"menu"} eq "34"){$tempa="In 1956 Accardo won the Geneva Competition and in 1958 became the first prize winner of the Paganini Competition in Genoa. He has recorded Paganini's famous 24 Caprices (re-recorded in 1999) for solo violin and was the first to record all six of the Paganini Violin Concertos.";$tempb="Accardo composed 24 Caprices.";}
		elsif($var{"menu"} eq "35"){$tempa="Dawson is currently a Professorial Fellow at the University of Melbourne, and an Adjunct Professor at Monash University.";$tempb="Dawson teaches at Monash University.";}
		else{$tempa="";$tempb="";}
		print("Content-type: text/html\n\n");
		$print=(<<"LOAD");
<html>
	<head>
		<title>VENSES: Venice Semantic Evaluation System</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<h1>VENSES: Venice Semantic Evaluation System</h1>
		<form action="venses.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>Venses is a system for recognizing textual entailment developed by Rodolfo Delmonte and can be regarded as a wrapper on top of two subsystems: a reduced version of GETARUN which produces the semantics from complete linguistic representations; a partial robust constituency-based parser.</p>
			<p>Try writing a small text and a shorter hypothesis and the system will tell you if the former entails the latter.</p>
			<p>Text:<br />
				<textarea name="text" rows="5" cols="60">$tempa</textarea>
			</p>
			<p>Hypothesis:<br />
				<input name="hypo" size="60" value="$tempb" />
			</p>
			<p>
				<input type="submit" name="choice" value="Submit" />
			</p>
			<hr />
			<p>Instead of making up a text yourself, you might want to load one of the RTE Challenge sample texts and its relevant hypothesis to try the system out. Make your choice in the menu below and click on the Load button to have them loaded in the above windows for your use as a template to further improve upon before submission to the system.</p>
			<p>
				<select name="menu">
					<option value="0">--------------------</option>
					<optgroup label="RTE 5 devset">
						<option value="51">01 (true)</option>
						<option value="52">02 (unknown)</option>
						<option value="53">03 (unknown)</option>
						<option value="54">06 (false)</option>
						<option value="55">42 (true)</option>
					</optgroup>
					<optgroup label="RTE 3 testset">
						<option value="31">01 (true)</option>
						<option value="32">02 (true)</option>
						<option value="33">07 (false)</option>
						<option value="34">13 (unknown)</option>
						<option value="35">15 (true)</option>
					</optgroup>
				</select>
				<input type="submit" name="choice" value="Load" />
			</p>
		</form>
	</body>
</html>
LOAD
		$print=encode('UTF-8',$print);
		print($print);
	} else {
		if($var{"text"} eq "" or $var{"hypo"} eq ""){

			$var{"text"}=~s/"/&quot;/sg;
			$var{"hypo"}=~s/"/&quot;/g;
			print("Content-type: text/html\n\n");
			$print=(<<"OUTRO");
<html>
	<head>
		<title>VENSES: Venice Semantic Evaluation System</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<h1>VENSES: Venice Semantic Evaluation System</h1>
		<form action="venses.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>Venses is a system for recognizing textual entailment developed by Rodolfo Delmonte and can be regarded as a wrapper on top of two subsystems: a reduced version of GETARUN which produces the semantics from complete linguistic representations; a partial robust constituency-based parser.</p>
			<p>Try writing a small text and a shorter hypothesis and the system will tell you if the former entails the latter.</p>
			<p>Text:<br />
				<textarea name="text" rows="5" cols="60">$var{"text"}</textarea>
			</p>
			<p>Hypothesis:<br />
				<input name="hypo" size="60" value="$var{"hypo"}" />
			</p>
			<p>
				<input type="submit" name="choice" value="Submit" />
			</p>
			<p><font color="red">You must insert BOTH a text and a hypothesis.</font></p>
			<hr />
			<p>Instead of making up a text yourself, you might want to load one of the RTE Challenge sample texts and its relevant hypothesis to try the system out. Make your choice in the menu below and click on the Load button to have them loaded in the above windows for your use as a template to further improve upon before submission to the system.</p>
			<p>
				<select name="menu">
					<option value="0">--------------------</option>
					<optgroup label="RTE 5 devset">
						<option value="51">01 (true)</option>
						<option value="52">02 (unknown)</option>
						<option value="53">03 (unknown)</option>
						<option value="54">06 (false)</option>
						<option value="55">42 (true)</option>
					</optgroup>
					<optgroup label="RTE 3 testset">
						<option value="31">01 (true)</option>
						<option value="32">02 (true)</option>
						<option value="33">07 (false)</option>
						<option value="34">13 (unknown)</option>
						<option value="35">15 (true)</option>
					</optgroup>
				</select>
				<input type="submit" name="choice" value="Load" />
			</p>
		</form>
	</body>
</html>
OUTRO
			$print=encode('UTF-8',$print);
			print($print);
		} else {

			$var{"text"}=~s/$/./sg;

			$var{"text"}=~s/(\D),/\1 , /sg;
			$var{"hypo"}=~s/(\D),/\1 , /g;

			$var{"text"}=~s/,(\D)/ , \1/sg;
			$var{"hypo"}=~s/,(\D)/ , \1/g;

			$var{"text"}=~s/,$/ ,/sg;
			$var{"hypo"}=~s/,$/ ,/g;

			$var{"text"}=~s/^,/, /sg;
			$var{"hypo"}=~s/^,/, /g;

			$var{"text"}=~s/(\D)\./\1 \. /sg;
			$var{"hypo"}=~s/(\D)\./\1 \. /g;

			$var{"text"}=~s/\.(\D)/ \. \1/sg;
			$var{"hypo"}=~s/\.(\D)/ \. \1/g;

			$var{"text"}=~s/\.$/ \./sg;
			$var{"hypo"}=~s/\.$/ \./g;

			$var{"text"}=~s/^\./\. /sg;
			$var{"hypo"}=~s/^\./\. /g;

			$var{"text"}=~s/!/ ! /sg;
			$var{"hypo"}=~s/!/ ! /g;

			$var{"text"}=~s/\?/ ? /sg;
			$var{"hypo"}=~s/\?/ ? /g;

			$var{"text"}=~s/:/ : /sg;
			$var{"hypo"}=~s/:/ : /g;

			$var{"text"}=~s/;/ ; /sg;
			$var{"hypo"}=~s/;/ ; /g;

			$var{"text"}=~s/"/ " /sg;
			$var{"hypo"}=~s/"/ " /g;

			$var{"text"}=~s/\(/ \( /sg;
			$var{"hypo"}=~s/\(/ \( /g;

			$var{"text"}=~s/\)/ \) /sg;
			$var{"hypo"}=~s/\)/ \) /g;

			$var{"text"}=~s/\x0d\x0a/ /sg;

			$var{"text"}=~s/ +/ /sg;
			$var{"hypo"}=~s/ +/ /g;

			$var{"text"}=~s/^ //sg;
			$var{"hypo"}=~s/^ //g;

			$var{"text"}=~s/ $//sg;
			$var{"hypo"}=~s/ $//g;

			$var{"text"}=~s/([^ ])/\\\1/sg;
			$var{"hypo"}=~s/([^ ])/\\\1/g;
			
			$ENV{VENSES_TEXT} = encode('UTF-8',$var{'text'});
			$ENV{VENSES_HYPO} = encode('UTF-8',$var{'hypo'});
			$new="echo ./myprog \$VENSES_TEXT \$VENSES_HYPO";
			$new=encode('UTF-8',$new);
			$output=`$new`;
			print("Content-type: text/plain\n\n");
			print($output);
		}
	}
}

