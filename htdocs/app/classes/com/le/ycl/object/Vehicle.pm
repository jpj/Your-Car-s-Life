package com::le::ycl::object::Vehicle;

use strict;

sub new {
	my $class = shift;
	my $self = {
		vehicleId => undef,
		user => undef,
		name => undef,
		description => undef,
		notes => undef
	};
	return bless $self, $class;
}

sub setVehicleId {
	my $self = shift;
	$self->{vehicleId} = shift;
}

sub getVehicleId {
	return shift->{vehicleId};
}

sub setUser {
	my $self = shift;
	$self->{user} = shift;
}

sub getUser {
	return shift->{user};
}

sub setName {
	my $self = shift;
	$self->{name} = shift;
}

sub getName {
	return shift->{name};
}

sub setDescription {
	my $self = shift;
	$self->{description} = shift;
}

sub getDescription {
	return shift->{description};
}

sub setNotes {
	my $self = shift;
	$self->{notes} = shift;
}

sub getNotes {
	return shift->{notes};
}

1;

