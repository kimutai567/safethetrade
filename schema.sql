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

CREATE TABLE IF NOT EXISTS offers (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  seller_id INT UNSIGNED NOT NULL,
  asset VARCHAR(10) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  amount DECIMAL(18,2) NOT NULL,
  rate DECIMAL(18,2) NOT NULL,
  status ENUM('active', 'paused', 'closed') NOT NULL DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_offers_seller (seller_id),
  CONSTRAINT fk_offers_seller FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS trades (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  offer_id INT UNSIGNED NOT NULL,
  buyer_id INT UNSIGNED NOT NULL,
  seller_id INT UNSIGNED NOT NULL,
  asset VARCHAR(10) NOT NULL,
  amount DECIMAL(18,2) NOT NULL,
  rate DECIMAL(18,2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  status ENUM('pending', 'funded', 'in_progress', 'completed', 'disputed', 'cancelled', 'expired') NOT NULL DEFAULT 'pending',
  time_limit_minutes INT UNSIGNED NOT NULL DEFAULT 60,
  instructions TEXT DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_trades_offer (offer_id),
  KEY fk_trades_buyer (buyer_id),
  KEY fk_trades_seller (seller_id),
  CONSTRAINT fk_trades_offer FOREIGN KEY (offer_id) REFERENCES offers(id) ON DELETE CASCADE,
  CONSTRAINT fk_trades_buyer FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
  CONSTRAINT fk_trades_seller FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS trade_messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  trade_id INT UNSIGNED NOT NULL,
  sender_id INT UNSIGNED NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_messages_trade (trade_id),
  KEY fk_messages_sender (sender_id),
  CONSTRAINT fk_messages_trade FOREIGN KEY (trade_id) REFERENCES trades(id) ON DELETE CASCADE,
  CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS escrow_transactions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  trade_id INT UNSIGNED NOT NULL,
  type ENUM('deposit', 'release', 'refund', 'dispute', 'fee') NOT NULL,
  amount DECIMAL(18,2) NOT NULL,
  status ENUM('pending', 'completed', 'failed') NOT NULL DEFAULT 'pending',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_escrow_trade (trade_id),
  CONSTRAINT fk_escrow_trade FOREIGN KEY (trade_id) REFERENCES trades(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS disputes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  trade_id INT UNSIGNED NOT NULL,
  opened_by INT UNSIGNED NOT NULL,
  reason TEXT NOT NULL,
  status ENUM('open', 'resolved', 'closed') NOT NULL DEFAULT 'open',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY fk_disputes_trade (trade_id),
  KEY fk_disputes_user (opened_by),
  CONSTRAINT fk_disputes_trade FOREIGN KEY (trade_id) REFERENCES trades(id) ON DELETE CASCADE,
  CONSTRAINT fk_disputes_user FOREIGN KEY (opened_by) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;
