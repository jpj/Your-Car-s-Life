package com::le::ycl::controller::GetVehiclesController;

use strict;
use com::le::common::exception::DaoException qw(:try);
use com::le::ycl::object::User;
use com::le::ycl::object::Vehicle;
use com::le::ycl::object::VehicleFilterInputData;
use Modi::framework::mvc::FormController;
use Modi::framework::mvc::ModelAndView;

use base qw(Modi::framework::mvc::FormController);

sub new {
	my $class = shift;
	my $self = $class->SUPER::new();
	$self->{vehicleDao} = undef;
}

sub isFormSubmission {
	return 1;
}

sub onSubmit {
	my $self = shift;
	my $request = shift;
	my $formData = shift;

	$request->setContentType("text/xml");
	my $log = $request->getApacheRequest()->log();
	my $mav = new Modi::framework::mvc::ModelAndView( $self->{successViewName} );

	my $inputData = new com::le::ycl::object::VehicleFilterInputData();

	my $user = new com::le::ycl::object::User();
	$user->setUserId( $request->getSession()->getAttribute("user")->getUserId() );
	$inputData->setUser( $user );

	my $vehicles = undef;
	try {
		$vehicles = $self->{vehicleDao}->getVehicles( $inputData );
	} catch com::le::common::exception::DaoException with {
		my $e = shift;
		die $e;
	};

	$mav->addObject("vehicleList", $vehicles);

	return $mav;
}

sub setVehicleDao {
	my $self = shift;
	$self->{vehicleDao} = shift;
}

1;

