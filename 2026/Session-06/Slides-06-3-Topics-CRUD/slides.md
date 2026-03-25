---
theme: nmt
background: https://cover.sli.dev
title: Session 06 - Laravel CRUD / BREAD (Topics)
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 06: CRUD/BREAD Basics (Topics)

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

- Implement BREAD operations for Staff/Admin Interface
- Implement Topics administration
- Implement Requests for Create and Store
    - include validation
    - include authentication

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

# Topics BREAD/CRUD

--- 
level: 2
---

# Topics BREAD

| Action           | VERB      | http://DOMAIN/... | Route Name(s) | Notes                         |
|------------------|-----------|-------------------|---------------|-------------------------------|
| Browse           | GET       | admin/topics      |               | Show all topics               |
| Read             | GET       | admin/topics/ID   |               | Show one topic                |
| Edit             | GET       | admin/topics/ID   |               | Show the edit view            |
|                  | PUT/PATCH | admin/topics/ID   |               |                               |
| Add              | GET       | admin/topics      |               | Show the add/create view      |
|                  | POST      | admin/topics      |               |                               |
| Delete / Destroy | GET       | admin/topics/ID   |               | Show delete confirmation view |
|                  | DELETE    | admin/topics/ID   |               |                               |

---
layout: section
---

# Administration Routes <br>for Topics BREAD

--- 
level: 2
---

# Topic Administration Routes

We already know we can split `routes\web.php` into several files.

For the Topics Administration, we edit the

- `routes\web.admin.php` file

--- 
level: 2
---

# Topic Administration Routes 2

File: `routes/web.admin.php`.

<small>Longer code snippet, all in same file</small>

````md magic-move

```php [php] {1-4|6-9,13|10|11|12|all}
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\TopicController;
use App\Http\Controllers\Admin\UserManagementController;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth', 'verified'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {
       // Topics Admin Routing
       // Admin Controller Routing
       // User Admin Routing
    });
```

```php [php] {1-5|7-9|10-11|13-14|all}
// use lines trimmed for brevity
Route::middleware(['auth', 'verified'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {

        // Topics Admin Routing
        // URL base: http://HOSTNAME/admin/topics
        // Route Names: admin.topics.*
        Route::resource('topics', TopicController::class)
            ->except(['show', 'edit', 'update', 'destroy']);

       // Admin Controller Routing goes here
       // User Admin Routing goes here
    });
```

```php [php] {1-5,7|9-11|13|all}
// use lines trimmed for brevity
Route::middleware(['auth', 'verified'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {

        // Topics Admin Routing goes here

        // Admin Controller Routing
        Route::get('/', [AdminController::class, 'index'])
            ->name('index');

       // User Admin Routing goes here
    });
```

```php [php] {1-9,13|11-12|all}
// use lines trimmed for brevity
Route::middleware(['auth', 'verified'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {

        // Topics Admin Routing goes here

        // Admin Controller Routing goes here

       // User Admin Routing 
        Route::resource('users', UserManagementController::class);
    });
```

````

> Remember that `->except()` allows us to allow routes other than those
> listed.


---
layout: section
---

# Topic Migration, Model, Controller and more

<br>

## Creating the stubs for the Topic Admin

--- 
level: 2
---

# Topic Migration, Model, Controller and more

We need to create:

- Migration
- Model
- Controller (Resourceful)
- Create & Update Requests
- Factory
- Seeder

Use `php artisan make` to do this.

<br>

<Announcement type="info">
Remember you can add <code>--help</code> to get assistance with an artisan 
command.
</Announcement>

--- 
level: 2
---

# Topic Migration, Model, Controller and more

<br>

## All New Classes

```shell
php artisan make:model Topic -ars --pest
```

Creates:

- `app/Http/Controllers/TopicController.php`
- `app/Http/Requests/StoreTopicRequest.php`,
  `app/Http/Requests/UpdateTopicRequest.php`
- `app/Models/Topic.php`
- `database/factories/TopicFactory.php`
- `database/migrations/2026_03_03_014357_create_topics_table.php`
- `database/seeders/TopicSeeder.php`
- `tests/Feature/Http/Controllers/Admin/TopicControllerTest.php`

--- 
level: 2
---

# Topic Migration, Model, Controller and more

<br>

## Missing Classes

If somethign is missing you may use the `make:OPTION` command to add the
missing
items.

```shell
php artisan make:model Topic
php artisan make:migration create_topic_table
php artisan make:seeder TopicSeeder
php artisan make:factory TopicFactory
php artisan make:controller Admin/TopicController
php artisan make:request StoreTopicRequest
php artisan make:request UpdateTopicRequest
```

<Announcement type="info">
Controller names: 
<code>Admin/TopicManagementController</code> or 
<code>Admin/TopicAdminController</code>
</Announcement>

--- 
level: 2
---

# Topics Admin: Browse sub-feature

Begin with the "browse":

- Migration
- Seeder
- Route
- Controller index method

---
level: 2
---

# Topics Admin: Browse sub-feature

## Migration

Open `database/migrations/yyyy_mm_dd_hhmmss_create_topics_table.php`

Edit the contents to add the fields:

| field name | type   | size | other                     |
|------------|--------|------|---------------------------|
| name       | string | 16   | unique, default "general" |
| description | string | | nullable |
| available | boolean | | default false |

<br>

<Announcement type="info">
Remember that yyyy_mm_dd_hhmmss is the year, month, day and time the file was 
created.
</Announcement>

---
level: 2
---

# Topics Admin: Browse sub-feature

## Migration

```php [PHP] {all}
    public function up(): void
    {
        Schema::create('topics', function (Blueprint $table) {
            $table->id();
            $table->string('name',16)->unique()->default("general");
            $table->string('description')->nullable();
            $table->boolean('available')->default(false);
            $table->timestamps();
        });
    }
```

---
level: 2
---

# Topics Admin: Browse sub-feature

## Seeder

The seeder `database\TopicSeeder.php` will add the base/demo topics for 
the application.

````md magic-move

```php [PHP] {1-2,16|4-7|9,14|10-13|9-14|all}
public function run(): void
    {

        $seedTopics = [
            // Seed topics will be added here

        ];

        foreach($seedTopics as $seedTopic){
            // Prevent trying to insert existing topics
            if (! Topic::where('name', $seedTopic['name'])) {
                Topic::create($seedTopic);
            }
        }

    }
```


```php [PHP] {all}
public function run(): void
    {

        $seedTopics = [
            [
                'id'=>1,
                'name' => 'general',
                'description' => 'General contact messages',
                'available' => true,
            ],
            
            // more seed topics

        ];

        // foreach block hidden for brevity
    }
```


```php [PHP] {all}
public function run(): void
    {

        $seedTopics = [
            // Topic 1 hidden
            [
                'id'=>100,
                'name' => 'website errors',
                'description' => 'Website errors',
                'available' => true,
            ],
            // more topics to come

        ];

        // foreach block hidden for brevity
    }
```



```php [PHP] {all}
public function run(): void
    {

        $seedTopics = [
            // Topic 1, 100 hidden
            [
                'name' => 'website oopsie',
                'description' => 'Website errors',
                'available' => false,
            ],
            // more topics to come
        ];

        // foreach block hidden for brevity
    }
```



```php [PHP] {all}
public function run(): void
    {

        $seedTopics = [
            // Topic 1, 100, 101 hidden
            [
                'name' => 'feedback',
                'description' => 'Client feedback (positive and negative)',
                'available' => true,
            ],
            // No more 'demo' topics
        ];

        // foreach block hidden for brevity
    }
```


````

---
level: 2
---

# Topics Admin: Browse sub-feature

## Execute Migration and Seeder

Execute any new migrations (e.g. create topic table), and execute the 
corresponding seeder.

```shell
php artisan migrate
php artisan db:seed --class=TopicSeeder
```

Alternatively, in development, execute a full refresh of database:

```shell
php artisan migrate:fresh --seed
```

---
level: 2
---


# Topics Admin: Browse sub-feature

## Create TopicController Index method

Open the `App/Http/Controllers/Admin/TopicController.php` file.

Edit code to read:

```php [PHP] {1-2,8|3-4|6-7|all}
public function index()
{
    $topics = Topic::orderBy('name')
        ->paginate(3);

    return view('admin.topics.index')
        ->with('topics', $topics);
}
```

---
level: 2
---


# Topics Admin: Browse sub-feature

## Create Topics Admin Index page

Execute the commands to create a blank topic administration index page:

```shell
mkdir -p resources/views/admin/topics
touch resources/views/admin/topics/{.gitignore,index.blade.php}
```

Open the code ready to add the details for displaying the data.

---
level: 2
---


# Topics Admin: Browse sub-feature

## Create Topics Admin Index page

We are going to add HTML and blade extension code in several stages.

````md magic-move

```php
<x-admin-layout>
    {{-- Header indicating the area of administration --}}
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-white leading-tight">
            {{ __('Topics Admin') }}
        </h2>
    </x-slot>

    {{-- TODO: Add section showing the table of topics --}}

    </section>

</x-admin-layout>
```

```php
<x-admin-layout>
    {{-- We have removed the header for brevity --}}

    <section class="py-4 mx-8 space-y-4 ">
        <header class="flex justify-between">
            <h3 class="text-2xl font-bold text-zinc-700">
                Topics
            </h3>
            <x-primary-link-button href="{{ route('admin.topics.create') }}">
                Add Topic
            </x-primary-link-button>
        </header>

        {{-- Table will go here --}}
    </section>

</x-admin-layout>
```

```php
{{-- Filling in the table part --}}

<div class="overflow-x-auto rounded border border-gray-300 shadow-sm">
  <table class="min-w-full divide-y-2 divide-gray-200 bg-white">
      <thead class="ltr:text-left rtl:text-right bg-gray-700 dark:bg-gray-800">
          {{-- table header here --}}
      </thead>
      <tbody class="bg-white *:hover:bg-gray-50">
          {{-- table body here --}}
      </tbody>
      <tfoot>
          {{-- table footer here --}}
      </tfoot>
  </table>
</div>
```

```php
{{-- Filling in the table header --}}
<table class="min-w-full divide-y-2 divide-gray-200 bg-white">
    <thead class="ltr:text-left rtl:text-right bg-gray-700 dark:bg-gray-800">
    <tr class="*:font-medium  text-gray-200 dark:text-gray-300 ">
        <th class="px-3 py-2 whitespace-nowrap">#</th>
        <th class="px-3 py-2 whitespace-nowrap">Name</th>
        <th class="px-3 py-2 whitespace-nowrap">Description</th>
        <th class="px-3 py-2 whitespace-nowrap">Actions</th>
    </tr>
    </thead>
{{-- ... --}}
```

```php
{{-- filling out the table body --}}
<tbody class="bg-white *:hover:bg-gray-50">
  
  @foreach($topics as $topic)
  <tr class="*:text-gray-900 *:first:font-medium">
      <td class="px-3 py-2 whitespace-nowrap">{{ $loop->index+1 }}</td>
      <td class="px-3 py-2 whitespace-nowrap">{{ $topic->name }}</td>
      <td class="px-3 py-2 whitespace-nowrap">{{ $topic->description }}</td>
      <td class="px-3 py-2 whitespace-nowrap">Show Edit Delete</td>
  </tr>
  @endforeach

</tbody>
{{-- ... --}}
```


```php
{{-- Filling out the table footer --}}
<tfoot>
<tr>
    <td colspan="4" class="px-3 py-2 whitespace-nowrap">
        {{ $topics->links() }}
    </td>
</tr>
</tfoot>
```

````


---
level: 2
layout: two-cols
---

# Topics Admin: Browse sub-feature

<br>

## Topics Admin - Create and Store

We will create the following:

::left::

#### create method
  - shows the `create.blade.php` page

<br>

#### create page
  - the page for adding new topics

::right::

#### store method
  - validates and stores the new topic

<br>

#### create topic request
  - validates the user submitted data
  - verifies user allowed to add topic



---
layout: 2
---

# Topics Admin: Browse sub-feature

## Topics Admin - Create Method



---
layout: 2
---

# Topics Admin: Browse sub-feature

## Topics Admin - Store Method



---
layout: 2
---

# Topics Admin: Browse sub-feature

## Topics Admin - StoreTopicRequest



---
layout: 2
---
# Topics Admin: Updating the Browse Sub-feature

<br>

We need to revisit the Browse to add the ability to show, edit, and delete 
topics.

## Action Links

- show: 
-   this is link styled as a button
- edit: 
  - this is a link styled as a button
- delete: 
  - this is a secondary button, and needs a form

<br>

<Announcement type="info">
The delete option will toggle the topic availability.
</Announcement>

---
level: 2
---

# Topics Admin: Browse sub-feature

## The action links per topic



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
