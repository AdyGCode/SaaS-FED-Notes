

# Continuing to build the Framework

So far we have created the helpers, the routes and the database configuration.

In this section we will look at the `public/index.php` file, and convert it from the current template file into a set of partials that will be stored in the `App/views/partials` folder..


## Public `index.php`

One of the most important files in our micro-framework is the front-facing 'index' file.

This file performs the actions of:
- loading the framework
- starting the session for the current site visitor
- getting the requested location from the server
- calling the router to direct the application flow

The file is hidden behind the use of our `.htaccess` file, so as far as the end user is concerned they have no idea it exists.

A request to `http://saas-vanilla-mvc.test/` actually is directed to `http://saas-vanilla-mvc.test/index.php` by the `.htaccess` file, and then this PHP file takes over.

> **Note:**
> 
> We have not provided the header DocBlock, that is for you to complete.

The code uses autoloading to first add the Router and Session files from the micro-framework.

It then starts the visitor's session.

It grabs the helper functions, and created a router object.

It then loads the routes, as defined in the `routes.php` file.

Next the request's URI is retrieved, before the routers is called to handle the requested URI path.

```php
require __DIR__ . '/../vendor/autoload.php';

use Framework\Router;
use Framework\Session;

Session::start();

require '../helpers.php';

// Instatiate the router
$router = new Router();

// Get routes
$routes = require basePath('routes.php');

// Get current URI and HTTP method
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

//echo password_hash("Password1",PASSWORD_DEFAULT);
//die;
// Route the request
$router->route($uri);

```

## Template HTML File

Download the [`template.php`](session-07/template.php) file we provide.

Copy/Move this into the `src` folder on the project so you have an easily accessed file.

We are ready to create the partials for the Application.

## Partials

The partials contain the common sections of pages such as Header, Footer and Navigation.

![](assets/Pasted%20image%2020240830162654.png)

Let's create each in turn.

### Header

In the `App/views/partials` folder create a new PHP file `header.view.php`.

Fill out the usual DocBlock comments as needed.

Then close the PHP tag `?>`.

Now Open the `template.php` file you have, and copy the section of code from `<!doctype html>` to `<body class="bg-white flex flex-col h-screen justify-between">` inclusive.

Go back to the header partial file and paste this code into the space after the `?>` close PHP tag.

Now we can do the navigation (and also the logo area).

### Navigation

As with the header, we create a new partial view and name it `navigation.view.php`.

Once you have done that, close the `?>` PHP tag, and then copy the section of the template code from `<header class="bg-black text-white p-4 flex-grow-0 flex flex-row align-middle content-center">` to `</header>`.

Paste this code after the close PHP tag.

Now the footer...

### Footer

We are on the last bit of the page partials, before we look at two new partials...

As before, create a new partial view and name it `footer.view.php`.

Go back to the template and locate the line `...` and select the code from there to the end of the file.

Add this code to the footer partial.

Edit the `<footer>`...`</footer>` content to be:
```html
<section class="w-1/2 p-8">  
    <p>&copy; Copyright 2024 YOUR_NAME. All rights reserved.</p>  
    <p class="text-xs">  
        Based on a <a href="https://github.com/AdyGCode/SaaS-FED-Notes/tree/main/session-07"  
                      class="text-zinc-500 hover:text-white underline">tutorial</a>  
        by <a href="https://adygcode.github.io"  
              class="text-zinc-500 hover:text-white">Adrian Gould</a> &  
        <a href="https://adygcode.github.io"  
           class="text-zinc-500 hover:text-red-700">North Metropolitan TAFE</a>  
    </p>    <p>License: MIT Open Source Licensing</p>  
</section>  
<section class="w-1/2 p-8 text-xs">  
    <ul>        <li><a href="#" class="text-zinc-500 hover:text-white">link 1</a></li>  
        <li><a href="#" class="text-zinc-500 hover:text-white">link 2</a></li>  
        <li><a href="#" class="text-zinc-500 hover:text-white">link 3</a></li>  
        <li><a href="#" class="text-zinc-500 hover:text-white">link 4</a></li>  
    </ul></section>
```

## New Partials

Ok now we are able to add our two new partials. The Errors partial is used to dispaly error messages suchas 404 on the site.

The message partial is used when we want to display a flash message on a page.

### Errors Partial

The errors partial is named `errors.view.php`. 

You are to complete the DocBlock at the start of the view, and then add the following code:

```php
if (isset($errors) && $errors !== null): ?>  
    <div class="flex w-full shadow-lg rounded-lg my-4">  
        <div class="bg-red-600 py-2 px-6 rounded-l-lg flex items-center">  
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="fill-current text-white" width="20"  
                 height="20">  
                <path fill-rule="evenodd"  
                      d="M4.47.22A.75.75 0 015 0h6a.75.75 0 01.53.22l4.25 4.25c.141.14.22.331.22.53v6a.75.75 0 01-.22.53l-4.25 4.25A.75.75 0 0111 16H5a.75.75 0 01-.53-.22L.22 11.53A.75.75 0 010 11V5a.75.75 0 01.22-.53L4.47.22zm.84 1.28L1.5 5.31v5.38l3.81 3.81h5.38l3.81-3.81V5.31L10.69 1.5H5.31zM8 4a.75.75 0 01.75.75v3.5a.75.75 0 01-1.5 0v-3.5A.75.75 0 018 4zm0 8a1 1 0 100-2 1 1 0 000 2z"></path>  
            </svg>        </div>        <div class="px-4 py-2 bg-white rounded-r-lg flex flex-col justify-between items-left w-full border border-l-transparent border-gray-200">  
            <?php  
            foreach ($errors as $error) : ?>  
  
                <p>  
                    <?= $error ?>  
                </p>  
            <?php  
            endforeach;  
            ?>  
        </div>  
    </div><?php  
endif;
```

This simply processes a list of errors that is sent to the partial, and adds them in an error 'message box'.

The error block is based on code from https://tailwindtemplates.io/templates?category=alert.


### Message Partial

The message partial is similar, but it actually uses the Session class to allow it to retrieve any flash messages and then display.

The code gets any success message from the session, and if one exists it shows the message in a green box.

Likewise for the error message, except a red box.


```php

use Framework\Session;

$successMessage = Session::getFlashMessage('success_message');
if ($successMessage !== null) : ?>
    <div class="flex w-full shadow-lg rounded-lg my-4">
        <div class="bg-green-600 py-2 px-6 rounded-l-lg flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="text-white fill-current" viewBox="0 0 16 16" width="20" height="20"><path fill-rule="evenodd" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>
        </div>
        <div class="px-4 py-2 bg-white rounded-r-lg flex justify-between items-center w-full border border-l-transparent border-gray-200">
            <?= $successMessage ?>
        </div>
    </div>
<?php
endif;

$errorMessage = Session::getFlashMessage('error_message');
if ($errorMessage !== null) : ?>
    <div class="flex w-full shadow-lg rounded-lg my-4">
        <div class="bg-red-600 py-2 px-6 rounded-l-lg flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" class="fill-current text-white" width="20" height="20"><path fill-rule="evenodd" d="M4.47.22A.75.75 0 015 0h6a.75.75 0 01.53.22l4.25 4.25c.141.14.22.331.22.53v6a.75.75 0 01-.22.53l-4.25 4.25A.75.75 0 0111 16H5a.75.75 0 01-.53-.22L.22 11.53A.75.75 0 010 11V5a.75.75 0 01.22-.53L4.47.22zm.84 1.28L1.5 5.31v5.38l3.81 3.81h5.38l3.81-3.81V5.31L10.69 1.5H5.31zM8 4a.75.75 0 01.75.75v3.5a.75.75 0 01-1.5 0v-3.5A.75.75 0 018 4zm0 8a1 1 0 100-2 1 1 0 000 2z"></path></svg>
        </div>
        <div class="px-4 py-2 bg-white rounded-r-lg flex justify-between items-center w-full border border-l-transparent border-gray-200">
            <?= $errorMessage ?>
        </div>
    </div>
<?php
endif;

```

The message blocks are based on code from https://tailwindtemplates.io/templates?category=alert.


next... [S07-Vanilla-PHP-MVC-Pt-6](session-06/S06-Vanilla-PHP-MVC-Pt-6.md)