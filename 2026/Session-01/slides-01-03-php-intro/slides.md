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
layout: section
---

# Configurations

- Terminal config (Bash, CLI Aliases)
- Check PHP version
- Check `PHP.INI` settings
- Check NPM/PNPM

--- 
layout: default
level: 2
---

# Configuration Check 1

## MS Terminal, Bash and CLI

- Have you set up MS Terminal, Bash and CLI Aliases?
  - No: Check out slides-01-01-setting up
  - Yes: Great, onto next step


--- 
layout: two-cols
level: 2
---

# Configuration Check 2

::left::

## PHP Version

Check the PHP Version via:

```shell
php --version
```

- **Not** Version 8.4+:
    - Install PHP 8.4 or later
    - Change version using Laragon
    - Update Laragon paths
    - Close terminal totally, and reopen

::right::

Example output (run on Mac OS)
```text
PHP 8.4.16 (cli) (built: Dec 20 2025 09:42:27) (NTS clang 17.0.0)
Copyright (c) The PHP Group
Built by Laravel Herd
Zend Engine v4.4.16, Copyright (c) Zend Technologies
    with Zend OPcache v8.4.16, Copyright (c), by Zend Technologies
```



--- 
layout: two-cols
level: 2
---

# Configuration Check 3

::left::

## Locating the `PHP.INI` File

PHP Settings for Development

`PHP.INI` located in:
- `c:\laragon\bin\php\PHP_VERSION`
- `c:\ProgramData\laragon\bin\php\PHP_VERSION`

::right::
<br><br>
<br><br>
You are able to open via:

- Opening Laragon
- Right Mouse
- Hover over PHP
- Hover over PHP Version
- Move down and click on `PHP.INI`



--- 
layout: two-cols
level: 2
---

# Configuration Check 4

::left::

## Changing the `PHP.INI` Settings 


Change Settings:
- `upload_max_filesize=5M`
- `post_max_size=5M`
- `memory_limit=128M`

<Announcement type="info" title="Server Defaults">
Keep smaller.<br>Beware of memory limit being too big.
</Announcement>

::right:: 

Locate Extensions section

Extensions have:
- `extension=` (enabled)
- `;extension=` (disabled)

Ensure following are **enabled**:
- `pdo_sqlite`, `pdo_mysql`
- `pdo_pgsql`, `sqlite3`
- `intl`, `bz2`, `curl`
- `gd`, `intl`, `mbstring`
- `zip`

--- 
layout: two-cols
level: 2
---

# Configuration Check 5

::left::

## Node.js, NPM and PNPM

- `node` - Node.js, JavaScript run time 
- `npm` - JavaScript package manager
- `pnpm` - Performant JavaScript package manager

Execute commands shown after `>` prompt.

```shell
> npm --version
11.6.1
> pnpm --version
10.28.2
> node --version
v24.10.0
```

::right::
> We will verify current versions on GitHub

Package manager - recommend using `pnpm`.
- Less drive space
- Faster package management
- Quicker run time

Replace any `npm` command with `pnpm` after installing.

#### Install pnpm using:

```shell
npm -g i pnpm
```

As per PHP, restart terminal after adding package

---
layout: section
---

# PHP to DB Quick Sprint

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

# Set Up Demo Project

Execute shell commands

```shell [shell]
cd Source/Repos
mkdir SaaS-1-CAD-FED
cd SaaS-1-CAD-FED
mkdir -p session-01-demo/{public,src,data} 
cd session-01-demo
```

Create empty files:

```shell [shell]
touch {.,src,public,data}/.gitignore
touch src/bootstrap.php
touch src/db.php
touch public/index.php
touch data/database.sqlite
```

---
layout: default 
level: 2
---

# Version Control & Start PHP Server

## Initialise Version Control

```shell [bash]
git init 
git status
git add .
git commit -m "chore: initialise project"
```

## Run PHP's dev server

```bash [shell]
php -S localhost:8000 -t public
```

- sets the "**root**" of the project to be the `public` folder
- will use `public` in real projects

<!-- Instructor Notes:
- If someone lacks SQLite driver, quickly show php.ini enabling `pdo_sqlite`.
- Windows note: run from project root, ensure `public/` is the doc root.
-->


---
layout: section
---

# PHP First Look

---
level: 2
---

# PHP files

End with
- `.php`

May be prefiex with sub-extensions, or clarifiers
- `.blade.php`
- `.view.php`

All files start with:

```php [PHP]
<?php
declare(strict_types=1);
```

- `declare(strict_types=1)` → stricter type checks for function calls

---
level: 2
---

# Types, Nullables

- Scalar types
    - `int`, `bool`, `string`  , `float`
- Compound types
    - `array`, `object`, `callable`, `iterable` 
- Special types
    - `resource`, `null` 

---
level: 2
---

# Type hint variables, function return types

### Return Types

```php [PHP]
function demoFunction (int $firstNumber, int $secondNumber): string {
    return "{$firstNumber} + {$secondNumber} = {$firstNumber + $secondNumber}";
}
```

### Nullable `?Type`

```php [PHP]
function demoFunction (int $firstNumber, int $secondNumber): ?string {
return "{$firstNumber} + {$secondNumber} = {$firstNumber + $secondNumber}";
}
```

> Scalar Type Hints. (2026). Symfonycasts.com. https://symfonycasts.com/screencast/php7/scalar-type-hints

---
level: 2
---

# Output, Error Reporting

## Simple Output

```php [PHP] {none|1|2-3|all}
echo "Hello, PHP 8.4!\n";
$version = PHP_VERSION;
echo "Running PHP $version\n";
```

## Error reporting:

```php [PHP]  {none|1|3|all}
error_reporting(E_ALL);

ini_set('display_errors', '1'); // dev only
```

<!-- Instructor Notes:
- Remind: strict types affect parameter & return type checks at call boundaries.
- Quick show: what happens if you pass an int where string required (if time).
-->

---
level: 2
---

# Flow Control & Functions

## Function Definition

```php [PHP] {none|1,3|2|all}
function greet(string $name = "world"): string {
  return "Hello, $name!";
}
```

## Flow control

- `if/elseif/else`, `switch/match`, `for/foreach`, `while`
- `match` (expression), `??` null‑coalesce, nullsafe `?->`

```php [PHP] {none|1|2,4|3|all}
$names = ["Ada", "Grace", "Linus"];
foreach ($names as $n) {
  echo greet($n) . PHP_EOL;
}
```

<!-- Instructor Notes:
- Keep this slide brisk; focus time on HTTP + DB.
-->


---
level: 2
---

# IFs, Ternary and Coalesce

Simplifying IF...THEN...ELSE

````md magic-move

```php [PHP] {none|1|1-2,4,6|1-4,6|all}
/* Using IF...THEN...ELSE */
if (exists($anotherVariable) && !is_null($anotherVariable) ) {
    $someValue = $anotherVariable;
} else {
    $someValue = 'Default Value';
}
```

```php [PHP] {1-2|3-5|all}
/* Initialise with default */
$someValue = 'Default Value';
if (exists($anotherVariable) && !is_null($anotherVariable) ) {
    $someValue = $anotherVariable;
}
```

```php [PHP]
/* Ternary Operator */
$someValue = (exists($anotherVariable) && !is_null($anotherVariable) ) ? $anotherVariable : 'Default Value';
```


```php [PHP]
/* Null Coalesce */
$someValue = $anotherVariable ?? 'Default Value';
```
````

The null coalesce checks the variable
- if variable is null, it applies a default value
- otherwise the value is the value of the variable being checked

---
layout: section
---

# Arrays, Superglobals & Forms


---
level: 2
---

# Arrays

Arrays are ordered and associative

```php [PHP] {none|1,9-10|3-7,12|all}
$simpleArray = [1, 'hello', 'orange',];

$associativeArray = [
    'id'=>1, 
    'greeting'=>'hello',
    'colour'=>'Orange',
];

echo $simpleArray[0];
echo $simpleArray[2];

echo $associativeArray['color'];
```

---
level: 2
---

# Superglobals

Available throughout code

- `$_GET`
- `$_POST`
- `$_SERVER`
- `$_SESSION`
- `$_COOKIE`
- `$_FILES`

Access using:

```php [PHP] {
$name = $_GET['name'] ?? 'Guest';
echo htmlspecialchars($name, ENT_QUOTES, 'UTF-8');
```

<Announcement type="important" tile="Security">
<strong>Always</strong> escape on output to prevent XSS.
</Announcement>


<!-- Instructor Notes:
- What do they notice?
- Contrast input filtering vs output escaping.
- Mention `htmlspecialchars(..., ENT_QUOTES, 'UTF-8')` as safe default.
-->


---
level: 2
---

# Working with HTTP Forms

1. Show form (GET)
2. Submit (POST)
3. Validate & sanitize
4. Store in DB
5. Redirect (PRG) and render safe HTML

**Input filtering:**

```php [PHP] {none|all}
$title = filter_input(INPUT_POST, 'title', FILTER_UNSAFE_RAW, FILTER_FLAG_STRIP_LOW);
```

**Output escaping:**

```php [PHP] {none|all}
echo htmlspecialchars($title, ENT_QUOTES, 'UTF-8');
```

<Announcement type='info' title='References'>
 Available at the end of the presentation
</Announcement>

<!-- Instructor Notes:
- PRG = Post/Redirect/Get
    - eliminate duplicate submissions on refresh.
- Keep validation simple but strict enough
    - (length, presence).
-->

---
level: 2
---

# CSRF (Cross-Site Request Forgery)

- Create a token, store in `$_SESSION`
- Include hidden `<input>` in form
- Verify token on POST

<br>

```php [PHP] {none|1|3-4|6|all}
session_start();

$_SESSION['csrf'] ??= bin2hex(random_bytes(32));
$token = $_SESSION['csrf'];

// On POST: 
// hash_equals($_SESSION['csrf'], $_POST['csrf'] ?? '')
```

<!-- Instructor Notes:
- Explain why CSRF matters even when using prepared statements (different threat).
- Quick demo: delete action uses POST + CSRF.
-->

---
layout: section
---

# Files & JSON

---
level: 2
---

# Files & JSON (Quick Look)

Able to Read & Write

Beware of dangers
- e.g. overwriting source code

Write JSON to file:

```php [PHP] {none|1|2|all}
$data = ["ok" => true, "time" => time()];
file_put_contents("data.json", json_encode($data, JSON_PRETTY_PRINT));
```

Read JSON from File:
```php [PHP] {none|all}
$content = json_decode(file_get_contents("data.json"), true);
```

<!-- Instructor Notes:
- Optional; skip if time is tight.
-->

---
layout: section
---

# OOP in PHP

## A tiny look


---
level: 2
---

# OOP Basics (Tiny Taste)

````md magic-move
```php [PHP] {none|all}
class NoteService {
  
}
```

```php [PHP] {1,8|3-6|10|all}
class NoteService {

  // Constructor has double underscore (_)
  public function __construct(private PDO $pdo) {
    // do object initialisation
  }
  
}

$notes = new NoteService();
```

```php [PHP] {1-5,12,14|7-11,15|all}
class NoteService {

  public function __construct(private PDO $pdo) {
    // do object initialisation
  }
  
  public function all(): array {
    return $this->pdo
           ->query("SELECT id, title, body FROM notes ORDER BY id DESC")
           ->fetchAll(PDO::FETCH_ASSOC);
  }
}

$notes = new NoteService();
$allNotes = $notes->all();
```

````


- Constructor property promotion
- Type-hinted dependencies (e.g., `PDO`)

<!-- Instructor Notes:
- Keep this conceptual; main code stays procedural for approachability.
-->

---
layout: section
---

# PDO

## PHP Data Objects

PHP's OOP Database Connectivity
---
level: 2
---

## Why PDO?

- Unified API for many DBs (SQLite, MySQL, PostgreSQL …)
- Prepared statements, transactions, error modes
- Consistent, secure, future-proof

<br>

### Connect (SQLite)

- SQLite uses a single file to store
- Use `__DIR__` as a absolute base for access to file

```php [PHP] {none|1,4|all}
$pdo = new PDO('sqlite:' . __DIR__ . '/../data/app.db', null, null, [
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
]);
```

---
level: 2
---

# DSN - Data Source Name

- SQLite

```php [PHP]
$dsn = 'sqlite:ABSOLUTE_FOLDER_REFERENCE/DATABASE_NAME.db';
```

- MySQL, MariaDB

```php [PHP]
$dsn = 'mysql:host=HOST_NAME;dbname=DATABASE_NAME;port=DATABASE_PORT;charset=utf8mb4'
```

- PostgreSQL

```php [PHP]
$dsn = 'pgsql:host=HOST_NAME;dbname=DATABASE_NAME;port=DATABASE_PORT;charset=utf8mb4'
```

<!-- Instructor Notes:
- Emphasize drivers: pdo_sqlite vs pdo_mysql
-->

---
level: 2
---

# MySQL DSN (Example)

- Database Name -> `my_app_db`
- Database Host -> `127.0.0.1`
- Database Port -> `3306` (MySQL/MariaDB default)
- Database User Name -> `app_user` 
- Database User password -> `secret`

```php [PHP] {none|1,9|1-2,9|1-4,9|all}
$pdo = new PDO(
  "mysql:host=127.0.0.1;port=3306;dbname=my_app_db;charset=utf8mb4",
  "app_user",
  "secret",
  [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
  ]
);
```

<!-- Instructor Notes:
- `utf8mb4` to support full Unicode.
- [ ] contains the connection options
-->


---
level: 2
---

# Prepared Statements

```php [PHP] {none|1,3|1-3|1-5,8|5-8|all}
$stmt = $pdo->prepare(
        "INSERT INTO notes(title, body) VALUES (:title, :body)"
);

$stmt->execute([
    ':title' => $title, 
    ':body' => $body
]);
```

- Avoids SQL injection
- Binds parameters with types automatically (or explicit `bindValue`)

<!-- Instructor Notes:
- Show contrast: DO NOT do `$sql = "...$title..."` string concat.
-->

---
level: 2
---

# Prepared Statements 2

Better to use longer code
- Easier to debug
- Less complex statements

```php [PHP] {none|1-3|5-6|all}
$stmt = $pdo->prepare(
        "INSERT INTO notes(title, body) VALUES (:title, :body)"
);

$stmt->bindParam( ':title', $title, PDO::PARAM_STRING);
$stmt->bindParam( ':body', $body, PDO::PARAM_STRING);

$stmt->execute();
```

---
level: 2
---


# Transactions

```php [PHP] {none|1|3,6,9|3-6,9|3,6-9|all}
$pdo->beginTransaction();

try {
  // multiple queries here
  $pdo->commit();
} catch (Throwable $e) {
  $pdo->rollBack();
  throw $e;
}
```

- All-or-nothing safety for multistep changes

<!-- Instructor Notes:
- Mention typical uses: multi-table updates, money transfers, counters.
-->

---
layout: section
---

# PHP Security Basics / Essentials

---
level: 2
---

## Security Essentials

- **Prepared statements** only (never "concatenate" SQL)
- **Escape output** with `htmlspecialchars`
- **CSRF tokens** on state changes (POST, PUT, PATCH, DELETE)
- **Password hashing**:

```php [PHP] {none|all}
$hash = password_hash($password, PASSWORD_DEFAULT);
password_verify($input, $hash);
```

- Turn off error display in production
    - Log errors instead

<!-- Instructor Notes:
- Quick note on configuration by environment (dev vs prod).
-->

---
layout: section
---

# Demo Application

--- 
level: 2
---

# Demo: What We Will Build

- Contacts mini-app
    - List contacts (name, phone number)
    - Add new contact (form POST)
    - Edit contact
    - Delete contact
- Database
  - SQLite by default
  - MySQL optional

## Run Application

We will use the following CLI command to run locally

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

# Resources

The following resources will be useful for research and future learning

- PHP Manual (language & functions)
    -Manual. (2026). PHP: PHP Manual - Manual. Php.net. https://www.php.net/manual/en/index.php
 
- PDO documentation
    -  Manual. (2026). PHP: PDO - Manual. Php.net. https://www.php.net/manual/en/book.pdo.php

- OWASP Cheat Sheets (XSS, SQLi, CSRF)
    - Introduction - OWASP Cheat Sheet Series. (2026). Owasp.org. https://cheatsheetseries.owasp.org/index.html

- OWASP Web Security Testing Guide
    - WSTG - Latest | OWASP Foundation. (2026). Owasp.org. https://owasp.org/www-project-web-security-testing-guide/latest/

---
level: 1
layout: section
---

# References

---
level: 2
---

# References 1


- PHP Tutorial. (2025, April 10). PHP Tutorial. https://www.phptutorial.net/
- PHP OOP - Object-oriented Programming in PHP. (2022, January 30). PHP Tutorial. https://www.phptutorial.net/php-oop/
- PHP PDO Tutorial. (2021, July 9). PHP Tutorial. https://www.phptutorial.net/php-pdo/

- berastis. (2023, June 6). An Exhaustive Guide to Understanding and Using PHP Data Types. Medium. https://medium.com/@berastis/an-exhaustive-guide-to-understanding-and-using-php-data-types-b56f6863c637
- Scalar Type Hints. (2026). Symfonycasts.com. https://symfonycasts.com/screencast/php7/scalar-type-hints

---
level: 2
---

# References 2


- Mastering Input Filtering in PHP: A Guide to `filter_input` Techniques. (2025, June 30). DEV Community; dev.to. https://dev.to/imoh_imohowo/mastering-input-filtering-in-php-a-guide-to-filterinput-techniques-n4o
- GeeksforGeeks. (2019, February 14). PHP | filter_input() Function. GeeksforGeeks. https://www.geeksforgeeks.org/php/php-filter_input-function/
- GeeksforGeeks. (2021, May 25). How to parse a JSON File in PHP? GeeksforGeeks. https://www.geeksforgeeks.org/php/how-to-parse-a-json-file-in-php/
- Dupont, N. (2022, March 12). Read, Decode, Encode, Write JSON in PHP. Nidup.io. https://www.nidup.io/blog/manipulate-json-files-in-php/
- Manual. (2026). PHP: PDO - Manual. Php.net. https://www.php.net/manual/en/book.pdo.php

---
level: 2
---

# References 3

- Adams, A. (2023, September 4). The definitive guide to object-oriented programming in PHP. Honeybadger. https://www.honeybadger.io/blog/in-depth-guide-to-object-oriented-programming-in-php/
- PHP Object-Oriented Programming Design Basics | Zend. (2025). Zend. https://www.zend.com/blog/object-oriented-programming-php
- SQLite vs MySQL vs PostgreSQL (Detailed Comparison). (2025, October 20). RunCloud Blog. https://runcloud.io/blog/sqlite-vs-mysql-vs-postgresql
- (The only proper) PDO tutorial. (2020). Treating PHP Delusions. https://phpdelusions.net/pdo
- Manual. (2026). PHP: PHP Manual - Manual. Php.net. https://www.php.net/manual/en/index.php
- Introduction - OWASP Cheat Sheet Series. (2026). Owasp.org. https://cheatsheetseries.owasp.org/index.html


---

# Acknowledgements

- Fu, A. (2020). Slidev. Sli.dev. https://sli.dev/
- Font Awesome. (2026). Font Awesome. Fontawesome.com; Font Awesome. https://fontawesome.com/

- Slide template
    - Adrian Gould

<br>

> - Some content was generated with the assistance of Microsoft CoPilot
