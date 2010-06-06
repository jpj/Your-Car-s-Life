package com::le::ycl::dao::impl::VehicleDaoDbi;

use strict;
use com::le::ycl::object::Vehicle;
use com::le::ycl::object::User;
use com::le::common::exception::DaoException;
use com::le::common::exception::DbConnectionException;
use com::le::common::exception::SQLException;
use Error qw(:try);

my $SELECT = "SELECT V.VEHICLE_ID, V.USER_ID, V.NAME, V.DESCRIPTION, V.NOTES ";

sub new {
	my $class = shift;
	my $self = {
		dbConnector => undef,
		userDao => undef
	};
	return bless $self, $class;
}

sub getVehicleById {
	my $self = shift;
	my $vehicleId = shift;

	my $vehicle = undef;
	my $conn = undef;
	my $sth = undef;

	my $query = $SELECT . " FROM USER_VEHICLE V WHERE V.VEHICLE_ID=?";

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare($query);
		$sth->execute($vehicleId);
	
		if (my $rs = $sth->fetchrow_hashref()) {
			$vehicle = new com::le::ycl::object::Vehicle();
			$vehicle->setVehicleId( $rs->{VEHICLE_ID} );
			#$vehicle->setRecordCreated( $rs->{RECORD_CREATED} );
			#$vehicle->setRecordModified( $rs->{RECORD_MODIFIED} );
			$vehicle->setDescription( $rs->{DESCRIPTION} );
			$vehicle->setNotes( $rs->{NOTES} );
			$vehicle->setUser( $self->{userDao}->getUserById($rs->{USER_ID}) );
		}

	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};

	return $vehicle;
}

sub getVehicles {
	my $self = shift;
	my $inputData = shift;

	my $vehicleList = [];

	my $query = $SELECT . " FROM USER_VEHICLE V, USER U WHERE V.USER_ID=U.USER_ID";
	my @params = ();

	if ( defined($inputData->getUser()) ) {
		if ( defined($inputData->getUser()->getUserId()) ) {
			$query .= " AND U.USER_ID=?";
			push(@params, $inputData->getUser()->getUserId());
		}
	}

	if ( defined($inputData->getVehicle()) ) {
		if ( defined($inputData->getVehicle()->getVehicleId()) ) {
			$query .= " AND V.VEHICLE_ID=?";
			push(@params, $inputData->getVehicle()->getVegicleId());
		}
	}
 
 	$query .= " ORDER BY V.NAME";

	if ( defined($inputData->getMaxResults()) ) {
		$query .= " LIMIT ?";
		push(@params, $inputData->getMaxResults());
	}

	if ( defined($inputData->getOffset()) && $inputData->getOffset() > 0 ) {
		$query .= " OFFSET ?";
		push(@params, $inputData->getOffset());
	}

	my $conn = undef;
	my $sth = undef;

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare($query);
		$sth->execute(@params);

		while (my $rs = $sth->fetchrow_hashref()) {
			my $vehicle = new com::le::ycl::object::Vehicle();
			$vehicle->setVehicleId( $rs->{VEHICLE_ID} );
			$vehicle->setName( $rs->{NAME} );
			$vehicle->setNotes( $rs->{NOTES} );
			push(@{$vehicleList}, $vehicle);
		}
	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};

	return $vehicleList;
}

sub getLogRecordCount {
	my $self = shift;
	my $inputData = shift;

	my $logRecordCount = -1;

	my $conn = $self->{dbConnector}->getConnection();
	my $query = "";
	my @params = ();

	$query .= "SELECT COUNT(*) AS COUNT FROM LOG L, USER_VEHICLE V, USER U WHERE L.VEHICLE_ID=V.AUTO_ID AND V.USER_ID=U.USER_ID";

	if ( defined($inputData->getUser()) ) {
		if ( defined($inputData->getUser()->getUserId()) ) {
			$query .= " AND U.USER_ID=?";
			push(@params, $inputData->getUser()->getUserId());
		}
	}

	if ( defined($inputData->getLogRecord()) ) {
		if ( defined($inputData->getLogRecord()->getLogRecordId()) ) {
			$query .= " AND L.LOG_ID=?";
			push(@params, $inputData->getLogRecord()->getLogRecordId());
		}
	}
	
	my $sth = $conn->prepare($query);
	$sth->execute(@params);

	if (my $rs = $sth->fetchrow_hashref()) {
		$logRecordCount = $rs->{COUNT};
	}

	$sth->finish();
	$conn->disconnect();

	return $logRecordCount;
}

sub addLogRecord {
	my $self = shift;
	my $logRecord = shift;

	my $conn = undef;
	my $sth = undef;

	my $query = "INSERT INTO LOG (VEHICLE_ID, LOG_DATE, ODOMETER, GALLONS, OCTANE, ACTIVE, RECORD_CREATED)";
	my @params = ();

	$query .= " VALUES (";

	$query .= "?,";
	push(@params, $logRecord->getVehicleId());

	$query .= "?,";
	push(@params, $logRecord->getDate());

	$query .= "?,";
	push(@params, $logRecord->getOdometer());

	$query .= "?,";
	push(@params, $logRecord->getGallons());

	$query .= "?,";
	push(@params, $logRecord->getOctane());

	$query .= "?,";
	push(@params, $logRecord->getActive());

	$query .= "NOW())";

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare($query);
		$sth->execute(@params);
	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e . "\nQuery: " . $query);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};

}

sub updateLogRecord {
	my $self = shift;
	my $logRecord = shift;

	my $conn = undef;
	my $sth = undef;

	my $query = "UPDATE LOG SET ";
	my @params = ();

	$query .= "VEHICLE_ID=?, ";
	push(@params, $logRecord->getVehicleId());

	$query .= "LOG_DATE=?, ";
	push(@params, $logRecord->getDate());

	$query .= "ODOMETER=?, ";
	push(@params, $logRecord->getOdometer());

	$query .= "GALLONS=?, ";
	push(@params, $logRecord->getGallons());

	$query .= "OCTANE=?, ";
	push(@params, $logRecord->getOctane());

	$query .= "ACTIVE=? ";
	push(@params, $logRecord->getActive());

	$query .= "WHERE LOG_ID=?";
	push(@params, $logRecord->getLogRecordId());

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare($query);
		$sth->execute(@params);
	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};
}

sub setDbConnector {
	my $self = shift;
	$self->{dbConnector} = shift;
}

sub setUserDao {
	my $self = shift;
	$self->{userDao} = shift;
}

1;

