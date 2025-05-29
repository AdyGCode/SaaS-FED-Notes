---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags:
  - SaaS
  - APIs
  - Back-End
date created: 03 July 2024
date modified: 10 July 2024
created: 2024-09-20T11:17
updated: 2025-05-23T11:13
---


# S10 Laravel Bootcamp: Part 8

## Software as a Service - Front-End Development

Developed by Adrian Gould

---

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

---

# Laravel Bootcamp: Part 10

# TODO: NOT WRITTEN

## Roles and Permissions

In this section, we will start to add an administration/management front-end that allows 
users with particular rights to perform management actions on data in the Chirp system.

We will:
- Build User Management Interface
- Determine Roles to use in Application
- Determine Permissions each Role will have
- Apply Roles & Permissions to Application (User Management)


## Before you start…

Have you completed (not just read):

- [Laravel v12 Bootcamp - Introducing Laravel](../session-11/S11-Introducing-Laravel-v12.md),
- [Laravel v12 Bootcamp - Part 1](../session-11/S10-Laravel-v12-BootCamp-Part-1.md),
- [Laravel v12 Bootcamp - Part 2](../session-11/S10-Laravel-v12-BootCamp-Part-2.md)
- [Laravel v12 Bootcamp - Part 3](../session-11/S10-Laravel-v12-BootCamp-Part-3.md)
- [Laravel v12 Bootcamp - Part 4](../session-11/S10-Laravel-v12-BootCamp-Part-4.md)
- [Laravel v12 Bootcamp - Part 5](../session-11/S10-Laravel-v12-BootCamp-Part-5.md)
- [Laravel v12 Bootcamp - Part 6](../session-11/S10-Laravel-v12-BootCamp-Part-6.md)
- [Laravel v12 Bootcamp - Part 7](../session-11/S10-Laravel-v12-BootCamp-Part-7.md)
- [Laravel v12 Bootcamp - Part 8](../session-11/S10-Laravel-v12-BootCamp-Part-8.md)
- [Laravel v12 Bootcamp - Part 9](../session-11/S10-Laravel-v12-BootCamp-Part-9.md)


No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you will
> only see parts of the application working when a stage is complete.
>
> So if you get an error in the browser, it may be because there is something missing.



# Roles & Permissions

Permission
- The ability to perform an action
  - Add User
  - Edit User

Role
- Collection of permissions
  - User Admin
  - Product Admin

## Gates and Policies

Gates are…
- Permissions
- Laravel uses the term “gate”

Policies are…
- Permissions applied to (Eloquent) Models

### How do we use Gates?

Identify the typical actions needing permission:

- Define the permission: E.g. "manage_users"
- Check the permission on the front-end: E.g. show/hide the button
- Check the permission on the back-end: E.g. can/can't update the data

### Laravel Example

Looking at the file `App/Providers/AppServiceProvider.php`:

```php
use App\Models\User;
use Illuminate\Support\Facades\Gate;
 
class AppServiceProvider extends ServiceProvider
{
  public function boot()
  {
    // Should return TRUE or FALSE
    Gate::define('manage_users', function(User $user) {
      return $user->is_admin == 1;
    });
  }
}

```

And the `Resources/views/navigation.blade.php` file:

```php
<ul>
	<li>
		<a href="{{ route('projects.index') }}">Projects</a>
	</li>
	@can('manage_users’)
	<li>
		<a href="{{ route('users.index') }}">Users</a>
	</li>
	@endcan
</ul>

```

## Ways to Check Permissions

- Routes Middleware
- Controller Can / Cannot
- Gate Allows / Denies
- Controller Authorise
- Form Request class

### Routes Middleware

```php
Route::post('users', [UserController::class, 'store’])
    ->middleware('can:create_users');

```

```php
Route::middleware(‘can:create-users')->group(function () {
    Route::post(‘users’, [UserController::class, ‘store',]
});
```

### Controller Can / Cannot

```php
public function store(Request $request)
{
  if (!$request->user()->can('create_users'))
    abort(403);
  }
}
```

```php
public function store(Request $request)
{
  if ($request->user()->cannot('create_users'))
    abort(403);
  }
}
```

```php
public function create()
{
  if (!auth()->user()->can('create_users'))
    abort(403);
  }
}
```

### Gate Allows / Denies

```php
public function store(Request $request)
{
    if (!Gate::allows('create_users')) {
        abort(403);
    }
}
```

```php
public function store(Request $request)
{
    abort_if(Gate::denies('create_users'), 403);
}
```

```php
public function store(Request $request)
{
    abort_if(Gate::denies('create_users'), 403);
}
```

### Controller Authorise

```php
public function store(Request $request)
{
    $this->authorize('create_users');
}
```

### Form Request class

```php
public function store(StoreUserRequest $request)
{
    // No check is needed in the Controller method
}
```

```php
class StoreProjectRequest extends FormRequest
{
    public function authorize()
    {
        return Gate::allows('create_users');
    }
 
    public function rules()
    {
        return [
            // ...
        ];
    }
}
```

## Policies

Model-based set of permissions

When used:

Able to attach permission to model?

Create a Policy using:

```shell
php artisan make:policy MODELNAMEPolicy --model=MODELNAME
```

Example:

```shell
php artisan make:policy ProductPolicy --model=Product
```

The Policy file will contain stubs.

You define the condition for true/false result, e.g.:

```php
class ProductPolicy
{
    public function create(User $user)
    {
        return $user->is_admin == 1;
    }

/* ... snipped out code ... */

}
```

### Check the Policy

Use these in a similar way to gates:

```php
public function store(Request $request)
{
    $this->authorize('create', Product::class);
}
```

## Roles

Universal set of Permissions

Not part of the framework
- ‘Human readable’ term
- Group Permissions

Examples include:
- Product Manager
- User Administrator
- Editor
- Author

# Spatie Permissions

Package to help with Roles and Permissions

- Assist by abstracting permission management
- Make it more human friendly

```php
$user->givePermissionTo('edit articles’);

$user->assignRole('writer’);

$role->givePermissionTo('edit articles’);

$user->can('edit articles');

```

## Creating a Demo App

Using Roles and Permissions in a small demo application

Code is available on GitHub: https://github.com/AdyGCode/laravel-11-roles-permissions-demo

We STRONGLY suggest you complete this tutorial from scratch

This will assist your understanding and ability to apply to other projects

### Starting Off

We presume you are using the bash terminal

For details on setting this up check the https://help.screencraft.net.au FAQs

Change into your Source/Repos folder:

```shell
cd /c/Users/USERID
cd Source/Repos
```

Create a new Laravel Application

```shell
laravel new laravel-11-roles-permissions
```

Use the following settings:

| Prompt             | Response |
|--------------------|----------|
| Starter Kit:       | Breeze   |
| Stack:             | Blade    |
| Dark Mode:         | No       |
| Testing Framework: | Pest     |
| Git Repo:          | Yes      |
| Database:          | SQLite   |

Change into your new project

```shell
cd laravel-11-roles-permissions
```

Install Spatie Permissions

```shell
composer require spatie/laravel-permission
```

Publish the Laravel Permission migrations etc:

```shell
php artisan vendor:publish --provider="Spatie\Permission\PermissionServiceProvider" 
```

Split the terminal into 5 panels:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+➖

Select the lower panel and use:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+➕
- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+➕

Remember that resizing panels is easy:

Click in the panel and use: <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+ ⬅️➡️⬆️⬇️ (arrow keys)

In each of the three panels execute:

```shell
cd laravel-11-roles-permissions
```

Click back in left-most panel and execute:

```shell
npm i && npm run dev
```

In middle panel execute:

```shell
mailpit --smtp=0.0.0.0:2525
```

In the right panel execute:

```shell
php artisan queue:listen --verbose
```

You are ready to continue…

### Bootstrapping the App

Bootstrap in this case means:

- To load more complex code within the application using a smaller and simpler piece of code.

Edit the `bootstrap/app.php` file, and update the ‘use’ lines by adding:

```php
use Spatie\Permission\Middleware\PermissionMiddleware;
use Spatie\Permission\Middleware\RoleMiddleware;
use Spatie\Permission\Middleware\RoleOrPermissionMiddleware;
```

Update the ‘middleware’ section, to load the Spatie Permissions Role, Permission and Role or
Permission middleware

```php
->withMiddleware(function (Middleware $middleware) {
    //
    $middleware->alias([
        'role' => RoleMiddleware::class,
        'permission' => PermissionMiddleware::class,
        'role_or_permission' => RoleOrPermissionMiddleware::class,
    ]);
})
```

Use the command below to create a new Roles and Permissions Controller:

```shell
php artisan make:controller RolesAndPermissionsController
```

Open the new file from the `app/Http/Controllers` folder

Edit the use lines to include:

```php
use App\Models\User;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Auth\Middleware\Authorize;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use Illuminate\Support\Facades\Gate;
use Spatie\Permission\Middleware\PermissionMiddleware;
use Spatie\Permission\Middleware\RoleMiddleware;
use Spatie\Permission\Models\Role;

```

Note the inclusion of the Spatie Permissions middleware, models and more.

We are now going to add a middleware, instantiation, index, store and destroy methods.

### Roles And Permissions Controller

#### Middleware method

Returns a list of valid ‘roles’ that have access to the controller

```php
    public static function middleware(): array
    {
        return [
            // examples with aliases, pipe-separated names, guards, etc:
            'role:Super-Admin|Admin',
        ];
    }
```

# Instantiation

```php
function __construct()
{
    // ensure admin has recently logged in, so it's not 
    // an unattended admin console being used
    $this->middleware('password.confirm');

    Gate::define('can delete admins', function ($user) {
        return $user->hasAnyRole('Super-Admin', 'Admin');
    });
    Gate::define('can delete super-admins', function ($user) {
        return $user->hasRole('Super-Admin');
    });
}
```

### Index

```php
public function index()
{
    // build the user-selector dropdown array for the view
    $select = new User;
    $select->id = 0;
    $select->name = ' Please select';

    $excludeRoles = [];
    // don't allow super-admins to be deleted unless pass the 
    // rule defined earlier
    if (!auth()->user()->can('can delete super-admins')) {
        $excludeRoles[] = 'Super-Admin';
    }

    // build a list of roles for dropdown
    $roles = Role::whereNotIn('name', $excludeRoles) 
             // ALERT: agnostic of guard_name here!
        ->with('users')
        ->get();

    // build a list of users for the dropdown
    $users = User::query()
        ->with('roles')
        ->get();

    return view('admin.roles_editor',
        [
            'roles' => $roles,
            'users' => $users->prepend($select),
            'canEdit' => auth()->user()->can('assign roles'),
            'canDeleteAdmins' => auth()->user()->can('can delete admins'),
            'canDeleteSuperAdmins' => auth()->user()
                                            ->can('can delete super-admins'),
        ]);
}
```

### Store

Adding a role to a user

```php
public function store(Request $request)
{
    \abort_unless($request->user()->can('assign roles'), '403',
        'You do not have permission to make Role assignments.');

    $rules = [
        'member_id' => 'exists:users,id',
        'role_id' => 'exists:roles,id',
    ];
    
    $request->validate($rules);

    $member = User::find($request->input('member_id'));
    $role = Role::findById($request->input('role_id'));

    // if member already has the role, flash message and return
    if ($member->hasRole($role)) {
        //optionally flash a session error message
        // flash()->warning('Note: Member already has the selected role. No action taken.');

        return redirect(route('admin.permissions'));
    }

    // do the assignment
    $member->assignRole($role);

    // optionally flash a success message
    // flash()->success($role->name . ' role assigned to ' . $member->name . '.');

    return redirect(route('admin.permissions'))
        ->with('success', 'Role Created/Updated successfully');
}
```

### Destroy

```php
public function destroy(Request $request)
{
    \abort_unless($request->user()->can('assign roles'), '403',
        'You do not have permission to change Role assignments.');

    $rules = [
        'member_id' => 'exists:users,id',
        'role_id' => 'exists:roles,id',
    ];

    $request->validate($rules);

    $member = User::find($request->input('member_id'));
    $role = Role::findById($request->input('role_id'));
    

    // cannot remove if doesn't already have it
    if (!$member->hasRole($role)) {
        // flash a session error message
        // flash()->warning('Note: Member does not have the 
                             selected role. No action taken.');

        return redirect(route('admin.permissions'));
    }

    // Prevent tampering with admins
    if ($role->name === 'Admin' && 
        $request->user()->cannot('can delete admins')) {
        // flash()->warning('Action could not be taken.');

        return redirect(route('admin.permissions'));
    }

    if ($role->name === 'Super-Admin' && 
        $request->user()->cannot('can delete super-admins')) {
        // flash()->warning('Action could not be taken.');

        return redirect(route('admin.permissions'));
    }

    // do the actual removal.
    $member->removeRole($role);

    return redirect(route('admin.permissions'))
        ->with('success', 'Role deleted successfully');
}
```

### Admin Layout Component

Create a new layout component...

Use:

```shell
php artisan make:component AdminLayout
```

Open the new file from the `app/view/components` folder.

Update the render method to return: `layouts.admin` in place of
`components.administration-layout`.

Also, the render method will return a View only.

Locate the `resources/views/components` folder and move the `admin-layout.blade.php` file from
here to the `resources/views/layouts` folder, and then rename the file to `admin.blade.php`.

The code for the admin layout may be copied from the GitHub repository into
the `admin.blade.php` file.

### Views

Create a folder `/resources/views/admin`.

Create two view files: `_member_selector.blade.php` and `roles_editor.blade.php`.

Copy the source code from the GitHub Repository

#### _member_selector.blade.php

```php
<select name="{{ $fieldname ?? 'member_id'}}"
        class="w-full grow rounded-md {{ !empty($class) ? ' ' . $class : '' }}"
        {{ !empty($autofocus) ? ' autofocus' : '' }} 
        id="{{ $field_id ?? $fieldname }}">
    @foreach ($users as $u)
        <option value="{{ $u->id }}“
                {{ $u->id == ($current ?? null) ? ' selected' : '' }}>
            {{ $u->name }}
        </option>
    @endforeach
</select>
```

#### roles_editor.blade.php

Full code on Github.

```php
@foreach ($role->users as $user)
    @if( ($role->name !== 'Admin' && $canEdit) ||
         ($role->name === 'Admin' && $canDeleteAdmins) ||
         ($role->name === 'Super-Admin' && $canDeleteSuperAdmins) )
        <form class="flex flex-row items-center
                     hover:bg-neutral-100
                     px-4 py-1
                     group transition-all duration-500 ease-in-out"
              role="form"
              method="POST"
              action="{{ route('admin.revoke-role') }}">

            @csrf
            @method('delete')
        
            <input type="hidden" name="role_id" value="{{ $role->id }}">
            <input type="hidden" name="member_id" value="{{ $user->id }}">
        
            <a href="{{ route('users.show', $user->id ) }}"
               class="grow text-neutral-600 hover:text-neutral-200">
                {{ $user->name }}
            </a>
        
            <button type="submit"
                    class="align-middle text-center select-none
                          rounded
                          py-1 px-4
                          no-underline text-xs
                          text-red-800 hover:text-red-100
                          border border-1 border-neutral-400 hover:border-red-100
                          group-hover:border-red-500
                          bg-neutral-200 hover:bg-red-500
                          transition-all duration-500 ease-in-out
                          print:hidden"
                    value=" X " title="Revoke">
                <i class="fa fa-times text-lg" title="X Symbol for deletion"></i>
            </button>
        </form>
    @else
        <a href="{{ route('users.show', $user->id ) }}"
           class="bg-neutral-200 text-neutral-800">
            {{ $user->name }}
        </a>
    @endif
```

### Routes

We will be protecting the area that deals with assigning roles to users.

Actions are:

- Permissions: Show roles and users with that role
- Assign Role: Add role to the user
- Revoke Role: Remove role from the user

Important items:

- Group applies ‘middleware’ etc to multiple routes
- Prefix adds a prefix in the URI for the group
- Middleware applies the specified middleware

```php
// role-assignment screen
Route::group(['prefix' => 'admin',
              'middleware' => ['auth','verified','role:Admin|Super-Admin']], function () {
	…
});
```

Before the `require` line add:

```php
// role-assignment screen
Route::group(['prefix' => 'admin',
              'middleware' => ['auth','verified','role:Admin|Super-Admin']], function () {

    Route::get('/permissions', [RolesAndPermissionsController::class, 'index'])
        ->name('admin.permissions');

    Route::post('/assign_role', [RolesAndPermissionsController::class, 'store'])
        ->name('admin.assign-role');

    Route::delete('/revoke_role', [RolesAndPermissionsController::class, 'destroy'])
        ->name('admin.revoke-role');

    Route::resource('/users',UserController::class);
});
```

## Migration and Seeders

When you published the Spatie Permission 'tag' it generated a migration automatically.

Simply execute: `php artisan migrate` to run the new migrations

We will create some sample users plus the Roles for this demo application
```php
php artisan make:seeder UserSeeder
php artisan make:seeder RoleSeeder
```

The Role Seeder must be executed before the User Seeder.

Open the Database Seeder file, and change the run method to read:

```php
public function run(): void
{
    $this->call([
       RoleSeeder::class,
       UserSeeder::class,
    ]);

    User::factory()->create([
        'name' => 'Test User',
        'email' => 'test@example.com',
    ]); // bonus dummy user, no roles
}
```

Find the code for the RoleSeeder in this slide’s notes or on the GitHub repository
We create three roles:

```php
'name' => 'Super-Admin'
'name' => 'Admin'
'name' => ‘User’
```

Also, in the RoleSeeder we add the permissions we will use:

```php
'role-list’,    'role-show’,    'role-create',    'role-edit’,    'role-delete’, 
'product-list’, 'product-show', 'product-create’, 'product-edit’, 'product-delete’,  
'user-list’,    'user-show',    'user-create’,    'user-edit’,    'user-delete',
```

Find the code for the UserSeeder in this slide’s notes or on the GitHub repository
We create 4 users:

```php
'name' => 'Administrator',
‘name' => ‘Adrian Gould',
'name' => 'STUDENT NAME',
'name' => 'Dee Mouser',
```

The steps for the users are:
- Get the Super Admin, Admin and User roles collections
- Create the User
- Assign role to the user

Repeat ‘Create User’ and ‘Assign Role’ for other seed users.

```php
$roleSuperAdmin = Role::whereName('Super-Admin’)
                         ->get();
$roleAdmin = Role::whereName('Admin')->get();
$roleUser = Role::whereName('User')->get();

$userAdmin = User::create([
    'id' => 111,
    'name' => 'Administrator',
    'email' => 'admin@example.com',
    'password' => Hash::make('Password1')
]);

$userAdmin->assignRole([$roleSuperAdmin]);
```

As   we are in **development**, we can re-run the migrations and seed the database

```php
php artisan migrate:fresh --seed
```

Remember:
- This MUST NOT be used on a production database
- This command DROPS all existing tables and data

## Testing

Open the site using http://localhost:8000
- Click on Login
- Enter `admin@example.com and` `Password1`
- Navigate around the Roles and Users pages
- Try allocating a new role to the Test User
- Try removing the role from the test user
- Logout
- Log in as the Dee Mouser user

What are you able to view/do?



# References

- Laravel Bootcamp - Learn the PHP Framework for Web Artisans - 07 Notifications & Events. (
  2025).
  Archive.org. https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/blade/notifications-and-events

# Up Next

- [Laravel v12 Bootcamp - Part 9](../session-11/S10-Laravel-v12-BootCamp-Part-9.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
