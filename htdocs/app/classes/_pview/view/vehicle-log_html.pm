package _pview::view::vehicle-log_html;

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
	
print qq();
my $include_docHeader = new _pview::view::include::docHeader_html();
$include_docHeader->printView($request);
print qq(
);
my $include_pageHeader = new _pview::view::include::pageHeader_html();
$include_pageHeader->printView($request);
print qq(

<div>Vehicle Log</div>

);
my $include_pageFooter = new _pview::view::include::pageFooter_html();
$include_pageFooter->printView($request);
print qq(
);
my $include_docFooter = new _pview::view::include::docFooter_html();
$include_docFooter->printView($request);
print qq(
);
;
}

1;
