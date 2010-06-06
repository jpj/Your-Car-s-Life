<?php
require_once '../include/init.php';
require_once 'controller/GetLogRecordListController.php';
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

$controller = new GetLogRecordListController();
$controller->handleRequest();
?>