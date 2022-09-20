-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`clientes` (
  `cpf` CHAR(11) NOT NULL,
  `primeiro_nome` VARCHAR(30) NOT NULL,
  `ultimo_nome` VARCHAR(30) NOT NULL,
  `logradouro` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB
COMMENT = 'Tabela cadastro de clientes';


-- -----------------------------------------------------
-- Table `oficina`.`veiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`veiculos` (
  `idveiculo` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(20) NOT NULL,
  `modelo` VARCHAR(30) NOT NULL,
  `cor` VARCHAR(20) NOT NULL,
  `placa` CHAR(7) NOT NULL,
  `clientes_cpf` CHAR(11) NOT NULL,
  PRIMARY KEY (`idveiculo`),
  INDEX `fk_veiculos_clientes_idx` (`clientes_cpf` ASC) VISIBLE,
  CONSTRAINT `fk_veiculos_clientes`
    FOREIGN KEY (`clientes_cpf`)
    REFERENCES `oficina`.`clientes` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela cadastro de veículos';


-- -----------------------------------------------------
-- Table `oficina`.`mecanicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`mecanicos` (
  `idmecanico` INT NOT NULL,
  `nome_mecanico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmecanico`))
ENGINE = InnoDB
COMMENT = 'Tabela dos mecânicos da oficina.';


-- -----------------------------------------------------
-- Table `oficina`.`especializacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`especializacoes` (
  `idespecializacao` INT NOT NULL AUTO_INCREMENT,
  `nome_especializacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idespecializacao`))
ENGINE = InnoDB
COMMENT = 'Tabela dos tipos de especializações.';


-- -----------------------------------------------------
-- Table `oficina`.`mec_espec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`mec_espec` (
  `mecanicos_idmecanico` INT NOT NULL,
  `especializacoes_idespecializao` INT NOT NULL,
  INDEX `fk_mec_espec_mecanicos1_idx` (`mecanicos_idmecanico` ASC) VISIBLE,
  INDEX `fk_mec_espec_especializacoes1_idx` (`especializacoes_idespecializacao` ASC) VISIBLE,
  CONSTRAINT `fk_mec_espec_mecanicos1`
    FOREIGN KEY (`mecanicos_idmecanico`)
    REFERENCES `oficina`.`mecanicos` (`idmecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mec_espec_especializacoes1`
    FOREIGN KEY (`especializacoes_idespecializao`)
    REFERENCES `oficina`.`especializacoes` (`idespecializao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela das especializações dos mecânicos.';


-- -----------------------------------------------------
-- Table `oficina`.`servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`servicos` (
  `idservico` INT NOT NULL AUTO_INCREMENT,
  `desc_servico` VARCHAR(45) NOT NULL,
  `preco_servico` FLOAT(7,2) NOT NULL,
  PRIMARY KEY (`idservico`))
ENGINE = InnoDB
COMMENT = 'Tabela dos tipos e preço dos serviços';


-- -----------------------------------------------------
-- Table `oficina`.`pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`pecas` (
  `idpeca` INT NOT NULL AUTO_INCREMENT,
  `desc_peca` VARCHAR(45) NOT NULL,
  `preco_peca` FLOAT(7,2) NOT NULL,
  PRIMARY KEY (`idpeca`))
ENGINE = InnoDB
COMMENT = 'Tabela cadastro de peças e preços';


-- -----------------------------------------------------
-- Table `oficina`.`ordens_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`ordens_servico` (
  `id_os` INT NOT NULL AUTO_INCREMENT,
  `data_os` DATE NOT NULL,
  `data_entrega` DATE NOT NULL,
  `status` ENUM('Avaliação', 'Autorizado', 'Cancelado') NOT NULL DEFAULT 'Avaliação',
  `veiculos_idveiculo` INT NOT NULL,
  `mecanicos_idmecanico` INT NOT NULL,
  PRIMARY KEY (`id_os`),
  INDEX `fk_ordens_servico_veiculos1_idx` (`veiculos_idveiculo` ASC) VISIBLE,
  INDEX `fk_ordens_servico_mecanicos1_idx` (`mecanicos_idmecanico` ASC) VISIBLE,
  CONSTRAINT `fk_ordens_servico_veiculos1`
    FOREIGN KEY (`veiculos_idveiculo`)
    REFERENCES `oficina`.`veiculos` (`idveiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordens_servico_mecanicos1`
    FOREIGN KEY (`mecanicos_idmecanico`)
    REFERENCES `oficina`.`mecanicos` (`idmecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela Ordens de Serviços.';


-- -----------------------------------------------------
-- Table `oficina`.`det_os_servicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`det_os_servicos` (
  `ordens_servico_id_os` INT NOT NULL,
  `servicos_idservico` INT NOT NULL,
  INDEX `fk_det_os_servicos_servicos1_idx` (`servicos_idservico` ASC) VISIBLE,
  INDEX `fk_det_os_servicos_ordens_servico1_idx` (`ordens_servico_id_os` ASC) VISIBLE,
  CONSTRAINT `fk_det_os_servicos_servicos1`
    FOREIGN KEY (`servicos_idservico`)
    REFERENCES `oficina`.`servicos` (`idservico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_det_os_servicos_ordens_servico1`
    FOREIGN KEY (`ordens_servico_id_os`)
    REFERENCES `oficina`.`ordens_servico` (`id_os`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela detalhamento somente dos serviços (sem peças)';


-- -----------------------------------------------------
-- Table `oficina`.`det_os_pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`det_os_pecas` (
  `ordens_servico_id_os` INT NOT NULL,
  `pecas_idpeca` INT NOT NULL,
  INDEX `fk_det_os_pecas_ordens_servico1_idx` (`ordens_servico_id_os` ASC) VISIBLE,
  INDEX `fk_det_os_pecas_pecas1_idx` (`pecas_idpeca` ASC) VISIBLE,
  CONSTRAINT `fk_det_os_pecas_ordens_servico1`
    FOREIGN KEY (`ordens_servico_id_os`)
    REFERENCES `oficina`.`ordens_servico` (`id_os`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_det_os_pecas_pecas1`
    FOREIGN KEY (`pecas_idpeca`)
    REFERENCES `oficina`.`pecas` (`idpeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabela detalhamento das peças que compõem o serviço.';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
