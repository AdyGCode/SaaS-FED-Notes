---
theme: nmt
background: https://cover.sli.dev
title: Session 03 - Introduction to TailwindCSS
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 45min
---

# Session 01: Introduction to TailwindCSS

## SaaS 1 – Cloud Application Development (Front-End Dev)

### A Quick Introduction to Utility First Style Systems

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->


---
layout: default
level: 2
---

# Navigating Slides

Hover over the bottom-left corner to see the navigation's controls panel.

## Keyboard Shortcuts

|                                                     |                             |
|-----------------------------------------------------|-----------------------------|
| <kbd>right</kbd> / <kbd>space</kbd>                 | next animation or slide     |
| <kbd>left</kbd>  / <kbd>shift</kbd><kbd>space</kbd> | previous animation or slide |
| <kbd>up</kbd>                                       | previous slide              |
| <kbd>down</kbd>                                     | next slide                  |

---
layout: section
---

# Objectives

---
layout: two-cols
level: 2
---

# Objectives

::left::

## Setting Up

- Creating the project
    - add folders
    - add files
    - required packages
    - `style.css`
    - `index.html`

::right::

## Styling a page

- Add base HTML
- Style Header
- Style Footer
- Style Main content

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---

# Before you Begin

<Announcement type="important" title="PNPM" class="max-w-[60ch]">
<p>
When developing, Adrian had some issues with not being able to
execute commands to create a new `pnpm` based project.
</p>
<p>
This was due to security restrictions on his laptop.
</p>
<p>
It is possible to work around this by using a
combination of <code>npm</code> and <code>pnpm</code> to install and
execute the development environment for TailwindCSS.
</p>
</Announcement>

<Announcement type="info" title="Terminal" class="max-w-[60ch]">
<p>
Remember that we also work with a split terminal, with one
terminal for the development server and the other for executing
commands such as <code>npm create vite@latest profile-page</code> 
 <br> and <code>pnpm install tailwindcss @tailwindcss/vite</code>.
</p>
</Announcement>

---
layout: section
---

# Profile Page Preview

We are developing a profile page to learn about TailwindCSS.

---
level: 2
layout: two-cols
---

# Profile Page Previews

::left::

## Screen Capture

![screen-capture-profile-page-complete.png](./public/screen-capture-profile-page-complete.png)

::right::

## Quick Video Tour

<SlidevVideo v-click autoplay controls class="max-h-96">
  <!-- Anything that can go in an HTML video element. -->
  <source 
    src="./public/screen-capture-profile-page-demo-video.mp4" 
    type="video/mp4" 
    />
  <p>
    Your browser does not support videos. You may download it
    <a href="./public/screen-capture-profile-page-demo-video.mp4">here</a>.
  </p>
</SlidevVideo>

Press Space to watch video

---
layout: section
---

# Creating the TailwindCSS Project

---
level: 2
layout: two-cols
---

# Creating the Project

::left::

## Setting Up

- Open MS Terminal
- Change into your `Source/Repos` folder
- Execute the command: 

```shell
npm create vite@latest profile-page
```

::right::

## Vite Options

When prompted, use the options:

- Framework: `Vanilla`
- Variant: `JavaScript`
- Use Vite beta: `No`
- Install with npm...: `No`

---
level: 2
---

# Creating the Project (2)

Continue the setting up by executing:

- `cd profile-page`
- Execute: `pnpm install tailwindcss @tailwindcss/vite `
- Execute: `pnpm install @tailwindcss/forms @fortawesome/fontawesome-free `

At this point the result of an `ls -la` should be **similar** to:

```text
-rw-r--r-- 1 UserName 1073742337   253 Feb 16 12:45 .gitignore
-rw-r--r-- 1 UserName 1073742337   359 Feb 16 17:07 index.html
drwxr-xr-x 1 UserName 1073742337     0 Feb 16 17:12 node_modules/
-rw-r--r-- 1 UserName 1073742337   325 Feb 16 17:12 package.json
-rw-r--r-- 1 UserName 1073742337 32794 Feb 16 17:12 pnpm-lock.yaml
drwxr-xr-x 1 UserName 1073742337     0 Feb 16 17:07 public/
drwxr-xr-x 1 UserName 1073742337     0 Feb 16 17:07 src/
```

---
level: 2
---

# Creating the Project (3)

## Add folders and empty files

- Execute:

```shell
touch vite.config.ts 
touch {src,public}/.gitignore
```


---
level: 2
---

# Creating the Project (4)


## Configure Vite

- Open the new `vite.config.ts` file
- Add the code to configure Vite
- Update to include the TailwindCSS Vite plugin

````md magic-move

```ts
import { defineConfig } from 'vite'
export default defineConfig({
  plugins: [  ],
})
```

```ts [typescript] {2,5}
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
export default defineConfig({
  plugins: [
    tailwindcss(),
  ],
})
```

````


---
level: 2
layout: two-cols
---

# Creating the Project (5)

::left::

## Execute the Dev server

```shell [Shell]
pnpm run dev
```

Open the page shown next to "Local" in the terminal in your browser.

This page is Vite's welcome page.

::right::

## Default Vite Welcome Page

![Image: Screenshot of the Vite Welcome Page](./public/screenshot-vite-welcome.png)

---
layout: section
---

# HTML & CSS Starter

Creating the HTML and CSS starter code for TailwindCSS styling.

--- 
level: 2
---

# Setting Up the CSS File

## Style File

Open the existing `src/style.css` file.

Remove ALL the existing CSS and replace with:

```css
@import "tailwindcss";
@import "@fortawesome/fontawesome-free/css/all.css";

@theme {
    --font-sans: Roboto, Trebuchet, sans-serif;
}
```

---
level: 2
---

# Setting Up the HTML File

## Index file


- Open the existing `index.html` file
- Remove all the content in the `<body> ... </body>` element


---
level: 2
---

# Setting Up the HTML File (2)

<Announcement type="info">
In this slide, we will show code in steps, highlighting key items.
</Announcement>

Update the content:

````md magic-move

```html [html] {all}
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Profile Page</title>

</head>
```

```html [html] {1-6,11|7|8-10|12|all}
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Profile Page</title>
    <!-- Load Fonts from CDN -->
    <link rel="preconnect" href="https://api.fonts.coollabs.io" crossorigin/>
    <link rel="stylesheet"
          href="https://api.fonts.coollabs.io/css2?family=Roboto:wght@100..900&display=swap" />

    <link rel="stylesheet" href="src/style.css">
</head>
```

````



---
level: 2
---

# Quick Aside: Font CDNs

Google and other CDNs may track usage.

The following are alternatives to the Google Font CDN, and are listed in 
no particular order.

- bunny.net. (2025). Bunny Fonts | Explore Faster & GDPR Friendly Fonts. Bunny.net. https://bunny.net/fonts/
- CDNFonts: Free Desktop & WebFonts [BETA]. (2020). Cdnfonts.com. https://www.cdnfonts.com/
- coolLabs Fonts. (2026). CoolLabs Fonts. https://fonts.coollabs.io/

<br><br>

<Announcement type="info" title="CDN">
Content Delivery Network
</Announcement>



---
level: 2
---

# Setting Up the HTML File (3)

Modify the HTML to include a basic semantic page layout:

````md magic-move

```html [html] {1,7-8|2-5|all}
<body>
<header>
    Header
    <nav>Navigation</nav>
</header>

</body>
</html>
```


```html [html] {1-5,9-10|7|all}
<body>
<header>
    Header
    <nav>Navigation</nav>
</header>

<main>Main Content of Page</main>

</body>
</html>
```


```html [html] {1-7,10-11|9|all}
<body>
<header>
    Header
    <nav>Navigation</nav>
</header>

<main>Main Content of Page</main>

<footer>Site/Page Footer</footer>
</body>
</html>
```




````

---
level: 2
---

# Setting Up the HTML & CSS (4)

Let's add some TailwindCSS classes.


Add a very pale grey page background:

````md magic-move

```html
<body class="bg-gray-50">
```

````

---
level: 2
---

# Setting Up the HTML & CSS (5)


Header and Navigation based upon a header from HyperUI.

Style the Header:

````md magic-move

```html
<header>
    <div>
        <a href="#MainContent">
            <p>
                YOUR INITIALS HERE
                <span>Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```

```html {1}
<header class="bg-black px-8 py-2 mb-0 sticky top-0">
    <div>
        <a href="#MainContent">
            <p>
                YOUR INITIALS HERE
                <span>Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```


```html {2}
<header class="bg-black px-8 py-2 mb-0 sticky top-0">
    <div class="mx-auto max-w-7xl flex items-center gap-8">
        <a href="#MainContent">
            <p>
                YOUR INITIALS HERE
                <span>Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```


```html {3-4}
<header class="bg-black px-8 py-2 mb-0 sticky top-0">
    <div class="mx-auto max-w-7xl flex items-center gap-8">
        <a class="text-teal-800 text-center items-center flex h-14 w-14" 
            href="#MainContent">
            <p>
                YOUR INITIALS HERE
                <span>Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```

```html {5-6}
<header class="bg-black px-8 py-2 mb-0 sticky top-0">
    <div class="mx-auto max-w-7xl flex items-center gap-8">
        <a class="text-teal-800 text-center items-center flex h-14 w-14" 
            href="#MainContent">
            <p class="text-3xl bg-teal-300 rounded-full h-14 w-14  items-center p-1 py-2">
                YOUR INITIALS HERE
                <span>Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```

```html {7|all}
<header class="bg-black px-8 py-2 mb-0 sticky top-0">
    <div class="mx-auto max-w-7xl flex items-center gap-8">
        <a class="text-teal-800 text-center items-center flex h-14 w-14" 
            href="#MainContent">
            <p class="text-3xl bg-teal-300 rounded-full h-14 w-14  items-center p-1 py-2">
                YOUR INITIALS HERE
                <span class="sr-only">Home</span>
            </p>
        </a>
        <nav></nav>
    </div>
</header>
```



````

---
level: 2
---

# Setting Up the HTML & CSS (7)

Build and Style the Navigation:

````md magic-move

```html {none|1,13|2,12|3,11|4-6|7-10|all}
<div>
    <nav>
        <ul>
            <li>
                <a href="#About">About</a>
            </li>
<!-- 
    Add Nav items for Skills, Projects and Contact here 
    Follow the List Item and Anchor pattern above
-->
       </ul>
    </nav>
</div>
```


```html {1}
<div class="flex flex-1 items-center justify-end md:justify-between">
     <nav>
        <ul>
            <li>
                <a href="#About">About</a>
            </li>
<!-- 
    Add Nav items for Skills, Projects and Contact here 
    Follow the List Item and Anchor pattern above
-->
       </ul>
    </nav>
</div>
```

```html {2} 
<div class="flex flex-1 items-center justify-end md:justify-between">
    <nav aria-label="Global" class="hidden md:block">
        <ul>
            <li>
                <a href="#About">About</a>
            </li>
<!-- 
    Add Nav items for Skills, Projects and Contact here 
    Follow the List Item and Anchor pattern above
-->
       </ul>
    </nav>
</div>
```

```html {3}
<div class="flex flex-1 items-center justify-end md:justify-between">
    <nav aria-label="Global" class="hidden md:block">
        <ul class="flex items-center gap-6 text-sm">
            <li>
                <a href="#About">About</a>
            </li>
<!-- 
    Add Nav items for Skills, Projects and Contact here 
    Follow the List Item and Anchor pattern above
-->
       </ul>
    </nav>
</div>
```

```html {5-8}
<div class="flex flex-1 items-center justify-end md:justify-between">
    <nav aria-label="Global" class="hidden md:block">
        <ul class="flex items-center gap-6 text-sm">
            <li>
                <a class="text-teal-400 transition hover:text-teal-300" 
                   href="#About">
                    About
                </a>
            </li>
<!-- 
    Add Nav items for Skills, Projects and Contact here 
    Follow the List Item and Anchor pattern above
-->
       </ul>
    </nav>
</div>
```

```html {10-13|all}
<div class="flex flex-1 items-center justify-end md:justify-between">
    <nav aria-label="Global" class="hidden md:block">
        <ul class="flex items-center gap-6 text-sm">
            <li>
                <a class="text-teal-400 transition hover:text-teal-300" 
                   href="#About">
                    About
                </a>
            </li>
<!-- 
    Repeat the li -> a elements to add Nav items for:
     Skills, Projects and Contact here 
-->
    </nav>
</div>
```



````

---
level: 2
---

# Setting Up the HTML & CSS (8)

Add the Main section, and style:

````md magic-move

```html
<main>
    <article>
        <header>
            <h1>
                Hello!
            </h1>
        </header>
        <section>
        </section>
    </article>
    <!-- More to be added here -->
</main>
```

```html {1-2,13}
<main class="max-w-7xl space-y-16 bg-white min-h-screen 
             mx-auto px-4 sm:px-6 lg:px-8 pt-12 pb-16">
    <article>
        <header>
            <h1>
                Hello!
            </h1>
        </header>
        <section>
        </section>
    </article>
    <!-- More to be added here -->
</main>
```


```html {3,11}
<main class="max-w-7xl space-y-16 bg-white min-h-screen 
             mx-auto px-4 sm:px-6 lg:px-8 pt-12 pb-16">
    <article class="border border-gray-200 rounded-xl shadow overflow-hidden">
        <header class="bg-pink-700 text-amber-100 w-full">
            <h1 class="text-3xl p-4">
                Hello!
            </h1>
        </header>
        <section class="space-y-4 p-4">
        </section>
    </article>
    <!-- More to be added here -->
</main>
```


```html {4,8|5-7|9-10}
<main class="max-w-7xl space-y-16 bg-white min-h-screen 
             mx-auto px-4 sm:px-6 lg:px-8 pt-12 pb-16">
    <article class="border border-gray-200 rounded-xl shadow overflow-hidden">
        <header class="bg-pink-700 text-amber-100 w-full">
            <h1 class="text-3xl p-4">
                Hello!
            </h1>
        </header>
        <section class="space-y-4 p-4">
        </section>
    </article>
    <!-- More to be added here -->
</main>
```


```html {10-12}
<main class="max-w-7xl space-y-16 bg-white min-h-screen 
             mx-auto px-4 sm:px-6 lg:px-8 pt-12 pb-16">
    <article class="border border-gray-200 rounded-xl shadow overflow-hidden">
        <header class="bg-pink-700 text-amber-100 w-full">
            <h1 class="text-3xl p-4">
                Hello!
            </h1>
        </header>
        <section class="space-y-4 p-4">
            <p>
                Welcome to YOUR NAME HERE's Profile.
            </p>
        </section>
    </article>
    <!-- More to be added here -->
</main>
```


````

---
level: 2
---

# Setting Up the HTML & CSS (9)

## Adding Projects

Project "cards" based on HyperUI Blog Card Components, specifically,  
"Floating image with title and excerpt".

````md magic-move

```html {1,11|2,6|3-5|7-9|10|all}
<article>
    <header>
        <h1>
            Projects
        </h1>
    </header>
    <div>
        <!-- We add the project cards here -->
    </div>
    <span id="Contact"></span>
</article>
```

```html {1}
<article class="border border-gray-200 rounded-xl shadow overflow-hidden">
    <header>
        <h1>
            Projects
        </h1>
    </header>
    <div>
        <!-- We add the project cards here -->
    </div>
    <span id="Contact"></span>
</article>
```

```html {2}
<article class="border border-gray-200 rounded-xl shadow overflow-hidden">
    <header class="bg-gray-700 text-gray-100 w-full">
        <h1>
            Projects
        </h1>
    </header>
    <div>
        <!-- We add the project cards here -->
    </div>
    <span id="Contact"></span>
</article>
```

```html {3}
<article class="border border-gray-200 rounded-xl shadow overflow-hidden">
    <header class="bg-gray-700 text-gray-100 w-full">
        <h1 class="text-3xl text-gray-100 p-4">
            Projects
        </h1>
    </header>
    <div>
        <!-- We add the project cards here -->
    </div>
    <span id="Contact"></span>
</article>
```

```html {7}
<article class="border border-gray-200 rounded-xl shadow overflow-hidden">
    <header class="bg-gray-700 text-gray-100 w-full">
        <h1 class="text-3xl text-gray-100 p-4">
            Projects
        </h1>
    </header>
    <div class="gap-4 p-4 grid grid-cols-3">
        <!-- We add the project cards here -->
    </div>
    <span id="Contact"></span>
</article>
```



````

---
level: 2
---

# Setting Up the HTML & CSS (10)

## Single Project Card

We replace the `<!-- We add the project cards here -->` with project cards.

````md magic-move````

```html {1-2,9|3,8|4|5-7|all}
<div class="gap-4 p-4 grid grid-cols-3">
    <!-- We add the project cards here -->
    <section class="group">
        <!-- Screenshot/Illustration here -->
        <div class="p-4">
            <!-- title and one sentence description -->
        </div>
    </section>
</div>
```

```html {1-2,12-13|3,11|4|5|6|7|8-10|all}
<div class="gap-4 p-4 grid grid-cols-3">
    <!-- Start of Card -->
    <section class="group">
        <img alt="..."
             aria-description="..."
             src="..."
             class="...">
        <div class="p-4">
            <!-- title and one sentence description -->
        </div>
    </section>
  <!-- End of Card -->
</div>
```

```html {1|2-4}
        <img alt="Photo: Image of Batman Rubber Duck"
             aria-description="Photo of Batman Rubber Duck by Brett Jordan.
              The duck is black, with a yellow oval and batman symbol on 
              it's belly, an orange beak, batman mask style eyes and ears."
             src="..."
             class="...">
```

```html {5-7}
        <img alt="Photo: Image of Batman Rubber Duck"
             aria-description="Photo of Batman Rubber Duck by Brett Jordan.
              The duck is black, with a yellow oval and batman symbol on 
              it's belly, an orange beak, batman mask style eyes and ears."
             src="https://images.unsplash.com/photo-1559715541-5daf8a0296d0?
                  q=80&w=986&auto=format&fit=crop&ixlib=rb-4.1.0
                  &ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
             class="...">
```

```html {8-10}
        <img alt="Photo: Image of Batman Rubber Duck"
             aria-description="Photo of Batman Rubber Duck by Brett Jordan.
              The duck is black, with a yellow oval and batman symbol on 
              it's belly, an orange beak, batman mask style eyes and ears."
             src="https://images.unsplash.com/photo-1559715541-5daf8a0296d0?
                  q=80&w=986&auto=format&fit=crop&ixlib=rb-4.1.0
                  &ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
             class="h-56 w-full rounded-xl object-cover shadow transition 
                    group-hover:grayscale-80">
```

````
---
level: 2
---

# Setting Up the HTML & CSS (11)

## Single Project Card

Add card title and description:

````md magic-move````

```html {all}
<div class="p-4">
    <!-- title and one sentence description -->
</div>
```

```html {3,7|4-6|9-11}
<div class="p-4">
    <!-- title and one sentence description -->
    <a href="#">
        <h3>
          Rubber Duck Debugging
        </h3>
    </a>

    <p>
        ...
    </p>
</div>
```

```html {4}
<div class="p-4">
    <!-- title and one sentence description -->
    <a href="#">
        <h3 class="text-lg font-medium text-gray-900">
          Rubber Duck Debugging
        </h3>
    </a>

    <p>
        ...
    </p>
</div>
```

```html {9-11}
<div class="p-4">
    <!-- title and one sentence description -->
    <a href="#">
        <h3 class="text-lg font-medium text-gray-900">
          Rubber Duck Debugging
        </h3>
    </a>

    <p>
        A demonstration application using Laravel, TailwindCSS, Livewire, Sanctum and more.
    </p>
</div>
```


```html {9}
<div class="p-4">
    <!-- title and one sentence description -->
    <a href="#">
        <h3 class="text-lg font-medium text-gray-900">
          Rubber Duck Debugging
        </h3>
    </a>

    <p class="mt-2 line-clamp-3 text-sm/relaxed text-gray-500">
        A demonstration application using Laravel, TailwindCSS, Livewire, Sanctum and more.
    </p>
</div>
```



````

---
layout: section
---

# TailwindCSS Practice

---
level: 2
layout: two-cols
---

# Practice!

::left::

For practice, we want you to:

- Follow the steps to create the profile-page project

Think about these questions:

<Announcement type="brainstorm">
How you could make it more professional?
</Announcement>



<Announcement type="brainstorm">
What colours, typeface, and other customisations do you want to use?
</Announcement>

::right::

- Update the layout to your personality & professional image
- Update colour, typeface to suit

- Ensure you have the following sections:
  - About, Education, Skills, 
  - Projects, Contact form

You may add extra sections as you believe are useful, for example: 
External Interests, Voluntary Roles

---

# Recap Checklist

- [ ] Create a new TailwindCSS Project
- [ ] Set up the Base HTML for the project
- [ ] Use different fonts for serif, sans and mono
- [ ] Use the responsive layout capabilities
- [ ] Ensure page is accessible
- [ ] Contains the required sections

---
level: 2
---

# Exit Ticket

> How has TailwindCSS altered your perception of CSS?

<br>

> What drawbacks do you see in TailwindCSS? 


---

# Acknowledgements

- Free Tailwind CSS Components | HyperUI | HyperUI. (2026). HyperUI. https://www.hyperui.dev
- Font Awesome. (2026). Font Awesome. Fontawesome.com; Font Awesome. https://fontawesome.com/
- Fu, A. (2020). Slidev. Sli.dev. https://sli.dev/
- Mermaid Chart. (2026). Mermaid.ai. https://mermaid.ai/
- Unsplash. (2025). Beautiful Free Images & Pictures | Unsplash. Unsplash.com; Unsplash. https://unsplash.com/

Slide template: Adrian Gould
