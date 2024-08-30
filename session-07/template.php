<?php
/**
 * HTML Template using TailwindCSS
 *
 * Filename:        template.php
 * Location:        src
 * Project:         SaaS-Vanilla-MVC
 * Date Created:    30/08/2024
 *
 * Author:          Adrian Gould <Adrian.Gould@nmtafe.wa.edu.au>
 *
 */
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <link rel="stylesheet" href="assets/css/site.css">
</head>
<body class="bg-white flex flex-col h-screen justify-between">


<header class="bg-black text-white p-4 flex-grow-0 flex flex-row align-middle content-center">
    <h1 class="flex-0 w-32 text-xl p-4 ">
        <a href="#"
           class="py-4 px-4 -mx-4 -my-4 font-bold rounded text-sky-300 hover:text-sky-700 hover:bg-sky-300
                     transition ease-in-out duration-500">
            MVC
        </a>
    </h1>
    <nav class="flex flex-row gap-4 py-4 flex-grow">

        <p><a href="/"
              class="pb-2 px-1 text-text-zinc-700-200 hover:text-sky-300
                     border-0 border-b-2 hover:border-b-sky-500
                     transition ease-in-out duration-500">
                Home
            </a></p>

        <p><a href="/products"
              class="pb-2 px-1 text-text-zinc-700-200 hover:text-sky-300
                     border-0 border-b-2 hover:border-b-sky-500
                     transition ease-in-out duration-500">
                Products
            </a></p>

        <p class="flex-grow"></p>

        <form method="POST" action="/auth/logout" class="">
            <button class="pb-2 px-1 text-text-zinc-700-200 hover:text-sky-300
                     border-0 border-b-2 hover:border-b-sky-500
                     transition ease-in-out duration-500">
                <i class="fa fa-search"></i> Logout
            </button>
        </form>

        <form method="GET" action="/products/search" class="block mx-5">
            <input type="text" name="keywords" placeholder="Product search..."
                   class="w-full md:w-auto px-4 py-2 focus:outline-none"/>
            <button class="w-full md:w-auto bg-sky-500 hover:bg-sky-600 text-white px-4 py-2 focus:outline-none transition ease-in-out duration-500">
                <i class="fa fa-search"></i> Search
            </button>
        </form>

    </nav>
</header>


<main class="container mx-auto bg-zinc-50 py-8 px-4 shadow shadow-black/25 rounded-b-lg">
    <article>
        <header class="bg-zinc-700 text-zinc-200 -mx-4 -mt-8 p-8 text-2xl font-bold mb-8">
            <h1>Vanilla PHP MVC Demo</h1>
        </header>
        <section class="grid grid-cols-2 my-8 ">

            <section class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-row">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        Products:
                    </h4>
                </header>
                15            </section>
            <section class="max-w-96 min-w-64 bg-white shadow rounded p-2 grid grid-cols-3">
                <h4 class="-ml-2 mr-6 bg-zinc-700 text-zinc-200 text-lg p-4 -my-2 rounded-l col-span-1">
                    Users:
                </h4>
                <p class="col-span-2 text-2xl ml-6">
                    6                </p>
            </section>

        </section>
        <section class="flex flex-wrap gap-8 justify-stretch">
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        German Shepherd                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">BrickHeadz theme: A BrickHeadz pet set featuring a cute German Shepherd and puppy, great for dog lovers.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $19.99</p>
                    <a href="/products/40440"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        The Mandalorian & The Child BrickHeadz                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">Star Wars theme: A BrickHeadz double pack featuring The Mandalorian and The Child (Baby Yoda), perfect for fans of the popular Star Wars series.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $29.99</p>
                    <a href="/products/75317"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        Sheep BrickHeadz                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">BrickHeadz theme: This set features an adorable sheep with a cute, blocky design, perfect for collectors and fans of the BrickHeadz series.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $19.99</p>
                    <a href="/products/40380"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        Valentine's Bear                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">BrickHeadz theme: A seasonal BrickHeadz set featuring a charming Valentine's Bear holding a heart, ideal for Valentine's Day.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $19.99</p>
                    <a href="/products/40379"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        Dragon Dance                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">Seasonal theme: This Chinese New Year-themed set features a vibrant and detailed dragon dance scene, complete with minifigures and traditional decorations.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $89.99</p>
                    <a href="/products/40354"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
            <!--            article>(header>h4{Name})+(section>p{Description})+(footer>p{Price})-->
            <article class="max-w-96 min-w-64 bg-white shadow rounded p-2 flex flex-col">
                <header class="-mx-2 bg-zinc-700 text-zinc-200 text-lg p-4 -mt-2 mb-4 rounded-t flex-0">
                    <h4>
                        Naboo Starfighter Microfighter                        </h4>
                </header>
                <section class="flex-grow grid grid-cols-5">
                    <p class="ml-4 col-span-2">
                        <img class="w-24 h-24 " src="https://dummyimage.com/200x200/a1a1aa/fff&text=Image+Here"
                             alt="">
                    </p>
                    <p class="col-span-3 text-zinc-600">Star Wars theme: A compact, easy-to-build model of the Naboo Starfighter, perfect for young Star Wars fans.</p>
                </section>
                <footer class="-mx-2 bg-zinc-200 text-zinc-900 text-sm px-4 py-1 mt-4 -mb-2 rounded-b flex-0">
                    <p>Price: $15.99</p>
                    <a href="/products/75223"
                       class="block w-full text-center px-5 py-2.5 shadow-sm rounded border
                                  text-base font-medium text-zinc-700 bg-zinc-100 hover:bg-zinc-200">
                        Details
                    </a>
                </footer>
            </article>
        </section>

    </article>
</main>



<footer class="bg-black text-text-zinc-700-400 p-4 mt-8">
    The footer
</footer>

</body>
</html>

