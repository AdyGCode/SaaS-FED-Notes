---
theme: nmt
background: https://cover.sli.dev
title: Session 09 - Laravel Testing & Code Coverage
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 09: Laravel Testing & Code Coverage

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
class: text-left
---

# Objectives

- Explain what testing is.
- Identify PHP testing frameworks
- Identify test frameworks for Laravel
- Why use Pest
- Explore a simple test
- Understand code coverage
- Comparing xDebug v PCov 
- Practice basic test writing

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
layout: figure
figureUrl: public/orly-book-cover-draft-testing.png
---

---
layout: section
---

# Ice Breaker

---
layout: two-cols
level: 2
---

# Ice Breaker

::left::

## TODO: Add ice-breaker here

::right::

## TODO: Second part of ice-breaker

---
layout: section
---

# What is Testing

--- 
level: 2
---

What is Software Testing?
Software testing is the process of evaluating software to ensure it works as expected, detecting bugs, verifying behaviour, and preventing regressions.
Testing helps developers:

Validate functionality
Increase confidence in changes
Improve code quality
Automate repeatable checks

<!--
Make the point that testing is not optional in professional environments. Nearly all teams expect developers to write tests.
-->

---
level: 2
---

PHP Testing Frameworks
Common testing frameworks in the PHP ecosystem:

PHPUnit — the default and most widely used; assertions, test cases
Pest — minimalist, modern syntax, built on PHPUnit
Codeception — integrates unit, API, acceptance tests
Behat — behaviour‑driven testing (BDD)


Explain the difference between unit, feature/integration, and end‑to‑end tests.

Testing Frameworks in Laravel
Laravel ships with first‑class support for:
✔ PHPUnit
The historical default framework for Laravel.
✔ Pest
Recommended in modern Laravel versions; lighter, expressive syntax.
✔ Laravel Dusk
For browser/automation/UI testing.
✔ Laravel Test Helpers
Factories, model testing helpers, HTTP testing, and database test tools.

Laravel’s test helpers significantly reduce boilerplate and encourage proper isolation.

Why Use Pest?
Pest is popular in the Laravel community because:

The syntax is clean and readable
Tests are shorter and expressive
Faster onboarding for students/juniors
Provides plugins, snapshot testing, datasets
Fully compatible with PHPUnit
Used in many modern tutorials and open-source Laravel projects

Example syntax comparison:
PHPUnit
PHPpublic function test_example() {    $this->assertTrue(true);}Show more lines
Pest
PHPtest('example', function () {    expect(true)->toBeTrue();});Show more lines

Show students how concise Pest tests are. This is often the turning point where they understand why Pest is preferred.

Exploring a Simple Test
Pest Example:
PHPtest('basic math works', function () {    expect(2 + 2)->toBe(4);});Show more lines
Laravel Feature Test Example:
PHPtest('home page loads', function () {    $response = $this->get('/');    $response->assertStatus(200);});Show more lines
Run tests:
PHPphp artisan testShow more lines

Explain how Laravel’s testing layer simulates HTTP requests without a live server.

Understanding Code Coverage
Code coverage measures how much of your codebase is executed by tests.
Types of coverage:

Line coverage – % of lines run
Branch coverage – whether all decision paths run
Function/method coverage – % of methods executed

Higher coverage ≠ good tests — but low coverage = risky code.
Generate coverage:
Shellphp artisan test --coverageShow more lines

Point out that 100% coverage isn’t realistic or required, but 60–80% is common for maintainable projects.

Comparing xDebug and PCov






























FeaturexDebugPCovPerformance❌ Slow✅ FastAccuracyHighHighUse CaseDebugging, profiling, coverageCoverage onlyBest For Testing❌ No✅ Yes
Summary:

xDebug → use for debugging
PCov → use for fast code coverage

Install PCov:
Shellpecl install pcovShow more lines

Laravel’s test suite runs noticeably faster with PCov. Developers often disable xDebug during testing.

Practice: Basic Test Writing
In-class practice tasks:

Write a basic math test
Write a route test using $this->get('/')
Write a model factory test
Write a validation test
Add tests for a controller method


Encourage pairing students so they see different testing approaches.

Out-of-Class Activities
To strengthen testing skills:
🔍 Research

Read the Pest documentation
Explore Laravel’s testing section
Research code coverage tools

🧪 Practice

Convert PHPUnit tests to Pest
Add coverage to a small Laravel project
Try writing dataset‑driven tests

🎓 Tutorials

Laravel documentation: Testing
Pest PHP official intro tutorials
Laracasts testing series
FreeCodeCamp Laravel testing videos


Tell students that consistency, not intensity, builds automated testing skills.



---
level: 2
---

---
layout: section
---

# Recap Checklist

---
level: 2
---

# Recap Checklist

- [ ] 

---
level: 2
---

# Quick Summary

-

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

> - Some content was generated with the assistance of Microsoft CoPilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:
- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
