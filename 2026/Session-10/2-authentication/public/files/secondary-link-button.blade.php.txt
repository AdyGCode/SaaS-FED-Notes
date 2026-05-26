<a {{ $attributes->merge([
        'class' => 'inline-flex items-center
                    px-4 py-2
                    bg-white hover:bg-zinc-50
                    border border-zinc-300 rounded-md
                    font-semibold text-xs text-zinc-700 uppercase tracking-widest
                    shadow-sm
                    focus:outline-none focus:ring-2 focus:ring-sky-500 focus:ring-offset-2
                    disabled:opacity-25
                    transition ease-in-out duration-150',
        ])
    }}>
    {{ $slot }}
</a>

