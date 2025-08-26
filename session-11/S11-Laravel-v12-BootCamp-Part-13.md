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
created: 2024-09-20T11:17
updated: 2025-08-21T15:59
---

# S11 Laravel Bootcamp: Part 13

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

# Laravel Bootcamp: Part 13

# TODO: IN PROGRESS

## Roles and Permissions Part 4

In this section, we continue with the administration/management front-end that allows
users with particular rights to perform management actions on data in the Chirp system.

We will:

- Build User Management Interface
- Determine Roles to use in Application
- Determine Permissions each Role will have
- Apply Roles & Permissions to Application (User Management)

## Before you start…

Have you completed (not just read):

- [Laravel v12 Bootcamp - Introducing Laravel](S11-Laravel-v12-Bootcamp-Part-00-Introducing-Laravel.md),
- [Laravel v12 Bootcamp - Part 1](S11-Laravel-v12-BootCamp-Part-01.md),
- [Laravel v12 Bootcamp - Part 2](S11-Laravel-v12-BootCamp-Part-02.md)
- [Laravel v12 Bootcamp - Part 3](S11-Laravel-v12-BootCamp-Part-03.md)
- [Laravel v12 Bootcamp - Part 4](S11-Laravel-v12-BootCamp-Part-04.md)
- [Laravel v12 Bootcamp - Part 5](S11-Laravel-v12-BootCamp-Part-05.md)
- [Laravel v12 Bootcamp - Part 6](S11-Laravel-v12-BootCamp-Part-06.md)
- [Laravel v12 Bootcamp - Part 7](S11-Laravel-v12-BootCamp-Part-07.md)
- [Laravel v12 Bootcamp - Part 8](S11-Laravel-v12-BootCamp-Part-08.md)
- [Laravel v12 Bootcamp - Part 9](S11-Laravel-v12-BootCamp-Part-09.md)
- [Laravel v12 Bootcamp - Part 10](S11-Laravel-v12-BootCamp-Part-10.md)
- [Laravel v12 Bootcamp - Part 11](S11-Laravel-v12-BootCamp-Part-11.md)
- [Laravel v12 Bootcamp - Part 12](S11-Laravel-v12-BootCamp-Part-12.md)

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you may
> only see parts of the application working.
>
> So if you get an error in the browser, it may be because there is something missing.
>
> Remember that code is available from the GitHub repository.

# Updating the Roles & Permissions & Seeders

Remember the most up-to-date code is available on GitHub:

- https://github.com/AdyGCode/roles-permissions-2025-s1

Even though we give you this code, we **STRONGLY** suggest you complete this tutorial from
scratch.

This will assist your understanding and ability to apply to other projects

## Planning

It is always a good idea to carefully plan your Role Based Access Control.

Ideally, a table showing the Role (horizontally) and the Permissions (vertically) with an
indicator if the role has the permission or not.

Here is a basic example. Across the top are the Roles, and down the side are the actions that
may be performed.

A `Y` means they are authorised to perform the action, a `blank` means they are not authorised to perform the action.

Here we have named the actions based on the BREAD acronym, and kept the resource being operated upon SINGULAR.

| Actions ⬇️        | Super Admin | Admin | Staff | Client |
| ----------------- | :---------: | :---: | :---: | :----: |
| browse user       |      Y      |   Y   |   Y   |        |
| read user         |      Y      |   Y   |   Y   |        |
| add user          |      Y      |   Y   |   Y   |        |
| edit user         |      Y      |   Y   |   Y   |        |
| delete user       |      Y      |   Y   |       |        |
| ...               |             |       |       |        |
| browse roles      |      Y      |   Y   |   Y   |        |
| read role         |      Y      |   Y   |       |        |
| edit role         |      Y      |   Y   |       |        |
| add role          |      Y      |   Y   |       |        |
| delete role       |      Y      |       |       |        |
| ...               |             |       |       |        |
| browse permission |      Y      |   Y   |   Y   |        |
| read permission   |      Y      |   Y   |       |        |
| edit permission   |      Y      |       |       |        |
| add permission    |      Y      |       |       |        |
| delete permission |      Y      |       |       |        |
| ...               |             |       |       |        |
| browse post       |      Y      |   Y   |   Y   |   Y    |
| read post         |      Y      |   Y   |   Y   |   Y    |
| edit post         |      Y      |       |       |   Y    |
| add post          |      Y      |       |       |   Y    |
| delete post       |      Y      |   Y   |   Y   |   Y    |
| publish post      |      Y      |       |   Y   |   Y    |
| ...               |             |       |       |        |

We obviously will have issues where a Staff user must not be able to change the role of an admin user, and so on... these sort of items we can look at once the basic permissions are applied.

It is possible to make the table more explicit and have lines for the likes of "Edit Admin User: change roles" if wanted. How you document your roles and permissions is important and should be documented no matter how complex the situation.

## Create a New Roles and Permissions Seeder

Before we continue, we are going to create a new seeder, and replace the current Role and Permissions seeders.

As we do this, we will use the table we created as the start point.

```shell
php artisan make:seeder RoleAndPermissionSeeder
```

Once created, it's time to unify the two existing seeders into one.

Open the `RoleAndPermissionSeeder` from the database migrations folder.

We are going to implement the permissions, one by one, with details on what each is doing.

#### Add List of Permissions

After the `run` method signature and opening `{` curly bracket, we add the list of the permissions we wish to use to seed the database.

```php
$seedPermissions = [  
    'browse user',  
    'read user',  
    'edit user',  
    'add user',  
    'delete user',  
  
    'browse post',  
    'read post',  
    'edit post',  
    'add post',  
    'delete post',  
    'publish post',  
  
    'browse permission',  
    'read permission',  
    'edit permission',  
    'add permission',  
    'delete permission',  
  
    'browse role',  
    'read role',  
    'edit role',  
    'add role',  
    'delete role',  
  
];
```

Nothing difficult about this list of strings.

Next we will do something a little different. We are going to add a CLI "progress" meter to this seeder.

We create a new `ConsoleOutput` object that allows data to be sent to the command line output.

Next a progress bar is created, linked to the output 'channel', with a count of the seed permissions. This allows the progress bar to step along as it performs the seeding.

```php
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedPermissions));  
$output->writeln("");  
$output->writeln('Seed Permissions');  
$progress->start();
```

Next we loop over the seed permissions, creating each one in turn.

After creating the permission, we tell the progress bar to advance...

```php
foreach ($seedPermissions as $newPermission) {  
    $permission = Permission::firstOrCreate(['name' => $newPermission]);  
    $progress->advance();  
}
```

After the seeding is completed, we tell the progress bar to finish and then output a blank line.

```php
$progress->finish();  
$output->writeln('');
```

OK, so that is the permissions seeded, now we are able to work with the roles and add the permissions as needed.

#### Create Super-Admin Role

This is an optional part of the seeding, but you may find it useful to define a super-admin. An administrator who can do ANYTHING.

Yes, be aware of the security implications with this!

Note the use of `firstOrCreate` which does a double action - it first checks to see if the role has already been created (`first`) and if so retrieves it's details. If not, then it creates the role and again grabs the resulting new role's details.

Neat way to work!

After this it syncs the permisssons.

```php
/* Create Super-Admin Role and Sync Permissions */  
  
$progress = new ProgressBar($output, 4);  
$output->writeln("");  
$output->writeln('Grant Permissions to Roles');  
$progress->start();  
  
$roleSuperAdmin = Role::firstOrCreate([
	'name' => 'super-admin'
]);  

$roleSuperAdmin->syncPermissions();  
$progress->advance();
```


It is interesting to see we have not allocated all the permissions to the super-admin. This is because we will use a "gate" to apply an all access pass later in this stage.

#### Admin Role

Next we create the admin role.

Here we create the role, then we list all the permissions the administrator role can perform, before synching them with the admin role.

```php
/* Create Admin Role and Sync Permissions */  
  
$roleAdmin = Role::firstOrCreate(['name' => 'admin']);  

$adminPermissions = [  
    'browse user', 'read user', 'edit user', 'add user', 'delete user',  
    'browse post', 'read post', 'edit post', 'add post', 'delete post', 
    'browse permission', 'read permission', 'edit permission', 'add permission',  
    'browse role', 'read role', 'edit role', 'add role', 
	'browse post', 'read post', 'edit post', 'add post', 'delete post', 'publish post',  
];  

$roleAdmin->syncPermissions($adminPermissions);  
$progress->advance();
```


> ### Important: 
> 
> Make sure you check the table against this list of permissions. Make sure you fix any errors.


This process is going to be repeated with the Staff and Client roles.

#### Staff Role

We keep going, next with the staff role.

```php
/* Create Staff Role and Sync Permissions */  
  
$roleStaff = Role::firstOrCreate(['name' => 'staff']);  

$staffPermissions = [  
    'browse user', 'read user', 'edit user', 'add user', 'delete user',  
    'browse permission', 'read permission',  
    'browse role', 'read role',  
	'browse post', 'read post', 'edit post', 'add post', 'delete post',  
	];  
	
$roleStaff->syncPermissions($staffPermissions);  
$progress->advance();
```

> ### Important: 
> 
> Make sure you check the table against this list of permissions. Make sure you fix any errors.


#### Client Role

Finally the client role.

```php
/* Create Client Role and Sync Permissions */  
  
$roleClient = Role::create(['name' => 'client']);  
$clientPermissions = [  
    'browse post', 'read post', 'edit post', 'add post', 'delete post', 'publish post',  
];  
$roleClient->syncPermissions($clientPermissions);  
$progress->advance();  
  
$progress->finish();  
$output->writeln("");
```

> ### Important: 
> 
> Make sure you check the table against this list of permissions. Make sure you fix any errors.

That's the seeder completed.

> ### Error?
> 
> Did you spot the error in the client role seeder code?


#### Forgetting Cached Permissions

Just after the `{` of the "run" method signature line (`public function run(): void`), we add:

```php
// Reset cached roles and permissions  
app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();  
  
```

This ensures that the permissions that may have been cached are removed before seeding starts.

#### Update the Database Seeder

Next we need to update the database seeder.

Remove the Role and Permission seeder lines and add one for the `RoleAndPermissionSeeder` instead.


```php
$this->call([  
    RoleAndPermissionSeeder::class,  
  
    AdminUserSeeder::class,  
    StaffUserSeeder::class,  
    UserSeeder::class,  
  
]);
```

#### Reseed the Database

Because we are in development mode, we can reseed the database without any issues.

```shell
php artisan migrate:fresh --seed
```

If you wanted to run JUST the `RoleAndPermissionSeeder` then you could use:

```shell
php artisan db:seed RoleAndPermissionSeeder
```

This would also be safe for production.

## Admin, Staff and Client Users Seeders

We need to make a few changes to the Admin, Client and Staff user seeders. This is to reflect the changes in the roles and permissions and also to make sure we have everything seeded as expected.

Instead of explaining every line, we will show blocks of the code with brief descriptions (which may be just one or two words)...

### Admin Users Seeder

List the details of the seed users - in this case the "super-admin" and an "admin" user.

```php
$seedAdminUsers = [  
    [  
        'id' => 100,  
        'name' => 'Ad Ministrator',  
        'email' => 'admin@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles'=>['staff','admin',]  
    ],  
    [  
        'id' => 99,  
        'name' => 'System Administrator',  
        'email' => 'systemadmin@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles'=>['super-admin',]  
    ],  
];
```

Start the progress bar:

```php
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedAdminUsers));  
$progress->start();
```

Seed users:

```php
foreach ($seedAdminUsers as $user) {  
    $roles = $user['roles'] ?? null;  
    unset($user['roles']);  
  
    $adminUser = User::updateOrCreate(  
        ['id' => $user['id']],  
        $user  
    );  
  
    $adminUser->assignRole($roles);  
    $progress->advance();  
}
```

End the progress bar:

```php
$progress->finish();  
$output->writeln("");
```

The remaining seeders will be very similar!

### Staff Users Seeder

```php
  
$seedStaffUsers = [  
    [  
        'id' => 200,  
        'name' => 'Staff User',  
        'email' => 'staff@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles' => ['staff',],  
    ],  
    [  
        'id' => 201,  
        'name' => 'Staff User 2',  
        'email' => 'staff2@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles' => ['staff', 'client'],  
    ],  
    [  
        'id' => 203,  
        'name' => 'Staff User 3',  
        'email' => 'staff3@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles' => ['staff'],  
    ],  
];  
  
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedStaffUsers));  
$progress->start();  
  
foreach ($seedStaffUsers as $user) {  
    $roles = $user['roles'] ?? null;  
    unset($user['roles']);  
  
    $staffUser = User::updateOrCreate(  
        ['id' => $user['id']],  
        $user  
    );  
  
    $staffUser->assignRole($roles);  
    $progress->advance();  
}  

$progress->finish();  
$output->writeln("");
```

### Client Users Seeder

```php
$seedClientUsers = [  
    [  
        'id' => 501,  
        'name' => 'Client User',  
        'email' => 'client@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles' => ['client',],  
    ],  
    [  
        'id' => 502,  
        'name' => 'Crystal Chantal-Lear',  
        'email' => 'crystal@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => null,  
    ],  
    [  
        'id' => 503,  
        'name' => 'Robyn Banks',  
        'email' => 'robyn@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => now(),  
        'roles' => ['client',],  
    ],  
    [  
        'id' => 504,  
        'name' => 'Eileen Dover',  
        'email' => 'eileen@example.com',  
        'password' => 'Password1',  
        'email_verified_at' => null,  
        'roles' => ['client',],  
    ],  
];  
  
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedClientUsers));  
$progress->start();  
  
foreach ($seedClientUsers as $user) {  
    $roles = $user['roles'] ?? null;  
    unset($user['roles']);  
  
    $clientUser = User::updateOrCreate(  
        ['id' => $user['id']],  
        $user  
    );  
  
    if (isset($roles)) {  
        $clientUser->assignRole($roles);  
    }  
    $progress->advance();  
}  
  
$progress->finish();  
$output->writeln("");
```

We suggest that you run each seeder in turn, using the `db:seed` method from above.

```shell
php artisan db:seed AdminUserSeeder
php artisan db:seed StaffUserSeeder
php artisan db:seed UserSeeder
```

# Super Admin!

Adding a super admin is quite easy when working with Spatie's Permissions package.

It is detailed in the package's documentaiton and in many tutorials.

- https://spatie.be/docs/laravel-permission/v6/basic-usage/super-admin 

Open the `App/Providers/AppServiceProvider` class, and in the `boot` method add the following:

```php
// Implicitly grant "Super Admin" role all permissions  
// This works in the app by using gate-related functions like auth()->user->can() and @can()  
// See https://spatie.be/docs/laravel-permission/v6/basic-usage/super-admin  
Gate::before(function ($user, $ability) {  
    return $user->hasRole('super-admin') ? true : null;  
});
```

This will check to see if the logged in user is a super admin, and if they are, grant FULL PERMISSIONS to the user by opening the permissions gate.

# Update The Views

Now we have the roles and permissions seeded, we can operate on the views.

There are a number of ways we can apply the roles and permissions to the views.

The most important thing to remember is that PERMISSIONS should ALWAYS take PRIORITY over ROLES.

In a blade template, you may use either:

- `@hasrole(...)` ... `@endhasrole`

or

- `@can(...)` ... `@endcan`

or one of their variants.


## Navigation

We begin by updating the navigation.

> ### IMPORTANT
>
> We are going to show you how to update the "desktop" navigation, but expect you to complete the mobile section as well.

Open the `navigation.blade.php` file and locate the "Navigation Links" section.

We are going to wrap the "admin" link with a `hasrole` that checks if the role the currently logged in user has is a staff, admin or super admin.


```php

@hasrole('admin|staff|super-admin')  
<x-nav-link :href="route('admin.index')"  
            :active="request()->routeIs('admin.*')">  
	<i class="fa-solid fa-user-tie mr-1"></i>  
        {{ __('Admin') }}  
    </x-nav-link>  
@endhasrole  
```


Now if you refresh and are logged in as a client, you will not see the admin link!

![](../assets/Pasted%20image%2020250610173242.png)

That's it (apart from the mobile navigation that you need to update).

## Permissions

Next onto the permissions.

The steps here will be applied to the other views as well. The only changes are the roles or permissions we are going to be allowing to perform actions.

### Permissions Create

Open the `create.blade.php` file from the admin/permissions folder.

Locate the `admin.permissions.create` link, and we are going to wrap it in a `@can` that checks for the logged in user's ability to  `add permission`.

```php
@can('add permission')  
    <a href="{{ route('admin.permissions.create') }}"  
       class="rounded bg-green-500 text-white hover:bg-white hover:text-green-500 border-green-500 px-4 py-2">  
        New Permission  
    </a>  
@endcan
```

This is painless!

Also we wrap the whole form in the same `@can('add permission')` and `@endcan` blade tags.

One small change is that we are also going to display a big red warning that they cannot perform the action... We show it in its entirety on this occasion.

```php
    @can('add permission')  
  
        <form action="{{ route('admin.permissions.store') }}"  
              method="POST"  
              class="p-6 flex flex-col space-y-4">  
  
            @csrf  
  
            <div>  
                <x-input-label for="name" :value="__('Permission Name')"/>  
  
                <x-text-input id="name" class="block mt-1 w-full" type="name" name="name"  
                              :value="old('name')" required/>  
  
                <x-input-error :messages="$errors->get('name')" class="mt-2"/>  
            </div>  
  
            <div class="flex flex-row space-x-4">  
  
                <x-primary-button>  
                    Save  
                </x-primary-button>  
                <x-link-button href="{{route('admin.permissions.index')}}">  
                    Cancel  
                </x-link-button>  
            </div>  
        </form>  
  
    @else  
        <p class="p-6 bg-red-500 text-white">You are not able to create new permissions</p>  
    @endcan  
```


And you are done.

### Permissions Delete

Similar principle to the previous example.

Wrap the "New permission link" (just a moment, that is the same as we just did for create... yep, we did say you'd be repeating yourself a fair amount).

```php
@can('add permission')  
    <a href="{{ route('admin.permissions.create') }}"  
       class="rounded bg-green-500 text-white hover:bg-white hover:text-green-500 border-green-500 px-4 py-2">  
        New Permission  
    </a>  
@endcan
```

Wrap the form in `@can('delete permission')` ... `@endcan`. 

We are not going to show all the code as it is the same process except for the message when the user cannot perform the action...

```php
  
@can('delete permission')  
<form action="{{ route('admin.permissions.destroy', $permission) }}"  
      method="POST"  
      class="p-6 flex flex-col space-y-4">  

<!-- 
We have removed this code for brevity. 
Ensure you do not remove any code.
Endure you wrap with the can/else/endcan 
-->
</form>
  
@else  
    <p class="p-6 bg-red-500 text-white">You are not able to delete permissions</p>  
@endcan
```


### Edit Permission

Guess what... you do the same again!

This time the permission for the form is `edit permission` in place of `delete permission`.

```php
@can('edit permission')  
    <form action="{{ route('admin.permissions.update', $permission) }}"  
          method="POST"  
          class="p-6 flex flex-col space-y-4">  

<!-- 
We have removed this code for brevity. 
Ensure you do not remove any code.
Endure you wrap with the can/else/endcan 
-->
</form>
  
@else  
    <p class="p-6 bg-red-500 text-white">You are not able to edit permissions</p>  
@endcan  

```

### Browse Permission

Finally browse permission. 

This is slightly different as we will hide the buttons based on the permission the user has.

We are not going to show full code, but we will show the wrapped code.

#### "New Permission" button

```php
@can('add permission')  
    <a href="{{ route('admin.permissions.create') }}"  
       class="rounded bg-green-500 text-white hover:bg-white hover:text-green-500 border-green-500 px-4 py-2">  
        New Permission  
    </a>  
@endcan
```

#### "Edit Permission" button

```php
@can('edit permission')  
    <x-link-button  
        class="hover:bg-amber-400 focus:bg-amber-400 active:bg-amber-400"  
        href="{{ route('admin.permissions.edit', $permission) }}">  
        Edit  
    </x-link-button>  
@endcan
```

#### "Delete Permission" button

```php
@can('delete permission')  
    <x-link-button  
        class="hover:bg-red-500 focus:bg-red-400 active:bg-red-400 "  
        href="{{ route('admin.permissions.delete', $permission) }}">  
        Delete  
    </x-link-button>  
@endcan
```



## Roles Views

The roles views will be exactly the same apart from "role" instead of "permission".

This is left as an exercise. Remember that we do provide the updated code in the GitHub repository.

## User Views

The user views will be the same, except we obviously now can view the user, and we also have the ability to update their role, or even permissions on a individual basis.


# TODO: Finish off User Views


# TODO: Add Web Routes Update

```php
Route::name('admin.')  
    ->prefix('admin')  
    ->middleware(['auth', 'verified', 'role:staff|admin|super-admin'])  
    ->group(function () {  
  
        Route::get('/', [StaticPageController::class, 'admin'])  
            ->name('index');  
  
        Route::post('roles/{role}/permissions', [RoleController::class, 'givePermission'])  
            ->name('roles.permissions');  
        Route::delete('roles/{role}/permissions/{permission}', [RoleController::class, 'revokePermission'])  
            ->name('roles.permissions.revoke');  
  
        Route::get('roles/{role}/delete', [RoleController::class, 'delete'])  
            ->name('roles.delete');  
  
        Route::resource('/roles', RoleController::class);  
  
        Route::get('permissions/{permission}/delete', [PermissionController::class, 'delete'])  
            ->name('permissions.delete');  
        Route::resource('/permissions', PermissionController::class);  
  
        Route::post('users/{user}/roles', [UserController::class, 'giveRole'])  
            ->name('users.roles');  
        Route::delete('users/{user}/roles', [UserController::class, 'revokeRole'])  
            ->name('users.roles.revoke');  
  
        Route::post('users/{user}/delete', [UserController::class, "delete"])  
            ->name('users.delete');  
  
        Route::resource('users',  
            UserController::class);  
    });
```

# App and Guest Template Fix

You may have noticed a problem with the icons on the admin pages. 

They are missing.

That is because we made a newbie error and forgot to load them from assets.

The `assets` function gives the full URL to the file you are wanting to add when it is stored in the `public` folder.

So in our case we are wanting the `css/all.css` file so we make sure the file is in the `public/css/` folder then use `asset` to create the correct URL.

```php
<link rel="stylesheet" href="{{ asset('css/all.css') }}">
```

Fix the appropriate line in the App and Guest blade template files.

# Using roles and permissions with controllers or policies

The next level of security is applied at the 'controller' level.

There are various ways to apply the policies or roles, we will show you some alternatives.


## Option 1: 


## Option 2: Controller Constructor & Middleware

The first option is to use middleware in the controller's constructor method.

For example, here we show the constructor for the `RoleController`:

*The `__construct()` usually is placed as the first of the methods within the controller class.*

```php
/**  
 * Role Constructor
 *     
 * Apply permissions to the methods before they are 'called'     
 */
public function __construct()  
{  
    $this->middleware('permission:browse role', ['only' => ['index',]]);  
    
    $this->middleware('permission:read role', ['only' => ['show',]]);  
    
    $this->middleware('permission:edit role', ['only' => ['update', 'edit', 'givePermission', 'revokePermission']]);  
    
    $this->middleware('permission:add role', ['only' => ['create', 'store', 'givePermission', 'revokePermission']]);  
    
    $this->middleware('permission:delete role', ['only' => ['delete', 'destroy']]);  
    }
```

The "only" tells the middleware to *only allow the following methods to be executed*. 

So for the "add role" permission the actions that are allowed to be performed are the `create`, `store`, `givePermission`,  and `revokePermission` methods.


## Option 3: Model Policies

- https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

The third option is to use Model Policies.

We will do this with a `Post` model.

### Create Post Model et al

To do this we need to add the model (we already have the permissions added in previous steps).

```shell
php artisan make:model Post --controller --resource --migration --seed --factory
```

> #### Exercise time...
> 
> Yes this is the long hand version of the model creation... 
>  
>  As an exercise, what would a short-hand version of the same command?
>  
>  Hint: use `php artisan make:model --help` for assistance.


### Post Migration

Now edit the migration to have the following:

```php
public function up(): void  
{  
    Schema::create('posts', function (Blueprint $table) {  
        $table->id();  
        $table->foreignId('user_id');  
        $table->string('title');  
        $table->text('content');  
        $table->timestamps();  
    });  
}
```

### Post Factory

We are going to use a factory to mock our posts for this exercise.

```php
public function definition(): array  
{  
    return [  
        'title'=> $this->faker->sentence(),  
        'content'=> $this->faker->paragraph(),  
        'user_id'=> \App\Models\User::inRandomOrder()->first()->id,  
    ];  
}
```

The `user_id`  is created by randomly selecting an existing user from the User model. Nice trick for use when testing as well.

### Post Seeder

Next, update the `PostSeeder` by adding the following code:

```php
public function run(): void  
{  
  
        Post::factory(20)->create();  
  
}
```

Run the migration and perform the seeding of the Post model using:

```shell
php artisan migrate 
php artisan db:seed PostSeeder
```


### Post Policy - **Best Practice* 

- https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies


The post policy will be applied to the Post model, and in this instance the web routes. 

The guard could be `web`, `api` or `command` depending on what routes this policy is being applied to.

```shell
php artisan make:policy PostPolicy --model=Post --guard=web
```

Now we will edit the policy (`App/Policies/PostPolicy.php`).

By default the policies are "false", but we need to allow them given the ability to do something.

We use the `can` method on the logged in user. 

**Note: We have added further permissions to the role and permission seeder, to provide a more granular list of permissions.**

```php

```

#### Applying Policies

- https://laravel.com/docs/12.x/authorization#creating-policies
- 
To use a policy there are some different methods.

We are able to:

- apply the policy in the 
- add the policy to the model




# Conclusion

That's it, an example of applying roles and permissions to an application.

Hopefully you have enough information to be able to apply the principles to your code.

The last parts in this series will be adding our own 'twist' to the error pages, and other random ideas, hints and tips.


# TODO: Update Useful References and Tutorials

# References

- Xhepa, T. (2022, March 1). Spatie Laravel Permission. YouTube. http://www.youtube.com/playlist?list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js

# Up Next

- [Laravel v12 Bootcamp - Part 14](session-11/S10-Laravel-v12-BootCamp-Part-14.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END



Research
https://www.youtube.com/@codingoblin

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://laravel.com/docs/12.x/authorization#via-the-user-model

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://medium.com/@codeaxion77/supercharge-your-laravel-app-with-spatie-roles-and-permissions-f20fe02a8c75

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://laravel.io/forum/set-permission-in-controller-when-using-spatiepermission

https://www.fundaofwebit.com/post/laravel-10-spatie-user-roles-and-permissions-tutorial

https://dev.to/varzoeaa/spatie-permissions-vs-laravel-policies-and-gates-handling-role-based-access-1bdn

https://magecomp.com/blog/manage-role-in-laravel-using-spatie-laravel-permission/

https://devpishon.hashnode.dev/streamline-role-based-access-control-with-spatie-laravel-permission

https://www.creative-tim.com/twcomponents/component/card-stats

https://tailwindcss.com/plus/ui-blocks/application-ui/data-display/stats

https://www.youtube.com/watch?v=cNrMdCXNml8&list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js&index=15

https://spatie.be/docs/laravel-permission/v6/basic-usage/blade-directives




https://www.fundaofwebit.com/post/laravel-policy-using-spatie-roles-and-permission-tutorial-step-by-step
