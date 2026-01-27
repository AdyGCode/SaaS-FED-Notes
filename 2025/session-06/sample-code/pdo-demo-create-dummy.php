<?php
/**
 * Demonstrate Creating a Record with PDO
 *
 * Filename:        pdo-demo-create.php
 * Location:        /session-04
 * Project:         SaaS-FED-Notes
 * Date Created:    7/08/2024
 *
 * Author:          Adrian Gould
 *
 */

$pdo = require "Connection.php";

$sql = "INSERT INTO demo(name, colour, owned) "
    . "VALUES( :name, :colour, :owned)";

$statement = $pdo->prepare($sql);

$name = 'dummy';
$colour = 'dummy';
$owned = false;

$statement->bindValue(":name", $name, PDO::PARAM_STR);
$statement->bindValue(":colour", $colour);
$statement->bindValue(":owned", $owned, PDO::PARAM_BOOL);

$statement->execute();
