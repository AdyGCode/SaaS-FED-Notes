# Clean up existing database and user
DROP DATABASE IF EXISTS XXX_SaaS_FED_2024_S2;
DROP USER IF EXISTS 'XXX_SaaS_FED_2024_S2'@'localhost';

# Create Database
CREATE DATABASE IF NOT EXISTS XXX_SaaS_FED_2024_S2;

# Create User & Grant Permissions
CREATE USER 'XXX_SaaS_FED_2024_S2'@'localhost'
    IDENTIFIED WITH mysql_native_password
        BY 'Password1234';

GRANT USAGE ON *.*
    TO 'XXX_SaaS_FED_2024_S2'@'localhost';


GRANT ALL PRIVILEGES
    ON `XXX\_SaaS\_FED\_2024\_S2`.*
    TO 'XXX_SaaS_FED_2024_S2'@'localhost';

## Use the New Database and Create a table
USE XXX_SaaS_FED_2024_S2;

CREATE TABLE demo
(
    id     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name   VARCHAR(255) NOT NULL,
    colour VARCHAR(128) DEFAULT 'UNKNOWN',
    owned  BOOLEAN      DEFAULT FALSE
);



create table `form_submissions`
(
    id      BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(255) NOT NULL,
    email   VARCHAR(255) NOT NULL,
    subject VARCHAR(64),
    message TEXT,
    privacy BOOLEAN
);