# Session 3 Practical

# Enterprise Development Sprint 03

## Building the Contact List Public Website

---

# Session Information

**Course**

ICT50220 Diploma of Information Technology

**Stage**

Stage 1 – Enterprise Web Application Development

**Session**

Session 3

**Duration**

Approximately 2 Hours

---

# Sprint Goal

Continue developing the Contact List application from **Session 2 Practical – Part 6**.

During this sprint you will extend the public website by completing the static pages and improving the application's presentation using the existing Laravel architecture.

You will work with:

- Static routes
- StaticPageController
- Blade views
- Shared layouts
- Named routes

The application should become more complete while maintaining a clean and maintainable structure.

---

# Learning Outcomes

By completing this sprint you will be able to:

- Navigate an existing Laravel application.
- Follow the Laravel request lifecycle.
- Extend the Contact List application using the existing architecture.
- Create professional static website content.
- Apply Blade layouts to reduce duplicated HTML.
- Follow Laravel conventions.

---

# Before You Begin

Continue from:

**Session 2 Practical – Part 6**

Confirm:

- Laragon is running.
- The Contact List application loads successfully.
- Home page loads.
- About page loads.
- Contact page loads.
- Latest work has been committed to GitHub.

---

# Sprint Overview

```text
Review Application
        │
        ▼
Review Architecture
        │
        ▼
Complete Public Pages
        │
        ▼
Improve Navigation
        │
        ▼
Test Application
        │
        ▼
Commit Changes
```

---

## Task 1 — Review the Application

Run the Contact List application.

Review the current public pages:

- Home
- About
- Contact Us

Locate any placeholder content that will need to be updated.

---

## Task 2 — Review the Project Structure

Locate the following folders.

```text
app/
resources/
routes/
public/
```

Identify where the following are stored:

- Routes
- Controllers
- Blade views

---

## Task 3 — Review the Public Routes

Open:

```text
routes/web.static.php
```

Locate the routes for:

- Home
- About
- Contact Us
- Privacy Policy
- Terms and Conditions

Confirm each route references the `StaticPageController`.

---

## Task 4 — Review the StaticPageController

Open:

```text
app/Http/Controllers/Web/StaticPageController.php
```

Locate the methods responsible for:

- Home
- About
- Privacy Policy
- Terms and Conditions

Confirm each method returns the correct Blade view.

---

## Task 5 — Complete the Home Page

Open:

```text
resources/views/web/static/welcome.blade.php
```

Complete the page by adding:

- Application title
- Introduction
- Purpose
- Key features
- Navigation links

Maintain the existing application layout.

---

## Task 6 — Complete the About Page

Open:

```text
resources/views/web/static/about.blade.php
```

Replace placeholder content with:

- Application overview
- Intended users
- Main features
- Technologies used
- Development approach

---

## Task 7 — Complete the Privacy Policy

Open:

```text
resources/views/web/static/privacy.blade.php
```

Create sections for:

- Information collected
- Use of information
- Security
- User responsibilities
- Contact information

Use clear and concise language.

---

## Task 8 — Complete the Terms and Conditions

Open:

```text
resources/views/web/static/terms.blade.php
```

Create sections for:

- Acceptable use
- User responsibilities
- Service availability
- Appropriate behaviour
- Changes to the application

---

## Task 9 — Improve the Contact Us Page

Open:

```text
resources/views/web/static/contact-us.blade.php
```

Improve the page by adding:

- Page heading
- Introduction
- Contact information
- Support information
- Consistent page layout

Do not modify the form processing.

---

## Task 10 — Review the Navigation

Locate the application's main navigation.

Ensure links exist for:

- Home
- About
- Contact Us
- Privacy Policy
- Terms and Conditions

Use Laravel named routes.

Example:

```php
route('web.static.about')
```

Avoid hard-coded URLs.

---

## Task 11 — Review the Shared Layout

Open the application's shared layout.

Confirm the following are shared across every page:

- Navigation
- Footer
- Stylesheets
- Scripts

Ensure individual pages only contain page-specific content.

---

## Task 12 — Test the Website

Verify every public page loads successfully.

| Page                 | Expected Result                    |
| -------------------- | ---------------------------------- |
| Home                 | Application introduction displayed |
| About                | Application overview displayed     |
| Contact Us           | Contact page displayed             |
| Privacy Policy       | Privacy Policy displayed           |
| Terms and Conditions | Terms and Conditions displayed     |

Also confirm:

- Navigation works correctly.
- Blade layout is applied consistently.
- No Laravel errors are displayed.
- Browser output matches the expected page.

---

## Task 13 — Improve the Website

Implement one improvement to the public website.

Suggested improvements:

- Active navigation
- Better page headings
- Improved footer
- Consistent content spacing
- Additional call-to-action buttons

Keep the improvement consistent with the existing application design.

---

## Task 14 — Commit Your Changes

Review the repository status.

```bash
git status
```

Stage your changes.

```bash
git add .
```

Commit your work.

```bash
git commit -m "feat: complete Contact List public website"
```

Push the latest commit.

```bash
git push
```

---

# Sprint Checklist

Before finishing, confirm the application contains:

- Completed Home page
- Completed About page
- Completed Privacy Policy
- Completed Terms and Conditions
- Improved Contact Us page
- Working named routes
- Consistent navigation
- Shared Blade layout
- Reduced duplicated HTML
- Successful Git commit and push

---

# Preparing for Session 4

Next session you will begin making the Contact List application interactive.

Topics include:

- HTML forms
- HTTP requests
- Form Requests
- Validation
- Error handling
- User feedback

Ensure your repository is committed and pushed before attending the next class.

---

# Extension Challenge

Investigate the following Laravel features using the official documentation.

- Resource Controllers
- Blade Components
- Route Groups

Be prepared to explain:

- What problem each feature solves.
- Where it could be used in the Contact List application.
- Whether it should be introduced later in the project.
