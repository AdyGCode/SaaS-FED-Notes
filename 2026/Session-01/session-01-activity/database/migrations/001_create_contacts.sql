-- Session 01: SQLite schema and seed data

CREATE TABLE IF NOT EXISTS contacts (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL,
    phone      TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

INSERT INTO contacts (name, email, phone)
VALUES ("Jacques d'Carre", 'jacques@example.com', '+61-8-0000-0000');

INSERT INTO contacts (name, email, phone)
VALUES ('Crystal Chantel-Leer', 'crystal@example.com', '+61-4-0000-0001');

INSERT INTO contacts (name, email, phone)
VALUES ('Robyn Banks', 'robyn@example.com', '+61-2-0000-0002');
