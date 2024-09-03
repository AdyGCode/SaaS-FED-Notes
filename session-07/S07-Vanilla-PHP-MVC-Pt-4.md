

# Continuing to build the Framework



---

## Validation

The validation class is next.

This deals with validating data that is to be stored in the database, as well as other purposes.

Our simple validator only contains three methods for validating:
- string length
- email address structure
- matching values

### Create Class

Create a Validation class in the Framework folder.

### String Validation

The sting validation checks to see if the provided value is a string, and then cheks the length of the string is between the minimum and maximum lengths.

We use the `INF` PHP constant to represent a string of any length, and thus provide the developpr with a simple way of testing for a string with a minimum length but no maximum:

```php
// returns false - string is less than 20 characters
Validate::string('Abcdefghijk', 20);
```



Here is the method:

```php
public static function string($value, $min = 1, $max = INF)  
{  
    if (is_string($value)) {  
        $value = trim($value);  
        $length = strlen($value);  
        return $length >= $min && $length <= $max;  
    }  
  
    return false;  
}
```



### Email Validation

The email validation uses the built in `filter_var` function to validate that the structure of the email address is correct.

```php
public static function email($value)  
{  
    $value = trim($value);  
  
    return filter_var($value, FILTER_VALIDATE_EMAIL);  
}
```

### Match Validation

This ensures that the two values given are the same type and the same value.

This means that `123` and `"123"` will give FALSE as they are a number and a string - different types. 

```php
public static function match($value1, $value2)  
{  
    $value1 = trim($value1);  
    $value = trim($value2);  
  
    return $value1 === $value2;  
}
```



### Exercise: Update Header Comments

You are expected to update the header comments to give a title and explain the purpose of this class to other developers.

Also add/update the method DocBlock comments to provide developer and IDE assistance.

---


## Authorisation

The Authorisation class is very short and has one method that checks if a particular resource is owned by the currently logged in user.

Create the `Authorisation` class in the Framework folder and add the following method:

```php
public static function isOwner($resourceId)  
{  
    $sessionUser = Session::get('user');  
  
    if ($sessionUser !== null && isset($sessionUser['id'])) {  
        $sessionUserId = (int)$sessionUser['id'];  
        return $sessionUserId === $resourceId;  
    }  
  
    return false;  
}
```



### Exercise: Update Header Comments

You are expected to update the header comments to give a title and explain the purpose of this class to other developers, plus add a suitable DocBlock for the method.

---


## Middleware/Authorise

Our last of our micro-framework's classes is the `Authorise` class which is used to 

- Verify if a user is logged in
- Redirect a unauthenticated user to the login page
- Redirect a 'guest' user to the home page

Create a new class in teh Framework/Middleware folder called `Authorise`.

Add the following to the class:

### Is Authenticated method

a simple test to check if the session has a user key.

```php
public function isAuthenticated()  
{  
    return Session::has('user');  
}
```


### Handle method

The handle method accepts a 'role' and then performs an action depending on the role and if the current 'user' is logged in.

```php
public function handle($role)  
{  
    if ($role === 'guest' && $this->isAuthenticated()) {  
        return redirect('/');  
    }  
  
    if ($role === 'auth' && !$this->isAuthenticated()) {  
        return redirect('/auth/login');  
    }  
}
```


### Exercise: Update Header Comments

You are expected to update/add the method and class header comments to explain them to other developers.

---

## Next time...

The next session continues the development with the creatoin of an application using our micro-framework code.

[S08 Vanilla PHP MVC - Pt 5](session-08/S08-Vanilla-PHP-MVC-Pt-5.md)
