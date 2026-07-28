# Create a Laravel 12 API Application Using Artisan Commands

This guide uses the official Laravel 12 documentation and limits the command-line workflow to `php artisan` commands.

> **Prerequisite:** You must already be inside an existing Laravel 12 application directory.
> A new Laravel project cannot be created with `php artisan` because the `artisan` file does not exist until Laravel has already been installed.

---

## 1. Confirm Artisan Is Available

```bash
php artisan --version
```

Expected result:

```text
Laravel Framework 12.x
```

View the available commands:

```bash
php artisan list
```

---

## 2. Configure the Application Key

Most fresh Laravel applications already contain an application key.

Generate one when required:

```bash
php artisan key:generate
```

Clear cached configuration after changing `.env` values:

```bash
php artisan config:clear
```

---

## 3. Install Laravel API Support

Laravel provides the `install:api` command to install API routing and Laravel Sanctum.

```bash
php artisan install:api
```

This command prepares the application for API development and creates the API route file used by Laravel.

Run the database migrations:

```bash
php artisan migrate
```

Check the installed routes:

```bash
php artisan route:list
```

Show only API routes:

```bash
php artisan route:list --path=api
```

---

## 4. Generate the API Domain Files

This example uses a `Product` resource.

Create the model, migration, factory and seeder:

```bash
php artisan make:model Product --migration --factory --seed
```

Equivalent short form:

```bash
php artisan make:model Product -mfs
```

This creates:

```text
app/Models/Product.php
database/migrations/...create_products_table.php
database/factories/ProductFactory.php
database/seeders/ProductSeeder.php
```

---

## 5. Generate an API Controller

Create a controller containing the five API resource methods:

```bash
php artisan make:controller Api/V1/ProductController --api --model=Product
```

The generated controller contains:

```text
index
store
show
update
destroy
```

The `create` and `edit` methods are excluded because an API normally returns JSON rather than HTML forms.

---

## 6. Generate Form Request Classes

Create a request class for storing a product:

```bash
php artisan make:request StoreProductRequest
```

Create a request class for updating a product:

```bash
php artisan make:request UpdateProductRequest
```

These classes provide a dedicated location for:

- validation rules
- authorisation checks
- reusable request logic

---

## 7. Generate an API Resource

Create a resource class for transforming product data into JSON:

```bash
php artisan make:resource ProductResource
```

Create a resource collection when a separate collection class is required:

```bash
php artisan make:resource ProductCollection
```

API resources provide a consistent JSON response structure.

---

## 8. Run the Migration

After defining the `products` table in the generated migration, run:

```bash
php artisan migrate
```

Check migration status:

```bash
php artisan migrate:status
```

Rollback the most recent migration batch when required:

```bash
php artisan migrate:rollback
```

Rebuild the database during development:

```bash
php artisan migrate:fresh
```

Rebuild and seed the database:

```bash
php artisan migrate:fresh --seed
```

---

## 9. Run the Seeder

Run every seeder registered by `DatabaseSeeder`:

```bash
php artisan db:seed
```

Run only the product seeder:

```bash
php artisan db:seed --class=ProductSeeder
```

---

## 10. Generate API Tests

Create a feature test:

```bash
php artisan make:test ProductApiTest
```

Create a Pest feature test when the project uses Pest:

```bash
php artisan make:test ProductApiTest --pest
```

Run the full test suite:

```bash
php artisan test
```

Run only the product API test:

```bash
php artisan test --filter=ProductApiTest
```

Stop immediately after the first failure:

```bash
php artisan test --stop-on-failure
```

---

## 11. Inspect the API Routes

After registering the resource route in `routes/api.php`, inspect it with:

```bash
php artisan route:list --path=api
```

Filter routes by name:

```bash
php artisan route:list --name=products
```

A standard API resource should expose routes similar to:

```text
GET       api/products
POST      api/products
GET       api/products/{product}
PUT       api/products/{product}
PATCH     api/products/{product}
DELETE    api/products/{product}
```

---

## 12. Start the Development Server

```bash
php artisan serve
```

Laravel normally starts at:

```text
http://127.0.0.1:8000
```

The API base URL is normally:

```text
http://127.0.0.1:8000/api
```

Use a different port when required:

```bash
php artisan serve --port=8080
```

---

## 13. Useful Development Commands

Clear all Laravel optimisation caches:

```bash
php artisan optimize:clear
```

Clear the application cache:

```bash
php artisan cache:clear
```

Clear the route cache:

```bash
php artisan route:clear
```

Clear the configuration cache:

```bash
php artisan config:clear
```

Display environment information:

```bash
php artisan about
```

Open Laravel Tinker:

```bash
php artisan tinker
```

---

## Complete Artisan Workflow

```bash
php artisan --version

php artisan key:generate

php artisan install:api

php artisan make:model Product -mfs

php artisan make:controller Api/V1/ProductController --api --model=Product

php artisan make:request StoreProductRequest

php artisan make:request UpdateProductRequest

php artisan make:resource ProductResource

php artisan make:test ProductApiTest --pest

php artisan migrate

php artisan db:seed --class=ProductSeeder

php artisan route:list --path=api

php artisan test

php artisan serve
```

---

## Important Limitation

Artisan can generate and manage the application structure, but it cannot complete the entire API without editing the generated PHP files.

You must still add code to:

- the migration
- the model
- the factory
- the seeder
- the controller
- the request classes
- the API resource
- `routes/api.php`
- the tests

For example, the API resource route must be registered in `routes/api.php`:

```php
use App\Http\Controllers\Api\V1\ProductController;
use Illuminate\Support\Facades\Route;

Route::apiResource('products', ProductController::class);
```

Therefore, the accurate description of this workflow is:

> Use only `php artisan` commands for installation, scaffolding, database management, inspection, testing and running the Laravel API application.

---

## Official Laravel 12 Documentation

- Artisan Console: https://laravel.com/docs/12.x/artisan
- Laravel Sanctum and `install:api`: https://laravel.com/docs/12.x/sanctum
- Controllers and API resource controllers: https://laravel.com/docs/12.x/controllers
- Eloquent models: https://laravel.com/docs/12.x/eloquent
- Database migrations: https://laravel.com/docs/12.x/migrations
- Database seeding: https://laravel.com/docs/12.x/seeding
- Validation and form requests: https://laravel.com/docs/12.x/validation
- Eloquent API resources: https://laravel.com/docs/12.x/eloquent-resources
- HTTP tests: https://laravel.com/docs/12.x/http-tests
