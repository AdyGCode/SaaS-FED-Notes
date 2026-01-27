---
created: 2025-07-11T16:33:55 (UTC +08:00)
tags: []
source: https://medium.com/@aiman.asfia/understanding-self-relationships-in-laravel-models-fd40d1bbf647
author: Asfia Aiman
---

# Understanding Self-Relationships in Laravel Models | by Asfia Aiman | Medium

> ## Excerpt
> When developing applications, we often encounter scenarios where one model needs to relate to another model of the same type. In Laravel, this is known as a self-referential relationship or…

---
![](Understanding%20Self-Relationships%20in%20Laravel%20Models%20%20by%20Asfia%20Aiman%20%20Medium/1xKoKnRoLA9SJJKOANAsyJg.png)

[

![Asfia Aiman](Understanding%20Self-Relationships%20in%20Laravel%20Models%20%20by%20Asfia%20Aiman%20%20Medium/1Jla_tppBFHMlZd26hlsswA.jpeg)



](https://medium.com/@aiman.asfia?source=post_page---byline--fd40d1bbf647---------------------------------------)

When developing applications, we often encounter scenarios where one model needs to relate to another model of the same type. In Laravel, this is known as a **self-referential relationship** or **self-relationship**. But why do we need such relationships? In this post, we’ll explore the concept, real-world applications, and how to implement self-relationships in Laravel with practical code examples.

## What Is a Self-Relationship?

A self-relationship occurs when an object can be associated with another object of the same kind. For instance, consider an organization where employees report to managers who are also employees. This creates a need to connect employees to other employees within the same model.

## Real-World Example: Employees and Managers

Imagine a scenario where:

-   An **employee** has a **manager**.
-   That manager is also an employee.

This necessitates creating a relationship between instances of the same model.

## Why Do We Need Self-Relationships?

Self-relationships are useful for various scenarios, including:

-   **Employee Hierarchy**: Employees report to managers who are also employees.
-   **Categories and Subcategories**: Categories can contain subcategories (e.g., “Programming” might have “Web Development” and “Data Science”).
-   **Social Networks**: Users can be friends with other users.

## Implementing Self-Relationships in Laravel

Let’s dive into how to implement a self-relationship using a common example: managing employees and their managers.

## Step 1: Create the `Employee` Model and Migration

Start by creating the `Employee` model and its corresponding migration:

```
<span id="7c62" data-selectable-paragraph="">php artisan make:model Employee -m</span>
```

## Step 2: Define the Migration

Next, open the migration file (found in the `database/migrations` directory) and define the table structure. We’ll include a column for `manager_id` to reference the manager (who is also an employee):

```
<span id="6f9c" data-selectable-paragraph=""><span>Schema</span>::<span>create</span>(<span>'employees'</span>, function (Blueprint <span>$table</span>) {<br>    <span>$table</span>-&gt;<span>id</span>(); <br>    <span>$table</span>-&gt;<span>string</span>(<span>'name'</span>); <br>    <span>$table</span>-&gt;<span>foreignId</span>(<span>'manager_id'</span>)-&gt;<span>nullable</span>()-&gt;<span>constrained</span>(<span>'employees'</span>); <br>    <span>$table</span>-&gt;<span>timestamps</span>();<br>});</span>
```

-   The `manager_id` field acts as a foreign key that points to the `id` of the same `employees` table.

Run the migration to create the table:

```
<span id="b2fb" data-selectable-paragraph="">php artisan migrate</span>
```

## Step 3: Define the Self-Relationship in the `Employee` Model

Now, let’s define the relationships within the `Employee` model:

```
<span id="bfd8" data-selectable-paragraph=""><span><span>class</span> <span>Employee</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>protected</span> <span>$fillable</span> = [<span>'name'</span>, <span>'manager_id'</span>];<br><br>    <br>    <span>public</span> <span><span>function</span> <span>manager</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>belongsTo</span>(<span>Employee</span>::<span>class</span>, <span>'manager_id'</span>);<br>    }<br><br>    <br>    <span>public</span> <span><span>function</span> <span>subordinates</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>hasMany</span>(<span>Employee</span>::<span>class</span>, <span>'manager_id'</span>);<br>    }<br>}</span>
```

Here, we’ve set up two relationships:

-   `manager()`: This method defines that an employee **belongs to** a manager.
-   `subordinates()`: This method defines that an employee **can have many** subordinates.

## Practical Usage

Now, let’s see how we can use these relationships in practice.

## Adding Employees

Let’s create three employees: Alice (the CEO), Bob (a manager), and Charlie (an employee reporting to Bob).

```
<span id="988a" data-selectable-paragraph=""><br><span>$alice</span> = <span>Employee</span>::<span>create</span>([<span>'name'</span> =&gt; <span>'Alice'</span>]);<br><br><br><span>$bob</span> = <span>Employee</span>::<span>create</span>([<span>'name'</span> =&gt; <span>'Bob'</span>, <span>'manager_id'</span> =&gt; <span>$alice</span>-&gt;id]);<br><br><br><span>$charlie</span> = <span>Employee</span>::<span>create</span>([<span>'name'</span> =&gt; <span>'Charlie'</span>, <span>'manager_id'</span> =&gt; <span>$bob</span>-&gt;id]);</span>
```

## Querying Relationships

1.  **Get Bob’s Manager**:

```
<span id="207e" data-selectable-paragraph=""><span>$bob</span> = Employee::<span>where</span>(<span>'name'</span>, <span>'Bob'</span>)-&gt;first();<br><span>echo</span> <span>$bob</span>-&gt;manager-&gt;name; // Outputs <span>"Alice"</span></span>
```

**2\. Get Alice’s Subordinates**:

```
<span id="e968" data-selectable-paragraph=""><span>$alice</span> = <span>Employee</span>::<span>where</span>(<span>'name'</span>, <span>'Alice'</span>)-&gt;<span>first</span>();<br><span>foreach</span> (<span>$alice</span>-&gt;subordinates <span>as</span> <span>$subordinate</span>) {<br>    <span>echo</span> <span>$subordinate</span>-&gt;name; <br>}</span>
```

**3\. Get Bob’s Subordinates**:

```
<span id="b232" data-selectable-paragraph=""><span>$bob</span> = <span>Employee</span>::<span>where</span>(<span>'name'</span>, <span>'Bob'</span>)-&gt;<span>first</span>();<br><span>foreach</span> (<span>$bob</span>-&gt;subordinates <span>as</span> <span>$subordinate</span>) {<br>    <span>echo</span> <span>$subordinate</span>-&gt;name; <br>}</span>
```

## Other Practical Use Cases for Self-Relationships

## Categories and Subcategories

You can also create a self-referencing `Category` model, allowing each category to have subcategories:

```
<span id="f579" data-selectable-paragraph=""><span>class</span> <span>Category</span> <span>extends</span> <span>Model</span><br>{<br>    <span>public</span> function parentCategory()<br>    {<br>        <span>return</span> $<span>this</span>-&gt;belongsTo(Category::<span>class</span>, <span>'parent_id'</span>);<br>    }<br><br>    <span>public</span> function subCategories()<br>    {<br>        <span>return</span> $<span>this</span>-&gt;hasMany(Category::<span>class</span>, <span>'parent_id'</span>);<br>    }<br>}</span>
```

This structure allows for nesting categories, such as:

-   **Electronics**
-   Laptops
-   Smartphones

## Social Networks: Friends

In a social networking app, users might have friends who are also users. You can model this relationship as follows:

```
<span id="f844" data-selectable-paragraph=""><span><span>class</span> <span>User</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>friends</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>belongsToMany</span>(<span>User</span>::<span>class</span>, <span>'user_friend'</span>, <span>'user_id'</span>, <span>'friend_id'</span>);<br>    }<br>}</span>
```

This allows each user to maintain a list of friends.

## Conclusion

Self-referential relationships in Laravel offer a powerful way to manage data that relates to itself. Whether you're modeling employee hierarchies, category structures, or social networks, these relationships help maintain organized data and allow for easy querying.

By understanding and implementing self-relationships, you can enhance the flexibility and scalability of your Laravel applications. If you're building an organizational chart, a nested category system, or a social networking platform, self-relationships can significantly simplify your data management.

Happy coding!
