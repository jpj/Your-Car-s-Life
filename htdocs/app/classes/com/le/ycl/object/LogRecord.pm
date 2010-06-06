package com::le::ycl::object::LogRecord;

use strict;

sub new {
	my $class = shift;
	my $self = {
		logRecordId => undef,
		vehicleId => undef,
		recordCreated => undef,
		recordModified => undef,
		date => undef,
		jsDate => undef,
		odometer => undef,
		gallons => undef,
		octane => undef,
		dipstick => undef,
		active => undef
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

sub setRecordCreated {
	my $self = shift;
	$self->{recordCreated} = shift;
}

sub getRecordCreated {
	return shift->{recordCreated};
}

sub setRecordModified {
	my $self = shift;
	$self->{recordModified} = shift;
}

sub getRecordModified {
	return shift->{recordModified};
}

sub setDate {
	my $self = shift;
	$self->{date} = shift;
}

sub getDate {
	return shift->{date};
}

sub setJsDate {
	my $self = shift;
	$self->{jsDate} = shift;
}

sub getJsDate {
	return shift->{jsDate};
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

sub setDipstick {
	my $self = shift;
	$self->{dipstick} = shift;
}

sub getDipstick {
	return shift->{dipstick};
}

sub setActive {
	my $self = shift;
	$self->{active} = shift;
}

sub getActive {
	return shift->{active};
}

1;

