---
theme: nmt
background: https://cover.sli.dev
title: Session 04 - Starting Laravel - Web Round Trip - MVC Basics
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 04: Starting Laravel

## SaaS 1 – Cloud Application Development (Front-End Dev)

### Web Round Trip & MVC Basics

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

<Toc minDepth="1" maxDepth="1" columns="2" />

---
layout: section
---
# Building apps...

## Fresh code finds its path<br>Folders breathe, routes softly wake<br>A new app begins

---
layout: section
---

# Laravel 12 + Blade + Tailwind - An Introduction

<br>

## From Zero to “Contact Us”

<br>

### *Platform:* Laravel 12 (MVC), Blade templating, Tailwind CSS

### *Goal:* Understand the workflow and build a small feature end‑to‑end

<!-- Presenter Notes:
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

## 1) Prerequisites

- PHP (compatible with Laravel 12)
- Composer (global)
- Node.js + npm (for Vite/Tailwind)

---
level: 2
---

# Installing the Laravel Installer (2)

## 2) Install the Laravel Installer (global)

```bash
composer global require laravel/installer
```

> Ensure Composer in your Path

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

## 3) Verify installed and accessible

```bash
laravel --version
```

<br>

<Announcement type="info" title="Updating Laravel Installer">
<p>If you have already installed the laravel installer globally then use:</p>
<pre><code>composer global update</code></pre>
<p>To update the installer and other globally added packages.</p>
</Announcement>

<!-- Presenter Notes:
- If “laravel” isn’t found, the global Composer bin directory isn’t on PATH.
- macOS/Linux can add: export PATH="$HOME/.composer/vendor/bin:$PATH"
  (or ~/.config/composer/vendor/bin depending on Composer version).
- Alternatively, skip the installer and use composer create-project (next slide).
-->


---
layout: section
---

# Creating a New Laravel Project

---
level: 2
---

# Creating a New Project

Three options available:

- Option A: Using the Laravel Installer
- Option B: Using Composer Directly
- Option C: Using the Laravel Installer & Template

Installer options do require interaction with the command line.

- Questions are asked for base application configuration.

Composer option requires more manual configuration.

---
level: 2
---

# Creating a New Project (2)

## Option A: Using the Laravel Installer

```bash
laravel new <MY_APPLICATION_NAME>
cd <MY_APPLICATION_NAME>
```

## Option B: Using Composer Directly

```bash
composer create-project laravel/laravel <MY_APPLICATION_NAME>
cd <MY_APPLICATION_NAME>
```

## Option C: Using the Laravel Installer & Template

```bash
laravel new <MY_APPLICATION_NAME> --using=<TEMPLATE_NAME>
cd <MY_APPLICATION_NAME>
```

---
level: 2
layout: two-cols-2-1
---

# Creating a New Project (3)

::right::

## Laravel Installer Switch Options

- Switches allow custom installing
- Examples:
    - `--git`,
    - `--database=sqlite`,
    - `--pnpm`

Use `laravel new --help` to see all options.

::left::

#### Selection of options

<div style="font-size:0.8rem; line-height:0.2rem;">

| Switch                   | Meaning                                          |
|--------------------------|--------------------------------------------------|
| --git                    | Initialize a Git repository                      |
| --database=DATABASE      | DB driver: mysql, mariadb, pgsql, sqlite, sqlsrv |
| --livewire               | Livewire Starter Kit                             |
| --teams                  | Team support                                     |
| --no-authentication      | No authentication scaffolding                    |
| --pest                   | Use PEST testing                                 |
| --pnpm                   | Use PNPM for npm packages                        |
| --no-boost               | Skip Laravel Boost installation                  |
| --using[=USING]          | Use a custom starter kit                         |
| --version                | Display this application version                 |
| -v, -vv, -vvv, --verbose | Increase the verbosity of messages               |

</div>

---
level: 2
---

# Creating a New Project (4)

## Questions asked by installer

We run the installer using: `laravel new test-laravel-installer --pnpm`

The following show each question that is asked and typical
responses.

````md magic-move

```text
$ laravel new test-laravel-installer --pnpm

 ██╗       █████╗  ██████╗   █████╗  ██╗   ██╗ ███████╗ ██╗
 ██║      ██╔══██╗ ██╔══██╗ ██╔══██╗ ██║   ██║ ██╔════╝ ██║
 ██║      ███████║ ██████╔╝ ███████║ ██║   ██║ █████╗   ██║
 ██║      ██╔══██║ ██╔══██╗ ██╔══██║ ╚██╗ ██╔╝ ██╔══╝   ██║
 ███████╗ ██║  ██║ ██║  ██║ ██║  ██║  ╚████╔╝  ███████╗ ███████╗
 ╚══════╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝   ╚═══╝   ╚══════╝ ╚══════╝
```

```text
 Which starter kit would you like to install? [None]:
  [none    ] None
  [react   ] React
  [svelte  ] Svelte
  [vue     ] Vue
  [livewire] Livewire
 > none
none
```

```text
 Which testing framework do you prefer? [Pest]:
  [0] Pest
  [1] PHPUnit
 > 0
0

```

```text
 Do you want to install Laravel Boost to improve AI assisted coding? (yes/no) [yes]:
 > no

```

```text
Creating a "laravel/laravel" project at "./test-laravel-installer"
Installing laravel/laravel (v13.2.0)
  - Downloading laravel/laravel (v13.2.0)
  - Installing laravel/laravel (v13.2.0): Extracting archive
Created project in C:\Users\5001775\Source\Repos/test-laravel-installer
Loading composer repositories with package information
Updating dependencies
Lock file operations: 106 installs, 0 updates, 0 removals
  - Locking brick/math (0.14.8)
  - Locking carbonphp/carbon-doctrine-types (3.2.0)
  - Locking dflydev/dot-access-data (v3.0.3)
...
```

```text
...
  - Installing phpunit/phpunit (12.5.23): Extracting archive
59 package suggestions were added by new dependencies, use `composer suggest` to see details.
Generating optimized autoload files
77 packages you are using are looking for funding.
Use the `composer fund` command to find out more!
No security vulnerability advisories found.
> @php -r "file_exists('.env') || copy('.env.example', '.env');"

   INFO  Application key set successfully.

```

```text
 Which database will your application use? [SQLite]:
  [sqlite ] SQLite
  [mysql  ] MySQL
  [mariadb] MariaDB
  [pgsql  ] PostgreSQL
  [sqlsrv ] SQL Server (Missing PDO extension)
 > sqlite
sqlite

```

```text
   INFO  Preparing database.

  Creating migration table ................................... 36.66ms DONE

   INFO  Running migrations.

  0001_01_01_000000_create_users_table ...................... 121.11ms DONE
  0001_01_01_000001_create_cache_table ....................... 65.75ms DONE
  0001_01_01_000002_create_jobs_table ........................ 92.46ms DONE

[Some automatic steps are removed for brevity]
```

```text
Generating optimized autoload files
> Illuminate\Foundation\ComposerScripts::postAutoloadDump
> @php artisan package:discover --ansi

   INFO  Discovering packages.

  laravel/pail ..................................................... DONE
  laravel/tinker ................................................... DONE
  nesbot/carbon .................................................... DONE
  nunomaduro/collision ............................................. DONE
  nunomaduro/termwind .............................................. DONE
  pestphp/pest-plugin-laravel ...................................... DONE
```

```text
[Some automatic steps are removed for brevity]

Packages: +58
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Progress: resolved 99, reused 63, downloaded 0, added 58, done

devDependencies:
+ @tailwindcss/vite 4.2.3
+ concurrently 9.2.1
+ laravel-vite-plugin 3.0.1
+ tailwindcss 4.2.3
+ vite 8.0.9

Done in 11.6s using pnpm v10.28.2
```

```text
> @ build C:\Users\5001775\Source\Repos\test-laravel-installer
> vite build


vite v8.0.9 building client environment for production...
✓ 3 modules transformed.
computing gzip size...
public/build/manifest.json             0.33 kB │ gzip: 0.16 kB
public/build/assets/app-D1Bb38BR.css  37.95 kB │ gzip: 9.38 kB
public/build/assets/app-34mOoJaZ.js    0.00 kB │ gzip: 0.02 kB

✓ built in 2.29s
```

```text
   INFO  Application ready in [test-laravel-installer]. You can start your local development using:

➜ cd test-laravel-installer
➜ composer run dev

  New to Laravel? Check out our documentation. Build something amazing!
```
````

---
level: 2
layout: two-cols
---

# Creating a New Project (4)

## Initialize Frontend (Vite + Tailwind)

Make sure you are in the newly created application's folder.

> *Tip:* After the command(s) below, you may need to use `php artisan 
> key:generate`, especially if you have used a "starter kit" template.


::left::

### Using NPM:

```bash [BASH + NPM]
npm install
npm update
```

::right::

### Using PNPM:

```bash [BASH + PNPM]
pnpm install
pnpm update -r --latest
```

---
level: 2
---

# Creating a New Project (5)

## Starting the Development Server

```bash
composer run dev
```

Once the shell shows responses similar to:

<pre style="font-size: 0.9rem; line-height: 0.9rem; background:rgba(64,64,
128,0.3); padding:0 0.5rem 1rem; border-radius: 0.25rem; margin: 0 auto; 
width:96ch;">

[vite]   VITE v8.0.9  ready in 9143 ms
[vite]
[vite]   ➜  Local:   http://localhost:5173/
[vite]   ➜  Network: use --host to expose
[vite]
[vite]   LARAVEL v12.56.0  plugin v3.0.1
[vite]
[vite]   ➜  APP_URL: http://localhost
[vite] 1:16:05 pm [vite] (client) [optimizer] scanning dependencies...
[vite] 1:16:06 pm [vite] (client) [optimizer] bundling dependencies...
</pre>

Open browser and enter `http://127.0.0.1:8000` into the address bar,
and press <kbd>ENTER</kbd> to see the default Laravel welcome page.

---
layout: section
---

# Folder Structure - Greatest Hits

<!-- Presenter Notes:
Section: Laravel folder structure. Focus on the high-signal directories and what
lives inside them for everyday development.
-->

---
level: 2
---

# Folder Structure - Greatest Hits

<div style="font-size: 0.9rem; line-height: 0.4rem; ">

| Folder         | Content                                                                      |
|----------------|------------------------------------------------------------------------------|
| `app/**`       | Your application code including controllers, models, policies and middleware |
| `bootstrap/**` | Framework bootstrapping (cache, autoload)                                    |
| `config/**`    | Config files (`app.php`, `database.php`, `mail.php`, …)                      |
| `database/**`  | Migrations, factories, seeders                                               |
| `public/**`    | Web root (index.php, assets entry point)                                     |
| `resources/**` | Views (Blade), CSS/JS (pre-Vite build), lang                                 |
| `routes/**`    | Routes files. Standard include `web.php`, `console.php`                      |
| `storage/**`   | Logs, compiled views, file uploads                                           |
| `tests/**`     | Unit/Feature tests                                                           |
| `vendor/**`    | Composer dependencies (don’t edit)                                           |

</div>

<br>

> You’ll mostly live/work in `app/`, `resources/`, and `routes/`.

<!-- Presenter Notes:
- Emphasize that public/ is the document root for production web servers.
- storage/logs/laravel.log is the first stop for debugging unexpected errors.
-->

---
layout: section
---

# MVC Overview

## Model–View–Controller

<!-- Presenter Notes:
Section: MVC concepts. Define the three roles, data flow, and how routes fit in.
Keep the mental model clear and practical.
-->

---
level: 2
---

# MVC Overview: Model–View–Controller

## Components

| Component  | Meaning/Purpose                                                  |
|------------|------------------------------------------------------------------|
| Route      | Routes map URLs to controllers                                   |
| Model      | Business logic & data representation (often Eloquent models)     |
| View       | Presentation layer (Blade templates)                             |
| Controller | Coordinates the request, invokes domain logic, returns responses |

### Process Flow (Simplified)

Browser → Route → Controller → (Model/services) → View (HTML) → Browser

<!-- Presenter Notes:
- Keep controllers skinny: 
  - orchestrate, 
  - don’t implement heavy business logic.
- Views should contain as little logic as possible: 
  - use Blade directives sparingly.
-->

---
layout: figure
figureUrl: ./public/assets/Laravel-Page-Request-Seqeunce-Simplified@2x.png
figureCaption: Laravel Page Request Sequence (Simplified)
---
<!-- Presenter Notes:
TODO: Add description in full of process
-->

---
layout: section
---

# Views - Laravel's Blade Templating Engine

<!-- Presenter Notes:
Section: Blade basics—creating views, syntax, escaping, and common directives.
Include simple code examples, data passing, and escaping safeguards.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Methods to Show Views

Views are displayed in two ways:

- direct return of the view by a route
- via a controller method returning the view

<br>

<Announcement type="info" title="Views">
<p>We will use the...</p>
<ul>
<li>first option for simplicity and to focus on Blade,</li>
<li>second option in the mini build, for more completeness</li>
</ul>
</Announcement>

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Render view direct from Route:

```php
// routes/web.php
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome', ['name' => 'Adrian']);
});
```

<br>

<Announcement type="warning" title="Direct access via route">
This is not the best practice. Use a controller to show the views.
</Announcement>

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Creating Blade Views

- Blade files end with `.blade.php`
- Keep view files in `resources/views`
- Nested folders use dot notation:
    - `views/home/index.blade.php` → `view('home.index')`

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Creating Blade Views

### View (`resources/views/welcome.blade.php`)

```blade
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Welcome</title></head>
  <body class="font-sans antialiased">
    <h1 class="text-2xl">Hello, {{ $name }}!</h1>
  </body>
</html>
```

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Creating Blade Views

### Passing Data to the View

Options are using:

- An array:
    - `view('welcome', ['name' => 'Adrian'])`
- Using with:
    - `view('welcome')->with('name', 'Adrian')`

<!-- Presenter Notes:
- Both methods are common
- the array syntax is more concise for multiple variables, 
- `with()` can be more readable (for single variables).
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Blade Syntax & Escaping:  Echoing Variables

```blade
{{ $title }}           {{-- Escaped (safe) --}}

{!! $html !!}          {{-- Unescaped (trust only sanitized content) --}}

@{{ user }}            {{-- Output literal “{{ user }}” (e.g., for Vue) --}}
```

---
level: 2
layout: two-cols
---

# Views - Laravel's Blade Templating Engine

## Blade Syntax & Escaping: Control Structures

::left::

#### Decision (if...elseif..else)

```blade
@if($count > 0)
  <p>Items: {{ $count }}</p>
@elseif($count === 0)
  <p>No items</p>
@else
  <p>Unknown</p>
@endif
```

::right::

#### Repetition

```blade
@foreach($items as $item)
  <li>{{ $item->name }}</li>
@endforeach

@foreach($items as $item)
  <li>{{ $item->name }}</li>
@empty
  <li>No items found.</li>
@endforeach
```

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Blade Syntax & Escaping: Raw Blocks

```blade
@verbatim
  <div id="app">{{ message }}</div>
@endverbatim
```

<br>

<Announcement type="error" title="Raw Blocks">
<p>Prefer &lbrace;&lbrace;  &rbrace;&rbrace; for safety. </p>
<p>Use &lbrace;!! ... !!&rbrace; only for trusted HTML.</p>
</Announcement>

<!-- Presenter Notes:
- Emphasize XSS protection via HTML escaping.
- @csrf and @method are helpers for forms—cover during the mini build.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Blade Goodies to Know (Quick Hits)

- `@csrf` and `@method('PUT')` inside forms
- `@include('partials.alert')` to pull partial templates
- `@once ... @endonce` to ensure a block renders once
- `@push('scripts')/@stack('scripts')` for stacked sections

- Attribute/State directives:
  ```blade
  <input type="checkbox" @checked($active)>
  <option @selected($id === $current)>
  <button @disabled($busy)>
  <div @class(['p-4', 'bg-green-100' => $ok, 'bg-red-100' => !$ok])></div>
  ```

<!-- Presenter Notes:
- @class is perfect for conditional Tailwind classes.
- @push/@stack helps when children need to append to layout-defined areas (e.g., scripts).
-->

---
layout: section
---

# Views - Laravel's Blade Templating Engine

## Template Inheritance

<!-- Presenter Notes:
Section: Components & template inheritance. Show @extends/@section flow and the
component-driven (x-) layout approach with slots and class merging. Then compare them.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Template Inheritance

We use: `@extends` / `@section` / `@yield`

Examples:

| Blade Code                  | Purpose                                                              |
|-----------------------------|----------------------------------------------------------------------|
| `@extends('layouts.app')`   | Tells Blade this view extends a layout                               |
| `@section('content')`       | Defines a section that fills `@yield('content')` in the layout       |
| `@yield('title', 'My App')` | In a layout allows child views to set a title or default to “My App” |

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Template Inheritance

Sample basic layout:

```blade
{{-- resources/views/layouts/app.blade.php --}}
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>@yield('title', 'My App')</title>
  @vite(['resources/css/app.css','resources/js/app.js'])
</head>
<body class="min-h-dvh bg-gray-50 text-gray-900">
  <header class="p-4 border-b">My App</header>
  <main class="p-6">
    @yield('content')
  </main>
</body>
</html>
```

<!-- Presenter Notes:
- @yield defines placeholders;
- You can use @section('title', '...') shorthand for single-line sections.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Template Inheritance

Sample Child View:

```blade
{{-- resources/views/home.blade.php --}}
@extends('layouts.app')

@section('title', 'Home')

@section('content')
  <h1 class="text-2xl font-semibold">Welcome Home</h1>
@endsection
```

<!-- Presenter Notes:
- @section fills @yield's them in child views.
- You can use @section('title', '...') shorthand for single-line sections.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

### Layout as a Component

We are able to create "class based" components.

These provide more power as:
- you may have logic in the class, 
- they allow you to use slots and props in the Blade view.

For our example, we have two files:
- `resources/views/components/guest.blade.php` (the 'guest layout' component)
- `app/View/GuestLayout.php` (the class-based component)


---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

The view for the component (`resources/views/components/guest.blade.php`):

````md magic-move

```blade
{{-- resources/views/components/guest.blade.php --}}
@props(['title' => 'My App'])

<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>{{ $title }}</title>
  @vite(['resources/css/app.css','resources/js/app.js'])
</head>
```

```blade
</head>
<body class="min-h-dvh bg-gray-50 text-gray-900">
  <header class="p-4 border-b">{{ $title }}</header>
  <main class="p-6">
    {{ $slot }}
  </main>
</body>
</html>
```

````

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

The class for the component (`app/View/GuestLayout.php`):

````md magic-move
```php
<?php
// resources/views/components/guest.blade.php

namespace App\View\Components;

use Illuminate\View\Component;
use Illuminate\View\View;

class GuestLayout extends Component
```
```php
class GuestLayout extends Component
{
    /**
     * Get the view / contents that represents the component.
     */
    public function render(): View
    {
        return view('layouts.guest');
    }
}
```
````

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

### Using the Layout Component

To use the component layout, we can do:

```blade
{{-- resources/views/hello.blade.php --}}
<x-guest-layout title="Welcome!">
  <h1 class="text-2xl font-semibold">
  Hello from the guest layout component
  </h1>
</x-guest0layout>
```

> Example shown for the guest layout, with a title prop and a default slot.


---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

### Reusable Button (with Tailwind Class Merge)

```blade
{{-- resources/views/components/button.blade.php --}}
@props(['type' => 'button'])
<button
  type="{{ $type }}"
  {{ $attributes->merge(['class' =>
    'inline-flex items-center rounded-md px-4 py-2 text-sm font-medium
     bg-indigo-600 text-white hover:bg-indigo-700 focus:outline-none focus:ring'
  ]) }}
>
  {{ $slot }}
</button>
```


<!-- Presenter Notes:
- $attributes->merge(['class' => '...']) merges caller classes with defaults—great for Tailwind.
- Anonymous components live in resources/views/components. Named slots: <x-slot:name>.
-->

---
level: 2
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

### Reusable Button (with Tailwind Class Merge)

Use this component in any view:

```blade
<x-button type="submit" class="mt-3">Save</x-button>
```


---
level: 2
layout: two-cols
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

When and Why use `@extends` vs `<x-component>`?

::left::

### `@extends` Layouts

- Ideal for **page-level layout inheritance**
  - e.g. master layout with `@yield` regions
- Familiar HTML flow
  - sections filled by child views via `@section`

::right::
### `@extends` Layouts
- Great for **global structure**
  - head, nav, footer with per-page content
- Simple mental model
- Less moving parts


---
level: 2
layout: two-cols
---

# Views - Laravel's Blade Templating Engine

## Components: `<x-…>` + Slots + Class Merging

When and Why use `@extends` vs `<x-component>`?

::left::

### `<x-…>` Components**

- Ideal for **reusable UI pieces** and **layout-as-component** patterns
- Support **props**, **slots**, and <br>`$attributes->merge()`
  - excellent for Tailwind class composition

::right::
### `<x-…>` Components**

- Encourages **encapsulation** and **composition**
  - nestable, testable, discoverable
- Can live as:
  - **anonymous** (Blade-only) or 
  - **class-based** components


---
level: 2
layout: two-cols
---

# Views - Laravel's Blade Templating Engine

## Choosing Between `@extends` and `<x-component>`

It’s common to **mix both**: 
- `@extends` for the outer shell 
- `<x-*>` for inner UI patterns

::left::
#### `@extends`

- Use **`@extends`** for a site-wide base layout with named sections

::right::
#### `<x-component>`
- Use **components** for reusable widgets (buttons, cards, alerts) **and**
  when you prefer composition over inheritance for layouts


<!-- Presenter Notes:
- Both compile to efficient PHP; choice is about ergonomics and reuse.
- Teams often start with @extends and gradually extract components as patterns repeat.
-->

---
layout: section
---

# How Tailwind Fits With Blade


<!-- Presenter Notes:
Section: Tailwind + Blade. Show where Tailwind is configured, how Vite compiles it,
and how Blade makes Tailwind ergonomic via directives and components.
-->

---
level: 2
---
# How Tailwind Fits With Blade


## Tailwind in Your Project

Two important files:
- `tailwind.config.js` (Tailwind configuration)
- `resources/css/app.css` (Tailwind entry point)

<br>

<Announcement type="important" title="Tailwind v4 Changes">
<p>TailwindCSS v4 and later have reduced the boilerplate used in the 
<code>app.css</code> file.</p>
<p>Many tutorials will still show Tailwind v3 based code.</p>
<p>We show v4 code in these notes.</p>
</Announcement>


---
level: 2
---
# How Tailwind Fits With Blade

## Tailwind in Your Project

### `resources/css/app.css`

```css
@import 'tailwindcss';
```

You may add customised styles here as well.

e.g.
```css
@import "@fortawesome/fontawesome-free/css/all.css";

@theme {
    --color-php-50: oklch(0.957 0.009 286.35);
}
```

Refer to [https://Tailwindcss.com](https://tailwindcss.com) website for more 
details on configuration and usage.


---
level: 2
---
# How Tailwind Fits With Blade

## Tailwind in Your Project

Tailwind uses the Vite JavaScript "compiler" to process your CSS and JS assets.

### Vite Configuration for Tailwind

````md magic-move
```js
// vite.config.js
import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [
        // ... code for plugins
    ],
    server: {
        // ... code for server config
    },
});
```
```js
// vite.config.js
// imports removed for brevity

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
        tailwindcss(),
    ],
     server: {
        // ... code for server config
    },
});
```
```js
// vite.config.js


export default defineConfig({
    plugins: [
        // ... code for plugins
    ],
    server: {
        watch: {
            ignored: ['**/storage/framework/views/**'],
        },
    },
});
```
````

---
level: 2
---
# How Tailwind Fits With Blade

## Tailwind in Your Project

### In Blade Layout files...

```blade
@vite(['resources/css/app.css','resources/js/app.js'])
```

### Ergonomics in Blade

- For conditional Tailwind classes: 
  - `@class([...])` 
- Components encapsulate Tailwind patterns using:
  -   `$attributes->merge(['class' => '...'])`

<!-- Presenter Notes:
- Starter kits ship with Tailwind + Vite pre-configured.
-->

---
layout: section
---

# Mini-Build

## “Contact Us” (No Storage)

<!-- Presenter Notes:
Section: Mini build—the “Contact Us” page. We’ll create routes, a controller, a
view with a Tailwind form, validate input, and show a success message—no database.
-->

---
level: 2
layout: two-cols
---

# Mini Build: “Contact Us” (No Storage)

::left::
### Overview

This mini-build will create a simple contact form with the following features:
- A GET route to show the form
- A POST route to handle form submission
- A controller to manage the form logic
- Validation of form input
- A Blade view with a Tailwind-styled form

::right::
### Order of Implementation

We show the parts for this build in the following order:
1. Routes
2. Controller
3. Blade View (with Tailwind form)
 
---
level: 2
---

# Mini Build: “Contact Us” (No Storage)


## 1) Routes

```php
// routes/web.php
use App\Http\Controllers\ContactController;
use Illuminate\Support\Facades\Route;

Route::get('/contact', [ContactController::class, 'create'])
    ->name('contact.create');
Route::post('/contact', [ContactController::class, 'store'])
    ->name('contact.store');
```

The routes define:
- `GET /contact` → shows the contact form (`create()` method)
- `POST /contact` → processes the form submission (`store()` method)

---
level: 2
---

# Mini Build: “Contact Us” (No Storage)

## 2) Controller

We will show the create and store methods of the controller in two steps.

````md magic-move

```php
// app/Http/Controllers/ContactController.php
namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ContactController extends Controller
{
    public function create() 
    {
        // show contact us page
    }

    public function store(Request $request) 
    {
        // validate and process form submission
    }
}
```

```php
class ContactController extends Controller
{
    public function create()
    {
        return view('contact.create');
    }

    public function store(Request $request)
    {
        // validate and process form submission
    }
}
```

```php
    public function store(Request $request)
    {
        $data = $request->validate([
            'name'    => ['required','string','max:255'],
            'email'   => ['required','email'],
            'message' => ['required','string','max:5000'],
        ]);

        // No storage: e.g., log or discard
        // \Log::info('Contact form submitted', $data);

        return back()->with('status', 'Thanks! Your message has been received.');
    }
```


````

<!-- Presenter Notes:
- We explicitly validate and then do nothing with the data (no DB).
- Using back()->with() flashes a success message for UX.
-->

---
level: 2
---

# Mini Build: “Contact Us” (No Storage)

## Contact Blade View (Tailwind Form)

<Announcement type="important" title="Components">
<p>Before you start the view, make sure you have the components 
from earlier:</p>
<ul>
<li>x-guest-layout</li>
<li>x-button</li>
</ul>
</Announcement>


---
level: 2
---

# Mini Build: “Contact Us” (No Storage)

## Contact Blade View (Tailwind Form)

The blade file for the contact form (`resources/views/contact/create.blade.php`):

````md magic-move
```blade
{{-- resources/views/contact/create.blade.php --}}
<x-layout title="Contact Us">
  {{-- session status code here --}}
  {{-- page header code here --}}
  {{-- form with validation errors code here --}}
</x-layout>
```

```blade
{{-- resources/views/contact/create.blade.php --}}
<x-layout title="Contact Us">
  @if (session('status'))
    <div class="mb-4 rounded-md bg-green-50 p-4 text-green-800">
      {{ session('status') }}
    </div>
  @endif

  {{-- page header code here --}}
  {{-- form with validation errors code here --}}
</x-layout>
```

```blade
<x-layout title="Contact Us">
  {{-- session status code here --}}

  <h1 class="mb-6 text-2xl font-semibold">Contact Us</h1>

  {{-- form with validation errors code here --}}
</x-layout>
```

```blade
<x-layout title="Contact Us">
  {{-- session status code here --}}
  {{-- page header code here --}}
  <form method="POST" action="{{ route('contact.store') }}" class="space-y-4 max-w-xl">
    @csrf

    {{-- name code here --}}
    {{-- email code here --}}
    {{-- message code here --}}
    {{-- send button here --}}

  </form>
</x-layout>
```

```blade
  {{--start of form code here --}}
    <div>
      <label for="name" class="block text-sm font-medium">Name</label>
      <input id="name" name="name" type="text"
             value="{{ old('name') }}"
             class="mt-1 block w-full rounded-md border-gray-300 shadow-sm
                    focus:border-indigo-500 focus:ring-indigo-500" />
      @error('name')
        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
      @enderror
    </div>

    {{-- email code here --}}
    {{-- message code here --}}
    {{-- send button here --}}
{{-- end of form and layout code here --}}
```

```blade
  {{--start of form code here --}}
    {{-- name code here --}}
    <div>
      <label for="email" class="block text-sm font-medium">Email</label>
      <input id="email" name="email" type="email"
             value="{{ old('email') }}"
             class="mt-1 block w-full rounded-md border-gray-300 shadow-sm
                    focus:border-indigo-500 focus:ring-indigo-500" />
      @error('email')
        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
      @enderror
    </div>
    {{-- message code here --}}
    {{-- send button here --}}
{{-- end of form and layout code here --}}
```

```blade
  {{--start of form code here --}}
    {{-- name code here --}}
    <div>
      <label for="message" class="block text-sm font-medium">Message</label>
      <textarea id="message" name="message" rows="5"
                class="mt-1 block w-full rounded-md border-gray-300 shadow-sm
                       focus:border-indigo-500 focus:ring-indigo-500">{{ old('message') }}</textarea>
      @error('message')
        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
      @enderror
    </div>
    {{-- send button here --}}
{{-- end of form and layout code here --}}
```

```blade
  {{--start of form code here --}}
    {{-- name code here --}}
    {{-- email code here --}}
    {{-- message code here --}}

    <x-button type="submit" class="mt-3">Send</x-button>
{{-- end of form and layout code here --}}
```

````

<!-- Presenter Notes:
- Old input values repopulate on validation errors.
- @error directives show field-level feedback.
- The success banner uses the flashed session('status').
-->

---
level: 2
---

# Mini Build: “Contact Us” (No Storage)

## Quick Checklist

- [ ] Routes defined (`GET /contact`, `POST /contact`)
- [ ] Controller actions (`create`, `store`)
- [ ] Validation in `store()` (discard or log data)
- [ ] Blade view with form + CSRF + errors
- [ ] Tailwind classes applied for clean UI
- [ ] Flash success message on submit


---
level: 2
---

# Mini Build: “Contact Us” (No Storage)

## Executing the Build

This has been previously shown.

As a reminder:

```bash
cd APPLICATION_FOLDER
composer run dev
```

Then open `http://localhost:8000/contact` in the browser to see the form.


<!-- Presenter Notes:
- That’s it—fully functional UX without persistence.
- Optional extension: send an email via Mail::to() if desired (beyond scope here).
-->

---
layout: section
---

# Knowledge Check

- building and setup process, 
- folder structure, and 
- MVC concepts.

<!-- Presenter Notes:
Section: Knowledge check. Four groups of multi-select questions. Encourage
discussion in pairs or small groups before revealing answers.
-->

---
level: 2
layout: two-cols
---

# Knowledge Check: Building & Setup

::left::
## Question 1

Which tools are typically required before creating a Laravel project?
  
::right::
## Possible Answers

A. PHP  

B. Composer  

C. Node.js + npm  

D. Docker

<!-- Presenter Notes:
Answer: A, B (C is common for asset pipeline; Docker is optional)

-->

---
level: 2
layout: two-cols
---

# Knowledge Check: Building & Setup

::left::

## Question 2
Which commands can initialize a new Laravel app?  

::right::

## Possible Answers
A. `laravel new myapp`  

B. `composer create-project laravel/laravel myapp`  

C. `php artisan app:new myapp`  

D. `npm create laravel myapp`

<!-- Presenter Notes:
Answer: A, B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check: Building & Setup

::left::

## Question 3
What does `@vite([...])` in a Blade layout do?  

::right::

## Possible Answers
A. Includes compiled assets from Vite  

B. Registers Composer packages  

C. Runs database migrations  

D. Enables hot module replacement in production

<!-- Presenter Notes:
Answer: A

-->

---
level: 2
layout: two-cols
---

# Knowledge Check: Building & Setup

::left::

## Question 4
When `laravel` command isn’t found after install, what’s the likely fix?

::right::

## Possible Answers
  
A. Reinstall PHP  

B. Add Composer’s global `vendor/bin` to system PATH  

C. Run `php artisan serve`  

D. Delete `vendor/`

<!-- Presenter Notes:
Answer: B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check: Building & Setup
::left::

## Question 5
Which commands start the dev servers?  

::right::

## Possible Answers
A. `php artisan serve`  

B. `npm run dev`  

C. `composer serve`  

D. `composer run dev`

<!-- Presenter Notes:
Answer: A, C

-->
<!-- Presenter Notes:
Composer run dev is the new and most correct method

Composer run dev calls npm/pnpm to execute vite, and other processes to 
allow a single command to start both the Laravel server and the Vite dev server with hot reload.
-->


---
level: 2
layout: two-cols
---
# Knowledge Check 
## Laravel Folder Structure

::left::

## Question 1
Which directories are most commonly edited during feature work?  

::right::

## Possible Answers
A. `app/`  

B. `resources/`  

C. `routes/`  

D. `vendor/`

<!-- Presenter Notes:
Answer: A, B, C

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Laravel Folder Structure

::left::

## Question 2
Where do Blade templates live by default?  

::right::

## Possible Answers
A. `resources/views/`  

B. `app/Views/`  

C. `resources/templates/`  

D. `resources/blade/`

<!-- Presenter Notes:
Answer: A

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Laravel Folder Structure

::left::

## Question 3
Which folder is the web document root in production?  

::right::

## Possible Answers
A. `storage/`  

B. `public/`  

C. `resources/`  

D. `bootstrap/`

<!-- Presenter Notes:
Answer: B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Laravel Folder Structure

::left::

## Question 4
Where do cached/compiled views and logs reside?  

::right::

## Possible Answers
A. `storage/`  

B. `bootstrap/`  

C. `config/`  

D. `database/`

<!-- Presenter Notes:
Answer: A

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Laravel Folder Structure

::left::

## Question 5
Which files define HTTP routes?  

::right::

## Possible Answers
A. `routes/web.php`  

B. `routes/api.php`  

C. `routes/console.php`  

D. `routes/channels.php`

<!-- Presenter Notes:
Answer: A, B (console/channels are for CLI/notifications)

-->
<!-- Presenter Notes:
Reinforce that editing vendor/ is a no-go; changes would be overwritten by updates.
-->


---
level: 2
layout: two-cols
---

# Knowledge Check 
## MVC Terms & Concepts

::left::

## Question 1
Which layer is responsible for rendering HTML?  

::right::

## Possible Answers
A. Model  

B. View  

C. Controller  

D. Route

<!-- Presenter Notes:
Answer: B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## MVC Terms & Concepts

::left::

## Question 2
Which items typically contain business rules or data access?  

::right::

## Possible Answers
A. Models  

B. Controllers  

C. Views  

D. Middleware

<!-- Presenter Notes:
Answer: A (services may encapsulate business logic as well)

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## MVC Terms & Concepts

::left::

## Question 3
Typical request flow includes which steps?  

::right::

## Possible Answers
A. Browser → Route → Controller  

B. Controller → Model/Service → View  

C. View → Controller → Model  

D. Browser → View → Controller

<!-- Presenter Notes:
Answer: A, B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## MVC Terms & Concepts

::left::

## Question 4
Where should heavy business logic primarily live?  

::right::

## Possible Answers
A. Controllers  

B. Views  

C. Models/Services  

D. Routes

<!-- Presenter Notes:
Answer: C

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## MVC Terms & Concepts

::left::

## Question 5
Which is true about routes?  

::right::

## Possible Answers
A. They map URIs to actions  

B. They should render large HTML blocks directly  

C. They can point to controllers or closures  

D. They run after Blade renders

<!-- Presenter Notes:
Answer: A, C

-->
<!-- Presenter Notes:
Encourage “thin controllers, fat models/services.” Views are for presentation only.
-->


---
level: 2
layout: two-cols
---

# Knowledge Check 
## Blade Views, Syntax & Inheritance

::left::

## Question 1
Which Blade echo escapes HTML by default?  

::right::

## Possible Answers
A. `{{ $var }}`  

B. `{!! $var !!}`  

C. `@{{ $var }}`  

D. `{{!! $var !!}}`

<!-- Presenter Notes:
Answer: A

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Blade Views, Syntax & Inheritance

::left::

## Question 2
Which features support template inheritance?  

::right::

## Possible Answers
A. `@extends`  

B. `@section`  

C. `@yield`  

D. `<x-layout> ... </x-layout>`

<!-- Presenter Notes:
Answer: A, B, C, D (components offer an alternative inheritance pattern)

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Blade Views, Syntax & Inheritance

::left::

## Question 3
What does `$attributes->merge(['class' => '...'])` do in a component?

::right::

## Possible Answers
  
A. Overrides all attributes  

B. Appends/merges classes with caller’s attributes  

C. Removes the `class` attribute  

D. Compiles Tailwind into CSS

<!-- Presenter Notes:
Answer: B

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Blade Views, Syntax & Inheritance

::left::

## Question 4
Which Blade directives help with conditional Tailwind classes?  

::right::

## Possible Answers
A. `@class([...])`  

B. `@style([...])`  

C. `@checked($expr)`  

D. `@selected($expr)`

<!-- Presenter Notes:
Answer: A, C, D

-->

---
level: 2
layout: two-cols
---

# Knowledge Check 
## Blade Views, Syntax & Inheritance

::left::

## Question 5
Which statements are true?  

::right::

## Possible Answers
A. `@verbatim` outputs content without Blade parsing  

B. `{!! !!}` should be used for arbitrary user input  

C. `@include` can inject partials into a view  

D. `<x-*>` components can define slots

<!-- Presenter Notes:
Answer: A, C, D

Stress the security risk of unescaped output and where it’s appropriate (only trusted/sanitized content).
-->

---
layout: section
---

# Session Checklist

<!-- Presenter Notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist 

- [ ] Installing the Laravel installer & alternatives (Composer)
- [ ] Creating a new project; running PHP server; Vite dev server
- [ ] Folder structure: app/, resources/, routes/, public/, storage/
- [ ] MVC overview: roles and request flow
- [ ] Blade: creating views, syntax, escaping, directives
- [ ] Template inheritance with `@extends/@section/@yield`
- [ ] Components with `<x-…>` (props, slots, `$attributes->merge`)
- [ ] How Tailwind integrates via Vite and Blade
- [ ] Mini build: “Contact Us” (routes, controller, validation, form UI)
- [ ] Knowledge checks & references

<!-- Presenter Notes:
Ask learners to identify any topics needing a deeper dive next session.
-->

---
layout: section
---

# Exit Tickets 🎫

---
level: 2
layout: two-cols
---

## Exit Tickets  🎫

::left::

1) **Architecture Reflection:**

In your own words, describe how a request to `/contact` flows through
Laravel (route → controller → validation → view) in our mini build. 

Where might you add logging or email sending, and why would you put that logic
there?

::right::

2) **Blade & Tailwind Application:**

Take the contact form and propose two improvements using Blade components and
Tailwind utilities (e.g., extract an `<x-input>` with label + error, add a
responsive grid). 

Explain how `$attributes->merge` and `@class` help keep your
markup DRY and readable.

<!-- Presenter Notes:
Look for clarity of request flow and solid reasoning for where to place logic.
For Blade/Tailwind: emphasize reusability, consistency, and conditional styling.
-->


---
layout: section
---

# Acknowledgements & References

<!-- Presenter Notes:
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

<br>

<br>
<br>

> Some content may have been generated generated with the assistance of Microsoft CoPilot

<!-- Presenter Notes:
Encourage learners to browse docs for their exact Laravel minor version.
-->


---
layout: end
---

# Fin!

<h2>
Request meets the mind<br>Models speak, views answer back<br>Order from intent
</h2>
