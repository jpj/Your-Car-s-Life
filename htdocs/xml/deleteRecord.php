<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");
	require_once("../../library/validation.php");

	session_start();


	$user = bindObject("User");

	$status = "success";
	$errors = array();


	$logRecordId = $_GET[logRecordId];
	//error_log("\$logRecordId is $logRecordId ");



	// If user is not logged in then create an error.
	// Do not bother validating the other fields if not logged in.
	if ($user->getIsLoggedIn()) {

		if (!$logRecordId) {
			$status = "fail";
			$errors[logRecordId] = "No logRecordId specefied.";
		}

	} else {
		$status = "fail";
		$errors[user] = "You are not logged in.";
	}


	$logRec = new LogRecord();

	if ($status == "success") {
		
		// Everything is OK. Do the DELETE:

		$logRec->setId($logRecordId);

		if (!$logRec->deleteRecord()) {
			$status = "fail";
			$errors[deleteRecordFailed] = "Failed to delete record.";
		}
	}

	header("content-type: text/xml");

?>


<DeleteLogRecord>
	<logId><?=$logRec->getId()?></logId>
	<status><?=$status?></status>
<?php	foreach($errors as $key => $value) { ?>
	<error id="<?=$key?>"><?=$value?></error>
<?php	} ?>
</DeleteLogRecord>




