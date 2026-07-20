# Slidev Theme (NMT) - Setup, Development and PDF Export Guide

This guide explains how to install, configure, build and export the **NMT Slidev presentations** used for the SaaS course materials.

---

# Prerequisites

Install the following software before beginning.

| Software | Notes |
|----------|------|
| Node.js | Version 20 LTS or newer recommended |
| npm | Installed with Node.js |
| Git | For cloning and updating repositories |

Verify the installation:

```bash
node --version
npm --version
git --version
```

---

# Open the Project

On the college computers the presentations are located at:

```text
/c/ProgramData/Laragon/www/Sources/Repos/SaaS-FED-Notes/2026/Session-00/Slides-00-00-TITLE
```

Navigate to the project:

```bash
# Example file path for Session 00
cd /c/ProgramData/Laragon/www/Sources/Repos/SaaS-FED-Notes/2026/Session-00/Slides-00-00-TITLE
```

---

# First Time Installation

## Step 1 – Install the project dependencies

```bash
npm install
```

---

## Step 2 – Install the NMT Slidev Theme

If the theme is not already installed:

```bash
npm install github:adygcode/slidev-theme-nmt
```

Alternatively:

```bash
npm install slidev-theme-nmt
```

If you run `npm run build` before installing the theme, Slidev will automatically detect the missing theme and prompt:

```text
The theme "slidev-theme-nmt" was not found.
Do you want to install it now?
```

Simply answer:

```text
yes
```

---

## Step 3 – Install Playwright

Playwright is required for PDF export.

Install it once:

```bash
npm install --save-dev playwright-chromium
```

---

## Step 4 – Install Chromium

Download the Playwright browser:

```bash
npx playwright install chromium
```

This only needs to be performed once on each computer.

---

# Verify the Installation

You should now have:

- Node.js
- npm
- Slidev
- slidev-theme-nmt
- Playwright
- Chromium

installed and ready to use.

---

# Starting the Presentation

Launch the development server:

```bash
npm run dev
```

The browser should automatically open.

If not, browse to:

```text
http://localhost:3030
```

---

# Editing Slides

All presentation content is stored in:

```text
slides.md
```

Simply edit the Markdown file.

Slidev automatically reloads the presentation after saving.

---

# Building the Presentation

To create a production-ready website:

```bash
npm run build
```

This creates:

```text
dist/
```

The **dist** folder contains:

- HTML
- CSS
- JavaScript
- Images
- Fonts
- Theme assets

This folder can be deployed directly to:

- GitHub Pages
- Netlify
- Vercel
- Apache
- Nginx
- IIS

---

# Previewing the Production Build

Open:

```text
dist/index.html
```

or host the folder using your preferred web server.

---

# Exporting to PDF

## Recommended Method (College Computers)

The college computers block the Playwright command-line browser, producing errors similar to:

```text
browserType.launch: spawn UNKNOWN
```

Therefore the recommended export method is the browser exporter.

### Step 1

Start the presentation.

```bash
npm run dev
```

---

### Step 2

Open the browser exporter.

```text
http://localhost:3030/export
```

---

### Step 3

Choose:

- PDF
- Export

The PDF will be generated directly from your browser.

This is the **recommended export method** for all college-managed computers.

---

# Optional Command Line Export

If using a personal computer without security restrictions, PDF export may also work from the terminal.

```bash
npm run export
```

If successful, a PDF will be generated in the project folder.

If you receive:

```text
browserType.launch: spawn UNKNOWN
```

simply use the browser exporter instead.

---

# Typical Workflow

First time only:

```bash
npm install
npm install github:adygcode/slidev-theme-nmt
npm install --save-dev playwright-chromium
npx playwright install chromium
```

Daily development:

```bash
npm run dev
```

Edit:

```text
slides.md
```

Preview:

```text
http://localhost:3030
```

Export:

```text
http://localhost:3030/export
```

Build for deployment:

```bash
npm run build
```

---

# Folder Structure

```
Slides-00-00-TITLE/
│
├── slides.md
├── package.json
├── components/
├── layouts/
├── public/
├── setup/
├── snippets/
├── theme/
├── dist/                 (generated)
└── node_modules/
```

---

# Useful Commands

| Command | Description |
|----------|-------------|
| `npm install` | Install all project dependencies |
| `npm install github:adygcode/slidev-theme-nmt` | Install the NMT Slidev theme |
| `npm install --save-dev playwright-chromium` | Install Playwright |
| `npx playwright install chromium` | Download the Chromium browser used for exporting |
| `npm run dev` | Start the Slidev development server |
| `npm run build` | Build a deployable static website into `dist/` |
| `npm run export` | Command-line PDF export (may not work on college PCs) |
| `http://localhost:3030/export` | Browser-based PDF export (recommended on college PCs) |

---

# Troubleshooting

## Theme Not Found

```text
The theme "slidev-theme-nmt" was not found.
```

Install the theme:

```bash
npm install github:adygcode/slidev-theme-nmt
```

---

## Playwright Missing

```text
The exporting for Slidev is powered by Playwright
```

Install Playwright:

```bash
npm install --save-dev playwright-chromium
```

---

## Chromium Missing

```text
Chromium executable doesn't exist
```

Install Chromium:

```bash
npx playwright install chromium
```

---

## Browser Launch Failed

```text
browserType.launch: spawn UNKNOWN
```

This is caused by Windows security policies on the college computers.

Use:

```text
http://localhost:3030/export
```

instead of the command-line exporter.

---

# Notes

- The browser exporter is the recommended PDF export method on college-managed computers.
- The `dist` folder is the deployable website version of the presentation.
- All presentation content is authored in Markdown (`slides.md`).
- The NMT theme will be automatically installed if missing during the first build.
- Avoid running `npm audit fix --force` unless you have tested the presentation afterwards, as upgrading dependencies may affect compatibility.
- The browser exporter produces the same visual output as the command-line exporter while avoiding the Playwright restrictions imposed on managed Windows devices.
