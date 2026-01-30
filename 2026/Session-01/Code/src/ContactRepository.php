<?php
declare(strict_types=1);

namespace Code\src;

use PDO;

final class ContactRepository
{
    public function __construct(private PDO $pdo) {}

    public function all(): array
    {
        $sql = "SELECT id, name, email, phone, created_at FROM contacts ORDER BY id DESC";
        return $this->pdo->query($sql)->fetchAll();
    }

    public function insert(string $name, string $email, ?string $phone): int
    {
        $sql  = "INSERT INTO contacts (name, email, phone) VALUES (:name, :email, :phone)";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([
            ':name'  => $name,
            ':email' => $email,
            ':phone' => $phone,
        ]);
        return (int) $this->pdo->lastInsertId();
    }
}
