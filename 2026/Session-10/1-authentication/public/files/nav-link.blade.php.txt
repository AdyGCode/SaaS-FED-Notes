@props(['active'])

@php
    $classes = ($active ?? false)
                ? 'inline-flex items-center px-1 pt-1 border-b-2 border-sky-400 text-sm font-medium leading-5 text-zinc-900 focus:outline-none focus:border-sky-700 transition duration-150 ease-in-out'
                : 'inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-zinc-500 hover:text-zinc-700 hover:border-zinc-300 focus:outline-none focus:text-zinc-700 focus:border-zinc-300 transition duration-150 ease-in-out';
@endphp

<a {{ $attributes->merge(['class' => $classes]) }}>
    {{ $slot }}
</a>
