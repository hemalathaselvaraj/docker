USE `recap` ;

-- Script for Release 0.9.24 starts here

CREATE TABLE IF NOT EXISTS `JOB_PARAM_T` (
  `RECORD_NUM`    INT  NOT NULL AUTO_INCREMENT,
  `JOB_NAME`     VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RECORD_NUM`),
  UNIQUE INDEX `JOB_NAME_UNIQUE` (`JOB_NAME` ASC)
)
  ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `JOB_PARAM_DATA_T` (
  `JOB_PARAM_DATA_ID` INT         NOT NULL AUTO_INCREMENT,
  `PARAM_NAME`    VARCHAR(100) NOT NULL,
  `PARAM_VALUE`   VARCHAR(2000) NOT NULL,
  `RECORD_NUM`     INT         NULL,
  PRIMARY KEY (`JOB_PARAM_DATA_ID`),
  INDEX `RECORD_NUM_idx` (`RECORD_NUM` ASC),
  INDEX `PARAM_NAME_idx` (`PARAM_NAME` ASC)
)
  ENGINE = InnoDB;

UPDATE `recap`.`customer_code_t` SET `DELIVERY_RESTRICTIONS`='BT,BZ,CS,MP,MH,RH,RS' WHERE `CUSTOMER_CODE`='RH';
UPDATE `recap`.`customer_code_t` SET `DELIVERY_RESTRICTIONS`='BT,BZ,MP,MZ,RS,RH' WHERE `CUSTOMER_CODE`='RS';

INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (5,'GenerateAccessionReport','Generate Accession Report',NULL,NULL,NULL,NULL);
INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (6,'Accession','Ongoing Accession',NULL,NULL,NULL,NULL);
INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (7,'RunJobSequentially','Run Job Sequentially',NULL,NULL,NULL,NULL);
INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (8,'PurgeAccessionRequests','Purge Accession Requests',NULL,NULL,NULL,NULL);
INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (9,'AccessionReconcilation','Generate DailyReconcilation Report',NULL,NULL,NULL,NULL);

-- Script for Release 0.9.24 ends here

-- Script for Release 0.9.23 starts here
UPDATE `recap`.`CUSTOMER_CODE_T` SET `DESCRIPTION`='Firestone Library' WHERE `CUSTOMER_CODE`='PA';
INSERT INTO `recap`.`REQUEST_ITEM_STATUS_T` (`REQUEST_STATUS_ID`,`REQUEST_STATUS_CODE`,`REQUEST_STATUS_DESC`) VALUES (9,'INITIAL_LOAD','INITIAL LOAD');
INSERT INTO `recap`.`job_t` (`JOB_ID`,`JOB_NAME`,`JOB_DESC`,`LAST_EXECUTED_TIME`,`NEXT_RUN_TIME`,`CRON_EXP`,`STATUS`) VALUES (4,'DailyReconcilation','Generate DailyReconcilation Report',NULL,NULL,NULL,NULL);

DROP TABLE AUDIT_T;
DROP TABLE LOAN_T;

-- Script for Release 0.9.23 ends here

-- Script for Release 0.9.22 starts here

DELETE FROM CROSS_PARTNER_MAPPING_T;
DELETE FROM DELIVERY_RESTRICTION_CROSS_PARTNER_T;
DELETE FROM CUSTOMER_CODE_T;
ALTER TABLE CUSTOMER_CODE_T ADD COLUMN CIRC_DESK_LOCATION VARCHAR(20) NULL DEFAULT NULL AFTER RECAP_DELIVERY_RESTRICTIONS;

INSERT INTO REQUEST_ITEM_STATUS_T (REQUEST_STATUS_ID, REQUEST_STATUS_CODE, REQUEST_STATUS_DESC) VALUES (8,"PROCESSING","PROCESSING ...");

-- Script for Release 0.9.22 starts here

-- Script for Release 0.9.21 starts here

ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` DROP FOREIGN KEY `FK_CROSS_PARTNER_CUSTOMER_CODE`;

ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` DROP FOREIGN KEY `FK_DELIVERY_RESTRICTION_ID`;

TRUNCATE RECAP.CROSS_PARTNER_MAPPING_T;

TRUNCATE RECAP.CUSTOMER_CODE_T ;

TRUNCATE RECAP.DELIVERY_RESTRICTION_CROSS_PARTNER_T;

ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` ADD CONSTRAINT `FK_CROSS_PARTNER_CUSTOMER_CODE` FOREIGN KEY (`CUSTOMER_CODE_ID`) REFERENCES `RECAP`.`CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`)
ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` ADD CONSTRAINT `FK_DELIVERY_RESTRICTION_ID` FOREIGN KEY (`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`) REFERENCES `RECAP`.`DELIVERY_RESTRICTION_CROSS_PARTNER_T` (`DELIVERY_RESTRICTION_CROSS_PARTNER_ID`)
ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Script for Release 0.9.21 starts here

-- Script for Release 0.9.20 starts here
ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` DROP FOREIGN KEY `FK_CROSS_PARTNER_CUSTOMER_CODE`;

TRUNCATE RECAP.CROSS_PARTNER_MAPPING_T;

TRUNCATE RECAP.CUSTOMER_CODE_T ;

ALTER TABLE `RECAP`.`CROSS_PARTNER_MAPPING_T` ADD CONSTRAINT `FK_CROSS_PARTNER_CUSTOMER_CODE` FOREIGN KEY (`CUSTOMER_CODE_ID`) REFERENCES `RECAP`.`CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`)
ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Script for Release 0.9.20 ends here

ALTER TABLE `RECAP`.`CUSTOMER_CODE_T` DROP FOREIGN KEY `CUST_CODE_OWNING_INST_ID_FK`;

ALTER TABLE `RECAP`.`CUSTOMER_CODE_T` CHANGE COLUMN `OWNING_INST_ID` `OWNING_INST_ID` INT(11) NULL ;

ALTER TABLE `RECAP`.`CUSTOMER_CODE_T` ADD CONSTRAINT `CUST_CODE_OWNING_INST_ID_FK` FOREIGN KEY (`OWNING_INST_ID`) REFERENCES `RECAP`.`INSTITUTION_T` (`INSTITUTION_ID`)
ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE CUSTOMER_CODE_T ADD COLUMN  PWD_DELIVERY_RESTRICTIONS VARCHAR(2000) NULL AFTER DELIVERY_RESTRICTIONS;

ALTER TABLE CUSTOMER_CODE_T ADD COLUMN  RECAP_DELIVERY_RESTRICTIONS VARCHAR(2000) NULL AFTER PWD_DELIVERY_RESTRICTIONS;

SET FOREIGN_KEY_CHECKS=0;

TRUNCATE RECAP.CUSTOMER_CODE_T ;

TRUNCATE RECAP.CROSS_PARTNER_MAPPING_T;

SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE `MATCHING_BIB_INFO_DETAIL_T` CHANGE `RECORD_NUM` `LATEST_RECORD_NUM` int(11);

UPDATE `ROLES_T` SET `ROLE_NAME`='Request' WHERE `ROLE_ID`='3';

INSERT INTO `recap`.`CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`,`CUSTOMER_CODE`,`DESCRIPTION`,`OWNING_INST_ID`,`DELIVERY_RESTRICTIONS`) VALUES( 110,'QX','Broadcast Center',1,'');

UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='' WHERE `CUSTOMER_CODE` = 'BU' AND `OWNING_INST_ID`='2';

truncate recap.customer_code_t ;

INSERT INTO `COLLECTION_GROUP_T` (`COLLECTION_GROUP_ID`,`COLLECTION_GROUP_CODE`,`COLLECTION_GROUP_DESC`,`CREATED_DATE`,`LAST_UPDATED_DATE`) VALUES (4,'NA','Not Available','2016-05-23 01:00:00',NULL);
INSERT INTO `REQUEST_ITEM_STATUS_T` (`REQUEST_STATUS_ID`, `REQUEST_STATUS_CODE`, `REQUEST_STATUS_DESC`) VALUES ('7', 'PENDING', 'PENDING');
INSERT INTO `INSTITUTION_T` (`INSTITUTION_ID`,`INSTITUTION_CODE`,`INSTITUTION_NAME`) VALUES (4,'HTC','HTC Global Services Inc.');
INSERT INTO `USER_T` (`LOGIN_ID`,`USER_INSTITUTION`,`USER_DESCRIPTION`,`CREATED_DATE`,`CREATED_BY`,`LAST_UPDATED_DATE`,`LAST_UPDATED_BY`) VALUES ('superadmin',4,'HTC User',now(),'ReCAP',now(),'ReCAP');
INSERT INTO `USER_ROLE_T` (`USER_ID`,`ROLE_ID`) VALUES (LAST_INSERT_ID(),1);
ALTER TABLE REQUEST_ITEM_T DROP FOREIGN KEY REQUEST_PATRON_ID_FK;
ALTER TABLE REQUEST_ITEM_T CHANGE COLUMN PATRON_ID PATRON_ID VARCHAR(45) NOT NULL ;
ALTER TABLE REQUEST_ITEM_T ADD COLUMN EMAIL_ID VARCHAR(45) NULL DEFAULT NULL AFTER NOTES;
DROP TABLE PATRON_T;

ALTER TABLE REQUEST_ITEM_T DROP COLUMN EMAIL_ID;
ALTER TABLE REQUEST_ITEM_T ADD COLUMN NOTES VARCHAR(2000) NULL AFTER REQUEST_STATUS_ID;
DROP TABLE NOTES_T;

ALTER TABLE `PERMISSIONS_T` MODIFY `PERMISSION_NAME` VARCHAR(120);

UPDATE `ROLES_T` SET `ROLE_NAME`='Super Admin' WHERE `ROLE_ID`=1;
UPDATE `ROLES_T` SET `ROLE_NAME`='Search Request' WHERE `ROLE_ID`=3;

UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Create User' WHERE `PERMISSION_ID`='1';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Write/Edit CGD' WHERE `PERMISSION_ID`='2';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Deaccession' WHERE `PERMISSION_ID`='3';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Place requests for own institution\'s items and Shared/Open items of other institution' WHERE `PERMISSION_ID`='4';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Place all requests' WHERE `PERMISSION_ID`='5';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Cancel requests' WHERE `PERMISSION_ID`='6';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='View and print reports' WHERE `PERMISSION_ID`='7';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Search' WHERE `PERMISSION_ID`='8';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Search (barcode number masked)' WHERE `PERMISSION_ID`='9';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Request Items' WHERE `PERMISSION_ID`='10';
UPDATE `PERMISSIONS_T` SET `PERMISSION_NAME`='Cancel all requests' WHERE `PERMISSION_ID`='11';

ALTER TABLE `ROLES_T` ADD COLUMN `CREATED_DATE` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `ROLES_T` ADD COLUMN `CREATED_BY` VARCHAR(45) NOT NULL;

ALTER TABLE `ROLES_T` ADD COLUMN `LAST_UPDATED_DATE` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `ROLES_T` ADD COLUMN `LAST_UPDATED_BY` VARCHAR(45) NOT NULL;

UPDATE `ROLES_T` SET  `CREATED_BY` = 'ReCAP' WHERE `CREATED_BY` = '';

UPDATE `ROLES_T` SET  `LAST_UPDATED_BY` = 'ReCAP' WHERE `LAST_UPDATED_BY` = '';

ALTER TABLE `USER_T` ADD COLUMN `CREATED_DATE` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `USER_T` ADD COLUMN `CREATED_BY` VARCHAR(45) NOT NULL;

ALTER TABLE `USER_T` ADD COLUMN `LAST_UPDATED_DATE` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `USER_T` ADD COLUMN `LAST_UPDATED_BY` VARCHAR(45) NOT NULL;

UPDATE `USER_T` SET `CREATED_BY` = 'ReCAP' WHERE `CREATED_BY` = '';

UPDATE `USER_T` SET `LAST_UPDATED_BY` = 'ReCAP' WHERE `LAST_UPDATED_BY` = '';

ALTER TABLE REQUEST_ITEM_T ADD COLUMN EMAIL_ID VARCHAR(100) NULL AFTER STOP_CODE;
ALTER TABLE REQUEST_ITEM_T ADD COLUMN CREATED_BY VARCHAR(45) NOT NULL AFTER REQ_EXP_DATE;
UPDATE REQUEST_ITEM_T SET CREATED_BY = 'Guest';

DROP VIEW MATCHING_INSTBIB_V;

ALTER TABLE `USER_ROLE_T` ADD PRIMARY KEY(`USER_ID`,`ROLE_ID`);

ALTER TABLE `ROLE_PERMISSION_T` ADD PRIMARY KEY(`ROLE_ID`,`PERMISSION_ID`);

ALTER TABLE USER_T DROP INDEX USER_EMAILID_UNIQUE;

ALTER TABLE REQUEST_ITEM_T ADD COLUMN REQUEST_STATUS_ID INT(11) NOT NULL AFTER REQUESTING_INST_ID, ADD INDEX REQUEST_STATUS_ID_FK_idx (REQUEST_STATUS_ID ASC);
UPDATE REQUEST_ITEM_T SET REQUEST_STATUS_ID = 4;
ALTER TABLE REQUEST_ITEM_T ADD CONSTRAINT REQUEST_STATUS_ID_FK FOREIGN KEY (REQUEST_STATUS_ID) REFERENCES REQUEST_ITEM_STATUS_T (REQUEST_STATUS_ID) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `USER_T`
ADD COLUMN `USER_EMAILID` VARCHAR(60) NULL AFTER `USER_DESCRIPTION`,
DROP INDEX `FK_USER_T_1_IDX` ,
ADD INDEX `FK_USER_T_1_IDX` (`USER_INSTITUTION` ASC, `LOGIN_ID` ASC),
ADD UNIQUE INDEX `USER_EMAILID_UNIQUE` (`USER_EMAILID` ASC);

ALTER TABLE `MATCHING_MATCHPOINTS_T` MODIFY COLUMN `CRITERIA_VALUE` VARCHAR(500);

ALTER TABLE  `ROLE_PERMISSION_T` DROP FOREIGN KEY `FK_ROLE_PERMISSION_T_1`;

ALTER TABLE `USER_ROLE_T` DROP FOREIGN KEY `FK_USER_ROLE_T_2`;

ALTER TABLE `ROLES_T` MODIFY `ROLE_ID` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `ROLE_PERMISSION_T` ADD CONSTRAINT `FK_ROLE_PERMISSION_T_1` FOREIGN KEY (`ROLE_ID`) REFERENCES `ROLES_T` (`ROLE_ID`);

ALTER TABLE `USER_ROLE_T` ADD CONSTRAINT `FK_USER_ROLE_T_2` FOREIGN KEY (`ROLE_ID`) REFERENCES `ROLES_T` (`ROLE_ID`);

ALTER TABLE  `USER_ROLE_T` DROP FOREIGN KEY `FK_USER_ROLE_T_1`;

ALTER TABLE `USER_T` MODIFY `USER_ID` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `USER_ROLE_T` ADD CONSTRAINT `FK_USER_ROLE_T_1` FOREIGN KEY (`USER_ID`) REFERENCES `USER_T` (`USER_ID`);

ALTER TABLE `ROLE_PERMISSION_T` DROP FOREIGN KEY `FK_ROLE_PERMISSION_T_2`;

ALTER TABLE `PERMISSIONS_T` MODIFY `PERMISSION_ID` INT NOT NULL AUTO_INCREMENT;

ALTER TABLE `ROLE_PERMISSION_T` ADD CONSTRAINT `FK_ROLE_PERMISSION_T_2` FOREIGN KEY (`PERMISSION_ID`) REFERENCES `PERMISSIONS_T` (`PERMISSION_ID`);


SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';

DELETE FROM `request_type_t` WHERE `REQUEST_TYPE_CODE`='HOLD';

UPDATE `request_type_t` SET `REQUEST_TYPE_ID`='1' WHERE `REQUEST_TYPE_CODE`='RETRIEVAL';

UPDATE `request_type_t` SET `REQUEST_TYPE_ID`='2' WHERE `REQUEST_TYPE_CODE`='RECALL';

UPDATE `request_type_t` SET `REQUEST_TYPE_ID`='3' WHERE `REQUEST_TYPE_CODE`='EDD';

UPDATE `request_type_t` SET `REQUEST_TYPE_ID`='4' WHERE `REQUEST_TYPE_CODE`='BORROW DIRECT';

ALTER TABLE `request_type_t` AUTO_INCREMENT = 5 ;

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;


ALTER TABLE `recap`.`request_item_t`
DROP COLUMN `REQUEST_POSITION`,
DROP INDEX `REQUEST_POSITION_ITEM_ID_PATRON_IDUNIQUE` ;

ALTER TABLE `BIBLIOGRAPHIC_T` ADD COLUMN `CATALOGING_STATUS` VARCHAR(20);
ALTER TABLE `ITEM_T` ADD COLUMN `CATALOGING_STATUS` VARCHAR(20);

ALTER TABLE `CUSTOMER_CODE_T` DROP INDEX `CUSTOMER_CODE_UNIQUE`;
ALTER TABLE `CUSTOMER_CODE_T` ADD CONSTRAINT CUSTOMER_CODE_UNIQUE UNIQUE (`CUSTOMER_CODE`,`OWNING_INST_ID`);
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'AC' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'AD' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'AR' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'AV' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'BC' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'BL' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'BR' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'BS' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'BT' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'BU' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'BZ' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CA' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CF' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CH' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'CI' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'CJ' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CM' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CP' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'CR' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'CS' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'CU' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'CV' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'EA' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'EN' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'EV' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'GC' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'GE' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'GS' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'HR' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'HS' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'HX' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'JC' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'JD' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'LD' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'LE' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'ML' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'MP' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'MR' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'MZ' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'OH' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'RH' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'RS' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2', `DELIVERY_RESTRICTIONS`='AC,AD,AR,AV,BC,BL,BR,BS,BT,BU,BZ,CA,CF,CH,CI,CJ,CM,CP,CR,CS,CU,CV,EA,EN,EV,GC,GE,GS,HR,HS,HX,JC,JD,LD,LE,ML,MP,MR,MZ,OH,RH,RS,SW,UA,UT,CD,CL,CX,JL,JM' WHERE `CUSTOMER_CODE` = 'SW' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'UA' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `OWNING_INST_ID`='2' WHERE `CUSTOMER_CODE` = 'UT' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NA' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NC**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'ND**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NE**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NF**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NG**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS,EDD,GO,IL,RR' WHERE `CUSTOMER_CODE` = 'NH' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NI**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NJ**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NK**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS,EDD,GO,IL,RR' WHERE `CUSTOMER_CODE` = 'NL' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NM**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NT**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS,EDD,GO,IL,RR' WHERE `CUSTOMER_CODE` = 'NW' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NY' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'NZ**' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'GN' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'ID' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS' WHERE `CUSTOMER_CODE` = 'JN' AND `OWNING_INST_ID`='3';
UPDATE `CUSTOMER_CODE_T` SET `DELIVERY_RESTRICTIONS`='NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS,EDD,GO,IL,RR' WHERE `CUSTOMER_CODE` = 'JO' AND `OWNING_INST_ID`='3';
INSERT INTO `CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`,`CUSTOMER_CODE`,`DESCRIPTION`,`OWNING_INST_ID`,`DELIVERY_RESTRICTIONS`) VALUES (116,'GO','Google NYPL',3,'NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS');
INSERT INTO `CUSTOMER_CODE_T` (`CUSTOMER_CODE_ID`,`CUSTOMER_CODE`,`DESCRIPTION`,`OWNING_INST_ID`,`DELIVERY_RESTRICTIONS`) VALUES (117,'JS','SIBL De-duping candidates',3,'NA,NB,NC**,ND**,NE**,NF**,NG**,NH,NI**,NJ**,NK**,NL,NM**,NN,NO,NP,NQ,NR,NS,NT**,NU,NV,NW,NX,NY,NZ**,GN,GO,ID,JN,JO,JS');

ALTER TABLE `request_item_t` CHANGE `CREATD_DATE` `CREATED_DATE` DATETIME;

ALTER TABLE `request_item_t` ADD COLUMN `REQUESTING_INST_ID` INT NOT NULL;

ALTER TABLE `request_item_t` ADD INDEX `REQUESTING_INST_ID_FK_idx` (`REQUESTING_INST_ID` ASC);

ALTER TABLE `request_item_t` ADD CONSTRAINT `REQUESTING_INST_ID_FK` FOREIGN KEY (`REQUESTING_INST_ID`) REFERENCES `institution_t` (`INSTITUTION_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

UPDATE `request_type_t` SET `REQUEST_TYPE_CODE`='BORROW DIRECT', `REQUEST_TYPE_DESC`='BORROW DIRECT' WHERE `REQUEST_TYPE_ID`='5';

DROP INDEX OCLC_idx ON matching_bib_t;

DROP INDEX ISBN_idx ON matching_bib_t;

DROP INDEX ISSN_idx ON matching_bib_t;

ALTER TABLE matching_bib_t MODIFY COLUMN OCLC VARCHAR(1500);

ALTER TABLE matching_bib_t MODIFY COLUMN ISBN VARCHAR(1500);

ALTER TABLE matching_bib_t MODIFY COLUMN ISSN VARCHAR(1500);