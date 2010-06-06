<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");

	session_start();


	$user = bindObject("User");

	$errors = "";
	$errLogin = "";
	$errDate = "";
	$errOdometer = "";
	$errGallons = "";
	$errOctane = "";

	$logRecordId = 0;

	// If user is not logged in then create an error.
	// Do not bother validating the other fields if not logged in.
	if ($user->getIsLoggedIn()) {

		if (!validateDate($_POST["date"])) {
			$errors = "true";
			$errDate = "Invalid date. Format must be YYYY-MM-DD HH:mm";
		}

		if ($_POST["odometer"] == "" || $_POST["odometer"] < 0 || $_POST["odometer"] > 10000000) {
			$errors = "true";
			$errOdometer = "Your odometer reading was outside the range 0 - 10,000,000 miles. I sincerely doubt that is possible.";
		}

		if ($_POST["gallons"] == "" || $_POST["gallons"] < 0 || $_POST["gallons"] > 10000) {
			$errors = "true";
			$errGallons = "Gallons outside acceptable range; 0 - 10,000.";
		}
		
		if ($_POST["octane"] < 87 || $_POST["octane"] > 94) {
			$errors = "true";
			$errOctane = "The only supported octanes are 87 - 94.";
		}

	} else {
		$errors = "true";
		$errLogin = "You are not logged in.";
	}


	if ($errors != "true") {
		
		// Everything is OK. Do the INSERT:
		$logRec = new LogRecord();

		$logRec->setAutoId($user->getCurrentAutoId());
		$logRec->setUserId($user->getUserId());
		$logRec->setLogDate($_POST["date"]);
		$logRec->setOdometer($_POST["odometer"]);
		$logRec->setGallons($_POST["gallons"]);
		$logRec->setOctane($_POST["octane"]);

		$logRecordId = $logRec->writeRecord();
	}

	header("content-type: text/xml");

?>


<AddRecordErrors>
	<errors><?=$errors?></errors>
	<login><?=$errLogin?></login>
	<date><?=$errDate?></date>
	<odometer><?=$errOdometer?></odometer>
	<gallons><?=$errGallons?></gallons>
	<octane><?=$errOctane?></octane>
	<logRecordId><?=$logRecordId?></logRecordId>
</AddRecordErrors>


<?php

	function validateDate($d) {
		$valid = false;


		# Does date at least match expected pattern?
		if (preg_match("/^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2}):([0-9]{2})$/", $d, $parts)) {

			# Is the date real?
			if (checkdate($parts[2], $parts[3], $parts[1])) {

				# Is the hour real?
				if ($parts[4] >= 0 && $parts[4] < 24) {
					
					# Is the minute real?
					if ($parts[5] >= 0 && $parts[5] < 60) {

						# Everything checks out
						$valid = true;

					}

				}

			}

		}

		return $valid;

	}




?>

