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
created: 2024-09-20T11:17
updated: 2025-10-28T22:05
---

# Laravel Bootcamp: Part 15

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

# Laravel Bootcamp: Part 13


## Roles and Permissions Part 5

In this section, we continue with the administration/management front-end that allows
users with particular rights to perform management actions on data in the Chirp system.

We will:

- Build User Management Interface
- Determine Roles to use in Application
- Determine Permissions each Role will have
- Apply Roles & Permissions to Application (User Management)

## Before you start…

Have you completed (not just read):

- [Laravel v12 Bootcamp - Introducing Laravel](S11-Laravel-v12-Bootcamp-Part-00-Introducing-Laravel.md),
- [Laravel v12 Bootcamp - Part 1](S11-Laravel-v12-BootCamp-Part-01.md),
- [Laravel v12 Bootcamp - Part 2](S11-Laravel-v12-BootCamp-Part-02.md)
- [Laravel v12 Bootcamp - Part 3](S11-Laravel-v12-BootCamp-Part-03.md)
- [Laravel v12 Bootcamp - Part 4](S11-Laravel-v12-BootCamp-Part-04.md)
- [Laravel v12 Bootcamp - Part 5](S11-Laravel-v12-BootCamp-Part-05.md)
- [Laravel v12 Bootcamp - Part 6](S11-Laravel-v12-BootCamp-Part-06.md)
- [Laravel v12 Bootcamp - Part 7](S11-Laravel-v12-BootCamp-Part-07.md)
- [Laravel v12 Bootcamp - Part 8](S11-Laravel-v12-BootCamp-Part-08.md)
- [Laravel v12 Bootcamp - Part 9](S11-Laravel-v12-BootCamp-Part-09.md)
- [Laravel v12 Bootcamp - Part 10](S11-Laravel-v12-BootCamp-Part-10.md)
- [Laravel v12 Bootcamp - Part 11](S11-Laravel-v12-BootCamp-Part-11.md)
- [Laravel v12 Bootcamp - Part 12](S11-Laravel-v12-BootCamp-Part-12.md)
- [Laravel v12 Bootcamp - Part 13](S11-Laravel-v12-BootCamp-Part-13.md)
- [Laravel v12 Bootcamp - Part 14](S11-Laravel-v12-BootCamp-Part-14.md)

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you may
> only see parts of the application working.
>
> So if you get an error in the browser, it may be because there is something missing.
>
> Remember that code is available from the GitHub repository.

# Livewire and Roles & Permissions

When we add a role, we need to be able to add permissions... but also, when we edit a role we will want to change the permissions... how can we do this?

Livewire to the rescue!

## Create a Livewire Role Create And Edit Component

```shell
php artisan livewire:make RoleCreateAndEdit
```

Two files are created

- `App/Livewire/RoleCreateAndEdit.php`
- `Resources/Views/Livewire/role-create-and-edit.blade.php`


> TODO: Fix the search part of this component
> 
### Livewire "Component Controller"

```php
<?php  
  
namespace App\Livewire;  
  
use Illuminate\Support\Str;  
use Illuminate\Validation\Rule;  
use Illuminate\Validation\ValidationException;  
use Illuminate\View\View;  
use Livewire\Component;  
use Spatie\Permission\Models\Permission;  
use Spatie\Permission\Models\Role;  
  
class RoleCreateAndEdit extends Component  
{  
  
    public ?int $roleId = null; // null for create, set for edit  
    public string $roleName = '';  
    public array $availablePermissions = [];  
    public array $selectedPermissions = [];  
    public string $search = '';  
  
  
    public function mount(?int $roleId = null): void  
    {  
        $this->roleId = $roleId;  
        $this->availablePermissions = Permission::pluck('name')->toArray();  
  
        if ($roleId) {  
            $role = Role::findOrFail($roleId);  
            $this->roleName = $role->name;  
            $this->selectedPermissions = $role->permissions->pluck('name')->toArray();  
            $this->availablePermissions = array_diff($this->availablePermissions,  
                $this->selectedPermissions);  
        }  
    }  
  
    public function selectPermission($permission): void  
    {  
        $this->selectedPermissions[] = $permission;  
        $this->availablePermissions = array_diff($this->availablePermissions, [$permission]);  
    }  
  
    public function removePermission($permission): void  
    {  
        $this->availablePermissions[] = $permission;  
        $this->selectedPermissions = array_diff($this->selectedPermissions, [$permission]);  
    }  
  
    public function saveRole()  
    {  
        $normalizedName = Str::kebab($this->roleName);  
  
        $this->validate([  
            'roleName' => [  
                'required',  
                'min:5',  
                'max:64',  
                Rule::unique('roles', 'name')  
                    ->ignore($this->roleId)  
                    ->where(function ($query) use ($normalizedName) {  
                        return $query->where('name', $normalizedName);  
                    })  
  
            ]  
        ]);  
  
        try {  
            $role = $this->roleId  
                ? Role::findOrFail($this->roleId)  
                : Role::create(['name' => $this->roleName]);  
  
            $role->name = $normalizedName;  
            $role->save();  
            $role->syncPermissions($this->selectedPermissions);  
  
            $msg = $this->roleId ? 'updated' : 'created';  
            $roleName = $role->name;  
  
            flash()->success("Role $roleName $msg successfully!",  
                [  
                    'position' => 'top-center',  
                    'timeout' => 5000,  
                ],  
                "Role ".Str::title($msg));  
  
            return to_route('admin.roles.index');  
  
        } catch (ValidationException $e) {  
            flash()->error('Please fix the errors in the form.',  
                [  
                    'position' => 'top-center',  
                    'timeout' => 5000,  
                ],  
                'Role Creation Failed');  
            return null;  
        }  
    }  
  
  
    public function render(): View  
    {  
  
        $filteredPermissions = array_filter($this->availablePermissions,  
            function ($permission) {  
                return stripos($permission, $this->search) !== false;  
        });  
  
        return view('livewire.role-create-and-edit', [  
            'filteredPermissions' => $filteredPermissions,  
        ]);  
  
    }  
}

```


### Livewire "Component View"


```php
<div class="space-y-4 bg-gray-50 p-4 rounded">  
    <!-- Role Name -->  
    <div>  
        <label class="block font-bold mb-1">Role Name</label>  
        <input type="text" wire:model="roleName" class="border p-2 w-full">  
  
    @error('roleName')  
        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>  
    @enderror  
    </div>  
  
    <!-- Search Filter -->  
    <div>  
        <input type="text" wire:model="search"  
               placeholder="Search permissions..."  
               class="border p-2 w-full">  
    </div>  
  
    <div class="flex space-x-8">  
        <!-- Available Permissions -->  
        <div class="w-1/2 border p-4">  
            <h3 class="font-bold mb-2">Available Permissions</h3>  
            <ul class="grid grid-cols-3 gap-2">  
                @foreach($filteredPermissions as $permission)  
                    <li class="cursor-pointer border border-gray-300 rounded  
                                hover:bg-gray-200 bg-gray-50 p-1 "                        wire:click="selectPermission('{{ $permission }}')"  
                    >  
                        {{ Str::title($permission) }}  
                    </li>  
                @endforeach  
            </ul>  
        </div>  
  
        <!-- Selected Permissions -->  
        <div class="w-1/2 border p-4">  
            <h3 class="font-bold mb-2">Selected Permissions</h3>  
            <ul class="grid grid-cols-3 gap-2">  
                @foreach($selectedPermissions as $key => $permission)  
                    <li class="cursor-pointer border border-gray-300 rounded  
                             bg-green-100 hover:bg-gray-200 p-1"                        wire:click="removePermission('{{ $permission }}')"  
                    >  
                        {{ Str::title( $permission ) }}  
                    </li>  
                @endforeach  
            </ul>  
        </div>  
    </div>  
  
    <!-- Save Button -->  
    <div>  
  
        <x-primary-link-button wire:click="saveRole">  
            <i class="fa-solid fa-save pr-4"></i>  
            {{ $roleId ? __('Update Changes') : __('Save') }}  
        </x-primary-link-button>  
  
        <x-secondary-link-button href="{{route('admin.roles.index')}}">  
            <i class="fa-solid fa-cancel pr-4"></i>  
            {{ __('Cancel') }}  
        </x-secondary-link-button>  
  
    </div>  
  
</div>
```




# Conclusion

That's it, an example of applying roles and permissions to an application.

Hopefully you have enough information to be able to apply the principles to your code.

The last parts in this series will be adding our own 'twist' to the error pages, and other random ideas, hints and tips.


# TODO: Update Useful References and Tutorials

# References

- Xhepa, T. (2022, March 1). Spatie Laravel Permission. YouTube. http://www.youtube.com/playlist?list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js

# Up Next

- [Laravel v12 Bootcamp - Part 14](../
  session-11/S11-Laravel-v12-BootCamp-Part-14.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](S11-Reflection-Exercises-and-Study.md)

# END



Research
https://www.youtube.com/@codingoblin

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://laravel.com/docs/12.x/authorization#via-the-user-model

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://medium.com/@codeaxion77/supercharge-your-laravel-app-with-spatie-roles-and-permissions-f20fe02a8c75

https://spatie.be/docs/laravel-permission/v6/best-practices/using-policies

https://laravel.io/forum/set-permission-in-controller-when-using-spatiepermission

https://www.fundaofwebit.com/post/laravel-10-spatie-user-roles-and-permissions-tutorial

https://dev.to/varzoeaa/spatie-permissions-vs-laravel-policies-and-gates-handling-role-based-access-1bdn

https://magecomp.com/blog/manage-role-in-laravel-using-spatie-laravel-permission/

https://devpishon.hashnode.dev/streamline-role-based-access-control-with-spatie-laravel-permission

https://www.creative-tim.com/twcomponents/component/card-stats

https://tailwindcss.com/plus/ui-blocks/application-ui/data-display/stats

https://www.youtube.com/watch?v=cNrMdCXNml8&list=PL6tf8fRbavl3xuFIe4_i3TB4PZbtbx3Js&index=15

https://spatie.be/docs/laravel-permission/v6/basic-usage/blade-directives




https://www.fundaofwebit.com/post/laravel-policy-using-spatie-roles-and-permission-tutorial-step-by-step
