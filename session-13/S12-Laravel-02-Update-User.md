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
created: 2024-10-08T10:54
updated: 2025-07-22T16:25
---

# Laravel: 02 Update User

## Software as a Service - Front-End Development

### Session 12

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

# Updating User Feature

The default user has a few 'restrictions' that are not necessarily the best for a full 
application.

These restrictions include:
- no separate given and family name
- no user avatar
- etc

We are going to:
- Add `given_name` and `family_name` fields to the User model
- We will allow the `family_name` to be empty.
- Create an update user migration to add given and family name fields and rename the name field
- Update the registration form to include the given and family name
- Update the user (profile) edit form to include the given and family name (and name)
- Update the user profile to include the new fields

## Create Update User Migration

Back to the CLI and in the top section execute:

```shell
php artisan make:migration update_users_table
```

Back in PhpStorm, locate the `database/migrations` folder, and find the file that will be 
something like `2024_10_08_122518_update_users_table.php`.

Open the file and alter the Up method code to be:

```php
public function up(): void  
{  
    Schema::table('users', function (Blueprint $table) {  
        $table->string('given_name');  
        $table->string('family_name')->nullable();  
    });  
}  

```

Likewise the Down method becomes:

```php
public function down(): void  
{  
    Schema::table('users', function (Blueprint $table) {  
        $table->dropColumn('given_name');  
        $table->dropColumn('family_name');  
    });  
}
```

These two should make sense to you. 

### Update the User Seeder

To make our lives a little easier, we will automate the creation of:
- A user who will become an Administrator
- A user who will become a Staff member
- A user who will become a Client

Runt he following command to create the seeder:

```shell
php artisan make:seeder UserSeeder
```

Now locate the `database\seeders\` folder and open the new `UserSeeder.php` file.

We will update the `run` method to be:

```php
$seedUsers = [  
    [  
        'id'=>100  
        'given_name' => 'Admin',  
        'family_name' => 'Istrator',  
        'name' => 'Admin',  
        'email' => 'admin@example.com',  
        'password' => 'Password1',  
    ],  
    [  
        'id'=>500  
        'given_name' => 'Staff',  
        'family_name' => 'Member',  
        'name' => 'Staff',  
        'email' => 'staff@example.com',  
        'password' => 'Password1',  
    ],  
    [  
        'id'=>1000  
        'given_name' => 'Eileen',  
        'family_name' => 'Dover',  
        'name' => 'Cliffwalker',  
        'email' => 'eileen@example.com',  
        'password' => 'Password1',  
    ],  
  
];  
  
foreach ($seedUsers as $seedUser) {  
    User::create($seedUser);  
}
```

Note we have given the Admin user the id of 100 - this is because 1 is often seen as the 
default for an admin  account, and this will help slow down 'quick hacks'.

### Update the Database Seeder

Now we open the `DatabaseSeeder.php` file from the same folder.

Comment out any reference to creating a test user. (Quick hint: CTRL / in PhpStorm comments out 
a line, or a selected block of code.)

In place of the code you have removed, the run method will now read:

```php
public function run(): void  
{  
    $this->call([  
        UserSeeder::class,  
	    /* Add more seeder calls here */
    ]);  
}
```

### Running the Migration

Run the migration using:

```shell
php artisan migrate
```

This will run any new migrations that have not been executed previously.

### Running the Seeder

To run a seeder we use the following call:

```shell
php artisan db:seed --class=UserSeeder
```

This executes **ONLY** the `UserSeeder`.

This is a good idea as it means you have targeted just one table to have seed data added.

#### Executing all Seeder Classes

To run all the seeder classes, you may use:

```shell
php artisan db:seed
```


#### Executing a Fresh Migrate and All Seeder Classes [DANGER]

**Important**

During development, you may start migrations (and seeding) from scratch. This ensures you see 
any changes in context of the 'from fresh' database.

We would NEVER run a fresh migration on a production database, as **ALL** data is destroyed in 
the process.

To run a 'fresh migration and seed' we use:

```shell
php artisan migrate:fresh --seed
```

## Update the User Model

Open the user model from the `App\Models` folder.

Make the following changes:

- Add the `first_name` and `last_name` to the fillable fields,

## Update the Register User Form

Locate and open the `resources\views\auth` folder.

In here, open the `register.blade.php` file.

Make the following additions and changes to the file:

#### 1: Add 'Given Name' Field

At the top of the file, just before the `<!-- Name -->` comment add the following:

```php
<!-- Given Name -->  
<div>  
    <x-input-label for="given_name" 
			       :value="__('Given Name')"/>  
    <x-text-input id="given_name" 
				  class="block mt-1 w-full" 
				  type="text" name="given_name"  
				  :value="old('given_name')" 
				  required autofocus 
				  autocomplete="given_name"/>  
    <x-input-error 
        :messages="$errors->get('given_name')" 
        class="mt-2"/>  
</div>
```

#### 2: Add 'Family Name' Field

Repeat the process and just before the `<!-- Name -->` comment, and after the just completed
'given name', add:

```php
<!-- Family Name -->  
<div class="mt-4">  
    <x-input-label for="family_name" 
                   :value="__('Family Name')"/>  
    <x-text-input id="family_name" 
                  class="block mt-1 w-full" 
                  type="text" name="family_name"  
                  :value="old('family_name')" 
                  autofocus 
                  autocomplete="family_name"/>  
    <x-input-error
         :messages="$errors->get('family_name')" 
         class="mt-2"/>  
</div>
```

> Code shown on multiple lines for readability. 

#### 3: Update the 'Name' field to 'name'

With the current name field, you will need to change each occurrence of `name` or `Name` to
`name` and `name or preferred name` respectively.

Also add `class="mt-4"`  to the `<div>`.

Also remove the `required` from the input.

## Update Registered User Controller

Open the `App\Http\Controllers\Auth` folder, and locate the `RegisteredUserController.php` file.

In the Store method, we need to add/update to include our new fields.

### Update the Validation in the Store method

Edit the validation code, adding the ability to leave 
the name blank.

```php
'name' => ['sometimes', 'nullable', 'string', 'max:255'],
```

Now, we will duplicate this line, and make the changes for the given and family name:

```php
'given_name' => ['required', 'string', 'max:255'],  
'family_name' => ['sometimes', 'nullable', 'string', 'max:255'],  
```

> **Important:**
> 
> We are allowing the user to have one name, but we will not know which field they will 
> enter their name into.
> 
> So, we will handle this in a moment by:
> 
> - moving the family name into the given name, if the given name is left blank, and
> - making the family name blank/null.

### Making sure the given name always filled

As we are allowing the user to have one name, we will make sure that we always fill in the 
given name. This is accomplished by the form request validation.

We can further enhance this mechanism, by adding checks and then copying the data to the 
correct field.

```php
if ($request->given_name === null && $request->family_name !== null) {  
    $request->given_name = $request->family_name;   
    $request->family_name = null;
}  
```

### Adding the name/preferred name when blank

We have made the design decision that when a user registers, we will copy the given name into 
the preferred name if the name/preferred name is blank.

After the above code we will add:

```php 
if ($request->name === null) {  
    $request->name = $request->given_name;
}
```

## Update the Profile Page

Once registered, we will now need to update the profile page with the new details.

Locate the `resources\views\profile\partials` folder.

Open the `update-profile-information-form.blade.php` file for editing.

We will add the fields in a similar way to what was done in the register form.

Edit the current `<div>` block with the "Name" to become the "Given Name":

```html
<div>  
    <x-input-label for="given_name" 
	     :value="__('Given Name')" />  
    <x-text-input id="given_name" name="given_name" 
	     type="text" class="mt-1 block w-full"  
         :value="old('given_name', $user->given_name)"  
         required autofocus autocomplete="given_name" />
    <x-input-error class="mt-2" :messages="$errors->get('given_name')" />  
</div>
```

Now duplicate this block, and edit Given Name to become Family Name:

```html
<div>  
    <x-input-label for="family_name" 
	     :value="__('Family Name')" />  
    <x-text-input id="family_name" name="family_name"
         type="text" class="mt-1 block w-full"  
         :value="old('family_name', $user->family_name)" 
         autofocus autocomplete="family_name" />  
    <x-input-error class="mt-2" 
         :messages="$errors->get('family_name')" />  
</div>
```

Remember, no required for Family Name!

Finally duplicate the family name block, and update the copy to be name in place of 
Family Name.

```html
<div>  
    <x-input-label for="name" 
         :value="__('Preferred Name/name (Default: Given Name)')" />  
    <x-text-input id="name" name="name" 
         type="text" class="mt-1 block w-full"  
         :value="old('name', $user->name)"  
         autofocus autocomplete="name" />  
    <x-input-error class="mt-2" 
         :messages="$errors->get('name')" />  
</div>
```

Also, no required for the name.

### Update the Update Profile Request

Open the `App\Http\Requests` folder and locate and open the `ProfileUpdateRequest.php` file.

Update the file so that the rules array contains the given, family and names, which replace
the 'name' field.

```php
'given_name' => [
	'required', 
	'string', 
	'max:255'
	],  
'family_name' => [
	'sometimes',
	'nullable', 
	'string', 
	'max:255'
	],  
'name' => [
	'sometimes',
	'nullable', 
	'string', 
	'max:255'
	],  
```

### Update the Profile Controller

We now need to modify the profile controller so that the changes, are updated as expected.

We also will need to make sure that the preferred name uses the given name if it is left blank.

Open the `App\Http\Controllers` folder and locate and open the `ProfileController.php` file.

Modify the update method, to include the new checks for the given and family names and name:

```php
        $validated = $request->validated();

        if ($validated["given_name"] === null && $validated["family_name"] !== null) {
            $validated["given_name"] = $validated["family_name"];
            $validated["family_name"] = null;
        }

        if ($validated["name"] === null) {
            $validated["name"] = $validated["given_name"];
        }

        $request->user()->fill($validated);

        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }

        $request->user()->save();

        return Redirect::route('profile.edit')->with('status', 'profile-updated');
```

## Test

This should now provide teh user with the ability to register with a full name, and 'nickname', and also update their profile.


Can you see a problem with this when working with exising users?


# END

Next up - [S12 Laravel 03 Feature Country](../session-12/S11-Laravel-02-Category-Feature.md)
