---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags:
  - SaaS
  - APIs
  - Back-End
date created: 03 July 2024
created: 2024-09-20T11:17
updated: 2025-08-26T14:39
---


# INCOMPLETE

**Code has issues**

# Laravel Bootcamp: Part 6

## Software as a Service - Front-End Development

Developed by Adrian Gould

---

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 3
includeLinks: true
```

---

# Laravel Bootcamp: Part 6

This set of notes is based on a conversation with Claude.AI.

The subject is an extension to the previous step where notifications were sent for every new Chirp.

This set of notes looks at sending batches that summarise notifications. 

The rules for this new feature are:

1) A notification should be sent for every 10 new chirps that are sent by any user
2) A notification should be sent at 11:50PM containing any remaining new Chirps for the day, and a new batch started.

This is OPTIONAL, as there are a number of techniques that are more advanced than what is covered so far.



## Before you start…

Have you completed (not just read):

- [Laravel v12 Bootcamp - Introducing Laravel](S11-Laravel-v12-Bootcamp-Part-00-Introducing-Laravel.md),
- [Laravel v12 Bootcamp - Part 1](S11-Laravel-v12-BootCamp-Part-01.md),
- [Laravel v12 Bootcamp - Part 2](S11-Laravel-v12-BootCamp-Part-02.md)
- [Laravel v12 Bootcamp - Part 3](S11-Laravel-v12-BootCamp-Part-03.md)
- [Laravel v12 Bootcamp - Part 4](S11-Laravel-v12-BootCamp-Part-04.md)
- [Laravel v12 Bootcamp - Part 5](S11-Laravel-v12-BootCamp-Part-05.md)

No? Well… go do it…

You will need these to be able to continue…

> **Important:** You should understand that whilst you are completing this tutorial, you will
> only see parts of the application working when a stage is complete.
>
> So if you get an error in the browser, it may be because there is something missing.

## Batching Notifications

Currently, your system sends individual notifications for each new chirp to all users (except the chirp creator) through the SendChirpCreatedNotifications listener which is triggered by the ChirpCreated event.
To implement batch notifications, we'll need to:

- Create a new notification class for batch notifications
- Implement a mechanism to collect chirps and trigger batch notifications when reaching 10 chirps
- Set up a scheduled task to send remaining chirps at 11:50 PM daily


### How it works:

1) When a user creates a new chirp, the ChirpCreated event is dispatched
2) The SendChirpCreatedNotifications listener adds the chirp to the batch via the ChirpBatchService
3) The batch service accumulates chirps in the cache
4) When the batch reaches 10 chirps, a notification is sent to all users (except those who authored chirps in the batch)
5) At 11:50 PM, the scheduled command runs and sends any remaining chirps for the day

### Create the Chirp Batch Notification

A new notification class that handles sending digest emails containing multiple chirps

Create the class using:

```shell
php artisan make:notification ChirpBatchNotification

```



### Create the Chirp Batch Service

- Manages the batching of chirps using Laravel's cache
- Adds chirps to the current batch
- Sends notifications when reaching 10 chirps
- Provides a method to send end-of-day notifications


Create the class using:

```shell
php artisan make:class Services/ChirpBatchService

```

### Update Send Chirp Created Notifications

Updated to use the batch service instead of sending individual notifications




### Create the Chirp Daily Digest

A command that can be scheduled to send the remaining chirps at the end of the day


Create the class using:

```shell
php artisan make:command SendDailyChirpDigest

```


### Updates for the Kernel and Service Providers

Schedules the daily digest command to run at 11:50 PM each day


Create the class using:

```shell
php artisan make:provider ChirpServiceProvider

```

Registers the batch service as a singleton in the application container










# References

- Laravel Bootcamp - Learn the PHP Framework for Web Artisans - 07 Notifications & Events. (
  2025).
  Archive.org. https://web.archive.org/web/20240927152838/https://bootcamp.laravel.com/blade/notifications-and-events

# Up Next

- [Laravel v12 Bootcamp - Part 6](S11-Laravel-v12-BootCamp-Part-06.md)
- [Session 11 ReadMe](../session-10/ReadMe.md)
- [Session 11 Reflection Exercises & Study](../session-11/S11-Reflection-Exercises-and-Study.md)

# END
