---
theme: nmt
background: https://cover.sli.dev
title: Session 04 - Starting Laravel - 1
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 04: Starting Laravel

## SaaS 1 – Cloud Application Development (Front-End Dev)

### Creating our first Laravel App

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

# Objectives

---
layout: two-cols
level: 2
class: text-left
---

# Objectives

::left::

- Identify the tools needed to install Laravel and recognize how to start a
  new Laravel project. (Remember / Understand)

- Describe the main folders in a Laravel project and explain what each is
  used for. (Understand)

- Explain how the MVC (Model–View–Controller) pattern works in Laravel. (
  Understand)

- Create simple Blade views and use Blade syntax safely (e.g., escaped
  output). (Apply)

::right::

- Use built‑in Blade components and apply props, slots, and attributes in
  your own views. (Apply)

- Compare `@extends` layouts with `<x-component>` layouts and decide when
  each approach fits best. (Analyze)

- Apply Tailwind CSS classes within Blade to style a page. (Apply)

- Build a simple “Contact Us” page that accepts form data and shows a
  success message. (Create)

<!--

Install and configure the Laravel Installer and understand alternative installation methods using Composer.
Create a new Laravel 12 project and run both the PHP development server and Vite asset server.
Identify and explain the Laravel folder structure, including the purpose of key directories such as app/, routes/, resources/, public/, and storage/.
Describe the Model–View–Controller (MVC) architecture and how Laravel implements this pattern in web applications.
Create and work with Blade view templates, including passing data from routes/controllers to views.
Apply Blade syntax, including escaped vs. unescaped output, directives, control structures, and best practices for secure template rendering.
Use built-in Blade components and understand how props, slots, and attribute merging work.
Understand template inheritance using both `@extends`/`@section`/`@yield` and component-based (`<x-layout>`, `<x-component>`) approaches.
Explain the differences between @extends layouts and `<x-component>` layouts, including when and why to use each.
Integrate Tailwind CSS with Blade using Vite, and apply Tailwind utility classes effectively within Blade templates.
Build a simple “Contact Us” page, including routing, form construction, validation, and handling POST requests without persistence.
Check understanding through targeted knowledge questions covering installation, folder structure, MVC, Blade, and template inheritance.

-->
---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
class: text-left
---

# Laravel 12 + Blade + Tailwind - An Introduction

<br>

## From Zero to “Contact Us”

<br>

### *Platform:* Laravel 12 (MVC), Blade templating, Tailwind CSS

### *Goal:* Understand the workflow and build a small feature end‑to‑end

<!-- Speaker notes:
Welcome! This deck walks through installing Laravel, spinning up a project,
understanding folder structure, MVC concepts, Blade fundamentals, components,
template inheritance, and how Tailwind ties in. 

We'll also build a quick “Contact Us” page without persisting to a 
database, and finish with knowledge checks, references, a session checklist, and exit tickets.
-->

---
layout: section
---

# Installing the Laravel Installer

<!--
Section: Installing Laravel & creating a project. Focus on the Laravel installer,
Composer, PATH setup, and alternatives. We'll run “Hello, Laravel” locally.
-->

---
level: 2
---

# Installing the Laravel Installer

## 0) Prerequisites

- PHP 5.4+ (compatible with Laravel 12)
- Composer (global)
- Node.js plus:
    - npm (for Vite/Tailwind)
    - pnpm (and Vite/Tailwind)

---
level: 2
---

# Installing the Laravel Installer (2)

## 1) Ensure Composer in your Path

<Announcement type="important" title="Laravel & Laragon">
<p>Remember that with Laragon, before opening your terminal, you will:</p>
<ul>
<li>Tools->Path->Remove Path, and then</li> 
<li>Tools->Path->Add Path</li>
</ul>
</Announcement>


You may also verify alternative locations:

- **Windows:** `%USERPROFILE%\AppData\Roaming\Composer\vendor\bin`
- **macOS/Linux (bash/zsh):** `~/.composer/vendor/bin` or
  `~/.config/composer/vendor/bin`

---
level: 2
---

# Installing the Laravel Installer (3)

## 2) Install the Laravel Installer (global)

```bash
composer global require laravel/installer
```

You may re-run this every two or three weeks.

This updates the installer with
the latest bug and security fixes and new features.

## 3) Verify installed and accessible

```bash
laravel --version
```

<!-- Speaker notes:
- If “laravel” isn’t found, the global Composer bin directory isn’t on PATH.
- macOS/Linux can add: export PATH="$HOME/.composer/vendor/bin:$PATH"
  (or ~/.config/composer/vendor/bin depending on Composer version).
- Alternatively, skip the installer and use composer create-project (next slide).
-->


---
layout: section
---

# Creating a New Laravel Project

<!-- Speaker notes:
- Option A is often faster and gives a clean scaffold.
- Option B is great for CI or when the installer isn’t available.
- Option C for when you use an Application Template
-->

---
level: 2
---

# Creating a New Project

## Option A: Using the Laravel Installer

To create a new application using

- the Laravel installer,
- `pnpm` for TailwindCSS etc. and
- initialising a git repository...

```bash
laravel new <MY_APPLICATION_NAME> --pnpm --git
```

---
level: 2
---

# Creating a New Project (2)

## Option B: Using Composer Directly

Creates a basic application with no extras

```bash
composer create-project laravel/laravel <MY_APPLICATION_NAME>
```

---
level: 2
---

# Creating a New Project (3)

## Option C: Using the Laravel Installer & Template

```bash
laravel new <MY_APPLICATION_NAME> --using=<TEMPLATE_NAME> --pnpm --git
```

<Announcement type="information" title="Templates">
<p>We will make use of a template later in the semster.</p>
<p>The template code will be provided by Adrian Gould.</p>
</Announcement>

---
level: 2
---

# Creating a New Project (4)

## Options commonly used when prompted

These are for Option A and C:

| Prompt                                                                                   | **Respond With** |
|------------------------------------------------------------------------------------------|------------------|
| Which starter kit would you like to install? **\[None]**:                                | **None**         |
| Which testing framework do you prefer? **\[Pest]**:                                      | **0** (Pest)     |
| Do you want to install Laravel Boost to improve AI assisted coding? (yes/no) **\[yes]**: | **No**           |
| Which database will your application use? **\[SQLite]**:                                 | **sqlite**       |

---
level: 2
---

# Creating a New Project (5)

## Running the Development Server

```bash
cd <MY_APPLICATION_NAME>
composer run dev
```

Open: http://127.0.0.1:8000

### Dev Server

`composer run dev` executes a node script to run multiple processes in
parallel for development.

- The PHP Web Server
- The Laravel Queue manager
- The Vite watcher

---
layout: section
---

# Clone & Set-up Existing Project

#### Steps to set up an existing remote repository for development locally

---
level: 2
layout: two-cols
---

# Clone & Set-up Existing Project

<br>
When you want to work on a project at a different location/computer, do
the following:

::left::

- Clone the repository
    - `git clone <REPOSITORY_URI>`
- Change directory into repository folder
    - `cd <FOLDER_NAME>`
- Execute `composer install`
- Execute `pnpm install`
- Copy the example `.env` file:
    - `cp .env.example .env`

::right::

- Generate a key
    - `php artisan key:generate`
- Create empty SQLite file if in development:
    - `touch database/database.sqlite`
- Update the `.env`
- Migrate the database
    - `php artisan migrate`
- Seed the database
    - `php artisan db:seed`

---
level: 2
---

# .env Settings to Update

| KEY          | Example Setting                                           |
|--------------|-----------------------------------------------------------|
| `APP_NAME`   | `"Contactive"`                                            |
| `APP_ENV`    | `local` (dev), `production`, `staging`, `testing`         |
| `APP_DEBUG`  | `true` (dev), `false` (production)                        |
| `APP_URL`    | `http://localhost:8000` (dev), `https://my-domain.com.au` |
| `APP_LOCALE` | `en_AU`                                                   |

---
level: 2
---

# .env Settings to Update (2)

| KEY          | Example Setting        |
|---------------------|------------------------|
| `MAIL_MAILER`       | `smtp`                 |
| `MAIL_HOST`         | `127.0.0.1`            |
| `MAIL_PORT`         | `2525`                 |
| `MAIL_FROM_ADDRESS` | `no-reply@example.com` |

Others updated depending on requirements


---
layout: section
---

# Laravel Folder Structure

<!-- Speaker notes:
Section: Laravel folder structure. Focus on the high-signal directories and what
lives inside them for everyday development.
-->

---
level: 2
---

## Folder Structure (The Greatest Hits)

- `app/` — Your application code
- `bootstrap/` — Framework bootstrapping (cache, autoload)
- `config/` — Config files (`app.php`, `database.php`, `mail.php`, …)
- `database/` — Migrations, factories, seeders
- `public/` — Web root (index.php, assets entry point)
- `resources/` — Views (Blade), CSS/JS (pre-Vite build), lang
- `routes/` — `web.php`, `api.php`, `console.php`, `channels.php`
- `storage/` — Logs, compiled views, file uploads
- `tests/` — Unit/Feature tests
- `vendor/` — Composer dependencies (**don’t edit**)
- `node_modules/` — Node.js dependencies (**don’t edit**)

You’ll mostly live in `app/`, `resources/`, and `routes/`.

<!-- Speaker notes:
- Emphasize that public/ is the document root for production web servers.
- storage/logs/laravel.log is the first stop for debugging unexpected errors.
-->

---
layout: section
---

# MVC Concepts

## Model - View - Controller

<!-- Speaker notes:
Section: MVC concepts. Define the three roles, data flow, and how routes fit in.
Keep the mental model clear and practical.
-->

---
level: 2
---

## MVC Overview: Model–View–Controller

## Model

- Business logic & data representation (often Eloquent models)

## View

- Presentation layer (Blade templates)

## Controller

- Coordinates the request, invokes domain logic, returns responses

---
level: 2
---

# MVC Overview: Model–View–Controller (2)

## Router

- Directs the incoming requests to the correct controller and method

## Flow
Browser → Route → Controller → (Model/services) → View (HTML) → Browser

<Announcement type="information">
<p>Routes map URLs to controllers.</p>
<p>Controllers prepare data (via Models).</p>
<p>Views present the data.</p>
</Announcement>

<!-- Speaker notes:
- Keep controllers skinny: orchestrate, don’t implement heavy business logic.
- Views should contain as little logic as possible; use Blade directives sparingly.
-->


---
layout: image
imageUrl: public/Laravel-Page-Request-Simplified@2x.png
imageCaption: Laravel Simplified Page Request
---

---
layout: section
---

# Creating Blade Views

<!-- Speaker notes:
Section: Blade basics—creating views, syntax, escaping, and common directives.
Include simple code examples, data passing, and escaping safeguards.
-->

---
level: 2
---

# Creating Blade Views

## Route → View

From the `routes/web.php` file:

```php [php] {1|3,5|all}
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome', ['name' => 'Adrian']);
});
```
OK for simple views.

Use controllers for maintainability and more complex logic.

---
level: 2
---

# Creating Blade Views (2)

## View (`resources/views/welcome.blade.php`)

```blade [blade] {1-3,6-7,9-10|all}
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Welcome</title>
</head>
<body class="font-sans antialiased">
  <h1 class="text-2xl">Hello, {{ $name }}!</h1>
</body>
</html>
```

---
level: 2
---

# Creating Blade Views (3)

## Passing Data

- Array: `view('welcome', ['name' => 'Adrian'])`
- `with()`: `view('welcome')->with('name', 'Adrian')`

<!-- Speaker notes:
- Blade files end with .blade.php.
- Keep view files in resources/views. Nested folders use dot notation:
  views/home/index.blade.php → view('home.index').
-->

---
layout: section
---

# Blade Syntax & Escaping

---
level: 2
---

# Blade Syntax & Escaping

## Echoing Variables

###  Escaped (safe) 
```blade [blade] {none|all}
{{ $title }}
```

###  Unescaped (trust only sanitized content) 
```blade [blade] {none|all}
{!! $html !!}
```

###  Output literal (e.g., for Vue) 
```blade [blade] {none|all}
@{{ user }}            
```

---
level: 2
---

# Blade Syntax & Escaping (2)

## Control Structures

```blade [blade] {1,7|1,3,5,7|all}
@if($count > 0)
  <p>Items: {{ $count }}</p>
@elseif($count === 0)
  <p>No items</p>
@else
  <p>Unknown</p>
@endif
```


---
level: 2
---

# Blade Syntax & Escaping (3)

## Control Structures (2)

```blade [blade] {1,3|all}
@foreach($items as $item)
  <li>{{ $item->name }}</li>
@endforeach
```

### Raw Blocks

```blade [blade] {none|all}
@verbatim
  <div id="app">{{ message }}</div>
@endverbatim
```

> Prefer `{{ }}` for safety.
> 
> Use `{!! !!}` only for trusted HTML.

<!-- Speaker notes:
- Emphasize XSS protection via HTML escaping.
- @csrf and @method are helpers for forms—cover during the mini build.
-->

---
level: 2
---

## Blade Goodies to Know (Quick Hits)

- `@csrf` and `@method('PUT')` inside forms
- `@include('partials.alert')` to pull partial templates
- `@once ... @endonce` to ensure a block renders once
- `@push('scripts')/@stack('scripts')` for stacked sections

- Attribute/State directives:
  ```blade [blade] {1|2|3|4|all}
  <input type="checkbox" @checked($active)>
  <option @selected($id === $current)>
  <button @disabled($busy)>
  <div @class(['p-4', 'bg-green-100' => $ok, 'bg-red-100' => !$ok])></div>
  ```

<!-- Speaker notes:
- @class is perfect for conditional Tailwind classes.
- @push/@stack helps when children need to append to layout-defined areas (e.g., scripts).
-->

---
layout: section
---

# Templates & Inheritance

<!-- Speaker notes:
Section: Components & template inheritance. Show @extends/@section flow and the
component-driven (x-) layout approach with slots and class merging. Then compare them.
-->

---
level: 2
---

# Template Inheritance

- `@extends`
- `@section`
- `@yield`


---
level: 2
---

# Template Inheritance (2)

## Layout `resources/views/layouts/app.blade.php` 

```blade {1-3,7,8,15-16|4|5|6|1-8,15-16|8,15|9-11|12-14|all}
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>@yield('title', 'My App')</title>
  @vite(['resources/css/app.css','resources/js/app.js'])
</head>
<body class="min-h-dvh bg-gray-50 text-gray-900">
  <header class="p-4 border-b">
    My App
  </header>
  <main class="p-6">
    @yield('content')
  </main>
</body>
</html>
```

---
level: 2
---

# Template Inheritance
## Child View using Template

### View (`resources/views/static/home.blade.php`)

```blade [blade] {1|3|5,7|all}
@extends('layouts.app')

@section('title', 'Home')

@section('content')
  <h1 class="text-2xl font-semibold">Welcome Home</h1>
@endsection
```

<!-- Speaker notes:
- @yield defines placeholders; @section fills them in child views.
- You can use @section('title', '...') shorthand for single-line sections.
-->

---
level: 2
---

# Components: `<x-…>` + Slots + Class Merging

## Layout as a Component

Component file: `resources/views/components/layout.blade.php`

```blade {1|3-6|7|8-9|10,15|11|12-14|15-16|all}
@props(['title' => 'My App'])

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>{{ $title }}</title>
  @vite(['resources/css/app.css','resources/js/app.js'])
</head>
<body class="min-h-dvh bg-gray-50 text-gray-900">
  <header class="p-4 border-b">{{ $title }}</header>
  <main class="p-6">
    {{ $slot }}
  </main>
</body>
</html>
```
---
level: 2
---


# Components: `<x-…>` + Slots + Class Merging (2)

## Using the Component

View File: `resources/views/dashboard.blade.php` 

```blade {1,3|2|all}
<x-layout title="Dashboard">
  <h1 class="text-2xl font-semibold">Hello from the component layout</h1>
</x-layout>
```
---
level: 2
---

# Components: `<x-…>` + Slots + Class Merging (3)

## Reusable Button (with Tailwind Class Merge)
 
Component Filename: `resources/views/components/button.blade.php` 

```blade {1|2,7,9|3-6|7-9|all}
@props(['type' => 'button'])
<button type="{{ $type }}"
  {{ $attributes->merge(['class' =>
    'inline-flex items-center rounded-md px-4 py-2 text-sm font-medium
     bg-indigo-600 text-white hover:bg-indigo-700 focus:outline-none focus:ring'
  ]) }}
>
  {{ $slot }}
</button>
```

## Use it

```blade {none|all}
<x-button type="submit" class="mt-3">Save</x-button>
```

<!-- Speaker notes:
- $attributes->merge(['class' => '...']) merges caller classes with defaults—great for Tailwind.
- Anonymous components live in resources/views/components. Named slots: <x-slot:name>.
-->


---
layout: section
---

# `@extends` vs `<x-component>`

## When & Why

---
level: 2
---

# `@extends` vs `<x-component>` — When & Why

<br>

## `@extends` Layouts

- Ideal for **page-level layout inheritance** (e.g., master layout with
  `@yield` regions)
- Familiar HTML flow; sections filled by child views via `@section`
- Great for **global structure** (head, nav, footer) with per-page content
- Simple mental model; less moving parts

---
level: 2
---

# `@extends` vs `<x-component>` — When & Why (2)

<br>

## `<x-…>` Components

- Ideal for **reusable UI pieces** and **layout-as-component** patterns
- Support **props**, **slots**, and `$attributes->merge()` (excellent for
  Tailwind class composition)
- Encourages **encapsulation** and **composition** (nestable, testable,
  discoverable)
- Can live as **anonymous** (Blade-only) or **class-based** components

---
level: 2
---

# `@extends` vs `<x-component>` — When & Why

<br>

## Choosing Between Them

- Use `@extends` for a site-wide base layout with named sections
- Use **components** for reusable widgets (buttons, cards, alerts) **and**
  when you prefer composition over inheritance for layouts
- It’s common to **mix both**: `@extends` for the outer shell + `<x-*>` for
  inner UI patterns

<!-- Speaker notes:
- Both compile to efficient PHP; choice is about ergonomics and reuse.
- Teams often start with @extends and gradually extract components as patterns repeat.
-->

---
layout: section
---


# How Tailwind Fits With Blade

<!-- Speaker notes:
Section: Tailwind + Blade. Show where Tailwind is configured, how Vite compiles it,
and how Blade makes Tailwind ergonomic via directives and components.
-->

---
level: 2
---

# How Tailwind Fits With Blade

## Tailwind in Your Project: CSS

Filename: `resources/css/app.css`

````md magic-move
```css [css] {none|all}
/* Import TailwindCSS v4 (or later) */
@import 'tailwindcss';
...
```
```css
...
/* Tell Vite to search following folders for Tailwind 
   class usage to purge unused styles */
@source '../../vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php';
@source '../../storage/framework/views/*.php';
@source '../**/*.blade.php';
@source '../**/*.js';
...
```
```css
...
/* Specify any custom CSS for Tailwind.
   Here we define the Instrument Sans font as 
   our default for sans-serif text */
@theme {
    --font-sans: 'Instrument Sans', ui-sans-serif, system-ui, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji',
        'Segoe UI Symbol', 'Noto Color Emoji';
}
```

````
Full Code:
- https://github.com/AdyGCode/contact-list-2026-s1/blob/main/resources/css/app.css

---
level: 2
---

# How Tailwind Fits With Blade (2)

## Tailwind in Your Project: Vite

Filename: `/vite.config.js`


````md magic-move

```js [js] {1-3|5,7|all}
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    ...
});

```

```js [js] {2,11|3,9|4-7|8|all}
...
export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        tailwindcss(),
    ],
    ...
});
```

```js [js] {2,9|4,8|5-7|all}
...
export default defineConfig({
...
    server: {
        watch: {
            ignored: ['**/storage/framework/views/**'],
        },
    },
});
```

````

Full Code:
- https://github.com/AdyGCode/contact-list-2026-s1/blob/main/vite.config.js

---
level: 2
---

# How Tailwind Fits With Blade

## Tailwind in Your Project: In Blade Layout

```blade
@vite(['resources/css/app.css','resources/js/app.js'])
```

This instructs Vite to hot reload the CSS and JS files during development.

---
level: 2
---

# How Tailwind Fits With Blade

## Tailwind in Your Project: Ergonomics in Blade

- Conditional Tailwind classes
  - `@class([...])` 
- Components encapsulate Tailwind patterns with:
  -   `$attributes->merge(['class' => '...'])`

<!-- Speaker notes:
- Starter kits (e.g., Breeze/Jetstream) ship with Tailwind + Vite pre-configured.
- Keep tailwind.config.js content globs up to date to avoid purge issues.
-->

---
layout: section
---

# Contact List Application

<br>

## Building a simple Contact-List Application 

### Using Laravel, Blade, and Tailwind.

#### Stage 1: Static Page - Contact Us

<!-- Speaker notes:
Section: Mini build—the “Contact Us” page. We’ll create routes, a controller, a
view with a Tailwind form, validate input, and show a success message—no database.
-->

---
level: 2
---

# Building a Contact-List App

## Static Pages - Contact Us

Create each part of this page in turn:

- Controller with stubs
- Routes to the controller
- Blade view with Tailwind form

---
level: 2
---

# Building a Contact-List App

## Static Pages - Contact Us - Controller With Stubs

To create a controller with stubs for the contact form:

```bash
php artisan make:controller ContactController --resource --only=index,show
```

We will rename the show to `thankyou` later.

---
level: 2
---

# Building a Contact-List App (2)

## Static Pages - Contact Us - Routes 

Filename: `routes/web.php`

```php [php] {none|1-2|4-5|6-7|all}
use App\Http\Controllers\StaticPages\ContactController;
use Illuminate\Support\Facades\Route;

Route::get('/contact-us', [ContactUsController::class, 'index'])
  ->name('static.contact-us');
Route::get('/thank-you', [ContactUsController::class, 'thankyou'])
  ->name('static.thank-you');
```
---
level: 2
---

# Building a Contact-List App (3)

## Static Pages - Contact Us - Controller

Filename: `app/Http/Controllers/ContactController.php`

```php {none|1,3|5-6,16|7-10|12-15|all}
namespace App\Http\Controllers\StaticPages;

use Illuminate\Http\Request;

class ContactUsController extends Controller
{
    public function index()
    {
        return view('static-pages.index');
    }

    public function thankyou()
    {
        return view('static-pages.thank-you');
    }
}
```

<!-- Speaker notes:
- We explicitly validate and then do nothing with the data (no DB).
- Using back()->with() flashes a success message for UX.
-->
---
level: 2
---

# Building a Contact-List App (4)

## Static Pages - Contact Us - Contact Us Page

### Create a folder

Create the `static-pages` folder for the views:

```bash
mkdir -p resources/views/static-pages
```

### Creating multiple folders a once

```bash
mkdir -p resources/views/{static-pages,client,admin}
```

Creates three subfolders, `static-pages`, `client` and `admin` within the 
`resources/views` folder.

---
level: 2
---

# Building a Contact-List App (5)

## Static Pages - Contact Us - Contact Us Page

Filename: `/resources/views/static-pages/index.blade.php`

We are not using a layout... yet.

````md magic-move

```blade [blade] {none|1-2,3,8-9,11-12|1-3,5,8-9,11-13|3-11|all}
<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <!-- more head content here -->
    <title>Contact Us | {{ config('app.name', 'Laravel') }}</title>
    <!-- Fonts -->
    <!-- Styles / Scripts -->
</head>
<body>
<!-- body content to go here -->
</body>
</html>
```

```blade [blade] {1-3,8-13|4-7|all}
<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Contact Us | {{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <!-- Styles / Scripts -->
</head>
```

```blade [blade] {1-3|4|5-6|all}
    <title>Contact Us | {{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net"/>
    <link href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600"
          rel="stylesheet"/>
```

```blade [blade] {1-4|5|5-9|all}
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net"/>
    <link href="https://fonts.bunny.net/css?family=instrument-sans:400,500,600"
          rel="stylesheet"/>
    <!-- Styles / Scripts -->
    @vite([
        'resources/css/app.css',
        'resources/js/app.js'
    ])
</head>
```

```blade [blade] {1|1-2,12-13|4-6|8-11|all}
</head>
<body>

<h1 class="text-4xl text-blue-500">
    Contact Us
</h1>

<a href="{{ route('static.thank-you') }}"
   class="text-xl p-1 bg-blue-100">
    Thank You Test Link
</a>
</body>
</html>
```

````

---
level: 2
---

# Building a Contact-List App (6)

## Static Pages - Contact Us - Thank You Page

Filename: `/resources/views/static-pages/thank-you.blade.php`

We are not using a layout... yet.

- Copy the contact-us page
- Rename to `thank-you.blade.php`
- Change the content:
  - Contact Us --> becomes --> Thank You
  - Change colours if you want
  - Update the title of the page
  - Remove the test link to the thank-you page

<!-- Speaker notes:
The thank-you.blade.php file is the same as the contact-us blade file, 
with the name of the file and text changed, plus the link removed.
-->



---
level: 2
---

# Building a Contact-List App (7)

## Static Pages - Contact Us - Testing


Make sure your development server is running:

```bash
composer run dev
````

Then visit:

- `http://127.0.0.1:8000/contact-us`

Click the “Thank You Test Link” to verify the thank-you page works.

---
layout: section
---

# Quick Group Exercise

<!--
Split group into 5 teams.
Each team investigates adn answers given question
After 5 minutes, team members will be mixed with other teams
Share findings about all 5 questions with each other
-->

---
level: 2
---

## Knowledge Check

Teams are Numbered 1-5

Answer your question as a team

1. Which tools are typically required before creating a Laravel project?
2. Which directories are most commonly edited during feature work?**  
3. Which layer is responsible for rendering HTML?**  
4. Where should heavy business logic primarily live?**  

---
layout: section
---

# Session Checklist!

<!-- Speaker notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist (Covered Today)

- [ ] Installing the Laravel installer & alternatives (Composer)
- [ ] Creating a new project; running PHP server; Vite dev server
- [ ] Folder structure: app/, resources/, routes/, public/, storage/
- [ ] MVC overview: roles and request flow
- [ ] Blade: creating views, syntax, escaping, directives
- [ ] Template inheritance with `@extends/@section/@yield`
- [ ] Components with `<x-…>` (props, slots, `$attributes->merge`)
- [ ] How Tailwind integrates via Vite and Blade
- [ ] Mini build: “Contact Us” (routes, controller, simple view)


<!-- Speaker notes:
Ask learners to identify any topics needing a deeper dive next session.
-->

---
level: 2
---

## Exit Tickets (Discuss or Submit)

1) **Architecture Reflection:**

In your own words, describe how a request to `/contact` flows through
Laravel (route → controller → validation → view) in our mini build. Where
might you add logging or email sending, and why would you put that logic
there?

2) **Blade & Tailwind Application:**

Take the contact form and propose two improvements using Blade components and
Tailwind utilities (e.g., extract an `<x-input>` with label + error, add a
responsive grid). Explain how `$attributes->merge` and `@class` help keep your
markup DRY and readable.

<!-- Speaker notes:
Look for clarity of request flow and solid reasoning for where to place logic.
For Blade/Tailwind: emphasize reusability, consistency, and conditional styling.
-->


---
layout: section
---

# Acknowledgements & References

<!-- Speaker notes:
Section: References. Provide reputable sources for further study in APA 7 style.
-->

---
level: 2
---

## References & Acknowledgements

- Laravel. (2026). *The PHP framework for web artisans. Laravel.com*; *
  *Laravel**.  
  https://laravel.com/
- Laravel. (2026). *Blade templates (Docs). Laravel.com*; **Laravel**.  
  https://laravel.com/docs/12.x/blade
- Laravel. (2026). *Starter kits (Breeze/Jetstream). Laravel.com*; **Laravel
  **.  
  https://laravel.com/docs/12.x/starter-kits
- Tailwind CSS. (2026). *Tailwind CSS. Tailwindcss.com*; **Tailwind Labs**.  
  https://tailwindcss.com/

---
level: 2
---

## References & Acknowledgements (2)

- Vite. (2026). *Vite. Vitejs.dev*; **Vite**.  
  https://vitejs.dev/
- Composer. (2026). *Composer. Getcomposer.org*; **Composer**.  
  https://getcomposer.org/
- PHP Group. (2026). *PHP manual. Php.net*; **The PHP Group**.  
  https://www.php.net/
- Node.js. (2026). *Node.js. Nodejs.org*; **OpenJS Foundation**.  
  https://nodejs.org/
- Font Awesome. (2026). *Font Awesome. Fontawesome.com*; **Font Awesome**.
  https://fontawesome.com/

<!-- Speaker notes:
Encourage learners to browse docs for their exact Laravel minor version.
-->

- Slide template: Adrian Gould

> - Some content was generated with the assistance of Microsoft CoPilot
