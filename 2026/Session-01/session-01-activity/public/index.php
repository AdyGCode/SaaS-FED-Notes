<?php
declare(strict_types=1);

use App\ContactRepository;
use App\Database;

spl_autoload_register(function (string $class): void {
    $prefix = 'App\\';
    $baseDirectory = dirname(__DIR__).'/src/';

    if (!str_starts_with($class, $prefix)) {
        return;
    }

    $relativeClass = substr($class, strlen($prefix));
    $file = $baseDirectory.str_replace('\\', '/', $relativeClass).'.php';

    if (is_file($file)) {
        require $file;
    }
});

session_start();

$dbFile = dirname(__DIR__).'/database/contact_list_db.sqlite';
$pdo = Database::sqlite($dbFile);
$repo = new ContactRepository($pdo);

if (empty($_SESSION['_csrf'])) {
    $_SESSION['_csrf'] = bin2hex(random_bytes(16));
}

$csrf = $_SESSION['_csrf'];
$action = $_GET['action'] ?? 'list';
$title = 'Contacts';
$body = '';

if ($action === 'list' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    // TODO A1.2: Load contacts from the repository.
    $contacts = [];

    ob_start();
    require dirname(__DIR__).'/views/contacts.list.php';
    $body = (string) ob_get_clean();
} elseif ($action === 'create' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $errors = [];
    $old = [];

    ob_start();
    require dirname(__DIR__).'/views/contacts.form.php';
    $body = (string) ob_get_clean();
} elseif ($action === 'store' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    // TODO A2.2: Check that the submitted CSRF token matches $csrf.

    $name = trim((string) ($_POST['name'] ?? ''));
    $email = trim((string) ($_POST['email'] ?? ''));
    $phone = trim((string) ($_POST['phone'] ?? ''));

    $errors = [];

    // TODO A2.3: Validate the name and email.
    // Name must not be empty.
    // Email must be present and valid.

    if ($errors !== []) {
        // TODO A2.4: Preserve submitted values in $old.
        $old = [];

        ob_start();
        require dirname(__DIR__).'/views/contacts.form.php';
        $body = (string) ob_get_clean();
    } else {
        // TODO A2.5: Insert the contact using the repository.
        // Convert an empty phone string to null.

        header('Location: /?action=list');
        exit;
    }
} else {
    http_response_code(404);
    $body = '<p>Not found</p>';
}

ob_start();
require dirname(__DIR__).'/views/layout.php';
echo (string) ob_get_clean();
