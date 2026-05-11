<a {{ $attributes->merge([
        'class' => 'inline-flex items-center
                px-4 py-2
                bg-zinc-800 hover:bg-zinc-700 focus:bg-zinc-700 active:bg-zinc-900
                focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2
                border border-transparent rounded-md
                font-semibold text-xs uppercase tracking-widest
                text-white
                transition ease-in-out duration-150',
        ])
    }}>
    {{ $slot }}
</a>

