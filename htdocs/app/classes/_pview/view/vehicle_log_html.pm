package _pview::view::vehicle_log_html;

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
 use com::le::ycl::util::YCLConstants; 
$modiBuffer .= qq(

);
my $include_docHeader = new _pview::view::include::docHeader_html();
$modiBuffer .= $include_docHeader->printView($request);
$modiBuffer .= qq(
		<script type="text/javascript" src="/static/js/controller/VehicleLogController.js"></script>
);
my $include_pageHeader = new _pview::view::include::pageHeader_html();
$modiBuffer .= $include_pageHeader->printView($request);
$modiBuffer .= qq(

<div>Vehicle Log</div>

<div id="vehicleLogRecords">
);
 for (my $i = 0; $i < com::le::ycl::util::YCLConstants::LOG_ROWS; $i++) { 
$modiBuffer .= qq(
	<div class="record">Row );
 print $i; 
$modiBuffer .= qq(</div>
);
 } 
$modiBuffer .= qq(
</div>

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
