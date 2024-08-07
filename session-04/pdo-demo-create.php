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

require_once "pdoConnect.php";

$sql = "INSERT INTO demo(name, colour, owned) "
    . "VALUES( :name, :colour, :owned)";

$statement = $pdo->prepare($sql);

$name = 'orville';
$colour = 'green';
$owned = 0; // used in place of FALSE (1 = TRUE)

$statement->execute([
    "name" => $name,
    "colour" => $colour,
    "owned" => $owned,
]);
