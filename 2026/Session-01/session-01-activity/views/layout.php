<?php
declare(strict_types=1);

/** @var string $title */
/** @var string $body */
?><!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars($title, ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="stylesheet" href="/site.css">
</head>
<body>
<header id="top">
    <h1>Contacts</h1>
    <nav>
        <a href="/?action=list">List</a>
        <span aria-hidden="true"> | </span>
        <a href="/?action=create">Create</a>
    </nav>
</header>

<main>
    <?= $body ?>
</main>

<footer>
    <small>Session 01 Activity • PHP 8.x + PDO + SQLite</small>
</footer>
</body>
</html>
