<?php
/**
 * Demonstrate Reading a Record with PDO
 *
 * Filename:        pdo-demo-read.php
 * Location:        /session-04
 * Project:         SaaS-FED-Notes
 * Date Created:    7/08/2024
 *
 * Author:          Adrian Gould
 *
 */

require_once "pdoConnect.php";

$sql = "SELECT id, name, colour, owned "
        ."FROM demo WHERE id = 4";

$statement = $pdo->prepare($sql);

$statement->execute();

$results = $statement->fetch(PDO::FETCH_ASSOC);

print_r($results);

echo "<dl>";
foreach( $results as $key=>$value){
?>
    <dt><?=$key ?></dt>
    <dd><?=$value ?></dd>
<?php
}
echo "</dl>";