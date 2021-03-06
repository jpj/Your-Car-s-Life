package _pview::test_yourcarslife_com::view::index_html;

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
	my $modi_mav = shift;
	my $modi_formdata = shift;
	my $modi_formerrors = shift;
	my $modiBuffer = "";
	
$modiBuffer .= qq();
my $include_docHeader = new _pview::test_yourcarslife_com::view::include::docHeader_html();
$modiBuffer .= $include_docHeader->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
);
my $include_pageHeader = new _pview::test_yourcarslife_com::view::include::pageHeader_html();
$modiBuffer .= $include_pageHeader->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(

<div>INDEX!</div>

<p>
	Your Car's Life is a site to keep track of stats/data on your vehicle. From gas mileage to total cost of owner ship to reminders on when to change your oil.
</p>

);
my $include_pageFooter = new _pview::test_yourcarslife_com::view::include::pageFooter_html();
$modiBuffer .= $include_pageFooter->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
);
my $include_docFooter = new _pview::test_yourcarslife_com::view::include::docFooter_html();
$modiBuffer .= $include_docFooter->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
);

	return $modiBuffer;
}

1;
