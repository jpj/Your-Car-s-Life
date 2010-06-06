package _pview::ycltest::view::manage_vehicles_html;

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
 use com::le::ycl::util::YCLConstants; 
$modiBuffer .= qq(
);
my $include_docHeader = new _pview::ycltest::view::include::docHeader_html();
$modiBuffer .= $include_docHeader->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
		<link rel="stylesheet" type="text/css" href="/static/css/vehicle.css" />

		<script type="text/javascript" src="/static/js/view/VehicleListView.js"></script>
		<script type="text/javascript" src="/static/js/object/Vehicle.js"></script>
		<script type="text/javascript" src="/static/js/object/VehicleFilterInputData.js"></script>
		<script type="text/javascript" src="/static/js/dao/VehicleDao.js"></script>
		<script type="text/javascript" src="/static/js/controller/VehicleController.js"></script>
);
my $include_pageHeader = new _pview::ycltest::view::include::pageHeader_html();
$modiBuffer .= $include_pageHeader->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(

<h2>Manage Vehicles</h2>

<div><a href="add" id="addVehicle">Add Vehicle</a></div>

<div id="vehicleForm">
	<div class="close"><a href="close0">close</a></div>
	<form class="form" action="#" method="post">
		<div class="message success"></div>
		<div>
			Vehicle Id <input type="text" name="vehicleId" class="input" />
		</div>
		<div>
			Name <input type="text" name="name" class="input" />
		</div>
		<div>
			Notes <input type="text" name="notes" class="input" />
		</div>
		<div>
			<input type="submit" />
		</div>
		<div class="message error"><ul></ul></div>
	</form>
</div>

<div id="vehicleRecords">
	<h3>Your Vehicles</h3>
);
 for (my $i = 0; $i < com::le::ycl::util::YCLConstants::VEHICLE_ROWS; $i++) { 
$modiBuffer .= qq(
	<div class="record item available" data-state="available" data-vehicleid="">&nbsp;
		<div class="entry name" data-id="name"></div>
		<div class="entry notes" data-id="notes"></div>
	</div>
);
 } 
$modiBuffer .= qq(
</div>

);
my $include_pageFooter = new _pview::ycltest::view::include::pageFooter_html();
$modiBuffer .= $include_pageFooter->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
);
my $include_docFooter = new _pview::ycltest::view::include::docFooter_html();
$modiBuffer .= $include_docFooter->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(
);

	return $modiBuffer;
}

1;
