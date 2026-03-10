<script setup>
import {computed} from 'vue'

const props = defineProps({
  type: {
    type: String,
    default: 'default',
    validator: (v) =>
        ['default', 'error', 'warning', 'info', 'duration', 'important', 'priority','idea', 'brainstorm'].includes(v),
  },
  role: {
    type: String,
    default: '',
  },
  /** Compact variant (smaller) */
  compact: {
    type: Boolean,
    default: false,
  },
  /** Label shown before the slot content (optional) */
  title: {
    type: String,
    default: '',
  },
  /**
   * Layout control - inline=false|true - default false
   */
  inline: {
    type: Boolean,
    default: false,
  },
  /**
   * Width control - fit|full - default: fit
   */
  width: {
    type: String,
    default: 'fit',
    validator: (v) => ['fit', 'full'].includes(v),
  },

})

/** Colours + Iconify icon names (via UnoCSS Icons) */
const map = {
  default: {
    classes: 'bg-zinc-800 text-zinc-200',
    iconClass: 'i-fa7-solid-note-sticky text-[1.25em]',
  },
  error: {
    classes: 'bg-red-800 text-red-200 m-0.5',
    iconClass: 'i-fa7-solid-triangle-exclamation text-[1.25em]',
  },
  warning: {
    classes: 'bg-amber-800 text-amber-200 m-0.5',
    iconClass: 'i-fa7-solid-circle-exclamation text-[1.25em]',
  },
  info: {
    classes: 'bg-sky-800 text-sky-200 m-0.5',
    iconClass: 'i-fa7-solid-circle-info text-[1.25em]',
  },
  duration: {
    classes: 'bg-blue-800 text-blue-200 m-0.5',
    iconClass: 'i-fa7-solid-hourglass-half text-[1.25em]',
  },
  important: {
    classes: 'bg-green-800 text-green-200 m-0.5',
    iconClass: 'i-fa7-solid-star text-[1.25em]',
  },
  idea: {
    classes: 'bg-teal-800 text-teal-200 m-0.5',
    iconClass: 'i-fa7-solid-lightbulb text-[1.25em]',
  },
  priority: {
    classes: 'bg-violet-800 text-violet-200 m-0.5',
    iconClass: 'i-fa7-solid-bolt-lightning text-[1.25em]',
  },
  brainstorm: {
    classes: 'bg-pink-800 text-pink-200 m-0.5',
    iconClass: 'i-fa7-solid-brain text-[1.25em]',
  },
}

const current = computed(() => map[props.type] ?? map.default)

const containerClasses = computed(() => {
  const padding = props.compact ? 'pl-1 pr-3 py-1.5 text-sm' : 'pl-2 pr-3 py-1'
  const minH = props.compact ? 'min-h-[1.5rem]' : 'min-h-[2rem]'
  const display = props.inline ? 'inline-flex' : 'flex'
  const width = props.width === 'full' ? 'w-full' : 'w-fit'
  const inlineSpacing = props.inline ? 'mr-2 last:mr-0' : 'mb-2 last:mb-0'

  return [
    display,
    'items-stretch gap-3 rounded leading-5 font-normal',
    width,
    padding,
    minH,
    inlineSpacing,
    current.value.classes,
  ].join(' ')
})

const iconClasses = computed(() => {
  const insets = props.compact ? 'my-0.5' : 'my-1'
  return [
    current.value.iconClass,
    'self-stretch aspect-square inline-block',
  ].join(' ')
})

const ariaRole = computed(() => {
  if (props.role) return props.role
  return ['error', 'warning'].includes(props.type) ? 'alert' : 'status'
})
</script>

<template>
  <div :class="containerClasses" :role="ariaRole">

    <slot name="icon">
      <i :class="iconClasses" aria-hidden="true"></i>
    </slot>

    <span class="self-center">
      <template v-if="title">
        <strong class="mr-1">{{ title }}:</strong>
      </template>
      <slot/>
    </span>

  </div>
</template>
