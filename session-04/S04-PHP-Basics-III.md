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
updated: 2025-03-12T09:28
---

# PHP Basics III - OOP Essentials

References

- https://bagor.tech/php-oop/
  - https://www.phptutorial.net/php-oop/ Section 1
  - https://www.phptutorial.net/php-oop/ Section 2
  - https://www.phptutorial.net/php-oop/ Section 3



## Revision

The four main principles of OOP are:

- Encapsulation: 
  - Bundling data and methods that operate on the data within a single unit, or object.
- Inheritance: 
  - Allowing a class to inherit properties and methods from another class, fostering code reuse.
- Polymorphism: 
  - Enabling objects of different classes to be treated as objects of a common interface, providing flexibility.
- Abstraction: 
  - Simplifying complex systems by modeling classes based on real-world entities and interactions.

---

## Defining a class

Classes should be:
- defined in a standalone PHP file
- file name must match the class' name
- PascalCase for class and file name

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
  - Accessible from outside the class.
- Protected: 
  - Accessible within the class and its subclasses.
- Private: 
  - Accessible only within the class.

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
        return "Name: $name is a $type game";
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
        return "Name: $name is a $type game";
    }
}
```
