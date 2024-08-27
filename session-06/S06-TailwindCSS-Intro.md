

# Quick Introduction to TailwindCSS

This introduction will tie in with our next sessions that look at MVC. We are going to create a template that will be then modified and used as needed.

## Create Base Project

We will start by creating a project that we will use in the next section on MVC.

Use these BASH  commands in your Source/Repos folder:

```bash
mkdir -P SaaS-Vanilla-MVC
```
This creates the new folder.

```shell
cd SaaS-Vanilla-MVC
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
![](session-06/gitignore.txt)

Use the following command to copy the file, and rename it, into your project's root folder:

```bash
cp -f ~/Downloads/gitignore.txt .gitignore
```

## Folder Structure

Now we create the various folders we need for the project:
```shell
mkdir -p {App,Framework,public,config,src}
mkdir -p App/{controllers,views}
mkdir -p Framework/middleware
mkdir -p public/assets/{css,js,img,downloads}
```

Next we create empty files in the folders. We are using empty `.gitignore` files are they are useful if we want to force particular folders to be included, or excluded.

```shell
touch public/assets/{css,js,img,downloads}/.gitignore
touch {App,Framework,public,config,src}/.gitignore
touch App/{controllers,views}/.gitignore
touch Framework/middleware/.gitignore
touch src/source.css
```


## Opening the new Project in PhpStorm

Open PhpStorm, and use the "hamburger" menu:

![Image: Hamburger Icon](assets/Pasted%20image%2020240827112528.png)

 Then click File, and click Open option:
 
![image: File - Open dialog](assets/Pasted%20image%2020240827112545.png)

Locate and then double-click on the new `SaaS-Vanilla-MVC` folder. Click Open to open the project.

## Install TailwindCSS

Next we install TailwindCSS and its required components...

```bash
npm install -D tailwindcss
```

Now we can execute the TailwindCSS command to create it's configuration file.

```
npx tailwindcss init
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
        "./src/**/*.{html,js}",
        "./**/*.{html,js,php}"
    ],
    theme: {
        extend: {},
    },
    plugins: [],
}
```


### Git: Commit changes

In the command line use:

```bash
git add .
```

This adds all added and  modified files to the staging area...

```bash
git commit -m "init: Start of Vanilla PHP MVC Project"
```

We will deal with pushing this to GitHub later...

## Running TailwindCSS' Transpiler

Now return to your CLI and run the command:

```bash
npx tailwindcss -i src/source.css -o public/assets/css/site.css --watch
```

This will continuously watch whilst we build the interface and code for the MVC application.

What did the command say to you?

### Previewing

Open Laragon, make sure that the Site Root is pointing at your `source/repos` folder, and then click Start All.

Open a browser and visit: http://SaaS-Vanilla-MVC.test

What did you get?

## Creating the Template

Create a new `index.php` file in the public folder.

Make sure the top of the file reads similar to this:

```php
<?php
/**
 * Home Page Demo using TailwindCSS
 *
 * Filename:        index.php
 * Location:        public/
 * Project:         SaaS-FED-Tailwind-Demo
 * Date Created:    21/08/2024
 *
 * Author:          YOUR NAME
 *
 */
 ?>
```

> **Note:** We used the close PHP tag.

Press enter to put yourself on a new line AFTER the `?>` and type in: `html:5` and press the <key>TAB</key> key.

You will now have a basic HTML 5 template with the required base head area.

Modify this template to read:
```html
<!doctype html>
<html lang="en_AU">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Demo!</title>

    <!-- Stylesheets -->
    <link rel="stylesheet" href="css/site.css">

    <!-- JavaScripts -->

</head>
```

In the body, update to read:

```html
<body>
header>h1+nav>ul>li*5>a[href=#]{Link $}
```

At the end of the second line, make sure there are no spaces and press <key>TAB</key> to expand the content.

This is called Emmet Coding (or Zen coding), because 'everything is awesome...' 

More on Emmet abbreviations here: https://docs.emmet.io/abbreviations/

### Preview

Head back to you browser and refresh...

What did you get?

## Style: Modify the `header`...

Go back and edit the `index.php` file...

Modify the lines as shown:

```html
<header class="bg-zinc-800 text-white p-4 flex mb-8">
    <h1 class="text-3xl">DEMO</h1>
    <nav class="flex-grow ml-8">
        <ul class="flex gap-4">
```

What happens when you refresh your preview?

| class         | action                                  |
| ------------- | --------------------------------------- |
| `bg-zinc-800` | set the background to dark zink         |
| `text-white`  | white text                              |
| `p-4`         | add 1 rem padding around all four sides |
| `mb-8`        | add 2 rem margin at the bottom          |
| `text-3xl`    | 3x extra large text                     |
| `flex`        | use the flex-box layout model           |
| `flex-grow`   | grow this item to fill the gap          |
| `gap-4`       | add a 1rem gap between each item        |

## Style: Modify the `nav`igation...

Now we will update the list items in the navigation.

We show just one, you will need to update the others to match...

```html
<li>
<a href="#"
   class="px-4 py-2 border-0 border-b-2
          hover:text-amber-500
          hover:border-amber-500
          transition ease-in-out duration-300 ">
       Link 1
   </a>
</li>
```

| class              | action                                                                 |
| ------------------ | ---------------------------------------------------------------------- |
| `py-2`             | add 1/2 rem padding on the top and bottom                              |
| `px-4`             | add 1 rem padding on the left and right sides                          |
| `border-0`         | add a border that is 0 pixels wide                                     |
| `border-b-2`       | add a 2px wide border to the bottom of the element                     |
| `hover:`           | apply this style when the element is hovered over                      |
| `text-amber-500`   | make the text midpoint (base) amber in colour                          |
| `border-amber-500` | make the border midpoint amber in colour                               |
| `transistion`      | transition colour, position and so on...                               |
| `ease-in-out`      | use the ease-in-out easing style (slow start and end, quick in middle) |
| `duration-300`     | take 0.3 seconds to transition from one state to the next when hovered |

### Preview

First check what has happened in the Bash command line... it will hopefully have something like:

```text

Rebuilding...

Done in 387ms.
```

In fact, every time you save the file (or more precisely when PhpStorm saves it as you change windows), the HTML, JS and PHP files are scanned and the `tailwindcss` executable updates the `site.css` file!

Refresh your browser and check what has happened.

Try hovering your mouse over the items in the navigation area.

## Add `main` content wrapper

Add the main content wrapper using:
```html
main>article>(header>h2)+(section>p*3>lorem)
```
Remember to press <key>TAB</key> immediately after the `lorem)`.

### Preview...

Go back to your browser and refresh... what is added?

## Style: Main content...

Start by modifying the main, article and header.

```html
<main class="container flex flex-col min-h-screen">
    <article class="w-8/12 mx-auto bg-white p-4 pb-6 shadow-md shadow-black/30 rounded-lg">
        <header class="bg-zinc-200 p-4 text-xl -mt-4 -mx-4 mb-2 rounded-t-lg">
```

**Question:** What do you think each of these do:
- `container`
- `flex-col`
- `min-h-screen`
- `w-8/12`
- `mx-auto`
- `shadow-md`
- `rounded-lg`
- `-mt-4`
- `-mx-4`
- `rounded-t-lg`

If in doubt, have a look at the TailwindCSS documentation ([(https://tailwindcss.com/docs](https://tailwindcss.com/docs)), and search for each one.

## Style: `article`'s section...

Now modify the `<section>` to read:

```html
        <section class="flex flex-col gap-4">

```

### Preview

Do the page refresh in the browser...

Remember: <key>CTRL</key>+<key>F5</key> on PC will force the browser to check for updated files such as CSS, and also remember that the TailwindCSS transpiling may take a few moments.

## The `footer`

We are now onto the footer.

Make sure you are on a blank line immediately before the `</body>` tag.

Type in the following and press <key>TAB</key> to expand...

```html
footer>section*3>p{Placeholder}
```

### Preview

I know this may be tedious, but doing this preview will help you see what is happening...

## Style: Add footer style...

Now modify the newly inserted `<footer>...</footer>`...

Edit the code to read:
```html
<footer class="mt-8 bg-zinc-700 text-zinc-200 pt-4 pb-8 px-8 flex">
```

Modify the first section to be:

```html
<section class="flex-grow">
```

The second section becomes:

```html
<section class="flex-grow text-center">
```
and the third section then becomes:

```html
    <section class="flex-grow text-right">
```

### Preview...

what's the result?

![Example of site preview](../assets/Pasted%20image%2020240827104504.png)

## Colour and TailwindCSS

We have used just White, Zinc and Black in this example.

Here is a table of colours that TailwindCSS comes with by default... experiment by changing the colours used in the various parts of the code above.

| Name    | 50                                              | 100                                             | 200                                             | 300                                             | 400                                             | 500                                             | 600                                             | 700                                             | 800                                             | 900                                             | 950                                             |     |
| ------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | --- |
| slate   | <span style="background:#F8FAFC">#F8FAFC</span> | <span style="background:#F1F5F9">#F1F5F9</span> | <span style="background:#E2E8F0">#E2E8F0</span> | <span style="background:#CBD5E1">#CBD5E1</span> | <span style="background:#94A3B8">#94A3B8</span> | <span style="background:#64748B">#64748B</span> | <span style="background:#475569">#475569</span> | <span style="background:#334155">#334155</span> | <span style="background:#1E293B">#1E293B</span> | <span style="background:#0F172A">#0F172A</span> | <span style="background:#020617">#020617</span> |     |
| gray    | <span style="background:#F9FAFB">#F9FAFB</span> | <span style="background:#F3F4F6">#F3F4F6</span> | <span style="background:#E5E7EB">#E5E7EB</span> | <span style="background:#D1D5DB">#D1D5DB</span> | <span style="background:#9CA3AF">#9CA3AF</span> | <span style="background:#6B7280">#6B7280</span> | <span style="background:#4B5563">#4B5563</span> | <span style="background:#374151">#374151</span> | <span style="background:#1F2937">#1F2937</span> | <span style="background:#111827">#111827</span> | <span style="background:#030712">#030712</span> |     |
| zinc    | <span style="background:#FAFAFA">#FAFAFA</span> | <span style="background:#F4F4F5">#F4F4F5</span> | <span style="background:#E4E4E7">#E4E4E7</span> | <span style="background:#D4D4D8">#D4D4D8</span> | <span style="background:#A1A1AA">#A1A1AA</span> | <span style="background:#71717A">#71717A</span> | <span style="background:#52525B">#52525B</span> | <span style="background:#3F3F46">#3F3F46</span> | <span style="background:#27272A">#27272A</span> | <span style="background:#18181B">#18181B</span> | <span style="background:#09090B">#09090B</span> |     |
| neutral | <span style="background:#FAFAFA">#FAFAFA</span> | <span style="background:#F5F5F5">#F5F5F5</span> | <span style="background:#E5E5E5">#E5E5E5</span> | <span style="background:#D4D4D4">#D4D4D4</span> | <span style="background:#A3A3A3">#A3A3A3</span> | <span style="background:#737373">#737373</span> | <span style="background:#525252">#525252</span> | <span style="background:#404040">#404040</span> | <span style="background:#262626">#262626</span> | <span style="background:#171717">#171717</span> | <span style="background:#0A0A0A">#0A0A0A</span> |     |
| stone   | <span style="background:#FAFAF9">#FAFAF9</span> | <span style="background:#F5F5F4">#F5F5F4</span> | <span style="background:#E7E5E4">#E7E5E4</span> | <span style="background:#D6D3D1">#D6D3D1</span> | <span style="background:#A8A29E">#A8A29E</span> | <span style="background:#78716C">#78716C</span> | <span style="background:#57534E">#57534E</span> | <span style="background:#44403C">#44403C</span> | <span style="background:#292524">#292524</span> | <span style="background:#1C1917">#1C1917</span> | <span style="background:#0C0A09">#0C0A09</span> |     |
| red     | <span style="background:#FEF2F2">#FEF2F2</span> | <span style="background:#FEE2E2">#FEE2E2</span> | <span style="background:#FECACA">#FECACA</span> | <span style="background:#FCA5A5">#FCA5A5</span> | <span style="background:#F87171">#F87171</span> | <span style="background:#EF4444">#EF4444</span> | <span style="background:#DC2626">#DC2626</span> | <span style="background:#B91C1C">#B91C1C</span> | <span style="background:#991B1B">#991B1B</span> | <span style="background:#7F1D1D">#7F1D1D</span> | <span style="background:#450A0A">#450A0A</span> |     |
| orange  | <span style="background:#FFF7ED">#FFF7ED</span> | <span style="background:#FFEDD5">#FFEDD5</span> | <span style="background:#FED7AA">#FED7AA</span> | <span style="background:#FDBA74">#FDBA74</span> | <span style="background:#FB923C">#FB923C</span> | <span style="background:#F97316">#F97316</span> | <span style="background:#EA580C">#EA580C</span> | <span style="background:#C2410C">#C2410C</span> | <span style="background:#9A3412">#9A3412</span> | <span style="background:#7C2D12">#7C2D12</span> | <span style="background:#431407">#431407</span> |     |
| amber   | <span style="background:#FFFBEB">#FFFBEB</span> | <span style="background:#FEF3C7">#FEF3C7</span> | <span style="background:#FDE68A">#FDE68A</span> | <span style="background:#FCD34D">#FCD34D</span> | <span style="background:#FBBF24">#FBBF24</span> | <span style="background:#F59E0B">#F59E0B</span> | <span style="background:#D97706">#D97706</span> | <span style="background:#B45309">#B45309</span> | <span style="background:#92400E">#92400E</span> | <span style="background:#78350F">#78350F</span> | <span style="background:#451A03">#451A03</span> |     |
| yellow  | <span style="background:#FEFCE8">#FEFCE8</span> | <span style="background:#FEF9C3">#FEF9C3</span> | <span style="background:#FEF08A">#FEF08A</span> | <span style="background:#FDE047">#FDE047</span> | <span style="background:#FACC15">#FACC15</span> | <span style="background:#EAB308">#EAB308</span> | <span style="background:#CA8A04">#CA8A04</span> | <span style="background:#A16207">#A16207</span> | <span style="background:#854D0E">#854D0E</span> | <span style="background:#713F12">#713F12</span> | <span style="background:#422006">#422006</span> |     |
| lime    | <span style="background:#F7FEE7">#F7FEE7</span> | <span style="background:#ECFCCB">#ECFCCB</span> | <span style="background:#D9F99D">#D9F99D</span> | <span style="background:#BEF264">#BEF264</span> | <span style="background:#A3E635">#A3E635</span> | <span style="background:#84CC16">#84CC16</span> | <span style="background:#65A30D">#65A30D</span> | <span style="background:#4D7C0F">#4D7C0F</span> | <span style="background:#3F6212">#3F6212</span> | <span style="background:#365314">#365314</span> | <span style="background:#1A2E05">#1A2E05</span> |     |
| green   | <span style="background:#F0FDF4">#F0FDF4</span> | <span style="background:#DCFCE7">#DCFCE7</span> | <span style="background:#BBF7D0">#BBF7D0</span> | <span style="background:#86EFAC">#86EFAC</span> | <span style="background:#4ADE80">#4ADE80</span> | <span style="background:#22C55E">#22C55E</span> | <span style="background:#16A34A">#16A34A</span> | <span style="background:#15803D">#15803D</span> | <span style="background:#166534">#166534</span> | <span style="background:#14532D">#14532D</span> | <span style="background:#052E16">#052E16</span> |     |
| emerald | <span style="background:#ECFDF5">#ECFDF5</span> | <span style="background:#D1FAE5">#D1FAE5</span> | <span style="background:#A7F3D0">#A7F3D0</span> | <span style="background:#6EE7B7">#6EE7B7</span> | <span style="background:#34D399">#34D399</span> | <span style="background:#10B981">#10B981</span> | <span style="background:#059669">#059669</span> | <span style="background:#047857">#047857</span> | <span style="background:#065F46">#065F46</span> | <span style="background:#064E3B">#064E3B</span> | <span style="background:#022C22">#022C22</span> |     |
| teal    | <span style="background:#F0FDFA">#F0FDFA</span> | <span style="background:#CCFBF1">#CCFBF1</span> | <span style="background:#99F6E4">#99F6E4</span> | <span style="background:#5EEAD4">#5EEAD4</span> | <span style="background:#2DD4BF">#2DD4BF</span> | <span style="background:#14B8A6">#14B8A6</span> | <span style="background:#0D9488">#0D9488</span> | <span style="background:#0F766E">#0F766E</span> | <span style="background:#115E59">#115E59</span> | <span style="background:#134E4A">#134E4A</span> | <span style="background:#042F2E">#042F2E</span> |     |
| cyan    | <span style="background:#ECFEFF">#ECFEFF</span> | <span style="background:#CFFAFE">#CFFAFE</span> | <span style="background:#A5F3FC">#A5F3FC</span> | <span style="background:#67E8F9">#67E8F9</span> | <span style="background:#22D3EE">#22D3EE</span> | <span style="background:#06B6D4">#06B6D4</span> | <span style="background:#0891B2">#0891B2</span> | <span style="background:#0E7490">#0E7490</span> | <span style="background:#155E75">#155E75</span> | <span style="background:#164E63">#164E63</span> | <span style="background:#083344">#083344</span> |     |
| sky     | <span style="background:#F0F9FF">#F0F9FF</span> | <span style="background:#E0F2FE">#E0F2FE</span> | <span style="background:#BAE6FD">#BAE6FD</span> | <span style="background:#7DD3FC">#7DD3FC</span> | <span style="background:#38BDF8">#38BDF8</span> | <span style="background:#0EA5E9">#0EA5E9</span> | <span style="background:#0284C7">#0284C7</span> | <span style="background:#0369A1">#0369A1</span> | <span style="background:#075985">#075985</span> | <span style="background:#0C4A6E">#0C4A6E</span> | <span style="background:#082F49">#082F49</span> |     |
| blue    | <span style="background:#EFF6FF">#EFF6FF</span> | <span style="background:#DBEAFE">#DBEAFE</span> | <span style="background:#BFDBFE">#BFDBFE</span> | <span style="background:#93C5FD">#93C5FD</span> | <span style="background:#60A5FA">#60A5FA</span> | <span style="background:#3B82F6">#3B82F6</span> | <span style="background:#2563EB">#2563EB</span> | <span style="background:#1D4ED8">#1D4ED8</span> | <span style="background:#1E40AF">#1E40AF</span> | <span style="background:#1E3A8A">#1E3A8A</span> | <span style="background:#172554">#172554</span> |     |
| indigo  | <span style="background:#EEF2FF">#EEF2FF</span> | <span style="background:#E0E7FF">#E0E7FF</span> | <span style="background:#C7D2FE">#C7D2FE</span> | <span style="background:#A5B4FC">#A5B4FC</span> | <span style="background:#818CF8">#818CF8</span> | <span style="background:#6366F1">#6366F1</span> | <span style="background:#4F46E5">#4F46E5</span> | <span style="background:#4338CA">#4338CA</span> | <span style="background:#3730A3">#3730A3</span> | <span style="background:#312E81">#312E81</span> | <span style="background:#1E1B4B">#1E1B4B</span> |     |
| violet  | <span style="background:#F5F3FF">#F5F3FF</span> | <span style="background:#EDE9FE">#EDE9FE</span> | <span style="background:#DDD6FE">#DDD6FE</span> | <span style="background:#C4B5FD">#C4B5FD</span> | <span style="background:#A78BFA">#A78BFA</span> | <span style="background:#8B5CF6">#8B5CF6</span> | <span style="background:#7C3AED">#7C3AED</span> | <span style="background:#6D28D9">#6D28D9</span> | <span style="background:#5B21B6">#5B21B6</span> | <span style="background:#4C1D95">#4C1D95</span> | <span style="background:#2E1065">#2E1065</span> |     |
| purple  | <span style="background:#FAF5FF">#FAF5FF</span> | <span style="background:#F3E8FF">#F3E8FF</span> | <span style="background:#E9D5FF">#E9D5FF</span> | <span style="background:#D8B4FE">#D8B4FE</span> | <span style="background:#C084FC">#C084FC</span> | <span style="background:#A855F7">#A855F7</span> | <span style="background:#9333EA">#9333EA</span> | <span style="background:#7E22CE">#7E22CE</span> | <span style="background:#6B21A8">#6B21A8</span> | <span style="background:#581C87">#581C87</span> | <span style="background:#3B0764">#3B0764</span> |     |
| fuchsia | <span style="background:#FDF4FF">#FDF4FF</span> | <span style="background:#FAE8FF">#FAE8FF</span> | <span style="background:#F5D0FE">#F5D0FE</span> | <span style="background:#F0ABFC">#F0ABFC</span> | <span style="background:#E879F9">#E879F9</span> | <span style="background:#D946EF">#D946EF</span> | <span style="background:#C026D3">#C026D3</span> | <span style="background:#A21CAF">#A21CAF</span> | <span style="background:#86198F">#86198F</span> | <span style="background:#701A75">#701A75</span> | <span style="background:#4A044E">#4A044E</span> |     |
| pink    | <span style="background:#FDF2F8">#FDF2F8</span> | <span style="background:#FCE7F3">#FCE7F3</span> | <span style="background:#FBCFE8">#FBCFE8</span> | <span style="background:#F9A8D4">#F9A8D4</span> | <span style="background:#F472B6">#F472B6</span> | <span style="background:#EC4899">#EC4899</span> | <span style="background:#DB2777">#DB2777</span> | <span style="background:#BE185D">#BE185D</span> | <span style="background:#9D174D">#9D174D</span> | <span style="background:#831843">#831843</span> | <span style="background:#500724">#500724</span> |     |
| rose    | <span style="background:#FFF1F2">#FFF1F2</span> | <span style="background:#FFE4E6">#FFE4E6</span> | <span style="background:#FECDD3">#FECDD3</span> | <span style="background:#FDA4AF">#FDA4AF</span> | <span style="background:#FB7185">#FB7185</span> | <span style="background:#F43F5E">#F43F5E</span> | <span style="background:#E11D48">#E11D48</span> | <span style="background:#BE123C">#BE123C</span> | <span style="background:#9F1239">#9F1239</span> | <span style="background:#881337">#881337</span> | <span style="background:#4C0519">#4C0519</span> |     |

## Git: Commit the changes

We are now ready to commit our changesd at this point.

Execute:
```bash
git add .
```

This will add the `index.php` file, and the compiled `site.css` file to the staging area.

Execute:

```bash
git commit -m "feat(template): Create & style site template"
```

## Git & GitHub: Creating & Pushing the Project

Now we are going to cheat a little by using PhpStorm's ability to communicate with GitHub.

Click on the hamburger, then hover over the Git menu, move down to GitHub and then click on the Share Project on GitHub option.

![Image: Hamburger->git->Github->Share Project](assets/Pasted%20image%2020240827113920.png)

What happens next will depend  on if you have manged to use GitHub before and pushed content to the remote.

You may need to connect to your account.

Once you have connected, PhpStorm will then load your account information, and at the same time it will check to see if the repository name has been used before (it defaults to the project name).

![image: PhpStorm checking the GiHub account](assets/Pasted%20image%2020240827114208.png)

Once complete, if it finds the repository name already, it will warn you. In that case, we suggest using a modified name such as `SaaS-Vanilla-PHP-MVC` instead.

![](assets/Pasted%20image%2020240827114230.png)

Note we have made the repository public as it is a demo, not an assessment.

Once this dialog appears, click the share button.

You have successfully pushed the work to GitHub.
