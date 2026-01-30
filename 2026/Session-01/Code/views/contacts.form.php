<?php
declare(strict_types=1);

/**
 * @var array<string,string> $errors
 */

/**
 * @var array<string,string|null> $old
 */

/**
 * @var string $csrf
 */

?>
<h2>Create Contact</h2>

<?php if ($errors): ?>

    <p class="error"><strong>Check the form:</strong></p>

    <ul class="error">
        <?php foreach ($errors as $field => $msg): ?>
            <li><span><?= htmlspecialchars($field) ?>:</span> <?= htmlspecialchars($msg) ?></li>
        <?php endforeach; ?>
    </ul>

<?php endif; ?>

<form method="post" action="/?action=store">
    <!--
        Required: add required attribute to the input to invoke the HTML5 action
        NB: for testing ALWAYS remove this to enable error messages to show when no data submitted
    -->
    <input type="hidden" name="_csrf" value="<?= htmlspecialchars($csrf) ?>">

    <div>
        <label for="Name">Name</label>
        <input type="text" name="name" id="Name" value="<?= htmlspecialchars($old['name'] ?? '') ?>">
    </div>

    <div>
        <label for="Email">Email</label>
        <input type="email" name="email" id="Email" value="<?= htmlspecialchars($old['email'] ?? '') ?>">
    </div>

    <div>
        <label for="Phone">Phone</label>
        <input type="text" name="phone" id="Phone" value="<?= htmlspecialchars($old['phone'] ?? '') ?>">
    </div>

    <div>
        <button type="submit">Save</button>
    </div>

</form>