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
created: 2024-10-08T10:54
updated: 2024-10-08T18:26
---

# Laravel: 03 Category Feature

## Software as a Service - Front-End Development

### Session 12

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

# Category Feature

We will add a category feature to the application.

This section is based on [Laravel Category Treeview Hierarchical Structure Example](https://www.itsolutionstuff.com/post/laravel-5-category-treeview-hierarchical-structure-example-with-demoexample.html), without the jQuery enhancement.

The category feature may be used in many situations. For example, for a market place where it is the product category; or a blog where the category is the general subject of the blog post.

We will store the following in our category model:

- category name
- description (optional)
- parent category id (defaults to 0)

This structure allows us to do the following:

```text
+---PHP
|   |
|   +---Framework
|   |   |
|   |   +- Laravel
|   |   +- Symfony
|   |   +- Yii
|   | 
|   +---Update   
|
+---C
+---Python

```

## Model, Migration, Seeder, Controller in one

Let's start by creating the Category model, but also create the migration, seeder, controller and other stubs at the same time.

```shell
php artisan make:model Category --all
```

One this is run we will have the following stub files:

- `app\Models\Category.php`
- `database\factories\CategoryFactory.php`
- `database\migrations\2024_10_08_155638_create_categories_table.php`
- `database\seeders\CategorySeeder.php`
- `app\Http\Requests\StoreCategoryRequest.php`
- `app\Http\Requests\UpdateCategoryRequest.php`
- `app\Http\Controllers\CategoryController.php`
- `app\Policies\CategoryPolicy.php`

We will start with the migration.

## Add Migration Details

Locate the migration file and add the following:

```php
$table->string('name');  
$table->string('description');  
$table->foreignId('category_id')->default(0);
```


### Add Fillable fields to Model

Open the Category model and update the fillable property to include:

- title
- description
- category id

```php
public $fillable = [  
    'name',
    'description',
    'category_id'
];
```

### Create relationship in Model

Now in the model we add the following that tells the category that it has one or more sub-categories.

```php
public function subCategories() {  
    return $this->hasMany(Category::class, 'category_id','id');  
}
```

### Create Seed Data

We will use the data presented earlier for our test.



### Add Routes

Open the `web.php` routes file.

Add the following:

```php
Route::resource('/categories', CategoryContrller::class)  
    ->only(['index','store']);
```


### Add Index and Store methods to Controller

Open the `CategoryController.php` file and update the stubs for index and store:

#### index method

```php

```

# END

Next up - [LINK TEXT](#)
