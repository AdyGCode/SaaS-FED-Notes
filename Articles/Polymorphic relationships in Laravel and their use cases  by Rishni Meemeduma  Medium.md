---
created: 2025-07-11T16:32:24 (UTC +08:00)
tags: []
source: https://medium.com/@ashameemeduma/polymorphic-relationships-in-laravel-and-their-use-cases-04396a64a608
author: Rishni Meemeduma
---

# Polymorphic relationships in Laravel and their use cases | by Rishni Meemeduma | Medium

> ## Excerpt
> In software development, it’s common to encounter models that belong to multiple entities. A great example is comments. Take an application like Facebook, for instance: comments can be associated…

---
[

![Rishni Meemeduma](Polymorphic%20relationships%20in%20Laravel%20and%20their%20use%20cases%20%20by%20Rishni%20Meemeduma%20%20Medium/16UyU5qP9mci6wvqXHWL77Q.jpeg)



](https://medium.com/@ashameemeduma?source=post_page---byline--04396a64a608---------------------------------------)

![](Polymorphic%20relationships%20in%20Laravel%20and%20their%20use%20cases%20%20by%20Rishni%20Meemeduma%20%20Medium/1FMLkqnasYKPHjC9k4RQZXg.jpeg)

In software development, it’s common to encounter models that belong to multiple entities. A great example is _comments_. Take an application like Facebook, for instance: comments can be associated with posts, stories, or videos while maintaining the same structure. This behavior is an excellent illustration of **polymorphism** in action.

In this article, we will explore polymorphic relationships in Laravel, delve into how they work, and discuss the various use cases where they shine the most.

## [Polymorphic Relationships](https://laravel.com/docs/11.x/eloquent-relationships#polymorphic-relationships)

A polymorphic relationship lets one model be connected to multiple other models using a single setup. For example, if you’re building an app where users can share blog posts and videos, a **Comment** model can be linked to both **Post** and **Video** models. This means users can comment on either posts or videos without needing separate comment systems.

**_One to One (Polymorphic)_**

A one-to-one polymorphic relationship is like a regular one-to-one relationship, but with a twist: the child model can be linked to more than one type of parent model using just one connection. For example, a **Profile** could belong to either a **User** or an **Admin**, all through the same relationship setup.

let’s examine the table structure:

```
<span id="fa26" data-selectable-paragraph="">admin<br>    id - <span>integer</span><br>    name - <span>string</span><br> <br>users<br>    id - <span>integer</span><br>    name - <span>string</span><br> <br>profile<br>    id - <span>integer</span><br>    avatar- <span>string</span><br>    profileable_id - <span>integer</span><br>    profileable_type - <span>string</span></span>
```

The profileable\_id column will contain the id values of admin or users. While the profileable\_type column will contain the class name of the parent users , admin models. it’s either _App\\Models\\Users_ or _App\\Models\\Admin_

Now, let check the models

```
<span id="cec4" data-selectable-paragraph=""><span>&lt;?php</span><br> <br><span>namespace</span> <span>App</span>\<span>Models</span>;<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphTo</span>;<br> <br><span><span>class</span> <span>Profile</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>profileable</span>(): <span>MorphTo</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphTo</span>();<br>    }<br>}<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphOne</span>;<br> <br><span><span>class</span> <span>Users</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>profile</span>(): <span>MorphOne</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphOne</span>(<span>Profile</span>::<span>class</span>, <span>'profileable'</span>);<br>    }<br>}<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphOne</span>;<br> <br><span><span>class</span> <span>Admin</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>profile</span>(): <span>MorphOne</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphOne</span>(<span>Profile</span>::<span>class</span>, <span>'profileable'</span>);<br>    }<br>}</span>
```

**_One to Many (Polymorphic)_**

A one-to-many polymorphic relationship is like a regular one-to-many relationship, but with a difference: the child model can be linked to multiple types of parent models using one setup. For example, a **Comment** model can belong to either a **Post** or a **Video**, allowing users to leave comments on both without needing separate comment systems

let’s examine the table structure required to build this relationship:

```
<span id="3e67" data-selectable-paragraph="">posts<br>    id - <span>integer</span><br>    title - <span>string</span><br>    body - text<br> <br>videos<br>    id - <span>integer</span><br>    title - <span>string</span><br>    url - <span>string</span><br> <br>comments<br>    id - <span>integer</span><br>    body - text<br>    commentable_id - <span>integer</span><br>    commentable_type - <span>string</span></span>
```

Next, Model structure

```
<span id="afdc" data-selectable-paragraph=""><span>&lt;?php</span><br> <br><span>namespace</span> <span>App</span>\<span>Models</span>;<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphTo</span>;<br> <br><span><span>class</span> <span>Comments</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>commentable</span>(): <span>MorphTo</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphTo</span>();<br>    }<br>}<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphOne</span>;<br> <br><span><span>class</span> <span>Videos</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>comments</span>(): <span>MorphMany</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphMany</span>(<span>Comments</span>::<span>class</span>, <span>'commentable'</span>);<br>    }<br>}<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphOne</span>;<br> <br><span><span>class</span> <span>Posts</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>comments</span>(): <span>MorphMany</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphMany</span>(<span>Comments</span>::<span>class</span>, <span>'commentable'</span>);<br>    }<br>}</span>
```

**_Many to Many (Polymorphic)_**

Many-to-many polymorphic relationships let multiple models share a common relationship with another model. For example, both a **Post** and a **Video** can have tags, and those tags are stored in a single table. This setup allows you to manage unique tags that can be linked to either posts or videos, keeping things organized and flexible.

let’s examine the table structure required to build this relationship:

```
<span id="a9f9" data-selectable-paragraph=""><br>posts<br>    id - <span>integer</span><br>    name - <span>string</span><br> <br>videos<br>    id - <span>integer</span><br>    name - <span>string</span><br> <br>tags<br>    id - <span>integer</span><br>    name - <span>string</span><br> <br>taggables<br>    tag_id - <span>integer</span><br>    taggable_id - <span>integer</span><br>    taggable_type - <span>string</span></span>
```

Now, let check models

```
<span id="3a1e" data-selectable-paragraph=""><span>&lt;?php</span><br> <br><span>namespace</span> <span>App</span>\<span>Models</span>;<br> <br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>MorphToMany</span>;<br> <br><span><span>class</span> <span>Post</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>     <span>public</span> <span><span>function</span> <span>tags</span>(): <span>MorphToMany</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphToMany</span>(<span>Tag</span>::<span>class</span>, <span>'taggable'</span>);<br>    }<br>}<br><br><span><span>class</span> <span>Tag</span> <span>extends</span> <span>Model</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>posts</span>(): <span>MorphToMany</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphedByMany</span>(<span>Post</span>::<span>class</span>, <span>'taggable'</span>);<br>    }<br> <br>    <br>    <span>public</span> <span><span>function</span> <span>videos</span>(): <span>MorphToMany</span><br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>morphedByMany</span>(<span>Video</span>::<span>class</span>, <span>'taggable'</span>);<br>    }<br>}</span>
```

**_Custom Polymorphic Types_**

By default, Laravel saves the full class name of the related model (like `App\Models\Post` or `App\Models\Video`) in the `commentable_type` column to identify the type of model a comment belongs to.

However, if you want to simplify this and avoid saving full class names in the database — for example, just save `post` or `video` instead—you can customize this behavior. This makes the database cleaner and less tied to the internal structure of your application.

You can do this by defining a **morph map**, which tells Laravel to use shorter, custom names instead of full class names.

```
<span id="65b1" data-selectable-paragraph=""><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Relations</span>\<span>Relation</span>;<br><br><span><span>class</span> <span>AppServiceProvider</span> <span>extends</span> <span>ServiceProvider</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>boot</span>()<br>    </span>{<br>        <span>Relation</span>::<span>enforceMorphMap</span>([<br>            <span>'post'</span> =&gt; <span>App\Models\Post</span>::<span>class</span>,<br>            <span>'video'</span> =&gt; <span>App\Models\Video</span>::<span>class</span>,<br>        ]);<br>    }<br>}</span>
```

In this example:

-   The `post` key maps to the `App\Models\Post` class.
-   The `video` key maps to the `App\Models\Video` class.

This will ensure that the `commentable_type` column in your database stores `post` or `video` instead of the fully qualified class names.

common usage,

```
<span id="c1e6" data-selectable-paragraph=""><span>use</span> <span>App</span>\<span>Models</span>\<span>Post</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\<span>Video</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\<span>Comment</span>;<br><br><br><span>$post</span> = <span>Post</span>::<span>find</span>(<span>1</span>);<br><span>$post</span>-&gt;<span>comments</span>()-&gt;<span>create</span>([<br>    <span>'body'</span> =&gt; <span>'This is a comment on a post'</span>,<br>]);<br><br><br><span>$video</span> = <span>Video</span>::<span>find</span>(<span>1</span>);<br><span>$video</span>-&gt;<span>comments</span>()-&gt;<span>create</span>([<br>    <span>'body'</span> =&gt; <span>'This is a comment on a video'</span>,<br>]);<br><br><br><br><span>$postComments</span> = <span>Post</span>::<span>find</span>(<span>1</span>)-&gt;comments;<br><br><br><span>$videoComments</span> = <span>Video</span>::<span>find</span>(<span>1</span>)-&gt;comments;<br><br><br><span>$comment</span> = <span>Comment</span>::<span>find</span>(<span>1</span>);<br><span>$parent</span> = <span>$comment</span>-&gt;commentable; </span>
```

Thank you !
