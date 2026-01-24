<?php
/**
 *
 */
?>
    <!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
    </head>
    <body>
    <?php
    /*
     * Multi line comment
     * ta-da!
     */
    echo "<h1>Hello World</h1>";
    echo '<p>Hello World!</p>';

    $name = 'Adrian';
    $count = 1;
    ?>

    <p><?php echo "Hi"; ?><?php echo $name; ?></p>
    <p><?= "Hi" ?> <?= $name ?></p>
    <p>Count: <?= $count ?></p>
    <p><?= "Count: $count" ?></p>
    <p><?= 'Count: $count' ?></p>
    <p><?= "Count: {$count}" ?></p>
    <p><?php echo "Count: " . ($count + 1); ?></p>
    <p>Arithmetic: BIMDAS Rules!</p>
    <p>Brackets (Parentheses) <code>( )</code></p>
    <p>Indices (Powers/Roots) <code>**</code></p>
    <p>Multiplication/Division/Modulo <code> * / %</code></p>
    <p>Addition/Subtraction <code>+ -</code></p>
    <?php
    echo "<p>5 + 6 = " . (5 + 6) . "</p>";
    echo "<p>5 - 6 = " . (5 - 6) . "</p>";
    echo "<p>5 * 6 = " . (5 * 6) . "</p>";
    echo "<p>5 / 6 = " . (5 / 6) . "</p>";
    echo "<p>8 % 5 = " . (8 % 5) . "</p>";
    echo "<p>2 ** 3 = " . (2 ** 3) . "</p>";
    echo "<p>2 ^ 3 = " . (2 ^ 3) . "(Bitwise xor operator)</p>";
    echo "<p>2 ~ 3 = " . (2 & 3) . "(Bitwise and operator)</p>";
    echo "<p>~3 = " . (~3) . "(Bitwise not operator)</p>";
    ?>

    <h2>Decisions et al</h2>
    <?php
    $flagYes = true;
    $flagNo = false;
    $yes_no = 'a' > 'b'; // > < >= <= != == === !==
    echo ('1' === 1) . " - " . ('1' == 1) . " - " . ('1' !== 1) . " - " . ('1' != 1);
    // AND && OR || Not !
    // Flatten your decisions
    if ('a' > 'b') {
        echo "A bigger";
    } elseif ('a' < 'b') {
        echo "A smaller";
    } else {
        echo "Same";
    }

    // bad code
    if ($count < 10)
        $count++;
    else {
        $count = 0;
    }

    // better code
    $count = $count < 10 ? $count + 1 : 0;

    // better code
    $total = 0;
    if ($count > 0) {
        $total = 1;
    }
    ?>

    <h2>Loops/Iteration</h2>
    <p>for foreach while </p>
    <?php
    for ($count = 0; $count < 10; $count++) {
        echo "$count ";
    }

    $myArray = [1, 2, 'a', 'b', 'Hello world', 5];
    foreach ($myArray as $item) {
        echo $item;
    }

    $count = 0;
    while ($count < 10) {
        echo "$count";
        $count++; // $count++ === $count+=1 === $count=$count+1
    }

    $count = 0;
    do {
        echo "$count";
        $count++;
    } while ($count < 5);
    ?>

    <h2>Constants</h2>
    <?php
    define('PI', 3.14159);
    const PI_2 = 3.141;

    echo PI * 3 * 3;
    echo PI * 3 ** 2;
    ?>
    <h2>Arrays</h2>
    <?php
    $months = ['Jan', 'Feb', 'Mar',];
    $monthNumbers = [1 => 'Jan',];
    $person = [
        'name' => 'Adrian',
        'location' => 'Perth',
    ];

    foreach ($person as $key=>$value) {
        echo"<p>".$key." : ".$value;
    }
    ?>
    </body>
    </html>
<?php
// End of file
// May do other stuff here
