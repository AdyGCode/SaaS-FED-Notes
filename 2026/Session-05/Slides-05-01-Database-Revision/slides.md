---
theme: nmt
background: https://cover.sli.dev
title: Session 05 - Database Revision
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 05: Database Revision 

## SaaS 1 – Cloud Application Development (Front-End Dev)

## SaaS 2 – APIs & NoSQL (Back-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
layout: default
level: 2
---

# Navigating Slides

Hover over the bottom-left corner to see the navigation's controls panel.

## Keyboard Shortcuts

|                                                     |                             |
|-----------------------------------------------------|-----------------------------|
| <kbd>right</kbd> / <kbd>space</kbd>                 | next animation or slide     |
| <kbd>left</kbd>  / <kbd>shift</kbd><kbd>space</kbd> | previous animation or slide |
| <kbd>up</kbd>                                       | previous slide              |
| <kbd>down</kbd>                                     | next slide                  |

---
layout: section
---

# Objectives

---
layout: two-cols
level: 2
class: text-left
---

# Objectives

By the end of this session, students will be able to:

::left::

- Explain the purpose of database normalisation beyond Third Normal Form (3NF)
- Identify functional, partial, transitive, and multi‑valued dependencies
- Interpret and create ERDs for progressively normalised designs
- Resolve one‑to‑many and many‑to‑many relationships correctly

::right::

- Apply Fourth Normal Form (4NF) and Fifth Normal Form (5NF) where appropriate
- Convert ERDs into valid SQL DDL statements
- Apply appropriate keys and constraints to enforce data integrity
- Explain when and why **controlled denormalisation** is justified
- Compare normalisation strategies in **OLTP vs OLAP** systems


<!-- Presenter Notes:

-->

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2" />


---
layout: section
level: 1
---

# Databases: Terminology

<br>

<Announcement type="brainstorm" style="margin-left: 24rem;">
<p style="line-height: 2rem; margin-top:0; margin-bottom:0;padding:1rem;">
Autumn branches split<br>
Tables, graphs, documents flow<br>
One soil beneath all
</p>
</Announcement>


---
level: 2
layout: two-cols
---

# Databases: Terminology

## Major types

:: left::

### Relational (SQL)

- Fixed schema
- Tables & rows
- SQL queries
- ACID transactions
- Strong consistency
- Vertical scaling
- Normalized data

::right::

### NoSQL

- Flexible schema
- Document / key-value
- Non-SQL access
- BASE consistency
- Eventual consistency
- Horizontal scaling
- Denormalized data

<!-- Presenter Notes:

Relational Databases:

- Fixed schema: Structure defined upfront; changes require migrations
- Tables & rows: Data organised into relations with primary/foreign keys
- SQL queries: Standardized query language (SELECT, JOIN, etc.)
- ACID transactions: Guarantees reliability and data integrity
- Strong consistency: All users see the same data at the same time
- Vertical scaling: Increase power of a single server
- Normalized data: Reduce duplication, improve integrity

NoSQL Databases:

- Flexible schema: Fields can vary per record
- Document / key-value: Includes document, key-value, column, graph models
- Non-SQL access: APIs or query languages vary by database
- BASE consistency: Prioritises availability and scalability
- Eventual consistency: Data syncs across nodes over time
- Horizontal scaling: Add more servers easily
- Denormalized data: Optimised for read performance

Summary:

- Use RDBMS for structured, transactional data
- Use NoSQL for large-scale, flexible, high‑performance systems

-->


---
level: 2
---

# Databases: Terminology

## Example SQL/RDBMS Implementations

There are many database engines available.

| RDBMS           | Quick Summary                                                 |
|-----------------|---------------------------------------------------------------|
| SQLite          | Embedded database with no user management                     |
| MySQL / MariaDB | Simple multi‑user RDBMS for web apps                          |
| PostgreSQL      | Powerful open‑source RDBMS with strong access control         |
| SQL Server      | Enterprise RDBMS tightly integrated with Microsoft ecosystems |
| Oracle          | Highly complex enterprise RDBMS with advanced security        |

---
level: 2
---

# Databases: Terminology

## Example NoSQL Implementations

| NoSQL     | Quick Summary                                                                   |
|-----------|---------------------------------------------------------------------------------|
| MongoDB   | Document database designed for flexible schemas & rapid application development |
| Cassandra | Distributed column‑store optimised for massive scale & high availability        |
| Redis     | In‑memory key–value store optimised for speed, caching, & transient data        |
| DynamoDB  | Fully managed cloud key–value database built for horizontal scalability         |
| CouchDB   | Document database focused on replication & offline‑first synchronisation        |
| Neo4j     | Graph database designed for managing & querying relationships                   |

<!-- Presenter Notes:

- MongoDB → “My data shape changes often”
- Cassandra → “I need to scale across many servers”
- Redis → “I need extremely fast access”
- DynamoDB → “I want serverless scalability”
- CouchDB → “I need sync and offline capability”
- Neo4j → “Relationships are the data”

-->

---
level: 2
layout: two-cols-2-1
---

# Databases: Terminology

## RDBMS Quick Comparison

::left::

<div style="font-size: 0.75rem; margin-top: 0; line-height: 0.9rem;">

| RDBMS           | Licence  | Complexity | | Users & Permissions              |
|-----------------|----------|------------|----|----------------------------------|
| SQLite          | PD       | VL         | ❌ | No (single application user)     |
| MySQL           | OC/OS/CO | L          | ✅ | Yes (basic role & user support)  |
| MariaDB         | OS       | L–M        | ✅ | Yes (users, roles, grants)       |
| PostgreSQL      | OS       | M          | ✅✅ | Advanced roles &  privileges     |
| MS SQL Server   | CO       | M–H        | ✅✅ | Advanced (roles, AD integration) |
| Oracle Database | CO       | V H        | ✅✅✅ | Enterprise‑grade security model  |

</div>

::right::

<div style="font-size: 0.6rem; margin-top: 0;  line-height: 0.65rem;">

| **Key** | **Definition**    | Notes                                        |
|---------|-----------------|----------------------------------------------|
| PD      | Public Domain | no licence, free to use                     |
| CO      | Commercial | paid licence                                |
| OS      | Open Source | free to use, source code available          |
| OC      | Open Core | free core features, paid: advanced features |
| VL      | Very Low  |                                              |
| L       | Low       |                                              |
| M       | Medium    |                                              |
| H       | High      |                                              |

</div>

---
level: 2
layout: two-cols
---

# Databases: Terminology

## ACID, BASE, CAP

What are ACID, BASE and CAP?

::left::

#### ACID

<div style="font-size: 1rem; margin-top: 0;">

| **Term**        | **Meaning**              |
|-----------------|--------------------------|
| **A**tomicity   | All or nothing           |
| **C**onsistency | Rules always enforced    |
| **I**solation   | Transactions don’t clash |
| **D**urability  | Data survives failure    |

</div>

::right::

#### BASE

<div style="font-size: 1rem; margin-top: 0;">

| **Term**                    | **Meaning**                 |
|-----------------------------|-----------------------------|
| **B**asically **A**vailable | System stays online         |
| **S**oft state              | Data may change temporarily |
| **E**ventually consistent   | Data syncs over time        |

</div>

<!-- Presenter Notes:

## ACID 

- Used by relational databases such as MySQL, PostgreSQL, SQL Server
- Best for banking, finance, inventory, critical systems

## BASE 

- Used by NoSQL databases such as MongoDB, Cassandra, DynamoDB
- Best for web apps, distributed systems, large-scale platforms
-->

---
level: 2
layout: two-cols
---

# Databases: Terminology

## ACID, BASE & CAP

::left::

## ACID

- Atomic operations
- Consistent state
- Isolated execution
- Durable writes
- Strong guarantees
- Immediate consistency

::right::

## BASE

- Basically available
- Soft state
- Eventual consistency
- High availability
- Partition tolerant
- Performance focused

<!-- Presenter Notes:

## ACID Transactions – Presenter Notes

- Atomic operations: All steps succeed or all fail (no partial updates)
- Consistent state: Database rules are always enforced
- Isolated execution: Transactions don’t interfere with each other
- Durable writes: Data persists after commit, even after crashes
- Strong guarantees: Prioritises correctness over speed
- Immediate consistency: Reads always return the latest committed data

## BASE Transactions – Presenter Notes

- Basically available: System remains available even during failures
- Soft state: Data may temporarily change or be out of sync
- Eventual consistency: All replicas converge over time
- High availability: Designed to stay online under load
- Partition tolerant: Works across distributed systems
- Performance focused: Optimised for scale and speed

-->


---
level: 2
---

# Databases: Terminology

## ACID, BASE & CAP Theory

CAP Theorem

|                     |                                                                   |
|---------------------|-------------------------------------------------------------------
| Consistency         | All nodes return the same, most recent data                       |
| Availability        | Every request receives a response                                 |
| Partition tolerance | System continues despite network failures                         |
| Pick two            | In a distributed system, only two can be fully guaranteed at once |

---
level: 2
layout: two-cols
---

## ACID, BASE & CAP Theory

::left::

#### ACID Alignment

- Consistency
- Availability
- Low partition tolerance

<br><br>

<Announcement type="info" style="width:100%;">
<p style="font-size:2rem;">ACID → CA</p>
<p>correctness first</p>
</Announcement>

::right::

#### BASE Alignment

- Availability
- Partition tolerance
- Eventual consistency

<br><br>

<Announcement type="info"  style="width:100%;">
<p style="font-size:2rem;">BASE → AP</p>
<p>scale and uptime first</p>
</Announcement>

---
layout: section
---

# Relational Databases

<Announcement type="idea" style="width: 50%;">
<p style="line-height: 2rem;">Spring rain selects rows</p>
<p style="line-height: 2rem;">From, where, join—order kept</p>
<p style="line-height: 2rem;">Answers bloom on screen</p>
</Announcement>

---
level: 2
---

# Relational Databases: Terminology

## Core Terms

|                          |                                                                       |
|--------------------------|-----------------------------------------------------------------------|
| Database                 | An organised collection of related data.                              |
| Table                    | A structure that stores data in rows and columns.                     |
| Row, Record, Tuple       | A single set of data values in a table.                               |
| Column, Field, Attribute | A single data item type in a table.                                   |
| Schema                   | The logical structure of a database (tables, columns, relationships). |
| Instance                 | The data stored in the database at a specific point in time.          |


---
level: 2
---

# Databases: Terminology

## "Common" Data Types: SQL vs NoSQL

| **General Type**         | **Example SQL Types**     | **Example NoSQL Terms**  |
|--------------------------|---------------------------|--------------------------|
| Integer                  | INT, INTEGER, SMALLINT    | int, long, number        |
| Floating‑point / Decimal | FLOAT, DOUBLE, DECIMAL    | float, double, number    |
| String                   | VARCHAR, CHAR             | string                   |
| Large text               | TEXT, CLOB                | string, text             |
| Boolean                  | BOOLEAN                   | boolean                  |
| Dates & Times            | DATE, TIMESTAMP, DATETIME | date, timestamp, ISODate |

<!--
## Key Takeaways

- SQL databases are schema‑first
- NoSQL databases are data‑first

- **SQL** enforces data types at the **schema level**
- **NoSQL** typically applies types at the **document or application level**
- Many concepts exist in **both**, but enforcement differs

-->

---
level: 2
---

# Databases: Terminology

## "Common" Data Types: SQL vs NoSQL

| **General Type**       | **Example SQL Types**     | **Example NoSQL Terms**         |
|------------------------|---------------------------|---------------------------------|
| Binary data            | BLOB, BYTEA               | binary, byte[]                  |
| Enumerated values      | ENUM (DB‑specific)        | string (application‑controlled) |
| JSON / Structured data | JSON, JSONB               | object, document, map           |
| Arrays / Lists         | Array types (DB‑specific) | array, list                     |
| Identifier / ID        | PRIMARY KEY, UUID         | _id, uuid, ObjectId             |
| Null / Missing         | NULL                      | null, field omitted             |

<!--
## Key Takeaways

- SQL databases are schema‑first
- NoSQL databases are data‑first

- **SQL** enforces data types at the **schema level**
- **NoSQL** typically applies types at the **document or application level**
- Many concepts exist in **both**, but enforcement differs

-->


---
level: 2
---

# Databases: Terminology
## Data Types & Domain Integrity

In any type of database, choosing the correct type for the data is important

Consider:

- `INT` vs `BIGINT`
- `VARCHAR(n)` vs `TEXT`
- `DATE` / `DATETIME`
- `BOOLEAN`

<br>

<Announcement type="important" title="Rule">
<p>Store data in the most restrictive valid type & size possible.</p>
</Announcement>



---
level: 2
---

# Relational Databases: Terminology

## Keys and Relationships

|                  |                                                                 |
|------------------|-----------------------------------------------------------------|
| Primary Key (PK) | A column (or set of columns) that uniquely identifies each row. |
| Foreign Key (FK) | A column that references a primary key in another table.        |
| Candidate Key    | Any column(s) that could serve as a primary key.                |
| Composite Key    | A primary key made of multiple columns.                         |
| Surrogate Key    | An artificial key (e.g. auto‑increment ID).                     |
| Relationship     | How tables are connected (via keys).                            |


---
level: 2
layout: two-cols
---

# Databases: Terminology

## Keys in Relational Design

::left::

### Primary Key (PK):
- Uniquely identifies a row
- Must be UNIQUE and NOT NULL

<br>

### Candidate Key:

- Any attribute(s) that *could* be a PK
- Example: `ISBN`

::right::

### Foreign Key (FK):
- References a PK in another table
- Enforces referential integrity


<br>

### Composite Key:
- A PK made of multiple columns
- Common in junction tables

---
layout: section
---

# SQL Constraints & Data Integrity

Protecting your data **at the database level**

---
level: 2
---

# SQL Constraints & Data Integrity

## Why Constraints Matter

Constraints ensure that **invalid data never enters the database**.

They:

- Enforce business rules
- Maintain referential integrity
- Reduce reliance on application-only validation
- Prevent data anomalies *before* they happen

<br>

<Announcement type="important" title="Rule of thumb">  
<p>If the rule is always true — enforce it in SQL</p>
</Announcement>

---
level: 2
---

# Databases: Terminology
## Constraints & Integrity

### Common SQL Constraints

- `PRIMARY KEY`
- `FOREIGN KEY`
- `UNIQUE`
- `NOT NULL`
- `CHECK`

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `PRIMARY KEY`

::left::

### What a PRIMARY KEY Does

- Uniquely identifies each row
- Cannot be `NULL`
- Cannot contain duplicate values
- Automatically indexed

<br>

<Announcement type="brainstorm">
Every table <strong>must</strong> have a primary key
</Announcement>

::right::

### PRIMARY KEY – Example

```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

- `student_id` uniquely identifies a student
- Two rows can never share the same `student_id`

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `PRIMARY KEY`

::left::

### Common PRIMARY KEY Mistakes 

- Using mutable data (email, name) as PK
- Forgetting to define one at all
- Expecting the application to enforce uniqueness


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `FOREIGN KEY`
 
::left::

### What a FOREIGN KEY Does

- Links one table to another
- Enforces referential integrity
- Prevents orphaned records

<br>

<Announcement type="brainstorm">
You can’t reference what doesn’t exist.
</Announcement>

::right::

```sql
CREATE TABLE Enrolments (
    student_id INT,
    unit_id INT,
FOREIGN KEY (student_id) 
    REFERENCES Students(student_id)
);
```

- An enrolment must belong to a real student
- You cannot enrol `student_id = 999` if it doesn’t exist

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `FOREIGN KEY`

<br>

### FOREIGN KEY Problems Prevented

::left::

#### Without FKs:

- Orphaned rows
- Broken joins
- Silent data corruption

::right::

#### With FKs:

- Database rejects invalid inserts immediately

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `UNIQUE` Constraint

::left::

## What UNIQUE Does

- Ensures values are not duplicated
- Allows `NULL` <br>(unless combined with `NOT NULL`)
- Often used for candidate keys

::right::

### UNIQUE – Example


```sql
CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL
);
```

- Two users cannot share the same email
- Email is a candidate key, <br>Not necessarily the PK


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity

::left::

### PK vs UNIQUE (Quick Compare)

| Feature       | PRIMARY KEY | UNIQUE |
|---------------|-------------|--------|
| NULL  allowed | No          | Yes    |
| One per table | One         | Many   |
| Indexed       | Yes         | Yes    |


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `NOT NULL`

::left::

## What NOT NULL Does

- Prevents missing data
- Enforces mandatory fields

::right::

### NOT NULL Example

```sql
CREATE TABLE Units (
  unit_id INT PRIMARY KEY,
  title VARCHAR(100) NOT NULL
);

```

- A unit must have a title
- `INSERT INTO Units VALUES (1, NULL);` fails

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `UNIQUE` Constraint

::left::

### NOT NULL Is Not Validation Logic

- It does not check format
- It only checks presence

::right::

###  Consider...

- Email format?
- Age range?

Use CHECK or application validation

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `CHECK` Constraint

::left::

### What CHECK Does

- Enforces value rules
- Prevents logically invalid data

::right::

### CHECK constraint example
```sql
CREATE TABLE Students (
  student_id INT PRIMARY KEY,
  age INT CHECK (age >= 16),
  status VARCHAR(20) CHECK 
      (status IN ('active', 'inactive'))
);

```

- No underage students
- Only valid status values allowed

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: `CHECK` Constraint

::left::

### CHECK: Database Support Note

- Fully supported in PostgreSQL, SQL Server
-️ MySQL supports it from 8.0.16+
- Ignored in very old MySQL versions

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: Constraints Working Together

::left::


### Realistic Example

```sql
CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  isbn VARCHAR(20) UNIQUE,
  title VARCHAR(200) NOT NULL,
  publisher_id INT NOT NULL,
  FOREIGN KEY (publisher_id) 
      REFERENCES Publishers(publisher_id)
);
```

::right::

### This table enforces:

- Identity
- Uniqueness
- Required data
- Referential integrity


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: Constraints vs Application Logic

::left::

### Best Practice Split

| Rule Type              | Enforced Where |
|------------------------|----------------|
| Existence, uniqueness  | Database       |
| Relationships          | Database       |
| Format (email regex)   | Application    |
| Complex workflow rules | Application    |

::right::

### So...

- Databases protect the truth
- Applications protect the experience


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: Constraints Working Together

::left::

### Common Errors

- Confusing UNIQUE with PRIMARY KEY
- Forgetting foreign keys in junction tables
- Relying only on front-end validation
- Assuming indexes enforce correctness

::right::

### Key Takeaways

- Constraints enforce data integrity
- Every table needs a primary key
- Foreign keys prevent orphaned data
- CHECK constraints protect logical correctness
- Integrity belongs in the database first

---
level: 2
layout: two-cols
---

# Databases: Terminology
## Constraints & Integrity: Quick Reflection Question

::left::
### Consider this...

If a rule is broken in the database, <br>should the application be able to “fix it later”?

::right::

### Answer this...

Why or why not?

---
level: 2
---

# Relational Databases: Terminology

## Relationship Types

|                                              |                                                            |
|----------------------------------------------|------------------------------------------------------------|
| One‑to‑One (1:1)                             | One row relates to one row.                                |
| One‑to‑Many (1:M)                            | One row relates to many rows.                              |
| Many‑to‑Many (M:M)                           | Many rows relate to many rows <br>(uses a junction table). |
| Junction, Pivot, Link,  Intermediatory Table | Resolves many‑to‑many relationships.                       |

---
level: 2
---

# Relational Databases: Terminology

## Data Integrity

|                       |                                                                       |
|-----------------------|-----------------------------------------------------------------------|
| Entity Integrity      | Primary key must be unique and not null.                              |
| Referential Integrity | Foreign keys must reference valid primary keys.                       |
| Domain Integrity      | Data must follow defined rules <br>(type, range, format).             |
| Constraints           | Rules enforced on data <br>(PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK). |
| NULL                  | Represents missing or unknown data <br>(not zero or empty).           |

---
level: 2
---

# Relational Databases: Terminology

## Normalisation Concepts

<div style="line-height: 1.1rem; font-size: 0.95rem;">

|                          |                                                                                                 |
|--------------------------|-------------------------------------------------------------------------------------------------|
| Normalisation            | Process of structuring data to reduce redundancy and anomalies.                                 |
| First Normal Form (1NF)  | Atomic values; <br>No repeating groups or multi-valued fields.                                  |
| Second Normal Form (2NF) | No partial dependency on a composite primary key.                                               |
| Third Normal Form (3NF)  | No transitive dependencies between non-key attributes; <br>M:N resolved via junction tables.    |
| Fourth Normal Form (4NF) | No independent multi-valued dependencies in one table.                                          |
| Fifth Normal Form (5NF)  | No join dependencies remain; <br>Decomposed tables can be losslessly reconstructed using joins. |
| Denormalisation          | Intentional duplication of data to improve read performance.                                    |
</div>

<!-- Presenter Notes:

- 3NF fixes dependency correctness
- 4NF fixes independent many-to-many facts
- 5NF proves logical completeness, not performance

-->


---
level: 2
layout: two-cols
---

# Relational Databases: Terminology
## Controlled Denormalisation 

- Normalisation ensures correctness.
- Denormalisation may improve performance.

::left::

#### Acceptable When:

- Data is derived or cached
- Infrequent writes, frequent reads
- Reporting / dashboards

::right::

#### Not Acceptable When:

- It breaks source‑of‑truth integrity
- It introduces update anomalies


---
level: 2
---

# Relational Databases: Terminology

## Indexes & Performance

|                     |                                            |
|---------------------|--------------------------------------------|
| Index               | Improves query performance.                |
| Clustered Index     | Data stored in index order.                |
| Non‑clustered Index | Separate structure referencing table data. |
| Query Optimiser     | Chooses the most efficient execution plan. |


---
level: 2
layout: two-cols
---

# Databases: Terminology
## Indexes (Performance Awareness)

::left::

### What Indexes Do

- Speed up data retrieval
- Add overhead to 
  - `INSERT` and
  - `UPDATE`

::right::

### Typical Index Targets

- Primary keys (automatic)
- Foreign keys (often manual)
- Columns used in 
  - `WHERE`,
  - `JOIN`,
  - `ORDER BY`



---
level: 2
---

# Relational Databases: Terminology

## Transactions & ACID

|             |                                                  |
|-------------|--------------------------------------------------|
| Transaction | A unit of work treated as a whole.               |
| ACID        | Atomicity / Consistency / Isolation / Durability |
| COMMIT      | Saves transaction changes.                       |
| ROLLBACK    | Undoes transaction changes.                      |
| Lock        | Prevents conflicting data access.                |


---
layout: section
---

# Relational Databases: SQL

---
level: 2
---

# Relational Databases: SQL



## SQL

- Structured Query Language
- Language used to manage relational databases
    - DML (Data Manipulation Language)
    - DDL (Data Definition Language)
    - DQL (Data Query Language)
    - DCL (Data Control Language)
    - TCL (Transaction Control Language)

---
level: 2
layout: two-cols
---

# Relational Databases: SQL

## SQL & Querying

::left::

### DDL

- **Data Definition Language**
- Defines and changes database structure
- Used to create, modify, and remove database objects.
- Purpose: “What does the database look like?”

<br>

### Common Statements

- CREATE, ALTER, DROP, TRUNCATE, RENAME

::right::

### Examples

```sql
CREATE TABLE students
(
    .
    .
    .
);

ALTER TABLE students
    ADD email VARCHAR(255);

DROP TABLE students;
```

---
level: 2
layout: two-cols
---

# Relational Databases: SQL

## SQL & Querying

::left::

### DQL

- **Data Query Language**
- Retrieves data
- Commonly treated as a separate category from DML.
- Purpose: “What data do I want to see?”

<br>

### Common Statements

- SELECT

::right::

### Examples

```sql
SELECT *
FROM students;

SELECT name
FROM students
WHERE grade >= 70;
```

<Announcement type="info">
<p>Often DQL and DML merged together as “DML”.</p>
<p>Useful to separate concepts as querying is a distinct 
activity from modifying data.</p>
</Announcement>

---
level: 2
layout: two-cols
---

# Relational Databases: SQL

## SQL & Querying

::left::

### DML

- **Data Manipulation Language**
- Changes the data inside tables
- Used to insert, update, or delete rows.
- Purpose: “How does the data change?”

<br>

### Common Statements

- INSERT, UPDATE, DELETE,
- some systems: MERGE

::right::

### Examples

```sql
INSERT INTO students
VALUES (...);

UPDATE students
SET email = 'a@example.com';

```

---
level: 2
layout: two-cols
---

# Relational Databases: SQL

## SQL & Querying

::left::

### DCL

- **Data Control Language**
- Controls access and permissions
- Used to manage security and authorisation.
- Purpose: “Who is allowed to do what?”

<br> 

### Common Statements

- GRANT, REVOKE

::right::

### Examples

```sql
GRANT SELECT ON students TO lecturer;

REVOKE DELETE ON students FROM guest;

GRANT ALL PRIVILEGES
    ON students
    TO `admin`@`localhost`;

``` 

---
level: 2
layout: two-cols
---

# Relational Databases: SQL

## SQL & Querying

::left::

### TCL

- **Transaction Control Language**
- Manages transactions
- Controls how & when changes permanently applied.
- Purpose: “When do changes become final?”

<br>

### Common Statements

- COMMIT, ROLLBACK, SAVEPOINT, <br>SET TRANSACTION

::right::

### Examples

```sql
BEGIN TRANSACTION;
    UPDATE accounts
        SET balance = balance - 100
        WHERE account_id = 1;
    UPDATE accounts
        SET balance = balance + 100
        WHERE account_id = 2;
COMMIT;
```

<Announcement type="info">
<p>Syntax varies depending on RDBMS implementation.</p>
</Announcement>

---
level: 2
---


# Relational Databases: SQL

### Transaction (TCL) Syntax Comparison

<div style="line-height: 0.75rem; font-size: 0.7rem;">

| Feature / DBMS        | Oracle                                                       | MS SQL Server                                                                       | MySQL                                                                               | PostgreSQL                                              |
|-----------------------|--------------------------------------------------------------|-------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|---------------------------------------------------------|
| Start Transaction     | Implicit (auto after previous commit)<br> or SET TRANSACTION | BEGIN TRANSACTION <br>or BEGIN                                                      | START TRANSACTION <br>or BEGIN                                                      | BEGIN <br>or START TRANSACTION                          | 
| Commit                | COMMIT                                                       | COMMIT                                                                              | COMMIT                                                                              | COMMIT                                                  | 
| Rollback              | ROLLBACK                                                     | ROLLBACK                                                                            | ROLLBACK                                                                            | ROLLBACK                                                | 
| Savepoint             | SAVEPOINT name                                               | SAVE TRANSACTION name                                                               | SAVEPOINT name                                                                      | SAVEPOINT name                                          | 
| Rollback to Savepoint | ROLLBACK TO name                                             | ROLLBACK TRANSACTION name                                                           | ROLLBACK TO name                                                                    | ROLLBACK TO name                                        | 
| Autocommit Default    | OFF (manual commit required)                                 | ON (each statement commits unless inside explicit transaction)                      | ON (must disable for multi-step transactions)                                       | OFF (manual commit required)                            | 
| Isolation Levels      | READ COMMITTED (default), SERIALIZABLE, READ ONLY            | READ COMMITTED (default), READ UNCOMMITTED, REPEATABLE READ, SNAPSHOT, SERIALIZABLE | REPEATABLE READ (default in InnoDB), READ COMMITTED, READ UNCOMMITTED, SERIALIZABLE | READ COMMITTED (default), REPEATABLE READ, SERIALIZABLE | 


</div>

---
layout: section
---

# Relational Databases: Revision Exercises

---
level: 2
---

# SQL Revision Exercises

## By Language Category

Focus areas:

- DDL
- DML
- DQL
- TCL
- DCL

Try each exercise **before** checking the answers.

Use the SQL syntax for MariaDB/MySQL.

---
level: 2
layout: two-cols
---

# DDL – Data Definition Language

DDL defines the **structure** of the database.

::left::

## Exercise 1

Create a table called `students` with:

- `student_id` (integer, primary key)
- `name` (string, max 100 characters)
- `email` (string, unique)
- `date_of_birth` (date)

::right::

## Exercise 2

Modify the `students` table to add a column:

- `enrolment_date` (date)

<!-- Presenter Notes:
Exercise 1 Answer:


CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(255) UNIQUE,
  date_of_birth DATE
);

Exercise 2 Answer:

ALTER TABLE students
ADD enrolment_date DATE;

-->

---
level: 2
layout: two-cols
---

# DML – Data Manipulation Language

DML changes the **data inside tables**.

::left::

## Exercise 3

Insert a student into the `students` table.

Values:

- ID: `1`
- Name: `Alex Tan`
- Email: `a.tan@example.com`
- Date of birth: `2004‑03‑15`

::right::

## Exercise 4

Update the student’s email to:

- `alex.tan@example.com`

<!-- Presenter Notes:
Exercise 3 Answer:

INSERT INTO students (student_id, name, email, date_of_birth)
VALUES (1, 'Alex Tan', 'a.tan@example.com', '2004-03-15');

Exercise 4 Answer:

UPDATE students
SET email = 'alex.tan@example.com'
WHERE student_id = 1;

-->
---
level: 2
---

# DML – Data Manipulation Language

## Exercise 5

Insert the following students into the `students` table, using just **TWO** `INSERT` statements:

| student_id | name            | enrolment_date | email                       | date_of_birth |
|-----------:|-----------------|----------------|-----------------------------|---------------|
|         23 | Jamie Li        | 2024‑01‑15     | 'jamie.li@example.com'      | '1987-12-03'  |
|         45 | Sam Wright      | 2023‑07‑20     | 'sam.wright@example.com'    | '2003-08-22'  | 
|         76 | Jacques d'Carre | 2024‑02‑14     | 'jaques.dcarre@example.com' | '1997-01-01'  | 
|        216 | Robyn Banks     | 2025‑09‑23     | 'robyn.banks@example.com'   | '1999-12-31'  | 
|        311 | Amy Tan         | 2023‑02‑01     | 'amy.tan@example.com'       | '2004-03-15'  |

::right::

## Exercise 4

Update the student’s email to:

- `a.tan@example.com`

<!-- Presenter Notes:
Exercise 3 Answer:

INSERT INTO students (student_id, name, email, date_of_birth)
VALUES (1, 'Alex Tan', 'alex.tan@example.com', '2004-03-15');

Exercise 4 Answer:

UPDATE students
SET email = 'a.tan@example.com'
WHERE student_id = 1;

Exercise 5 Answer:


INSERT INTO students (student_id, name, enrolment_date, email, date_of_birth)
VALUES
  (23, 'Jamie Li',        '2024-01-15', 'jamie.li@example.com',      '1987-12-03'),
  (45, 'Sam Wright',      '2023-07-20', 'sam.wright@example.com',    
'2003-08-22'),
  (76, 'Jacques d''Carre','2024-02-14', 'jaques.dcarre@example.com', '1997-01-01');


INSERT INTO students (student_id, name, enrolment_date, email, date_of_birth)
VALUES
  (216, 'Robyn Banks', '2025-09-23', 'robyn.banks@example.com', '1999-12-31'),
  (311, 'Amy Tan',     '2023-02-01', 'amy.tan@example.com',    '2004-03-15');

-->

---
level: 2
layout: two-cols
---

# DQL – Data Query Language

DQL retrieves data using `SELECT`.

::left::

## Exercise 6

Write a query to return **all students**.

<br>
<br>
<br>

## Exercise 7

Write a query to return students enrolled **after 1 January 2023**.

::right::


## Exercise 8

Write a query to return the `student_id`, `name`, and `email` for all 
students **enrolled in 2024**.

<br>

## Exercise 9

Write a query to return  `name` and `date_of_birth` for students **born 
before 1 January 2000**, ordered by date of birth (oldest first).



<!-- Presenter Notes:
Exercise 6 Answer:

SELECT * FROM students;

Exercise 7 Answer:

SELECT *
FROM students
WHERE enrolment_date > '2023-01-01';

Exercise 8 Answer:

SELECT student_id, name, email
FROM students
WHERE enrolment_date BETWEEN '2024-01-01' AND '2024-12-31';

Exercise 9 Answer:

SELECT name, date_of_birth
FROM students
WHERE date_of_birth < '2000-01-01'
ORDER BY date_of_birth ASC;

-->


---
level: 2
layout: two-cols
---

# TCL – Transaction Control Language

TCL controls when changes are **saved** or **undone**.

::left::

## Exercise 10

Start a transaction and update a student’s name to `Alexander Tan`.

<Announcement type="warning">
Do <strong>not</strong> make the change permanent.
</Announcement>

::right::

## Exercise 11

Commit all changes made in the current transaction.

<!-- Presenter Notes:
Exercise 10 Answer:

BEGIN;
UPDATE students
SET name = 'Alexander Tan'
WHERE student_id = 1;
ROLLBACK;

Exercise 11 Answer:

COMMIT;

-->


---
level: 2
layout: two-cols
---

# DCL – Data Control Language

DCL manages **users and permissions**.

::left::

## Exercise 12

Create two users:

- `lecturer@localhost`
- `lecturer@127.0.0.1`

Grant these two users permission to:

- view (`SELECT`) data in the `students` table

::right::

## Exercise 13

Revoke permission to delete records from the same users.

<!-- Presenter Notes:
Exercise 12 Answer:

Same syntax for `lecturer`@`127.0.0.1`;

CREATE USER 'lecturer'@'localhost' 
IDENTIFIED VIA mysql_native_password 
USING 'Password1';

GRANT USAGE ON *.* TO 'lecturer'@'localhost' REQUIRE NONE;

GRANT SELECT
ON students
TO `lecturer`@`localhost`;

Exercise 13 Answer:

REVOKE DELETE
ON students
FROM `lecturer`@`localhost`;

-->

---
level: 2
layout: two-cols
---

# Review Checkpoint

Match each task to the correct SQL category:

| Task             | Category |
|------------------|----------|
| Creating a table | ?        |
| Inserting a row  | ?        |
| Querying records | ?        |
| Undoing changes  | ?        |
| Granting access  | ?        |

<!-- Presenter Notes:
Answers:
- Creating a table → DDL
- Inserting a row → DML
- Querying records → DQL
- Undoing changes → TCL
- Granting access → DCL
-->




---
layout: section
---

# Session Checklist!

<!-- 
Presenter Notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist

By the end of this session, students should be able to:

- [ ] Explain the difference between SQL and NoSQL databases
- [ ] Identify major RDBMS platforms and their typical use cases
- [ ] Describe ACID, BASE, and CAP at a conceptual level
- [ ] Explain core relational concepts (tables, rows, keys, relationships)
- [ ] Distinguish between DDL, DML, DQL, DCL, and TCL
- [ ] Write basic `CREATE`, `INSERT`, `SELECT`, `UPDATE`, and `DELETE` statements
- [ ] Use `WHERE`, date comparisons, and sorting in queries
- [ ] Demonstrate basic transaction control (`COMMIT`, `ROLLBACK`)
- [ ] Explain the purpose of SQL permissions (`GRANT`, `REVOKE`)

---
layout: section
---


# Exit Tickets 🎫

---
level: 2
layout: two-cols
---

## Exit Tickets - Reflection & Self-Assessment

::left::

## Exit Ticket 1

<Announcement type="brainstorm"  style="width: 100%; padding: 1rem;" title="SQL & Data Safety">

You are building a multi‑user web application with sensitive data.

Consider these two questions, and discuss your thoughts:

- Which SQL language categories are most critical for data safety?
- Why?

</Announcement>


::right::

### Exit Ticket 2

<Announcement type="brainstorm"   style="width: 100%; padding: 1rem;" title="DQL vs DML">

Explain why `SELECT` is often separated into **DQL**, even though some 
systems group it under DML.

- What learning benefit does this separation provide?
- 
</Announcement>


<!-- Presenter Notes:
...

-->


---
layout: section
---

# Additional Learning <br>& Further Study

<Announcement type="info"   style="line-height: 1rem; margin-top: 2rem; padding: 1.5rem;          margin-left: 24ch;"   title="Further Study">
<p style="line-height: 1.5rem;">The following resources provide more 
in‑depth information on databases, SQL, and related concepts.</p> 
<p style="line-height: 1.5rem;">They are provided for out of class study 
purposes.</p>
</Announcement>

---
level: 2
layout: two-cols
---

<h1 style="margin-bottom:0">Additional Learning & Further Study</h1>

::left::

### SQL (General)

- Allen, J. (n.d.). *SQLBolt: Learn SQL with interactive exercises*.    https://sqlbolt.com

- Mode Analytics. (n.d.). *SQL tutorial*.    https://mode.com/sql-tutorial/

<br>

### MariaDB / MySQL

- MariaDB Foundation. (n.d.). *MariaDB knowledge base*.  https://mariadb.com/kb/en/

- MySQL Tutorial Team. (n.d.). *MySQL tutorial*.    https://www.mysqltutorial.org/

::right::

### PostgreSQL

- PostgreSQL Global Development Group. (n.d.). *PostgreSQL documentation*.    https://www.postgresql.org/docs/

- PGExercises. (n.d.). *PostgreSQL exercises*.    https://pgexercises.com/


---
layout: section
---

# Acknowledgements & References

<!-- Presenter Notes:
Section: References. Provide reputable sources for further study in APA 7 style.
-->

---
level: 2
---

# References & Acknowledgements

- Laravel. (2026). *The PHP framework for web artisans. Laravel.com*; *
  *Laravel**.    https://laravel.com/

- Elmasri, R., & Navathe, S. B. (2016). *Fundamentals of database systems* (7th ed.). Pearson Education.

- ISO/IEC. (2016). *ISO/IEC 9075:2016 — Information technology — Database languages — SQL*. International Organization for Standardization.

- Date, C. J. (2019). *An introduction to database systems* (8th ed.). Addison‑Wesley.

- Oracle Corporation. (2024). *SQL language reference*. https://docs.oracle.com

- PostgreSQL Global Development Group. (2024). *PostgreSQL documentation*. https://www.postgresql.org/docs/



---
level: 2
---

# References & Acknowledgements (2)

<br>

<Announcement type="info" style="width: 100%; padding: 1rem;" title="Disclosures">
<p><b>Slide template:</b> Adrian Gould</p>
<p><b>AI Use:</b> Some content may have been generated with the assistance of Microsoft 
CoPilot</p>
</Announcement>


---
level: 2
layout: end
---

<h1 style="text-align: left">
Fin!
<br>
<br>
Spring indexes bud —
<br>
Design trims the data loss
<br>
Queries fly away
</h1>
