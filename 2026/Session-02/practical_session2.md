# Session 2 Practical Task Guide

## Enterprise Web Application Development

### Session 2 – The Web Round Trip

---

# Overview

In this practical you will build the first feature of your Contact List application using Laravel's MVC architecture.

You will:

- Create a route
- Generate a controller
- Create your first Blade view
- Connect all three together
- Verify your work using Artisan

This practical supports **Assessment 2 – Contact List Application**.

---

# Learning Outcomes

By the end of this session you should be able to:

- Explain how Laravel handles an HTTP request.
- Create and register a route.
- Generate a controller using Artisan.
- Return a Blade view from a controller.
- Verify routes using `route:list`.

---

# Prerequisites

Before beginning, confirm you have:

- [ ] Started Laragon
- [ ] Opened the Contact List project
- [ ] Launched VS Code
- [ ] Started the Laravel development server
- [ ] Confirmed the starter application loads in your browser

If any of these steps fail, ask your lecturer before continuing.

---

# Part 1 – Explore the Laravel Project

Spend five minutes exploring the project structure.

Locate the following folders.

```
app/
routes/
resources/
database/
tests/
```

Discuss with your partner:

1. Which folder probably contains the controllers?
2. Which folder contains the application's web routes?
3. Which folder contains the HTML templates?

Record your answers in your notes.

---

# Part 2 – Create a Route

Open:

```
routes/web.php
```

Add a new route that responds to the URL:

```
/contacts
```

Initially return a simple text response.

Example output:

```
Contacts
```

---

## Checkpoint

Visit the URL in your browser.

If it works, answer the following:

- What HTTP method is being used?
- Which file handled the request?
- What response was returned?

---

# Part 3 – Generate a Controller

Open a terminal inside the project.

Generate a new controller.

```bash
php artisan make:controller ContactController
```

Locate the generated file.

```
app/Http/Controllers/ContactController.php
```

Inspect the generated code.

Discuss:

- What did Laravel create for you?
- Why is generating code useful?

---

# Part 4 – Add an Action

Inside `ContactController`, create an `index()` method.

For now, return a simple text response.

Example:

```
Contacts
```

Do not create a view yet.

---

## Reflection

Why is this approach preferable to placing all your logic directly inside `routes/web.php`?

Write a short answer in your notes.

---

# Part 5 – Connect the Route and Controller

Update your route so that it calls the `index()` method of `ContactController`.

Refresh the browser.

The page should behave exactly as before, but the work is now being performed by the controller.

---

## Checkpoint

Your application should now have:

- [ ] Route
- [ ] Controller
- [ ] Controller action

Ask your lecturer to verify your progress before continuing.

---

# Part 6 – Create Your First Blade View

Create the following folder and file if they do not already exist.

```
resources/views/contacts/index.blade.php
```

Add a heading and a short welcome message.

Example:

```
Contacts

Welcome to the Contact List application.
```

---

# Part 7 – Return the View

Modify the `index()` method so that it returns your Blade view instead of plain text.

Refresh the browser.

You should now see your HTML page.

---

## Reflection

Consider the responsibilities of each MVC component.

Complete the table.

| Component | Responsibility |
|-----------|----------------|
| Route | |
| Controller | |
| View | |

---

# Part 8 – Explore Artisan

Run the following command.

```bash
php artisan route:list
```

Locate your `/contacts` route.

Record:

| Property | Value |
|----------|-------|
| Method | |
| URI | |
| Action | |

---

# Part 9 – Test Your Understanding

Answer the following questions.

1. What happens after a browser sends an HTTP request?
2. Why do we use controllers?
3. What is the purpose of a Blade view?
4. What command displays every registered route?
5. Which folder contains your views?

Discuss your answers with another student.

---

# Part 10 – Assessment Milestone

Complete the following independently.

### Task 1

Create a second page.

Example:

```
/about
```

Return a Blade view.

---

### Task 2

Assign a name to your `/contacts` route.

Verify the route appears in `route:list`.

---

### Task 3

Create a route parameter.

Example:

```
/contacts/{name}
```

Display a personalised greeting.

---

### Task 4

Demonstrate your completed work.

---

# Extension Challenge

Research how to pass data from a controller to a Blade view.

Modify your page so that the heading is supplied by the controller rather than being hard-coded.

Document the code you used.

---

# Commit Your Work

Commit your progress to Git.

```bash
git add .

git commit -m "Session 2 - MVC routing completed"

git push
```

---

# Self-Assessment

Tick each item once completed.

- [ ] I created a route.
- [ ] I generated a controller.
- [ ] I created a controller action.
- [ ] I created a Blade view.
- [ ] I connected the controller to the view.
- [ ] I verified my route using `route:list`.
- [ ] I committed my work to GitHub.

---

# Preparing for Session 3

Next week you will improve the Contact List application by introducing:

- Blade layouts
- Shared navigation
- Template inheritance
- Reusable page structure

Ensure your application is fully working before leaving class.
