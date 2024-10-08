---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags:
  - SaaS
  - APIs
  - Back-End
date created: 03 July 2024
date modified: 10 July 2024
created: 2024-10-05T15:41
updated: 2024-10-05T17:19
---

# S12 Laravel 1 - Basics - Planning a Feature

## Software as a Service - Front-End Development

### Session 12

Developed by Adrian Gould

---

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

---

# Terms

| Term                                 | Meaning                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Authentication                       | The process of verifying the identity of a user. <br>In Laravel, this is handled by the `Auth` facade, which manages user login and registration.                                                                                                                                                                                                                                                                                                                             |
| Authorisation                        | The permission to perform an action. Requires authentication to be completed before then checking for the authority to perform an action. <br>The process of granting or denying access to resources based on user roles and permissions. <br>Laravel uses *gates* and *policies* for authorisation.                                                                                                                                                                          |
| BREAD                                | *Browse*, *Read*, *Edit*, *Add*, *Delete*. Alternative term for CRUD. <br>Often used in the context of administrative interfaces. <br>Laravel's Nova package supports BREAD operations.                                                                                                                                                                                                                                                                                       |
| CRUD                                 | **Create**, **Retrieve**, **Update**, **Delete** actions applied to a resource, and are the basic operations for managing data. <br>Usually seen in terms of application to a database to refer to the Insertion of one or more records, Retrieval of one or more records, Editing of one or more items of data within one or more records, and finally the deletion or one or more records. <br>In Laravel, CRUD operations are typically handled by controllers and models. |
| Controller                           | Handles the logic of the application, processing requests and returning responses. <br>In Laravel, controllers are stored in the `app/Http/Controllers` directory.                                                                                                                                                                                                                                                                                                            |
| Factory                              | Defines the default state of a model for testing and seeding.<br>In Laravel, factories are used to generate fake data and are stored in the `database/factories` directory.                                                                                                                                                                                                                                                                                                   |
| Feature                              | A new functionality or improvement added to the application. <br>Features are often requested by users and planned in project roadmaps.                                                                                                                                                                                                                                                                                                                                       |
| HTTP Response Code                   | Numeric codes returned by the server to indicate the result of a request. <br>Laravel uses these codes to communicate the status of requests. <br>The code that tells the end client (browser, application or similar) about the result of the action that was requested. they include 200 OK, 201 Created, 301 Moved Permanently, 401 Unauthorised, 403 Forbidden, 404 Not Found, 418 I'm a Teapot, 500 Server Error, and 502 Bad Gateway.                                   |
| HTTP Verb<br><br>HTTP Request Method | Methods used in HTTP to indicate the desired action to be performed on a resource.<br>Laravel routes use these verbs to define actions and handle the requests.<br>The most commonly known ones include GET, POST, PUT, PATCH, DELETE, and OPTIONS.                                                                                                                                                                                                                           |
| Issue                                | A problem or bug that needs to be resolved. <br>Issues are tracked in project management tools like GitHub Issues or Jira.                                                                                                                                                                                                                                                                                                                                                    |
| MVP                                  | Minimum Viable Product. <br>The most basic version of a product with just enough features to satisfy early customers and provide feedback for future development.                                                                                                                                                                                                                                                                                                             |
| Migration                            | A version control system for the database schema.<br>In Laravel, migrations are used to create and modify database tables and are stored in the `database/migrations` directory.                                                                                                                                                                                                                                                                                              |
| MoSCoW                               | *Must have, Should have, Could have, Won't have*<br>**Important:** This short name has **no** relationship to any person, place or event in current, past or the future)                                                                                                                                                                                                                                                                                                      |
| Model                                | Represents the data structure and business logic of an application. <br>In Laravel, models interact with the database and are typically stored in the `app/Models` directory.                                                                                                                                                                                                                                                                                                 |
| Request                              | Represents an HTTP request received by the application. <br>In Laravel, requests can be validated using form request classes stored in the `app/Http/Requests` directory.                                                                                                                                                                                                                                                                                                     |
| Resourceful Route                    | A route that maps standard HTTP methods to controller actions for a resource. <br>In Laravel, resourceful routes can be defined using `Route::resource('resource', ResourceController::class)`.                                                                                                                                                                                                                                                                               |
| Route                                | A path that defines how a request should be handled. <br>In Laravel, routes are defined in `web.php` or `api.php` files and map URLs to controller actions.                                                                                                                                                                                                                                                                                                                   |
| Seeder                               | Populates the database with initial data. <br>In Laravel, seeders are used to insert sample data and are stored in the `database/seeders` directory.                                                                                                                                                                                                                                                                                                                          |
| Stakeholder                          | An individual or group with an interest in the success of a project. <br>Stakeholders can include users, developers, investors, and more. <br>They provide input and feedback during development.                                                                                                                                                                                                                                                                             |
| TBW                                  | To Be Written                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Artisan                              | Laravel's command-line interface tool. <br>Used for various tasks like running migrations, seeding the database, and generating boilerplate code. <br>Example: `php artisan migrate`.                                                                                                                                                                                                                                                                                         |
| Middleware                           | Software that acts as a bridge between the request and the response. <br>In Laravel, middleware can be used to handle tasks like authentication, logging, and more. <br>Defined in the `app/Http/Middleware` directory.                                                                                                                                                                                                                                                       |


# Overview

The steps outlined in this set of notes could be repeated until a **Minimal Viable Product** is completed. At this point each new feature, or group of related features, is then a 'new release' for the application.

It is important to have a broad concept of the project, and from there, identify the key features.

This may be achieved in many ways, but the key is to gather details from the application's stakeholders.

These include:
- The Client
- The End Users
- Other Similar Applications
- The Support Staff
- and more.

The details could gathered by using one or more techniques including:
- interview
- workshops
- documents
- current systems
- ...

Also part of this is the identification of the features and their importance. This will be driven by the stakeholders.

There are many ways to do this, but they are not within the scope of this cluster.

Saying this, we tend to use the "*Must have, Should have, Could have, Won't have*" method (MoSCoW).

Using sticky notes, or flash cards with the features, allows them to be organised into these four categories by each of the different stakeholder groups.

These then could be added to a spreadsheet, or other document or system.

One good way to keep track of them is to use some form of project management application, or, in some cases, use a feature of another application to do this. For example GitHub Projects and Issues.

# Feature Development Overview

Each feature will go through a phased development.

The phases **may** be similar to:

- Identify feature requirements in more detail
- Add user stories to project planning
- Develop and test the feature
- Release the feature

## I - Identify the requirements for the feature. 

We already know that gathering data to enable the development of a feature's overview is important.

We use any of the methods identified previously, and must also emphasise the identification of the criteria for completion of the feature.

Many companies will take the details from the various sources and distill these into "stories" that outline each feature and the criterial that must be met. These are usually called "user stories".

## II - Add Stories to Project Planning

Using something like GitHub projects, you are able to create a project and then bind an issue (a user story) to the project.

This gives you a very healthy way of tracking you work, and how the project is progressing.

For example, these could be the user stories for the ability to register and authenticate with a site:

- As a visitor to the site I must be able to register to create and account, so that I may use the features that require authentication.

- As a visitor I must be able to verify my email address after creating an account, so that I may be able to login and access the site's features.

- As a visitor I must be able to log into the application to enable me to use it's features that require authentication.

- As a user I must be able to log out, to prevent others using my account.

- As a user I must be able to reset my password via a reset email that provides a one time usage link.

We could add each of the above as individual issues on Github, or an 'epic story' that covers all these, and then add issues for each part of the epic. These could then be marked as required by the epic for it to be completed as a 'milestone' within the project.

Please read the following set of notes on how to create a Project, Automate adding Issues, Adding Sub Issues and Setting up a 'KANBAN' board.

- [S12-Managing-Projects-Using-GitHub-and-Kanban](S12-Managing-Projects-Using-GitHub-and-Kanban.md) **TBW**

## III - Develop Feature

We are now ready to develop the feature.

- Create Route Tests
- Create Route(s)
- Create Model Tests
- Create Model
- Create Migration
- Create Controller, Methods and Views

The Controller, Methods and Views are often completed one by one:
- Create Tests
- Create Method
- Create View

The Methods are often known by the acronym, "CRUD" or, my personal preference, "BREAD".

**BREAD**
- Browse, Read, Edit, Add, Delete
**CRUD**
- Create, Read, Update, Delete

The Laravel Method names are not quite the same, but they are still easy to remember.

| **Action** |        | **Controller<br>Method** | **HTTP VERB**    | **Notes**                                         |
| ---------- | ------ | ------------------------ | ---------------- | ------------------------------------------------- |
| BROWSE     | READ   | index                    | GET              | Shows "all" records                               |
| READ       | READ   | show                     | GET              | Shows one record                                  |
| EDIT       | UPDATE | edit<br>update           | GET<br>PUT/PATCH | retrieves the record & view<br>updates the record |
| ADD        | CREATE | create<br>store          | GET<br>POST      | retrieves view<br>saves the new record            |
| DELETE     | DELETE | destroy                  | DELETE           | destroys the record                               |

## IV - User Acceptance test



## V - Release



# END

Next up - [LINK TEXT](#)
