---
marp: true
paginate: true
size: A4
theme: nmtafe_v2
---

# Session 8 Practical

## Retrieve, Display and Format Contact Data

**Student environment:** AT2 Part A Student Starter

In the lecture example you saw the complete Read pattern using **Topics**.

Your task is to identify the equivalent parts of the Student Starter and independently apply that pattern to your assessed **Contact** functionality.

---

# Practical Goal

Build a database-driven Contact index that demonstrates:

- controller-based Eloquent retrieval
- controller → Blade data transfer
- display of multiple Contact records
- a useful table or list
- an empty state
- pagination
- appropriate display formatting

Do not rebuild the Topic feature.

Use it as an architectural reference.

---

# Before You Start

Make sure your work from earlier sessions is available:

- Contact database design
- approved ERD
- Contact migration(s)
- Contact model
- User–Contact relationship work
- Contact factory/seeder or suitable test data
- working MariaDB connection

Check the application runs before making Session 8 changes.

---

# Task 1 — Inspect the Existing Topic Pattern

Locate the existing Topic implementation in the Student Starter.

```text
Topic model
Topic controller
Topic index action
Topic Blade index
Topic route
```

Trace the existing request, but do not change the Topic feature.

```text
Request
   ↓
TopicController
   ↓
Eloquent
   ↓
$topics
   ↓
Topic Blade index
```

---

# Task 2 — Identify the Session 8 Techniques

In the Topic implementation, locate examples of:

- Eloquent retrieval
- ordering
- passing data to Blade
- looping through records
- table output
- pagination
- displaying model attributes

Also notice any relationship loading in the query.

You do not need to copy every part.

Identify which techniques are relevant to your Contact index.

---

# Task 3 — Map Topic Responsibilities to Contacts

Before coding, identify the Contact equivalent of each responsibility.

```text
LECTURE / REFERENCE        YOUR WORK

Topic model            →   ?
Topic controller       →   ?
Topic index action     →   ?
$topics                →   ?
Topic Blade index      →   ?
Topic route            →   ?
```

Use the existing project structure and your assessment requirements to locate the correct files.

---

# Task 4 — Review Your Contact Design

Use your existing:

- Database Integration Plan
- ERD
- Contact migration
- Contact model

Decide:

- which Contact fields belong on the index
- how the records should be ordered
- which nullable fields need fallback output
- whether an approved relationship is needed for this page
- an appropriate number of records per page

Your implementation should match **your Contact design**, not the Topic schema.

---

# Task 5 — Retrieve Contacts in the Controller

Implement the Contact index retrieval using Eloquent.

Your controller should:

```text
receive the index request
        ↓
build an appropriate Contact query
        ↓
order the results
        ↓
paginate the results
        ↓
pass them to the Contact Blade view
```

Use the Topic controller to remind yourself of the pattern.

Do not simply rename the Topic code.

---

# Checkpoint 1 — Controller

Before moving on, confirm:

- the correct Contact model is being queried
- the query matches your Contact schema
- ordering is useful for Contacts
- pagination is present
- the result is passed to the intended Blade view
- variable names clearly describe the data

If necessary, use Tinker to confirm Contact data exists.

---

# Task 6 — Build the Contact Index Display

Open the appropriate Contact index Blade view.

Display the records using the collection supplied by the controller.

Your page should provide a useful overview of the Contacts.

Choose fields based on your design.

Focus on:

```text
correct data
    ↓
clear structure
    ↓
readable output
```

**Do not spend most of the practical on styling.**

---

# Task 7 — Loop Through the Contacts

Use an appropriate Blade loop to render each Contact.

Think about the lecture pattern:

```text
collection
    ↓
one model per iteration
    ↓
one row/item per model
```

Check that:

- the collection variable matches the controller
- the individual item variable is clear
- each displayed property exists in your Contact schema

---

# Task 8 — Add an Empty State

Your index must still communicate clearly when there are no Contacts.

Add an empty state appropriate to the page.

Test both conditions:

```text
Contacts exist
→ Contact records are displayed
```

```text
No Contacts exist
→ useful empty-state message is displayed
```

Use the Topic lecture example to recall the `@forelse` pattern if required.

---

# Task 9 — Add Pagination

Display the paginator navigation in the Contact index.

Confirm that:

- the controller uses pagination
- the Blade view displays pagination links
- the page size is reasonable
- navigating between pages works

Create enough sample Contact data to test more than one page if necessary.

---

# Task 10 — Format the Output

Review the Contact values being displayed.

Consider whether any need:

- fallback text for `null`
- readable date formatting
- conditional display
- loop numbering
- clearer labels

Formatting should improve presentation without changing the stored database value.

---

# Task 11 — Test the Read Workflow

Trace your implementation from the browser:

```text
Contact index request
        ↓
route
        ↓
controller
        ↓
Eloquent query
        ↓
MariaDB
        ↓
Contact paginator
        ↓
Blade
        ↓
formatted Contact output
```

If something fails, identify which layer first stops behaving as expected.

---

# Task 12 — Test the Empty State

Temporarily test the page with no Contact records available.

Confirm that:

- the request succeeds
- Blade does not fail
- the table/list does not appear broken
- the user receives a useful message

Restore suitable development data after the test if required.

---

# Task 13 — Test Pagination

Make sure there are enough Contact records to create multiple pages.

Verify:

```text
Page 1 works
Page 2 works
Navigation works
Ordering remains correct
Displayed values remain correct
```

Do not assume pagination works because the links are visible.

Use them.

---

# Task 14 — Compare with the Topic Pattern

Return to the Topic reference implementation.

Compare the architecture:

```text
Topic Read workflow
        ↕
Contact Read workflow
```

Ask:

- Are the responsibilities in equivalent layers?
- Did I adapt the query to Contacts?
- Did I adapt the display to Contact requirements?
- Did I avoid unnecessary Topic-specific code?

The structures may be similar.

The implementations should reflect different entities and requirements.

---

# Practical Completion Check

You should now be able to demonstrate:

- Contact data retrieved from MariaDB
- Eloquent retrieval in the appropriate controller
- data passed to Blade
- multiple Contact records displayed
- appropriate table/list structure
- empty state
- pagination
- readable formatting
- working navigation between pages

Your page should use real database data rather than hard-coded Contact records.

---

# Git Checkpoint

Review your changes before committing.

Useful checks:

```bash
git status
git diff
```

Commit the completed Read/display milestone using a meaningful message.

For example:

```text
Implement database-driven contact index
```

Your Git history should show staged development of the assessment application.

---

# Goal

Stop after the Contact **Read/display** milestone.

Session 9 introduces:

```text
Create form
    ↓
CSRF
    ↓
Validation
    ↓
Store
    ↓
Redirect
```

Today the focus remains:

```text
Retrieve → Display → Format
```
