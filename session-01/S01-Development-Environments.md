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
date created: 03 July 2024
date modified: 07 July 2024
created: 2024-08-01T09:23
updated: 2024-09-10T16:36
---

# Development Environments

There are many ways you may complete your development.

Some are much simpler to use and maintain, whilst others give a closer to real world production environments for development and testing.

These development environments are across the whole of the Certificate IV in IT and Diploma of IT at North Metropolitan TAFE.

We show our default, and supported environment, plus we provide you with alternatives that you may use on your own devices (For general conditions on these. see the section on BYOD and the Product & Service Disclaimer sections).

```table-of-contents
title: # Contents
style: nestedList
minLevel: 0
maxLevel: 0
includeLinks: true
```

**This article is subject to update. Please check back regularly to see what the latest developments are**

### BYOD

> We **do not** officially support your BYOD even if they are Windows based systems.
> Any member of staff *has the right to refuse* to assist you with your personal devices during and after class time.
> If you are experiencing issues, then it is best to ask nicely and see if they are able to assist you **outside** of class time.

### Links

> The links with `{SC}` will take you to articles on the ScreenCraft Helpdesk to assist you in installing and/or updating the items above on a Windows based system. 

### Link Disclaimer

> We are not responsible for any cybersecurity issues that may be on external sites. 
> 
> Links to external sites are used by lecturers and staff. We attempt to prevent sites with malicious code, scam and phishing, and other cybersecurity issues being linked.  

### Product & Service Disclaimer

> By using particular systems and software, NM TAFE does not indicate its direct support for a business or 3rd party that develops and supports said software or system. 
> 
> Lecturers have their preferred tools and services which are a reflection on what they see in use in industry and what enhances your learning experience. 

## NM TAFE Standard Development Environment

Our preferred standard development environment at TAFE is:

- Windows 10/11

- Laragon ()
	- Provides all the basics, but we will need to update items such as Apache, MySQL/MariaDB, NodeJS
	- It is important to update the default software to at least: Apache 2.4.59, Node 20, PHP 8.2, 
		- [Apache 2.4.59+](https://help.screencraft.net.au/hc/2680392001/68/update-the-apache-web-server-in-laragon?category_id=29) {SC}
		- [PHP 8.2+](https://help.screencraft.net.au/hc/2680392001/67/add-a-new-version-of-php-to-laragon?category_id=29) {SC}
		- [NodeJS 20+](https://help.screencraft.net.au/hc/2680392001/84/update-nodejs-and-npm-in-laragon?category_id=35) {SC}
		- [MySQL 8+]() or [MariaDB 10+]()
		- [MailPit](https://help.screencraft.net.au/hc/2680392001/69/install-and-run-mailpit?category_id=29) {SC}
		- MongoDB {TO ADD DETAILS}

- IDEs
	- PhpStorm {TO ADD DETAILS}
	- PyCharm {TO ADD DETAILS}
	- Visual Studio {TO ADD DETAILS}

- DB Management
	- SQLite <https://sqlitebrowser.org> (Easily added to Laragon)
	- phpMyAdmin {TO ADD DETAILS} (Installable from within Laragon)
	- HeidiDB {TO ADD DETAILS} (Installable from within Laragon)
	- MongoDB…. {TO ADD DETAILS} (Easily added to Laragon)

- Programming Languages
	- Python 3.10+ {TO ADD DETAILS}
	- Dart & Flutter {TO ADD DETAILS}

- CLI Tools
	- Windows Terminal
	- Bash (Installed as part of Laragon's Git)

- Version Control
	- Git SCM {SC} (Installed with Laragon)

- Debugging tools
	- xdebug (for PHP)
- 

## Command Line Tools

For Command Line interaction, which is a vital part of modern development, we use Microsoft's Windows Terminal. We also use the version of Bash that comes with Git. Details and links to install these below:

- [Windows Terminal (MS Store)](https://apps.microsoft.com/detail/9n0dx20hk701?hl=en-us&gl=US) 
- [Setting Terminal as default CLI](https://learn.microsoft.com/en-us/windows/terminal/install) 
- [Git Bash in Windows Terminal](https://help.screencraft.net.au/hc/2680392001/65/add-git-bash-to-microsoft-terminal?category_id=35)  {SC}
- [Bash aliases for increased productivity](https://help.screencraft.net.au/hc/2680392001/66/add-bash-command-line-aliases-for-git?category_id=35)  {SC}
- [Windows Terminal Themes](https://windowsterminalthemes.dev)

# Other Recommended Tools

We have tried many different systems between us, and the following are a sample of what we have used in our time, and would still recommend investigating even if we are not currently using them.

## Development Environment Tools

- [DBngin](https://dbngin.com)
	- Platform(s): MacOS
- [Laravel Herd](https://herd.laravel.com/?ref=herd)
	- Platform(s): MacOS, Windows
- [Docker]()
	- Platform(s): MacOS, Linux, Windows (via WSL2)

## IDEs

- PhpStorm - Professional only
	- Professional free whilst studying
	- Platform(s): Windows, Linux, MacOS
- Visual Studio Code (VSCode) - Free
	- Platform(s): Windows, Linux, MacOS
- PyCharm - Community or Professional free whilst studying
	- Platform(s): Windows, Linux, MacOS
- CLion - Professional free whilst studying
	- Platform(s): Windows, Linux, MacOS
- Arduino -
	- Platform(s): Windows, Linux, MacOS

## Electronics Design & Simulation

- {TO ADD DETAILS}
	- Platform(s): Windows, Linux, MacOS

## Database Systems & Management Tools

There are many possible ways to manage the databases created and modified during development and testing. The following are possible alternatives, with some supporting just one database, whilst others may support multiple database platforms.

### Database Systems

Installation of these systems may not be possible on every Operating System, or will provide issues when doing so. 

- [MySQL]()
	- …
	- Platform(s): Windows, Linux, MacOS
- [MariaDB]()
	- …
	- Platform(s): Windows, Linux, MacOS
- [MongoDB]()
	- ….
	- Platform(s): Windows, Linux, MacOS
- [PostgreSQL]()
	- ….
	- Platform(s): Windows, Linux, MacOS
- [SQLite]()
	- ….
	- Platform(s): Windows, Linux, MacOS
- [...]()
	- ….
	- Platform(s): Windows, Linux, MacOS

### DB Management Tools

- [SQLite Browser](https://sqlitebrowser.org)
	- Platform(s): Windows, MacOS, Linux
	- Mac Users: If an Intel Mac make sure you download the Intel only
- [DBGate](https://dbgate.org)
	- Platform(s): Windows, MacOS, Linux
	- Supports: MySQL, PostgreSQL, MS SQL, Oracle, MongoDB, SQLite and more…
- [phpMyAdmin]()
	- Platform(s): Any that has an active web server
	- Supports: MySQL, MariaDB
- [dbBeaver]()
	- Platform(s): 
	- Supports:
- [Heidi DB]()
	- Platform(s): 
	- Supports: 
- …

## CLI Terminals

- [iTerm]()
	- Platform(s): MacOS
- [Warp]()
	- Platform(s): MacOS
- [Windows Terminal]() 
	- Platform(s): Windows

## Debugging Tools

- Xdebug 
	- is a useful debugging extension that may be integrated into PhpStorm and VSCode.
	- Platform(s): Windows, MacOS, Linux
	- Installation details - [Adding-XDebug](..\Session-02\Adding-XDebug.md)

# FAQs

Other useful FAQs are found here:

- [Laragon FAQs on ScreenCraft Helpdesk](https://help.screencraft.net.au/hc/2680392001/search?q=laragon) {SC}
- …

# Other Development Configurations

There are many other ways to develop with PHP, MySQL/MariaDB, NodeJS and associated tools. The details below are some of the options, and may be used at your own discretion.

| Configuration         | Windows | MacOS | Linux |
| --------------------- |:-------:|:-----:|:-----:|
| Laravel Sail & Docker | Y       | Y     | Y     |
| Laravel Herd & DBngin |         | Y     |       |
| Laravel Herd          | Y       |       |       |
| Docker                | Y       | Y     | Y     |
| XAMPP                 | Y       | Y     | Y     |
| MAMP/MAMP Pro         |         | Y     |       |
| …                     |         |       |       |
