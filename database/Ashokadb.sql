-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: ashokadb
-- ------------------------------------------------------
-- Server version	8.0.21

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam`
--

LOCK TABLES `ashokateam` WRITE;
/*!40000 ALTER TABLE `ashokateam` DISABLE KEYS */;
INSERT INTO `ashokateam` VALUES (0,'dummy','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Dummy','Vikas',9999999999,'dummy',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,'2025-01-01','sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0),(1,'Sushil','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Sushil Chugh','Vikas Puriu',9999449267,'Partner',NULL,NULL,0,NULL,'sushil@udanchoo.com',NULL,NULL,'sushil@vistaluxhotel.com',0,NULL,NULL,NULL,NULL,'',1,0,0,0,0),(13,'Wasim','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Sushil Chugh','Vikas Puri',9999449267,'Partner',NULL,NULL,0,'1977-12-16','sushil@vistaluxhotel.com',NULL,NULL,'sushil.chugh@gmail.com',9999441267,NULL,NULL,NULL,NULL,'I am proud of you user. You rock. ',1,0,0,0,0),(14,'Sushil3','$2a$10$2mo3JX/Th08K6lpp1fkx1eimparjm.tC.Cv/eUqfGD.2fK0mTPjhO','Sushil 3 chugh','vuikas purn ',99999999,'founder',NULL,NULL,0,'1977-12-16','sushil3@gmail.com',NULL,NULL,'personal@gmail.com',9999999999,NULL,NULL,NULL,NULL,'hello. ',0,0,1,0,0),(15,'Sushil3','$2a$10$M2sHZQ.LMqShWQe.QfcQROdG8pxfrcKXp1deTOMQGSVA/tSWIBbwq','Sushil 3 chugh','vuikas purn ',99999999,'founder',NULL,NULL,0,'1977-12-16','sushil3@gmail.com',NULL,NULL,'personal@gmail.com',9999999999,NULL,NULL,NULL,NULL,'hello. ',0,0,0,0,0),(16,'Sushil4','$2a$10$B1aJH8A5KvMXDDgKRYvr7.qK6Fp6ONzhhAZEhNHWreJ53Khw7Iyz6','sushil 4 chugh','fundu',9999999999,'founder',NULL,NULL,0,'2020-12-12','sus@gmail.com',NULL,NULL,'persna@gmail.com',9999999999,NULL,NULL,NULL,NULL,'asdgag',0,0,0,0,0),(17,'guru','$2a$10$ULQWB5xKtS/Tbu3hPzb8AeQFFmU.7JJX26/5GXF2BVfMZ7UcfReua','guru chugh','tihar',9999999999,'furu guru',NULL,NULL,0,'2009-12-12','guru@gmail.com',NULL,NULL,'persu@gmail.com',9999999999,NULL,NULL,NULL,NULL,'check it out. ',0,0,0,0,0),(18,'ndps','$2a$10$UhY8sEWIigBQCqvyRnjt3.YKO9OngtETkNEce1GvrLUv9HxdgtlES','NPPS Chugh','chalo ji',9090909090,'perfectionist',NULL,NULL,0,'2009-10-10','ndps@gmail.com',NULL,NULL,'ndps@gil.com',8989898989,NULL,NULL,NULL,NULL,'adsga',0,0,0,0,0),(19,'udanchoo','$2a$10$r4J8rLihfdPQIEQR/C7Di.2SKFytXAJtd91LeTs7Pbx6WaEGpLaRu','UdanChoo Tourism LLP','vikas puri',9999446267,'founder',NULL,NULL,0,'1977-12-16','sales@udanchoo.com','2025-12-10 00:00:00',NULL,'sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,'perfect execution. ',1,0,0,0,0),(20,'s4solvents','$2a$10$VjDvxmncS24fQZW5K9bycOshG/bh.0FHmFwS7jYOoNNnCambP0jDu','S4 Solvents Group','',9898989898,'asdg',NULL,NULL,0,'2025-01-01','sanjy@sanju.com',NULL,NULL,'sushil@sushil.com',0,NULL,NULL,NULL,NULL,'',0,0,0,0,0),(21,'kashish','$2a$10$dv6HkaDKNDihxTd4GjETfeFLtEAwcN5fx8a815JuHLEZEpOjEX3d2','Kashish','',9090762424,'Reservations',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,NULL,'sub.coll@gmail.com',0,NULL,NULL,NULL,NULL,'',1,0,0,0,0);
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
INSERT INTO `ashokateam_role` VALUES (1,1,1),(269,14,1),(271,15,2),(272,16,1),(273,17,1),(274,18,1),(276,13,2),(277,20,2),(278,19,2),(282,21,2);
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
INSERT INTO `cities` VALUES (1,'Corbett2','IND','India',1),(2,'New York','USA','United States of America',1),(3,'Murabadab','IND','India',1),(4,'Corbett','IND','India',1),(8,'New Jersy','USA','United States of America',1),(9,'Chicago','USA','United States of America',1),(11,'Corbett3','IND','India',1),(12,'Unknown','IND','India',1);
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
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`clientId`),
  KEY `cityId` (`cityId`),
  KEY `salesPartnerId` (`salesPartnerId`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`cityId`) REFERENCES `cities` (`destinationId`),
  CONSTRAINT `client_ibfk_2` FOREIGN KEY (`salesPartnerId`) REFERENCES `salespartner` (`salesPartnerId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (2,'Sushil Chugh',1,0,9999449267,'sushil@udanchoo.com','direct ',2,'amazing growth. ',1),(3,'Vikash Kumar',3,1,9898989898,'sales@udanchoo.com','bali and singapore',5,'need to plan meeting. ',1),(4,'TBO,TBO',1,1,9898989898,'tbo@tbo.com','asdg',2,'adsg',1),(5,'Mohit',1,0,9898989898,'mohit@bi.com','direct',5,'lets see',1),(6,'Rohit Kumar',12,0,9999999999,'ROHIT@janjaesgroup.com','Direct',11,'direct',1);
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
INSERT INTO `hibernate_sequence` VALUES (22);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_master`
--

LOCK TABLES `lead_master` WRITE;
/*!40000 ALTER TABLE `lead_master` DISABLE KEYS */;
INSERT INTO `lead_master` VALUES (12,2,2,3,4,5,'Client Perfect','','2025-01-20','2025-01-26',101,NULL,0,0,1,0,1,0,1,1,'2025-01-25 06:59:20','2025-01-25 06:59:20'),(13,5,1,1,1,1,'client remarks now. ','','2025-01-28','2025-01-30',102,NULL,1,0,1,0,1,0,1,1,'2025-01-25 07:13:35','2025-01-28 20:04:04'),(14,2,2,3,5,7,'Client is superb. ','','2025-01-22','2025-01-28',101,NULL,0,0,1,1,1,1,1,1,'2025-01-25 07:20:07',NULL),(15,3,2,2,1,0,'Meal Plan : APAI ','internally good. ','2025-01-28','2025-01-29',102,NULL,0,0,1,0,0,0,1,1,'2025-01-25 07:28:16','2025-01-28 20:04:04'),(16,2,2,2,1,1,'Meal Plan APAI','','2025-01-27','2025-01-29',101,NULL,0,0,1,0,0,0,1,21,'2025-01-25 07:31:43','2025-01-25 07:31:43'),(17,6,2,2,1,1,'* Meal Plan : APAI\r\n* Safari Needs to be included for all pax','this is internal','2025-01-27','2025-01-29',103,NULL,0,0,1,0,0,0,1,21,'2025-01-25 07:34:08','2025-01-28 20:04:04'),(18,5,1,1,1,1,'client remarks now. ','','2025-01-28','2025-01-30',101,NULL,1,1,1,1,1,0,1,1,NULL,NULL),(19,3,2,4,6,6,'client remarks now. Thsi is great initiative that you are updating client remarks. client need APAI meal plan and flexible on dates as well. provided cheaper ticket is availabl.e','Client is money oriented and not ready to pay. we need to ensure that client living style is mantained and ask mroe payment, if client services then payment will be required. inform in advance .  ','2025-01-28','2025-01-31',101,NULL,1,0,0,0,1,0,1,1,NULL,NULL);
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
INSERT INTO `leads_team_map` VALUES (12,0),(14,13),(18,21),(19,21);
/*!40000 ALTER TABLE `leads_team_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_room_details`
--

DROP TABLE IF EXISTS `master_room_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_room_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `room_category` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL,
  `standard_occupancy` int NOT NULL,
  `max_occupancy` int NOT NULL,
  `extra_bed` int DEFAULT '0',
  `child` int DEFAULT '0',
  `comp_child` int DEFAULT '0',
  `categorylevel` int DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_room_details`
--

LOCK TABLES `master_room_details` WRITE;
/*!40000 ALTER TABLE `master_room_details` DISABLE KEYS */;
INSERT INTO `master_room_details` VALUES (1,'Deluxe Room Pool Front','this is the first level of room category. ','500 ',2,3,1,1,2,1,1);
/*!40000 ALTER TABLE `master_room_details` ENABLE KEYS */;
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
INSERT INTO `ratetype` VALUES (1,'OTA | B2C','These are the rates published for OTAs online. ',1,'2025-01-03 07:47:10','2025-01-03 13:53:43'),(2,'GTI Special Rate','GTI special Rates',1,'2025-01-03 07:51:15','2025-01-03 13:53:34'),(3,'B2B-Partners-Worked','These are the b2bpartners man. You are right chugh, it worked. ',1,'2025-01-03 07:52:58','2025-01-03 13:56:51'),(4,'Direct-Sales-Valuable','Welcome to the world of direct sales. ',1,'2025-01-03 13:58:00','2025-01-03 18:02:54');
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
  CONSTRAINT `fk_city` FOREIGN KEY (`cityId`) REFERENCES `cities` (`destinationId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salespartner`
--

LOCK TABLES `salespartner` WRITE;
/*!40000 ALTER TABLE `salespartner` DISABLE KEYS */;
INSERT INTO `salespartner` VALUES (2,'udanchoo','udanchoo tourism',9999449267,'sales@udanchoo.com',1,'vikas puri','direct','perfect company and great company',1,'2025-01-03 17:52:07','2025-01-10 03:22:40'),(3,'udanchoo back','udanchoo tourism',9898989898,'undo@undo.com',1,'hello','hljlsk','nklnkl',0,'2025-01-03 17:56:23','2025-01-11 03:56:41'),(4,'udanchoo3','udanchoo t3',9999449267,'sales@udanchoo.com',1,'vikas puri','final hai','perfectu hai',0,'2025-01-03 18:00:19','2025-01-09 16:31:03'),(5,'ashoka self','vistalux',0,NULL,4,'nainital','self made','hum hi hum hai. ',1,'2025-01-03 18:01:28','2025-01-06 12:54:01'),(6,'tourish','Tourish DMC',9999999999,'tourish@gmail.com',3,'Sec 18','Direct','perfect. ',1,'2025-01-06 14:04:28','2025-01-24 06:09:29'),(7,'udanchoo','udanchoo tourism',9999449267,'sushil@udanchoo.com',1,'vikas puri','direct','perfect company',0,'2025-01-06 14:11:08','2025-01-09 16:31:16'),(8,'udanchoo','udanchoo tourism',9999449267,'sushil@udanchoo.com',1,'vikas puri','direct','perfect company',0,'2025-01-06 14:12:21','2025-01-09 16:31:25'),(9,'udanchoo','udanchoo tourism',9999449267,'sushil@udanchoo.com',1,'vikas puri','direct','perfect company',0,'2025-01-06 14:12:58','2025-01-09 16:31:32'),(10,'udanchoo','udanchoo tourism',9999449267,'sushil@udanchoo',1,'vikas puri','direct','perfect company',0,'2025-01-06 14:28:19','2025-01-09 16:31:38'),(11,'B2C','All B2c Client',9999999999,'unknown@gmail.com',3,'','','',1,'2025-01-25 01:54:54',NULL);
/*!40000 ALTER TABLE `salespartner` ENABLE KEYS */;
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

-- Dump completed on 2025-02-04 21:19:14
