-- SQLite schema (default)
CREATE TABLE IF NOT EXISTS contacts
(
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL,
    phone      TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

-- MariaDB / MySQL alternative:
-- CREATE TABLE contacts (
--   id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
--   name VARCHAR(120) NOT NULL,
--   email VARCHAR(190) NOT NULL,
--   phone VARCHAR(40) NULL,
--   created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO CONTACTS(    name,     email,     phone)
VALUES ("Jacques d'Carre", "jacques@example.com", "+61-8-0000-0000");

INSERT INTO CONTACTS(    name,     email,     phone)
values ("Crystal Chantel-Leer", "crystal@example.com", "+61-4-0000-0001");

INSERT INTO CONTACTS(    name,     email,     phone)
VALUES ("Robyn Banks", "robyn@example.com", "+61-2-0000-0002");
