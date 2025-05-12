---
created: 2025-04-29T17:26:02 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20250103202746/https://bootcamp.laravel.com/blade/creating-chirps
author: 
updated: 2025-05-01T11:53
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **03.** Creating Chirps

You're now ready to start building your new application! Let's allow our users to post short messages called _Chirps_.

## Models, migrations, and controllers

To allow users to post Chirps, we will need to create models, migrations, and controllers. Let's explore each of these concepts a little deeper:

-   [Models](https://web.archive.org/web/20250103202746/https://laravel.com/docs/eloquent) provide a powerful and enjoyable interface for you to interact with the tables in your database.
-   [Migrations](https://web.archive.org/web/20250103202746/https://laravel.com/docs/migrations) allow you to easily create and modify the tables in your database. They ensure that the same database structure exists everywhere that your application runs.
-   [Controllers](https://web.archive.org/web/20250103202746/https://laravel.com/docs/controllers) are responsible for processing requests made to your application and returning a response.

Almost every feature you build will involve all of these pieces working together in harmony, so the `artisan make:model` command can create them all for you at once.

Let's create a model, migration, and resource controller for our Chirps with the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
php  
 
artisan 
 
  
 
make:model 
 
  
 
-mrc 
 
  
 
Chirp 
</p>
```

This command will create three files for you:

-   `app/Models/Chirp.php` - The Eloquent model.
-   `database/migrations/<timestamp>_create_chirps_table.php` - The database migration that will create your database table.
-   `app/Http/Controllers/ChirpController.php` - The HTTP controller that will take incoming requests and return responses.

## Routing

We will also need to create URLs for our controller. We can do this by adding "routes", which are managed in the `routes` directory of your project. Because we're using a resource controller, we can use a single `Route::resource()` statement to define all of the routes following a conventional URL structure.

To start with, we are going to enable two routes:

-   The `index` route will display our form and a listing of Chirps.
-   The `store` route will be used for saving new Chirps.

We are also going to place these routes behind two [middleware](https://web.archive.org/web/20250103202746/https://laravel.com/docs/middleware):

-   The `auth` middleware ensures that only logged-in users can access the route.
-   The `verified` middleware will be used if you decide to enable [email verification](https://web.archive.org/web/20250103202746/https://laravel.com/docs/verification).

routes/web.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 <?php 
</p><p> 
+ 
 
use 
 
 App\Http\Controllers\ 
 
ChirpController 
 
; 
</p><p> 
  
 
use 
 
 App\Http\Controllers\ 
 
ProfileController 
 
; 
</p><p> 
  
 
use 
 
 Illuminate\Support\Facades\ 
 
Route 
 
; 
</p><p> 
  
 
Route 
 
:: 
 
get 
 
( 
 
' 
 
/ 
 
' 
 
,  
 
function 
 
  
 
() 
 
 { 
</p><p> 
  
 
     
 
return 
 
  
 
view 
 
( 
 
' 
 
welcome 
 
' 
 
); 
</p><p> 
  
 
}); 
</p><p> 
  
 
Route 
 
:: 
 
get 
 
( 
 
' 
 
/dashboard 
 
' 
 
,  
 
function 
 
  
 
() 
 
 { 
</p><p> 
  
 
     
 
return 
 
  
 
view 
 
( 
 
' 
 
dashboard 
 
' 
 
); 
</p><p> 
  
 
}) 
 
-&gt; 
 
middleware 
 
([ 
 
' 
 
auth 
 
' 
 
,  
 
' 
 
verified 
 
' 
 
]) 
 
-&gt; 
 
name 
 
( 
 
' 
 
dashboard 
 
' 
 
); 
</p><p> 
  
 
Route 
 
:: 
 
middleware 
 
( 
 
' 
 
auth 
 
' 
 
) 
 
-&gt; 
 
group 
 
( 
 
function 
 
  
 
() 
 
 { 
</p><p> 
  
 
     
 
Route 
 
:: 
 
get 
 
( 
 
' 
 
/profile 
 
' 
 
, [ 
 
ProfileController 
 
:: 
 
class 
 
,  
 
' 
 
edit 
 
' 
 
]) 
 
-&gt; 
 
name 
 
( 
 
' 
 
profile.edit 
 
' 
 
); 
</p><p> 
  
 
     
 
Route 
 
:: 
 
patch 
 
( 
 
' 
 
/profile 
 
' 
 
, [ 
 
ProfileController 
 
:: 
 
class 
 
,  
 
' 
 
update 
 
' 
 
]) 
 
-&gt; 
 
name 
 
( 
 
' 
 
profile.update 
 
' 
 
); 
</p><p> 
  
 
     
 
Route 
 
:: 
 
delete 
 
( 
 
' 
 
/profile 
 
' 
 
, [ 
 
ProfileController 
 
:: 
 
class 
 
,  
 
' 
 
destroy 
 
' 
 
]) 
 
-&gt; 
 
name 
 
( 
 
' 
 
profile.destroy 
 
' 
 
); 
</p><p> 
  
 
}); 
</p><p> 
+ 
 
Route 
 
:: 
 
resource 
 
( 
 
' 
 
chirps 
 
' 
 
,  
 
ChirpController 
 
:: 
 
class 
 
) 
</p><p> 
+ 
 
     
 
-&gt; 
 
only 
 
([ 
 
' 
 
index 
 
' 
 
,  
 
' 
 
store 
 
' 
 
]) 
</p><p> 
+ 
 
     
 
-&gt; 
 
middleware 
 
([ 
 
' 
 
auth 
 
' 
 
,  
 
' 
 
verified 
 
' 
 
]); 
</p><p> 
  
 
require 
 
  
 
__DIR__ 
 
. 
 
' 
 
/auth.php 
 
' 
 
; 
</p>
```

This will create the following routes:

| Verb | URI | Action | Route Name |
| --- | --- | --- | --- |
| GET | `/chirps` | index | chirps.index |
| POST | `/chirps` | store | chirps.store |

Let's test our route and controller by returning a test message from the `index` method of our new `ChirpController` class:

app/Http/Controllers/ChirpController.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
namespace 
 
 App\Http\Controllers; 
</p><p> 
  
 
 
 
use 
 
 App\Models\ 
 
Chirp 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Http\ 
 
Request 
 
;  
</p></details><p> 
+ 
 
 
 
use 
 
 Illuminate\Http\ 
 
Response 
 
;  
</p><p> 
  
 
 
 
class 
 
  
 
ChirpController 
 
  
 
extends 
 
  
 
Controller 
</p><p> 
  
 
 
 
{ 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display a listing of the resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
- 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
index 
 
() 
</p><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
index 
 
() 
 
: 
 
  
 
Response 
 
  
</p><p> 
  
 
 
 
    { 
</p><p> 
- 
 
 
 
         
 
// 
</p><p> 
+ 
 
 
 
         
 
return 
 
  
 
response 
 
( 
 
' 
 
Hello, World! 
 
' 
 
); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for creating a new resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
create 
 
() 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Store a newly created resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
store 
 
( 
 
Request 
 
  
 
$request 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
show 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for editing the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
edit 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Update the specified resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
update 
 
( 
 
Request 
 
  
 
$request 
 
,  
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Remove the specified resource from storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
destroy 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
} 
</p>
```

If you are still logged in from earlier, you should see your message when navigating to [http://localhost:8000/chirps](https://web.archive.org/web/20250103202746/http://localhost:8000/chirps), or [http://localhost/chirps](https://web.archive.org/web/20250103202746/http://localhost/chirps) if you're using Sail!

## Blade

Not impressed yet? Let's update the `index` method of our `ChirpController` class to render a Blade view:

app/Http/Controllers/ChirpController.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
namespace 
 
 App\Http\Controllers; 
</p><p> 
  
 
 
 
use 
 
 App\Models\ 
 
Chirp 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Http\ 
 
Request 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Http\ 
 
Response 
 
; 
</p></details><p> 
+ 
 
 
 
use 
 
 Illuminate\View\ 
 
View 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
ChirpController 
 
  
 
extends 
 
  
 
Controller 
</p><p> 
  
 
 
 
{ 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display a listing of the resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
- 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
index 
 
() 
 
: 
 
  
 
Response 
</p><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
index 
 
() 
 
: 
 
  
 
View 
</p><p> 
  
 
 
 
    { 
</p><p> 
- 
 
 
 
         
 
return 
 
  
 
response 
 
( 
 
' 
 
Hello, World! 
 
' 
 
); 
</p><p> 
+ 
 
 
 
         
 
return 
 
  
 
view 
 
( 
 
' 
 
chirps.index 
 
' 
 
); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for creating a new resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
create 
 
() 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Store a newly created resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
store 
 
( 
 
Request 
 
  
 
$request 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
show 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for editing the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
edit 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Update the specified resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
update 
 
( 
 
Request 
 
  
 
$request 
 
,  
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Remove the specified resource from storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
destroy 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
} 
</p>
```

We can then create our Blade view template with a form for creating new Chirps:

resources/views/chirps/index.blade.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
 < 
 
x-app-layout 
 
&gt; 
</p><p> 
     
 
 < 
 
div 
 
  
 
class 
 
= 
 
" 
 
max-w-2xl mx-auto p-4 sm:p-6 lg:p-8 
 
" 
 
&gt; 
</p><p> 
         
 
 < 
 
form 
 
  
 
method 
 
= 
 
" 
 
POST 
 
" 
 
  
 
action 
 
= 
 
" 
 
{{ 
 
  
 
route 
 
( 
 
' 
 
chirps.store 
 
' 
 
) 
 
  
 
}} 
 
" 
 
&gt; 
</p><p> 
             
 
@csrf 
</p><p> 
             
 
 < 
 
textarea 
</p><p> 
                 
 
name 
 
= 
 
" 
 
message 
 
" 
</p><p> 
                 
 
placeholder 
 
= 
 
" 
 
{{ 
 
  
 
__ 
 
( 
 
' 
 
What 
 
\' 
 
s on your mind? 
 
' 
 
) 
 
  
 
}} 
 
" 
</p><p> 
                 
 
class 
 
= 
 
" 
 
block w-full border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm 
 
" 
</p><p> 
            &gt;{{ 
 
  
 
old 
 
( 
 
' 
 
message 
 
' 
 
)  
 
}} </ 
 
textarea 
 
&gt; 
</p><p> 
             
 
 < 
 
x-input-error 
 
  
 
:messages 
 
= 
 
" 
 
$errors-&gt;get('message') 
 
" 
 
  
 
class 
 
= 
 
" 
 
mt-2 
 
" 
 
 /&gt; 
</p><p> 
             
 
 < 
 
x-primary-button 
 
  
 
class 
 
= 
 
" 
 
mt-4 
 
" 
 
&gt;{{ 
 
  
 
__ 
 
( 
 
' 
 
Chirp 
 
' 
 
)  
 
}} </ 
 
x-primary-button 
 
&gt; 
</p><p> 
         
 
 </ 
 
form 
 
&gt; 
</p><p> 
     
 
 </ 
 
div 
 
&gt; 
</p><p> 
 </ 
 
x-app-layout 
 
&gt; 
</p>
```

That's it! Refresh the page in your browser to see your new form rendered in the default layout provided by Breeze!

![Chirp form](Laravel%20Bootcamp/chirp-form.png)

If your screenshot doesn't look quite like the above, you may need to stop and start the Vite development server for Tailwind to detect the CSS classes in the new file we just created.

From this point forward, any changes we make to our Blade templates will be automatically refreshed in the browser whenever the Vite development server is running via `npm run dev`.

## Navigation menu

Let's take a moment to add a link to the navigation menu provided by Breeze.

Update the `navigation.blade.php` component provided by Breeze to add a menu item for desktop screens:

resources/views/layouts/navigation.blade.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 < 
 
div 
 
  
 
class 
 
= 
 
" 
 
hidden space-x-8 sm:-my-px sm:ml-10 sm:flex 
 
" 
 
&gt; 
</p><p> 
  
 
     
 
 < 
 
x-nav-link 
 
  
 
:href 
 
= 
 
" 
 
route('dashboard') 
 
" 
 
  
 
:active 
 
= 
 
" 
 
request()-&gt;routeIs('dashboard') 
 
" 
 
&gt; 
</p><p> 
  
 
         
 
{{ 
 
  
 
__ 
 
( 
 
' 
 
Dashboard 
 
' 
 
)  
 
}} 
</p><p> 
  
 
     
 
 </ 
 
x-nav-link 
 
&gt; 
</p><p> 
+ 
 
     
 
 < 
 
x-nav-link 
 
  
 
:href 
 
= 
 
" 
 
route('chirps.index') 
 
" 
 
  
 
:active 
 
= 
 
" 
 
request()-&gt;routeIs('chirps.index') 
 
" 
 
&gt; 
</p><p> 
+ 
 
         
 
{{ 
 
  
 
__ 
 
( 
 
' 
 
Chirps 
 
' 
 
)  
 
}} 
</p><p> 
+ 
 
     
 
 </ 
 
x-nav-link 
 
&gt; 
</p><p> 
  
 
 </ 
 
div 
 
&gt; 
</p>
```

And also for mobile screens:

resources/views/layouts/navigation.blade.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 < 
 
div 
 
  
 
class 
 
= 
 
" 
 
pt-2 pb-3 space-y-1 
 
" 
 
&gt; 
</p><p> 
  
 
     
 
 < 
 
x-responsive-nav-link 
 
  
 
:href 
 
= 
 
" 
 
route('dashboard') 
 
" 
 
  
 
:active 
 
= 
 
" 
 
request()-&gt;routeIs('dashboard') 
 
" 
 
&gt; 
</p><p> 
  
 
         
 
{{ 
 
  
 
__ 
 
( 
 
' 
 
Dashboard 
 
' 
 
)  
 
}} 
</p><p> 
  
 
     
 
 </ 
 
x-responsive-nav-link 
 
&gt; 
</p><p> 
+ 
 
     
 
 < 
 
x-responsive-nav-link 
 
  
 
:href 
 
= 
 
" 
 
route('chirps.index') 
 
" 
 
  
 
:active 
 
= 
 
" 
 
request()-&gt;routeIs('chirps.index') 
 
" 
 
&gt; 
</p><p> 
+ 
 
         
 
{{ 
 
  
 
__ 
 
( 
 
' 
 
Chirps 
 
' 
 
)  
 
}} 
</p><p> 
+ 
 
     
 
 </ 
 
x-responsive-nav-link 
 
&gt; 
</p><p> 
  
 
 </ 
 
div 
 
&gt; 
</p>
```

## Saving the Chirp

Our form has been configured to post messages to the `chirps.store` route that we created earlier. Let's update the `store` method on our `ChirpController` class to validate the data and create a new Chirp:

app/Http/Controllers/ChirpController.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
namespace 
 
 App\Http\Controllers; 
</p><p> 
  
 
 
 
use 
 
 App\Models\ 
 
Chirp 
 
; 
</p></details><p> 
+ 
 
 
 
use 
 
 Illuminate\Http\ 
 
RedirectResponse 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Http\ 
 
Request 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Http\ 
 
Response 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\View\ 
 
View 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
ChirpController 
 
  
 
extends 
 
  
 
Controller 
</p><p> 
  
 
 
 
{ 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display a listing of the resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
index 
 
() 
 
: 
 
  
 
View 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
  
 
view 
 
( 
 
' 
 
chirps.index 
 
' 
 
); 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for creating a new resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
create 
 
() 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Store a newly created resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
- 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
store 
 
( 
 
Request 
 
  
 
$request 
 
) 
</p><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
store 
 
( 
 
Request 
 
  
 
$request 
 
) 
 
: 
 
  
 
RedirectResponse 
</p><p> 
  
 
 
 
    { 
</p><p> 
- 
 
 
 
         
 
// 
</p><p> 
+ 
 
 
 
         
 
$validated 
 
  
 
= 
 
  
 
$request 
 
-&gt; 
 
validate 
 
([ 
</p><p> 
+ 
 
 
 
             
 
' 
 
message 
 
' 
 
  
 
=&gt; 
 
  
 
' 
 
required|string|max:255 
 
' 
 
, 
</p><p> 
+ 
 
 
 
        ]); 
</p><p> 
+ 
 
 
&nbsp;</p><p> 
+ 
 
 
 
         
 
$request 
 
-&gt; 
 
user 
 
() 
 
-&gt; 
 
chirps 
 
() 
 
-&gt; 
 
create 
 
( 
 
$validated 
 
); 
</p><p> 
+ 
 
 
&nbsp;</p><p> 
+ 
 
 
 
         
 
return 
 
  
 
redirect 
 
( 
 
route 
 
( 
 
' 
 
chirps.index 
 
' 
 
)); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Display the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
show 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Show the form for editing the specified resource. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
edit 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Update the specified resource in storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
update 
 
( 
 
Request 
 
  
 
$request 
 
,  
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Remove the specified resource from storage. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
destroy 
 
( 
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
} 
</p>
```

We're using Laravel's powerful validation feature to ensure that the user provides a message and that it won't exceed the 255 character limit of the database column we'll be creating.

We're then creating a record that will belong to the logged in user by leveraging a `chirps` relationship. We will define that relationship soon.

Finally, we can return a redirect response to send users back to the `chirps.index` route.

## Creating a relationship

You may have noticed in the previous step that we called a `chirps` method on the `$request->user()` object. We need to create this method on our `User` model to define a ["has many"](https://web.archive.org/web/20250103202746/https://laravel.com/docs/eloquent-relationships#one-to-many) relationship:

app/Models/User.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
namespace 
 
 App\Models; 
</p><p> 
  
 
 
 
// 
 
 use Illuminate\Contracts\Auth\MustVerifyEmail; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Database\Eloquent\Factories\ 
 
HasFactory 
 
; 
</p></details><p> 
+ 
 
 
 
use 
 
 Illuminate\Database\Eloquent\Relations\ 
 
HasMany 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Foundation\Auth\ 
 
User 
 
  
 
as 
 
 Authenticatable; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Notifications\ 
 
Notifiable 
 
; 
</p><p> 
  
 
 
 
use 
 
 Laravel\Sanctum\ 
 
HasApiTokens 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
User 
 
  
 
extends 
 
  
 
Authenticatable 
</p><p> 
  
 
 
 
{ 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
use 
 
  
 
HasApiTokens 
 
,  
 
HasFactory 
 
,  
 
Notifiable 
 
; 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * The attributes that are mass assignable. 
</p><p> 
  
 
 
 
     * 
</p><p> 
  
 
 
 
     *  
 
@var 
 
  
 
array 
 
 < 
 
int 
 
, string&gt; 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
protected 
 
  
 
$fillable 
 
  
 
= 
 
 [ 
</p><p> 
  
 
 
 
         
 
' 
 
name 
 
' 
 
, 
</p><p> 
  
 
 
 
         
 
' 
 
email 
 
' 
 
, 
</p><p> 
  
 
 
 
         
 
' 
 
password 
 
' 
 
, 
</p><p> 
  
 
 
 
    ]; 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * The attributes that should be hidden for serialization. 
</p><p> 
  
 
 
 
     * 
</p><p> 
  
 
 
 
     *  
 
@var 
 
  
 
array 
 
 < 
 
int 
 
, string&gt; 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
protected 
 
  
 
$hidden 
 
  
 
= 
 
 [ 
</p><p> 
  
 
 
 
         
 
' 
 
password 
 
' 
 
, 
</p><p> 
  
 
 
 
         
 
' 
 
remember_token 
 
' 
 
, 
</p><p> 
  
 
 
 
    ]; 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Get the attributes that should be cast. 
</p><p> 
  
 
 
 
     * 
</p><p> 
  
 
 
 
     *  
 
@return 
 
  
 
array 
 
 < 
 
string 
 
, string&gt; 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
protected 
 
  
 
function 
 
  
 
casts 
 
() 
 
: 
 
  
 
array 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
 [ 
</p><p> 
  
 
 
 
             
 
' 
 
email_verified_at 
 
' 
 
  
 
=&gt; 
 
  
 
' 
 
datetime 
 
' 
 
, 
</p><p> 
  
 
 
 
             
 
' 
 
password 
 
' 
 
  
 
=&gt; 
 
  
 
' 
 
hashed 
 
' 
 
, 
</p><p> 
  
 
 
 
        ]; 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
chirps 
 
() 
 
: 
 
  
 
HasMany 
</p><p> 
+ 
 
 
 
    { 
</p><p> 
+ 
 
 
 
         
 
return 
 
  
 
$this 
 
-&gt; 
 
hasMany 
 
( 
 
Chirp 
 
:: 
 
class 
 
); 
</p><p> 
+ 
 
 
 
    } 
</p><p> 
  
 
 
 
} 
</p>
```

## Mass assignment protection

Passing all of the data from a request to your model can be risky. Imagine you have a page where users can edit their profiles. If you were to pass the entire request to the model, then a user could edit _any_ column they like, such as an `is_admin` column. This is called a [mass assignment vulnerability](https://web.archive.org/web/20250103202746/https://en.wikipedia.org/wiki/Mass_assignment_vulnerability).

Laravel protects you from accidentally doing this by blocking mass assignment by default. Mass assignment is very convenient though, as it prevents you from having to assign each attribute one-by-one. We can enable mass assignment for safe attributes by marking them as "fillable".

Let's add the `$fillable` property to our `Chirp` model to enable mass-assignment for the `message` attribute:

app/Models/Chirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
namespace 
 
 App\Models; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Database\Eloquent\Factories\ 
 
HasFactory 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Database\Eloquent\ 
 
Model 
 
; 
</p></details><p> 
  
 
 
 
class 
 
  
 
Chirp 
 
  
 
extends 
 
  
 
Model 
</p><p> 
  
 
 
 
{ 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
use 
 
  
 
HasFactory 
 
; 
</p></details><p> 
+ 
 
 
 
     
 
protected 
 
  
 
$fillable 
 
  
 
= 
 
 [ 
</p><p> 
+ 
 
 
 
         
 
' 
 
message 
 
' 
 
, 
</p><p> 
+ 
 
 
 
    ]; 
</p><p> 
  
 
 
 
} 
</p>
```

You can learn more about Laravel's mass assignment protection in the [documentation](https://web.archive.org/web/20250103202746/https://laravel.com/docs/eloquent#mass-assignment).

## Updating the migration

During the creation of the application, Laravel already applied the default migrations that are included in the `database/migrations` directory. You may inspect the current database structure by using the `php artisan db:show` and `php artisan db:table` commands:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
php  
 
artisan 
 
  
 
db:show 
</p><p> 
php  
 
artisan 
 
  
 
db:table 
 
  
 
users 
</p>
```

So, the only thing missing is extra columns in our database to store the relationship between a `Chirp` and its `User` and the message itself. Remember the database migration we created earlier? It's time to open that file to add some extra columns:

database/migrations/<timestamp>\_create\_chirps\_table.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
use 
 
 Illuminate\Database\Migrations\ 
 
Migration 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Database\Schema\ 
 
Blueprint 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Support\Facades\ 
 
Schema 
 
; 
</p></details><p> 
  
 
 
 
return 
 
  
 
new 
 
  
 
class 
 
  
 
extends 
 
  
 
Migration 
</p><p> 
  
 
 
 
{ 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Run the migrations. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
up 
 
() 
 
: 
 
  
 
void 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
Schema 
 
:: 
 
create 
 
( 
 
' 
 
chirps 
 
' 
 
,  
 
function 
 
  
 
( 
 
Blueprint 
 
  
 
$table 
 
) 
 
 { 
</p><p> 
  
 
 
 
             
 
$table 
 
-&gt; 
 
id 
 
(); 
</p><p> 
+ 
 
 
 
             
 
$table 
 
-&gt; 
 
foreignId 
 
( 
 
' 
 
user_id 
 
' 
 
) 
 
-&gt; 
 
constrained 
 
() 
 
-&gt; 
 
cascadeOnDelete 
 
(); 
</p><p> 
+ 
 
 
 
             
 
$table 
 
-&gt; 
 
string 
 
( 
 
' 
 
message 
 
' 
 
); 
</p><p> 
  
 
 
 
             
 
$table 
 
-&gt; 
 
timestamps 
 
(); 
</p><p> 
  
 
 
 
        }); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Reverse the migrations. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
down 
 
() 
 
: 
 
  
 
void 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
Schema 
 
:: 
 
dropIfExists 
 
( 
 
' 
 
chirps 
 
' 
 
); 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
}; 
</p>
```

We haven't migrated the database since we added this migration, so let's do it now:

## Testing it out

We're now ready to send a Chirp using the form we just created! We won't be able to see the result yet because we haven't displayed existing Chirps on the page.

![Chirp form](Laravel%20Bootcamp/chirp-form-filled.png)

If you leave the message field empty, or enter more than 255 characters, then you'll see the validation in action.

### Artisan Tinker

This is great time to learn about [Artisan Tinker](https://web.archive.org/web/20250103202746/https://laravel.com/docs/artisan#tinker), a _REPL_ ([Read-eval-print loop](https://web.archive.org/web/20250103202746/https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)) where you can execute arbitrary PHP code in your Laravel application.

In your console, start a new tinker session:

Next, execute the following code to display the Chirps in your database:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
=&gt; Illuminate\Database\Eloquent\Collection {#4512 
</p><p> 
     all: [ 
</p><p> 
       App\Models\Chirp {#4514 
</p><p> 
         id: 1, 
</p><p> 
         user_id: 1, 
</p><p> 
         message: "I'm building Chirper with Laravel!", 
</p><p> 
         created_at: "2022-08-24 13:37:00", 
</p><p> 
         updated_at: "2022-08-24 13:37:00", 
</p><p> 
       }, 
</p><p> 
     ], 
</p><p> 
   } 
</p>
```

You may exit Tinker by using the `exit` command, or by pressing Ctrl + c.

[Continue to start showing Chirps...](https://web.archive.org/web/20250103202746/https://bootcamp.laravel.com/blade/showing-chirps)
