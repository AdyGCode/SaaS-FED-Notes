---
created: 2025-04-29T17:27:03 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20240926170349/https://bootcamp.laravel.com/blade/deleting-chirps
author: 
updated: 2025-05-01T11:58
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---

## **06.** Deleting Chirps

Sometimes no amount of editing can fix a message, so let's give our users the ability to delete
their Chirps.

Hopefully you're starting to get the hang of things now. We think you'll be impressed how
quickly we can add this feature.

## Routing

We'll start again by updating our routes to enable the `chirps.destroy` route:

routes/web.php

```php
<?php 
use  App\Http\Controllers\ChirpController; 
use App\Http\Controllers\ProfileController ; 
use Illuminate\Support\Facades\Route ;  Route::get('/'  ,   function     ()   {
 
           return     view  (  '  welcome  '  );
 
     });
 
     Route  ::  get  (  '  /dashboard  '  ,   function     ()   {
 
           return     view  (  '  dashboard  '  );
 
     })  ->  middleware  ([  '  auth  '  ])  ->  name  (  '  dashboard  '  );
 
     Route  ::  middleware  (  '  auth  '  )  ->  group  (  function     ()   {
 
           Route  ::  get  (  '  /profile  '  , [  ProfileController  ::  class  ,   '  edit  '  ])  ->  name  (  '  profile.edit  '  );
 
           Route  ::  patch  (  '  /profile  '  , [  ProfileController  ::  class  ,   '  update  '  ])  ->  name  (  '  profile.update  '  );
 
           Route  ::  delete  (  '  /profile  '  , [  ProfileController  ::  class  ,   '  destroy  '  ])  ->  name  (  '  profile.destroy  '  );
 
     });


     Route  ::  resource  (  '  chirps  '  ,   ChirpController  ::  class  )
 
-          ->  only  ([  '  index  '  ,   '  store  '  ,   '  edit  '  ,   '  update  '  ])
 
+          ->  only  ([  '  index  '  ,   '  store  '  ,   '  edit  '  ,   '  update  '  ,   '  destroy  '  ])
 
           ->  middleware  ([  '  auth  '  ,   '  verified  '  ]);
 
    
  
...

     require     __DIR__  .  '  /auth.php  '  ;

```

Our route table for this controller now looks like this:

| Verb      | URI                    | Action  | Route Name     |
|-----------|------------------------|---------|----------------|
| GET       | `/chirps`              | index   | chirps.index   |
| POST      | `/chirps`              | store   | chirps.store   |
| GET       | `/chirps/{chirp}/edit` | edit    | chirps.edit    |
| PUT/PATCH | `/chirps/{chirp}`      | update  | chirps.update  |
| DELETE    | `/chirps/{chirp}`      | destroy | chirps.destroy |

## Updating our controller

Now we can update the `destroy` method on our `ChirpController` class to perform the deletion
and return to the Chirp index:

app/Http/Controllers/ChirpController.php

```php


      <?php
 
    
  
...

     namespace   App\Http\Controllers; 

     use   App\Models\  Chirp  ;
 
     use   Illuminate\Http\  RedirectResponse  ;
 
     use   Illuminate\Http\  Request  ;
 
     use   Illuminate\Http\  Response  ;
 
     use   Illuminate\Support\Facades\  Gate  ;
 
     use   Illuminate\View\  View  ;


     class     ChirpController     extends     Controller
 
     {
 
    
  
...

           /**
          * Display a listing of the resource.
            */
 
           public     function     index  ()  :     View
         {
               return     view  (  '  chirps.index  '  ,     [
                   '  chirps  '     =>     Chirp  ::  with  (  '  user  '  )  ->  latest  ()  ->  get  (),
               ]);
 
         }
 
           /**
 
          * Show the form for creating a new resource.
 
            */
 
           public     function     create  ()
 
         {
 
               //
 
         }
 
           /**
 
          * Store a newly created resource in storage.
 
            */
 
           public     function     store  (  Request     $request  )  :     RedirectResponse
 
         {
 
               $validated     =     $request  ->  validate  ([
 
                   '  message  '     =>     '  required|string|max:255  '  ,
 
             ]);
 
               $request  ->  user  ()  ->  chirps  ()  ->  create  (  $validated  );
 
               return     redirect  (  route  (  '  chirps.index  '  ));
 
         }
 
           /**
 
          * Display the specified resource.
 
            */
 
           public     function     show  (  Chirp     $chirp  )
 
         {
 
               //
 
         }
 
           /**
 
          * Show the form for editing the specified resource.
 
            */
 
           public     function     edit  (  Chirp     $chirp  )  :     View
 
         {
 
               Gate  ::  authorize  (  '  update  '  ,   $chirp  );
 
               return     view  (  '  chirps.edit  '  ,     [
 
                   '  chirp  '     =>     $  chirp  ,
 
               ]);
 
         }
 
           /**
 
          * Update the specified resource in storage.
 
            */
 
           public     function     update  (  Request     $request  ,   Chirp     $chirp  )  :     RedirectResponse
 
         {
 
               Gate  ::  authorize  (  '  update  '  ,   $chirp  );
 
               $validated     =     $request  ->  validate  ([
 
                   '  message  '     =>     '  required|string|max:255  '  ,
 
             ]);
 
               $chirp  ->  update  (  $validated  );
 
               return     redirect  (  route  (  '  chirps.index  '  ));
 
         }


           /**
 
          * Remove the specified resource from storage.
 
            */
 
-          public     function     destroy  (  Chirp     $chirp  )
 
+          public     function     destroy  (  Chirp     $chirp  )  :     RedirectResponse
 
         {
 
-              //
 
+              Gate  ::  authorize  (  '  delete  '  ,   $chirp  );
 
+   
 
+              $chirp  ->  delete  ();
 
+   
 
+              return     redirect  (  route  (  '  chirps.index  '  ));
 
         }
 
     } 
</p>
```

## Authorization

As with editing, we only want our Chirp authors to be able to delete their Chirps, so let's
update the `delete` method in our `ChirpPolicy` class:

app/Policies/ChirpPolicy.php

```php


      <?php
 
    
  
...

     namespace   App\Policies;
 
     use   App\Models\  Chirp  ;
 
     use   App\Models\  User  ;
 
     use   Illuminate\Auth\Access\  HandlesAuthorization  ;


     class     ChirpPolicy
 
     {
 
    
  
...

           use     HandlesAuthorization  ;
 
           /**
 
          * Determine whether the user can view any models.
 
            */
 
           public     function     viewAny  (  User     $user  )  :     bool
 
         {
 
               //
 
         }
 
           /**
 
          * Determine whether the user can view the model.
 
            */
 
           public     function     view  (  User     $user  ,   Chirp     $chirp  )  :     bool
 
         {
 
               //
 
         }
 
           /**
 
          * Determine whether the user can create models.
 
            */
 
           public     function     create  (  User     $user  )  :     bool
 
         {
 
               //
 
         }
 
           /**
 
          * Determine whether the user can update the model.
 
            */
 
           public     function     update  (  User     $user  ,   Chirp     $chirp  )  :     bool
 
         {
 
               return     $chirp  ->  user  ()  ->  is  (  $user  );
 
         }


           /**
 
          * Determine whether the user can delete the model.
 
            */
 
           public     function     delete  (  User     $user  ,   Chirp     $chirp  )  :     bool
 
         {
 
-              //
 
+              return     $this  ->  update  (  $user  ,   $chirp  );
 
         }
 
    
  
...

           /**
 
          * Determine whether the user can restore the model.
 
            */
 
           public     function     restore  (  User     $user  ,   Chirp     $chirp  )  :     bool
 
         {
 
               //
 
         }
 
           /**
 
          * Determine whether the user can permanently delete the model.
 
            */
 
           public     function     forceDelete  (  User     $user  ,   Chirp     $chirp  )  :     bool
 
         {
 
               //
 
         }


     } 
</p>
```

Rather than repeating the logic from the `update` method, we can define the same logic by
calling the `update` method from our `delete` method. Anyone that is authorized to update a
Chirp will now be authorized to delete it as well.

## Updating our view

Finally, we can add a delete button to the dropdown menu we created earlier in our
`chirps.index` view:

resources/views/chirps/index.blade.php

```php


    <  x-app-layout  >
 
          <  div     class  =  "  max-w-2xl mx-auto p-4 sm:p-6 lg:p-8  "  >
 
              <  form     method  =  "  POST  "     action  =  "  {{     route  (  '  chirps.store  '  )     }}  "  >
 
                 @csrf
 
                  <  textarea
 
                     name  =  "  message  "
 
                     placeholder  =  "  {{     __  (  '  What  \'  s on your mind?  '  )     }}  "
 
                     class  =  "  block w-full border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm  "
 
               >{{     old  (  '  message  '  )   }} </  textarea  >
 
                  <  x-input-error     :messages  =  "  $errors->get('message')  "     class  =  "  mt-2  "   />
 
                  <  x-primary-button     class  =  "  mt-4  "  >{{     __  (  '  Chirp  '  )   }} </  x-primary-button  >
 
              </  form  >
 
              <  div     class  =  "  mt-6 bg-white shadow-sm rounded-lg divide-y  "  >
 
                 @foreach   (  $chirps     as     $chirp  )
 
                      <  div     class  =  "  p-6 flex space-x-2  "  >
 
                          <  svg     xmlns  =  "  http://www.w3.org/2000/svg  "     class  =  "  h-6 w-6 text-gray-600 -scale-x-100  "     fill  =  "  none  "     viewBox  =  "  0 0 24 24  "     stroke  =  "  currentColor  "     stroke-width  =  "  2  "  >
 
                              <  path     stroke-linecap  =  "  round  "     stroke-linejoin  =  "  round  "     d  =  "  M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z  "     />
 
                          </  svg  >
 
                          <  div     class  =  "  flex-1  "  >
 
                              <  div     class  =  "  flex justify-between items-center  "  >
 
                                  <  div  >
 
                                      <  span     class  =  "  text-gray-800  "  >{{     $chirp  ->user->name     }} </  span  >
 
                                      <  small     class  =  "  ml-2 text-sm text-gray-600  "  >{{     $chirp  ->created_at->  format  (  '  j M Y, g:i a  '  )   }} </  small  >
 
                                     @unless   (  $chirp  ->created_at->  eq  (  $chirp  ->updated_at  ))
 
                                          <  small     class  =  "  text-sm text-gray-600  "  >     &amp;middot;     {{     __  (  '  edited  '  )   }} </  small  >
 
                                     @endunless
 
                                  </  div  >
 
                                 @if   (  $chirp  ->user->  is  (  auth  ()  ->  user  ()))
 
                                      <  x-dropdown  >
 
                                          <  x-slot     name  =  "  trigger  "  >
 
                                              <  button  >
 
                                                  <  svg     xmlns  =  "  http://www.w3.org/2000/svg  "     class  =  "  h-4 w-4 text-gray-400  "     viewBox  =  "  0 0 20 20  "     fill  =  "  currentColor  "  >
 
                                                      <  path     d  =  "  M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z  "     />
 
                                                  </  svg  >
 
                                              </  button  >
 
                                          </  x-slot  >
 
                                          <  x-slot     name  =  "  content  "  >
 
                                              <  x-dropdown-link     :href  =  "  route('chirps.edit', $chirp)  "  >
 
                                                 {{     __  (  '  Edit  '  )   }}
 
                                              </  x-dropdown-link  >
 
+                                             <  form     method  =  "  POST  "     action  =  "  {{     route  (  '  chirps.destroy  '  ,     $  chirp  )     }}  "  >
 
+                                                @csrf
 
+                                                @method  (  '  delete  '  )
 
+                                                 <  x-dropdown-link     :href  =  "  route('chirps.destroy', $chirp)  "     onclick  =  "  event  .  preventDefault  ()  ;   this  .  closest  (  '  form  '  )  .  submit  ()  ;  "  >
 
+                                                    {{     __  (  '  Delete  '  )   }}
 
+                                                 </  x-dropdown-link  >
 
+                                             </  form  >
 
                                          </  x-slot  >
 
                                      </  x-dropdown  >
 
                                 @endif
 
                              </  div  >
 
                              <  p     class  =  "  mt-4 text-lg text-gray-900  "  >{{     $chirp  ->message     }} </  p  >
 
                          </  div  >
 
                      </  div  >
 
                 @endforeach
 
              </  div  >
 
          </  div  >
 
    </  x-app-layout  > 
</p>
```

## Testing it out

If you Chirped anything you weren't happy with, try deleting it!

![Deleting a chirp](Laravel%20Bootcamp/chirp-delete-blade.png)

[Continue to notifications & events...](https://web.archive.org/web/20240926170349/https://bootcamp.laravel.com/blade/notifications-and-events)
