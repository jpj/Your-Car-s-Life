<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");
	require_once("../../library/validation.php");

	session_start();


	$user = bindObject("User");

	$isErrors = "false";
	$errors = array();


	$logRecordId = $_GET[logRecordId];
	$logRecordDate = $_GET[logRecordDate];
	$logRecordOdometer = $_GET[logRecordOdometer];
	$logRecordGallons = $_GET[logRecordGallons];
	$logRecordOctane = $_GET[logRecordOctane];
	$logRecordDipstick = $_GET[logRecordDipstick];

	if(!$logRecordId) {
		$logRecordId = 0;
	}


	// If user is not logged in then create an error.
	// Do not bother validating the other fields if not logged in.
	if ($user->getIsLoggedIn()) {

		if (!validateDate($logRecordDate)) {
			$isErrors = "true";
			//array_push($errors, "logRecordDate" => "Invalid date. Format must be YYYY-MM-DD HH:mm");
			$errors[logRecordDate] = "Invalid date. Format must be YYYY-MM-DD HH:mm";
		}

		if ($logRecordOdometer == "" || $logRecordOdometer < 0 || $logRecordOdometer > 10000000) {
			$isErrors = "true";
			$errors[logRecordOdometer] = "Your odometer reading was outside the range 0 - 10,000,000 miles.";
		}

		if ($logRecordGallons == "" || $logRecordGallons < 0 || $logRecordGallons > 10000) {
			$isErrors = "true";
			$errors[logRecordGallons] = "Gallons outside acceptable range; 0 - 10,000.";
		}
		
		if ($logRecordOctane < 87 || $logRecordOctane > 94) {
			$isErrors = "true";
			$errors[logRecordOctane] = "The only supported octanes are 87 - 94.";
		}

		//if (!is_numeric($logRecordDipstick) && ($logRecordDipstick < 0.00 || $logRecordDipstick > 1.00)) {
		if (is_numeric($logRecordDipstick)) {
			if ($logRecordDipstick < 0.00 || $logRecordDipstick > 1.00) {
				$isErrors = "true";
				$errors[logRecordDipstick] = "Dipstick reading must be between 0.00 and 1.00 ($logRecordDipstick)";
			}
		} else {
			$isErrors = "true";
			$errors[logRecordDipstick] = "Dipstick reading must be a numeric value. You entered \"$logRecordDipstick\"";
		}
	

	} else {
		$isErrors = "true";
		$errors[user] = "You are not logged in.";
	}


	$logRec = new LogRecord();

	if ($isErrors != "true") {
		
		// Everything is OK. Do the INSERT:

		$logRec->setId($logRecordId);
		$logRec->setAutoId($user->getCurrentAutoId());
		$logRec->setUserId($user->getUserId());
		$logRec->setLogDate($logRecordDate);
		$logRec->setOdometer($logRecordOdometer);
		$logRec->setGallons($logRecordGallons);
		$logRec->setOctane($logRecordOctane);
		$logRec->setDipstick($logRecordDipstick);

		$logRec->writeRecord();
	}

	header("content-type: text/xml");

?>


<SaveLogRecord>
	<logId><?=$logRec->getId()?></logId>
	<previousRecordId><?=$logRec->getPreviousRecord()?></previousRecordId>
	<nextRecordId><?=$logRec->getNextRecord()?></nextRecordId>
<?php	foreach($errors as $key => $value) { ?>
	<error id="<?=$key?>"><?=$value?></error>
<?php	} ?>
</SaveLogRecord>



