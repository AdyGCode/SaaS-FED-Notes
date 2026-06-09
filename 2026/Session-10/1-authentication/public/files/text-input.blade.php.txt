@props(['disabled' => false])

<input @disabled($disabled)
    {{ $attributes->merge([
    'class' => 'rounded-md p-2 py-1
                border-zinc-300 focus:border-sky-500
                focus:ring-sky-500
                rounded-md shadow shadow-zinc-500/50']) }}>
