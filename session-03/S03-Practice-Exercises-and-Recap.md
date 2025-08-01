---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testing, PEST
created: 2024-08-01T09:23
updated: 2025-07-22T17:14
---

# Session 02 Practice Exercises and Recap

Here are your instructions for this session's exercises and practice.

## Study

Make sure you have read through the following sections from PHP
Tutorial (https://phptutorial.net):

- **Sections 1 - 8**

## Reading

Read these articles:

https://rubygarage.org/blog/iaas-vs-paas-vs-saas

https://azure.microsoft.com/en-us/overview/what-are-private-public-hybrid-clouds/

https://www.dummies.com/programming/networking/comparing-public-private-and-hybrid-cloud-computing-options/

## Exercises

Research and explain in your own words the following terms from Software Development.

Remember that you must include a reference for each term using [MyBib](https://mybib.com) to
create the reference.

- KISS
- WET
- DRY
- YAGNI

Answer these questions:

- What do these terms mean?
    - Public cloud,
    - Private cloud, and
    - Hybrid cloud
- What do these terms mean:
    - PaaS,
    - SaaS, and
    - IaaS

Remember that you must include a reference for each term using [MyBib](https://mybib.com) to
create the reference.

Your references should be different to those included in notes, presentations or other in class
sources.

# External Coursework

Work on one of the external PHP courses.

# PHP Exercises

Complete the following PHP Exercises.

We suggest creating a new Project using PHP Storm to do this.

Name the project `SaaS-FED-S03-Exercises`.

At the start of each exercise you will see a table giving:

- folder name
- file name

Make sure you create the file in the folder identified.

Then copy the code provided into the new file, and complete the TODO tasks to match the given
output or results.

## PHP Exercise 1

| Item        | Value     |
|-------------|-----------|
| Folder name | basics    |
| File name   | hello.php |

```php
<?php

$name = 'Petra';
// TODO 

// Output:
//  hello Alice
```

## PHP Exercise 2

| Item        | Value   |
|-------------|---------|
| Folder name | basics  |
| File name   | bmi.php |

Given the following data:

| Category      | BMI                  |
|---------------|----------------------|
| Underweight   | <18.5                |
| Normal weight | 18.5–24.9            |
| Overweight    | 25–29.9              |
| Obesity       | BMI of 30 or greater |

Complete the following PHP script.

```php
<?php
<?php

// BMI = weight/height²

$weight = 60.0;
$height = 1.65;
$result;

// TODO if

// Output:
//  BMI: 22.038567493113
//  Result: Normal weight
```

## PHP Exercise 3

| Item        | Value     |
|-------------|-----------|
| Folder name | basics    |
| File name   | taxes.php |

Given the following information, complete the PHP code.

| Gross Pay in AU$        | Tax Rate % | Deductions |
|-------------------------|------------|------------|
| Under 1903.98           | –          | –          | 
| From 1903.99 to 2826.65 | 7.5        | 142.80     | 
| From 2826.66 to 3751.05 | 15.0       | 354.80     | 
| From 3751.06 to 4664.68 | 22.5       | 636.13     | 
| Over 4664.68            | 27.5       | 869.36     | 

The calculation for tax is:

- `tax = salary * taxRate - deduction`

```php
<?php

const salary = 3500;

// TODO
// Output: Payable Tax: 170.2
```

## PHP Exercise 4

| Item        | Value           |
|-------------|-----------------|
| Folder name | basics          |
| File name   | numbers-for.php |

This problem requires you to output the numbers 00 to 99 in a 10x10 square. You will use a
SINGLE for loop.

```php
<?php
// TODO for

// Output:
// 00 01 02 03 04 05 06 07 08 09
// 10 11 12 13 14 15 16 17 18 19
// 20 21 22 23 24 25 26 27 28 29
// 30 31 32 33 34 35 36 37 38 39
// 40 41 42 43 44 45 46 47 48 49
// 50 51 52 53 54 55 56 57 58 59
// 60 61 62 63 64 65 66 67 68 69
// 70 71 72 73 74 75 76 77 78 79
// 80 81 82 83 84 85 86 87 88 89
// 90 91 92 93 94 95 96 97 98 99
```

## PHP Exercise 5

| Item        | Value               |
|-------------|---------------------|
| Folder name | basics              |
| File name   | numbers-for-for.php |

This problem requires you to output the numbers 00 to 99 in a 10x10 square.

For this solution use nested For Loops.

```php
<?php
// TODO for

// Output:
// 00 01 02 03 04 05 06 07 08 09
// 10 11 12 13 14 15 16 17 18 19
// 20 21 22 23 24 25 26 27 28 29
// 30 31 32 33 34 35 36 37 38 39
// 40 41 42 43 44 45 46 47 48 49
// 50 51 52 53 54 55 56 57 58 59
// 60 61 62 63 64 65 66 67 68 69
// 70 71 72 73 74 75 76 77 78 79
// 80 81 82 83 84 85 86 87 88 89
// 90 91 92 93 94 95 96 97 98 99
```

## PHP Exercise 6

| Item        | Value                       |
|-------------|-----------------------------|
| Folder name | basics                      |
| File name   | numbers-reverse-odd-for.php |

This problem requires you to output the ODD numbers 99 to 00.

```php
<?php

// TODO for

// Output:
// 99 97 95 93 91
// 89 87 85 83 81
// 79 77 75 73 71
// 69 67 65 63 61
// 59 57 55 53 51
// 49 47 45 43 41
// 39 37 35 33 31
// 29 27 25 23 21
// 19 17 15 13 11
// 09 07 05 03 01
```

## PHP Exercise 7

| Item        | Value               |
|-------------|---------------------|
| Folder name | functions           |
| File name   | harmonic-series.php |

This problem requires you to add 1/1 + 1/2 +1/3 + 1/4 ...

You are to write a function to perform the calculation.

The function will be given an argument which indicates how many steps to use in the calculation.

```php
<?php
const size = 10;

// TODO h(10)
// Output: h(10): 2.9289682539683
```

## PHP Exercise 8

| Item        | Value        |
|-------------|--------------|
| Folder name | functions    |
| File name   | calendar.php |

You are to create a function that when it is given the starting day of the week and the number
of days in the month, will output the calendar for the month.

```php
<?php

/** calendar
 * $beginWeek: 0..6 - 0(Mon), 1(Tue), 2(Wed), 3(Thu), 4(Fri), 5(Sat), 6(Sun)
 * $endDay: 28..31
 */
function calendar($beginWeek, $endDay)
{
  // TODO
}
```

## PHP Exercise 9

This exercise continues from the previous exercise

| Item        | Value                |
|-------------|----------------------|
| Folder name | functions            |
| File name   | display-calendar.php |

You are to include the calendar file into this new file.

The new file will then test the calendar function creates the correct output for each of the
following:

```php
<?php

require __DIR__ . './calendar.php';

// Calendar

// TODO: display a month starting on Sunday and ending on the 31st

// TODO: display a month starting on Monday and ending on the 31st

// TODO: display a month starting on Tuesday and ending on the 30th

// TODO: display a month starting on Wednesday and ending on the 29th

// TODO: display a month starting on Saturday and ending on the 31st

```

## PHP Exercise 10

| Item        | Value                     |
|-------------|---------------------------|
| Folder name | arrays                    |
| File name 1 | calculate-change.php      |
| File name 2 | calculate-change-test.php |

This problem asks you to create a function that will return an array containing the minimum
combination of Australian currency values for change.

You will create the function in the `calculate-change.php` file.

The function will return an array with the corresponding number of any denomination that is
needed to provide the change in the smallest number of notes/coins.

We advise using an associative array.

### Australian Currency Values

| Note/Coin Value | $100  | $50  | $20  | $10  | $5  | $2  | $1  | 50c | 20c | 10c | 5c |
|-----------------|-------|------|------|------|-----|-----|-----|-----|-----|-----|----|
| Number of Cents | 10000 | 5000 | 2000 | 1000 | 500 | 200 | 100 | 50  | 20  | 10  | 5  |

> Important
> .
> If the change has cents, then it must be rounded as per the following:
> - 1, 2 round down to 0
> - 3, 4 round up to 5
> - 6, 7 round down to 5
> - 8, 9 round up to 10
>
> So:
> - 92c rounds to 90c
> - 89c rounds to 90c
> - 76c rounds to 75c
> - 63c rounds to 65c

```php
<?php

function calculateChange($number)
{
  // TODO
}

```

| Item        | Value                     |
|-------------|---------------------------|
| Folder name | arrays                    |
| File name   | calculate-change-test.php |

Create a second file and include the first one as needed (see starter code below).

This file will be used to output the results of the change calculation, and the expected output.

A very crude way to test your code.

```php
<?php
require __DIR__ . '/calculate-change.php';

// Minimum Change Calculation

// minimum of 1280
var_dump(calculateChange(1280));
var_dump(['$100'=>12, '$50'=> 1, '$20'=> 1, '$10'=> 1]);

// minimum of 5705
var_dump(calculateChange(57.05));
var_dump([[100, 57], [5, 1]]);
var_dump(['$50'=> 1, '$5'=> 1, '$2'=> 1, '5c'=>1]);
// minimum of 892
var_dump(calculateChange(892.92));
var_dump([[100, 8], [50, 1], [20, 2], [2, 1]]);
var_dump(['$100'=>12, '$50'=> 1, '$20'=> 1, '$10'=> 1, '50c'=>1, '20c'=>2]);

```

## PHP Exercise 11

| Item        | Value                |
|-------------|----------------------|
| Folder name | arrays               |
| File name 1 | array-utils.php      |
| File name 2 | array-utils-test.php |

In this exercise you will be implementing a set of array utilities that work on arrays of
numbers only.

In the `array-utils.php` file, add the following stubs and explanations/documentation. 

```php
<?php
/**
 * Find the minimum value in an array of values
 * 
 * @param $array
 * @return int | float
 */
function minimum($array) 
{
  // TODO
  
  return $min_value
}

/**
 * Find the maximum value in an array of values
 * 
 * @param $array
 * @return int | float
 */
function maximum($array) 
{
  // TODO
  
  return $_max_value
}

/**
 * Create an array of numbers in a given rage.
 * 
 * @param int $length required, starting value _or_ the length of the array
 * @param int $last optional, end value, default 0
 * @param int $step optional, increment between values, default 1
 * @return array
 * 
 * Example Use:
 * rangeValues(10) 
 *    --> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
 * rangeValues(1, 10) 
 *    --> [1, 2, 3, 4, 5, 6, 7, 8, 9]
 * rangeValues(0, 20, 5) 
 *    --> [0, 5, 10, 15]
 */
function rangeValues($length, $last=0, $step=1)
{
  // TODO
  
  return $array_of_values
}

/**
 * "zips" arrays together
 * 
 * @param ...$arrays
 * @return array
 * 
 * Example Use:
 * zip(['frank', 'freda'], [99, 101]) 
 *    --> [['frank', 99], ['freda', 101]]
 * zip(['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false])
 *    --> [['moe', 30, true], ['larry', 40, false], ['curly', 50, false]] 
 */
function zip(...$arrays) 
{
  // TODO
  
  return $zipped_array
}

/**
 * Removes the duplicates from the provided array
 * 
 * @param $array
 * @return array
 * 
 * Example use:
 * uniq([1, 2, 1, 4, 1, 3])
 *    --> [1, 2, 4, 3]
 */
function uniq($array) 
{
  // TODO
  
  return $unique_array
}

/**
 * Sort an array of numbers either ascending or descending
 * 
 * @param $array
 * @param $direction optional, sort ascending or descending, default true
 * @return array
 * 
 * Example use:
 * sortNum([1, 3, 2])
 *    --> [1, 2, 3]
 * sortNum([1, 3, 2], false)
 *    --> [3, 2, 1]
 */
function sortNum(array $array, bool $direction=true) 
{
  // TODO
  return $sorted_array
} 
```

In the `array-utils-test.php` file add the following for testing your functions:

```php
<?php
require __DIR__ . '/../src/array-util.php';

// Array Util

// find lowest value in [1, 4, 2, 6, 10, 3]
var_dump(minimum([1, 4, 2, 6, 10, 3]));
var_dump(1);

// find lowest value in [1, 4, -1, 6, 10, 3]
var_dump(minimum([1, 4, -1, 6, 10, 3]));
var_dump(-1);

// find greatest value in [1, 4, 2, 6, 10, 3]
var_dump(maximum([1, 4, 2, 6, 10, 3]));
var_dump(10);

// generate range of numbers from 0 to 10
var_dump(rangeValues(10));
var_dump([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);

// generate range of numbers from 1 to 11
var_dump(rangeValues(1, 11));
var_dump([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

// generate range of numbers from 0 to 10 with steps
var_dump(rangeValues(0, 30, 5));
var_dump([0, 5, 10, 15, 20, 25]);

// generate zip of [\'moe\', \'larry\'] and [30, 40]
var_dump(zip(['moe', 'larry'], [30, 40]));
var_dump([['moe', 30], ['larry', 40]]);

// generate zip of [\'moe\', \'larry\', \'curly\'], [30, 40, 50] and [true, false, false]
var_dump(zip(['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]));
var_dump([['moe', 30, true], ['larry', 40, false], ['curly', 50, false]]);

// remove duplicate values in [1, 2, 1, 4, 1, 3]
var_dump(uniq([1, 2, 1, 4, 1, 3]));
var_dump([1, 2, 4, 3]);

// remove duplicate values in [1, 2, 1, 3, 3]
var_dump(uniq([1, 2, 1, 3, 3]));
var_dump([1, 2, 3]);

// sort number values in [1, 3, 2]
var_dump(sortNum([1, 3, 2]));
var_dump([1, 2, 3]);

// sort number values in [1, 2, 10, 3, 32]
var_dump(sortNum([1, 2, 10, 3, 32]));
var_dump([1, 2, 3, 10, 32]);

// sort number values in [7, 5, 6,2, 99] descending
var_dump(sortNum([7, 5, 6, 2, 99], false));
var_dump([99, 7, 6, 5, 2]);
```