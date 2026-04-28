---
theme: nmt
background: https://cover.sli.dev
title: Session 11 - Laravel Testing Revisited
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 90min
---

# Session 11: Laravel Testing Revisited

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

### Required Knowledge

- Explain what software testing is & where it fits in Laravel
- Identify PHP testing frameworks & Laravel-specific tools
- Explain why **Pest** is widely adopted in Laravel
- Compare **Xdebug** vs **PCOV** for coverage

::right::

## Practice

- Measure & interpret **code coverage**
- Write unit, feature, & **browser** tests (Pest v4)
- Practice writing tests for **Topic** (CRUD) & a **Contact** page
- Plan out-of-class activities to build testing habits

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" columns="2" />

---
layout: figure
figureUrl: public/orly-book-cover-draft-testing.png
---

---
layout: section
---

# 🌟 Ice Breaker

## The Testing Time Machine

<!--

- You need a timer, initially set to 90s

“The Testing Time Machine” (5–7 minutes)

Goal: Activate prior knowledge, reduce anxiety around testing terminology, and transition participants into thinking about why testing matters before diving into Laravel, Pest, and Playwright.

-->

---
layout: two-cols
level: 2
---

# Ice Breaker: “The Testing Time Machine”

::left::

## Question:

Think back to a time when a bug made it into production… 

What happened?

<br>

<Announcement type="duration">
You have Ninety (90) Seconds!
</Announcement>
::right::

## Actions

Turn to the person next to you and share:

- The bug (**non-sensitive** details only)...
- How it impacted users or the team...
- Whether a test could have prevented it...


<!--
You need a 90 second timer!
-->


---
level: 2
---

# Ice Breaker: “The Testing Time Machine”

## Quick Group Debrief

<Announcement type="brainstorm" class="text-2xl mt-12">
Did your partner have any humorous bugs or issues?
</Announcement>

<br>

<Announcement type="priority" class="text-2xl mt-12">
Want to volunteer your (or your partner's) example?
</Announcement>

<!--
Invite 2–3 volunteers to share (keep it light and humorous—bugs are universal!).

Then summarize:

Most production issues come from untested interactions or unexpected user behaviour

These issues are exactly what feature tests and browser tests aim to catch

Modern tooling like Pest v4’s Browser plugin and Playwright provides realistic browser automation (“real clicks, real DOM, real JS”), which the Pest docs emphasize is essential for ensuring applications work across browsers and devices

Laravel’s own testing documentation stresses that feature tests give the highest confidence because they simulate real user flows end‑to‑end 1
-->

---
layout: default
level: 2
---

# Quick Poll 1/3

## Have you written any feature tests before?

<Poll 
question="Have you written any feature tests before?"
:answers="['yes','no']"
/>


---
level: 2
---

# Quick Poll 2/3

## Have you written browser/end-to-end tests?

<Poll 
question="Have you written browser/end-to-end tests?"
:answers="['yes','no']"
/>

---
level: 2
---

# Quick Poll 3/3

## Who is new to Pest?

<Poll 
question="Who is new to Pest?"
:answers="['yes','no']"
/>



---
layout: section
---

# What is Testing

--- 
level: 2
---

# What is Software Testing?

## Software testing

- verifies that code behaves as expected, 
- prevents regressions, and 
- documents intent. 

In Laravel, tests also provide a fast
feedback loop via `php artisan test`.

--- 
level: 2
---

# What is Software Testing? 2

Key benefits:

- Safer refactoring and upgrades
- Faster iteration with confidence
- Clearer design (tests describe behaviour)
- Repeatable checks in CI/CD

<!-- notes 
Stress behaviour over implementation. Students should test *outcomes*, not
private details.
-->

---
layout: section
---

# PHP & Laravel Testing Landscape

---
layout: two-cols
level: 2
---

# PHP & Laravel Testing Landscape

::left::

### PHP Tools

- **PHPUnit**
    - foundation used across PHP
    - Pest builds on it
- **Pest** 
    - modern, readable syntax; 
    - integrates deeply with Laravel
- **Codeception**
    - scenario/BDD-style testing across layers
- **Behat**
    - BDD with Gherkin-style specs

::right::

### Laravel Tools

- Test runners (`php artisan test`)
- HTTP test helpers
    - `get`, `postJson`, `assertOk`, etc.
- **Model factories**, database helpers, fakers
    - Mail, Bus, Events
- **Pest v4 Browser Testing** 
    - Playwright-based
- **Laravel Dusk** 
    - legacy browser tests

<!-- notes 
Laravel supports both Pest and PHPUnit out of the box. 

Pest rides on PHPUnit’s engine.

Modern apps can do most browser tests directly in Pest v4. 

Dusk is still available but often unnecessary now.
-->

---
layout: section
---

# Why Pest?

---
level: 2
layout: two-cols
---
# Why Pest?

::left::

- Concise, expressive syntax 
    - faster authoring & reviews
- Built on PHPUnit 
    - full ecosystem compatibility
- First-class **Laravel** plugin and helpers
- **Pest v4**: 
    - integrated **Browser Testing**, 
        - visual & smoke tests 
        - device emulation
    - sharding

::right::

### PHP Unit

```php [PHP]
public function test_example() { 
    $this->assertTrue(true); 
}
```

<br>

### Pest

```php [PHP]
it('works', function () { 
    expect(true)->toBeTrue(); 
});
```


<!-- notes
Show the readability delta. Less ceremony helps students focus on behaviour.
 -->

---
layout: two-cols
level: 2
---

# Our Example Domain

<br>
The "contacts" app is the context/domain we use for demonstration.

The "contact us" page is the specific area.


<Announcement type="info" title="Remember">
<code>created_at</code> and <code>updated_at</code> are generated using <code>timestamps()</code> method.
</Announcement>

<br>

## (Two) Testing Models

::left:: 

#### Topic
`id`, `name`, `description`, `available`, `created_at`, 
  `updated_at`

::right::

#### Message

`id`, `name`, `email`, `subject`, `topic_id`, `message`, `read_at`, `created_at`, 
  `updated_at`

<!-- notes 
Students will CRUD Topics and submit Messages via a simple Contact page. 

We’ll test both HTTP and browser flows.


Topic: - `id`, `name` (string), `description` (text, nullable), `available` 
(boolean, default true), timestamps

Message: - `id`, `name` (string), `email` (string), `subject` (string), `topic_id` (fk
  to topics), `message` (text), `read_at` (nullable datetime), timestamps

-->

---
level: 2
---

# Setup: Packages & Scaffolding

Before starting:

- Duplicate `.env` and name it `.env.testing`
- Edit `.env.testing` 
    - Update `APP_NAME` to include `Testing: ` 
    - Change the DB details:
        - DB_CONNECTION is sqlite
        - DB_DATABASE is testing.sqlite

::left:: 


1) **Install Pest + Laravel plugin**

```bash
composer require --dev pestphp/pest pestphp/pest-plugin-laravel
php artisan pest:install
```

2) **Enable Pest v4 Browser Testing** (Playwright)

```bash
composer require --dev pestphp/pest-plugin-browser
npm install playwright@latest
npx playwright install
```

3) Run tests

```bash
php artisan test
```

<!-- notes 

Ensure `.env.testing` is configured (separate DB). Add
`uses(RefreshDatabase::class);` to `tests/Pest.php` for DB isolation.
-->

---

# Migrations & Models (Topic)

**database/migrations/YYYY_MM_DD_create_topics_table.php**

```php
Schema::create('topics', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->text('description')->nullable();
    $table->boolean('available')->default(true);
    $table->timestamps();
});
```

**app/Models/Topic.php**

```php
class Topic extends Model
{
    protected $fillable = ['name','description','available'];
    protected $casts = ['available' => 'boolean'];
    public function messages(){
        return $this->hasMany(Message::class);
    }
}
```

---

# Migrations & Models (Message)

**database/migrations/YYYY_MM_DD_create_messages_table.php**

```php
Schema::create('messages', function (Blueprint $table) {
    $table->id();
    $table->string('name');
    $table->string('email');
    $table->string('subject');
    $table->foreignId('topic_id')->constrained()->cascadeOnDelete();
    $table->text('message');
    $table->timestamp('read_at')->nullable();
    $table->timestamps();
});
```

**app/Models/Message.php**

```php
class Message extends Model
{
    protected $fillable = ['name','email','subject','topic_id','message','read_at'];
    protected $casts = ['read_at' => 'datetime'];
    public function topic(){ return $this->belongsTo(Topic::class); }
}
```

---

# Controllers & Routes

**app/Http/Controllers/TopicController.php** (excerpt)

```php
public function store(Request $request)
{
    $data = $request->validate([
        'name' => ['required','string','max:255'],
        'description' => ['nullable','string'],
        'available' => ['boolean'],
    ]);
    $topic = Topic::create($data);
    return redirect()->route('topics.show', $topic)->with('status','Created');
}
```

**Contact page** — `MessageController@store`

```php
public function store(Request $request)
{
    $data = $request->validate([
        'name'=>['required','string','max:255'],
        'email'=>['required','email'],
        'subject'=>['required','string','max:255'],
        'topic_id'=>['required','exists:topics,id'],
        'message'=>['required','string'],
    ]);
    Message::create($data);
    return back()->with('status','Thanks, we will respond soon.');
}
```

**routes/web.php**

```php
Route::resource('topics', TopicController::class);
Route::post('/contact', [MessageController::class,'store'])->name('contact.store');
```

---

# Factories & Seeders

**database/factories/TopicFactory.php**

```php
$factory->define(Topic::class, function (Faker $f) {
    return [
        'name' => $f->unique()->words(2, true),
        'description' => $f->optional()->paragraph(),
        'available' => $f->boolean(85),
    ];
});
```

**database/factories/MessageFactory.php**

```php
$factory->define(Message::class, function (Faker $f) {
    return [
        'name' => $f->name(),
        'email' => $f->safeEmail(),
        'subject' => $f->sentence(3),
        'topic_id' => Topic::factory(),
        'message' => $f->paragraph(),
        'read_at' => null,
    ];
});
```

---

# Writing Tests: Unit

**tests/Unit/TopicTest.php**

```php
it('casts available to boolean', function () {
    $topic = new Topic(['available' => 1]);
    expect($topic->available)->toBeBool()->toBeTrue();
});
```

**Principles**

- Unit tests target *small, isolated* behaviour
- Keep them fast; avoid the database when possible

---

# Writing Tests: Feature (CRUD — Topic)

**tests/Feature/TopicCrudTest.php**

```php
use App\Models\Topic;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

it('creates a topic', function () {
    $response = $this->post(route('topics.store'), [
        'name' => 'Accessibility',
        'description' => 'ARIA, color contrast, keyboard nav',
        'available' => true,
    ]);

    $response->assertRedirect();
    expect(Topic::where('name','Accessibility')->exists())->toBeTrue();
});

it('validates required fields when creating a topic', function () {
    $this->post(route('topics.store'), [])->assertSessionHasErrors(['name']);
});

it('updates a topic', function () {
    $topic = Topic::factory()->create();
    $this->put(route('topics.update', $topic), ['name' => 'Updated'])
        ->assertRedirect();
    expect($topic->refresh()->name)->toBe('Updated');
});

it('deletes a topic', function () {
    $topic = Topic::factory()->create();
    $this->delete(route('topics.destroy',$topic))->assertRedirect();
    expect(Topic::find($topic->id))->toBeNull();
});
```

---

# Writing Tests: Feature (Contact Page — Message)

**tests/Feature/ContactMessageTest.php**

```php
use App\Models\{Message, Topic};
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

it('submits a contact message', function () {
    $topic = Topic::factory()->create(['available'=>true]);

    $res = $this->post(route('contact.store'), [
        'name' => 'Ada Lovelace',
        'email' => 'ada@example.com',
        'subject' => 'Syllabus question',
        'topic_id' => $topic->id,
        'message' => 'Could you clarify the assessment rubric?',
    ]);

    $res->assertSessionHasNoErrors()->assertRedirect();
    expect(Message::whereEmail('ada@example.com')->exists())->toBeTrue();
});

it('validates contact fields', function () {
    $this->post(route('contact.store'), [])->assertSessionHasErrors([
        'name','email','subject','topic_id','message'
    ]);
});
```

---

# Browser Testing with Pest v4 (Playwright)

**Install once**

```bash
composer require --dev pestphp/pest-plugin-browser
npm install playwright@latest
npx playwright install
```

**tests/Browser/ContactPageTest.php**

```php
use App\Models\Topic;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

it('lets a user submit the contact form in a real browser', function () {
    $topic = Topic::factory()->create(['name'=>'General', 'available'=>true]);

    $page = visit('/contact');

    $page->type('name','Grace Hopper')
         ->type('email','grace@example.com')
         ->type('subject','Compiler help')
         ->select('topic_id', (string)$topic->id)
         ->type('message','I found a bug (literally).')
         ->press('Send')
         ->assertSee('Thanks, we will respond soon.')
         ->assertNoJavascriptErrors();
});
```

**Run**

```bash
./vendor/bin/pest --filter=ContactPageTest
```

<!-- notes -->
Pest v4’s browser tests support Laravel helpers, device emulation, dark mode,
screenshots, and parallel runs.

---

# Code Coverage: What & How

Coverage tells you which code executed during tests (line/branch/path).

- Run in Laravel: `php artisan test --coverage`
- Generate HTML with Pest: `vendor/bin/pest --coverage-html=build/coverage`
- Enforce minimum: `vendor/bin/pest --coverage --min=80`

**Tip:** Exclude untestable sections with `@codeCoverageIgnoreStart/End`.

<!-- notes -->
Aim for meaningful tests over chasing 100%. 60–80% is often healthy for apps.

---

# Xdebug vs PCOV for Coverage

**Xdebug**

- Full-featured (debugger, profiler, coverage incl. branch/path)
- Heavier; slower test runs when enabled

**PCOV**

- Lightweight, **fast line coverage** only
- Great for speeding up suites; historically less maintained but usable on
  modern PHP

**Practical guidance**

- Use **PCOV** for fast CI coverage
- Switch to **Xdebug** when you need step-debugging or branch/path metrics

<!-- notes -->
Keep only one driver enabled at a time. Use env or ini toggles to switch.

---

# In-Class Practice Checklist

- ✅ Unit: Topic casts & relationships
- ✅ Feature: Topic CRUD + validation
- ✅ Feature: Contact form submission + validation
- ✅ Browser: Contact form end-to-end (real browser)
- ✅ Coverage: Run and review HTML report

<!-- notes -->
Encourage pairing and red/green/refactor cycles.

---

# Out-of-Class Activities

**Research**

- Read Pest docs (coverage & browser testing)
- Review Laravel testing guide

**Practice**

- Convert one PHPUnit file to Pest
- Add dataset-driven validation tests
- Add visual regression assertion to a critical page

**Tutorials**

- Laracasts & official docs on Pest and Laravel testing

---

# References (for students)

- Pest v4 Browser Testing announcement & docs
- Pest coverage guide
- Laravel testing docs (12.x/13.x)
- PCOV vs Xdebug discussions / PHPUnit manual

Laravel Documentation

Laravel. (2026). Testing: Getting started (Laravel 13.x). Laravel. 1
Laravel. (2026). Starter kits: Laravel Breeze (Laravel 11.x). Laravel. [Elegant Te...ou Forward]

Pest PHP (Testing Framework)

Pest Documentation. (2026). Browser testing. PestPHP.
Crozat, B. (2025, September 30). What’s new in Pest 4 and how to upgrade. benjamincrozat.com.

Playwright (Browser Automation)

Microsoft Playwright Team. (2026). Installation: Playwright documentation. Playwright. [deepwiki.com]

Code Coverage

Redmond, P. (2024, March 28). Generate code coverage in Laravel with PCOV. Laravel News. 4

General Guidance / CI Pipelines

DevOps7. (2025). Setting up Laravel CI/CD with test coverage gates. DevOps7.com.

Breeze Installation Articles

Laravel Daily. (2025, February 27). How to (Still) Use Laravel Breeze in Laravel 12. laraveldaily.com. [pestphp.com]

<!-- notes -->

---

# Summary Checklist

- [ ] Explain testing & frameworks
- [ ] Use Pest for unit/feature/browser tests
- [ ] CRUD tests for Topic
- [ ] Contact form tests for Message
- [ ] Generate & read coverage
- [ ] Know when to use Xdebug vs PCOV

---

---

# Browser Testing: Topic Create (Admin Flow)

**tests/Browser/TopicCreateTest.php**

```php
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

it('creates a topic via the browser UI', function () {
    $page = visit('/topics/create')
        ->type('name','Testing Practices')
        ->type('description','Unit, Feature, Browser tests')
        ->check('available')
        ->press('Save')
        ->assertSee('Created')
        ->assertSee('Testing Practices')
        ->assertNoConsoleLogs();
});
```

---

# Step‑by‑Step Demo (Contact Page with Topic)

1. **Migrations** for `topics` and `messages`
2. **Models** with relationships & casts
3. **Routes**: `Route::resource('topics', ...)`,
   `Route::post('/contact', ...)`
4. **Controllers**: validate & persist; flash success messages
5. **Views**: contact form with `<select name="topic_id">`
6. **Factories** for Topic & Message
7. **Pest** tests
    - Unit: casts/relations
    - Feature: Topic CRUD & Contact POST
    - Browser: Contact E2E (Playwright)
8. **Coverage**: `php artisan test --coverage` + HTML report

---

# Contact Page (Blade) — Minimal View

**resources/views/contact.blade.php**

```blade
@extends('layouts.app')
@section('content')
<h1>Contact</h1>
@if(session('status'))
  <div role="alert">{{ session('status') }}</div>
@endif
<form method="POST" action="{{ route('contact.store') }}">
  @csrf
  <label>Name <input type="text" name="name" value="{{ old('name') }}"></label>
  @error('name')<div>{{ $message }}</div>@enderror

  <label>Email <input type="email" name="email" value="{{ old('email') }}"></label>
  @error('email')<div>{{ $message }}</div>@enderror

  <label>Subject <input type="text" name="subject" value="{{ old('subject') }}"></label>
  @error('subject')<div>{{ $message }}</div>@enderror

  <label>Topic
    <select name="topic_id">
      <option value="">-- Choose --</option>
      @foreach(\App\Models\Topic::where('available',true)->orderBy('name')->get() as $topic)
        <option value="{{ $topic->id }}" @selected(old('topic_id')==$topic->id)>{{ $topic->name }}</option>
      @endforeach
    </select>
  </label>
  @error('topic_id')<div>{{ $message }}</div>@enderror

  <label>Message <textarea name="message">{{ old('message') }}</textarea></label>
  @error('message')<div>{{ $message }}</div>@enderror

  <button type="submit">Send</button>
</form>
@endsection
```

<!-- notes -->
Use semantic labels for accessibility. Keep element names matching your test
selectors.

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

> Some content may have been generated with the assistance of Microsoft CoPilot

---
layout: end
---

# Remember: 🦆

### With Laravel and Pest:

- your code can be clean,
- your tests can be sharp, and...
- according to the rubber duck:
- your sanity can remain… mostly intact.
