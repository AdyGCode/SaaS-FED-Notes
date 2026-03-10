---
theme: nmt
background: https://cover.sli.dev
title: Session 06 - Laravel CRUD / BREAD
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 06: CRUD/BREAD Basics

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

- Explain what HTTP verbs mean and how safe/idempotent methods affect design.
- Map CRUD/BREAD to verbs and typical status codes for web flows.
- Use Laravel 12 routes, resourceful routing, and route model binding
  effectively.
- Implement basic validation (Form Requests) and return redirects properly.
- Configure SQLite for dev and run via Laragon on Windows.

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
layout: section
---

# Ice Breaker
---
layout: two-cols
level: 2
---

# Ice Breaker

::left::

## Verb - Operation Match

1. In pairs, decide which verb fits each action in a contact book.

- View list,
- Add a contact,
- See one contact,
- edit a contact,
- delete a contact.

---
layout: two-cols
level: 2
---

# Ice Breaker

::left::

## Verb - Operation Match

1. In pairs, decide which verb fits each action in a contact book.

- View list,
- Add a contact,
- See one contact,
- edit a contact,
- delete a contact.

::right::

## URL Map and Status Codes

2. Map each verb to a URL (e.g., /contacts/42) and a status code you’d
   expect back.

---
layout: section
---

# What are CRUD/BREAD

Two acronyms with similar meanings

--- 
level: 2
---

# What is CRUD

| Initial | Title            | Description                                                    |
|---------|------------------|----------------------------------------------------------------|
| C       | Create           | Act of adding data to the data store                           |
| R       | Retrieve / Read  | When one or more item of data is retrieved from the data store |
| U       | Update           | Changing one or more item stored in the data store             |
| D       | Delete / Destroy | The removal of one or more items from the data store           |

--- 
level: 2
---

# What is BREAD

Often used in Administration UIs

| Initial | Title            | Description                                                                           |
|---------|------------------|---------------------------------------------------------------------------------------|
| B       | Browse           | Reading and displaying more than one item from the data store.<br> e.g. Browse All.   |
| R       | Read             | Used when retrieving one item of data from the data store and showing it to the user. |
| E       | Edit             | Changing one or more item stored in the data store                                    |
| A       | Add              | Creation of one or more item of data and storing in the data store                    |
| D       | Delete / Destroy | The removal of one or more items from the data store                                  |

---
layout: section
---

# What are HTTP Verbs

--- 
level: 2
layout: two-cols
---

# What are HTTP Verbs

::left::

- HTTP verbs (aka “HTTP methods”) express intent:
    - GET,
    - POST,
    - PUT,
    - PATCH,
    - DELETE,
    - HEAD,
    - OPTIONS.
      ::right::
- Some are safe and idempotent: e.g.
    - GET is safe/idempotent,
    - PUT/DELETE are idempotent,
    - POST is neither.
- Core semantics standardized by IETF RFC 9110 (2022)
    - applies across HTTP/1.1, HTTP/2, HTTP/3.

---
lavel: 2
---

# Examples: HTTP Verbs in Requests

### Get Request to "contacts"

```http
GET /contacts HTTP/1.1
Host: contact-list.test
```

### Post Request to create a Contact

```http
POST /contacts HTTP/1.1
Content-Type: application/json

{
    "name":"Ada Lovelace",
    "email":"ada@example.com"
}
```

---
layout: section
---

# HTTP Verbs & CRUD/BREAD Operation Mapping

--- 
level: 2
---

# HTTP Verbs & CRUD/BREAD Operations

Typical mapping & status codes (Web + API):

| BREAD  | Method  | HTTP Verb        | URI              | Status Code / Details                                       |
|--------|---------|------------------|------------------|-------------------------------------------------------------|
| Browse | index   | `GET`            | `/contacts`      | 200 OK.                                                     |
| Read   | show    | `GET`            | `/contacts/{id}` | 200 OK.                                                     |
| Add    | store   | `POST`           | `/contacts`      | 201 Created + Location header redirect (web) or JSON (api). |
| Edit   | update  | `PUT` or `PATCH` | `/contacts/{id}` | 200 OK or 204 No Content.                                   |
| Delete | destroy | `DELETE`         | `/contacts/{id}` | 204 No Content.                                             |

---
layout: section
---

# HTTP Verbs and Laravel Routes

--- 
level: 2
---

# HTTP Verbs and Laravel Routes

The `routes\web.php` routes file may be split into several files.

This can aid with maintenance and make it easier to develop additional 
features.

Suggested files:

- `routes\web.php` - Primary Web Routes
- `routes\web.static.php` - Guest/Visitor Routes
- `routes\web.client.php` - Client (Logged-in user) Routes
- `routes\web.admin.php` - The Administration Routes

--- 
level: 2
---

# HTTP Verbs and Laravel Routes 2

### Primary Routes File: `routes\web.php`

```php [PHP] {1|2|3|4|5|all}
<?php

require __DIR__ . '/web.static.php';
require __DIR__ . '/web.client.php';
require __DIR__ . '/web.admin.php';
require __DIR__ . '/auth.php';

```

--- 
level: 2
---

# HTTP Verbs and Laravel Routes 3

### Guest/Visitor Routes: `routes\web.static.php`

```php [PHP] {1-2|4-5|7,14|7-8,14|7-10,14|7,12-14|all}
use App\Http\Controllers\Web\StaticPageController;
use Illuminate\Support\Facades\Route;

Route::get('/', [StaticPageController::class, 'home'])
    ->name('home');

Route::name('web.static.')->group(function () {
    // Actual web route name will be: web.static.contact
    Route::get('/contact-us', [StaticPageController::class, 'contact'])
        ->name('contact');

    Route::get('/privacy', [StaticPageController::class, 'privacy'])
        ->name('privacy');
});

```

--- 
level: 2
---

# HTTP Verbs and Laravel Routes 4

### Client (Logged-in user) Routes: `routes\web.client.php` 
<small>Longer code snippet, all in same file</small>

````md magic-move

```php [PHP] {1-3|5|5-6,9|7-8|all}
use App\Http\Controllers\Client\DashboardController;
use App\Http\Controllers\Client\ProfileController;
use Illuminate\Support\Facades\Route;

// Show the Logged in User Dashboard
Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'dashboard'])
        ->name('dashboard');
});

```

```php [PHP] {1-2,9|1-4|1-2,5-6,9|1-2,7-9|all}
// Authenticated user's profile details Routes 
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])
        ->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])
        ->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])
        ->name('profile.destroy');
});
```


```php [PHP] {1-2,17|1-4,17|1-2,5-6,17|1-2,7-8,17|1-2,9-10,17|1-2,11-12,17|1-2,13-14,17|1-2,15-17|all}
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    Route::get('/contacts', [ContactController::class, 'index'])
        ->name('contacts.index');
    Route::get('/contacts/create', [ContactController::class, 'create'])
        ->name('contacts.create');
    Route::post('/contacts', [ContactController::class, 'store'])
        ->name('contacts.store');
    Route::get('/contacts/{contact}', [ContactController::class, 'show'])
        ->name('contacts.show');
    Route::get('/contacts/{contact}/edit', [ContactController::class, 'edit'])
        ->name('contacts.edit');
    Route::put('/contacts/{contact}', [ContactController::class, 'update'])
        ->name('contacts.update');
    Route::delete('/contacts/{contact}', [ContactController::class, 'destroy'])
        ->name('contacts.destroy');
});
```

````

---
layout: section
---

# Resourceful Routing

--- 
level: 2
---

# Resourceful Routing

Reduction of many route lines into a single line.

````md magic-move
```php [PHP] {1-2,17|all}
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    Route::get('/contacts', [ContactController::class, 'index'])
        ->name('contacts.index');
    Route::get('/contacts/create', [ContactController::class, 'create'])
        ->name('contacts.create');
    Route::post('/contacts', [ContactController::class, 'store'])
        ->name('contacts.store');
    Route::get('/contacts/{contact}', [ContactController::class, 'show'])
        ->name('contacts.show');
    Route::get('/contacts/{contact}/edit', [ContactController::class, 'edit'])
        ->name('contacts.edit');
    Route::put('/contacts/{contact}', [ContactController::class, 'update'])
        ->name('contacts.update');
    Route::delete('/contacts/{contact}', [ContactController::class, 'destroy'])
        ->name('contacts.destroy');
});
```

```php
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    // Generates index/create/store/show/edit/update/destroy with
    // conventional names and URIs.
    Route::resource('contacts', ContactController::class);
});
```
````

---
layout: section
---

# Laravel Routes & Controller Methods

## “Thin routes, focused controllers”
--- 
level: 2
---

# Laravel Routes & Controller Methods

### Best Practice:
- Use Form Requests to centralize validation & authorization.

Following code shows a simple version of each controller method

````md magic-move

```php [php] {1,7-8,12|1-8,12|all}
namespace App\Http\Controllers;

use App\Http\Requests\StoreContactRequest;
use App\Http\Requests\UpdateContactRequest;
use App\Models\Contact;

class ContactController extends Controller
{

    // Controller Methods will be added here
    
} // End of Contact Controller
```

```php [php] {1-2,11|1-3,7,11|1-5,7,11|1-3,6-7,11|all}
class ContactController extends Controller
{
    public function index()  { 
        $contacts = Contact::latest()
            ->paginate(10); 
        return view('contacts.index', compact('contacts')); 
    }
    
    // create method replaces this line
    
} // End of Contact Controller
```

```php [php] {1-3,11|1-2,5,7,11|1-5,7,11|1-2,5-7,11|all}
class ContactController extends Controller
{
    // index method before this method
    
    public function create() { 
        return view('contacts.create'); 
    }
    
    // store method replaces this line

} // End of Contact Controller
```


```php [php] {1-3,14|1-5,10-11,14|1-6,10-11,14|1-5,7-9,14|all}
class ContactController extends Controller
{
    // index, create methods before this method

    public function store(StoreContactRequest $request) { 
        $contact = Contact::create($request->validated()); 
        return redirect()
            ->route('contacts.show', $contact)
            ->with('status','Created'); 
    }

    // show method replaces this line

} // End of Contact Controller
```


```php [php] {1-2,11|1-3,7,11|1-5,7,11|1-3,6-7,11|all}
class ContactController extends Controller
{
    // index, create, store methods before this method

    public function show(Contact $contact) { 
      return view('contacts.show', compact('contact')); 
    }
    
    // edit method replaces this line
   
} // End of Contact Controller
```


```php [php] {1-2,11|1-3,7,11|1-5,7,11|1-3,6-7,11|all}
class ContactController extends Controller
{
    // index, create, store, show methods before this method

    public function edit(Contact $contact) { 
      return view('contacts.edit', compact('contact')); 
    }
    
    // update method replaces this line

    
} // End of Contact Controller
```


```php [php] {1-2,11|1-3,7,11|1-5,7,11|1-3,6-7,11|all}
class ContactController extends Controller
{

    // index, create, store, show, edit methods before this method

    public function update(UpdateContactRequest $request, Contact $contact) { 
        $contact->update($request->validated()); 
        return redirect()
            ->route('contacts.show', $contact)
            ->with('status','Updated'); 
    }

    // destroy method replaces this line
    
} // End of Contact Controller
```


```php [php] {1-2,11|1-3,7,11|1-5,7,11|1-3,6-7,11|all}
class ContactController extends Controller
{
    // index, create, store, show, edit, update methods before this method
    
    public function destroy(Contact $contact) { 
        $contact->delete(); 
        return redirect()
            ->route('contacts.index')
            ->with('status','Deleted'); 
    }
    
} // End of Contact Controller
```


````

---
layout: section
---

# Laravel Route-Model Binding

---
level: 2
---

# Laravel Route-Model Binding

```php
// Controller signatures
public function show(\App\Models\Contact $contact) { /* ... */ }
public function update(Request $request, \App\Models\Contact $contact) { /* ... */ }

```

Binding injects the Contact or 404s if not found. [laravel.com]

---
layout: section
---

# Implementing Basic CRUD/BREAD

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

---
layout: section
---

# Recap Checklist

---
level: 2
---

# Recap Checklist

- [ ]  I can define safe vs idempotent and pick verbs accordingly.
- [ ]  I can map CRUD/BREAD to routes, names, and status codes.
- [ ]  I can create resourceful routes and rely on route model binding.
- [ ]  I can validate with Form Requests (web gets redirect+errors, API gets
  422 JSON).
- [ ]  I can run Laravel 12 on Laragon with SQLite for dev.

---
level: 2
---

# Quick Summary

- HTTP verbs communicate intent.
- Status codes confirm outcomes.
- Laravel 12’s resourceful routing + Form Requests = fast, consistent Web &
  API.
- SQLite keeps dev friction low.

---
level: 2
---

# Exit Ticket Questions

Think back over everything we explored today:

- HTTP verbs,
- CRUD/BREAD operations,
- Laravel’s resourceful routing, and
- validation.

Now imagine you’ve been asked to extend the Contact‑List application with
a brand‑new feature (for example, tagging contacts, marking VIPs, or
bulk‑updating records).

<Announcement type="brainstorm">
What HTTP verbs, routes, controller methods, and validation rules would 
you choose — and why?
</Announcement>

<Announcement type="idea">
Explain how each decision aligns with the principles we studied and how 
it ensures a clean, maintainable, and predictable user experience.
</Announcement>

---

# Acknowledgements & References

- Fielding, R. T., Nottingham, M., & Reschke, J. (2022). HTTP semantics
  (RFC 9110). Internet Engineering Task Force (STD
  97). https://www.rfc-editor.org/info/rfc9110 [rfc-editor.org]
- Mozilla Developer Network. (2025, July 4). HTTP request methods. MDN Web
  Docs. https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Methods [developer....ozilla.org]
- Microsoft. (n.d.). Best practices for RESTful web API design. Azure
  Architecture
  Center. https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design [learn.microsoft.com]

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
  documentation. https://laragon.org/docs [laragon. org]

<br>


> - Some content was generated with the assistance of Microsoft CoPilot

---
layout: end
---

# A rubber duck is not just a gift... they are a coder's companion for life
