<?php
/**
 * Functions
 */

//include 'functions.php'; // include the file, but warn if missing
//include_once 'functions.php'; // only include the file once, warn if missing
require 'functions.php'; // MUST include the file, error out if missing
require_once 'functions.php'; // MUST include the file once, error out if missing

echo greeting("Evelyn");
echo greeting("");
echo greeting(true);


$name = "Fred 😊";
e($name);
e(strtolower($name));
e(mb_strtolower($name));
e(mb_strtoupper($name));
e(strlen($name));
e(mb_strlen($name));



echo counter();
echo counter();
echo counter();
echo counter();
