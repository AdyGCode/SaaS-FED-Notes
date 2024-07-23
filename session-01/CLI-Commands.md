---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, APIs, Back-End

date created: 03 July 2024
date modified: 07 July 2024
---

# The CLI

Many people will not be familiar with the CLI, or Command Line Interface.

This is a disadvantage to any developer, be they a web, software or other area of IT.

We recommend becoming familiar with some of the basic commands, and some extra commands.

## Getting ready for a CLI

Before starting there are two ways to make sure you have a suitable CLI.

### Installations
#### Windows Users
1. Install Git from the https://git-scm.com and use the `git/bin/bash.exe` file for the command prompt
2. Install Laragon and use the `Laragon\bin\gity\bin\bash.exe` file as the command prompt
#### Mac Users

You will have either `z-shell` or `bash` installed by default
#### Linux Users

In most cases you will have `bash` installed by default.
## Terminals

We recommend different applications depending on the operating system.

| Windows                                                                                                                                                                                                                                                                                                                                                                                               | MacOS                                                 | Linux                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------------------------------- |
| Microsoft Terminal                                                                                                                                                                                                                                                                                                                                                                                    | iTerm2 or Warp                                        | Built in terminal depends on Linux "flavour"<br>Alternatives include Warp |
| [MS Store Link](https://www.bing.com/ck/a?!&&p=07e2c938d4768fc0JmltdHM9MTcyMTYwNjQwMCZpZ3VpZD0wZGFlNjE2OS0zZmQzLTY0ZjgtMjlkYS03NWZkM2VlYTY1OTYmaW5zaWQ9NTU0Ng&ptn=3&ver=2&hsh=3&fclid=0dae6169-3fd3-64f8-29da-75fd3eea6596&psq=micosoft+t5erminal&u=a1aHR0cHM6Ly9hcHBzLm1pY3Jvc29mdC5jb20vZGV0YWlsLzlOMERYMjBISzcwMT9sYXVuY2g9dHJ1ZSZtb2RlPWZ1bGwmaGw9ZW4tYXUmZ2w9YXUmb2NpZD1iaW5nd2Vic2VhcmNo&ntb=1) | [iTerm2 Downloads](https://iterm2.com/downloads.html) |                                                                           |
| [GitHub Link](https://github.com/microsoft/terminal/releases/latest)                                                                                                                                                                                                                                                                                                                                  | [Warp website](https://www.warp.dev/)                 | [Warp website](https://www.warp.dev/)                                     |

It is possible also to use Bash from within the JetBrains' IDEs.
# Useful Commands
 
The table below shows some useful commands that you may want to use during your diploma studies, both for SaaS and for other clusters.

| command                                                   | action                                                                                                                                                                                                                                       |
| :-------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `pwd`                                                     | Print Working Directory shows the current foloder address in the form `/VOLUME/LOCATION`, for example: `/C/Users/Fred/`                                                                                                                      |
| `ls`                                                      | List files (files and folders with no extra details)                                                                                                                                                                                         |
| `ls -l`                                                   | List files in long format (one line per file, extra details)                                                                                                                                                                                 |
| `ls -la`                                                  | List all files in long format including hidden (dot) files.                                                                                                                                                                                  |
| `cd .`                                                    | Change into the current folder.                                                                                                                                                                                                              |
| `cd ~`                                                    | Change into your "home" folder.<br>NB, always check the folder location using `pwd` afterwards as network systems may store your profile on a server.                                                                                        |
| `cd ..`                                                   | move your locate into the folder above (parent)                                                                                                                                                                                              |
| `cd FOLDER_NAME`                                          | Change into the (child) folder named FOLDER_NAME                                                                                                                                                                                             |
| `cd ~/Source/Repos`                                       | Change into the Source Repos folder inside the current user's home folder.                                                                                                                                                                   |
| `mkdir FOLDER_NAME`                                       | Create a new folder/directory `FOLDER_NAME` within the current folder                                                                                                                                                                        |
| `rmdir FOLDER_NAME`                                       | Remove the empty folder `FOLDER_NAME`<br>**IMPORTANT: There is NO undo in bash**                                                                                                                                                             |
| `mkdir -p FOLDER_NAME/SUB_FOLDER`                         |                                                                                                                                                                                                                                              |
| `mkdir -p FOLDER_NAME/{SUB_FOLDER_1,SUB_FOLDER_2}`        | Create a new folder `FOLDERR_NAME` and then two folders within it called `SUB_FOLDER_1` and `SUB_FOLDER_2`.                                                                                                                                  |
| `touch FILE_NAME`                                         | Create a new empty file called `FILE_NAME`, or if it exists, update the last accessed time to the current date and time.<br>**IMPORTANT: Files need to have their extension added, and any file with . at the front is "hidden" by default** |
| `touch FOLDER_NAME\{FILE_1,FILE_2,FILE3}`                 | As before, but for multiple files within the folder `FOLDER_NAME`.                                                                                                                                                                           |
| `rm -Rf FOLDER_NAME`                                      | Remove all files and folders and the named folder `FOLDER-NAME`<br>**IMPORTANT: There is NO undo in bash... Only do this when you are certain**                                                                                              |
| `mkdir -P database/data`                                  | Create a folder called `database` with a folder called `data` within it                                                                                                                                                                      |
| `cp FILE_NAME NEW_FILE_NAME`                              | Copy the file `FILE_NAME` into a new copy called `NEW_FILE_NAME`                                                                                                                                                                             |
| `cp FILE_NAME NEW_FOLDER_LOCATION`                        | Copy the file `FILE_NAME` into the folder `NEW_FOLDER_LOCATION`                                                                                                                                                                              |
| `cp FOLDER_NAME NEW_FOLDER_NAME`                          | As before, but a folder                                                                                                                                                                                                                      |
| `mv FILE_NAME NEW_FILE_NAME`                              | Rename the file `FILE_NAME` to `NEW_FILE_NAME`<br>Also applies to folders                                                                                                                                                                    |
| `mv FILE_NAME FOLDER_NAME`                                | Move the file `FILE_NAME` into the folder `FOLDER_NAME`                                                                                                                                                                                      |
|                                                           |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
| `history`                                                 | Shows the commands you have used                                                                                                                                                                                                             |
| `history \| tail`                                         | Shows the last ten commands<br>**Note: the \ is not needed, it is due to Markdown using \| to separate columns in tables**                                                                                                                   |
| `history \| grep XXX`                                     | As above, but also filter the history to show only the commands containing `XXX`                                                                                                                                                             |
| `composer global require laravel/installer`               | Install or update the `laravel new` command                                                                                                                                                                                                  |
| `php -v`                                                  | Display the current version of PHP that is in the system path                                                                                                                                                                                |
| `node -v`                                                 | Display the version of Node that is being used                                                                                                                                                                                               |
| `npm -v`                                                  | Display the version of NPM being used.                                                                                                                                                                                                       |
| `composer -V`                                             | Display the version of Composer being used (**Note: capital V)**                                                                                                                                                                             |
|                                                           |                                                                                                                                                                                                                                              |
| `laravel new`                                             | Interactive command that starts a new Laravel application. The name you give it will be the name of the folder created.                                                                                                                      |
| `laravel new APP_NAME`                                    | as above but creates the folder `APP_NAME`. We seriously suggest using the previous command as it provides better overall control.                                                                                                           |
| `php artisan make:model ModelName`                        | Creates a new model called `ModelName` in the Laravel application. Models MUST be named using Pascal Case and Must be the Singular version of the word. For example `Region` whereas the table created in the migration will be `regions`.   |
| `php artisan make:migration create_pluralised_model_name` | Used to create the table migration for the model.<br><br>For example, `create_regions` would be used for the `Region` model.<br>                                                                                                             |
| `php artisan make:migration update_tablename`             | As before, but for updating a model's table.<br><br>When adding or removing fields from a model, name the migrations with `update`.                                                                                                          |
| `php artisan migrate:fresh`                               | Recreate the database structure, by first dropping all existing tables and then creating them again.                                                                                                                                         |
| `php artisan migrate:fresh --seed`                        | As above, but also run all the seed classes executed within the `DatabaseSeeder` class.                                                                                                                                                      |
| `php artisan db:seed --class=RegionSeeder`                | Run a single database seeder class, in this case the `RegionSeeder`.                                                                                                                                                                         |
| `php artisan make:class Classes/ApiResponseClass`         | Create a generic application class                                                                                                                                                                                                           |
| `php artisan route:list`                                  | List all your routes                                                                                                                                                                                                                         |
| `php artisan make:test BrowseRegionsTest --pest`          | Create a new Pest **feature** test                                                                                                                                                                                                           |
| `.vendor/bin/pest`                                        | Execute all the Pest tests                                                                                                                                                                                                                   |
| `composer require --dev knuckleswtf/scribe`               | Add the Scribe API Documentation package written and maintained by KnuckesWTF.                                                                                                                                                               |
| `php artisan vendor:publish --tag=scribe-config`          | Publish the scribe configuration file to the `config` folder.                                                                                                                                                                                |
| `composer require spatie/pest-plugin-test-time --dev`     |                                                                                                                                                                                                                                              |
| `php artisan scribe:generate`                             |                                                                                                                                                                                                                                              |
| `composer require laravel/sanctum`                        |                                                                                                                                                                                                                                              |
| `composer require --dev laravel/pint`                     |                                                                                                                                                                                                                                              |
| `php artisan publish`                                     | Provide an interactive method to publish (copy from the package's vendor folder) configuration, templates, or other components of a package for user modification.                                                                           |
| `php artisan make:model Region --all --api`               |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
| `mv ~/Downloads/regions.json database/data/`              |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
|                                                           |                                                                                                                                                                                                                                              |
