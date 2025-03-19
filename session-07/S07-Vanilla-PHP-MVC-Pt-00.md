---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testng, PEST
created: 2024-09-05T08:58
updated: 2025-03-13T17:51
---


# Setting up for the Project


## Create Base Project

We will start by creating a project that we will use in the next section on MVC.

Use these BASH  commands in your Source/Repos folder, replacing `XXX` with YOUR initials, `YYYY` with the year and `N` with the semester number (`1` or `2`):

```bash
# Open Terminal, make sure you are in your ~/Source/Repos folder
cd ~/Source/Repos

# Create new project folder
mkdir -p XXX-SaaS-Vanilla-MVC-YYYY-SN
```

This creates the new folder.

```shell
# Change into the folder
cd XXX-SaaS-Vanilla-MVC-YYYY-SN
```

This changes the directory (folder) to this new folder.

## Git: Initialise the Repository

We are now ready to initialise version control:

```bash
git init .
```

This initialises the repository.

### Git: Add `.gitignore`

We now need to update the `.gitignore` in the root folder.

Download this file:
[gitignote.txt - a Git Ignore Sample File for NM TAFE Students](../session-06/sample-code/gitignore.txt)

Use the following command to copy the file into your project's root folder and rename it (`.gitignore`) in one command:

```bash
cp -f ~/Downloads/gitignore.txt .gitignore
```

## Folder Structure

Now we create the various folders we need for the project:
```shell
mkdir -p {config,src}
mkdir -p App/{controllers,views}
mkdir -p Framework/middleware
mkdir -p public/assets/{css,js,img,downloads}
```

Next we create empty `.gitignore` files in the folders. 

We are using empty `.gitignore` files are they are useful if we want to force particular folders to be included, or excluded. It also means the structure may be maintained in the Git repository, which reduces the time taken to create a new project using this 'template'.

Also a `source.css` file is created ready for the TailwindCSS configuration.

```shell
touch public/assets/{css,js,img,downloads}/.gitignore
touch public/{assets}/.gitignore
touch {App,Framework,config,src}/.gitignore
touch App/{controllers,views}/.gitignore
touch Framework/middleware/.gitignore
touch src/source.css
```


## Opening the Project in PhpStorm

Open PhpStorm, and use the "hamburger" menu:

![Image: Hamburger Icon](../assets/Pasted%20image%2020240827112528.png)

Then click File, and click Open option:

![image: File - Open dialog](../assets/Pasted%20image%2020240827112545.png)

Locate and then double-click on the new `XXX-SaaS-Vanilla-MVC-YYYY-SN` folder. Click Open to open the project.


## Set Up `package.json`

Before we install the TailwindCSS packages we will set up the `package.json` file:

```shell
npm init
```

Answer the questions as follows, replacing `YOUR_NAME` , `EMAIL@ADDRESS` and `YOUR_GITHUB_USERNAME` with the relevant details.

| Prompt          | Response                                                                 |
| --------------- | ------------------------------------------------------------------------ |
| package name:   | tailwindcss-php-mvc-starter                                              |
| version:        | <kbd>ENTER</kbd>                                                         |
| description:    | TailwindCSS V4, plus basic PHP MVC Framework Starter Kit                 |
| entry point:    | index.php                                                                |
| test command:   | <kbd>ENTER</kbd>                                                         |
| git repository: | httpds://github.com/YOUR_GITHUB_USERNAME/tailwindcss-php-mvc-starter.git |
| keywords:       | tailwindcss,css,html5,nodejs,php,mvc,simple,traversy-media               |
| author:         | YOUR_NAME <EMAIL@ADDRESS>                                                |
| license:        | SEE LICENSE IN Licence.md                                                |

It will show you the prepared `package.json` contents and then ask if this looks ok.

Here is an example:

```json
{
  "name": "XXX-SaaS-Vanilla-MVC-YYYY-SN",
  "version": "1.0.0",
  "description": "Simple PHP MVC & TailwindCSS Application Template",
  "main": "index.php",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "repository": {
    "type": "git",
    "url": "git+https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN.git"
  },
  "keywords": [
    "tailwindcss",
    "css",
    "html5",
    "nodejs",
    "php",
    "mvc",
    "simple",
    "traversy-media"
  ],
  "author": "Adrian Gould <adrian.gould@nmtafe.wa.edu.au>",
  "license": "SEE LICENSE IN Licence.md",
  "bugs": {
    "url": "https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN/issues"
  },
  "homepage": "https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN#readme"
}
```

Respond <kbd>Y</kbd> if all looks correct.

## Install TailwindCSS, Vite and Plugins

Next we install TailwindCSS and its required components...

```bash
npm install -D tailwindcss @tailwindcss/vite 
npm install -D @tailwindcss/postcss @tailwindcss/cli
npm install -D vite-plugin-php vite-plugin-live-reload
```

Now we can create a Vite configuration file.

```
touch vite.config.js
```

Open the `vite.config.js` file (it will be in the root of the project) and update it so it contains:

```js
/**  
 * Vite Configuration File 
 * 
 * Filename:        vite.config.js 
 * Location:        / 
 * Project:         XXX-SaaS-Vanilla-MVC-YYYY-SN 
 * Date Created:    2025-03-13 
 * 
 * Author:          Adrian Gould <adrian.gould@nmtafe.wa.edu.au>  
 */  
  
import {defineConfig} from 'vite'  
import tailwindcss from '@tailwindcss/vite'  
import usePHP from 'vite-plugin-php';  
import liveReload from 'vite-plugin-live-reload'  
  
export default defineConfig({  
    plugins: [  
        tailwindcss(),  
        usePHP({  
            entry: [  
                'index.{html,php}',  
                'public/index.{html,php}',  
                'App/views/**/*.{html,php}'  
            ],  
        }),  
        liveReload([  
            'index.{html,php}',  
            'public/index.{html,php}',  
            'App/views/**/*.{html,php}'  
            ],  
            {  
                alwaysReload: true  
            }  
        ),  
    ],  
})
```

The `vite-plugin-php` allows the Vite package to load PHP files, and interpret them using an installed version of PHP.

The `vite-plugin-live-reload` provides Vite with an automatic reload of pages when their source is changed.

These two combined will mean you can change code and on save  (<kbd>CTRL</kbd>+<kbd>S</kbd>) it will perform the rebuild of the pages live reloading the updates.

### Update package.json

Update the `package.json` file to include the shortcut commands for development, building and preview.

Locate the scripts area and add/update to read:

```json
"scripts": {  
  "test": "echo \"Error: no test specified\" && exit 1",  
  "serve": "vite preview",  
  "dev": "vite",  
  "build": "vite build"  
},
```

Also add the line `"type": "module",  ` to the file, just before the scripts.

Here is an example of a completed `package.json` file:

```json
{  
  "name": "XXX-SaaS-Vanilla-MVC-YYYY-SN",  
  "version": "1.0.0",  
  "description": "Simple PHP MVC & TailwindCSS Application Template",  
  "main": "index.php",  
  "type": "module",  
  "scripts": {  
    "test": "echo \"Error: no test specified\" && exit 1",  
    "serve": "vite preview",  
    "dev": "vite",  
    "build": "vite build"  
  },  
  "repository": {  
    "type": "git",  
    "url": "git+https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN.git"  
  },  
  "keywords": [  
    "tailwindcss",  
    "css",  
    "html5",  
    "nodejs",  
    "php",  
    "mvc",  
    "simple",  
    "traversy-media"  
  ],  
  "author": "Adrian Gould <adrian.gould@nmtafe.wa.edu.au>",  
  "license": "SEE LICENSE IN Licence.md",  
  "bugs": {  
    "url": "https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN/issues"  
  },  
  "homepage": "https://github.com/adygcode/XXX-SaaS-Vanilla-MVC-YYYY-SN#readme",  
  "devDependencies": {  
    "@tailwindcss/cli": "^4.0.13",  
    "@tailwindcss/postcss": "^4.0.13",  
    "@tailwindcss/vite": "^4.0.13",  
    "tailwindcss": "^4.0.13",  
    "vite-plugin-live-reload": "^3.0.4",  
    "vite-plugin-php": "^2.0.1"  
  },  
  "dependencies": {  
  }
}
```


## Adding Font Awesome (Free)

Download the Font Awesome Free Package from their web site:

Uncompress the file in your downloads folder.

Rename the `fontawesome-free-X.Y.Z-web` folder to `fontawesome-free` to make the next steps easier.

> To do this in the command line use the command (Remember to replace X.Y.Z with the version numbers of your download):
> 
> ```shell
> mv ~/Downloads/fontawesome-free-X.Y.Z-web ~/Downloads/fontawesome-free
> ```

Now use the following commands to copy the required folders/files to the `public/assets/` folder:

```shell
 cp -r ~/Downloads/fontawesome-free/{webfonts,css,js,svgs,sprites} public/assets/
```

Now create a new `index.php` file and open it to add the following:

```php
<?php  
/**  
 * HTML Template using TailwindCSS 
 * 
 * Filename:        index.php 
 * Location:        / 
 * Project:         SaaS-Vanilla-MVC 
 * Date Created:    30/08/2024 
 * 
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>  
 * 
 */?>  
  
<!doctype html>  
<html lang="en">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>Document</title>  
  
    <!-- During DEVELOPMENT the src/source.css file is used -->  
    <link rel="stylesheet" href="./src/source.css">  
    <!-- For production the assets/css/site.css file will be used -->  
  
    <!-- Font Awesome -->    <link rel="stylesheet" href="./assets/css/all.css">  
  
</head>  
<body class="bg-white flex flex-col h-screen justify-between">  
  
<header class="bg-gray-950 text-gray-200 p-4 flex-grow-0 flex flex-row align-middle content-center">  
    <h1 class="flex-0 w-32 text-xl p-4 ">  
        <a href="#"  
           class="py-4 px-4 -mx-4 -my-4 font-bold rounded text-gray-300 hover:text-gray-700 hover:bg-gray-300  
                     transition ease-in-out duration-500">  
            MVC  
        </a>  
    </h1>  
    <nav class="flex flex-row py-4 flex-grow ml-8">  
        <ul class="flex flex-row gap-4 flex-grow">  
            <li>  
                <a href="/"  
                   class="pb-2 px-1 text-gray-400 hover:text-gray-300  
                     border-0 border-b-2 hover:border-b-gray-500                     transition ease-in-out duration-500">  
                    Home  
                </a>  
            </li>  
  
            <li>                <a href="#"  
                   class="pb-2 px-1 text-gray-400 hover:text-gray-300  
                     border-0 border-b-2 hover:border-b-gray-500                     transition ease-in-out duration-500">  
                    Link 1  
                </a>  
            </li>  
        </ul>  
  
        <ul class="flex flex-row gap-4">  
            <li>  
                <form method="POST" action="#" class="">  
                    <button class="pb-2 px-1 text-sm text-gray-400 hover:text-gray-300  
                     border-0 border-b-2 hover:border-b-gray-500                     transition ease-in-out duration-500">  
                        <i class="fa fa-door-open"></i> Login  
                    </button>  
                </form>  
            </li>  
            <li>                <form method="POST" action="#" class="">  
                    <button class="pb-2 px-1 text-sm text-gray-400 hover:text-gray-300  
                     border-0 border-b-2 hover:border-b-gray-500                     transition ease-in-out duration-500">  
                        <i class="fa fa-user-plus"></i> Register  
                    </button>  
                </form>  
            </li>  
            <li>                <form method="POST" action="#" class="">  
                    <button class="pb-2 px-1 text-sm text-gray-400 hover:text-gray-300  
                     border-0 border-b-2 hover:border-b-gray-500                     transition ease-in-out duration-500">  
                        <i class="fa fa-door-closed"></i> Logout  
                    </button>  
                </form>  
            </li>  
            <li>                <form method="GET" action="#" class="block mx-5">  
                    <input type="text" name="keywords" placeholder="Product search..."  
                           class="w-full md:w-auto px-4 py-2 focus:outline-none"/>  
                    <button class="w-full md:w-auto bg-gray-500 hover:bg-gray-600 text-white px-4 py-2 focus:outline-none transition ease-in-out duration-500">  
                        <i class="fa fa-search"></i> Search  
                    </button>  
                </form>  
            </li>  
        </ul>  
    </nav>  
</header>
  
<main class="container mx-auto bg-gray-50 py-8 px-4 shadow shadow-black/25 rounded-b-lg">  
    Main Page Content
</main>  
  
  
<footer class="bg-black text-text-gray-700-400 p-4 mt-8">  
    The footer  
</footer>  
  
</body>  
</html>


```

NB: We have left a couple of issues in this code on purpose.

## Ignoring the `vendor` and `node_modules` folders

It is important we update the `.gitignore` file at this point to remove the `vendor` and `node_modules` folders from version control.

To do so, open the `/.gitignore` file and go to the bottom if it.

The last few linesd will be similar to this:

```text
    
!.obsidian  
/.obsidian/plugins/novel-word-count/data.json  /.obsidian/workspace.json  
/.obsidian/vault-stats.json
```

Now add:

```ignore
  
# Vendor and Node Modules  
# Logs  
logs  
*.log  
  
# Dependency directories  
node_modules/  
  
# Optional npm cache directory  
.npm  
  
# dotenv environment variable files  
.env  
.env.development.local  
.env.test.local  
.env.production.local  
.env.local  
  
# Composer and Vendor folders  
composer.phar  
/vendor/  
composer.lock
```

# Commit Your Work

Add the changes to the stash and commit them to the repository:

```shell
git add .

git commit -m "Inital Project Commit

- Created folder structure
- Added TailwindCSS, Vite, FontAwesome
- Created a simple index.php page
- Configured Vite
- Configured npm package.json
- 
"

git push -u origin main
```



We are ready to start our PHP... [S07-Vanilla-PHP-MVC-Pt-1](./session-07/S07-Vanilla-PHP-MVC-Pt-1.md)
