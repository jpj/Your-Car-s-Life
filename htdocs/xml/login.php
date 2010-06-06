<?php
require_once '../include/init.php';
require_once("controller/LoginController.php");

$controller = new LoginController();
$controller->handleRequest();
?>