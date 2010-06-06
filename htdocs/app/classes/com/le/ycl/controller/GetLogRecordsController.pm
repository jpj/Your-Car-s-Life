package com::le::ycl::controller::GetLogRecordsController;

use strict;
use com::le::ycl::controller::LoginVerificationXmlController;
use com::le::ycl::object::LogRecord;
use com::le::ycl::object::LogRecordInputData;
use com::le::ycl::object::Vehicle;
use com::le::ycl::util::YCLConstants;
use XML::LibXML;

use base qw(com::le::ycl::controller::LoginVerificationXmlController);

sub new {
	my $class = shift;
	my $self = {
		logRecordDao => undef
	};
	return bless $self, $class;
}

sub createAndReturnXml {
	my $self = shift;
	my $request = shift;

	my $doc = XML::LibXML->createDocument();

	$doc->setDocumentElement( $doc->createElement("logRecords") );

	#my $inputData = new com::le::ycl::object::LogRecordInputData();
	my $inputData = com::le::ycl::object::LogRecordInputData->new();
	$inputData->setUser( $request->getSession()->getAttribute("user") );
	# TODO Check vehicleId param, make sure it belongs to user.
	# maybe handle this by subquery (no results if not etc )
	my $vehicle = new com::le::ycl::object::Vehicle();
	$vehicle->setVehicleId( $request->getParameter("vehicleId") );

	$inputData->setVehicle( $vehicle );

	if ( defined($request->getParameter("logRecordId")) && $request->getParameter("logRecordId") ne "" ) {
		$inputData->setLogRecord( new com::le::ycl::object::LogRecord() );
		$inputData->getLogRecord()->setLogRecordId( $request->getParameter("logRecordId") );
	}

	my $logRecordCount = $self->{logRecordDao}->getLogRecordCount($inputData);

	# TODO
	# Modify this for paging. The last result may return less than LOG_ROWS
	# and offset could be < 0.
	$inputData->setMaxResults( com::le::ycl::util::YCLConstants::LOG_ROWS );
	$inputData->setOffset( $logRecordCount - $inputData->getMaxResults() );

	my $logRecordList = $self->{logRecordDao}->getLogRecordsForInputData($inputData);

	foreach my $logRecord (@{$logRecordList}) {
		my $lr = $doc->createElement("logRecord");

		my $id = $doc->createElement("logRecordId");
		$id->appendText( $logRecord->getLogRecordId() );
		$lr->addChild($id);

		my $vehicleId = $doc->createElement("vehicleId");
		$vehicleId->appendText( $logRecord->getVehicleId() );
		$lr->appendChild($vehicleId);

		my $date = $doc->createElement("date");
		$date->appendText( $logRecord->getDate() );
		$lr->appendChild($date);

		my $jsDate = $doc->createElement("jsDate");
		$jsDate->appendText( $logRecord->getJsDate() );
		$lr->appendChild($jsDate);

		my $gallons = $doc->createElement("gallons");
		$gallons->appendText( $logRecord->getGallons() );
		$lr->appendChild($gallons);

		my $odometer = $doc->createElement("odometer");
		$odometer->appendText( $logRecord->getOdometer() );
		$lr->appendChild($odometer);

		my $octane = $doc->createElement("octane");
		$octane->appendText( $logRecord->getOctane() );
		$lr->appendChild($octane);

		$doc->getDocumentElement()->addChild($lr);
	}

	my $logRecordCountEl = $doc->createElement("logRecordCount");
	$logRecordCountEl->appendText( $logRecordCount );
	$doc->getDocumentElement()->addChild($logRecordCountEl);

	return $doc;
}

sub setLogRecordDao {
	my $self = shift;
	$self->{logRecordDao} = shift;
}

1;

