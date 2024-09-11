---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testing, PEST
created: 2024-08-01T09:23
updated: 2024-09-10T16:37
---

# MVC Background

**Model - View - Controller**

> **Note:** Before commencing this section, make sure you have read and understood [S05 Terminology MVC](S05-Terminology-MVC.md)

---

## What is it?

- A software pattern
- Reduces code complexity
- Increased number of files
- May enforce a folder structure for code

--- 

## Responsibilities

**Model:** Responsible for working with the data
**View:** Responsible for displaying the data
**Controller:** Interacts with the Model and View to perform tasks

---

## Them Heavy MVC Components...

MVC may be:

- **Controller Heavy:** Most of the business logic is written in the controller
- **Model Heavy:** Most of the business logic is in the model

![[MVC-Background-20240723154711502.png]]


---

## The MVC Process Flow
![[MVC-Background-20240723154733861.png]]
- User requests
- Web server directs request to Router
- Router called required Controller
- Controller requests data via model
- Model returns data
- Controller processes data
- Controller sends data to view
- View composed the page
- View is passed back to user via web server
