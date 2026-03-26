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
level: 2
---

# A quick reminder

Laradumps is a great way to help debug code.

It allows you to:

- dump variables without stopping execution
- monitor logs, sql queries, HTTP requests and more
- dump variables, logs, jobs and more
  and much more.

For more details check out:

- Laravel Daily. (2025, August 18). LaraDumps: A Package for Better dd() in
  Laravel/PHP. Youtube.com. https://www.youtube.com/watch?v=1c2MT2d00EE

‌
- 


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

# Topic Migration, Model, Controller and more

<br>

### Creating the stubs for the Topic Admin

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

If something is missing you may use the `make:OPTION` command to add the
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
layout: section
---

# Topics: Migrate, Seed, Route

---
level: 2
---

# Topics: Migrate, Seed, Route

## Migration

Open `database/migrations/yyyy_mm_dd_hhmmss_create_topics_table.php`

Edit the contents to add the fields:

| field name  | type    | size | other                     |
|-------------|---------|------|---------------------------|
| name        | string  | 16   | unique, default "general" |
| description | string  | 255  | nullable                  |
| available   | boolean |      | default false             |

<br>

<Announcement type="info">
Remember that yyyy_mm_dd_hhmmss is the year, month, day and time the file was 
created.
</Announcement>

---
level: 2
---

# Topics: Migrate, Seed, Route

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

# Topics: Migrate, Seed, Route

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

# Topics: Migrate, Seed, Route

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

# Topics: Migrate, Seed, Route

## Routes for administration

We already know we can split `routes\web.php` into several files.

For the Topics Administration, we edit the

- `routes\web.admin.php` file

--- 
level: 2
---

# Topics: Migrate, Seed, Route

## Routes for administration

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

# Topics Admin: Browse

---
level: 2
---

# Topics Admin: Browse

Begin with the "browse":

- Controller (index method)
- Topic Browse User Interface

---
level: 2
layout: figure
figureUrl: /public/topic-admin-index.png
---


---
level: 2
layout: figure
figureUrl: /public/topic-admin-add-button.png
---


---
level: 2
---

# Topics Admin: Browse

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

# Topics Admin: Browse

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

# Topics Admin: Browse

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
layout: section
---

# Topics Admin: Create/Add

---
level: 2
layout: two-cols
---

# Topics Admin: Create/Add

We will create the following:

::left::

#### create method

- shows the `create.blade.php` page

<br>
<br>

#### create page

- the page for adding new topics

::right::

#### store method

- validates and stores the new topic
- uses the store topic request

<br>

#### store topic request

- validates the user submitted data
- verifies user allowed to add topic




---
level: 2
layout: figure
figureUrl: /public/topic-admin-create.png
---



---
level: 2
layout: figure
figureUrl: /public/topic-admin-create-example.png
---



---
level: 2
layout: figure
figureUrl: /public/topic-admin-create-error-example.png
---




---
level: 2
---

# Topics Admin: Create/Add

## Create Method

```php [PHP]
public function create()
{
  /* Return the "add new topic" user interface page */
  return view('admin.topics.create');
}
```

---
level: 2
---

# Topics Admin: Create/Add

## Store Method

```php [PHP]
public function store(StoreTopicRequest $request)
{
    $validated = $request->validated();

    Topic::create($validated);

    return redirect('admin.topics.index')
        ->with('status', 'Topic Created');
}
```

---
layout: section
---

# Topics Admin: Create/Add

## Store Topic Request

---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

Create using:

```shell
php artisan make:request StoreTopicRequest
```

Open the `app/Http/Requests/StoreTopicRequst.php` file.

We will add code to:

- allow authenticated users to add a topic
- validate user entered data

---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

````md magic-move

```php [PHP]
class StoreTopicRequest extends FormRequest
{
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
}
```

```php [PHP] {1-2,16|3-9|10-13|all}
class StoreTopicRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *  - No users: false
     *  - Any user: true 
     *  - Authenticated user: auth()
     *  - Permissions: implementation dependant
     */
    public function authorize(): bool
    {
        return auth()->check();
    }

    // Validation method here...
}
```

```php [PHP] {1-3,16|5-9|10-15|all}
class StoreTopicRequest extends FormRequest
{
    // Authorized to store method here
    
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            //
        ];
    }
}
```

```php [PHP] {1-6,15-16|7-14|all}
class StoreTopicRequest extends FormRequest
{
    // Authorized to store method here

    public function rules(): array
    {
        return [
            'name'=>[
                'required',
                'string',
                'max:16'
            ],
            // description, available rules to come
        ];
    }
}
```

```php [PHP]  {7-8,15-16|7-16|all}
class StoreTopicRequest extends FormRequest
{
    // Authorized to store method here

    public function rules(): array
    {
        return [
            // name rules here...
            
            'description'=>[
                'nullable',
                'string'
            ],
            
            // available rules here...
        ];
    }
}
```

```php [PHP] {5-8,14-17|9-13|all}
class StoreTopicRequest extends FormRequest
{
    // Authorized to store method here

    public function rules(): array
    {
        return [
            // name, description rules to come

            'available'=>[
                'required',
                'boolean'
            ],
            
        ];
    }
}
```


````

<Announcement type="info">
We have removed the comments for brevity
</Announcement>



---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

### Custom validation error messages

After the rules method we can specify custom validation messages.

This is done using the `messages` method.

---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

### Example Custom validation error messages

```php [PHP]
    public function messages(): array
    {
        return [
            'required' => 'Please give a value for :attribute',
            'nullable' => 'You may leave :attribute empty',
            'string' => ':attribute must contain text',
            'max' => 'Maximum length of :attribute is :max',
        ];
    }
```

---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

### Preparing for Validation

Another useful method that we may specify is the prepare for validation
method.

This allows us to:

- pre-process data that is entered by the user
- and other operations before validation occurs

In this example:

- we **require** the available field to be set
- use the prepare for validation method
- to ensure available has false if unfilled

---
level: 2
---

# Topics Admin: Create/Add

## Store Topic Request

### Example `prepareForValidation` method

```php [PHP]
    protected function prepareForValidation(): void
    {
        if (!$this->filled('available')) {
            $this->merge([
                'available' => false,
            ]);
        }
    }
```

---
layout: section
---

# Topics Admin: Create/Add

## Create Topic User Interface

---
level: 2
---

# Topics Admin: Create/Add

## Create User Interface File

User Interfaces are developed using:

- Blade
- React
- Vue
- Livewire

Other options may exist as third party options.

<Announcement type="brainstorm">
We are using HTML/CSS via Blade files for this set of notes.
</Announcement>

---
level: 2
---

# Topics Admin: Create/Add

## Create User Interface File

Create the blade file by using:

```shell
touch resources/views/admin/topics/create.blade.php
```

Then open the now empty Blade file for editing.

<Announcement type="info">
<p>We presume you have used either:</p>
<ul>
<li>the blade-sanctum-kit for your application, or</li>
<li>created a suitable layout template for the next steps</li>
</ul>
</Announcement>

---
level: 2
---

# Topics Admin: Create/Add

## Create User Interface File

Start code for page.

```html [Blade HTML & PHP]

<x-admin-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-white leading-tight">
            {{ __('Topics Admin') }}
        </h2>
    </x-slot>

    <section class="py-4 mx-8 space-y-4 ">
        <!-- create form will go here -->
    </section>
</x-admin-layout>    
```

---
level: 2
---

# Topics Admin: Create/Add

## Create User Interface File

````md magic-move

```html [Blade HTML & PHP]
<!-- add this code to the section -->
<header>
    <h3 class="text-2xl font-bold text-zinc-700">
        Add New Topic
    </h3>
</header>

<div class="overflow-x-auto rounded border border-gray-300 shadow-sm">

    <!-- Form code goes here -->

</div>
```

```html [Blade HTML & PHP]
<!-- The form wrapper code -->
<form action="{{ route('admin.topics.store') }}"
      method="post"
      class="flex flex-col p-4 bg-white">

    @csrf

    <!-- Enter name of topic to go here -->
    <!-- Enter topic description here -->
    <!-- Is topic available here -->
    <!-- save and cancel buttons here -->
</form>

```

```html [Blade HTML & PHP]
<!-- Code for Enter name of topic -->
<div class="p-4 w-1/2">
    <x-input-label for="name">Name:</x-input-label>

    <x-text-input id="name"
                  name="name"
                  type="text"
                  placeholder="Name of topic"
                  value="{{ old('name')??'' }}"
                  autocomplete="name"
                  class="w-full"
    />

    <x-input-error :messages="$errors->first('name')"
                   class="my-2"/>
</div>
<!-- Enter topic description here -->
<!-- Is topic available here -->
<!-- save and cancel buttons here -->
```

```html [Blade HTML & PHP]
<!-- Code for Enter topic description -->
<div class="p-4 w-1/2">
  <x-input-label for="description">Description:</x-input-label>

  <x-textarea id="description"
              name="description"
              type="text"
              placeholder="Name of topic"
              value="{{ old('name')??'' }}"
              autocomplete="description"
  />

  <x-input-error :messages="$errors->first('description')"
                 class="my-2"/>
</div>
<!-- Is topic available here -->
<!-- save and cancel buttons here -->
```

```html [Blade HTML & PHP]
<!-- Code for Is topic available -->
<div class="p-4 w-1/2">
    <x-input-label for="">Available:</x-input-label>

    <label for="available"
           class="relative block h-8 w-14 rounded-full bg-gray-300
                  transition-colors [-webkit-tap-highlight-color:transparent]
                  has-checked:bg-green-500">
        <input type="checkbox"
               value="1"
               id="available"
               name="available"
               class="peer sr-only">
        <span
            class="absolute inset-y-0 inset-s-0 m-1 size-6 rounded-full
                   bg-white transition-[inset-inline-start]
                   peer-checked:start-6"></span>
    </label>
</div>
<!-- save and cancel buttons here -->
```

```html [Blade HTML & PHP]
<!-- save and cancel buttons code -->
<div class="p-4 w-1/2 flex gap-4">
    <x-primary-button type="submit"
                      class="px-12">
        Save
    </x-primary-button>
    <x-secondary-link-button href="{{ route('admin.topics.index') }}"
                             class="px-8">
        Cancel
    </x-secondary-link-button>
</div>
```

````

---
level: 2
---

# Topics Admin: Updating Browse (index)

<br>

We need to revisit the Browse to add the ability to show, edit, and delete
topics.

## Action Links

- **show**: link styled as a button
- **edit**: link styled as a button
- **delete**: a secondary button, and needs a form

<br>

<Announcement type="warning">
The delete will permamently remove the topic.
</Announcement>

<Announcement type="info">
Laravel has "soft deletes" which allows for items to be deleted but not 
permamently.
</Announcement>

---
level: 2
---

# Topics Admin: Updating Browse (index)

## Action Links: Show

```html [Blade HTML & CSS]

<x-primary-link-button
        href="{{ route('admin.topics.index', $topic) }}"
        class="hover:bg-green-800!">
    <i class="fa-solid fa-eye"></i>
    <span class="sr-only">Show</span>
</x-primary-link-button>
```

<Announcement type="info">
The route (<code>admin.topics.index</code>) will be updated to 
<code>admin.topics.show</code> when we implement READ from the BREAD actions.
</Announcement>
---
level: 2
---

# Topics Admin: Updating Browse (index)

## Action Links: Edit

```html [Blade HTML & CSS]

<x-primary-link-button
        href="{{ route('admin.topics.index', $topic) }}"
        class="hover:bg-amber-800!">
    <i class="fa-solid fa-edit"></i>
    <span class="sr-only">Edit</span>
</x-primary-link-button>
```

<Announcement type="info">
The route (<code>admin.topics.index</code>) will be updated to
<code>admin.topics.edit</code> when we implement EDIT from the BREAD actions.
</Announcement>
---
level: 2
---

# Topics Admin: Updating Browse (index)

## Action Links: Delete

```html [Blade HTML & CSS]

<form action="{{ route('admin.topics.index', $topic) }}"
      method="post">
    @csrf
    @method('delete')
    <x-secondary-button class="hover:bg-red-800! hover:text-white!">
        <i class="fa-solid fa-trash"></i>
        <span class="sr-only">Delete</span></x-secondary-button>
</form>
```

<Announcement type="info">
The route (<code>admin.topics.index</code>) will be updated to
<code>admin.topics.delete</code> when we implement the DELETE from the BREAD actions.
</Announcement>






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
- [ ]  I can run Laravel 12 / Laravel 13 with SQLite for dev.

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
layout: two-cols
---

# Exit Ticket Questions

::left::

Think back over everything we explored today:

- HTTP verbs,
- CRUD/BREAD operations,
- Laravel’s resourceful routing, and
- validation.

Now imagine you’ve been asked to extend the Contact‑List application with
a brand‑new feature... For example, tagging contacts, marking VIPs, or
bulk‑updating records.

::right::

<Announcement type="brainstorm">
<p>What HTTP verbs, routes, controller methods, and validation rules would 
you choose?</p>

<p>Why have you made these choices?</p>
</Announcement>

<br>

<Announcement type="idea">
<p>Explain how each decision aligns with the principles we studied.</p>
<p>Explain it ensures a clean, maintainable, and predictable user 
experience.</p>
</Announcement>

---

# Acknowledgements & References

- Fielding, R. T., Nottingham, M., & Reschke, J. (2022). HTTP semantics
  (RFC 9110). Internet Engineering Task Force (STD 97).
  https://www.rfc-editor.org/info/rfc9110

- Mozilla Developer Network. (2025, July 4). HTTP request methods. MDN Web
  Docs. https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Methods

- Microsoft. (n.d.). Best practices for RESTful web API design. Azure
  Architecture Center.
  https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design

---
level: 2
---

# Acknowledgements & References

- Laravel. (2026). Routing — Laravel 12.x documentation.
  https://laravel.com/docs/12.x/routing

- Laravel. (2026). Controllers — Laravel 12.x documentation.
  https://laravel.com/docs/12.x/controllers

- Laravel. (2026). Validation — Laravel 12.x documentation.
  https://laravel.com/docs/12.x/validation

- Laravel. (2026). Database: Getting started — SQLite configuration.
  https://laravel.com/docs/12.x/database

- Laragon. (n.d.). Laragon documentation.
  https://laragon.org/docs

<br>


> - Some content was generated with the assistance of Microsoft CoPilot

---
layout: end
---

# Fin!

## Web apps bloom with ease<br>BREAD guides each quiet action —<br>Data flows like wind.
