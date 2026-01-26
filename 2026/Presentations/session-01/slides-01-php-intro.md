---
theme: nmt
title: Session 01 - PHP Fundamentals & Intro MVC
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
addons:
  - announcement
---

# Session 01: Demo

## SaaS – Cloud Application Development (Front-End Dev)

### PHP to DB: Quick Sprint (Instructor Edition)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->

---
level: 2
---

# Session 01 Objectives

## By the end, you should be capable of:

- Running PHP from CLI and built-in web server
- Handling HTTP requests (GET/POST), validate & escape input
- Connecting to a database using PDO
- Performing CRUD with prepared statements & transactions
- Applying basic security patterns (password hashing, CSRF token, error modes)

<!-- Instructor Notes:
- Tie each outcome to a demo moment in the session.
- Highlight that we’ll default to SQLite for zero-config, but show MySQL swap.
-->


---

# Contents

<Toc minDepth="1" maxDepth="1" />


---
layout: default
level: 2
---

# Navigating Slides

Hover over the bottom-left corner to see the navigation's controls panel.

## Keyboard Shortcuts

|                                                     |                             |
|-----------------------------------------------------|-----------------------------|
| <kbd>right</kbd> / <kbd>space</kbd>                 | next animation or slide     |
| <kbd>left</kbd>  / <kbd>shift</kbd><kbd>space</kbd> | previous animation or slide |
| <kbd>up</kbd>                                       | previous slide              |
| <kbd>down</kbd>                                     | next slide                  |

---
layout: grid
---

# PHP to DB: Quick Sprint

## From Zero → Forms → PDO → CRUD

::tl::

### Target Technology

- PHP 8.4+
- SQLite
- HTML5 & CSS3

::bl::

### Resources

- PhpStorm
- Laragon
- MS Terminal (& Bash)

::tr::

### Outcome

- Build a tiny web app that reads/writes a database securely.

::br::

### Aside

<Announcement title="PHP 8.4+">
PHP 8.4 or later
</Announcement>

<Announcement type="info">
Laragon from https://github.com/adygcode/
</Announcement>



<!-- Instructor Notes:
- Set expectations: 90–120 minutes core, +30–60 stretch.
- Emphasize practical outcome: a working CRUD mini‑app.
- Ask learners about prior exposure (any scripting, HTML forms?).
- Icebreaker: "What’s the one thing you want your app to *save* today?"-->

---
level: 2
---

# Prerequisites & Setup
- MS Terminal with Git's Bash enabled
- PHP **8.4+** installed (`php -v`)
- IDE (PhpStorm ✔️) or Editor (VS Code)
- SQLite (bundled PDO driver on most installs)
- PDO enabled in `php.ini` (`pdo_sqlite`)

---
level: 2
---

# Create folder structure

- Open MS Terminal
```shell [shell]
pwd
cd Source/Repos
mkdir SaaS-1-CAD-FED
cd SaaS-1-CAD-FED
mkdir 
```

**Run the dev server:**

```bash [shell]
php -S localhost:8000 -t public
```

<!-- Instructor Notes:
- If someone lacks SQLite driver, quickly show php.ini enabling `pdo_sqlite`.
- Windows note: run from project root, ensure `public/` is the doc root.
-->

---

## PHP: First Look

```php
<?php
declare(strict_types=1);

echo "Hello, PHP 8.4!\n";
$version = PHP_VERSION;
echo "Running PHP $version\n";
```

- `declare(strict_types=1)` → stricter type checks for function calls
- Scalar types, return types, nullable `?Type`
- Error reporting:

```php
error_reporting(E_ALL);
ini_set('display_errors', '1'); // dev only
```

<!-- Instructor Notes:
- Remind: strict types affect parameter & return type checks at call boundaries.
- Quick show: what happens if you pass an int where string required (if time).
-->

---

## Flow Control & Functions

```php
function greet(string $name = "world"): string {
  return "Hello, $name!";
}

$names = ["Ada", "Grace", "Linus"];
foreach ($names as $n) {
  echo greet($n) . PHP_EOL;
}
```

- `if/elseif/else`, `switch/match`, `for/foreach`, `while`
- `match` (expression), `??` null‑coalesce, nullsafe `?->`

<!-- Instructor Notes:
- Keep this slide brisk; focus time on HTTP + DB.
-->

---

## Arrays & Superglobals

- Arrays are ordered and associative
- Superglobals: `$_GET`, `$_POST`, `$_SERVER`, `$_SESSION`, `$_COOKIE`, `$_FILES`

```php
$name = $_GET['name'] ?? 'Guest';
echo htmlspecialchars($name, ENT_QUOTES, 'UTF-8');
```

> **Always escape on output** to prevent XSS.

<!-- Instructor Notes:
- Contrast input filtering vs output escaping.
- Mention `htmlspecialchars(..., ENT_QUOTES, 'UTF-8')` as safe default.
-->

---

## Working with HTTP Forms

1. Show form (GET)
2. Submit (POST)
3. Validate & sanitize
4. Store in DB
5. Redirect (PRG) and render safe HTML

**Input filtering:**

```php
$title = filter_input(INPUT_POST, 'title', FILTER_UNSAFE_RAW, FILTER_FLAG_STRIP_LOW);
```

**Output escaping:**

```php
echo htmlspecialchars($title, ENT_QUOTES, 'UTF-8');
```

<!-- Instructor Notes:
- PRG = Post/Redirect/Get; eliminate duplicate submissions on refresh.
- Keep validation simple but strict enough (length, presence).
-->

---

## CSRF (Cross-Site Request Forgery)

- Create a token, store in `$_SESSION`
- Include hidden `<input>` in form
- Verify token on POST

```php
session_start();
$_SESSION['csrf'] ??= bin2hex(random_bytes(32));
$token = $_SESSION['csrf'];
// On POST: hash_equals($_SESSION['csrf'], $_POST['csrf'] ?? '')
```

<!-- Instructor Notes:
- Explain why CSRF matters even when using prepared statements (different threat).
- Quick demo: delete action uses POST + CSRF.
-->

---

## Files & JSON (Quick Look)

```php
$data = ["ok" => true, "time" => time()];
file_put_contents("data.json", json_encode($data, JSON_PRETTY_PRINT));

$content = json_decode(file_get_contents("data.json"), true);
```

<!-- Instructor Notes:
- Optional; skip if time is tight.
-->

---

## OOP Basics (Tiny Taste)

```php
class NoteService {
  public function __construct(private PDO $pdo) {}
  public function all(): array {
    return $this->pdo->query("SELECT id, title, body FROM notes ORDER BY id DESC")
                     ->fetchAll(PDO::FETCH_ASSOC);
  }
}
```

- Constructor property promotion
- Type-hinted dependencies (e.g., `PDO`)

<!-- Instructor Notes:
- Keep this conceptual; main code stays procedural for approachability.
-->

---

## Why PDO?

- Unified API for many DBs (SQLite, MySQL, PostgreSQL…)
- Prepared statements, transactions, error modes
- Consistent, secure, future-proof

**Connect (SQLite):**

```php
$pdo = new PDO('sqlite:' . __DIR__ . '/../data/app.db', null, null, [
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);
```

<!-- Instructor Notes:
- Emphasize drivers: pdo_sqlite vs pdo_mysql.
-->

---

## Prepared Statements

```php
$stmt = $pdo->prepare("INSERT INTO notes(title, body) VALUES (:title, :body)");
$stmt->execute([':title' => $title, ':body' => $body]);
```

- Avoids SQL injection
- Binds parameters with types automatically (or explicit `bindValue`)

<!-- Instructor Notes:
- Show contrast: DO NOT do `$sql = "...$title..."` string concat.
-->

---

## Transactions

```php
$pdo->beginTransaction();
try {
  // multiple queries here
  $pdo->commit();
} catch (Throwable $e) {
  $pdo->rollBack();
  throw $e;
}
```

- All-or-nothing safety for multi-step changes

<!-- Instructor Notes:
- Mention typical uses: multi-table updates, money transfers, counters.
-->

---

## MySQL DSN (Alternative)

```php
$pdo = new PDO(
  "mysql:host=127.0.0.1;dbname=app;charset=utf8mb4",
  "app_user",
  "secret",
  [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
  ]
);
```

<!-- Instructor Notes:
- Call out `utf8mb4` to support full Unicode.
-->

---

## Security Essentials

- **Prepared statements** only (never concat SQL)
- **Escape output** with `htmlspecialchars`
- **CSRF tokens** on state changes
- **Password hashing**:

```php
$hash = password_hash($password, PASSWORD_DEFAULT);
password_verify($input, $hash);
```

- Turn off error display in production; log errors instead

<!-- Instructor Notes:
- Quick note on configuration by environment (dev vs prod).
-->

---

## Demo: What We’ll Build

- Notes mini-app
    - List notes (title + body)
    - Add new note (form POST)
    - Edit & Delete note
    - SQLite by default; MySQL optional

**Run:**

```bash
php -S localhost:8000 -t public
```

<!-- Instructor Notes:
- Show directory structure and first run.
-->

---

## Live Coding Checkpoint #1: Project Bootstrap (5–8 min)

- Create folders: `public/`, `src/`, `data/`
- Add `src/bootstrap.php` with error reporting, session, CSRF
- Add `src/db.php` that returns PDO (SQLite)
- Add `public/index.php` with a basic HTML shell

**Goal:** page loads without errors at `/`.

<!-- Instructor Notes:
- Keep pace brisk; provide starter zip for late joiners.
-->

---

## Live Coding Checkpoint #2: Create Note (10–12 min)

- Build a POST form with fields: `title`, `body`, hidden `csrf`
- Validate inputs; on success `INSERT` via prepared statement
- PRG redirect back to `/`

**Goal:** Add a note and see it on the list.

<!-- Instructor Notes:
- Sprinkle in `e()` helper for escaping outputs.
-->

---

## Live Coding Checkpoint #3: List & Delete (8–10 min)

- Query all notes by `created_at DESC`
- Render each with escaped HTML
- Add `delete.php` handling POST + CSRF to remove by id

**Goal:** Delete works safely via POST (confirm dialog optional).

<!-- Instructor Notes:
- Explain why delete should not be a GET.
-->

---

## Live Coding Checkpoint #4: Edit Note (10–12 min)

- Add `edit.php`:
    - GET loads note by id; prefill form
    - POST validates and `UPDATE`s with prepared statement
    - Redirect back to `/`

**Goal:** Full CRUD achieved.

<!-- Instructor Notes:
- Mention optimistic approach (no version column) for simplicity.
-->

---

## Live Coding Checkpoint #5: Search & Pagination (Optional, 10–15 min)

- Add GET `q` filter (title LIKE `%term%`)
- Add page size (5) and `page` param for pagination

**Goal:** Usable list with simple search and paging.

<!-- Instructor Notes:
- Stress binding for `LIMIT/OFFSET` as integers.
-->

---

## Troubleshooting

- “Driver not found” → enable `pdo_sqlite` or `pdo_mysql`
- Permissions for `data/` folder (writable)
- Check `error_log` if display is off

<!-- Instructor Notes:
- Keep a known-good zip ready for distribution.
-->

---

## Next Steps

- Pagination & search
- User accounts with sessions
- Input validation library
- Migrations & seeders
- Framework bridge (Laravel Eloquent)

<!-- Instructor Notes:
- Tie to follow-up modules in your course.
-->

---

## Stretch Goals (More!)

- Tags with many-to-many relation to notes (tables: `tags`, `note_tag`)
- Soft delete (`deleted_at` nullable) and restore
- Full-text search (SQLite FTS5 or MySQL FULLTEXT where available)
- File uploads (attach an image to a note; validate type/size; store path)
- Basic auth: register/login with `password_hash` + session
- Export notes to JSON and re-import with validation
- Introduce a tiny router and controllers
- Add unit/integration tests for DB layer (PDO in-memory SQLite)

<!-- Instructor Notes:
- Let teams pick 1–2 stretch goals to pursue.
-->

---

## Resources

- PHP Manual (language & functions)
- PDO documentation
- OWASP Cheat Sheets (XSS, SQLi, CSRF)

<!-- Instructor Notes:
- Provide links in LMS or repo README for easy access.
-->
