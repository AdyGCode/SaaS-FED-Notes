@props(['rows' => 3, 'value'=>null])

<textarea
      {{ $attributes->merge([
            'class' => 'p-2 py-1 block w-full
                        border
                        border-zinc-300 focus:border-sky-300
                        focus:ring focus:ring-sky-200
                        rounded-md shadow-sm',
            'rows' => $rows]) }}
>{{ $value ?? null }}</textarea>
