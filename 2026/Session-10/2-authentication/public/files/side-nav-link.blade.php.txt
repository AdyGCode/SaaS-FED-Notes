@props(['active'])

@php
    $classes = ($active ?? false)
                ? 'block pl-3 pr-4 py-2 text-sm font-medium
                   text-zinc-100 hover:text-zinc-900
                   bg-zinc-600
                   hover:bg-zinc-300
                   border-0 border-l-4 border-zinc-400
                   focus:border-sky-700
                   focus:outline-none
                   transition duration-250 ease-in-out'
                : 'block pl-3 pr-4 py-2 text-sm font-medium
                   text-zinc-500 hover:text-zinc-900 focus:text-zinc-700
                   hover:bg-zinc-200
                   border-0 border-l-4 border-transparent
                   hover:border-zinc-700 focus:border-zinc-300
                   focus:outline-none
                   transition duration-250 ease-in-out';
@endphp

<a
    {{ $attributes->merge(['class' => $classes]) }}
>
    {{ $slot }}
</a>
