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
created: 2024-09-20T11:17
updated: 2025-05-23T11:12
---


# S10 Laravel Bootcamp: Part 8

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

# Laravel Bootcamp: Part 8

There are a couple of minor issues to fix from [the previous part of this tutorial](../session-11/S10-Laravel-v12-BootCamp-part-7).

This short set of notes helps provide solutions.


## Before you start…

Have you completed (not just read):

- [Laravel v12 Bootcamp - Introducing Laravel](../session-11/S11-Introducing-Laravel-v12.md),
- [Laravel v12 Bootcamp - Part 1](../session-11/S10-Laravel-v12-BootCamp-Part-1.md),
- [Laravel v12 Bootcamp - Part 2](../session-11/S10-Laravel-v12-BootCamp-Part-2.md)
- [Laravel v12 Bootcamp - Part 3](../session-11/S10-Laravel-v12-BootCamp-Part-3.md)
- [Laravel v12 Bootcamp - Part 4](../session-11/S10-Laravel-v12-BootCamp-Part-4.md)
- [Laravel v12 Bootcamp - Part 5](../session-11/S10-Laravel-v12-BootCamp-Part-5.md)
- [Laravel v12 Bootcamp - Part 6](../session-11/S10-Laravel-v12-BootCamp-Part-6.md)
- [Laravel v12 Bootcamp - Part 7](../session-11/S10-Laravel-v12-BootCamp-Part-7.md)

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you will
> only see parts of the application working when a stage is complete.
>
> So if you get an error in the browser, it may be because there is something missing.


# Pagination, Search and Data

At the end of the previous part, we had a small issue in the way that when we paginated results after searching, when we went to any other page of results we lost the search filter.

To correct this we need to make a couple of tweaks.

But before that, we want to show you an alternative way to send data to the view.

## Sending Data to Views

Laravel, like any good framework, is robust, flexible and always looking to improve.

To date we have shown that you are able to return a view using code like this:

```php
return view('users.index', 
            compact(['users', 'search',]);
```

This is not the only way.

In fact you can also use the `->with()` method to say you want to send the specified data *with* the view.

Here is an example:

```php
return view('users.index')  
    ->with('users', $users)  
    ->with('search', $search);
```

In some ways you may find the latter clearer as far as readability is concerned.

## Fixing the pagination and search

To fix the search we need to send data to the pagination method to get it to add data to the end of its links.

We do this using `->appends()`.

Find the `$users = User::whereAny(...)` statement in the index method and update it to read:

```php
$users = User::whereAny(  
    ['name', 'email', 'position',], 'LIKE', "%$search%")  
    ->paginate(10)  
    ->appends(['search' => $search]);
```

We still have the pagination, but we tell it to append the search argument to the URLs that are produced.

The URLs now look like this: `http://localhost:8000/users?search=user&page=1` where the search term is `user` and we are wanting to go to page `1`.

A much lesser part of the fix is making sure you pass the search term onto the page to allow it to be filled in the search form. We had already completed that in the previous part of the tutorial.



# References

- Laravel Bootcamp - Learn the PHP Framework for Web Artisans - 07 Notifications & Events. (
  2025).
  Archive.org. https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/blade/notifications-and-events

# Up Next

- [Laravel v12 Bootcamp - Part 9](../session-11/S10-Laravel-v12-BootCamp-Part-9.md)
- [Session 11 ReadMe](../session-10/ReadMe%201.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
