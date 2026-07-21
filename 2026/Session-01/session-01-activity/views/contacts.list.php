<?php
declare(strict_types=1);

/** @var array<int, array<string, mixed>> $contacts */
?>
<h2>All Contacts</h2>

<!-- TODO A1.3
Create a table with these columns:
ID, Name, Email, Phone, Created.

Loop through $contacts and create one table row per contact.
Escape all text output with htmlspecialchars().
Cast the ID to an integer before displaying it.
-->

<?php if ($contacts === []): ?>
    <p class="notice">No contacts are displayed yet. Complete the A1 TODOs.</p>
<?php endif; ?>
