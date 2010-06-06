package _pview::ycltest::view::vehicle_log_html;

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
		<link rel="stylesheet" type="text/css" href="/static/css/vehicle-log.css" />

		<script type="text/javascript" src="/static/js/object/LogRecord.js"></script>
		<script type="text/javascript" src="/static/js/object/Vehicle.js"></script>
		<script type="text/javascript" src="/static/js/object/LogRecordFilterInputData.js"></script>
		<script type="text/javascript" src="/static/js/object/VehicleFilterInputData.js"></script>
		<script type="text/javascript" src="/static/js/formdata/LogRecordFormData.js"></script>
		<script type="text/javascript" src="/static/js/view/LogRecordListView.js"></script>
		<script type="text/javascript" src="/static/js/view/LogRecordFormView.js"></script>
		<script type="text/javascript" src="/static/js/view/VehicleSelectListView.js"></script>
		<script type="text/javascript" src="/static/js/dao/LogRecordDao.js"></script>
		<script type="text/javascript" src="/static/js/dao/VehicleDao.js"></script>
		<script type="text/javascript" src="/static/js/controller/VehicleLogController.js"></script>
);
my $include_pageHeader = new _pview::ycltest::view::include::pageHeader_html();
$modiBuffer .= $include_pageHeader->printView($request, $modi_mav, $modi_formdata);
$modiBuffer .= qq(

<h2>Vehicle Log</h2>

<div><a href="add" id="addNewRecord">Add New Record</a></div>
<div>
	<select id="vehicleId" name="vehicleId">
	</select>
</div>

<div id="logRecordForm">
	<div class="close"><a href="close0">close</a></div>
	<form class="form" action="#" method="post">
		<div class="message success"></div>

		<div>
			<input type="hidden" name="logRecordId" class="input" />
			<input type="hidden" name="vehicleId" class="input" />
		</div>

		<div class="container">
			<label>Date <input type="text" name="date" class="input" /></label>
		</div>
		<div class="container">
			<label>Odometer <input type="text" name="odometer" class="input" /></label>
		</div>
		<div class="container">
			<label>Gallons <input type="text" name="gallons" class="input" /></label>
		</div>
		<div class="container">
			<label>Octane <input type="text" name="octane" class="input" /></label>
		</div>
		<div class="container">
			&nbsp; <input type="submit" />
		</div>
		<div class="message error"><ul></ul></div>
	</form>
</div>

<p id="logRecordStats">
	Average MPG of <span class="mpg" data-totalmpg="0.00">0</span> for <span class="total">0</span> records.
</p>

<div id="vehicleLogRecord" class="pageSection">
	<div >
		);
 for (my $i = 0; $i < com::le::ycl::util::YCLConstants::LOG_ROWS; $i++) { 
$modiBuffer .= qq(
		<div class="record item" data-state="available">
			<div class="entry id" data-id="logRecordId"></div>
			<div class="entry date" data-id="date"></div>
			<div class="entry odometerlabel label">Odometer:</div>
			<div class="entry odometer" data-id="odometer"></div>
			<div class="entry fuellabel label notcrucial">Fuel:</div>
			<div class="entry gallons notcrucial" data-id="gallons"></div>
			<div class="entry octanelabel label notcrucial">Octane:</div>
			<div class="entry octane notcrucial" data-id="octane"></div>
			<div class="entry distancelabel label notcrucial">Distance:</div>
			<div class="entry miles notcrucial" data-id="miles"></div>
			<div class="entry economylabel label">Economy:</div>
			<div class="entry mpg" data-id="mpg"></div>
		</div>
		);
 } 
$modiBuffer .= qq(
	</div>
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
