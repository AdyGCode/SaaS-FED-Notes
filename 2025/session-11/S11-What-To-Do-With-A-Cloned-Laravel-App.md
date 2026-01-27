---
created: 2025-08-21T15:35
updated: 2025-08-21T15:50
---

# The Development Environment (revisted)

When working in a team you will all want to run your own development system.

For our development environment you must ensure you have very recent versions, if not the latest versions of:

- PHP
- Composer
- NodeJS
- NPM
- Mailpit
- Git
- Bash Terminal (via Git/Laragon)

We are presuming you have followed the instructions on the ScreenCraft Helpdesk FAQs to set up and configure each of these.

## Adding Mail Pit to the Composer Run Dev

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

Once you have done this, stop the current `composer run dev` using <key>CTRL</key>+<key>C</key> and then re-running the command:

```shell
composer run dev
```


# What to do with a Cloned Laravel Application

If you have forked or cloned a Laravel application (for example you are working on a team project, with the primary repository hosted by the company), then you will not be able to run the application.

To enable you to do this you need to do at least the following:

- Copy the .env.example file to .env
- Update the .env file
- Install the Composer packages
- Install the NodeJS packages
- Generate a new Application Key
- Run migrations
- Run sample data seeders

## Duplicate and Update the `.env`

Copy .env.example to .env

```shell
cp .env.example .env
```

Now open your IDE (e.g. PhpStorm) and edit the `.env` file.

You will need to update the lines shown below with the required data - we have used placeholder text enclosed in `<` and `>`:

```ini
APP_NAME="<APPLICATION_NAME>"  
APP_URL=<FULL_URL_TO_DEV_SERVER>

MAIL_MAILER=smtp  
MAIL_HOST=127.0.0.1  
MAIL_PORT=2525  
MAIL_FROM_ADDRESS="<DUMMY_EMAIL_ADDRESS>"  
```

## Install Composer and NodeJS Packages

Execute:

```shell
composer install
npm install
```

You may optionally do a `composer update` to update packages as needed.

## Generate a New Application Key

Execute:

```shell
php artisan key:generate
```


## Running the Migrations

Execute the following:

```shell
php artisan migrate:fresh
```

## Seeding the Database

If needed, you may then execute the seeding process:

```shell
php artisan db:seed
```

