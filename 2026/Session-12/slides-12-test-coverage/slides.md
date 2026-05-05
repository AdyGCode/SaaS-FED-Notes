---
theme: nmt
background: https://cover.sli.dev
title: Session 12 - Testing & Code Coverage
drawings:
  persist: false
transition: slide
mdc: true
duration: 90min
---

# Testing & Code Coverage

## Session 12

## SaaS 1 – Cloud Application Development (Front-End Dev)

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa-brands-github class="text-zinc-300 text-2xl mr-2"/>
  </a>
</div>


<!-- Presenter Notes:
Scope

PEST testing
PEST testing (Browser)
Code coverage
Static Analysis

-->


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

## Knowledge

- 

::right::

## Skills

- 

<!-- Presenter Notes:

-->

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2"></Toc>

---
layout: figure
figureUrl: orly-book-cover-hoping-nobody-hacks-you.png
---


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

# 🌟 Ice Breaker

## ...

<!-- Presenter Notes:

-->

---
layout: section
---

# PEST Testing

---
level: 2
layout: two-cols
---

# PEST Testing

## Recap

::left::

## Unit Tests

- ...

::right::

## Feature Tests

- ...

<!-- Presenter Notes:

-->

---
layout: section
---

# PEST Tests: Browser tests

### Setting up for Automated Browser Testing

---
level: 2
---

# PEST Tests: Browser tests

### Requirements

- Pest v4 introduced the browser testing
- Requires teh PHP Sockets extension
- Requires Pest plugin
- Requires Node package (Playwrite)


<!-- Presenter Notes:

-->

---
level: 2
---

# PEST Tests: Browser tests

## Enable PHP's Sockets extension

Laragon:
Right click on Laragon
Hover over PHP
Hover over Extensions
If Sockets is not ticked, Click on it to enable

## Install PEST Plugin

```shell
composer require pestphp/pest-plugin-browser:^4.0 --dev
```

## Install Playwright

```shell
pnpm install playwright@latest -D
pnpx playwright install
```


<!-- Presenter Notes:

-->

---
layout: section
---

# Static Analysis & Code Coverage

---
level: 2
layout: two-cols
---

# Static Analysis & Code Coverage

## Requirements

<Announcement type=error title="Compatibility">
You should **NOT enable** xDebug and PCov at the same time. You will 
encounter serious iussues with PHP, and most likely be unable to execute 
any code. 
</Announcement>

::left:: 
### Option 1
- xDebug
- Larastan

Pros:

✅ All‑in‑one debugging tool
Provides step debugging, stack traces, variable inspection, profiling, and code coverage.
✅ Excellent developer experience
Deep IDE integration (PhpStorm, VS Code) for breakpoints and step‑through debugging.
✅ Well‑established and widely supported
Large community, extensive documentation, and predictable behaviour.
✅ Accurate coverage reporting
Produces precise line‑level and branch coverage data.
✅ Useful beyond testing
Valuable for diagnosing complex runtime bugs during development.

Cons:

❌ Significant performance overhead
Tests and requests can be 2–5× slower, especially with coverage enabled.
❌ Heavy memory usage
Can cause OOM issues in large test suites or CI environments.
❌ Configuration complexity
Requires careful ini tuning (modes, triggers, environment flags).
❌ Not ideal for CI
Slower pipelines unless coverage is explicitly disabled.
❌ Debugging features mostly unused in CI
Overkill when you just want coverage metrics.

::right::
## Option 2
- Pcov
- Larastan

Pros:

✅ Extremely fast code coverage
Purpose‑built for coverage; often 3–10× faster than Xdebug.
✅ Minimal overhead
Very low memory and CPU impact, ideal for large test suites.
✅ CI‑friendly
Great choice for automated pipelines where speed matters.
✅ Simple configuration
Usually just enable the extension—no complex modes or triggers.
✅ Works perfectly with PHPUnit / PEST
Seamless coverage integration.
✅ Recommended by the Laravel community for CI
Frequently used in production test pipelines.

Cons:

❌ No step debugging
Coverage only—no breakpoints, stack inspection, or profiling.
❌ Not a general debugging tool
You still need Xdebug locally for debugging logic issues.
❌ Less visibility into runtime behaviour
Cannot inspect variables or execution flow interactively.
❌ Another extension to manage
Requires switching extensions between local and CI environments.


✅ Recommended Strategy (Best Practice)


EnvironmentRecommendationLocal developmentXdebug + LarastanCI / Coverage runsPCOV + Larastan
Why this works best:

You get excellent debugging locally
You get fast, reliable coverage in CI
Larastan works identically in both setups
Many teams toggle extensions via .env or separate php.ini files


✅ One‑line summary

Xdebug is for humans debugging code; PCOV is for machines measuring coverage.


---
level: 2
layout: two-cols
---

# Static Analysis & Code Coverage

## Installing xDebug / PCov

### PCov

When using a PC:

::left::



Download the relevant DLL from https://pecl.php.net/package/pcov
Extract the four files from the zip file
copy the DLL and PDB file into the `Laragon/bin/php/php-8.x.y-.../ext` folder

Open the `Laragon/bin/php/php-8.x.y-.../php.ini`
Move to the bottom of the file and add
```ini
[pcov]
extension=pcov
pcov.enabled=1
```

Save teh changes

Check pcov enabled using
```shell
php --info | grep pcov
```

You should see something similar to:

```text
pcov
pcov.directory => C:\Users\5001775\Source\Repos
pcov.exclude => none
pcov.initial.memory => 65336 bytes
pcov.initial.files => 64
```

::right::

...

---
level: 2
layout: two-cols
---

# Static Analysis & Code Coverage

## Installing xDebug / PCov

### xDebug

<Announcement type=info title="TO DO">
Notes on installing xDebug are to be added.
</Announcement>

---
level: 2
---

# Static Analysis & Code Coverage
### Installing Larastan (& PhpStan static analysis tool)

Execute the following composer command:

```shell
composer require larastan/larastan --dev
```

Static analysis allows you to find ...

It literally checks code WITHOUT executing it.

---
level: 2
---

# Static Analysis & Code Coverage

## Generating a Code Coverage Report (HTML)

Go to the command line, and ensure iu are  in the project's folder.

Make sure you have your development server running (`composer run dev`).

<Announcement type=info title="Why Run Dev Server">
<p>If your tests have any browser testing then you need to have the 
development server executing so it may respond to requests.</p>
</Announcement>


---
level: 2
---

# Static Analysis & Code Coverage

## Generating a Code Coverage Report (HTML)

Now you execute:

```shell
php artisan test --coverage-html=storage/coverage
```

This requests Laravel's testing to pass onto PHPUnit the command line 
switch that generates an HTML version of the code coverage report and store 
it in the `storage/coverage` folder.

When you do this you will get an HTML report that is openable as a local 
file in a browser, with:

- Per‑file coverage
- Line‑by‑line highlighting
- Clickable navigation


---
level: 2
layout: grid
---

# Static Analysis & Code Coverage

## Viewing a Code Coverage Report (HTML)

::tl::

### Via File Explorer

To view the report:
- open file explorer, 
- navigate to the Application's code repository, 
- navigate into the `storage/coverage` folder.

Finally:
- double-click the `index.html` to open the file.

::bl::

### Via Command Line (Option 1)

In a command line, and in your project folder:

```shell
cd storage/coverage
start index.html
```

::br::

### Via Command Line (Option 2)

In a command line, and in your project folder:

```shell
start storage/coverage/index.html
```

---
level: 2
---

# Static Analysis & Code Coverage

## Viewing the Report (Home page)


Here are some examples from a code coverage report, showing the nested 
details:

![Code Coverage Home page](./code-coverage-home.png)

---
level: 2
---

# Static Analysis & Code Coverage

## Example Report 2

![Code Coverage Http page](./code-coverage-http.png)

---
level: 2
---

# Static Analysis & Code Coverage

## Example Report 3


<div class="overflow-scroll overflow-x-clip block mt-4 h-96">
  <div class="w-11/12">

![Code Coverage Destroy Topic Request](./code-coverage-destroytopicrequest.png)

  </div>
</div>

---
layout: section
---

# Static Analysis



---

# Out-of-Class Activities

**Research**

- ...

**Practice**

- ...

**Tutorials**

- ...

<!-- Presenter Notes:

-->

---

# Summary Checklist

- [ ] ...

<!-- Presenter Notes:

-->

---
level: 2
layout: grid
---

# Exit Ticket Questions

::tl::

<Announcement type="brainstorm">
...</Announcement>


::tr::

<Announcement type="brainstorm">
...</Announcement>


::bl::

<Announcement type="brainstorm">
...</Announcement>

::br::

<Announcement type="brainstorm">
...</Announcement>


<!-- Presenter Notes:

-->

---

# Acknowledgements & References (APA v7)

- TODO: Add references etc

> Some content may have been generated with the assistance of Microsoft
> CoPilot


<!-- Presenter Notes:

-->

---
layout: end
---

# Fin!

Haiku here



<!-- Presenter Notes:

-->

---
