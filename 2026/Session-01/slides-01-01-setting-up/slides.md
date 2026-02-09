---
theme: nmt
background: https://cover.sli.dev
title: Session 01 - Setting Up
class: text-left
drawings:
  persist: false
transition: fade
mdc: true
duration: 35min
addons:
  - Announcement
---

# Session 01: Setting Up

## SaaS 1 – Cloud Application Development (Front-End Dev)

### Setting Up for Development

<div @click="$slidev.nav.next" class="mt-12 -mx-4 p-4" hover:bg="white op-10">
<p>Press <kbd>Space</kbd> or <kbd>RIGHT</kbd> for next slide/step <fa7-solid-arrow-right /></p>
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/adygcode/SaaS-FED-Notes" target="_blank" class="slidev-icon-btn">
    <fa7-brands-github class="text-zinc-300 text-3xl -mr-2"/>
  </a>
</div>


<!--
We have a set of requirements that we use for our development work, this 
presentation takes you through setting up in our TAFE labs, and a good 
guide for Windows 11 users at home.
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
layout: two-cols
level: 1
class: text-left
---

# Objectives

- What do I need
- Network Account
- Set up Laragon
- Set up Windows Terminal
- Set up Bash Aliases
- Set up PhpStorm

---
level: 2
---

# Contents

<Toc minDepth="1" maxDepth="1" />

---
class: text-left
---

# What do I need?

The college provides you with:

- Office 365 Account
- TDM Account (Room 3-06)
- Windows 11 based system
- Software for class
    - IDE: PhpStorm & Student Licence
    - MS Terminal
    - Laragon v6
    - Git
    -

---

# Network Accounts

- TAFE Office 365 account
    - Login to PC using your `STUDENT_ID` & Password
    - Login to Office 365 using `STUDENT_ID@tafe.wa.edu.au`

- TDM Account (Rm 3-06)
    - Username
        - Up to 5 letters of surname
        - 1 or more letters of given name
        - e.g. John Smith : `smithj`
        - e.g. Yi Ho : `hoyi`
    - Password
        - Default is `Password1`

---

# Laragon v6 - Setting up

- Installed by default
- Updated components
    - Available from Repository
    - Download:
        - `https://github.com/AdyGCode/NMTAFE-Laragon-v6`

## At home

- We suggest using the ZIP version
- Uncompress to `c:\laragon`
- ...

---

# Laragon Components

We have multiple ways of updating the Laragon installation.

1. Use the Tools - Add menu option
2. Download zip files and uncompress to correct location

With the first option (1)

- we are also able to create a customised
  "configuration file"
- which provides the required files and places them
  automatically in the right spot.

With the second option (2),

- we will need to make sure we get the correct files,
- uncompress and move to the correct location.

---

## Option 1 Steps

To make life easier, Laragon v8 and v6 use a configuration file.

We can replace this with our own version, which you may download from the
NMTAFE Laragon Repository.

- Download the packages.conf file
- Move the file to the usr folder in the Laragon installation
- Use the Tools - Add menu to add the required components

---

## Option 1 Steps: In more depth

- Download latest [`packages.conf`](https://github.com/AdyGCode/NMTAFE-Laragon-v6/releases/download/v1.2/packages.conf)


#### **MS DOS Terminal**

Open MS Terminal and execute the following...

For Home PCs/Room 3-06:

```shell
move %UserProfile%\Downloads\packages.conf c:\Laragon\user\ 
```

For NM TAFE PCs:

```shell
move %UserProfile%\Downloads\packages.conf c:\ProgramData\Laragon\usr\ 
```
<br>

> Bash commands on next slide

---

#### **Using Bash Terminal**

Open MS Terminal and execute the following:

For Home PCs/Room 3-06:

```shell
mv /c/Users/USERNAME/Downloads/packages.conf /c/Laragon/usr/
```

For NM TAFE PCs:

```shell
mv /c/Users/USERNAME/Downloads/packages.conf /c/ProgramData/Laragon/usr/
```

---

## Option 2 Steps

- Download compressed file
- Uncompress file
- Move to required location

**Example: PHP 8.5**

- Download PHP 8.5 & Uncompress contents
- Open the folder `php-8.5.1-nts-Win32-vs17-x64`
- Move the inner `php-8.5.1-nts-Win32-vs17-x64` folder
    - to `C:\laragon\bin\php\` at home and Rm 3-06
    - to `C:\ProgramData\Laragon\bin\php` in TAFE Labs

Same principle for other components

<Announcement type="info" title="7-Zip">
Using 7-Zip you may not have a sub-folder
</Announcement>

---

# Recap Checklist

- [ ] Options for Home and College Development
- [ ] Installing Laragon
- [ ] Updating Laragon components

---
level: 2
---

# Exit Ticket

<Announcement type="question" title="Reflection on Setting Up">
<p>
Consider your requirements, including operating system, hardware, and 
software.
</p>
<p>
What are the key steps you need to take to set up your development environment for this course?
</p>
</Announcement>

---

# Acknowledgements

- Fu, A. (2020). Slidev. Sli.dev. https://sli.dev/
- Font Awesome. (2026). Font Awesome. Fontawesome.com; Font
  Awesome. https://fontawesome.com/
- Mermaid Chart. (2026). Mermaid.ai. https://mermaid.ai/

- Slide template
    - Adrian Gould

<br>

> - Mermaid syntax used for some diagrams
> - Some content was generated with the assistance of Microsoft CoPilot
