<?php
declare(strict_types=1);

/**
 * @var array<int, array<string,string>> $contacts
 */
?>
<h2>All Contacts</h2>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Created</th>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($contacts as $c): ?>
        <tr>
            <td><?= (int) $c['id'] ?></td>
            <td><?= htmlspecialchars($c['name']) ?></td>
            <td><?= htmlspecialchars($c['email']) ?></td>
            <td><?= htmlspecialchars((string) $c['phone']) ?></td>
            <td>
                <time datetime="<?= htmlspecialchars($c['created_at']) ?>">
                    <?= htmlspecialchars($c['created_at']) ?>
                </time>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>