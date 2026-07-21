# Session 01 Student Starter — PHP Contacts

This starter project supports the two activities from the Session 01 slides:

- **A1 — List Contacts**
- **A2 — Create Contact**

It intentionally contains incomplete sections marked `TODO`. Complete the TODOs in order rather than copying a finished solution.

## Requirements

- PHP 8.2 or later
- PDO
- `pdo_sqlite`
- `sqlite3`

Check the extensions:

```bash
php -m
```

## Run the starter

From the project root:

```bash
php -S 127.0.0.1:8080 -t public
```

Open:

```text
http://127.0.0.1:8080/?action=list
```

The SQLite database and seed contacts are created automatically on first run.

## Activity A1 — List Contacts

Complete these TODOs:

1. `src/ContactRepository.php` — `A1.1`
2. `public/index.php` — `A1.2`
3. `views/contacts.list.php` — `A1.3`

- The page displays the three seed contacts.
- The table includes ID, Name, Email, Phone and Created.
- Text values are escaped before output.

## Activity A2 — Create Contact

Complete these TODOs:

1. `src/ContactRepository.php` — `A2.1`
2. `public/index.php` — `A2.2` to `A2.5`
3. `views/contacts.form.php` — `A2.6`

Acceptance check:

- Valid contacts are inserted and appear in the list.
- Blank names show an error.
- Invalid emails show an error.
- Old form values remain after validation fails.
- The form includes and verifies a CSRF token.

## Reset the database

Stop the PHP server and delete:

```text
database/contact_list_db.sqlite
```

Restart the server. The database and seed data will be recreated.

## Suggested commits

```bash
git init
git add .
git commit -m "Create Session 01 starter project"
```

After A1:

```bash
git add .
git commit -m "Complete contact list activity"
```

After A2:

```bash
git add .
git commit -m "Complete create contact activity"
```

## Request flow

```text
Browser request
    -> public/index.php
    -> ContactRepository
    -> SQLite database
    -> view file
    -> layout.php
    -> HTML response
```
