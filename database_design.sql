-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema inventory_management
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventory_management
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventory_management` DEFAULT CHARACTER SET utf8 ;
USE `inventory_management` ;

-- -----------------------------------------------------
-- Table `inventory_management`.`item_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management`.`item_category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory_management`.`item_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management`.`item_list` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `material` VARCHAR(50) NOT NULL,
  `category_id` INT NOT NULL,
  `safe_stock_level` INT NOT NULL,
  PRIMARY KEY (`item_id`, `category_id`),
  INDEX `fk_item_item_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_item_item_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `inventory_management`.`item_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory_management`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management`.`supplier` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `usual_days_to_arrive` INT NOT NULL,
  `delivery_fee` VARCHAR(45) NOT NULL,
  `comment` TINYTEXT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory_management`.`price_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management`.`price_list` (
  `price_id` INT NOT NULL AUTO_INCREMENT,
  `item_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `price_per_unit` DECIMAL(6,2) NOT NULL,
  `unit_detail` VARCHAR(255) NOT NULL,
  `item_name` VARCHAR(50) NOT NULL,
  `last_updated` DATETIME NOT NULL,
  PRIMARY KEY (`price_id`, `item_id`, `supplier_id`),
  INDEX `fk_item_has_supplier_supplier1_idx` (`supplier_id` ASC),
  INDEX `fk_item_has_supplier_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_item_has_supplier_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `inventory_management`.`item_list` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_has_supplier_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `inventory_management`.`supplier` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory_management`.`stock_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management`.`stock_log` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `log_date` DATETIME NOT NULL,
  `item_id` INT NOT NULL,
  `current_stock` INT NOT NULL,
  PRIMARY KEY (`log_id`, `item_id`),
  INDEX `fk_stock_revision_log_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_stock_revision_log_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `inventory_management`.`item_list` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
