package com::le::ycl::object::User;

use strict;

sub new {
	my $class = shift;
	my $self = {
		userId => undef,
		login => undef,
		email => undef,
		firstName => undef,
		lastName => undef,
		enabled => undef
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

sub setLogin {
	my $self = shift;
	$self->{login} = shift;
}

sub getLogin {
	return shift->{login};
}

sub setEmail {
	my $self = shift;
	$self->{email} = shift;
}

sub getEmail {
	return shift->{email};
}

sub setFirstName {
	my $self = shift;
	$self->{firstName} = shift;
}

sub getFirstName {
	return shift->{firstName};
}

sub setLastName {
	my $self = shift;
	$self->{lastName} = shift;
}

sub getLastName {
	return shift->{lastName};
}

sub setEnabled {
	my $self = shift;
	$self->{enabled} = shift;
}

sub getEnabled {
	return shift->{enabled};
}

1;

