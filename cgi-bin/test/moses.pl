#!/usr/bin/perl
use utf8;
use Encode;
use CGI::Carp('fatalsToBrowser');

print("Content-type: text/html\n\n");
if ($ENV{REQUEST_METHOD} eq "GET") {
	$print=(<<"TEXT");
<html>
	<head>
		<title>TEST</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<form action="moses.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>
				<input name="text" size="100" value="$text" />
				<br />
				<input type="submit" value="Translate" />
			</p>
		</form>
	</body>
</html>
TEXT
	$print=encode('UTF-8',$print);
	print($print);
} else {
	read(STDIN, $data, $ENV{CONTENT_LENGTH});
	$data=decode('UTF-8', $data);
	$ENV{CONTENT_TYPE}=~m/^multipart\/form-data; boundary=(.*)/;
	$data=~m/^--$1\x0d\x0aContent-Disposition: form-data; name="text"\x0d\x0a\x0d\x0a(.*)\x0d\x0a--$1--\x0d\x0a$/;
	$text=$input1=$input2=$1;
	$text=~s/"/&quot;/g;

	$input1=~s/(\|[^ ]*)//g;
	$input1=~s/(.)/\\\1/g;
	$input2=~s/(.)/\\\1/g;

	$input1=encode('UTF-8',$input1);
	$output1=`echo $input1 | moses -f moses1.ini -monotone-at-punctuation`;
	$output1=decode('UTF-8', $output1);

	$input2=encode('UTF-8',$input2);
	$output2=`echo $input2 | moses -f moses2.ini -monotone-at-punctuation`;
	$output2=decode('UTF-8', $output2);

	$print=(<<"TEXT");
<html>
	<head>
		<title>TEST</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	</head>
	<body>
		<form action="moses.pl" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">
			<p>
				<input name="text" size="100" value="$text" />
				<br />
				<input type="submit" value="Translate" />
			</p>
		</form>
		<p><b>Unfactored model:</b><br /><font color="red">$output1</font></p>
		<p><b>Factored model:</b><br /><font color="red">$output2</font></p>
	</body>
</html>
TEXT
	$print=encode('UTF-8',$print);
	print($print);
}
