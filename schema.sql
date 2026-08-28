CREATE DATABASE IF NOT EXISTS safethetrade
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE safethetrade;

CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  referral_code VARCHAR(32) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY unique_users_email (email)
) ENGINE=InnoDB;
