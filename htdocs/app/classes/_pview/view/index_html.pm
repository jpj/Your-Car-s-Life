package _pview::view::index_html;

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
	
$modiBuffer .= qq();
my $include_docHeader = new _pview::view::include::docHeader_html();
$modiBuffer .= $include_docHeader->printView($request);
$modiBuffer .= qq(
);
my $include_pageHeader = new _pview::view::include::pageHeader_html();
$modiBuffer .= $include_pageHeader->printView($request);
$modiBuffer .= qq(

<div>INDEX!</div>

);
my $include_pageFooter = new _pview::view::include::pageFooter_html();
$modiBuffer .= $include_pageFooter->printView($request);
$modiBuffer .= qq(
);
my $include_docFooter = new _pview::view::include::docFooter_html();
$modiBuffer .= $include_docFooter->printView($request);
$modiBuffer .= qq(
);

	return $modiBuffer;
}

1;
