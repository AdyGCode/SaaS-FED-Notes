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

$sql = "SELECT name, colour, owned FROM demo "
    . "WHERE id = 3";

$statement = $pdo->prepare($sql);

$statement->execute();


$records = $statement->fetchAll();

var_dump($records);

$record = $statement->fetch();

var_dump($record);
