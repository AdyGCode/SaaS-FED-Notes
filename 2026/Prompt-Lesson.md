
Given the following attached lesson plan, we are to produce a suitable set of lesson slides with presenter notes to cover the content within the document.

We will need:
- References (with URLs for web based references) to resources that related to the topics
- Code examples to demonstrate the principles
- Mermaid diagrams to assist in understanding
- Step by step instructions (with detail) for any practical learning (guided)
- Core steps (without precise detail) for student activities
- Terminology summary table for any term introduced within the lesson
- A mini project for demonstration of the principle (this will be expanded during subsequent sessions)
- Details for a suitable summary activity for the end of the session
- Other suitable activities for out of class learning and practice, with details of what is required

Remember that the lesson is conducted using Laragon for provision of the services such as web server, PHP, MariaDB, Redis et al. 

The technology used is PHP, Laravel 12, Postman (or an equivalent), Windows 11, git, the Bash terminal that is available with a git installation, and we will use SQLite for development and training.

Produce the presentation using Markdown, and the Slid-dev markdown presentation structure.


----------


-----------

Using Laravel 12 as the platform of choice for an MVC framework, we are to develop a set of slides and presenter notes that covers the following:

 - installing laravel installer
- setting up a new project
- folder structure of laravel
- MVC overview, terms and concepts
- Creating blade views
- built in Blade components
- Explain Blade syntax, escaping
- Blade template inheritance (@extends/@section/@yield syntax)
- Blade template inheritance (x-component/template syntax)
- How Tailwind is used by Blade

The slides should have sample code to illustrate concepts
Complement the slides with a set of steps to create a "contact us" page without the data being stored

Also create a set of multi select questions and answers (covering the details above, splitting the questions into groups: Installing Laravel & creating a project, folder structure of laravel, MVC terms and concepts, Blade views & syntax & inheritance), with 5 questions per group.


Please create a markdown document for the slides.

Slides are separated by `---`
The Presenter Notes are embedded as HTML comment blocks BEFORE the slide separator for the next slide.

The presentation slides will be separated into sections using:
---
layout: section
---
(3 lines)
between sections, and the slides within the section preceded by:
---
level: 2
---

Also generate two exit questions for the students to discuss and complete at the end of the session as a way to self assess their understanding.


Move the exit tickets to the last slide of the slidewhow and just before this a checklist of what was covered.
Also add a slide containing references to turotiials and additional information useful with the concepts covered so far in APA v7 format and us teh following marksown as an example:

- Font Awesome. (2026). *Font Awesome. Fontawesome.com*; **Font Awesome**. 
  https://fontawesome.com/


Then produce a downloadable file for the presentation, plus downloadable text files for the quiz questions (one file per group of questions) in the format:

TYPE[TAB]Question text[TAB]Answer A[TAB]correct|incorrect[TAB]Answer B[TAB]correct|incorrect ...
with MC = Multiple Choice, MA = Multiple Answer. No header row. English keywords correct/incorrect/true/false.
