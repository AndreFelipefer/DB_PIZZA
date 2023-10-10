# Apresentação de Banco de Dados de Pizzas

### Nesta apresentação, vamos abordar o desenvolvimento de um banco de dados para um restaurante de pizzas. O banco de dados será utilizado para armazenar informações sobre as pizzas, os ingredientes e os pizzaiolos.
### Modelo Conceitual
### O modelo conceitual é uma representação de alto nível do banco de dados. Ele é utilizado para capturar os conceitos e relacionamentos entre os dados.

### 1- Transforme o modelo conceitual em modelo lógico;

![image](https://github.com/AndreFelipefer/DB_PIZZA/assets/129207232/3d09265b-a0c9-4d1c-8d13-3159b088e466)


### 2- Escreva o script SQL que cria o banco de dados;
```SQL
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`receita` (
  `id_receita` INT NOT NULL AUTO_INCREMENT,
  `instrucoes` VARCHAR(45) NULL,
  `autor` VARCHAR(45) NULL,
  PRIMARY KEY (`id_receita`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `sabor` VARCHAR(45) NULL,
  `preco_pizza` DECIMAL(9,2) NULL,
  `descricao` VARCHAR(45) NULL,
  `tamanho_pizza` CHAR(0) NULL,
  `receita_id_receita` INT NOT NULL,
  `tamanho_embalagem` CHAR(0) NULL,
  `material` VARCHAR(45) NULL,
  `preco_embalagem` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pizza`, `receita_id_receita`),
  INDEX `fk_pizza_receita1_idx` (`receita_id_receita` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_receita1`
    FOREIGN KEY (`receita_id_receita`)
    REFERENCES `mydb`.`receita` (`id_receita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizzaiolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizzaiolo` (
  `id_pizzaiolo` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `salario` DECIMAL(9,2) NULL,
  PRIMARY KEY (`id_pizzaiolo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza_has_pizzaiolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza_has_pizzaiolo` (
  `pizza_id_pizza` INT NOT NULL,
  `pizzaiolo_id_pizzaiolo` INT NOT NULL,
  PRIMARY KEY (`pizza_id_pizza`, `pizzaiolo_id_pizzaiolo`),
  INDEX `fk_pizza_has_pizzaiolo_pizzaiolo1_idx` (`pizzaiolo_id_pizzaiolo` ASC) VISIBLE,
  INDEX `fk_pizza_has_pizzaiolo_pizza_idx` (`pizza_id_pizza` ASC) VISIBLE,
  CONSTRAINT `fk_pizza_has_pizzaiolo_pizza`
    FOREIGN KEY (`pizza_id_pizza`)
    REFERENCES `mydb`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_has_pizzaiolo_pizzaiolo1`
    FOREIGN KEY (`pizzaiolo_id_pizzaiolo`)
    REFERENCES `mydb`.`pizzaiolo` (`id_pizzaiolo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes` (
  `id_ingredientes` INT NOT NULL AUTO_INCREMENT,
  `trigo` VARCHAR(45) NULL,
  `molho_tomate` VARCHAR(45) NULL,
  `queijo` VARCHAR(45) NULL,
  `calabresa` VARCHAR(45) NULL,
  `frango` VARCHAR(45) NULL,
  `tomate` VARCHAR(45) NULL,
  `peperoni` VARCHAR(45) NULL,
  `brocolis` VARCHAR(45) NULL,
  `bacon` VARCHAR(45) NULL,
  `milho` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ingredientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes_has_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes_has_pizza` (
  `ingredientes_id_ingredientes` INT NOT NULL,
  `pizza_id_pizza` INT NOT NULL,
  `pizza_receita_id_receita` INT NOT NULL,
  PRIMARY KEY (`ingredientes_id_ingredientes`, `pizza_id_pizza`, `pizza_receita_id_receita`),
  INDEX `fk_ingredientes_has_pizza_pizza1_idx` (`pizza_id_pizza` ASC, `pizza_receita_id_receita` ASC) VISIBLE,
  INDEX `fk_ingredientes_has_pizza_ingredientes1_idx` (`ingredientes_id_ingredientes` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_has_pizza_ingredientes1`
    FOREIGN KEY (`ingredientes_id_ingredientes`)
    REFERENCES `mydb`.`ingredientes` (`id_ingredientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id_pizza` , `pizza_receita_id_receita`)
    REFERENCES `mydb`.`pizza` (`id_pizza` , `receita_id_receita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

```
### 3- Insira dados no banco criado;
```SQL
insert into pizzaiolo (nome, salario) 
values ('André Felipe', 8900),
('Teruo Yamassaka', 8400),
('Yasmin braz', 8300),
('William Santos', 8100),
('Juliana ferreira', 8900),
('Kaua Seraphim', 8000);
```
```SQL
insert into pizza (sabor, preco_pizza, descricao,
tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
values ('Frango', 29.99, 'Pizza de frango com borda recheada ','G','G','Papelao', 7.99),
('Queijo', 29.99, 'Pizza de queijo com borda recheada', 'G', 'G', 'Papelao', 7.99),
('Calabresa', 27.99, 'Pizza de calabresa com borda recheada', 'M', 'M', 'Papelao', 5.99),
('Pepperoni', 29.99, 'Pizza de pepperoni com borda recheada', 'G', 'G', 'Papelao', 7.99),
('Brócolis', 22.99, 'Pizza de brócolis', 'P', 'P', 'Papelao', 3.99),
('Bacon', 27.99, 'Pizza de bacon com borda recheada', 'M', 'M', 'Papelao', 5.99),
('Milho', 22.99, 'Pizza de milho ', 'P', 'P', 'Papelao', 3.99);
```
### 4- Crie um relatório com todas as pizzas e os pizzaiolos aptos a produzi-las;
```SQL

```
### 5- Crie um relatório com todas as pizzas e seus ingredientes;
```SQL

```
### 6- Crie um relatório com todos os ingredientes e as pizzas onde são utilizados;
```SQL

```
### 7- Crie um relatório com os sabores de todas as pizzas, o nome dos pizzaiolos que as fazem e as instruções para produzi-las;


