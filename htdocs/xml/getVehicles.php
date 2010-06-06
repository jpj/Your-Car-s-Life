<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");

	session_start();


	$user = bindSessionObject("User");



	header("content-type: text/xml");



?>


<vehicles>


<?php

		/*
		$query = sprintf("SELECT DATE_FORMAT(LOG_DATE, '%%Y-%%m-%%d %%H:%%i') AS LOG_DATE_FORMAT, L.* FROM LOG L WHERE L.USER_ID='%s' AND L.AUTO_ID='%s' AND ACTIVE=1 AND LOG_ID IN ('%s', '%s')",
			mysql_real_escape_string($user->getUserId(), $conn),
			mysql_real_escape_string($user->getCurrentAutoId(), $conn),
			mysql_real_escape_string($previousLogRecordId, $conn),
			mysql_real_escape_string($logRecordId, $conn)
		);
		*/

	$conn = mysql_connect("localhost", "autologger", "vessEpIdd") or die ("Error connecting to Mysql");
	mysql_select_db("AUTOLOGGER");
	
	$query = sprintf("SELECT DISTINCT(YEAR) AS YEAR FROM VEHICLES ORDER BY YEAR DESC", $conn);
	$resultSet = mysql_query( $query );

	while ($row = mysql_fetch_array($resultSet, MYSQL_ASSOC)) {



?>

	<vehicle>
		<id><?=$logRec->getId()?></id>
		<date><?=$logRec->getLogDate()?></date>
		<odometer><?=$logRec->getOdometer()?></odometer>
		<gallons><?=number_format($logRec->getGallons(), 3)?></gallons>
		<octane><?=$logRec->getOctane()?></octane>
		<mpg><?=number_format($logRec->getMpg(), 2)?></mpg>
	</vehicle>

<?php


	}


	mysql_close($conn);



?>


</vehicles>
