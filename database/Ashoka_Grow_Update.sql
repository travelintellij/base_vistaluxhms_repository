

CREATE TABLE travel_claim_bills (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    travelClaimId BIGINT NOT NULL,
    bill_file LONGBLOB NOT NULL,
    file_name VARCHAR(255),
    file_type VARCHAR(100),
    CONSTRAINT fk_travel_claim FOREIGN KEY (travelClaimId)
      REFERENCES my_travel_claims (travelClaimId)
      ON DELETE CASCADE
);

ALTER TABLE `ashokadb`.`my_travel_claims`
ADD COLUMN `otherExpensesDetails` VARCHAR(500) NULL AFTER `otherExpense3`;

ALTER TABLE `ashokadb`.`travel_claim_bills`
DROP FOREIGN KEY `fk_travel_claim`;
ALTER TABLE `ashokadb`.`travel_claim_bills`
DROP INDEX `fk_travel_claim` ;
;

ALTER TABLE `ashokadb`.`my_travel_claims`
CHANGE COLUMN `travelClaimId` `travelClaimId` BIGINT NOT NULL AUTO_INCREMENT ;


ALTER TABLE `ashokadb`.`travel_claim_bills`
ADD INDEX `fk_travel_claims_idx` (`travelClaimId` ASC) VISIBLE;
;
ALTER TABLE `ashokadb`.`travel_claim_bills`
ADD CONSTRAINT `fk_travel_claims`
  FOREIGN KEY (`travelClaimId`)
  REFERENCES `ashokadb`.`my_travel_claims` (`travelClaimId`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `ashokadb`.`my_travel_claims`
ADD COLUMN `claimStatus` INT NULL AFTER `claimentId`;


CREATE TABLE `ashokadb`.`status_master` (
  `statusId` INT NOT NULL AUTO_INCREMENT,
  `status_obj` VARCHAR(45) NULL,
  `status_obj_type` VARCHAR(150) NULL,
  `statusName` VARCHAR(250) NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`statusId`));

INSERT INTO `ashokadb`.`status_master` (`statusId`, `status_obj`, `status_obj_type`, `statusName`, `active`) VALUES ('1', 'TRAV_EXP', 'TRAVEL_EXPENSE_CLAIM', 'Claimed', '1');
INSERT INTO `ashokadb`.`status_master` (`statusId`, `status_obj`, `status_obj_type`, `statusName`, `active`) VALUES ('2', 'TRAV_EXP', 'TRAVEL_EXPENSE_CLAIM', 'Approved', '1');
INSERT INTO `ashokadb`.`status_master` (`statusId`, `status_obj`, `status_obj_type`, `statusName`, `active`) VALUES ('3', 'TRAV_EXP', 'TRAVEL_EXPENSE_CLAIM', 'Partially Approved', '1');
INSERT INTO `ashokadb`.`status_master` (`statusId`, `status_obj`, `status_obj_type`, `statusName`, `active`) VALUES ('4', 'TRAV_EXP', 'TRAVEL_EXPENSE_CLAIM', 'Rejected', '1');
INSERT INTO `ashokadb`.`status_master` (`statusId`, `status_obj`, `status_obj_type`, `statusName`, `active`) VALUES ('5', 'TRAV_EXP', 'TRAVEL_EXPENSE_CLAIM', 'Paid Settled', '1');


ALTER TABLE `ashokadb`.`status_master`
ADD COLUMN `master_status` TINYINT NULL AFTER `statusName`;

UPDATE `ashokadb`.`status_master` SET `master_status` = '1' WHERE (`statusId` = '1');
UPDATE `ashokadb`.`status_master` SET `master_status` = '1' WHERE (`statusId` = '2');
UPDATE `ashokadb`.`status_master` SET `master_status` = '1' WHERE (`statusId` = '4');
UPDATE `ashokadb`.`status_master` SET `master_status` = '1' WHERE (`statusId` = '3');
UPDATE `ashokadb`.`status_master` SET `master_status` = '1' WHERE (`statusId` = '5');

INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('43', 'SUPERADMIN', 'PRIV');
INSERT INTO `ashokadb`.`ashokateam_role` (`userRoleId`, `userId`, `roleId`) VALUES ('304', '1', '43');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('5000', 'EXPENSE_APPROVER', 'EXPENSE');
UPDATE `ashokadb`.`role` SET `roleTarget` = 'EXPENSE-SAR' WHERE (`roleId` = '5000');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('5100', 'CAN_CLAIM', 'EXPENSE-SAR');

ALTER TABLE `ashokadb`.`my_travel_claims`
CHANGE COLUMN `kms` `kms` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `travelExpense` `travelExpense` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `foodExpense` `foodExpense` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `parkingExpense` `parkingExpense` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `otherExpense1` `otherExpense1` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `otherExpense2` `otherExpense2` INT NOT NULL DEFAULT 0 ,
CHANGE COLUMN `otherExpense3` `otherExpense3` INT NOT NULL ,
CHANGE COLUMN `claimStatus` `claimStatus` INT NULL ;

CREATE TABLE hotel_central_config (
    id INT PRIMARY KEY AUTO_INCREMENT,
    logo_path VARCHAR(255),
    bank_name VARCHAR(100),
    account_number VARCHAR(50),
    ifsc_code VARCHAR(20),
    branch VARCHAR(100),
    global_watcher_emails TEXT,
    hotel_name VARCHAR(150),
    hotel_address VARCHAR(255),
    hotel_central_number VARCHAR(20),
    global_watcher_enabled BOOLEAN DEFAULT FALSE,
    facebook_link VARCHAR(255),
    instagram_link VARCHAR(255),
    linkedin_link VARCHAR(255),
    youtube_link VARCHAR(255),
    x_link VARCHAR(255),
    centralized_email VARCHAR(150),
    resort_gst_number VARCHAR(30),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


************************************************************ updated till below *****************
CREATE TABLE `ashokadb`.`my_claims` (
  `claimId` BIGINT NOT NULL,
  `claimdetails` VARCHAR(500) NULL,
  `claimamount` INT NULL,
  `approvedamount` INT NULL,
  `claimdate` DATE NULL,
  `claimdecisiondate` DATE NULL,
  `claimstatus` INT NULL,
  `expensestartdate` DATE NULL,
  `expenseenddate` DATE NULL,
  `managementremarks` VARCHAR(500) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `claimentId` INT NULL,
  `decisionmakerid` INT NULL,
  PRIMARY KEY (`claimId`));

ALTER TABLE `ashokadb`.`my_claims`
ADD CONSTRAINT `fk_myclaims_claiment`
FOREIGN KEY (`claimentId`) REFERENCES `ashokateam`(`userid`)
ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_myclaims_decisionmaker`
FOREIGN KEY (`decisionmakerId`) REFERENCES `ashokateam`(`userid`)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `ashokadb`.`my_claims`
ADD COLUMN `claimtype` INT NULL AFTER `claimamount`;

CREATE TABLE `ashokadb`.`my_travel_claims` (
  `travelClaimId` BIGINT NOT NULL,
  `source` VARCHAR(250) NULL,
  `destination` VARCHAR(250) NULL,
  `expenseStartDate` DATE NULL,
  `expenseEndDate` DATE NULL,
  `claimDetails` VARCHAR(500) NULL,
  `travelMode` INT NULL,
  `kms` INT NULL,
  `travelExpense` INT NULL,
  `foodExpense` INT NULL,
  `parkingExpense` INT NULL,
  `otherExpense1` INT NULL,
  `otherExpense2` INT NULL,
  `otherExpense3` INT NULL,
  `claimentId` INT NULL,
  `approverId` INT NULL,
  `approverRemarks` VARCHAR(500) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`travelClaimId`),
  INDEX `FK_ClaimentId_idx` (`claimentId` ASC) VISIBLE,
  INDEX `FK_ApproverID_idx` (`approverId` ASC) VISIBLE,
  CONSTRAINT `FK_ClaimentId`
    FOREIGN KEY (`claimentId`)
    REFERENCES `ashokadb`.`ashokateam` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ApproverID`
    FOREIGN KEY (`approverId`)
    REFERENCES `ashokadb`.`ashokateam` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);






/********************* Updated below already *****************************/

INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('3', 'CLIENT_CREATE', 'CLIENT');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('4', 'CLIENT_MANAGE', 'CLIENT');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('5', 'USER_MANAGE', 'USER');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('6', 'LEADS_MANAGE', 'LEADS');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('7', 'COST_MANAGE', 'COST');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('8', 'SALES_PARTNER_CREATE', 'SALES');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('9', 'SALES_PARTNER_MANAGE', 'SALES');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('10', 'RATE_TYPE_MANAGE', 'SALES');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('11', 'ROOMS_MANAGE', 'SALES');
INSERT INTO `ashokadb`.`role` (`roleId`, `roleName`, `roleTarget`) VALUES ('12', 'EVENT_MANAGE', 'EVENT');


CREATE TABLE lead_system_quotation (
    lsqid BIGINT AUTO_INCREMENT PRIMARY KEY,
    leadId BIGINT NOT NULL,
    versionId INT,
    contactMethod INT,
    clientId INT,
    guestName VARCHAR(255),
    mobile VARCHAR(45),
    email VARCHAR(1000),
    grandTotal INT,
    discount INT,
    remarks VARCHAR(1000),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_lead FOREIGN KEY (leadId) REFERENCES lead_master(leadId),
    CONSTRAINT fk_client_sq FOREIGN KEY (clientId) REFERENCES client(clientId)
);


CREATE TABLE lead_system_quotation_room_details (
    lsqrd BIGINT AUTO_INCREMENT PRIMARY KEY,
    lsqid BIGINT NOT NULL,
    roomCategoryId INT NOT NULL,
    mealPlanId INT,
    adults INT DEFAULT 0,
    CWB INT DEFAULT 0,         -- Child With Bed
    CNB INT DEFAULT 0,         -- Child No Bed
    extraBed INT DEFAULT 0,
    checkInDate DATE NOT NULL,
    checkOutDate DATE NOT NULL,
    adultsTotalPrice INT DEFAULT 0,
    cwbTotalPrice INT DEFAULT 0,
    cnbTotalPrice INT DEFAULT 0,
    extraBedTotalPrice INT DEFAULT 0,
    totalPrice INT DEFAULT 0,

    CONSTRAINT fk_lsqid FOREIGN KEY (lsqid) REFERENCES lead_system_quotation(lsqid)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_room_category FOREIGN KEY (roomCategoryId) REFERENCES master_room_details(roomCategoryId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


ALTER TABLE `ashokadb`.`lead_system_quotation`
DROP COLUMN `email`,
DROP COLUMN `mobile`,
DROP COLUMN `guestName`,
DROP COLUMN `contactMethod`;


INSERT INTO `ashokadb`.`workload_status` (`id`, `workloadStatusId`, `workloadStatusObj`, `workloadStatusObjType`, `workloadStatusName`, `workloadCategory`, `active`) VALUES ('4', '104', 'LEAD_STATUS', 'LEAD_STATUS', 'Won-Converted', '2000', '1');
INSERT INTO `ashokadb`.`workload_status` (`id`, `workloadStatusId`, `workloadStatusObj`, `workloadStatusObjType`, `workloadStatusName`, `workloadCategory`, `active`) VALUES ('5', '105', 'LEAD_STATUS', 'LEAD_STATUS', 'Duplicate', '2000', '1');
UPDATE `ashokadb`.`workload_status` SET `workloadStatusName` = 'Failed-Closed' WHERE (`id` = '3');

CREATE TABLE `lead_fh_quotation` (
  `lfhqid` bigint NOT NULL AUTO_INCREMENT,
  `leadId` bigint NOT NULL,
  `versionId` int DEFAULT NULL,
  `clientId` int DEFAULT NULL,
  `grandTotal` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lfhqid`),
  KEY `fk_lead` (`leadId`),
  KEY `fk_client_sq` (`clientId`),
  CONSTRAINT `fk_client_fhq` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  CONSTRAINT `fk_lead_fh` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `lead_fh_quotation_room_details` (
  `lfqrd` bigint NOT NULL AUTO_INCREMENT,
  `lfhqid` bigint NOT NULL,
  `roomCategoryName` varchar(250) NOT NULL,
  `mealPlanId` int DEFAULT NULL,
  `adults` int DEFAULT '0',
  `CWB` int DEFAULT '0',
  `CNB` int DEFAULT '0',
  `extraBed` int DEFAULT '0',
  `checkInDate` date NOT NULL,
  `checkOutDate` date NOT NULL,
  `adultsTotalPrice` int DEFAULT '0',
  `cwbTotalPrice` int DEFAULT '0',
  `cnbTotalPrice` int DEFAULT '0',
  `extraBedTotalPrice` int DEFAULT '0',
  `totalPrice` int DEFAULT '0',
  PRIMARY KEY (`lfqrd`),
  KEY `fk_lfqid` (`lfhqid`),
  CONSTRAINT `fk_lfhqid` FOREIGN KEY (`lfhqid`) REFERENCES `lead_fh_quotation` (`lfhqid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `ashokadb`.`lead_fh_quotation_room_details`
DROP COLUMN `extraBedTotalPrice`,
DROP COLUMN `cnbTotalPrice`,
DROP COLUMN `cwbTotalPrice`,
DROP COLUMN `adultsTotalPrice`,
DROP COLUMN `extraBed`,
DROP COLUMN `CNB`,
CHANGE COLUMN `CWB` `noOfChild` INT NULL DEFAULT '0' ;


ALTER TABLE `ashokadb`.`lead_fh_quotation_room_details`
ADD COLUMN `noOfRooms` INT NULL DEFAULT 0 AFTER `roomCategoryName`;



#change the lead id and user id as appropriate.
INSERT INTO `ashokadb`.`leads_team_map` (`leadId`, `userId`) VALUES ('34', '0');

CREATE TABLE `ashokadb`.`eventtype` (
  `eventTypeId` INT NOT NULL,
  `eventTypeName` VARCHAR(500) NOT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`eventTypeId`));

CREATE TABLE event_master_service (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(300),
    type ENUM('PER_ROOM', 'PER_GUEST', 'ONE_TIME', 'PER_DAY') NOT NULL,
    baseCost DECIMAL(10,2) NOT NULL,
    eventTypeId INT NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_event_type
        FOREIGN KEY (eventTypeId) REFERENCES eventtype(eventTypeId)
);

CREATE TABLE event_package (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    package_name VARCHAR(255) NOT NULL,
    description varchar(500),
    base_guest_count INT,
    package_type int not null,
    created_by int,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_ep_created_by
        FOREIGN KEY (created_by) REFERENCES ashokateam(userId),
	CONSTRAINT fk_ep_event_type
	FOREIGN KEY (package_type) REFERENCES eventtype(eventTypeId)
);

CREATE TABLE event_package_service (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    package_id BIGINT,
    service_name VARCHAR(255),
    service_type ENUM('PER_ROOM', 'PER_GUEST', 'ONE_TIME', 'PER_DAY'),
    cost_per_unit DECIMAL(10,2),
    quantity INT DEFAULT 1,
    total_cost DECIMAL(10,2),
    is_custom BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (package_id) REFERENCES event_package(id)
);

ALTER TABLE `ashokadb`.`event_master_service`
CHANGE COLUMN `baseCost` `baseCost` INT NOT NULL ;

ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `cost_per_unit` `cost_per_unit` INT NULL DEFAULT NULL ,
CHANGE COLUMN `total_cost` `total_cost` INT NULL DEFAULT NULL ;

ALTER TABLE `ashokadb`.`eventtype`
ADD COLUMN `description` VARCHAR(250) NULL AFTER `eventTypeName`;

INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('1', 'Wedding', 'Wedding Event', '1');
INSERT INTO `ashokadb`.`eventtype` (`eventTypeId`, `eventTypeName`, `description`, `active`) VALUES ('2', 'Corporate Event', 'Corporate Event management', '1');

ALTER TABLE `ashokadb`.`event_master_service`
CHANGE COLUMN `type` `type` ENUM('PER_ROOM', 'PER_GUEST', 'ONE_TIME', 'PER_DAY', 'PER_GUEST_PER_NIGHT') NOT NULL ;

CREATE TABLE `ashokadb`.`event_service_cost_type` (
  `eventServiceCostTypeId` INT NOT NULL AUTO_INCREMENT,
  `eventServiceCostTypeName` VARCHAR(100) NOT NULL,
  `active` TINYINT NULL,
  PRIMARY KEY (`eventServiceCostTypeId`));

INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('1', 'PER_ROOM', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('2', 'PER_GUEST', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('3', 'ONE_TIME', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('4', 'PER_DAY', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('5', 'PER_GUEST_PER_NIGHT', '1');

ALTER TABLE `ashokadb`.`event_master_service`
CHANGE COLUMN `type` `eventServiceCostTypeId` INT NOT NULL ;

drop table event_master_service;

CREATE TABLE `event_master_service` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(300) DEFAULT NULL,
  `eventServiceCostTypeId` INT NOT NULL,
  `baseCost` INT NOT NULL,
  `eventTypeId` INT NOT NULL,
  `active` TINYINT(1) DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_event_type` (`eventTypeId`),
  CONSTRAINT `fk_event_type` FOREIGN KEY (`eventTypeId`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


ALTER TABLE `event_package_service`
ADD COLUMN `grand_total_cost` INT DEFAULT 0,
ADD COLUMN `discount` INT DEFAULT 0,
ADD COLUMN `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `ashokadb`.`event_package_service`
DROP COLUMN `discount`,
DROP COLUMN `grand_total_cost`;

ALTER TABLE `ashokadb`.`event_package`
ADD COLUMN `grand_total_cost` INT NULL DEFAULT 0 AFTER `package_type`,
ADD COLUMN `discount` INT NULL DEFAULT 0 AFTER `grand_total_cost`,
CHANGE COLUMN `base_guest_count` `base_guest_count` INT NULL DEFAULT 0 ;


ALTER TABLE `ashokadb`.`event_package`
ADD COLUMN `eventStartDate` DATE NULL AFTER `discount`,
ADD COLUMN `eventEndDate` DATE NULL AFTER `eventStartDate`;

delete from event_service_cost_type;

INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`) VALUES ('1', 'PER_GUEST_PER_NIGHT');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`) VALUES ('2', 'PER_GUEST_ONE_TIME');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('3', 'PER_GUEST_PER_DAY', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('4', 'PER_ROOM_ONE_TIME', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('5', 'PER_ROOM_PER_NIGHT', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('6', 'PER_DAY', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('7', 'PER_NIGHT', '1');
INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('8', 'ONE_TIME', '1');

ALTER TABLE `ashokadb`.`event_package`
ADD COLUMN `numberOfRooms` INT NULL AFTER `package_type`;

UPDATE `ashokadb`.`event_service_cost_type` SET `active` = '1' WHERE (`eventServiceCostTypeId` = '1');
UPDATE `ashokadb`.`event_service_cost_type` SET `active` = '1' WHERE (`eventServiceCostTypeId` = '2');


ALTER TABLE `ashokadb`.`event_package`
ADD COLUMN `gstIncluded` TINYINT NULL AFTER `discount`,
ADD COLUMN `showBreakup` TINYINT NULL AFTER `gstIncluded`;

INSERT INTO `ashokadb`.`event_service_cost_type` (`eventServiceCostTypeId`, `eventServiceCostTypeName`, `active`) VALUES ('9', 'MANUAL', '1');

ALTER TABLE `ashokadb`.`event_package`
ADD COLUMN `guestId` INT NULL AFTER `eventEndDate`,
ADD COLUMN `guestName` VARCHAR(250) NULL AFTER `guestId`,
ADD COLUMN `quotationAudienceType` INT NULL AFTER `guestName`,
ADD COLUMN `contactMethod` VARCHAR(45) NULL AFTER `quotationAudienceType`,
ADD COLUMN `mobile` VARCHAR(45) NULL AFTER `contactMethod`,
ADD COLUMN `email` VARCHAR(1000) NULL AFTER `mobile`,
ADD COLUMN `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER `created_at`,
ADD INDEX `fk_client_id_idx` (`guestId` ASC) VISIBLE;
;
ALTER TABLE `ashokadb`.`event_package`
ADD CONSTRAINT `fk_client_id`
  FOREIGN KEY (`guestId`)
  REFERENCES `ashokadb`.`client` (`clientId`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `ashokadb`.`event_package`
DROP FOREIGN KEY `fk_ep_event_type`;

ALTER TABLE `ashokadb`.`event_package`
CHANGE COLUMN `base_guest_count` `baseGuestCount` INT NULL DEFAULT '0' ;

ALTER TABLE `ashokadb`.`event_package`
ADD CONSTRAINT `fk_ep_event_type`
  FOREIGN KEY (`package_type`)
  REFERENCES `ashokadb`.`eventtype` (`eventTypeId`);


  ALTER TABLE `ashokadb`.`event_package`
  DROP FOREIGN KEY `fk_ep_created_by`;

  ALTER TABLE `ashokadb`.`event_package`
  CHANGE COLUMN `created_by` `createdBy` INT NULL DEFAULT NULL ;

  ALTER TABLE `ashokadb`.`event_package`
  ADD CONSTRAINT `fk_ep_created_by`
    FOREIGN KEY (`createdBy`)
    REFERENCES `ashokadb`.`ashokateam` (`userId`);

ALTER TABLE `ashokadb`.`event_package`
CHANGE COLUMN `package_name` `packageName` VARCHAR(255) NOT NULL ;


ALTER TABLE `ashokadb`.`event_package`
DROP FOREIGN KEY `fk_client_id`;

ALTER TABLE `ashokadb`.`event_package`
DROP INDEX `fk_client_id_idx` ;
;

ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `cost_per_unit` `costPerUnit` INT NULL DEFAULT NULL ;


ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `is_custom` `isCustom` TINYINT(1) NULL DEFAULT '0' ;

ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `service_name` `serviceName` VARCHAR(255) NULL DEFAULT NULL ;

ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `total_cost` `totalCost` INT NULL DEFAULT NULL ;

ALTER TABLE `ashokadb`.`event_package_service`
CHANGE COLUMN `service_type` `service_type` INT NULL DEFAULT NULL ;


ALTER TABLE `ashokadb`.`event_package_service`
DROP COLUMN `isCustom`;


#############################
Following Done
#########################################################################################
#Created on 14th April
#Updated ubuntu on 14th April
CREATE TABLE `leads_followup` (
  `leadFollowupId` bigint NOT NULL AUTO_INCREMENT,
  `leadId` bigint DEFAULT NULL,
  `followuptime` datetime DEFAULT NULL,
  `response` varchar(2000) DEFAULT NULL,
  `nextfollowuptime` datetime DEFAULT NULL,
  `nextactionplan` varchar(2000) DEFAULT NULL,
  `updatedBy` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`leadFollowupId`),
  KEY `Lead_Followup_ID_idx` (`leadId`),
  KEY `Lead_Followup_USR_idx` (`updatedBy`),
  CONSTRAINT `Lead_Followup_ID` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`),
  CONSTRAINT `Lead_Followup_USR` FOREIGN KEY (`updatedBy`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=20869 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;