---
marp: true
paginate: true
size: A4
theme: nmtafe_v2
---

# Session 9 Practical

## Create and Store Workflow for Contacts

In the lecture you saw the complete create/store workflow using **Topics**.

Your task is to inspect that pattern and independently implement the equivalent workflow for your assessed **Contact** functionality.

---

# Practical Goal

Build and test a create/store workflow demonstrating:

- resource routing and a create form
- POST request and CSRF protection
- request validation
- validation errors and old input
- safe model creation
- redirect after successful storage
- feature tests for success and failure

Use Topics as an architectural reference. Do not rebuild the Topic feature.

---

# Before You Start

Confirm your Session 8 work is functioning:

```text
Application runs
MariaDB connection works
Contact index retrieves and displays database data
Pagination works
Git work flow is considered
```

Check:

```bash
git status
php artisan migrate:status
php artisan route:list
```

Commit unfinished Session 8 work before beginning.

---

# Task 1 — Trace the Topic Create Workflow

Locate the Topic:

- resource route
- controller `create()` and `store()`
- create Blade view and form
- Form Request
- model fillable configuration
- feature tests

```text
GET create
   ↓
form
   ↓
POST store
   ↓
validation
   ↓
model creation
   ↓
redirect
```

---

# Task 2 — Inspect the Resource Routes

Use:

```bash
php artisan route:list
```

Locate the Topic `create` and `store` routes.

Identify:

```text
HTTP method → URI → route name → controller action
```

Then locate the equivalent routing area for your Contact work.

Do not assume the route names or structure without checking the project.

---

# Task 3 — Map the Responsibilities

Before coding, map:

```text
TOPIC REFERENCE             YOUR CONTACT WORK

Topic resource route    →   ?
TopicController         →   ?
create()                →   ?
store()                 →   ?
Topic create view       →   ?
StoreTopicRequest       →   ?
Topic fillable fields   →   ?
Topic feature tests     →   ?
```

The architecture is transferable. The fields and requirements are not.

---

# Task 4 — Review Your Requirements

Use your:

- assessment requirements
- Database Integration Plan
- ERD
- migrations
- model

Determine which fields the user enters, which are required/optional, relevant length/format/uniqueness rules, which values must not be user-controlled, and where success should redirect.

Your validation must reflect your implemented design.

---

# Task 5 — Establish the Create Route

Identify or implement the route that displays the create form.

Verify it with:

```bash
php artisan route:list
```

Be able to explain:

```text
HTTP method → URI → route name → controller action
```

Do not move on until the expected create route exists.

---

# Task 6 — Implement create()

Implement the controller action responsible for displaying the form.

Remember the Topic pattern:

```text
GET request
    ↓
create()
    ↓
return Blade view
```

Opening the form must not create a database record.

Test the route in the browser before implementing `store()`.

---

# Checkpoint 1 — Form Page

Confirm:

- create URL opens
- correct controller action runs
- intended Blade view renders
- opening the page creates no database row
- existing navigation still works

Possible commit:

```text
Add contact create form route
```

---

# Task 7 — Build the Form

Create the fields required by your design.

For each field check:

```text
label
input type
name attribute
old value
validation feedback location
```

The `name` attributes become request keys sent to Laravel.

Do not copy the Topic fields.

---

# Task 8 — Configure the Form Request

The form must submit to the appropriate **store** route using:

```text
POST
```

Check:

```text
form action → correct named route
form method → POST
```

Avoid hard-coded URLs when an appropriate named route exists.

---

# Task 9 — Add CSRF Protection

Confirm the form uses Laravel's CSRF protection.

Inspect the rendered form if useful and identify the generated hidden token field.

Remember:

```text
CSRF → protects the authenticity of a state-changing web request
```

Do not disable CSRF to make a failing form submit.

---

# Security Check — CSRF and XSS

Keep these controls distinct:

```text
CSRF
→ unwanted forged request

XSS
→ unsafe content rendered in the browser
```

When displaying user-controlled values, use normal escaped Blade output unless there is a justified, controlled reason not to.

---

# Task 10 — Trace Submitted Data

Check:

```text
HTML name
    ↓
request key
    ↓
validation rule
    ↓
model/database field
```

Names should align where appropriate.

Do not submit fields that should be controlled by the application rather than the user.

---

# Task 11 — Create a Form Request

Use the Topic Form Request as a structural reference.

Define rules appropriate to **your schema and requirements**.

Consider where relevant:

- `required`
- `nullable`
- `string`
- `max`
- valid formats
- uniqueness only when required

Do not copy Topic validation rules simply because they already work.

---

# Task 12 — Authorisation vs Validation

Distinguish:

```text
AUTHORISATION
May this user perform the action?

VALIDATION
Is this submitted data acceptable?
```

Inspect how the starter application protects its routes and requests.

Do not weaken existing authentication or authorisation controls.

---

# Task 13 — Test Invalid Input First

Submit missing or invalid required values.

Expected:

```text
POST
 ↓
validation fails
 ↓
no database insert
 ↓
redirect back
 ↓
errors available
 ↓
old input available
```

Prove invalid data is rejected before completing the success path.

---

# Task 14 — Display Validation Errors

Display useful feedback near the relevant fields.

Use the Topic implementation to identify the application's existing error-display pattern.

Check that:

- important fields show their errors
- messages are understandable
- invalid data is not silently accepted
- the page remains usable

---

# Task 15 — Restore Old Input

Test:

```text
Enter several values
      ↓
make one field invalid
      ↓
submit
      ↓
validation fails
      ↓
other useful values remain
```

Use Laravel's old-input mechanism following the Topic pattern.

Pay attention to different input types.

---

# Checkpoint 2 — Validation Failure

Demonstrate:

```text
Invalid request             ✓
Validation error displayed  ✓
Useful old input restored   ✓
Invalid row not stored      ✓
```

Possible commit:

```text
Add contact create validation
```

---

# Task 16 — Implement store()

Once validation works, implement the successful store workflow.

Conceptually:

```text
receive validated request
        ↓
obtain validated data
        ↓
create model
        ↓
redirect
```

Use Topic `store()` as the architectural reference.

Do not pass unchecked request data directly into model creation.

---

# Task 17 — Check Mass Assignment

Compare:

```text
form/request fields
        ↓
validated fields
        ↓
model mass-assignable fields
```

Only intended attributes should be mass assignable.

Consider whether some values should be established by the application rather than accepted from the browser.

---

# Task 18 — Successful Redirect

After storing:

```text
POST
 ↓
database insert
 ↓
redirect
 ↓
GET page
```

Verify:

- a new row exists
- browser ends on intended GET route
- refreshing does not create another row
- success/status message behaves as expected

This is the Post/Redirect/Get workflow.

---

# Task 19 — Verify the Database

Do not rely only on the browser.

Use appropriate verification, for example:

```bash
php artisan tinker
```

Inspect your model data and confirm:

- valid data was stored
- invalid data was not stored
- stored values are correct

---

# Task 20 — Notice Session Behaviour

Laravel uses session-backed state for features such as:

```text
validation errors
old input
flash status messages
authenticated user state
CSRF token
```

You do not need to build a custom session system.

Use the existing Laravel mechanisms correctly.

---

# Task 21 — Consider Rate Limiting

Inspect the starter route/middleware configuration.

Ask:

- Is authentication already protecting this workflow?
- Is throttling already present?
- Would repeated submissions create an abuse concern?
- Would a limit interfere with legitimate behaviour?

Consider users when setting rate limits. Rate limiting is one layer of protection.

---

# Task 22 — Locate the Topic Feature Tests

Inspect existing Topic tests for:

- create page
- unauthenticated access
- invalid input
- old input/session errors
- successful store
- database persistence
- important validation constraints

They demonstrate **behaviours to prove**, not test code to rename.

---

# Task 23 — Test the Create Page

Write a feature test proving the intended user can reach the create form:

```text
Given correct user/application state
When create route is requested
Then expected page is available
```

Also test rejected access where required by the starter application's security design.

---

# Task 24 — Test Validation Failure

Write a feature test for invalid submitted data.

Prove:

```text
validation error exists
AND
invalid row is not stored
```

Where appropriate, verify useful old input is available after failure.

Choose invalid data from your own validation rules.

---

# Task 25 — Test Successful Storage

Write a feature test submitting valid data.

Prove:

```text
request accepted
    ↓
expected redirect
    ↓
database contains record
```

Do not stop at a successful HTTP response. The purpose of `store()` is persistence.

---

# Task 26 — Test an Important Constraint

Choose a real requirement to prove, such as:

- required data
- maximum length
- valid format
- uniqueness where required
- prohibited user-controlled values

The test should correspond to an application/database requirement.

---

# Checkpoint 3 — Feature Tests

Run the relevant tests:

```bash
php artisan test
```

or the specific feature test file used by the project.

Confirm tests demonstrate:

```text
create page
validation failure
successful store
database persistence
important constraint
```

Fix the implementation rather than weakening a correct test just to make it pass.

---

# Task 27 — For the validation meeting

```text
create route
    ↓
controller create action
    ↓
Blade form
    ↓
CSRF
    ↓
POST store route
    ↓
Form Request
    ↓
authorisation + validation
    ↓
validated data
    ↓
model creation
    ↓
MariaDB
    ↓
redirect
```

---

# Task 28 — Compare with Topics

Return to the Topic reference:

```text
TOPIC WORKFLOW
      ↕
YOUR CREATE/STORE WORKFLOW
```

Check:

- equivalent MVC responsibilities?
- entity-specific fields?
- validation based on your requirements?
- correct model configuration?
- appropriate tests?
- no unnecessary Topic-specific behaviour copied?

The pattern transfers; the implementation remains your own.

---

# Git Checkpoint

Review:

```bash
git status
git diff
```

Possible staged commit messages:

```text
Add contact create form
Add contact create validation
Implement contact store workflow
Add contact create feature tests
```

Or for one completed milestone:

```text
Implement contact create and store workflow
```

Use messages that accurately describe your changes.
