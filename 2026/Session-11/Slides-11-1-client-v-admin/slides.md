---
theme: nmt
background: https://cover.sli.dev
title: Session 11 - Client v Admin
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 90min
---

# Session 11: Client v Admin

## SaaS 1 – Cloud Application Development (Front-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
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

<Toc minDepth="1" maxDepth="1" />

---
layout: section
---

# 🌟 Ice Breaker

## TODO: Add ice-breaker

---
layout: section
---

# Client v Admin

---
layout: two-cols
level: 2
---

# Client v Admin

::left::

## Client

- main users of the application
- relevant features and data
- similar design to main application
- often simpler and more streamlined interface
- different requirements for different clients
- permissions determine accessible features and data

::right::

### Possible Content

Possible content may include, but is not limited to:

- dashboard,
- user profile,
- content creation and management,
- communication tools,
- relevant data and analytics, and
- personalised content

<!-- Presenter Notes

Client


- main users of the application
- access to features and data relevant to their needs and permissions
- often has a different layout and design to the admin dashboard
- focuses on providing a user-friendly and intuitive interface for clients to interact with the application
- may include features such as user profiles, content creation and management, communication tools, and access to relevant data and analytics
- may have a simpler and more streamlined interface compared to the admin dashboard, as it is designed for clients who may not need access to all the features and data of the application.
- may have different access levels and permissions for different clients, allowing for a more personalized and tailored experience based on their needs and roles within the application.
- overall, the client dashboard is a crucial component of any application that serves clients, providing them with the tools and information they need to effectively use and benefit from the application, while also ensuring a positive user experience and engagement with the application.

-->


---
layout: two-cols
level: 2
---

# Client v Admin

::left::

## Admin

- manage complete application
- manage users, content, system settings etc
- access to all data and features of the application
- often has a different layout and design to the main application
- focuses on tools and information for administrators to effectively manage
  the application

::right::

### Possible Content

Possible content may include, but is not limited to:

- user management,
- content moderation,
- analytics,
- system settings,
- monitoring system logs, error tracking
- performance metrics
- access control and permissions management

<!-- Presenter Notes

Admin

- manage complete applicaiton
- manage users, content, system settings etc
- access to all data and features of the application
- often has a different layout and design to the main application
- focuses on providing tools and information for administrators to effectively manage the application
- may include features such as user management, content moderation, analytics, and system settings
- may have a more complex and feature-rich interface compared to the client dashboard, as it is designed for administrators who need to perform various tasks and manage different aspects of the application.
- may have different access levels and permissions for different administrators, allowing for a more granular control over who can access and manage certain features and data within the application.
- may also include features for monitoring and maintaining the health and performance of the application, such as system logs, error tracking, and performance metrics.
- overall, the admin dashboard is a crucial component of any application that requires effective management and administration, providing administrators with the tools and information they need to ensure the smooth operation and success of the application.
-->

---
layout: section
---

# Static v Client v Admin - Project Structure

---
level: 2
layout: grid
---

# Static v Client v Admin - Project Structure

::tl::

### Client

- `app\http\controllers\Client\...`
- `resources\views\client\...`
- `routes\web.client.php` or `routes\web\client.php`

::tr::

### Admin

- `app\http\controllers\Admin\...`
- `resources\views\admin\...`
- `routes\web.admin.php` or `routes\web\admin.php`

::br::

### Static Content

- `resources\views\static\...`
- `app\http\Controllers\Web\...`

::bl::

### About the Structure

- A suggested structure
- Simplified but organised
- Adapt based on the specific application

<!-- Presenter notes:

The key is to maintain a clear separation between client, admin, and static content to ensure better organization and maintainability of the codebase.

-->


---
layout: section
---

# Client v Admin - Design Considerations

---
level: 2
layout: two-cols
---

# Client v Admin - Design Considerations

::left::

- User Experience (UX)
- User Interface (UI)
- Functionality
- Performance
- Security
- Scalability
- Maintainability
- Accessibility
- Responsiveness

::right::

- Personalisation
- Analytics and Reporting
- Integration with other systems
- Customisation options
- User Roles and Permissions
- Feedback and Support Mechanisms
- Testing and Quality Assurance
- Documentation and Training Resources
- Regulatory and standards compliance

---
level: 2
---

# Client v Admin - Design Considerations

## Naming conventions

Consistency in naming conventions is imperative

| type        | static       | client           | admin           |
|-------------|--------------|------------------|-----------------|
| controllers | `Web\...`    | `Client\...`     | `Admin\...`     |
| views       | `static\...` | `client\...`     | `admin\...`     |
| routes      | `web.php`    | `web.client.php` | `web.admin.php` 

---
level: 2
---

# Client v Admin - Design Considerations

## Naming Controllers

Strongly suggested convention:

| Controller Type | Example 1                           | Example 2                            |
|-----------------|-------------------------------------|--------------------------------------|
| static          | `Web\AboutController`               | `Web\StatisPageController`           |
| admin           | `Admin\ContactManagementController` | `Admin\AnalyticsController`          |
| client          | `Client\ContactController`          | `Client\ProfileController`           |
| API             | `Api\V1\ContactController`          | `Api\V1\ContactManagementController` |

> All have `.php` extensions

<!--
Strongly suggest naming controllers based on their purpose and functionality, rather than the type of user they serve. This promotes better organization and maintainability of the codebase.

-->

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

> - Some content was generated with the assistance of Microsoft Copilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:

- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
