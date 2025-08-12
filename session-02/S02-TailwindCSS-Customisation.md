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
updated: 2025-08-12T17:23
---

# Customisation with TailwindCSS v4

So we now have a layout, but what if you want to customise things?

Well TailwindCSS provides a bunch of methods to customise the framework and thus, the look and feel of the page.

Here are a few:
- Create "macros" that represent items such as "standardised buttons" similar to Blueprint, Foundation and other "traditional" CSS Frameworks.
- Add custom Colours
- Change the Fonts
and more...

## 1. Custom Colours

 TailwindCSS uses the OKLCH colour mapping. This is because it provides a homogeneous brightness perception across the colours on screen.

> More on OKLCH here:
>
> Bornstein, N. G. (2024, January 24). _The New CSS Color Format You Didn’t Know You Needed; OKLCH()_. DEV Community. https://dev.to/greenteaisgreat/the-new-css-color-format-you-didnt-know-you-needed-oklch-10hf


Customisation happens via the `style.css` (or `app.css` in Laravel) file.

A common naming methodology for colours is to use 
- primary
- secondary
- tertiary

You may also add:
- error
- info
- success
- warning
- default
and other more semantic names as needed.


### 1.1. Adding  a Custom Colour

To add a new colour to the possible colours, we need to modify the `app.css` or `style.css` file.

In this file you define a new colour using the following basic template:

```css
@theme {  
  
    --color-NAME-VALUE: oklch(X Y Z);  
   
}
```

Note the `@theme` which wraps the customisation rule.

The rule uses CSS Variables, which are prefixed by the `--`. So we are creating a CSS variable called `color-NAME-VALUE`.

Let's add a new colour, `Avacado` (this is from the TailwindCSS docs):

```css
@theme {  
  
    --color-avocado: oklch(0.84 0.18 117.33);  
}
```

This is great, we can now colour our button avocado by using:

```html
<button class="bg-avacado"> ... </button>
```

You can also change the text to use the colour:

```html
<p class="text-avocado"> ... </p>
```

In fact, anywhere you may use a colour, you may use the colour's name!


### 1.2. Creating a "10 or 11 step Colour Gradient"

What you will note is that TailwindCSS gives colours that have `VALUE` from 50 to 900.

These colours have been carefully created so that they occupy the colour space consistently, and provide consistent luminosity and other factors across the range.

So how can we quickly define a multi-step colour range?

We can use any number of tools that are available on the web, including the ones shown below:

- UI Colours - https://uicolors.app/
- Tailwind Hues - https://www.tailwindhues.com
- Tints DEV - https://www.tints.dev/
- ...



#### 1.2.1 Tailwind Hues

With this application, you copy a HEX colour (or RGB colour, or any other colour definition) as a string, and paste it into the space indicated.

![](../assets/Pasted%20image%2020250812160406.png)

So, copying `#00b388` and pasting into the application generates the colours:

![](../assets/Pasted%20image%2020250812160427.png)

From here you may export the colours:

![](../assets/Pasted%20image%2020250812160500.png)

Which generates:

![](../assets/Pasted%20image%2020250812160525.png)

Which you may then coy using the button shown.

Once you have the colour copied you then paste it into the `@theme { }` in the `style.css` or `app.css` file.

Note that the default name for the colour is `primary`, so you may want to rename as needed, depending on the purpose of the colour. You could also use a name.

> Aside: if you use a name, then you cannot uses spaces or dashes. We strongly advise you use camel cased names (e.g. mountainMeadow).


#### 1.2.2 UIColors

This application presents colours as a preview as well as calculating the colour grid.

![](../assets/Pasted%20image%2020250812161711.png)

You may change the colour system using the button:

![](../assets/Pasted%20image%2020250812161726.png)

By default it is HEX, so we can paste a colour into the space provided:

![](../assets/Pasted%20image%2020250812161801.png)

From this we then can export the scheme by clicking export:

![](../assets/Pasted%20image%2020250812162025.png)

This gives a dialog box, where you select Tailwind v4 and HEX (unfortunately OKLCH is a premium feature 🙁).

![](../assets/Pasted%20image%2020250812162009.png)


#### 1.2.3 Others

You will see the other systems we listed all have similar capabilities, and we suggest you explore and find one you like using.


# 2. Fonts

Fonts are customisable, just like colours.

We define the fonts in the `@theme` as we did with colours.

Before you do, it is important to determine the font, or fonts you will use on the site.

In general, we strongly suggest no more than 3 fonts, and when possible only 1 or 2.

### 2.1 Sources of Fonts

There are many font hosting and sources around.

Some include:

- Google Fonts - https://fonts.google.com
- CDN Fonts = https://www.cdnfonts.com
- Font Source - https://fontsource.org
- XZ Fonts - https://fonts.xz.style
- Bunny Fonts - https://fonts.bunny.net
-  ...

### 2.2 Adding a New Font

To add a font you need to do two things:

- Decide on the font(s)
- Include the font(s) CDN (or self hosted copy) in the HTML Head section.
- Add the font(s) to the TailwindCSS `style.css` or `app.css` file.

### 2.2.1 Locate Font

After searching over the web, we decided to demo with a "display" type font from Bunny Net.

![](../assets/Pasted%20image%2020250812164050.png)

Settling on Corben:

![](../assets/Pasted%20image%2020250812164224.png)

We added the two variants... then clicked the Fonts+ button. We switched to the HTML variant and copied the code:

![](../assets/Pasted%20image%2020250812164348.png)

### 2.2.2 Add the Font Source (CDN) to the HTML page

Heading to the `index.html` page, we added the new font after the one we already have.

![](../assets/Pasted%20image%2020250812164513.png)

Our `index.html` file's `head` now looks like this:

```html
<!doctype html>  
<html lang="en_AU">  
<head>  
    <meta charset="UTF-8">  
    <meta name="viewport"  
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">  
    <meta http-equiv="X-UA-Compatible" content="ie=edge">  
    <title>Home | AJG</title>  
  
    <!-- Fonts -->  
    <link rel="preconnect" href="https://fonts.bunny.net">  
    <link href="https://fonts.bunny.net/css?family=corben:400,700" rel="stylesheet" />  
    <!-- CSS File -->  
    <link href="./src/style.css" rel="stylesheet">  
    <!-- JS Files -->  
  
</head>

```

### 2.2.3. Add font to the TailwindCSS `style` or `app` file

TailwindCSS has three default font names:

- font-sans
- font-serif
- font-mono

These are defined as:

```css
--font-sans: ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"; 

--font-serif: ui-serif, Georgia, Cambria, "Times New Roman", Times, serif; 

--font-mono: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
```

It is possible to add your own names by prefixing with `--font-`. For example `--font-display`.

You may override the defaults as well.

Now we open the `app.css` or `style.css` file and update the `@theme`, by overriding the serif default:

```css
@theme {
    --font-serif: 'Corben', ui-serif, Georgia, Cambria, "Times New Roman", Times, serif;

}
```


To test the font works as expected we will update the Navigation bar Company name to use the serif font:

```html
<h1>  
    <a class="flex title-font font-medium items-center text-gray-400 mb-4 md:mb-0">  
        <span><i class="fa fa-worm text-3xl text-gray-200"></i></span>  
        <span class="ml-3 text-xl inline-block font-serif">Quick Name</span>  
    </a>  
</h1>
```

You should now see the new font in action:

![](../assets/Pasted%20image%2020250812165453.png)


## 3. Macros, or Utility Classes

It is possible to create classes that are then used in place of the long list of TailwindCSS styles.

It will depend on what you are wanting to achieve, but in some cases it definitely has benefits.

Here is an example.

We are defining a `btn` utility:

```css
@utility btn {  
    @apply px-12 py-3 m-1 font-medium align-middle;  
    @apply bg-gray-200 hover:bg-gray-700;  
    @apply text-gray-700 hover:text-gray-200;  
    @apply border border-gray-400 hover:border-gray-900;  
    @apply hover:shadow-none shadow;  
    @apply rounded ;  
    @apply transition ease-in-out duration-500;  
    @apply inline-block;  
    @apply focus:ring-3 focus:outline-hidden w-1/2;
}
```

To use this, you add the code AFTER any `@theme` definitions.


Next we can define `layer components` by using `@layer components`.

Here is an example:

```css
/* Define Additional Button CSS classes
   that extend the `.btn` to use its own
   colours and other formatting
 */
@layer components {
    /* Primary Button Component */
	.btn-primary {  
	    @apply btn;  
	    @apply bg-avocado-200 hover:bg-avocado-700;  
	    @apply text-avocado-700 hover:text-avocado-200;  
	    @apply border border-avocado-700 hover:border-avocado-200;  
	}

}
```


Using these new classes is as easy as adding them to the HTML.

For example the Submit Button we have on the form:

```html
<button class="btn-primary">  
    Save  
</button>
```

## Conclusion

This is just a taste of what you can do with customising TailwindCSS to suit your needs.

