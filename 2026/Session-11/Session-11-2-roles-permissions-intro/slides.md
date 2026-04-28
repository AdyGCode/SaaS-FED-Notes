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
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
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

> Some content may have been generated with the assistance of Microsoft Copilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:

- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
