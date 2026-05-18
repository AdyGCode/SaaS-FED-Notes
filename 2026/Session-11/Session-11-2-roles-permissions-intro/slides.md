---
theme: nmt
background: https://cover.sli.dev
title: Session 11 - Roles & Permissions
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 90min
---

# Session 11: Roles & Permissions

## SaaS 1 – Cloud Application Development (Front-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa-brands-github class="text-zinc-300 text-3xl -mr-2"/>
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
layout: two-cols
---

# Objectives

::left::

::right::



---
level: 2
layout: figure-side
figureUrl: public/orly-book-cover-dashboards.png
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2" />

---
layout: section
---

# 🌟 Ice Breaker

## TODO: Add ice-breaker

---
layout: section
---

# Client Dashboard

---
layout: two-cols
level: 2
---

# Client Dashboard

::left::

### Client & Admin Dashboards

- Client Dashboard:
    - Users of the application
    - Layout similar to main application
    - User's Statistics & Other information
- Admin Dashboard:
    - Administrators of the application
    - Layout Often different from main application
    - System Statistics & Other information

::right::

### Parts

- Admin Dashboard Index Page
- Admin Dashboard Controller

### Requirements

- HyperUI.dev TailwindCSS components
- Laravel v12+
- TailwindCSS
- PHP 8.4 or later

---
layout: section
---

# Admin Dashboard: Controller

## The Controller

---
level: 2
---

# Admin Dashboard: Controller

## Creating the controller

```shell
php artisan make:controller Admin/AdminController
```

Open the `/app/Http/Controllers/Admin/AdminController.php` file

## Index method

The index method will:

- collect data for display on admin dashboard
- send data to view and request it to be rendered

---
level: 2
---

# Admin Dashboard: Controller

## Creating the controller

Start of the `AdminController.php` file:

Include:

- required models,
- other required classes

```php [PHP] {none|1|3|4-5|6-7|all}
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Topic;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\View\View;
```

---
level: 2
---

# Admin Dashboard: Controller

## Creating the controller

````md magic-move

```php
class AdminController extends Controller
{
    /**
     * Administration Dashboard Controller
     *
     * @return View
     */
    public function index()
    {
        // Data collection
        // Render view
    }
}
```

```php [PHP] {1-3|3-6|8-9|11-14|16|all}
    public function index()
    {
        // Data Collection
        $topic_count = Topic::count();
        $contact_count = 1;
        $message_count = 1;
        
        $visitor_count = 1;
        $user_logged_in_count = 1;
        
        $user_count = User::count();
        $user_suspended_count = 0;
        $user_banned_count = 0;
        $user_unverified_count = 0;

        // Render View Code
```

```php [PHP] {1|1-2|3-5|7-8|10-13|all}
        // Render View Code
        return view('admin.index')
            ->with('topic_count', $topic_count)
            ->with('contact_count', $contact_count)
            ->with('message_count', $message_count)
            
            ->with('visitor_count', $visitor_count)
            ->with('user_logged_in_count', $user_logged_in_count)
            
            ->with('user_count', $user_count)
            ->with('user_suspended_count', $user_suspended_count)
            ->with('user_banned_count', $user_banned_count)
            ->with('user_unverified_count', $user_unverified_count);

```


````

<Announcement type="info">
Each item you wish to display on the admin dashboard will need to be<br> 'calculated' and passed to the view.
</Announcement>


---
layout: section
---

# Admin Dashboard: View

---
level: 2
---

# Admin Dashboard: View

## Process (From Scratch)

- start with a blank `resources/views/admin/index.blade.php` file
- use the admin-layout 'control' to indicate the layout
- add the page header slot details
- add the main page body and section headers
- add the statistics card for each item

## Process from sample `index.blade.php`

- Update / Remove items as needed

---
level: 2
---

# Admin Dashboard: View

## Layout & Page Header

```php
<x-admin-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-white leading-tight">
            {{ __('Administration') }} {{ __("Dashboard") }}
        </h2>
    </x-slot>

    <!-- statistics section -->
    <!-- users section -->
    <!-- system section -->

</x-admin-layout>
```

---
level: 2
---

# Admin Dashboard: View

## Statistic Section

This replaces, or is added after the `<!-- statistics section -->` comment.

```php
<section class="my-6 mx-12 space-y-4">

        <header>
            <h3 class="text-sm lg:text-2xl font-bold text-zinc-700">
                {{__('Statistics')}}
            </h3>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 2xl:grid-cols-4 gap-4 ">

            <x-stats-card title="{{ __('Contacts') }}"
                          value="{{ $contact_count }}"
                          bg="bg-rose-700"
                          icon="fa-solid fa-contact-card"
                          icon-color="text-white"/>

            <x-stats-card title="{{ __('Topics') }}"
                          value="{{ $topic_count }}"
                          bg="bg-pink-700"
                          icon="fa-solid fa-tag"
                          icon-color="text-white"/>

            <x-stats-card title="{{ __('Messages') }}"
                          value="{{ $message_count }}"
                          bg="bg-fuchsia-700"
                          icon="fa-solid fa-message"
                          icon-color="text-white"/>


            <div class="col-span-1 md:col-span-3 2xl:col-span-4"></div>

            <x-stats-card title="{{ __('Unique Visitors') }}"
                          value="{{ $visitor_count }}"
                          bg="bg-zinc-700"
                          icon="fa-solid fa-arrow-trend-up"
                          icon-color="text-white"/>

        </div>
    </section>
```

<br>

<Announcement type="info">
The <code>...</code> (elipsis) is used to show where more code will be added. 
</Announcement>



---
level: 2
---

# Admin Dashboard: View

## Users Section

This replaces, or is added after the `<!-- users section -->` comment.

```php
    <section class="my-6 mx-12 space-y-4">

        <header>
            <h3 class="text-sm lg:text-2xl font-bold text-zinc-700">
                {{__('Users')}}
            </h3>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 2xl:grid-cols-4 gap-4 ">

            <a href="{{ route('admin.users.index') }}">
                <x-stats-card icon="fa-solid fa-person"
                              title="{{ __('Users') }}"
                              value="{{ $user_count }}"
                              bg="bg-purple-700"
                              icon-color="text-white"/>
            </a>

            <x-stats-card icon="fa-solid fa-person-walking"
                          title="{{ __('Signed In') }}"
                          value="{{ $user_logged_in_count }}"
                          bg="bg-green-700"
                          icon-color="text-white"/>

            <div class="col-span-1 2xl:col-span-2"></div>

            <x-stats-card title="{{ __('Suspended') }}"
                          value="{{ $user_suspended_count }}"
                          bg="bg-amber-700"
                          icon="fa-solid fa-person-circle-exclamation"
                          icon-color="text-white"/>

            <x-stats-card title="{{ __('Unverified') }}"
                          value="{{ $user_unverified_count }}"
                          bg="bg-orange-700"
                          icon="fa-solid fa-person-circle-question"
                          icon-color="text-white"/>

            <x-stats-card title="{{ __('Banned') }}"
                          value="{{ $user_banned_count }}"
                          bg="bg-red-700"
                          icon="fa-solid fa-person-circle-xmark"
                          icon-color="text-white"/>

        </div>

    </section>
```

---
level: 2
---

# Admin Dashboard: View

## System Section

This replaces, or is added after the `<!-- system section -->` comment.

```php
    <section class="my-6 mx-12 space-y-4">

        <header>
            <h3 class="text-sm lg:text-2xl font-bold text-zinc-700">
                {{__('System')}}
            </h3>
        </header>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 2xl:grid-cols-4 gap-4 ">

            <x-stats-card icon="fa-solid fa-info-circle"
                          title="{{ __('Version') }}"
                          value="{{ config('app.version', 'development') }}  {{ config('app.codename', '') }}"
                          value-class="text-xl text-zinc-900"
                          bg="bg-slate-700"
                          icon-color="text-white"/>

            <x-stats-card icon="fa-solid fa-square-binary"
                          title="{{ __('Environment') }}"
                          value="{{ config('app.env', 'Unknown') }} {{ config('app.debug',0)?'debug':'' }}"
                          bg="bg-slate-700"
                          icon-color="text-white"/>

            <div class="col-span-1 2xl:col-span-2"></div>

            <x-stats-card icon="fa-brands fa-laravel"
                          title="{{ __('Laravel') }}"
                          value="{{ app()->version() }}"
                          bg="bg-laravel-500"
                          icon-color="text-white"/>

            <x-stats-card icon="fa-brands fa-php"
                          title="{{ __('PHP') }}"
                          value="{{ phpversion() }}"
                          bg="bg-php-500"
                          icon-color="text-white"/>

        </div>

    </section>

```

---
layout: section
---

# Determining Roles & Permissions

---
level: 2
---

# Determining Roles & Permisisons

When you add roles & permissions it is a good idea to know what each role will
be able to do in the system.

This can be done by creating a table of roles and permissions.

| Role      | Permission 1 | Permission 2 | Permission 3 | ... |
|-----------|--------------|--------------|--------------|-----|  
| Admin     | Yes          | Yes          | Yes          | ... |
| Moderator | No           | Yes          | Yes          | ... | 
| User      | No           | No           | Yes          | ... |

You may also base this on the features of the system, and determine which
roles will have access to which features, and then determine the permissions
based on the features.

This is the method we have used in this course, and is a good method to use as
it is based on the features of the system, and can be easily updated as the
system evolves.

---
level: 2
---

# Determining Roles & Permissions

We have created a spreadsheet to assist in completing this task:

- [Permission-Matrix.xlsx](public/Permission-Matrix.xlsx)
- Alternative links:
  - Notes [GitHub repository](https://github.com/AdyGCode/SaaS-FED-Notes)
  - Session Folder [Permission Matrix Excel Spreadsheet](https://github.com/AdyGCode/SaaS-FED-Notes/tree/main/2026/Session-11/Session-11-2-roles-permissions-intro/public) 

The Permissions Matrix is best created in conjunction with the development
team and stakeholders to ensure that all requirements are captured and
understood.

This will include the MoSCoW and RACI frameworks to help determine the
importance and responsibility of each permission.


---
layout: figure
figureUrl: ./images/Permission-Matrix.png
figureCaption: Sample Permission Matrix (partially completed)
---

# Permission Matrix Sample

A sample of a partially completed permission matrix is shown in the image 
below. 

This is just an example and is not complete. 

It is meant to show the format and how it can be used to determine the roles and permissions for the system.

---
layout: section
---

# Adding Roles & Permissions

---
level: 2
---

# Adding Roles & Permissions

## Options

- Implement your own
- Use a package such as
    - Spatie Laravel
      Permission (https://spatie.be/docs/laravel-permission/v5/introduction)
    - Bouncer (https://github.com/JosephSilber/bouncer)
    - Laratrust (https://laratrust.santigarcor.me/)
    - Sentinel (https://cartalyst.com/manual/sentinel/2.x)
    - Jeremy Kenedy's Laravel
      Roles (https://github.com/jeremykenedy/laravel-roles)
    - and many more

We will use Spatie's Laravel Permission package for this course.

---
level: 2
---

# Adding Roles & Permissions

## Spatie Laravel Permission Package

- Open Source package for handling roles and permissions in Laravel
  applications
- Provides a simple and flexible way to manage user roles and permissions
- Supports both role-based and permission-based access control
- Integrates well with Laravel's built-in authentication system
- Provides Artisan commands for managing roles and permissions
- Provides middleware for checking permissions in routes and controllers
- Provides blade directives for checking permissions in views

and much more...

---
level: 2
---

# Adding Roles & Permissions

## Installation

```shell
composer require spatie/laravel-permission
``` 

Once the package is installed, you can publish the migration and config files
using the following command:

```shell
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider"
``` 

Then run the migrations to create the necessary tables in the database:

```shell
php artisan migrate
```

<Announcement class="mt-6" type="info">
You may publish the requiured files using an integrated menu:

<code>php artisan vendor:publish</code>

Then select the relevant items from the list.
</Announcement>


---
level: 2
---

# Adding Roles & Permissions

Once installed we need to:

- Create a seeder which will contain the default roles and permissions for 
  the system.
- Create a middleware to check for permissions in the routes and controllers.
- Update the User model to use the HasRoles trait provided by the package.  
- Update the routes and controllers to check for permissions using the middleware.
- Update the views to show/hide content based on permissions using the blade directives provided by the package.


---
level: 2
---

# Adding Roles & Permissions
## Creating a Seeder

To create a seeder for the default roles and permissions, run the following command:

```shell
php artisan make:seeder RolesAndPermissionsSeeder
``` 
This will create a new seeder file in the `database/seeders` directory. Open the file and add the following code to create some default roles and permissions:

```php
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;  

class RolesAndPermissionsSeeder extends Seeder
{
    public function run()
    {
        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // Create permissions
        $seedRoles = [
            // Roles depend on the application's requirements
            ['name' => 'super-admin'],
            ['name' => 'admin'],
            ['name' => 'staff'],
            ['name' => 'client'],
        ];

        $seedPermissions = [
            //     [ 'permission'=>'', 'roles'=>['']],
            ['permission' => 'user-add', 'roles' => ['admin', 'staff']],
            ['permission' => 'user-edit', 'roles' => ['admin', 'staff']],
            ['permission' => 'user-browse', 'roles' => ['admin', 'staff']],
            ['permission' => 'user-read', 'roles' => ['admin']],
            ['permission' => 'user-delete', 'roles' => ['admin']],

            ['permission' => 'users-count', 'roles' => ['admin', 'staff']],
            ['permission' => 'client-only', 'roles' => ['client']],
            ['permission' => 'staff-only', 'roles' => ['staff']],
            ['permission' => 'admin-only', 'roles' => ['admin']],
        ];

        foreach ($seedRoles as $role) {
            $role = Role::create($role);
        }

        foreach ($seedPermissions as $seedPermission) {
            $newPermission = ['name' => $seedPermission['permission']];
            $permission = Permission::create($newPermission);
            $permission->syncRoles($seedPermission['roles']);
        }
}
```

---
level: 2
---

After creating the seeder, you can run it using the following command:

```shell  
php artisan db:seed --class=RolesAndPermissionsSeeder
```

This seeds teh Roles and Permissions

Next we need to work on the User model and the seeder we have.

The seeder will be updated to apply the roles and permissions we allocate to the users we create.

```php

<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $seedUsers = [
            [
                'id' => 100,
                'name' => 'Ad Ministrator',
                'email' => 'admin@example.com',
                'password' => bcrypt('Password1'),
                'permissions' => [],
                'roles' => ['admin']
            ],
            [
                'id' => 200,
                'name' => 'Staff Member',
                'email' => 'staff@example.com',
                'password' => bcrypt('Password1'),
                'permissions' => [],
                'roles' => ['staff']
            ],
            [
                'id' => 1000,
                'name' => 'Client User',
                'email' => 'client@example.com',
                'password' => bcrypt('Password1'),
                'permissions' => [],
                'roles' => ['client']
            ],
        ];

        foreach ($seedUsers as $seedUser) {
            $permissions = $seedUser['permissions'];
            $roles = $seedUser['roles'];
            unset($seedUser['permissions']);
            unset($seedUser['roles']);

            $user = User::create($seedUser);
            $user->permissions()->sync($permissions);
            $user->syncRoles($roles);
        }
    }
}

```

---
layout: section
---

# Applying Roles & Permissions


---
level: 2
---

# Applying Roles & Permissions

We have a number of methods to apply the roles and permissions.

- Apply to Routes
- Apply to Controllers
- Apply to Views
- Apply to Blade Templates
- Apply to Middleware
- Apply to Policies
- Apply to Gates
- Apply to any other part of the application where you need to check for permissions

We will look at:

- Routes
- Controllers
- Views & Blade Templates
- Middleware

---
level: 2
---

## Routes

To apply the middleware to routes, you can add it to the route definition like this:

```php
Route::get('/admin', [AdminController::class, 'index'])
    ->middleware('permission:admin-only');
```


---
level: 2
---

## Middleware
To create a middleware for checking permissions, run the following command:

```shell
php artisan make:middleware PermissionMiddleware
``` 
This will create a new middleware file in the `app/Http/Middleware` directory. Open the file and add the following code to check for permissions:

```php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Exceptions\UnauthorizedException;

class PermissionMiddleware
{
    public function handle(Request $request, Closure $next, $permission)
    {
        if (!Auth::check()) {
            throw UnauthorizedException::notLoggedIn();
        }

        if (!Auth::user()->can($permission)) {
            throw UnauthorizedException::forPermissions([$permission]);
        }

        return $next($request);
    }
}
```
This middleware checks if the user is authenticated and has the required permission. If not, it throws an UnauthorizedException.

## Applying the middleware
To apply the middleware to routes, you can add it to the route definition like this:

```php
Route::get('/admin', [AdminController::class, 'index'])
    ->middleware('permission:admin-only');
``` 

This route will only be accessible to users who have the 'admin-only' permission.




---
level: 2
---

# Exit Ticket Questions

TODO: Add exit ticket questions

<Announcement type="brainstorm">
...
</Announcement>

<Announcement type="idea">
...
</Announcement>

---

# Acknowledgements & References

- TODO: Add references etc

> Some content may have been generated with the assistance of Microsoft
> Copilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:

- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
