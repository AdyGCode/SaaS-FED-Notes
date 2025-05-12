---
created: 2025-04-29T17:34:37 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20240926224511/https://bootcamp.laravel.com/livewire/notifications-and-events
author: 
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **07.** Notifications & Events

Let's take Chirper to the next level by sending [email notifications](https://web.archive.org/web/20240926224511/https://laravel.com/docs/notifications#introduction) when a new Chirp is created.

In addition to support for sending email, Laravel provides support for sending notifications across a variety of delivery channels, including email, SMS, and Slack. Plus, a variety of community built notification channels have been created to send notification over dozens of different channels! Notifications may also be stored in a database so they may be displayed in your web interface.

## Creating the notification

Artisan can, once again, do all the hard work for us with the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>php </span><span>artisan</span><span> </span><span>make:notification</span><span> </span><span>NewChirp</span></p>
```

This will create a new notification at `app/Notifications/NewChirp.php` that is ready for us to customize.

Let's open the `NewChirp` class and allow it to accept the `Chirp` that was just created, and then customize the message to include the author's name and a snippet from the message:

app/Notifications/NewChirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p><span> </span><span></span><span>&lt;?php</span></p><p><span> </span><span></span><span>namespace</span><span> App\Notifications;</span></p><p><span>+</span><span></span><span>use</span><span> App\Models\</span><span>Chirp</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Bus\</span><span>Queueable</span><span>;</span></p><p><span>+</span><span></span><span>use</span><span> Illuminate\Support\</span><span>Str</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Contracts\Queue\</span><span>ShouldQueue</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Notifications\Messages\</span><span>MailMessage</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Notifications\</span><span>Notification</span><span>;</span></p><p><span> </span><span></span><span>class</span><span> </span><span>NewChirp</span><span> </span><span>extends</span><span> </span><span>Notification</span></p><p><span> </span><span></span><span>{</span></p><p><span> </span><span></span><span>    </span><span>use</span><span> </span><span>Queueable</span><span>;</span></p><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Create a new notification instance.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span>-</span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>__construct</span><span>()</span></p><p><span>+</span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>__construct</span><span>(</span><span>public</span><span> </span><span>Chirp</span><span> </span><span>$chirp</span><span>)</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>//</span></p><p><span> </span><span></span><span>    }</span></p><details><summary><p><span> </span><span></span>&nbsp;<span>...</span></p></summary><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Get the notification's delivery channels.</span></p><p><span> </span><span></span><span>     *</span></p><p><span> </span><span></span><span>     * </span><span>@return</span><span> </span><span>array</span><span>&lt;</span><span>int</span><span>, string&gt;</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>via</span><span>(</span><span>object</span><span> </span><span>$notifiable</span><span>)</span><span>:</span><span> </span><span>array</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>return</span><span> [</span><span>'</span><span>mail</span><span>'</span><span>];</span></p><p><span> </span><span></span><span>    }</span></p></details><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Get the mail representation of the notification.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>toMail</span><span>(</span><span>object</span><span> </span><span>$notifiable</span><span>)</span><span>:</span><span> </span><span>MailMessage</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>return</span><span> (</span><span>new</span><span> </span><span>MailMessage</span><span>)</span></p><p><span>-</span><span></span><span>                    </span><span>-&gt;</span><span>line</span><span>(</span><span>'</span><span>The introduction to the notification.</span><span>'</span><span>)</span></p><p><span>-</span><span></span><span>                    </span><span>-&gt;</span><span>action</span><span>(</span><span>'</span><span>Notification Action</span><span>'</span><span>, </span><span>url</span><span>(</span><span>'</span><span>/</span><span>'</span><span>))</span></p><p><span>+</span><span></span><span>                    </span><span>-&gt;</span><span>subject</span><span>(</span><span>"</span><span>New Chirp from {</span><span>$this</span><span>-&gt;chirp-&gt;user-&gt;name</span><span>}</span><span>"</span><span>)</span></p><p><span>+</span><span></span><span>                    </span><span>-&gt;</span><span>greeting</span><span>(</span><span>"</span><span>New Chirp from {</span><span>$this</span><span>-&gt;chirp-&gt;user-&gt;name</span><span>}</span><span>"</span><span>)</span></p><p><span>+</span><span></span><span>                    </span><span>-&gt;</span><span>line</span><span>(</span><span>Str</span><span>::</span><span>limit</span><span>(</span><span>$this</span><span>-&gt;chirp-&gt;message</span><span>, </span><span>50</span><span>))</span></p><p><span>+</span><span></span><span>                    </span><span>-&gt;</span><span>action</span><span>(</span><span>'</span><span>Go to Chirper</span><span>'</span><span>, </span><span>url</span><span>(</span><span>'</span><span>/</span><span>'</span><span>))</span></p><p><span> </span><span></span><span>                    </span><span>-&gt;</span><span>line</span><span>(</span><span>'</span><span>Thank you for using our application!</span><span>'</span><span>);</span></p><p><span> </span><span></span><span>    }</span></p><details><summary><p><span> </span><span></span>&nbsp;<span>...</span></p></summary><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Get the array representation of the notification.</span></p><p><span> </span><span></span><span>     *</span></p><p><span> </span><span></span><span>     * </span><span>@return</span><span> </span><span>array</span><span>&lt;</span><span>string</span><span>, mixed&gt;</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>toArray</span><span>(</span><span>object</span><span> </span><span>$notifiable</span><span>)</span><span>:</span><span> </span><span>array</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>return</span><span> [</span></p><p><span> </span><span></span><span>            </span><span>//</span></p><p><span> </span><span></span><span>        ];</span></p><p><span> </span><span></span><span>    }</span></p></details><p><span> </span><span></span><span>}</span></p>
```

We could send the notification directly from the `store` method on our `ChirpController` class, but that adds more work for the controller, which in turn can slow down the request, especially as we'll be querying the database and sending emails.

Instead, let's dispatch an event that we can listen for and process in a background queue to keep our application snappy.

## Creating an event

Events are a great way to decouple various aspects of your application, since a single event can have multiple listeners that do not depend on each other.

Let's create our new event with the following command:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>php </span><span>artisan</span><span> </span><span>make:event</span><span> </span><span>ChirpCreated</span></p>
```

This will create a new event class at `app/Events/ChirpCreated.php`.

Since we'll be dispatching events for each new Chirp that is created, let's update our `ChirpCreated` event to accept the newly created `Chirp` so we may pass it on to our notification:

app/Events/ChirpCreated.php

```
<!-- Syntax highlighted by torchlight.dev --><p><span> </span><span></span><span>&lt;?php</span></p><p><span> </span><span></span><span>namespace</span><span> App\Events;</span></p><p><span>+</span><span></span><span>use</span><span> App\Models\</span><span>Chirp</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Broadcasting\</span><span>Channel</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Broadcasting\</span><span>InteractsWithSockets</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Broadcasting\</span><span>PresenceChannel</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Broadcasting\</span><span>PrivateChannel</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Contracts\Broadcasting\</span><span>ShouldBroadcast</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Foundation\Events\</span><span>Dispatchable</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Queue\</span><span>SerializesModels</span><span>;</span></p><p><span> </span><span></span><span>class</span><span> </span><span>ChirpCreated</span></p><p><span> </span><span></span><span>{</span></p><p><span> </span><span></span><span>    </span><span>use</span><span> </span><span>Dispatchable</span><span>, </span><span>InteractsWithSockets</span><span>, </span><span>SerializesModels</span><span>;</span></p><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Create a new event instance.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span>-</span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>__construct</span><span>()</span></p><p><span>+</span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>__construct</span><span>(</span><span>public</span><span> </span><span>Chirp</span><span> </span><span>$chirp</span><span>)</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>//</span></p><p><span> </span><span></span><span>    }</span></p><details><summary><p><span> </span><span></span>&nbsp;<span>...</span></p></summary><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Get the channels the event should broadcast on.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>broadcastOn</span><span>()</span><span>:</span><span> </span><span>array</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>return</span><span> [</span></p><p><span> </span><span></span><span>            </span><span>new</span><span> </span><span>PrivateChannel</span><span>(</span><span>'</span><span>channel-name</span><span>'</span><span>),</span></p><p><span> </span><span></span><span>        ];</span></p><p><span> </span><span></span><span>    }</span></p></details><p><span> </span><span></span><span>}</span></p>
```

## Dispatching the event

Now that we have our event class, we're ready to dispatch it any time a Chirp is created. You may [dispatch events](https://web.archive.org/web/20240926224511/https://laravel.com/docs/events#dispatching-events) anywhere in your application lifecycle, but as our event relates to the creation of an Eloquent model, we can configure our `Chirp` model to dispatch the event for us.

app/Models/Chirp.php

```
<!-- Syntax highlighted by torchlight.dev --><p><span> </span><span>&lt;?php</span></p><p><span> </span><span>namespace</span><span> App\Models;</span></p><p><span>+</span><span>use</span><span> App\Events\</span><span>ChirpCreated</span><span>;</span></p><p><span> </span><span>use</span><span> Illuminate\Database\Eloquent\Factories\</span><span>HasFactory</span><span>;</span></p><p><span> </span><span>use</span><span> Illuminate\Database\Eloquent\</span><span>Model</span><span>;</span></p><p><span> </span><span>use</span><span> Illuminate\Database\Eloquent\Relations\</span><span>BelongsTo</span><span>;</span></p><p><span> </span><span>class</span><span> </span><span>Chirp</span><span> </span><span>extends</span><span> </span><span>Model</span></p><p><span> </span><span>{</span></p><p><span> </span><span>    </span><span>use</span><span> </span><span>HasFactory</span><span>;</span></p><p><span> </span><span>    </span><span>protected</span><span> </span><span>$fillable</span><span> </span><span>=</span><span> [</span></p><p><span> </span><span>        </span><span>'</span><span>message</span><span>'</span><span>,</span></p><p><span> </span><span>    ];</span></p><p><span>+</span><span>    </span><span>protected</span><span> </span><span>$dispatchesEvents</span><span> </span><span>=</span><span> [</span></p><p><span>+</span><span>        </span><span>'</span><span>created</span><span>'</span><span> </span><span>=&gt;</span><span> </span><span>ChirpCreated</span><span>::</span><span>class</span><span>,</span></p><p><span>+</span><span>    ];</span></p><p><span> </span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>user</span><span>()</span><span>:</span><span> </span><span>BelongsTo</span></p><p><span> </span><span>    {</span></p><p><span> </span><span>        </span><span>return</span><span> </span><span>$this</span><span>-&gt;</span><span>belongsTo</span><span>(</span><span>User</span><span>::</span><span>class</span><span>);</span></p><p><span> </span><span>    }</span></p><p><span> </span><span>}</span></p>
```

Now any time a new `Chirp` is created, the `ChirpCreated` event will be dispatched.

## Creating an event listener

Now that we're dispatching an event, we're ready to listen for that event and send our notification.

Let's create a listener that subscribes to our `ChirpCreated` event:

```
<!-- Syntax highlighted by torchlight.dev --><p><span>php artisan make:listener SendChirpCreatedNotifications --event=ChirpCreated</span></p>
```

The new listener will be placed at `app/Listeners/SendChirpCreatedNotifications.php`. Let's update the listener to send our notifications.

app/Listeners/SendChirpCreatedNotifications.php

```
<!-- Syntax highlighted by torchlight.dev --><p><span> </span><span></span><span>&lt;?php</span></p><p><span> </span><span></span><span>namespace</span><span> App\Listeners;</span></p><p><span> </span><span></span><span>use</span><span> App\Events\</span><span>ChirpCreated</span><span>;</span></p><p><span>+</span><span></span><span>use</span><span> App\Models\</span><span>User</span><span>;</span></p><p><span>+</span><span></span><span>use</span><span> App\Notifications\</span><span>NewChirp</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Contracts\Queue\</span><span>ShouldQueue</span><span>;</span></p><p><span> </span><span></span><span>use</span><span> Illuminate\Queue\</span><span>InteractsWithQueue</span><span>;</span></p><p><span>-</span><span></span><span>class</span><span> </span><span>SendChirpCreatedNotifications</span></p><p><span>+</span><span></span><span>class SendChirpCreatedNotifications </span><span>implements</span><span> </span><span>ShouldQueue</span></p><p><span> </span><span></span><span>{</span></p><details><summary><p><span> </span><span></span>&nbsp;<span>...</span></p></summary><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Create the event listener.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>__construct</span><span>()</span></p><p><span> </span><span></span><span>    {</span></p><p><span> </span><span></span><span>        </span><span>//</span></p><p><span> </span><span></span><span>    }</span></p></details><p><span> </span><span></span><span>    </span><span>/**</span></p><p><span> </span><span></span><span>     * Handle the event.</span></p><p><span> </span><span></span><span>     </span><span>*/</span></p><p><span> </span><span></span><span>    </span><span>public</span><span> </span><span>function</span><span> </span><span>handle</span><span>(</span><span>ChirpCreated</span><span> </span><span>$event</span><span>)</span><span>:</span><span> </span><span>void</span></p><p><span> </span><span></span><span>    {</span></p><p><span>-</span><span></span><span>        </span><span>//</span></p><p><span>+</span><span></span><span>        </span><span>foreach</span><span> (</span><span>User</span><span>::</span><span>whereNot</span><span>(</span><span>'</span><span>id</span><span>'</span><span>, </span><span>$event</span><span>-&gt;chirp-&gt;user_id</span><span>)</span><span>-&gt;</span><span>cursor</span><span>() </span><span>as</span><span> </span><span>$user</span><span>) {</span></p><p><span>+</span><span></span><span>            </span><span>$user</span><span>-&gt;</span><span>notify</span><span>(</span><span>new</span><span> </span><span>NewChirp</span><span>(</span><span>$event</span><span>-&gt;chirp</span><span>));</span></p><p><span>+</span><span></span><span>        }</span></p><p><span> </span><span></span><span>    }</span></p><p><span> </span><span></span><span>}</span></p>
```

We've marked our listener with the `ShouldQueue` interface, which tells Laravel that the listener should be run in a [queue](https://web.archive.org/web/20240926224511/https://laravel.com/docs/queues). By default, the "database" queue will be used to process jobs asynchronously. To begin processing queued jobs, you should run the `php artisan queue:work` Artisan command in your terminal.

We've also configured our listener to send notifications to every user in the platform, except the author of the Chirp. In reality, this might annoy users, so you may want to implement a "following" feature so users only receive notifications for accounts they follow.

We've used a [database cursor](https://web.archive.org/web/20240926224511/https://laravel.com/docs/eloquent#cursors) to avoid loading every user into memory at once.

## Testing it out

You may utilize local email testing tools like [Mailpit](https://web.archive.org/web/20240926224511/https://github.com/axllent/mailpit) and [HELO](https://web.archive.org/web/20240926224511/https://usehelo.com/) to catch any emails coming from your application so you may view them. If you are developing via Docker and Laravel Sail then Mailpit is included for you.

Alternatively, you may configure Laravel to write mail to a log file by editing the `.env` file in your project and changing the `MAIL_MAILER` environment variable to `log`. By default, emails will be written to a log file located at `storage/logs/laravel.log`.

We've configured our notification not to send to the Chirp author, so be sure to register at least two users accounts. Then, go ahead and post a new Chirp to trigger a notification.

If you're using Mailpit, navigate to [http://localhost:8025/](https://web.archive.org/web/20240926224511/http://localhost:8025/), where you will find the notification for the message you just chirped!

![Mailpit](Laravel%20Bootcamp/mailpit.png)

### Sending emails in production

To send real emails in production, you will need an SMTP server, or a transactional email provider, such as Mailgun, Postmark, or Amazon SES. Laravel supports all of these out of the box. For more information, take a look at the [Mail documentation](https://web.archive.org/web/20240926224511/https://laravel.com/docs/mail#introduction).

[Continue to learn about deploying your application...](https://web.archive.org/web/20240926224511/https://bootcamp.laravel.com/deploying)
