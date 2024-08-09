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

# SQL Examples for Each

To show how these relate to database operations, we show an example of each below.

## Browse

```sql
SELECT * from users;
```

## Retrieve

```sql
SELECT * from users 
  WHERE id = 1234;
```


## Edit

```sql
UPDATE users 
  SET name = "Juliette" 
  WHERE id = 4321;
```


## Add

```sql
INSERT INTO users (name, password) 
  VALUES ("James", PASSWORD("Some Password"));
```

## Delete

```sql
DELETE FROM users WHERE id = 666;
```


# PDO and SQL

When using 
