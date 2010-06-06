package com::le::ycl::controller::IndexController;

use strict;
use Modi::framework::mvc::Controller;
use Modi::framework::mvc::ModelAndView;

use base qw(Modi::framework::mvc::Controller);

sub handleRequest {
	my $self = shift;
	my $request = shift;

	# Logout
	if ( $request->getParameter("logout") && $request->getParameter("logout") eq "true" ) {
		$request->getSession()->setAttribute("user", undef);
	}

	return new Modi::framework::mvc::ModelAndView($self->getViewName());
}

1;

