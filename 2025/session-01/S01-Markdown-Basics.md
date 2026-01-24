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
created: 2025-04-03T10:10
updated: 2025-04-28T18:00
---

# Markdown Basics

Another part of documentation is the ReadMe and user documentation.

Most projects today, use Markdown to create their documentation as it is lightweight, and
easy to learn and use.

In fact, Markdown uses less extra characters than HTML, but at the same time it does lose
some of the expressive semantics that modern HTML contains.

## Basic Syntax "Tags"

| Purpose         | 'Tag'                    | Notes                                                                                                                                                  |
|-----------------|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| Heading 1       | `#`                      | `# Page Header`                                                                                                                                        |
| Heading 2       | `##`                     | `## Sub heading`                                                                                                                                       |
| Heading 3       | `###`                    | `### Sub-Sub heading`                                                                                                                                  |
| Heading 4       | `####`                   | `#### Sub-Sub-Sub heading`                                                                                                                             |
| Heading 5       | `#####`                  | `##### Sub-Sub-Sub-Sub heading`                                                                                                                        |
| Heading 6       | `######`                 | `##### Sub-Sub-Sub-Sub-Sub heading`                                                                                                                    |
| Bold            | `**` or `__`              | The `**` are placed either side of the bolded text, e.g. `**bold**`                                                                                    |
| Italics         | `_` or `*`               | The `_` is placed eitehr   side of the text, e.g. `_italics_`                                                                                          |
| Blockquote      | `>`                      | `> This is a block quote` Additional lines start with `> `                                                                                             |
| Ordered List    | `1.`                     | `1. First item  ` <br>  `2. Second item  ` <br/>you can number yourself, or mark them all, and Markdown engines will work out the incremented numbers. |
| Unordered List  | `-`                      | `- First item` <br> `- Second item  `  <br> `- Third item `                                                                                            |
| Code            | \`code\`                 | \`name = name.upper()\`                                                                                                                                |
| Horizontal Rule | `---`                    |                                                                                                                                                        |
| Link            | `[link text](link uri)`  | `[SQuASH](https://help.screencraft.net.au)`                                                                                                            |
| Image           | `![alt text](image uri)` | `![alt text](image.jpg)`                                                                                                                               |

## Extended Syntax "tags"

These elements extend the basic syntax by adding additional features. Not all Markdown
applications support these elements.

Not all Markdown rendering engines are built the same, so some extensions may not work.

| Element	        | Markdown Syntax                                                                                                           | Notes                                                                                                                              |
|-----------------|---------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| Table           | `\| heading \| heading \| ...     \|`  <br>`\|---------\|----------\|-------\|` <br>`\| content \| centred \| content \|` |                                                                                                                                    |
| Code Block      | \`\`\`*language* <br>code here<br>\`\`\`                                                                                  | *Languages* usually recognised and syntax highlighted include shell, bash, cpp, c, csharp, python, ruby, php, js, ts, rs, and more |
| Footnote	       | `Sentence with a footnote. [^1]`<br>`[^1]: This is the footnote.`                                                         | The footnote text is usually added at the end of the document                                                                      |
| Heading ID      | `### My Great Heading {#custom-id}`                                                                                       | Useful for links within documents                                                                                                  |
| Definition List | `term` <br> `: definition`                                                                                                |                                                                                                                                    |
| Strikethrough   | `~~The world is flat.~~`                                                                                                  |                                                                                                                                    |
| Task List       | `- [x] Write release`<br>`- [ ] Update website`<br>`- [ ] Contact media`                                                  |                                                                                                                                    |
| Emoji           | `:emoji name:`                                                                                                            | `:laugh:`                                                                                                                          |
| Highlight       | `==very important words==`                                                                                                |                                                                                                                                    |
| Subscript       | `H~2~O`                                                                                                                   |                                                                                                                                    |
| Superscript     | `X^2^`                                                                                                                    |                                                                                                                                    |

### Extended Table Notes

Tables can have content aligned using colons (`:`).

| Left aligned  | centred         | right aligned  |
|---------------|-----------------|----------------|
| `\|-------\|` | `\|:-------:\|` | `\|-------:\|` |


## Example

Here is a small Markdown Example:
```md
### Extended table notes

Tables can have content aligned using colons (`:`).

| Left aligned  | centred         | right aligned  |
|---------------|-----------------|----------------|
| `\|-------\|` | `\|:-------:\|` | `\|-------:\|` |
```

> ⚠️ Notice that we had to include the `\` before the `|` in the example to escape 
> the table column separators.
> 
> Also, we inserted the emoji directly into this document, without using the syntax.

## Markdown and ReadMe Files

Version control repositories, such as GitHub and GitLab, have automatic rendering of Markdown 
included in their features.

When you put code into a remote repository on these systems, it is rendered into a web page.

One of the most important pages you can add to your code is a `ReadMe.md` file.

We provide a base ReadMe file for you to use.

You are able to access, and then download it, by 
clicking here: [Base ReadMe](../assets/ReadMe-Base.md).


#### Extract of the ReadMe Base File

```md

<a name="readme-top"></a>

(START)

TO DO: Make sure the Repository is PRIVATE

TO DO: Add Your lecturer as a contributor to the project repository, so
they are able to see your code, the commit history and other details 
within the repository.

TO DO: Add a one sentence overview/summary of this project.

Once complete, remove from `(START)` to `(END)`

(END)


#### Built With
```

We include instructions embedded in the ReadMe to assist in creating the file.

In the exercise, we will be asking you to create a ReadMe as a practice for the assessments.
