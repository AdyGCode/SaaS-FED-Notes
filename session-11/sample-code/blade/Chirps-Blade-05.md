---
created: 2025-04-29T17:26
updated: 2025-05-01T11:50
tags: []
source: https://web.archive.org/web/20240927032922/https://bootcamp.laravel.com/blade/editing-chirps
author: 
---

# Laravel Bootcamp    


## **05.** Editing Chirps    


Let's add a feature that's missing from other popular bird-themed microblogging platforms — the ability to edit Chirps!    


## Routing    


First we will update our routes file to enable the `chirps.edit` and `chirps.update` routes for our resource controller. The `chirps.edit` route will display the form for editing a Chirp, while the `chirps.update` route will accept the data from the form and update the model:    


routes/web.php    


```    

<!-- Syntax highlighted by torchlight.dev --> <?php    


     ...    

 use App\Http\Controllers\ChirpController;    

 use App\Http\Controllers\ProfileController;    

 use Illuminate\Support\Facades\Route;    

 Route::get('/', function () {    

     return view('welcome');    

 });    

 Route::get('/dashboard', function () {    

     return view('dashboard');    

 })->middleware(['auth', 'verified'])->name('dashboard');    

 Route::middleware('auth')->group(function () {    

     Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');    

     Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');    

     Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');    

 });    

 Route::resource('chirps', ChirpController::class)    

-    ->only(['index', 'store'])    

+    ->only(['index', 'store', 'edit', 'update'])    

     ->middleware(['auth', 'verified']);    


     ...    

 require __DIR__.'/auth.php';    


```    


Our route table for this controller now looks like this:    


| Verb      | URI                    | Action | Route Name    |     |
| --------- | ---------------------- | ------ | ------------- | --- |
| GET       | `/chirps`              | index  | chirps.index  |     |
| POST      | `/chirps`              | store  | chirps.store  |     |
|           |                        |        |               |     |
| GET       | `/chirps/{chirp}/edit` | edit   | chirps.edit   |     |
| PUT/PATCH | `/chirps/{chirp}`      | update | chirps.update |     |


## Linking to the edit page    


Next, let's link our new `chirps.edit` route. We'll use the `x-dropdown` component that comes with Breeze, which we'll only display to the Chirp author. We'll also display an indication if a Chirp has been edited by comparing the Chirp's `created_at` date with its `updated_at` date:    


resources/views/chirps/index.blade.php    


```    

<!-- Syntax highlighted by torchlight.dev --> <x-app-layout>    

     <div class="max-w-2xl mx-auto p-4 sm:p-6 lg:p-8">    

         <form method="POST" action="{{ route('chirps.store') }}">    

             @csrf    

             <textarea    

                 name="message"    

                 placeholder="{{ __('What\'s on your mind?') }}"    

                 class="block w-full border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm"    

             >{{ old('message') }}</textarea>    

             <x-input-error :messages="$errors->get('message')" class="mt-2" />    

             <x-primary-button class="mt-4">{{ __('Chirp') }}</x-primary-button>    

         </form>    

         <div class="mt-6 bg-white shadow-sm rounded-lg divide-y">    

             @foreach ($chirps as $chirp)    

                 <div class="p-6 flex space-x-2">    

                     <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-600 -scale-x-100" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">    

                         <path stroke-linecap="round" stroke-linejoin="round" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />    

                     </svg>    

                     <div class="flex-1">    

                         <div class="flex justify-between items-center">    

                             <div>    

                                 <span class="text-gray-800">{{ $chirp->user->name }} 
    

                                 <small class="ml-2 text-sm text-gray-600">{{ $chirp->created_at->format('j M Y, g:i a') }}</small>    

+                                @unless ($chirp->created_at->eq($chirp->updated_at))    

+                                    <small class="text-sm text-gray-600"> &amp;middot; {{ __('edited') }}</small>    

+                                @endunless    

                             </div>    

+                            @if ($chirp->user->is(auth()->user()))    

+                                <x-dropdown>    

+                                    <x-slot name="trigger">    

+                                        <button>    

+                                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" viewBox="0 0 20 20" fill="currentColor">    

+                                                <path d="M6 10a2 2 0 11-4 0 2 2 0 014 0zM12 10a2 2 0 11-4 0 2 2 0 014 0zM16 12a2 2 0 100-4 2 2 0 000 4z" />    

+                                            </svg>    

+                                        </button>    

+                                    </x-slot>    

+                                    <x-slot name="content">    

+                                        <x-dropdown-link :href="route('chirps.edit', $chirp)">    

+                                            {{ __('Edit') }}    

+                                        </x-dropdown-link>    

+                                    </x-slot>    

+                                </x-dropdown>    

+                            @endif    

                         </div>    

                         <p class="mt-4 text-lg text-gray-900">{{ $chirp->message }}</p>    

                     </div>    

                 </div>    

             @endforeach    

         </div>    

     </div>    

 </x-app-layout>    


```    


## Creating the edit form    


Let's create a new Blade view with a form for editing a Chirp. This is similar to the form for creating Chirps, except we'll post to the `chirps.update` route and use the `@method` directive to specify that we're making a "PATCH" request. We'll also pre-populate the field with the existing Chirp message:    


resources/views/chirps/edit.blade.php    


```    

<!-- Syntax highlighted by torchlight.dev --><x-app-layout>    

    <div class="max-w-2xl mx-auto p-4 sm:p-6 lg:p-8">    

        <form method="POST" action="{{ route('chirps.update', $chirp) }}">    

            @csrf    

            @method('patch')    

            <textarea    

                name="message"    

                class="block w-full border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm"    

            >{{ old('message', $chirp->message) }}</textarea>    

            <x-input-error :messages="$errors->get('message')" class="mt-2" />    

            <div class="mt-4 space-x-2">    

                <x-primary-button>{{ __('Save') }}</x-primary-button>    

                <a href="{{ route('chirps.index') }}">{{ __('Cancel') }}</a>    

            </div>    

        </form>    

    </div>    

</x-app-layout>    


```    


## Updating our controller    


Let's update the `edit` method on our `ChirpController` to display our form. Laravel will automatically load the Chirp model from the database using [route model binding](https://web.archive.org/web/20240927032922/https://laravel.com/docs/9.x/routing#route-model-binding) so we can pass it straight to the view.    


We'll then update the `update` method to validate the request and update the database.    


Even though we're only displaying the edit button to the author of the Chirp, we still need to make sure the user accessing these routes is authorized:    


app/Http/Controllers/ChirpController.php    


```    

<!-- Syntax highlighted by torchlight.dev --> <?php    


     ...    

 namespace App\Http\Controllers;    

 use App\Models\Chirp;    

 use Illuminate\Http\RedirectResponse;    

 use Illuminate\Http\Request;    

 use Illuminate\Http\Response;    

+use Illuminate\Support\Facades\Gate;    

 use Illuminate\View\View;    

 class ChirpController extends Controller    

 {    


     ...    

     /**    

      * Display a listing of the resource.    

      */    

     public function index(): View    

     {    

         return view('chirps.index', [    

             'chirps' => Chirp::with('user')->latest()->get(),    

         ]);    

     }    

     /**    

      * Show the form for creating a new resource.    

      */    

     public function create()    

     {    

         //    

     }    

     /**    

      * Store a newly created resource in storage.    

      */    

     public function store(Request $request): RedirectResponse    

     {    

         $validated = $request->validate([    

             'message' => 'required|string|max:255',    

         ]);    

         $request->user()->chirps()->create($validated);    

         return redirect(route('chirps.index'));    

     }    

     /**    

      * Display the specified resource.    

      */    

     public function show(Chirp $chirp)    

     {    

         //    

     }    

     /**    

      * Show the form for editing the specified resource.    

      */    

-    public function edit(Chirp $chirp)    

+    public function edit(Chirp $chirp): View    

     {    

-        //    

+        Gate::authorize('update', $chirp);    

+        

+        return view('chirps.edit', [    

+            'chirp' => $chirp,    

+        ]);    

     }    

     /**    

      * Update the specified resource in storage.    

      */    

-    public function update(Request $request, Chirp $chirp)    

+    public function update(Request $request, Chirp $chirp): RedirectResponse    

     {    

-        //    

+        Gate::authorize('update', $chirp);    

+        

+        $validated = $request->validate([    

+            'message' => 'required|string|max:255',    

+        ]);    

+        

+        $chirp->update($validated);    

+        

+        return redirect(route('chirps.index'));    

     }    


     ...    

     /**    

      * Remove the specified resource from storage.    

      */    

     public function destroy(Chirp $chirp)    

     {    

         //    

     }    

 }    


```    


## Authorization    


By default, the `authorize` method will prevent _everyone_ from being able to update the Chirp. We can specify who is allowed to update it by creating a [Model Policy](https://web.archive.org/web/20240927032922/https://laravel.com/docs/authorization#creating-policies) with the following command:    


```shell
php artisan make:policy ChirpPolicy --model=Chirp    

```    


This will create a policy class at `app/Policies/ChirpPolicy.php` which we can update to specify that only the author is authorized to update a Chirp:    


app/Policies/ChirpPolicy.php    


```    

<!-- Syntax highlighted by torchlight.dev --> <?php    


     ...    

 namespace App\Policies;    

 use App\Models\Chirp;    

 use App\Models\User;    

 use Illuminate\Auth\Access\HandlesAuthorization;    

 class ChirpPolicy    

 {    


     ...    

     use HandlesAuthorization;    

     /**    

      * Determine whether the user can view any models.    

      */    

     public function viewAny(User $user): bool    

     {    

         //    

     }    

     /**    

      * Determine whether the user can view the model.    

      */    

     public function view(User $user, Chirp $chirp): bool    

     {    

         //    

     }    

     /**    

      * Determine whether the user can create models.    

      */    

     public function create(User $user): bool    

     {    

         //    

     }    

     /**    

      * Determine whether the user can update the model.    

      */    

     public function update(User $user, Chirp $chirp): bool    

     {    

-        //    

+        return $chirp->user()->is($user);    

     }    


     ...    

     /**    

      * Determine whether the user can delete the model.    

      */    

     public function delete(User $user, Chirp $chirp): bool    

     {    

         //    

     }    

     /**    

      * Determine whether the user can restore the model.    

      */    

     public function restore(User $user, Chirp $chirp): bool    

     {    

         //    

     }    

     /**    

      * Determine whether the user can permanently delete the model.    

      */    

     public function forceDelete(User $user, Chirp $chirp): bool    

     {    

         //    

     }    

 }    


```    


## Testing it out    


Time to test it out! Go ahead and edit a few Chirps using the dropdown menu. If you register another user account, you'll see that only the author of a Chirp can edit it.    


![An editted chirp](Laravel%20Bootcamp/chirp-editted-blade.png)    


[Continue to allow deleting of Chirps...](https://web.archive.org/web/20240927032922/https://bootcamp.laravel.com/blade/deleting-chirps)    

