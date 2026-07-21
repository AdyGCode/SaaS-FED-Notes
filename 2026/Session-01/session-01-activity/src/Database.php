<?php
declare(strict_types=1);

namespace App;

use PDO;
use RuntimeException;

final class Database
{
    public static function sqlite(string $filename): PDO
    {
        $directory = dirname($filename);

        if (!is_dir($directory) && !mkdir($directory, 0777, true) && !is_dir($directory)) {
            throw new RuntimeException("Could not create database directory: {$directory}");
        }

        $databaseIsNew = !is_file($filename);
        $pdo = new PDO('sqlite:'.$filename);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

        if ($databaseIsNew) {
            $migration = dirname(__DIR__).'/database/migrations/001_create_contacts.sql';
            $schema = file_get_contents($migration);

            if ($schema === false) {
                throw new RuntimeException('Could not read the database migration.');
            }

            $pdo->exec($schema);
        }

        return $pdo;
    }
}
