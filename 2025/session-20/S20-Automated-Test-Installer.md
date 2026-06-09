---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags:
  - SaaS
  - APIs
  - Back-End
date created: 03 July 2024
created: 2024-09-20T11:17
updated: 2025-07-22T16:25
---

# S20 Automated Test Installer

## Software as a Service - Front-End Development

Developed by Adrian Gould

---

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

---

# What is this "Automated Test Installer"?

The script is used to rebuild the dependencies and database of your Laravel Application.

The script asks you to select the DB backend (SQLite, MySQL/MariaDB, PostGreSQL) for the installation test.

> **Important** currently only MySQL/MariaDB available

Once it has done this, it then completes these steps:

1) Removes existing `node_modules` and `vendor` directories...
2) Removes existing `database/database.sqlite`
3) Copies `.env.dev` to `.env`
4) Modifies .env file for database configuration
5) Creates database:
   - MySQL/MariaDB uses folder name for the database, root for the user and no password
   - PostGreSQL version to come
   - SQLite creates new database at database/database.sqlite
6) Runs `composer install`
7) Runs `composer update`
8) Runs `npm install`
9) Runs `npm run build`
10) Runs Laravel migrations and seeding `php artisan migrate:fresh --seed`
11) Runs `php artisan queue:watch` to watch the event queues (eg mail)


