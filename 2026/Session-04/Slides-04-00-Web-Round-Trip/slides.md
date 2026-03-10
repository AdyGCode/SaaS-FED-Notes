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
layoput: section
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

## 3) Verify installed and acessible

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

---
level: 2
---

# Creating a New Project

## Option A: Using the Laravel Installer

```bash
laravel new <MY_APPLICATION_NAME>
cd <MY_APPLICATION_NAME>
php artisan serve
```

Open: http://127.0.0.1:8000


---
level: 2
---

# Creating a New Project (2)

## Option B: Using Composer Directly

```bash
composer create-project laravel/laravel <MY_APPLICATION_NAME>
cd <MY_APPLICATION_NAME>
php artisan serve
```

---
level: 2
---

# Creating a New Project (3)

## Option C: Using the Laravel Installer & Template

```bash
laravel new <MY_APPLICATION_NAME> --using=<TEMPLATE_NAME>
cd <MY_APPLICATION_NAME>
php artisan serve
```

---
level: 2
---
# Creating a New Project (4)

## Initialize Frontend (Vite + Tailwind)

```bash
npm install
npm run dev      # or: npm run build
```

> *Tip:* Use `php artisan key:generate` if needed (usually auto-run).

<!-- Speaker notes:
- Option A is often faster and gives a clean scaffold.
- Option B is great for CI or when the installer isn’t available.
- `npm run dev` launches Vite in dev mode with HMR. Use a second terminal for that.
-->

---

layout: section
---

<!-- Speaker notes:
Section: Laravel folder structure. Focus on the high-signal directories and what
lives inside them for everyday development.
-->

---
level: 2
---

## Folder Structure (The Greatest Hits)

- **app/** — Your application code
    - `Http/Controllers/`, `Models/`, `Policies/`, `Middleware/`
- **bootstrap/** — Framework bootstrapping (cache, autoload)
- **config/** — Config files (`app.php`, `database.php`, `mail.php`, …)
- **database/** — Migrations, factories, seeders
- **public/** — Web root (index.php, assets entry point)
- **resources/** — Views (Blade), CSS/JS (pre-Vite build), lang
- **routes/** — `web.php`, `api.php`, `console.php`, `channels.php`
- **storage/** — Logs, compiled views, file uploads
- **tests/** — Unit/Feature tests
- **vendor/** — Composer dependencies (don’t edit)

> You’ll mostly live in **app/**, **resources/**, and **routes/**.

<!-- Speaker notes:
- Emphasize that public/ is the document root for production web servers.
- storage/logs/laravel.log is the first stop for debugging unexpected errors.
-->

---

layout: section
---

<!-- Speaker notes:
Section: MVC concepts. Define the three roles, data flow, and how routes fit in.
Keep the mental model clear and practical.
-->

---
level: 2
---

## MVC Overview: Model–View–Controller

**Model**

- Business logic & data representation (often Eloquent models)

**View**

- Presentation layer (Blade templates)

**Controller**

- Coordinates the request, invokes domain logic, returns responses

**Flow**  
Browser → Route → Controller → (Model/services) → View (HTML) → Browser

> Routes map URLs to controllers; controllers prepare data; views present it.



<!-- Speaker notes:
- Keep controllers skinny: orchestrate, don’t implement heavy business logic.
- Views should contain as little logic as possible; use Blade directives sparingly.
-->


---
layout: image
image: public/Laravel-Page-Request-Seqeunce-Simplified.png
---

---
layout: section
---

<!-- Speaker notes:
Section: Blade basics—creating views, syntax, escaping, and common directives.
Include simple code examples, data passing, and escaping safeguards.
-->

---
level: 2
---

## Creating Blade Views

**Route → View**

```php
// routes/web.php
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome', ['name' => 'Adrian']);
});
```

**View (resources/views/welcome.blade.php)**

```blade
<!doctype html>
<html>
  <head><meta charset="utf-8"><title>Welcome</title></head>
  <body class="font-sans antialiased">
    <h1 class="text-2xl">Hello, {{ $name }}!</h1>
  </body>
</html>
```

**Passing Data**

- Array: `view('welcome', ['name' => 'Adrian'])`
- `with()`: `view('welcome')->with('name', 'Adrian')`

<!-- Speaker notes:
- Blade files end with .blade.php.
- Keep view files in resources/views. Nested folders use dot notation:
  views/home/index.blade.php → view('home.index').
-->

---
level: 2
---

## Blade Syntax & Escaping

**Echoing Variables**

```blade
{{ $title }}           {{-- Escaped (safe) --}}
{!! $html !!}          {{-- Unescaped (trust only sanitized content) --}}
@{{ user }}            {{-- Output literal “{{ user }}” (e.g., for Vue) --}}
```

**Control Structures**

```blade
@if($count > 0)
  <p>Items: {{ $count }}</p>
@elseif($count === 0)
  <p>No items</p>
@else
  <p>Unknown</p>
@endif

@foreach($items as $item)
  <li>{{ $item->name }}</li>
@endforeach
```

**Raw Blocks**

```blade
@verbatim
  <div id="app">{{ message }}</div>
@endverbatim
```

> Prefer `{{ }}` for safety. Use `{!! !!}` only for trusted HTML.

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
  ```blade
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

<!-- Speaker notes:
Section: Components & template inheritance. Show @extends/@section flow and the
component-driven (x-) layout approach with slots and class merging. Then compare them.
-->

---
level: 2
---

## Template Inheritance: `@extends` / `@section` / `@yield`

**Layout**

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

**Child View**

```blade
{{-- resources/views/home.blade.php --}}
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

## Components: `<x-…>` + Slots + Class Merging

**Layout as a Component**

```blade
{{-- resources/views/components/layout.blade.php --}}
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

**Using the Component**

```blade
{{-- resources/views/dashboard.blade.php --}}
<x-layout title="Dashboard">
  <h1 class="text-2xl font-semibold">Hello from the component layout</h1>
</x-layout>
```

**Reusable Button (with Tailwind Class Merge)**

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

**Use it**

```blade
<x-button type="submit" class="mt-3">Save</x-button>
```

<!-- Speaker notes:
- $attributes->merge(['class' => '...']) merges caller classes with defaults—great for Tailwind.
- Anonymous components live in resources/views/components. Named slots: <x-slot:name>.
-->

---
level: 2
---

## `@extends` vs `<x-component>` — When & Why

**`@extends` Layouts**

- Ideal for **page-level layout inheritance** (e.g., master layout with
  `@yield` regions)
- Familiar HTML flow; sections filled by child views via `@section`
- Great for **global structure** (head, nav, footer) with per-page content
- Simple mental model; less moving parts

**`<x-…>` Components**

- Ideal for **reusable UI pieces** and **layout-as-component** patterns
- Support **props**, **slots**, and `$attributes->merge()` (excellent for
  Tailwind class composition)
- Encourages **encapsulation** and **composition** (nestable, testable,
  discoverable)
- Can live as **anonymous** (Blade-only) or **class-based** components

**Choosing Between Them**

- Use **`@extends`** for a site-wide base layout with named sections
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

<!-- Speaker notes:
Section: Tailwind + Blade. Show where Tailwind is configured, how Vite compiles it,
and how Blade makes Tailwind ergonomic via directives and components.
-->

---
level: 2
---

## How Tailwind Fits With Blade

**Tailwind in Your Project**

- **resources/css/app.css**
  ```css
  @tailwind base;
  @tailwind components;
  @tailwind utilities;
  ```
- **tailwind.config.js** — content paths include Blade & JS
- **Vite** compiles Tailwind & your assets

**Vite Setup (excerpt)**

```js
// vite.config.js
import {defineConfig} from 'vite'
import laravel from 'laravel-vite-plugin'

export default defineConfig({
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
})
```

**In Blade Layout**

```blade
@vite(['resources/css/app.css','resources/js/app.js'])
```

**Ergonomics in Blade**

- `@class([...])` for conditional Tailwind classes
- Components encapsulate Tailwind patterns with
  `$attributes->merge(['class' => '...'])`

<!-- Speaker notes:
- Starter kits (e.g., Breeze/Jetstream) ship with Tailwind + Vite pre-configured.
- Keep tailwind.config.js content globs up to date to avoid purge issues.
-->

---

layout: section
---

<!-- Speaker notes:
Section: Mini build—the “Contact Us” page. We’ll create routes, a controller, a
view with a Tailwind form, validate input, and show a success message—no database.
-->

---
level: 2
---

## Mini Build: “Contact Us” (No Storage)

### 1) Routes

```php
// routes/web.php
use App\Http\Controllers\ContactController;
use Illuminate\Support\Facades\Route;

Route::get('/contact', [ContactController::class, 'create'])->name('contact.create');
Route::post('/contact', [ContactController::class, 'store'])->name('contact.store');
```

### 2) Controller

```php
// app/Http/Controllers/ContactController.php
namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ContactController extends Controller
{
    public function create()
    {
        return view('contact.create');
    }

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
}
```

<!-- Speaker notes:
- We explicitly validate and then do nothing with the data (no DB).
- Using back()->with() flashes a success message for UX.
-->

---
level: 2
---

## Contact Blade View (Tailwind Form)

```blade
{{-- resources/views/contact/create.blade.php --}}
<x-layout title="Contact Us">
  @if (session('status'))
    <div class="mb-4 rounded-md bg-green-50 p-4 text-green-800">
      {{ session('status') }}
    </div>
  @endif

  <h1 class="mb-6 text-2xl font-semibold">Contact Us</h1>

  <form method="POST" action="{{ route('contact.store') }}" class="space-y-4 max-w-xl">
    @csrf

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

    <div>
      <label for="message" class="block text-sm font-medium">Message</label>
      <textarea id="message" name="message" rows="5"
                class="mt-1 block w-full rounded-md border-gray-300 shadow-sm
                       focus:border-indigo-500 focus:ring-indigo-500">{{ old('message') }}</textarea>
      @error('message')
        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
      @enderror
    </div>

    <x-button type="submit" class="mt-3">Send</x-button>
  </form>
</x-layout>
```

> Make sure you have the `<x-layout>` and `<x-button>` components from
> earlier.

<!-- Speaker notes:
- Old input values repopulate on validation errors.
- @error directives show field-level feedback.
- The success banner uses the flashed session('status').
-->

---
level: 2
---

## Mini Build: Quick Checklist

- [ ] Routes defined (`GET /contact`, `POST /contact`)
- [ ] Controller actions (`create`, `store`)
- [ ] Validation in `store()` (discard or log data)
- [ ] Blade view with form + CSRF + errors
- [ ] Tailwind classes applied for clean UI
- [ ] Flash success message on submit

**Run it**

```bash
php artisan serve
npm run dev
```

<!-- Speaker notes:
- That’s it—fully functional UX without persistence.
- Optional extension: send an email via Mail::to() if desired (beyond scope here).
-->

---

layout: section
---

<!-- Speaker notes:
Section: Knowledge check. Four groups of multi-select questions. Encourage
discussion in pairs or small groups before revealing answers.
-->

---
level: 2
---

## Knowledge Check — Installing Laravel & Creating a Project (5)

**Q1. Which tools are typically required before creating a Laravel project?
**  
A. PHP  
B. Composer  
C. Node.js + npm  
D. Docker

**Answer:** A, B (C is common for asset pipeline; Docker is optional)

---

**Q2. Which commands can initialize a new Laravel app?**  
A. `laravel new myapp`  
B. `composer create-project laravel/laravel myapp`  
C. `php artisan app:new myapp`  
D. `npm create laravel myapp`

**Answer:** A, B

---

**Q3. What does `@vite([...])` in a Blade layout do?**  
A. Includes compiled assets from Vite  
B. Registers Composer packages  
C. Runs database migrations  
D. Enables hot module replacement in production

**Answer:** A

---

**Q4. When `laravel` command isn’t found after install, what’s the likely fix?
**  
A. Reinstall PHP  
B. Add Composer’s global `vendor/bin` to PATH  
C. Run `php artisan serve`  
D. Delete `vendor/`

**Answer:** B

---

**Q5. Which commands start the dev servers?**  
A. `php artisan serve`  
B. `npm run dev`  
C. `composer serve`  
D. `php artisan dev`

**Answer:** A, B

<!-- Speaker notes:
Clarify that Node.js/npm are part of the modern asset pipeline. Some teams might
use alternatives, but Vite is the default.
-->

---
level: 2
---

## Knowledge Check — Laravel Folder Structure (5)

**Q1. Which directories are most commonly edited during feature work?**  
A. `app/`  
B. `resources/`  
C. `routes/`  
D. `vendor/`

**Answer:** A, B, C

---

**Q2. Where do Blade templates live by default?**  
A. `resources/views/`  
B. `app/Views/`  
C. `resources/templates/`  
D. `resources/blade/`

**Answer:** A

---

**Q3. Which folder is the web document root in production?**  
A. `storage/`  
B. `public/`  
C. `resources/`  
D. `bootstrap/`

**Answer:** B

---

**Q4. Where do cached/compiled views and logs reside?**  
A. `storage/`  
B. `bootstrap/`  
C. `config/`  
D. `database/`

**Answer:** A

---

**Q5. Which files define HTTP routes?**  
A. `routes/web.php`  
B. `routes/api.php`  
C. `routes/console.php`  
D. `routes/channels.php`

**Answer:** A, B (console/channels are for CLI/notifications)

<!-- Speaker notes:
Reinforce that editing vendor/ is a no-go; changes would be overwritten by updates.
-->

---
level: 2
---

## Knowledge Check — MVC Terms & Concepts (5)

**Q1. Which layer is responsible for rendering HTML?**  
A. Model  
B. View  
C. Controller  
D. Route

**Answer:** B

---

**Q2. Which items typically contain business rules or data access?**  
A. Models  
B. Controllers  
C. Views  
D. Middleware

**Answer:** A (services may encapsulate business logic as well)

---

**Q3. Typical request flow includes which steps?**  
A. Browser → Route → Controller  
B. Controller → Model/Service → View  
C. View → Controller → Model  
D. Browser → View → Controller

**Answer:** A, B

---

**Q4. Where should heavy business logic primarily live?**  
A. Controllers  
B. Views  
C. Models/Services  
D. Routes

**Answer:** C

---

**Q5. Which is true about routes?**  
A. They map URIs to actions  
B. They should render large HTML blocks directly  
C. They can point to controllers or closures  
D. They run after Blade renders

**Answer:** A, C

<!-- Speaker notes:
Encourage “thin controllers, fat models/services.” Views are for presentation only.
-->

---
level: 2
---

## Knowledge Check — Blade Views, Syntax & Inheritance (5)

**Q1. Which Blade echo escapes HTML by default?**  
A. `{{ $var }}`  
B. `{!! $var !!}`  
C. `@{{ $var }}`  
D. `{{!! $var !!}}`

**Answer:** A

---

**Q2. Which features support template inheritance?**  
A. `@extends`  
B. `@section`  
C. `@yield`  
D. `<x-layout> ... </x-layout>`

**Answer:** A, B, C, D (components offer an alternative inheritance pattern)

---

**Q3. What does `$attributes->merge(['class' => '...'])` do in a component?
**  
A. Overrides all attributes  
B. Appends/merges classes with caller’s attributes  
C. Removes the `class` attribute  
D. Compiles Tailwind into CSS

**Answer:** B

---

**Q4. Which Blade directives help with conditional Tailwind classes?**  
A. `@class([...])`  
B. `@style([...])`  
C. `@checked($expr)`  
D. `@selected($expr)`

**Answer:** A, C, D

---

**Q5. Which statements are true?**  
A. `@verbatim` outputs content without Blade parsing  
B. `{!! !!}` should be used for arbitrary user input  
C. `@include` can inject partials into a view  
D. `<x-*>` components can define slots

**Answer:** A, C, D

<!-- Speaker notes:
Stress the security risk of unescaped output and where it’s appropriate (only trusted/sanitized content).
-->

---

layout: section
---

<!-- Speaker notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist (Covered Today)

- Installing the Laravel installer & alternatives (Composer)
- Creating a new project; running PHP server; Vite dev server
- Folder structure: app/, resources/, routes/, public/, storage/
- MVC overview: roles and request flow
- Blade: creating views, syntax, escaping, directives
- Template inheritance with `@extends/@section/@yield`
- Components with `<x-…>` (props, slots, `$attributes->merge`)
- How Tailwind integrates via Vite and Blade
- Mini build: “Contact Us” (routes, controller, validation, form UI)
- Knowledge checks & references

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
