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

$name = 'Count Duckula';
$colour = 'black';
$owned = 1; // 0 used in place of FALSE (1 = TRUE)

$statement->bindValue(":name", $name, PDO::PARAM_STR);
$statement->bindValue(":colour", $colour);
$statement->bindValue(":owned", $owned, PDO::PARAM_BOOL);

$statement->execute();
