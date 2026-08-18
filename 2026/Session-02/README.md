# Laravel Development Environment Setup

This guide explains how to set up the Laravel development environment used throughout this course.

> **Important**
>
> All students are expected to use the standard NMTAFE development environment to ensure demonstrations, practical activities and assessments are consistent.

---

# Software Requirements

Install the following software before attending Session 1.

| Software | Version |
|-----------|----------|
| Laragon | Latest |
| PHP | 8.3 or newer |
| Composer | Latest |
| Node.js (LTS) | Latest LTS |
| npm | Installed with Node.js |
| Git | Latest |
| Visual Studio Code | Latest |
| Google Chrome or Microsoft Edge | Latest |

---

# Recommended Folder Structure

All course work should be stored inside the Laragon **www** directory.

Example:

```text
C:\ProgramData\Laragon\www\
    Sources\
        Repos\
            contact-list
```

Do **not** store projects inside:

- Desktop
- Downloads
- OneDrive
- USB drives

---

# Verify Your Installation

Open **Git Bash** from Laragon.

Run the following commands.

```bash
php --version
```

```bash
composer --version
```

```bash
node --version
```

```bash
npm --version
```

```bash
git --version
```

Expected result:

Each command should display a version number without any errors.

---

# Clone the Repository

Navigate to your repositories folder.

```bash
cd /c/ProgramData/Laragon/www/Sources/Repos
```

Clone the course repository.

```bash
git clone <repository-url>

# If creating composer
create-project --prefer-dist laravel/laravel my-app
```

Move into the project.

```bash
cd contact-list
```

Replace `<repository-url>` with the repository URL provided by your lecturer.

---

# Install PHP Dependencies

Install the Laravel packages.

```bash
composer install
```

This downloads all PHP dependencies listed in `composer.json`.

---

# Install JavaScript Dependencies

Install the frontend packages.

```bash
npm install
```

---

# Create the Environment File

Copy the example environment file.

```bash
cp .env.example .env
```

If using Command Prompt:

```cmd
copy .env.example .env
```

---

# Generate the Application Key

Run:

```bash
php artisan key:generate
```

Expected output:

```text
Application key set successfully.
```

---

# Configure the Database

Open:

```text
.env
```

Update the database settings.

Example:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=contact_list
DB_USERNAME=root
DB_PASSWORD=
```

> Your lecturer may provide different settings for a particular class or assessment.

---

# Create the Database

Open **HeidiSQL** (included with Laragon).

Create a new database.

Example:

```text
contact_list
```

Do not create any tables manually.

Laravel will create them using migrations.

---

# Run Database Migrations

Execute:

```bash
php artisan migrate
```

Laravel will build the database structure automatically.

---

# Seed Sample Data (Optional)

If seeders are included in the project:

```bash
php artisan db:seed
```

or

```bash
php artisan migrate:fresh --seed
```

---

# Build Frontend Assets

Start the Vite development server.

```bash
npm run dev
```

Leave this terminal running while developing.

---

# Start Laravel

Open a second terminal.

Run:

```bash
php artisan serve
```

Expected output:

```text
http://127.0.0.1:8000
```

Open the URL in your browser.

> **Note:** If you are using Laragon's virtual hosts (recommended), you can access the project using its local domain (for example, `http://contact-list.test`) instead of `http://127.0.0.1:8000`.

---

# Running Both Servers

During development you normally have two terminals open.

Terminal 1

```bash
npm run dev
```

Terminal 2

```bash
php artisan serve
```

---

# Useful Artisan Commands

Display all routes.

```bash
php artisan route:list
```

Clear application caches.

```bash
php artisan optimize:clear
```

Create a controller.

```bash
php artisan make:controller ContactController
```

Create a model with migration.

```bash
php artisan make:model Contact -m
```

Run the test suite.

```bash
php artisan test
```

List available Artisan commands.

```bash
php artisan
```

---

# Updating Dependencies

Update PHP packages.

```bash
composer update
```

Update JavaScript packages.

```bash
npm update
```

---

# Git Workflow

Check project status.

```bash
git status
```

Stage changes.

```bash
git add .
```

Commit changes.

```bash
git commit -m "Describe your changes"
```

Push to GitHub.

```bash
git push
```

Commit your work regularly.

---

# Common Problems

## PHP Not Found

```text
php: command not found
```

Solution:

- Start Git Bash from Laragon.
- Confirm PHP has been added to your PATH.

---

## Composer Not Found

```text
composer: command not found
```

Solution:

- Verify Composer is installed.
- Restart your terminal.
- Confirm Composer is on your PATH.

---

## npm Not Found

```text
npm: command not found
```

Solution:

- Install the Node.js LTS version.
- Restart your terminal.

---

## Vite Not Starting

Run:

```bash
npm install
```

Then:

```bash
npm run dev
```

---

## Database Connection Error

Check:

- Laragon is running.
- MySQL is started.
- Database exists.
- `.env` values are correct.

---

## Application Key Missing

Run:

```bash
php artisan key:generate
```

---

## Route Not Found

Check:

```bash
php artisan route:list
```

Verify your route exists.

---

# Development Checklist

Before each class, confirm:

- [ ] Laragon is running.
- [ ] MySQL is started.
- [ ] Project opens in VS Code.
- [ ] `composer install` completed.
- [ ] `npm install` completed.
- [ ] `.env` configured.
- [ ] Database migrated.
- [ ] `npm run dev` running.
- [ ] Laravel application loads successfully.

---

# Course Conventions

Throughout this course:

- Use **Git** for version control.
- Commit work regularly.
- Use **Artisan** to generate Laravel components.
- Do not manually edit files generated by Composer.
- Keep project files inside the Laragon `www` directory.
- Follow the folder structure and naming conventions demonstrated by your lecturer.

Following these conventions will ensure that demonstrations, practical activities and assessments work consistently across all lab computers.
