package com::le::ycl::object::LogRecordInputData;

use strict;
use com::le::common::object::PageableInputData;

use base qw(com::le::common::object::PageableInputData);

sub new {
	my $class = shift;
	my $self = $class->SUPER::new();

	$self->{logRecord} = undef;
	$self->{vehicle} = undef;
	$self->{user} = undef;

	return bless $self, $class;
}

sub setLogRecord {
	my $self = shift;
	$self->{logRecord} = shift;
}

sub getLogRecord {
	return shift->{logRecord};
}

sub setVehicle {
	my $self = shift;
	$self->{vehicle} = shift;
}

sub getVehicle {
	return shift->{vehicle};
}

sub setUser {
	my $self = shift;
	$self->{user} = shift;
}

sub getUser {
	return shift->{user};
}

1;

