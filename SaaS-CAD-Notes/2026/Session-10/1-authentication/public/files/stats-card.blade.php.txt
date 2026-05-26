@props([
    // Core content
    'icon' => 'fa-solid fa-font-awesome',   // Font Awesome 6 classes
    'title' => '',
    'value' => '',

    // Colors (defaults based on zinc)
    'bg' => 'bg-zinc-100',              // circle background
    'iconColor' => 'text-zinc-600',     // icon color

    // Sizes
    'circleClass' => 'w-16 h-16',       // circle dimensions
    'iconSize' => 'text-xl lg:text-2xl 2xl:text-4xl',

    // Card styling
    'cardClass' => 'rounded-lg bg-white  p-2 shadow shadow-zinc-500/50',
    'hover' => true,                    // enable hover effects

    // Optional text classes
    'titleClass' => 'text-sm text-zinc-500 uppercase',
    'valueClass' => 'text-2xl font-medium text-zinc-900',
])

@php
    // Hover toggles (kept simple & composable)
    $hoverCardBg = $hover ? 'hover:bg-zinc-700' : '';
    $hoverText   = $hover ? 'group-hover:text-white' : '';
    $hoverIcon   = $hover ? 'group-hover:-rotate-15' : '';
@endphp

<article class="group flex items-center gap-6 {{ $cardClass }} {{ $hoverCardBg }} transition ease-in-out  duration-500">
    <!-- Circular icon background -->
    <div class="flex ml-2 {{ $circleClass }} items-center justify-center rounded-full {{ $bg }} {{ $iconColor }}">
        <i class="{{ $icon }} {{ $iconSize }} transition-transform  ease-in-out duration-500 {{ $hoverIcon }}"
           aria-hidden="true"></i>
    </div>

    <!-- Text content -->
    <div>
        <p class="{{ $titleClass }} {{ $hoverText }}  ease-in-out duration-500">{{ $title }}</p>
        <p class="{{ $valueClass }} {{ $hoverText }}  ease-in-out duration-500">{{ $value }}</p>

        <!-- Optional extra content slot -->
        {{ $slot }}
    </div>
</article>
