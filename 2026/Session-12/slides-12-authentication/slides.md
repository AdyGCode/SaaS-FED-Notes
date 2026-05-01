---
theme: nmt
background: https://cover.sli.dev
title: Session 12 - Authentication & Authorisation - Basics
drawings:
  persist: false
transition: slide
mdc: true
duration: 90min
---

# Authentication & Authorisation Basics

## Session 12

## SaaS 1 – Cloud Application Development (Front-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa-brands-github class="text-zinc-300 text-2xl mr-2"/>
  </a>
</div>


<!-- Presenter Notes:
Introduce scope.

This session is authentication only; authorisation comes next.
-->


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

## Knowledge

- Understand **Authentication vs Authorisation**
- Understand **Laravel Fortify** and **Laravel Sanctum**
- Understand how Authentication flows work
- Understand Email Verification and Password Confirmation

::right::

## Skills

- Install and configure Laravel Fortify
- Protect routes with authentication
- Enforce authentication in Form Requests
- Test authentication flows using **Pest**

<!-- Presenter Notes:

-->

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2"></Toc>

---
layout: figure
figureUrl: orly-book-cover-hoping-nobody-hacks-you.png
---


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

# 🌟 Ice Breaker

## Where have you logged in today?

- Apps?
- Websites?
- Devices?

<!-- Presenter Notes:

-->

---
layout: section
---

# Authentication and Authorisation

---
level: 2
layout: two-cols
---

# Authentication & Authorisation

## What are they, and a comparison

::left::

## Authentication

- <strong class="text-amber-500">Who are you?</strong>
    - Proves identity
    - Usually involves:
        - Email / username
        - Password
        - Token or session

::right::

## Authorisation

- <strong class="text-amber-500">What are you allowed to do?</strong>
    - Checks permissions
    - Happens after authentication

<!-- Presenter Notes:

-->

---
layout: section
---

# Fortify & Sanctum

- Two of Laravel's Authentication Systems
- Fortify is for web authentication
- Sanctum is for APIs and SPAs

<!-- Presenter Notes:

-->

---
level: 2
---

# What is Laravel Fortify

Laravel Fortify is a backend authentication implementation for Laravel.

It provides:

- Registration
- Login / Logout
- Password reset
- Email verification
- Two‑factor authentication (optional)

Note:

- No UI provided
- Fully configurable

<!-- Presenter Notes:

-->

---
level: 2
---

# What is Laravel Sanctum

Laravel Sanctum provides API authentication using:

- API tokens
- SPA session authentication

Used for:

- Single Page Applications (React, Vue)
- Mobile apps
- External APIs

<br>

In previous Laravel versions (up to v10 inclusive), Sanctum was also
responsible for the Web based authentication.

<!-- Presenter Notes:

-->

---
level: 2
---

# Fortify & Sanctum Quick Side by Side

| Fortify            | Sanctum               |
|--------------------|-----------------------|
| Web authentication | API authentication    |
| Sessions & cookies | Tokens / SPA sessions |
| Login forms        | API calls             |

- Most Laravel web apps use both

---
layout: section
---

# Adding Laravel Fortify

- How to install
- How to configure
- How to publish settings/components/views

<!-- Presenter Notes:

-->

---
level: 2
---

# Adding Laravel Fortify

Laravel Fortify provides backend authentication features for Laravel
applications.

It handles all core authentication actions without forcing a UI, making it
ideal for custom Blade, Tailwind, or frontend-driven designs.

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Installation

From your Laravel project root, install Fortify using Composer:

```shell
composer require laravel\/fortify
```

Once installed, run the Fortify installer:

```shell
php artisan fortify:install
```

This command performs several important tasks:

- Publishes Fortify configuration
- Registers Fortify service provider
- Creates action classes for authentication logic
- Prepares the application for authentication flows

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Installation

Finally, run your migrations (if not already done):

```shell
php artisan migrate
```

At this point, Laravel Fortify is installed, but not yet configured.

## Configuring Fortify

Fortify is configured in the file: `config/fortify.php`

This file controls which authentication features are enabled.

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Configuring Fortify

### Enable Core Features

Open `config/fortify.php` and ensure the following features are enabled:

```php
'features' => [
  Features::registration(),
  Features::resetPasswords(),
  Features::emailVerification(),
],
```

These features provide:

- User registration
- Password reset workflow
- Email verification enforcement

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Update the User Model

To enable email verification, update the User model.

- Add the `MustVerifyEmail` contract,
- Ensure the User model implements the `MustVerifyEmail` contract

```php {none|1|3|all}
use Illuminate\Contracts\Auth\MustVerifyEmail;

class User extends Authenticatable implements MustVerifyEmail
{
    // ...
}
```

This ensures Laravel automatically requires verified email addresses where
appropriate.


---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Ensure Fortify Is Registered

Fortify should already be registered automatically.

Inside AppServiceProvider (or bootstrap/app.php in Laravel 11+), ensure
providers are loaded correctly, verifying that the Fortify Service
Provider exists:

```php
/FortifyServiceProvider.php
```

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## How to Publish Settings, Components, and Views

Fortify is UI-agnostic by default, meaning it does not publish Blade views
automatically.

The following steps allow you to customise authentication pages.

- Publish Configuration
    - No further action required here unless updating features
- Publish Fortify Views (Optional but Recommended)
    - To customise login, register, and verification views

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## How to Publish Settings, Components, and Views

To publish the Fortify views use:

```shell
artisan vendor:publish --tag=fortify-views
```

This creates `resources/views/auth/`, including templates for:

- Login
- Registration
- Password reset
- Email verification
- Confirm password

<Announcement type="idea">
You are now free to modify these views using Blade + Tailwind CSS.
</Announcement>


---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Enable Custom Views in Fortify

Open `app/Providers/FortifyServiceProvider.php` and ensure view rendering is
enabled:

```php
use Laravel\Fortify\Fortify;

public function boot(): void
{
    Fortify::loginView(fn () => view('auth.login'));
    Fortify::registerView(fn () => view('auth.register'));
}
```

You may also define views for:

- Password reset
- Email verification
- Confirm password

---
level: 2
---

# How to Install, Configure & Implement Laravel Fortify

## Quick Verification Checklist

- Composer package installed
- `fortify:install` executed
- Config enabled (`config/fortify.php`)
- User model implements MustVerifyEmail
- Views published and editable
- Fortify service provider configured

---
level: 2
layout: two-cols
---

# What Fortify Does Not Do

::left::

It is important to understand Fortify’s boundaries:

- Does NOT provide frontend styling
- Does NOT define roles or permissions
- Does NOT replace policies or gates

::right::

Those responsibilities belong to:

- Blade / Tailwind / Frontend framework
- Laravel Authorisation (Policies & Gates)
- Sanctum (API authentication)

---
layout: section
---

# How Fortify Works

<!-- Presenter Notes:

-->

---
level: 2
layout: two-cols-2-1
---

# How Fortify Works

::right::

## Registration Flow

1. User submits registration form
2. Data validated
3. User record created
4. Email verification sent <br> (if enabled)

::left::

```mermaid
sequenceDiagram
  User->>Laravel: Submit registration
  Laravel->>Database: Create user
  Laravel->>Mail: Send verification email
```

---
level: 2
---

# How Fortify Works

## The Process of Email Validation

Email validation (email verification) ensures that a registered user actually
owns the email address they supplied.

Laravel Fortify integrates this process directly into the authentication
lifecycle.

| Step                       | Actions Taken                                                                                                        |
|----------------------------|----------------------------------------------------------------------------------------------------------------------|
| User registers an account  | The user submits the registration form (name, email, password).<br>Laravel validates the input data.                 |
| User record is created     | A new user record is saved to the database.<br>The user is marked as unverified (email_verified_at = null).          |
| Verification email is sent | Laravel automatically sends an email containing:<br>- A signed verification URL<br>- A unique token tied to the user |

---
level: 2
---

# How Fortify Works

## The Process of Email Validation

continued...

| Step                          | Actions Taken                                                                                                  |
|-------------------------------|----------------------------------------------------------------------------------------------------------------|
| User clicks verification link | The link directs the user back to the application.<br>The request includes a signed hash to prevent tampering. |
| Laravel validates the request | The signature and user ID are verified.<br>If valid, Laravel updates the user record.                          |
| Email marked as verified      | The email_verified_at timestamp is set.<br>The user is now considered verified.                                |
| Access to protected features  | Routes or features requiring verified middleware are now accessible.                                           |

<!--
Key Laravel Concepts Involved

- MustVerifyEmail interface on the User model
- auth middleware (authentication)
- verified middleware (email verification)
- Signed URLs for security
- Notification system (email delivery)
-->


---
level: 2
---

# How Fortify Works

## The Process of Email Validation

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant Laravel
    participant Database
    participant Mail

    User->>Laravel: Submit registration form
    Laravel->>Database: Create user (email_verified_at = null)
    Laravel->>Mail: Send verification email
    Mail->>User: Verification link received

    User->>Browser: Click verification link
    Browser->>Laravel: GET /email/verify/{id}/{hash}
    Laravel->>Laravel: Validate signed URL
    Laravel->>Database: Update email_verified_at
    Laravel->>User: Email verified successfully
```

---
level: 2
---

# How Fortify Works

## Why Email Verification Matters

- Prevents fake or disposable email accounts
- Reduces spam and abuse
- Protects password reset workflows
- Improves application security

---
level: 2
---

# How Fortify Works

## Common Middleware Usage

```php {none|1|all}
Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/dashboard', fn () => view('dashboard'));
});
```

<Announcement type=info title="auth/verified" class="mt-8">

In the list/array `['auth', 'verified']` ...

- auth &rarr; user must be logged in
- verified &rarr; user must have a verified email address

</Announcement>

---
level: 2
---

# How Fortify Works

## Failure Scenarios to Consider

- User never clicks verification email
- Verification link expires
- Verification link is modified or tampered with
- User attempts access without verification

These scenarios are ideal for Pest test cases and will be covered in testing
sections.


---
level: 2
---

# How Fortify Works

## Summary

- Email verification is automatic once Fortify is configured
- Verification status is stored in the database
- Access can be enforced using middleware
- Security relies on signed URLs and timestamps

---
level: 2
layout: two-cols-2-1
---

# How Fortify Works

## Login Flow

::right::

### Process...

- User submits credentials
- Credentials validated
- Session created
- User authenticated

::left::

```mermaid
sequenceDiagram
  User->>Laravel: Submit login
  Laravel->>Database: Verify credentials
  Laravel->>Session: Create session

```

---
level: 2
layout: two-cols-2-1
---

# How Fortify Works

## Logout Flow

::right::

### Process...

- User logs out
- Session destroyed
- User unauthenticated

::left::

```mermaid
sequenceDiagram
  User->>Laravel: Logout
  Laravel->>Session: Destroy session
```

<!-- Presenter Notes:

-->

---
layout: section
---

# Using Fortify in Laravel Application

<!-- Presenter Notes:

-->

---
level: 2
---

# Using Fortify in Laravel Application

- Installation and Configuration provided earlier

<!-- Presenter Notes:

-->

---
level: 2
---

# Using authentication in routes

```php
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', fn () => view('dashboard'));
});
```

- Only authenticated users can access

<!-- Presenter Notes:

-->

---
level: 2
---

# Authentication in Store, Update Requests

```php
public function authorize(): bool
{
    return auth()->check();
}
```

- Protects business logic
- Works even if routes are misconfigured

<!-- Presenter Notes:

-->

---
level: 2
---

# Enabling & Configuring Email Verification

- Ensures user owns the email address
- Prevents fake account abuse
- Enabled in Laravel by implementing MustVerifyEmail

<!-- Presenter Notes:

-->

---
layout: section
level: 2
---

# Testing Email Verification using Mailpit

<!-- Presenter Notes:
# Testing Email Verification using Mailpit

This section demonstrates how to safely and visually test email verification
**without sending real emails**.

Mailpit acts as a local email inbox for development and testing.

-->

---
level: 2
layout: two-cols
---

# Testing Email Verification using Mailpit

::left::

## Why Use Mailpit?

- Local email testing tool
- Captures outgoing emails
- No real emails are sent
- Perfect for development and automated testing

::right::

## Benefits...

✅ Safe
✅ Fast
✅ Visual

---
level: 2
---

# Testing Email Verification using Mailpit

## Installing Mailpit

| Option             | Notes                                             |
|--------------------|---------------------------------------------------|
| Local Installation | Does not rely on WSL/Docker/et al                 |
| Docker             | Self contained                                    |
| Laragon            | Windows Only, Laragon v8 has Mailpit as an option |

<Announcement type=info title="Installation instructions">

Please refer to the Axllent Mailpit Docs: https://mailpit.axllent.
org/docs/install/

</Announcement>


---
level: 2
layout: two-cols
---

# Testing Email Verification using Mailpit

## Using Mailpit

| Exposed Service | Address:Port          |
|-----------------|-----------------------|
| SMTP Server     | localhost:1025        |
| Web UI          | http://localhost:8025 |

::left::

### Configure Laravel to Use Mailpit

Update your `.env` file.

When testing only change:

- `MAIL_MAILER`, `MAIL_HOST`, `MAIL_PORT`, `MAIL_FROM_ADDRESS`

External mail providers - check their details.

::right::

### Example settings

```ini {none|1|2|3|7|all}
MAIL_MAILER = smtp
MAIL_HOST = 127.0.0.1
MAIL_PORT = 1025
MAIL_USERNAME = null
MAIL_PASSWORD = null
MAIL_ENCRYPTION = null
MAIL_FROM_ADDRESS = "noreply@example.com"
MAIL_FROM_NAME = "${APP_NAME}"
```

---
level: 2
---

# Testing Email Verification using Mailpit

## Triggering the Verification Email

- Register a new user
- Laravel automatically sends a verification email
- Mailpit captures the email instantly

✅ No extra code required


---
level: 2
layout: two-cols
---

# Testing Email Verification using Mailpit

::left::

## Viewing the Verification Email

Open Mailpit in your browser: http://localhost:8025

Select the latest email

Inspect:

- Recipient
- Subject
- Verification link

::right::

## Verifying the Email Address

Click the verification link in Mailpit

Laravel validates:

- Signed URL
- User ID

When successful:

- email_verified_at is updated
- User is redirected to the intended page

✅ Email successfully verified

---
level: 2
layout: grid
---

# Testing Email Verification using Mailpit

## Common Issues & Troubleshooting

::tl::

### No email received?

- Check Mailpit is running
- Confirm .env MAIL settings

::tr::

### Verification link expired?

- Request new verification email

::bl::

### Access denied?

- Ensure verified middleware is applied correctly

---
level: 2
layout: two-cols
---

# Testing Email Verification using Mailpit

<br>

## Useful Routes for Testing

Use the dashboard to test authentication:

- e.g. http://localhost:8000/dashboard

```php
Route::middleware(['auth', 'verified'])
    ->get('/dashboard', function () {
        return view('dashboard');
    });
```

::left::

### When testing the routes...

Try accessing "client dashboard":

- before email verification
- after email verification

::right::

### Why This Matters for Testing

- Prevents fake accounts
- Verifies email-based workflows
- Enables full end-to-end authentication testing
- Required for reliable Pest feature tests

Mailpit ensures this can all be done locally and safely.


---
level: 2
layout: two-cols
---

# Confirm Password: Adding extra protection

Accomplish this by password re-confirmation.

::left::

### Protect:

- sensitive areas of site
- sensitive actions/features

::right::

### For example:

- Changing email
- Deleting account
- Protecting the Admin Dashboard and other Admin routes.

---
level: 2
layout: two-cols
---

# Confirm Password: Adding extra protection

<br>

## Example:

- protecting the admin dashboard
- require re-enter current user password

::left::

### Protect Admin dashboard

|             |               |
|-------------|---------------|
| Endpoint:   | `/admin`      |
| Route Name: | `admin.index` |

::right::

### Example Code

```php
Route::get('/admin', fn () => view('admin'))
    ->middleware([ 'auth', 'password.confirm' ])
    ->name('admin.index');
```

<!-- Presenter Notes:

-->


---
layout: section
---

# Authentication Pest Testing

Testing register, login, logout, and other actions.

<!-- Presenter Notes:

This section introduces automated testing for authentication.

Emphasize authentication is critical infrastructure and MUST be tested.

These are feature tests that simulate real user behaviour.

-->

---
level: 2
layout: two-cols
---

# Authentication Pest Testing

::left::

### We test:

- Register success & failure
- Login success & failure
- Logout behaviour
- Email verification

::right::

### Why:

- Confidence
- Prevent regressions
- Catch security flaws early
- Prove expected behaviour

<!-- Presenter Notes:

Reinforce: authentication bugs are security bugs.
Testing ensures our assumptions about access control are correct.

-->


---
level: 2
---

# Authentication Pest Testing

## Register success

```php
it('allows a user to register successfully', function () {

    $response = $this->post('/register', [
        'name' => 'Test User',
        'email' => 'pest.test@example.com',
        'password' => 'password',
        'password_confirmation' => 'password',
    ]);

    $response->assertRedirect('/email/verify');

    $this->assertDatabaseHas('users', [
        'email' => 'pest.test@example.com',
    ]);

});
```

---
level: 2
---

# Authentication Pest Testing

## Register failure

```php
it('fails registration when email is missing', function ()
{
    $response = $this->post('/register', [
        'name' => 'Test User',
        'password' => 'password',
        'password_confirmation' => 'password',
    ]);

    $response->assertSessionHasErrors('email');
});

```

---
level: 2
---

# Authentication Pest Testing

## Verify email success

```php
it('verifies a users email address', function () {
    $user = User::factory()->unverified()->create();

    $verifyUrl = URL::temporarySignedRoute(
        'verification.verify',
        now()->addMinutes(60),
        [
            'id' => $user->id,
            'hash' => sha1($user->email)
        ]
    );

    $this->actingAs($user)->get($verifyUrl);

    expect($user->fresh()->hasVerifiedEmail())->toBeTrue();
});
```

---
level: 2
---

# Authentication Pest Testing

## Verify email failure

```php
it('rejects an invalid verification link', function () {

    $user = User::factory()
                ->unverified()
                ->create();

    $invalidUrl = route('verification.verify', [
                            'id' => $user->id,
                            'hash' => 'invalid-hash',
                  ]);
               
    $this->actingAs($user)
        ->get($invalidUrl)
        ->assertStatus(403);
});
```

---
level: 2
---

# Authentication Pest Testing

## Login success

```php
it('allows a verified user to login', function () {

    $user = User::factory()->create([
        'password' => bcrypt('password'),
        'email_verified_at' => now(),
    ]);

    $response = $this->post('/login', [
        'email' => $user->email,
        'password' => 'password',
    ]);

    $response->assertRedirect('/dashboard');

    $this->assertAuthenticatedAs($user);
});
```

---
level: 2
---

# Authentication Pest Testing

## Login failure (wrong email address)

```php
it('fails login with incorrect email', function () {

    $user = User::factory()->create([
        'password' => bcrypt('password'),
    ]);

    $response = $this->post('/login', [
        'email' => 'wrong@example.com',
        'password' => 'password',
    ]);

    $response->assertSessionHasErrors();

    $this->assertGuest();
});
```

---
level: 2
---

# Authentication Pest Testing

## Login failure (password)

```php
it('fails login with incorrect password', function () {

    $user = User::factory()->create([
        'password' => bcrypt('password'),
    ]);

    $response = $this->post('/login', [
        'email' => $user->email,
        'password' => 'wrong-password',
    ]);

    $response->assertSessionHasErrors();
    $this->assertGuest();
});
```

---
level: 2
---

# Authentication Pest Testing

## Logout success (authenticated)

```php
it('logs out an authenticated user', function () {   
 
    $user = User::factory()->create();    
    
    $this->actingAs($user)        
         ->post('/logout')        
         ->assertRedirect('/');
             
    $this->assertGuest();
});
```

---
level: 2
---

# Authentication Pest Testing

## Logout failure (not authenticated)

```php
it('prevents logout when not authenticated', function () {    

    $this->post('/logout')        
         ->assertRedirect('/login');
         
});
```

---
layout: section
---

# Demo

Adding a "Topics" CRUD with Authentication

<!-- Presenter Notes:

-->

---
level: 2
layout: two-cols
---

# Adding a "Topics" CRUD with Authentication

<br>

## General Overview

With the Contacts Application, we are providing a "Contact Us" page.

::left::

### Contact Us Page:

- Details how to contact the company
- A contact us form to send messages

<br>

### Contact Us Form:

- Name, Topic, Subject, and Message fields

::right::

### Topics:

- A topic is a general subject for the form
- We are providing CRUD/BREAD to manage the topics
- Topic CRUD will be part of the Admin area

---
level: 2
---

# Topic Overview

<br>

### Topic Model Detail 

| Property    | Specifications                       |    |
|-------------|--------------------------------------|----|
| id          | unsigned, big integer, autoincrement | PK |
| name        | string, unique, min: 6, max: 32      |    |
| description | string, nullable                     |    |
| available   | boolean, default true                |    |
| created_at  | timestamp                            |    |
| updated_at  | timestamp                            |    |

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Create Stub Files

```shell
php artisan make:model Topic --controller --migration --policy --seed --resource --factory --pest --request
```
<Announcement type="warning">Lots of typing. Easy to make 
mistakes.</Announcement>

or shorthand:

```shell
php artisan make:model Topic --all --pest
```

<Announcement type="joke">Much Neater!</Announcement>

<br>

## Create Subfolders

```shell
mkdir -p app/Http/{Controllers,Requests}/{Admin,Web,Client}
```

<br>

## Create `.gitignore` files

```shell
touch app/Http/{Controllers,Requests}/{Admin,Client,Web}/.gitignore
```

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Organise Newly Added  Files

Move the Topic Controller and Requests into the sub-folders.

```shell
mv app/Http/Controllers/TopicController.php app/Http/Controllers/Admin/TopicController.php

mv app/Http/Requests/{StoreTopicRequest.php,UpdateTopicRequest.php} app/Http/Requests/Admin
```

<br>
<br>

<Announcement type=info title="Bash Shortcuts">
<p>Note the use of the `{ }` in the commands.</p>
<p>This provides a list of items that will be iterated.</p>
<p>Helps reduce number of commands entered.</p>
</Announcement>

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Model code

We will employ the use of PHP Attributes for defining our properties:

```php {none|1|2-3,22|4-5|6-14|15-21|all}
#[Fillable(['name', 'description', 'available'])]
class Topic extends Model
{
    /** @use HasFactory<\Database\Factories\TopicFactory> */
     use HasFactory;
     
    /**
     * Attribute (type) casting
     *
     */
    protected function casts(): array{
        return [];
    }

    /**
     * Relationships
     */

    /**
     * Model helper methods
     */
}
```

Use `#[Hidden([...])]` for hidden/non-serialisable properties
---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Migration code

Open `database/migrations/YYYY_MM_DD_HHMMSS_create_topics_table.php`

Update the 'up' method:

```php {none|1-2,10|3,9|4|5|6|7|8|all}
public function up(): void
{
    Schema::create('topics', function (Blueprint $table) {
        $table->id();
        $table->string('name',16)->unique()->default("general");
        $table->string('description')->nullable();
        $table->boolean('available')->default(true);
        $table->timestamps();
    });
}
```

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Seed Data

We are going to add seed data.

Topic #1 is a default "Unknown / General Query" topic

| ID  | Name    | Description                    | Available                             |
|-----|---------|--------------------------------|---------------------------------------|
| 1   | General | Genweral query / Unknown topic | <span class="text-green-500">Y</span> |

Open the `database/seeders/TopicSeeder.php` file...

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Seeder code

We will show each block of the seeder code.

````md magic-move

```php {1-2,14|4-6|8-12|all}
public function run(): void
{

    $seedTopics = [
        // Seed topics added here
    ];

    foreach($seedTopics as $seedTopic){
        if (! Topic::find($seedTopic['name'])) {
            Topic::create($seedTopic);
        }
    }

}
```

```php {4,11-12|5-10|all}
public function run(): void
{

    $seedTopics = [
        [
            'id'=>1,
            'name' => 'general',
            'description' => 'General Query / Unknown Topic',
            'available' => true,
        ],
        // Three more seed topics
    ];

    foreach($seedTopics as $seedTopic){
        if (! Topic::find($seedTopic['name'])) {
            Topic::create($seedTopic);
        }
    }

}
```


```php {4,12-13|5-11|all}
public function run(): void
{

    $seedTopics = [
        // Topic 1 [ 'id'=>1, ...],
        [
            'id'=>100,
            'name' => 'website errors',
            'description' => 'Website errors',
            'available' => true,
        ],
        // Two more seed topics
    ];

    foreach($seedTopics as $seedTopic){
        if (! Topic::find($seedTopic['name'])) {
            Topic::create($seedTopic);
        }
    }

}
```

```php {4,12-13|4-6,12-13|7-11|all}
public function run(): void
{

    $seedTopics = [
        // Topic 1 [ 'id'=>1, ...],
        // Topic 100 [ 'id'=>100, ...],
        [
            'name' => 'website oopsie',
            'description' => 'Website errors',
            'available' => false,
        ],
        // One more seed topic
    ];

    foreach($seedTopics as $seedTopic){
        if (! Topic::find($seedTopic['name'])) {
            Topic::create($seedTopic);
        }
    }

}
```


```php {4-7,13|8-12|all}
public function run(): void
{

    $seedTopics = [
        // Topic 1 [ 'id'=>1, ...],
        // Topic 100 [ 'id'=>100, ...],
        // Topic 101 [ 'name'=>'feedback', ...],
        [
            'name' => 'feedback',
            'description' => 'Client feedback (positive and negative)',
            'available' => true,
        ],
    ];

    foreach($seedTopics as $seedTopic){
        if (! Topic::find($seedTopic['name'])) {
            Topic::create($seedTopic);
        }
    }

}
```


````

---
level: 2
---

# Exercise: add more seed topics

Add the following seed topics to the seeder:

| ID  | Name        | Description                      | Available                             |
|-----|-------------|----------------------------------|---------------------------------------|
| 300 | Books       | Fiction & Non Fiction            | <span class="text-green-500">Y</span> |
| 199 | Dummy Topic |                                  | <span class="text-red-500">N</span>   |
| 200 | Technology  | Information & Other Technologies | <span class="text-green-500">Y</span> |
| 900 | Dummy Topic |                                  | <span class="text-red-500">N</span>   |

Make sure you keep the above order in the seed data.

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Factory code

Open the `database/factories/TopicFactory.php` file...

Edit the file - the code is show in stages.

````md magic-move

```php {none|1-4|5-11|all}
namespace Database\Factories;

use App\Models\Topic;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Topic>
 */
class TopicFactory extends Factory
{
    public function definition(): array
    {
        // Code to add here
    }
}

```

```php {1-2,8|3,7|4|5|6|all}
    public function definition(): array
    {
        return [
                'name' => fake()->word(),
                'description' => fake()->sentence(),
                'available' => fake()->boolean(0.5),
            ];
    }
```

````


---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Routing for Topics

Open the `routes\web.admin.php` (or `routes\web\admin.php`) file.

The top of the file indicates the controllers being used.

Add:
- Admin and Topic Controllers:
- Route middleware, name and prefixing
- Define the topics as a resourceful route

#### Code:

````md magic-move
```php
use App\Http\Controllers\Admin\AdminController;
use App\Http\Controllers\Admin\TopicController;
use Illuminate\Support\Facades\Route;
```

```php
Route::middleware(['auth', 'verified'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {

    // Add Routes

    });

```

```php
    ->group(function () {

        // URL base: http://HOSTNAME/admin/topics
        // Route Names: admin.topics.*
        Route::resource('topics', TopicController::class);

        Route::get('/', [AdminController::class, 'index'])
            ->name('index');
    });
```

````

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Resourceful controller code

We will now create the TopicController code for each method:

- index
- show
- create
- store
- edit
- update
- destroy


---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `index`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `show`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `create`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `store`


---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `edit`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `update`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Resourceful Controller Code: `destroy`



---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Requests code for Store and Update

The authorize method requires updating:

- brute force, return true

Problem:
- allows anyone to use the store/update.

Solution:
- check if logged in
- additionally check permissions (later)

This applies to BOTH Store and Update requests.

```php
public function authorize(): bool
{
    return auth()->check();
}
```




---
level: 2
---

# Adding a "Topics" CRUD with Authentication

### Add Validation for Store Request


---
level: 2
---

# Adding a "Topics" CRUD with Authentication

### Add Validation for Update Request

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Add Authentication validation for routes, requests and actions

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Authentication: All actions must be logged in before working

---
level: 2
---

# Adding a "Topics" CRUD with Authentication

## Authentication verification within Store & Update Requests

Modify the previous `authorize` method to now read:

```php
public function authorize(): bool
{
    return auth()->check();
}
```

- Checks is CURRENT USER is logged in.
- Returns:
    - true (logged in - authenticated) or
    - false (not authenticated)

<!-- Presenter Notes:

-->

---
layout: section
---

# Pest Testing Actions with Authentication

<!-- Presenter Notes:


-->

---
level: 2
---

# Pest Testing Actions with Authentication

---
level: 2
---

## Browse topics (no authentication)

---
level: 2
---

## Read a Topic (authentication required)

---
level: 2
---

## Read a Topic Failure (Not Authenticated)

---
level: 2
---

## Read a Topic Failure (Authenticated, Topic does not exist)

---
level: 2
---

## Create/Store a New Topic (Authenticated)

---
level: 2
---

## Create/Store a New Topic Failure (Authenticated, missing topic name)

---
level: 2
---

## Create/Store a New Topic Failure (Authenticated, Topic name too short)

---
level: 2
---

## Create/Store a New Topic Failure (Not Authenticated)

---
level: 2
---

## Edit/Update an existing Topic (Authenticated)

---
level: 2
---

## Edit/Update an existing Topic Failure (Authenticated, missing topic name)

---
level: 2
---

## Edit/Update an existing Topic Failure (Authenticated, Topic name too short)

---
level: 2
---

## Edit/Update an existing Topic Failure (Not Authenticated)

---
level: 2
---

## Destroy an existing Topic (authentication required)

---
level: 2
---

## Destroy an existing Topic Failure (Not authenticated)

---
level: 2
---

## Destroy an existing Topic Failure (Authenticated, Topic does not exist)

<!-- Presenter Notes:

Each of the above will be level: 2 slides

-->

---

# In-Class Practice Exercise

- Create a basic CRUD for Categories
    - A category has: title (unique, min: 6, max: 32), description (nullable)
    - Add Model, Migration, Seeder (seed data provided), Factory, Resourceful
      controller, Requests
    - Add routing for Categories

- Add Authentication validation for routes, requests and actions
    - All actions must be logged in before working
    - use Store and Update Requests for ensuring authenticaiton
    - use Store and Update Requests for validation of data

<!-- Presenter Notes:



-->


<!-- Presenter Notes:

-->

---

# Out-of-Class Activities

**Research**

- ...

**Practice**

- ...

**Tutorials**

- ...

<!-- Presenter Notes:

-->

---

# Summary Checklist

- [ ] ...

<!-- Presenter Notes:

-->

---
level: 2
layout: grid
---

# Exit Ticket Questions

::tl::

<Announcement type="brainstorm">
What is authentication?
</Announcement>


::tr::

<Announcement type="brainstorm">
How is it different from authorisation?
</Announcement>


::bl::

<Announcement type="brainstorm">
Why verify email addresses?
</Announcement>

::br::

<Announcement type="brainstorm">
Where should authentication checks exist?
</Announcement>


<!-- Presenter Notes:

-->

---

# Acknowledgements & References (APA v7)

- TODO: Add references etc

> Some content may have been generated with the assistance of Microsoft
> CoPilot


<!-- Presenter Notes:

-->

---
layout: end
---

# Fin!

Haiku here



<!-- Presenter Notes:

-->

---
