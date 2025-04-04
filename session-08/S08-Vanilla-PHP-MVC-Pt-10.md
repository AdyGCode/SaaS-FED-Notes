---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testng, PEST
created: 2024-09-03T12:55
updated: 2025-03-31T09:43
---

# Source Code for Full Framework

You may find the **latest release** of the source code (complete) here:

- [XXX-SaaS-Vanilla-MVC-YYYY-SN releases][https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN/releases/latest]

Code in development, with fixes is available from:

- [XXX-SaaS-Vanilla-MVC-YYYY-SN][https://github.com/AdyGCode/XXX-SaaS-Vanilla-MVC-YYYY-SN]


# Testing the whole application

OK, so it's time for you test the application.

This is going to be an exercise as we want you to practice thinking about what tests would be
required for an application.

You should:

- Create a list of the features and the sub features to test
- Create sample data that will test success and failure of your features
- Execute each test in turn, noting results and issues

We suggest using a table to help that could be similar to this:

| Feature  | Sub-Feature | Test Data                                       | Expected Result                                             | Actual Result | Notes |
|----------|-------------|-------------------------------------------------|-------------------------------------------------------------|---------------|-------|
| Users    | Login       | email: user1@example.com<br>password: Password1 | Returns to home page<br>Login/Register replaced with Logout |               |       |
|          | Login       | email: user1@example.com<br>password:           | Displays error as no password provided                      |               |       |
|          | Login       | email: <br>password: Password1                  | Displays an error as no email provided                      |               |       |
|          | ----------- |                                                 |                                                             |               |       |
|          | Register    |                                                 |                                                             |               |       |
|          | ----------- |                                                 |                                                             |               |       |
|          | Logout      |                                                 |                                                             |               |       |
| -------- | ----------- |                                                 |                                                             |               |       |
| Products | ...         |                                                 |                                                             |               |       |
|          |             |                                                 |                                                             |               |       |
