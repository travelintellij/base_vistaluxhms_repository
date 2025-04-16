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