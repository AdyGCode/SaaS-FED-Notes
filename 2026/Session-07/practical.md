---
marp: true
paginate: true
size: A4
theme: nmtafe_v2
---

# Session 7 Practical

## Models, Relationships, Factories, Seeders and Data Retrieval

**Worked example:** Topics and Messages in the Example App
**Assessment transfer:** User–Contact in the assessment starter

```text
Existing MariaDB Tables
        ↓
Eloquent Models
        ↓
Relationships
        ↓
Factories
        ↓
Seeders
        ↓
Retrieve and Inspect Data
        ↓
SQL → Query Builder → Eloquent
        ↓
Transfer to Assessment Starter
```

---

# Goalß

By the end of this practical you should be able to:

- create Eloquent models for existing database tables
- implement and test a one-to-many relationship
- generate realistic sample data using factories
- populate repeatable development data using seeders
- retrieve data using SQL, Query Builder and Eloquent
- explain how a database row becomes an Eloquent object
- recognise how Route Model Binding resolves a model
- transfer the same pattern to the assessment starter

> Controllers and Blade output are left for Session 8.

---

# Before You Start

Use the **Example App** from the end of Session 6.

Confirm the migrations are available and the database connection works:

```bash
php artisan migrate:status
```

Inspect the tables:

```bash
php artisan db:table topics
php artisan db:table messages
```

You should have working `topics` and `messages` tables before continuing.

---

# 1 — Create the Topic Model

Generate the model:

```bash
php artisan make:model Topic
```

```text
app/Models/Topic.php
```

Add the `HasFactory` trait:

```php
use Database\Factories\TopicFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
```

Inside the class:

```php
/** @use HasFactory<TopicFactory> */
use HasFactory;
```

---

# Add Topic Fillable Attributes

Add:

```php
protected $fillable = [
    'name',
    'description',
    'available',
];
```

Your model should now represent the existing `topics` table.

Laravel conventions map:

```text
Topic model
    ↓
topics table
```

No `$table` property is required.

---

# Inspect Topic Data with Tinker

Start Tinker:

```bash
php artisan tinker
```

Run:

```php
use App\Models\Topic;

$topic = Topic::first();
$topic;
```

Then inspect:

```php
$topic?->getKey();
$topic?->name;
$topic?->description;
$topic?->available;
```

### Observe

A row from `topics` is represented as a PHP `Topic` object.

---

# Database Row → Eloquent Object

```text
DATABASE                    ELOQUENT

topics table                Topic model
     ↓                           ↓
database row  ───────────▶  Topic object
     ↓                           ↓
columns                     attributes
```

The database stores the data.

The Eloquent model gives your PHP application an object-oriented way to work with it.

---

# 2 — Create the Message Model

Generate:

```bash
php artisan make:model Message
```

```text
app/Models/Message.php
```

Add:

```php
use Database\Factories\MessageFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
```

Then:

```php
/** @use HasFactory<MessageFactory> */
use HasFactory;
```

---

# Add Message Fillable Attributes

Add fields that match the existing `messages` table & a cast for `read_at`:

```php
protected $fillable = [
    'topic_id',
    'name',
    'email',
    'subject',
    'message',
    'read_at',
];
```

```php
protected function casts(): array
{
    return [
        'read_at' => 'datetime',
    ];
}
```

---

# 3 — Add the Relationship

The database design & relationship needs both directions:

```text
TOPICS
  id
   │
   │ 1
   │
   │ many
   ▼
MESSAGES
  topic_id
```

```text
Topic
  └── hasMany Messages

Message
  └── belongsTo Topic
```

---

# Topic hasMany Messages

In `Topic.php` import:

```php
use Illuminate\Database\Eloquent\Relations\HasMany;
```

Add:

```php
public function messages(): HasMany
{
    return $this->hasMany(Message::class);
}
```

Laravel uses the conventional foreign key:

```text
messages.topic_id
```

---

# Message belongsTo Topic

In `Message.php` import:

```php
use Illuminate\Database\Eloquent\Relations\BelongsTo;
```

Add:

```php
public function topic(): BelongsTo
{
    return $this->belongsTo(Topic::class);
}
```

### Explain

Why does `Message` use `belongsTo()` rather than `hasMany()`?

---

# Test the Relationship Structure

In Tinker:

```php
use App\Models\Topic;
use App\Models\Message;

$topic = Topic::first();
$message = Message::first();
```

If records exist, try:

```php
$topic?->messages;
$message?->topic;
```

If no Messages exist yet, continue to the factory activities.

---

# Relationship Method vs Related Data

Compare:

```php
$topic->messages()
```

with:

```php
$topic->messages
```

### Observe

`messages()` gives a relationship/query object.

`messages` gives the related Message models.

Try:

```php
$topic->messages()->count();
$topic->messages->count();
```

---

# 4 — Create the Topic Factory

Generate:

```bash
php artisan make:factory TopicFactory --model=Topic
```

```text
database/factories/TopicFactory.php
```

Define:

```php
public function definition(): array
{
    return [
        'name' => fake()->unique()->word(),
        'description' => fake()->sentence(),
        'available' => fake()->boolean(),
    ];
}
```

---

# Factories Must Respect the Schema

Inspect the Topic migration. If the schema says:

```php
$table->string('name', 16)->unique();
```

then factory data must respect:

- maximum length
- uniqueness
- valid data type

The database constraints still apply to factory-generated data.

---

# Test make() vs create()

In Tinker:

```php
Topic::factory()->make();
```

```php
Topic::count();
```

```php
Topic::factory()->create();
```

```php
Topic::count();
```

What changed in the database?

---

# Generate Several Topics

Run:

```php
$topics = Topic::factory()->count(5)->create();
```

Inspect:

```php
$topics;
$topics->count();
```

Then verify:

```bash
php artisan db:table topics
```

---

# 5 — Create the Message Factory

Generate:

```bash
php artisan make:factory MessageFactory --model=Message
```

```text
database/factories/MessageFactory.php
```

Import:

```php
use App\Models\Topic;
```

---

# Define the Message Factory

Use:

```php
public function definition(): array
{
    return [
        'topic_id' => Topic::factory(),
        'name' => fake()->name(),
        'email' => fake()->safeEmail(),
        'subject' => fake()->sentence(4),
        'message' => fake()->paragraph(),
        'read_at' => null,
    ];
}
```

### Observe

The Message factory can create its required related Topic automatically (if it imports it!)

---

# Test Related Factory Data

In Tinker:

```php
$message = Message::factory()->create();
```

Inspect:

```php
$message->topic_id;
$message->topic;
```

Then:

```php
$message->topic->messages;
```

How did the Message receive a valid foreign key?

---

# 6 — Create TopicSeeder

Generate:

```bash
php artisan make:seeder TopicSeeder
```

Open:

```text
database/seeders/TopicSeeder.php
```

Import:

```php
use App\Models\Topic;
```

---

# Add Repeatable Topic Seed Data

Use named Topics so the same records can be found again:

```php
public function run(): void
{
    $topics = [
        [
            'name' => 'general',
            'description' => 'General enquiries',
            'available' => true,
        ],
        [
            'name' => 'feedback',
            'description' => 'Feedback and suggestions',
            'available' => true,
        ],
    ];

    foreach ($topics as $topic) {
        Topic::updateOrCreate(
            ['name' => $topic['name']],
            $topic,
        );
    }
}
```

---

# Why updateOrCreate()?

This:

```php
Topic::updateOrCreate(
    ['name' => $topic['name']],
    $topic,
);
```

means:

```text
Find Topic with this name
        ↓
If found → update it
If missing → create it
```

### Result

The seeder can be run repeatedly without creating duplicate named Topics.

---

# Run TopicSeeder

Run:

```bash
php artisan db:seed --class=TopicSeeder
```

Inspect:

```bash
php artisan db:table topics
```

Run it again:

```bash
php artisan db:seed --class=TopicSeeder
```

### Check

The named Topics should still appear only once.

---

# 7 — Create MessageSeeder

Generate:

```bash
php artisan make:seeder MessageSeeder
```

Open:

```text
database/seeders/MessageSeeder.php
```

Import:

```php
use App\Models\Message;
use App\Models\Topic;
```

---

# Retrieve Topics for Message Seeding

Retrieve the Topic objects:

```php
$general = Topic::where('name', 'general')->firstOrFail();

$feedback = Topic::where('name', 'feedback')->firstOrFail();

$oops = Topic::where('name', 'website oops')->firstOrFail();
```

### Explain

Why is this clearer than hard-coding a primary key value?

---

# Seed Messages Through Their Topics

Use the factory with an existing Topic:

```php
Message::factory()
    ->for($general)
    ->create([
        'subject' => 'General enquiry',
    ]);
```

Create another Message for:

```php
$feedback
```

and another for:

```php
$oops
```

Choose sensible subject/message text for each.

---

# Register the Seeders

Open:

```text
database/seeders/DatabaseSeeder.php
```

Call:

```php
$this->call([
    TopicSeeder::class,
    MessageSeeder::class,
]);
```

Run:

```bash
php artisan db:seed
```

Inspect:

```bash
php artisan db:table topics
php artisan db:table messages
```

---

# Verify Related Seed Data

In Tinker:

```php
$general = Topic::where('name', 'general')->firstOrFail();
```

Then:

```php
$general->messages;
```

Inspect a Message:

```php
$message = Message::first();
$message->topic;
```

### Checkpoint

Both relationship directions should work.

---

# Repeatable Development Setup

A full development reset can use:

```bash
php artisan migrate:fresh --seed
```

This:

1. drops the current tables
2. recreates them from migrations
3. runs the seeders

> `migrate:fresh` is destructive. Use it only on a disposable development database.

---

# 8 — Compare Three Retrieval Approaches

You now have enough data to compare:

```text
Raw SQL
   ↓
Query Builder
   ↓
Eloquent
```

All three retrieve data from the same MariaDB tables.

---

# Retrieve Available Topics

In Tinker import:

```php
use Illuminate\Support\Facades\DB;
use App\Models\Topic;
```

### Raw SQL

```php
DB::select(
    'SELECT * FROM topics WHERE available = ?',
    [true],
);
```

---

# Query Builder and Eloquent

### Query Builder

```php
DB::table('topics')
    ->where('available', true)
    ->get();
```

### Eloquent

```php
Topic::where('available', true)->get();
```

### Observe

All three answer the same business question.

---

# Add Sorting

```php
DB::select(
    'SELECT * FROM topics
     WHERE available = ?
     ORDER BY name',
    [true],
);
```

### Query Builder

```php
DB::table('topics')
    ->where('available', true)
    ->orderBy('name')
    ->get();
```

### Eloquent

```php
Topic::where('available', true)
    ->orderBy('name')
    ->get();
```

---

# Compare What Comes Back

Run:

```php
$sql = DB::select('SELECT * FROM topics');
$query = DB::table('topics')->get();
$eloquent = Topic::all();
```

Then inspect:

```php
gettype($sql);
get_class($query);
get_class($eloquent);
```

Which result gives you Topic model behaviours such as:

```php
$eloquent->first()->messages;
```

---

# Retrieve Messages Through the Relationship

Use:

```php
$topic = Topic::where('name', 'general')->firstOrFail();
```

Retrieve:

```php
$topic->messages;
```

Filter through the relationship:

```php
$topic->messages()
    ->whereNull('read_at')
    ->get();
```

A relationship method can also become the starting point for a query.

---

# 9 — Route Model Binding Preview

This is only a preview for Session 8.

Temporarily add to `routes/web.php`:

```php
use App\Models\Topic;
use Illuminate\Support\Facades\Route;

Route::get('/topic-check/{topic}', function (Topic $topic) {
    return $topic;
});
```

Do not build a controller yet.

---

# Test Route Model Binding

Get a real Topic key:

```php
$topic = Topic::first();
$topic->getKey();
```

Use that value in the URL:

```text
/topic-check/<topic-key>
```

Laravel resolves:

```text
route parameter
      ↓
Topic lookup
      ↓
Topic object
```

Remove the temporary route after testing.

---

# Example App Checkpoint

You should now have working:

- `Topic` model
- `Message` model
- `Topic::messages()`
- `Message::topic()`
- `TopicFactory`
- `MessageFactory`
- `TopicSeeder`
- `MessageSeeder`
- SQL retrieval
- Query Builder retrieval
- Eloquent retrieval
- relationship retrieval

This is the complete Session 7 worked example.

---

# Assessment — User and Contact

Now open the **assessment starter application**.

Do not copy Topic/Message fields into Contacts.

Use:

- your approved User–Contact ERD
- your Database Integration Plan
- the existing assessment schema
- the Topic/Message pattern from the worked example

The assessment starter may already contain some equivalent scaffolded code.

---

# Transfer 1 - Inspect Before You Change

Inspect:

```text
app/Models/User.php
app/Models/Contact.php
database/factories
database/seeders
```

Identify:

- what already exists
- what is incomplete
- what matches the worked example pattern
- what must be adapted to the User–Contact design

Do not rewrite completed scaffold code unnecessarily.

---

# Transfer 2 — User–Contact Relationship

Using your ERD, determine:

```text
Which model has many?
Which model belongs to?
Which foreign key supports the relationship?
```

Implement or complete the relationship in both directions.

### Verify in Tinker

Demonstrate:

```text
User → Contacts
Contact → User
```

---

# Transfer 3 — Contact Factory and Seeder

Complete the Contact factory using:

- the actual Contact schema
- valid field lengths and types
- a valid User relationship
- realistic sample data

Then complete useful repeatable Contact seed data.

### Verify

Confirm:

- Contacts exist
- every Contact has a valid User
- repeated development setup works as intended

---

# Transfer 4 — Contact Retrieval

Retrieve Contact data using:

```text
DB::select(...)
DB::table('contacts')...
Contact::query()...
```

Your retrieval should include:

1. all Contacts
2. one useful condition from your integration plan
3. a sensible sort
4. related User data through Eloquent

> Do not build controller methods or Blade views yet.

---

# Final Practical Checkpoint

Before finishing, demonstrate:

### Example App

- Topic/Message models
- working relationship
- factories
- seeders
- SQL, Query Builder and Eloquent retrieval
- related Message retrieval

### Assessment Starter

- User–Contact relationship checked/completed
- Contact factory checked/completed
- Contact seeding checked/completed
- retrieval implemented using the three approaches

---

# Git Evidence

Check your work:

```bash
git status
git diff
```

Stage the files that belong to the work you completed.

Example:

```bash
git add app/Models
git add database/factories
git add database/seeders
git commit -m "Complete Session 7 Eloquent data layer"
```

Use a meaningful commit message that reflects the actual work completed.

---
