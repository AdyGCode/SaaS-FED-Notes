# PHP Basics VII -  PDO Continues!

https://www.phptutorial.net/php-pdo/ Section 3
https://www.phptutorial.net/php-pdo/ Section 4
https://www.phptutorial.net/php-pdo/ Section 5
https://www.phptutorial.net/php-pdo/ Section 6
https://www.phptutorial.net/php-pdo/ Section 7


# BREAD & CRUD

BREAD and CRUD are two acronyms that represent interaction with databases.

Whilst CRUD is more commonly used, the BREAD acronym provides a little more context, and within many application solutions that are developed, the retrieval of a single resource item is one of the most heavily used.

**BREAD**
- **B** Browse *(many)*
- **R** Retrieve *(one)*
- **E** Edit
- **A** Add
- **D** Delete
**CRUD**
- **C** Create
- **R** Retrieve *(one or more)*
- **U** Update
- **D** Delete

The **R** (Retrieve) in CRUD is equivalent to the **BR** (Browse, Retrieve) in BREAD.

Retrieve may also be replaced by Read.

# SQL Examples for BREAD/CRUD

To show how these relate to database operations, we show an example of each below.

## Browse/Read

```sql
SELECT * from users;
```

## Retrieve/Read

```sql
SELECT * from users 
  WHERE id = 1234;
```


## Edit/Update

```sql
UPDATE users 
  SET name = "Juliette" 
  WHERE id = 4321;
```


## Add/Create

```sql
INSERT INTO users (name, password) 
  VALUES ("James", PASSWORD("Some Password"));
```

## Delete/Delete

```sql
DELETE FROM users WHERE id = 666;
```


# PDO and SQL

When using PHP to interact with A database we use PDO, or PHP Data Objects.

PDO gives us very robust methods to interact with a database using SQL, and more predictable results by using prepared statements.

## Good Techniques

There are a number of good techniques to use when developing a PHP based application.

We will look at some of them as we progress, starting with using a "config" file.

## Config File

A config file is a method to keep "secrets" and other data in one location.

We can do this by having `config.php` file or a `.env` file. The latter will need to be read and processed to provide the settings to the application, whilst the former can be simply included.

### Example `config.php`

```php
<?php  
/**  
 * Basics of PDO: DB configuration file 
 * 
 * Filename:        config.php 
 * Location:        /session-04 
 * Date Created:    2024-08-07 
 * 
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>  
 * 
 */  
 
$dbHost = 'localhost';  
$dbName = 'XXX_SaaS_FED_2024_S2';  
$dbUser = 'XXX_SaaS_FED_2024_S2';  
$dbPass = 'Password1234';
```

## Database Connection File

Another good technique is to centralise the database connection code, so as to dry out the repetition from your application.

In the previous lecture we created a file that did not use OOP techniques. The example below uses OOP to define a database class, that is then instantiated as required.

### Example `Connection.php` Class

The following code creates a new class called Connection, and within it a static method to instantiate the DB connection.

```php
<?php

require_once 'config.php';

class Connection
{
	public static function make($host, $db, $user, $password)
	{
		$dsn = "mysql:host=$host;dbname=$db;charset=UTF8";

		try {
			$options = [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION];

			return new PDO($dsn, $username, $password, $options);
		} catch (PDOException $e) {
			die($e->getMessage());
		}
	}
}

return Connection::make($host, $db, $user, $password);
```

Ref: [PHP PDO MySQL (phptutorial.net)](https://www.phptutorial.net/php-pdo/php-pdo-mysql/)

Important items in this code:
- `make` is a static method that is use to create the connection
- `PDO::ATTR_ERMODE` is the type of errors we want, in this case exceptions (`PDO::ERRMODE_EXCEPTION`)
- The last line, `return`, calls the `make` method when the file is included and returns the connection details.

The last item is a little strange, but when used int he following manner, will create a connection and store the details in the variable `$pdo` ready for use.

```php
<?php
$pdo = require 'Connection.php';
```

## Prepared Statements

Prepared statements in the context of PHP and SQL can mean two things:

- An SQL Prepared statement that is stored as part of the database.
- An SQL Statement that is part of the PHP code with placeholders where values will be inserted.

We will look at the latter.

Whilst there are at least two different ways to prepare a statement in PHP PDO, we will use placeholders as this makes it much more explicit as to what you are targeting in the SQL, and also makes it easier if you cannot recall the order of the placeholders.

```php
$sql = "INSERT INTO demo(name, colour, owned) "  
     . "VALUES( :name, :colour, :owned)"
```

The above code provides us with a table, `demo` and three fields, `name`, `owned` and `colour` that data will be inserted into.

It also provides three placeholders `:name`, `:colour`, `:owned` where we will replace these placeholders with the data to be inserted.

To use these we write PHP code similar to this:

```php
$pdo = require 'Connection.php';

$sql = "INSERT INTO demo(name, colour, owned) "  
     . "VALUES( :name, :colour, :owned)";  
  
$statement = $pdo->prepare($sql);  
  
$name = 'Count Duckula';  
$colour = 'black';  
$owned = 1; // 0 used in place of FALSE (1 = TRUE)  
  
$statement->bindValue(":name", $name, PDO::PARAM_STR);  
$statement->bindValue(":colour", $colour);  
$statement->bindValue(":owned", $owned, PDO::PARAM_BOOL);  
  
$statement->execute();
```

Key points of this code:
- We use the Connection class and static  make method to create the $pdo instance.
- We prepare the SQL statement ready for placeholder replacement.
- We define the values to be inserted.
- We bind the placeholders to the required values, and specify the type of data to be bound.
- We execute the SQL statement.

## BREAD Operations using Prepared Statements

We provide examples of each of the BREAD (aka CRUD) actions as example PHP code.

### Browse

```php
$pdo = require 'Connection.php';

$sql = "SELECT name, colour, owned FROM demo "  
     . "ORDER BY name";  
  
$statement = $pdo->prepare($sql);  
  
$statement->execute();

$records = $statement->fetchAll();
```


### Read

```php
$pdo = require 'Connection.php';

$sql = "SELECT name, colour, owned FROM demo "  
     . "WHERE id = 3";  
  
$statement = $pdo->prepare($sql);  
  
$statement->execute();
  
$records = $statement->fetchAll();
```

This produces an array containing one record that is an associative array with the name, colour and owned fields.

To get the first result, and return an associative array we use:

```php
  
$pdo = require 'Connection.php';  
  
$sql = "SELECT name, colour, owned FROM demo "  
    . "WHERE id = 3";  
  
$statement = $pdo->prepare($sql);  
  
$statement->execute();  
  
$record = $statement->fetch();  
```


### Edit

```php
$pdo = require "Connection.php";  
  
$sql = "UPDATE demo "  
    . "SET name = :name, "  
    . "SET colour = :colour, "  
    . "SET owned = :owned "  
    . "WHERE id = 1";  
  
$statement = $pdo->prepare($sql);  
  
$name = 'Count Duckula';  
$colour = 'black';  
$owned = false;  
  
$statement->bindValue(":name", $name, PDO::PARAM_STR);  
$statement->bindValue(":colour", $colour);  
$statement->bindValue(":owned", $owned, PDO::PARAM_BOOL);  
  
$statement->execute();
```



### Add

```php
$pdo = require 'Connection.php';

$sql = "INSERT INTO demo(name, colour, owned) "  
     . "VALUES( :name, :colour, :owned)";  
  
$statement = $pdo->prepare($sql);  
  
$name = 'Count Duckula';  
$colour = 'black';  
$owned = 1; // 0 used in place of FALSE (1 = TRUE)  
  
$statement->bindValue(":name", $name, PDO::PARAM_STR);  
$statement->bindValue(":colour", $colour);  
$statement->bindValue(":owned", $owned, PDO::PARAM_BOOL);  
  
$statement->execute();

```



### Delete

```php
$pdo = require "Connection.php";  
  
$sql = "DELETE FROM demo  "  
    . "where id = :id";  
  
$statement = $pdo->prepare($sql);  
  
$id = 7;  
  
$statement->bindValue(":id", $id, PDO::PARAM_INT);  
  
$statement->execute();
```


### Bonus: Create Multiple Records

```php
$pdo = require 'Connection.php';

$ducks = [
	['name'=>'Donald','colour'=>'white','owned'=>false,],
	['name'=>'Daffy','colour'=>'black','owned'=>true,],
	['name'=>'April','colour'=>'white','owned'=>false,],
	['name'=>'Quackup','colour'=>'blue','owned'=>true,],
];

$sql = "INSERT INTO demo(name, colour, owned) "  
     . "VALUES( :name, :colour, :owned)";  

foreach ($ducks as $duck){
	$statement = $pdo->prepare($sql);  
  
	$statement->bindValue(":name", $duck['name'], PDO::PARAM_STR);  
	$statement->bindValue(":colour", $duck['colour']);  
	$statement->bindValue(":owned", $duck['owned'], PDO::PARAM_BOOL);  
  
	$statement->execute();
}

```


### Bonus: Using IN within a Prepared Statement

If you want to retrieve certain records based on their `id` from a table then the `IN` SQL construct is very useful.

Here is an example:

```sql
SELECT name, colour, owned FROM demo WHERE id IN (1, 3, 4);
```

Now to implement this using the techniques we have seen with `bindValue`, we could write the following code:

```php
$pdo = require 'Connection.php';  
  
$list = [1,3,4];  
  
$placeholder = "";  
for ($count = 0; $count < count($list); $count++) {  
    $placeholders [$count]= ":id". str_pad($count, 2, '0', STR_PAD_LEFT);  
}  
  
$placeholder = implode(", ",$placeholders);  
  
$sql = "SELECT name, colour, owned FROM demo "  
    . "WHERE id in ( {$placeholder} )";  
  
$statement = $pdo->prepare($sql);  
  
foreach ($placeholders as $key=>$placeholder) {  
    $statement->bindValue($placeholder, $list[$key]);  
}  
  
$statement->execute();  
  
$records = $statement->fetchAll(PDO::FETCH_ASSOC);
```


