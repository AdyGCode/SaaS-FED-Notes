# Connecting DB to Web with "pure" PHP

## Contacts Demo (Session 01)

- Run: `php -S 127.0.0.1:8080 -t public`
- Open: http://127.0.0.1:8080/?action=list
-

- Default DB: `contacts.sqlite` (created automatically)
- Switch to MariaDB:
  - edit `public/index.php` 
  - and `Database::mysql(...)`.

