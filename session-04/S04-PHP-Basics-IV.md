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

# PHP Basics IV - OOP Essentials Continued


## PHP Inheritance

- Use the code from one class as the base for another class
- Parent (base or super-) class
- Child (derived or sub-) class
- Code from parent may be used by both parent and children
- use the `extends` keyword

```php
<?php
class Animal {
    public $name;

    public function eat() {
        echo $this->name . " is eating.\n";
    }
}

class Dog extends Animal {
    public function bark() {
        echo $this->name . " is barking.\n";
    }
}

$dog = new Dog();
$dog->name = "Buddy";
$dog->eat();  
$dog->bark(); 
?>

```

### Overriding Parent Methods

A child may replace the parent method:

```php
<?php
class Vehicle {
    public function start() {
        echo "Vehicle is starting.\n";
    }
}

class Car extends Vehicle {
    public function start() {
        echo "Car is starting with a roar!\n";
    }
}

$car = new Car();
$car->start(); 
?>

```

### Using a Parent's method when Overriding

If you still want to call the parent method within the child we use `parent`.

```php
<?php
class Person {
    public function greet() {
        echo "Hello from Person.\n";
    }
}

class Student extends Person {
    public function greet() {
        parent::greet(); // Call the parent method
        echo "Hello from Student.\n";
    }
}

$student = new Student();
$student->greet();

?>

```

### Child Constructors and Parent Constructors

A child may have its own constructor method.

If this is the case then the parent's constructor is not called.

This is an issue, so you must call the parent constructor before you work on the child's properties, even if all the
child constructor does is call the parent.

### Child does not have a Constructor

If you do not define a constructor for the child then the parent's is automatically used.

```php
<?php
class Vehicle {
    public function __construct($type) {
        echo "Vehicle constructor: Type is $type\n";
    }
}

class Car extends Vehicle {
    // No constructor defined, parent constructor inherited
}

$car = new Car("Sedan");
?>

```

### Calling the Parent Constructor

There are times that you will want to call the parent constructor as part of the child's constructor.

This is also known as overriding the parent constructor.

Here, we have the parent class with a property "name" being set by the constructor.

Then the child uses the parent constructor to give its name, before also adding the age property.

To call teh parent we use `parent::__construct(...)`. The `...` here represents optional parameters depending on the
parent's constructor definition.

```php
<?php
class ParentClass {
    public string $name;
    
    public function __construct(string $name) {
        echo "Parent constructor called.\n";
        $this->name = $name;
        echo "Name: $this->name\n";
    }
}

class ChildClass extends ParentClass {
    public int $age;
    
    public function __construct(string $name, int $age) {
        parent::__construct($name); // Call the parent constructor
        echo "Child constructor called.\n";
        $this->age = $age;
        echo "Name: $this->name\n";
        echo "Age: $this->age\n";
    }
}

$child = new ChildClass("Alice", 25);
?>

```

> Note we have used echo to show what is happening, we would not usually display data in this manner.

## Method Overriding (again)

Overriding allows you to define a specific, or custom, method that is based on, or completely different from the
parent's.

### Overriding the Parent Constructor

Another example:

```php
<?php
class Animal {
    public function __construct($species) {
        echo "Animal constructor: Species is $species\n";
    }
}

class Dog extends Animal {
    public function __construct($species, $breed) {
        parent::__construct($species); // Call the parent constructor
        echo "Dog constructor: Breed is $breed\n";
    }
}

$dog = new Dog("Mammal", "Golden Retriever");
?>

```

Here is another example...

```php
<?php
class Fruit {
    public $name;

    public function __construct($name) {
        $this->name = $name;
    }

    public function intro() {
        return "This is a fruit called {$this->name}.";
    }
}

class Strawberry extends Fruit {
    public function intro() {
        return "Strawberries are delicious! This one is called {$this->name}.";
    }
}

$fruit = new Fruit("Generic Fruit");
echo $fruit->intro();

$strawberry = new Strawberry("Strawberry");
echo $strawberry->intro();
?>

```

To call the parent's method we us... yes you guessed it `parent::` followed by the parent method.

For example, modifying the Strawberry class:

```php
class Strawberry extends Fruit {
    public function intro() {
        $parentInfo = parent::info();
        $childInfo =  "Strawberries are delicious! This one is called {$this->name}."
        return $parentInfo . CRLF . $childInfo; // presuming you have CRLF defined
    }
}
```

## Final Methods

The keyword `final` allows you to indicate that the method being defined the definitive definition, and it cannot be overriden.

This is a way to prevent inheritance of a method.

```php
final class ParentClass {
    public function sayHello() {
        echo "Hello from ParentClass!";
    }
}

// This will cause a fatal error because ParentClass is final and cannot be extended.
// class ChildClass extends ParentClass {}

$parent = new ParentClass();
$parent->sayHello(); // Output: Hello from ParentClass!

```


Read more on this in the PHP Tutorial [PHP Overrides](https://www.phptutorial.net/php-oop/php-override-method/).


## Abstract Classes

- Classes that cannot be instantiated.
- Typical use: defining an interface for other classes to extend.
- Use the `abstract` keyword in front of `class`.
- Define `abstract` methods in the same way.


Example showing an Abstract Class with abstract adn non-abstract methods:

```php
<?php
abstract class Animal {

    abstract protected function makeSound();

    public function sleep() {
        echo "I am sleeping...\n";
    }
}
```

So to make use of this new 'animal' class as a parent, and to complete the abstract method definition:

```php
class Dog extends Animal {

    protected function makeSound() {
        echo "Woof! Woof!\n";
    }
    
}

$dog = new Dog();
$dog->makeSound(); // Outputs: Woof! Woof!
$dog->sleep();     // Outputs: I am sleeping...
?>

```


## PHP and Interfaces

- allow the specification of a contract that a class must implement.
- methods contain no implementation code
- all methods are abstract
- may include constants
- all methods are public

Why use them?

- a class can only inherit from ONE class, but may implement zero or more interfaces!

```php
<?php

interface Vehicle {

    const TYPE = "Transport";

    public function start();
    public function stop();
    public function getFuelType();
}

// Implement the interface in a class
class Car implements Vehicle {
    private $fuelType;

    public function __construct($fuelType) {
        $this->fuelType = $fuelType;
    }

    // Implementing the methods
    public function start() {
        echo "Car is starting...\n";
    }

    public function stop() {
        echo "Car is stopping...\n";
    }

    public function getFuelType() {
        return $this->fuelType;
    }
}

// Using the class
$myCar = new Car("Petrol");
echo "Vehicle Type: " . Car::TYPE . "\n"; // Accessing the constant
$myCar->start();
echo "Fuel Type: " . $myCar->getFuelType() . "\n";
$myCar->stop();
?>

```



## Polymorphism in PHP

- Greek word meaning `many forms`.
- OOP: closely related to inheritance.
- Allows objects of different classes to respond differently based on the same message.
- Implement using either abstract classes or interfaces.
- Helps create a generic framework that takes the different object types that share the same interface.
- Which means, adding a new object type removes the need to change the framework to accommodate the new object type as long as it implements the same interface.
- It is possible to therefore reduce coupling and increase code reusability.

Using Abstract Classes

```php
<?php
abstract class Animal {

    abstract public function makeSound();

    public function move() {
        return "I can move!";
    }
}

class Dog extends Animal {
    public function makeSound() {
        return "Woof! Woof!";
    }
}

class Cat extends Animal {
    public function makeSound() {
        return "Meow! Meow!";
    }
}

class Bird extends Animal {
    public function makeSound() {
        return "Tweet! Tweet!";
    }
}

$animals = [new Dog(), new Cat(), new Bird()];

foreach ($animals as $animal) {
    echo $animal->makeSound() . PHP_EOL; // Calls the specific implementation
    echo $animal->move() . PHP_EOL;      // Calls the shared method
}
?>


```


Using Interfaces

```php
<?php
// Define an interface
interface Animal {
    public function makeSound();
}

// Implement the interface in different classes
class Dog implements Animal {
    public function makeSound() {
        return "Woof!";
    }
}

class Cat implements Animal {
    public function makeSound() {
        return "Meow!";
    }
}

class Cow implements Animal {
    public function makeSound() {
        return "Moo!";
    }
}

function animalSound(Animal $animal) {
    echo $animal->makeSound() . PHP_EOL;
}

$dog = new Dog();
$cat = new Cat();
$cow = new Cow();

animalSound($dog); // Output: Woof!
animalSound($cat); // Output: Meow!
animalSound($cow); // Output: Moo!
?>

```

## Traits

- For more details see [Traits](https://www.phptutorial.net/php-oop/php-traits/) on the PHP Tutorial site.


## Static Methods/Properties

- See [Static methods and properties](https://www.phptutorial.net/php-oop/php-static-methods/).

## Class Constants

- See [Class Constants](https://www.phptutorial.net/php-oop/php-class-constants/).

## Magic Methods, `__toString`, `__call`, and more!

- See [Magic Methods](https://www.phptutorial.net/php-oop/php-magic-methods/).
- See [`__toString`](https://www.phptutorial.net/php-oop/php-__tostring/).
- See [`__call`](https://www.phptutorial.net/php-oop/php-__call/).
- See [`__call`](https://www.phptutorial.net/php-oop/php-__call/).
- See [`__callStatic`](https://www.phptutorial.net/php-oop/php-__callstatic/).
- See [`__invoke`](https://www.phptutorial.net/php-oop/php-__invoke/).
- See [`serialize`](https://www.phptutorial.net/php-oop/php-serialize/).
- See [`unserialize`](https://www.phptutorial.net/php-oop/php-unserialize/).

Also...
- [Object Cloning](https://www.phptutorial.net/php-oop/php-clone-object/)
- [Object Comparison](https://www.phptutorial.net/php-oop/php-compare-objects/)
- [Anonymous Classes](https://www.phptutorial.net/php-oop/php-anonymous-class/)


Next: [S04-PHP-Basics-V.md](S04-PHP-Basics-V.md)
 



