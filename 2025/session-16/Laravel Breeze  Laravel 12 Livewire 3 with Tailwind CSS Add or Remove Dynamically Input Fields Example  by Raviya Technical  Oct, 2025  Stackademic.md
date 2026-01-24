---
created: 2025-11-12T13:30:48 (UTC +08:00)
tags: []
source: https://blog.stackademic.com/laravel-breeze-laravel-12-livewire-3-with-tailwind-css-add-or-remove-dynamically-input-fields-55a82e4b8bd2
author: Raviya Technical
---

# Laravel Breeze | Laravel 12 Livewire 3 with Tailwind CSS Add or Remove Dynamically Input Fields Example | by Raviya Technical | Oct, 2025 | Stackademic

> ## Excerpt
> Laravel Breeze | Laravel 12 Livewire 3 with Tailwind CSS Add or Remove Dynamically Input Fields Example Laravel Install Commnads using Composer composer global require laravel/installer Setup Fresh …

---
[

![Raviya Technical](Laravel%20Breeze%20%20Laravel%2012%20Livewire%203%20with%20Tailwind%20CSS%20Add%20or%20Remove%20Dynamically%20Input%20Fields%20Example%20%20by%20Raviya%20Technical%20%20Oct,%202025%20%20Stackademic/0jm4QzqR758FuQLCF.jpeg)



](https://raviyatechnical.medium.com/?source=post_page---byline--55a82e4b8bd2---------------------------------------)

Press enter or click to view image in full size

![](Laravel%20Breeze%20%20Laravel%2012%20Livewire%203%20with%20Tailwind%20CSS%20Add%20or%20Remove%20Dynamically%20Input%20Fields%20Example%20%20by%20Raviya%20Technical%20%20Oct,%202025%20%20Stackademic/1Rq96XG5HBfJYKU3gDvN8VA.png)

Laravel Breeze | Laravel 12 Livewire 3 with Tailwind CSS Add or Remove Dynamically Input Fields Example

Laravel Install Commnads using Composer

```
<span id="d846" data-selectable-paragraph="">composer <span>global</span> <span>require</span> laravel/installer</span>
```

Setup Fresh Laravel 12 Project with Breeze

```
<span id="f9ee" data-selectable-paragraph="">laravel <span>new</span> example</span>
```

Install Laravel 12 with Breeze starter kit

![](Laravel%20Breeze%20%20Laravel%2012%20Livewire%203%20with%20Tailwind%20CSS%20Add%20or%20Remove%20Dynamically%20Input%20Fields%20Example%20%20by%20Raviya%20Technical%20%20Oct,%202025%20%20Stackademic/0wsJP5M_LDhfxT0R_.png)

Select Option of livewire class with alpine js

![](Laravel%20Breeze%20%20Laravel%2012%20Livewire%203%20with%20Tailwind%20CSS%20Add%20or%20Remove%20Dynamically%20Input%20Fields%20Example%20%20by%20Raviya%20Technical%20%20Oct,%202025%20%20Stackademic/0StFqY_he6vemF1a8.png)

**Create Migration and Model**

```
<span id="2b11" data-selectable-paragraph="">php artisan <span>make</span>:model Contact -m</span>
```

Change **Path:-** database/migrations/xxxx\_xx\_xx\_xxxxxx\_create\_contacts\_table.php

```
<span id="f588" data-selectable-paragraph=""><span>&lt;?php</span><br><br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Migrations</span>\<span>Migration</span>;<br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Schema</span>\<span>Blueprint</span>;<br><span>use</span> <span>Illuminate</span>\<span>Support</span>\<span>Facades</span>\<span>Schema</span>;<br><br><span>return</span> <span>new</span> <span><span>class</span> <span>extends</span> <span>Migration</span><br></span>{<br>    <br>    <span>public</span> <span><span>function</span> <span>up</span>(): <span>void</span><br>    </span>{<br>        <span>Schema</span>::<span>create</span>(<span>'contacts'</span>, function (Blueprint <span>$table</span>) {<br>            <span>$table</span>-&gt;<span>id</span>();<br>            <span>$table</span>-&gt;<span>string</span>(<span>'name'</span>);<br>            <span>$table</span>-&gt;<span>string</span>(<span>'phone'</span>);<br>            <span>$table</span>-&gt;<span>timestamps</span>();<br>        });<br>    }<br><br>    <br>    <span>public</span> <span><span>function</span> <span>down</span>(): <span>void</span><br>    </span>{<br>        <span>Schema</span>::<span>dropIfExists</span>(<span>'contacts'</span>);<br>    }<br>};</span>
```

Contant Model

```
<span id="e564" data-selectable-paragraph=""><span>&lt;?php</span><br><br><span>namespace</span> <span>App</span>\<span>Models</span>;<br><br><span>use</span> <span>Illuminate</span>\<span>Database</span>\<span>Eloquent</span>\<span>Model</span>;<br><br><span><span>class</span> <span>Contact</span> <span>extends</span> <span>Model</span><br></span>{<br>    <span>protected</span> <span>$fillable</span> = [<span>'name'</span>, <span>'phone'</span>];<br>}</span>
```

Create Contacts using livewire

```
<span id="57f5" data-selectable-paragraph="">php artisan <span>make</span>:livewire Contacts</span>
```

**Path:** app/Livewire/Contacts.php

```
<span id="6477" data-selectable-paragraph=""><span>&lt;?php</span><br><br><span>namespace</span> <span>App</span>\<span>Livewire</span>;<br><br><span>use</span> <span>App</span>\<span>Models</span>\<span>Contact</span>;<br><span>use</span> <span>Livewire</span>\<span>Component</span>;<br><span>use</span> <span>Livewire</span>\<span>WithFileUploads</span>;<br><br><span><span>class</span> <span>Contacts</span> <span>extends</span> <span>Component</span><br></span>{<br>    <span>use</span> <span>WithFileUploads</span>;<br><br>    <br>    <span>public</span> <span>$names</span> = [<span>''</span>];<br>    <span>public</span> <span>$phones</span> = [<span>''</span>];<br>    <span>public</span> <span>$inputs</span> = [];<br><br>    <br>    <span>public</span> <span>$records</span> = [];<br><br>    <span>public</span> <span><span>function</span> <span>mount</span>()<br>    </span>{<br>        <span>$this</span>-&gt;records = <span>Contact</span>::<span>latest</span>()-&gt;<span>get</span>();<br>    }<br><br>    <span>protected</span> <span><span>function</span> <span>rules</span>()<br>    </span>{<br>        <span>return</span> [<br>            <span>'names.*'</span>  =&gt; [<span>'required'</span>, <span>'string'</span>, <span>'max:100'</span>],<br>            <span>'phones.*'</span> =&gt; [<span>'required'</span>, <span>'string'</span>, <span>'max:20'</span>],<br>        ];<br>    }<br><br>    <br>    <span>public</span> <span><span>function</span> <span>addField</span>()<br>    </span>{<br>        <span>$this</span>-&gt;names[] = <span>''</span>;<br>        <span>$this</span>-&gt;phones[] = <span>''</span>;<br>    }<br><br>    <br>    <span>public</span> <span><span>function</span> <span>removeField</span>(<span><span>$index</span></span>)<br>    </span>{<br>        <span>unset</span>(<span>$this</span>-&gt;names[<span>$index</span>], <span>$this</span>-&gt;phones[<span>$index</span>], <span>$this</span>-&gt;images[<span>$index</span>]);<br>        <span>$this</span>-&gt;names = <span>array_values</span>(<span>$this</span>-&gt;names);<br>        <span>$this</span>-&gt;phones = <span>array_values</span>(<span>$this</span>-&gt;phones);<br>    }<br><br>    <br>    <span>public</span> <span><span>function</span> <span>save</span>()<br>    </span>{<br>        <span>$this</span>-&gt;<span>validate</span>();<br><br>        <span>foreach</span> (<span>$this</span>-&gt;names <span>as</span> <span>$key</span> =&gt; <span>$name</span>) {<br><br><br>            <span>Contact</span>::<span>create</span>([<br>                <span>'name'</span>  =&gt; <span>$name</span>,<br>                <span>'phone'</span> =&gt; <span>$this</span>-&gt;phones[<span>$key</span>],<br>            ]);<br>        }<br><br>        <span>session</span>()-&gt;<span>flash</span>(<span>'message'</span>, <span>'Contacts created successfully.'</span>);<br><br>        <span>$this</span>-&gt;<span>reset</span>([<span>'names'</span>, <span>'phones'</span>, <span>'images'</span>]);<br>        <span>$this</span>-&gt;names = [<span>''</span>];<br>        <span>$this</span>-&gt;phones = [<span>''</span>];<br>        <span>$this</span>-&gt;images = [<span>''</span>];<br><br>        <span>$this</span>-&gt;records = <span>Contact</span>::<span>latest</span>()-&gt;<span>get</span>();<br>    }<br><br>    <span>public</span> <span><span>function</span> <span>render</span>()<br>    </span>{<br>        <span>return</span> <span>view</span>(<span>'livewire.contacts'</span>)-&gt;<span>layout</span>(<span>'layouts.app'</span>);<br>    }<br>}</span>
```

**Path:** resources/views/contacts.blade.php

```
<span id="e261" data-selectable-paragraph=""><span>&lt;<span>div</span>&gt;</span><br>    <span>&lt;<span>x-slot</span> <span>name</span>=<span>"header"</span>&gt;</span><br>        <span>&lt;<span>h2</span> <span>class</span>=<span>"font-semibold text-xl text-gray-800 leading-tight"</span>&gt;</span><br>            {{ __('Contacts') }}<br>        <span>&lt;/<span>h2</span>&gt;</span><br>    <span>&lt;/<span>x-slot</span>&gt;</span><br><br>    <span>&lt;<span>div</span> <span>class</span>=<span>"py-6"</span>&gt;</span><br>        <span>&lt;<span>div</span> <span>class</span>=<span>"max-w-5xl mx-auto sm:px-6 lg:px-8 space-y-6"</span>&gt;</span><br><br>            {{-- ✅ Flash message --}}<br>            @if (session('message'))<br>                <span>&lt;<span>div</span> <span>class</span>=<span>"bg-green-100 text-green-800 p-3 rounded-lg"</span>&gt;</span><br>                    {{ session('message') }}<br>                <span>&lt;/<span>div</span>&gt;</span><br>            @endif<br><br>            {{-- ✅ Contact List --}}<br>            <span>&lt;<span>div</span> <span>class</span>=<span>"bg-white shadow rounded-lg p-6"</span>&gt;</span><br>                <span>&lt;<span>h3</span> <span>class</span>=<span>"text-lg font-semibold mb-4"</span>&gt;</span>{{ __('Existing Contacts') }}<span>&lt;/<span>h3</span>&gt;</span><br><br>                @forelse ($records as $record)<br>                    <span>&lt;<span>div</span> <span>class</span>=<span>"flex items-center gap-4 border-b py-3"</span>&gt;</span><br>                        <span>&lt;<span>div</span>&gt;</span><br>                            <span>&lt;<span>div</span> <span>class</span>=<span>"font-medium"</span>&gt;</span>{{ $record-&gt;name }}<span>&lt;/<span>div</span>&gt;</span><br>                            <span>&lt;<span>div</span> <span>class</span>=<span>"text-sm text-gray-500"</span>&gt;</span>{{ $record-&gt;phone }}<span>&lt;/<span>div</span>&gt;</span><br>                        <span>&lt;/<span>div</span>&gt;</span><br>                    <span>&lt;/<span>div</span>&gt;</span><br>                @empty<br>                    <span>&lt;<span>p</span> <span>class</span>=<span>"text-gray-400 italic"</span>&gt;</span>{{ __('No contacts found.') }}<span>&lt;/<span>p</span>&gt;</span><br>                @endforelse<br>            <span>&lt;/<span>div</span>&gt;</span><br><br>            {{-- ✅ Add Contacts Form --}}<br>            <span>&lt;<span>form</span> <span>wire:submit.prevent</span>=<span>"save"</span> <span>class</span>=<span>"bg-white shadow rounded-lg p-6 space-y-6"</span>&gt;</span><br>                <span>&lt;<span>h3</span> <span>class</span>=<span>"text-lg font-semibold mb-4"</span>&gt;</span>{{ __('Add New Contacts') }}<span>&lt;/<span>h3</span>&gt;</span><br><br>                @foreach ($names as $index =&gt; $value)<br>                    <span>&lt;<span>div</span> <span>class</span>=<span>"grid grid-cols-1 sm:grid-cols-4 gap-4 items-end border-b pb-4 mb-4"</span>&gt;</span><br>                        <span>&lt;<span>div</span>&gt;</span><br>                            <span>&lt;<span>x-input-label</span> <span>value</span>=<span>"Name"</span> /&gt;</span><br>                            <span>&lt;<span>x-text-input</span> <span>wire:model</span>=<span>"names.{{ $index }}"</span> <span>class</span>=<span>"w-full"</span> /&gt;</span><br>                            <span>&lt;<span>x-input-error</span> <span>:messages</span>=<span>"$errors-&gt;get('names.' . $index)"</span> /&gt;</span><br>                        <span>&lt;/<span>div</span>&gt;</span><br><br>                        <span>&lt;<span>div</span>&gt;</span><br>                            <span>&lt;<span>x-input-label</span> <span>value</span>=<span>"Phone"</span> /&gt;</span><br>                            <span>&lt;<span>x-text-input</span> <span>wire:model</span>=<span>"phones.{{ $index }}"</span> <span>class</span>=<span>"w-full"</span> /&gt;</span><br>                            <span>&lt;<span>x-input-error</span> <span>:messages</span>=<span>"$errors-&gt;get('phones.' . $index)"</span> /&gt;</span><br>                        <span>&lt;/<span>div</span>&gt;</span><br><br>                        <span>&lt;<span>div</span> <span>class</span>=<span>"flex items-center space-x-2"</span>&gt;</span><br>                            @if ($index === 0)<br>                                <span>&lt;<span>x-secondary-button</span><br>                                    <span>wire:click.prevent</span>=<span>"addField"</span>&gt;</span>{{ __('Add') }}<span>&lt;/<span>x-secondary-button</span>&gt;</span><br>                            @else<br>                                <span>&lt;<span>x-danger-button</span><br>                                    <span>wire:click.prevent</span>=<span>"removeField({{ $index }})"</span>&gt;</span>{{ __('Remove') }}<span>&lt;/<span>x-danger-button</span>&gt;</span><br>                            @endif<br>                        <span>&lt;/<span>div</span>&gt;</span><br>                    <span>&lt;/<span>div</span>&gt;</span><br>                @endforeach<br><br>                <span>&lt;<span>div</span>&gt;</span><br>                    <span>&lt;<span>x-primary-button</span> <span>wire:loading.attr</span>=<span>"disabled"</span>&gt;</span>{{ __('Save Contacts') }}<span>&lt;/<span>x-primary-button</span>&gt;</span><br>                    <span>&lt;<span>span</span> <span>wire:loading</span> <span>wire:target</span>=<span>"save"</span><br>                        <span>class</span>=<span>"text-gray-500 ml-2 text-sm"</span>&gt;</span>{{ __('Saving...') }}<span>&lt;/<span>span</span>&gt;</span><br>                <span>&lt;/<span>div</span>&gt;</span><br>            <span>&lt;/<span>form</span>&gt;</span><br>        <span>&lt;/<span>div</span>&gt;</span><br>    <span>&lt;/<span>div</span>&gt;</span><br><span>&lt;/<span>div</span>&gt;</span></span>
```

> Did you know you can clap multiple times? 🥰 If this story added value to your day, please show your support by giving it a 👏 clap, sharing it with others, or even sponsoring my work. Your appreciation means the world to me!

## A message from our Founder

**Hey,** [**Sunil**](https://linkedin.com/in/sunilsandhu) **here.** I wanted to take a moment to thank you for reading until the end and for being a part of this community.

Did you know that our team run these publications as a volunteer effort to over 3.5m monthly readers? **We don’t receive any funding, we do this to support the community. ❤️**

If you want to show some love, please take a moment to **follow me on** [**LinkedIn**](https://linkedin.com/in/sunilsandhu)**,** [**TikTok**](https://tiktok.com/@messyfounder), [**Instagram**](https://instagram.com/sunilsandhu). You can also subscribe to our [**weekly newsletter**](https://newsletter.plainenglish.io/).

And before you go, don’t forget to **clap** and **follow** the writer️!
