---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testing, PEST
created: 2024-08-27T17:17
updated: 2024-12-04T14:25
---

# Session 20

- Review of Cluster
- Testing Your App Works
- Preparation for SaaS - Back End Development Cluster
## Review


## Testing your App Works

Check out the notes on testing your application works:
- [S20-How-To-Test-Your-App-Works](session-20/S20-How-To-Test-Your-App-Works.md)

## Automated Test Installer

The automated test installer is a scipt to ensure that your application is installable on a different computer.

It automatically executes items such as creating a new database, running composer and npm installs, and more.

It is a great way to make sure the application you submit is testable by the assessors.


## FontAwesome Icons Not Showing 

A common issue with apps is that 3rd party icon fonts etc are not loading.

For FontAwesome, the simplest fix is to refer to their basic CDN and include this as a link.

Edit your guest.blade.php and app.blade.php layouts and locate the line:

```html
 <!-- Fonts -->
<link rel="preconnect" href="https://fonts.bunny.net">
<link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />
```

Below the line with `href="https://fonts.bunny.net/` add:


```html
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="{{ url('all.css') }}">
```

Now download this small compressed file ([Zip](../assets/font-awesome-v6-free.zip) 
or [7Zip](../assets/font-awesome-v6-free.7z)), and extract the contents.

Move the `webfonts` folder and the `all.css` file into the `public` folder.

On refresh, you should now see the FontAwesome icons.


## Preparation for Stage 2 of SaaS - Back End Dev

We highly recommend that you practice the use of Laravel by looking at the following tutorials. Where possible we have selected free tutorials, but when this is not possible we indicate that it is paid access via a $ symbol.

> The college does NOT provide refunds for any courses that are suggested as good resources. They are the responsibility of the individual.

### YouTube Channels to Subscribe to

| Name           | Link to Channel                       |
| -------------- | ------------------------------------- |
| Laravel Daily  | https://www.youtube.com/@LaravelDaily |
| Laravel        | https://www.youtube.com/@LaravelPHP   |
| Code with Dary | https://www.youtube.com/@codewithdary |
### Laravel

| Title                                                | Link                                                                                             | Cost |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------ | ---- |
| Laravel 11 CRUD with Image Upload Tutorial<br>       | https://www.itsolutionstuff.com/post/laravel-11-crud-with-image-upload-tutorialexample.html      |      |
| How to Save JSON Data in Database in Laravel 11?<br> | https://www.itsolutionstuff.com/post/how-to-save-json-data-in-database-in-laravel-11example.html |      |
|                                                      |                                                                                                  |      |
|                                                      |                                                                                                  |      |

### APIs

| Title                                   | Link                                                                                                        | Cost |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ---- |
| Laravel API Course \| Learn Laravel API | https://www.youtube.com/watch?v=D29sUCaUJg0&list=PLFHz2csJcgk8kvwLWESQcfk1eAivQOjdN&ab_channel=CodeWithDary |      |
|                                         |                                                                                                             |      |
|                                         |                                                                                                             |      |

### Livewire

| Title                                                                  | Link                                                                                                      | Cost |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ---- |
| Livewire Basics                                                        | https://laracasts.com/series/livewire-basics                                                              | $    |
| Livewire 3 from Scratch                                                | https://laracasts.com/series/livewire-3-from-scratch                                                      | $    |
| Using Livewire with Laravel                                            | https://www.slingacademy.com/article/using-livewire-with-laravel-a-developers-guide/                      |      |
| Laravel 11 Livewire CRUD using Jetstream & Tailwind CSS                | https://www.itsolutionstuff.com/post/laravel-11-livewire-crud-using-jetstream-tailwind-cssexample.html    |      |
| Laravel 11 & Livewire 3 Blog Application                               | https://www.youtube.com/playlist?list=PLdj_kazFZvyz5saAng6TV6LEH0_2E2wPO                                  |      |
| Laravel 11 & Livewire 3: Mastering CRUD Operations \| Beginner’s Guide | https://abu-sayed.medium.com/laravel-11-livewire-3-mastering-crud-operations-beginners-guide-cc5f44a7b472 | $    |
| Laravel Livewire v3 Crash Course                                       | https://www.youtube.com/playlist?list=PLFHz2csJcgk-8bDC1CTsZa0boRmKss8Y8                                  |      |

### Other


| Title                                   | Link                                                                                | Cost |
| --------------------------------------- | ----------------------------------------------------------------------------------- | ---- |
| Learn PHP in 2020                       | https://www.youtube.com/watch?v=te3GnuhU6oQ&list=PLFHz2csJcgk_fFEWydZJLiXpc9nB1qfpi |      |
| Learn Laravel Jetstream                 | https://www.youtube.com/playlist?list=PLFHz2csJcgk8gx6nl6V7JY5eBIO-A6Spx            |      |
| Mastering Eloquent & Collection Methods | https://www.youtube.com/playlist?list=PLFHz2csJcgk-uM0GcLtuZxN8Myl5Ui1Zf            |      |

