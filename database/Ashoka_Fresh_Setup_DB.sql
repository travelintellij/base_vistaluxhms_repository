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
INSERT INTO `ashokateam` VALUES (0,'dummy','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Dummy','Vikas',9999999999,'dummy',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,'2025-01-01','sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0),(1,'Sushil','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Sushil Chugh','Vikas Puriu',9999449267,'Partner',NULL,NULL,0,NULL,'sushil@udanchoo.com',NULL,NULL,'sushil@vistaluxhotel.com',9999441267,NULL,NULL,NULL,NULL,'perfect',1,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=283 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam_role`
--

LOCK TABLES `ashokateam_role` WRITE;
/*!40000 ALTER TABLE `ashokateam_role` DISABLE KEYS */;
INSERT INTO `ashokateam_role` VALUES (1,1,1);
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
INSERT INTO `cities` VALUES (1,'Corbett2','IND','India',1),(2,'New York','USA','United States of America',1),(3,'Murabadab','IND','India',1),(4,'Corbett','IND','India',1),(8,'New Jersy','USA','United States of America',1),(9,'Chicago','USA','United States of America',1),(11,'Corbett3','IND','India',1),(12,'Unknown','IND','India',1),(22,'Noida','IND','India',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
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
INSERT INTO `hibernate_sequence` VALUES (23);
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_master`
--

LOCK TABLES `lead_master` WRITE;
/*!40000 ALTER TABLE `lead_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_master` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_room_details`
--

LOCK TABLES `master_room_details` WRITE;
/*!40000 ALTER TABLE `master_room_details` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratetype`
--

LOCK TABLES `ratetype` WRITE;
/*!40000 ALTER TABLE `ratetype` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salespartner`
--

LOCK TABLES `salespartner` WRITE;
/*!40000 ALTER TABLE `salespartner` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_rate_mapping`
--

LOCK TABLES `session_rate_mapping` WRITE;
/*!40000 ALTER TABLE `session_rate_mapping` DISABLE KEYS */;
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

-- Dump completed on 2025-04-05 14:09:50
