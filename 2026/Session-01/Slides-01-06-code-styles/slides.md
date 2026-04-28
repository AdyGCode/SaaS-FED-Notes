---
theme: nmt
background: https://cover.sli.dev
title: Session 01 - Code Styles
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
---

# Session 01: Code Styles

## Unified Code Style Guide

#### All Diploma of Information Technology Specialisations


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
| --------------------------------------------------- | --------------------------- |
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
---

# Objectives

- Apply industry‑aligned code style rules consistently
- Recognise poor vs good code practices
- Use framework‑specific idioms correctly
- Justify style choices in reviews and assessments

<!--
Presenter notes:
Explain how outcomes map to assessment criteria.
-->

---
level: 2
---

# Contents 

<Toc minDepth="1" maxDepth="1" columns="2" />

---
class: text-left
---


---

# Core Principles

- Readability > Cleverness
- Consistency over preference
- Fail fast, fail clearly

<!-- Presenter notes:
Emphasise that tools enforce these rules.
-->

---

## ❌ Before vs ✅ After Example (Laravel)

<Announcement type="brainstorm" title="What's Wrong">
<p>What do you think is wrong with the code?</p>
</Announcement>

<br>

````md magic-move

```php
class usr_svc{public function getusr($i){return DB::t('u')->f($i);} }
```


```php
class UserService
{
    public function getUserById(int $id): User
    {
        return User::findOrFail($id);
    }
}
```

````

<!-- Presenter notes:
Ask learners to identify improvements before showing after.
-->

---

## C++ Example

```cpp
int* value = new int(5);
```

```cpp
auto value = std::make_unique<int>(5);
```

<!-- Presenter notes:
Explain RAII and memory safety.
-->

---

## Flutter (Dart) Example

```dart
Container(child: Text('Hello'));
```

```dart
const Text('Hello');
```

<!-- Presenter notes:
Discuss const widgets and performance.
-->

---

# Exercises

## Exercise 1: Refactor the Code

Given the following PHP code, refactor it to meet PSR‑12 and Laravel idioms:

```php
function getuser($id){return DB::table('users')->where('id',$id)->first();}
```

---

## Exercise 2: Identify Issues

What style and safety issues exist in this C++ snippet?

```cpp
int* data = new int[10];
```

---

## Exercise 3: Framework Idioms

Rewrite the following Flutter code using best practices:

```dart
Text('Counter');
```

<!-- Presenter notes:
Encourage discussion and peer review of solutions.
-->

---




# Recap Checklist

- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 

---
level: 2
---

# Exit Ticket

> Pose a question about the content


---

# Acknowledgements

- Fu, A. (2020). Slidev. Sli.dev. https://sli.dev/
- Font Awesome. (2026). Font Awesome. Fontawesome.com; Font Awesome. https://fontawesome.com/
- Mermaid Chart. (2026). Mermaid.ai. https://mermaid.ai/

- Slide template
  - Adrian Gould

<br>

> - Mermaid syntax used for some diagrams
> Some content may have been generated with the assistance of Microsoft CoPilot
