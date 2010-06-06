<?php

	require_once("../../classes/User.php");
	require_once("../../classes/LogRecord.php");
	require_once("../../library/common.php");

	session_start();


	$user = bindSessionObject("User");



	header("content-type: text/xml");



?>


<vehicleYears>


<?php


	$conn = getDatabaseConnection();
	
	$query = sprintf("SELECT DISTINCT(YEAR) AS YEAR FROM VEHICLES ORDER BY YEAR DESC", $conn);
	$resultSet = mysql_query( $query, $conn );

	while ($row = mysql_fetch_array($resultSet, MYSQL_ASSOC)) {



?>
	<year><?=$row[YEAR]?></year>
<?php


	}


	mysql_close($conn);



?>


</vehicleYears>

