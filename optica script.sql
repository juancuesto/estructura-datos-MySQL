-- MySQL Script generated by MySQL Workbench
-- Sat Jan  8 11:22:54 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Optica` ;

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`Proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Proveedor` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Proveedor` (
  `NIF` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(120) NULL,
  `telefono` VARCHAR(9) NULL,
  `fax` VARCHAR(9) NULL,
  PRIMARY KEY (`NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Gafas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Gafas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Gafas` (
  `marca` VARCHAR(45) NOT NULL,
  `Grad_OD` VARCHAR(45) NULL,
  `Grad_OI` VARCHAR(45) NULL,
  `color_gafa` VARCHAR(45) NULL,
  `color_lentes` VARCHAR(45) NULL,
  `pvp` FLOAT NOT NULL,
  PRIMARY KEY (`marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`Clientes` ;

CREATE TABLE IF NOT EXISTS `Optica`.`Clientes` (
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(9) NULL,
  `email` VARCHAR(45) NULL,
  `fecha_registro` DATE NULL,
  `atendido por` VARCHAR(45) NULL,
  `cliente nuevo` VARCHAR(2) BINARY NULL,
  `recomendado por` VARCHAR(45) NULL,
  PRIMARY KEY (`nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`compras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`compras` ;

CREATE TABLE IF NOT EXISTS `Optica`.`compras` (
  `Clientes_nombre` VARCHAR(45) NOT NULL,
  `Gafas_marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Clientes_nombre`, `Gafas_marca`),
  INDEX `fk_Clientes_has_Gafas_Gafas1_idx` (`Gafas_marca` ASC) VISIBLE,
  INDEX `fk_Clientes_has_Gafas_Clientes_idx` (`Clientes_nombre` ASC) VISIBLE,
  UNIQUE INDEX `Gafas_marca_UNIQUE` (`Gafas_marca` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_has_Gafas_Clientes`
    FOREIGN KEY (`Clientes_nombre`)
    REFERENCES `Optica`.`Clientes` (`nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_has_Gafas_Gafas1`
    FOREIGN KEY (`Gafas_marca`)
    REFERENCES `Optica`.`Gafas` (`marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica`.`suministro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`suministro` ;

CREATE TABLE IF NOT EXISTS `Optica`.`suministro` (
  `Proveedor_NIF` VARCHAR(10) NOT NULL,
  `Gafas_marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Proveedor_NIF`, `Gafas_marca`),
  INDEX `fk_Proveedor_has_Gafas_Gafas1_idx` (`Gafas_marca` ASC) VISIBLE,
  INDEX `fk_Proveedor_has_Gafas_Proveedor1_idx` (`Proveedor_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Proveedor_has_Gafas_Proveedor1`
    FOREIGN KEY (`Proveedor_NIF`)
    REFERENCES `Optica`.`Proveedor` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Proveedor_has_Gafas_Gafas1`
    FOREIGN KEY (`Gafas_marca`)
    REFERENCES `Optica`.`Gafas` (`marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
