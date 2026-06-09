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

$pdo = require 'Connection.php';

$list = [1,3,4];

$placeholder = "";
for ($count = 0; $count < count($list); $count++) {
    $placeholders [$count]= ":id". str_pad($count, 2, '0', STR_PAD_LEFT);
}

$placeholder = implode(", ",$placeholders);

$sql = "SELECT name, colour, owned FROM demo "
    . "WHERE id in ( {$placeholder} )";

$statement = $pdo->prepare($sql);

foreach ($placeholders as $key=>$placeholder) {
    $statement->bindValue($placeholder, $list[$key]);
}

$statement->execute();

$records = $statement->fetchAll(PDO::FETCH_ASSOC);
