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
updated: 2025-05-30T08:51
---

# Laravel: 01 Setting Up

## Software as a Service - Front-End Development

### Session 11

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

# Installing Laravel

## Installing & Updating the Laravel Installer

```shell
composer global require laravel/installer
```

## Creating a New Laravel project

```shell
laravel new
```

Enter the details as required. For us we use:

| Prompt            | Answer                                    |
| ----------------- | ----------------------------------------- |
| Project name      | xxx-SaaS-FED-Laravel-11-Learning          |
| Starter Kit       | Breeze                                    |
| Stack             | Blade                                     |
| Dark Mode         | No                                        |
| Testing Framework | Pest                                      |
| Git Repository    | Yes                                       |
| Database          | SQLite (whilst developing)                |
| Run migrations    | Yes                                       |
|                   | If asked to create database file, say yes |

Change into the folder once completed:

```shell
cd xxx-SaaS-FED-Laravel-11-Learning
```

Open a browser and head to:

```html
http://xxx-SaaS-FED-Laravel-11-Learning.test
```

You should get the default page shown.t in PHP Storm


Back in your terminal, split the screen into 4 sections. Once horizontally, then the lower half into three columns. Resize to suit your needs.

ALT SHIFT - (split into half vertically)
ALT SHIFT + (Split into half horizontally)

### Tailwind and JS Compiler (Vite)

In the bottom left execute:
\
```shell
cd xxx-SaaS-FED-Laravel-11-Learning
npm run dev
```

### MailPit

In the bottom middle, execute:

```shell
cd xxx-SaaS-FED-Laravel-11-Learning
mp2525
```

The above presumes you have an alias for MailPit, see ScreenCraft Help Desk FAQs for details.
 
### Laravel Queue Monitoring (for Email, etc)

In the third column (bottom right) execute:

```shell
cd xxx-SaaS-FED-Laravel-11-Learning
php artisan queue:work
```


You are now ready to continue with the development of the application.

### ReadMe Update

In the top half of the CLI, we will rename the original Laravel ReadMe and create a new empty ReadMe:

```shell
mv ReadMe.md ReadMe-Laravel.md
touch ReadMe.md
```


### Update `.env` 

Go back to PhpStorm. Locate and open the `.env` file.

Edit the following environment entries of the file:

| Key               | New Value                                    |
| ----------------- | -------------------------------------------- |
| APP_URL           | http://xxx-SaaS-FED-Laravel-11-Learning.test |
| APP_NAME          | "XXX Laravel Learning"                       |
| APP_TIMEZONE      | Australia/Perth                              |
| MAIL_MAILER       | smtp                                         |
| MAIL_FROM_ADDRESS | "no-reply@example.com"                       |
| APP_LOCALE        | en_AU                                        |

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

# END

Next up - [S12 Laravel 02 Update User](../session-13/S12-Laravel-02-Update-User.md)
