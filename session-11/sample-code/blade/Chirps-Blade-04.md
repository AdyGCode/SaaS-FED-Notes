---
created: 2025-04-29T17:26:26 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20241221170529/https://bootcamp.laravel.com/blade/showing-chirps
author: 
updated: 2025-05-01T11:53
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **04.** Showing Chirps

In the previous step we added the ability to create Chirps, now we're ready to display them!

## Retrieving the Chirps

Let's update the `index` method on our `ChirpController` class to pass Chirps from every user to our index page:

app/Http/Controllers/ChirpController.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
&lt;?php 
</p><details><summary><p> 
  
 
 
  
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
</p></details><p> 
  
 
 
 
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
 
  
 
view 
 
( 
 
' 
 
chirps.index 
 
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
 
, 
 
  
 
[ 
</p><p> 
+ 
 
 
 
             
 
' 
 
chirps 
 
' 
 
  
 
=> 
 
  
 
Chirp 
 
:: 
 
with 
 
( 
 
' 
 
user 
 
' 
 
) 
 
-> 
 
latest 
 
() 
 
-> 
 
get 
 
(), 
</p><p> 
+ 
 
 
 
         
 
]); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
  
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
 
: 
 
  
 
RedirectResponse 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
$validated 
 
  
 
= 
 
  
 
$request 
 
-> 
 
validateWithBag 
 
( 
 
' 
 
store 
 
' 
 
, [ 
</p><p> 
  
 
 
 
             
 
' 
 
message 
 
' 
 
  
 
=> 
 
  
 
' 
 
required|string|max:255 
 
' 
 
, 
</p><p> 
  
 
 
 
        ]); 
</p><p> 
  
 
 
 
         
 
$request 
 
-> 
 
user 
 
() 
 
-> 
 
chirps 
 
() 
 
-> 
 
create 
 
( 
 
$validated 
 
); 
</p><p> 
  
 
 
 
         
 
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

Here we've used Eloquent's `with` method to [eager-load](https://web.archive.org/web/20241221170529/https://laravel.com/docs/eloquent-relationships#eager-loading) every Chirp's associated user. We've also used the `latest` scope to return the records in reverse-chronological order.

## Connecting users to Chirps

We've instructed Laravel to return the `user` relationship so that we can display the name of the Chirp's author. But, the Chirp's `user` relationship hasn't been defined yet. To fix this, let's add a new ["belongs to"](https://web.archive.org/web/20241221170529/https://laravel.com/docs/eloquent-relationships#one-to-many-inverse) relationship to our `Chirp` model:

app/Models/Chirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
&lt;?php 
</p><details><summary><p> 
  
 
 
  
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
+ 
 
 
 
use 
 
 Illuminate\Database\Eloquent\Relations\ 
 
BelongsTo 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
Chirp 
 
  
 
extends 
 
  
 
Model 
</p><p> 
  
 
 
 
{ 
</p><details><summary><p> 
  
 
 
  
... 
</p></summary><p> 
  
 
 
 
     
 
use 
 
  
 
HasFactory 
 
; 
</p><p> 
  
 
 
 
     
 
protected 
 
  
 
$fillable 
 
  
 
= 
 
 [ 
</p><p> 
  
 
 
 
         
 
' 
 
message 
 
' 
 
, 
</p><p> 
  
 
 
 
    ]; 
</p></details><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
user 
 
() 
 
: 
 
  
 
BelongsTo 
</p><p> 
+ 
 
 
 
    { 
</p><p> 
+ 
 
 
 
         
 
return 
 
  
 
$this 
 
-> 
 
belongsTo 
 
( 
 
User 
 
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

This relationship is the inverse of the "has many" relationship we created earlier on the `User` model.

## Updating our view

Next, let's update our `chirps.index` component to display the Chirps below our form:

resources/views/chirps/index.blade.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
&lt; 
 
x-app-layout 
 
> 
</p><p> 
  
 
     
 
&lt; 
 
div 
 
  
 
class 
 
= 
 
" 
 
max-w-2xl mx-auto p-4 sm:p-6 lg:p-8 
 
" 
 
> 
</p><p> 
  
 
         
 
&lt; 
 
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
 
> 
</p><p> 
  
 
             
 
@csrf 
</p><p> 
  
 
             
 
&lt; 
 
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
  
 
            >{{ 
 
  
 
old 
 
( 
 
' 
 
message 
 
' 
 
)  
 
}}&lt;/ 
 
textarea 
 
> 
</p><p> 
  
 
             
 
&lt; 
 
x-input-error 
 
  
 
:messages 
 
= 
 
" 
 
$errors->store->get('message') 
 
" 
 
  
 
class 
 
= 
 
" 
 
mt-2 
 
" 
 
 /> 
</p><p> 
  
 
             
 
&lt; 
 
x-primary-button 
 
  
 
class 
 
= 
 
" 
 
mt-4 
 
" 
 
>{{ 
 
  
 
__ 
 
( 
 
' 
 
Chirp 
 
' 
 
)  
 
}}&lt;/ 
 
x-primary-button 
 
> 
</p><p> 
  
 
         
 
&lt;/ 
 
form 
 
> 
</p><p> 
+ 
 
         
 
&lt; 
 
div 
 
  
 
class 
 
= 
 
" 
 
mt-6 bg-white shadow-sm rounded-lg divide-y 
 
" 
 
> 
</p><p> 
+ 
 
             
 
@foreach  
 
( 
 
$chirps 
 
  
 
as 
 
  
 
$chirp 
 
) 
</p><p> 
+ 
 
                 
 
&lt; 
 
div 
 
  
 
class 
 
= 
 
" 
 
p-6 flex space-x-2 
 
" 
 
> 
</p><p> 
+ 
 
                     
 
&lt; 
 
svg 
 
  
 
xmlns 
 
= 
 
" 
 
http://www.w3.org/2000/svg 
 
" 
 
  
 
class 
 
= 
 
" 
 
h-6 w-6 text-gray-600 -scale-x-100 
 
" 
 
  
 
fill 
 
= 
 
" 
 
none 
 
" 
 
  
 
viewBox 
 
= 
 
" 
 
0 0 24 24 
 
" 
 
  
 
stroke 
 
= 
 
" 
 
currentColor 
 
" 
 
  
 
stroke-width 
 
= 
 
" 
 
2 
 
" 
 
> 
</p><p> 
+ 
 
                         
 
&lt; 
 
path 
 
  
 
stroke-linecap 
 
= 
 
" 
 
round 
 
" 
 
  
 
stroke-linejoin 
 
= 
 
" 
 
round 
 
" 
 
  
 
d 
 
= 
 
" 
 
M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z 
 
" 
 
  
 
/> 
</p><p> 
+ 
 
                     
 
&lt;/ 
 
svg 
 
> 
</p><p> 
+ 
 
                     
 
&lt; 
 
div 
 
  
 
class 
 
= 
 
" 
 
flex-1 
 
" 
 
> 
</p><p> 
+ 
 
                         
 
&lt; 
 
div 
 
  
 
class 
 
= 
 
" 
 
flex justify-between items-center 
 
" 
 
> 
</p><p> 
+ 
 
                             
 
&lt; 
 
div 
 
> 
</p><p> 
+ 
 
                                 
 
&lt; 
 
span 
 
  
 
class 
 
= 
 
" 
 
text-gray-800 
 
" 
 
>{{ 
 
  
 
$chirp 
 
->user->name 
 
  
 
}}&lt;/ 
 
span 
 
> 
</p><p> 
+ 
 
                                 
 
&lt; 
 
small 
 
  
 
class 
 
= 
 
" 
 
ml-2 text-sm text-gray-600 
 
" 
 
>{{ 
 
  
 
$chirp 
 
->created_at-> 
 
format 
 
( 
 
' 
 
j M Y, g:i a 
 
' 
 
)  
 
}}&lt;/ 
 
small 
 
> 
</p><p> 
+ 
 
                             
 
&lt;/ 
 
div 
 
> 
</p><p> 
+ 
 
                         
 
&lt;/ 
 
div 
 
> 
</p><p> 
+ 
 
                         
 
&lt; 
 
p 
 
  
 
class 
 
= 
 
" 
 
mt-4 text-lg text-gray-900 
 
" 
 
>{{ 
 
  
 
$chirp 
 
->message 
 
  
 
}}&lt;/ 
 
p 
 
> 
</p><p> 
+ 
 
                     
 
&lt;/ 
 
div 
 
> 
</p><p> 
+ 
 
                 
 
&lt;/ 
 
div 
 
> 
</p><p> 
+ 
 
             
 
@endforeach 
</p><p> 
+ 
 
         
 
&lt;/ 
 
div 
 
> 
</p><p> 
  
 
     
 
&lt;/ 
 
div 
 
> 
</p><p> 
  
 
&lt;/ 
 
x-app-layout 
 
> 
</p>
```

Now take a look in your browser to see the message you Chirped earlier!

![Chirp listing](Laravel%20Bootcamp/chirp-index-blade.png)

Feel free to Chirp some more, or even register another account and start a conversation!

[Continue to allow editing of Chirps...](https://web.archive.org/web/20241221170529/https://bootcamp.laravel.com/blade/editing-chirps)
