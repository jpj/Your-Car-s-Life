<?php
require_once 'include/init.php';
$isUserLoggedIn = false;

header("content-type: text/xml");

if ( $ycl_user != null && $ycl_user->getIsLoggedIn() ) {
	$isUserLoggedIn = true;
}
?>
<loginCheck>
	<userLoggedIn><?=$isUserLoggedIn ? "true" : "false"?></userLoggedIn>
</loginCheck>
