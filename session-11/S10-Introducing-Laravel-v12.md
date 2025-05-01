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
updated: 2025-05-01T13:54
---

# S10 Introducing Laravel v12

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

# Introducing Laravel v12

https://laravel.com/docs

As Laravel 12's documentation does not include a bootcamp, we will take the Laravel 11 Bootcamp and use this as a basis for this introduction.

For this we will create an application called Chirper. A basic Twitter, now X, clone.

## How to Use Laravel

We can develop and run Laravel applications in a number of ways:
- Local PHP & Composer installation (eg via Laragon, Xampp, Mamp, Herd, etc)
- Docker based installer
- Valet
- and more...

## Before you Begin

Make sure you have the following installed:

- Laragon 6 with updates to:
	- Apache 2.4.62 or later (very important)
	- PHP 8.3 or later (8.4 preferred)
	- NodeJS 18 or later (Node 20 LTS, or Node 22 or later preferred)
	- Composer 2.4 or later
	- NPM 8.18 or later
- MailPit  (for mail debugging)
- Windows Terminal (for CLI) with the BASH CLI

> Note: Laragon 7 and after require a license to be used. Laravel 6 is no longer supported by the author.

### Updating Laragon's Software

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


> ### ⚠️ Important:
>
> Adrian has created a starter kit for Laravel 12, and is awaiting it to be added to the "custom starter kits" list.
> 
> This means that the following may not work at time of writing, but the alternative method is provided using a clone of the original GitHub repository (See ... [Setting Up from the Retro Blade Starter Kit](#Setting%20up%20from%20the%20Retro%20Blade%20Starter%20Kit%20Repo)).


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
laravel new --using=adygcode/retro-blade-kit
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

Enter the name `chirper-2025-s1`

### Starter Kits

As we gave the CLI a starter kit we will not need to select a kit from the default Laravel 12 options.

The starter kit contains:
  
- Blade Templates circa Laravel 11  
- Navigation bar on guest and app layouts  
- Footer in guest and app layouts  
- [Laravel Sanctum](https://laravel.com/docs/sanctum) authentication  
- Email Verification enabled  
- [Laravel Debug Bar](https://laraveldebugbar.com)  
- [Laravel Telescope](https://laravel.com/docs/telescope)  
- [Laravel Livewire](https://livewire.laravel.com)  
- [Font Awesome 6 (Free)](https://fontawesom.com)

Jump to [Setting Up from the Retro Blade Starter Kit](#Setting%20up%20from%20the%20Retro%20Blade%20Starter%20Kit%20Repo)

---
## TODO: Update this section

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
    Creating a "laravel/laravel" project at "./chirper-2025-s1"
    Installing laravel/laravel (v11.2.0)
  - Downloading laravel/laravel (v11.2.0)
      - Installing laravel/laravel (v11.2.0): Extracting archive
    Created project in C:\Users\5001775\Source\Repos/chirper-2025-s1
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

Once it gets to this point, we now make a decision about the Database we will use.

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

When you have entered SQLite and pressed <kbd>ENTER</kbd> you will get asked about running migrations... say `yes`:

```text

 Would you like to run the default database migrations? (yes/no) [yes]:
 >
```

If you get asked about creating the SQLite database file, again say `yes`.

```text


   WARN  The SQLite database configured for this application does not exist: C:\Users\5001775\Source\Repos\chirper-2025-s1\database\database.sqlite.

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
   INFO  Application ready in [chirper-2025-s1]. You can start your local development using:

➜ cd chirper-2025-s1
➜ php artisan serve

  New to Laravel? Check out our bootcamp and documentation. Build something amazing!
```
## END TODO: Update this section

## Setting up from the Retro Blade Starter Kit Repo

If you are unable to use the `laravel new` command to create a new application using the Retro Blade starter kit then the following steps need to be followed...

1. Open Terminal with Bash Shell
2. Ensure you are in the Source/Repos folder
3. Decide on application name
4. Clone the repository
5. Change into the repo and install requirements

So lets complete these steps:

### Open Terminal with Bash Shell

Open the MS Windows Terminal - making sure you have the "Bash" shell from the git installation running.

### Ensure you are in the Source/Repos folder

Make sure that you are in your `Source/Repos` folder. If not use:

```shell
cd ~/Source/Repos`
```

### Decide on application name

Decide on the name for the application. This will be needed in two or three places, one of which will be for the cloning of the repository.

We suggest you fill out a little table similar to this one to help your documentation:

|                      | Application Name          | Repository Folder Name | Alternative Folder Name   |
| -------------------- | ------------------------- | ---------------------- | ------------------------- |
| **Example 1**        | Lego Masters Brick System | lmbs                   | lego-masters-brick-system |
| **Example 2**        | Chirper                   | chirper                | twitter-clone             |
| **Your Application** |                           |                        |                           |

We will use `chirper-2025-s1` for the rest of these steps.

### Clone the repository

Next we clone the repository, and we will do this into the correct folder at the same time as making the clone:

```shell
git clone https://github.com/adygcode/retro-blade-kit chirper-2025-s1
```

### Install requirements

We now have a new folder, `chirper-2025-s1`, which we are ready to work with.

```shell
cd chirper-2025-s1
```

Now we install the requirements:

```shell
touch database/database.sqlite
composer install
npm install
```

In most cases when starting a new application it is always a good idea to update the packages used:

```shell
composer update
npm update
```

For example, at time of writing there had been a minor update to the Laravel framework:
```text
Package operations: 0 installs, 1 update, 0 removals
  - Downloading laravel/framework (v12.10.2)
  - Upgrading laravel/framework (v12.10.0 => v12.10.2): Extracting archive
```

### Create your GitHub repository

Before continuing we need to create a GitHub repository. 

Go to your GitHub account and create a new repository using the same name as you application.

Make sure that the repository is **TOTALLY EMPTY**. 
- No `ReadMe`, 
- No `License`, and
- No `.gitignore`.

![New GitHUb Repo](../assets/Pasted%20image%2020250428171521.png)

### Update Remote and Push

We now need to update where the remote is and push our changes.

Update the URI to suit your personal GitHub account and repository details by:

1. removing the origin as being Adrian's original repository
2. attaching your new repository as the remote
3. pushing the code to the remote

```shell
git remote remove origin
git remote add origin https://github.com/AdyGCode/chirper-2025-s1.git
git push -u origin main
```

Check that your remote has the required files.

![](../assets/Pasted%20image%2020250428171915.png)


## We're Ready!

At this point we are ready to start our investigation and learning about Laravel.

But... before we do, we need to run a few commands at the CLI and leave them running as we develop.

## The Essentials when Developing

When you are working with Laravel for a web application you will need a number of essential applications to be executing.

- TailwindCSS builder
- MailPit
- The Laravel Queue Worker

Thankfully at least two of these is now handled by Laravel via Composer and NPM.

Go back to your CLI and press:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>-</kbd>

This splits the screen in half vertically

### Resizing the sections

To resize the sections you use the <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&larr;</kbd> (left arrow) and <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&rarr;</kbd> (right arrow) key combinations.

#### Moving between sections

To move between sections use the <kbd>ALT</kbd>+<kbd>&larr;</kbd>, <kbd>ALT</kbd>+<kbd>&rlarr;</kbd>, <kbd>ALT</kbd>+<kbd>&darr;</kbd>, and <kbd>ALT</kbd>+<kbd>&uarr;</kbd> (ALT key and the arrow keys).

### Change to the App Folder

In each window you will need to change into your application's folder:

```shell
cd chirper-2025-s1
```


### Copy the `.env.example`  & Generate App Key

We need to duplicate the `.env.example` file and rename it. Use the command:

```shell
cp .env.example .env
php artisan key:generate
```

### Edit the .env File & Update

Now open your IDE (e.g. PhpStorm) and edit the .env file.

For our Chirper Application we will make the following changes to the lines shown (DO NOT delete any lines):

```ini
APP_NAME="Chirper 2025/S1"  
APP_URL=http://localhost:8000

MAIL_MAILER=smtp  
MAIL_HOST=127.0.0.1  
MAIL_PORT=2525  
MAIL_FROM_ADDRESS="chirper@example.com"  
```

### Composer Run to the Rescue!

In the top shell area run the following command:

```bash
composer run dev
```

This tells composer to execute (via NPM) the following:
- Vite to compile any JS and CSS
- PHP's Development web server on port 8000
- Laravel's queue watcher

### Mail Pit Watcher

We also need the Mail Pit command to be executed so we are able to intercept email whilst we are developing.

Click on the bottom WindowIn a second window start your Mail Pit application:

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

### Adding Mail Pit to the Composer Run Dev

It is possible to add Mail Pit to the composer run dev.

Open the `composer.json` file in the root of the application's code folder.

Locate the lines:

```json
"dev": [  
    "Composer\\Config::disableProcessTimeout",  
    "npx concurrently -c \"#93c5fd,#c4b5fd,#fb7185\" \"php artisan serve\" \"php artisan queue:listen --tries=1\" \"npm run dev\" --names=server,queue,vite"],
```

Update it to read:

```json
"dev": [  
    "Composer\\Config::disableProcessTimeout",  
    "npx concurrently -c \"#93c5fd,#c4b5fd,#fb7185,#fdba74\" \"php artisan serve\" \"php artisan queue:listen --tries=1\" \"npm run dev\" \"c:\\ProgramData\\Laragon\\bin\\mailpit\\mailpit --smtp 0.0.0.0:2525\" --names=server,queue,vite,mailpit"],
```

Once you have done this, stop the current composer run dev using <key>CTRL</key>+<key>C</key> and then re-running the command:

```shell
composer run dev
```

### Running the Migrations

Because the starter kit comes with a variety of compoents already installed, we also need to run the migrations by hand.

Perform the following:

```shell
php artisan migrate:fresh --seed
```

This creates a number of tables for the starter kit, and some starter data (for example 3 sample users).
## A Quick Check on our Application

Now, go back to Laragon and stop and start Apache. Always look out for the Windows Security prompt, as it will not let you do the next step without acknowledging it...

Open a web browser and enter: `http://127.0.0.1:8000` and press <kbd>ENTER</kbd>.

If you have Laragon's Apache server running you may also visit: `http://chirper-2025-s1.test`.


In the browser you will now see:

![Laravel Initial Web Site](../assets/Pasted%20image%2020250428175052.png)

We are now ready to find out a bit more...

### Open PhpStorm and Open the Project

If you have not done so before, open PhpStorm (or your preferred editor), and the use the usual method to open the `chirper-2025-s1` folder.

Click on the Hamburger Icon, Click File, Click Open, Select the `Source/Repos` folder, then select the `chirper-2025-s1` folder, and click Open. (The animation shows a different application, but the process is the same)

![](../assets/phpstorm64_NPKG6zDBWm%201.gif)

# Folder Structure

***Program with Gio*** does a good job at explaining the Folder Structure...

<iframe width="560" height="315" src="https://www.youtube.com/embed/KzyMmRVRInM?si=ExHjcgQS6IOE-t4q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


You are ready to carry on with the Boot Camp.

# END

Next up - [S10 Laravel BootCamp Part 1](session-11/S10-Laravel-BootCamp-Part-1.md) and [Part 2](session-11/S10-Laravel-BootCamp-Part-2.md)
