---
created: 2025-04-29T17:27:26 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/blade/notifications-and-events
author: 
updated: 2025-05-01T11:53
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **07.** Notifications & Events

Let's take Chirper to the next level by sending [email notifications](https://web.archive.org/web/20240927152838/https://laravel.com/docs/notifications#introduction) when a new Chirp is created.

In addition to support for sending email, Laravel provides support for sending notifications across a variety of delivery channels, including email, SMS, and Slack. Plus, a variety of community built notification channels have been created to send notification over dozens of different channels! Notifications may also be stored in a database so they may be displayed in your web interface.

## Creating the notification

Artisan can, once again, do all the hard work for us with the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
php  
 
artisan 
 
  
 
make:notification 
 
  
 
NewChirp 
</p>
```

This will create a new notification at `app/Notifications/NewChirp.php` that is ready for us to customize.

Let's open the `NewChirp` class and allow it to accept the `Chirp` that was just created, and then customize the message to include the author's name and a snippet from the message:

app/Notifications/NewChirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><p> 
  
 
 
 
namespace 
 
 App\Notifications; 
</p><p> 
+ 
 
 
 
use 
 
 App\Models\ 
 
Chirp 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Bus\ 
 
Queueable 
 
; 
</p><p> 
+ 
 
 
 
use 
 
 Illuminate\Support\ 
 
Str 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Contracts\Queue\ 
 
ShouldQueue 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Notifications\Messages\ 
 
MailMessage 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Notifications\ 
 
Notification 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
NewChirp 
 
  
 
extends 
 
  
 
Notification 
</p><p> 
  
 
 
 
{ 
</p><p> 
  
 
 
 
     
 
use 
 
  
 
Queueable 
 
; 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Create a new notification instance. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
- 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
__construct 
 
() 
</p><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
__construct 
 
( 
 
public 
 
  
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Get the notification's delivery channels. 
</p><p> 
  
 
 
 
     * 
</p><p> 
  
 
 
 
     *  
 
@return 
 
  
 
array 
 
 < 
 
int 
 
, string> 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
via 
 
( 
 
object 
 
  
 
$notifiable 
 
) 
 
: 
 
  
 
array 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
 [ 
 
' 
 
mail 
 
' 
 
]; 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Get the mail representation of the notification. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
toMail 
 
( 
 
object 
 
  
 
$notifiable 
 
) 
 
: 
 
  
 
MailMessage 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
 ( 
 
new 
 
  
 
MailMessage 
 
) 
</p><p> 
- 
 
 
 
                     
 
-> 
 
line 
 
( 
 
' 
 
The introduction to the notification. 
 
' 
 
) 
</p><p> 
- 
 
 
 
                     
 
-> 
 
action 
 
( 
 
' 
 
Notification Action 
 
' 
 
,  
 
url 
 
( 
 
' 
 
/ 
 
' 
 
)) 
</p><p> 
+ 
 
 
 
                     
 
-> 
 
subject 
 
( 
 
" 
 
New Chirp from { 
 
$this 
 
->chirp->user->name 
 
} 
 
" 
 
) 
</p><p> 
+ 
 
 
 
                     
 
-> 
 
greeting 
 
( 
 
" 
 
New Chirp from { 
 
$this 
 
->chirp->user->name 
 
} 
 
" 
 
) 
</p><p> 
+ 
 
 
 
                     
 
-> 
 
line 
 
( 
 
Str 
 
:: 
 
limit 
 
( 
 
$this 
 
->chirp->message 
 
,  
 
50 
 
)) 
</p><p> 
+ 
 
 
 
                     
 
-> 
 
action 
 
( 
 
' 
 
Go to Chirper 
 
' 
 
,  
 
url 
 
( 
 
' 
 
/ 
 
' 
 
)) 
</p><p> 
  
 
 
 
                     
 
-> 
 
line 
 
( 
 
' 
 
Thank you for using our application! 
 
' 
 
); 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Get the array representation of the notification. 
</p><p> 
  
 
 
 
     * 
</p><p> 
  
 
 
 
     *  
 
@return 
 
  
 
array 
 
 < 
 
string 
 
, mixed> 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
toArray 
 
( 
 
object 
 
  
 
$notifiable 
 
) 
 
: 
 
  
 
array 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
 [ 
</p><p> 
  
 
 
 
             
 
// 
</p><p> 
  
 
 
 
        ]; 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
} 
</p>
```

We could send the notification directly from the `store` method on our `ChirpController` class, but that adds more work for the controller, which in turn can slow down the request, especially as we'll be querying the database and sending emails.

Instead, let's dispatch an event that we can listen for and process in a background queue to keep our application snappy.

## Creating an event

Events are a great way to decouple various aspects of your application, since a single event can have multiple listeners that do not depend on each other.

Let's create our new event with the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
php  
 
artisan 
 
  
 
make:event 
 
  
 
ChirpCreated 
</p>
```

This will create a new event class at `app/Events/ChirpCreated.php`.

Since we'll be dispatching events for each new Chirp that is created, let's update our `ChirpCreated` event to accept the newly created `Chirp` so we may pass it on to our notification:

app/Events/ChirpCreated.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><p> 
  
 
 
 
namespace 
 
 App\Events; 
</p><p> 
+ 
 
 
 
use 
 
 App\Models\ 
 
Chirp 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Broadcasting\ 
 
Channel 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Broadcasting\ 
 
InteractsWithSockets 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Broadcasting\ 
 
PresenceChannel 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Broadcasting\ 
 
PrivateChannel 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Contracts\Broadcasting\ 
 
ShouldBroadcast 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Foundation\Events\ 
 
Dispatchable 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Queue\ 
 
SerializesModels 
 
; 
</p><p> 
  
 
 
 
class 
 
  
 
ChirpCreated 
</p><p> 
  
 
 
 
{ 
</p><p> 
  
 
 
 
     
 
use 
 
  
 
Dispatchable 
 
,  
 
InteractsWithSockets 
 
,  
 
SerializesModels 
 
; 
</p><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Create a new event instance. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
- 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
__construct 
 
() 
</p><p> 
+ 
 
 
 
     
 
public 
 
  
 
function 
 
  
 
__construct 
 
( 
 
public 
 
  
 
Chirp 
 
  
 
$chirp 
 
) 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Get the channels the event should broadcast on. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
broadcastOn 
 
() 
 
: 
 
  
 
array 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
return 
 
 [ 
</p><p> 
  
 
 
 
             
 
new 
 
  
 
PrivateChannel 
 
( 
 
' 
 
channel-name 
 
' 
 
), 
</p><p> 
  
 
 
 
        ]; 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
} 
</p>
```

## Dispatching the event

Now that we have our event class, we're ready to dispatch it any time a Chirp is created. You may [dispatch events](https://web.archive.org/web/20240927152838/https://laravel.com/docs/events#dispatching-events) anywhere in your application lifecycle, but as our event relates to the creation of an Eloquent model, we can configure our `Chirp` model to dispatch the event for us.

app/Models/Chirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 <?php 
</p><p> 
  
 
namespace 
 
 App\Models; 
</p><p> 
+ 
 
use 
 
 App\Events\ 
 
ChirpCreated 
 
; 
</p><p> 
  
 
use 
 
 Illuminate\Database\Eloquent\Factories\ 
 
HasFactory 
 
; 
</p><p> 
  
 
use 
 
 Illuminate\Database\Eloquent\ 
 
Model 
 
; 
</p><p> 
  
 
use 
 
 Illuminate\Database\Eloquent\Relations\ 
 
BelongsTo 
 
; 
</p><p> 
  
 
class 
 
  
 
Chirp 
 
  
 
extends 
 
  
 
Model 
</p><p> 
  
 
{ 
</p><p> 
  
 
     
 
use 
 
  
 
HasFactory 
 
; 
</p><p> 
  
 
     
 
protected 
 
  
 
$fillable 
 
  
 
= 
 
 [ 
</p><p> 
  
 
         
 
' 
 
message 
 
' 
 
, 
</p><p> 
  
 
    ]; 
</p><p> 
+ 
 
     
 
protected 
 
  
 
$dispatchesEvents 
 
  
 
= 
 
 [ 
</p><p> 
+ 
 
         
 
' 
 
created 
 
' 
 
  
 
=> 
 
  
 
ChirpCreated 
 
:: 
 
class 
 
, 
</p><p> 
+ 
 
    ]; 
</p><p> 
  
 
     
 
public 
 
  
 
function 
 
  
 
user 
 
() 
 
: 
 
  
 
BelongsTo 
</p><p> 
  
 
    { 
</p><p> 
  
 
         
 
return 
 
  
 
$this 
 
-> 
 
belongsTo 
 
( 
 
User 
 
:: 
 
class 
 
); 
</p><p> 
  
 
    } 
</p><p> 
  
 
} 
</p>
```

Now any time a new `Chirp` is created, the `ChirpCreated` event will be dispatched.

## Creating an event listener

Now that we're dispatching an event, we're ready to listen for that event and send our notification.

Let's create a listener that subscribes to our `ChirpCreated` event:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
php artisan make:listener SendChirpCreatedNotifications --event=ChirpCreated 
</p>
```

The new listener will be placed at `app/Listeners/SendChirpCreatedNotifications.php`. Let's update the listener to send our notifications.

app/Listeners/SendChirpCreatedNotifications.php

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
 
 
 <?php 
</p><p> 
  
 
 
 
namespace 
 
 App\Listeners; 
</p><p> 
  
 
 
 
use 
 
 App\Events\ 
 
ChirpCreated 
 
; 
</p><p> 
+ 
 
 
 
use 
 
 App\Models\ 
 
User 
 
; 
</p><p> 
+ 
 
 
 
use 
 
 App\Notifications\ 
 
NewChirp 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Contracts\Queue\ 
 
ShouldQueue 
 
; 
</p><p> 
  
 
 
 
use 
 
 Illuminate\Queue\ 
 
InteractsWithQueue 
 
; 
</p><p> 
- 
 
 
 
class 
 
  
 
SendChirpCreatedNotifications 
</p><p> 
+ 
 
 
 
class SendChirpCreatedNotifications  
 
implements 
 
  
 
ShouldQueue 
</p><p> 
  
 
 
 
{ 
</p><details><summary><p> 
  
 
 
&nbsp; 
... 
</p></summary><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Create the event listener. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
__construct 
 
() 
</p><p> 
  
 
 
 
    { 
</p><p> 
  
 
 
 
         
 
// 
</p><p> 
  
 
 
 
    } 
</p></details><p> 
  
 
 
 
     
 
/** 
</p><p> 
  
 
 
 
     * Handle the event. 
</p><p> 
  
 
 
 
      
 
*/ 
</p><p> 
  
 
 
 
     
 
public 
 
  
 
function 
 
  
 
handle 
 
( 
 
ChirpCreated 
 
  
 
$event 
 
) 
 
: 
 
  
 
void 
</p><p> 
  
 
 
 
    { 
</p><p> 
- 
 
 
 
         
 
// 
</p><p> 
+ 
 
 
 
         
 
foreach 
 
 ( 
 
User 
 
:: 
 
whereNot 
 
( 
 
' 
 
id 
 
' 
 
,  
 
$event 
 
->chirp->user_id 
 
) 
 
-> 
 
cursor 
 
()  
 
as 
 
  
 
$user 
 
) { 
</p><p> 
+ 
 
 
 
             
 
$user 
 
-> 
 
notify 
 
( 
 
new 
 
  
 
NewChirp 
 
( 
 
$event 
 
->chirp 
 
)); 
</p><p> 
+ 
 
 
 
        } 
</p><p> 
  
 
 
 
    } 
</p><p> 
  
 
 
 
} 
</p>
```

We've marked our listener with the `ShouldQueue` interface, which tells Laravel that the listener should be run in a [queue](https://web.archive.org/web/20240927152838/https://laravel.com/docs/queues). By default, the "database" queue will be used to process jobs asynchronously. To begin processing queued jobs, you should run the `php artisan queue:work` Artisan command in your terminal.

We've also configured our listener to send notifications to every user in the platform, except the author of the Chirp. In reality, this might annoy users, so you may want to implement a "following" feature so users only receive notifications for accounts they follow.

We've used a [database cursor](https://web.archive.org/web/20240927152838/https://laravel.com/docs/eloquent#cursors) to avoid loading every user into memory at once.

## Testing it out

You may utilize local email testing tools like [Mailpit](https://web.archive.org/web/20240927152838/https://github.com/axllent/mailpit) and [HELO](https://web.archive.org/web/20240927152838/https://usehelo.com/) to catch any emails coming from your application so you may view them. If you are developing via Docker and Laravel Sail then Mailpit is included for you.

Alternatively, you may configure Laravel to write mail to a log file by editing the `.env` file in your project and changing the `MAIL_MAILER` environment variable to `log`. By default, emails will be written to a log file located at `storage/logs/laravel.log`.

We've configured our notification not to send to the Chirp author, so be sure to register at least two users accounts. Then, go ahead and post a new Chirp to trigger a notification.

If you're using Mailpit, navigate to [http://localhost:8025/](https://web.archive.org/web/20240927152838/http://localhost:8025/), where you will find the notification for the message you just chirped!

![Mailpit](Laravel%20Bootcamp/mailpit.png)

### Sending emails in production

To send real emails in production, you will need an SMTP server, or a transactional email provider, such as Mailgun, Postmark, or Amazon SES. Laravel supports all of these out of the box. For more information, take a look at the [Mail documentation](https://web.archive.org/web/20240927152838/https://laravel.com/docs/mail#introduction).

[Continue to learn about deploying your application...](https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/deploying)
