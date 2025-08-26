---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testng, PEST
created: 2025-04-03T10:10
updated: 2025-08-26T14:39
---

# Documenting Code

Firstly, why do you document your code?

- Industry standard practices include commenting code.
- Good habits.
- Assists your fellow developers when working on a project.
- Provides the IDE with context based documentation when coding.
- May be used to automatically generate online documentation for other developers.
- Reminds **you** of what you are doing!

With this in mind, here are some hints, tips, and good habits to use.

## When to comment

Remember that the likes of "web application development" is not just User Interface design and development, but it is probably more back-of-house code development, so code documentation is essential.

Here are some of the times you could document. The items that are optional may be omitted, the others are a *must* be included.

- When code is complex, add comments before the complex code, this does not get includes in automatically generated documentation.
- At the top of a file to indicate it's purpose, location in the project folder structure, original author, data started, etc
- Before each method/function to explain its purpose, the parameters it expects and the output it gives.
- Optionally you may add comments to indicate when properties are defined, and when methods are defined.
- Always comment PHP files that are classes, helpers etc
- Optionally use PHP comments in files that are HTML heavy, but use PHP.

All the examples below are in the ⁠[XXX-SaaS-Vanilla-MVC-YYYY-SN](https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN "https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN") ([https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN](https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN "https://github.com/adygcode/xxx-saas-vanilla-mvc-yyyy-sn")) code base.

### PHP File Header Comments (e.g. Classes, Helper Files, et al)

This shows the details of the file and a brief (one or two sentence) explanation of it's purpose.

```php
<?php
/**
 * Database Access Class
 *
 * Provides the database access tools used by our micro-framework 
 * 
 * Filename:        Database.php 
 * Location:        /Framework/ 
 * Date Created:    13/03/2025 
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>
 */ 
```

### Properties section (optional)

The example below shows how the properties section may be started.

```php
/**
 * Property Definitions 
 */
```

### Property definitions

The example below shows how a property may be commented.

```php
/** 
 * Connection property
 *
 * @var PDO 
 */
public $conn;
```

### Method Section header (optional)

```php
/**
 * Method Definitions 
 */ 
```

### Method definitions

```php
/** 
 * Constructor for Database class 
 * 
 * @param array $config 
 * @return void  
 * @throws Exception 
 */
public function __construct($config){   
    $host = $config['host'];
    $port = $config['port'];    
    $dbName = $config['dbname'];
```

Another example, including example use code:

```php
/** 
 * Query the database 
 * 
 * The SQL to execute and an optional array of named 
 * parameters and values are required. 
 * 
 * Use: 
 * <code> 
 *   $sql = "SELECT name, description from products WHERE name like '%:name%'"; 
 *   $filter = ['name'=>'ian',]; 
 *   $results = $dbConn->query($sql,$filter); 
 * </code> 
 * 
 * @param string $query 
 * @param array $params []|[associative array of parameter names and values] 
 * 
 * @return PDOStatement 
 * @throws PDOException|Exception 
 */
public function query($query, $params = [])
{
    try {
        $sth = $this->conn->prepare($query);
```

PHP file with Majority HTML (e.g. a view)

```php
<?php
/** 
 * Home Page View 
 * 
 * Filename:        home.view.php 
 * Location:        /App/views 
 * Project:         XXX-SaaS-Vanilla-MVC-YYYY-SN 
 * Date Created:    23/08/2024 
 * 
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au> 
 * 
 */
loadPartial('header');
loadPartial('navigation');
?> 
```


## Real World Examples

Laravel Framework - from the `PasswordBroker`:

```php
/**  
 * Send a password reset link to a user. 
 * 
 * @param  array  $credentials  
 * @param  \Closure|null  $callback  
 * @return string  
 */
public function sendResetLink(#[\SensitiveParameter] array $credentials, ?Closure $callback = null)  
{  
    // First we will check to see if we found a user at the given credentials and  
    // if we did not we will redirect back to this current URI with a piece of    
    // "flash" data in the session to indicate to the developers the errors.    $user = $this->getUser($credentials);  
  
    if (is_null($user)) {  
        return static::INVALID_USER;  
    }  
  
    if ($this->tokens->recentlyCreatedToken($user)) {  
        return static::RESET_THROTTLED;  
    }  
  
    $token = $this->tokens->create($user);  
  
    if ($callback) {  
        return $callback($user, $token) ?? static::RESET_LINK_SENT;  
    }  
  
    // Once we have the reset token, we are ready to send the message out to this  
    // user with a link to reset their password. We will then redirect back to    
    // the current URI having nothing set in the session to indicate errors.    $user->sendPasswordResetNotification($token);  
  
    $this->events?->dispatch(new PasswordResetLinkSent($user));  
  
    return static::RESET_LINK_SENT;  
}
```



## Conclusion

These examples should give you all a very good idea of what to do.

I know you may think this is a lot of excess work, but in the end it becomes part of your (brain's) muscle memory, and you will start to do it automatically.

These essential hints and tips will also enable you to do less work when creating API or other documentation to be used by other developers.


Long live in-code documentation!
