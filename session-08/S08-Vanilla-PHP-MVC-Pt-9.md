

# Building the Application Part 3

We are now into the Products feature... and have created the browse and retrieve actions.

## Product Feature


Next we are going to tackle the Edit sub-feature.

---

### Edit Part 1 (Update view)

The edit and add views are very similar, so let's complete the edit in detail. When we look at add, we will duplicate the edit view and make changes as needed.

Start with a new PHP file, and add the partial loading lines:

```php
<?php
/** Header comments here **/

loadpartial("header");
loadPartial('navigation');
?>

<!-- code to go here ->

<?php
loadPartial("footer");


```

> **Note:** We have missed out the comments!

Now we add the container with the header, replacing the HTML comment "Code to go here":

```php
<main class="container mx-auto bg-zinc-50 py-8 px-4 shadow shadow-black/25 rounded-b-lg flex flex-col flex-grow">
    <article>
        <header class="bg-zinc-700 text-zinc-200 -mx-4 -mt-8 p-8 mb-8 flex">
            <h1 class="grow text-2xl font-bold ">
            Products - Edit
            </h1>
            
            <p class="text-md flex-0 px-8 py-2 bg-emerald-500 hover:bg-emerald-600 text-white rounded transition ease-in-out duration-500">
                <a href="/products/create">Add Product</a>
            </p>
        </header>

<!-- form code here -->

    </article>
</main>
```

That is the base of the page.

After the header, we add a new section with the partial loader to display any errors that may occur...

```php
        <section>

        <?= loadPartial('errors', [
            'errors' => $errors ?? []
        ]) ?>
```

We are now ready to start the form. 

Continuing inside the section we just started, create a form with a POST method and adding a hidden field to indicate we are actually using "PUT"...

```php
            <form method="POST" action="/products/<?= $product->id ?>">
                <input type="hidden" name="_method" value="PUT">



            </form>

        </section>
```


Once we have this, we are now able to create each part of the form inside the `form` element.

First we create the Product name field.

Note that there are NO spaces on the left side of the `<?= $product`  and to the right of ` '' ?>`. If there are, you will have spaces added onto the data when it is saved to the database...

```php
<div class="mb-4">  
    <input type="text" name="name" placeholder="Product Name"  
           class="w-full px-4 py-2 border rounded focus:outline-none"  
           value="<?= $product->name ?? '' ?>"/>  
</div>  

```

Next it is the Product description field.

Notice how we have included the `$product->description` inside the open and close tags for the `textarea` element.

Again, note that there are NO spaces on the left side of the `<?= $product` and to the right of `'' ?>`. If there are, you will have spaces added to the data when it is saved to the database...

```php
<div class="mb-4">  
<textarea name="description" placeholder="Product Description"  
          class="w-full px-4 py-2 border rounded focus:outline-none"  
><?= $product->description ?? '' ?></textarea>  
</div>  

```

Last of the fields (for now) is the Product price:

```php  
<div class="mb-4">  
    <input type="text" name="price" placeholder="Price"  
           class="w-full px-4 py-2 border rounded focus:outline-none"  
           value="<?= $product->price ?? '' ?>"/>  
</div>  

```

That's the fields taken care of, and now the two buttons.

First the Save button...

```php  
<button type="submit"  
        class="w-full bg-green-500 hover:bg-green-600 text-white px-4 py-2 my-3 rounded  
           focus:outline-none">  
    Save  
</button>  

```

And then the Cancel... which is really just a link back to the details page...

```php  
<a href="/products/<?= $product->id ?>"  
   class="block text-center w-full bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded  
      focus:outline-none">  
    Cancel  
</a>
```

#### Exercise 1:

Refer to the users pages, and modify the above code to include labels for each of the fields.

#### Exercise 2:

Make the Save and Cancel buttons align on the same line, as per the edit and delete buttons of the details page.

#### Exercise 3:

Add a new text field for the filename of an image.

**Important:** We are **NOT** expecting you to create a file upload function.


Ok, so the view is complete... next the `edit` method that will show this form and then in part three of this stage, the `update` method that will make the actual changes in the database...

### Edit Part 2 (Edit method)

The edit method is very similar to the `show` in that it requires a parameter that has the ID of the product, and it uses the same method as the `show` to retrieve the product.

The only difference is that we send the data and open the `edit` view instead:

```php
public function edit($params)  
{  
    $id = $params['id'] ?? '';  
  
    $params = [  
        'id' => $id  
    ];  
  
    $product = $this->db->query('SELECT * FROM products WHERE id = :id', $params)->fetch();  
  
    // Check if product exists  
    if (!$product) {  
        ErrorController::notFound('Product not found');  
        return;  
    }  
```

The next change is that we need to verify that the item being edited belongs to the user who is logged in. If it does not then we display an 'Unauthorised' error page.

```php
    // Authorisation  
    if (!Authorisation::isOwner($product->user_id)) {  
        Session::setFlashMessage('error_message', 'You are not authoirzed to update this product');  
        return redirect('/products/' . $product->id);  
    }  
```

Now we can send the data to the edit view we just created.

```php
    loadView('products/edit', [  
        'product' => $product  
    ]);  
}
```


OK, so that's the edit page displaying.

We now need to deal with the form data when it is submitted...

### Edit Part 3 (Update method)

OK, on your marks... get set... GO! 

Let's create the Update method.

Modify the signature to accept a set of parameters:

```php
public function update($params)
    {
```

As before, transform the `id` part of the parameters and replace the parameter list as needed...
```php
        $id = $params['id'] ?? '';

        $params = [
            'id' => $id
        ];
```

Retrieve the product indicated by the `id`... giving an error page if the product id provided does not exist.

```php
        $product = $this->db->query('SELECT * FROM products WHERE id = :id', $params)->fetch();

        // Check if product exists
        if (!$product) {
            ErrorController::notFound('Product not found');
            return;
        }
```

Verify that the user who is logged in, owns the product and thus is allowed to edit the details...
```php
        // Authorisation
        if (!Authorisation::isOwner($product->user_id)) {
            Session::setFlashMessage('error_message', 'You are not authoirzed to update this product');
            return redirect('/products/' . $product->id);
        }
```

Now we get to a very interesting part...

We want to make sure that the data being submitted only affects the fields we allow. In this case the `name`, `description` and `price`.

So we use the array intersect function to retrieve only these fields from the values send by the form when POST-ed.

```php
        $allowedFields = ['name', 'description', 'price'];

        $updateValues = [];

        $updateValues = array_intersect_key($_POST, array_flip($allowedFields));
```

Next we use our `sanitize` function (see the `helpers.php` file) to make sure that any data saved has special characters filtered and transformed as needed.

```php
        $updateValues = array_map('sanitize', $updateValues);
```

We are now able to check to make sure the **required** fields, that is the name and price, contain data before we look at saving to the database...

```php
        $requiredFields = ['name', 'price'];

        $errors = [];

        foreach ($requiredFields as $field) {
            if (empty($updateValues[$field]) || !Validation::string($updateValues[$field])) {
                $errors[$field] = ucfirst($field) . ' is required';
            }
        }
```

If any of the fields are missing data then the above code adds an error to the `$errors` array.

Obviously we do not want to process the data if there are errors, so we check and redirect back to the edit page if there are.

```php
        if (!empty($errors)) {
            loadView('products/edit', [
                'product' => $product,
                'errors' => $errors
            ]);
            exit;
        } else {
```

OK, so we are now ready to submit to the database.

First we process each field in the list of 'update fields', creating a set of query sections that will be like this:

```text
name = :name, price = :price, description = :description
```

This is then appended to a base SQL Query to perform the update:

```php
// Submit to database
            $updateFields = [];

            foreach (array_keys($updateValues) as $field) {
                $updateFields[] = "{$field} = :{$field}";
            }

            $updateFields = implode(', ', $updateFields);

            $updateQuery = "UPDATE products SET $updateFields WHERE id = :id";
```

Once this is complete, we then execute the update query.

```php
            $updateValues['id'] = $id;
            $this->db->query($updateQuery, $updateValues);

```

After the update we set a flash message, and redirect to the show page for the product we have just edited so we can see the changes have been made.

```php
            // Set flash message
            Session::setFlashMessage('success_message', 'Product updated');

            redirect('/products/' . $id);
        }
    }
```


Next it is the turn of the Add feature...


---

### Add Part 1 (Create view)

We are on the penultimate sub-feature of the Products.

We already can edit a product, but we also need to be able to create them. So it's time to do that.

We will create the view (hint, its very similar to the edit view), then the two methods used to first open the create view, and the second to perform the save process.

OK, let's start by re-using the Edit view.

Duplicate the `edit.view.php` page in the `App/viewes/products` folder, renaming it to `create.view.php`.

Open the file and make the following changes:

#### Page title

Update the page title to:

```php
<h1 class="grow text-2xl font-bold ">
	Products - Add
</h1>
```

#### Form method action

The form method becomes:

```php
<form method="POST" action="/products">
```
#### Remove hidden field

We do not need a hidden field for this page, so remove the line:
```php
<input type="hidden" name="_method" value="PUT">
```

Next we will be updating the input elements to utilise arrays as we do not retrieve the data from the database and send to the form...

#### Change value on Name input

Update the input element for the name so the `value=` now reads:

```php
value="<?= $product['name'] ?? '' ?>"
```

#### Change Text area content for description

For the test area, between the `>` and `</textarea>` we now replace the content so it reads:

```php
><?= $product['description'] ?? '' ?></textarea>
```

#### Change value on price input

Update the input element for the price so the `value=` now reads:

```php
value="<?= $product['price'] ?? '' ?>"/>
```

#### Change the Cancel link 

Update the HREF for the cancel link button to:

```php
<a href="/products"
```


OK, now onto the two methods that show the add page and then save the data.

### Add Part 2 (Create method)

This is short and sweet... update the stub to read:

```php
public function create()  
{  
    loadView('products/create');  
}
```

### Add Part 3 (Store method)

Just like the `update` method, the `store` method has a fair chunk of code... sections of which are identical.

So here we go...

We will only discuss/describe the parts that are different, so you can begin by copying the `update` method code, and paste into the store method.

The first difference is that the `store` method's signature does NOT need an parameters.

```php
public function store()
    {
```

The allowed fields, data sanitisation and the required fields section is the same.

```php
        $allowedFields = ['name', 'description', 'price'];

        $newProductData = array_intersect_key($_POST, array_flip($allowedFields));

        $newProductData['user_id'] = Session::get('user')['id'];

        $newProductData = array_map('sanitize', $newProductData);

        $requiredFields = ['name', 'price'];

        $errors = [];

        foreach ($requiredFields as $field) {
            if (empty($newProductData[$field]) || !Validation::string($newProductData[$field])) {
                $errors[$field] = ucfirst($field) . ' is required';
            }
        }
```

But this is where we will get changes occurring...

When it comes to sending errors back to the add page for the user to correct, we also need to send the data for the product back.

```php
        if (!empty($errors)) {
            // Reload view with errors
            loadView('products/create', [
                'errors' => $errors,
                'product' => $newProductData
            ]);
        }
```

Now we can continue on with the processing of the data and saving the details to the database.

Remove the lines up to the `$updateQuery` and replace with the following:

```php
// Save the submitted data  
$fields = [];  
  
foreach ($newProductData as $field => $value) {  
    $fields[] = $field;  
}  
  
$fields = implode(', ', $fields);  
```

This creates a list of the fields we will be saving data to as a set of comma separated field names.

Then we extract the values for each of the fields, imploding them into a string of comma separated values.

```php
$values = [];  
  
foreach ($newProductData as $field => $value) {  
    // Convert empty strings to null  
    if ($value === '') {  
        $newProductData[$field] = null;  
    }  
    $values[] = ':' . $field;  
}  
  
$values = implode(', ', $values);
```

Now it is time to change the `$updateQuery` line to read:

```php
$insertQuery = "INSERT INTO products ({$fields}) VALUES ({$values})";
```

We are now able to execute the query, set a success flash message and redirect to the products page.

```php
            $this->db->query($insertQuery, $newProductData);

            Session::setFlashMessage('success_message', 'Product created successfully');

            redirect('/products');
        }
    }
```

> **Note:**
> 
> We have neglected to use PDO's binding to make sure that data is saved correctly. 


#### Exercise 4:

We noted the lack of use of `bindValue`... how could you modify the code we have to use this to make sure the values are correctly used in the query?


### Delete (Destroy method)

We are on the last of the sub-features for Product... delete!

We are not creating a confirm the delete page, so we will simply implement the delete method without any ability to undo...

Yes this is dangerous, and we usually would have some way of either confirming a deletion, or in some situations, having a trash can where we can undo deletions from.

The destroy method (or if you are a Dr Who fan, the `exterminate` method), as we have just indicated, has no safety net.

It starts with the requirement for parameters to be passed. This parameter is the id of the record to be deleted.

```php
public function destroy($params)  
{  
```

As per the show and edit methods, we then extract the parameters we need (the `id`), and replace the parameter list with just this item.

```php

    $id = $params['id'];  
  
    $params = [  
        'id' => $id  
    ];  
```

We now execute a query to check the required `id` is in the database, if not we show a "not found" error.

```php
    $product = $this->db->query('SELECT * FROM products WHERE id = :id', $params)->fetch();  
  
    // Check if product exists  
    if (!$product) {  
        ErrorController::notFound('Product not found');  
        return;  
    }  
```

Now we verify the user who is making the delete is the owner of the record... and if not, we give an "unauthorised" error.

```php
    // Authorisation  
    if (!Authorisation::isOwner($product->user_id)) {  
        Session::setFlashMessage('error_message', 'You are not authoirzed to delete this product');  
        return redirect('/products/' . $product->id);  
    }  
```

We are now able to run the delete and remove the product from the database.
```php
    $this->db->query('DELETE FROM products WHERE id = :id', $params);  
```

Finally set a flash message, and redirect to the products page.
```php
   Session::setFlashMessage('success_message', 'Product deleted successfully');  
  
    redirect('/products');  
}
```



## Reflection Questions

### Question 1: Data Binding

What could we do to make sure that the data being entered is the correct type?

How difficult would this be to implement?


### Question 2: Refactoring

There are sections of code in the application that are repeated, how could you refactor this code to reduce replication?


### Question 3: Exceptions!

Currently we have many places that exceptions could occur.

Consider how you could make the application display a more meaningful and user friendly error when such a situation occurs.


---


So that's the coding done... time to test... [S07 Vanilla PHP MVC Pt 10 (Testing)](session-08/S08-Vanilla-PHP-MVC-Pt-10.md)

