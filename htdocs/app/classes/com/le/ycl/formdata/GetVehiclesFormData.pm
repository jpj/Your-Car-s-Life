package com::le::ycl::formdata::GetVehiclesFormData;

use strict;

sub new {
	my $class = shift;
	my $self = {
		userId => undef,
		vehicleId => undef
	};
	return bless $self, $class;
}

sub setUserId {
	my $self = shift;
	$self->{userId} = shift;
}

sub getUserId {
	return shift->{userId};
}

sub setVehicleId {
	my $self = shift;
	$self->{vehicleId} = shift;
}

sub getVehicleId {
	return shift->{vehicleId};
}

1;

