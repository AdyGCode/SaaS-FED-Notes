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

$ducks = [
    ['name'=>'Donald','colour'=>'white','owned'=>false,],
    ['name'=>'Daffy','colour'=>'black','owned'=>true,],
    ['name'=>'April','colour'=>'white','owned'=>false,],
    ['name'=>'Quackup','colour'=>'blue','owned'=>true,],
];

$sql = "INSERT INTO demo(name, colour, owned) "
    . "VALUES( :name, :colour, :owned)";

foreach ($ducks as $duck){
    $statement = $pdo->prepare($sql);

    $statement->bindValue(":name", $duck['name'], PDO::PARAM_STR);
    $statement->bindValue(":colour", $duck['colour']);
    $statement->bindValue(":owned", $duck['owned'], PDO::PARAM_BOOL);

    $statement->execute();
}
