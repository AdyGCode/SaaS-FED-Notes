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

<Toc minDepth="1" maxDepth="1" columns="2" />

---
layout: figure
figureUrl: public/orly-book-cover-saas-bread.png
---

---
level: 2
---

# Warm-up time!

Split into pairs (Lecturer will indicate how)

Before writing any code, we need to be clear about what the web expects.

## Question

Answer the following in plain language:

- What does an HTTP status code communicate?
- What does idempotent mean in the context of HTTP?
- Why should a developer care about idempotency?

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

## Authentication for Staff/Admin Routes:

Authentication is:

- Added via Laravel Breeze,
- Enforced via route middleware and FormRequest authorization.

--- 
level: 2
---

# Topics: Migrate, Seed, Route

## Routes for Administration

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
level: 2

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
                'max:16',
                'unique:topics'
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
            'unique' => 'The :attribute has already been taken.',
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
level: 2
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

# Topics Admin: Show

---
level: 2
---

# Topics Admin: Show

- Sub-feature of Topic Admin
- Displays the details for the topic
- Allows access to edit
- Allows topic to be deleted


---
layout: figure
figureUrl: public/topic-admin-index-show-link.png
---

---
layout: figure
figureUrl: public/topic-admin-show.png
---


---
level: 2
---

# Topics Admin: Show

## Update 'show' primary link button route

Edit the `admin/topcs/index.blade.php` file and alter the show's primary
link button's href to:

```html [Blade & HTML]

<x-primary-link-button href="{{ route('admin.topics.show', $topic) }}"
```

---
level: 2
---

# Topics Admin: Show

## Update admin web routes

Edit the `web.admin.php` route file

Change the `->except()` method by removing 'show'.

```php
        Route::resource('topics', TopicController::class)
            ->except(['edit', 'update', 'destroy']);
```

---
level: 2
---

# Topics Admin: Show

## Update Topic Controller

Open the `app/Http/Controllers/Admin/TopicController.php` and update the show
method

```php
    public function show(Topic $topic)
    {
        return view('admin.topics.show')
            ->with('topic', $topic);
    }
```

Uses route-model binding to get the Topiuc details.

---
level: 2
---

# Topics Admin: Show

## Topic Show UI

Create a new file:

```shell
touch resources/admin/topics/show.blade.php
```

Add the "Common wrapper" for Admin layouts (on next slide).


---
level: 2
---

# Topics Admin: Show

## Standard Admin Page Layout Wrapper

````md magic-move


```php
<x-admin-layout>
    <!-- TODO: Header Slot -->
    <!-- TODO: Content Slot -->
    <!-- Content slot dependent on the page function -->
</x-admin-layout>
```

```html [HTML & Blade]
<!-- Header Slot Code -->
<x-slot name="header">
    <h2 class="font-semibold text-xl text-white leading-tight">
        {{ __('Topics Admin') }}
    </h2>
</x-slot>
```

```html
<!-- Content Slot Code -->
<section class="py-4 mx-8 space-y-4 ">
  <header class="flex justify-between">
      <h3 class="text-2xl font-bold text-zinc-700">
          Topic Details
      </h3>

      <x-primary-link-button href="{{ route('admin.topics.create') }}">Add Topic</x-primary-link-button>
  </header>

  <!-- TODO: Content of page here -->  
</section>
```

````

---
level: 2
---

# Topics Admin: Show

## Show Page Details

For the Show page the "Content of page" will be:

````md magic-move

```html
<!-- Layout for card details code -->
<div class="overflow-x-auto rounded bg-white border border-gray-300
            shadow-sm w-full sm:w-1/2 lg:w-1/3 p-4 sm:p-8
            sm:flex flex-col sm:justify-between sm:gap-2 lg:gap-4">

    <header class="bg-gray-200 -m-8 mb-0 p-4">
        <h3 class="text-xl font-medium text-pretty text-gray-900">
            {{ $topic->name }}
        </h3>
    </header>

    <!-- TODO: Description and Creation Date -->
</div>
```

```html
<!-- Description and Creation Date -->
<p class="mt-4 line-clamp-2 text-pretty text-gray-700">
    @empty($topic->description)
        n/a
    @else
        {{ $topic->description }}
    @endempty
</p>

<div class="flex items-center gap-2">
    <p class="text-gray-700">
        Added:
    </p>
    <p class="text-gray-700">{{ $topic->created_at }}</p>
</div>
</dl>
<!-- TODO: Card Footer -->
```

```html
<!-- Card Footer -->
<footer class="mt-2 gap-2 flex justify-end content-between">
    <!-- TODO: Show ALl Link Button -->
    <!-- TODO: Edit Link Button -->
    <!-- TODO: Delete Form -->
</footer>
```

```html
<!-- Card Footer -->
<footer class="mt-2 gap-2 flex justify-end content-between">
    <x-primary-link-button href="{{ route('admin.topics.index') }}"
                           class="hover:bg-green-800!">
        <i class="fa-solid fa-list"></i>
        <span class="sr-only">All</span>
    </x-primary-link-button>
    <!-- TODO: Edit Link Button -->
    <!-- TODO: Delete Form -->
</footer>
```

```html
<!-- Edit Link Button -->
<x-primary-link-button href="{{ route('admin.topics.index', $topic) }}"
                       class="hover:bg-amber-800!">
    <i class="fa-solid fa-edit"></i>
    <span class="sr-only">Edit</span>
</x-primary-link-button>
```

```html
<!-- Delete Form and Button -->
<form action="{{ route('admin.topics.index', $topic) }}"
      method="post">
    @csrf
    @method('delete')
    <x-secondary-button class="hover:bg-red-800! hover:text-white!">
        <i class="fa-solid fa-trash"></i>
        <span class="sr-only">Delete</span>
    </x-secondary-button>
</form>
```


````

---
layout: section
---

# Topics Admin: Edit

---
level: 2
---

# Topics Admin: Edit

Edit requires:

- Update the admin topics routing
- Update the links in index & show
- Edit Admin Topics view
- Topic Controller edit method
- Topic Controller update method
- Update Topic Request



---
layout: figure
figureUrl: public/topic-admin-show-edit-link.png
---


---
layout: figure
figureUrl: public/topic-admin-edit-page.png
---


---
layout: figure
figureUrl: public/topic-admin-edit-error.png
---


---
level: 2
---

# Topics Admin: Edit

## Update Admin  Topic Route

- Remove the 'edit' and 'update' exceptions

```php
        Route::resource('topics', TopicController::class)
            ->except(['destroy']);
```

---
level: 2
---

# Topics Admin: Edit

## Update Links

Edit:

- `/resources/views/admin/topics/index.blade.php`
- `/resources/views/admin/topics/show.blade.php`

Locate the "edit" primary link button...

Change:

````md magic-move

```php
 <x-primary-link-button href="{{ route('admin.topics.index') }}"
                        class="hover:bg-amber-800!">
```

```php
 <x-primary-link-button href="{{ route('admin.topics.edit', $topic) }}"
                        class="hover:bg-amber-800!">
```

````

---
level: 2
---

# Topics Admin: Edit

## Edit Method

- Retrieve topic
- Call edit view to be rendered and sent to client

---
level: 2
---

# Topics Admin: Edit

## Edit Method

```php [PHP]
public function edit(Topic $topic)
{
    return view('admin.topics.edit')
        ->with('topic', $topic)
        ->with('messages');    
}
```

---
level: 2
---

# Topics Admin: Edit

## Update Request

- Ignore current topic when editing
    - If not, update will fail due to perceived duplicate
- Define error messages
- Make sure available is set

````md magic-move

```php [PHP]
public function authorize(): bool
{
    return auth()->check();
}
```

```php [PHP]
public function rules(): array
{
    return [
        'name' => [ ... ],
        'description' => [ ... ],
        'available' => [ ... ],
    ];
}
```

```php [PHP]
        'name' => [
            'required',
            'string',
            'max:16',
            Rule::unique(Topic::class)
                ->ignoreModel($this->route('topic'))
        ],
```

```php [PHP]
        'description' => [
            'nullable',
            'string'
        ],
```

```php [PHP]
        'available' => [
            'required',
            'boolean'
        ],
```

```php
    public function messages(): array
    {
        return [
            'required' => 'Please give a value for :attribute',
            'nullable' => 'You may leave :attribute empty',
            'string' => ':attribute must contain text',
            'max' => 'Maximum length of :attribute is :max',
            'unique' => 'The :attribute has already been taken.',
        ];
    }
```

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

````

---
level: 2
---

# Topics Admin: Edit

## Update Method

```php [PHP]
    public function update(UpdateTopicRequest $request, Topic $topic)
    {
        $validated = $request->validated();
        $topic->update($validated);
        return redirect(route('admin.topics.index'))
            ->with('message','updated');
    }
```

---
level: 2
---

# Topics Admin: Edit

## Edit View

Easiest way to create the Edit view:

- Duplicate the`resources/views/admin/topics/index.blade.php`
- Naming the copy `resources/views/admin/topics/edit.blade.php`

Update the following:

- Add `put` method
- Name input
- Description text area
- Available checkbox
- Heading

---
level: 2
---

# Topics Admin Edit

## Edit View

Update each part:

````md magic-move

```html [HTML & Blade]
<section class="py-4 mx-8 space-y-4 ">
    <header>
        <h3 class="text-2xl font-bold text-zinc-700">
            Edit Topic
        </h3>
    </header>
```

```html [HTMNL & Blade]
<form action="{{ route('admin.topics.update', $topic) }}"
      method="post"
      class="flex flex-col p-4 bg-white">

  @csrf
  @method('put')
```

```html [HTMNL & Blade]
<x-text-input id="name"
              name="name"
              type="text"
              placeholder="Name of topic"
              value="{{ old('name')?? $topic->name }}"
              autocomplete="name"
              class="w-full"
/>
```

```html [HTML & Blade]
<x-textarea id="description"
            name="description"
            type="text"
            :value="old('description')??$topic->description"
            placeholder="Topic Description"
            autocomplete="description"
/>
```

```html [HTML & Blade]
<input type="checkbox"
       value="1"
       id="available"
       name="available"
       @if($topic->available) checked @endif
       class="peer sr-only">
```

````

<Announcement type="info" title="Update textarea component">
<p>
You may need to edit the 
<code>resources/views/components/textarea.blade.php</code> file and replace
<code>message</code> with <code>value</code>.
</p>
</Announcement>



---
layout: section
---

# Topics Admin: Delete

---
level: 2
layout: two-cols
---

# Topics Admin: Delete

<br>

## Four ways to 'delete'

::left::

### Hard or Soft Delete

- Non-Reversible Delete, or
- Soft Delete

<br>

### To Confirm, or Not to Confirm

- Immediate, or
- Confirm.

::right::

### This example:

- Non-Reversible (hard)
- Immediate (no confirmation)

---
level: 2
---

# Topics Admin: Delete

- update destroy route
- add destroy method
- update the delete form actions

---
layout: figure
figureUrl: public/topic-admin-delete-button.png
figureCaption: Delete button hovered over
---

---
layout: figure
figureUrl: public/topic-admin-delete-result.png
figureCaption: Topic has been deleted, no confirmation
---


---
level: 2
---

# Topics Admin: Delete

## Update destroy route

Remove the except, as we now have all the actions

```php [PHP]
Route::resource('topics', TopicController::class);
```

---
level: 2
---

# Topics Admin: Delete

## Update delete form action (index and show views)

Open:

- `resources/views/admin/topics/index.blade.php`
- `resources/views/admin/topics/edit.blade.php`

Update the secondary button to be a submit button:

````md magic-move
```php
<x-secondary-button class="hover:bg-red-800! hover:text-white!">
    <i class="fa-solid fa-trash"></i>
    <span class="sr-only">Delete</span></x-secondary-button>
```

```php
<x-secondary-button class="hover:bg-red-800! hover:text-white!" type="submit">
    <i class="fa-solid fa-trash"></i>
    <span class="sr-only">Delete</span></x-secondary-button>
```
````

---
level: 2
---

# Topics Admin: Delete

## Add destroy method

Edit `Admin/TopicController.php`

```php [PHP]
    public function destroy(Topic $topic)
    {
        $oldTopic = $topic;
        $topic->delete();

        return redirect(route('admin.topics.index'))
            ->with('massage','deleted');
    }
```

---
layout: section
---

# Admin Navigation Update


---
level: 2
---

# Admin Navigation Update

We need to:
- update the admin sidebar navigation to add "Topics"


Open `resources/views/layouts/`admin-navigation.blade.php

Search for `Jokes`


---
level: 2
---

# Admin Navigation Update

Edit the `route()` to point to:
- `admin.topics.index`

Edit the `routeIs()` to point to:
- `admin.topics.*`

Update the `__('Jokes')` to:
- `__('Topics')`

Change the Icon to suit, for example:
- `fa-list`
- `fa-tag`

---
level: 2
---

# Admin Navigation Update

Test the navigation update by heading to:

- `http://localhost:8000/admin/topics`

---
layout: section
---

# Exercises

---
level: 2
---

# Exercise: Fill the Table (Pairs)

For each action:

- identify the HTTP verb,
- whether it is safe, idempotent, both, or neither,
- and the most appropriate success status code.

| Action           | Verb | Safe? | Idempotent? | Typical Success Code |
|------------------|------|-------|-------------|----------------------|
| Browse contacts  | ?    | ?     | ?           | ?                    |
| View one contact | ?    | ?     | ?           | ?                    |
| Create a contact | ?    | ?     | ?           | ?                    |
| Update a contact | ?    | ?     | ?           | ?                    |
| Delete a contact | ?    | ?     | ?           | ?                    |

<!-- 
Expected Concepts (Instructor Notes)
GET → Safe ✅, Idempotent ✅
POST → Not safe ❌, Not idempotent ❌
PUT/PATCH → Not safe ❌, Idempotent ✅
DELETE → Not safe ❌, Idempotent ✅
-->

---
layout: section
---

# Recap

---
level: 2
---

# Recap Checklist

- [ ]  I can choose appropriate HTTP verbs (safe vs idempotent) and apply them using Laravel resource routes.
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
- Laravel’s resourceful routing, and validation.

Now imagine you’ve been asked to extend the Contact‑List application with
a brand‑new feature... For example, tagging contacts, marking VIPs, or
bulk‑updating records.

You must support validation, authorization, and pagination.

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
layout: section
---

# Acknowledgements & References

---
level: 2
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


> Some content may have been generated with the assistance of Microsoft CoPilot

---
layout: end
level: 2
---

# Fin!

## Web apps bloom with ease<br>BREAD guides each quiet action —<br>Data flows like wind.
