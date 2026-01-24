-- Create the 'SaaS Vanilla MVC' database & User
DROP USER IF EXISTS
    'xxx_saas_vanilla_mvc'@'127.0.0.1';

CREATE USER IF NOT EXISTS
    'xxx_saas_vanilla_mvc'@'127.0.0.1'
        IDENTIFIED WITH mysql_native_password
            BY 'PasswordSecret';

GRANT USAGE ON *.* TO
    'xxx_saas_vanilla_mvc'@'127.0.0.1';

# ALTER USER 'xxx_saas_vanilla_mvc'@'127.0.0.1'
#     REQUIRE NONE WITH
#     MAX_QUERIES_PER_HOUR 0
#     MAX_CONNECTIONS_PER_HOUR 0
#     MAX_UPDATES_PER_HOUR 0
#     MAX_USER_CONNECTIONS 0;

DROP DATABASE IF EXISTS
    `xxx_saas_vanilla_mvc`;

CREATE DATABASE IF NOT EXISTS
    `xxx_saas_vanilla_mvc`;

GRANT ALL PRIVILEGES ON
    `xxx_saas_vanilla_mvc`.*
    TO 'xxx_saas_vanilla_mvc'@'127.0.0.1';

USE xxx_saas_vanilla_mvc;

-- Create the Users Table
DROP TABLE IF EXISTS `users`;

-- Table structure for 'users' table
CREATE TABLE IF NOT EXISTS `users`
(
    `id`         BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(255)     DEFAULT NULL,
    `email`      VARCHAR(320)     NOT NULL UNIQUE,
    `password`   VARCHAR(255)     NOT NULL,
    `city`       VARCHAR(45)      DEFAULT NULL,
    `state`      VARCHAR(45)      DEFAULT NULL,
    `country`    VARCHAR(45)      DEFAULT 'Australia',
    `created_at` TIMESTAMP        NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

-- Product Table Creation
DROP TABLE IF EXISTS `products`;

-- Table structure for 'products' table
CREATE TABLE IF NOT EXISTS `products`
(
    `id`          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`     BIGINT UNSIGNED DEFAULT 10,
    `name`        VARCHAR(255)    NOT NULL,
    `description` TEXT,
    `price`       INT UNSIGNED    DEFAULT NULL,
    `created_at`  TIMESTAMP       NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB
  AUTO_INCREMENT = 1000
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;

-- Seeding
-- Insert data into 'users' table
-- The password is Password1 hashed using the PHP password_hash() method.
--
INSERT INTO `users`
VALUES (10, 'Administrator', 'admin@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Perth', 'WA', 'Australia', '2000-01-01 00:00:01');

INSERT INTO `users`
VALUES (20, 'Adrian Gould', 'adrian@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Perth', 'WA', 'Australia', '2024-01-01 10:30:01'),
       (30, 'YOUR NAME', 'GIVEN_NAME@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Perth', 'WA', 'Australia', '2024-08-10 16:11:43');

INSERT INTO `users`
VALUES (100, 'John Doe', 'user1@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Bunbury', 'WA', 'Australia', '2024-08-15 13:04:21'),
       (101, 'Jane Doe', 'user2@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Melbourne', 'VIC', 'Australia', '2024-08-20 13:17:21'),
       (102, 'Steve Smith', 'user3@example.com',
        '$2y$10$4Ae3n2iQ0MwXMNz0UEmNne2PaNyfYsBFYb97nayHWTDCwpnuPi6f.',
        'Adelaide', 'SA', 'Australia', '2024-08-20 17:59:13');

INSERT INTO `products`(`id`, `user_id`, `name`, `description`, `price`, `created_at`)
VALUES (40380, 20, 'Sheep BrickHeadz',
        'BrickHeadz theme: This set features an adorable sheep with a cute, blocky design, perfect for collectors and fans of the BrickHeadz series.',
        1999, '2020-01-01'),
       (75224, 20, 'Sith Infiltrator Microfighter',
        'Star Wars theme: A mini version of Darth Maul\'s Sith Infiltrator, part of the LEGO Star Wars Microfighters series, great for Star Wars enthusiasts.',
        1599, '2019-01-01'),
       (75223, 20, 'Naboo Starfighter Microfighter',
        'Star Wars theme: A compact, easy-to-build model of the Naboo Starfighter, perfect for young Star Wars fans.',
        1599, '2019-01-01'),
       (75228, 20, 'Escape Pod vs. Dewback Microfighters',
        'Star Wars theme: This set features a Dewback and an Escape Pod, each with a mini-figure from the Star Wars saga, perfect for imaginative play.',
        2999, '2019-01-01'),
       (75317, 20, 'The Mandalorian & The Child BrickHeadz',
        'Star Wars theme: A BrickHeadz double pack featuring The Mandalorian and The Child (Baby Yoda), perfect for fans of the popular Star Wars series.',
        2999, '2020-08-01'),
       (40379, 20, 'Valentine\'s Bear',
        'BrickHeadz theme: A seasonal BrickHeadz set featuring a charming Valentine\'s Bear holding a heart, ideal for Valentine\'s Day.',
        1999, '2020-01-01'),
       (40354,10,  'Dragon Dance',
        'Seasonal theme: This Chinese New Year-themed set features a vibrant and detailed dragon dance scene, complete with minifigures and traditional decorations.',
        8999, '2019-01-01'),
       (40440, 10, 'German Shepherd',
        'BrickHeadz theme: A BrickHeadz pet set featuring a cute German Shepherd and puppy, great for dog lovers.',
        1999, '2021-01-01'),
       (21108, 30, 'Ghostbusters Ecto-1',
        'Ideas theme: A LEGO Ideas set featuring the iconic Ecto-1 car from the Ghostbusters movies, complete with minifigures of the Ghostbusters team.',
        7999, '2014-06-01'),
       (10226, 30, 'Sopwith Camel',
        'Creator Expert theme: A detailed model of the Sopwith Camel biplane, part of the LEGO Creator Expert series, perfect for aviation enthusiasts.',
        13999, '2012-06-01'),
       (6907, 10, 'Cosmic Cruiser',
        'Space theme: A classic LEGO Space set featuring a detailed cosmic cruiser spacecraft, part of the Futuron sub-theme.',
        2999, '1987-01-01'),
       (6086, 100, 'Black Knight\'s Castle',
        'Castle theme: A large, fortified castle set from the LEGO Castle theme, complete with knights, horses, and secret passages.',
        10999, '1992-01-01'),
       (6990, 100, 'Monorail Transport System',
        'Space theme: A futuristic monorail system set, part of the LEGO Space theme, featuring a full track, stations, and space-themed vehicles.',
        14999, '1987-01-01'),
       (6875, 101, 'Spy Trak 1',
        'Space theme: A classic set from the LEGO Space theme, featuring a high-tech, mobile spying unit with various play features.',
        1999, '1988-01-01'),
       (885, 101, 'Space Scooter',
        'Space theme: A small, classic LEGO Space set featuring a simple yet iconic space scooter vehicle.', 999,
        '1979-01-01');