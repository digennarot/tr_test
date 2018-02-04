<?php

session_start();
#$count = isset($_SESSION['count']) ? $_SESSION['count'] : 1;
#$_SESSION['count'] = ++$count;
#echo nl2br('You have been here ' . $_SESSION['count'] . ' times.');

function getnow() {
	$dt = date('Y-m-d');
	return $dt;
}

function getip() {
    $ipaddress = '';
    if ($_SERVER['HTTP_CLIENT_IP'])
        $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
    else if($_SERVER['HTTP_X_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
    else if($_SERVER['HTTP_X_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
    else if($_SERVER['HTTP_FORWARDED_FOR'])
        $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
    else if($_SERVER['HTTP_FORWARDED'])
        $ipaddress = $_SERVER['HTTP_FORWARDED'];
    else if($_SERVER['REMOTE_ADDR'])
        $ipaddress = $_SERVER['REMOTE_ADDR'];
    else
        $ipaddress = 'UNKNOWN';
    return $ipaddress;
}

$now = getnow();
$ip = getip();

$json = array(
      'date' => $now,
      'ip' => $ip
);

$string = json_encode($json);
echo $string;


?>
