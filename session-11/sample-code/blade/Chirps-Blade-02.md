---
created: 2025-04-29T17:25:39 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20250103202752/https://bootcamp.laravel.com/blade/installation
author: 
updated: 2025-05-01T11:50
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **02.** Installation

## Installing Laravel

### Quick Installation

If you have already [installed PHP and Composer on your local machine](https://web.archive.org/web/20250103202752/https://herd.laravel.com/), you may create a new Laravel project via Composer:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
composer  
 
create-project 
 
  
 
laravel/laravel 
 
  
 
chirper 
</p>
```

For simplicity, Composer's `create-project` command will automatically create a new SQLite database at `database/database.sqlite` to store your application's data. After the project has been created, start Laravel's local development server using Laravel Artisan's `serve` command:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
cd chirper 
</p><p> 
php artisan serve 
</p>
```

Once you have started the Artisan development server, your application will be accessible in your web browser at [http://localhost:8000](https://web.archive.org/web/20250103202752/http://localhost:8000/).

![A fresh Laravel installation](Laravel%20Bootcamp/fresh.png)

### Installation via Docker

If you do not have PHP installed locally, you may develop your application using [Laravel Sail](https://web.archive.org/web/20250103202752/https://laravel.com/docs/sail), a light-weight command-line interface for interacting with Laravel's default Docker development environment, which is compatible with all operating systems. Before we get started, make sure to install [Docker](https://web.archive.org/web/20250103202752/https://docs.docker.com/get-docker/) for your operating system. For alternative installation methods, check out our full [installation guide](https://web.archive.org/web/20250103202752/https://laravel.com/docs/installation).

The easiest way to install Laravel is using our `laravel.build` service, which will download and create a fresh Laravel application for you. Launch a terminal and run the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
curl  
 
-s 
 
  
 
" 
 
https://laravel.build/chirper 
 
" 
 
  
 
| 
 
 bash 
</p>
```

Sail installation may take several minutes while Sail's application containers are built on your local machine.

By default, the installer will pre-configure Laravel Sail with a number of useful services for your application, including a MySQL database server if you wish to use MySQL instead of SQLite. You may [customize the Sail services](https://web.archive.org/web/20250103202752/https://laravel.com/docs/installation#choosing-your-sail-services) if needed.

After the project has been created, you can navigate to the application directory and start Laravel Sail:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
cd 
 
  
 
chirper 
</p><p> 
./vendor/bin/sail  
 
up 
</p>
```

When developing applications using Sail, you may execute Artisan, NPM, and Composer commands via the Sail CLI instead of invoking them directly:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
./vendor/bin/sail  
 
php 
 
  
 
--version 
</p><p> 
./vendor/bin/sail  
 
artisan 
 
  
 
--version 
</p><p> 
./vendor/bin/sail </span> 
composer</span> 
 </span> 
--version</span></p><p> 
./vendor/bin/sail </span> 
npm</span> 
 </span> 
--version</span></p>
```

Once the application's Docker containers have started, you should run your application's [database migrations](https://web.archive.org/web/20250103202752/https://laravel.com/docs/migrations):

```
<!-- Syntax highlighted by torchlight.dev --><p> 
./vendor/bin/sail </span> 
artisan</span> 
 </span> 
migrate</span></p>
```

Finally, you can access the application in your web browser at: [http://localhost](https://web.archive.org/web/20250103202752/http://localhost/).

![A fresh Laravel installation](Laravel%20Bootcamp/fresh.png)

## Installing Laravel Breeze

Next, we will give your application a head-start by installing [Laravel Breeze](https://web.archive.org/web/20250103202752/https://laravel.com/docs/starter-kits#laravel-breeze), a minimal, simple implementation of all of Laravel's authentication features, including login, registration, password reset, email verification, and password confirmation. Once installed, you are welcome to customize the components to suit your needs.

Laravel Breeze offers several options for your view layer, including Blade templates, or [Vue](https://web.archive.org/web/20250103202752/https://vuejs.org/) and [React](https://web.archive.org/web/20250103202752/https://reactjs.org/) with [Inertia](https://web.archive.org/web/20250103202752/https://inertiajs.com/). For this tutorial, we'll be using Blade.

Open a new terminal in your `chirper` project directory and install your chosen stack with the given commands:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
composer </span> 
require</span> 
 </span> 
laravel/breeze</span> 
 </span> 
--dev</span></p><p> 
php </span> 
artisan</span> 
 </span> 
breeze:install</span> 
 </span> 
blade</span></p>
```

Breeze will install and configure your front-end dependencies for you, so we just need to start the Vite development server to automatically recompile our CSS and refresh the browser when we make changes to our Blade templates:

If you refresh your new Laravel application in the browser, you should now see a "Register" link at the top-right. Follow that to see the registration form provided by Laravel Breeze.

![Laravel registration page](Laravel%20Bootcamp/register.png)

Register yourself an account and log in!

[Continue to start creating Chirps...](https://web.archive.org/web/20250103202752/https://bootcamp.laravel.com/blade/creating-chirps)
