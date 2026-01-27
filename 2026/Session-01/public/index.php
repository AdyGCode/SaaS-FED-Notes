<?php
declare(strict_types=1);

use App\Database;
use App\ContactRepository;

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

session_start();

// Configure PDO (SQLite for class)
$dbFile = dirname(__DIR__).'/database/contact_list_db.sqlite';
if (!is_file($dbFile)) {
    touch($dbFile);
    $pdo = Database::sqlite($dbFile);
    $schema = file_get_contents(dirname(__DIR__).'/database/migrations/001_create_contacts.sql');
    $pdo->exec($schema);
} else {
    $pdo = Database::sqlite($dbFile);
}
// For MariaDB instead, comment out above and use:
// $pdo = Database::mysql('127.0.0.1', 'cad', 'cad_user', 'secret');

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
        $repo->insert($name, $email, $phone !== '' ? $phone : None);
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