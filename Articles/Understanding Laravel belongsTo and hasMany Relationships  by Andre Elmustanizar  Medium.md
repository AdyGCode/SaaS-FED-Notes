---
created: 2025-07-11T15:48:46 (UTC +08:00)
tags: []
source: https://medium.com/@andreelm/understanding-laravel-belongsto-and-hasmany-relationships-b6355d2a7742
author: Andre Elmustanizar
---

# Understanding Laravel belongsTo and hasMany Relationships | by Andre Elmustanizar | Medium

> ## Excerpt
> In developing applications involving databases with more than one table, we often encounter table relationships. For example, there are two tables, namely the 'categories' table and the…

---
[

![Andre Elmustanizar](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/14UX3Wx4oWhzW6xfzp56UZw.jpeg)



](https://medium.com/@andreelm?source=post_page---byline--b6355d2a7742---------------------------------------)

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1Ic5C3qwy2dmbjaHKtB6V-w.png)

Understanding Laravel belongsTo and hasMany Relationships

In developing applications involving databases with more than one table, we often encounter table relationships. For example, there are two tables, namely the 'categories' table and the 'sub\_categories' table. In this case, the 'categories' table acts as the master table, and the 'sub\_categories' table is the dependent table that requires a relationship with the 'categories' table.

For example, the ‘sub\_categories’ table requires values in the ‘name’ field from the ‘categories’ table, and conversely, there are cases where data from ‘sub\_categories’ is needed based on the selected ‘categories’.

In the Laravel framework, all of these can be easily accomplished using the `belongsTo` and `hasMany` relationships. Here is an example scenario that I have chosen to demonstrate the usage of `belongsTo` and `hasMany` relationships.

> _Before Start Coding Link to the GitHub for this project at the end of the Article._

**Let’s start!**

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1mpuNzseL1Aj8CWj-omlZnw.png)

RELATIONSHIP

I have 4 tables:  
1\. categories  
2\. subcategories  
3\. products  
4\. galleries  
From these 4 tables, I will establish their respective relationships using `belongsTo` and `hasMany`.

1.  **Create Laravel Project**

```
<span id="bb5f" data-selectable-paragraph="">composer create-project laravel/laravel laravel-relations</span>
```

**2\. Create migration, model, and controller Category**

```
<span id="409f" data-selectable-paragraph="">php artisan <span>make</span>:model -mrc Category</span>
```

-   **Migration table categories**

```
<span id="888b" data-selectable-paragraph=""><span>Schema</span>::<span>create</span>(<span>'categories'</span>, function (Blueprint <span>$table</span>) {<br>    <span>$table</span>-&gt;<span>id</span>();<br>    <span>$table</span>-&gt;<span>string</span>(<span>'name'</span>);<br>    <span>$table</span>-&gt;<span>boolean</span>(<span>'status'</span>)-&gt;<span>default</span>(<span>true</span>);<br>    <span>$table</span>-&gt;<span>timestamps</span>();<br>});</span>
```

-   **Model Category**

```
<span id="bed5" data-selectable-paragraph=""><span><span>class</span> <span>Category</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>use</span> <span>HasFactory</span>;<br><br>    <span>protected</span> <span>$fillable</span> = [<span>'name'</span>, <span>'status'</span>];<br><br>    <span>public</span> <span><span>function</span> <span>subCategories</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>hasMany</span>(<span>SubCategory</span>::<span>class</span>);<br>    }<br>}</span>
```

-   **Controller Category**

```
<span id="30c3" data-selectable-paragraph=""><span>&lt;?php</span><br><span>namespace</span> <span>App</span>\<span>Http</span>\<span>Controllers</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\<span>Category</span>;<br><span>use</span> <span>Illuminate</span>\<span>Http</span>\<span>Request</span>;<br><br><span><span>class</span> <span>CategoryController</span> <span>extends</span> <span>Controller</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>index</span>()<br>    </span>{<br>        <span>$categories</span> = <span>Category</span>::<span>all</span>();<br>        <span>$i</span> = <span>1</span>;<br>        <span>return</span> <span>view</span>(<span>'pages.categories.index'</span>, <span>compact</span>(<span>'categories'</span>, <span>'i'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>create</span>()<br>    </span>{<br>        <span>return</span> <span>view</span>(<span>'pages.categories.create'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>store</span>(<span>Request <span>$request</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>Category</span>::<span>create</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Category created successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>show</span>(<span>Category <span>$category</span></span>)<br>    </span>{<br>        <span>return</span> <span>view</span>(<span>'categories.edit'</span>, <span>compact</span>(<span>'category'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>edit</span>(<span>Category <span>$category</span></span>)<br>    </span>{<br>        <span>return</span> <span>view</span>(<span>'pages.categories.edit'</span>, <span>compact</span>(<span>'category'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>update</span>(<span>Request <span>$request</span>, Category <span>$category</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>$category</span>-&gt;<span>update</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Category updated successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>destroy</span>(<span>Category <span>$category</span></span>)<br>    </span>{<br>        <span>$category</span>-&gt;<span>delete</span>();<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Category deleted successfully.'</span>);<br>    }<br>}</span>
```

**3\. Create migration, model, and controller SubCategory**

```
<span id="939c" data-selectable-paragraph="">php artisan <span>make</span>:model -mrc SubCategories</span>
```

-   **Migration table sub\_categories**

```
<span id="806f" data-selectable-paragraph=""><span>Schema</span>::<span>create</span>(<span>'sub_categories'</span>, function (Blueprint <span>$table</span>) {<br>    <span>$table</span>-&gt;<span>id</span>();<br>    <span>$table</span>-&gt;<span>foreignId</span>(<span>'category_id'</span>)-&gt;<span>constrained</span>(<span>'categories'</span>);<br>    <span>$table</span>-&gt;<span>string</span>(<span>'name'</span>);<br>    <span>$table</span>-&gt;<span>boolean</span>(<span>'status'</span>)-&gt;<span>default</span>(<span>true</span>);<br>    <span>$table</span>-&gt;<span>timestamps</span>();<br>});</span>
```

-   **Model SubCategory**

```
<span id="238a" data-selectable-paragraph=""><span><span>class</span> <span>SubCategory</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>use</span> <span>HasFactory</span>;<br><br>    <span>protected</span> <span>$fillable</span> = [<span>'category_id'</span>, <span>'name'</span>, <span>'status'</span>];<br><br>    <span>public</span> <span><span>function</span> <span>category</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>belongsTo</span>(<span>Category</span>::<span>class</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>products</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>hasMany</span>(<span>Product</span>::<span>class</span>);<br>    }<br>}</span>
```

-   **Controller SubCategory**

```
<span id="9d4a" data-selectable-paragraph=""><span>&lt;?php</span><br><span>namespace</span> <span>App</span>\<span>Http</span>\<span>Controllers</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\{<span>Category</span>, <span>SubCategory</span>};<br><span>use</span> <span>Illuminate</span>\<span>Http</span>\<span>Request</span>;<br><br><span><span>class</span> <span>SubCategoryController</span> <span>extends</span> <span>Controller</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>index</span>()<br>    </span>{<br>        <span>$subCategories</span> = <span>SubCategory</span>::<span>all</span>();<br>        <span>$i</span> = <span>1</span>;<br>        <span>return</span> <span>view</span>(<span>'pages.sub_categories.index'</span>, <span>compact</span>(<span>'subCategories'</span>, <span>'i'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>create</span>()<br>    </span>{<br>        <span>$categories</span> = <span>Category</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.sub_categories.create'</span>, <span>compact</span>(<span>'categories'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>store</span>(<span>Request <span>$request</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'category_id'</span> =&gt; <span>'required|exists:categories,id'</span>,<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>SubCategory</span>::<span>create</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'sub-categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'SubCategory created successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>edit</span>(<span>SubCategory <span>$subCategory</span></span>)<br>    </span>{<br>        <span>$categories</span> = <span>Category</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.sub_categories.edit'</span>, <span>compact</span>(<span>'subCategory'</span>, <span>'categories'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>update</span>(<span>Request <span>$request</span>, SubCategory <span>$subCategory</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'category_id'</span> =&gt; <span>'required|exists:categories,id'</span>,<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>$subCategory</span>-&gt;<span>update</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'sub-categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'SubCategory updated successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>destroy</span>(<span>SubCategory <span>$subCategory</span></span>)<br>    </span>{<br>        <span>$subCategory</span>-&gt;<span>delete</span>();<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'sub-categories.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'SubCategory deleted successfully.'</span>);<br>    }<br>}</span>
```

**4\. Create migration, model, and controller Product**

```
<span id="baec" data-selectable-paragraph="">php artisan <span>make</span>:model -mrc Product</span>
```

-   **Migration table products**

```
<span id="ed9b" data-selectable-paragraph=""><span>Schema</span>::<span>create</span>(<span>'products'</span>, function (Blueprint <span>$table</span>) {<br>    <span>$table</span>-&gt;<span>id</span>();<br>    <span>$table</span>-&gt;<span>foreignId</span>(<span>'sub_category_id'</span>)-&gt;<span>constrained</span>(<span>'sub_categories'</span>);<br>    <span>$table</span>-&gt;<span>string</span>(<span>'name'</span>);<br>    <span>$table</span>-&gt;<span>text</span>(<span>'description'</span>);<br>    <span>$table</span>-&gt;<span>boolean</span>(<span>'status'</span>)-&gt;<span>default</span>(<span>true</span>);<br>    <span>$table</span>-&gt;<span>timestamps</span>();<br>});</span>
```

-   **Model Product**

```
<span id="e8ab" data-selectable-paragraph=""><span><span>class</span> <span>Product</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>use</span> <span>HasFactory</span>;<br><br>    <span>protected</span> <span>$fillable</span> = [<span>'sub_category_id'</span>, <span>'name'</span>, <span>'description'</span>, <span>'status'</span>];<br><br>    <span>public</span> <span><span>function</span> <span>subCategory</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>belongsTo</span>(<span>SubCategory</span>::<span>class</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>photos</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>hasMany</span>(<span>ProductGallery</span>::<span>class</span>);<br>    }<br>}</span>
```

-   **Controller Product**

```
<span id="9de3" data-selectable-paragraph=""><span>&lt;?php</span><br><span>namespace</span> <span>App</span>\<span>Http</span>\<span>Controllers</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\<span>Product</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\<span>SubCategory</span>;<br><span>use</span> <span>Illuminate</span>\<span>Http</span>\<span>Request</span>;<br><br><span><span>class</span> <span>ProductController</span> <span>extends</span> <span>Controller</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>index</span>()<br>    </span>{<br>        <span>$products</span> = <span>Product</span>::<span>all</span>();<br>        <span>$i</span> = <span>1</span>;<br>        <span>return</span> <span>view</span>(<span>'pages.products.index'</span>, <span>compact</span>(<span>'products'</span>, <span>'i'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>create</span>()<br>    </span>{<br>        <span>$subCategories</span> = <span>SubCategory</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.products.create'</span>, <span>compact</span>(<span>'subCategories'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>store</span>(<span>Request <span>$request</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'sub_category_id'</span> =&gt; <span>'required|exists:sub_categories,id'</span>,<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'description'</span> =&gt; <span>'required|string'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>Product</span>::<span>create</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'products.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Product created successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>edit</span>(<span>Product <span>$product</span></span>)<br>    </span>{<br>        <span>$subCategories</span> = <span>SubCategory</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.products.edit'</span>, <span>compact</span>(<span>'product'</span>, <span>'subCategories'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>update</span>(<span>Request <span>$request</span>, Product <span>$product</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'sub_category_id'</span> =&gt; <span>'required|exists:sub_categories,id'</span>,<br>            <span>'name'</span> =&gt; <span>'required|string|max:255'</span>,<br>            <span>'description'</span> =&gt; <span>'required|string'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>$product</span>-&gt;<span>update</span>(<span>$request</span>-&gt;<span>all</span>());<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'products.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Product updated successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>destroy</span>(<span>Product <span>$product</span></span>)<br>    </span>{<br>        <span>$product</span>-&gt;<span>delete</span>();<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'products.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Product deleted successfully.'</span>);<br>    }<br>}</span>
```

**5\. Create migration, model, and controller ProductGallery**

```
<span id="c0c3" data-selectable-paragraph="">php artisan <span>make</span>:model -mrc ProductGallery</span>
```

-   **Migration table product\_galleries**

```
<span id="672a" data-selectable-paragraph=""><span>Schema</span>::<span>create</span>(<span>'product_galleries'</span>, function (Blueprint <span>$table</span>) {<br>    <span>$table</span>-&gt;<span>id</span>();<br>    <span>$table</span>-&gt;<span>foreignId</span>(<span>'product_id'</span>)-&gt;<span>constrained</span>(<span>'products'</span>);<br>    <span>$table</span>-&gt;<span>string</span>(<span>'photo'</span>);<br>    <span>$table</span>-&gt;<span>boolean</span>(<span>'status'</span>)-&gt;<span>default</span>(<span>true</span>);<br>    <span>$table</span>-&gt;<span>timestamps</span>();<br>});</span>
```

-   **Model ProductGallery**

```
<span id="7db2" data-selectable-paragraph=""><span><span>class</span> <span>ProductGallery</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>use</span> <span>HasFactory</span>;<br><br>    <span>protected</span> <span>$fillable</span> = [<span>'product_id'</span>, <span>'photo'</span>, <span>'status'</span>];<br><br>    <span>public</span> <span><span>function</span> <span>product</span>()<br>    </span>{<br>        <span>return</span> <span>$this</span>-&gt;<span>belongsTo</span>(<span>Product</span>::<span>class</span>);<br>    }<br>}</span>
```

-   **Controller ProductGallery**

```
<span id="336a" data-selectable-paragraph=""><span>&lt;?php</span><br><span>namespace</span> <span>App</span>\<span>Http</span>\<span>Controllers</span>;<br><span>use</span> <span>Illuminate</span>\<span>Http</span>\<span>Request</span>;<br><span>use</span> <span>Illuminate</span>\<span>Support</span>\<span>Facades</span>\<span>Storage</span>;<br><span>use</span> <span>App</span>\<span>Models</span>\{<span>Product</span>, <span>ProductGallery</span>};<br><br><span><span>class</span> <span>ProductGalleryController</span> <span>extends</span> <span>Controller</span><br></span>{<br>    <span>public</span> <span><span>function</span> <span>index</span>()<br>    </span>{<br>        <span>$galleries</span> = <span>ProductGallery</span>::<span>with</span>(<span>'product'</span>)-&gt;<span>get</span>();<br>        <span>$i</span> = <span>1</span>;<br>        <span>return</span> <span>view</span>(<span>'pages.galleries.index'</span>, <span>compact</span>(<span>'galleries'</span>, <span>'i'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>create</span>()<br>    </span>{<br>        <span>$products</span> = <span>Product</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.galleries.create'</span>, <span>compact</span>(<span>'products'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>store</span>(<span>Request <span>$request</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'product_id'</span> =&gt; <span>'required|exists:products,id'</span>,<br>            <span>'photo'</span> =&gt; <span>'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <span>$photoPath</span> = <span>$request</span>-&gt;<span>file</span>(<span>'photo'</span>)-&gt;<span>store</span>(<span>'gallery'</span>, <span>'public'</span>);<br>        <span>ProductGallery</span>::<span>create</span>([<br>            <span>'product_id'</span> =&gt; <span>$request</span>-&gt;product_id,<br>            <span>'photo'</span> =&gt; <span>$photoPath</span>,<br>            <span>'status'</span> =&gt; <span>$request</span>-&gt;status,<br>        ]);<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'galleries.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Photo added to the gallery successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>edit</span>(<span>ProductGallery <span>$gallery</span></span>)<br>    </span>{<br>        <span>$products</span> = <span>Product</span>::<span>all</span>();<br>        <span>return</span> <span>view</span>(<span>'pages.galleries.edit'</span>, <span>compact</span>(<span>'products'</span>, <span>'gallery'</span>));<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>update</span>(<span>Request <span>$request</span>, ProductGallery <span>$gallery</span></span>)<br>    </span>{<br>        <span>$request</span>-&gt;<span>validate</span>([<br>            <span>'product_id'</span> =&gt; <span>'required|exists:sub_categories,id'</span>,<br>            <span>'photo'</span> =&gt; <span>'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:2048'</span>,<br>            <span>'status'</span> =&gt; <span>'required|boolean'</span>,<br>        ]);<br>        <br>        <span>$oldPhotoPath</span> = <span>$gallery</span>-&gt;photo;<br>        <span>if</span> (<span>$request</span>-&gt;<span>hasFile</span>(<span>'photo'</span>)) {<br>            <span>$photoPath</span> = <span>$request</span>-&gt;<span>file</span>(<span>'photo'</span>)-&gt;<span>store</span>(<span>'gallery'</span>, <span>'public'</span>);<br>            <span>$gallery</span>-&gt;<span>update</span>([<span>'photo'</span> =&gt; <span>$photoPath</span>]);<br>            <br>            <span>if</span> (<span>Storage</span>::<span>disk</span>(<span>'public'</span>)-&gt;<span>exists</span>(<span>$oldPhotoPath</span>)) {<br>                <span>Storage</span>::<span>disk</span>(<span>'public'</span>)-&gt;<span>delete</span>(<span>$oldPhotoPath</span>);<br>            }<br>        } <span>else</span> {<br>            <br>            <span>$gallery</span>-&gt;<span>update</span>([<br>                <span>'product_id'</span> =&gt; <span>$request</span>-&gt;product_id,<br>                <span>'status'</span> =&gt; <span>$request</span>-&gt;status,<br>            ]);<br>        }<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'galleries.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Photo updated successfully.'</span>);<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>destroy</span>(<span>ProductGallery <span>$gallery</span></span>)<br>    </span>{<br>        <br>        <span>$photoPath</span> = <span>$gallery</span>-&gt;photo;<br>        <br>        <span>$gallery</span>-&gt;<span>delete</span>();<br>        <br>        <span>if</span> (<span>Storage</span>::<span>disk</span>(<span>'public'</span>)-&gt;<span>exists</span>(<span>$photoPath</span>)) {<br>            <span>Storage</span>::<span>disk</span>(<span>'public'</span>)-&gt;<span>delete</span>(<span>$photoPath</span>);<br>        }<br>        <span>return</span> <span>redirect</span>()-&gt;<span>route</span>(<span>'galleries.index'</span>)-&gt;<span>with</span>(<span>'success'</span>, <span>'Photo deleted from the gallery successfully.'</span>);<br>    }<br>}</span>
```

**6\. Create a storage link to the public folder**

```
<span id="69d5" data-selectable-paragraph="">php artisan storage:<span>link</span></span>
```

**7\. Basic View with Bootstrap 5**

for the view section, I use Bootstrap as the framework. I use basic features in Bootstrap, such as cards, tables, forms, and others.  
These are some screenshots of the features in this project, for details you can check on my GitHub at the following link: [https://github.com/barnoxdeveloper/laravel-relations.git](https://github.com/barnoxdeveloper/laravel-relations.git)

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1kLRCZovwCgPpQV-K5Perzw.png)

Welcome Page

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/13XSusYXUcLT_oLNPcAqjgQ.png)

Category Page

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1B7HTRwxfcnGuoOa33VNM1A.png)

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1bUE8RGUxfOkoeR5UAMDKOA.png)

Products Page

![](Understanding%20Laravel%20belongsTo%20and%20hasMany%20Relationships%20%20by%20Andre%20Elmustanizar%20%20Medium/1jZ1eJJy7bSdegaDDTRTBrg.png)

Product Gallery Page

**CONCLUSION.**  
Managing relationships between tables in a database is very important in an application that uses a database. By using the right way, all of that will be easy to do, in this article, I exemplify how relationships between 4 tables are easily managed using belonsTo and hasMany in the Laravel Framework.

Actually, there are many more relations between tables in the Laravel Framework, for example, One To One, One To Many, Belongs To, Has One Of Many, Many to Many, and others.  
You can see all the relations in the official Laravel Framework documentation at the following link: [https://laravel.com/docs/10.x/eloquent-relationships#main-content](https://laravel.com/docs/10.x/eloquent-relationships#main-content)

Thank You,  
Greetings Coding from Indonesia,  
André.
