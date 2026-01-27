---
created: 2025-07-11T16:38:09 (UTC +08:00)
tags: []
source: https://medium.com/@developerawam/optimize-laravel-queries-with-lazy-eager-loading-and-automatic-relationship-loading-in-laravel-12-8-f556164667f7
author: Developer Awam
---

# Optimize Laravel Queries with Lazy Eager Loading and Automatic Relationship Loading in Laravel 12.8 | by Developer Awam | May, 2025 | Medium

> ## Excerpt
> Have you ever built a Laravel app that feels slow — even though you’re just displaying related data from a few tables? Chances are, you’re running into what’s known as the N+1 problem, and you might…

---
## What is Lazy Eager Loading?

Before jumping into lazy eager loading, let’s quickly review the basics:

**Lazy Loading**: Loads related data _only_ when accessed.

```
<span id="9514" data-selectable-paragraph=""><span>$posts</span> = <span>Post</span>::<span>all</span>(); <br><br><span>foreach</span> (<span>$posts</span> <span>as</span> <span>$post</span>) {     <br>  <span>echo</span> <span>$post</span>-&gt;user-&gt;name; <br>}</span>
```

❗️ This can cause multiple queries — one for each post (a.k.a. the N+1 problem).

**Eager Loading**: Loads related data _along with_ the main query.

```
<span id="943f" data-selectable-paragraph=""><span>$posts</span> = <span>Post</span>::<span>with</span>(<span>'user'</span>)-&gt;<span>get</span>();</span>
```

**Lazy Eager Loading**: Hybrid approach. You load the main data first, then later _on demand_, you load specific relationships in bulk.

## New in Laravel 12.8.0: Automatic Eager Loading

Here’s the exciting part: starting from **Laravel v12.8.0**, there’s now **automatic eager relationship loading**.

In large projects with complex and nested relationships, managing eager loads manually can become a nightmare. This new feature lets Laravel _figure it out for you_.

Instead of doing this:

```
<span id="1cec" data-selectable-paragraph=""><span>$projects</span>-&gt;<span>load</span>([<br>    <span>'client.owner.details'</span>,<br>    <span>'client.customPropertyValues'</span>,<br>    <span>'clientContact.customPropertyValues'</span>,<br>    <span>'status'</span>,<br>    <span>'company.statuses'</span>,<br>    <span>'posts.authors.articles.likes'</span>,<br>    <span>'related.statuses'</span><br>]);</span>
```

You can now simply do this:

```
<span id="f7c2" data-selectable-paragraph=""><span>$projects</span>-&gt;withRelationshipAutoloading();</span>
```

And Laravel will automatically load relationships as they’re accessed:

```
<span id="0b7e" data-selectable-paragraph=""><span>$orders</span> = <span>Order</span>::<span>all</span>()-&gt;<span>withRelationshipAutoloading</span>();<br><br><span>foreach</span> (<span>$orders</span> <span>as</span> <span>$order</span>) {<br>    <span>echo</span> <span>$order</span>-&gt;client-&gt;owner-&gt;company-&gt;name;<br>}</span>
```

Behind the scenes, Laravel performs:

```
<span id="554e" data-selectable-paragraph=""><span>$orders</span>-&gt;<span>loadMissing</span>(<span>'client'</span>);<br><span>$orders</span>-&gt;<span>loadMissing</span>(<span>'client.owner'</span>);<br><span>$orders</span>-&gt;<span>loadMissing</span>(<span>'client.owner.company'</span>);</span>
```

You can even enable it globally across all models like this:

```
<span id="0dcd" data-selectable-paragraph="">Model::automaticallyEagerLoadRelationships();</span>
```

This feature can significantly simplify code in large apps with deeply nested relationships.
