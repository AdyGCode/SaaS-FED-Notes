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
created: 2024-09-20T11:17
updated: 2025-10-28T22:56
---


# Laravel Bootcamp: Part 12

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

# Laravel Bootcamp: Part 12

## Roles and Permissions Part 2

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


No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you may only see parts of the application working.
>
> So if you get an error in the browser, it may be because there is something missing.
> 
> Remember that code is available from the GitHub repository.
> 
>
> - https://github.com/AdyGCode/xxx-roles-permissions-2025-s2
>
> Even though we give you this code, we **STRONGLY** suggest you complete this tutorial from scratch.
>
> This will assist your understanding and ability to apply to other projects.


# Permissions

As we know, roles have permissions, but with our current data there are no permissions for the roles.

We will fix this issue before continuing.

## Adding Permissions to Seed Data

We will add the permissions to the Role Seeder... it makes it easier to maintain as we need to update the permissions for the application.

Open the `RoleSeeder.php` file, and update it.

Begin by updating the list of classes used by this Seeder class:

```php
use Illuminate\Database\Console\Seeds\WithoutModelEvents;  
use Illuminate\Database\Seeder;  
use Illuminate\Support\Str;  
  
use Laravel\Prompts\Output\ConsoleOutput;  

use Spatie\Permission\Models\Permission;  
use Spatie\Permission\Models\Role;  

use Symfony\Component\Console\Helper\ProgressBar;
```

Next we will define the permissions. We do this by adding the following immediately AFTER the `public function run(): void {`:

```php
app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();  
```

This tells the Spatie package to clear the cached permissions so that we can update the collection.

Next we define the permissions, without allocating them to any particular role or user. It is simply an array of the permission names.

> **Note:** we will be kebab casing the permissions as we add them, but you may do this as you create them, and use the kebab method as a precaution.
>
>To illustrate this we have kebab cased two or three of the permissions.

```php
$seedPermissions = [  
  
    'browse-post',  
    'read-any-post',  
    'read own post',  
    'read any unpublished post',  
    'read own unpublished post',  
    'edit any post',  
    'edit own post',  
    'add post',  
    'delete any post',  
    'delete own post',  
    'publish any post',  
    'publish own post',  
    'restore any post',  
    'restore own post',  
    'trash any post',  
    'trash own post',  
  
    'browse-user',  
    'read user',  
    'edit user',  
    'add user',  
    'delete user',  
  
    'browse permission',  
    'read permission',  
    'edit permission',  
    'add permission',  
    'delete permission',  
  
    'browse role',  
    'read role',  
    'edit role',  
    'add role',  
    'delete-role',  
  
];  
```

Ok, so now we are going to do a little more with the seeding.

You will have noted that when you are seeding data it is not possible to tell how far though it has progressed.

What we are going to do in this seeder (and you will be welcome to update any other seeders) is to add a progress bar to show this.

We begin by setting up the console output, and setting the progress bar.

The progress bar uses the count of the number of items to seed as a way to show the progress between 0% and 100%.

The progress bar is started after a short message.
```php  
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedPermissions));  
$output->writeln("");  
$output->writeln('Seed Permissions');  
$progress->start();  
```

Now we use a good old `foreach` loop to progress thrugh the seed data and add the new permissions:

```php  
foreach ($seedPermissions as $newPermission) {
	$newPermission = Str::of($newPermission)->kebab();
	  
    $permission = Permission::firstOrCreate(['name' => $newPermission]);  
    $progress->advance();  
}  
```

> **Note:** You may encounter an issue with the line:
>  
> ```php
> $newPermission = Str::of($newPermission)->kebab();
> ```
> If you do, then try these possible solutions:
> - Run `composer update` in your project's root folder to ensure latest package versions are present.
> - Replace the line with  `$newPermission = Str::kebab($newPermission);
>
> The original line runs successfully for the author on bot Windows and Mac systems.


The final step is to finish up the progress bar and output a blank to force the cursor to the next line.
```php  
$progress->finish();  
$output->writeln('');
```


##### Aside: Interesting String Utility Methods - `of()` and `kebab()`

You will note that in the line:
 
```php
$newPermission = Str::of($newPermission)->kebab();
```

We see two static methods being used:

- `Str::of()` 
	- ensures that the variable is "stringable".
	- provides access to chaining Str utility methods such as `lower()`, `title()`, `reverse()`, `limit()`, and `excerpt()`.
	- See Laravel Docs: https://laravel.com/docs/12.x/strings
- `Str::kebab()` 
	- converts the string into kebeb case
  
So for a permission such as `Admin everything` the result is `admin-everything`.

Another use-case of Str is shown at: https://laravel-news.com/attributes-as-stringable


### Adding Permissions to our Default Roles 

Ok, so we have the permissions seeded, and we already have a list of our roles. Next we are going to add the permissions for each role.

Immediately after the above code we will now add four sections, each creating a role and adding permissions.

### Super Admin Role

The super admin role has permission to perform ALL actions.

To do this, we add the following code:
```php
$output->writeln('Create Roles with Permissions');  
$output->writeln('');  
  
/* Create Super-Admin Role and Sync Permissions */  
  
$progress = new ProgressBar($output, 4);  
$output->writeln("");  
$output->writeln('Grant Permissions to Roles');  
$progress->start();  
  
$roleSuperAdmin = Role::firstOrCreate(
					  ['name' => 'super-user']
				  );  
  
$roleSuperAdmin->syncPermissions();  
$progress->advance();
```

This is the simplest of the stages. The strange thing here is that we DO NOT need to have any permissions synchronised, so the `synvPermissions()` call is empty.

We will use a different method to permit the super user complete access. We still need the role as we need to allocate it to a user.

Next we will do the admin role.

### Admin Role

The admin role has a set of permissions that is not quite as extensive as the super admin, but may be very close.

To shorten the code we have put multiple permissions on each line.

```php
/* Create Admin Role and Sync Permissions */  
  
$roleAdmin = Role::firstOrCreate(['name' => 'admin']);  
  
$adminPermissions = [  
    'browse user', 'read user', 'edit user',
    'add user', 'delete user', 'browse post', 
    'read any post', 'read own post',  
    'read any unpublished post', 
    'read own unpublished post',  
    'edit any post', 'edit own post', 
    'add post', 'delete any post', 
    'delete own post', 'publish any post', 
    'publish own post', 'restore any post',  
    'restore own post', 
    'trash any post', 'trash own post',  
    'browse permission', 'read permission', 
    'edit permission', 'add permission', 
    'delete permission',  
    'browse role', 'read role', 'edit role', 
    'add role', 'delete role',  
];  
  
foreach ($adminPermissions as $key => $permission) {  
    $adminPermissions[$key] = Str::of($permission)->kebab();  
}  
  
$roleAdmin->syncPermissions($adminPermissions);  
$progress->advance();
```

After defining the permissions for the admin role, we then kebab case the permissions and synch them to the user.

Next is the Staff Role.

### Staff Role

This is a repeat of the Admin user, but with different permissions:

```php
/* Create Staff Role and Sync Permissions */  
  
$roleStaff = Role::firstOrCreate(['name' => 'staff']);  
  
$staffPermissions = [  
    'browse user', 'read user', 'edit user', 'add user', 'delete user',  
    'browse permission', 'read permission',  
    'browse role', 'read role',  
    'browse post', 'read any post', 'read own post',  
    'read any unpublished post', 'read own unpublished post',  
    'edit any post', 'edit own post', 'add post', 'delete any post',  
    'delete own post', 'publish any post', 'publish own post', 'restore any post',  
    'restore own post', 'trash any post', 'trash own post',  
];  
  
foreach ($staffPermissions as $key => $permission) {  
    $staffPermissions[$key] = Str::of($permission)->kebab();  
}  
  
$roleStaff->syncPermissions($staffPermissions);  
$progress->advance();
```

Finally we get the client role.

### Client Role

```php
/* Create Client Role and Sync Permissions */  
  
$roleClient = Role::firstOrCreate(['name' => 'client']);  
  
$clientPermissions = [  
    'browse post', 'read own post',  
    'read own unpublished post',  
    'edit own post', 'add post', 'delete own post',  
    'publish own post', 'restore own post', 'trash own post',  
];  
  
foreach ($clientPermissions as $key => $permission) {  
    $clientPermissions[$key] = Str::of($permission)->kebab();  
}  
  
$roleClient->syncPermissions($clientPermissions);  
$progress->advance();  
  
$progress->finish();  
$output->writeln(" ");
```


### Roles Without Default Permissions (not Super Admin)

It is possible to create roles without default permissions. This could be useful if you want to seed the Role, but then let the administrators define the permissions.

We will create a role of "Guest" but for this demo app we will not make any use of it.

```php
/* Permission-less Roles */  
  
$output->writeln("Adding roles, without permissions");  
  
$seedRoles = [  
    ['name' => 'guest'],  
];  
  
$output = new ConsoleOutput();  
$progress = new ProgressBar($output, count($seedRoles));  
$output->writeln("");  
$output->writeln('Seed Permissionless Roles');  
$progress->start();  
  
foreach ($seedRoles as $seedRole) {  
    Role::create($seedRole);  
    $progress->advance();  
}  
$progress->finish();  
$output->writeln('');
```

### Adding execution time details

If you want you can add a total execution time to the seeder by doing the following...

At the start of the `run()` method, we grab the starting time as a variable (`$start`) that is set to the current date-time value using `now()`.

```php
public function run(): void  
{  
  
    $start = now();  
  
    app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();
```

At the end of the method we then calculate the time difference and display it.

```php
$time = $start->diffInSeconds(now());  
$output->writeln("Roles & Permissions completed: $time seconds");  
$output->writeln(" ");
```

# Manage Permissions in Roles

So far we have created the major part of the roles and permissions CRUD:

- Create Role
- Read (all) Roles/Permissions
- Update Role
- Delete Role

One of the cool features we did add was in the Delete. We get the user to re-enter the role/permission to confirm deletion, just like GitHub does in its 'Danger Zone'.

Remember the most up to date code is available on GitHub:

- https://github.com/AdyGCode/xxx-roles-permissions-2025-s2

Even though we give you this code, we **STRONGLY** suggest you complete this tutorial from scratch.

This will assist your understanding and ability to apply to other projects

## Show all Permissions for a Role

When editing a role we need to see the permissions that are associated with it.

So let's start by:

- Updating the `RoleManagementController` edit method
- Updating the `edit.blade.php` file for the roles


### Update the Edit Method

Let's start by getting the data and sending to the form.

We need to retrieve all the permissions and the permissions that the role currently has been given and pass them to the form:


```php
$permissions = Permission::all();  
$rolePermissions = $role->permissions()->get();  
  
return view('admin.roles.edit')  
    ->with('role', $role)  
    ->with('permissions', $permissions)  
    ->with('rolePermissions', $rolePermissions);
```

With this data, we are now ready to update the edit form.
### Edit the Edit page

The edit page will look something similar to this when completed:

![Picture: Role Administration Edit Form with Permission assign and revoke](../assets/Pasted%20image%2020250603170956.png)

We will update this form and the Role Controller in steps.

### Step 1: Add Display Current Permissions

The first of the steps is to add the "pills" that contain the current permissions.

Locate the end of the only form on the page (as it stands at the moment) which is the `</form>` tag.

After this line add the following:

```php
<section class="grid grid-cols-2 space-y-2 mt-4 px-6  space-x-8">  
    <div class="-mx-6 bg-gray-100 col-span-2 px-6 pb-2">  
        <h3 class="-mx-6 px-6 py-2 text-lg font-semibold col-span-2 bg-gray-100">  
            Current Permissions  
        </h3>  
        <div class="flex flex-row gap-1 flex-wrap pb-2">  
            @forelse($rolePermissions as $rolePermission)  
                <p class="text-xs bg-gray-700 text-gray-100 p-1 px-2 rounded-full whitespace-nowrap">
                {{ $rolePermission->name }}
                </p>  
            @empty  
                <p class="text-gray-600 text-sm">
	                No Permissions
                </p>  
            @endforelse  
        </div>  
    </div>

</section>
```

This will loop through each of the permissions and display them in a little 'pill'. Once the line is full, the next pill will start on the next line.

Ok, so that is the first of the changes... next...

### Step 2: Add Assign Permissions

For this, we need to do two parts:

- Add the "add permission" form
- Add the assign permission method to the Role Controller

Adding the "Add Permission" to the page is first.

#### Page Updates

Locate the `</section>` from the code we just added to the page.

Immediately BEFORE the close tag we want to add the code, but we also need to make sure we leave a blank line or two ready for the next part of the updated page.

This code is a bit longer. We are adding a form with a select element and button to the page, with the select containing all the possible options for permissions listed in it.

```php
<div class="mt-2 mb-6 bg-gray-100 shadow border border-gray-300 rounded p-4 pt-2">  

    <h3 class="mb-2 bg-gray-300 text-gray-800 px-4 py-1 -mt-2 -mx-4">
    Add Permissions
    </h3>  
  
    <form method="POST"
          action="{{ route('admin.roles.permissions', $role->id) }}">  
        @csrf  
        
        <div class="sm:col-span-6">  
  
            <x-input-label 
	            for="permission" 
	            :value="__('Permission')"/>  
  
            <select 
	            id="permission"
	            name="permission" 
	            autocomplete="permission-name"  
	            class="mt-1 mb-4 block w-full py-1 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">  
                
                @foreach ($permissions as $permission)  
                    <option value="{{ $permission->name }}">
	                    {{ $permission->name }}
	                </option>  
                @endforeach
                  
            </select>  
            
            <x-input-error 
	            :messages="$errors->get('permission')" 
	            class="mt-2"/>  
        </div>  
  
        <x-primary-button 
	        class="bg-green-600 hover:bg-green-500 text-white" 
	        type="submit">  
            Assign  
        </x-primary-button>  
    </form>  
</div>
```

We believe that by this point, the code used should be pretty clear.

Now we need to add the code that performs the `admin.roles.permissions` and add a route to enable this action.

#### Web Routes Update

Open the web routes and **immediately** before the `delete` route add:

```php
Route::post('/roles/{role}/permissions', 
			[RoleManagementController::class, 'givePermission'])
	->name('roles.permissions');
```

> ### Important:
>  
> One problem that you may encounter is when routes are ordered incorrectly.
>  
> This occurs when wildcards intercept parts of the URI incorrectly. 
>  
> For example, the route`/users/{user}` will accept anything at the `{user}` part of the URI. 
> So this means that `/users/3`, `/users/edit/` and so on would be accepted. The `edit` 
> would fail as we expect an integer in the `{user}` position.
>  
> This is why we placed our `delete` routes before the resourceful ones, thus enforcing they 
> are added to the internal routing tables before the more general wildcard routes.


#### Role Controller Updates

Now open the `RoleManagementController` and at the bottom of the class, immediately before the last closing curly brace (`}`), add:

```php
public function givePermission(Request $request, Role $role)  
{  
    if ($role->hasPermissionTo($request->permission)) {  
    
        return back()->with('message', 'Permission exists.'); 
         
    }    
    
    $role->givePermissionTo($request->permission);  
    
    return back()->with('message', 'Permission added.');  
}
```


You may be able to test this is working, but to do so you would need to add some permissions to begin with.

Now onto the revoke...

### Step 3: Add Revoke Permissions

Again we will split this into parts to complete.

#### Page Updates

Once again, locate the `</section>` from the edit page.

Add a blank line, if there is not one, before the tag and then add the following (making sure you have a blank line after this code block):


```php
@if ($role->permissions)  
    <div class="mt-2 mb-6 bg-gray-100 shadow 
                border border-gray-300 rounded px-4 pt-2">  
        <h3 class="mb-2 bg-gray-300 text-gray-800 px-4 py-1 -mt-2 -mx-4">
            Revoke Permissions
        </h3>  
        <div class="flex space-x-4 flex-wrap">  
        
            @foreach ($role->permissions as $rolePermission)  
            
                <form class="px-0 py-1 text-white rounded-md"  
                       method="POST"  
                       action="{{ route('admin.roles.permissions.revoke',
                                    [$role->id, $rolePermission->id]) }}"  
                       onsubmit="return confirm('Are you sure?');">  
                       
	                @csrf  
                    @method('DELETE')  
                       
                    <x-danger-button type="submit">  
                        {{ $rolePermission->name }}  
                    </x-danger-button>  
                </form>  
                
            @endforeach  
            
        </div>  
    </div>  
@endif  

```
Whilst this may appear to be a little strange, what we have done is added a small form with a button for each currently assigned permission.

This means we can click the button which then triggers a "submit" for the permission to be revoked.

But... as the button is clicked we show a JavaScript pop-up dialog to confirm the action. If the cancel button is pressed then the revoke will be terminated.

The revoke makes use of a new route `admin.roles.permissions.revoke`... so time to add this to the web routes.

#### Web Routes Update

Open the web routes and **immediately** before the `delete` route,  add the route to revoke a permission:

```php
Route::delete('/roles/{role}/permissions/{permission}', 
				[RoleManagementController::class, 'revokePermission'])  
    ->name('roles.permissions.revoke');
```
Make sure you do not remove the current give permission route.

#### Role Controller Updates

Now open the `RoleManagementController` and once again, at the bottom of the class and  immediately before the last closing curly brace (`}`), add:

```php
public function revokePermission(
					Role $role, 
					Permission $permission)  
{  
    if ($role->hasPermissionTo($permission)) {  
    
        $role->revokePermissionTo($permission);  
        
        return back()->with('message', 'Permission revoked.');  
        
    }    
    
    return back()->with('message', 'Permission does not.');  
}
```

Here the code accepts the Role and Permission, and if the role has the permission, then it is 
revoked. If not, then an error is shown.

Well, it would be, but we need to change this to use the Flasher.

> ### Important
>  
> If you have added a composer-based package to a project and pushed the changes to teh 
> repository, then when editing on a different PC, or a team member is working on the 
> application, then when the new code is pulled you must do the following:
>  
> - run `composer install` _or_ `composer update`
> - run any additional installation routines
> - clear caches, routes and compiled views:
>   - `php artisan cache:clear`
>   - `php artisan view:clear`
>   - `php artisan route:clear`
> - commit the updates so you have a 'roll back' point

It is a good idea at this point to make sure that you have the flasher package installed and 
are ready to continue using:

```shell
composer require php-flasher/flasher-laravel
```



### Update the Assign and Revoke messages to add Flasher

This is going to be a quick change.

#### Update the `return back()->` calls

Change the permission exists line into the following lines:

```php
flash()->warning('Role already has this permission.',  
    [  
        'position' => 'top-center',  
        'timeout' => 5000,  
    ],  
    'Permission Exists');  
  
return back();
```


Change the permission added line into the following lines:

```php
flash()->success('Permission has been addd to the Role.',  
    [  
        'position' => 'top-center',  
        'timeout' => 5000,  
    ],  
    'Permission Added');  
  
return back();
```

Change the permission revoked line into the following lines:

```php
flash()->success('Permission has been removed from the Role.',  
    [  
        'position' => 'top-center',  
        'timeout' => 5000,  
    ],  
    'Permission Revoked');  
  
return back();
```

And finally, change the permission does not exist  into the following lines:

```php
flash()->warning('Role did not have this permission.',  
    [  
        'position' => 'top-center',  
        'timeout' => 5000,  
    ],  
    'Permission not present');  
  
return back();
```





# References

- Xhepa, T. (2022, March 1). Spatie Laravel Permission. 
>   YouTube. http://www.youtube.com/playlist?list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js


# Up Next

- [Laravel v12 Bootcamp - Part 13](S11-Laravel-v12-BootCamp-Part-13.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
