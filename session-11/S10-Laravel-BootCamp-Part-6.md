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
updated: 2025-05-15T18:14
---


# INCOMPLETE - Updates 15/5/25

# S10 Laravel Bootcamp: Part 6

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

# Laravel Bootcamp: Part 6

## Chirper Administration Front End

In this section we will start to add an administration/management front-end that allows users with particular rights to perform management actions on data in the Chirp system.

We will:
- Build User Management Interface
- Determine Roles to use in Application
- Determine Permissions each Role will have
- Apply Roles & Permissions to Application (User Management)

## Important Thoughts

Before we launch into the main content of this set of notes we would like to remind you of a very important factor in software development...

Working Code is more important than Optimised Code...

This may sound strange, but when creating a solution to an opportunity, it is more important to get something working first.

Delaying production of the product will lead to delays or even not achieving "profit" for a business, or even individual. (Profit may be measured in many ways including social benefit and financial benefit. It is up to you to determine the more important of these.)

Optimisation may occur after release when you see an uptake in the solution that leads to people asking for new features, and even feedback about responsiveness...

## Minimal Viable Product

When developing software, it is important to start by identifying the MVP, or Minimum Viable Product.

The MVP is:

- The simplest version of a product that you need to build to sell it to a market.
- Eric Ries said in his book "The Lean Startup": 
	- “*The version of a new product which allows a team to collect the maximum amount of validated learning about customers with the least effort.*”

### Further reading on MVP
- lssdefinition. (2020, April 2). _Lean Startup_. Lean Manufacturing and Six Sigma Definitions - Glossary Terms, History, People and Definitions about Lean and Six Sigma. https://www.leansixsigmadefinition.com/glossary/lean-startup/#:~:text=Minimum%20viable%20product%20(MVP)%20%E2%80%93,similar%20to%20a%20pilot%20experiment).
- _Minimum Viable Product (MVP)_. (2024, November 22). ProductPlan. https://www.productplan.com/glossary/minimum-viable-product/
- Atlassian. (2023). _Minimum Viable Product (MVP): What is it & Why it Matters_. Atlassian. https://www.atlassian.com/agile/product-management/minimum-viable-product
- Tan, P. (2020, September 18). _11 Minimum Viable Product Examples (With Actionable Tips)_. Appsumo.com; AppSumo. https://appsumo.com/blog/minimum-viable-product-examples?utm_source=google&utm_medium=cpc&utm_campaign=SH-Buy-Prospect-Evergreen-Mix-Dynamic-WorldWide-Null-PMax&utm_adset=&utm_content=&utm_term=&loc_i=1009317&loc_p=1009309&network=x&dvc=c&utm_placement=))&gad_source=5&gad_campaignid=22208046847&gclid=EAIaIQobChMI6s2p6oKljQMVoE9HAR3K5C-JEAAYASAAEgKfKfD_BwE


## Chirper MVP

For us, the Chirper App has a set of key needs:
- To Register as a Chirper User
- To Create, Edit and Delete Chirps
- To Follow and Unfollow other Chirpers
- To Like and Dislike Chirps

But this then also leads us into what is needed for administration of this application? 

The admin needs stretch beyond the needs above.

For this example application we need Super Admin, Admin, Staff and Client roles who will have varying levels of permission to "abilities" or features:
- Browse, read, edit, add and delete chirpers
- Browse, read, edit, add and delete chirps
- Browse, read, edit, add and delete likes/dislikes
- Browse, read, edit, add and delete followers

This is just a start, but this provides a good way to begin the MVP and admin of the MVP.

This set of notes looks at *Administration of users*.

In subsequent notes we look at Roles and Permissions, Likes and Dislikes.

Other notes will be added over time to illustrate various features of the Laravel framework using Chirper as the base.


## Before you start…

Have you completed (not just read):

- [Introducing Laravel](session-10/S10-Introducing-Laravel-v11.md),
- [Laravel Boot Camp - Part 1](session-11/S10-Laravel-BootCamp-Part-1.md),
- [Laravel Boot Camp - Part 2](session-11/S10-Laravel-BootCamp-Part-2.md)
- [Laravel Boot Camp - Part 3](session-11/S10-Laravel-BootCamp-Part-3.md)
- [Laravel Boot Camp - Part 4](session-11/S10-Laravel-BootCamp-Part-4.md)
- [Laravel Boot Camp - Part 5](session-11/S10-Laravel-BootCamp-Part-5.md)

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you will
> only see parts of the application working when a stage is complete.
>
> So if you get an error in the browser, it may be because there is something missing.

## User Management Interface

So, so we have chirps, we have notifications being sent to users, but we do not have any way to manage these users. So let's start to build an interface to do this.

We are going to create each part of the Management interface in turn, so that CRUD (or BREAD) actions are completed.

### Create User Resourceful Routes

Open the `routes/web.php` file and add a new set of routes before the `require __DIR__.'/auth.php';` line.

```php
Route::resource('users',
			UserManagementController::class)
	->middleware(['auth',]);
```

We will add the "`verified`" middleware to this later.

At the top of the file add to the list of use lines the following:

```php
use App\Http\Controllers\UserManagementController;
```


If you try visiting `http://localhost:8000/users` it should give an error.

![](assets/Pasted%20image%2020250506134848.png)


### Create views/users` folder

Use the command line to quickly create the required folder:

```shell
mkdir -p resources/views/users
```


### Create User Management Controller

Next we will create our management controller.

In the case of the Users, we will name this `UserManager` just in case we may want to have a different "User" controller for another purpose. It also makes it obvious the purpose of said controller.

```shell
php artisan make:controller UserManagementController --resource 
```

The `--resource` will automatically add the index, store, edit and other method stubs for us to fill out.

## Browse Users

We start by building the "browse users" sub-feature. This is usually known as the "index" view.

### Add index method to user management controller

Use the SHIFT-SHIFT method to open the `UserManagementController`.

The index method will initially retrieve all users and display them on a page. 

Later we will add 2 more capabilities to the method:
- search users
- pagination

Edit the `public function index()` method and add:

```php
$users = User::all();
return view('users.index', compact(['users',]))
```

Remember to import the User class in the "use" area:

```php
use App\Models\User;
```

Refreshing will give a different error - no users index view found.

![](assets/Pasted%20image%2020250506135347.png)

### Create `users/index.blade.php`

Use the touch command to create the index blade fle for the users:

```shell
touch resources/views/users/index.blade.php
```

The browser, when refreshed will now show a blank page.

Let's code the view.

Start by adding the `x-app-layout`, with the header slot and a wrapper for the main page content:

```php
<x-app-layout>  
  
    <x-slot name="header" class="flex flex-row flex-between">  
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">  
            {{ __('Users') }}  
        </h2>        <p><a href="{{ route('users.create') }}">New User</a></p>  
    </x-slot>  
  
    <div class="py-12">  

	<!-- main page cntent here -->

	</div>  
</x-app-layout>

```

Refreshing will show:

![](assets/Pasted%20image%2020250506152133.png)

Next replace the `<!-- main page content here -->` comment with the space for a 'table' of users, plus the header for the data:

```php

        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">  
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">  
  
                <article class="my-0">  
  
                    <header class="grid grid-cols-10 bg-gray-500 text-gray-50 text-lg px-4 py-2">  
                        <span class="col-span-1">#</span>  
                        <span class="col-span-4">User</span>  
                        <span class="col-span-1">Added</span>  
                        <span class="col-span-1">Role</span>  
                        <span class="col-span-1">Actions</span>  
                    </header>  

  <!-- loop for users here -->

                </article>  
  
            </div>  
        </div>  


```

Refreshing we see:

![](assets/Pasted%20image%2020250506152834.png)

Now we add the loop for the users, that will show a row number, the user name, date they were added/joined, a role, and actions for each user.

The code will look like this, replacing the `<!-- loop for users here -->`:

```php

 @foreach ($users as $user)  
 
     <section class="px-4 grid grid-cols-10 py-1 hover:bg-gray-100 border-b border-b-gray-300 transition duration-150">
	 
          <p class="col-span-1">{{ $loop->index + 1 }}</p>  
  
          <h5 class="flex flex-col col-span-4 text-gray-800">  
              {{ $user->name }}  
          </h5>  
  
          <p class="text-xs text-gray-400 col-span-1 p-1">  
              {{ $user->created_at->format('j M Y') }}  
           </p>  
  
           <p class="col-span-1">  
               <span class="text-xs bg-gray-800 text-gray-100 rounded-full px-2 py-0.5">  
                   Role  
               </span>  
           </p>  
           
           <!-- Only Admin and Staff access these options -->  
                            
           <!-- /End Form -->  
  
       </section>  
   @endforeach  


```

We now should see:

![](assets/Pasted%20image%2020250506153402.png)

Now we need the form to go where we have the `<!-- Only Admin and Staff access these options -->`:

```php
<form method="POST"  
      class="col-span-2 flex border border-gray-300 rounded-full px-0 overflow-hidden"  
      action="{{ route('users.destroy', $user) }}">  
  
      @csrf  
      @method('delete')  
  
      <a href="{{ route('users.show', $user) }}"  
         class="bg-gray-100 hover:bg-blue-500  
                text-blue-800 hover:text-gray-100 text-center
                border-r border-r-gray-300 
                transition ease-in-out duration-300             
				grow px-2                                          rounded-l">  
	      <i class="fa-solid fa-user text-sm"></i> 
	      {{ __('Show') }}  
      </a>  
      
      <a href="{{ route('users.edit', $user) }}"  
         class="bg-gray-100 hover:bg-amber-500
				text-amber-800 hover:text-gray-100  text-center    
				border-x border-x-gray-300         
				transition ease-in-out duration-300             
				grow px-2 ">  
	      <i class="fa-solid fa-user-edit  text-sm"></i>  
          {{ __('Edit') }}  
      </a>  
      
      <button type="submit"  
              class="bg-gray-100 hover:bg-red-500
					 text-red-800 hover:text-gray-100 text-center      
					 border-l border-l-gray-300
					 transition ease-in-out duration-300
					 grow px-2                                          rounded-r ">  
	       <i class="fa-solid fa-user-minus  text-sm"></i>
		   {{ __('Delete') }}  
      </button>  
      
</form>  
```

This gives:

![](assets/Pasted%20image%2020250506153327.png)

After the `@endforeach` and before the `</article>` we need to add the footer for the "table". It is a placeholder for the time being:

```php

                    <footer class="px-4 pb-2 pt-4 ">  
                        Pagination Navigation here  
                    </footer>  

```

The final result:


![](assets/Pasted%20image%2020250506152736.png)

Note that the role and pagination are not showing read details as we have to yet implement them.

### Test Browse/Index Action

Check the page works as expected.

The "New User" button will be placed on the right side of the header area. We leave that as an exercise.

## Read a User

Our next item in the CRUD / BREAD journey is the "read" sub-feature.

This is where we are shown just ONE user's "full" details.

### Add Show method to user management controller

Our next step is to update the show method to give the user's details that we want to view.

The button on the Index page calls the `users.show` route with the user (we have removed the CSS for brevity):

```php
<a href="{{ route('users.show', $user) }}">  
    <i class="fa-solid fa-user  text-sm"></i>  
    {{ __('Show') }}  
</a>
```

In the `UserMangementController` find the `show` method.

Add the following code:

```php
        return view('users.show', compact(['user']));
```

This uses the Route-Model binding that we have seen previously.

### Create `users/show.blade.php`

The Show page will be a good start as we then duplicate and update it to become the Create page, and from that the Edit page.

This is the final layout:

![](assets/Pasted%20image%2020250506161021.png)


In PhpStorm, click on the `users/index.blade.php` file and then use CTRL+C followed by CTRL+V

Rename the file to `show.blade.php`.


OR...

```shell
cp resources/views/users/index.blade.php resources/views/users/show.blade.php
```

Open the new file and start the editing.

Delete everything from ` <article class="my-0">` to `</article>` (approximately lines `xxx` to `yyy`).

This leaves a smaller base file to use:


```php
<x-app-layout>  
  
    <x-slot name="header" class="flex flex-row flex-between">  
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">  
            {{ __('Users') }}  
        </h2>
        <p>
            <a href="{{ route('users.create') }}">New User</a>
        </p>  
    </x-slot>  
  
    <div class="py-12">  
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">  
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">  
  
                <article class="my-0">  


                </article>  
  
            </div>  
        </div>  
    </div>  
</x-app-layout>
```


Now we add code into the space we just created (between the start and end article tags).

We will show each new section as a separate block of code. 

Inside the article we first add the header:

```php
<header class="bg-gray-500 text-gray-50 text-lg px-4 py-2">  
    <h5>  
        {{ __('Details for') }}  
        <em>{{ $user->name }}</em>  
    </h5>  
</header>
```

Add a section immediately after the header:

```php
<section class="px-4 flex flex-col text-gray-800">  
  
</section>    
```

Inside the section we now add a block for each part of the information we will display.

Name part:

```php
<div class="grid grid-rows-3 mt-6 ">  
    <p class="text-gray-500 text-sm ">Name:</p>  
    <p class="w-full ml-4">  
        {{ $user->name ?? "No Name provided" }}  
    </p>
</div>
```


This basic layout will now be reproduced for each of the items of detail we will display...

Email part:

```php
<div class="grid grid-rows-3  ">  
    <p class="text-gray-500 text-sm ">Email:</p>  
    <p class="w-full ml-4">  
        {{ $user->email ?? "No Email Provided" }}  
    </p>
</div>
```

Role part:

```php
  
<div class="grid grid-rows-3  ">  
    <p class="text-gray-500 text-sm ">Role:</p>  
    <p class="w-full ml-4">  
        {{ $user->role ?? "No Role Provided" }}  
    </p>
</div>
```

Added and Last Updated:

```php
<div class="grid grid-rows-3  ">  
    <p class="text-gray-500 text-sm ">Added:</p>  
    <p class="w-full ml-4">  
        {{ $user->created_at->format('j M Y') }}  
    </p>
</div>
```

Duplicate the above and change the `created_at` for `updated_at`.

Action buttons part... start by adding the form wrapper:

```php
<!-- Only Admin and Staff access these options -->  
<form method="POST"  
      class="flex my-8 gap-6 ml-4"  
      action="{{ route('users.destroy', $user) }}">  
  
    @csrf  
    @method('delete')  
    
</form>  
<!-- /Only Admin and Staff access these options -->
```

Inside this wrapper you will add each button in turn, before the `</form>` tag.

All users button

```php
<a href="{{ route('users.index', $user) }}"  
   class="bg-gray-100 hover:bg-blue-500  
          text-blue-800 hover:text-gray-100 text-center
          border border-gray-300
          transition ease-in-out duration-300
          p-2 min-w-24 rounded">  
    <i class="fa-solid fa-user inline-block"></i>  
    {{ __('All Users') }}  
</a> 
```

Edit button

```php
<a href="{{ route('users.edit', $user) }}"  
   class="bg-gray-100 hover:bg-amber-500  
          text-amber-800 hover:text-gray-100 text-center
          border border-gray-300
		  transition ease-in-out duration-300
		  p-2 min-w-24 rounded">  
    <i class="fa-solid fa-user-edit text-sm"></i>  
    {{ __('Edit') }}  
</a>  

```


Delete button, is a true button, as we saw on the index page.

```php
<button type="submit"  
        class="bg-gray-100 hover:bg-red-500  
               text-red-800 hover:text-gray-100
               text-center
               border border-gray-300                  
               transition ease-in-out duration-300
               p-2 min-w-16 rounded">
    <i class="fa-solid fa-user-minus text-sm"></i>  
    {{ __('Delete') }}  
</button>

```

And we are done!

Make sure that everything is correctly entered, and you have your HTML balanced (start & end tags) as needed.

### Test Show Action

If all works as expected you should be able to click on a user in the index page and it will jump to the users details.

![](assets/vivaldi_LTZ7aCBugA.gif)

## Add User

So that is **B**rowse and **R**ead complete... next is **A**dd.

OK, so we are skipping Edit for now... there are reasons...

### Add Create method to user management controller

Ok, so we now have the show page, we next need to add the "Create and Store" to be able to add a new user to the system.

Locate the create method in the User Management Controller.

Add the following code:

```php
// TODO: Update when we add Roles & Permissions  
$roles = Collection::empty();   
return view('users.create', compact(['roles',]));
```

Note the comment - we will update this when we add Roles & Permissions to the application.

### Create `users/create.blade.php`

We are ging to be a little lazy, and duplicate the show view we added previously.

So, CTRL+C and CTRL+V the `users/show.blade.php` file and rename it to `create.blade.php`.

The reason we are doing this is because we will lay out the create page in the same way as we did the show page.

Each block of the create page will have:
- a wrapper div
- a label
- the form control to be used

Update the page header:

```php
<header class="bg-gray-500 text-gray-50 text-lg px-4 py-2">  
    <h5>  
        {{ __('Create New User') }}  
    </h5>  
</header>
```

We now need to move the form code from its current location to immediately after the `<section>` tag.

Plus we also need to update the section and form's classes to suit the new layout:

```php
<section>  

	<form method="POST"  
          class="my-4 gap-4 px-4 flex flex-col text-gray-800"  
          action="{{ route('users.store') }}">  
  
        @csrf  
        
  <!--- THE FORM FIELD BLOCKS WILL GO HERE -->
   
    </form>  
  
</section>
```

The remaining blocks, will look very similar to the code below (the name field). Add each in turn, within the form tags.

```php
<div class="flex flex-col">  
    <x-input-label for="name" :value="__('Name')"/>  
    
    <x-text-input id="name" class="block mt-1 w-full"  
                  type="text"  
                  name="name"  
                  :value="old('name')"  
                  required autofocus autocomplete="name"/>  
                  
    <x-input-error :messages="$errors->get('name')" class="mt-2"/>  
</div>
```

Email field...

```php
<div class="flex flex-col">  
    <x-input-label for="Email" :value="__('Email')"/>  
    <x-text-input id="Email" class="block mt-1 w-full"  
                  type="text"  
                  name="email"  
                  :value="old('email')"  
                  required autofocus autocomplete="email"/>  
    <x-input-error :messages="$errors->get('email')" class="mt-2"/>  
</div>
```

As the `div` is the same for the remaining fields, we are omitting it int he remaining sample code. You **must** add it for each field.

Password field...

```php
<x-input-label for="Password" :value="__('Password')"/>  
<x-text-input id="Password" class="block mt-1 w-full"  
              type="text"  
              name="password"  
              required autofocus />  
<x-input-error :messages="$errors->get('password')" class="mt-2"/>
```

Password Confirmation field...

```php
<x-input-label for="Password_Confirmation" :value="__('Confirm Password')"/>  
<x-text-input id="Password_Confirmation" class="block mt-1 w-full"  
              type="text"  
              name="password_confirmation"  
              required autofocus />  
<x-input-error :messages="$errors->get('password_confirmation')" class="mt-2"/>
```

Role field...

```php
<x-input-label for="Role" :value="__('Role')"/>  
<select id="Role"  
        class="block mt-1 w-full px-2 py-1 border-gray-300  
            focus:outline-indigo-500 focus:outline-2 focus:ring-2 focus:ring-indigo-500              rounded-md shadow-sm"        type="text"  
        name="role"  
        :value="old('role')"  
        required autofocus autocomplete="role">  
    <option>  
        Role will be implemented with Roles & Permissions  
    </option>  
</select>  
  
<x-input-error :messages="$errors->get('role')" class="mt-2"/>
```

Buttons...

The buttons are aligned horizontally so... `flex-row` for them in place of `flex-col`.

```php
<div class="flex flex-row gap-6  ">  
  
    <a href="{{ route('users.index') }}"  
       class="bg-gray-100 hover:bg-blue-500  
              text-blue-800 hover:text-gray-100 text-center              border border-gray-300              transition ease-in-out duration-300              p-2 min-w-24 rounded">  
        <i class="fa-solid fa-times inline-block"></i>  
        {{ __('Cancel') }}  
    </a>  
  
    <button type="submit"  
            class="bg-gray-100 hover:bg-green-500  
                 text-green-800 hover:text-gray-100 text-center                 border border-gray-300              transition ease-in-out duration-300              p-2 min-w-32 rounded">  
        <i class="fa-solid fa-save text-sm"></i>  
        {{ __('Save') }}  
    </button>  
</div>
```

### Add Store method to user management controller

The store method will:
- validate the data
- create a new user
- return to the users index page

```php
$validated = $request->validate([  
    'name'=>['required','min:2', 'max:192',],  
    'email' => ['required', 'string', 'email', 'max:255', 'unique:'.User::class],  
    'password' => ['required', 'confirmed', Rules\Password::defaults()],  
    'role'=>['nullable',],  
]);  
  
$user = User::create([  
    'name' => $request->name,  
    'email' => mb_strtolower($request->email),  
    'password' => Hash::make($request->password),  
]);  
  
return redirect(route('users.index'));
```

### Test Add Action

Test the action to see it works.

Here is a demonstration.

![](assets/vivaldi_yYBUqIS4VM.gif)


## Edit the User

We just got Add completed, so we are ready for Edit.

The reason we did it this way around was so you could understand the basic process of validating data and ensuring you were redirected accordingly.

### Code Duplication... sometimes a good thing

One of the nice parts of the process we are following is that once we have a set of working code, it provides us with a template for other features.

As we stated earlier, it is more important to get code working and then at a later date optimise.

Even in developing this user management feature we can see that code can be repurposed.

We definitely see this in the Edit User "sub-feature".

### Add Edit method to user management controller

Open the User Management Controller and locate the edit and update methods.

Change the edit method to read:

```php
    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        // TODO: Update when we add Roles & Permissions
        $roles = Collection::empty();

        return view('users.edit', compact(['roles', 'user',]));
    }
```

This looks almost identical to the Add, except:
- The method expects the user details to be given to it... the user that will be edited
- The view call puts the roles and the user data into the packet that is sent to the view.

### Create the Edit Blade File

To create the edit view, we will duplicate the create view and rename it to `edit.blade.php`.

Once duplicated we need to edit the code.

There is a lot of basically repeated edits, so we will show just one or two here.

Start by editing the article header, to show it is editing a user...

```php
<header class="bg-gray-500 text-gray-50 text-lg px-4 py-2">
    <h5>
    {{ __('Edit User') }}
    </h5>
</header>
```

Now edit the form by changing the route that will be called:

```php
<form method="POST"
      class="my-4 px-4 gap-4 flex flex-col text-gray-800"
      action="{{ route('users.update', $user) }}">
```

Now, for the name, and otehr text-input fields we need to add a key aspect of the edit... the original information from the User's model must be shown when we open the file...

Locate the `x-text-input` for the name, and update the value to read:

```php
<x-text-input id="name" class="block mt-1 w-full"
              type="text"
              name="name"
              :value="old('name')??$user->name"
              required autofocus autocomplete="name"/>

```

The key change is adding a null coalesce (`??`) that says "if the old name is empty, then use the user model's name". 

This change will need to be completed for each of:
- name
- email
- role

The passwords do not take the old value, so we make sure there is no `:value` entry.

Once the changes are done, save and we can next look at the update method in the user management controller.

### Add Update method to user management controller


### Test Update Action

The definiton of the method should not change from the default that was created by the artisan command.

```php
public function update(Request $request, User $user)  
{  
    // TODO: Update when we add Roles & Permissions  
  

```

Next we need toa dd the validation to make sure the user is following our rules for data in the application.

The validation looks dramatically similar to the store method's... with one or two small changes...

```php
$validated = $request->validate([  
    'name' => ['required', 'min:2', 'max:192',],  
    'email' => [  
        'required',  
        'string',  
        'email',  
        'max:255',  
```

This section is the same, but the email validation rule gets altered when it comes to being unique...

```php     
        Rule::unique(User::class)->ignore($user),  
```

This change in the rule tells Laravel to check that the email is not used elsewhere in the applications user data, *except for the user you are editing*!

This means you can leave the user's email address alone unless it is being changed.

The rest of the validation rules code is again, untouched.

```php
    ],  
    'password' => [  
        'sometimes',  
        'nullable',  
        'confirmed',  
        Rules\Password::defaults()  
    ],  
    'role' => ['nullable',],  
]);  
```

Now we need to work with two things... the passwords and the emails.

Let's start with the passwords.

If the user's data does not include a password change we need to remove it from the data being updated by a "patch".

To do this we check to see if the validated password is null, and if so remove the array key so it does not violate the "required" and "not null" data requirements in the model.

```php
    // Remove password if null  
    if (isNull($validated['password'])) {  
        unset($validated['password']);  
    }  

```

Next we tell Laravel to fill the changed fields with the validated data...

```php
    $user->fill($validated);  
```

The next step checks to see if the email has changed... that is "is the data dirty". If it is then we force the user to verify the new email address...

```php
    if ($user->isDirty('email')) {  
        $user->email_verified_at = null;  
    }  

```

Once this is set we save the updated user data.

```php
    $user->save();  

```

Finally the redirect back to the user index view.

```php
    return redirect(route('users.index'));  
}
```

And we are done.

#### Test! 

Test the edit to make sure it works.

### Notify User to Verify New Email

If we are editing the user's email address, we want them to be notified, so we need to add three lines of code just before redirecting...

```php
if (isNull($user->email_verified_at)) {  
    $user->sendEmailVerificationNotification();  
}
```

This code checks to see if the email has had its verified at date and time reset to null, and if so force the system to send an email.

👍 Nice!

## Delete User

Ok, so we like "Dr Who". If we were a fan of the doctor, we would expect the delete method to be called "Exterminate"... 

### Add Delete method to user management controller


The delete functionality of the user management is not the same as the delete a chirp. We are going to provide a safety net and have the user confirm they want to delete the user from the system.

To do so we need to add a "delete" method and a new "delete" route to the controller and route respectively.

### Create `resources/views/users/delete.blade.php`


### Add Destroy method to user management controller


### Test Delete Action



## Small UI Fixes

Ok, we have noted a few small UI abhorrations that may be fixed.

### Index View - Edit and Show Buttons

The index and show buttons are not well aligned, so we found that a a padding of 1.5 on the y axis seems to do the job.

Locate the Edit and Show buttons (approximately lines 65 to 85 in the code) and update the following:

```php
grow px-2
```

to become:

```php
grow px-2 py-1.5
```

### Fix the "header" for Index, Edit, Show, Delete, and Add views

This needs two things to be completed.

First we need to change the "app.blade.php" layout, and then we need to update the headers on each of the above views.

#### App Blade Update

Open the `app.blade.php` file and locate the section that reads:

```php
@isset($header)
    <header class="bg-white shadow">
        <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
            {{ $header }}
        </div>
    </header>
@endisset
```

The `div` will be updated to read:

```php
<div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8 flex flex-row space-x-2">
```

This will then place the title on the left, the add and search on the right.
#### User Views Updates

The user's views `<x-slot>` for the header all need to have updates.

These updates ensure that the layout is correct and also that there is a search box added ready for later.

Open your code and update the sections shown.

Opening of the header should NOT contain a class...:

```php
<x-slot name="header">
```

On the `h2` we need to add a `grow` class to the current list.

```php
<h2 class="font-semibold text-xl text-gray-800 leading-tight grow">
```

Immediately before the  `</x-slot>` we are adding the search box:

```php
<form action="{{ route('users.index') }}" method="GET" class="flex flex-row gap-0">

    <x-text-input id="search"
                  type="text"
                  name="search"
                  class="border border-gray-200 rounded-r-none shadow-transparent"
                  :value="$search??''"
    />

    <button type="submit"
            class="text-gray-800
                   bg-gray-100
                   border border-gray-300
                   rounded-lg
                   px-4 py-1
                   rounded-l-none">
        <i class="fa-solid "></i>
        Search
    </button>

</form>
```


These changes result in:

![](assets/Pasted%20image%2020250515180411.png)

Well, they will when you complete the exercise below to add icons and a few other fixes...
## Exercise

Oh, you should work out for yourselves how to make the buttons for search and "New User" look better than they currently are...

Improvements include:
- Wrap the `h2` in an anchor element that links to the user's index page - this makes it easier to navigate back to this page.
- Move the `grow` class from the `h2` and add a new `class=""` attribute with the value of `grow` class to the new anchor.
- Add a user icon to the Add button.
- Add a magnifying glass icon to the Search button.
- Add hover effects by changing the font and background colours to be similar to the other buttons (as in they go dark background and light text).

We have made the search and its button look like they are a single item already for you.



# References

- Laravel Bootcamp - Learn the PHP Framework for Web Artisans - 07 Notifications & Events. (
  2025).
  Archive.org. https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/blade/notifications-and-events

# Up Next

- [Laravel Boot Camp - Part 7](session-11/S10-Laravel-BootCamp-Part-7.md)
- [Session 11 ReadMe](session-11/ReadMe.md)
- [Session 11 Reflection Exercises & Study](session-11/S11-Reflection-Exercises-and-Study.md)

# END
