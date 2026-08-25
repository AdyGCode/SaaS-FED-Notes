---
theme: nmt
background: https://cover.sli.dev
title: Session 06 – Contacts CRUD/BREAD Practice
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Contacts CRUD/BREAD Practice
## Blade (Web) – Client & Admin Areas

Press Space → to proceed

<!-- presenter notes 
This session is hands-on practice applying CRUD/BREAD using Blade views, controllers, routes, validation, and tests.
-->

No APIs are used.
---

## Exercise Context

We are building a **Contacts feature** in a traditional Laravel web app.

- Contacts belong to users
- Clients manage **their own contacts**
- Admins manage **any user’s contacts**
- Blade views only (no JSON / API responses)

<!-- presenter notes
Reinforce separation of concerns: 
- client vs admin,
- ownership rules, 
- Blade not API responses.
-->

---


# Client Area – Browse (BREAD: Browse)

## Task

Allow a logged‑in user to browse **only their own contacts**.

### Requirements
- Route: `/dashboard/contacts`
- Controller: `Client\ContactController@index`
- Paginate results
- Blade view: `client.contacts.index`

<!-- presenter notes 
Emphasise filtering by auth user and pagination.

## Sample Solution – Client Browse

### Controller
```php
public function index()
{
    $contacts = auth()->user()
        ->contacts()
        ->orderBy('name')
        ->paginate(10);

    return view('client.contacts.index', compact('contacts'));
}
```
-->

---
