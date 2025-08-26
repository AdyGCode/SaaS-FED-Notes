-- ======================================> BEGIN SECTION <=====================================
-- BEFORE COMMENCING:
--
-- - Replace all instances of YYYY with the current year
--   For example, 2025
-- - Replace all instances of SN with S followed by the semester number
--   For example, S1 for semester 1
-- - Replace ALL instances of XXX with your initials
--   For example, AJG for Adrian Gould
--
-- We have split the file into sections each surrounded with a BEGIN SECTION and END SECTION
-- comment line. These sections may be copied and pasted into the SQL interface for the RDBMS
-- and executed to perform the steps.
--
-- Alternatively, copy the whole file and paste into the SQL command interface provided for/by
-- your GUI based RDBMS management software.
-- ======================================> BEGIN SECTION <=====================================



-- ======================================> BEGIN SECTION <=====================================
-- USER & DATABASE REMOVAL
-- In this section we perform a clean-up of any existing database and user(s) associated with
-- this database.
--
-- It is important to understand that this DESTROYS all data associated with the database and
-- the database user(s) and CANNOT be recovered.
-- --------------------------------------------------------------------------------------------

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
