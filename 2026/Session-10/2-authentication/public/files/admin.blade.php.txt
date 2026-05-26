<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet"/>

    <!-- Scripts -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="font-sans antialiased">
<div class="min-h-screen bg-zinc-100 flex flex-row">

    <nav class="basic-1/4 h-screen sticky top-0">
        @include('layouts/admin-navigation')
    </nav>

    <div class="grow flex flex-col">

        <!-- Page Heading -->
        @isset($header)
            <header class="bg-zinc-700 shadow">
                <div class="w-full py-6 px-4 sm:px-6 lg:px-8">
                    {{ $header }}
                </div>
            </header>
        @endisset

        <!-- Page Content -->
        <main class="h-max">
            {{ $slot }}
        </main>

    </div>
</div>
</body>
</html>
