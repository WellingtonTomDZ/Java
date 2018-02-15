-- MySQL Script generated by MySQL Workbench
-- Wed Jan 24 09:09:10 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema loja
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema loja
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `loja` DEFAULT CHARACTER SET utf8 ;
USE `loja` ;

-- -----------------------------------------------------
-- Table `loja`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`cliente` (
  `idCliente` BIGINT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` INT(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`pagamento` (
  `idPagamento` BIGINT NOT NULL,
  `codPagamento` INT(11) NOT NULL,
  `cliente_idCliente` BIGINT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_pagamento_cliente1_idx` (`cliente_idCliente` ASC),
  CONSTRAINT `fk_pagamento_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `loja`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`carrinho` (
  `idcarrinho` BIGINT NOT NULL,
  `pagamento_idPagamento` BIGINT NOT NULL,
  `cliente_idCliente` BIGINT NOT NULL,
  PRIMARY KEY (`idcarrinho`),
  INDEX `fk_carrinho_pagamento1_idx` (`pagamento_idPagamento` ASC),
  INDEX `fk_carrinho_cliente1_idx` (`cliente_idCliente` ASC),
  CONSTRAINT `fk_carrinho_pagamento1`
    FOREIGN KEY (`pagamento_idPagamento`)
    REFERENCES `loja`.`pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrinho_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `loja`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`categoria` (
  `idCategoria` BIGINT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`endereco` (
  `idendereco` BIGINT NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `CEP` INT(11) NOT NULL,
  `cliente_idCliente` BIGINT NOT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_cliente1_idx` (`cliente_idCliente` ASC),
  CONSTRAINT `fk_endereco_cliente1`
    FOREIGN KEY (`cliente_idCliente`)
    REFERENCES `loja`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`fabricante` (
  `idFabricante` BIGINT NOT NULL,
  `codigo` INT(11) NOT NULL,
  `nomeFabricante` VARCHAR(45) NOT NULL,
  `enderecoFabricante` VARCHAR(45) NOT NULL,
  `CNPJ` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFabricante`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`formapagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`formapagamento` (
  `idFormaPagamento` BIGINT NOT NULL,
  `pagamento` ENUM('debito', 'credito', 'boleto') NOT NULL,
  `pagamento_idPagamento` BIGINT NOT NULL,
  PRIMARY KEY (`idFormaPagamento`),
  INDEX `fk_formapagamento_pagamento1_idx` (`pagamento_idPagamento` ASC),
  CONSTRAINT `fk_formapagamento_pagamento1`
    FOREIGN KEY (`pagamento_idPagamento`)
    REFERENCES `loja`.`pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`produto` (
  `idProduto` BIGINT NOT NULL,
  `nomeProduto` VARCHAR(45) NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `preco` DOUBLE NOT NULL,
  `quantidade` INT(11) NOT NULL,
  `tamanho` VARCHAR(45) NOT NULL,
  `cor` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`produto_has_fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`produto_has_fabricante` (
  `produto_idProduto` BIGINT NOT NULL,
  `fabricante_idFabricante` BIGINT NOT NULL,
  PRIMARY KEY (`produto_idProduto`, `fabricante_idFabricante`),
  INDEX `fk_produto_has_fabricante_fabricante1_idx` (`fabricante_idFabricante` ASC),
  INDEX `fk_produto_has_fabricante_produto1_idx` (`produto_idProduto` ASC),
  CONSTRAINT `fk_produto_has_fabricante_produto1`
    FOREIGN KEY (`produto_idProduto`)
    REFERENCES `loja`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_fabricante_fabricante1`
    FOREIGN KEY (`fabricante_idFabricante`)
    REFERENCES `loja`.`fabricante` (`idFabricante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`produto_has_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`produto_has_categoria` (
  `produto_idProduto` BIGINT NOT NULL,
  `categoria_idCategoria` BIGINT NOT NULL,
  PRIMARY KEY (`produto_idProduto`, `categoria_idCategoria`),
  INDEX `fk_produto_has_categoria_categoria1_idx` (`categoria_idCategoria` ASC),
  INDEX `fk_produto_has_categoria_produto1_idx` (`produto_idProduto` ASC),
  CONSTRAINT `fk_produto_has_categoria_produto1`
    FOREIGN KEY (`produto_idProduto`)
    REFERENCES `loja`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idCategoria`)
    REFERENCES `loja`.`categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `loja`.`produto_has_carrinho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `loja`.`produto_has_carrinho` (
  `produto_idProduto` BIGINT NOT NULL,
  `carrinho_idcarrinho` BIGINT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`produto_idProduto`, `carrinho_idcarrinho`),
  INDEX `fk_produto_has_carrinho_carrinho1_idx` (`carrinho_idcarrinho` ASC),
  INDEX `fk_produto_has_carrinho_produto1_idx` (`produto_idProduto` ASC),
  CONSTRAINT `fk_produto_has_carrinho_produto1`
    FOREIGN KEY (`produto_idProduto`)
    REFERENCES `loja`.`produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_carrinho_carrinho1`
    FOREIGN KEY (`carrinho_idcarrinho`)
    REFERENCES `loja`.`carrinho` (`idcarrinho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
