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
created: 2024-08-02T13:12
updated: 2025-08-26T17:45
---

# Session 05 Practice Exercises and Recap

Here are your instructions for this session's Journal and other exercises and practice.

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

## Readings and Study

Make sure you have read through the following sections from PHP
Tutorial (https://phptutorial.net):

- **Sections 1–11** (To be completed before S03)
- **Sections 12–20** (To be completed before S05)

Make sure you have read through the following sections from PHP PDO Tutorial
(https://www.phptutorial.net/php-pdo/):

- **Sections 1–6** (To be completed before S05)

ake sure you have read through the following sections from PHP OOP Tutorial
(https://www.phptutorial.net/php-oop/)

- **Sections 1–7** (To be completed before S06)
- **Sections 8–15** (To be completed before S07)

## Exercises

> For these exercises you should use the template code provided here...
> - [template.php](../session-07/sample-code/template.php)

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

### Exercise 4 - Simple Table

Write the SQL to create a guestbook table in your `XXX_SaaS_FED_2024_S2` database.

The table requires the following fields and types/sizes:

| Field name               | Type        | Size | Other Details                         |
|--------------------------|-------------|------|---------------------------------------|
| id                       | Big Integer |      | Primary Key, Auto Increment, Unsigned |
| Name                     | String      | 96   | Not Null                              |
| Email                    | String      | 520  | Not Null                              |
| Subject                  | String      | 64   | Not Null                              |
| Message                  | Text        |      | Not Null                              |
| Privacy Policy Agreement | Boolean     |      | Default False                         |
| Created At               | Data Time   |      | Default to "now"                      |

If the DBMS does not have the relevant type, then substitute with the most appropriate.

Questions:

- Are spaces in a field name a good idea?
- If not, what should you replace spaces, and other special characters with?
- Would you use dunders (double underscores) in field names?

### Exercise 5 - Saving Data from a Form

Using the newly defined table, update the `contact-save` method to:

- save the form data to the database
- ensure that any database errors are shown

You do NOT have to validate any data for this exercise.

### Exercise 6 - Show Contact Book

Create a new page that will:

- Display the Name, Subject and Privacy Policy fields from the database.
- Display each as a separate line in a table
- Display in reverse order of creation date

### Exercise 7 - Create a "destroy-database" PHP file

In this exercise you will need to create a `destroy-database.php` file that:

- Removes the tables from the predefined database
- Removes a user with a predefined name
- Removes a database of a predefined name


### Exercise 8 - Create a "setup-database" PHP file

In this exercise you will need to create a `setup-database.php` file that:

- Creates a database of a predefined name
- Creates a user with a predefined name
- Gives full access to the new user to the previously created database
- Ensures the privileges are flushed.
- Creates the guestbook table in the database


