

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

The Authorsation and Authorise classes we create perform different purposes, and these will be explained when we cover them within these notes.

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
 * Database Access Class * * Provides the database access tools used by our micro-framework
```

Plus the file location will change to: `Framework/`.


## Methods: `__construct` and `query`

Now onto the main parts of the class.

#### Constructor

The first is the constructor, `__construct`. This is called when you instantiate a Database object. 

During this instantiation, the method uses the database connection information to connect to the database server using the username and password, plus establish a link to the database ready for commands to be issued.

The constructor uses PDO options that set the error mode to exceptions, and the fetch mode to use objects rather than associative arrays or similar.




### Router


### Session


### Validation


### Authorisation



### Middleware/Authorise



