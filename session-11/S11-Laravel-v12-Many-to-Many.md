---
created: 2025-02-25T14:55
updated: 2025-03-04T13:51
---
# S11 Laravel v12: Many-to-Many


This is based on:

- Laravel Daily. (2025). _Laravel Challenge: Many-to-Many Relations - Olympic Medals_. Youtube.com. https://www.youtube.com/watch?v=-WrFxyZXzdE

‌

Additional information from:
- _How to Install Laravel Breeze on Laravel 12_. (2025). Codecourse.com. https://codecourse.com/articles/how-to-install-laravel-breeze-on-laravel-12
- _barryvdh/laravel-debugbar: Debugbar for Laravel (Integrates PHP Debug Bar)_. (2025, February 25). GitHub. https://github.com/barryvdh/laravel-debugbar

‌
- ...

‌

## Before You Begin

If you have not done so:
- Install the Laragon server system (we supply a copy of V6 with new versions of PHP, Node, MailPit, MariaDB, and others ready to use)
- Add Laragon to the Path
- Create a `Source\Repos` folder in the `C:\Users\USERNAME\` folder
- Install the Windows Terminal
- Set up a BASH shell
- Set up the `.bashrc` and `.aliases` files


## Update Laravel installer

```shell
composer global require laravel/installer
```


## Create the Demo Application

Create a new Laravel project:

```shell
laravel new
```

Use following settings:

| Item        | Value                        | Notes                            |
| ----------- | ---------------------------- | -------------------------------- |
| Name        | `SaaS-FED-L12-Basic-2025-S1` | Replace `xxx` with your initials |
| Starter Kit | None                         |                                  |
| Database    | sqlite                       |                                  |
| Run NPM...  | Yes                          |                                  |

Change into new project directory:

```shell
cd SaaS-FED-L12-Basic-2025-S1
```

### Install the Laravel Breeze Starter Kit

Laravel 12 has changed its default UI Starter Kits. To use a base Blade with Sanctum authentication user kit (aka Breeze) we do the following...

Use the following to install the Laravel Breeze (and Blade) starter kit:

```shell
composer require laravel/breeze --dev
php artisan breeze:install
```

When prompted select the `blade` option, `no`  to dark mode support, and `pest` for the testing.

Once the installation of the new requirements is complete, then use:

```shell
php artisan migrate
```

to perform the initial migrations.

### Add the Laravel DebugBar (Dev Mode only)

Use the following to add the Laravel Debug Bar - a great tool to check what is happening with your application:

```shell
composer require barryvdh/laravel-debugbar --dev
```

More details at:
- _barryvdh/laravel-debugbar: Debugbar for Laravel (Integrates PHP Debug Bar)_. (2025, February 25). GitHub. https://github.com/barryvdh/laravel-debugbar

‌

### Terminal Inception..

Split terminal into 4 sections:

Split horizontally:
`ALT`+`SHIFT`+`-`
Split vertically the new lower section (repeat twice):
`ALT`+`SHIFT`+`=`


You may resize using the `ALT`+`SHIFT`+ arrow keys

Result:

![](assets/Pasted%20image%2020250225150641.png)

In the three new sections, use the previous cd command:

```shell
cd SaaS-FED-L12-Basic-2025-S1
```

### Executing NPM

In the first of the bottom sections we will run `npm` to update the Vite, TailwindCSS and other `npm` installations, plus run the development server to watch for changes to the source files and to update the `css`/`js` files used by the application.

```shell
npm install && npm run dev
```

### Executing MailPit for Mail Testing

In the middle section execute MailPit by using the alias we created as part of the `.aliases` file:

```
mp2525
```

In the last of the three sections run the Laravel queue listener:

```shell
php artisan queue:listen
```

## Problem: Store medals won by each country for each sport

The following shows a typical problem where we have a many to many relationship.

| Sport                           | Gold | Silver | Bronze   |
| ------------------------------- | ---- | ------ | -------- |
| Hockey (m)                      | IND  | NED    | GER      |
| Diving - Springboard 3m (w)     | CHN  | JPN    | CHL      |
| Athletics - 100m (m)            | USA  | JAM    | CAN      |
| Swimming - 200m Freestyle (w)   | AUS  | SWE    | CAN      |
| Basketball (w)                  | USA  | FRA    | AUS      |
| Gymnastics - Floor Exercise (m) | JPN  | ROU    | GBR      |
| Cycling - Road Race (w)         | NED  | ITA    | GER      |
| Tennis - Singles (m)            | ESP  | SRB    | USA      |
| Volleyball (w)                  | BRA  | CHN    | USA      |
| Archery - Individual (m)        | KOR  | ITA    | TUR      |
| Weightlifting - 73kg (w)        | CHN  | KAZ    | COL      |
| Rowing - Double Sculls (m)      | NZL  | FRA    | CHN      |
| Judo - Heavyweight (m)          | GEO  | ROC    | BRA      |
| Boxing - Lightweight (w)        | BRA  | THA    | ITA      |
| Fencing - Épée Individual (m)   | FRA  | UKR    | ITA      |
| Sailing - 470 (w)               | GBR  | NZL    | USA      |
| Shooting - 10m Air Rifle (m)    | CHN  | IRI    | USA      |
| Taekwondo - 57kg (w)            | KOR  | ROC    | TUR      |
| Triathlon (m)                   | NOR  | NZL    | BEL      |
| Badminton - Singles (w)         | CHN  | IND    | TPE      |
| Canoeing - Slalom K1 (m)        | SVK  | SLO    | GER      |
| Equestrian - Individual Jumping | SWE  | ROC    | USA      |
| Wrestling - Freestyle 65kg (m)  | JPN  | IRI    | KAZ      |
| Table Tennis - Singles (w)      | CHN  | USA    | JPN      |
| Surfing (m)                     | BRA  | JPN    | AUS      |
| Skateboarding - Park (w)        | JPN  | BRA    | GBR      |
| Sport Climbing - Combined (m)   | ESP  | JPN    | AUT      |
| Karate - Kata (w)               | ESP  | JPN    | USA      |
| Baseball (m)                    | JPN  | USA    | DOM      |
| Softball (w)                    | USA  | JPN    | CAN      |
| Rugby Sevens (m)                | FIJ  | NZL    | ARG      |
| Beach Volleyball (w)            | USA  | AUS    | BRA, GBR |

The relationships between Sport and Country and the Medals they win are:

- A country may win many medals in a sport
- A sport has many medals awarded within it (it is possible to have two countries win the same medal).

It is possible that a sport awards two of the same medal for a 'draw' or similar. 

This is known as a Many to Many relationship:

![Country and Sports - Many to Many](assets/Country-Medals-Sports-0NF.png)

### Quick Normalisation

To alleviate this we need to Normalise the data.

The actual normalisation process can be long winded, but we will simplify it here.

#### 0NF (Zero Normal Form)

This is the raw data, with no changes.


| Sport                           | Gold | Silver | Bronze |
| ------------------------------- | ---- | ------ | ------ |
| Hockey (m)                      | IND  | NED    | GER    |
| Diving - Springboard 3m (w)     | CHN  | JPN    | CHL    |
| Athletics - 100m (m)            | USA  | JAM    | CAN    |
| Swimming - 200m Freestyle (w)   | AUS  | SWE    | CAN    |

1NF (First Normal Form)

Remove Repeated Fields




Many to many relationships are easy to remove by first splitting the data into two sets. In this case Sports and Countries.

At the same time, you need to uniquely identify the rows of data, so we add an ID field (column) to the data.

#### Sports

| ID  | Name                            |
| --- | ------------------------------- |
| 1   | Hockey (m)                      |
| 2   | Diving - Springboard 3m (w)     |
| 3   | Athletics - 100m (m)            |
| 4   | Swimming - 200m Freestyle (w)   |
| 5   | Basketball (w)                  |
| 6   | Gymnastics - Floor Exercise (m) |
| 7   | Cycling - Road Race (w)         |
| 8   | Tennis - Singles (m)            |
| 9   | Volleyball (w)                  |

#### Countries

| ID  | ISO 3LC | Name                      |
| --- | ------- | ------------------------- |
| 1   | IND     | India                     |
| 2   | CHN     | Peoples Republic of China |
| 3   | USA     | United States of America  |
| 4   | AUS     | Australia                 |
| 5   | FRA     | France                    |
| 6   | JPN     | Japan                     |
| ... | ...     | ...                       |

We are only showing a few of the actual 200+ countries.

This now leaves a problem, of how we relate these two tables.

### Create the "Pivot"/"Intermediary" Table

Next we need to create a table that relates these two entities together. This is known as the Pivot Table, or Intermediary Table, or a Joining Table.

| Entity / Table | Fields | --      | --   | --  |
| -------------- | ------ | ------- | ---- | --- |
| Countries      | ID     | ISO 3LC | Name |     |
| Sports         | ID     | Name    |      |     |
| Country-Sports | ID     |         |      |     |

At the same time we need to include the data that is lost...

We need to use the Countries table's ID and the Sports table's ID to identify each row of data, plus we need to identify the type of medal won (the position or placing).

| Entity / Table | Fields | --         | --       | --               |
| -------------- | ------ | ---------- | -------- | ---------------- |
| Countries      | ID     | ISO 3LC    | Name     |                  |
| Sports         | ID     | Name       |          |                  |
| Country-Sports | ID     | Country ID | Sport ID | Position/Placing |

![Many-To-Many Resolved to One-to-Many](assets/Country-Medals-Sports-3NF.png)

## Setting Up Models, Migrations and More

Create the model, migrations, factories, and associated classes for Country and Sport:

```shell
php artisan make:model -a Country
php artisan make:model -a Sport
```

Create the pivot table migration:

```shell
php artisan make:migration create_country_sport_table
```

### Edit the migrations

The migration files will be named in the following form:

`YYYY_MM_DD_HHMMSS_create_MODELNAME_table.php`

They are found in the /database/migrations folder.

#### Sport Migration

Example filename: `2025_02_27_052413_create_sports_table.php`

The up method will read:

```php
Schema::create('sports', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->timestamps();
});
```

#### Country Migration

Example filename: `2025_02_27_052408_create_countries_table.php`

The up method will read:

```php
Schema::create('countries', function (Blueprint $table) {
	$table->id();
	$table->string('name', 192);
	$table->string('short_code', 3);
	$table->timestamps();
});
```

#### Pivot Table: Country Sport Migration

Example filename: ``

The up method now reads:

```php
Schema::create('country_sport', function (Blueprint $table) {
	$table->foreignId('country_id')->constrained();
	$table->foreignId('sport_id')->constrained();
	$table->unsignedSmallInteger('position');
});
```


### Execute the migrations

To run the new migrations use:

```shell
php artisan migrate
```

> _**IMPORTANT:**_
>
> When you use `php artisan migrate` it does **NOT** run any migrations that have been previously completed. 
>
> If you want to alter a table in any way, **ALWAYS** create a new 'update' migration, e.g. `update_users_changing_name_to_nickname` or similar.


## Create and Update Seeder Classes

### Create User Seeder

The Country seeder and Sport seeder were created when we used the `-a` CLI flag. So we will just create the User Seeder.

```shell
php artisan make:seeder UserSeeder
```

### Update the Seeders

#### User Seeder

Add/update the required use clauses:

```php
use Illuminate\Database\Console\Seeds\WithoutModelEvents;  
use Illuminate\Database\Seeder;  
use Illuminate\Support\Facades\Hash;  
use Illuminate\Support\Str;  
use App\Models\User;  

```

Now update the run method:

```php
$users = [  
    [  
        'name' => 'Ad Ministrator',  
        'email' => 'admin@example.com',  
        'email_verified_at' => now(),  
        'password' => Hash::make('Password1'),  
        'remember_token' => Str::random(10),  
        'email_verified_at' => now(),  
    ],  
    
    [  
        'name' => 'Robyn Banks',  
        'email' => 'robyn@example.com',  
        'email_verified_at' => now(),  
        'password' => Hash::make('Password1'),  
        'remember_token' => Str::random(10),  
        'email_verified_at' => now(),  
    ],  
    
    [  
        'name' => "Jacques d'Carre",  
        'email' => 'jacques@example.com',  
        'email_verified_at' => now(),  
        'password' => Hash::make('Password1'),  
        'remember_token' => Str::random(10),  
        'email_verified_at' => now(),  
    ],  
];  
  
User::insert($users);  
  
```

#### Sport Seeder

Update the Use lines to include:

```php
use App\Models\Sport;
```

Add these lines to the run method:

```php
$sports = [  
    ['name' => "Hockey (m)",],  
    ['name' => "Diving - Springboard 3m (w)",],  
    ['name' => "Athletics - 100m (m)",],  
    ['name' => "Swimming - 200m Freestyle (w)",],  
    ['name' => "Basketball (w)",],  
    ['name' => "Gymnastics - Floor Exercise (m)",],  
    ['name' => "Cycling - Road Race (w)",],  
    ['name' => "Tennis - Singles (m)",],  
    ['name' => "Volleyball (w)",],  
    ['name' => "Archery - Individual (m)",],  
    ['name' => "Weightlifting - 73kg (w)",],  
    ['name' => "Rowing - Double Sculls (m)",],  
    ['name' => "Judo - Heavyweight (m)",],  
    ['name' => "Boxing - Lightweight (w)",],  
    ['name' => "Fencing - Épée Individual (m)",],  
    ['name' => "Sailing - 470 (w)",],  
    ['name' => "Shooting - 10m Air Rifle (m)",],  
    ['name' => "Taekwondo - 57kg (w)",],  
    ['name' => "Triathlon (m)",],  
    ['name' => "Badminton - Singles (w)",],  
    ['name' => "Canoeing - Slalom K1 (m)",],  
    ['name' => "Equestrian - Individual Jumping",],  
    ['name' => "Wrestling - Freestyle 65kg (m)",],  
    ['name' => "Table Tennis - Singles (w)",],  
    ['name' => "Surfing (m)",],  
    ['name' => "Skateboarding - Park (w)",],  
    ['name' => "Sport Climbing - Combined (m)",],  
    ['name' => "Karate - Kata (w)",],  
    ['name' => "Baseball (m)",],  
    ['name' => "Softball (w)",],  
    ['name' => "Rugby Sevens (m)",],  
    ['name' => "Beach Volleyball (w)",],  
];

Sport::insert($sports);
```


#### Country Seeder

In the country seeder add the new use lines:

```php
use App\Models\Country;
```

Add these lines to the run method:

```php
 $countries = [
    ['id' => 1, 'name' => 'Afghanistan', 'short_code' => 'AFG'],
    ['id' => 2, 'name' => 'Albania', 'short_code' => 'ALB'],
    ['id' => 3, 'name' => 'Algeria', 'short_code' => 'DZA'],
    ['id' => 4, 'name' => 'American Samoa', 'short_code' => 'ASM'],
    ['id' => 5, 'name' => 'Andorra', 'short_code' => 'AND'],
    ['id' => 6, 'name' => 'Angola', 'short_code' => 'AGO'],
    ['id' => 7, 'name' => 'Anguilla', 'short_code' => 'AIA'],
    ['id' => 8, 'name' => 'Antarctica', 'short_code' => 'ATA'],
    ['id' => 9, 'name' => 'Antigua and Barbuda', 'short_code' => 'ATG'],
    ['id' => 10, 'name' => 'Argentina', 'short_code' => 'ARG'],
    ['id' => 11, 'name' => 'Armenia', 'short_code' => 'ARM'],
    ['id' => 12, 'name' => 'Aruba', 'short_code' => 'ABW'],
    ['id' => 13, 'name' => 'Australia', 'short_code' => 'AUS'],
    ['id' => 14, 'name' => 'Austria', 'short_code' => 'AUT'],
    ['id' => 15, 'name' => 'Azerbaijan', 'short_code' => 'AZE'],
    ['id' => 16, 'name' => 'Bahamas', 'short_code' => 'BHS'],
    ['id' => 17, 'name' => 'Bahrain', 'short_code' => 'BHR'],
    ['id' => 18, 'name' => 'Bangladesh', 'short_code' => 'BGD'],
    ['id' => 19, 'name' => 'Barbados', 'short_code' => 'BRB'],
    ['id' => 20, 'name' => 'Belarus', 'short_code' => 'BLR'],
    ['id' => 21, 'name' => 'Belgium', 'short_code' => 'BEL'],
    ['id' => 22, 'name' => 'Belize', 'short_code' => 'BLZ'],
    ['id' => 23, 'name' => 'Benin', 'short_code' => 'BEN'],
    ['id' => 24, 'name' => 'Bermuda', 'short_code' => 'BMU'],
    ['id' => 25, 'name' => 'Bhutan', 'short_code' => 'BTN'],
    ['id' => 26, 'name' => 'Bolivia', 'short_code' => 'BOL'],
    ['id' => 27, 'name' => 'Bosnia and Herzegovina', 'short_code' => 'BIH'],
    ['id' => 28, 'name' => 'Botswana', 'short_code' => 'BWA'],
    ['id' => 29, 'name' => 'Brazil', 'short_code' => 'BRA'],
    ['id' => 30, 'name' => 'British Indian Ocean Territory', 'short_code' => 'IOT'],
    ['id' => 31, 'name' => 'British Virgin Islands', 'short_code' => 'VGB'],
    ['id' => 32, 'name' => 'Brunei', 'short_code' => 'BRN'],
    ['id' => 33, 'name' => 'Bulgaria', 'short_code' => 'BGR'],
    ['id' => 34, 'name' => 'Burkina Faso', 'short_code' => 'BFA'],
    ['id' => 35, 'name' => 'Burundi', 'short_code' => 'BDI'],
    ['id' => 36, 'name' => 'Cambodia', 'short_code' => 'KHM'],
    ['id' => 37, 'name' => 'Cameroon', 'short_code' => 'CMR'],
    ['id' => 38, 'name' => 'Canada', 'short_code' => 'CAN'],
    ['id' => 39, 'name' => 'Cape Verde', 'short_code' => 'CPV'],
    ['id' => 40, 'name' => 'Cayman Islands', 'short_code' => 'CYM'],
    ['id' => 41, 'name' => 'Central African Republic', 'short_code' => 'CAF'],
    ['id' => 42, 'name' => 'Chad', 'short_code' => 'TCD'],
    ['id' => 43, 'name' => 'Chile', 'short_code' => 'CHL'],
    ['id' => 44, 'name' => 'China', 'short_code' => 'CHN'],
    ['id' => 45, 'name' => 'Christmas Island', 'short_code' => 'CXR'],
    ['id' => 46, 'name' => 'Cocos Islands', 'short_code' => 'CCK'],
    ['id' => 47, 'name' => 'Colombia', 'short_code' => 'COL'],
    ['id' => 48, 'name' => 'Comoros', 'short_code' => 'COM'],
    ['id' => 49, 'name' => 'Cook Islands', 'short_code' => 'COK'],
    ['id' => 50, 'name' => 'Costa Rica', 'short_code' => 'CRI'],
    ['id' => 51, 'name' => 'Croatia', 'short_code' => 'HRV'],
    ['id' => 52, 'name' => 'Cuba', 'short_code' => 'CUB'],
    ['id' => 53, 'name' => 'Curacao', 'short_code' => 'CUW'],
    ['id' => 54, 'name' => 'Cyprus', 'short_code' => 'CYP'],
    ['id' => 55, 'name' => 'Czech Republic', 'short_code' => 'CZE'],
    ['id' => 56, 'name' => 'Democratic Republic of the Congo', 'short_code' => 'COD'],
    ['id' => 57, 'name' => 'Denmark', 'short_code' => 'DNK'],
    ['id' => 58, 'name' => 'Djibouti', 'short_code' => 'DJI'],
    ['id' => 59, 'name' => 'Dominica', 'short_code' => 'DMA'],
    ['id' => 60, 'name' => 'Dominican Republic', 'short_code' => 'DOM'],
    ['id' => 61, 'name' => 'East Timor', 'short_code' => 'TLS'],
    ['id' => 62, 'name' => 'Ecuador', 'short_code' => 'ECU'],
    ['id' => 63, 'name' => 'Egypt', 'short_code' => 'EGY'],
    ['id' => 64, 'name' => 'El Salvador', 'short_code' => 'SLV'],
    ['id' => 65, 'name' => 'Equatorial Guinea', 'short_code' => 'GNQ'],
    ['id' => 66, 'name' => 'Eritrea', 'short_code' => 'ERI'],
    ['id' => 67, 'name' => 'Estonia', 'short_code' => 'EST'],
    ['id' => 68, 'name' => 'Ethiopia', 'short_code' => 'ETH'],
    ['id' => 69, 'name' => 'Falkland Islands', 'short_code' => 'FLK'],
    ['id' => 70, 'name' => 'Faroe Islands', 'short_code' => 'FRO'],
    ['id' => 71, 'name' => 'Fiji', 'short_code' => 'FJI'],
    ['id' => 72, 'name' => 'Finland', 'short_code' => 'FIN'],
    ['id' => 73, 'name' => 'France', 'short_code' => 'FRA'],
    ['id' => 74, 'name' => 'French Polynesia', 'short_code' => 'PYF'],
    ['id' => 75, 'name' => 'Gabon', 'short_code' => 'GAB'],
    ['id' => 76, 'name' => 'Gambia', 'short_code' => 'GMB'],
    ['id' => 77, 'name' => 'Georgia', 'short_code' => 'GEO'],
    ['id' => 78, 'name' => 'Germany', 'short_code' => 'DEU'],
    ['id' => 79, 'name' => 'Ghana', 'short_code' => 'GHA'],
    ['id' => 80, 'name' => 'Gibraltar', 'short_code' => 'GIB'],
    ['id' => 81, 'name' => 'Greece', 'short_code' => 'GRC'],
    ['id' => 82, 'name' => 'Greenland', 'short_code' => 'GRL'],
    ['id' => 83, 'name' => 'Grenada', 'short_code' => 'GRD'],
    ['id' => 84, 'name' => 'Guam', 'short_code' => 'GUM'],
    ['id' => 85, 'name' => 'Guatemala', 'short_code' => 'GTM'],
    ['id' => 86, 'name' => 'Guernsey', 'short_code' => 'GGY'],
    ['id' => 87, 'name' => 'Guinea', 'short_code' => 'GIN'],
    ['id' => 88, 'name' => 'Guinea-Bissau', 'short_code' => 'GNB'],
    ['id' => 89, 'name' => 'Guyana', 'short_code' => 'GUY'],
    ['id' => 90, 'name' => 'Haiti', 'short_code' => 'HTI'],
    ['id' => 91, 'name' => 'Honduras', 'short_code' => 'HND'],
    ['id' => 92, 'name' => 'Hong Kong', 'short_code' => 'HKG'],
    ['id' => 93, 'name' => 'Hungary', 'short_code' => 'HUN'],
    ['id' => 94, 'name' => 'Iceland', 'short_code' => 'ISL'],
    ['id' => 95, 'name' => 'India', 'short_code' => 'IND'],
    ['id' => 96, 'name' => 'Indonesia', 'short_code' => 'IDN'],
    ['id' => 97, 'name' => 'Iran', 'short_code' => 'IRN'],
    ['id' => 98, 'name' => 'Iraq', 'short_code' => 'IRQ'],
    ['id' => 99, 'name' => 'Ireland', 'short_code' => 'IRL'],
    ['id' => 100, 'name' => 'Isle of Man', 'short_code' => 'IMN'],
    ['id' => 101, 'name' => 'Israel', 'short_code' => 'ISR'],
    ['id' => 102, 'name' => 'Italy', 'short_code' => 'ITA'],
    ['id' => 103, 'name' => 'Ivory Coast', 'short_code' => 'CIV'],
    ['id' => 104, 'name' => 'Jamaica', 'short_code' => 'JAM'],
    ['id' => 105, 'name' => 'Japan', 'short_code' => 'JPN'],
    ['id' => 106, 'name' => 'Jersey', 'short_code' => 'JEY'],
    ['id' => 107, 'name' => 'Jordan', 'short_code' => 'JOR'],
    ['id' => 108, 'name' => 'Kazakhstan', 'short_code' => 'KAZ'],
    ['id' => 109, 'name' => 'Kenya', 'short_code' => 'KEN'],
    ['id' => 110, 'name' => 'Kiribati', 'short_code' => 'KIR'],
    ['id' => 111, 'name' => 'Kosovo', 'short_code' => 'XKX'],
    ['id' => 112, 'name' => 'Kuwait', 'short_code' => 'KWT'],
    ['id' => 113, 'name' => 'Kyrgyzstan', 'short_code' => 'KGZ'],
    ['id' => 114, 'name' => 'Laos', 'short_code' => 'LAO'],
    ['id' => 115, 'name' => 'Latvia', 'short_code' => 'LVA'],
    ['id' => 116, 'name' => 'Lebanon', 'short_code' => 'LBN'],
    ['id' => 117, 'name' => 'Lesotho', 'short_code' => 'LSO'],
    ['id' => 118, 'name' => 'Liberia', 'short_code' => 'LBR'],
    ['id' => 119, 'name' => 'Libya', 'short_code' => 'LBY'],
    ['id' => 120, 'name' => 'Liechtenstein', 'short_code' => 'LIE'],
    ['id' => 121, 'name' => 'Lithuania', 'short_code' => 'LTU'],
    ['id' => 122, 'name' => 'Luxembourg', 'short_code' => 'LUX'],
    ['id' => 123, 'name' => 'Macau', 'short_code' => 'MAC'],
    ['id' => 124, 'name' => 'North Macedonia', 'short_code' => 'MKD'],
    ['id' => 125, 'name' => 'Madagascar', 'short_code' => 'MDG'],
    ['id' => 126, 'name' => 'Malawi', 'short_code' => 'MWI'],
    ['id' => 127, 'name' => 'Malaysia', 'short_code' => 'MYS'],
    ['id' => 128, 'name' => 'Maldives', 'short_code' => 'MDV'],
    ['id' => 129, 'name' => 'Mali', 'short_code' => 'MLI'],
    ['id' => 130, 'name' => 'Malta', 'short_code' => 'MLT'],
    ['id' => 131, 'name' => 'Marshall Islands', 'short_code' => 'MHL'],
    ['id' => 132, 'name' => 'Mauritania', 'short_code' => 'MRT'],
    ['id' => 133, 'name' => 'Mauritius', 'short_code' => 'MUS'],
    ['id' => 134, 'name' => 'Mayotte', 'short_code' => 'MYT'],
    ['id' => 135, 'name' => 'Mexico', 'short_code' => 'MEX'],
    ['id' => 136, 'name' => 'Micronesia', 'short_code' => 'FSM'],
    ['id' => 137, 'name' => 'Moldova', 'short_code' => 'MDA'],
    ['id' => 138, 'name' => 'Monaco', 'short_code' => 'MCO'],
    ['id' => 139, 'name' => 'Mongolia', 'short_code' => 'MNG'],
    ['id' => 140, 'name' => 'Montenegro', 'short_code' => 'MNE'],
    ['id' => 141, 'name' => 'Montserrat', 'short_code' => 'MSR'],
    ['id' => 142, 'name' => 'Morocco', 'short_code' => 'MAR'],
    ['id' => 143, 'name' => 'Mozambique', 'short_code' => 'MOZ'],
    ['id' => 144, 'name' => 'Myanmar', 'short_code' => 'MMR'],
    ['id' => 145, 'name' => 'Namibia', 'short_code' => 'NAM'],
    ['id' => 146, 'name' => 'Nauru', 'short_code' => 'NRU'],
    ['id' => 147, 'name' => 'Nepal', 'short_code' => 'NPL'],
    ['id' => 148, 'name' => 'Netherlands', 'short_code' => 'NLD'],
    ['id' => 149, 'name' => 'Netherlands Antilles', 'short_code' => 'ANT'],
    ['id' => 150, 'name' => 'New Caledonia', 'short_code' => 'NCL'],
    ['id' => 151, 'name' => 'New Zealand', 'short_code' => 'NZL'],
    ['id' => 152, 'name' => 'Nicaragua', 'short_code' => 'NIC'],
    ['id' => 153, 'name' => 'Niger', 'short_code' => 'NER'],
    ['id' => 154, 'name' => 'Nigeria', 'short_code' => 'NGA'],
    ['id' => 155, 'name' => 'Niue', 'short_code' => 'NIU'],
    ['id' => 156, 'name' => 'North Korea', 'short_code' => 'PRK'],
    ['id' => 157, 'name' => 'Northern Mariana Islands', 'short_code' => 'MNP'],
    ['id' => 158, 'name' => 'Norway', 'short_code' => 'NOR'],
    ['id' => 159, 'name' => 'Oman', 'short_code' => 'OMN'],
    ['id' => 160, 'name' => 'Pakistan', 'short_code' => 'PAK'],
    ['id' => 161, 'name' => 'Palau', 'short_code' => 'PLW'],
    ['id' => 162, 'name' => 'Palestine', 'short_code' => 'PSE'],
    ['id' => 163, 'name' => 'Panama', 'short_code' => 'PAN'],
    ['id' => 164, 'name' => 'Papua New Guinea', 'short_code' => 'PNG'],
    ['id' => 165, 'name' => 'Paraguay', 'short_code' => 'PRY'],
    ['id' => 166, 'name' => 'Peru', 'short_code' => 'PER'],
    ['id' => 167, 'name' => 'Philippines', 'short_code' => 'PHL'],
    ['id' => 168, 'name' => 'Pitcairn', 'short_code' => 'PCN'],
    ['id' => 169, 'name' => 'Poland', 'short_code' => 'POL'],
    ['id' => 170, 'name' => 'Portugal', 'short_code' => 'PRT'],
    ['id' => 171, 'name' => 'Puerto Rico', 'short_code' => 'PRI'],
    ['id' => 172, 'name' => 'Qatar', 'short_code' => 'QAT'],
    ['id' => 173, 'name' => 'Republic of the Congo', 'short_code' => 'COG'],
    ['id' => 174, 'name' => 'Reunion', 'short_code' => 'REU'],
    ['id' => 175, 'name' => 'Romania', 'short_code' => 'ROU'],
    ['id' => 176, 'name' => 'Russia', 'short_code' => 'RUS'],
    ['id' => 177, 'name' => 'Rwanda', 'short_code' => 'RWA'],
    ['id' => 178, 'name' => 'Saint Barthelemy', 'short_code' => 'BLM'],
    ['id' => 179, 'name' => 'Saint Helena', 'short_code' => 'SHN'],
    ['id' => 180, 'name' => 'Saint Kitts and Nevis', 'short_code' => 'KNA'],
    ['id' => 181, 'name' => 'Saint Lucia', 'short_code' => 'LCA'],
    ['id' => 182, 'name' => 'Saint Martin', 'short_code' => 'MAF'],
    ['id' => 183, 'name' => 'Saint Pierre and Miquelon', 'short_code' => 'SPM'],
    ['id' => 184, 'name' => 'Saint Vincent and the Grenadines', 'short_code' => 'VCT'],
    ['id' => 185, 'name' => 'Samoa', 'short_code' => 'WSM'],
    ['id' => 186, 'name' => 'San Marino', 'short_code' => 'SMR'],
    ['id' => 187, 'name' => 'Sao Tome and Principe', 'short_code' => 'STP'],
    ['id' => 188, 'name' => 'Saudi Arabia', 'short_code' => 'SAU'],
    ['id' => 189, 'name' => 'Senegal', 'short_code' => 'SEN'],
    ['id' => 190, 'name' => 'Serbia', 'short_code' => 'SRB'],
    ['id' => 191, 'name' => 'Seychelles', 'short_code' => 'SYC'],
    ['id' => 192, 'name' => 'Sierra Leone', 'short_code' => 'SLE'],
    ['id' => 193, 'name' => 'Singapore', 'short_code' => 'SGP'],
    ['id' => 194, 'name' => 'Sint Maarten', 'short_code' => 'SXM'],
    ['id' => 195, 'name' => 'Slovakia', 'short_code' => 'SVK'],
    ['id' => 196, 'name' => 'Slovenia', 'short_code' => 'SVN'],
    ['id' => 197, 'name' => 'Solomon Islands', 'short_code' => 'SLB'],
    ['id' => 198, 'name' => 'Somalia', 'short_code' => 'SOM'],
    ['id' => 199, 'name' => 'South Africa', 'short_code' => 'ZAF'],
    ['id' => 200, 'name' => 'South Korea', 'short_code' => 'KOR'],
    ['id' => 201, 'name' => 'South Sudan', 'short_code' => 'SSD'],
    ['id' => 202, 'name' => 'Spain', 'short_code' => 'ESP'],
    ['id' => 203, 'name' => 'Sri Lanka', 'short_code' => 'LKA'],
    ['id' => 204, 'name' => 'Sudan', 'short_code' => 'SDN'],
    ['id' => 205, 'name' => 'Suriname', 'short_code' => 'SUR'],
    ['id' => 206, 'name' => 'Svalbard and Jan Mayen', 'short_code' => 'SJM'],
    ['id' => 207, 'name' => 'Swaziland', 'short_code' => 'SWZ'],
    ['id' => 208, 'name' => 'Sweden', 'short_code' => 'SWE'],
    ['id' => 209, 'name' => 'Switzerland', 'short_code' => 'CHE'],
    ['id' => 210, 'name' => 'Syria', 'short_code' => 'SYR'],
    ['id' => 211, 'name' => 'Taiwan', 'short_code' => 'TWN'],
    ['id' => 212, 'name' => 'Tajikistan', 'short_code' => 'TJK'],
    ['id' => 213, 'name' => 'Tanzania', 'short_code' => 'TZA'],
    ['id' => 214, 'name' => 'Thailand', 'short_code' => 'THA'],
    ['id' => 215, 'name' => 'Togo', 'short_code' => 'TGO'],
    ['id' => 216, 'name' => 'Tokelau', 'short_code' => 'TKL'],
    ['id' => 217, 'name' => 'Tonga', 'short_code' => 'TON'],
    ['id' => 218, 'name' => 'Trinidad and Tobago', 'short_code' => 'TTO'],
    ['id' => 219, 'name' => 'Tunisia', 'short_code' => 'TUN'],
    ['id' => 220, 'name' => 'Turkey', 'short_code' => 'TUR'],
    ['id' => 221, 'name' => 'Turkmenistan', 'short_code' => 'TKM'],
    ['id' => 222, 'name' => 'Turks and Caicos Islands', 'short_code' => 'TCA'],
    ['id' => 223, 'name' => 'Tuvalu', 'short_code' => 'TUV'],
    ['id' => 224, 'name' => 'U.S. Virgin Islands', 'short_code' => 'VIR'],
    ['id' => 225, 'name' => 'Uganda', 'short_code' => 'UGA'],
    ['id' => 226, 'name' => 'Ukraine', 'short_code' => 'UKR'],
    ['id' => 227, 'name' => 'United Arab Emirates', 'short_code' => 'ARE'],
    ['id' => 228, 'name' => 'United Kingdom', 'short_code' => 'GBR'],
    ['id' => 229, 'name' => 'United States', 'short_code' => 'USA'],
    ['id' => 230, 'name' => 'Uruguay', 'short_code' => 'URY'],
    ['id' => 231, 'name' => 'Uzbekistan', 'short_code' => 'UZB'],
    ['id' => 232, 'name' => 'Vanuatu', 'short_code' => 'VUT'],
    ['id' => 233, 'name' => 'Vatican', 'short_code' => 'VAT'],
    ['id' => 234, 'name' => 'Venezuela', 'short_code' => 'VEN'],
    ['id' => 235, 'name' => 'Vietnam', 'short_code' => 'VNM'],
    ['id' => 236, 'name' => 'Wallis and Futuna', 'short_code' => 'WLF'],
    ['id' => 237, 'name' => 'Western Sahara', 'short_code' => 'ESH'],
    ['id' => 238, 'name' => 'Yemen', 'short_code' => 'YEM'],
    ['id' => 239, 'name' => 'Zambia', 'short_code' => 'ZMB'],
    ['id' => 240, 'name' => 'Zimbabwe', 'short_code' => 'ZWE'],
];


        $chunks = array_chunk($countries, 50);

        foreach ($chunks as $chunk) {
            Country::insert($chunk);
        }

```

### Add Seeding to the Database Seeder

Modify the Database seeder to read:

```php
// \App\Models\User::factory(10)->create();
$this->call([
	UserSeeder::class,
	CountrySeeder::class,
    SportSeeder::class,
]);
```

It is important to create and seed databases from the outside in. That is, make sure that any tables that rely on other tables, have thee tables that rely on created and seeded first.

### Run the Seeders

```shell
php artisan db:seed
```

Remember that if you run the above command again, it will *add* the same data tot he database, and if any conflicts occur (e.g. unique email addresses) it will bomb out.

To execute a particular seeder use:

```shell
php artisan db:seed SEEDER_CLASS_NAME
```

For example: `php artisan db:seed UserSeeder`.

## Store Requests

If we have not used the `-a` flag when creating the model we would need to create a new request. For example a `StoreSportRequest` would be created using:

```shell
php artisan make:request StoreSportRequest
```

We do not need to do this as we created the request as part of the model creation earlier.

So let's open the request file from the `App/Http/Requests` folder.

Update the request code:

```php
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }
```

In the `authorize` method we short-cut to allow everyone to store a new sport.

In the `rules` method we short-cut to say that every field in the sports model is required...

We also give a message that is customised when a field is omitted.

```php
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'sports.*.*' => 'required',
        ];
    }

    public function messages()
    {
        return [
            'sports.*.*.required' => 'Please choose the country',
        ];
    }
```

### Create a Static Page Controller

```shell
php artisan make:controller StaticPageController
```

#### Edit the Static Page Controller

This controller is used to show pages that do not require database interaction (in general).

In the controller add the methods `__construct` and `index`:

```php
      /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function index()
    {
        return view('welcome');
    }

	public function dashboard() {
		return view('dashboard');
	}
}
```

The `__construct` method provides a quick way of indicating that the authentication middleware needs to be executed.

The `index` method returns the home page.

## Routing

Edit the web routes file, and before the `require __DIR__ . '/auth.php'`  line, add the following routes:

```php
Route::resource('/sports', SportController::class)  
    ->only(['index', 'show', 'store', 'create',]);
```

The only method tells Laravel to only respond to the routes listed. In our case they will be:

| HTTP | Route          | Route Name    | Controller      | Method Called |
| ---- | -------------- | ------------- | --------------- | ------------- |
| GET  | sports         | sports.index  | SportController | index         |
| POST | sports         | sports.store  | SportController | store         |
| GET  | sports/create  | sports.create | SportController | create        |
| GET  | sports/{sport} | sports.show   | SportController | show          |

Update the `/` route to be:

```php
Route::get('/', [StaticPageController::class, 'index'])
    ->name('home');
```


## Blade Files

When we installed the Breeze starter kit with the Blade option, we are provided with some pages ready to use.

They include:
- App layout - when logged in
- Guest layout - for guest users
- Welcome page - the default 'home' for guests
- Dashboard page - the default page for authenticated users

We will need to update these and quite a few others.

The full list of updated views, and links to source code on GitHub, includes:

| View                            | GitHub Link                                                                                                      |
| ------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| auth/confirm-password.blade.php | [Confirm Password](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/confirm-password.blade.php) |
| auth/forgot-password.blade.php  | [Forgot Password](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/forgot-password.blade.php)  |
| auth/login.blade.php            | [Login](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/login.blade.php)            |
| auth/register.blade.php         | [Register](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/register.blade.php)         |
| auth/reset-password.blade.php   | [Reset Password](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/reset-password.blade.php)   |
| auth/verify-email.blade.php     | [Verify eMail](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/auth/verify-email.blade.php)     |
| layouts/guest.blade.php         | [Guest](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/layouts/guest.blade.php)         |
| layouts/navigation.blade.php    | [Navigation](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/layouts/navigation.blade.php)    |
| welcome.blade.php               | [Welcome](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/welcome.blade.php)               |
| dashboard.blade.php             | [Dashboard](https://github.com/AdyGCode/SaaS-FED-L12-Basic-2025-S1/blob/main/resources/views/dashboard.blade.php)             |

The changes include making the Navigation available to Guest and App layouts, adding a wrapper to the Auth components so the pages render with the parts in the middle of the screen, and updating the Welcome and Dashboard 'static' pages.






