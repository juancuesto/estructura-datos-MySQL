-- MySQL Script generated by MySQL Workbench
-- Sat Feb 19 09:30:48 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Botiga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Botiga` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Botiga` (
  `idBotiga` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NULL,
  `codigo postal` VARCHAR(10) NULL,
  `localidad` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`idBotiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Provincia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Loclidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Loclidad` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Loclidad` (
  `idLoclidad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idLoclidad`),
  INDEX `fk_Loclidad_Provincia_idx` (`Provincia_idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_Loclidad_Provincia`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `mydb`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`Clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`Clientes` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `codigo postal` VARCHAR(10) NULL,
  `tefefono` VARCHAR(9) NULL,
  `direccion` VARCHAR(45) NULL,
  `localidad_id` INT NULL,
  `Botiga_idBotiga` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idClientes`, `Botiga_idBotiga`),
  INDEX `fk_clientes_localidad_idx` (`localidad_id` ASC) VISIBLE,
  INDEX `fk_Clientes_Botiga1_idx` (`Botiga_idBotiga` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_localidad`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `mydb`.`Loclidad` (`idLoclidad`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clientes_Botiga1`
    FOREIGN KEY (`Botiga_idBotiga`)
    REFERENCES `mydb`.`Botiga` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productos_comanda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`productos_comanda` ;

CREATE TABLE IF NOT EXISTS `mydb`.`productos_comanda` (
  `id_comanda` INT NOT NULL AUTO_INCREMENT,
  `cantidad_pizza` INT NULL,
  `cantidad_hamburguesa` INT NULL,
  `cantidad_bebida` INT NULL,
  PRIMARY KEY (`id_comanda`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comanda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Comanda` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Comanda` (
  `idComanda` INT NOT NULL AUTO_INCREMENT,
  `fecha/hora` DATE NULL,
  `reparto/recogida` ENUM('recogida', 'reparto') NULL,
  `cantidad de productos` INT NULL,
  `pvp_total` FLOAT NULL,
  `Clientes_idClientes` INT UNSIGNED NOT NULL,
  `productos_comanda_id_comanda` INT NOT NULL,
  `id_cliente` INT NULL,
  PRIMARY KEY (`idComanda`, `Clientes_idClientes`),
  INDEX `fk_Comanda_Clientes1_idx` (`Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Comanda_productos_comanda1_idx` (`productos_comanda_id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_Comanda_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `pizzeria`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_productos_comanda1`
    FOREIGN KEY (`productos_comanda_id_comanda`)
    REFERENCES `mydb`.`productos_comanda` (`id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Categoria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Producto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` BLOB NULL,
  `pvp` FLOAT NULL,
  `Comanda_idComanda` INT NOT NULL,
  `Comanda_Clientes_idClientes` INT UNSIGNED NOT NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `tipo_producto` ENUM('pizza', 'hamburguesa', 'bebida') NULL,
  PRIMARY KEY (`idProducto`, `Comanda_idComanda`, `Comanda_Clientes_idClientes`, `Categoria_idCategoria`),
  INDEX `fk_Producto_Comanda1_idx` (`Comanda_idComanda` ASC, `Comanda_Clientes_idClientes` ASC) VISIBLE,
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Comanda1`
    FOREIGN KEY (`Comanda_idComanda` , `Comanda_Clientes_idClientes`)
    REFERENCES `mydb`.`Comanda` (`idComanda` , `Clientes_idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `mydb`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Empleado` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `nif` VARCHAR(10) NULL,
  `telefono` VARCHAR(9) NULL,
  `cocinero/repartidor` ENUM('cocinero', 'repartidor') NULL,
  `Empleadocol` VARCHAR(45) BINARY NULL,
  `Botiga_idBotiga` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEmpleado`, `Botiga_idBotiga`),
  INDEX `fk_Empleado_Botiga1_idx` (`Botiga_idBotiga` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Botiga1`
    FOREIGN KEY (`Botiga_idBotiga`)
    REFERENCES `mydb`.`Botiga` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `pizzeria` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
