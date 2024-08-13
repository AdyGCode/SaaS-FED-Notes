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

$sql = "DELETE FROM demo  "
    . "where id = :id";

$statement = $pdo->prepare($sql);

$id = 7;

$statement->bindValue(":id", $id, PDO::PARAM_INT);

$statement->execute();
