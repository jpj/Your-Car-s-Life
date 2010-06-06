package _pview::ycltest::view::include::docHeader_html;

use strict;

sub new {
	my $class = shift;
	my $self = {
		attributes => {}
	};
	bless $self, $class;
	return $self;
}

sub setAttribute {
	my $self = shift;
	my $name = shift;
	my $value = shift;

	$self->{attributes}->{$name} = $value;
}

sub getAttribute {
	my $self = shift;
	my $name = shift;
	return $self->{attributes}->{$name};
}

sub printView {
	my $self = shift;
	my $request = shift;
	my $modi_mav = shift;
	my $modi_formdata = shift;
	my $modi_formerrors = shift;
	my $modiBuffer = "";
	
$modiBuffer .= qq(<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Your Car's Life</title>

		<link rel="stylesheet" type="text/css" href="/static/css/layout.css" />
		<link rel="stylesheet" type="text/css" href="/static/css/common.css" />
		<link rel="stylesheet" type="text/css" href="/static/css/unleaded.css" />

		<script type="text/javascript" src="/static/js/util/Globals.js"></script>
		<script type="text/javascript" src="/static/js/util/YCLConstants.js"></script>
		<script type="text/javascript" src="/static/js/util/date.format.js"></script>
		<script type="text/javascript" src="/static/js/view/LoginFormView.js"></script>
		<script type="text/javascript" src="/static/js/view/LogoutView.js"></script>
		<script type="text/javascript" src="/static/js/jquery/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="/static/js/util/Common.js"></script>
		<script type="text/javascript" src="/static/js/util/LoginFunctions.js"></script>
		<script type="text/javascript" src="/static/js/dao/UserDao.js"></script>
		<script type="text/javascript" src="/static/js/controller/CommonController.js"></script>
		<script type="text/javascript" src="/static/js/exception/Exception.js"></script>
);

	return $modiBuffer;
}

1;
