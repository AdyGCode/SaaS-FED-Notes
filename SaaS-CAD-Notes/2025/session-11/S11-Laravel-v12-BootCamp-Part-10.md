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
updated: 2025-10-28T21:56
---


# Laravel Bootcamp: Part 10

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

> We take a short break from the Chirper application whilst we look at Roles and Permissions.
> 
> These notes look at what Roles & Permissions are, and indicate possible ways to use and implement them.
> 
> We then look at a package (Spatie Permissions) that assists us in implementing Roles and Permissions, and use this in a separate demo application.


## Access Control

- RBAC
- PBAC
- ABAC

Microsoft's Co-pilot was asked: "Explain the terms ABAC RBAC PBAC in simple terms for a beginner, giving a table of pros and cons as a summary". 

Here is its response:

**ABAC, RBAC, and PBAC are different ways to control who can access what in a computer system. Each method has its own style of deciding permissions.**

### 🧠 Simple Definitions

- **RBAC (Role-Based Access Control)** 
	- _Access is based on your job role._  
	- Example: If you're a "Manager," you get access to manager-level tools.
    
- **ABAC (Attribute-Based Access Control)**  
	- _Access depends on attributes like your department, location, or time of access._  
	- Example: You can access a file only if you're in the "Finance" department and it's during work hours.
    
- **PBAC (Policy-Based Access Control)**  
	- _Access is controlled by policies that combine roles, attributes, and rules._  
	- Example: A policy might say: "Managers in Finance can approve expenses over $1,000 only during business hours."

### 📊 Comparison Table: Pros and Cons

|Model|Pros|Cons|
|---|---|---|
|**RBAC**|✅ Easy to set up and understand  <br>✅ Scales well for small teams|❌ Can become rigid  <br>❌ Struggles with complex or changing needs|
|**ABAC**|✅ Very flexible  <br>✅ Supports dynamic, real-time decisions|❌ Harder to manage and test  <br>❌ More complex to implement|
|**PBAC**|✅ Combines RBAC and ABAC strengths  <br>✅ Centralized, auditable policies|❌ Requires careful planning  <br>❌ Can be complex to maintain|

Sources:
- _RBAC vs ABAC vs PBAC: Understanding Access Control Models in 2025_. (2025). Osohq.com. https://www.osohq.com/learn/rbac-vs-abac-vs-pbac
- _RBAC vs ABAC vs PBAC: What Is the Difference? | Frontegg_. (2025, July 23). Frontegg. https://frontegg.com/guides/rbac-vs-abac-vs-pbac
- _Ping Identity_. (2025). Pingidentity.com. https://www.pingidentity.com/en/resources/identity-fundamentals/authorization/authorization-methods.html


If you're just starting out, **RBAC is the simplest**, but **ABAC and PBAC offer more control** as your system grows or becomes more complex. 


# Roles & Permissions

Permission:
- Granular in nature, as they are applied to individual actions/methods.
- They indicate the ability to perform an action.
- For example the ability to Add or Edit a User.

Role:
- A role is a collection of permissions.
- The role's permissions usually relate to a 'job function or 'job title' or other other organisational structure.
- Roles based on job functions could include "User Administration", "Order Administration" and "Product Administration".
- Roles based on a 'job title' could include  as "Staff", "Admin", "Writer" and "Manager".

Permissions and Roles may be combined to give a user a specific set of permissions based on one-off requirements. If a set of permissions is needed more than once, it is better to create a new role for that particular set of needs.

## Gates and Policies

Gates are…
- Permissions
- Laravel uses the term “gate”

Policies are…
- Permissions applied to (Eloquent) Models

### How do we use Gates?

Identify the typical actions needing permission:

- Define the permission: E.g. "`manage users`"
- Check the permission on the front-end:
	- E.g. show/hide the button
- Check the permission on the back-end: 
	- E.g. can/can't update the data

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
    Gate::define('manage users', 
                 function(User $user) {
      return $user->is_admin == 1;
    });
  }
}
```

And the `Resources/views/navigation.blade.php` file:

```php
<ul>

  <li>
    <a href="{{ route('projects.index') }}">
        Projects
    </a>
  </li>
	
  @can('manage users’)
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
Route::middleware(‘can:create-users')
    ->group(function () {
        Route::post(‘users’, 
              [UserController::class, ‘store']);
});
```

### Controller Can / Cannot

```php
public function store(Request $request)
{
  if (!$request->user()->can('create_users'))
    abort(403);
  }
  ...
}
```

```php
public function store(Request $request)
{
  if ($request->user()->cannot('create_users'))
    abort(403);
  }
  ...
}
```

```php
public function create()
{
  if (!auth()->user()->can('create_users'))
    abort(403);
  }
  ...
}
```

### Gate Allows / Denies

```php
public function store(Request $request)
{
    if (!Gate::allows('create_users')) {
        abort(403);
    }
    ...
}
```

```php
public function store(Request $request)
{
    abort_if(Gate::denies('create_users'), 403);
    ...
}
```

```php
public function store(Request $request)
{
    abort_if(Gate::denies('create_users'), 403);
    ...
}
```

### Controller Authorise

```php
public function store(Request $request)
{
    $this->authorize('create_users');
    ...
}
```

### Form Request class (e.g. `StoreProjectRequest`)

```php
public function store(StoreProjectRequest $request)
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
            // …
        ];
    }
}
```

## Policies

Model-based set of permissions.

Policies in Laravel are classes that organize authorization logic for a specific model or resource. 

They’re typically used with Laravel’s Gate or the `authorize()` method to control access to actions like viewing, creating, updating, or deleting resources. 

For example, a `PostPolicy` might define who can edit or delete a blog post.

> Shariful Ehasan. (2025, September 16). _Laravel Policies: Do You Really Use Them in Real Projects?_ DEV Community. https://dev.to/thecodeliner/laravel-policies-do-you-really-use-them-in-real-projects-2pa1

‌


Able to attach permission to model?

Create a Policy using (one line):

```shell
php artisan make:policy MODELNAMEPolicy 
                             --model=MODELNAME
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

/* … snipped out code … */

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

Not part of the Laravel framework.

- ‘Human readable’ term
- Groups Permissions into more 'human friendly' concepts

Examples include:

- Product Manager
- User Administrator
- Editor
- Author
- Staff Member

Permissions are what should be checked, as roles encompass many permissions. Plus a single permission may be granted to a user, thus given very precise control.



# Up Next

- [Laravel v12 Bootcamp - Part 11](S11-Laravel-v12-BootCamp-Part-12.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](S11-Reflection-Exercises-and-Study.md)

# END
