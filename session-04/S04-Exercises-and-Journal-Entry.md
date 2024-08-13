# Session 04 Exercises and Journal Entry

Here are your instructions for this session's Journal and other exercises and practice.

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```
The journal entry this week will contain the following:

- A summary of what you have learned, including any topics you found difficult to follow.
- Any research you performed as part of the consolidation learning.

Remember to use MyBib to add links/references to your research.

## Out of Class Study

Make sure you have read through the following sections from [PHP OOP - Object-oriented Programming in PHP (phptutorial.net)](https://www.phptutorial.net/php-oop/):

- **Sections 1 - 7 if not already completed
- **Sections 8 - 15**

# External Coursework

PHP From Scratch
- [OOP - Object Oriented Programming](https://www.traversymedia.com/products/php-from-scratch-beginner-to-advanced/categories/2154265677)
- [Superglobals](https://www.traversymedia.com/products/php-from-scratch-beginner-to-advanced/categories/2154265741)



## Exercises

### Exercise 1 - Contact Form

Take the idea of a Contact form and create one using HTML, 
PHP and CSS (TailwindCSS).

The file will be called `contact.php`.

The form must have the following fields:

- Name (Text)
- Email (Text)
- Subject (Select from: Website issue, Quote for work, Other)
- Message (Textbox)
- Privacy Policy (Checkbox)

The form will have `submit` and `clear` buttons.

The `submit` button sends the form data and `clear` clears 
the form's content.

The form will submit to a file called `contact-save.php`.

### Exercise 2 - Contact Save

The `contact-save.php` file will do the following:

Display the content of the `POST` method on a page, **WITHOUT** using the
`var_dump` function.

> **Hint:**
> You will need to use the `$_POST` super-global, and a loop to do this.

### Exercise 3 - Simple Database

In this exercise we will create a basic MySQL/MariaDB database
for testing purposes.

The database will be named `XXX_SaaS_FED_2024_S2` where `XXX` is replaced
by your initials.

The database user will be `XXX_SaaS_FED_2024_S2` with the 
password `Password1234`.

What is the SQL used to:

- Create the new database?
- Create the new user with the given password?
- Give the new user permission to access the database?
