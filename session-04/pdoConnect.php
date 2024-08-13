<?php
/**
 * Basics of PDO
 *
 *
 * Filename:        pdoConnect.php
 * Location:        /session-04
 * Date Created:    2024-08-07
 *
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>
 *
 */

require_once 'config-04.php';

$dsn = "mysql:host=$dbHost;dbname=$dbName;charset=UTF8";

try {
    $pdo = new PDO($dsn, $dbUser, $dbPass);

    if ($pdo) {
        echo "Connected to the $dbName database successfully!";
    }
} catch (PDOException $e) {
    echo $e->getMessage();
}