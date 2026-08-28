---
marp: true
theme: nmtafe_v2
paginate: true
size: A4
---

# Session 5 Practical

# Enterprise Development Sprint 05

## Relational Design, Normalisation & SQL

---

# Sprint Goal

Continue from your completed **Contact List Database Integration Plan**.

During this sprint you will:

- Complete any unfinished Session 4 planning
- Convert the approved requirements into a relational design
- Normalise the User–Contact schema
- Create the User–Contact ERD
- Practise SQL retrieval
- Run SQL through Laravel Tinker
- Review the supplied Contact migration

Do not implement the Contact migration yet.

---

# Session 5 Deliverables

By the end of this session retain:

1. **Completed Database Integration Plan** from Session 4
2. **User–Contact ERD**
3. **Tested SQL queries**

Do not create another planning document.

---

# Task 1 — Complete Session 4 Planning

Open your existing:

```text
Database Integration Plan
```

Complete any unfinished sections.

Do not reproduce information you have already completed.

Before progressing, confirm the plan identifies:

- Contact requirements
- Contact data
- Business rules
- Technical requirements
- User–Contact ownership
- Acceptance criteria

Obtain lecturer approval.

---

# Task 2 — Convert the Plan into a Relational Design

Use the approved Database Integration Plan.

Identify the database fields required for:

```text
User
```

```text
Contact
```

For each field determine:

- Field name
- Appropriate data type
- Required or optional
- Primary Key
- Foreign Key
- Relevant index

These decisions will be recorded directly on your ERD.

---

# Task 3 — Establish the Relationship

Use the ownership requirement already defined in your integration plan.

Your relational design must support:

```text
One User can own many Contacts.
Each Contact belongs to one User.
```

Identify the User Primary Key.

```text
users.id
```

Identify the Contact Foreign Key.

```text
contacts.user_id
```

---

# Task 4 — Check First Normal Form

Review your proposed fields.

Check:

- Each field contains one value.
- There are no lists inside fields.
- There are no repeating groups.
- Each record can be uniquely identified.

Correct the design where required.

---

# Task 5 — Check Second Normal Form

Do not duplicate User information such as, for every Contact field ask:

```text
Does this information describe the Contact?
```

```text
user_name
user_email
```

To create inside the Contactrelationship that information belongs to the User.

Use:

```text
user_id
```

---

# Task 6 — Check Third Normal Form

Review the schema for:

- Duplicated information
- Information belonging to another entity
- Unnecessary calculated values
- Values that could become inconsistent

Remove or relocate unnecessary data.

---

# Task 7 — Create the User–Contact ERD

Create an Entity Relationship Diagram containing:

```text
User

Contact
```

Your ERD must show:

- Entity names
- Field names
- Data types
- Primary Keys
- Foreign Key
- Required relationship
- One-to-many direction

---

For example:

```text
USER
----------------
PK id
   name
   email

        1
        │
        │
        └──────────────< many

CONTACT
----------------
PK id
FK user_id
   ...
```

Complete the Contact fields using your approved Database Integration Plan.

---

# Task 8 — Validate the ERD

Compare:

```text
Database Integration Plan
        ↓
ERD
```

Check that:

- Every required Contact data item is represented.
- Required fields are supported.
- Business rules are supported.
- Each Contact has a Primary Key.
- Contact ownership is represented.
- `user_id` connects Contact to User.
- No unnecessary data has been added.

Correct the ERD where required.

---

# Lecturer Checkpoint

Before beginning SQL, show your ERD to your lecturer.

Be prepared to identify:

```text
Primary Key
Foreign Key
One-to-Many Relationship
User Ownership
```

and explain one normalisation decision.

---

# SQL Investigation

We will now use the relational design to practise retrieving data.

Use the prepared Session 5 practice database supplied by your lecturer.

You are **not implementing your Laravel migration yet**.

---

# Task 9 — Start Laravel Tinker

From the Contact List project:

```bash
php artisan tinker
```

For this activity, Tinker allows us to send SQL to the prepared database.

Remember:

```sql
SELECT *
FROM contacts;
```

is SQL.

This:

```php
DB::select('SELECT * FROM contacts');
```

uses Laravel to execute the SQL.

---

# Task 10 — Retrieve Contacts

Run:

```php
DB::select('SELECT * FROM contacts');
```

Then retrieve only:

```text
first_name
last_name
email
```

Write the SQL yourself before executing it through Tinker.

---

# Task 11 — Filter Contacts

Retrieve only active Contacts.

Your SQL should use:

```sql
WHERE
```

Then retrieve Contacts belonging to:

```text
user_id = 1
```

Use a parameterised query:

```php
DB::select(
    'SELECT * FROM contacts WHERE user_id = ?',
    [1]
);
```

Change the User ID and compare the results.

---

# Task 12 — Combine Conditions

Retrieve Contacts that:

```text
belong to User 1
```

and:

```text
are active
```

---

Your query should use:

```sql
WHERE
```

and:

```sql
AND
```

Test the result.

---

# Task 13 — Sort Contacts

Retrieve Contacts ordered by:

```text
last_name
```

A–Z.

Use:

```sql
ORDER BY
```

Change:

```sql
ASC
```

to:

```sql
DESC
```

and compare the result.

---

# Task 14 — Filter and Sort

Create a query that returns:

```text
Active Contacts
```

ordered by:

```text
Last Name A–Z
```

---

Your query should use:

```text
SELECT
FROM
WHERE
ORDER BY
```

Run and test it through Tinker.

---

# Task 15 — Join Users and Contacts

Return:

```text
User name
Contact first name
Contact last name
Contact email
```

Use the relationship:

```text
users.id
        ↓
contacts.user_id
```

---

Start with:

```sql
SELECT
    users.name,
    contacts.first_name,
    contacts.last_name,
    contacts.email
FROM users
JOIN contacts
    ON users.id = contacts.user_id;
```

Run the query through Tinker.

---

# Task 16 — Test the Relationship

Inspect the JOIN results.

For several Contacts trace:

```text
Contact
    ↓
user_id
    ↓
User
```

Confirm each Contact is matched to the correct User.

---

# Task 17 — Final SQL Query

Create one query that returns:

```text
User Name
Contact First Name
Contact Last Name
Contact Email
```

for:

```text
Active Contacts
```

sorted:

```text
Contact Last Name A–Z
```

---

Your final query must use:

```sql
SELECT
JOIN
WHERE
ORDER BY
```

Test it through Tinker.

Keep your tested query.

---

# MyJamJar API Comparison

Compare the Contact List:

```text
Database
    ↓
Model
    ↓
Controller
    ↓
Blade
    ↓
HTML
```

---

with the MyJamJar API:

```text
Database
    ↓
Model
    ↓
Controller
    ↓
API Response
    ↓
JSON
```

Both applications retrieve data.

The presentation layer is different.

No MyJamJar code changes are required.

---

# Task 18 — Review the Supplied Migration

Locate the existing Contact migration:

```text
database/migrations/
```

Do not edit it.

Compare:

```text
Approved ERD
        ↓
Existing Migration
```

Identify any differences.

Consider:

- Missing fields
- Primary Key
- Foreign Key
- Required relationship
- Required constraints

Be prepared to discuss one change the migration will need.

Implementation occurs in Session 6.

---

# Assessment Evidence Checkpoint

You should now have only three pieces of database-design evidence:

```text
1. Database Integration Plan
        ↓
2. User–Contact ERD
        ↓
3. Tested SQL Queries
```

These demonstrate:

```text
Requirements
    ↓
Relational Design
    ↓
SQL Retrieval
```

---

# Git Checkpoint

Check:

```bash
git status
```

Commit appropriate documentation or design artefacts.

```bash
git add .
git commit -m "docs: finalise Contact relational design"
git push
```

Do not modify the Contact migration yet.

---

# Sprint Checklist

Confirm:

- [ ] Session 4 Database Integration Plan completed
- [ ] User and Contact entities identified
- [ ] Field names and data types determined
- [ ] Primary Key identified
- [ ] Foreign Key identified
- [ ] User–Contact relationship established
- [ ] 1NF checked
- [ ] 2NF checked
- [ ] 3NF checked
- [ ] User–Contact ERD completed
- [ ] ERD checked against the integration plan
- [ ] `SELECT` tested
- [ ] `WHERE` tested
- [ ] `ORDER BY` tested
- [ ] User–Contact `JOIN` tested
- [ ] Existing migration reviewed

---

# Stop Here

Do not implement:

```text
Migration Changes

Eloquent Relationships

Factories

Seeders

Controller Database Queries
```

These come later.

---

# Preparing for Session 6

Your development progression is now:

```text
Database Integration Plan
        ↓
User–Contact ERD
        ↓
Tested SQL
        ↓
SESSION 6
Database Implementation
```

Bring your approved **Database Integration Plan and ERD** to Session 6.
