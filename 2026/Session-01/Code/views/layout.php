<?php
declare(strict_types=1);

/**
 * @var string $title contains the page title (in browser tab)
 * @var string $body contains the content for the body of the page
 */
?><!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><?= htmlspecialchars($title) ?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="preconnect" href="https://api.fonts.coollabs.io" crossorigin />
    <link href="https://api.fonts.coollabs.io/css2?family=Lexend:wght@100..900&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="/site.css">
</head>
<body>
<header id="Top">
    <h1>Contacts</h1>
    <nav>
        <a href="/?action=list">List</a> &vert; <a href="/?action=create">Create</a>
    </nav>
</header>
<main>
    <?= $body ?>
</main>
<footer>
    <small>Session 01 Demo • PHP 8.x + PDO</small></footer>
</body>
</html>
