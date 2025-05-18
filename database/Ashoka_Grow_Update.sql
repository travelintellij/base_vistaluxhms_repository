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




/********************* Updated below already *****************************/
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