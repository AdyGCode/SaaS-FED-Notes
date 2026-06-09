<?php
declare(strict_types=1);

namespace App;

use PDO;

final class ContactRepository
{
    public function __construct(private PDO $pdo)
    {
    }

    public function all(): array
    {
        $sql = "SELECT id, name, email, phone, created_at FROM contacts ORDER BY id DESC";
        return $this->pdo->query($sql)->fetchAll();
    }

    public function insert(string $name, string $email, ?string $phone): int
    {
        $sql = "INSERT INTO contacts (name, email, phone) VALUES (:name, :email, :phone)";
        $stmt = $this->pdo->prepare($sql);

        // Less readable form, and no definition of field/column type
        //        $stmt->execute([
        //            ':name'  => $name,
        //            ':email' => $email,
        //            ':phone' => $phone,
        //        ]);

        $stmt->bindValue(':name', $name, PDO::PARAM_STR);
        $stmt->bindValue(':email', $email, PDO::PARAM_STR);
        $stmt->bindValue(':phone', $phone, PDO::PARAM_STR);

        $stmt->execute();

        return (int) $this->pdo->lastInsertId();
    }
}
