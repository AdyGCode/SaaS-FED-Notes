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
updated: 2024-10-22T08:14
---

# S10 Introducing Laravel

## Software as a Service - Back-End Development

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

# Introducing Laravel

https://laravel.com/docs/11.x#meet-laravel

For those who missed the in class tutorial, follow the Laravel Bootcamp:
- Build Chirper with Blade https://bootcamp.laravel.com


## How to Use Laravel

We can develop and run Laravel applications in a number of ways:
- Local PHP & Composer installation (eg via Laragon, Xampp, Mamp, Herd, etc)
- Docker based installer
- Valet
- ...

## Before you Begin

Make sure you have the following installed:

- Laragon 6 with updates to:
	- Apache 2.4.62 or later (very important)
	- PHP 8.2 or later (8.3 preferred)
	- NodeJS 18 or later (Node 20 LTS, or Node 22 or later preferred)
	- Composer 2.4 or later
	- NPM 8.18 or later
- MailPit  (for mail debugging)
- Windows Terminal (for CLI) with the BASH CLI

Information on updating Laragon to these versions is available at the:

- [ScreenCraft Help Desk](https://help.screencraft.net.au/hc/2680392001) 

Any FAQs that refer to Laragon may be found using this HelpDesk link to

- [Search for Laragon Articles](https://help.screencraft.net.au/hc/2680392001/search?q=laragon)

Some useful Direct Links:

- [Add a new version of PHP to Laragon?](https://help.screencraft.net.au/hc/2680392001/67/add-a-new-version-of-php-to-laragon) 
- [Update the Apache web server in Laragon](https://help.screencraft.net.au/hc/2680392001/68/update-the-apache-web-server-in-laragon)
- [Install and Run MailPit?](https://help.screencraft.net.au/hc/2680392001/69/install-and-run-mailpit)
- [Update NodeJS (and NPM) in Laragon](https://help.screencraft.net.au/hc/2680392001/84/update-nodejs-and-npm-in-laragon)
- Adding xDebug to PHP

### Use Bash CLI

We also **strongly** recommend using the Git **Bash Shell** with the MS Terminal as this provides a CLI experience that is transferrable to Linux and MacOS.

For details on configuring this, and adding some CLI shortcut aliases see:

- [Add Git Bash to Microsoft Terminal](https://help.screencraft.net.au/hc/2680392001/65/add-git-bash-to-microsoft-terminal)
- [Add or Update Bash Command Line Aliases for Git, Laravel, and more](https://help.screencraft.net.au/hc/2680392001/66/add-bash-command-line-aliases-for-git)


### Point Laragon "Root Path" to Source Repos

You will also be working in a Source Repos folder, so we recommend pointing Laragon's web services to this folder.

- [Change the Laragon Web Root Folder](https://help.screencraft.net.au/hc/2680392001/61/change-the-laragon-web-root-folder)

We will be using SQLite for the majority of the time when developing and testing. This is because it will interact with the system faster, and we do not need to have all the power of a full DBMS like MySQL, MariaDB or PostgreSQL.


### Making PHP, Composer and NPM available from the CLI

One thing that is important to dop whenever you update or change a version of the above tools is to remove and add the Laragon components from the system path. For details see here:

- [Adding Laragon to the System Path](https://help.screencraft.net.au/hc/2680392001/36/adding-laragon-to-the-system-path)


### PHP extensions

Make sure that you have the following PHP extensions installed and enabled:
- bz2
- curl
- fileinfo
- gd
- intl
- mbstring
- exif  
- mysqli
- openssl
- pdo_mysql
- pdo_pgsql
- pdo_sqlite
- xsl
- zip

You can easily do this by first making sure the PHP is at least the minimum shown above, then:

- right click on Laragon UI
- hover over PHP
- click on the `php.ini` entry

This will open up the `PHP.INI` file and let you uncomment the lines as shown below:

```ini
extension=bz2
extension=curl
extension=fileinfo
extension=gd
extension=intl
extension=mbstring
extension=exif  
extension=mysqli
extension=openssl
extension=pdo_mysql
extension=pdo_pgsql
extension=pdo_sqlite
extension=xsl
extension=zip
```

After removing the `;` semi-colons from these lines (if they have them), make sure you save the file and close.

Next stop and start Apache, as a precaution.

# Installing the Laravel Installer

Open a terminal and execute the following:

```shell
composer global install laravel/installer
```

This makes it available anytime you wish to start a new project.


# Creating your First App

To create a Laravel application, make sure the MS Terminal application is open, and you have a BASH shell with your source repos folder. See below:

```text
Good afternoon
Welcome 5001775, to Bash on NMT-204426.
Today's date is: Friday, 20-09-24

AD+5001775@NMT-204426 MINGW64 ~/Source/Repos
$
```


### Starting the process

Execute the following:

```shell
laravel new
```

You will get a nice welcome and it asking for a project name. As per any 'file name' we do not allow spaces and other special characters, but you may use the letters `a` to `z`, the numbers `0` to `9` and minus `-` and full stop `.`.

```text
$ laravel new

   _                               _
  | |                             | |
  | |     __ _ _ __ __ ___   _____| |
  | |    / _` | '__/ _` \ \ / / _ \ |
  | |___| (_| | | | (_| |\ V /  __/ |
  |______\__,_|_|  \__,_| \_/ \___|_|


 What is the name of your project?:
```

### Give the project a name

Enter the name `saas-fed-laravel-11-demo`

### Starter Kits

The installer then asks you for a start kit:

```text
  Would you like to install a starter kit? [No starter kit]:
  [none     ] No starter kit
  [breeze   ] Laravel Breeze
  [jetstream] Laravel Jetstream
 > breeze
```

We will use `breeze` for this demo.

Type in `breeze` and press <kbd>ENTER</kbd>.

It then asks for the "Stack" to use with Breeze.

We will be using the Blade templating system for the majority of our work, so we will select the "Blade with Alpine" option:

```text
 Which Breeze stack would you like to install? [Blade with Alpine]:
  [blade              ] Blade with Alpine
  [livewire           ] Livewire (Volt Class API) with Alpine
  [livewire-functional] Livewire (Volt Functional API) with Alpine
  [react              ] React with Inertia
  [vue                ] Vue with Inertia
  [api                ] API only
 > blade
```

The next step of the UI decisions is if we want to have dark mode enabled. 

We will select the default, `no`, but you are most welcome to enter `yes`. 

```text
 Would you like dark mode support? (yes/no) [no]:
 > no
```

### Adding a Testing Framework

Even though we are not going to write tests in this example, we will still enable a testing framework.

In this case we will select the Pest testing framework:

```text
 Which testing framework do you prefer? [Pest]:
  [0] Pest
  [1] PHPUnit
 > 0
```

### Start a Repo

Well, this should be a no-brainer... yes!

```text
 Would you like to initialize a Git repository? (yes/no) [no]:
 > yes

```

### Now we wait a while

At this point the installer starts to to its thing...

```text
    Creating a "laravel/laravel" project at "./saas-fed-laravel-11-demo"
    Installing laravel/laravel (v11.2.0)
  - Downloading laravel/laravel (v11.2.0)
      - Installing laravel/laravel (v11.2.0): Extracting archive
    Created project in C:\Users\5001775\Source\Repos/saas-fed-laravel-11-demo
Loading composer repositories with package information
    Updating dependencies
    Lock file operations: 106 installs, 0 updates, 0 removals
  - Locking brick/math (0.12.1)
...
...
 105/106 [===========================>]  99%
 106/106 [============================] 100%
    51 package suggestions were added by new dependencies, use `composer suggest` to see details.
Generating optimized autoload files
    78 packages you are using are looking for funding.
Use the `composer fund` command to find out more!
    No security vulnerability advisories found
    > @php -r "file_exists('.env') || copy('.env.example', '.env');"

   INFO  Application key set successfully.
```

Once it gets tot his point, we now make a decision about the Database we will use.

### Select the Database technology to use

Laravel supports a lot of DBMS straight out of the box. If you have enabled the PHP Extensions, then you may select from:

  - SQLite
  - MySQL
  - MariaDB
  - PostgreSQL
  - SQL Server

We are using SQLite for our learning, development and testing. Deployment to a staging server or to production would require us to use a more robust DBMS such as MariaDB, PostgreSQL or similar.

```text
 Which database will your application use? [SQLite]:
  [sqlite ] SQLite
  [mysql  ] MySQL
  [mariadb] MariaDB
  [pgsql  ] PostgreSQL
  [sqlsrv ] SQL Server (Missing PDO extension)
 > sqlite
```

When you have entered sqlite and pressed <kbd>ENTER</kbd> you will get asked about runnign migrations... say `yes`:

```text

 Would you like to run the default database migrations? (yes/no) [yes]:
 >
```

If you get asked about creating the SQLite database file, again say `yes`.

```text


   WARN  The SQLite database configured for this application does not exist: C:\Users\5001775\Source\Repos\saas-fed-laravel-11-demo\database\database.sqlite.

  Would you like to create it? (yes/no) [yes]
❯
   INFO  Preparing database.

  Creating migration table .............................................................................. 30.44ms DONE

   INFO  Running migrations.

  0001_01_01_000000_create_users_table     ................................................................. 391.83ms DONE
  0001_01_01_000001_create_cache_table .................................................................. 26.55ms DONE
  0001_01_01_000002_create_jobs_table     ................................................................... 61.38ms DONE
```

### And so we continue...

Once the migrations are completed, the installer carries on with adding more components...

```text
    Using version ^2.2 for laravel/breeze
./composer.json has been updated
    Running composer update laravel/breeze
Loading composer repositories with package information
    Updating dependencies
Lock file operations: 1 install, 0 updates, 0 removals
  - Locking laravel/breeze (v2.2.0)
...
...
...

   INFO  Breeze scaffolding installed successfully.

    warning: in the working copy of 'package.json', CRLF will be replaced by LF the next time Git touches it
   INFO  Application ready in [saas-fed-laravel-11-demo]. You can start your local development using:

➜ cd saas-fed-laravel-11-demo
➜ php artisan serve

  New to Laravel? Check out our bootcamp and documentation. Build something amazing!
```


### We're Ready!

At this point we are ready to start our investigation and learning about Laravel.

But... before we do, we need to run a few commands at the CLI and leave them running as we develop.

## The Essentials when Developing

When you are working with Laravel for a web application you will need a number of essential applications to be executing.

- TailwindCSS builder
- MailPit
- A spare Bash shell 

There are a couple more items that will be introduced later. They include:

- The Artisan Queue Worker

Go back to your CLI and do the following:

Click on the Bash CLI you have open.

Press:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>-</kbd>

This splits the screen in half vertically

Click in the bottom half and press:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>+</kbd>

This will split the lower half of the screen vertically.

Repeat this in the bottom right hand of the CLI.

You should end up with a screen similar to this:

![](../assets/S10-Introducing-Laravel-20240920153937338.png)

### Resizing the sections

To resize the sections you use the <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&larr;</kbd> (left arrow) and <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&rarr;</kbd> (right arrow) key combinations.

#### Moving between sections

To move between sections use the <kbd>ALT</kbd>+<kbd>&larr;</kbd>, <kbd>ALT</kbd>+<kbd>&rlarr;</kbd>, <kbd>ALT</kbd>+<kbd>&darr;</kbd>, and <kbd>ALT</kbd>+<kbd>&uarr;</kbd> (ALT key and the arrow keys).

### Change to the App Folder

In each window you will need to change into your application's folder:

```shell
cd saas-fed-laravel-11-demo
```


### Tailwind Watch and Build

In one of the shells, start the TailwindCSS watch and build action:

```bash
 npm run dev
```

This tells NPM to execute the vite command with the "dev" action.

The command is contained in the `package.json` file.

### Mail Pit Watcher

In a second window start your Mail Pit application:

```bash
/c/Laragon/bin/mailpit/mailpit.exe --smtp 0.0.0.0:2525
```

At TAFE this will be:

```bash
/c/ProgramData/Laragon/bin/mailpit/mailpit.exe --smtp 0.0.0.0:2525
```
If you have created the aliases defined in the FAQs then the last command may be shortened to:

```
mp2525
```

The command tells Mail Pit to listen to port 2525 on all network interfaces for SMTP commands.

### Example of Mail Pit and Tailwind running

Here are the two sections of the terminal with these running:

![](../assets/S10-Introducing-Laravel-20240920155255149.png)


## A Quick Check on our Application

Now, go back to Laragon and stop and start Apache. Always look out for the Windows Security prompt, as it will not let you do the next step without acknowledging it...

Open a web browser and enter: `http://saas-fed-laravel-11-demo.test` and press <kbd>ENTER</kbd>.

In the browser you will now see:

![Laravel Initial Web Site](../assets/S10-Introducing-Laravel-20240920133837144.png)

We are now ready to find out a bit more...

### Open PhpStorm and Open the Project

Before we start coding, open PhpStorm (or your preferred editor), and the use the usual method to open the `saas-fed-laravel-11-demo` folder.

Click on the Hamburger Icon, Click File, Click Open, Select the `Source/Repos` folder, then select the `saas-fed-laravel-11-demo` folder, and click Open.

![](../assets/phpstorm64_NPKG6zDBWm%201.gif)

# Folder Structure

Program with Gio does a good job at explaining the Folder Structure...

<iframe width="560" height="315" src="https://www.youtube.com/embed/KzyMmRVRInM?si=ExHjcgQS6IOE-t4q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>




# END

Next up - [S10 Laravel BootCamp Part 1](session-10/S10-Laravel-BootCamp-Part-1.md) and [Part 2](session-10/S10-Laravel-BootCamp-Part-2.md)
