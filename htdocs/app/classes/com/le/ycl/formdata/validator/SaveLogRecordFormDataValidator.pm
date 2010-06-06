package com::le::ycl::formdata::validator::SaveLogRecordFormDataValidator;

sub new {
	my $class = shift;
	my $self = {
	};
	return bless $self, $class;
}

sub validate {
	my $self = shift;
	my $formData = shift;
	my $errors = shift;

	if ( !defined($formData->getGallons()) || $formData->getGallons() eq "" ) {
		$errors->addFieldError("gallons", "Gallons must be filled in.");
	}
}

1;

