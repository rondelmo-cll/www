#!/usr/bin/perl
use utf8;
use Encode;
use CGI::Carp('fatalsToBrowser');
print("Content-type: text/html\n\n");
if ($ENV{REQUEST_METHOD} eq "GET") {
	print(<<"INTRO");
<html>
	<head>
		<title>POS Tagger for the Venetan language</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<h1>POS Tagger for the Venetan language</h1>
		<form action="tagger.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>Input your sentence in the following space. Here are some examples:</p>
			<ul>
				<li>Dałe olte i sogni i se avéra.</li>
				<li>I skei i juta a soportar ła povartà.</li>
				<li>Cuel ke gavémo in comun xe ke sémo tuti difarenti l' un da l' altro.</li>
			</ul>
			<p>
				<input name="input" size="60" />
				<br /><br />
				<input type="submit" value="Tag" />
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
	$sentence=decode('UTF-8', $sentence);
	$boundary=$ENV{CONTENT_TYPE};
	$boundary=~s/^multipart\/form-data; boundary=//;
	$sentence=~s/^--$boundary\x0d\x0aContent-Disposition: form-data; name="input"\x0d\x0a\x0d\x0a//;
	$sentence=~s/\x0d\x0a--$boundary--\x0d\x0a$//;

	#$sentence=~s/(\D),/\1 , /g;
	#$sentence=~s/,(\D)/ , \1/g;
	#$sentence=~s/,$/ ,/g;
	#$sentence=~s/^,/, /g;
	#$sentence=~s/(\D)\./\1 \. /g;
	#$sentence=~s/\.(\D)/ \. \1/g;
	#$sentence=~s/\.$/ \./g;
	#$sentence=~s/^\./\. /g;
	#$sentence=~s/\(/ \( /g;
	#$sentence=~s/\)/ \) /g;
	#$sentence=~s/'/' /g;
	#$sentence=~s/!/ ! /g;
	#$sentence=~s/\?/ ? /g;
	#$sentence=~s/:/ : /g;
	#$sentence=~s/;/ ; /g;
	#$sentence=~s/"/ " /g;
	#$sentence=~s/ +/ /g;
	#$sentence=~s/^ //;
	#$sentence=~s/ $//;

=comment
	$sentence=~s/A/a/g;
	$sentence=~s/B/b/g;
	$sentence=~s/C/c/g;
	$sentence=~s/D/d/g;
	$sentence=~s/E/e/g;
	$sentence=~s/F/f/g;
	$sentence=~s/G/g/g;
	$sentence=~s/H/h/g;
	$sentence=~s/I/i/g;
	$sentence=~s/J/j/g;
	$sentence=~s/K/k/g;
	$sentence=~s/L/l/g;
	$sentence=~s/M/m/g;
	$sentence=~s/N/n/g;
	$sentence=~s/O/o/g;
	$sentence=~s/P/p/g;
	$sentence=~s/Q/q/g;
	$sentence=~s/R/r/g;
	$sentence=~s/S/s/g;
	$sentence=~s/T/t/g;
	$sentence=~s/U/u/g;
	$sentence=~s/V/v/g;
	$sentence=~s/W/w/g;
	$sentence=~s/X/x/g;
	$sentence=~s/Y/y/g;
	$sentence=~s/Z/z/g;
	$sentence=~s/À/à/g;
	$sentence=~s/Á/á/g;
	$sentence=~s/Â/â/g;
	$sentence=~s/Ã/ã/g;
	$sentence=~s/Ä/ä/g;
	$sentence=~s/Å/å/g;
	$sentence=~s/Æ/æ/g;
	$sentence=~s/Ç/ç/g;
	$sentence=~s/È/è/g;
	$sentence=~s/É/é/g;
	$sentence=~s/Ê/ê/g;
	$sentence=~s/Ë/ë/g;
	$sentence=~s/Ì/ì/g;
	$sentence=~s/Í/í/g;
	$sentence=~s/Î/î/g;
	$sentence=~s/Ï/ï/g;
	$sentence=~s/Ð/ð/g;
	$sentence=~s/Ñ/ñ/g;
	$sentence=~s/Ò/ò/g;
	$sentence=~s/Ó/ó/g;
	$sentence=~s/Ô/ô/g;
	$sentence=~s/Õ/õ/g;
	$sentence=~s/Ö/ö/g;
	$sentence=~s/Ø/ø/g;
	$sentence=~s/Ù/ù/g;
	$sentence=~s/Ú/ú/g;
	$sentence=~s/Û/û/g;
	$sentence=~s/Ü/ü/g;
	$sentence=~s/Ý/ý/g;
	$sentence=~s/Þ/þ/g;
	$sentence=~s/Ł/ł/g;
	$sentence=~s/£/ł/g;
=cut

	#$sentence=~tr/ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŁ£/abcdefghijklmnopqrstuvwxyzàáâãäåæçèéêëìíîïðñòóôõöøùúûüýþłł/;

	$value=$sentence;
	$value=~s/"/&quot;/g;
	$sentence=~s/(.)/\\\1/g;
	$print=(<<"OUTRO_OP");
<html>
	<head>
		<title>POS Tagger for the Venetan language</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<h1>POS Tagger for the Venetan language</h1>
		<form action="tagger.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>Input your sentence in the following space. Here are some examples:</p>
			<ul>
				<li>Dałe olte i sogni i se avéra.</li>
				<li>I skei i juta a soportar ła povartà.</li>
				<li>Cuel ke gavémo in comun xe ke sémo tuti difarenti l' un da l' altro.</li>
			</ul>
			<p>
				<input name="input" size="60" />
				<br /><br />
				<input type="submit" value="Tag" />
			</p>
		</form>
OUTRO_OP
	$print=encode('UTF-8',$print);
	print($print);
	if($sentence ne ""){
		$sentence=encode('UTF-8',$sentence);
		$translation=`./tagger.sh $sentence`;
		$translation=decode('UTF-8', $translation);
		$translation=~s/\\x([[:xdigit:]][[:xdigit:]])/chr hex $1/ge;
		$translation=~s/\\u([[:xdigit:]][[:xdigit:]][[:xdigit:]][[:xdigit:]])/chr hex $1/ge;
		$translation=~s/\(u'/('/g;
		$translation=~s/\(u"/("/g;
		$print=(<<"OUTRO_MID_1");
		<p>Your Venetan sentence has been tagged as:</p>
		<p><font color="red">$translation</font></p>
OUTRO_MID_1
		$print=encode('UTF-8',$print);
		print($print);
	} else {
		$print=(<<"OUTRO_MID_2");
		<p>No sentence has been typed.</p>
OUTRO_MID_2
		$print=encode('UTF-8', $print);
		print($print);
	}
	print(<<"OUTRO_ED");
	</body>
</html>
OUTRO_ED

=comment
print("<html><head><title>ENV information</title><head><body><ol>\n");
foreach $key (keys(%ENV)) {
	print("<li>$key\t$ENV{$key}\n");
}
print("</ol></body></html>\n");
=cut
}

