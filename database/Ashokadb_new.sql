-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: ashokadb
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ashokateam`
--

DROP TABLE IF EXISTS `ashokateam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ashokateam` (
  `userId` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `Name` varchar(145) DEFAULT NULL,
  `Address` varchar(245) DEFAULT NULL,
  `Mobile` bigint DEFAULT NULL,
  `Designation` varchar(45) DEFAULT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Shift` varchar(45) DEFAULT NULL,
  `FixedIncentive` bigint DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `LastWorkingDay` datetime DEFAULT NULL,
  `DOJ` date DEFAULT NULL,
  `personalEmail` varchar(100) DEFAULT NULL,
  `personalMobile` bigint DEFAULT NULL,
  `panCard` varchar(50) DEFAULT NULL,
  `aadharCard` varchar(50) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `maritalStatus` varchar(50) DEFAULT NULL,
  `remarks` varchar(1200) DEFAULT NULL,
  `Active` tinyint DEFAULT NULL,
  `accountExpired` tinyint DEFAULT '0',
  `accountLocked` tinyint DEFAULT '0',
  `credentialsExpired` tinyint DEFAULT '0',
  `deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam`
--

LOCK TABLES `ashokateam` WRITE;
/*!40000 ALTER TABLE `ashokateam` DISABLE KEYS */;
INSERT INTO `ashokateam` VALUES (0,'dummy','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Dummy','Vikas',9999999999,'dummy',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,'2025-01-01','sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0),(1,'Sushil','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Sushil Chugh','Vikas Puriu',9999449267,'Partner',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,NULL,'sushil@vistaluxhotel.com',9999441267,NULL,NULL,NULL,NULL,'perfect',1,0,0,0,0),(24,'Prashant Thakur','$2a$10$/eVPhoz0R9yBufCBc8z71ustQlcaKNg1WgnB4eFjgH9VyYBjk9/wa','Prashant Thakur','',9999441267,'General Manager',NULL,NULL,0,NULL,'sales@udanchoo.com',NULL,NULL,'sales@udanchoo.com',9999441267,NULL,NULL,NULL,NULL,'',1,0,0,0,0);
/*!40000 ALTER TABLE `ashokateam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ashokateam_role`
--

DROP TABLE IF EXISTS `ashokateam_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ashokateam_role` (
  `userRoleId` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `roleId` int DEFAULT NULL,
  PRIMARY KEY (`userRoleId`),
  KEY `FK_USR_ID_idx` (`userId`),
  KEY `FK_ROLE_ID_idx` (`roleId`),
  CONSTRAINT `FK_ROLE_ID` FOREIGN KEY (`roleId`) REFERENCES `role` (`roleId`),
  CONSTRAINT `FK_USR_ID_RL_MAP` FOREIGN KEY (`userId`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam_role`
--

LOCK TABLES `ashokateam_role` WRITE;
/*!40000 ALTER TABLE `ashokateam_role` DISABLE KEYS */;
INSERT INTO `ashokateam_role` VALUES (1,1,1),(283,24,2);
/*!40000 ALTER TABLE `ashokateam_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `destinationId` bigint NOT NULL AUTO_INCREMENT,
  `CityName` varchar(100) NOT NULL,
  `CountryCode` varchar(5) NOT NULL,
  `CountryName` varchar(245) NOT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`destinationId`)
) ENGINE=InnoDB AUTO_INCREMENT=50002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Corbett2','IND','India',1),(2,'New York','USA','United States of America',1),(3,'Murabadab','IND','India',1),(4,'Corbett','IND','India',1),(8,'New Jersy','USA','United States of America',1),(9,'Chicago','USA','United States of America',1),(11,'Corbett3','IND','India',1),(12,'Unknown','IND','India',1),(22,'Noida','IND','India',1),(23,'Delhi','IND','India',1);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `clientName` varchar(255) NOT NULL,
  `cityId` bigint DEFAULT NULL,
  `b2b` tinyint DEFAULT NULL,
  `mobile` bigint DEFAULT NULL,
  `emailId` varchar(250) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `salesPartnerId` bigint DEFAULT NULL,
  `remarks` text,
  `isSalesPartner` tinyint DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` varchar(45) DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  PRIMARY KEY (`clientId`),
  KEY `cityId` (`cityId`),
  KEY `salesPartnerId` (`salesPartnerId`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`cityId`) REFERENCES `cities` (`destinationId`),
  CONSTRAINT `client_ibfk_2` FOREIGN KEY (`salesPartnerId`) REFERENCES `salespartner` (`salesPartnerId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (12,'03_Lowest_B2b_Rates',23,1,9999449267,'sales@udanchoo.com','Direct',14,NULL,1,1,'2025-04-10 15:01:25','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(13,'01_B2C_Direct_Clients',23,1,9999441267,'sushil@vistaluxhotel.com','Direct',15,NULL,1,1,'2025-04-10 15:07:37','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(14,'02_Standard_B2b_Rates',23,1,9999449267,'sushil@vistaluxhotel.com','direct',16,NULL,1,1,'2025-04-10 15:08:41','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(15,'Sushil Chugh',23,0,9999449267,'sushil@udanchoo.com','Direct',15,'Direct',0,1,'2025-04-10 15:09:26','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(16,'Rohit Kumar',23,0,8001580015,'info@vistaluxhotel.cm','Direct',15,'Direct',0,1,'2025-04-10 15:27:20','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(17,'UdanChoo Tourism',23,1,9999449267,'sales@udanchoo.com','direct',17,NULL,1,1,'2025-04-10 15:30:51','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_master_service`
--

DROP TABLE IF EXISTS `event_master_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_master_service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(300) DEFAULT NULL,
  `type` enum('PER_ROOM','PER_GUEST','ONE_TIME','PER_DAY') NOT NULL,
  `baseCost` int NOT NULL,
  `eventTypeId` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_event_type` (`eventTypeId`),
  CONSTRAINT `fk_event_type` FOREIGN KEY (`eventTypeId`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_master_service`
--

LOCK TABLES `event_master_service` WRITE;
/*!40000 ALTER TABLE `event_master_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_master_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_package`
--

DROP TABLE IF EXISTS `event_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_package` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `package_name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `base_guest_count` int DEFAULT NULL,
  `package_type` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_ep_created_by` (`created_by`),
  KEY `fk_ep_event_type` (`package_type`),
  CONSTRAINT `fk_ep_created_by` FOREIGN KEY (`created_by`) REFERENCES `ashokateam` (`userId`),
  CONSTRAINT `fk_ep_event_type` FOREIGN KEY (`package_type`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_package`
--

LOCK TABLES `event_package` WRITE;
/*!40000 ALTER TABLE `event_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_package_service`
--

DROP TABLE IF EXISTS `event_package_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_package_service` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `package_id` bigint DEFAULT NULL,
  `service_name` varchar(255) DEFAULT NULL,
  `service_type` enum('PER_ROOM','PER_GUEST','ONE_TIME','PER_DAY') DEFAULT NULL,
  `cost_per_unit` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `total_cost` int DEFAULT NULL,
  `is_custom` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `event_package_service_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `event_package` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_package_service`
--

LOCK TABLES `event_package_service` WRITE;
/*!40000 ALTER TABLE `event_package_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_package_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventtype`
--

DROP TABLE IF EXISTS `eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventtype` (
  `eventTypeId` int NOT NULL,
  `eventTypeName` varchar(500) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`eventTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtype`
--

LOCK TABLES `eventtype` WRITE;
/*!40000 ALTER TABLE `eventtype` DISABLE KEYS */;
INSERT INTO `eventtype` VALUES (1,'Wedding','Wedding Event',1),(2,'Corporate Event','Corporate Event management',1);
/*!40000 ALTER TABLE `eventtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (30);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_master`
--

DROP TABLE IF EXISTS `lead_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_master` (
  `leadId` bigint NOT NULL AUTO_INCREMENT,
  `clientId` int NOT NULL,
  `adults` int NOT NULL,
  `CWB` int DEFAULT '0',
  `CNB` int DEFAULT '0',
  `compChild` int DEFAULT '0',
  `clientRemarks` varchar(500) DEFAULT NULL,
  `internalRemarks` varchar(500) DEFAULT NULL,
  `checkInDate` date DEFAULT NULL,
  `checkOutDate` date DEFAULT NULL,
  `leadStatus` int NOT NULL,
  `resultReason` int DEFAULT NULL,
  `qualified` tinyint(1) DEFAULT '0',
  `flagged` tinyint(1) DEFAULT '0',
  `FIT` tinyint(1) DEFAULT '0',
  `groupEvent` tinyint(1) DEFAULT '0',
  `Marriage` tinyint(1) DEFAULT '0',
  `Others` tinyint(1) DEFAULT '0',
  `leadCreationClientInformed` tinyint(1) DEFAULT '0',
  `leadOwner` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`leadId`),
  KEY `fk_client` (`clientId`),
  KEY `fk_lead_owner_user_idx` (`leadOwner`),
  CONSTRAINT `fk_client` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  CONSTRAINT `fk_lead_owner_user` FOREIGN KEY (`leadOwner`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_master`
--

LOCK TABLES `lead_master` WRITE;
/*!40000 ALTER TABLE `lead_master` DISABLE KEYS */;
INSERT INTO `lead_master` VALUES (34,15,2,3,4,0,'sdgasgadgs This isclient remarks. ','','2025-04-15','2025-04-17',101,NULL,0,0,1,0,0,0,1,1,NULL,NULL);
/*!40000 ALTER TABLE `lead_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads_followup`
--

DROP TABLE IF EXISTS `leads_followup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads_followup`
--

LOCK TABLES `leads_followup` WRITE;
/*!40000 ALTER TABLE `leads_followup` DISABLE KEYS */;
INSERT INTO `leads_followup` VALUES (28,34,'2025-04-14 19:00:00','asdg','2025-04-15 20:00:00','sdagadg',1,'2025-04-14 18:38:13','2025-04-14 18:38:13'),(29,34,'2025-04-15 21:00:00','called up but no response','2025-04-16 20:00:00','will call again. ',1,'2025-04-14 19:27:07','2025-04-14 19:27:07');
/*!40000 ALTER TABLE `leads_followup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leads_team_map`
--

DROP TABLE IF EXISTS `leads_team_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads_team_map` (
  `leadId` bigint NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`leadId`,`userId`),
  KEY `USR_LEAD_FK_idx` (`userId`),
  CONSTRAINT `LEAD_USR_FK` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads_team_map`
--

LOCK TABLES `leads_team_map` WRITE;
/*!40000 ALTER TABLE `leads_team_map` DISABLE KEYS */;
INSERT INTO `leads_team_map` VALUES (34,24);
/*!40000 ALTER TABLE `leads_team_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_room_details`
--

DROP TABLE IF EXISTS `master_room_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_room_details` (
  `roomCategoryId` int NOT NULL AUTO_INCREMENT,
  `roomCategoryName` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `standardOccupancy` int NOT NULL,
  `maxOccupancy` int NOT NULL,
  `extraBed` int DEFAULT '0',
  `child` int DEFAULT '0',
  `compChild` int DEFAULT '0',
  `categorylevel` int DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `extraBedPercentage` int DEFAULT '0',
  `cnbPercentage` int DEFAULT '0',
  PRIMARY KEY (`roomCategoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_room_details`
--

LOCK TABLES `master_room_details` WRITE;
/*!40000 ALTER TABLE `master_room_details` DISABLE KEYS */;
INSERT INTO `master_room_details` VALUES (4,'Deluxe Room','','',2,3,1,1,2,1,1,35,20),(5,'Super Deluxe Room','','',4,5,1,1,2,2,1,35,20),(6,'Victoria Cottages','','',4,5,1,1,2,3,1,35,20),(7,'Mud Cottage','','',2,3,1,1,1,3,1,35,20);
/*!40000 ALTER TABLE `master_room_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mealplan`
--

DROP TABLE IF EXISTS `mealplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mealplan` (
  `mealPlanId` int NOT NULL AUTO_INCREMENT,
  `planName` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mealPlanId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mealplan`
--

LOCK TABLES `mealplan` WRITE;
/*!40000 ALTER TABLE `mealplan` DISABLE KEYS */;
INSERT INTO `mealplan` VALUES (1,'EP',1,'2025-02-18 14:18:36','2025-02-18 14:18:36'),(2,'CP',1,'2025-02-18 14:18:36','2025-02-18 14:18:36'),(3,'MAP',1,'2025-02-18 14:18:36','2025-02-18 14:18:36'),(4,'AP',1,'2025-02-18 14:18:36','2025-02-18 14:18:36');
/*!40000 ALTER TABLE `mealplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratetype`
--

DROP TABLE IF EXISTS `ratetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratetype` (
  `rateTypeId` int NOT NULL AUTO_INCREMENT,
  `rateTypeName` varchar(50) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rateTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratetype`
--

LOCK TABLES `ratetype` WRITE;
/*!40000 ALTER TABLE `ratetype` DISABLE KEYS */;
INSERT INTO `ratetype` VALUES (5,'Lowest_B2B_Rates','All dates will be mapped with this rate type. ',1,'2025-04-10 14:53:24','2025-04-10 14:53:24'),(6,'Standard_B2b_Rates','Any Standard Agent B2b Rates',1,'2025-04-10 14:53:51','2025-04-10 14:53:51'),(7,'B2C_Rate_Type','Direct Customer Rate Type',1,'2025-04-10 14:54:11','2025-04-10 14:54:11');
/*!40000 ALTER TABLE `ratetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `roleId` int NOT NULL AUTO_INCREMENT,
  `roleName` varchar(50) NOT NULL,
  `roleTarget` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`roleId`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN','PRIV'),(2,'USER','PRIV');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salespartner`
--

DROP TABLE IF EXISTS `salespartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salespartner` (
  `salesPartnerId` bigint NOT NULL AUTO_INCREMENT,
  `salesPartnerShortName` varchar(50) NOT NULL,
  `salesPartnerName` varchar(100) NOT NULL,
  `rateTypeId` int DEFAULT NULL,
  `mobile` bigint DEFAULT NULL,
  `emailId` varchar(250) DEFAULT NULL,
  `cityId` bigint DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`salesPartnerId`),
  KEY `fk_city` (`cityId`),
  KEY `fk_ratetype_idx` (`rateTypeId`),
  CONSTRAINT `fk_city` FOREIGN KEY (`cityId`) REFERENCES `cities` (`destinationId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_ratetype` FOREIGN KEY (`rateTypeId`) REFERENCES `ratetype` (`rateTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salespartner`
--

LOCK TABLES `salespartner` WRITE;
/*!40000 ALTER TABLE `salespartner` DISABLE KEYS */;
INSERT INTO `salespartner` VALUES (14,'03_Lowest_B2b_Rates','03_Lowest_B2b_Rates',5,9999449267,'sales@udanchoo.com',23,'JG3 250B Vikas Puri','Direct','Sales Partner',1,'2025-04-10 15:01:25','2025-04-10 15:31:41'),(15,'01_B2C_Direct_Clients','01_B2C_Direct_Clients',7,9999441267,'sushil@vistaluxhotel.com',23,'JG3 250B First Floor \r\nVikas Puri','Direct','Direct',1,'2025-04-10 15:07:38','2025-04-10 15:31:23'),(16,'02_Standard_B2b_Rates','02_Standard_B2b_Rates',6,9999449267,'sushil@vistaluxhotel.com',23,'JG3 250B First Floor `\r\nVikas Puri','direct','Direct',1,'2025-04-10 15:08:42','2025-04-10 15:31:33'),(17,'UdanChoo','UdanChoo Tourism',5,9999449267,'sales@udanchoo.com',23,'JG3 250B First Floor `\r\nVikas Puri','direct','Direct',1,'2025-04-10 15:30:52',NULL);
/*!40000 ALTER TABLE `salespartner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `sessionId` int NOT NULL AUTO_INCREMENT,
  `sessionName` varchar(255) NOT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`sessionId`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (17,'B2C_Main_Season_1st_April_30th_June','Main Season Rates for B2C','2025-04-10 07:01:52','2025-04-10 13:41:11',1),(18,'Standard_B2b_Main_Season_1st_April_30th_June','This is the main season for corbett. ','2025-04-10 07:03:17','2025-04-10 07:03:17',1),(19,'Standard_B2b_Monsoon_Off_1st_July_14th_Oct','this includes off season and monsoon season. ','2025-04-10 07:04:08','2025-04-10 07:04:08',1),(20,'Standard_B2b_Peak_Diwali_15th_Oct_25th_Oct','this is the peak diwali season. ','2025-04-10 07:04:47','2025-04-10 12:55:20',1),(21,'Standard_B2b_Normal_26th_Oct_19th_Dec','This is the normal season. ','2025-04-10 07:06:00','2025-04-10 07:06:00',1),(22,'B2C_Monsoon_Off_1st_July_14th_Oct','B2c Off Season','2025-04-10 13:42:02','2025-04-10 13:42:02',1),(23,'B2C_Peak_Diwali_15th_Oct_25th_Oct','Peak Season B2C','2025-04-10 13:42:34','2025-04-10 13:42:34',1),(24,'B2C_Normal_26th_Oct_19th_Dec','Normal Season','2025-04-10 13:42:56','2025-04-10 13:42:56',1),(25,'Lowest_B2b_Main_Season_1st_April_30th_June','this is lowest','2025-04-10 14:14:06','2025-04-10 14:14:06',1),(26,'Lowest_B2b_Monsoon_Off_1st_July_14th_Oct','','2025-04-10 14:14:28','2025-04-10 14:14:28',1),(27,'Lowest_B2b_Peak_Diwali_15th_Oct_25th_Oct','','2025-04-10 14:14:49','2025-04-10 14:14:49',1),(28,'Lowest_B2b_Normal_26th_Oct_19th_Dec','','2025-04-10 14:15:10','2025-04-10 14:15:10',1);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_rate_mapping`
--

DROP TABLE IF EXISTS `session_rate_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session_rate_mapping` (
  `sessionRateTypeId` int NOT NULL AUTO_INCREMENT,
  `sessionId` int NOT NULL,
  `rateTypeId` int NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `active` tinyint DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sessionRateTypeId`),
  KEY `sessionId` (`sessionId`),
  KEY `rateTypeId` (`rateTypeId`),
  CONSTRAINT `session_rate_mapping_ibfk_1` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`) ON DELETE CASCADE,
  CONSTRAINT `session_rate_mapping_ibfk_2` FOREIGN KEY (`rateTypeId`) REFERENCES `ratetype` (`rateTypeId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_rate_mapping`
--

LOCK TABLES `session_rate_mapping` WRITE;
/*!40000 ALTER TABLE `session_rate_mapping` DISABLE KEYS */;
INSERT INTO `session_rate_mapping` VALUES (26,25,5,'2025-04-01','2025-06-30',1,'2025-04-10 14:54:50','2025-04-10 14:54:50'),(27,26,5,'2025-07-01','2025-10-14',1,'2025-04-10 14:55:42','2025-04-10 14:55:42'),(28,27,5,'2025-10-15','2025-10-25',1,'2025-04-10 14:56:10','2025-04-10 14:56:10'),(29,28,5,'2025-10-26','2025-12-19',1,'2025-04-10 14:56:27','2025-04-10 14:56:27'),(30,17,7,'2025-04-01','2025-06-30',1,'2025-04-10 14:56:52','2025-04-10 14:56:52'),(31,22,7,'2025-07-01','2025-10-14',1,'2025-04-10 14:57:09','2025-04-10 14:57:09'),(32,23,7,'2025-10-15','2025-10-25',1,'2025-04-10 14:57:34','2025-04-10 14:57:34'),(33,24,7,'2025-10-26','2025-12-19',1,'2025-04-10 14:58:02','2025-04-10 14:58:02'),(34,18,6,'2025-04-01','2025-06-30',1,'2025-04-10 14:58:22','2025-04-10 14:58:22'),(35,19,6,'2025-07-01','2025-10-14',1,'2025-04-10 14:58:38','2025-04-10 14:58:38'),(36,20,6,'2025-10-15','2025-10-25',1,'2025-04-10 14:58:59','2025-04-10 14:58:59'),(37,21,6,'2025-10-26','2025-12-19',1,'2025-04-10 14:59:24','2025-04-10 14:59:24');
/*!40000 ALTER TABLE `session_rate_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessiondetail`
--

DROP TABLE IF EXISTS `sessiondetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessiondetail` (
  `sessionId` int NOT NULL,
  `roomCategoryId` int NOT NULL,
  `mealPlanId` int NOT NULL,
  `person1` int DEFAULT NULL,
  `person2` int DEFAULT NULL,
  `person3` int DEFAULT NULL,
  `person4` int DEFAULT NULL,
  `person5` int DEFAULT NULL,
  `person6` int DEFAULT NULL,
  `maxOccupancy` int NOT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sessionId`,`roomCategoryId`,`mealPlanId`),
  KEY `fk_roomCategory` (`roomCategoryId`),
  KEY `fk_mealPlan` (`mealPlanId`),
  KEY `fk_sessionId_idx` (`sessionId`),
  CONSTRAINT `fk_mealPlan` FOREIGN KEY (`mealPlanId`) REFERENCES `mealplan` (`mealPlanId`),
  CONSTRAINT `fk_roomCategory` FOREIGN KEY (`roomCategoryId`) REFERENCES `master_room_details` (`roomCategoryId`),
  CONSTRAINT `fk_sessionId` FOREIGN KEY (`sessionId`) REFERENCES `session` (`sessionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessiondetail`
--

LOCK TABLES `sessiondetail` WRITE;
/*!40000 ALTER TABLE `sessiondetail` DISABLE KEYS */;
INSERT INTO `sessiondetail` VALUES (17,4,1,4800,4900,0,0,0,0,0,NULL,1,'2025-04-10 13:43:42','2025-04-10 13:43:42'),(17,4,2,5200,5400,0,0,0,0,0,NULL,1,'2025-04-10 13:43:57','2025-04-10 13:43:57'),(17,4,3,5500,5900,0,0,0,0,0,NULL,1,'2025-04-10 13:44:15','2025-04-10 13:44:15'),(17,4,4,5800,6400,0,0,0,0,0,NULL,1,'2025-04-10 13:44:29','2025-04-10 13:44:29'),(17,5,1,5220,5320,6118,6916,0,0,0,NULL,1,'2025-04-10 13:45:13','2025-04-10 13:45:13'),(17,5,2,5620,5820,6693,7566,0,0,0,NULL,1,'2025-04-10 13:45:53','2025-04-10 13:45:53'),(17,5,3,5920,6320,7268,8216,0,0,0,NULL,1,'2025-04-10 13:46:31','2025-04-10 13:46:31'),(17,5,4,6220,6820,7843,8866,0,0,0,NULL,1,'2025-04-10 13:47:10','2025-04-10 13:47:10'),(17,6,1,6620,6720,7728,8736,0,0,0,NULL,1,'2025-04-10 13:47:47','2025-04-10 13:47:47'),(17,6,2,7020,7220,8303,9386,0,0,0,NULL,1,'2025-04-10 13:48:28','2025-04-10 13:48:28'),(17,6,3,7320,7720,8878,10036,0,0,0,NULL,1,'2025-04-10 13:49:20','2025-04-10 13:49:20'),(17,6,4,7620,8220,9453,10686,0,0,0,NULL,1,'2025-04-10 13:50:04','2025-04-10 13:50:04'),(17,7,1,6620,6720,0,0,0,0,0,NULL,1,'2025-04-10 13:50:13','2025-04-10 13:50:13'),(17,7,2,7020,7220,0,0,0,0,0,NULL,1,'2025-04-10 13:50:25','2025-04-10 13:50:25'),(17,7,3,7320,7720,0,0,0,0,0,NULL,1,'2025-04-10 13:50:36','2025-04-10 13:50:36'),(17,7,4,7620,8220,0,0,0,0,0,NULL,1,'2025-04-10 13:50:46','2025-04-10 13:50:46'),(18,4,1,3400,3500,0,0,0,0,0,NULL,1,'2025-04-10 12:36:47','2025-04-10 12:36:47'),(18,4,2,3800,4000,0,0,0,0,0,NULL,1,'2025-04-10 12:37:13','2025-04-10 12:37:13'),(18,4,3,4100,4500,0,0,0,0,0,NULL,1,'2025-04-10 12:37:29','2025-04-10 12:37:29'),(18,4,4,4400,5000,0,0,0,0,0,NULL,1,'2025-04-10 12:37:49','2025-04-10 12:37:49'),(18,5,1,3700,3800,4370,4940,0,0,0,NULL,1,'2025-04-10 12:39:13','2025-04-10 12:39:13'),(18,5,2,4100,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 12:40:50','2025-04-10 12:40:50'),(18,5,3,4400,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 12:41:37','2025-04-10 12:41:37'),(18,5,4,4700,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 12:42:14','2025-04-10 12:42:14'),(18,6,1,4700,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 12:43:22','2025-04-10 12:43:22'),(18,6,2,5100,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 12:44:04','2025-04-10 12:44:04'),(18,6,3,5400,5800,6670,7540,0,0,0,NULL,1,'2025-04-10 12:44:47','2025-04-10 12:44:47'),(18,6,4,5700,6300,7245,8190,0,0,0,NULL,1,'2025-04-10 12:45:30','2025-04-10 12:45:30'),(18,7,1,4700,4800,0,0,0,0,0,NULL,1,'2025-04-10 12:45:44','2025-04-10 12:45:44'),(18,7,2,5100,5300,0,0,0,0,0,NULL,1,'2025-04-10 12:45:53','2025-04-10 12:45:53'),(18,7,3,5400,5800,0,0,0,0,0,NULL,1,'2025-04-10 12:46:04','2025-04-10 12:46:04'),(18,7,4,5700,6300,0,0,0,0,0,NULL,1,'2025-04-10 12:46:14','2025-04-10 12:46:14'),(19,4,1,3200,3300,0,0,0,0,0,NULL,1,'2025-04-10 12:56:32','2025-04-10 12:58:40'),(19,4,2,3600,3800,0,0,0,0,0,NULL,1,'2025-04-10 12:58:54','2025-04-10 12:58:54'),(19,4,3,3900,4300,0,0,0,0,0,NULL,1,'2025-04-10 12:59:06','2025-04-10 12:59:06'),(19,4,4,4200,4800,0,0,0,0,0,NULL,1,'2025-04-10 12:59:18','2025-04-10 12:59:18'),(19,5,1,3500,3600,4140,4680,0,0,0,NULL,1,'2025-04-10 13:07:50','2025-04-10 13:07:50'),(19,5,2,3900,4100,4715,5330,0,0,0,NULL,1,'2025-04-10 13:08:22','2025-04-10 13:08:22'),(19,5,3,4200,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 13:09:12','2025-04-10 13:09:12'),(19,5,4,4500,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 13:09:46','2025-04-10 13:09:46'),(19,6,1,4500,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 13:10:40','2025-04-10 13:10:40'),(19,6,2,4900,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 13:11:24','2025-04-10 13:11:24'),(19,6,3,5200,5600,6440,7280,0,0,0,NULL,1,'2025-04-10 13:12:07','2025-04-10 13:12:07'),(19,6,4,5500,6100,7015,7930,0,0,0,NULL,1,'2025-04-10 13:12:45','2025-04-10 13:12:45'),(19,7,1,4500,4600,0,0,0,0,0,NULL,1,'2025-04-10 13:12:59','2025-04-10 13:12:59'),(19,7,2,4900,5100,0,0,0,0,0,NULL,1,'2025-04-10 13:13:08','2025-04-10 13:13:08'),(19,7,3,5200,5600,0,0,0,0,0,NULL,1,'2025-04-10 13:13:17','2025-04-10 13:13:17'),(19,7,4,5500,6100,0,0,0,0,0,NULL,1,'2025-04-10 13:13:26','2025-04-10 13:13:26'),(20,4,1,3400,3500,0,0,0,0,0,NULL,1,'2025-04-10 13:14:59','2025-04-10 13:14:59'),(20,4,2,3800,4000,0,0,0,0,0,NULL,1,'2025-04-10 13:15:08','2025-04-10 13:15:08'),(20,4,3,4100,4500,0,0,0,0,0,NULL,1,'2025-04-10 13:15:17','2025-04-10 13:15:17'),(20,4,4,4400,5000,0,0,0,0,0,NULL,1,'2025-04-10 13:15:26','2025-04-10 13:15:26'),(20,5,1,3700,3800,4370,4940,0,0,0,NULL,1,'2025-04-10 13:15:51','2025-04-10 13:15:51'),(20,5,2,4100,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 13:16:21','2025-04-10 13:16:21'),(20,5,3,4400,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 13:16:44','2025-04-10 13:16:44'),(20,5,4,4700,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 13:17:10','2025-04-10 13:17:10'),(20,6,1,4700,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 13:17:36','2025-04-10 13:17:36'),(20,6,2,5100,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 13:18:02','2025-04-10 13:18:02'),(20,6,3,5400,5800,6670,7540,0,0,0,NULL,1,'2025-04-10 13:18:27','2025-04-10 13:18:27'),(20,6,4,5700,6300,7245,8190,0,0,0,NULL,1,'2025-04-10 13:18:50','2025-04-10 13:18:50'),(20,7,1,4700,4800,0,0,0,0,0,NULL,1,'2025-04-10 13:18:59','2025-04-10 13:18:59'),(20,7,2,5100,5300,0,0,0,0,0,NULL,1,'2025-04-10 13:19:10','2025-04-10 13:19:10'),(20,7,3,5400,5800,0,0,0,0,0,NULL,1,'2025-04-10 13:19:18','2025-04-10 13:19:18'),(20,7,4,5700,6300,0,0,0,0,0,NULL,1,'2025-04-10 13:19:28','2025-04-10 13:19:28'),(21,4,1,3200,3300,0,0,0,0,0,NULL,1,'2025-04-10 13:20:29','2025-04-10 13:20:29'),(21,4,2,3600,3800,0,0,0,0,0,NULL,1,'2025-04-10 13:20:37','2025-04-10 13:20:37'),(21,4,3,3900,4300,0,0,0,0,0,NULL,1,'2025-04-10 13:20:47','2025-04-10 13:20:47'),(21,4,4,4200,4800,0,0,0,0,0,NULL,1,'2025-04-10 13:20:57','2025-04-10 13:20:57'),(21,5,1,3500,3600,4140,4680,0,0,0,NULL,1,'2025-04-10 13:21:19','2025-04-10 13:21:19'),(21,5,2,3900,4100,4715,5330,0,0,0,NULL,1,'2025-04-10 13:21:41','2025-04-10 13:21:41'),(21,5,3,4200,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 13:32:19','2025-04-10 13:32:19'),(21,5,4,4500,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 13:32:57','2025-04-10 13:32:57'),(21,6,1,4500,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 13:33:28','2025-04-10 13:33:28'),(21,6,2,4900,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 13:33:55','2025-04-10 13:33:55'),(21,6,3,5200,5600,6440,7280,0,0,0,NULL,1,'2025-04-10 13:34:20','2025-04-10 13:34:20'),(21,6,4,5500,6100,7015,7930,0,0,0,NULL,1,'2025-04-10 13:34:47','2025-04-10 13:34:47'),(21,7,1,4500,4600,0,0,0,0,0,NULL,1,'2025-04-10 13:39:21','2025-04-10 13:39:21'),(21,7,2,4900,5100,0,0,0,0,0,NULL,1,'2025-04-10 13:39:30','2025-04-10 13:39:30'),(21,7,3,5200,5600,0,0,0,0,0,NULL,1,'2025-04-10 13:39:39','2025-04-10 13:39:39'),(21,7,4,5500,6100,0,0,0,0,0,NULL,1,'2025-04-10 13:39:49','2025-04-10 13:39:49'),(22,4,1,4065,4165,0,0,0,0,0,NULL,1,'2025-04-10 14:00:09','2025-04-10 14:00:09'),(22,4,2,4390,4590,0,0,0,0,0,NULL,1,'2025-04-10 14:00:25','2025-04-10 14:00:25'),(22,4,3,4615,5015,0,0,0,0,0,NULL,1,'2025-04-10 14:00:44','2025-04-10 14:00:44'),(22,4,4,4840,5440,0,0,0,0,0,NULL,1,'2025-04-10 14:01:01','2025-04-10 14:01:01'),(22,5,1,4422,4522,5200,5878,0,0,0,NULL,1,'2025-04-10 14:01:53','2025-04-10 14:01:53'),(22,5,2,4747,4947,5689,6431,0,0,0,NULL,1,'2025-04-10 14:02:29','2025-04-10 14:02:53'),(22,5,3,4972,5372,6177,6982,0,0,0,NULL,1,'2025-04-10 14:03:29','2025-04-10 14:03:29'),(22,5,4,5197,5797,6666,7535,0,0,0,NULL,1,'2025-04-10 14:04:04','2025-04-10 14:04:04'),(22,6,1,5612,5712,6568,7424,0,0,0,NULL,1,'2025-04-10 14:04:41','2025-04-10 14:04:41'),(22,6,2,5937,6137,7057,7977,0,0,0,NULL,1,'2025-04-10 14:05:32','2025-04-10 14:05:32'),(22,6,3,6162,6562,7546,8530,0,0,0,NULL,1,'2025-04-10 14:06:14','2025-04-10 14:06:14'),(22,6,4,6387,6987,8035,9083,0,0,0,NULL,1,'2025-04-10 14:06:55','2025-04-10 14:06:55'),(22,7,1,5612,5712,0,0,0,0,0,NULL,1,'2025-04-10 14:07:04','2025-04-10 14:07:04'),(22,7,2,5937,6137,0,0,0,0,0,NULL,1,'2025-04-10 14:07:15','2025-04-10 14:07:15'),(22,7,3,6162,6562,0,0,0,0,0,NULL,1,'2025-04-10 14:07:23','2025-04-10 14:07:23'),(22,7,4,6387,6987,0,0,0,0,0,NULL,1,'2025-04-10 14:07:32','2025-04-10 14:07:32'),(23,4,1,4800,4900,0,0,0,0,0,NULL,1,'2025-04-10 13:51:19','2025-04-10 13:51:19'),(23,4,2,5200,5400,0,0,0,0,0,NULL,1,'2025-04-10 13:51:30','2025-04-10 13:51:30'),(23,4,3,5500,5900,0,0,0,0,0,NULL,1,'2025-04-10 13:51:43','2025-04-10 13:51:43'),(23,4,4,5800,6400,0,0,0,0,0,NULL,1,'2025-04-10 13:51:54','2025-04-10 13:51:54'),(23,5,1,5220,5320,6118,6916,0,0,0,NULL,1,'2025-04-10 13:52:29','2025-04-10 13:52:29'),(23,5,2,5620,5820,6693,7566,0,0,0,NULL,1,'2025-04-10 13:52:55','2025-04-10 13:52:55'),(23,5,3,5920,6320,7268,8216,0,0,0,NULL,1,'2025-04-10 13:53:24','2025-04-10 13:53:24'),(23,5,4,6220,6820,7843,8866,0,0,0,NULL,1,'2025-04-10 13:53:49','2025-04-10 13:53:49'),(23,6,1,6620,6720,7728,8736,0,0,0,NULL,1,'2025-04-10 13:54:20','2025-04-10 13:54:20'),(23,6,2,7020,7220,8303,9386,0,0,0,NULL,1,'2025-04-10 13:54:48','2025-04-10 13:54:48'),(23,6,3,7320,7720,8878,10036,0,0,0,NULL,1,'2025-04-10 13:55:19','2025-04-10 13:55:19'),(23,6,4,7620,8220,9453,10686,0,0,0,NULL,1,'2025-04-10 13:55:53','2025-04-10 13:55:53'),(23,7,1,6620,6720,0,0,0,0,0,NULL,1,'2025-04-10 13:56:02','2025-04-10 13:56:02'),(23,7,2,7020,7220,0,0,0,0,0,NULL,1,'2025-04-10 13:56:11','2025-04-10 13:56:11'),(23,7,3,7320,7720,0,0,0,0,0,NULL,1,'2025-04-10 13:56:21','2025-04-10 13:56:21'),(23,7,4,7620,8220,0,0,0,0,0,NULL,1,'2025-04-10 13:56:32','2025-04-10 13:56:32'),(24,4,1,4065,4165,0,0,0,0,0,NULL,1,'2025-04-10 14:08:11','2025-04-10 14:08:11'),(24,4,2,4390,4590,0,0,0,0,0,NULL,1,'2025-04-10 14:08:22','2025-04-10 14:08:22'),(24,4,3,4615,5015,0,0,0,0,0,NULL,1,'2025-04-10 14:08:34','2025-04-10 14:08:34'),(24,4,4,4840,5440,0,0,0,0,0,NULL,1,'2025-04-10 14:08:46','2025-04-10 14:08:46'),(24,5,1,4422,4522,5200,5878,0,0,0,NULL,1,'2025-04-10 14:09:11','2025-04-10 14:09:11'),(24,5,2,4747,4947,5689,6431,0,0,0,NULL,1,'2025-04-10 14:09:35','2025-04-10 14:09:35'),(24,5,3,4972,5372,6177,6982,0,0,0,NULL,1,'2025-04-10 14:10:01','2025-04-10 14:10:01'),(24,5,4,5197,5797,6666,7535,0,0,0,NULL,1,'2025-04-10 14:10:27','2025-04-10 14:10:27'),(24,6,1,5612,5712,6568,7424,0,0,0,NULL,1,'2025-04-10 14:10:57','2025-04-10 14:10:57'),(24,6,2,5937,6137,7057,7977,0,0,0,NULL,1,'2025-04-10 14:11:23','2025-04-10 14:11:23'),(24,6,3,6162,6562,7546,8530,0,0,0,NULL,1,'2025-04-10 14:11:49','2025-04-10 14:11:49'),(24,6,4,6387,6987,8035,9083,0,0,0,NULL,1,'2025-04-10 14:12:15','2025-04-10 14:12:15'),(24,7,1,5612,5712,0,0,0,0,0,NULL,1,'2025-04-10 14:12:25','2025-04-10 14:12:25'),(24,7,2,5937,6137,0,0,0,0,0,NULL,1,'2025-04-10 14:12:34','2025-04-10 14:12:34'),(24,7,3,6162,6562,0,0,0,0,0,NULL,1,'2025-04-10 14:12:42','2025-04-10 14:12:42'),(24,7,4,6387,6987,0,0,0,0,0,NULL,1,'2025-04-10 14:12:51','2025-04-10 14:12:51'),(25,4,1,3200,3300,0,0,0,0,0,NULL,1,'2025-04-10 14:16:07','2025-04-10 14:16:07'),(25,4,2,3600,3800,0,0,0,0,0,NULL,1,'2025-04-10 14:16:19','2025-04-10 14:16:19'),(25,4,3,3900,4300,0,0,0,0,0,NULL,1,'2025-04-10 14:16:33','2025-04-10 14:16:33'),(25,4,4,4200,4800,0,0,0,0,0,NULL,1,'2025-04-10 14:16:50','2025-04-10 14:16:50'),(25,5,1,3500,3600,4140,4680,0,0,0,NULL,1,'2025-04-10 14:29:35','2025-04-10 14:29:35'),(25,5,2,3900,4100,4715,5330,0,0,0,NULL,1,'2025-04-10 14:30:13','2025-04-10 14:30:13'),(25,5,3,4200,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 14:30:46','2025-04-10 14:30:46'),(25,5,4,4500,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 14:31:20','2025-04-10 14:31:20'),(25,6,1,4500,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 14:32:01','2025-04-10 14:32:01'),(25,6,2,4900,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 14:32:34','2025-04-10 14:32:34'),(25,6,3,5200,5600,6440,7280,0,0,0,NULL,1,'2025-04-10 14:33:15','2025-04-10 14:33:15'),(25,6,4,5500,6100,7015,7930,0,0,0,NULL,1,'2025-04-10 14:34:03','2025-04-10 14:34:03'),(25,7,1,4500,4600,0,0,0,0,0,NULL,1,'2025-04-10 14:34:17','2025-04-10 14:34:17'),(25,7,2,4900,5100,0,0,0,0,0,NULL,1,'2025-04-10 14:34:28','2025-04-10 14:34:28'),(25,7,3,5200,5600,0,0,0,0,0,NULL,1,'2025-04-10 14:34:38','2025-04-10 14:34:38'),(25,7,4,5500,6100,0,0,0,0,0,NULL,1,'2025-04-10 14:34:47','2025-04-10 14:34:47'),(26,4,1,2900,3000,0,0,0,0,0,NULL,1,'2025-04-10 14:40:30','2025-04-10 14:40:30'),(26,4,2,3200,3500,0,0,0,0,0,NULL,1,'2025-04-10 14:40:45','2025-04-10 14:40:45'),(26,4,3,3600,4000,0,0,0,0,0,NULL,1,'2025-04-10 14:41:07','2025-04-10 14:41:07'),(26,4,4,3900,4500,0,0,0,0,0,NULL,1,'2025-04-10 14:41:21','2025-04-10 14:41:21'),(26,5,1,3200,3300,3795,4290,0,0,0,NULL,1,'2025-04-10 14:42:07','2025-04-10 14:42:07'),(26,5,2,3600,3800,4370,4940,0,0,0,NULL,1,'2025-04-10 14:42:37','2025-04-10 14:42:37'),(26,5,3,3900,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 14:43:05','2025-04-10 14:43:05'),(26,5,4,4200,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 14:43:37','2025-04-10 14:43:37'),(26,6,1,4200,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 14:44:08','2025-04-10 14:44:08'),(26,6,2,4600,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 14:44:38','2025-04-10 14:44:38'),(26,6,3,4900,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 14:45:16','2025-04-10 14:45:16'),(26,6,4,5200,5800,6670,7540,0,0,0,NULL,1,'2025-04-10 14:45:51','2025-04-10 14:45:51'),(26,7,1,4200,4300,0,0,0,0,0,NULL,1,'2025-04-10 14:46:02','2025-04-10 14:46:02'),(26,7,2,4600,4800,0,0,0,0,0,NULL,1,'2025-04-10 14:46:12','2025-04-10 14:46:12'),(26,7,3,4900,5300,0,0,0,0,0,NULL,1,'2025-04-10 14:46:20','2025-04-10 14:46:20'),(26,7,4,5200,5800,0,0,0,0,0,NULL,1,'2025-04-10 14:46:30','2025-04-10 14:46:30'),(27,4,1,3200,3300,0,0,0,0,0,NULL,1,'2025-04-10 14:35:13','2025-04-10 14:35:13'),(27,4,2,3600,3800,0,0,0,0,0,NULL,1,'2025-04-10 14:35:23','2025-04-10 14:35:23'),(27,4,3,3900,4300,0,0,0,0,0,NULL,1,'2025-04-10 14:35:36','2025-04-10 14:35:36'),(27,4,4,4200,4800,0,0,0,0,0,NULL,1,'2025-04-10 14:35:46','2025-04-10 14:35:46'),(27,5,1,3500,3600,4140,4680,0,0,0,NULL,1,'2025-04-10 14:36:08','2025-04-10 14:36:08'),(27,5,2,3900,4100,4715,5330,0,0,0,NULL,1,'2025-04-10 14:36:31','2025-04-10 14:36:31'),(27,5,3,4200,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 14:36:57','2025-04-10 14:36:57'),(27,5,4,4500,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 14:37:24','2025-04-10 14:37:24'),(27,6,1,4500,4600,5290,5980,0,0,0,NULL,1,'2025-04-10 14:37:54','2025-04-10 14:37:54'),(27,6,2,4900,5100,5865,6630,0,0,0,NULL,1,'2025-04-10 14:38:18','2025-04-10 14:38:18'),(27,6,3,5200,5600,6440,7280,0,0,0,NULL,1,'2025-04-10 14:38:47','2025-04-10 14:38:47'),(27,6,4,5500,6100,7015,7930,0,0,0,NULL,1,'2025-04-10 14:39:14','2025-04-10 14:39:14'),(27,7,1,4500,4600,0,0,0,0,0,NULL,1,'2025-04-10 14:39:26','2025-04-10 14:39:26'),(27,7,2,4900,5100,0,0,0,0,0,NULL,1,'2025-04-10 14:39:35','2025-04-10 14:39:35'),(27,7,3,5200,5600,0,0,0,0,0,NULL,1,'2025-04-10 14:39:50','2025-04-10 14:39:50'),(27,7,4,5500,6100,0,0,0,0,0,NULL,1,'2025-04-10 14:39:59','2025-04-10 14:39:59'),(28,4,1,2900,3000,0,0,0,0,0,NULL,1,'2025-04-10 14:47:02','2025-04-10 14:47:02'),(28,4,2,3200,3500,0,0,0,0,0,NULL,1,'2025-04-10 14:47:11','2025-04-10 14:47:11'),(28,4,3,3600,4000,0,0,0,0,0,NULL,1,'2025-04-10 14:47:21','2025-04-10 14:47:21'),(28,4,4,3900,4500,0,0,0,0,0,NULL,1,'2025-04-10 14:47:30','2025-04-10 14:47:30'),(28,5,1,3200,3300,3795,4290,0,0,0,NULL,1,'2025-04-10 14:47:51','2025-04-10 14:47:51'),(28,5,2,3600,3800,4370,4940,0,0,0,NULL,1,'2025-04-10 14:48:13','2025-04-10 14:48:13'),(28,5,3,3900,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 14:48:38','2025-04-10 14:48:38'),(28,5,4,4200,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 14:49:02','2025-04-10 14:49:02'),(28,6,1,4200,4300,4945,5590,0,0,0,NULL,1,'2025-04-10 14:49:26','2025-04-10 14:49:26'),(28,6,2,4600,4800,5520,6240,0,0,0,NULL,1,'2025-04-10 14:49:49','2025-04-10 14:49:49'),(28,6,3,4900,5300,6095,6890,0,0,0,NULL,1,'2025-04-10 14:50:18','2025-04-10 14:50:18'),(28,6,4,5200,5800,6670,7540,0,0,0,NULL,1,'2025-04-10 14:50:45','2025-04-10 14:50:45'),(28,7,1,4200,4300,0,0,0,0,0,NULL,1,'2025-04-10 14:51:04','2025-04-10 14:51:04'),(28,7,2,4600,4800,0,0,0,0,0,NULL,1,'2025-04-10 14:51:17','2025-04-10 14:51:17'),(28,7,3,4900,5300,0,0,0,0,0,NULL,1,'2025-04-10 14:51:33','2025-04-10 14:51:33'),(28,7,4,5200,5800,0,0,0,0,0,NULL,1,'2025-04-10 14:51:45','2025-04-10 14:51:45');
/*!40000 ALTER TABLE `sessiondetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workload_status`
--

DROP TABLE IF EXISTS `workload_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workload_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `workloadStatusId` int NOT NULL,
  `workloadStatusObj` varchar(15) DEFAULT NULL,
  `workloadStatusObjType` varchar(45) DEFAULT NULL,
  `workloadStatusName` varchar(50) DEFAULT NULL,
  `workloadCategory` int DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workload_status`
--

LOCK TABLES `workload_status` WRITE;
/*!40000 ALTER TABLE `workload_status` DISABLE KEYS */;
INSERT INTO `workload_status` VALUES (1,101,'LEAD_STATUS','LEAD_STATUS','Open',1000,1),(2,102,'LEAD_STATUS','LEAD_STATUS','Work In Progress',1000,1),(3,103,'LEAD_STATUS','LEAD_STATUS','Closed',2000,1);
/*!40000 ALTER TABLE `workload_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-16 21:02:09
