package _pview::view::error::accessDenied_xml;

use strict;

sub new {
	my $class = shift;
	my $self = {
		attributes => {}
	};
	bless $self, $class;
	return $self;
}

sub setAttribute {
	my $self = shift;
	my $name = shift;
	my $value = shift;

	$self->{attributes}->{$name} = $value;
}

sub getAttribute {
	my $self = shift;
	my $name = shift;
	return $self->{attributes}->{$name};
}

sub printView {
	my $self = shift;
	my $request = shift;
	my $modiBuffer = "";
	
$modiBuffer .= qq(<error>
	<userLoggedIn>false</userLoggedIn>
</error>
);

	return $modiBuffer;
}

1;
