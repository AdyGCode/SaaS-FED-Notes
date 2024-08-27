

# Starting the PHP Code

We are now ready to start on the MVC framework.

As mentioned previously, we are basing the code on the Brad Traversy course.

As we work through, you may find some differences in the code we use for the UI. We will attempt to highlight these as we work through the code.

To build this demo, we will complete the components in this order:
- Composer requirements
- Configuration 
- Helpers
- Routes
- Framework
- Framework Middleware
- Public `index.php`
- App Views
- App Controllers

## Composer Requirements

In the Bash CLI enter:

```bash
touch composer.json
```

Now open this file in PhpStorm...

We need to carefully edit this file and add the following:

```json
{  
  "name": "YOUR_GITHUB_NAME/GITHUB_REPOSITORY_NAME",  
  "description": "Vanilla PHP MVC Framework Demo",  
  "type": "project",  
  "version": "0.1",  
  "time": "YYYY-MM-DD",  
  "keywords": [  
    "mvc",  
    "framework",  
    "vanilla",  
    "demo",  
    "mysql",  
    "mariadb"  
  ],  
  "minimum-stability": "stable",  
  "license": "MIT",  
  "authors": [  
    {  
      "name": "YOUR_NAME",  
      "email": "SAME_EMAIL_AS_GITHUB",  
      "homepage": "https://YOUR_GITHUB_NAME.github.io",  
      "role": "Developer"  
    },  
    {  
      "name": "Brad Traversy",  
      "email": "support@traversymedia.com",  
      "homepage": "https://www.traversymedia.com"  
    }  
  ],  
  "require": {  
    "php": ">=8.2"  
  },  
  "autoload": {  
    "psr-4": {  
      "Framework\\": "Framework/",  
      "App\\": "App/"  
    }  
  }  
}
```

As you enter this, **make sure** that you replace:
- `YOUR_GITHUB_NAME` with your GitHub user name
- `GITHUB_REPOSITORY_NAME` with your GitHub repository name, in lower case
- `SAME_EMAIL_AS_GITHUB` with the same email address as your GitHub account.
- `YOUR_NAME` with your name
- `YYYY-MM-DD` with the date you created the project.

Once you have completed this, go back to the command line and execute:

```bach
composer install
```

This will run PHP's composer package manager and create a `vendor` folder and a `composer.lock` file.

Sample output:
```text
No composer.lock file present. Updating dependencies to latest instead of installing from lock file. See https://getcomposer.org/install for more information.
Loading composer repositories with package information
Updating dependencies
Nothing to modify in lock file
Writing lock file
Installing dependencies from lock file (including require-dev)
Nothing to install, update or remove
Generating autoload files
```

If we were to add other composer packages to the project they would be added to this `composer.json` file, and the `composer.lock` would be updated. 

## Configuration

As a backup we will put a copy of the SQL we used to create our database and seed it. You may download a copy from and then move it into the `config` folder.

Now we need to create a configuration file that holds our database details.

Create a new file `db.php` in the config folder using:

```bash
touch config/db.php
```

Edit the file and add/update to read (replace with your details as needed):

```php
<?php  
/**  
 * Database Configuration File 
 * 
 * Filename:        db.php 
 * Location:        config/ 
 * Project:         SaaS-Vanilla-MVC 
 * Date Created:    DATE_CREATED 
 * 
 * Author:          YOUR NAME
 * 
 */  
return [  
    'host' => '127.0.0.1',  
    'port' => 3306,  
    'dbname' => 'xxx_saas_vanilla_mvc',  
    'username' => 'xxx_saas_vanilla_mvc',  
    'password' => 'PasswordSecret'  
];
```

This file holds the database details separate from anything we add to the framework, thus making the framework code more transferable to other projects.

## Helpers

Next we are going to add some helper code.

Create a new PHP file in the root of the project (next to the `package.json` and `composer.json` files) with the name `helpers.php`.

We are now going to edit this file and add helper functions to it.

Let's start with the header comments:

```php
<?php  
/**  
 * Helper Functions 
 * 
 * Filename:        helpers.php 
 * Location:        ${FILE_LOCATION} 
 * Project:         SaaS-FED-Notes 
 * Date Created:    DATE_CREATED 
 * 
 * Author:          YOUR NAME  
 * 
 */
```

We are going to add the following functions:
- `basePath`
- `loadView`
- `loadPartial`
- `inpsect`
- `inspectAndDie`
- `sanitize`
- `redirect`

### Function: `basePath`

The `basePath` function obtains the base path so as to provide accurate and reliable paths to files when included and used across the framework and application.

For example, if I was to use `basePath('index.php')` from within the `public` folder, then I would get a path of:
```text
C:\Users\USERNAME\Source\Repos\SaaS-Vanilla-MVC/index.php
```

This is the absolute path to this file. 

Note that it is the absolute path based on the ROOT folder.
If we wanted the path to the DB configuration file we would use:

`basePath('config/db.php')`

Here is code for the function... 

*Make sure you include the comments as they will help the editor hint you with details when using code completion.*

```php
/**  
 * Get the base path 
 * 
 * BasePath function to provide accurate paths to files 
 * 
 * @param string $path  
 * @return string  
 */
function basePath($path = '')  
{  
    return __DIR__ . '/' . $path;  
}
```

### Function: `loadView`

The `loadView` function is used to load the views we create as part of the application.

```php
  
/**  
 * Load a view * * @param string $name  
 * @return void  
 * */function loadView($name, $data = [])  
{  
    $viewPath = basePath("App/views/{$name}.view.php");  
  
    if (file_exists($viewPath)) {  
        extract($data);  
        require $viewPath;  
    } else {  
        echo "View '{$name} not found!'";  
    }  
}
```



### Function: `loadPartial`

The `loadPartial` function is used to load partial views we create as part of the application.

A partial view is a compontent that is used multiple times in the user interface. For example the head part of the HTML page, a footer, and so on.

```php

/**
 * Load a partial
 *
 * @param string $name
 * @return string
 *
 */
function loadPartial($name, $data = [])
{
    $partialPath = basePath("App/views/partials/{$name}.view.php");

    if (file_exists($partialPath)) {
        extract($data);
        require $partialPath;
    } else {
        echo "Partial '{$name} not found!'";
    }
}

```

### Functions: `inpsect` & `inspectAndDie`

The inspect and inspect and die functions are used to assist in debugging and testing.

The both dump the content of a single variable, but the latter then terminates the script.

#### Inspect

```php
/**
 * Inspect a value(s)
 *
 * @param mixed $value
 * @return void
 */
function inspect($value)
{
    echo '<pre>';
    var_dump($value);
    echo '</pre>';
}
```


#### Inspect and Die

```php

/**
 * Inspect a value(s) and die
 *
 * @param mixed $value
 * @return void
 */
function inspectAndDie($value)
{
    inspect($value);
    die();
}
```


### Functions: `dump` and `dd`

These two functions are similar to inspect and inspect and die, except they allow you to dump multiple variables out.

These two function rely on the use of PHP capability to check on arguments sent to the function, even though none are declared in the actual function definition.

To use these functions use a call similar to:

```php
<?php

$name  ="string";
$values = [1, 2, 3, 4, ];

dd($name, $values);

```

#### dump

```php

/**
 * Dump the values of one or more variables, objects or similar.
 * 
 * @return void
 */
 function dump(): void
{
    echo "<pre class='bg-gray-100 color-black m-2 p-2 rounded shadow flex-grow text-sm'>";
    array_map(function ($x) {
        var_dump($x);
    }, func_get_args());
    echo "</pre>";
}

```

#### dd

```php

/**
 * Dump the values of one or more variables, objects or similar, then terminate the script.
 * 
 * @return void
 */
 function dd(): void
{
    echo "<pre class='bg-gray-100 color-black m-2 p-2 rounded shadow flex-grow text-sm'>";
    array_map(function ($x) {
        var_dump($x);
    }, func_get_args());
    echo "</pre>";
    die();
}

```

### Function: `sanitize`

The sanitize function is used to apply a filter to the variable sent to it to 'sanitise' the HTML special characters from the content of a variable.

This HTML encodes the `'"<>&` and characters with ASCII value less than 32, optionally strip or encode other special characters.

```php
/**
 * Sanitize Data
 *
 * @param string $dirty
 * @return string
 */
function sanitize($dirty)
{
    return filter_var(trim($dirty), FILTER_SANITIZE_SPECIAL_CHARS);
}
```


### Function: `redirect`

The redirect function is used to tell the browser to go to a new location. This is ideal when you want to load a new page after a form has made a change to the data in the database.

```php

/**
 * Redirect to a given url
 *
 * @param string $url
 * @return void
 */
function redirect($url)
{
    header("Location: {$url}");
    exit;
}
```





## Routes



## Framework



## Framework Middleware



## Public `index.php`



## App Views



## App Controllers


