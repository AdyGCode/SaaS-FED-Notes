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

# S10 Laravel v12 and imacrayon/blade-starter-kit

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

# Laravel 12 & I'm A Crayon's Blade Starter kit

Laravel v12 comes with four main starter kits:
- None
- React
- Vue, and
- Livewire

What if you do nto want to use one of these?

There was a tweak to the installer that allows us to use "custom starter kits".

One of these is the `https://github.com/imacrayon/blade-starter-kit`.

These notes take you through setting up a base application using this starter kit.

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

Information on adding and/or updating components and configurations for the likes of the Laragon Paths, Bash and MailPit is available from:

- [ScreenCraft Help Desk](https://help.screencraft.net.au/hc/2680392001) 
-  [Search for Laragon Articles](https://help.screencraft.net.au/hc/2680392001/search?q=laragon)
- [Add a new version of PHP to Laragon?](https://help.screencraft.net.au/hc/2680392001/67/add-a-new-version-of-php-to-laragon) 
- [Update the Apache web server in Laragon](https://help.screencraft.net.au/hc/2680392001/68/update-the-apache-web-server-in-laragon)
- [Install and Run MailPit?](https://help.screencraft.net.au/hc/2680392001/69/install-and-run-mailpit)
- [Update NodeJS (and NPM) in Laragon](https://help.screencraft.net.au/hc/2680392001/84/update-nodejs-and-npm-in-laragon)
- Adding xDebug to PHP
- [Add Git Bash to Microsoft Terminal](https://help.screencraft.net.au/hc/2680392001/65/add-git-bash-to-microsoft-terminal)
- [Add or Update Bash Command Line Aliases for Git, Laravel, and more](https://help.screencraft.net.au/hc/2680392001/66/add-bash-command-line-aliases-for-git)
- - [Change the Laragon Web Root Folder](https://help.screencraft.net.au/hc/2680392001/61/change-the-laragon-web-root-folder)
- [Adding Laragon to the System Path](https://help.screencraft.net.au/hc/2680392001/36/adding-laragon-to-the-system-path)

## Installing/Updating the Laravel Installer

Open a terminal and execute the following:

```shell
composer global require laravel/installer
```

This makes it available anytime you wish to start a new project.

# Creating the Starter Kit based App

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
 laravel new --git --pest --using=imacrayon/blade-starter-kit
```

> Note:
> - `--git` initialises a git repository, 
> - `--pest` installs the pest testing framework.
> - `--using` uses the specified repository as the starter template

You will get a nice welcome and it asking for a project name. As per any 'file name' we do not allow spaces and other special characters, but you may use the letters `a` to `z`, the numbers `0` to `9` and the minus sign `-`.

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

Enter the name `saas-fed-l12-blade-demo`

### Whilst you are waiting...

After this, the starter kit is downloaded, uncompressed and the required packages are installed.

Some of the choices and packages that are added include:
- Database will be SQLite
- Sanctum is added
- ...

### Running `npm install` & `npm run build`

We next answer `yes` to the question on running the `npm install` and the `npm run build` commands.

The installation will complete.

### Quick Test of the application

To test the application, we need to be in the folder with the project. This will be the 
folder `saas-fed-l12-blade-demo`.

Back in the Terminal, use the command:
```shell
cd saas-fed-l12-blade-demo
```

This places you in the correct folder.

Now execute:
```shell
composer run dev
```

This will do three things:
1. execute a development web server (`php artisan serve`)
2. execute the queue listener (`php artisan queue:listen`)
3. execute the development server for npm (`npm run dev`)

Open a browser and go to: http://localhost:8000 to view the starter kit homepage.... complete with login and register buttons!

![](../assets/Pasted%20image%2020250409121645.png)

We are ready to add a few more features ready for work.

## Split your Terminal Console 

Before we go any further we will split the terminal into two parts:
1. Top part will have the currently running composer command
2. Bottom part will be for us to execute commands

### To Split Across Horizontally 

Use <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>-</kbd>

### To Split Across Vertically

Use <kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>=</kbd>

We want a HORIZONTAL SPLIT.

![](../assets/terminal-split-image%2020250409100830.png)

Once this is done, change into the project folder.

```shell
cd saas-fed-l12-blade-demo
```


## The Essentials when Developing

When you are working with Laravel for a web application you will need a number of essential applications to be executing.

- Vite builder for JS & CSS
- MailPit for email testing
- Development server
- Queue Listener

The Composer run dev does most of these for you.

We can modify the `composer.json` file to add the MailPit listener as part of this command.


![](../assets/Pasted%20image%2020250409122307.png)


![](../assets/Pasted%20image%2020250409122340.png)


![](../assets/Pasted%20image%2020250409122353.png)


![](../assets/Pasted%20image%2020250409122407.png)


C:\ProgramData\Laragon\bin\mailpit


![](../assets/Pasted%20image%2020250409122454.png)

![](../assets/Pasted%20image%2020250409122501.png)

![](../assets/Pasted%20image%2020250409122513.png)


Close terminal and repoen it

if using termnal in PHP Storm close PHP Storm first

### Adding MailPit to Composer Run Dev



"npx concurrently -c \"#93c5fd,#c4b5fd,#fdba74,#6666ff\" \"php artisan serve\" \"php artisan queue:listen --tries=1\" \"npm run dev\" \"mailpit --smtp=0.0.0.0:2525\" --names='server,queue,vite,mailpit'"


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

Next up - [S10 Laravel BootCamp Part 1](session-11/S10-Laravel-v12-BootCamp-Part-1.md) and [Part 2](session-11/S10-Laravel-v12-BootCamp-Part-2.md)
