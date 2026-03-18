---
theme: nmt
background: https://cover.sli.dev
title: Session 06 - Adding Authentication
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 06: Adding Authentication

## SaaS 1 – Cloud Application Development (Front-End Dev)

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
level: 2
class: text-left
---

# Objectives

- Understand Authentication
- Options available for Laravel
- Installing Authentication for App

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
layout: figure
figureUrl: public/orly-book-cover-saas-bread.png
---

---
layout: section
---

# Ice Breaker

---
layout: two-cols
level: 2
---

# Ice Breaker

TODO: TO BE ADDED

---
layout: section
---

# Adding Authentication

--- 
level: 2
---

# Adding Authentication

## Authentication

- identification of the user accessing the application
- verification that the user is who they say they are

## Common Methods

- Password Login
- One-time codes
- Biometrics
- Security Keys
- Open Authentication

--- 
level: 2
---

# Adding Authentication

Laravel has multiple authentication methods

- Sanctum
- Breeze
- Fortify
- Passport
- Jetstream
- Socialite

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Sanctum

Laravel Sanctum provides:

- lightweight API authentication,
- SPA authentication, and
- personal access tokens.

::right::

#### Key features:

- Cookie‑based authentication for SPAs
- Simple token issuing with “abilities”
- Much easier than OAuth2

<br>

#### Best For:

- First‑party SPAs (React, Vue, Inertia)
- Mobile apps
- Simple token-based APIs
- When you want easy “token + abilities” handling without OAuth

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Passport

Laravel Passport is:

- full OAuth2 server implementation.

<br>

#### Best for:

- Third‑party clients
- Enterprise or public APIs
- Where you need OAuth2 features like:
    - Client credentials
    - Authorization codes
    - Refresh tokens

::right::

#### Key features:

- OAuth2-compliant
- Full token lifecycle
- Heavyweight but powerful

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Fortify

Laravel Fortify is:

- an authentication backend - routes + controllers for auth logic.

Jetstream builds on Fortify for backend logic.

::right::

#### Best For:

- Complete control over your frontend
- Headless or API-first apps
- Auth features without Laravel shipping HTML

<br>

#### Key features:

- Login / registration / logout
- Password reset / email verification
- Two-factor authentication
- Profile update + password update
- No UI (you must build your own)

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Breeze

Laravel Breeze is:

- the simplest starter kit for authentication scaffolding.

<br>

#### Best For:

- Learning Laravel
- Small to medium apps
- Lightweight apps where you want clean, minimal code

::right::

### Key features:

- Basic login, registration, password reset
- Blade, Livewire, or Inertia (React/Vue/Svelte)
- Very readable, minimal boilerplate
- Good for learning the fundamentals

<Announcement type="info" title="Deprecated">
<ul>
<li>Breeze has been "deprecated".</li>
<li>Custom Starter Kits with it Built in</li>
<li>e.g. AdyGCode/blade-sanctum-kit, and others</li>
</ul>
</Announcement>

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Jetstream

Laravel Jetstream is:

- full-featured,
- production-ready
- application scaffolding kit.

<br>

#### Best For:

- Apps that require user management features
- Quickly launching SaaS-style platforms
- Want opinionated, powerful scaffolding

::right::

#### Key features:

- Teams / team switching
- Profile management
- Browser session management
- API tokens (powered by Sanctum)
- 2FA
- Email verification
- Choose Livewire or Inertia

--- 
level: 2
layout: two-cols
---

# Adding Authentication

::left::

## Socialite

Laravel Socialite:

- provides OAuth login with external providers.

<br>

#### Best For:

- “Login with Google/GitHub/Facebook/Microsoft”
- Reducing friction for user onboarding
- Apps needing third‑party identity providers

::right::

#### Key features:

- Built-in drivers for popular providers
- Extendable for custom OAuth providers
- Easy to plug into any auth flow

---
level: 2
layout: two-cols
---

# Adding Breeze Based Authentication

Two options:

- When building a new app from scratch 🌶️, or with template kit 🌶️🌶️
- Adding to an existing app (using a template kit) 🌶️🌶️🌶️

::left::

### Adding to An Existing Application:

- Add the required packages
- Download 'kit' from GitHub
    - e.g. `adygcode/blade-sanctum-kit`
- Copy templates, Controllers etc. to correct locations

::right::

### When Creating a New Application:

1. create new app with `using` switch
2. create new app and add Breeze
  

---
level: 2
layout: section
---

# Adding Breeze Based Authentication

## Creating a New Application With Starter Kit

---
level: 2
---

# Adding Breeze Based Authentication

## Adding when Creating a New Application (With kit)

Use the command line, and answer questions...

```shell
laravel new APPLICATION_NAME --using=adygcode/blade-sanctum-kit 
```

To do the above but also set up version control (Git), PNPM, Pest testing,
SQLite...

```shell
laravel new  APPLICATION_NAME --using=adygcode/blade-sanctum-kit --git  
             --pnpm --pest --database=sqlite 
```

<Announcement type="info">
<p>Usually entered as a single line command.</p>
<p>Above: Split over multiple lines using the Bash CLI <code>\</code> 
command continuation character.</p>
</Announcement>


---
level: 2
layout: section
---

# Adding Breeze Based Authentication

## Creating New Application and Adding Breeze


---
level: 2
---

# Adding Breeze Based Authentication

## Creating a New Application and Adding Breeze

Similar to previous steps... execute and select NONE for the starter kit...

```shell
laravel new APPLICATION_NAME 
```
Better option, as above, plus: Git, PNPM, 
Pest testing, SQLite... 

```shell
laravel new  APPLICATION_NAME --using=adygcode/blade-sanctum-kit --git  
             --pnpm --pest --database=sqlite 
```

Then... 

```shell
cd APPLICATION_NAME
composer require --dev laravel/breeze
php artisan breeze:install
php artisan migrate
```

---
level: 2
layout: section
---

# Adding Breeze Based Authentication

## To Existing Simple Application via Starter Kit


---
level: 2
---

# Adding Breeze Based Authentication

## Adding to Existing Simple Application

- Rename your existing `routes/web.php` to `routes/web-old.php`
- Copy your existing `welcome.blade.php` file to a new folder called `old`
- Download the latest copy
  of https://github.com/AdyGCode/blade-sanctum-kit.git
- Uncompress into a temporary folder
- Copy folders/files from temporary folder to destination (see next page)
- Install the node packages required
<br>

<Announcement type="important" title="Best Option">
<p>We recommend that you start from scratch using a suitable template, and 
if needed transfer code to the new project.</p>
</Announcement>

---
level: 2
---

# Adding Breeze Based Authentication

## Files/Folders to copy

| **From**             | **Folder(s)/File(s)**                                                  | **Existing App Folder** |
|----------------------|------------------------------------------------------------------------|-------------------------|
| App/Http/Controllers | Auth, Admin, Client, Web                                               | App/Http/Controllers    |
| App/Http/            | Requests                                                               | App/Http/               |
| App/                 | View                                                                   | App/                    |


---
level: 2
---

# Adding Breeze Based Authentication

## Files/Folders to Copy 2

| **From**             | **Folder(s)/File(s)**                                                            | **Existing App Folder** |
|----------------------|----------------------------------------------------------------------------------|-------------------------|
| resources/views      | admin, auth, client, <br> components, errors, layouts, <br> profile, vendor, web | resources/views         |
| routes               | auth.php, web.admin.php, <br> web.client.php, web.static.php, <br> web.php       | routes                  |


---
level: 2
---

# Adding Breeze Based Authentication

## Files/Folders to Copy 3

If you then run the development server and get errors, carefully check:

- routes are correct
- file locations are correct
- controllers point at correct views

One possible error will be in migrating: missing fields.

If so, copy: 
`database/migrations/2025_12_31_062625_update_users_add_suspended_banned.php`
to your `database/migrations` folder.

This adds `suspended_at` and `banned_at` fields. You may or may not 
require these for your application, but these fields are part of the user 
seeder that is the starter kit.


---
level: 2
---

# Adding Breeze Based Authentication

## Node Packages

Execute the following command:


```shell [Bash]
pnpm install @fortawesome/fontawesome-free @midudev/tailwind-animations chart.js
pnpm install --save-dev @tailwindcss/forms @tailwindcss/postcss @tailwindcss/vite
pnpm install --save-dev alpinejs autoprefixer axios concurrently 
pnpm install --save-dev laravel-vite-plugin tailwindcss vite
```

If using npm use:

```shell [Bash]
npm install @fortawesome/fontawesome-free @midudev/tailwind-animations chart.js
pnpm install --dev @tailwindcss/forms @tailwindcss/postcss @tailwindcss/vite
pnpm install --dev alpinejs autoprefixer axios concurrently 
pnpm install --dev laravel-vite-plugin tailwindcss vite
```


---
level: 2
---

# Adding Breeze Based Authentication

## Edit `app.js`

Edit your `resources/js/app.js` file to include the Alpine requirements:

```js [JS]
import './bootstrap';
import Alpine from 'alpinejs';
window.Alpine = Alpine;
Alpine.start();
```

---
level: 2
---

# Adding Breeze Based Authentication

## Update App CSS file

Edit the `resources/css/app.css` file and add/update to include:

```css
@import "@fortawesome/fontawesome-free/css/all.css";
```

immediately after `@import 'tailwindcss';`

<br>

<Announcement type="info">
You may wish to copy the custom CSS from the
<code>resources/css/app.css</code> file into your site file.
</Announcement>


---
level: 2
---

# Testing the Authentication

- Run the migrations and seeders from fresh.
- Run the development server
- Visit: http://127.0.0.1:8000
- Try logging in with `client@example.com` and `Password1`
- Try logging in with `staff@example.com` and `Password1`
- Try logging in with `admin@example.com` and `Password1`

Next Logout and try registering and loggingin.

---
layout: section
---

# Recap Checklist

---
level: 2
layout: two-cols
---

# Recap Checklist

I should  now able to...

::left::

- [ ] explain what authentication is
- [ ] understand why authentication is required
- [ ] describe different authentication methods
- [ ] understand each Laravel authentication option

::right::
- [ ] create a new Laravel app with a starter kit or add Breeze manually
- [ ] integrate a starter kit into an existing project
- [ ] updated routes, controllers, and views correctly
- [ ] register a new account and log in

---
level: 2
---

# Quick Summary

- Authentication verifies user identity and protects applications.
- Laravel offers a full spectrum of authentication tools (Sanctum → 
  Jetstream).
- Starter kits simplify setting up complete auth flows.
- Proper setup requires updates to routes, controllers, views, CSS, JS, and 
  Node dependencies.
- Testing includes using seeded accounts and verifying registration works.

---
level: 2
---

# Exit Ticket Questions



<Announcement type="brainstorm">
What is Authentication?
</Announcement>

<Announcement type="brainstorm">
Why do we use Authentication?
</Announcement>

---

# Acknowledgements & References

- 

---
level: 2
---

# Acknowledgements & References

- Laravel. (2026). Routing — Laravel 12.x documentation. https://laravel.
  com/docs/12.x/routing [laravel.com]
- Laravel. (2026). Controllers — Laravel 12.x documentation.
  https://laravel.com/docs/12.x/controllers [laravel.com]
- Laravel. (2026). Validation — Laravel 12.x documentation. https://laravel.
  com/docs/12.x/validation [laravel.com]
- Laravel. (2026). Database: Getting started — SQLite configuration.
  https://laravel.com/docs/12.x/database [laravel.com]
- Laragon. (n.d.). Laragon
  documentation. https://laragon.org/docs [laragon.org]

<br>


> - Some content was generated with the assistance of Microsoft CoPilot

---
layout: end
---

# A rubber duck is not just a gift... they are a coder's companion for life
