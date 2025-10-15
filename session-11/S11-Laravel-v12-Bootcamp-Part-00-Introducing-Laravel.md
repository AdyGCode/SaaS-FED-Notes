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
created: 2024-09-20T11:17
updated: 2025-08-21T15:59
---

# Laravel Bootcamp: Introducing Laravel v12

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
### Updating Laragon's Software

Information on updating Laragon to these versions is available at the:

- [ScreenCraft Help Desk](https://help.screencraft.net.au/hc/1299211922) 

Any FAQs that refer to Laragon may be found using this HelpDesk link to

- [Search for Laragon Articles](https://help.screencraft.net.au/hc/1299211922/search?q=laragon)

Some useful Direct Links:

- [Add a new version of PHP to Laragon?](https://help.screencraft.net.au/hc/1299211922/67/add-a-new-version-of-php-to-laragon) 
- [Update the Apache web server in Laragon](https://help.screencraft.net.au/hc/1299211922/68/update-the-apache-web-server-in-laragon)
- [Install and Run MailPit?](https://help.screencraft.net.au/hc/1299211922/69/install-and-run-mailpit)
- [Update NodeJS (and NPM) in Laragon](https://help.screencraft.net.au/hc/1299211922/84/update-nodejs-and-npm-in-laragon)
- Adding xDebug to PHP


> #### Note: 
> 
> Laragon 7 and above require a license to be used. 
> 
> Laravel 6 is no longer supported by developer of Laragon.


### Use Bash CLI

We also **strongly** recommend using the Git **Bash Shell** with the MS Terminal as this provides a CLI experience that is transferrable to Linux and MacOS.

For details on configuring this, and adding some CLI shortcut aliases see:

- [Add Git Bash to Microsoft Terminal](https://help.screencraft.net.au/hc/1299211922/65/add-git-bash-to-microsoft-terminal)
- [Add or Update Bash Command Line Aliases for Git, Laravel, and more](https://help.screencraft.net.au/hc/1299211922/66/add-bash-command-line-aliases-for-git)

### Point Laragon "Root Path" to Source Repos

You will also be working in a Source Repos folder, so we recommend pointing Laragon's web services to this folder.

- [Change the Laragon Web Root Folder](https://help.screencraft.net.au/hc/1299211922/61/change-the-laragon-web-root-folder)

We will be using SQLite for the majority of the time when developing and testing. This is because it will interact with the system faster, and we do not need to have all the power of a full DBMS like MySQL, MariaDB or PostgreSQL.


### Making PHP, Composer and NPM available from the CLI

One thing that is important to dop whenever you update or change a version of the above tools is to remove and add the Laragon components from the system path. For details see here:

- [Adding Laragon to the System Path](https://help.screencraft.net.au/hc/1299211922/36/adding-laragon-to-the-system-path)


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

- Right click on Laragon UI
- Hover over PHP
- Click on the `php.ini` entry

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

## Verifying the versions of PHP, NodeJS et al

Before you continue, it is a good idea to check that Node, PHP and such are available on the CLI and that they are using the correct versions.

Use the following commands:

```shell
composer --version
php --version 
node --version
npm --version
```

Check to see that you have at least these versions of the software tools. If not, it is a good idea to update to the latest when possible.

| Application | Minimum Version | Latest Version | Update using                       |
| ----------- | --------------- | -------------- | ---------------------------------- |
| PHP         | 8.3.x           | 8.4.x          | See FAQ on help.screencraft.net.au |
| Node JS     | 22.18.x         |                | See FAQ on help.screencraft.net.au |
| Composer    | 2.8.10          |                | `composer global self-update`      |
| NPM         | 10.9.x          |                | `npm install npm@latest`           |


# Installing the Laravel Installer

Open a terminal and execute the following:

```shell
composer global require laravel/installer
```

This makes it available anytime you wish to start a new project.


## Creating a New Laravel Application Using the Installer

Laravel provides a number of ways to create a new application code base.

The best way is using the Laravel installer.

### Before you continue: Decide on the application name

You need to decide on the name for the application. 

This will be needed in two or three places, one of which will be for the creation of the Laravel application using the Base Blade kit.

It is important to NOT use any characters other than the letters `a`-`z` and the dash/minus sign (`-`) in your application name you enter in to the command line/Laravel installer.

We suggest you fill out a little table similar to this one to help your documentation:

|                      | Application Name          | Laravel Installer Name | Alternative Laravel Installer Name |
| -------------------- | ------------------------- | ---------------------- | ---------------------------------- |
| **Example 1**        | Lego Masters Brick System | lmbs                   | lego-masters-brick-system          |
| **Example 2**        | Chirper                   | chirper                | twitter-clone-2025                 |
| **Your Application** |                           |                        |                                    |

### Starting the process...

To begin we us the command:

```shell
laravel new project-name-here
```

Where you replace `project-name-here` with the name of the new Laravel application.

It will greet you with:

```text

   _                               _
  | |                             | |
  | |     __ _ _ __ __ ___   _____| |
  | |    / _` |  __/ _` \ \ / / _ \ |
  | |___| (_| | | | (_| |\ V /  __/ |
  |______\__,_|_|  \__,_| \_/ \___|_|


 ┌ Which starter kit would you like to install? ────────────────┐
 │ › ● None                                                     │
 │   ○ React                                                    │
 │   ○ Vue                                                      │
 │   ○ Livewire                                                 │
 └──────────────────────────────────────────────────────────────┘
```

This first prompt is asking you to select a starter kit for the application.

We will use `none` for this demo.

Type in `none` and press <kbd>ENTER</kbd>.

It starts to do the downloading and installing of the Laravel framework and its required packages.


### Select the Database technology to use

After a few moments it will ask:

```text

   INFO  Application key set successfully.  

 ┌ Which database will your application use? ───────────────────┐
 │ › ● SQLite                                                   │
 │   ○ MySQL                                                    │
 │   ○ MariaDB                                                  │
 │   ○ PostgreSQL                                               │
 │   ○ SQL Server (Missing PDO extension)                       │
 └──────────────────────────────────────────────────────────────┘
```

Once it gets to this point, we now make a decision about the Database we will use.

Laravel supports a lot of DBMS straight out of the box. If you have enabled the PHP Extensions, then you may select from:

  - SQLite
  - MySQL
  - MariaDB
  - PostgreSQL
  - SQL Server

We are using **SQLite** for our learning, development and testing. 

Deployment to a staging server or to production would require us to use a more robust DBMS such as MariaDB, PostgreSQL or similar.

Make sure the SQLite option is highlighted and press <kbd>ENTER</kbd>.

It will go away and now create a new SQLite Database file and perform some base migrations.

> #### Note:
>
> If you get asked about creating the SQLite database file, say `yes`.

```text


   INFO  Preparing database.  

  Creating migration table .................................................................................... 5.47ms DONE

   INFO  Running migrations.  

  0001_01_01_000000_create_users_table ........................................................................ 5.99ms DONE
  0001_01_01_000001_create_cache_table ........................................................................ 2.09ms DONE
  0001_01_01_000002_create_jobs_table ......................................................................... 4.36ms DONE

```

### NPM - Install and Build

The next question you get asked is about running `npm` installs and running the build script.

```text

 ┌ Would you like to run npm install and npm run build? ────────┐
 │ ● Yes / ○ No                                                 │
 └──────────────────────────────────────────────────────────────┘
```

The Yes option is selected by default, so hit <kbd>ENTER</kbd>.

The final steps of the install process are now completed...

```text
vite v7.1.3 building for production...
✓ 53 modules transformed.
public/build/manifest.json             0.31 kB │ gzip:  0.17 kB
public/build/assets/app-Dz1ORB9U.css  33.37 kB │ gzip:  8.48 kB
public/build/assets/app-C0G0cght.js   35.48 kB │ gzip: 14.21 kB
✓ built in 761ms
   INFO  Application ready in [project-name-here]. You can start your local development using:

➜ cd project-name-here
➜ composer run dev

  New to Laravel? Check out our documentation. Build something amazing!
```

That created a basic Laravel application, with no extras.

To view the new basic application do these two commands in the CLI:

```shell
cd project-name-here
composer run dev
```

Now open a browser and go to http://localhost:8000, and you should see:

![](../assets/CleanShot%202025-08-21%20at%2014.58.27@2x.png)

# Creating your First Laravel Application

Ok, now you know how to create a basic application, we are going to do the steps again, but this time using a Template.

> ## ⚠️ Important:
>
> Adrian has created a starter kit for Laravel 12. It has been registered on the Packagist web site, so we are able to use this for our starter template.

## Creating an Application with a Template


To create a Laravel application, make sure the MS Terminal application is open, and you have a BASH shell with your source repos folder. 

See below:

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
laravel new --using=adygcode/base-blade-kit
```

You will get a nice welcome and it asking for a project name. As per any 'file name' we do not allow spaces and other special characters, but you may use the letters (`a` to `z`), the numbers (`0` to `9`) and minus (`-`) and full stop (`.`).

```text
laravel new --using=adygcode/base-blade-kit

   _                               _
  | |                             | |
  | |     __ _ _ __ __ ___   _____| |
  | |    / _` |  __/ _` \ \ / / _ \ |
  | |___| (_| | | | (_| |\ V /  __/ |
  |______\__,_|_|  \__,_| \_/ \___|_|


 ┌ What is the name of your project? ───────────────────────────┐
 │ E.g. example-app                                             │
 └──────────────────────────────────────────────────────────────┘
```

### Give the project a name


We will use `xxx-chirper-2025-s2` for the rest of these steps, where you **will** replace **`xxx`** with **your** initials.


Enter the name `xxx-chirper-2025-s2` - remember to replace the **`xxx`**!

### The Base Blade Starter Kit

As we gave the CLI a starter kit we will not need to select a kit from the default Laravel 12 options.

The starter kit contains:
  
- Blade Templates circa Laravel 11  
- Guest, App and Admin layouts
- [Laravel Sanctum](https://laravel.com/docs/sanctum) authentication  
- Email Verification enabled  
- [Laravel Debug Bar](https://laraveldebugbar.com)  
- [Laravel Telescope](https://laravel.com/docs/telescope)  
- [Laravel Livewire](https://livewire.laravel.com)  
- [Font Awesome 7 (Free)](https://fontawesom.com)


---

### Waiting...

Because we are using the Base Blade kit, we will not get any more questions (apart from possibly asking about creating  `database/database.sqlite` ).

The next question will be...

### NPM - Install and Build

The next question you get asked is about running `npm` installs and running the build script.

```text

 ┌ Would you like to run npm install and npm run build? ────────┐
 │ ● Yes / ○ No                                                 │
 └──────────────────────────────────────────────────────────────┘
```

The **Yes** option is selected by default, so hit <kbd>ENTER</kbd>.

The final steps of the install process are now completed...

```text
vite v7.1.3 building for production...
✓ 53 modules transformed.
public/build/manifest.json             0.31 kB │ gzip:  0.17 kB
public/build/assets/app-Dz1ORB9U.css  33.37 kB │ gzip:  8.48 kB
public/build/assets/app-C0G0cght.js   35.48 kB │ gzip: 14.21 kB
✓ built in 761ms
   INFO  Application ready in [project-name-here]. You can start your local development using:

➜ cd project-name-here
➜ composer run dev

  New to Laravel? Check out our documentation. Build something amazing!
```

That created the application with all the parts of the templated layout ready for you to use.

### Composer Run to the Rescue!

In the CLI run the following command:

```shell
cd project-name-here
composer run dev
```

This tells composer to execute (via NPM) the following:
- Vite to compile any JS and CSS
- PHP's Development web server on port 8000
- Laravel's queue watcher

Now open the location http://localhost:8000 in your preferred browser.

You should see:

![](../assets/CleanShot%202025-08-21%20at%2015.16.13@2x.png)

Yep, it looks the same, except we have login and register buttons...


## We're Ready!

At this point we are ready to start our investigation and learning about Laravel.


## The Essentials when Developing

When you are working with Laravel for a web application you will need a number of essential applications to be executing.

- TailwindCSS builder
- MailPit
- The Laravel Queue Worker
- Development web server

Thankfully at least three of these is now handled by Laravel via Composer and NPM.

Go back to your CLI and press:

- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>+</kbd>

This splits the screen in half.

### Resizing the sections

To resize the sections you use the arrow keys and  ALT and the SHIFT keys.

-  <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&larr;</kbd> (left arrow) 
- <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>&rarr;</kbd> (right arrow) 
-  ALT+<kbd>SHIFT</kbd>+↑ (up arrow) 
- ALT+<kbd>SHIFT</kbd>+↓ (down arrow) 

#### Moving between sections

To move between sections use the <kbd>ALT</kbd>+<kbd>&larr;</kbd>, <kbd>ALT</kbd>+<kbd>&rlarr;</kbd>, <kbd>ALT</kbd>+<kbd>&darr;</kbd>, and <kbd>ALT</kbd>+<kbd>&uarr;</kbd> (ALT key and the arrow keys).

### Change to the App Folder

The top section is already running the `composer run dev` command so we have the web server, queue listener, vite process and mailpit (if installed) executing.

We now need to go into the other part of the split screen (use the keys shown above).

In this section of the window you will need to change into your application's folder:

```shell
cd xxx-chirper-2025-s2
```

At this point we will start...

## Version Controlling the Project

When developing an application, especially when working in a team, version control is one of the many required processes we will use.

In fact it is a vital part of the process of development.

By default Laravel projects are not version controlled.

If you did not use the --git switch then you need to do the following at this point:

```shell
git init
git add .
git commit -m "chore: Initial Laravel 12 Code"
git status
```

This initialises the Git version control on the code, adds the files that were created to version control and commits them to the repository.

Now you need to create a GitHub repository, and push the new code to it...

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

Update the URI to suit your personal GitHub accountby:

1. Ensuring no current origin
2. Change the branch to `main`
3. Attaching your new repository as the remote
4. Pushing the code to the remote

```shell
git branch -m main
git remote remove origin
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/xxx-chirper-2025-s2.git
git push -u origin main
```

Check that your remote has the required files.

![](../assets/Pasted%20image%2020250428171915.png)


## Updating the Settings

Once you have started the version controlling of the application we can update some settings in the environment variables file, `.env`.

By default the Laravel installer creates a new `.env` file from the `.env.example` file.

We therefore do not need to do anything except edit the new `.env` file to reflect the settings we want.


### Edit the .env File & Update

Now open your IDE (e.g. PhpStorm) and edit the `.env` file.

For our Chirper Application we will make the following changes to the variables shown (DO NOT delete any lines):

| Key               | New Value                   |
| ----------------- | --------------------------- |
| APP_URL           | http://localhost:8000       |
| APP_NAME          | "XXX \| Chirper \| 2025 S2" |
| APP_TIMEZONE      | Australia/Perth             |
| MAIL_MAILER       | smtp                        |
| MAIL_FROM_ADDRESS | "no-reply@example.com"      |
| APP_LOCALE        | en_AU                       |
| MAIL_HOST         | 127.0.0.1                   |
| MAIL_PORT         | 2525                        |

### Development Environment Backup

When developing it is useful to have the `.env` Environment settings for the project backed up.

> **IMPORTANT**
> 
> In Production, we would NOT commit these settings to the repository.
> 
> This is because the `.env` file contains secrets such as SMTP passwords, database users and passwords, access to S3 buckets and more.

For the development of this small application we will use the following commands:

```shell
cp .env .env.dev
```


Done, now we continue with the application development.

## A Quick Check on our Application

Now, go back to Laragon and stop and start Apache. Always look out for the Windows Security prompt, as it will not let you do the next step without acknowledging it...

Open a web browser and enter: `http://127.0.0.1:8000` and press <kbd>ENTER</kbd>.

If you have Laragon's Apache server running you may also visit: `http://xxx-chirper-2025-s2.test`.


In the browser you will now see:

![](../assets/CleanShot%202025-08-21%20at%2015.16.13@2x.png)

We are now ready to find out a bit more...

### Open PhpStorm and Open the Project

If you have not done so before, open PhpStorm (or your preferred editor), and the use the usual method to open the `xxx-chirper-2025-s2` folder.

Click on the Hamburger Icon, Click File, Click Open, Select the `Source/Repos` folder, then double click the `xxx-chirper-2025-s2` folder, and click Open. (The animation shows a different application, but the process is the same)

![](../assets/phpstorm64_NPKG6zDBWm%201.gif)

# Folder Structure

***Program with Gio*** does a good job at explaining the Folder Structure...

<iframe width="560" height="315" src="https://www.youtube.com/embed/KzyMmRVRInM?si=ExHjcgQS6IOE-t4q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


You are ready to carry on with the Boot Camp.

# END

Next up - [S11 Laravel Bootcamp Part 1](S11-Laravel-v12-BootCamp-Part-01.md) and [Part 2](S11-Laravel-v12-BootCamp-Part-02.md)
