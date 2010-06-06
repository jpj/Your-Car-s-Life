package com::le::ycl::dao::impl::LogRecordDaoDbi;

use strict;
use com::le::ycl::object::LogRecord;
use com::le::common::exception::DaoException;
use com::le::common::exception::DbConnectionException;
use com::le::common::exception::SQLException;
use Error qw(:try);

my $SELECT = "SELECT L.LOG_ID, L.VEHICLE_ID, L.RECORD_CREATED, L.RECORD_MODIFIED, L.LOG_DATE, DATE_FORMAT(L.LOG_DATE, '%M %d, %Y %H:%i:%s') AS JS_LOG_DATE, L.ODOMETER, L.GALLONS, L.OCTANE, L.DIPSTICK, L.ACTIVE ";

sub new {
	my $class = shift;
	my $self = {
		dbConnector => undef
	};
	return bless $self, $class;
}

sub getLogRecordById {
	my $self = shift;
	my $logRecordId = shift;

	my $logRecord = undef;
	my $conn = undef;
	my $sth = undef;

	my $query = $SELECT . " FROM LOG L, USER_VEHICLE V, USER U WHERE L.VEHICLE_ID=V.VEHICLE_ID AND V.USER_ID=U.USER_ID AND L.LOG_ID=?";

	try {
		$conn = $self->{dbConnector}->getConnection();
		$sth = $conn->prepare($query);
		$sth->execute($logRecordId);
	
		if (my $rs = $sth->fetchrow_hashref()) {
			$logRecord = new com::le::ycl::object::LogRecord();
			$logRecord->setLogRecordId( $rs->{LOG_ID} );
			$logRecord->setVehicleId( $rs->{VEHICLE_ID} );
			$logRecord->setRecordCreated( $rs->{RECORD_CREATED} );
			$logRecord->setRecordModified( $rs->{RECORD_MODIFIED} );
			$logRecord->setDate( $rs->{LOG_DATE} );
			$logRecord->setJsDate( $rs->{JS_LOG_DATE} );
			$logRecord->setOdometer( $rs->{ODOMETER} );
			$logRecord->setGallons( $rs->{GALLONS} );
			$logRecord->setOctane( $rs->{OCTANE} );
			$logRecord->setDipstick( $rs->{DIPSTICK} );
			$logRecord->setActive( $rs->{ACTIVE} );
		}

	} catch Error with {
		my $e = shift;
		throw com::le::common::exception::DaoException($e);
	} finally {
		$sth->finish();
		$conn->disconnect();
	};

	return $logRecord;
}

sub getLogRecordsForInputData {
	my $self = shift;
	my $inputData = shift;

	my $logRecordList = [];

	my $conn = $self->{dbConnector}->getConnection();
	my $query = $SELECT . " FROM LOG L, USER_VEHICLE V, USER U WHERE L.VEHICLE_ID=V.VEHICLE_ID AND V.USER_ID=U.USER_ID";
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
			push(@params, $inputData->getVehicle()->getVehicleId());
		}
	}

	if ( defined($inputData->getLogRecord()) ) {
		if ( defined($inputData->getLogRecord()->getLogRecordId()) ) {
			$query .= " AND L.LOG_ID=?";
			push(@params, $inputData->getLogRecord()->getLogRecordId());
		}
	}
 
 	$query .= " ORDER BY L.ODOMETER";

	if ( defined($inputData->getMaxResults()) ) {
		$query .= " LIMIT ?";
		push(@params, $inputData->getMaxResults());
	}

	if ( defined($inputData->getOffset()) && $inputData->getOffset() > 0 ) {
		$query .= " OFFSET ?";
		push(@params, $inputData->getOffset());
	}

	#die $query;

	my $sth = $conn->prepare($query);
	$sth->execute(@params);

	while (my $rs = $sth->fetchrow_hashref()) {
		my $log = new com::le::ycl::object::LogRecord();
		$log->setLogRecordId( $rs->{LOG_ID} );
		$log->setVehicleId( $rs->{VEHICLE_ID} );
		$log->setRecordCreated( $rs->{RECORD_CREATED} );
		$log->setRecordModified( $rs->{RECORD_MODIFIED} );
		$log->setDate( $rs->{LOG_DATE} );
		$log->setJsDate( $rs->{JS_LOG_DATE} );
		$log->setOdometer( $rs->{ODOMETER} );
		$log->setGallons( $rs->{GALLONS} );
		$log->setOctane( $rs->{OCTANE} );
		$log->setDipstick( $rs->{DIPSTICK} );
		$log->setActive( $rs->{ACTIVE} );
		push(@{$logRecordList}, $log);
	}

	$sth->finish();
	$conn->disconnect();

	return $logRecordList;
}

sub getLogRecordCount {
	my $self = shift;
	my $inputData = shift;

	my $logRecordCount = -1;

	my $conn = $self->{dbConnector}->getConnection();
	my $query = "";
	my @params = ();

	$query .= "SELECT COUNT(*) AS COUNT FROM LOG L, USER_VEHICLE V, USER U WHERE L.VEHICLE_ID=V.VEHICLE_ID AND V.USER_ID=U.USER_ID";

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

1;

