<?php
declare(strict_types=1);

namespace App;

use PDO;
use PDOException;

final class Database
{
    public static function sqlite(string $path): PDO
    {
        $dsn = 'sqlite:' . $path;
        $pdo = new PDO($dsn);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        return $pdo;
    }

    public static function mysql(
        string $host,
        string $db,
        string $user,
        string $pass,
        int $port = 3306,
        string $charset = 'utf8mb4'
    ): PDO {
        $dsn = "mysql:host={$host};dbname={$db};port={$port};charset={$charset}";
        $pdo = new PDO($dsn, $user, $pass, [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
        return $pdo;
    }
}