

# Continuing to build the Framework

So far we have created the helpers, the routes and the database configuration.

Now we need to add a controller that will handle errors such as 404 not found...

## The Error Controller

Create  a new PHP Class file in the `App/Controllers` folder called `ErrorController`.

This controller will handle two main errors:
- 404 Not Found
- 403 Unauthorised

It can easily be extended to include other errors as needed.

Before we create the class and methods we need a generalised error page.

## Error View

Create a new PHP file in the `views` folder.

In this page, you must firest update the header DocBlock to contain the usual information.

After the DocBlock add:

```php
  
loadPartial('header');  
loadPartial('navigation');
```

This will load the header and navigation partials ready for the page to be displayed.

Then close the PHP tag and add the following HTML/PHP code:

```php
    <section class="container mx-auto p-4 mt-4">
        <div class="px-8 py-6 bg-red-600 text-white flex justify-between rounded">
            <div class="flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-32 w-32 mr-6" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd"
                          d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z"
                          clip-rule="evenodd"/>
                </svg>
                <div class="flex flex-col items-left gap-4">
                    <p class="text-4xl font-bold ">
                        <?= $status ?>
                    </p>
                    <p class="text-2xl font-semibold ">
                        <?= $message ?>
                    </p>
                    <p>
                        <a class="underline underline-offset-2
                                  hover:text-black transition ease-in-out duration-500"
                           href="/products">Go Back To Products</a>
                    </p>
                </div>
            </div>

        </div>

    </section>
<?php

loadPartial('footer');
```

When used it will display a page similar to this:

![404 error being shown using the error view](../assets/Pasted%20image%2020240830174221.png)

## Not Found

The not found method takes a message string as an argument. 

It then makes the response code for the HTTP response equal to 404 before then loading the error view we created in the previous step.

```php
public static function notFound($message = 'Resource not found')  
{  
    http_response_code(404);  
  
    loadView('error', [  
        'status' => '404',  
        'message' => $message  
    ]);  
}
```

## Unauthorised

The unauthorised method takes care of showing the 403 page when a user tries to perform an action they are not authorised to do. 

In our little application that is like attempting to create a product when they are not logged in.

```php
public static function unauthorized($message = 'You are not authorized to view this resource')  
{  
    http_response_code(403);  
  
    loadView('error', [  
        'status' => '403',  
        'message' => $message  
    ]);  
}
```


### Mini Exercise

As usual you are charged with adding the relevant DocBlocks to the methods and updating the class DocBlock.


## The Home Controller & View

Before we start on the User and Product feature, we will add our home controller and view.

### Home Controller

Create a new PHP Class file in the `App/Controllers` folder, and name it `HomeController`.

In this class we need to add:

- A protected variable to hold the database connection
- A constructor to connect to the database
- An index method that retrieves the latest six products and sends them to the home view for display

### Database Property

The database property is simply `$db`.

```php
protected $db;
```

### Constructor method

The constructor has two steps:
- Store the configuration data in a `$config` variable
- Instantiate the Database class with the `$config` details.

```php
public function __construct()  
{  
    $config = require basePath('config/db.php');  
    $this->db = new Database($config);  
}
```


### Index method

Our index method does the following:
- Retrieve the last 6 added products
- Retrieve a count of all the products
- Retrieve a count of all the users
- Load the home view with the above data for display.

```php
$products = $this->db->query('SELECT * FROM products ORDER BY created_at DESC LIMIT 6')->fetchAll();  
  
$productCount = $this->db->query('SELECT count(id) as total FROM products ')->fetch();  
  
$userCount = $this->db->query('SELECT count(id) as total FROM users')->fetch();  
  
loadView('home', [  
    'products' => $products,  
    'productCount' => $productCount,  
    'userCount' => $userCount,  
]);
```


That's it for the controller.

Now the view.

### Home View

Like the error view, the home view is a HTML/PHP page that is in the `App/views` folder.

Create a new PHP file in the `App/views` and name it `home.view.php`.

Lets construct it from the top...

First update the DocBlock...

```php
/**
 * Home Page View
 *
 * Filename:        home.view.php
 * Location:        /App/views
 * Project:         SaaS-Vanilla-MVC
 * Date Created:    23/08/2024
 *
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>
 *
 */
```


Now include the header and navigation, just like the error page, before closing the PHP element.

```php
  
loadPartial('header');  
loadPartial('navigation');  
  
?>
```

Now we construct the main element of the page:

```php
<main class="container mx-auto bg-zinc-50 py-8 px-4 shadow shadow-black/25 rounded-b-lg">
    <article>
        <header class="bg-zinc-700 text-zinc-200 -mx-4 -mt-8 p-8 text-2xl font-bold mb-8">
            <h1>Vanilla PHP MVC Demo</h1>
        </header>
        <section class="flex flex-row flex-wrap justify-center my-8 gap-8">

<!-- there will be approximately 50 lines of code to add here -->


        </section>  
  
    </article>
</main>  
```

Finally at the end of the file we add:
```php
<?php  
loadPartial('footer');  
?>
```


This will render a very boring page with no products being displayed.

Let's fix that.

#### Add the User and Product Counts

Go back to the `<section class="flex...">` line and press enter so you have a blank line after it...

Add the following to create a "statistics card" with the total products on the site:

```php
<section class="w-1/4 bg-zinc-700 text-sky-300 shadow rounded p-2 flex flex-row">  
    <h4 class="flex-0 w-1/2 -ml-2 mr-6 bg-sky-800 text-white text-lg p-4 -my-2 rounded-l">  
        Products:  
    </h4>  
    <p class="grow text-4xl ml-6">  
        <?= $productCount->total ?>  
    </p>  
</section>
```

Then immediately after this add the same for the user count, but we change the base colour:

```php
<section class="w-1/4 bg-zinc-700 text-red-300 shadow rounded p-2 flex flex-row">  
    <h4 class="flex-0 w-1/2 -ml-2 mr-6 bg-red-800 text-white text-lg p-4 -my-2 rounded-l">  
        Users:  
    </h4>  
    <p class="grow text-4xl ml-6">  
        <?= $userCount->total ?>  
    </p>  
</section>
```

Here is an example of its output:

![](../assets/Pasted%20image%2020240830180600.png)

Ok, so that is the 'statistics' done.

#### Add the Product Cards

We now need to create a secondary section of the page, this time for the (maximum of) 6 products we are displaying.

Begin by closing the previous section and then creating a new section of the page:

```php
</section>  
  
<section class="flex flex-wrap gap-8 justify-center">
```

Now we need to work trhough the list of products that were sent from the controller to this view.

We use a `foreach` for this purpose.

```php
<?php  
foreach ($products as $product):  
    ?>  

<!-- HTML for the cards goes here -->

    <?php  
endforeach  
?>
```

So that is the loop, what about the HTML for the cards?

We will put each product into an article as it is probably the best fit from a semantic viewpoint...

Replace the HTML Comment (`<!-- HTML... -->`) in the code we just added with:
```php
<article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
    <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
	    <h4>
	        PRODUCT_NAME
        </h4>
    </header>
    <section class="flex-grow grid grid-cols-5">
	    <p class="ml-4 col-span-2">
	        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
		         alt="">
        </p>
        <p class="col-span-3 text-zinc-600">PRODUCT_DESCRIPTION</p>
    </section>
    <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm 
                   px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
	    <p>Price: $PRODUCT_PRICE</p>
	    <a href="/products/PRODUCT_ID"
           class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
            Details
        </a>
    </footer>
</article>
```

When you preview this by visiting the web page, you should no see something like this:

![](../assets/Pasted%20image%2020240830181741.png)

#### Adding the Product information

We are on the last step of this home page...

We need to replace the placeholder text such as PRODUCT ID with the relevant PHP code.

Use the table below to do this:

| Placeholder         | PHP Code to use                |
| ------------------- | ------------------------------ |
| PRODUCT DESCRIPTION | `<?= $product->description ?>` |
| PRODUCT ID          | `<?= $product->id ?>`          |
| PRODUCT NAME        | `<?= $product->name ?>`        |
| PRODUCT PRICE       | `<?= $product->price ?>`       |

We now get (one product shown):

![](../assets/Pasted%20image%2020240830182209.png)

#### What is the problem?

Do you notice a small problem?

How do you think you fix this?

Try fixing it to match this (one product shown):

![](../assets/Pasted%20image%2020240830182226.png)


and finally ... [S08-Vanilla-PHP-MVC-Pt-7](../session-08/S08-Vanilla-PHP-MVC-Pt-7.md)
