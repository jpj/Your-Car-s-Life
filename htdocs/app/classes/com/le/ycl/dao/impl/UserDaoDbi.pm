package com::le::ycl::dao::impl::UserDaoDbi;

use strict;
use com::le::common::exception::DaoException;
use com::le::ycl::object::User;
use Error qw(:try);
use Digest::MD5;

my $SELECT = "SELECT USER_ID, LOGIN, EMAIL, FIRST_NAME, LAST_NAME, ENABLED ";

sub new {
	my $class = shift;
	my $self = {
		dbConnector => undef
	};
	return bless $self, $class;
}

sub getUserByLoginAndPassword {
	my $self = shift;
	my $login = shift;
	my $password = shift;
	my $user = undef;

	my $passwordMd5 = new Digest::MD5();
	$passwordMd5->add($password);

	my $conn = $self->{dbConnector}->getConnection();
	my $sth = $conn->prepare(
		$SELECT . " FROM USER WHERE LOGIN=? AND PASSWORD=?"
	);
	$sth->execute($login, $passwordMd5->hexdigest());

	if (my $rs = $sth->fetchrow_hashref()) {
		$user = new com::le::ycl::object::User();
		$user->setUserId( $rs->{USER_ID} );
		$user->setLogin( $rs->{LOGIN} );
		$user->setEmail( $rs->{EMAIL} );
		$user->setFirstName( $rs->{FIRST_NAME} );
		$user->setLastName( $rs->{LAST_NAME} );
		$user->setEnabled( $rs->{ENABLED} );
	}

	$sth->finish();
	$conn->disconnect();

	return $user;
}

sub getUserById {
	my $self = shift;
	my $userId = shift;

	my $user = undef;
	my $conn = undef;
	my $sth = undef;

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare(
			$SELECT . " FROM USER WHERE USER_ID=?"
		);
		$sth->execute($userId);

		if (my $rs = $sth->fetchrow_hashref()) {
			$user = new com::le::ycl::object::User();
			$user->setUserId( $rs->{USER_ID} );
			$user->setLogin( $rs->{LOGIN} );
			$user->setEmail( $rs->{EMAIL} );
			$user->setFirstName( $rs->{FIRST_NAME} );
			$user->setLastName( $rs->{LAST_NAME} );
			$user->setEnabled( $rs->{ENABLED} );
		}
	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};

	return $user;
}

sub setDbConnector {
	my $self = shift;
	$self->{dbConnector} = shift;
}

1;

