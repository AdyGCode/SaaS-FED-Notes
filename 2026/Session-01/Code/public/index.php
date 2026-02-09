<?php
declare(strict_types=1);

/**
 *  Constants:
 *  - DB_FILENAME        For SQLite ONLY
 *  - DB_HOST            For MariaDB/MySQL
 *  - DB_NAME            For MariaDB/MySQL
 *  - DB_USER            For MariaDB/MySQL
 *  - DB_PASSWORD        For MariaDB/MySQL
 */
const DB_FILENAME='contact_list_db.sqlite';
const DB_HOST='localhost';
const DB_NAME='contact_list_database';
const DB_USER='contact_list_user';
const DB_PASSWORD='some-secret-password';

/**
 * Register classes for automatic loading
 * within the `App` namespace
 */
spl_autoload_register(function ($class) {
    $prefix = 'App\\';
    $baseDir = dirname(__DIR__).'/src/';
    if (str_starts_with($class, $prefix)) {
        $rel = substr($class, strlen($prefix));
        $file = $baseDir.str_replace('\\', '/', $rel).'.php';
        if (is_file($file)) {
            require $file;
        }
    }
});

/**
 * Start the session for CSRF et al
 */
session_start();


use App\ContactRepository;
use App\Database;

/**
 * Create the Database Connection
 *
 * If SQLite then we use the DB_FILENAME constant.
 * The db is automatically created if it doesn't exist, and the schema is applied.
 *
 * If MySQL/MariaDB then we expect a database and user to have been created beforehand.
 * Databse connection details are then added to replace the constants at the top of this file.
 */
$pdo = Database::sqlite(DB_FILENAME);
// For MariaDB instead, comment out above and use:
// $pdo = Database::mysql(DB_HOST, DB_NAME, DB_USER, DB_PASSWORD);

$repo = new ContactRepository($pdo);

// CSRF: generate token if missing
if (empty($_SESSION['_csrf'])) {
    $_SESSION['_csrf'] = bin2hex(random_bytes(16));
}
$csrf = $_SESSION['_csrf'];

// Routing
$action = $_GET['action'] ?? 'list';
$title = 'Contacts';
$body = '';

if ($action === 'list' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $contacts = $repo->all();
    ob_start();
    require dirname(__DIR__).'/views/contacts.list.php';
    $body = ob_get_clean();

} elseif ($action === 'create' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $errors = [];
    $old = [];
    ob_start();
    require dirname(__DIR__).'/views/contacts.form.php';
    $body = ob_get_clean();

} elseif ($action === 'store' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    // Basic CSRF check
    if (!hash_equals($csrf, $_POST['_csrf'] ?? '')) {
        http_response_code(419);
        exit('CSRF token mismatch');
    }

    // Validation (simple)
    $name = trim((string) ($_POST['name'] ?? ''));
    $email = trim((string) ($_POST['email'] ?? ''));
    $phone = trim((string) ($_POST['phone'] ?? ''));

    $errors = [];
    if ($name === '') {
        $errors['name'] = 'Name is required';
    }
    if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors['email'] = 'Valid email required';
    }

    if ($errors) {
        $old = compact('name', 'email', 'phone');
        ob_start();
        require dirname(__DIR__).'/views/contacts.form.php';
        $body = ob_get_clean();

    } else {
        $repo->insert($name, $email, $phone !== '' ? $phone : null);
        header('Location: /?action=list');
        exit;
    }

} else {
    http_response_code(404);
    $body = '<p>Not found</p>';
}

// Render
ob_start();
require dirname(__DIR__).'/views/layout.php';
echo ob_get_clean();
