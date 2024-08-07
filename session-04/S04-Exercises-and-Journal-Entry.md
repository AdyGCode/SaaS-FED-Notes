# Session 04 Exercises and Journal Entry

Here are your instructions for this session's Journal and other exercises and practice.

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

## Journal

## Study

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

### Exercise 4

We will start by refactoring the files we currently have:

- rename the contact-save.php to contact-form-display.php

Create the following PHP files:

- `contact-save.php`
- `database.php`

In the `database.php` file create a database class that may be
used to connect to, and then access the `XXX_SaaS_FED_2024_S2` database.

In the contact-save.php file you are to save the data to the database 
in a table called `form_submissions`.