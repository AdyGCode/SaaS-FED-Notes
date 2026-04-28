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

<Toc minDepth="1" maxDepth="1" columns="2" />

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

::left::

## Verb - Operation Match

1. In pairs, decide which verb fits each action in a contact book.

    - View list of contacts,
    - Create a contact,
    - View one contact,
    - Update a contact,
    - Remove a contact.

---
layout: two-cols
level: 2
---

# Ice Breaker

::left::

## Verb - Operation Match

1. In pairs, decide which verb fits each action in a contact book.

    - View list of contacts,
    - Create a contact,
    - View one contact,
    - Update a contact,
    - Remove a contact.

::right::

## URL Map and Status Codes

2. Map each verb to a URL (e.g., /contacts/42) and a status code you’d
   expect back.

---
layout: section
---

# What are CRUD/BREAD & HTTP Verbs

--- 
level: 2
layout: two-cols
---

# BREAD & CRUD

Two acronyms with similar meanings

::left::

## CRUD

- Create
- Retrieve / Read
- Update
- Delete / Destroy

::right::

## BREAD

- Browse
- Read
- Edit
- Add
- Delete / Destroy

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
level: 2
layout: two-cols
---

# What are HTTP Verbs

::left::

## HTTP Verbs

- HTTP verbs (aka “HTTP methods”) express intent:
    - GET,
    - POST,
    - PUT,
    - PATCH,
    - DELETE,
    - HEAD,
    - OPTIONS.

::right::

## Important Notes

- Some are safe and idempotent: e.g.
    - GET is safe/idempotent,
    - PUT/DELETE are idempotent,
    - POST is neither.
- Core semantics
    - standardised by IETF RFC 9110 (2022)
    - applies across HTTP/1.1, HTTP/2, HTTP/3.

---
level: 2
layout: two-cols
---

# Examples: HTTP Verbs in Requests

::left::

### Get All "contacts"

URI: http://contact-list.test/contacts

```http
GET /contacts HTTP/1.1
Host: contact-list.test
```

::right::

### Post Request to create a Contact

URI: http://contact-list.test/contacts

```http
POST /contacts HTTP/1.1
Host: contact-list.test
Content-Type: application/json

{
    "name":"Ada Lovelace",
    "email":"ada@example.com"
}
```

---
level: 2
layout: two-cols
---

# Examples: HTTP Verbs in Requests 2

::left::

### Get One Contact (ID 1)

URI: http://contact-list.test/contacts/1

```http
GET /contacts/1 HTTP/1.1
Host: contact-list.test
```

::right::

## Update a contact  (ID 1)

Replace ALL data (`PUT`) in contact #1

URI: http://contact-list.test/contacts/1

```http
PUT /contacts/1 HTTP/1.1
Host: contact-list.test
Content-Type: application/json

{
    "name": "Ada Lovelace",
    "email": "ada.lovelace@example.com"
}
```

---
level: 2
layout: two-cols
---

# Examples: HTTP Verbs in Requests 3

::left::

## Update a contact (ID 1)

Replace SOME data (`PATCH`) in contact #1

URI: http://contact-list.test/contacts/1

```http
PATCH /contacts/1 HTTP/1.1
Host: contact-list.test
Content-Type: application/json

{
    "email": "ada.new@example.com"
}
```

::right::

## Delete a contact (ID 1)

URI: http://contact-list.test/contacts/1

```http
DELETE /contacts/1 HTTP/1.1
Host: contact-list.test
```

---
layout: section
---

# HTTP Verbs, Routes & CRUD/BREAD Operations

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
// Auth routes added when authentication installed
// require __DIR__ . '/auth.php';

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

```php [php] {1-3|5|5-6,9|7-8|all}
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
level: 2
---

# Resourceful Routing

What if some methods are not needed?

Use the chainable methods:

- `->only()`, and
- `->except()`

Example: Only index, show wanted...

````md magic-move
```php [PHP] {1-2,7|all}
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    Route::get('/contacts', [ContactController::class, 'index'])
        ->name('contacts.index');
    Route::get('/contacts/{contact}', [ContactController::class, 'show'])
        ->name('contacts.show');
});
```

```php [PHP] {1,2,5|all}
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    Route::resource('contacts', ContactController::class)
        -> only(['index','show']);
});
```

```php [PHP] {1-3,5|all}
// Authenticated user access to contacts
Route::middleware('auth')->group(function () {
    Route::resource('contacts', ContactController::class)
        -> except(['store','put','patch','destroy']);
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

- Use Form Requests to centralise validation & authorisation.

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

Example Simple Controller signature

```php
public function update(Request $request, string $id)
{ /* ... */ }
```

### Why?

Two useful outcomes:

- Injects the Contact when found, or
- Injects and reroutes to give a 404 if not found.

Route-Model Binding Controller Method Signature

```php
public function update(Request $request, Contact $contact)
{ /* ... */ }
```

---
level: 2
layout: two-cols
---

# Laravel Route-Model Binding

<br>

### The Binding

- Replace `int $id` with `Contact $contact`
- Contact model is imported via `use \App\Models\Contact;`

::left::

### Without Route-Model Binding

```php
Route::get('/contacts/{$id}', 
    [ContactController::class, 'show'])
->name('web.contacts.show');
```

```php
public function show(string $id) {
    $contact = Contact::findOrFail($id); 
    return view('contacts.show')
        ->with('contact', $contact); 
}
```

::right::

### With Route Model Binding

```php
Route::get('/contacts/{$contact}',
    [ContactController::class, 'show'])
->name('web.contacts.show');
```

```php
public function show(Contact $contact) { 
      return view('contacts.show')
        ->with('contact', $contact);  
    }
```


---
layout: section
---

# Validation / Authorisation Requests

--- 
level: 2
layout: two-cols
---

# Validation / Authorisation Requests

Requests are stored in `app\Http\Requests`.

::left:: 

They provide two features by default:
- Authorisation to perform a request
- Validation of data sent to the request

By default, we get:
- Update MODEL_NAME Request and Create MODEL_NAME Request
- We may add others

::right:: 

Created using:

```shell
php artisan make:request NAME_OF_REQUEST
```

Where NAME_OF_REQUEST would be similar to:

```shell
StoreContactUsRequest
```

--- 
level: 2
layout: two-cols
---

# Validation / Authorisation Requests 2

<br>

## Request Code Structure

Two parts:

```php [PHP] {none|1-4|6-11|all}
    public function authorize(): bool
    {
        return false;
    }

    public function rules(): array
    {
        return [
            //
        ];
    }
```


--- 
level: 2
layout: two-cols
---

# Validation / Authorisation Requests 3

::left::

## authorize

By default, access is presented (`false`)

Example options:

- allow everyone access: <br>`true`
- logged-in, allow access:<br> `auth()`
- logged-in, apply permission: <br>`auth()->can('users-edit-any')`


::right::

## validate

By default, there is no validation

Example:

```php
return [
    'email': [
        'required',
        'email',
        'unique:users',
    ],
'given_name': [
    'nullable',
    'max:64',
],
```


--- 
level: 2
layout: two-cols-2-1
---

# Validation / Authorisation Requests 4

::left::

### Another example:
```php
return [
    'name' => ['required', 'min:2', 'max:192',],
    'email' => [
        'required',
        'string',
        'email',
        'max:255',
        Rule::unique(User::class)->ignore($user),
    ],
    'password' => [
        'sometimes',
        'nullable',
        'confirmed',
        Rules\Password::defaults()
    ],
    'role' => ['nullable',],
];
```

::right::

### Note on Validation

- Has many options.
- Including, but not limited to:

`Accepted` `After`  <br> `Alpha`
`Between` 
`Contains` <br> 
`Confirmed` 
`Extensions` <br> 
`Filled` 
`Declined If` <br>
`Min` 
`Doesnt End With` <br>
`IP Address` <br> 
`Not In` 
`Missing` <br>
`Max Digits` 
`Unique` <br>
`Sometimes` 
`MIME Types` 



---
layout: section
---

# Implementing Basic CRUD/BREAD

--- 
level: 2
layout: two-cols
---

# Implementing Basic CRUD/BREAD

::left::

## Create these:

- Model,
- Migration, 
- Factory,
- Seeder, 
- Form Requests, 
- Controller, 
- Routes

::right::

## When "making":

Using `artisan make` for most of these...

- Stub files are created quickly.

- Actual code takes a little time.

but...

- Routes added manually

--- 
level: 2
---

# Implementing Basic CRUD/BREAD 2

## Artisan "make" Sub-Commands

| Create     | Artisan Command   | Example                                            |
|------------|-------------------|----------------------------------------------------|
| Model      | `make:model`      | `php artisan make:model Contact`                   |
| Migration  | `make:migration`  | `php artisan make:migration create_contacts_table` |
| Factory    | `make:factory`    | `php artisan make:factory ContactFactory`          |
| Seeder     | `make:seeder`     | `php artisan make:seeder ContactSeeder`            |
| Controller | `make:controller` | `php artisan make:controller ContactController`    |
| Request    | `make:request`    | `php artisan make:request StoreContactRequest`     |

--- 
level: 2
layout: two-cols-2-1
---

# Implementing Basic CRUD/BREAD 3

::right:: 

### Creates...

- Model
- Migration
- Seeder
- Factory
- Pest Test
- Policy
- Resourceful Controller
- Request

::left::

### One-Shot Make

```shell
php artisan make:model MODEL_NAME --all --seed --pest 
```

or

```shell
php artisan make:model MODEL_NAME -as --pest
```

`MODEL_NAME`: **singular** PascalCase version of the table/entity.

For more details use `php artisan make:model --help`.

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

## Creating Contacts Feature

For demonstration purposes, we presume a **Contact** has:

- `title`, `given_name`, `family_name`, `nick_name`, and `email`, only.

The instructions presume you have your application in a folder
`contact-list-2026-s1`.

```shell
cd contact-list-2026-s1
```

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

## Creating Stubs

```shell [Shell]
php artisan make:model Contact
php artisan make:migration create_contacts_table
php artisan make:factory ContactFactory
php artisan make:seeder ContactSeeder
php artisan make:controller ContactController
php artisan make:request StoreContactRequest
# etc
```

to be 'lazy' use:

```shell [Shell]
php artisan make:model Contact -as --pest
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Migration code

Open `database/migrations/YYYY_MM_DD_HHMMSS_create_contacts_table.php`:

```php [PHP] {all}
Schema::create('contacts', function (Blueprint $table) {
    $table->id();
    $table->string('title', 16)->nullable();
    $table->string('given_name', 64);
    $table->string('family_name', 64)->nullable();
    $table->string('nick_name', 32)->nullable();
    $table->string('email', 360)->nullable();
    // TODO: Create update migration to add user - contact relationship
    $table->timestamps();
    // TODO: Create update migration to add indexes
});
```

- `nullable()` may be empty

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code

Open the `database\seeders\DatabaseSeeder.php` class file.

Start by adding the 'database' seeder code, which invokes each model's seeder
in turn.

```php [PHP] {1-2,11|1-4,10-13|1-4,5-7,10-13|1-4,8-9,10-13|all}
public function run(): void
{
    $this->call(
        [
            // When using Spatie Permissions, perform the Role / Permission 
            // seeding FIRST. e.g. RolePermissionSeeder::class,
            UserSeeder::class,
            // Add further seeder classes here. e.g. ContactSeeder::class,
            ContactSeeder::class,
        ]
    );
}
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code (Users)

The `User` Model and `users` Table are created automatically by Laravel.

We primarily add seed users for testing...

Create a User Seeder class:

```shell
php artisan make:seeder UserSeeder 
```

Open the `database\seeders\UserSeeder.php` class file.

Edit the `run` method...

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code (Users)

<Announcement type="info">
Note that this is quite long, so we will show each user separately.
</Announcement>

```php [PHP] {all}
public function run(): void
{
    // Seeder code is added in two stages:
    // - List of Seed Users
    // - Creation Code
}
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code (Users)

````md magic-move

```php [PHP] {1-4,9-10|4-8|all}
public function run(): void
{
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // seed users added here
    ];

    // - Creation code
}
```

```php [PHP] {1-3,14-15|4-13|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        [
            'id' => 99,
            'name' => 'Super Admin',
            'email' => 'supervisor@example.com',
            'password' => 'Password1',
            'email_verified_at' => now(),
            'roles' => ['super-user', 'admin'],
            'permissions' => [],
        ],
        // Next seed user (100)...
    ];
    // - Creation code
```

```php [PHP] {1-4,14-17|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 99 hidden for brevity
        [
            'id' => 100,
            'name' => 'Admin I Strator',
            'email' => 'admin@example.com',
            'password' => 'Password1',
            'email_verified_at' => now(),
            'roles' => ['admin'],
            'permissions' => [],
        ],
        // Next seed user (200)...
    ];
    // - Creation code
```

```php [PHP] {1-4,14-17|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 100 hidden for brevity
        [
            'id' => 200,
            'name' => 'Staff User',
            'email' => 'staff@example.com',
            'password' => 'Password1',
            'email_verified_at' => now(),
            'roles' => ['staff'],
            'permissions' => [],
        ],
        // Next seed user (300) ...
    ];

    // - Creation code
```

```php [PHP] {1-4,14-17|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 200 hidden for brevity
        [
            'id' => 300,
            'name' => 'Client User',
            'email' => 'client@example.com',
            'password' => 'Password1',
            'email_verified_at' => now(),
            'roles' => ['client'],
            'permissions' => [],
        ],
        // Next seed user (301) here...
    ];

    // - Creation code
```

```php [PHP] {1-4,14-17|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 300 hidden for brevity
        [
            'id' => 301,
            'name' => 'Client User II',
            'email' => 'client2@example.com',
            'password' => 'Password1',
            'email_verified_at' => null,
            'roles' => ['client'],
            'permissions' => [],
        ],
        // Next seed user (302) here...
    ];

    // - Creation code
```

```php [PHP] {1-4,14-17|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 301 hidden for brevity
        [
            'id' => 302,
            'name' => 'Client User III',
            'email' => 'client3@example.com',
            'password' => 'Password1',
            'email_verified_at' => null,
            'roles' => ['client'],
            'permissions' => [],
        ],
        // Next seed user (303) here...
    ];

    // - Creation code
```

```php [PHP] {1-4,16-18|all}
    // Seeder code is added in two stages:
    // - List of Seed Users
    $seedUsers = [
        // Previous seed user 302 hidden for brevity
        [
            'id' => 303,
            'name' => 'Client User IV',
            'email' => 'client4@example.com',
            'password' => 'Password1',
            'email_verified_at' => null,
            'suspended_at' => now(),
            'roles' => ['client'],
            'permissions' => [],
        ],
        // No more seed users
    ];

    // - Creation code
```

```php [PHP] {1-7,16|9-12|14-15|all}
public function run(): void
{
    // Seeder code is added in two stages:
    // - List of seed users
    $seedUsers = [
        // Seed user data hidden for brevity
    ];

    // - Creation code
    foreach ($seedUsers as $newUser) {
        // Create each seed user in turn here
    }

    // Uncomment the line below to create (10) randomly named users using the User Factory.
    // User::factory(10)->create();
}
```

```php [PHP] {1-4,11-15|5-10|all}
    // - List of Seed Users hidden for brevity

    // - Creation code
    foreach ($seedUsers as $newUser) {

        // grab the roles & additional permissions from the seed users
        $roles = $newUser['roles'];
        unset($newUser['roles']);
        
        // more code to come (~10 lines)
    }

    // Uncomment the line below to create (10) randomly named users using the User Factory.
    // User::factory(10)->create();
}
```

```php [PHP] {1-6,12-15|5-11}
    // - List of Seed Users hidden for brevity

    // - Creation code
    foreach ($seedUsers as $newUser) {

        // grab the roles ... cut for brevity

        $permissions = $newUser['permissions'];
        unset($newUser['permissions']);

        // More code to come (~7 lines)
    }

    // Uncomment the line below to create (10) randomly named users using the User Factory.
    // User::factory(10)->create();
}
```

```php [PHP] {1-6,14-18|5-13}
    // - List of Seed Users hidden for brevity

    // - Creation code
    foreach ($seedUsers as $newUser) {

        // permissions code hidden for brevity
        // if the seed user is not found, create them, otherwise update
        $user = User::updateOrCreate(
            ['id' => $newUser['id']],
            $newUser
        );
        
        // Three (commented) lines to come
    }

    // Uncomment the line below to create (10) randomly named users using the User Factory.
    // User::factory(10)->create();
}
```

```php [PHP] {1-6,14-18|7-11}
   // - List of Seed Users hidden for brevity

    // - Creation code
    foreach ($seedUsers as $newUser) {

        // roles, permissions & create code removed

        // Uncomment this line when using Spatie Permissions
        // $user->assignRole($roles);
        // $user->assignPermissions($permissions);

    }

    // Uncomment the line below to create (10) randomly named users using the User Factory.
    // User::factory(10)->create();
}
```

````

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Practice - Seeder Code (Contacts)

The following slides give you steps to create the contacts seeder.

## Creating Seeder File

If you have not done so already, create the seeder file using:

```shell
php artisan make:seeder ContactSeeder
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Practice - Seeder Code (Contacts)

### Edit the File

Open the `database\seeders\ContactSeeder.php` class file.

The seeder follows the same 'pattern' as the `UserSeeder.php` class.

- Seed Contacts
- Creation Code

We start by creating a 'blank contact' associative array that we can
duplicate.

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code (Contacts)

Update the run method to have the following basic structure:

```php
    public function run(): void
    {
        $seedContacts = [
            [
                'title' => '',
                'given_name' => '',
                'family_name' => '',
                'nick_name' => '',
                'email' => '',
                'user_id' => 000,
            ],
        ];
        // Creation code here...
    }
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Code (Contacts)

- Select the `[ 'title'=>` ... to ... `000, ],`
- Duplicate this 29 times (total 30 copies)
- Fill in the data from the following table(s) into the templates

Any fields that have no data remove them, for example:

```php
    [
        'given_name' => 'Isaac',
        'nick_name' => 'Gravity Falls',
        'user_id' => 100,
    ],
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Data (Contacts)

| title | given_name | family_name | nick_name | email                    | user_id |
|-------|------------|-------------|-----------|--------------------------|---------|
| Ms    | Penny      | Lane        |           | Penny.Lane@example.com   | 303     |
| Dr    | Maura      | Less        |           | Maura.Less@example.com   | 300     |
|       | Kitty      | Litter      | Kit       | Kitty.Litter@example.com | 302     |
| Ms    | Dot        | Matrix      | Dotty     | Dot.Matrix@example.com   | 200     |
| Cllr  | Robin      | Money       | Rob       | Robin.Money@example.com  | 100     |
|       | Chip       | Munk        | Woody     | Chip.Munk@example.com    | 303     |

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Data (Contacts)

| title | given_name | family_name | nick_name | email                   | user_id |
|-------|------------|-------------|-----------|-------------------------|---------|
|       | Rusty      | Nails       |           | Rusty.Nails@example.com | 300     |
|       | Hazel      | Nutt        | Crackers  | Hazel.Nutt@example.com  | 200     |
| Ms    | Zoe        | Ology       |           | Zoe.Ology@example.com   | 100     |
|       | Rick       | O'Shea      |           | Rick.O'Shea@example.com | 303     |
| Mstr  | Tad        | Pole        | Tad       | Tad.Pole@example.com    | 200     |
| Mstr  | Peter      | Pan         |           | Peter.Pan@example.com   | 302     |

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Data (Contacts)

| title | given_name | family_name | nick_name | email                     | user_id |
|-------|------------|-------------|-----------|---------------------------|---------|
| Dame  | Holly      | Day         |           | Holly.Day@example.com     | 301     |
|       | Dwayne     | Pipe        |           | Dwayne.Pipe@example.com   | 100     |
| Mr    | Samson     | Knight      |           | Samson.Knight@example.com | 300     |
|       | May        | Day         |           | May.Day@example.com       | 301     |
| Mr    | Mason      | Knight      |           | Mason.Knight@example.com  | 300     |
| Dr    | Lou        | Pole        |           | Lou.Pole@example.com      | 200     |

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Data (Contacts)

| title | given_name | family_name | nick_name | email                     | user_id |
|-------|------------|-------------|-----------|---------------------------|---------|
| Mrs   | Lily       | Pond        |           | Lily.Pond@example.com     | 301     |
|       | Jack       | Pott        |           | Jack.Pott@example.com     | 300     |
| HRH   | Owen       | Money       |           | Owen.Money@example.com    | 100     |
|       | Will       | Power       | Zap       | Will.Power@example.com    | 302     |
|       | Dee        | Zaster      | Dee       | Dee.Zaster@example.com    | 200     |
| Mrs   | Tamara     | Knight      | Tam       | Tamara.Knight@example.com | 300     |

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Seeder Data (Contacts)

| title | given_name | family_name | nick_name | email                    | user_id |
|-------|------------|-------------|-----------|--------------------------|---------|
| Prof  | Jed I.     | Knight      | Obi-wan   | Jed.I.Knight@example.com | 300     |
| Mrs   | Sandy      | Beach       |           | Sandy.Beach@example.com  | 303     |
| Sir   | Sonny      | Day         |           | Sonny.Day@example.com    | 301     |
|       | Windy      | Day         |           | Windy.Day@example.com    | 301     |
| Mr    | Rocky      | Beach       |           | Rocky.Beach@example.com  | 303     |
|       | Rusty      | Dorr        | Squeeky   | Rusty.Dorr@example.com   | 100     |

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Model Code

The Contact model requires us to define the:

- fillable fields,
- protected fields and
- type casts.

We are also able to define:

- utility methods,
- calculated attributes
- relationships between models and
- other business logic.

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Model Code

Open the `App\Models\Contact.php` model class file.

Add the code to the class definition:

````md magic-move

```php
/**
 * Mass assignable attributes (table fields)
 *
 */
protected $fillable = [
    'given_name',
    'family_name',
    'nick_name',
    'title',
    'email',
    'user_id',
];

```

```php [PHP] {7-12}

protected $fillable = [ ... ]; // code folded to save space

/**
 * Hidden from serialisation attributes (fields)
 *
 */
protected $hidden = [];

```

```php [PHP] {5-12}
protected $fillable = [ ... ]; // code folded to save space

protected $hidden = [];        // code folded to save space

/**
 * Attribute (type) casting
 *
 */
protected function casts(): array{
    return [];
}
```


````

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Execute migration and Seeders

Executes new migrations: both create & update

```shell
php artisan migrate
```

<br>

### Fresh migration

<Announcement type="error">
This DESTROYS all existing data. <br> DO NOT use on a production / live databas.
</Announcement>

Migrating from the beginning: drops all tables & deletes all data

```shell
php artisan migrate:fresh
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Execute migration and Seeders

### Seed Database

Seeding a database may be executed for:

- all seeders, or
- individual seeders.

Run all seeders:

```shell
php artisan db:seed
```

Run a given seeder (e.g. ContactSeeder):

```shell
php artisan db:seed --seeder=ContactSeeder
```

---
level: 2
---

# Implementing Basic CRUD/BREAD

## Recreate Tables & Seed from Scratch

<Announcement type="info" title="Make a fresh start">
<p>When working on a <strong>TESTING</strong>/<strong>DEVELOPMENT</strong> 
system you <strong>MAY</strong> want to use the following artisan command 
to...</p>
<ul>
<li>Drop all tables</li> 
<li>Delete all data</li> 
<li>Execute all migrations (create & update)</li>
<li>Execute all seeders</li>
</ul>
</Announcement>

```shell
php artisan migrate:fresh --seed
```

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

--- 
level: 2
---

# Implementing Basic CRUD/BREAD

--- 
level: 2
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


> Some content may have been generated with the assistance of Microsoft CoPilot

---
layout: end
---

# A rubber duck is not just a gift... they are a coder's companion for life
