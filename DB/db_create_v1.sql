-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pharmacy_db_v1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pharmacy_db_v1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmacy_db_v1` DEFAULT CHARACTER SET utf8 ;
USE `pharmacy_db_v1` ;

-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`org_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`org_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `org_name` VARCHAR(255) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `contact_no` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `removed_on` DATE NULL,
  `removed_by` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_org_user_removed_by_idx` (`removed_by` ASC),
  CONSTRAINT `fk_org_user_removed_by`
    FOREIGN KEY (`removed_by`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`user_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`user_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(255) NULL,
  `created_date` DATETIME NULL,
  `removed_on` DATE NULL,
  `removed_by` INT NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_removed_idx` (`removed_by` ASC),
  INDEX `fk_user_org_id_idx` (`org_id` ASC),
  CONSTRAINT `fk_user_removed`
    FOREIGN KEY (`removed_by`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_org_id`
    FOREIGN KEY (`org_id`)
    REFERENCES `pharmacy_db_v1`.`org_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`user_org_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`user_org_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `org_id` INT NOT NULL,
  `added_on` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_org_user_idx` (`user_id` ASC),
  INDEX `fk_user_org_org_idx` (`org_id` ASC),
  CONSTRAINT `fk_user_org_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_org_org`
    FOREIGN KEY (`org_id`)
    REFERENCES `pharmacy_db_v1`.`org_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`role_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`role_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NULL,
  `permission_name` VARCHAR(255) NULL,
  `role_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`user_role_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`user_role_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_role_user_idx` (`user_id` ASC),
  INDEX `fk_user_role_role_idx` (`role_id` ASC),
  CONSTRAINT `fk_user_role_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `pharmacy_db_v1`.`role_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`supplier_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`supplier_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `contact_no` VARCHAR(45) NULL,
  `removed_by` INT NULL,
  `removed_date` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`medicine_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`medicine_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `medicine_name` VARCHAR(255) NULL,
  `vendor` INT NULL,
  `quantity` INT NULL,
  `unit_price` DECIMAL(5,2) NULL,
  `removed_on` DATE NULL,
  `removed_by` INT NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_medicine_removed_by_idx` (`removed_by` ASC),
  INDEX `fk_medicine_vendor_idx` (`vendor` ASC),
  INDEX `fk_medicine_org_idx` (`org_id` ASC),
  CONSTRAINT `fk_medicine_removed_by`
    FOREIGN KEY (`removed_by`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicine_vendor`
    FOREIGN KEY (`vendor`)
    REFERENCES `pharmacy_db_v1`.`supplier_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicine_org`
    FOREIGN KEY (`org_id`)
    REFERENCES `pharmacy_db_v1`.`org_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`payment_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`payment_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(5,2) NULL,
  `paid_amount` DECIMAL(5,2) NULL,
  `balance_amount` DECIMAL(5,2) NULL,
  `payment_mode` VARCHAR(45) NULL,
  `paid_date` DATETIME NULL,
  `cashier` INT NOT NULL,
  `org_code` INT NOT NULL,
  `receipt_id` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_cashier_idx` (`cashier` ASC),
  INDEX `fk_payment_org_idx` (`org_code` ASC),
  CONSTRAINT `fk_payment_cashier`
    FOREIGN KEY (`cashier`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_org`
    FOREIGN KEY (`org_code`)
    REFERENCES `pharmacy_db_v1`.`org_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`receipt_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`receipt_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `issued_date` DATETIME NULL,
  `receipt_id` INT NOT NULL,
  `medicine_id` INT NULL,
  `customer_name` VARCHAR(255) NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_receipt_id_idx` (`receipt_id` ASC),
  INDEX `fk_medicine_id_idx` (`medicine_id` ASC),
  INDEX `k_receipt_org_id_idx` (`org_id` ASC),
  CONSTRAINT `fk_receipt_id`
    FOREIGN KEY (`receipt_id`)
    REFERENCES `pharmacy_db_v1`.`payment_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipt_medicine_id`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `pharmacy_db_v1`.`medicine_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `k_receipt_org_id`
    FOREIGN KEY (`org_id`)
    REFERENCES `pharmacy_db_v1`.`org_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy_db_v1`.`staff_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy_db_v1`.`staff_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) NULL,
  `dob` DATE NULL,
  `identification_no` VARCHAR(255) NULL,
  `position` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `district` VARCHAR(45) NULL,
  `branch` VARCHAR(45) NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_staff_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `pharmacy_db_v1`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
