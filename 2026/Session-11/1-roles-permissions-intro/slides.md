---
theme: nmt
background: https://cover.sli.dev
title: Session 11 - Roles & Permissions
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 90min
---

# 1 - Roles & Permissions - Intro

## SaaS 1 – Cloud Application Development (Front-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
layout: default
level: 2
---

# Navigating Slides

Hover over the bottom-left corner to see the navigation's controls panel.

## Keyboard Shortcuts

|                                                     |                             |
|-----------------------------------------------------|-----------------------------|
| <kbd>right</kbd> / <kbd>space</kbd>                 | next animation or slide     |
| <kbd>left</kbd>  / <kbd>shift</kbd><kbd>space</kbd> | previous animation or slide |
| <kbd>up</kbd>                                       | previous slide              |
| <kbd>down</kbd>                                     | next slide                  |

---
layout: section
---

# Objectives

---
level: 2
layout: two-cols
---

# Objectives

::left::

::right::



---
level: 2
layout: figure-side
figureUrl: public/orly-book-cover-dashboards.png
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2" />

---
layout: section
---

# 🌟 Ice Breaker

## TODO: Add ice-breaker



---
layout: section
---

# Authorisation - PBAC/RBAC

Who can do what in the system?

---
level: 2
---

# What is Authorisation

- Controls what an authenticated user can do
- Happens *after* authentication
- Enforced by backend logic

## Access Control Models

There are many ACMs (Access Control Models).

We will concentrate on the use of RBAC/PBAC for this cluster.

<!-- Presenter Notes:
Authn vs Authz distinction.
-->


---
level: 2
---

# Access Control Models

<div class="leading-2 ">

| Model                                                                                       | Quick Description                                           |
|---------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| <strong class="bg-green-800 px-2 py-2 rounded w-24 inline-block text-center">ABAC</strong>  | attributes-based rules                                      |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">ACL</strong>    | per‑resource lists of users and their allowed actions       |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">DAC</strong>    | resource owners decide who can access their resources       |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">Hybrid</strong> | combines multiple models for flexible, fine‑grained control |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">MAC</strong>    | centrally enforced security labels and clearance rules      |
| <strong class="bg-green-800 px-2 py-2 rounded w-24 inline-block text-center">PBAC</strong>  | policy-driven rules                                         |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">TBAC</strong>   | permissions activated only while performing specific tasks  |
| <strong class="bg-green-800 px-2 py-2 rounded w-24 inline-block text-center">RBAC</strong>  | roles with permissions                                      |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">ReBAC</strong>  | access based on relationships between users and resources   |
| <strong class="bg-gray-800 px-2 py-2 rounded w-24 inline-block text-center">RuBAC</strong>  | access decisions made using explicit logical rules          |

</div>

<!-- Presenter Notes:

Focus on PBAC/RBAC for this cluster.

- RBAC answers: “What role are you?”
- ABAC answers: “What attributes apply right now?”
- PBAC answers: “Do the policies allow this?”

Students are expected to know RBAC, ABAC and PBAC conceptually
-->

---
layout: two-cols
level: 2
---

# Access Control Models

## RBAC — Role-Based Access Control

::left::

### What it is:

- Access is granted based on **roles**
- Roles group permissions together

<br>

### How it works:

- Users → roles
- Roles → permissions

::right::

### Examples:

- Admin, staff, student roles
- Enterprise business systems

<br>

### Key Points

- ✅ Simple and easy to manage
- ✅ Scales well
- ❌ Limited flexibility for complex rules

---
layout: two-cols
level: 2
---

# Access Control Models

## ABAC — Attribute-Based Access Control

::left::

### What it is:

- Access decisions based on **attributes**

<br>

### Common attributes:

- User (department, clearance)
- Resource (owner, sensitivity)
- Environment (time, location)

::right::

### Examples:

- Cloud platforms
- Fine-grained data protection

<br>

### Key Points:

- ✅ Very flexible
- ✅ Context-aware decisions
- ❌ More complex to design and manage

<!-- Presenter Notes:

Reinforce that RBAC is the most common model students will encounter.

Emphasise that ABAC evaluates conditions dynamically at runtime.
-->


---
layout: two-cols
level: 2
---

# Access Control Models

## PBAC — Policy-Based Access Control

::left::

### What it is:

- Access governed by **policies**
- Policies define rules independently of code

<br>

### How it works:

- Requests evaluated against policies
- Often implemented via policy engines

::right::

### Examples:

- Enterprise security platforms
- Compliance-driven systems

<br>

### Key Points:

- ✅ Centralised control
- ✅ Highly configurable
- ❌ Policy complexity can grow quickly

<!-- Presenter Notes:
PBAC is often seen as an architectural approach rather than a single model.

-->

---
level: 2
---

# Access Control Models


## Key Takeaways

- **RBAC** is best for clear, stable permissions
- **ABAC** handles complex, dynamic conditions
- **PBAC** provides centralised policy control
- **Other** models solve niche problems
- Real systems often **combine these models** into Hybrid models


## Beyond RBAC, ABAC & PBAC

For more details on what lays beyond RBAC/PBAC/ABAC please refer to:

- [Access Control - Wikipedia](https://en.wikipedia.org/wiki/Access_control)
  - `https://en.wikipedia.org/wiki/Access_control`
- [Authorisation Notes - Intermediate IoT & Software Security](https://github.com/AdyGCode/ICT50220-InterRIoT-Notes/tree/main/Software-Security/04-authorisation)
  - `https://github.com/AdyGCode/ICT50220-InterRIoT-Notes/tree/main/Software-Security/04-authorisation`

<!-- Presenter Notes:
Introduce this as a broadening of student knowledge.
Explain that RBAC, ABAC and PBAC are common, but not the only models.
-->


---
layout: section
---

# Determining Roles & Permissions

---
level: 2
layout: two-cols
---

# Determining Roles & Permissions
## Quick Recap

::left::
#### Role

- aka Group, Position, etc
- A collection of permissions
- Assigned to users
- Defines what users can do in the system
- Examples: Admin, Moderator, User, etc.

<br>

##### Identify Roles based on:

- application's requirements & features
- business needs of the system
- security & compliance needs of the system
- user types of the system 
- and more...

::right::
#### Permission

- aka Policy, Capability, Right, etc
- Defines specific actions users can perform
- May be grouped into roles
- Examples: create-post, edit-post, delete-post, view-dashboard, etc.

<br>

##### Identify Permissions based on:

- application's features and functionality
- actions users need to perform
- security and compliance requirements of the system
- and more...

---
level: 2
---

# Determining Roles & Permissions

When you add roles & permissions it is a good idea to know what each role will
be able to do in the system.

This can be done by creating a table of roles and permissions.

| Role      | Permission 1 | Permission 2 | Permission 3 | ... |
|-----------|--------------|--------------|--------------|-----|  
| Admin     | Yes          | Yes          | Yes          | ... |
| Moderator | No           | Yes          | Yes          | ... | 
| User      | No           | No           | Yes          | ... |

You may also base this on the features of the system, and determine which
roles will have access to which features, and then determine the permissions
based on the features.

This is the method we have used in this course, and is a good method to use as
it is based on the features of the system, and can be easily updated as the
system evolves.

---
level: 2
---

# Determining Roles & Permissions

We have created a spreadsheet to assist in completing this task:

- [Permission-Matrix.xlsx](public/Permission-Matrix.xlsx)
- Alternative links:
  - Notes [GitHub repository](https://github.com/AdyGCode/SaaS-FED-Notes)
  - GitHub Notes Session Folder [Permission Matrix Excel Spreadsheet](https://github.com/AdyGCode/SaaS-FED-Notes/tree/main/2026/Session-11/Session-11-2-roles-permissions-intro/public) 

The Permissions Matrix is best created in conjunction with the development
team and stakeholders to ensure that all requirements are captured and
understood.

This will include the MoSCoW and RACI frameworks to help determine the
importance and responsibility of each permission.


---
layout: figure
figureUrl: ./images/Permission-Matrix.png
figureCaption: Sample Permission Matrix (partially completed)
---

# Permission Matrix Sample

A sample of a partially completed permission matrix is shown in the image 
below. 

This is just an example and is not complete. 

It is meant to show the format and how it can be used to determine the roles and permissions for the system.

---
level: 2
---

# Exit Ticket Questions

TODO: Add exit ticket questions

<Announcement type="brainstorm">
...
</Announcement>

<Announcement type="idea">
...
</Announcement>

---

# Acknowledgements & References

- TODO: Add references etc

> Some content may have been generated with the assistance of Microsoft
> Copilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:

- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
