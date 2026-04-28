# Session 12: Authentication & Authorisation Basics

## SaaS 1 – Cloud Application Development (Front-End Dev)

Press Space or RIGHT for next slide/step

https://github.com/adygcode/SaaS-FED-Notes

---

## Navigating Slides

Hover over the bottom-left corner to see the navigation controls.

**Keyboard shortcuts:**

- **Right / Space** → Next slide or animation
- **Left / Shift + Space** → Previous animation
- **Up** → Previous slide
- **Down** → Next slide

---

## Objectives

### Knowledge

- Understand **authentication vs authorisation**
- Understand **Laravel Fortify** and **Laravel Sanctum**
- Understand how authentication flows work
- Understand email verification and password confirmation

### Skills

- Install and configure Laravel Fortify
- Protect routes with authentication
- Enforce authentication in Form Requests
- Test authentication flows using **Pest**

---

## Contents

- Authentication vs Authorisation
- Laravel Fortify
- Laravel Sanctum (overview)
- Fortify vs Sanctum
- Installing Fortify
- Authentication flows
- Using authentication in routes & requests
- Email verification
- Confirm password protection
- Testing authentication with Pest

---

## Authentication vs Authorisation

### Authentication

- **Who are you?**
- Proves identity
- Email / username + password

### Authorisation

- **What are you allowed to do?**
- Checked after authentication

---

## What is Laravel Fortify

Laravel Fortify is a backend authentication implementation for Laravel.

It provides:
- Registration
- Login / Logout
- Password reset
- Email verification
- Two‑factor authentication

---

## What is Laravel Sanctum

Laravel Sanctum provides API authentication using:
- API tokens
- SPA session authentication

---

## Fortify vs Sanctum

Fortify is for web authentication, Sanctum is for APIs and SPAs.

---

## Authentication Flows

### Registration

User submits registration → user saved → verification email sent

### Login

Credentials validated → session created

### Logout

Session destroyed → user logged out

---

## Authentication in Routes

```php
Route::middleware('auth')->group(function () {
    Route::get('/dashboard', fn () => view('dashboard'));
});
```

---

## Authentication in Form Requests

```php
public function authorize(): bool
{
    return auth()->check();
}
```

---

## Email Verification

Ensures users own their email address and reduces abuse.

---

## Confirm Password Middleware

Used for sensitive actions like admin dashboards.

```php
->middleware(['auth','password.confirm'])
```

---

## Testing Authentication with Pest

Test registration, login, logout, and email verification.

---

## Summary Checklist

- Authentication concepts understood
- Fortify awareness
- Route and request protection
- Testing importance

---

## Exit Ticket Questions

1. What is authentication?
2. How does it differ from authorisation?
3. Why verify emails?
4. Where should auth checks exist?

---

## References

Laravel Documentation (2025). Authentication & Fortify.

---

Fin 🌱
