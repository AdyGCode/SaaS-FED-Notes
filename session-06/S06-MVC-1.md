

# MVC Part 1

Use these BASH  commands in your Source/Repos folder:

```bash
mkdir -P SaaS-Vanilla-MVC/{App,Framework,public,config,src}
mkdir -P mvc/App/{controllers,views}
mkdir -P mvc/Framework/middleware
mkdir -P mvc/public/assets/{css,js,img,downloads}
touch mvc/public/assets/{css,js,img,downloads}/.gitignore
touch mvc/{App,Framework,public,config,src}/.gitignore
touch mvc/App/{controllers,views}/.gitignore
touch mvc/Framework/middleware/.gitignore
touch mvc/src/source.css

cd mvc
npx tailwind init
```

Open PHPStorm, and use the hamburger --> File --> Open menu option...
Locate and then double-click on the new `mvc` folder.
Click Open to open the project.

Open the tailwind.config.js file and update to read:

```js
/**
 * Tailwind Configuration File
 *
 * Filename:        tailwind.config.js
 * Location:        /
 * Project:         mvc
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

Now return to your CLI and run the command:

```bash
npx tailwindcss -i src/source.css -o public/assets/css/site.css --watch
```

This will continuously watch whilst we build the interface and code for the MVC application.




Open Laragon, make sure that the Site Root is pointing at your source/repos folder, and then click Start All.

Open a browser and visit: http://SaaS-Vanilla-MVC.test

What did you get?





