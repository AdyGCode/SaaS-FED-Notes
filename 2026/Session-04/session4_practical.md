# Session 4 Practical

# Enterprise Development Sprint 04

## Routing, Controllers & Database Integration Planning

---

# Sprint Goal

Continue developing the **Contact List application**.

During this sprint you will:

- Complete the Session 3 public website work
- Extend the existing `ContactController`
- Create four Contact routes
- Create matching Blade views
- Define Model responsibility
- Identify Contact data requirements
- Create a database integration plan

Do not create the database or ERD during this sprint.

---

# Learning Outcomes

By completing this sprint you will be able to:

- Connect routes to controller actions.
- Apply Laravel controller conventions.
- Explain the responsibility of a Model.
- Identify application data requirements.
- Define business rules.
- Create an initial data dictionary.
- Define acceptance criteria.
- Plan future database integration.

---

# Before You Begin

Open your existing Contact List application.

Continue from:

**Session 3 Practical — Task 3**

Confirm:

- The application runs successfully.
- Your latest work is committed.
- `routes/web.static.php` exists.
- `StaticPageController` is working.
- The existing `ContactController` is available.

---

# Task 1 — Complete Session 3

Complete the remaining Session 3 practical tasks.

Ensure the public website contains:

- Home
- About
- Contact Us
- Privacy Policy
- Terms and Conditions

Confirm:

- Navigation works.
- Named routes are used.
- Blade views display correctly.
- The shared layout is working.

Commit your completed Session 3 work.

---

# Task 2 — Review the Existing ContactController

Locate the existing:

```text
ContactController.php
```

Open the controller.

Identify:

- Namespace
- Class
- Existing method
- Returned response or view

Do not add database logic.

---

# Task 3 — Add the Contact Actions

Extend the existing `ContactController` with:

```text
index()
show()
create()
edit()
```

Each method should return its matching Blade view.

Use:

```text
contacts.index
contacts.show
contacts.create
contacts.edit
```

---

# Task 4 — Add the Contact Routes

Create routes for:

```text
GET /contacts
GET /contacts/create
GET /contacts/{contact}
GET /contacts/{contact}/edit
```

Connect each route to the correct `ContactController` method.

---

# Task 5 — Check the Routes

Run:

```bash
php artisan route:list
```

Confirm the four Contact routes display the correct:

- HTTP method
- URI
- Controller
- Controller method

---

# Task 6 — Create the Contact Views

Create or complete:

```text
resources/views/contacts/
├── index.blade.php
├── show.blade.php
├── create.blade.php
└── edit.blade.php
```

Use the existing application layout.

Keep the pages static.

Do not add database queries.

---

# Task 7 — Test the Contact Pages

Test:

```text
/contacts

/contacts/create

/contacts/1

/contacts/1/edit
```

Confirm each request follows:

```text
Route
    ↓
ContactController
    ↓
Controller Method
    ↓
Blade View
```

Resolve any routing or view errors before continuing.

---

# Task 8 — Identify the Missing Data Layer

Review the current application structure.

```text
Browser
    ↓
Route
    ↓
ContactController
    ↓
?
    ↓
Blade View
```

The future Model will provide the missing data responsibility.

Plan for:

```text
Route
    ↓
ContactController
    ↓
Contact Model
    ↓
Database
```

Do not create the Model yet.

---

# Task 9 — Identify Contact Requirements

Review the Contact List application.

Identify what users need to do with Contacts.

Include:

- View Contacts
- View one Contact
- Enter a new Contact
- Edit Contact information

Add any other Contact requirements already supported by the application requirements.

---

# Task 10 — Identify Contact Data

Identify the information required to represent a Contact.

Start with:

- First name
- Last name
- Email
- Phone

Add other information only where required by the Contact List application.

---

# Task 11 — Create the Data Dictionary

Create an initial data dictionary.

Use this structure:

| Data Item  | Description             | Required | Rule        |
| ---------- | ----------------------- | -------- | ----------- |
| First Name | Contact's first name    | Yes      | Required    |
| Last Name  | Contact's surname       | Yes      | Required    |
| Email      | Contact's email address | Yes      | Valid email |
| Phone      | Contact's phone number  | No       | Optional    |

Extend the table using the application requirements.

Do not add SQL data types yet.

---

# Task 12 — Define Business Rules

Create a concise list of rules for Contact data.

Consider:

- Required information
- Optional information
- Valid formats
- Who can modify Contacts

Base the rules on the Contact List requirements.

---

# Task 13 — Record Technical Constraints

Add the existing technical environment to the integration plan.

Include:

- Laravel
- PHP
- Blade
- MVC architecture
- Existing Contact List project structure
- Existing routes and controllers

The future database integration must work within this architecture.

---

# Task 14 — Define Acceptance Criteria

Create acceptance criteria for the four Contact actions.

Use this structure:

| Requirement    | Acceptance Criterion                                      |
| -------------- | --------------------------------------------------------- |
| View Contacts  | Available Contacts can be displayed                       |
| View Contact   | An individual Contact can be displayed                    |
| Create Contact | The Contact entry interface can be displayed              |
| Edit Contact   | Existing Contact information can be displayed for editing |

Keep each criterion clear and testable.

---

# Task 15 — Map the Future Data Flow

Add the planned data flow to your integration plan.

```text
Browser
    ↓
Route
    ↓
ContactController
    ↓
Contact Model
    ↓
Database
```

For displaying data:

```text
Database
    ↓
Contact Model
    ↓
ContactController
    ↓
Blade View
    ↓
Browser
```

---

# Task 16 — Complete the Integration Plan

Your **Contact List Database Integration Plan** should contain:

1. Application purpose
2. Organisational requirements
3. Contact requirements
4. User input requirements
5. Initial data dictionary
6. Business rules
7. Technical constraints
8. Acceptance criteria
9. Planned Laravel data flow

Keep each section concise.

---

# Task 17 — Review the Plan

Check the integration plan against the Contact List application.

Confirm:

- Required Contact information is identified.
- Required and optional data is clear.
- Business rules are included.
- Acceptance criteria are testable.
- Existing Laravel architecture is considered.
- No unnecessary features have been added.

Obtain peer or lecturer feedback.

Update the plan where required.

---

# Task 18 — Commit Your Application Changes

Check your repository.

```bash
git status
```

Stage your changes.

```bash
git add .
```

Commit:

```bash
git commit -m "feat: add Contact routes and controller actions"
```

Push:

```bash
git push
```

---

# Sprint Checklist

Before finishing, confirm you have:

- Completed the Session 3 public website
- Extended the existing `ContactController`
- Added `index()`
- Added `show()`
- Added `create()`
- Added `edit()`
- Created four Contact routes
- Created four Contact Blade views
- Tested all Contact routes
- Defined Model responsibility
- Identified Contact data requirements
- Created an initial data dictionary
- Defined business rules
- Defined acceptance criteria
- Completed the database integration plan
- Obtained feedback
- Committed and pushed the application changes

---

# Stop Here

Do not create:

- Database tables
- Migrations
- Foreign keys
- Eloquent relationships
- ERD
- `store()`
- `update()`
- `destroy()`

These require the database design to be completed first.

---

# Preparing for Session 5

Session 4 identified:

```text
What data does the Contact List need?
```

Session 5 will determine:

```text
How should that data be organised?
```

Bring your revised **Database Integration Plan** and **Data Dictionary** to Session 5.

They will be used to begin the Contact List database design and ERD.
