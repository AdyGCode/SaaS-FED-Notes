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
created: 2024-08-01T09:23
updated: 2025-08-26T17:31
---

# PHP Basics III - OOP Essentials

References

- https://bagor.tech/php-oop/
    - https://www.phptutorial.net/php-oop/ Section 1
    - https://www.phptutorial.net/php-oop/ Section 2
    - https://www.phptutorial.net/php-oop/ Section 3

## Revision

The four main principles of OOP are:

- **Encapsulation**:
    - Bundling data and methods that operate on the data within a single unit, or object.
- **Inheritance**:
    - Allowing a class to inherit properties and methods from another class, fostering code reuse.
- **Polymorphism**:
    - Enabling objects of different classes to be treated as objects of a common interface, providing flexibility.
- **Abstraction**:
    - Simplifying complex systems by modeling classes based on real-world entities and interactions.

---

## Defining a class

Classes should be:

- defined in a standalone PHP file
- file name must match the class' name
- **PascalCase** for class and file name

```php
/**
 * Game class
 *
 * Filename: Game.php 
 */
class Game {
    public $name;
    public $type;
    
    public function details() {
        return "Name: $name is a $type game";
    }
}
```

Using the class is done by including the class file into the PHP file that needs it:

```php
require_once 'Game.php';

$munchkin = new Game();
$munchkin->name="Munchkin";
$munchkin->type="Competitive Role-Playing Card";

echo $munchkin->details();
```

---

## Properties and Methods and Accessibility

Properties and Methods may be:

- Public:
    - Accessible from inside and outside the class.
- Private:
    - Accessible only within the class.
- Protected:
      - Accessible within the class and its subclasses.


---

## Object Constructors

PHP has the `__construct()` method that allows actions to be performed when the object is
created.

```php
class Game {
    public $name;
    public $type;
    
    public function __construct($name,$type){
        $this->name = $name ?? "";
        $this->type = $type ?? "";
    }
    
    public function details() {
        return "Name: $this->name is a $this->type game";
    }
}
```

Using the above constructor:

```php
require_once 'Game.php';

$munchkin = new Game("Munchkin","Competitive Role-Playing Card");

echo $munchkin->details();
```

---

## Object Destructors

As per construction, we can perform actions on destruction of objects:

```php
class Game {
    public $name;
    public $type;
    
    public function __destruct(){
        // Are you able to identify any situations a destruct may be useful?
    }
    
    public function details() {
        return "Name: $this->name is a $this->type game";
    }
}
```

## Typed Properties

PHP has the ability to provide Type hints. These help when coding to guide the developers
and ensuring they have the correct data type when using the property.

Revisiting the Game class:

```php
class Game {
    public string $name;
    public string $type;
    public int $price; // in cents

}
```

A nice side effect of this is that if you try accessing a property when it is not defined, you get an error.

```php
$myGame = new Game();
var_dump($myGame->name);
```

Will give an error.

But by allocating a value first this is alleviated:

```php
$myGame = new Game();
$myGame->name = "Munchkin";
var_dump($myGame->name);
```

It is better to use the constructor to initialise the properties, as we have seen:

```php
class Game {
    public $name;
    public $type;
    public int $price; // in cents
    
    public function __construct($name, $type, $price){
        $this->name = $name ?? "";
        $this->type = $type ?? "";
        $this->price = $price ?? 0;
    }
    
    public function details() {
        return "Name: $this->name is a $this->type game [RRP \$$this->price/100]";
    }
}

$myGame = new Game("Munchkin", "Competitive Role Playing, Card", 3456);
echo $myGame->name;
echo $myGame->price;

echo $myGame->details();
```

## Strict typing and Typed Properties

Using strict typing, provides another level of development security.

To enforce Strict typing (we recomment this), at the top of your PHP file (after any header comments) use the line

```php
declare(strict_types=1);
```

So for the Game example:

```php

declare(strict_types=1);

// This is one time we need to use the older "define" method for constants
define("CRLF", chr(10) . chr(13));


class Game
{
    public $name;
    public $type;
    public int $price; // in cents

    public function __construct(string $name, string $type, int $price)
    {
        $this->name = $name ?? "";
        $this->type = $type ?? "";
        $this->price = $price ?? 0;
    }

    public function details()
    {
        $format = "Name: %s is a %s game [RRP $%.2f]";
        $name = $this->name;
        $type = $this->type;
        $price = $this->price / 100; // convert cents to $
        return sprintf($format, $name, $type, $price);
    }
}

$myGame = new Game("Munchkin", "Competitive Role Playing, Card", 3456);

echo $myGame->name . CRLF;
echo $myGame->price . CRLF;

echo $myGame->details() . CRLF;
```

BTW: we have split the `sprintf` line into parts to make it easier to read, and used temporary (method local) variables.

## Read Only (RO) Properties

We create a RO Property using `readonly` as part of the property definition.

```php
class Game
{
    public string $name;
    public string $type;
    public int $price; // in cents
    public readonly int $year;
    
} 
```

You cannot then give it a value without the use of a "**setter**".

```php
class Game
{
    public readonly string $name;

    public function setName(string $name): void
    {
        $this->name = $name;
    }
    
}

$myGame = new Game();
$myGame->setName('Munchkin Revenge');

echo $myGame->name;
```

This allows you to create the property, and then assign it a value **ONLY ONCE**. It cannot be updated.

You can also achieve this using the constructor:

```php
class Game
{
    public string $name;
    public string $type;
    public int $price; // in cents
    public int $year;
    public function __construct(string $theName, string $theType, int $thePrice, readonly int $theYear)
    {
        $this->name = $theName ;
        $this->type = $theType ;
        $this->price = $thePrice;
        $this->year = $theYear;
    }
 
 // ...
    
}   
```

## Mutability, Typed Properties and ReadOnly

Notes on properties:

- a property without a type has a default of `null`
- you **must** have a type with a `readonly` property.
- `readonly` does not guarantee "immutability"

For more details and examples
see [Read Only, Typed and Immutable Properties](https://www.phptutorial.net/php-oop/php-readonly-properties/#readonly-typed-properties)
from the PHP Tutorial.

Next: [S04-PHP-Basics-IV.md](S04-PHP-Basics-IV.md)
