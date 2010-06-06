package _pview::ycltest::view::saveLogRecordView_xml;

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
	
$modiBuffer .= qq(<saveLogRecord>
	);
 foreach my $error (@{$modi_mav->getObject("errors")}) { 
$modiBuffer .= qq(
	<error>);
$modiBuffer .= $error;
$modiBuffer .= qq(</error>
	);
 } 
$modiBuffer .= qq(
	);
 foreach my $error (@{$modi_formerrors->getFieldErrors()}) { 
$modiBuffer .= qq(
	<error field=");
$modiBuffer .= $error->getField();
$modiBuffer .= qq(">);
$modiBuffer .= $error->getMessage();
$modiBuffer .= qq(</error>
	);
 } 
$modiBuffer .= qq(
	<message>);
$modiBuffer .= $modi_mav->getObject("message");
$modiBuffer .= qq(</message>
	<logRecordId>);
$modiBuffer .= $modi_formdata->getLogRecordId();
$modiBuffer .= qq(</logRecordId>
	<gallons>);
$modiBuffer .= $modi_formdata->getGallons();
$modiBuffer .= qq(</gallons>
</saveLogRecord>
);

	return $modiBuffer;
}

1;
