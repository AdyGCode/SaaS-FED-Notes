# Session 05 Exercises and Journal Entry

Here are your instructions for this session's Journal and other exercises and practice.

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

## Journal

Review the content so far, and note what has been learned.

# External Coursework

PHP From Scratch

- [Database & PDO](https://www.traversymedia.com/products/php-from-scratch-beginner-to-advanced/categories/2154269413)

# Exercises

Remember we use the bash (git-bash) terminal for our command line work.

On Windows devices you will need to install and run the Windows Terminal application, then configure it to use the `git-bash` CLI.

Useful links for this:

- [Windows terminal on Microsoft Store](https://apps.microsoft.com/detail/9n0dx20hk701?hl=en-gb&gl=AU)
- [Setting up Git bash on Windows Terminal](https://help.screencraft.net.au/hc/2680392001/65/add-git-bash-to-microsoft-terminal?category_id=35)
- [Adding Command Line Aliases to make you life easier](https://help.screencraft.net.au/hc/2680392001/66/add-bash-command-line-aliases-for-git?category_id=35)

## Exercises Preparation

Before commencing, open a (bash) terminal and follow these instructions, replacing `XXX` with your (lowercase) initials.

```shell

mkdir XXX-mvc-jokes
cd XXX-mvc-jokes
git init .
mkdir -p assets/{css,js,img,downloads}
mkdir src includes public database templates
touch ReadMe.md .gitignore 
touch {src,includes,public,database,templates}/.gitignore
touch assets/{css,js,img,downloads}/.gitignore
npm install -D tailwindcss
npx tailwindcss init
git add ReadMe.md .gitignore
git commit -m "init: Start of MVS Project
```

Following these commands, open the folder as a PhpStorm project and check the structure is similar to the following image (it is missing the`database` folder):

![](../assets/phpstorm64_k2K8iLNCwl.png)

## Exercise 1

Edit the `tailwind.config.js` file and edit/add:

```js
/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./**/*.{php,html}",
        "./assets/js/*.js",
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
```

### Exercise 1

Create a new SQL file (filename: `setup.sql`) and save it in the database folder.

At the top of the file add a suitable comment describing the purpose of the file, the author, date created and the
version.

```text
/*  
 * ONE LINE PURPOSE OF THE FILE 
 * 
 * Author:  YOUR NAME 
 * Created: YYYY-MM-DD
 * Version: 1.0
 * 
 */
```

In the SQL file create the SQL to do the following:

- If the database `xxx_mvc_jokes` exists, drop it.
- If the user `xxx_mvc_jokes` exists, drop it.
- Create the database  `xxx_mvc_jokes`.
- Create the user `xxx_mvc_jokes` allowing them access from `127.0.0.1` with the password of `Password1234`.
- Grant the user full access to the `xxx_mvc_jokes` database.
- Grant the user usage on all databases.

> **Note:** Remember that users and databases can only use lower case letters, numbers and the underscore.
>
> It is convention to only use LOWER CASE and UNDERSCORE.

### Exercise 2

Create a new SQL file called `tables.sql`.

At the top of the file add a suitable comment describing the purpose of the file, the author, date created and the
version.

```text
/*  
 * ONE LINE PURPOSE OF THE FILE 
 * 
 * Author:  YOUR NAME 
 * Created: YYYY-MM-DD
 * Version: 1.0
 * 
 */
```

In this file add the SQL to create the following tables with the provided specifications.

> Remember that field and table names MUST only contain `a`-`z` and underscore (`_`).
>
> It is convention to only use LOWER CASE and UNDERSCORE.

| Table Name | Field Name | Type                 | Length | Default           | Other         |
|------------|------------|----------------------|--------|-------------------|---------------|
| jokes      | id         | unsigned big integer |        |                   | Autoincrement |
|            | question   | text                 |        |                   |               |
|            | answer     | text                 |        |                   | Nullable      |
|            | tags       | varchar              | 192    |                   | Nullable      |
|            | created at | datetime             |        | CURRENT_TIMESTAMP |               |
|            | updated at | datetime             |        | null              | nullable      |
|            | author id  | unsigned big integer |        | 0                 |               |
|            |            |                      |        |                   |               |

This table should have the following indexes added:

```sql
PRIMARY KEY (`id`),  
FULLTEXT `joke_text` (`joke`),  
FULLTEXT `tag_index` (`tags`)
```

The second tables details are:

| Table Name | Field Name    | Type                 | Length | Default                    | Other         |
|------------|---------------|----------------------|--------|----------------------------|---------------|
| users      | id            | unsigned big integer |        |                            | Autoincrement |
|            | given name    | varchar              | 64     |                            | not null      |
|            | family name   | varchar              | 64     |                            | nullable      |
|            | email         | varchar              | 320    |                            | not null      |
|            | user password | varchar              | 255    | md5 version of 'Password1' | not null      |
|            | created at    | datetime             |        | CURRENT_TIMESTAMP          |               |
|            | updated at    | datetime             |        | null                       | nullable      |
|            |               |                      |        |                            |               |

This table should have the following indexes as part of its definition:

```sql
PRIMARY KEY (`id`),  
UNIQUE `email_index` (`email`),  
INDEX  `given_family`(`given_name`,`family_name`),  
INDEX  `family_given`(`family_name`,`given_name`)
```

### Exercise 3

Create a suitable `config.php` file in the root of your project, and add variables as described below:

- dbUser
- dbPass
- dbHost
- dbName

### Exercise 4

Create a new Class file called `Connection.php` file in the includes folder.

This connection class will use a static method `make` to create and return a PDO instance.

### Exercise 5

Create a PHP Class file called `Utilities.php` in the includes folder.\

The Utilities class will provide a number of static methods that include:

- `dump` which will dump the contents of one or more variables in a suitably formatted way.
- `dd` which will dump the contents of one or more variables then terminate the script using the `die()` function

### Exercise 6

Create a new file `db-test.php` in the root of your project.

This file is to:

- connect to your database
- dump the PDO connection information

### Exercise 7

Create a basic HTML5 web page in the templates folder and name it `template.html`.

Edit the template file and update the required parts to include tghe new lines from below 

```html
    <!-- Stylesheets and Fonts -->  
    <link rel="stylesheet" href="/assets/css/site.css">  
          
<!-- Pre-page load and deferred JavaScript -->  

</head>  
<body>  
  
  
<!-- Post Page load JavaScript -->
</body>
```

Use this file to help build the next two files.

Create a `header.php` file in the `templates` folder

- The file will contain the standard HTML5 code up to `<body>`

Create a `footer.php` file in the `templates` folder

- this file will contain the end of the template including the comment added to the template file.


### Exercise 8

Create a new folder called `views`, and inside this folder two more folders, one for `users` and one for `jokes`.

Make sure that all three folders have `.gitignore` files using the `touch` command.


### Exercise 9

In the `views/users` folder create a PHP file (`index.php`) that uses the echo command to show "Users Index".

In the `views/jokes` folder create a PHP file (`index.php`) that uses the echo command to show "Jokes Index".


In the public folder, create an `index.php` file that:

- Provides a link to the users index page.
- Provides a link to the jokes index page.


### Exercise 10

Create a new file `app.css` in the `src` folder.

In this file add:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Exercise 11

Start a new git bash terminal, and use the following commands:

```bash
cd xxx-mvc-jokes
npx tailwindcss -i ./src/app.css -o ./assets/css/site.css --watch
```

This should watch for changes in your `html`, `php` and `js` files and automatically rebuild the `site.css` file for you.

### Exercise 12

