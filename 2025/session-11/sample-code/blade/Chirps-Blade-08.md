---
created: 2025-04-29T17:28:12 (UTC +08:00)
tags: []
source: https://web.archive.org/web/20240927001916/https://bootcamp.laravel.com/deploying
author: 
updated: 2025-05-01T11:53
---

# Laravel Bootcamp

> ## Excerpt
> Together let's walk through building and deploying a modern Laravel application from scratch.

---
## **08.** Deploying

Let's switch gears and look at how we can deploy our new Laravel application.

## Choosing a provider

Laravel can be deployed to any modern PHP hosting environment that meets Laravel's modest [server requirements](https://web.archive.org/web/20240927001916/https://laravel.com/docs/deployment#server-requirements). However, configuring and managing a web server and database server takes our attention away from building applications and delivering value to our users. That's why we built [Laravel Forge](https://web.archive.org/web/20240927001916/https://forge.laravel.com/?ref=bootcamp.laravel.com) and [Laravel Vapor](https://web.archive.org/web/20240927001916/https://vapor.laravel.com/?ref=bootcamp.laravel.com).

#### Laravel Forge

Laravel Forge can create servers on various infrastructure providers such as DigitalOcean, Linode, AWS, and more. In addition, Forge installs and manages all of the tools needed to build robust Laravel applications, such as Nginx, MySQL, Redis, Memcached, Beanstalk, and more.

#### Laravel Vapor

Laravel Vapor is a serverless deployment platform for Laravel, powered by AWS. Launch your Laravel infrastructure on Vapor and fall in love with the scalable simplicity of serverless.

Both are fantastic options, but today we're going with Forge for its simplicity, choice of providers, and for being budget-friendly on smaller applications. You can always move to Vapor later if you want the scalability of serverless.

Sign up for your free trial with [Laravel Forge](https://web.archive.org/web/20240927001916/https://forge.laravel.com/?ref=bootcamp.laravel.com) and then pick your server provider:

-   [DigitalOcean](https://web.archive.org/web/20240927001916/https://try.digitalocean.com/freetrialoffer/) <small>($100 free credit available)</small>
-   [Linode](https://web.archive.org/web/20240927001916/https://www.linode.com/) <small>($50 free credit available)</small>
-   [AWS](https://web.archive.org/web/20240927001916/https://aws.amazon.com/free/) <small>(free tier available)</small>
-   [Vultr](https://web.archive.org/web/20240927001916/https://www.vultr.com/promo/try50/) <small>($50 free credit available)</small>
-   [Hetzner](https://web.archive.org/web/20240927001916/https://www.hetzner.com/)
-   Custom VPS server

If you're not sure who to pick, we recommend [DigitalOcean](https://web.archive.org/web/20240927001916/https://try.digitalocean.com/freetrialoffer/) for their generous credit, great user interface, and excellent features.

## Connecting to source control

Forge needs to know where to find your application's code, so you'll need an account with a source control provider, such as [GitHub](https://web.archive.org/web/20240927001916/https://github.com/), [GitLab](https://web.archive.org/web/20240927001916/https://gitlab.com/), or [Bitbucket](https://web.archive.org/web/20240927001916/https://bitbucket.com/).

You may then connect Forge to your provider by selecting it on Forge's welcome screen, or by visiting the _Source Control_ section of your Forge account.

![Source control screenshot](Laravel%20Bootcamp/forge-source-control.png)

## Connecting to your server provider

Forge will need the API key for your server provider so that it can build your servers. You can connect to your server provider on the Forge welcome screen, or by visiting the _Server Providers_ section of your Forge account.

![Server providers screenshot](Laravel%20Bootcamp/forge-server-providers.png)

Follow the instructions to create API credentials for Forge with your selected provider, and then enter the details to continue.

## Creating a server

Now that Forge is connected to your source control and server providers, we're ready to create our first server!

From the _Servers_ page, click the _Create Server_ button.

Next, select your server provider. You'll be presented with several options depending on your provider. The default options will be perfect for deploying Chirper, but we recommend reviewing all of the available options for your chosen provider to ensure everything matches your requirements and budget.

![Create server screenshot](Laravel%20Bootcamp/forge-create-server.png)

Creating a server takes about 10 minutes, depending on your provider and the options selected.

## Creating a site (optional)

Forge will automatically create a "default" site on your new server. This is perfect for deploying our application because we can visit it using the server's public IP address instead of purchasing a domain name.

If you would like to use a domain name then we recommend visiting the _Sites_ tab of your server to delete the "default" site and create a new site. You may create as many sites as you need. You'll also have the option to create a database for your new site.

![New site screenshot](Laravel%20Bootcamp/forge-new-site.png)

Select your site, and then click on its name in the heading to visit your site and see Forge's default site page.

## Creating a database

If you're using the "default" site, you will need to create a database for your application. You may create databases on the _Database_ tab of your server.

![Add database screenshot](Laravel%20Bootcamp/forge-add-database.png)

You may leave the username and password fields empty to use the credentials generated by Forge when building your server.

## Installing a repository

We're ready to install a source control repository on our new site. If you haven't already, make sure to create a git repository for your application and push the source code up to the source control provider that you connected to Forge earlier.

Choose your site from the _Sites_ tab of your server and then click _Git Repository_. Enter your repository name (e.g. `taylorotwell/chirper`) and select your branch. Be sure that "Install Composer Dependencies" is checked, and then install your repository to continue.

![Install repository screenshot](Laravel%20Bootcamp/forge-install-repository.png)

## Configuring your environment file

When installing your repository, Forge will copy the `.env.example` environment file from your repository. You may review your environment configuration file from the _Edit Files_ menu of your site.

![Site environment screenshot](Laravel%20Bootcamp/forge-site-environment.png)

You should carefully review all of the values to ensure everything is configured correctly for your production environment.

Ensure that the `DB_*` values match the database you created earlier. If you created a dedicated database username and password, be sure to configure those as well.

If you would like to send emails from your application, you will need to review the `MAIL_*` values and add any additional variables that may be required for your chosen [mail provider](https://web.archive.org/web/20240927001916/https://laravel.com/docs/mail#configuration).

If you would like to run a queue worker, ensure that the `QUEUE_CONNECTION` value matches your desired queue connection and that you have installed and configured any [prerequisites](https://web.archive.org/web/20240927001916/https://laravel.com/docs/queues#driver-prerequisites).

## Configuring your deploy script

On the _App_ tab for your site, you may review the deploy script that Forge created for you.

![Deploy script screenshot](Laravel%20Bootcamp/forge-deploy-script.png)

Our application is using Node dependencies and Vite, so we'll need to add steps to install the dependencies and build our assets:

```
<!-- Syntax highlighted by torchlight.dev --><p> 
  
 
cd /home/forge/default 
</p><p> 
  
 
git pull origin $FORGE_SITE_BRANCH 
</p><p> 
  
 
$FORGE_COMPOSER install --no-interaction --prefer-dist --optimize-autoloader 
</p><p> 
+ 
 
npm ci 
</p><p> 
+ 
 
npm run build 
</p><p> 
  
 
( flock -w 10 9 || exit 1 
</p><p> 
  
 
    echo 'Restarting FPM...'; sudo -S service $FORGE_PHP_FPM reload ) 9>/tmp/fpmlock 
</p><p> 
  
 
if [ -f artisan ]; then 
</p><p> 
  
 
    $FORGE_PHP artisan migrate --force 
</p><p> 
  
 
fi 
</p>
```

## Running a queue worker (optional)

If you've chosen to configure a [queue worker](https://web.archive.org/web/20240927001916/https://laravel.com/docs/queues), you may now instruct Forge to start and manage the worker on the _Queue_ tab of your site.

![New worker screenshot](Laravel%20Bootcamp/forge-new-worker.png)

## Running a task scheduler (optional)

If you've chosen to use Laravel's [task scheduling](https://web.archive.org/web/20240927001916/https://laravel.com/docs/scheduling), you may configure Forge to run the scheduler on the _Scheduler_ tab of your server. You will need to set the frequency to "every minute" so that the scheduler will check for due tasks on any schedule you may configure.

![New scheduled job screenshot](Laravel%20Bootcamp/forge-new-scheduled-job.png)

## Deploying

We're ready to deploy our application for the first time! Press the _Deploy Now_ button, and then sit back while Forge runs your deploy script.

You may review your deployment history on the _Deployments_ tab.

Once complete, visit your site again to confirm everything has deployed successfully.

[Continue to conclusion and next steps...](https://web.archive.org/web/20240927001916/https://bootcamp.laravel.com/conclusion)
