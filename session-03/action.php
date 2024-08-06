<?php
require_once "functions.php";
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/site.css">
</head>
<body>

<?php

$getValues = $_GET;
$postValues = $_POST;

echo '<pre class="bg-stone-200 p-2 rounded-sm color-blue-700">';
print_r($getValues);
echo '</pre>';

echo '<pre class="bg-stone-200 p-2 rounded-sm color-blue-700">';
print_r($postValues);
echo '</pre>';
?>

<?php
if (isset($_GET['name'])){
    e("Name is set in GET");
}

if (isset($_POST['name'])){
    e("Name is set in POST");
}

?>
</body>
</html>
