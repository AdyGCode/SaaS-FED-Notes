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
updated: 2025-06-03T17:56
---


# S10 Laravel Bootcamp: Part 12

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

# TODO: IN PROGRESS

## Roles and Permissions Part 3

In this section, we continue with the administration/management front-end that allows 
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
- [Laravel v12 Bootcamp - Part 10](../session-11/S10-Laravel-v12-BootCamp-Part-10.md)
- [Laravel v12 Bootcamp - Part 11](../session-11/S10-Laravel-v12-BootCamp-Part-11.md)


No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you may only see parts of the application working.
>
> So if you get an error in the browser, it may be because there is something missing.
> 
> Remember that code is available from the GitHub repository.


# Manage User Roles (and Permissions)

Remember the most up-to-date code is available on GitHub:
- https://github.com/AdyGCode/roles-permissions-2025-s1

Even though we give you this code, we **STRONGLY** suggest you complete this tutorial from scratch.

This will assist your understanding and ability to apply to other projects

## Organising our Code

Up to this point we had not been organising our code very well. This was especially true with the Roles and Permissions controllers.

So we are going to tidy up by adding an `Admin` folder to the `App/Http/Controllers` folder and moving our code to this folder.

When we do this, we need to then update any references to the controllers (e.g. in the `web.php` routes file).

```shell
mkdir App/Http/Controllers/Admin
```

Now, in PhpStorm we can move files to other folders, and it will help refactor references as well.

Drag and Drop the RoleController and the PermissionController into the Admin folder.

When prompted you will be given the opportunity to check that the changes **will be** correctly applied.

Click Refactor to apply the changes.

Here is an animation of the process:

- Original Screen Recording: [phpstorm-refactor-role-permission-admin-folder.mp4](../assets/phpstorm-refactor-role-permission-admin-folder.mp4)
- Animated GIF: ![phpstorm-roles-perms-refactor.gif](../assets/phpstorm-roles-perms-refactor.gif)


## Adding Roles to Users

We will now create an admin section for users. This will allow us to add, remove and edit users as required.

This has been done many times before, as we often use this as a way to teach CRUD/BREAD.

### Add the User Admin Routes

Edit the web.php file and add the admin route for users

```php
        Route::post('users/{user}/delete', [UserController::class, "delete"])
            ->name('users.delete');
        
        Route::resource('users',
            UserController::class);
```

We put these in the `admin` block after the permissions routes.


### Create the User Admin Controller 

As with the roles and permissions, we will put the admin controller for the users in the Controllers/Admin folder.

```shell
php artisan make:controller Admin/UserController -r
```

To make things easier, we will give you the starting code for the User admin controller... it is in fact the code from the Chirper tutorial, so you will be able tos ee how to modify and update Chirper to have these new features.

```php
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // TODO: Only allow authorised users (Admin/Staff Roles)

        $validated = $request->validate([
            'search' => ['nullable', 'string',]
        ]);


        $search = $validated['search'] ?? '';


        $users = User::whereAny(
            ['name', 'email', 'position',], 'LIKE', "%$search%")
            ->paginate(2)
            ->appends(['search' => $search]);


        return view('users.index')
            ->with('users', $users)
            ->with('search', $search);

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {

            $validated = $request->validate([
                'name' => ['required', 'min:2', 'max:192',],
                'email' => ['required', 'string', 'email', 'max:255', 'unique:' . User::class . ',email',],
                'password' => ['required', 'confirmed', Rules\Password::defaults()],
                'role' => ['nullable',],
            ]);

            $user = User::create([
                'name' => $validated['name'],
                'email' => Str::lower($validated['email']),
                'password' => Hash::make($validated['password']),
            ]);

        } catch (ValidationException $e) {

            flash()->error('Please fix the errors in the form.',
                [
                    'position' => 'top-center',
                    'timeout' => 5000,
                ],
                'User Creation Failed');

            return back()->withErrors($e->validator)->withInput();

        }

        $userName = $user->name;

        flash()->success("User $userName created successfully!",
            [
                'position' => 'top-center',
                'timeout' => 5000,
            ],
            "User Added");

        return redirect(route('users.index'));


    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // TODO: Update when we add Roles & Permissions
        $roles = Collection::empty();

        return view('users.create', compact(['roles',]));
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        // TODO: Update when we add Roles & Permissions

        return view('users.show', compact(['user']));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        // TODO: Update when we add Roles & Permissions
        $roles = Collection::empty();

        return view('users.edit', compact(['roles', 'user',]));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {
        // TODO: Update when we add Roles & Permissions

        try {

            $validated = $request->validate([
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
            ]);

            // Remove password if null
            if (isNull($validated['password'])) {
                unset($validated['password']);
            }

            $user->fill($validated);

            if ($user->isDirty('email')) {
                $user->email_verified_at = null;
            }

            $user->save();

        } catch (ValidationException $e) {

            flash()->error('Please fix the errors in the form.',
                [
                    'position' => 'top-center',
                    'timeout' => 5000,
                ],
                'User Update Failed');

            return back()->withErrors($e->validator)->withInput();

        }

        if (isNull($user->email_verified_at)) {
            $user->sendEmailVerificationNotification();
        }

        $userName = $user->name;

        flash()->info("User $userName details updated successfully!",
            [
                'position' => 'top-center',
                'timeout' => 5000,
            ],
            "User Updated");

        return redirect(route('users.index'));
    }

    /**
     * Confirm the removal of the specified user.
     *
     * This is a prequel to the actual destruction of the record.
     * Put in place to provide a "confirm the action".
     *
     * @param User $user
     */
    public function delete(User $user)
    {
        // TODO: Update when we add Roles & Permissions

        return view("users.delete", compact(['user',]));

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param User $user
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(User $user)
    {
        // TODO: Update when we add Roles & Permissions

        $oldUser = $user;

        $user->delete();


        $userName = $oldUser->name;

        flash()->info("User $userName removed successfully!",
            [
                'position' => 'top-center',
                'timeout' => 5000,
            ],
            "User Deleted");

        return redirect(route('users.index'));

    }
```

#### Update the Routes!

In this newly added code, search and replace the `route('users` with `route('admin.users`.


### CRUD views

Create a new folder in the `resources/views/admin` folder, called `users`.

To make it a bit easier on you, we are providing the views to download from our sample code.

- User List - [index.blade.php](sample-code/index.blade.php)
- User Create - [create.blade.php](sample-code/create.blade.php)
- User Edit - [edit.blade.php](sample-code/edit.blade.php)
- User Delete - [delete.blade.php](sample-code/delete.blade.php)
- User Details - [show.blade.php](sample-code/show.blade.php)

Download each file and move into the users admin views folder.

#### Update the Routes!

In these files, you will then need to replace every occurrence of `route('users` with `route('admin.users` as you did with the controller code.

Going to http://localhost:8000/users should now show the list of users.

> IMPORTANT: Check the other functions work as expected adn fix any errors!


Excellent - we are ready to continue!

> ### redirect route or to_route
> 
> You may use `to_route(...)` to replace the `redirect(route(...))` combination.

### 


# References

- Xhepa, T. (2022, March 1). Spatie Laravel Permission. 
>   YouTube. http://www.youtube.com/playlist?list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js


# Up Next

- [Laravel v12 Bootcamp - Part 13](../session-11/S10-Laravel-v12-BootCamp-Part-13.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
