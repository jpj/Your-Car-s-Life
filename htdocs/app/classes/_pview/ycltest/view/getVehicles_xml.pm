package _pview::ycltest::view::getVehicles_xml;

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
	
$modiBuffer .= qq(<vehicles>
	
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

	);
 foreach my $vehicle (@{$modi_mav->getObject("vehicleList")}) { 
$modiBuffer .= qq(
	<vehicle>
		<vehicleId>);
$modiBuffer .= $vehicle->getVehicleId();
$modiBuffer .= qq(</vehicleId>
		<name>);
$modiBuffer .= $vehicle->getName();
$modiBuffer .= qq(</name>
		<notes>);
$modiBuffer .= $vehicle->getNotes();
$modiBuffer .= qq(</notes>
	</vehicle>
	);
 } 
$modiBuffer .= qq(
</vehicles>
);

	return $modiBuffer;
}

1;
