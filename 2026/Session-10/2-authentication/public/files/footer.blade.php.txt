<footer class="bg-zinc-900">
    <div class="mx-auto max-w-7xl px-4 pt-16 pb-6 sm:px-6 lg:px-8 lg:pt-24">
        <div class="grid grid-cols-1 gap-8 lg:grid-cols-3">
            <div>
                <div class="flex gap-4 justify-center align-middle sm:justify-start text-zinc-300">
                    <p>
                        <x-application-logo class="h-8 text-zinc-300 fill-zinc-300"/>
                    </p>
                    <p class="text-xl">{{ config('app.name', "Laravel") }}</p>
                </div>

                <p class="mt-6 max-w-md text-center leading-relaxed text-zinc-500 sm:max-w-xs sm:text-left text-zinc-400">
                    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Incidunt consequuntur amet
                    culpa cum itaque neque.
                </p>

                <ul class="mt-8 flex justify-center gap-6 sm:justify-start md:gap-8">
                    <li>
                        <a href="#" rel="noreferrer" target="_blank"
                           class="transition text-zinc-500 hover:text-zinc-500/75">
                            <span class="sr-only">Facebook</span>
                            <i class="fa-brands fa-facebook text-2xl"></i>
                        </a>
                    </li>

                    <li>
                        <a href="#" rel="noreferrer" target="_blank"
                           class="transition text-zinc-500 hover:text-zinc-500/75">
                            <span class="sr-only">Instagram</span>
                            <i class="fa-brands fa-instagram text-2xl"></i>
                        </a>
                    </li>

                    <li>
                        <a href="#" rel="noreferrer" target="_blank"
                           class="transition text-zinc-500 hover:text-zinc-500/75">
                            <span class="sr-only">Twitter</span>
                            <i class="fa-brands fa-twitter text-2xl"></i>
                        </a>
                    </li>

                    <li>
                        <a href="#" rel="noreferrer" target="_blank"
                           class="transition text-zinc-500 hover:text-zinc-500/75">
                            <span class="sr-only">GitHub</span>
                            <i class="fa-brands fa-github text-2xl"></i>
                        </a>
                    </li>

                    <li>
                        <a href="#" rel="noreferrer" target="_blank"
                           class="transition text-zinc-500 hover:text-zinc-500/75">
                            <span class="sr-only">Dribbble</span>
                            <i class="fa-brands fa-dribbble text-2xl"></i>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="grid grid-cols-1 gap-8 sm:grid-cols-2 md:grid-cols-4 lg:col-span-2">
                <div class="text-center sm:text-left">
                    <p class="text-lg font-medium text-zinc-300">About Us</p>

                    <ul class="mt-8 space-y-4 text-sm">
                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Company History
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Meet the Team
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Employee Handbook
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Careers
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="text-center sm:text-left">
                    <p class="text-lg font-medium text-zinc-300">Our Services</p>

                    <ul class="mt-8 space-y-4 text-sm">
                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Web Development
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Web Design
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Marketing
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Google Ads
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="text-center sm:text-left">
                    <p class="text-lg font-medium text-zinc-300">Helpful Links</p>

                    <ul class="mt-8 space-y-4 text-sm">
                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                FAQs
                            </a>
                        </li>

                        <li>
                            <a class="transition hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75"
                               href="#">
                                Support
                            </a>
                        </li>

                        <li>
                            <a class="group flex justify-center gap-1.5 ltr:sm:justify-start rtl:sm:justify-end"
                               href="#">
                                <span
                                    class="transition group-hover:text-zinc-700/75 text-zinc-400 hover:text-zinc-300/75">
                                  Live Chat
                                </span>
                                <span class="relative flex size-2">
                                  <span class="relative inline-flex size-2 rounded-full bg-zinc-500"></span>
                                  <span
                                      class="absolute inline-flex h-full w-full animate-ping rounded-full bg-lime-400 opacity-70"></span>
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="text-center sm:text-left text-zinc-600">
                    <p class="text-lg font-medium text-zinc-200">Contact Us</p>

                    <ul class="mt-8 space-y-4 text-sm">
                        <li>
                            <a class="flex items-center justify-center gap-1.5 ltr:sm:justify-start rtl:sm:justify-end"
                               href="#">
                                <i class="fa-solid fa-envelope text-lg min-w-6 "></i>
                                <span class=" text-zinc-400"> enquiries@example.com </span>
                            </a>
                        </li>

                        <li>
                            <a class="flex items-center justify-center gap-1.5 ltr:sm:justify-start rtl:sm:justify-end"
                               href="#">
                                <i class="fa-solid fa-phone text-lg min-w-6 "></i>
                                <span class=" text-zinc-400">+00-0000-0000</span>
                            </a>
                        </li>

                        <li class="flex items-start justify-center gap-1.5 ltr:sm:justify-start rtl:sm:justify-end">
                            <i class="fa-solid fa-location-pin text-lg min-w-6 "></i>
                            <address class="-mt-0.5 not-italic  text-zinc-400">
                                Nimbus House, <br>Drizzle Drive, <br>Rainville-on-Thames, UK, CL0 UD9
                            </address>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="mt-12 border-t pt-6 border-zinc-800">
            <div class="text-center sm:flex sm:justify-between sm:text-left">
                <p class="text-sm text-zinc-400">
                    <span class="block sm:inline">All rights reserved.</span>

                    <a class="inline-block underline transition hover:text-zinc-600/75 text-zinc-500 hover:text-zinc-500/75"
                       href="{{ route('web.static.terms-and-conditions') }}">
                        Terms &amp; Conditions
                    </a>

                    <span>·</span>

                    <a class="inline-block underline transition hover:text-zinc-600/75 text-zinc-500 hover:text-zinc-500/75"
                       href="{{ route('web.static.privacy') }}">
                        Privacy Policy
                    </a>
                </p>

                <p class="mt-4 text-sm sm:order-first sm:mt-0 text-zinc-400">
                    © 2022 Company Name
                </p>
            </div>
        </div>
    </div>
</footer>
