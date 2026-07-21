<?php
declare(strict_types=1);

namespace App;

use PDO;

final class ContactRepository
{
    public function __construct(private PDO $pdo)
    {
    }

    /**
     * Return all contacts, newest first.
     *
     * @return array<int, array<string, mixed>>
     */
    public function all(): array
    {
        // TODO A1.1
        // 1. Write a SELECT query for id, name, email, phone and created_at.
        // 2. Order the results by id descending.
        // 3. Run the query using $this->pdo.
        // 4. Return all rows.

        return [];
    }

    public function insert(string $name, string $email, ?string $phone): int
    {
        // TODO A2.1
        // 1. Write an INSERT statement using named placeholders.
        // 2. Prepare the statement.
        // 3. Bind name, email and phone.
        // 4. Execute the statement.
        // 5. Return the new record ID.

        return 0;
    }
}
