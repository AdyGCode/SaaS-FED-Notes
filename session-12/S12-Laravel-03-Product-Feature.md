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
updated: 2024-10-09T17:22
---

# Laravel: 03 Product Feature

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

# Creating a Product Feature

A typical type of feature is a list of products, books, equipment, and so forth.

In this example we will create a product feature that:

- Allows users to Add, Edit, Delete, Browse and View products
- Stores product name, description, recommended price, and category.

For the time being we will store the category as a number that will refer to a category table.

We will create the category model, migration and seeder so we have data for use in the product.

## Before beginning

Before you begin, check you have completed [S11 Laravel 02 Category Feature](session-11/S11-Laravel-02-Category-Feature.md).

## Create stubs

We can fast track the creation of stubs for each of the required code components using:

```shell
php artisan make:model Product --all
```

## Create Product Model

Open the product model, and add the mass assignment fields:

```php
protected $fillable = [
	'name',
	'description', 
	'recommended_price', 
	'category_id',
];
```

## Create Product Migration

Open the product migration and add the definitions:

| field             | type       | size | other              |
| ----------------- | ---------- | ---- | ------------------ |
| name              | string     | 128  |                    |
| description       | text       |      | nullable           |
| recommended price | integer    |      | unsigned, nullable |
| category id       | foreign id |      | default 0          |

This equates to:

```php
$table->string('name', 128);  
$table->text('description')->nullable();  
$table->string('recommended_price')->integer()->nullable();  
$table->unsignedInteger('category_id')->default(0);
```


## Create Seed Data

Next we will create some seed data, and then add the seeder to the Database Seeder file.

We are going to do a bit of cheating, and import the seed data using a CSV file.

To do so, we need to add a helper function to the `DatabaseSeeder.php` file.

### Import CSV Function

Open the Database Seeder file, and add the following function ***inside*** the `run()` method:

```php
  
function import_CSV($filename, $delimiter = ','){  
    if(!file_exists($filename) || !is_readable($filename))  
        return false;  
    $header = null;  
    $data = array();  
    if (($handle = fopen($filename, 'r')) !== false){  
        while (($row = fgetcsv($handle, 1000, $delimiter)) !== false){  
            if(!$header)  
                $header = $row;  
            else  
                $data[] = array_combine($header, $row);  
        }  
        fclose($handle);  
    }  
    return $data;  
}
```

This function opens a file that is passed to the function, with the delimiter between the fields...

it then 

### The Product Seeder



```php

```




# END

Next up - ...
