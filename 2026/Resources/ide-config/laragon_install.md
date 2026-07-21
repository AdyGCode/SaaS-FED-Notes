# Laravel Installation Guide (Windows + Git Bash + Laragon)

This guide installs a fresh Laravel project using **Git Bash** on Windows with **Laragon**.

---

# Prerequisites

Ensure the following are installed:

- Laragon (PHP, MySQL, Composer)
- Git for Windows
- Node.js (LTS)
- Visual Studio Code (recommended)

Verify the installations:

```bash
php -v
composer -V
node -v
npm -v
git --version
```

---

# 1. Start Laragon

Open **Laragon** and click:

```
Start All
```

Confirm the following services are running:

- Apache or Nginx
- MySQL

---

# 2. Open Git Bash

Navigate to your web directory.

Example:

```bash
cd /c/ProgramData/Laragon/www
```

---

# 3. Create a New Laravel Project

Replace `my-project` with your project name.

```bash
composer create-project laravel/laravel my-project
```

Example:

```bash
composer create-project laravel/laravel student-management
```

---

# 4. Enter the Project

```bash
cd my-project
```

Example:

```bash
cd student-management
```

---

# 5. Install JavaScript Dependencies

```bash
npm install
```

---

# 6. Build Vite Assets

Development build:

```bash
npm run dev
```

Leave this terminal running while developing.

Alternatively build once:

```bash
npm run build
```

---

# 7. Create the Environment File (if required)

Laravel normally creates this automatically.

If it doesn't:

```bash
cp .env.example .env
```

---

# 8. Generate the Application Key

```bash
php artisan key:generate
```

---

# 9. Create a Database

Open Laragon.

Go to:

```
Menu
→ MySQL
→ HeidiSQL
```

Create a new database.

Example:

```
student_management
```

---

# 10. Configure the Database

Open:

```
.env
```

Update:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=student_management
DB_USERNAME=root
DB_PASSWORD=
```

Laragon's default MySQL password is blank.

---

# 11. Run Database Migrations

```bash
php artisan migrate
```

Expected output:

```
Migrating...

DONE
```

---

# 12. Install Authentication (Optional)

Laravel provides starter kits.

Example using Breeze:

```bash
composer require laravel/breeze --dev
```

Install:

```bash
php artisan breeze:install
```

Rebuild assets:

```bash
npm install
npm run dev
```

Run migrations:

```bash
php artisan migrate
```

---

# 13. Start the Laravel Development Server

```bash
php artisan serve
```

Open:

```
http://127.0.0.1:8000
```

---

# 14. Alternatively Use Laragon Virtual Hosts

If the project is inside:

```
C:\ProgramData\Laragon\www\
```

Laragon automatically creates a virtual host.

Access the project at:

```
http://my-project.test
```

Example:

```
http://student-management.test
```

No need to run `php artisan serve` when using Laragon's virtual host.

---

# 15. Useful Artisan Commands

Clear cache:

```bash
php artisan optimize:clear
```

Run migrations:

```bash
php artisan migrate
```

Rollback last migration:

```bash
php artisan migrate:rollback
```

Fresh database:

```bash
php artisan migrate:fresh
```

Fresh database with seeders:

```bash
php artisan migrate:fresh --seed
```

List all routes:

```bash
php artisan route:list
```

List Artisan commands:

```bash
php artisan list
```

---

# 16. Useful NPM Commands

Development server:

```bash
npm run dev
```

Production build:

```bash
npm run build
```

---

# 17. Typical Git Bash Workflow

Open project:

```bash
cd /c/ProgramData/Laragon/www/student-management
```

Start Vite:

```bash
npm run dev
```

(Optional) Start Laravel server:

```bash
php artisan serve
```

If using Laragon virtual hosts, only `npm run dev` is typically required.

---

# 18. Updating Composer Dependencies

```bash
composer update
```

Install dependencies from an existing project:

```bash
composer install
```

---

# 19. Updating NPM Dependencies

Install packages:

```bash
npm install
```

Update packages:

```bash
npm update
```

---

# 20. Common Troubleshooting

## Missing Application Key

```bash
php artisan key:generate
```

---

## Database Connection Error

Check:

- MySQL is running.
- Database exists.
- `.env` settings are correct.

---

## Clear All Laravel Caches

```bash
php artisan optimize:clear
```

---

## Vite Manifest Not Found

Run:

```bash
npm install
npm run dev
```

or

```bash
npm run build
```

---

## Permission Issues

Reinstall dependencies:

```bash
composer install
npm install
```

---

# Recommended Folder Structure

```
C:\ProgramData\Laragon\www\
│
├── student-management
├── inventory-system
├── blog
└── api-demo
```

Git Bash equivalent:

```bash
cd /c/ProgramData/Laragon/www
```

---

# Quick Start Summary

```bash
cd /c/ProgramData/Laragon/www

composer create-project laravel/laravel student-management

cd student-management

npm install

cp .env.example .env

php artisan key:generate

php artisan migrate

npm run dev
```

Open the application in your browser:

- **Laragon Virtual Host:** `http://student-management.test`
- **Laravel Development Server:** `http://127.0.0.1:8000`
