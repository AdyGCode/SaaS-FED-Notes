---
theme: default
paginate: true
footer: © Copyright 2024, Adrian Gould & NM TAFE
header: "![NMTAFE](../images/Black-Red-Banner.svg)"
auto-scaling: true
size: 4k
color: "#ccc"
backgroundColor: "#060606"
tags: SaaS, Front-End, MVC, Laravel, Framework, PHP, MySQL, MariaDB, SQLite, Testing, Unit Testing, Feature Testing, PEST
created: 2024-08-06T15:47
updated: 2024-09-10T16:36
---

# Installing and Continuously Rebuilding TailwindCSS


# Install TailwindCSS

Open the Windows terminal

Make sure in home folder
```bash
cd ~
```

> **_Note in 3-06:_**
> ```bash
> cd /c/Users/USERNAME
> ```

Create `src` and `assets/css` folders
```shell
mkdir src assets/css
```

Create `.gitignore` files in these folders

```bash
touch {src,assets,assets/css}/.gitignore
```

Create `site-source.css`, `tailwind.config.js` file

```bash
touch src/site-source.css tailwind.config.js
```

Edit the `site-source.css` file and add:
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

Edit the `tailwind.config.js` file and add:

```js
/*
 * Filename: tailwind.config.js
 * Location: /
 */

/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./src/**/*.{html,js}",
        "./session-*/**/*.{html,js,php}"
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
```

Create `form.php` and `action.php` in the `session-03` folder:

```bash
touch session-03/{form.php,action.php}
```

Install tailwindcss!
```bash
npm install -D tailwindcss
```

Start tailwind watching your code
```bash
npx tailwindcss -i ./src/site-source.css -o ./assets/css/site.css --watch
```
