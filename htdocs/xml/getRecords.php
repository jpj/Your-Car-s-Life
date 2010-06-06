<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");

	session_start();


	$user = bindObject("User");



	$logRecordId = $_GET[logRecordId];
	$previousLogRecordId = $_GET[previousLogRecordId];



	header("content-type: text/xml");



?>


<logRecords>


<?php

	// Maximum number of rows to display on this page.
	$maxRows = 25;





	$conn = mysql_connect("localhost", "autologger", "vessEpIdd") or die ("Error connecting to Mysql");
	mysql_select_db("AUTOLOGGER");
	
	$query = sprintf("SELECT COUNT(*) AS COUNT FROM LOG WHERE USER_ID='%s' AND AUTO_ID='%s' AND ACTIVE=1",
			mysql_real_escape_string($user->getUserId(), $conn),
			mysql_real_escape_string($user->getCurrentAutoId(), $conn)
	);
	$resultSet = mysql_query( $query );
	$totalRows = 0;
	if ($row = mysql_fetch_array($resultSet, MYSQL_ASSOC)) {
		$totalRows = $row["COUNT"];
	}

	$query = "";

	if ($logRecordId) {
		$query = sprintf("SELECT DATE_FORMAT(LOG_DATE, '%%Y-%%m-%%d %%H:%%i') AS LOG_DATE_FORMAT, L.* FROM LOG L WHERE L.USER_ID='%s' AND L.AUTO_ID='%s' AND ACTIVE=1 AND LOG_ID IN ('%s', '%s')",
			mysql_real_escape_string($user->getUserId(), $conn),
			mysql_real_escape_string($user->getCurrentAutoId(), $conn),
			mysql_real_escape_string($previousLogRecordId, $conn),
			mysql_real_escape_string($logRecordId, $conn)
		);
	} else {
		$query = sprintf("SELECT DATE_FORMAT(LOG_DATE, '%%Y-%%m-%%d %%H:%%i') AS LOG_DATE_FORMAT, L.* FROM LOG L WHERE L.USER_ID='%s' AND L.AUTO_ID='%s' AND ACTIVE=1 ORDER BY L.ODOMETER LIMIT $maxRows OFFSET %s",
			mysql_real_escape_string($user->getUserId(), $conn),
			mysql_real_escape_string($user->getCurrentAutoId(), $conn),
			mysql_real_escape_string($totalRows - $maxRows, $conn)
		);
	}
	/*
	$query = sprintf("SELECT DATE_FORMAT(LOG_DATE, '%%Y-%%m-%%d %%H:%%i') AS LOG_DATE_FORMAT, L.* FROM LOG L WHERE L.USER_ID='%s' AND L.AUTO_ID='%s' AND ACTIVE=1 ORDER BY L.ODOMETER LIMIT $maxRows OFFSET %s",
		mysql_real_escape_string($user->getUserId(), $conn),
		mysql_real_escape_string($user->getCurrentAutoId(), $conn),
		mysql_real_escape_string($totalRows - $maxRows, $conn)
	);
	*/


	$resultSet = mysql_query( $query );





	//error_log($query);
	while ($row = mysql_fetch_array($resultSet, MYSQL_ASSOC)) {

		$logRec = new LogRecord();

		$logRec->setId( $row["LOG_ID"] );
		$logRec->setAutoId( $row["AUTO_ID"] );
		$logRec->setLogDate( $row["LOG_DATE_FORMAT"] );
		$logRec->setOdometer( $row["ODOMETER"] );
		$logRec->setGallons( $row["GALLONS"] );
		$logRec->setOctane( $row["OCTANE"] );
		$logRec->setDipstick( $row["DIPSTICK"] );


		

?>

	<record>
		<id><?=$logRec->getId()?></id>
		<date><?=$logRec->getLogDate()?></date>
		<odometer><?=$logRec->getOdometer()?></odometer>
		<gallons><?=number_format($logRec->getGallons(), 3)?></gallons>
		<octane><?=$logRec->getOctane()?></octane>
		<mpg><?=number_format($logRec->getMpg(), 2)?></mpg>
	</record>

<?php





	}


	mysql_close($conn);



?>


</logRecords>
