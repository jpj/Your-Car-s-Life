package com::le::ycl::formdata::SaveLogRecordFormData;

sub new {
	my $class = shift;
	my $self = {
		logRecordId => undef,
		vehicleId => undef,
		date => undef,
		odometer => undef,
		gallons => undef,
		octane => undef
	};
	return bless $self, $class;
}

sub setLogRecordId {
	my $self = shift;
	$self->{logRecordId} = shift;
}

sub getLogRecordId {
	return shift->{logRecordId};
}

sub setVehicleId {
	my $self = shift;
	$self->{vehicleId} = shift;
}

sub getVehicleId {
	return shift->{vehicleId};
}

sub setDate {
	my $self = shift;
	$self->{date} = shift;
}

sub getDate {
	return shift->{date};
}

sub setOdometer {
	my $self = shift;
	$self->{odometer} = shift;
}

sub getOdometer {
	return shift->{odometer};
}

sub setGallons {
	my $self = shift;
	$self->{gallons} = shift;
}

sub getGallons {
	return shift->{gallons};
}

sub setOctane {
	my $self = shift;
	$self->{octane} = shift;
}

sub getOctane {
	return shift->{octane};
}

1;

