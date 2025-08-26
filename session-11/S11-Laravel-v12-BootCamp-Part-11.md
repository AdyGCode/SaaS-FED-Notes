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
updated: 2025-08-21T15:59
---


# S11 Laravel Bootcamp: Part 11

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

# Laravel Bootcamp: Part 11

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


No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you may only see parts of the application working.
>
> So if you get an error in the browser, it may be because there is something missing.
> 
> Remember that code is available from the GitHub repository.


# Manage Permissions in Roles

So far we have created the major part of the roles and permissions CRUD:

Create Role/Permission
Read (all) Roles/Permissions
Update Role/Permission
Delete Role/Permissions

One of the cool features we did add was in the Delete. We get the user to re-enter the role/permission to confirm deletion, just like GitHub does in its 'Danger Zone'.

Remember the most up to date code is available on GitHub:
- https://github.com/AdyGCode/roles-permissions-2025-s1

Even though we give you this code, we **STRONGLY** suggest you complete this tutorial from scratch.

This will assist your understanding and ability to apply to other projects

## Show all Permissions for a Role

When editing a role we need to see the permissions that are associated with it.

So let's start by:
- Updating the `RoleController` edit method
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
			[RoleController::class, 'givePermission'])
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

Now open the `RoleController` and at the bottom of the class, immediately before the last closing curly brace (`}`), add:

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
				[RoleController::class, 'revokePermission'])  
    ->name('roles.permissions.revoke');
```
Make sure you do not remove the current give permission route.

#### Role Controller Updates

Now open the `RoleController` and once again, at the bottom of the class and  immediately before the last closing curly brace (`}`), add:

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

- [Laravel v12 Bootcamp - Part 12](S11-Laravel-v12-BootCamp-Part-12.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
