<?php
declare(strict_types=1);

namespace App;

use PDO;


final class Database
{

    public static function sqlite(string $filename): PDO
    {
        $dbPath = dirname(__DIR__).'/database/contact_list_db.sqlite';

        $dir = dirname($dbPath);

        if (!is_dir($dir)) {
            if (!mkdir($dir, 0777, true) && !is_dir($dir)) {
                throw new \RuntimeException("Failed to create database directory: {$dir}");
            }
        }

        if (!is_file($dbPath)) {
            touch($dbPath);
            $pdo = Database::sqlite($dbPath);
            $schema = file_get_contents(dirname(__DIR__).'/database/migrations/001_create_contacts.sql');
            $pdo->exec($schema);
        }

        $dsn = 'sqlite:'.$dbPath;
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
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);
        return $pdo;
    }
}
