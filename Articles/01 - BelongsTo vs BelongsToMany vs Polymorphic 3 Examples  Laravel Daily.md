---
created: 2025-07-11T16:31:08 (UTC +08:00)
tags: []
source: https://laraveldaily.com/lesson/structuring-databases-laravel/belongsto-vs-belongstomany-vs-polymorphic
author: 
---

# 01 - BelongsTo vs BelongsToMany vs Polymorphic: 3 Examples | Laravel Daily

> ## Excerpt
> To understand how to structure the DB in Laravel or in whatever language, one of the most important concepts is relationships and understanding the differences between them. How do you choose whether it should be a belongsTo, belongsToMany, or polymorphic?

---
To understand how to structure the DB in Laravel or in whatever language, one of the most important concepts is relationships and understanding the differences between them. How do you choose whether it should be a belongsTo, belongsToMany, or polymorphic?

In this lesson, I will show three examples of all those relationships within the same project. The project is a typical blog or a portal of articles, and we will add additional tables to the articles with relationships. We will see which relationship is suitable for which situation.

___

## Example 1: Photos

### Scenario 1. BelongsTo Relationship

The first situation is about photos. The most typical scenario is that each article has many photos. In this case, we have a `hasMany` and a `belongsTo` relationship.

First, the articles are a simple table of title and text.

**database/migrations/xxx\_create\_articles\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>articles</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>title</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>body</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

We have a foreign ID for the `articles` table in the migration for the `photos` table.

**database/migrations/xxx\_create\_photos\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>photos</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>filename</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>constrained</span><span>(); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

Then, in the Model, every photo belongs to some article.

**app/Models/Photo.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsTo</span><span>;</span></p><p><span>class</span><span> </span><span>Photo</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>filename</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>article_id</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>article</span><span>()</span><span>:</span><span> </span><span>BelongsTo</span><span> </span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsTo</span><span>(</span><span>Article</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

And every article has many photos.

**app/Models/Article.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>HasMany</span><span>;</span></p><p><span>class</span><span> </span><span>Article</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>title</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>body</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>photos</span><span>()</span><span>:</span><span> </span><span>HasMany</span><span> </span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>hasMany</span><span>(</span><span>Photo</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

This is the most simple and the most typical example.

![](01%20-%20BelongsTo%20vs%20BelongsToMany%20vs%20Polymorphic%203%20Examples%20%20Laravel%20Daily/photos-belongs-to-articles-relationship.png)

___

### Scenario 2. BelongsToMany Relationship

What if you want each photo to be used in **multiple** articles? For example, some photos are suitable for many different articles. Then you need a `belongsToMany` relationship. A photo may belong to many articles, but each article still has many photos. Then, it's a two-way relationship.

You create a pivot table `article_photo` with foreign key columns for both tables.

> Laravel has a naming convention for creating a pivot table. It should be singular from both tables and in alphabetical order. So, not `photo_article` and not `article_photos`.

**database/migrations/xxx\_create\_article\_photo\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>article_photo</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>photo_id</span><span>'</span><span>)</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>});</span></p>
```

Then, in the `Photo` Model, instead of the `belongsTo(Article)` relationship, we have `belongsToMany(Article)`.

**app/Models/Photo.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsToMany</span><span>;</span></p><p><span>class</span><span> </span><span>Photo</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>filename</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>article_id</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>articles</span><span>()</span><span>:</span><span> </span><span>BelongsToMany</span><span> </span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsToMany</span><span>(</span><span>Article</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

In the `Article` Model, it's also a `belongsToMany` relationship instead of `hasMany`.

**app/Models/Article.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsToMany</span><span>;</span></p><p><span>class</span><span> </span><span>Article</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>title</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>body</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>photos</span><span>()</span><span>:</span><span> </span><span>BelongsToMany</span><span> </span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsToMany</span><span>(</span><span>Photo</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

That's the second scenario. Do you feel the difference? Now, let's add a third scenario.

![](01%20-%20BelongsTo%20vs%20BelongsToMany%20vs%20Polymorphic%203%20Examples%20%20Laravel%20Daily/article-photo-belongs-to-many.png)

___

### Scenario 3. Polymorphic Relationship

What if there's a separate table called `videos` in addition to articles? The blog project has two types of entities: articles and videos. The photo and thumbnail may belong to either an article or a video.

One way of doing that in the `photos` table is to add another foreign ID to `video_id`. Both should be `nullable` because only one will be present each time.

**database/migrations/xxx\_create\_photos\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>photos</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>filename</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>(); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>video_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

Then, you should add a second `belongsTo` relationship in the `Photo` Model for the video.

**app/Models/Photo.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsTo</span><span>;</span></p><p><span>class</span><span> </span><span>Photo</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>filename</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>article_id</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>articles</span><span>()</span><span>:</span><span> </span><span>BelongsTo</span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsTo</span><span>(</span><span>Article</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>video</span><span>()</span><span>:</span><span> </span><span>BelongsTo</span><span> </span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsTo</span><span>(</span><span>Video</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

However, a polymorphic relationship should be considered for this type of scenario. Polymorphic relationships are used when an entity can belong to anything.

In the migration, you can use a `morphs()` method, which will create two columns:

-   `{column}_id` (the ID of the record)
-   `{column}_type` (the model like `App\Models\Article` or `App\Models\Video`).

The name for the morph columns is the table name with an `able` suffix, like `photoable_id` and `photoable_type`.

**database/migrations/xxx\_create\_photos\_tables.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>photos</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>filename</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>(); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>video_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>morphs</span><span>(</span><span>'</span><span>photoable</span><span>'</span><span>); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

In the `Photo` Model, you only need to define the `morphTo` relation instead of a relationship for every Model.

**app/Models/Photo.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>MorphTo</span><span>;</span></p><p><span>class</span><span> </span><span>Photo</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>filename</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>article_id</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>photoable</span><span>()</span><span>:</span><span> </span><span>MorphTo</span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>morphTo</span><span>();</span></p><p><span>    }</span></p><p><span>}</span></p>
```

On the other side, in each parent model, you call `morphMany` with the name of a relationship. In this case, it's `photoable`.

**app/Models/Article.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>MorphMany</span><span>;</span></p><p><span>class</span><span> </span><span>Article</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>title</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>body</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>photos</span><span>()</span><span>:</span><span> </span><span>MorphMany</span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>morphMany</span><span>(</span><span>Photo</span><span>::</span><span>class</span><span>, </span><span>'</span><span>photoable</span><span>'</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

**app/Models/Video.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>MorphMany</span><span>;</span></p><p><span>class</span><span> </span><span>Video</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>title</span><span>'</span><span>,</span></p><p><span>        </span><span>'</span><span>video_url</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>photos</span><span>()</span><span>:</span><span> </span><span>MorphMany</span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>morphMany</span><span>(</span><span>Photo</span><span>::</span><span>class</span><span>, </span><span>'</span><span>photoable</span><span>'</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

![](01%20-%20BelongsTo%20vs%20BelongsToMany%20vs%20Polymorphic%203%20Examples%20%20Laravel%20Daily/photoable-polymorphic.png)

When you want to get those child records by article, for example, in the ArticleController, you treat them like they would be a `hasMany` relationship.

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> App\Models\</span><span>Article</span><span>;</span></p><p><span>class</span><span> </span><span>ArticleController</span><span> </span><span>extends</span><span> </span><span>Controller</span></p><p><span>{</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>index</span><span>(</span><span>Article</span><span> </span><span>$article</span><span>)</span></p><p><span>    {</span></p><p><span>        </span><span>foreach</span><span> (</span><span>$article</span><span>-&gt;photos</span><span> </span><span>as</span><span> </span><span>$photo</span><span>) { </span></p><p><span>            </span><span>echo</span><span> </span><span>$photo</span><span>-&gt;filename</span><span>;</span></p><p><span>        }</span></p><p><span>    }</span></p><p><span>}</span></p>
```

So that's the first example of `belongsTo`, `belongsToMany`, and Polymorphic relationships with photos.

___

## Example 2: Comments

Let's say we have a `comments` table in the same blog project, and comments belong to an article. However, in the future, comments may also belong to a video.

Again, for the comments table, there could be two foreign nullable columns for each model to which a comment belongs.

**database/migrations/xxx\_create\_comments\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>comments</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>(); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>video_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>body</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

Or you may choose a polymorphic relationship.

**database/migrations/xxx\_create\_comments\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>comments</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>(); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>video_id</span><span>'</span><span>)</span><span>-&gt;</span><span>nullable</span><span>()</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>morphs</span><span>(</span><span>'</span><span>commentable</span><span>'</span><span>); </span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>body</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

From the practical point of view, I want you to understand the difference between a regular `belongsTo` and a polymorphic `belongsTo`.

___

## Example 3: Tags

Finally, let's look at the `belongsToMany` example with **tags**. Let's add tags to all those articles, videos, and photos in the same project. What would be their relationship to articles? It's probably `belongsToMany`.

When deciding whether a relationship belongs to one article or many, my tip is to try to pronounce what makes more sense in your head. Does the tag belong to one article, or does it belong to many articles? If every tag belongs to only one article, then what's the point of the tags? The tagging system should have many tags for many articles.

**database/migrations/xxx\_create\_tags\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>tags</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>id</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>string</span><span>(</span><span>'</span><span>name</span><span>'</span><span>);</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>timestamps</span><span>();</span></p><p><span>});</span></p>
```

In the `Tag` Model, we have a `belongsToMany` relationship to articles.

**app/Models/Tag.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsToMany</span><span>;</span></p><p><span>class</span><span> </span><span>Tag</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span>{</span></p><p><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span>        </span><span>'</span><span>name</span><span>'</span><span>,</span></p><p><span>    ];</span></p><p><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>articles</span><span>()</span><span>:</span><span> </span><span>BelongsToMany</span></p><p><span>    {</span></p><p><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsToMany</span><span>(</span><span>Article</span><span>::</span><span>class</span><span>);</span></p><p><span>    }</span></p><p><span>}</span></p>
```

We also have a separate pivot table for the `article_tag`.

**database/migrations/xxx\_create\_article\_tag\_table.php**:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>Schema</span><span>::</span><span>create</span><span>(</span><span>'</span><span>article_tag</span><span>'</span><span>, </span><span>function</span><span> </span><span>(</span><span>Blueprint</span><span> </span><span>$table</span><span>)</span><span> {</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>article_id</span><span>'</span><span>)</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>    </span><span>$table</span><span>-&gt;</span><span>foreignId</span><span>(</span><span>'</span><span>tag_id</span><span>'</span><span>)</span><span>-&gt;</span><span>constrained</span><span>();</span></p><p><span>});</span></p>
```

What about the video situation? A tag may belong to many articles or many videos. Should it be a polymorphic relationship? In my opinion, it shouldn't. There is a way to have polymorphic relationships with many to many, but then it gets very complex.

Personally, I would add another `belongsToMany` relationship for the videos and another `tag_video` pivot table in the 'Tag' model.

___

I hope this short introduction to relationships makes it a bit clearer to you when to choose which. This is one of the typical tasks or jobs when trying to come up with a database structure: how to structure the relationships.

This is an introduction to most typical scenarios. Let's dive deeper with more examples in the following lessons.
