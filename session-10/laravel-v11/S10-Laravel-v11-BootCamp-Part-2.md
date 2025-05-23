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
updated: 2025-05-23T11:58
---

# S10 Laravel Bootcamp: Part 2

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

# Laravel Bootcamp Part 2

The following notes are based on the official Laravel v12 Bootcamp(Build Chirper with Blade https://bootcamp.laravel.com) with Adrian's shortened explanations.

## Before you start...

Have you gone over the [S10 Introducing Laravel](session-10/laravel-v11/S10-Introducing-Laravel-v11.md) and then [S10 Laravel v12 BootcampPart 1](session-11/S10-Laravel-v12-BootCamp-Part-1.md) ?

No? Well... go do it...

We will wait here until you are ready.

# Adding a New Menu Item

The default Laravel Blade template for the navigation has both a desktop and responsive menu, so our editing will need to update (add) both options.

Let's get started...

Use the, by now familiar, Double SHIFT to open the file find dialog, and enter navigation.

This should highlight the `navigation.blade.php` file

Open this up and search for the following:

```php
<x-nav-link :href="route('dashboard')" :active="request()->routeIs('dashboard')">

{{ __('Dashboard') }}

</x-nav-link>
```

This is the desktop navigation link.

We are going to cheat dramatically here and select these lines and use the CTRL+D shortcut in PhpStorm to duplicate the lines.

Now we need to edit this to have "Chirps" and to route to the chirps index page.

```php
<x-nav-link :href="route('chirps.index')" 
		    :active="request()->routeIs('chirps.index')">
	{{ __('Chirps') }}
</x-nav-link>
```

Refreshing your browser page will give the Chirps menu item, and even better it will be highlighted as active!

Now to do the mobile/responsive menu.

in the same file search for the code that says:

```php
  
<x-responsive-nav-link 
		:href="route('dashboard')"
		:active="request()->routeIs('dashboard')">  
    {{ __('Dashboard') }}  
</x-responsive-nav-link>
```

Duplicate these lines, and do the same edits...

```php
<x-responsive-nav-link 
		:href="route('chirps.index')" 
		:active="request()->routeIs('chirps.index')">  
    {{ __('Chirps') }}  
</x-responsive-nav-link>
```

If you refresh your browser and also shrink it down, you will see the mobile navigation appear, and then using the hamburger, it will expand to show the Chirps entry, again highlighted as active.

![](assets/S10-Laravel-v12-BootCamp-Part-2-20240920172149440.png)

# Display our Chirps

Ok, so we can chirp, and we can navigate to the chirps when we log in... but what about seeing them?

Well, it's that time.

Locate the Chirp Controller and edit the index method as we need to do two things in here:
\
- Collect all the chirps in reverse order
- Send the chirps to the Chirps index page

## Getting all the Chirps

To collect all the chirps we use the following:

```php
$chirps = Chirp::with('user')->latest()->get();
```

This tells Laravel to retrieve the Chirps with each Chirp's User details, sorting them in reverse order.

We then send these to the Chirps index page:

```php
return view('chirps.index', compact(['chirps',]));
```

Update the index method to use these lines instead of the single line:

```php
return view('chirps.index');
```


## Bonus: Awesome Icons in the App

In an effort to reduce the embedded SVGs for icons (for the time being) we are going to use Font Awesome, a wonderful Free and Paid icon set that provides over *33,000 icons* in total, and of that 2,000 icons are for free to use.

Start by heading to the Bash Shell and in one of the sections that is not busy enter:

```shell
npm install --save @fortawesome/fontawesome-free
```


> **Note:** To see the range of icons (both Free and Paid), head to https://fontawesome.com, and more particularly the following link:
> 
> - https://fontawesome.com/search?o=r&m=free



### Update Tailwind CSS Configuration

Now edit the `tailwind.config.js` file and modify the `content` section to be:

```js
content: [  
    './vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php',  
    './storage/framework/views/*.php',  
    './resources/**/*.blade.php',  
    './resources/**/*.{js,vue}',  
],
```


### Add Font Awesome to App CSS

Now open the `resources/css/app.css` file and modify to include the Font Awesome libraries:

```css
@import '@fortawesome/fontawesome-free/css/fontawesome.css';  
@import '@fortawesome/fontawesome-free/css/regular.css';  
@import '@fortawesome/fontawesome-free/css/solid.css';  
@import '@fortawesome/fontawesome-free/css/brands.css';  
  
@tailwind base;  
@tailwind components;  
@tailwind utilities;
```


### Check Vite Config

Make sure the Vite configuration is correct ... open `vite.config.js` and check it is the same as:

```js
import { defineConfig } from 'vite';  
import laravel from 'laravel-vite-plugin';  
  
export default defineConfig({  
    plugins: [  
        laravel({  
            input: [  
                'resources/css/app.css',  
                'resources/js/app.js',  
            ],  
            refresh: true,  
        }),  
    ],  
});
```


### App Template update

Next we need to update the app and the guest templates...

Open the `resources/views/layouts/app.blade.php` file and check it contains the following:

```html

```

Repeat for the `resources/views/layouts/guest.blade.php` file...

Ok, now this is done we can work on our Chirps in the Chirp Index Page.



## Updating the Chirps Index page

Open the `resources/views/chirps/index.blade.php` file, and navigate to immediately after the `</form>` tag, and press ENTER twice.

In this new space, add:

```php
<div class="mt-6 bg-white shadow-sm 
			rounded-lg divide-y">  
    @foreach ($chirps as $chirp)  
      <div class="p-6 flex space-x-2">  
        <span 
            class="fa-regular fa-comment-dots 
	              fa-shake 
	              text-xl text-blue-400"  
            style="--fa-animation-duration: 2s;
                   --fa-animation-iteration-count: 2;  
                  --fa-animation-timing: ease-in-out;"  
            aria-hidden="true"></span>  
        <div class="flex-1">  
            <div class="flex justify-between items-center">  
                <div>
                <span class="text-gray-800">
                {{ $chirp->user->name }}
                </span>  
                <small class="ml-2 
			                 text-sm text-gray-600">
			    {{ $chirp->created_at->format('j M Y, g:i a') }}
			    </small>  
                </div>                
            </div>
            <p class="mt-4 text-lg text-gray-900">
            {{ $chirp->message }}
            </p>  
        </div>
      </div>    
    @endforeach  
</div>
```

The important bits are:

```php
    @foreach ($chirps as $chirp)  
    
	@endforeach
```

This iterates through each of the chirps that have been retrieved... placing them in a `$chirp` variable...

```php
{{ $chirp->user->name }}
```



```php
{{ $chirp->created_at->format('j M Y, g:i a')
```



```php
{{ $chirp->message }}
```


And then there is the Font Awesome icon...

```html
<span 
    class="fa-regular fa-comment-dots 
	       fa-shake 
	       text-xl text-blue-400"  
    style="--fa-animation-duration: 2s;
           --fa-animation-iteration-count: 2;  
          --fa-animation-timing: ease-in-out;"  
    aria-hidden="true"></span>  
```

This displays an animated (shake) comment bubble, in blue, that shakes twice and takes two seconds to do the shake.

![](assets/vivaldi_qqHh6J21aQ.gif)

# Coming Up

Come back in a few days and find the rest of our explanation and enhanced Boot Camp...


TODO: Add Edit

TODO: Add Delete




# END
