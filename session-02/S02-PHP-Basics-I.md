# PHP Basics I

PHP: Hypertext Preprocessor
[recursive acronym]

Executed:
- Using a PHP ‘interpreter’ on
- a web server

Generates output based on executed code, and data sources as required

---

PHP is…
- A server side language

Runs on many ‘platforms’:
- Linux
- Windows
- Mac OS 
- etc


---

PHP Interpreter can be executed on most modern web servers, inlcuding:
- Apache
- NginX
- IIS
- etc

---

It is FREE!

Supports wide range of databases
- MySQL, PostgreSQL, MariaDB, Oracle, MS SQL Server, MongoDB, Redis and many more
- Support is via PHP Extensions

---

# Basic PHP Page

![duck.svg|142](../assets/duck.svg)

(from: [Duck - Free animals icons (flaticon.com)](https://www.flaticon.com/free-icon/duck_2307968?term=rubber+duck&page=1&position=36&origin=search&related_id=2307968))

---
## PHP Tags

Open: `<?php`
Close: `?>`
![PHP-Basics-I-20240723160049504.png](../assets/PHP-Basics-I-20240723160049504.png)
---

## Basic Page continued

Every PHP Page must have documentation

- Indicates what it the code does
- Indicates who the code is by
- Indicates when code was started

![PHP-Basics-I-20240723160259020.png](../assets/PHP-Basics-I-20240723160259020.png)

---

## Basic PHP Continued

Setting up the template

Copy this code into your clipboard:

```php
/**
 * FILE TITLE GOES HERE
 *
 * DESCRIPTION OF THE PURPOSE AND USE OF THE CODE
 * MAY BE MORE THAN ONE LINE LONG
 * KEEP LINE LENGTH TO NO MORE THAN 96 CHARACTERS
 *
 * Filename:        ${FILE_NAME}
 * Location:        FILE_LOCATION
 * Project:         ${PROJECT_NAME}
 * Date Created:    ${DATE}
 *
 * Author:          YOUR_NAME
 *
 */
```

Open PHP Storm settings
<kbd>CTRL</kbd> + <kbd>ALT</kbd> + <kbd>S</kbd> (PC)
<kbd>CTRL</kbd> + <kbd>,</kbd> (MAC)

Locate “Editor” Option
Locate “File and Code Templates”
Click on the “Includes” tab in new dialog


---

Locate and click on “PHP File Header”
Click in the editor (right hand side)
Paste the code into this space (<kbd>CTRL</kbd> + <kbd>V</kbd>)
Edit `YOUR_NAME` and `YOUR_EMAIL_ADDRESS` to show your name ONLY
Click OK
Click OK to close settings


When you create the file, you will need to replace the `FILE_LOCATION` with the folder path the file is in. 

For example: `App/Models/`. 

Also, make sure the placeholder (All Caps) text is replaced with a one line title and, if required, a short description of the code and its purpose. If no description is needed, then the long text may be removed.

---

## Naming Conventions: Files

Filenames must:
- Start with a letter
- Use only `A`-`Z`, `a`-`z`, `0`-`9`, or the dash `-`

PHP Class Files must be:
- Pascal Case (`PascalCase`), 
- Have dashes `-` (or underscores `_`) between words

---

## New file in PhpStorm

#### Method One - The Pancake Stack

- Click on the folder the file is to be created in
- Click the "pancake stack" icon, then File (in menu)
- Click New
- Select PHP File from the list
- Type in the name of the file
	- Use only a-z, A-Z, 0-9, full stops (.) and dashes (-)

![](../assets/phpstorm64_1shbmmdaJs.gif)

#### Method Two - The Right Mouse Click

- Right Mouse click on the folder the file is to be created in
- Click New
- Select PHP File from the list
- Type in the name of the file
	- Use only a-z, A-Z, 0-9, full stops (.) and dashes (-)

![](../assets/phpstorm64_3sqVeFqzk0.gif)

#### Method Three - The Keyboard Junkie

- Press ALT + 1
- Use UP/DOWN to highlight the relevant folder
- Press ALT + INSERT
- Select PHP File
- Type in the name of the file
	- Use only a-z, A-Z, 0-9, full stops (.) and dashes (-)


![](../assets/phpstorm64_vvWkPlJBGl.gif)
---

## PHP and HTML (et al)

If the PHP has non-PHP after or surrounding it then:
- Close tag must be present on each PHP block

If the PHP Code does not have non-PHP after it then:
- Close tag may be omitted 

---

## Basic HTML Page (Empty)

If you create a new PHP file it contains (with our new template):

```

```

To add the base HTML to this file we do the following:

Close the PHP element using `?>`.

Press ENTER

Now type in `html:5` and press the TAB key...

The following will be added to the file:
```html
<!doctype html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
    <meta http-equiv="X-UA-Compatible" content="ie=edge">  
    <title>Page Title</title>  
</head>  
<body>    
  
</body>  
</html>
```

---

## PHP Within HTML

```php
<!doctype html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport"          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
    <meta http-equiv="X-UA-Compatible" content="ie=edge">  
    <title>PHP with HTML</title>  
</head>  
<body>  
<?php    
// PHP embedded inside PHP    
echo "Hello World.";  
?>  
</body>  
</html>
```

You only need to close the PHP tag if there is HTML after the PHP code.

---

## PHP After HTML

```php
<!doctype html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
    <meta http-equiv="X-UA-Compatible" content="ie=edge">  
    <title>PHP with HTML</title>  
</head>  
<body>  

</body>  
</html>

<?php    
// PHP embedded after HTML
// do something here
```


---
## PHP Before HTML

```php
<?php  
    // Add PHP code after the Document Block

?>  
<!doctype html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
    <meta http-equiv="X-UA-Compatible" content="ie=edge">  
    <title>PHP with HTML</title>  
</head>  
<body>  

</body>  
</html>
```

Note the close PHP element tag.

---

# PHP Variables

Variables must:
- Start with a `$`
- Have a letter or underscore after the `$`
- Use only `A`-`Z`, `a`-`z`, `0`-`9` and `_`
- Be camel case (`camelCase`)


---

## Examples:
Note: Images are reproduced as code 
### Valid
 ![PHP-Basics-I-20240723162125584.png](../assets/PHP-Basics-I-20240723162125584.png)

```php
$_testing = "OK";  
$theTotal = 0;
``` 

### Invalid

![[PHP-Basics-I-20240723162130870.png]]                                          

 ```php
 $another-variable = "OOPS!";  
 $test this = 0;  
 test = 1;
``` 

---

# Data Types in PHP

| Scalar types                   | Compound types                           | Special types    |
| ------------------------------ | ---------------------------------------- | ---------------- |
| bool<br>int<br>float<br>string | array<br>object<br>callable<br>iterable  | resource<br>null |
| Single value held in variable  | Variables may contain one or more values |                  |

---

## PHP Types Continued

Traditionally...
- PHP was “weakly typed”

PHP V7 changed this...
- Default to Weak Typing
- Could enable strict types

More on this later...


---

## PHP Syntax - Assignment

### Assignment
Uses the equals sign `=`

```php
$name = "Adrian";
```

### Arithmetic
All traditional arithmetic operators supported
Table shows example with integers and floats

| Operation       | Symbol | Other name | Example  |
| --------------- | ------ | ---------- | -------- |
| Plus            | +      | add        | 5 + 4    |
| Minus           | -      | Subtract   | 23.5 – 5 |
| Times           | *      | Multiply   | 2.1 * 3  |
| Divide          | /      |            | 5 / 2.5  |
| Remainder       | %      | Modulo     | 5 % 3    |
| To the power of | **     | Exponent   | 2 ** 3   |

### Priority

Normal Maths priorities apply:

- Brackets, 
- Power/Roots, 
- Multiple/Divide, 
- Add/Subtract

Brackets...
- Round brackets
- Aka Parentheses
- Used to prioritised the calculations


---

## Inc/Dec Shortcuts

Increment
- To increase, enlarge, make bigger
Decrement
- To decrease, reduce, make smaller

Three ways to do both

```php
$inc = $inc + 1;
$inc = $inc + 1234;

$dec = $dec - 1;
$dec = $dec - 75;
```

### Increment (by 1) Shortcuts

```php
$inc = $inc + 1;
$inc += 1;
$inc++;
```

### Increment (by more than one) Shortcuts

```php
$inc = $inc + 1234;
$inc += 1234;
```

### Decrement (by 1) Shortcuts

```php
$dec = $dec - 1;
$dec -= 1;
$dec--;
```

### Decrement (by more than 1) Shortcuts

```php
$dec = $dec - 1234;
$dec -= 1234;
```

## String Concatenation

Concatenation (joining) uses the full stop (`.`)

You can “add” or join strings: 

```php
“first string ” . “second string”
```

## Strings and Variables

```php
$name = "Fred"
$anotherName = 'Janelle';
$greeting = "Hello, " . $name . ".";
```

### Examples

```php
<body>
<?php
$name = "Fred";
?>
<!-- Output using PHP Echo -->
<p>Buonjourno, <?php echo $name; ?></p>
<!-- Outputting a PHP variable inside HTML -->
<p>Welcome, <?= $name ?></p>
</body>
```

### Echo Shortcuts

Long hand...
```php
<p>Buonjourno, <?php echo $name; ?></p>  
```

Short hand...
```php
<p>Welcome, <?= $name ?></p>
```

---

# PHP Arrays

- Use square brackets `[ ]`
- May be weakly typed typing
	- i.e. may contain a mix of types/values
- May be “associative”
	- This is when a key and value are paired
- Items separated by commas (`,`)
- May include a comma `,` before the closing bracket
	- we recommend doing this as less errors appear by forgetting to add a comma

### Array of integers
```php
$rainfall = [1, 5, 0, 7, 4, 6, 10];
```
### Array of strings
```php
$names = ['Amy', 'Brian', 'Charlie', 'Dave', 'Eva',
          'Frida', 'Geoff', ‘Marriette‘,'Zara'];
```

> **Note:** Do you see a problem with the above code?

### Array of floats
```php
$expenses = [25.69, 34.77, 12.4, 68.92,];
```
 
### Mixed Content
```php
$mixed = [1, "Hello", 3.5, true];
```


### Associative
- Use “key”=>”value” pairs
- Keys may be strings or integers

```php
$associative = [
    'given' => 'Adrian',
    'family' => 'Gould',
];
```


---

# PHP Strings

You have seen strings in use...

- Strings are enclosed in either
	- Quotation marks `" "` or
	- Apostrophes `' '`

Strings with quotation marks (quotes)
- May be ‘interpolated’ (see later)

If you need to include quotes in a quotes string:
- Escape the quotes using `\"`

Same for apostrophes

In a quoted (`" "`) string:
- Wrap PHP code/variables in braces (curly brackets) `{ }`
- Content in curly brackets is interpreted as PHP

Apostrophes (`' '`):
- Give the literal string (no evaluation)

Example:
```php
echo "<p>length: {$length}</p>";
```

Will display the value of the `$length` variable



---

# PHP Conditionals
| Name                     | Symbol |     Example     | Note                                                     |
| ------------------------ | :----: | :-------------: | -------------------------------------------------------- |
| Greater Than             |  `>`   |     `7 > 6`     |                                                          |
| Less Than                |  `<`   |   `'a' < 'b'`   |                                                          |
| Equal To                 |  `==`  |  `'45' == 45`   | This works as PHP does not check type by default         |
| Greater than or equal to |  `>=`  |   `76 >= 45`    |                                                          |
| Less than or equal to    |  `<=`  |   `56 <= 67`    |                                                          |
| Equivalent to            | `===`  | `'45' === '45'` | Forces PHP to check types are identical, then the values |
Conditionals are used in:
- Decisions
- Loops
- Ternary operators

# PHP Decisions

The most well known basic structure is:

```php
if ( condition(s) ) {
    // do something
} else {
    // do something else
}
```

If nothing needed for ‘`else`’ then omit it:

```php
if ( condition(s) ) {
    // do something
}
```

Successive conditions may use `elseif (condition)`

```php
if ( condition(s) ) {
    // do something
} elseif ( condition(s) ) {
    // do something else
} else {
    // do something else
}
```


### DRY Code/Comments/Models and more

[What is DRY code? (youtube.com)](https://www.youtube.com/watch?v=HwTcjWtDAfc)

<iframe width="560" height="315" src="https://www.youtube.com/embed/HwTcjWtDAfc?si=FwBdyLAKKrHfWlxF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### DRY-ing out Decisions

Using a decision to assign one of two values?

```php
if ($given > "") {
    $greeting = "Hello, {$given}.";
} else {
    $greeting = "Is anyone there?";
}
```

Dry the code by:
- Assigning the default value
- Then use the decision to update as needed
```php
$greeting = "Is anyone there?";
if ($given > "") {
    $greeting = "Hello, {$given}.";
}
```

Also, could use a ternary operator:

```php
$greeting = $given > "" ? "Hello, {$given}." : "Is anyone there?";
```

Be careful as ternary operators can become unreadable very quickly.

### DRY a True or False result?

If you are going to assign a "true" or "false" value only, then do not use a decision. For example:

```php
// Bad code
if ( $total > 100) {
  $result = true;
} else {
  $result = false;
}
```

This is much simpler to read and also shorter:

```php
// Good code
$result = $total > 100;
```

## Nesting Decisions

- When possible "flatten" out to make more readable
- example?


### Making Nested If...Then...Else Easier to Understand

[PHP: Make If-Else More Readable and Shorter (youtube.com)](https://www.youtube.com/watch?v=0vJ_SkuBgbo)

<iframe width="560" height="315" src="https://www.youtube.com/embed/0vJ_SkuBgbo?si=cXxSRnHmC0PDvqUG" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

Other videos on this (not PHP):
- [Why You Shouldn't Nest Your Code (youtube.com)](https://www.youtube.com/watch?v=CFRhGnuXG-4&t=145s)
- [Nesting "If Statements" Is Bad. Do This Instead. (youtube.com)](https://www.youtube.com/watch?v=Zmx0Ou5TNJs)
- [Stop Doing This in PHP... | Avoid Nesting If Statements | Better Coding Habits in PHP (youtube.com)](https://www.youtube.com/watch?v=6CsryA-nSEA)

### Switch vs If...Then...Else

[PHP Switch Statement - Switch vs if/else statement - Full PHP 8 Tutorial (youtube.com)](https://www.youtube.com/watch?v=egDgLO8kvtI&t=168s)

<iframe width="560" height="315" src="https://www.youtube.com/embed/egDgLO8kvtI?si=snMi2P_gBvdacL5Y" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

# Repetition

- For
- Foreach
- While
- Do while

# For 

```php
for ($count = 0; $count < 10; $count++){
    $product = 10 * $count;
    echo "<p>The product of 10 * $count is $product </p>";
}
```
# Foreach

```php
$people = ["Amy", "Brad", "Charmaine", "Dave"];

foreach($people as $person){
    echo "<p>{$person}</p>";
}
```

Using associative array...

```php
$people = [
    "Mary" => "Female", 
    "John" => "Male", 
    "Alex" => "Female",
    "Irna" => "Non-binary",
];

foreach($people as $key => $value){
   echo "<p>{$key} identifies as {$value}</p>";
}
```
# While

```php
$total = 0; 
$number = 1; 
while ($number <= 10) {
    $total += $number; 
    $number++; 
} 
echo "<p>The total is... $total</p>";
```

[An Essential Guide to PHP do-while Statement By Examples (phptutorial.net)](https://www.[PHP while (phptutorial.net)](https://www.phptutorial.net/php-tutorial/php-while/)

# Do while

```php
$count = 10; 
do { 
	echo "<p>$count...</p>";
	$count--; 
} while ($count > 0);
```

[An Essential Guide to PHP do-while Statement By Examples (phptutorial.net)](https://www.phptutorial.net/php-tutorial/php-do-while/)


https://www.phptutorial.net/ section 1
https://www.phptutorial.net/ section 2
https://www.phptutorial.net/ section 3
https://www.phptutorial.net/ section 4
https://www.phptutorial.net/ section 5
