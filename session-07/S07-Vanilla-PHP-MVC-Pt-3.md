

# Continuing to build the Framework

So far we have created the helpers, the routes and the database configuration.

In this section we will look at the main framework code.

The framework consists of:
- Authorisation
- Database
- Router
- Session
- Validation
- Middleware/Authorise

Remember that these are *not* extensive, but a very simple implementation, to show you how we create an MVC framework.

The Authorisation and Authorise classes we create perform different purposes, and these will be explained when we cover them within these notes.

We will start with the Database, then the Router, Session, before hitting the remaining 3 classes.

## Database

The database class takes care of the database connection and executing SQL queries.

Create a new class in the `Framework` folder by doing the following:

- Right Mouse Click on the Framework folder
- Hover over New
- Then hover over and click PHP Class

![image: right mouse clicking on a folder to create a new PHP Class](assets/Pasted%20image%2020240827145826.png)

Now complete the resulting dialog box:

![Image: New Class Dialog Box](assets/Pasted%20image%2020240827145943.png)

Here are the values:

| Name      | Value     |
| --------- | --------- |
| Name      | Database  |
| Namespace | Framework |
| Filename  | Database  |
| Template  | Class     |

Once you have the values entered, you click OK, click OK again without entering a file location.

You now have a blank class:

```php
<?php
/**
 * FILE TITLE GOES HERE
 *
 * DESCRIPTION OF THE PURPOSE AND USE OF THE CODE
 * MAY BE MORE THAN ONE LINE LONG
 * KEEP LINE LENGTH TO NO MORE THAN 96 CHARACTERS
 *
 * Filename:        Database.php
 * Location:
 * Project:         SaaS-Vanilla-MVC
 * Date Created:    DATE_CREATED
 *
 * Author:          YOUR NAME
 *
 */

namespace Framework;

class Database
{

}
```

We are now ready to complete the header text, class properties and  methods.

### Header Text:

The header text only needs a small alteration:

```text
/**  
 * Database Access Class 
 * 
 * Provides the database access tools used by our micro-framework
```

Plus the file location will change to: `Framework/`.


### Required 'use' statements

Before we add any mehtods and propertiues to the class, we need to inlcude a number of `use` lines to import various class defintions before they are used.

These classes are built into PHP, and not defined by us as coders.

The use lines appear after the `namespace` line, and before the `class` line.

```php
use Exception;  
use PDO;  
use PDOStatement;
use PDOException;
```

## The Properties

This class has one property which is the 'connection' property.

Immediately after the curly bracket (`}`) after the `class` line, add:

```php
    /**
     * Connection Property
     * 
     * @var PDO 
     */
    public $conn;
```

### Methods: `__construct` and `query`

Now onto the main parts of the class.

#### Constructor

The first is the constructor, `__construct`. This is called when you instantiate a Database object. 

The constructor is given an array of configuration parameters for it to use for the connection.

During this instantiation, the method uses the database connection information to connect to the database server using the username and password, plus establish a link to the database ready for commands to be issued.

The constructor uses PDO options that set the error mode to exceptions, and the fetch mode to use objects rather than associative arrays or similar.

When the constructor attempts to create the connection (in a `try`...`catch`) it sets a public property `conn` to the value of the successful connection ready for use.

On failure, a suitable exception is thrown and the application will stop.

```php
/**  
 * Constructor for Database class 
 * 
 * @param array $config  
 */  
public function __construct($config)  
{  
    $host =$config['host'];
    $port = $config['port'];
    $dbName = $config['dbname'];
    
    $dsn = "mysql:host={$host};port={$port};dbname={$dbName}";  
  
    $options = [  
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,  
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ  
    ];  
  
    try {  
        $this->conn = new PDO($dsn, $config['username'], $config['password'], $options);  
    } catch (PDOException $e) {  
        throw new Exception("Database connection failed: {$e->getMessage()}");  
    }  
}
```

### Query

The second method is the `query` method. This method takes a query and the parameters that may need to be passed to the query.

The query contains the SQL with named parameters in place. 


The parameters (`params`) are an associative array and these correspond to the SQL named parameters.

They will be expanded and inserted into the SQL using the `bindValue` PDO method.

Once the parameters are inserted and bound, the statement is executed and if successful the method will return the PDO statement with execution results ready for processing.


```php
    /**
     * Query the database
     */
public function query($query, $params = [])
{
    try {
        $sth = $this->conn->prepare($query);

        // Bind named params
        foreach ($params as $param => $value) {
            $sth->bindValue(':' . $param, $value);
        }

        $sth->execute();
        return $sth;
    } catch (PDOException $e) {
        throw new Exception("Query failed to execute: {$e->getMessage()}");
    }
}
```

### Update the DocBlocks

There are a number of extra items we should add to our DocBlocks.

Here are more complete DocBlocks, but we are not indicating which one belongs to which... it should be obvious.

```php
    /**
     * Query the database
     * 
     * The SQL to execute and an optional array of named parameters and values
     * are required.
     *
     * Use:
     * <code>
     *   $sql = "SELECT name, description from products WHERE name like '%:name%'";
     *   $filter = ['name'=>'ian',];
     *   $results = $dbConn->query($sql,$filter);
     * </code>
     *
     * @param string $query
     * @param array $params []|[associative array of parameter names and values]
     *
     * @return PDOStatement
     * @throws PDOException|Exception
     */
 

    /**
     * Constructor for Database class
     *
     * @param array $config
     * @throws Exception
     */

```

## Router

The router is fairly complex, but it is the workhorse of the framework as it directs the incoming requests to the correct location.

Create a new  class "Router" in the Framework folder.

Add the following two `use` lines immediately after the namespace:

```php
use App\Controllers\ErrorController;  
use Framework\Middleware\Authorise;
```

### Properties

The Router class has one public property: `$routes`. This is used to hold the routes in memory as the application is executed, thus allowing faster response times.

The register route method is used by `get`, `put`, `post` and `delete` HTTP methods to add routes to the `$routes` property.

The actual routes are defined in the `routes.php` file.

```php
protected $routes = [];
```


### Register Route method

The `registerRoute` method is given an HTTP method, the URI to match against, an action (controller method) and optional middleware required.

One interesting part of the method is...

```php
    list($controller, $controllerMethod) = explode('@', $action);  
```

This creates a list (array) that includes the controller name and the method from a string of the form `controller@method`. For example `ProductController@update`.

After this, the method adds the various parts of the route to the routes property.

The complete method code:
```php
public function registerRoute($method, $uri, $action, $middleware = [])  
{  
    list($controller, $controllerMethod) = explode('@', $action);  
  
    $this->routes[] = [  
        'method' => $method,  
        'uri' => $uri,  
        'controller' => $controller,  
        'controllerMethod' => $controllerMethod,  
        'Middleware' => $middleware  
    ];  
}
```

We will talk about middleware when we come to the Authorize class.

The Register Route is used by each of the Get, Post, Put and Delete methods...

### Get method

The `get` method is used to register a GET HTTP method route and accepts a URI, Controller and optional Middleware. 

It calls the register route method to add the get request to the route list.

```php
public function get($uri, $controller, $middleware = [])  
{  
    $this->registerRoute('GET', $uri, $controller, $middleware);  
}
```

### Post method

This method is the same as `get`, except we are looking at the POST HTTP method.

```php
public function post($uri, $controller, $middleware = [])  
{  
    $this->registerRoute('POST', $uri, $controller, $middleware);  
}
```

### Put method

Not much difference here, except the PUT HTTP method is being handled. This is used for updating data.

```php
public function put($uri, $controller, $middleware = [])  
{  
    $this->registerRoute('PUT', $uri, $controller, $middleware);  
}
```


### Delete method

We are on the last of the HTTP methods we are handling,  DELETE.

```php
public function delete($uri, $controller, $middleware = [])  
{  
    $this->registerRoute('DELETE', $uri, $controller, $middleware);  
}
```


### Route method

We are now into the last method, and this is the most complex part of the framework.

The reason is that the Route method has to handle each request, deconstruct the requested URI,  identify which controller is being requested, make sure that any middleware is applied, and then instantiate the required called and call the method (action) that is being requested.

Yep, a lot is done by this one method.

Here are the parts of the method with quick descriptions...

```php
$requestMethod = $_SERVER['REQUEST_METHOD'];  
  
// Check for _method input  
if ($requestMethod === 'POST' && isset($_POST['_method'])) {  
    // Override the request method with the value of _method  
    $requestMethod = strtoupper($_POST['_method']);  
}
```

Here we get the request (HTTP) method that is being used (GET, POST).

> **Important:** Because the majority of web servers do not identify the PUT, PATCH and DELETE HTTP methods, we have to fake these requests by using a 'hidden' `_method` request variable along with the supported POST HTTP method.

When we want to do a PUT or DELETE we set the `_method` to the required action. 

When the request method is checked, if there is a `_method` set, then the request method is changed from POST to the required action.

The next section of code contains the guts of this method, and requires the processing of the requested URIL against each of the registered routes... 

```php
foreach ($this->routes as $route) {  
  
    $uriSegments = explode('/', trim($uri, '/'));  
  
    $routeSegments = explode('/', trim($route['uri'], '/'));  
  
    $match = true;
```

Next we need to go through the registered routes one by one.

We explode the incoming request URI into segments. This is ready for matching.

We do the same for the URI of the current registered route.

We then set a default value for match completion, so we only need to change this when no match is found.

The next part is where we check the segments of the request against the segments of the registered route...

```php
if (count($uriSegments) === count($routeSegments) && strtoupper($route['method'] === $requestMethod)) {  
    $params = [];  
  
    $match = true;  
    $segments = count($uriSegments);  
    for ($i = 0; $i < $segments; $i++) {  
        
        if ($routeSegments[$i] !== $uriSegments[$i] && !preg_match('/\{(.+?)}/', $routeSegments[$i])) {  
            $match = false;  
            break;  
        }  
  
        if (preg_match('/\{(.+?)}/', $routeSegments[$i], $matches)) {  
            $params[$matches[1]] = $uriSegments[$i];  
        }  
    }
```

So we do not waste time processing the first thing we do is to check if:
- the number of segments in the requested URI and the number of segments in the current route are the same
and...
- the method being used by the request is the same as the route expects.

If this is true, we set the match to be true... then count the segments ready for processing.

Next we go through each segment in the requested URI, checking if the segment **does not match** the route segment **and** do a regular expression match to check there are **no** parameters. If this is true, then the `match` is set to false, and we break from the loop.

If the previous decision is false we then check and add the parameter to the parameters array.

We are now ready to process the middleware component of the route, if required...

```php
if ($match) {  
    foreach ($route['Middleware'] as $middleware) {  
        (new Authorise())->handle($middleware);  
    }  
  
    $controller = 'App\\controllers\\' . $route['controller'];  
    $controllerMethod = $route['controllerMethod'];  
  
    // Instantiate the controller and call the method  
    $controllerInstance = new $controller();  
    $controllerInstance->$controllerMethod($params);  
    return;  
}
```

If we get to this block of code and the `match` is still true we are able to process the middleware requirements.

The code checks the middleware requested, creating a new instance of the Authorise class, and executes its handle method. 

Next it creates a reference string to the controller class and a reference to the controller method being requested.

It then instantiates a copy of the controller and calls the method with the parameters required before returning.

If, after all that, the route was not found, then an error is created using the ErrorController's static not found method.


### Exercise: Update Header Comments

You are expected to update the header comments to give a title and explain the purpose of this class to other developers. Make sure any parameters are included as well as an example of how to use the method.

---

## Session

Use the same technique as previously to create a new class in the Framework folder, this time called Session.

Fill out the header DocBlock as required.

#### Start Method

We will begin with the `start` method.

```php
  
namespace Framework;  
  
class Session  
{  
    /**  
     * Start the session     
     *     
     * @return void  
     */    
    public static function start()  
    {  
        if (session_status() == PHP_SESSION_NONE) {  
            session_start();  
        }  
    }
```

This simply checks to see if a session has been created, if not it starts it!

### Clear All method

The clear all method is used to remove all session data, but most importantly it can be used as a way to clear a 'logged in' user's session. You will see it in action in a future set of notes.

```php
/**  
 * Clear all session data 
 * 
 * @return void  
 */
public static function clearAll()  
{  
    session_unset();  
    session_destroy();  
}
```


### Clear method

Unlike Clear All, the Clear method only removes ONE entry (key & value) from the session.

```php
/**  
 * Clear session by key 
 * 
 * @param string $key  
 * @return void  
 */
public static function clear($key)  
{  
    if (isset($_SESSION[$key])) {  
        unset($_SESSION[$key]);  
    }  
}
```

### Get Method

The get method is used to retrieve a key's value from, the session.

It will return a value if the session's key is set, otherwise a default value which may be null, or user (developer) specified.

```php
/**  
 * Get a session value by the key 
 * 
 * @param string $key  
 * @param mixed $default  
 * @return mixed  
 */
public static function get($key, $default = null)  
{  
    return isset($_SESSION[$key]) ? $_SESSION[$key] : $default;  
}
```

### Set Method

Set completes the opposite task to get/clear.

The Set method is given a key and a value and stores or updates the value in the session for the provided key.

```php
/**  
 * Set a session key/value pair 
 * 
 * @param string $key  
 * @param mixed $value  
 * @return void  
 */
public static function set($key, $value)  
{  
    $_SESSION[$key] = $value;  
}
```

### Has method

The has method checks to see if the session data contains a particular entry (key).

```php
/**  
 * Check if session key exists 
 * 
 * @param string $key  
 * @return bool  
 */
public static function has($key)  
{  
    return isset($_SESSION[$key]);  
}
```


### Set & Get Flash Message Methods

Flash messages are messages that are shown on a web page for a brief period of time. In the case of a site without any JavaScript interaction, this is usually between pager refreshes, or between page navigations.

The methods use the get and set methods that are part of this class.

#### Set Flash Message 

```php
public static function setFlashMessage($key, $message)  
{  
    self::set('flash_' . $key, $message);  
}
```


#### Get Flash Message

You will notice that Get Flash Message deletes the key that was set once it is retrieved, thus making the key 'transient'.

```php
public static function getFlashMessage($key, $default = null)  
{  
    $message = self::get('flash_' . $key, $default);  
    self::clear('flash_' . $key);  
    return $message;  
}
```

### Exercise: Update Header Comments

You are expected to update the header comments to give a title and explain the purpose of this class and its methods to other developers.


---

next... [S07 Vanilla PHP MVC Pt 4](../session-07/S07-Vanilla-PHP-MVC-Pt-4.md)
