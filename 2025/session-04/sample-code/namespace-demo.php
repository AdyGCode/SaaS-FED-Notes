<?php
/**
 * FILE TITLE GOES HERE
 *
 * DESCRIPTION OF THE PURPOSE AND USE OF THE CODE
 * MAY BE MORE THAN ONE LINE LONG
 * KEEP LINE LENGTH TO NO MORE THAN 96 CHARACTERS
 *
 * Filename:        class-demo.php
 * Location:        ${FILE_LOCATION}
 * Project:         SaaS-FED-Notes
 * Date Created:    6/08/2024
 *
 * Author:          YOUR_NAME <YOUR_EMAIL_ADDRESS>
 *
 */

require_once __DIR__ . "/Duck/RubberDuck.php";

$yellowDuck = new RubberDuck("yellow");

$colours = ['red', 'green', 'blue'];

$ducks = [];

foreach ($colours as $colour) {
    $ducks[$colour] = new RubberDuck($colour);
}

$ducks['blue']->setName('Bluey');

function d(): void
{
    echo "<pre class='bg-gray-100 color-black m-2 p-2 rounded shadow flex-grow text-sm'>";
    array_map(function ($x) {
        var_dump($x);
    }, func_get_args());
    echo "</pre>";
}

?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SaaS - FED | OOP | PHP | Namespace Demo</title>
    <link rel="stylesheet" href="/assets/css/site.css">
</head>
<body>
<main class="mt-8">
    <article class="flex flex-row gap-8 w-9/10 mx-auto p-8">
        <section class="flex flex-row gap-8 border border-amber-500 w-4/12 p-4 rounded">
            <h3 class="font-bold text-lg max-w-36">One Duck</h3>
            <?php d($yellowDuck); ?>
        </section>

        <section class="flex flex-row gap-8 border border-amber-500 w-4/12 p-4 rounded">
            <h3 class="font-bold text-lg max-w-36">Loads of Ducks</h3>
            <?php d($ducks); ?>
        </section>

        <section class="flex flex-col gap-8 border border-amber-500 w-4/12 p-4 rounded">
            <h3 class="font-bold text-lg max-w-36">Loads of Ducks</h3>
            <?php
            foreach ($ducks as $duck) {
                echo "<p>{$duck->details()}</p>";
            }
            ?>
        </section>
    </article>

</main>

</body>
</html>
