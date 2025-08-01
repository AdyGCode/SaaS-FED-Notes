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
updated: 2025-07-22T17:04
---

# S20 End of Cluster

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

# Testing Your App Works

One of the biggest issues we find is that an application has not been tested on a separate instance of the application or computer.

So, what do you need to do to make sure everything is correct?

1) Make sure that any new computer is set up as required (see [Setting Up For Testing](#Setting%20Up%20For%20Testing))
2) Download your code as a compressed file from [GitHub](https://github.com) and Decompress your compressed file
3) Move the folder into your `Source/Repos` folder
4) Stop and Start the Laragon services for it to pick up the new test site
5) Open a CLI and run the `composer` and `npm` install commands (see NPM & Composer)
6) Run a fresh `artisan migrate` to create and seed the database (see Artisan time)
7) Open the http://FOLDER_NAME.test URL and test all parts of the application.

## Setting Up For Testing

Make sure you have the following installed:

- Laragon 6 (or later) with updates to:
	- Apache 2.4.62 or later (**very important**)
	- PHP 8.3 or later (**8.4 preferred**)
	- NodeJS 18 or later (**Node 20 LTS, or Node 22 or later preferred**)
	- Composer 2.4 or later (see later on how to upgrade)
	- NPM 8.18 or later
- MailPit  (for mail debugging)
- Windows Terminal (for CLI) with the BASH CLI

The following direct links will assist you:
- [Add a new version of PHP to Laragon](https://help.screencraft.net.au/hc/1299211922/67/add-a-new-version-of-php-to-laragon) 
- [Update the Apache web server in Laragon](https://help.screencraft.net.au/hc/1299211922/68/update-the-apache-web-server-in-laragon)
- [Install and Run MailPit](https://help.screencraft.net.au/hc/1299211922/69/install-and-run-mailpit)
- [Update NodeJS (and NPM) in Laragon](https://help.screencraft.net.au/hc/1299211922/84/update-nodejs-and-npm-in-laragon)
- [Add Git Bash to Microsoft Terminal](https://help.screencraft.net.au/hc/1299211922/65/add-git-bash-to-microsoft-terminal)
- [Add or Update Bash Command Line Aliases for Git, Laravel, and more](https://help.screencraft.net.au/hc/1299211922/66/add-bash-command-line-aliases-for-git)

Point Laragon "Root Path" to `Source/Repos` folder:
- [Change the Laragon Web Root Folder](https://help.screencraft.net.au/hc/1299211922/61/change-the-laragon-web-root-folder)

Make PHP, Composer and NPM available from the CLI
- [Adding Laragon to the System Path](https://help.screencraft.net.au/hc/1299211922/36/adding-laragon-to-the-system-path)

Restart the Laragon services to make sure that the correct version of PHP is selected.

Now ensure these PHP Extensions are enabled:
- `bz2`, `curl`, `fileinfo`, `gd`, `intl`, `mbstring`, `exif`  
- `mysqli`, `openssl`, `pdo_mysql`, `pdo_pgsql`
- `pdo_sqlite`, `xsl`, `zip`

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

After removing the `;` semi-colons from the start of these lines (if they have them), make sure you save the file and close.

Next stop and start Apache, as a precaution.

## NPM & Composer

Open the MS Terminal and make sure you are in BASH.

Change into the folder containing the newly uncompressed source code (replace FOLDER_NAME with the new folder name):

```shell
cd FOLDER_NAME
```

Check that NPM and Composer are available:

```shell
npm --version
composer --version
```

If you get an error it is because you have not **[Added/Updated Laragon in the System Path](https://help.screencraft.net.au/hc/1299211922/36/adding-laragon-to-the-system-path)**. You need to do this if you change versions of **ANY** of the services!

You may be given a prompt to update NPM or Composer or both. To do so use:

```shell
composer self-update
npm install -g npm@latest
```

Run the following command to install the **composer** and **NodeJS** modules for the application:

```shell
composer install && npm install
npm run dev
```

Run the following command to compile the Tailwind CSS:

```shell
npm run build
```

## Check the `.env`

When you placed your application onto GitHub you were told to make sure you duplicated the `.env` file into a new copy called something similar to `.env.sqlite` or `.env.dev`.

Copy this file to `.env` using:

```shell
cp .env.sqlite .env
```

or

```shell
cp .env.dev .env
```


You must also update the following in the `.env` file (we show only the lines to be checked and changed):

- change `TEST_NAME` to the name of the application
- change `FOLDER-NAME` to the new folder's name, eg `some-application-main`

```ini
APP_NAME="TEST_NAME - Test"  
APP_ENV=local  
APP_KEY=
APP_DEBUG=true  
APP_TIMEZONE=Australia/Perth  
APP_URL=http://FOLDER_NAME.test  
  
APP_LOCALE=en_AU  
APP_FALLBACK_LOCALE=en  
APP_FAKER_LOCALE=en_US  
  
  
DB_CONNECTION=sqlite  
  
MAIL_MAILER=smtp  
MAIL_HOST=127.0.0.1  
MAIL_PORT=2525  
MAIL_FROM_ADDRESS="no-reply@example.com"  
  
```
## Artisan Time

Once you have the modules installed and ready we next make sure an empty database is available (for SQLite) and perform the migrations and seeding.

Before this we will generate a new Secret Key for the Application:

```shell
php artisan generate:key
```

Remove any existing SQLite database and create an empty file:

```shell
rm database/database.sqlite
touch database/database.sqlite
```

Execute the migration (from fresh) and seed:

```shell
php artisan migrate:fresh --seed
```

You should now be ready to test your application.

# Problems!

If you have any problems then this is the time to resolve them.

Common issues:

- During development you have not reset the database and not detected problems before this point
- You have commented out seeders
- You are seeding data in the wrong order
- You have seeding in a migration (very wrong)
- Your migrations have errors
- Routes are incorrect
and many more!

