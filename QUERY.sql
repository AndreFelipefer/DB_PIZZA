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
-- Table `mydb`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `sabor` VARCHAR(45) NULL,
  `preco_pizza` DECIMAL(9,2) NULL,
  `descricao` VARCHAR(45) NULL,
  `tamanho_pizza` CHAR(1) NULL,
  `tamanho_embalagem` CHAR(1) NULL,
  `material` VARCHAR(45) NULL,
  `preco_embalagem` VARCHAR(45) NULL,
  PRIMARY KEY (`id_pizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`receita` (
  `id_receita` INT NOT NULL AUTO_INCREMENT,
  `instrucoes` VARCHAR(45) NULL,
  `autor` VARCHAR(45) NULL,
  `pizza_id_pizza` INT NOT NULL,
  PRIMARY KEY (`id_receita`, `pizza_id_pizza`),
  INDEX `fk_receita_pizza1_idx` (`pizza_id_pizza` ASC) VISIBLE,
  CONSTRAINT `fk_receita_pizza1`
    FOREIGN KEY (`pizza_id_pizza`)
    REFERENCES `mydb`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizzaiolo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizzaiolo` (
  `id_pizzaiolo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `salario` DECIMAL(10,2) NULL,
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
  `ingredientes_pizza` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ingredientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingredientes_has_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingredientes_has_pizza` (
  `ingredientes_id_ingredientes` INT NOT NULL,
  `pizza_id_pizza` INT NOT NULL,
  PRIMARY KEY (`ingredientes_id_ingredientes`, `pizza_id_pizza`),
  INDEX `fk_ingredientes_has_pizza_pizza1_idx` (`pizza_id_pizza` ASC) VISIBLE,
  INDEX `fk_ingredientes_has_pizza_ingredientes1_idx` (`ingredientes_id_ingredientes` ASC) VISIBLE,
  CONSTRAINT `fk_ingredientes_has_pizza_ingredientes1`
    FOREIGN KEY (`ingredientes_id_ingredientes`)
    REFERENCES `mydb`.`ingredientes` (`id_ingredientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredientes_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id_pizza`)
    REFERENCES `mydb`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Mussarela
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Mussarela', 22.99, 'Pizza de Mussarela', 'M', 'M', 'Papelao', 5.99);

-- Frango com Catupiry
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Frango com Catupiry', 24.99, 'Pizza de Frango com Catupiry', 'G', 'M', 'Papelao', 6.99);

-- Portuguesa
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Portuguesa', 23.99, 'Pizza Portuguesa', 'M', 'G', 'Papelao', 7.99);

-- Vegetariana
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Vegetariana', 21.99, 'Pizza Vegetariana', 'P', 'P', 'Papelao', 4.99);

-- Chocolate
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Chocolate', 20.99, 'Pizza de Chocolate', 'P', 'M', 'Papelao', 5.99);

-- Peperoni
INSERT INTO pizza (sabor, preco_pizza, descricao, tamanho_pizza, tamanho_embalagem, material, preco_embalagem)
VALUES ('Peperoni', 22.99, 'Pizza de Peperoni', 'P', 'G', 'Papelao', 6.99);
-- Mussarela
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de tomate'), ('queijo mussarela');

-- Frango com Catupiry
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de tomate'), ('frango desfiado'), ('catupiry');

-- Portuguesa
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de tomate'), ('presunto'), ('queijo mussarela'), ('ovo'), ('azeitonas'), ('orégano');

-- Vegetariana
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de tomate'), ('queijo mussarela'), ('tomate'), ('cebola'), ('azeitonas'), ('orégano');

-- Chocolate
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de chocolate'), ('chocolate derretido');

-- Peperoni
INSERT INTO ingredientes (ingredientes_pizza)
VALUES ('molho de tomate'), ('queijo mussarela'), ('rodelas de pepperoni');insert into pizzaiolo (nome, salario)
values ('Maria', 1199.99);

insert into pizzaiolo (nome, salario)
values ('João', 1199.99);

insert into pizzaiolo (nome, salario)
values ('Ana', 1199.99);

insert into pizzaiolo (nome, salario)
values ('Carlos', 1199.99);
INSERT INTO receita (instrucoes, autor, pizza_id_pizza)
VALUES ('Massa de pizza, molho de tomate, queijo mussarela', 'Jorge', 1),
('Massa de pizza, molho de tomate, frango desfiado, catupiry', 'Maria', 2),
('Massa de pizza, molho de tomate, presunto, queijo mussarela, ovo, azeitonas e orégano', 'João', 3),
('Massa de pizza, molho de tomate, queijo mussarela, tomate, cebola, azeitonas e orégano', 'Ana', 4),
('Massa de pizza, molho de chocolate, chocolate derretido', 'Jorge', 5),
('Massa de pizza, molho de tomate, queijo mussarela, rodelas de pepperoni', 'Carlos', 6);

insert into  pizza_has_pizzaiolo ( pizza_id_pizza, pizzaiolo_id_pizzaiolo) values
(1, 1), (2,2) , (3,3), (4,4), (5,2) ,(6,4);

select pizza.sabor as Tab_SaborPizza, pizzaiolo.nome as pizzaiolo 
from pizza 
join pizza_has_pizzaiolo on pizza.id_pizza = pizza_has_pizzaiolo.pizza_id_pizza 
join pizzaiolo on pizza_has_pizzaiolo.pizzaiolo_id_pizzaiolo  = pizzaiolo.id_pizzaiolo;

select 
	pizza.sabor as sabor, 
   group_concat( ingredientes.ingredientes_pizza) as ingredientes
from pizza join ingredientes_has_pizza on pizza.id_pizza =  ingredientes_has_pizza.pizza_id_pizza
join ingredientes on ingredientes_has_pizza.ingredientes_id_ingredientes = ingredientes.id_ingredientes
group by pizza.sabor;

select 
	ingredientes.ingredientes_pizza as Ingredientes,
    group_concat(pizza.sabor) as Sabor
from ingredientes join ingredientes_has_pizza on ingredientes.id_ingredientes =  ingredientes_has_pizza.ingredientes_id_ingredientes
join pizza on ingredientes_has_pizza.pizza_id_pizza = pizza.id_pizza
GROUP BY ingredientes.ingredientes_pizza;

select 
	ingredientes.ingredientes_pizza as Ingredientes,
    group_concat(pizza.sabor) as Sabor
from ingredientes join ingredientes_has_pizza on ingredientes.id_ingredientes =  ingredientes_has_pizza.ingredientes_id_ingredientes
join pizza on ingredientes_has_pizza.pizza_id_pizza = pizza.id_pizza
GROUP BY ingredientes.ingredientes_pizza;

