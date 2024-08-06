<?php
/**
 * Form demo with PHP
 *
 * TailwindCSS: https://tailwindcss.com
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
    <title>Session 03 | Form Demo</title>

    <link rel="stylesheet" href="/assets/css/site.css">
</head>
<body>
<main class="mt-8">
    <form action="action.php" method="post"
          class="flex flex-col gap-8 w-80 m-auto border border-amber-500 p-8">
        <div class="grid grid-cols-2">
            <label for="Name">Name:</label>
            <input type="text" id="Name" name="name"
                   class="bg-neutral-200 p-1">
        </div>

        <div class="grid grid-cols-2">
            <p></p>
            <button type="submit"
                    class="bg-blue-500 color-white rounded">Send</button>
        </div>
    </form>
</main>
</body>
</html>
