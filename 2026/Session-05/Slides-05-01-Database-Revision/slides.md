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

::left::

-

::right::

-

<!-- Presenter Notes:


-->
---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
class: text-left
layout: section
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
- SQL queries: Standardised query language (SELECT, JOIN, etc.)
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
layout: two-cols
---

# Databases: Terminology

## Example Implementations

There are many database engines available.

:: left::

### Relational (SQL)

- MySQL
- PostgreSQL
- Microsoft SQL Server
- Oracle Database
- SQLite
- MariaDB

::right::

### NoSQL

- MongoDB
- Cassandra
- Redis
- DynamoDB
- CouchDB
- Neo4j

---
level: 2
layout: two-cols
---

# Databases: Terminology

## ACID, BASE, CAP

What are ACID, BASE and CAP?

::left::

## ACID

| **Term**        | **Meaning**              |
|-----------------|--------------------------|
| **A**tomicity   | All or nothing           |
| **C**onsistency | Rules always enforced    |
| **I**solation   | Transactions don’t clash |
| **D**urability  | Data survives failure    |

::right::

## BASE

| **Term**                    | **Meaning**                 |
|-----------------------------|-----------------------------|
| **B**asically **A**vailable | System stays online         |
| **S**oft state              | Data may change temporarily |
| **E**ventually consistent   | Data syncs over time        |

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
---

# Relational Databases: Terminology

## Relationship Types

|                                             |                                                        |
|---------------------------------------------|--------------------------------------------------------|
| One‑to‑One (1:1)                            | One row relates to one row.                            |
| One‑to‑Many (1:M)                           | One row relates to many rows.                          |
| Many‑to‑Many (M:M)                          | Many rows relate to many rows (uses a junction table). |
| Junction, Pivot, Link, Intermediatory Table | Resolves many‑to‑many relationships.                   |

---
level: 2
---

# Relational Databases: Terminology

## Data Integrity

|                       |                                                                   |
|-----------------------|-------------------------------------------------------------------|
| Entity Integrity      | Primary key must be unique and not null.                          |
| Referential Integrity | Foreign keys must reference valid primary keys.                   |
| Domain Integrity      | Data must follow defined rules (type, range, format).             |
| Constraints           | Rules enforced on data (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK). |
| NULL                  | Represents missing or unknown data (not zero or empty).           |

---
level: 2
---

# Relational Databases: Terminology

## Normalisation Concepts

|                          |                                           |
|--------------------------|-------------------------------------------|
| Normalisation            | Process of reducing data redundancy.      |
| First Normal Form (1NF)  | Atomic values, no repeating groups.       |
| Second Normal Form (2NF) | No partial dependency on a composite key. |
| Third Normal Form (3NF)  | No transitive dependencies.               |
| Denormalisation          | Intentional duplication for performance.  |

---
level: 2
---

# Relational Databases: Terminology

## SQL & Querying

SQL (Structured Query Language) – Language used to manage relational databases.
SELECT – Retrieves data.
INSERT – Adds new data.
UPDATE – Modifies existing data.
DELETE – Removes data.
JOIN – Combines data from multiple tables.

INNER JOIN
LEFT / RIGHT JOIN
FULL JOIN

WHERE – Filters rows.
GROUP BY – Aggregates rows.
HAVING – Filters groups.


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
level: 2
---

# Relational Databases: Terminology

## Data Types

| General Type  | Example SQL Types      | Example NoSQL Types | 
|---------------|------------------------|---------------------| 
| Integer       | Numeric                |                     | 
| String        | VARCHAR, CHAR          |                     | 
| Dates & Times | DATE, TIMESTAMP        |                     | 
| Boolean       | BOOLEAN                |                     | 
| Binary data   | BLOB (Binary large object) |                     |
| Large text | TEXT (a form of BLOB) | |

---
layout: section
---

# Quick Group Exercise

<!--
Split group into 5 teams.
Each team investigates adn answers given question
After 5 minutes, team members will be mixed with other teams
Share findings about all 5 questions with each other
-->

---
level: 2
---

## Knowledge Check

Teams are Numbered 1-5

Answer your question as a team

1. ...
2. ...
3. ...
4. ...
5. ...

---
layout: section
---

# Session Checklist!

<!-- Speaker notes:
Wrap-up: provide a quick checklist of what was covered and then exit tickets as
last slide for reflection/self-assessment.
-->

---
level: 2
---

## Session Checklist (Covered Today)

- [ ] ...

<!-- Speaker notes:
Ask learners to identify any topics needing a deeper dive next session.
-->

---
level: 2
---

## Exit Tickets (Discuss or Submit)

1) ...

...

2) ...

...

<!-- Speaker notes:
Look for clarity of request flow and solid reasoning for where to place logic.
For Blade/Tailwind: emphasize reusability, consistency, and conditional styling.
-->


---
layout: section
---

# Acknowledgements & References

<!-- Speaker notes:
Section: References. Provide reputable sources for further study in APA 7 style.
-->

---
level: 2
---

## References & Acknowledgements

- Laravel. (2026). *The PHP framework for web artisans. Laravel.com*; *
  *Laravel**.  
  https://laravel.com/
-

---
level: 2
---

## References & Acknowledgements (2)

- ...

<!-- Speaker notes:
Encourage learners to browse docs for their exact Laravel minor version.
-->

- Slide template: Adrian Gould

> - Some content was generated with the assistance of Microsoft CoPilot


---
level: 2
layout: end
---

# Spring indexes bud —<br>Design trims the data loss<br>Queries fly away
