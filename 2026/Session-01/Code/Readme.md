# Contacts Demo (Session 01)

A simple PHP contacts application demonstrating how to connect a web application to either **SQLite** or **MariaDB** using PDO.

---

## Requirements

- PHP 8.2 or later
- PDO enabled
- SQLite PDO extension (for SQLite)
- MariaDB/MySQL server (for MariaDB)

Check your installed PHP extensions:

```bash
php -m
```

For SQLite you should see:

```
PDO
pdo_sqlite
sqlite3
```

---

## Running the Application

From the project root:

```bash
php -S 127.0.0.1:8080 -t public
```

Open your browser:

```
http://127.0.0.1:8080/?action=list
```

---

## Database

The application supports both **SQLite** and **MariaDB**.

### SQLite (Default)

SQLite is the default database.

On first run the application will automatically:

1. Create `database/contact_list_db.sqlite`
2. Run the migration in `database/migrations/001_create_contacts.sql`
3. Insert the sample contacts

No manual migration is required.

---

### Switching to MariaDB

To use MariaDB instead of SQLite:

1. Create a database (for example `contact_list_database`).
2. Run the migration:

```bash
mysql -u contact_list_user -p contact_list_database < database/migrations/001_create_contacts.sql
```

Enter your password when prompted.

3. Open `public/index.php` and replace:

```php
$pdo = Database::sqlite(DB_FILENAME);
```

with:

```php
$pdo = Database::mysql(
    DB_HOST,
    DB_NAME,
    DB_USER,
    DB_PASSWORD
);
```

4. Update the connection details in your configuration.
5. Refresh the application.

---

# Troubleshooting

## `PDOException: could not find driver`

The SQLite PDO extension is not enabled.

Check:

```bash
php -m
```

If `pdo_sqlite` or `sqlite3` are missing:

1. Open your `php.ini`.
2. Enable:

```ini
extension=pdo_sqlite
extension=sqlite3
```

3. Restart PHP or Laragon.

---

## `SQLSTATE[HY000]: no such table: contacts` (SQLite)

The SQLite database exists, but the migration has not been applied.

Delete:

```
database/contact_list_db.sqlite
```

Refresh the application.

A new database will be created automatically and the migration will run.

---

## `SQLSTATE[42S02]: Table 'contacts' doesn't exist` (MariaDB)

The database connection is working, but the MariaDB migration has not been run.

Run:

```bash
mysql -u contact_list_user -p contact_list_database < database/migrations/001_create_contacts.sql
```

Then refresh the application.

---

## Blank Page or Other Errors

Enable PHP error reporting while developing.

In `php.ini`:

```ini
display_errors = On
error_reporting = E_ALL
```

or temporarily add to the top of `public/index.php`:

```php
ini_set('display_errors', 1);
error_reporting(E_ALL);
```

---

## Project Structure

```
public/
    index.php

src/
    Database.php
    ContactRepository.php

database/
    contact_list_db.sqlite
    migrations/
        001_create_contacts.sql
```
