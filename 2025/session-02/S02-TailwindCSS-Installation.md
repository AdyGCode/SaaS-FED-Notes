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
  - Front-End
  - MVC
  - Laravel
  - Framework
  - PHP
  - MySQL
  - MariaDB
  - SQLite
  - Testing
  - Unit Testing
  - Feature Testing
  - PEST
created: 2024-08-06T15:47
updated: 2025-08-12T17:26
---

# Installing and Continuously Rebuilding TailwindCSS

The notes that follow are heavily influenced by Paul Magadi's Repo "Tailwind CSS Installation
using Vite"

> Paul Magadi. (2025). GitHub - paulmagadi/Tailwind-install-Vite-JS:
> Tailwind CSS Installation Using Vite.
> GitHub. https://github.com/paulmagadi/Tailwind-install-Vite-JS

# Install TailwindCSS v4

Open the Windows terminal

Make sure you are in your home folder:

```bash
cd ~
```

Verify you have a `Source/Repos` folder using:

```shell
ls -l Source
```

You should see an entry like:

```text
drwxr-xr-x 1 USER_NAME GROUP_NAME 0 Jul 31 09:38 Repos/
```

If no source folder, then use the following to make one:

```shell
mkdir -p Source/Repos 
```

Now move into that folder:

```shell
cd ~/Source/Repos
```

> **IMPORTANT**
>
> In Room 3-06 we MUST use a slightly different command to get into the home folder:
>
>  ```bash
>  cd /c/Users/USERNAME
>  ```

Create a new project folder, and change into it:

```shell
mkdir TailwindCSS-Demo-2015-s2
cd TailwindCSS-Demo-2025-s2
```

## 🚀 Tailwind CSS Installation Using Vite

This guide helps you set up Tailwind CSS in a **Vite + Vanilla JavaScript** project.

---

### 1. Create a Vite Project

```bash
npm create vite@latest .
```

When prompted select:

- **Vanilla** and
- **JavaScript**

Install dependencies:

```bash
npm install
```

---

### 2. Install Tailwind CSS with Vite Plugin

```bash
npm install tailwindcss @tailwindcss/vite
```

---

### 3. Configure Vite to Use Tailwind CSS

In the root directory, create a `vite.config.js` file (if not auto-created):

```shell
touch vite.config.js
```

In this file, add (or update):

```js
// vite.config.js
import {defineConfig} from 'vite'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
    plugins: [tailwindcss()],
})
```

---

## 4. Create and Configure Tailwind CSS

Create a new set of folders, and add empty `.gitignore` files to them:

```shell
mkdir -p src assets/{js,css,images,media,downloads,webfonts}
touch {src,assets,assets/{css,js,images,media,downloads,webfonts}}/.gitignore
```

#### 4.1 Tidy up the Vite Installation Content

We will create a backup folder that is ignored to hold the vite created files:

```shell
mkdir _backup
```

Now copy/move the files to the new folder:

```shell
cp index.html _backup/
cp -r src/ _backup/
cp -r public/ _backup/

rm public/* src/{*.js,*.svg,*.css}
```

#### 4.2 Create the Styles CSS file

In your `src/` folder, create a `styles.css` file and add:

```shell
touch src/styles.css
```

Now add the following:

```css
/* src/styles.css */
@import "tailwindcss";
```

---

## 5. Add Tailwind to Your HTML

Open the `/index.html` file.

Use <kbd>CTRL</kbd>+<kbd>A</kbd> to select all the content, and press <kbd>DEL</kbd> to delete
it.

Now enter <code>!</code> and press <kbd>TAB</kbd> to create the starter code for an HTML 5
document.

Update the lines shown below to match as required:

| Line No. | Old Code    | New Code                |
|----------|-------------|-------------------------|
| 2        | `lang="en"` | `lang="en_AU"`          |
| 8        | `Document`  | ` Demo ⋯ YOUR_INITIALS` |

After the `<title> ... </title>` element, and before the `</head>`, press enter twice and add:

```html
    <!-- Web Fonts -->

<!-- CSS Includes -->
<link href="/src/styles.css" rel="stylesheet">

<!-- JS includes -->
```

Make sure you have at least one blank line before the `</head>`.

Update the `<body>` tag to read:

```html

<body class="font-sans antialiased text-gray-900 bg-gray-100 flex flex-col">
```

#### 5.1 Add Sample Content

Inside the `<body> ... </body>` section (which is currently a blank line), add the following:

```html
    <h1 class="text-3xl font-bold underline text-amber-500 text-center mt-10">
    Hello world!
</h1>
```

---

## 6. Run the Development Server

```bash
npm run dev
```

Visit `http://localhost:5173` to see your Tailwind-styled project!

This is the start... you will build a layout in the next set of notes:

- [Building a Layout with TailwindCSS](S02-TailwindCSS-Building-A-Layout.md)

