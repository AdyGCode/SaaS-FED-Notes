<?php

declare(strict_types=1);

$students = [
    "Alice",
    "Bob",
    "Charlie",
    "Diana",
    "Ethan"
];

$marks = [85, 72, 91, 67, 78];

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PHP Loops Demo</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 2rem auto;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 2rem;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }

        th {
            background: #333;
            color: white;
        }

        h2 {
            margin-top: 2rem;
        }
    </style>
</head>
<body>

<h1>PHP Loops Demonstration</h1>

<h2>Example 1 - foreach</h2>

<p>Loop through an array of student names.</p>

<ul>

<?php foreach ($students as $student): ?>

    <li><?= htmlspecialchars($student) ?></li>

<?php endforeach; ?>

</ul>

<hr>

<h2>Example 2 - for</h2>

<p>Display the numbers 1 to 10.</p>

<?php for ($i = 1; $i <= 10; $i++): ?>

    <p>Number <?= $i ?></p>

<?php endfor; ?>

<hr>

<h2>Example 3 - for with an array</h2>

<table>

<tr>
    <th>#</th>
    <th>Student</th>
</tr>

<?php for ($i = 0; $i < count($students); $i++): ?>

<tr>
    <td><?= $i + 1 ?></td>
    <td><?= htmlspecialchars($students[$i]) ?></td>
</tr>

<?php endfor; ?>

</table>

<hr>

<h2>Example 4 - foreach with key and value</h2>

<table>

<tr>
    <th>Student</th>
    <th>Mark</th>
</tr>

<?php foreach ($marks as $index => $mark): ?>

<tr>
    <td><?= htmlspecialchars($students[$index]) ?></td>
    <td><?= $mark ?></td>
</tr>

<?php endforeach; ?>

</table>

<hr>

<h2>Example 5 - Challenge</h2>

<p>Modify this code to:</p>

<ol>
    <li>Add another student.</li>
    <li>Add another mark.</li>
    <li>Only display marks greater than or equal to 80.</li>
    <li>Display "Pass" if the mark is 50 or more, otherwise "Fail".</li>
</ol>

</body>
</html>
