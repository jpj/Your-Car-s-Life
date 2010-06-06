package com::le::ycl::controller::SaveLogRecordController;

use strict;
use com::le::ycl::object::LogRecord;
use com::le::ycl::util::YCLConstants;
use com::le::common::exception::DaoException qw(:try);
use Modi::framework::mvc::FormController;
use Modi::framework::mvc::ModelAndView;
use XML::LibXML;

use base qw(Modi::framework::mvc::FormController);

sub new {
	my $class = shift;
	my $self = $class->SUPER::new();
	$self->{logRecordDao} = undef;
	$self->{vehicleDao} = undef;
	#return bless $self, $class;
}

sub isFormSubmission {
	return 1;
}

sub onSubmit {
	my $self = shift;
	my $request = shift;
	my $formData = shift;

	my $mav = new Modi::framework::mvc::ModelAndView();
	my $log = $request->getApacheRequest()->log();
	my $errors = [];

	$request->setContentType("text/xml");

	my $logRecord = new com::le::ycl::object::LogRecord();
	$logRecord->setLogRecordId( $formData->getLogRecordId() );
	$logRecord->setVehicleId( $formData->getVehicleId() );
	$logRecord->setDate( $formData->getDate() );
	$logRecord->setOdometer( $formData->getOdometer() );
	$logRecord->setGallons( $formData->getGallons() );
	$logRecord->setOctane( $formData->getOctane() );

	if ( !defined($formData->getLogRecordId()) || $formData->getLogRecordId() == 0 ) {

		# Make sure this user owns the vehicle.
		my $vehicle = undef;
		try {
			$vehicle = $self->{vehicleDao}->getVehicleById( $formData->getVehicleId() );
		} catch com::le::common::exception::DaoException with {
			my $e = shift;
			push(@{$errors}, "An error occured verifying vehicle ownership.");
			$log->debug("Error occured getting vehicle with id " . $formData->getVehicleId() . ": " . $e);
		};

		if ( !defined($vehicle) || $vehicle->getUser()->getUserId() != $request->getSession()->getAttribute("user")->getUserId() ) {
			push(@{$errors}, "You cannot add this record as you do not own the vehicle.");
		} else {

			# Add Log Record
			$logRecord->setActive(1);
			try {
				$self->{logRecordDao}->addLogRecord( $logRecord );
				$mav->addObject("message", "Log Record added successfully");
			} catch com::le::common::exception::DaoException with {
				my $e = shift;
				push(@{$errors}, "An error occured adding this record. Please try again in a few moments.");
				$log->debug("Error occured while inserting record: " . $e);
			};
		}
	} else {

		# Update Log Record
		my $logRecordOnFile = undef;
		try {
			$logRecordOnFile = $self->{logRecordDao}->getLogRecordById($logRecord->getLogRecordId());
		} catch com::le::common::exception::DaoException with {
			my $e = shift;
			push(@{$errors}, "An error occured getting log record #".$logRecord->getLogRecordId().". Please try your request again in a few minutes.");
			$log->debug("Error occured getting initial log record: " . $e);
		};

		if ($logRecordOnFile != undef) {
			$logRecord->setActive( $logRecordOnFile->getActive() );
			$logRecord->setVehicleId( $logRecordOnFile->getVehicleId() );

			try {
				$self->{logRecordDao}->updateLogRecord( $logRecord );
				$mav->addObject("message", "Log Record updated successfully");
			} catch com::le::common::exception::DaoException with {
				my $e = shift;
				push(@{$errors}, "An error occured updating this record. Please try your request again in a few minutes.");
				$log->debug("Error occured: " . $e);
			};
		}
	}

	$mav->setViewName( $self->getSuccessViewName() );
	$mav->addObject("errors", $errors);
	return $mav;
}

sub setLogRecordDao {
	my $self = shift;
	$self->{logRecordDao} = shift;
}

sub setVehicleDao {
	my $self = shift;
	$self->{vehicleDao} = shift;
}

1;

