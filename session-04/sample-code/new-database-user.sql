# ---------------------------------------------------------------------------------------------
#
# BEFORE COMMENCING:
#
# - Replace all instances of YYYY with the current year (eg 2025)
# - Replace all instances of SN with S followed by the semester number (eg S1 for semster 1)
# - Replace ALL instances of XXX with your initials (eg AJG for Adrian Gould)
#
# ---------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------
# Clean up existing database and user
DROP DATABASE IF EXISTS XXX_SaaS_FED_YYYY_SN;
DROP USER IF EXISTS 'XXX_SaaS_FED_YYYY_SN'@'localhost';
DROP USER IF EXISTS 'XXX_SaaS_FED_YYYY_SN'@'127.0.0.1';

# ---------------------------------------------------------------------------------------------
# Create Database
CREATE DATABASE IF NOT EXISTS XXX_SaaS_FED_YYYY_SN;


# ---------------------------------------------------------------------------------------------
# Create User & Grant Permissions
CREATE USER 'XXX_SaaS_FED_YYYY_SN'@'localhost'
    IDENTIFIED WITH mysql_native_password
        BY 'Password1234';

CREATE USER 'XXX_SaaS_FED_YYYY_SN'@'127.0.0.1'
    IDENTIFIED WITH mysql_native_password
        BY 'Password1234';


GRANT USAGE ON *.*
    TO 'XXX_SaaS_FED_YYYY_SN'@'localhost';

GRANT USAGE ON *.*
    TO 'XXX_SaaS_FED_YYYY_SN'@'127.0.0.1';


GRANT ALL PRIVILEGES
    ON `XXX\_SaaS\_FED\_YYYY\_SN`.*
    TO 'XXX_SaaS_FED_YYYY_SN'@'localhost';

GRANT ALL PRIVILEGES
    ON `XXX\_SaaS\_FED\_YYYY\_SN`.*
    TO 'XXX_SaaS_FED_YYYY_SN'@'127.0.0.1';

FLUSH PRIVILEGES;

# ---------------------------------------------------------------------------------------------

## Use the New Database and Create a table
USE XXX_SaaS_FED_YYYY_SN;

CREATE TABLE `demo`
(
    `id`     BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name`   VARCHAR(255) NOT NULL,
    `colour` VARCHAR(128) DEFAULT 'UNKNOWN',
    `owned`  BOOLEAN      DEFAULT FALSE
);

CREATE TABLE `users`
(
    `id`       BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name`     VARCHAR(128) NOT NULL,
    `email`    VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NULLABLE
);

CREATE TABLE `form_submissions`
(
    `id`      BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `name`    VARCHAR(128) NOT NULL,
    `email`   VARCHAR(255) NOT NULL,
    `subject` VARCHAR(64),
    `message` TEXT,
    `privacy` BOOLEAN
);
