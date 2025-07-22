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
created: 2024-10-05T15:41
updated: 2025-07-22T16:25
---

# S12 Laravel 2 - Basics - Regions (States) Feature

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

# Terms

Please refer to the terms in [S12-Laravel-1-Basics-Planning-A-Feature](../session-12/S12-Laravel-1-Basics-Planning-A-Feature.md)

# Overview

In this section of notes we will be adding a Regions Feature.

This feature is primarily used to provide a lookup table for other features. We will also create a basic a management interface that will allow regions to be added, editing, deleted, searched and browsed.

In the context of this set of notes, a region is an autonomous subdivision of a country. Often called States, Counties, or similar.

# MVP Requirements

The MVP requirements for this feature are:

- An administrative user must be able to add regions to the system
- An administrative user must be able to mark a region as deleted
- An administrative user must be able to edit a region
- Any user must be able to use the regions data when filling out a form that required this data within the application
- An administrative user must be able to browse the regions data
- An administrative user must be able to search the regions data

At the moment, we will concentrate on providing the ability for **ANY** user to perform these actions, and in a later section we will add authentication, and then authorisation.

The data stored in the Regions table will be:

- ...

# Develop Feature

Let's start the development process.

- Create model
- Create migration
- Create factory
- Create seeder
- Create controller & views
	- Create method
	- Create view

## Create the Model

Begin by issuing the command:

php artisan make model Regions

Open the /app/Models/Regions.php file

Add the "mass assignment" fields:

```php
protected $fillable = [  
    'name',  
    'code',  
    'country_id',  
];
```

# END

Next up - [LINK TEXT](#)
