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
updated: 2025-03-12T11:01
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
[Git Ignore File](../session-06/gitignore.txt)

Use the following command to copy the file, and rename it, into your project's root folder:

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

Next we create empty files in the folders. We are using empty `.gitignore` files are they are useful if we want to force particular folders to be included, or excluded.

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

Locate and then double-click on the new `SaaS-Vanilla-MVC` folder. Click Open to open the project.

## Install TailwindCSS

Next we install TailwindCSS v4 and its required components...

```bash
npm install -D tailwindcss@latest @tailwindcss/vite
npm install @tailwindcss/postcss @tailwindcss/cli
npm install vite-plugin-live-reload
```

Now we can create a TailwindCSS configuration file.

```
touch tailwind.config.js
```

Open the `tailwind.config.js` file (it will be in the root of the project) and update it so it contains:

```js
/**
 * Tailwind Configuration File
 *
 * Filename:        tailwind.config.js
 * Location:        /
 * Project:         SaaS-Vanilla-MVC
 * Date Created:    20/08/2024
 *
 * Author:          Your Name
 */

/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
		"./App/views/**/*.php",  
		"./src/templates/**/*.html",  
		"./public/**/*.html"
	],
    theme: {
        extend: {},
    }
}
```

Create a vite.config.js file

```shell
touch vite.config.js
```

Edit this file and add:

```js
import { defineConfig } from 'vite';  
import tailwindcss from '@tailwindcss/vite';  
  
export default defineConfig({  
    plugins: [  
        tailwindcss(),  
    ],  
    server: {  
        watch: {  
            usePolling: true,  
        },  
        hmr: true,  
        proxy: {  
            // Proxy PHP backend  
            '/': 'http://localhost:8000',  
        }  
    }  
});
```



We are ready to start our PHP... [S07-Vanilla-PHP-MVC-Pt-1](./session-07/S07-Vanilla-PHP-MVC-Pt-1.md)
