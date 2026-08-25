---
marp: true
theme: nmtafe_v2
paginate: true
size: A4
---

# Session 6 Practical

# Enterprise Development Sprint 06

## Relationships, ERDs and Laravel Migrations

---

# Sprint Goal

This session continues the process:

```text
ERD
    ↓
Laravel Migration
    ↓
MariaDB Schema
    ↓
Verification
```

We will practise first with **Topics and Messages**.

---

# Part 1 — Topic and Message Relationship

The application needs to store:

```text
Topics
```

and:

```text
Messages
```

The requirement is:

> One Topic can have many Messages.

> Each Message belongs to one Topic.

---

# Task 1 — Identify the Keys

For:

```text
TOPIC
```

identify the Primary Key.

For:

```text
MESSAGE
```

identify:

- Primary Key
- Foreign Key

Use the relationship requirement to decide where the Foreign Key belongs.

---

# Task 2 — Build the ERD

```text
TOPIC
----------------
PK id
   name
   description
   available
        1
        └──────────────< many

MESSAGE
----------------
PK id
FK topic_id
   name
   email
   subject
   message
   read_at
```

---

The relationship is:

```text
topics.id
        ↓
messages.topic_id
```

---

# Task 3 — Review the Fields

For each field determine:

```text
Data Type
Required or Optional
Primary Key
Foreign Key
```

```text
description
available
topic_id
message
read_at
```

---

# Task 4 — Generate the Topics Migration

Run:

```bash
php artisan make:migration create_topics_table
```

Open the generated migration in:

```text
database/migrations/
```

---

Replace the `up()` method with:

```php
public function up(): void
{
    Schema::create('topics', function (Blueprint $table): void {
        $table->id();
        $table->string('name', 16)->unique();
        $table->string('description')->nullable();
        $table->boolean('available')->default(true);
        $table->timestamps();
    });
}
```

---

# Topics Migration — `down()`

Complete the rollback method:

```php
public function down(): void
{
    Schema::dropIfExists('topics');
}
```

Your migration should now be able to:

```text
up()
  ↓
Create topics

down()
  ↓
Remove topics
```

---

# Task 5 — Read the Topics Migration

Identify where the code implements:

```text
Primary Key
String
Maximum length
Unique value
Optional value
Boolean
Default value
Timestamps
```

Connect each migration statement back to the ERD.

---

# Task 6 — Generate the Messages Migration

Run:

```bash
php artisan make:migration create_messages_table
```

Open the generated migration.

---

Build the table using:

```php
public function up(): void
{
    Schema::create('messages', function (Blueprint $table): void {
        $table->id();

        $table->foreignId('topic_id')
            ->constrained()
            ->cascadeOnDelete();

        $table->string('name');
        $table->string('email');
        $table->string('subject', 128);
        $table->text('message');
        $table->timestamp('read_at')->nullable();
        $table->timestamps();
    });
}
```

---

# Messages Migration — `down()`

Complete:

```php
public function down(): void
{
    Schema::dropIfExists('messages');
}
```

Save the migration.

---

# Task 7 — Identify the Relationship Code

Locate:

```php
$table->foreignId('topic_id')
    ->constrained()
    ->cascadeOnDelete();
```

Match it to the ERD:

```text
topics.id
        ↓
messages.topic_id
```

Identify what each part contributes.

---

# `foreignId()`

```php
$table->foreignId('topic_id');
```

creates the field that stores the related Topic identifier.

It represents:

```text
messages.topic_id
```

---

# `constrained()`

```php
->constrained()
```

uses Laravel conventions to connect:

```text
topic_id
```

to:

```text
topics.id
```

This creates the Foreign Key relationship.

---

# `cascadeOnDelete()`

```php
->cascadeOnDelete()
```

means:

```text
Delete Topic
      ↓
Delete related Messages
```

For this teaching example we will use cascade delete.

This is a database design decision, not something to add automatically to every relationship.

---

# Task 8 — Check Migration Order

The Messages table depends on:

```text
topics.id
```

Therefore the Topics table must exist first.

Check the timestamps in:

```text
database/migrations/
```

---

Confirm:

```text
create_topics_table
```

runs before:

```text
create_messages_table
```

---

# Task 9 — Compare ERD and Migrations

Compare:

```text
ERD
        ↓
Topics Migration
        ↓
Messages Migration
```

Check:

- Entity names match
- Field names match
- Types are appropriate
- Required/optional values match
- Primary Keys exist
- Foreign Key exists
- One-to-many relationship is implemented

---

# Task 10 — Explain the Migration

Be prepared to explain:

```text
Why topic_id is stored in messages
How topic_id connects to topics.id
Why description is nullable
Why read_at is nullable
Why message uses text()
What cascadeOnDelete() does
```

---

# Part 1 Checkpoint

You should now have:

```text
Topic–Message Requirement
        ↓
Topic–Message ERD
        ↓
Topics Migration
        ↓
Messages Migration
```

---

and understand how:

```text
ERD
    ↓
Laravel Schema Builder
```

translates a relational design into code.

---

# Transfer Principle

The worked example gives you:

```text
HOW
```

to implement a relationship using Laravel migrations.

It does not give you:

```text
WHAT
```

your Contact migration should contain.

Your Contact implementation must come from:

```text
Database Integration Plan
        +
User–Contact ERD
```

---

# Next

## Part 2 — Run and Verify the Topic / Message Migrations

Next you will:

```text
Configure MariaDB
        ↓
Run migrations
        ↓
Inspect topics
        ↓
Inspect messages
        ↓
Verify the Foreign Key
        ↓
Rollback
        ↓
Reapply
```

Once the worked example is verified, you will transfer the same process to **Contacts**.

---

## Part 2 — Run and Verify the Topic / Message Migrations

You have created:

```text
Topic–Message ERD
        ↓
Topics Migration
        ↓
Messages Migration
```

Now test that the implementation produces the database structure you designed.

---

# Task 11 — Configure MariaDB

Open:

```text
.env
```

Update the connection for your NMTAFE MariaDB environment:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

Use the credentials supplied for your environment.

Do not commit `.env`.

---

# Task 12 — Test the Connection

Clear the existing configuration:

```bash
php artisan config:clear
```

Start Tinker:

```bash
php artisan tinker
```

Test the connection:

```php
DB::connection()->getPdo();
```

Exit Tinker when the connection succeeds.

---

# Task 13 — Check Migration Status

Before running the migrations:

```bash
php artisan migrate:status
```

Locate:

```text
create_topics_table

create_messages_table
```

---

Check whether they are:

```text
Pending
```

or:

```text
Ran
```

---

# Task 14 — Run the Migrations

Run:

```bash
php artisan migrate
```

Read the terminal output.

Then check:

```bash
php artisan migrate:status
```

Confirm the Topic and Message migrations have run.

---

# Task 15 — Inspect Topics

Run:

```bash
php artisan db:table topics
```

Confirm the table contains the fields from your ERD:

```text
id
name
description
available
created_at
updated_at
```

Check the Primary Key and `name` constraint.

---

# Task 16 — Inspect Messages

Run:

```bash
php artisan db:table messages
```

---

Confirm:

```text
id
topic_id
name
email
subject
message
read_at
created_at
updated_at
```

Check the Primary Key and Foreign Key.

---

# Task 17 — Verify the Relationship

Your ERD specified:

```text
TOPIC 1 ─────────────< many MESSAGE
```

The database should implement:

```text
topics.id
        ↓
messages.topic_id
```

---

Trace this through:

```text
ERD
    ↓
Migration
    ↓
MariaDB Foreign Key
```

Confirm all three agree.

---

# Task 18 — Check Optional Fields

Your migrations defined:

```php
$table->string('description')->nullable();
```

and:

```php
$table->timestamp('read_at')->nullable();
```

Inspect the schema. Confirm both fields allow:

```text
NULL
```

---

# Task 19 — Test Rollback

Run:

```bash
php artisan migrate:rollback
```

Then:

```bash
php artisan migrate:status
```

---

Inspect what changed.

This tests the migration:

```php
down()
```

methods.

---

# Task 20 — Reapply

Run:

```bash
php artisan migrate
```

Check the schema again.

You have now tested:

```text
Migrate
    ↓
Inspect
    ↓
Rollback
    ↓
Inspect
    ↓
Migrate
```

---

# Topic / Message Checkpoint

Confirm:

- [ ] Laravel connects to MariaDB
- [ ] Topics table exists
- [ ] Messages table exists
- [ ] Primary Keys are correct
- [ ] `messages.topic_id` is a Foreign Key
- [ ] Optional fields allow `NULL`
- [ ] Constraints are present
- [ ] Rollback works
- [ ] Migrations can be reapplied

---

## Part 3 — Transfer the Process to Contacts

You will now return to:

```text
Database Integration Plan
        +
User–Contact ERD
```

and apply the same process:

```text
Design
    ↓
Migration
    ↓
Migrate
    ↓
Inspect
    ↓
Rollback
    ↓
Reapply
```

The Topic / Message implementation is your worked example.

The Contact migration is your independent transfer task.

---

## Transfer the Process to Contacts

You have completed the worked Topic / Message example.

Now return to your:

```text
Database Integration Plan
        +
User–Contact ERD
```

Use these as the specification for your Contact migration.

---

# Task 21 — Review Your ERD

Open your approved User–Contact ERD.

```text
Contact Primary Key
User–Contact Foreign Key
Contact fields
Required / optional fields
Indexes
Constraints
```

Confirm the relationship:

```text
USER 1 ─────────────< many CONTACT
```

---

# Task 22 — Inspect the Existing Migration

Locate the migration affecting:

```text
contacts
```

Compare:

```text
Approved ERD
        ↓
Existing Migration
```

Identify what:

- Already matches
- Is missing
- Needs changing

Do not copy the Topic / Message fields.

---

# Task 23 — Check Migration State

Run:

```bash
php artisan migrate:status
```

Determine whether the Contact migration has already run.

If you are unsure how to change an existing migration safely, check with your lecturer before continuing.

---

# Task 24 — Implement Your Design

Update the Contact database structure to match your approved ERD.

Use the migration techniques practised with Topics and Messages.

You may need:

```php
$table->id();

$table->string(...);

$table->boolean(...);

$table->foreignId(...);

$table->index(...);
```

---

You may also need modifiers such as:

```php
->nullable();

->default(...);

->constrained();
```

Only use them where your approved design requires them.

---

# Task 25 — Implement the Relationship

Use your ERD to implement:

```text
users.id
        ↓
contacts.user_id
```

Refer back to the worked example:

```text
topics.id
        ↓
messages.topic_id
```

Apply the **relationship pattern**, not the field names.

---

# Task 26 — Check Before Running

Compare:

```text
Database Integration Plan
        ↓
User–Contact ERD
        ↓
Contact Migration
```

Check:

- Field names
- Data types
- Required / optional fields
- Primary Key
- Foreign Key
- Indexes
- Constraints

Correct any differences before running the migration.

---

# Task 27 — Run the Migration

Run:

```bash
php artisan migrate
```

Then:

```bash
php artisan migrate:status
```

If the migration fails, use the Session 6 Troubleshooting Guide.

Do not change the ERD simply to make the migration run.

---

# Task 28 — Inspect Contacts

Inspect the resulting table:

```bash
php artisan db:table contacts
```

Compare:

```text
Approved User–Contact ERD
            ↓
Actual contacts Table
```

Confirm the migration produced the intended schema.

---

# Task 29 — Verify the Relationship

Confirm:

```text
contacts.user_id
        ↓
users.id
```

Be prepared to explain:

> Why is `user_id` stored in Contacts?

> How does the Foreign Key represent Contact ownership?

---

# Task 30 — Test the Migration

Use the same process as Topics and Messages.

Rollback:

```bash
php artisan migrate:rollback
```

Inspect the result.

Then reapply:

```bash
php artisan migrate
```

Inspect the schema again.

---

# Task 31 — Trace a Requirement

Choose one Contact requirement.

Trace it through:

```text
Requirement
    ↓
Database Integration Plan
    ↓
ERD
    ↓
Migration
    ↓
MariaDB Schema
```

Be prepared to show where the requirement appears at each stage.

---

# Git Checkpoint

Check:

```bash
git status
```

Confirm:

```text
.env
```

is not being committed.

---

Review:

```bash
git diff
```

Then commit your migration work:

```bash
git add .
git commit -m "feat: implement contact database schema"
git push
```
