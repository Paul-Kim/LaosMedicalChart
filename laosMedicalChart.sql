-- MySQL Workbench Synchronization
-- Generated: 2016-07-03 00:17
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: kmc55

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `laos` DEFAULT CHARACTER SET utf8 ;

DROP TABLE IF EXISTS `laos`.`patient`;
CREATE TABLE IF NOT EXISTS `laos`.`patient` (
  `pid` INT(11) NOT NULL AUTO_INCREMENT,
  `pname` VARCHAR(50) NOT NULL,
  `birth` DATE NOT NULL,
  `sex` CHAR(1) NOT NULL,
  `reciept_datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `systolicBP` INT(11) NULL DEFAULT NULL,
  `diastolicBP` INT(11) NULL DEFAULT NULL,
  `pulse` INT(11) NULL DEFAULT NULL,
  `temperature` FLOAT(11) NULL DEFAULT NULL,
  `bst` INT(11) NULL DEFAULT NULL,
  `height` FLOAT(11) NULL DEFAULT NULL,
  `weight` FLOAT(11) NULL DEFAULT NULL,
  `spo2` FLOAT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `laos`.`chart`;
CREATE TABLE IF NOT EXISTS `laos`.`chart` (
  `cid` INT(11) NOT NULL AUTO_INCREMENT,
  `pid` INT(11) NOT NULL,
  `medical_chart` TEXT NULL DEFAULT NULL,
  `prescription` TEXT NULL DEFAULT NULL,
  `oriental_chart` TEXT NULL DEFAULT NULL,
  `oriental_prescription` TEXT NULL DEFAULT NULL,
  `lab` TEXT NULL DEFAULT NULL,
  `memo` TEXT NULL DEFAULT NULL,
  `createTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `complete` boolean NULL DEFAULT NULL,
  PRIMARY KEY (`cid`, `pid`),
  INDEX `fk_chart_patient_idx` (`pid` ASC),
  CONSTRAINT `fk_chart_patient`
    FOREIGN KEY (`pid`)
    REFERENCES `laos`.`patient` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = '	';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


drop procedure if exists insert_chart;
delimiter #
create procedure insert_chart(
in p_id INT(11)
)
begin
	declare c_id INT(11) default 0;
	insert into chart (pid) values (p_id);
	set c_id = last_insert_id();

	select cid, pid, medical_chart, prescription, oriental_chart, oriental_prescription, lab, memo, DATE_FORMAT(createTime, '%Y-%m-%d %h:%i %p') as createTime
    from chart where cid = c_id AND pid = p_id;
end#
delimiter ;

-- ------------------------------------------

USE LAOS;
SHOW TABLES;

