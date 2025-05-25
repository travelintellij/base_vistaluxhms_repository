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
INSERT INTO `ashokateam` VALUES (0,'dummy','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Dummy','Vikas',9999999999,'dummy',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com',NULL,'2025-01-01','sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,NULL,0,0,0,0,0),(1,'Sushil','$2a$10$CJp7hk40hr/Hq01JUQfN7.H5yBG6Ah.ayH.0G2y/nd8u.IPdgrP26','Sushil Chugh','Vikas Puri',9999449267,'Partner',NULL,NULL,0,'1977-12-16','sushil@vistaluxhotel.com',NULL,'2024-11-01','sushil@vistaluxhotel.com',9999441267,NULL,NULL,NULL,NULL,'perfect',1,0,0,0,0),(24,'Prashant Thakur','$2a$10$/eVPhoz0R9yBufCBc8z71ustQlcaKNg1WgnB4eFjgH9VyYBjk9/wa','Prashant Thakur','',9999441267,'General Manager',NULL,NULL,0,NULL,'sales@udanchoo.com',NULL,NULL,'sales@udanchoo.com',9999441267,NULL,NULL,NULL,NULL,'',1,0,0,0,0),(30,'dummy','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Dummy','Vikas',9999999999,'dummy',NULL,NULL,0,NULL,'sushil@vistaluxhotel.com','2025-05-24 00:00:00',NULL,'sushil.chugh@gmail.com',9999999999,NULL,NULL,NULL,NULL,'',0,0,0,0,0),(31,'ritik','$2a$10$cphLJyQp1li.N/p0ejNi/.vvIwsDE8UQEhcvelff.wlgNePCDMO/K','Ritik Makkar','Uttam Nagar',9999449267,'Business Development Manager',NULL,NULL,0,'2005-02-01','ritik@digitalintellij.com','2025-10-14 00:00:00','2025-03-01','ritik.01@gmail.com',9999446267,NULL,NULL,NULL,NULL,'asdg',1,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam_role`
--

LOCK TABLES `ashokateam_role` WRITE;
/*!40000 ALTER TABLE `ashokateam_role` DISABLE KEYS */;
INSERT INTO `ashokateam_role` VALUES (1,1,1),(283,24,2),(284,30,2),(286,31,2),(290,24,7),(292,31,5),(293,24,6),(294,31,3),(296,31,4),(300,31,8),(301,31,7),(302,31,12),(303,31,6);
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (12,'03_Lowest_B2b_Rates',23,1,9999449267,'sales@udanchoo.com','Direct',14,NULL,1,1,'2025-04-10 15:01:25','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(13,'01_B2C_Direct_Clients',23,1,9999441267,'sushil@vistaluxhotel.com','Direct',15,NULL,1,1,'2025-04-10 15:07:37','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(14,'02_Standard_B2b_Rates',23,1,9999449267,'sushil@vistaluxhotel.com','direct',16,NULL,1,1,'2025-04-10 15:08:41','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(15,'Sushil Chugh',23,0,9999449267,'sushil@udanchoo.com','Direct',15,'Direct',0,1,'2025-04-10 15:09:26','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(16,'Rohit Kumar',23,0,8001580015,'info@vistaluxhotel.cm','Direct',15,'Direct',0,1,'2025-04-10 15:27:20','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(17,'UdanChoo Tourism',23,1,9999449267,'sales@udanchoo.com','direct',17,NULL,1,1,'2025-04-10 15:30:51','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(18,'Vritiaa Rana',23,0,9999449267,'sushil@vistaluxhotel.com','Digital Marketing',15,'New Client. ',0,1,'2025-05-10 08:47:08','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(19,'Rahul Sarin',23,1,9999441267,'sales@udanchoo.com','',16,'',0,1,'2025-05-10 08:47:45','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(20,'Sanjay Singh',23,0,9999449267,'sushil@udanchoo.com','asdg',15,'asdg',0,1,'2025-05-14 07:52:29','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(21,'Vijay thadani',23,1,9999449267,'vijay@udanchoo.com','asdg',15,'ag',0,1,'2025-05-14 07:55:38','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(22,'Jeetpal',23,0,9999449267,'jeetpal@udanchoo.com','asdg',15,'agag',0,1,'2025-05-14 07:56:25','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(23,'Honeygold travels',23,1,9999449267,'honey@udanchoo.com','direct',18,NULL,1,1,'2025-05-14 10:48:11','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(24,'dummy one',23,1,9999449267,'dummy@udanchoo.com','',19,NULL,1,1,'2025-05-15 14:11:55','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(25,'Pankaj Khanna',23,0,9310010096,'sushil@udanchoo.com','',15,'',0,1,'2025-05-22 08:41:36','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),(26,'Ankur Jain',23,0,9910388250,'ankurja@gmail.com','',15,'',0,1,'2025-05-22 09:13:49','CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP');
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
  `eventServiceCostTypeId` int NOT NULL,
  `baseCost` int NOT NULL,
  `eventTypeId` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_event_type` (`eventTypeId`),
  CONSTRAINT `fk_event_type` FOREIGN KEY (`eventTypeId`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_master_service`
--

LOCK TABLES `event_master_service` WRITE;
/*!40000 ALTER TABLE `event_master_service` DISABLE KEYS */;
INSERT INTO `event_master_service` VALUES (8,'Accomodation in well appointed rooms during the ceremony','Acccodation with food will be provided. ',1,2200,1,1,'2025-04-19 12:22:23','2025-04-23 13:04:11'),(9,'Decoration','Will do flower decoration. ',7,20000,1,1,'2025-04-22 15:22:55','2025-04-23 13:02:56'),(10,'Hi Tea','',3,400,1,1,'2025-04-23 13:04:38','2025-04-23 13:04:38'),(11,'DJ Service','',8,5000,1,1,'2025-04-23 13:04:55','2025-04-23 13:04:55'),(12,'Room Cleaning','',5,300,1,1,'2025-04-23 13:05:50','2025-04-23 13:05:50'),(13,'Projector and Stationary','',8,200,2,1,'2025-04-26 11:22:32','2025-04-26 11:22:32');
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
  `packageName` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `baseGuestCount` int DEFAULT '0',
  `package_type` int NOT NULL,
  `numberOfRooms` int DEFAULT NULL,
  `grand_total_cost` int DEFAULT '0',
  `discount` int DEFAULT '0',
  `gstIncluded` tinyint DEFAULT NULL,
  `showBreakup` tinyint DEFAULT NULL,
  `eventStartDate` date DEFAULT NULL,
  `eventEndDate` date DEFAULT NULL,
  `guestId` int DEFAULT NULL,
  `guestName` varchar(250) DEFAULT NULL,
  `quotationAudienceType` int DEFAULT NULL,
  `contactMethod` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_ep_created_by` (`createdBy`),
  KEY `fk_ep_event_type` (`package_type`),
  CONSTRAINT `fk_ep_event_type` FOREIGN KEY (`package_type`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_package`
--

LOCK TABLES `event_package` WRITE;
/*!40000 ALTER TABLE `event_package` DISABLE KEYS */;
INSERT INTO `event_package` VALUES (1,'Goa Diaries','Hi Tea at 4 Pam. ',10,2,2,0,0,1,1,'2025-04-29','2025-04-30',0,'Guest',0,NULL,'9999449267','',1,'2025-04-28 05:50:22','2025-04-28 05:50:22'),(3,'Goa Diaries','at 6 pm',10,2,2,20200,0,1,1,'2025-04-29','2025-04-30',0,'Guest',0,NULL,'9999449267','',1,'2025-04-28 07:18:29','2025-04-28 07:18:29'),(4,'Goa Diaries','asdg',10,2,3,20200,3000,1,1,'2025-04-28','2025-04-30',0,'Guest',0,NULL,'9999449267','',1,'2025-04-28 07:25:00','2025-04-28 07:25:00'),(5,'Thailand Diaries','pojhkojn',9,2,23,4200,345,1,1,'2025-04-29','2025-04-30',17,'UdanChoo Tourism',0,NULL,'9999449267','sales@udanchoo.com',1,'2025-04-28 07:27:06','2025-04-28 07:27:06'),(6,'Golden Tulip','zxbegh',10,2,1,215,15,1,1,'2025-04-29','2025-04-30',0,'Guest',2,'mobile','9999449267','',1,'2025-04-28 07:38:07','2025-04-28 07:38:07'),(7,'Golden Tulip','Finally Loading Worked. ',10,2,1,215,15,1,1,'2025-04-29','2025-04-30',0,'Guest',2,'mobile','9999449267','',1,'2025-04-28 14:45:08','2025-04-28 14:45:08'),(8,'Golden Tulip','Finally Loading Worked. ',10,2,1,215,15,1,1,'2025-04-29','2025-04-30',0,'Guest',2,'mobile','9999449267','',1,'2025-04-29 15:17:56','2025-04-29 15:17:56'),(9,'Golden Tulip','Finally Loading Worked. ',10,2,1,4215,215,1,1,'2025-04-30','2025-05-01',0,'Guest',2,'mobile','9999449267','',1,'2025-04-29 15:32:20','2025-04-29 15:32:20'),(10,'Golden Tulip','Finally Loading Worked. ',10,2,1,1700,700,1,1,'2025-06-02','2025-06-03',0,'Guest',2,'mobile','9999449267','',0,'2025-04-29 15:57:47','2025-05-02 16:00:26'),(11,'Perfect Trip','Finally Loading Worked. ',10,2,1,11700,700,1,1,'2025-05-02','2025-05-03',0,'Guest',2,'mobile','9999449267','',0,'2025-04-29 16:01:18','2025-05-01 14:04:36'),(12,'Perfect Trip','Finally Loading Worked. ',10,2,1,9700,700,1,1,'2025-04-30','2025-05-01',0,'Guest',2,'mobile','9999449267','',1,'2025-04-29 16:06:12','2025-04-29 16:10:19'),(13,'Amazing Wedding','Need to provide good services. ',2,1,1,50400,400,1,1,'2025-05-02','2025-05-04',0,'Guest',2,'mobile','9999449267','',0,'2025-05-01 14:33:58','2025-05-02 10:37:11'),(14,'Golden Tulip','',9,1,8,422200,0,1,1,'2025-05-05','2025-05-09',0,'Guest',2,'mobile','9999449267','',1,'2025-05-02 10:42:48','2025-05-02 10:42:48'),(15,'Amazing Wedding','',10,1,7,262000,2000,1,1,'2025-05-12','2025-05-15',0,'Guest',0,'','','',0,'2025-05-02 10:43:54','2025-05-02 16:13:04'),(16,'Thailand Diaries','',2,1,1,96200,0,1,1,'2025-05-27','2025-05-29',0,'Guest',2,'mobile','9999449267','',0,'2025-05-02 10:45:28','2025-05-02 10:45:51'),(17,'Goa Diaries','',2,1,7,110400,800,1,1,'2025-05-26','2025-05-28',0,'Guest',2,'mobile','9999449267','',0,'2025-05-02 10:47:22','2025-05-06 07:39:41'),(18,'Royal Marriage at Corbett','Min. 50% of the payment required. Liquor License cost is INR 25000 per day. we can help in procurement. \r\n',2,1,7,18804,1292,1,1,'2025-05-26','2025-05-28',0,'Sushil Chugh',2,'mobile','9999449267','sushil@udanchoo.com',0,'2025-05-02 15:36:41','2025-05-07 07:25:07'),(20,'Diwali Grand Event','WE will ensure success for your corporate event. we are experienced. ',50,2,10,136700,700,1,0,'2025-05-09','2025-05-11',0,'Guest',2,'both','9999449267','sushil@udanchoo.com',0,'2025-05-06 13:19:56','2025-05-06 15:24:10');
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
  `serviceName` varchar(255) DEFAULT NULL,
  `service_type` int DEFAULT NULL,
  `costPerUnit` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `totalCost` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `event_package_service_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `event_package` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_package_service`
--

LOCK TABLES `event_package_service` WRITE;
/*!40000 ALTER TABLE `event_package_service` DISABLE KEYS */;
INSERT INTO `event_package_service` VALUES (1,1,'Projector and Stationary',8,200,1,200,'2025-04-28 11:20:22','2025-04-28 11:20:22'),(2,1,'Hi Tea',1,200,2,400,'2025-04-28 11:20:22','2025-04-28 11:20:22'),(3,3,'Projector and Stationary',8,200,1,200,'2025-04-28 12:48:29','2025-04-28 12:48:29'),(5,4,'Projector and Stationary',8,200,1,200,'2025-04-28 12:55:00','2025-04-28 12:55:00'),(6,4,'Decoration',2,20000,1,20000,'2025-04-28 12:55:00','2025-04-28 12:55:00'),(7,5,'Projector and Stationary',8,200,1,200,'2025-04-28 12:57:06','2025-04-28 12:57:06'),(8,5,'Big Barter',6,2000,1,4000,'2025-04-28 12:57:06','2025-04-28 12:57:06'),(9,6,'Projector and Stationary',8,200,1,200,'2025-04-28 13:08:07','2025-04-28 13:08:07'),(10,6,'Projector',1,5,3,15,'2025-04-28 13:08:07','2025-04-28 13:08:07'),(11,7,'Projector and Stationary',8,200,1,200,'2025-04-28 20:15:08','2025-04-28 20:15:08'),(12,7,'Projector',1,5,3,15,'2025-04-28 20:15:08','2025-04-28 20:15:08'),(13,8,'Projector and Stationary',8,200,1,200,'2025-04-29 20:47:56','2025-04-29 20:47:56'),(14,8,'Projector',1,5,3,15,'2025-04-29 20:47:56','2025-04-29 20:47:56'),(15,9,'Projector and Stationary',8,200,1,200,'2025-04-29 21:02:20','2025-04-29 21:02:20'),(16,9,'Projector',1,5,3,15,'2025-04-29 21:02:20','2025-04-29 21:02:20'),(17,9,'Hi Tea',1,400,10,4000,'2025-04-29 21:02:20','2025-04-29 21:02:20'),(18,10,'Projector and Stationary',8,200,1,200,'2025-04-29 21:27:47','2025-04-29 21:27:47'),(19,10,'Projector',1,500,3,1500,'2025-04-29 21:27:47','2025-04-29 21:27:47'),(21,11,'Projector and Stationary',8,200,1,200,'2025-04-29 21:31:18','2025-04-29 21:31:18'),(22,11,'Projector On Rent ',1,500,3,1500,'2025-04-29 21:31:18','2025-05-01 19:32:00'),(23,12,'Projector and Stationary',8,200,1,200,'2025-04-29 21:36:12','2025-04-29 21:36:12'),(24,12,'Projector',1,500,3,1500,'2025-04-29 21:36:12','2025-04-29 21:36:12'),(25,12,'Hi Tea',1,400,10,4000,'2025-04-29 21:36:12','2025-04-29 21:36:12'),(26,12,'Projector and Stationary',8,200,1,200,'2025-04-29 21:37:12','2025-04-29 21:37:12'),(27,12,'Projector',1,500,3,1500,'2025-04-29 21:37:12','2025-04-29 21:37:12'),(28,12,'Hi Tea',1,400,20,8000,'2025-04-29 21:37:12','2025-04-29 21:37:12'),(29,12,'Projector and Stationary',8,200,1,200,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(30,12,'Projector',1,500,3,1500,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(31,12,'Hi Tea',1,400,10,4000,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(32,12,'Projector and Stationary',8,200,1,200,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(33,12,'Projector',1,500,3,1500,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(34,12,'Hi Tea',1,400,20,8000,'2025-04-29 21:40:19','2025-04-29 21:40:19'),(35,11,'Meeting and Safari',8,5000,2,10000,'2025-05-01 19:34:36','2025-05-01 19:34:36'),(36,13,'Decoration',7,20000,1,40000,'2025-05-01 20:03:58','2025-05-01 21:21:00'),(37,13,'Hi Tea',3,400,2,2400,'2025-05-01 20:03:58','2025-05-01 21:21:00'),(38,13,NULL,NULL,0,NULL,0,'2025-05-01 20:03:58','2025-05-01 21:24:54'),(39,13,NULL,NULL,0,NULL,0,'2025-05-01 20:03:58','2025-05-01 21:22:12'),(40,13,NULL,NULL,0,NULL,0,'2025-05-01 20:03:58','2025-05-01 21:21:28'),(41,13,NULL,NULL,0,NULL,0,'2025-05-01 20:57:16','2025-05-01 20:59:00'),(42,13,'DJ Service',7,2000,2,8000,'2025-05-02 16:06:55','2025-05-02 16:06:55'),(43,13,'Projector and Stationary',8,5000,1,5000,'2025-05-02 16:06:55','2025-05-02 16:06:55'),(44,14,'Accomodation in well appointed rooms during the ceremony',1,2200,9,79200,'2025-05-02 16:12:48','2025-05-02 16:12:48'),(45,14,'Decoration',7,20000,4,320000,'2025-05-02 16:12:48','2025-05-02 16:12:48'),(46,14,'Hi Tea',3,400,9,18000,'2025-05-02 16:12:48','2025-05-02 16:12:48'),(47,14,'DJ Service',8,5000,1,5000,'2025-05-02 16:12:48','2025-05-02 16:12:48'),(48,15,'Accomodation in well appointed rooms during the ceremony',1,2200,10,66000,'2025-05-02 16:13:54','2025-05-02 16:13:54'),(49,15,'Decoration',7,20000,3,180000,'2025-05-02 16:13:54','2025-05-02 16:13:54'),(53,16,'Accomodation in well appointed rooms during the ceremony',1,2200,2,8800,'2025-05-02 16:15:28','2025-05-02 16:15:28'),(54,16,'Decoration',7,20000,2,80000,'2025-05-02 16:15:28','2025-05-02 16:15:28'),(55,16,'Hi Tea',3,400,2,2400,'2025-05-02 16:15:28','2025-05-02 16:15:28'),(57,16,NULL,NULL,0,NULL,0,'2025-05-02 16:15:28','2025-05-02 16:16:17'),(58,17,'Accomodation in well appointed rooms during the ceremony',1,2200,2,8800,'2025-05-02 16:17:22','2025-05-02 16:17:22'),(59,17,'Decoration',7,20000,2,80000,'2025-05-02 16:17:22','2025-05-02 16:17:22'),(61,17,'Room Cleaning',1,5000,1,10000,'2025-05-02 16:17:22','2025-05-02 16:31:41'),(63,17,NULL,NULL,0,NULL,0,'2025-05-02 16:45:57','2025-05-02 17:11:23'),(64,17,NULL,NULL,0,NULL,0,'2025-05-02 16:45:57','2025-05-02 17:11:23'),(65,17,NULL,NULL,0,NULL,0,'2025-05-02 16:45:57','2025-05-02 17:11:23'),(66,17,NULL,NULL,0,NULL,0,'2025-05-02 16:45:57','2025-05-02 17:11:23'),(67,18,'Accomodation in well appointed rooms during the ceremony',1,2200,2,8800,'2025-05-02 21:06:41','2025-05-02 21:06:41'),(70,15,'Hi Tea',3,400,10,16000,'2025-05-02 21:43:04','2025-05-02 21:43:04'),(71,18,'Decoration',7,2000,1,4000,'2025-05-03 15:29:30','2025-05-03 15:29:30'),(72,18,'Hi Tea',2,600,10,6000,'2025-05-05 19:23:28','2025-05-05 19:23:28'),(73,18,'Room Cleaning',1,1,2,4,'2025-05-05 20:29:11','2025-05-05 20:29:11'),(77,17,'DJ Service',7,5000,1,10000,'2025-05-06 13:07:51','2025-05-06 13:07:51'),(78,17,'Banquet Hall',8,300,2,600,'2025-05-06 13:08:16','2025-05-06 13:08:16'),(79,17,'Aarti Pooja',8,100,10,1000,'2025-05-06 13:08:52','2025-05-06 13:08:52'),(82,20,'Projector and Stationary',8,200,1,200,'2025-05-06 18:49:56','2025-05-06 18:49:56'),(83,20,'Accomodation in well appointed rooms',1,1100,50,110000,'2025-05-06 18:49:56','2025-05-06 18:49:56'),(84,20,'AM PM',2,200,50,10000,'2025-05-06 18:49:56','2025-05-06 18:49:56'),(85,20,'Room Cleaning',6,500,10,15000,'2025-05-06 18:49:56','2025-05-06 18:49:56'),(86,20,'Banquet Hall',6,500,1,1500,'2025-05-06 18:49:56','2025-05-06 18:49:56');
/*!40000 ALTER TABLE `event_package_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_service_cost_type`
--

DROP TABLE IF EXISTS `event_service_cost_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_service_cost_type` (
  `eventServiceCostTypeId` int NOT NULL AUTO_INCREMENT,
  `eventServiceCostTypeName` varchar(100) NOT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`eventServiceCostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_service_cost_type`
--

LOCK TABLES `event_service_cost_type` WRITE;
/*!40000 ALTER TABLE `event_service_cost_type` DISABLE KEYS */;
INSERT INTO `event_service_cost_type` VALUES (1,'PER_GUEST_PER_NIGHT',1),(2,'PER_GUEST_ONE_TIME',1),(3,'PER_GUEST_PER_DAY',1),(4,'PER_ROOM_ONE_TIME',1),(5,'PER_ROOM_PER_NIGHT',1),(6,'PER_DAY',1),(7,'PER_NIGHT',1),(8,'ONE_TIME',1),(9,'MANUAL',1);
/*!40000 ALTER TABLE `event_service_cost_type` ENABLE KEYS */;
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
INSERT INTO `hibernate_sequence` VALUES (32);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_master`
--

LOCK TABLES `lead_master` WRITE;
/*!40000 ALTER TABLE `lead_master` DISABLE KEYS */;
INSERT INTO `lead_master` VALUES (34,15,2,3,4,0,'sdgasgadgs This isclient remarks. ','','2025-05-20','2025-05-22',101,NULL,1,0,1,0,0,0,1,1,NULL,NULL),(35,15,2,0,0,0,'1) Temperature\r\n2) Safari Cost\r\n3) Safari Timings\r\n4) Possible Activities. ','','2025-05-14','2025-05-16',101,NULL,1,0,1,0,0,0,1,31,NULL,NULL);
/*!40000 ALTER TABLE `lead_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_system_quotation`
--

DROP TABLE IF EXISTS `lead_system_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_system_quotation` (
  `lsqid` bigint NOT NULL AUTO_INCREMENT,
  `leadId` bigint NOT NULL,
  `versionId` int DEFAULT NULL,
  `contactMethod` int DEFAULT NULL,
  `clientId` int DEFAULT NULL,
  `guestName` varchar(255) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `email` varchar(1000) DEFAULT NULL,
  `grandTotal` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lsqid`),
  KEY `fk_lead` (`leadId`),
  KEY `fk_client_sq` (`clientId`),
  CONSTRAINT `fk_client_sq` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  CONSTRAINT `fk_lead` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_system_quotation`
--

LOCK TABLES `lead_system_quotation` WRITE;
/*!40000 ALTER TABLE `lead_system_quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_system_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_system_quotation_room_details`
--

DROP TABLE IF EXISTS `lead_system_quotation_room_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_system_quotation_room_details` (
  `lsqrd` bigint NOT NULL AUTO_INCREMENT,
  `lsqid` bigint NOT NULL,
  `roomCategoryId` int NOT NULL,
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
  PRIMARY KEY (`lsqrd`),
  KEY `fk_lsqid` (`lsqid`),
  KEY `fk_room_category` (`roomCategoryId`),
  CONSTRAINT `fk_lsqid` FOREIGN KEY (`lsqid`) REFERENCES `lead_system_quotation` (`lsqid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_room_category` FOREIGN KEY (`roomCategoryId`) REFERENCES `master_room_details` (`roomCategoryId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_system_quotation_room_details`
--

LOCK TABLES `lead_system_quotation_room_details` WRITE;
/*!40000 ALTER TABLE `lead_system_quotation_room_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_system_quotation_room_details` ENABLE KEYS */;
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
INSERT INTO `role` VALUES (1,'ADMIN','PRIV'),(2,'USER','PRIV'),(3,'CLIENT_CREATE','CLIENT'),(4,'CLIENT_MANAGE','CLIENT'),(5,'USER_MANAGE','USER'),(6,'LEADS_MANAGE','LEADS'),(7,'COST_MANAGE','COST'),(8,'SALES_PARTNER_CREATE','SALES'),(9,'SALES_PARTNER_MANAGE','SALES'),(10,'RATE_TYPE_MANAGE','SALES'),(11,'ROOMS_MANAGE','SALES'),(12,'EVENT_MANAGE','EVENT');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salespartner`
--

LOCK TABLES `salespartner` WRITE;
/*!40000 ALTER TABLE `salespartner` DISABLE KEYS */;
INSERT INTO `salespartner` VALUES (14,'03_Lowest_B2b_Rates','03_Lowest_B2b_Rates',5,9999449267,'sales@udanchoo.com',23,'JG3 250B Vikas Puri','Direct','Sales Partner',1,'2025-04-10 15:01:25','2025-04-10 15:31:41'),(15,'01_B2C_Direct_Clients','01_B2C_Direct_Clients',7,9999441267,'sushil@vistaluxhotel.com',23,'JG3 250B First Floor \r\nVikas Puri','Direct','Direct',1,'2025-04-10 15:07:38','2025-04-10 15:31:23'),(16,'02_Standard_B2b_Rates','02_Standard_B2b_Rates',6,9999449267,'sushil@vistaluxhotel.com',23,'JG3 250B First Floor `\r\nVikas Puri','direct','Direct',1,'2025-04-10 15:08:42','2025-04-10 15:31:33'),(17,'UdanChoo','UdanChoo Tourism',5,9999449267,'sales@udanchoo.com',23,'JG3 250B First Floor `\r\nVikas Puri','direct','Direct',1,'2025-04-10 15:30:52',NULL),(18,'Honeygold','Honeygold travels',6,9999449267,'honey@udanchoo.com',23,'pitam pura','direct','direct. ',1,'2025-05-14 10:48:12',NULL),(19,'dummy one','dummy one',5,9999449267,'dummy@udanchoo.com',23,'','','',1,'2025-05-15 14:11:55',NULL);
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

-- Dump completed on 2025-05-25 13:26:19
