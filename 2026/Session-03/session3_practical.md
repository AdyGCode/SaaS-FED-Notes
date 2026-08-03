# Session 3 Practical Investigation

## Refactoring the Contact List Application using Controllers and Blade

By completing this sprint you will be able to:

- Apply MVC architecture.
- Create a conventional Laravel Controller.
- Refactor route closures into controller actions.
- Create reusable Blade layouts.
- Apply separation of concerns.
- Improve maintainability using Laravel conventions.

---

# Prerequisites

Before beginning confirm you have completed:

- Session 2 Practical – Part 6 on
- Working Laravel application
- Git repository
- Latest code committed
- Application running correctly

If your application is not working correctly, resolve these issues or ask for help.

---

# Development Sprint Overview

```text
Checkpoint
↓
Build
↓
Observe
↓
Test
↓
Explain
↓
Improve
↓
Git Commit
```

Complete every stage before progressing.

---

# Repository Checkpoint

Open your project. Confirm the following folders exist.

```text
app/
resources/
routes/
public/
storage/
```

Run the application.

Verify:

- Home page loads.
- About page loads.
- Contacts page loads.

Do not continue until everything works correctly.

---

## Review the Existing Routes

Open

```text
routes/web.php
```

Identify:

- Home route
- About route
- Contacts route

Questions:

- Which routes use closures?
- Which routes return Blade views?
- Where is the application logic currently located?

---

# Observe

Discuss with your partner. What problems might occur if the application grows to include:

- Contact search
- Contact editing
- Categories
- Authentication
- Hundreds of contacts

Would route closures remain manageable?

---

## Generate the ContactController

Use Artisan to create a conventional controller.

```bash
php artisan make:controller ContactController
```

Locate the generated controller.

```text
app/
    Http/
        Controllers/
            ContactController.php
```

Review the generated class.

---

# Observe 2

Open the controller.

- Namespace
- Class declaration
- Methods

Why does Laravel create an empty controller rather than adding application logic automatically.

---

# Build 3

Create the following methods.

```text
index()

show()
```

Initially both methods should return static Blade views.

Do not introduce database queries.

---

# Test 1

Update the routes.

Replace the route closure with a controller action.

Verify:

- The application still loads.
- The Contact page still works.
- No routing errors occur.

---

# Explain

Answer the following.

Why is the controller a better location for application behaviour than a route closure?

Discuss:

- Maintainability
- Readability
- Scalability

---

# Build 4

## Create a Shared Layout

Inside

```text
resources/views/
```

create

```text
layouts/

app.blade.php
```

Move the following into the layout.

- HTML document
- Navigation
- Shared CSS
- Footer

---

# Build 5

Update the existing pages.

Refactor:

- Home
- About
- Contacts
- Contact Details

Each page should extend the shared layout rather than duplicating HTML.

---

# Observe 3

Compare the project before and after refactoring.

Questions:

- Has the amount of duplicated HTML reduced?
- Is the navigation easier to maintain?
- Which files became simpler?

---

# Test 2

Verify every page still loads correctly.

Test:

- Home
- About
- Contacts
- Contact Details

Confirm:

- Navigation works.
- Layout displays correctly.
- No Blade errors occur.

---

# Investigate

Using the official Laravel documentation investigate:

- Controllers
- Blade Layouts
- Template Inheritance

Highlight three features that were not demonstrated during today's lesson.

---

# Improve

Consider how the application could be improved.

Ideas include:

- Active navigation highlighting
- Shared page titles
- Consistent headings
- Footer improvements
- Contact cards
- Better page structure

Implement one improvement.

---

# Enterprise Reflection

Imagine another software developer joins your team tomorrow.

Would they understand your project?

- Folder structure
- Naming conventions
- Controller organisation
- Blade layouts

Write a short reflection describing how today's refactoring has improved the application.

---

# Git Checkpoint

Commit your completed sprint.

Example commit message.

```bash
git commit -m "feat: Refactor Contact List application using ContactController and Blade layouts"
```

Push your changes to GitHub.

---

# Sprint Review Checklist

Your application should now contain:

- ContactController
- index()
- show()
- Updated routes
- Shared Blade layout
- Reduced duplicated HTML
- Working navigation
- Successful Git commit

---

# Preparing for Session 4

Next session we will begin making the application interactive.

Topics include:

- HTML forms
- User input
- Form Requests
- Validation
- Error messages

Ensure your repository is committed and pushed before attending the next class.

---

# Extension Challenge

Research Resource Controllers. Investigate the Artisan command used to generate one.

Do not implement it yet.

- Why Laravel provides Resource Controllers.
- When they should be used.
- How they differ from a standard controller.

This investigation will prepare you for later sessions.
