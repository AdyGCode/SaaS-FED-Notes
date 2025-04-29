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
updated: 2025-04-29T17:19
---

# S10 Laravel Bootcamp: Part 3

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

# Laravel Bootcamp: Part 3

The following notes are based on the official Laravel 11 Boot Camp (Build Chirper with Blade https://bootcamp.laravel.com) with Adrian's shortened explanations.

## Before you start…

Have you gone over the [Introducing Laravel](session-10/S10-Introducing-Laravel-v11.md) and then [Laravel Boot Camp Part 1](session-11/S10-Laravel-BootCamp-Part-1.md) and  [ Laravel Boot Camp Part-2](session-11/S10-Laravel-BootCamp-Part-2.md)?

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you will only see parts of the application working when a stage is complete. 
> 
> So if you get an error in the browser, it may be because there is something missing.

## A Small Route Cheat Sheet

Use the SHIFT SHIFT method to locate the `web.php` file and add the following comments **IMMEDIATELY** before the `Route::resource('chirps')…` code:

```php
/**  
 * Table of the HTTP VERBs, the ENDPOINT URIs, 
 * CONTROLLER ACTIONs and the ROUTEs 
 * interpreted when using route('ROUTE_NAME')
 * in code.  
 * 
* | Verb       |  URI                       |  Action   |  Route Name          |  
* |------------|----------------------------|-----------|----------------------|  
* | GET        |  /chirps                   |  index    |  chirps.index        |  
* | POST       |  /chirps                   |  store    |  chirps.store        |  
* | GET        |  /chirps/{chirp}/edit      |  edit     |  chirps.edit         |  
* | PUT/PATCH  |  /chirps/{chirp}           |  update   |  chirps.update       |  
* | DELETE     |  /chirps/{chirp}           |  destroy  |  chirps.destroy      |
 */
```

What does this tell you?

This little table identifies what is called when you use the `route('ROUTE_NAME')` in the PHP or Blade code.

This version of the table may be more readable:

| Verb      | URI                    | Controller Action | Route Name       |
| --------- | ---------------------- | ----------------- | ---------------- |
| GET       | `/chirps`              | index             | `chirps.index`   |
| POST      | `/chirps`              | store             | `chirps.store`   |
| GET       | `/chirps/{chirp}/edit` | edit              | `chirps.edit`    |
| PUT/PATCH | `/chirps/{chirp}`      | update            | `chirps.update`  |
| DELETE    | `/chirps/{chirp}`      | destroy           | `chirps.destroy` |

Ok… now onto the Edit functionality …

# Edit Chirp

To edit a chirp we are going to add a small menu to each chirp that the current logged in user owns.

This menu will have an edit and a delete action within it.

Before this we will make the Chirp index page a bit more semantic.

## Making things Semantic

Use the SHIFT-SHIFT technique to find the `chirps/index.blade.php` file.

Update the following code:

```php
<div class="mt-6 bg-white shadow-sm rounded-lg divide-y">  
    @foreach ($chirps as $chirp)  
        <div class="p-6 flex space-x-2">
```

To become:

```php
<article class="mt-6 bg-white shadow-sm rounded-lg divide-y">  
    @foreach ($chirps as $chirp)  
        <section class="p-6 flex space-x-2">
```

This makes the chirps into an article, which in semantic terms means the content could be subscribed to.

Each chirp is then a section in this article.

Make sure that the end is also updated from:
```php
        </div>  
    @endforeach  
</div>
```

to…

```php
        </section>  
    @endforeach  
</article>
```

Also, update the following parts of the code (the `…` is just a placeholder - do not delete any code at this point):

```php
<div class="flex-1">  
    <div class="flex justify-between items-center">  
        <div>
        
…

        </div>  
    </div>  
    <p class="mt-4 text-lg text-gray-900">  
        {{ $chirp->message }}  
    </p>  
</div>
```

to become:

```php
<div class="flex-1">  
    <div class="flex justify-between items-center">  
        <h5>

…

        </h5>  
    </div>  
    <p class="mt-4 text-lg text-gray-900">  
        {{ $chirp->message }}  
    </p>  
</div>
```

These changes will NOT change the look of the page, but adds extra meaning to the content.

> TODO: Add link to Semantic Markup for Web Pages

Refreshing the page should show no changes.

## Add 'Individual chirp' pop up menu

Ok, now we can add our little pop up menu.

Immediately after the `</h5>` press enter two or three times to add a line or two of space.

Then in this space we will add:

```php
@if($chirp->user->is(auth()->user()))  
    <x-dropdown>  
        <x-slot name="trigger">  
            <button>  
                Action  
            </button>  
        </x-slot>  
        <x-slot name="content">  
            <x-dropdown-link  
                :href="route('chirps.edit',$chirp)">  
                {{ __('Edit') }}  
            </x-dropdown-link>  
        </x-slot>  
    </x-dropdown>  
@endif
```

What does this do?

> Remember we use `…` to hide code that we are not discussing.

```php
@if($chirp->user->is(auth()->user()))  

	…
	
@endif
```

This blade template macro performs a decision to check if the current chirp's user is the same as the one that is currently logged in. If so then the code within the `@if`…`@endif` will be shown.

```php
@if($chirp->user->is(auth()->user()))  
    <x-dropdown>  
        <x-slot name="trigger">  
            <button>  
                Action  
            </button>  
        </x-slot>  
        
		…
		
    </x-dropdown>  
@endif
```

What will be shown is a dropdown menu that contains a single "action" button. 

```php
        <x-slot name="content">  
            <x-dropdown-link  
                :href="route('chirps.edit',$chirp)">  
                {{ __('Edit') }}  
            </x-dropdown-link>  
        </x-slot>  
```

Immediately after the button is added, we then show the action options that will appear for the drop-down.

In this case we only (currently) have the "Edit" Action.

If you save the file and refresh the browser, we get an error:

![](assets/Pasted%20image%2020250429145616.png)

Oops! We have a problem with the routes.

### Add "edit" action to the Web Routes

Use SHIFT-SHIFT and find the `web.php` routes file.

Locate the `Route::resource('chirps')` code…

We need to edit the actions that are being allowed to execute.

Update the line:

```php
->only(['index', 'store', ])
```

To read:

```php
->only(['index', 'store', 'edit', 'update',])
```

This tells the router that we want to also allow the *edit* and *update* methods to be executed.

Refreshing the page should now remove the error we had and we get "Action" being shown:

![](assets/Pasted%20image%2020250429151804.png)

In the image above, you can see the action in the Staff User chirp, but not in the Administrator chirp. This is because the Staff User is logged in, not the Administrator.

Clicking onthe word "Action" pops up a menu:

![](assets/Pasted%20image%2020250429151936.png)

But clicking edit gives us a blank screen… :-(

So close…


### Add the Edit Method

Using SHIFT-SHIFT locate the `ChirpController` and open it.

Now scroll to find the `edit` method and update it as follows:

```php
public function edit(Chirp $chirp)  
{  
    return view('chirps.edit', compact(['chirp',]);  
}
```

Ok, there are a couple of things you need to be aware of in these four lines of code.

1. `public function edit(Chirp $chirp)`

	- This method uses Route-Model Binding
	- The resourceful route definition means we use the `edit` method.
	- If we wrote the route (in `routes/web.php`) by hand then it would be:
	   `route::get("chirps/{chirp}/edit", [ChirpController::class, 'edit'])->name('chirps.edit')` 
	- The `Chirp $chirp` automatically calls "Eloquent" to find the Model (`Chirp`) that was requested
	- The `{chirp}` is used as the "id" for Eloquent to perform the equivalent to:
	   `$chirp = Chirp::whereID($chirp)->get()`
2. We compact the `$chirp` that was found (as an Eloquent model) and send to the view for it to render.

Refreshing the browser will now remove the error and show a blank page…

### Adding the View

Let's start by adding a new view to the chirps by using the `touch` command…

```shell
touch resources/views/chirps/edit.blade.php
```

Use the SHIFT-SHIFT method to locate the file and open it.

To this blank file we now add (keep the blank lines for readability):

```php
<x-app-layout>  
    <div class="max-w-2xl mx-auto p-4 sm:p-6 lg:p-8">  

…

    </div>   
</x-app-layout>
```

Inside the `<div>` … `</div>` we add the following, making sure we leave a blank line before the form element, and three blank lines after:

```php
<form action="{{ route('chirps.update', $chirp) }}"  
      method="POST">  
    @csrf  
    @method('patch')  
  
…

</form>  
```

> We need to take a small stop here and look at the code to understand what is happening.
>
> The form is pretty familiar. 
> 
> We are asking the form to use the `POST` method to send the form content to the `chirps.update` route with the `$chirp` that we are editing.
> 
> The `CSRF` blade macro inserts a hidden input field that contains a token to help prevent cross-site request forgeries.
> 
> The `method` is Laravel's way of faking the actual `PUT` or `PATCH` HTTP request verb, as most browsers, servers and language interpreters, do not understand the methods beyond `GET` and `POST`.
> 
> It created another hidden field, `_method` and makes its value `PATCH`.

Next we add the `textarea` and the error message area to the form:

```php
<textarea  
    name="message"  
    rows="3"  
    placeholder="{{ __("What's on your mind?") }}"  
    class="block w-full p-4  
           border-gray-300 focus:border-indigo-300
           focus:ring focus:ring-indigo-200
           focus:ring-opacity-50
           rounded-md shadow-sm shadow-black/50"      >{{ old('message', $chirp->message) }}</textarea>
          
<x-input-error :messages="$errors->get('message')" class="mt-2"/>  

```

The only real change to this version of the text areas, as compred to the one in the index page () is:

```php
{{ old('message', $chirp->message) }}
```

This blade macro uses the `old` method to show the 'message' content from the submitted form. This is usually due to a validation error.

If there are no errors then the original from the chirp is shown in the text area.


Finally we add the buttons to save or cancel the changes:

```php 
<div class="mt-4 space-x-2">  
    <x-primary-button>
        {{ __('Save') }}
    </x-primary-button>  
    <a href="{{ route('chirps.index') }}">  
        {{ __('Cancel') }}  
    </a>  
</div>  
```

Note how the Cancel button is in fact just a hyperlink back to the index page for the chirps.

Refreshing the browser will now show something similar to:

![](assets/Pasted%20image%2020250429160908.png)

We are getting closer, but if we click the Save after making changes, we will get nothing except an error!

![](assets/Pasted%20image%2020250429161011.png)

We will fix this in the next step, when we (a) add the update method, and (b) edit the `UpdateChirpRequest`.
### Update Method & Update Chirp Request time

Before we look at the update Method, we want to remove the two requests that we will not be using.

> Aside:
> 
> Laravel has TWO main ways of validating data that is submitted via forms or APIs.
>
> - Method 1: Embed the validation code in the method
> - Method 2: Create a Request Class and add the validation instructions to this
> 
> The request class provides the validation via a `rules` method that returns an array of rules that will be applied to the data being sent via the request.
> 
> The request class also provides a method to verify that a particular user is allowed to perform an action (`authorize`).
> 
> Further Reading: [Laravel Validation](https://laravel.com/docs/validation)

#### Remove the Chirp Requests

Navigate to the `/app/Http/Requests` folder and delete the `Create` and `Update` requests as we are not using them in this application.

![](assets/phpstorm64_L3BQMctt98.gif)

#### Update the Chirp Controller's update method

Now we have removed the requests, let's update the Update method.

Open the `ChirpController` and locate the `update` method.

Modify the code below:

```php
public function update(UpdateChirpRequest $request, Chirp $chirp)  
{  
    //  
}
```

To be …

```php
public function update(Request $request, Chirp $chirp): RedirectResponse  
{  
  
    $validated = $request->validate([  
        'message' => [  
            'required',  
            'string',  
            'min:5',  
            'max:255',  
        ],  
    ]);  
  
    $chirp->update($validated);  
  
    return redirect(route('chirps.index'));  
}
```

Note the small change to the validation for the message?

Make sure the store has the same - a minimum length of chirp!

The `$chirp->update(…)` performs the update based on the validated data that is returned by the validation method call.

We then send the browser back to the chirps index page.

![](assets/vivaldi_a7LJoWDDza.gif)


Excellent the update is completed.

Now let's allow for deleting chirps.

# Delete Chirp

We can now update the pop-up menu and enable the delete.

Locate the code we just previously to the `index.blade.php` file and add the following code immediately after the `</x-dropdown-link>` and before the `</x-slot>`:

```php

<form method="POST"  
    action="{{ route('chirps.destroy', $chirp) }}">  
    @csrf  
    @method('delete')  
            
    <x-dropdown-link  
        :href="route('chirps.destroy',$chirp)"  
        onclick="event.preventDefault(); this.closest('form').submit();">  
        {{ __('Delete') }}  
    </x-dropdown-link>  
     
</form>  

```

Adding this creates the delete option int he droip down.

Immediately on saving the file you will find that if you refresh the browser there will be an error:

![](assets/Pasted%20image%2020250429163914.png)

So let's fox this by adding the required route to the `web.php` routes file.

Use SHIFT-SHIFT and open the web routes file.

In the chirps resourceful route, we will update the only to add `destroy`:

```php
->only(['index', 'store', 'edit', 'update', 'destroy',])
```

Save the file.

Refresh and everything is back. Clicking the action will now show the delete option.

Now we need to add the destroy code tot he Chirps Controller.

SHIFT-SHIFT and open the Chirps Controller.

Find the `destroy` method:

```php
public function destroy(Chirp $chirp)  
{  
    //  
}
```


Update it to include the following between the curly braces (`{` … `}`):
```php
$chirp->delete();  
return redirect(route('chirps.index'));
```

Ok we are ready to test the delete…

> ### ⚠️ NOTE: 
> 
> Once a message is deleted there is NO WAY BACK!

Ok, so the warning has been issued, so let's try deleting a chirp…

> You may want to create a test chirp and delete it, as shown in the animation below:

![](assets/vivaldi_RLbZay8OW4.gif)


Woohoo! We have a basic Twitter clone.

But there is more to come.

## Exercise

Just as a way to make sure you are working through these notes, we have a couple of exercises for you to complete:

### 1. Update the Application Logo

Locate the "Application Logo" blade file (Remember SHIFT-SHIFT).

Delete the SVG code.

Add:

```php
<i class="fa-solid fa-kiwi-bird mr-1 text-4xl"></i>
```

Save the file and close.

Refreshing should now give a Kiwi in place of the Laravel logo:

![](assets/Pasted%20image%2020250429165905.png)

Work out how to make the logo "brown" rather than grey, and update the application logo as required.

### 2. Replace Action with an Icon

In place of the "action" text we would like an icon.

Find the locations where the text "Action" is shown as a drop down button, and replace "Action" with a Font Awesome icon from the following:

- fa-kiwi-bird
- fa-drumstick-bite
- fa-bacon
- fa-play
- fa-pen-to-square
- fa-keyboard

![](assets/Pasted%20image%2020250429171417.png)

Also, make the icon have some padding either side to make it easier to click, and when hovered it needs to change colou8r and background. Here is an example using a 'plaster'. 

![](assets/vivaldi_yaqh6lditp.gif)



# Up Next

In the next part of the bootcamp we will … .

- [Laravel Boot Camp - Part 4](session-11/S10-Laravel-BootCamp-Part-4.md)
- [Session 11 ReadMe](session-11/ReadMe.md)
- [Session 11 Reflection Exercises & Study](session-11/S11-Reflection-Exercises-and-Study.md)




# END
