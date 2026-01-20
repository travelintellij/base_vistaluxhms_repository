-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: vanilla
-- ------------------------------------------------------
-- Server version	8.0.43

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
  `userId` int NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam`
--

LOCK TABLES `ashokateam` WRITE;
/*!40000 ALTER TABLE `ashokateam` DISABLE KEYS */;
INSERT INTO `ashokateam` VALUES (1,'admin','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Super Admin','Corbett',9090762424,'Super Admin',NULL,NULL,0,NULL,'sales@digitalintellij.com',NULL,'2026-01-13','sales@digitalintellij.com',9090762424,NULL,NULL,NULL,NULL,'perfect',1,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam_role`
--

LOCK TABLES `ashokateam_role` WRITE;
/*!40000 ALTER TABLE `ashokateam_role` DISABLE KEYS */;
INSERT INTO `ashokateam_role` VALUES (1,1,1),(2,1,43);
/*!40000 ALTER TABLE `ashokateam_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_allocations`
--

DROP TABLE IF EXISTS `asset_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_allocations` (
  `allocation_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT NULL,
  `ashokateam_id` int DEFAULT NULL,
  `allocated_date` datetime NOT NULL,
  PRIMARY KEY (`allocation_id`),
  KEY `asset_id` (`asset_id`),
  KEY `fk_asset_allocations_ashokateam` (`ashokateam_id`),
  CONSTRAINT `asset_allocations_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `fk_asset_allocations_ashokateam` FOREIGN KEY (`ashokateam_id`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_allocations`
--

LOCK TABLES `asset_allocations` WRITE;
/*!40000 ALTER TABLE `asset_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_transfer_history`
--

DROP TABLE IF EXISTS `asset_transfer_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_transfer_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT NULL,
  `from_ashokateam_id` int DEFAULT NULL,
  `to_ashokateam_id` int DEFAULT NULL,
  `transfer_date` datetime NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `asset_transfer_history_ibfk_1` (`asset_id`),
  KEY `fk_transfer_to_ashokateam` (`to_ashokateam_id`),
  KEY `fk_transfer_from_ashokateam` (`from_ashokateam_id`),
  CONSTRAINT `asset_transfer_history_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_transfer_from_ashokateam` FOREIGN KEY (`from_ashokateam_id`) REFERENCES `ashokateam` (`userId`),
  CONSTRAINT `fk_transfer_to_ashokateam` FOREIGN KEY (`to_ashokateam_id`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_transfer_history`
--

LOCK TABLES `asset_transfer_history` WRITE;
/*!40000 ALTER TABLE `asset_transfer_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_transfer_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `asset_id` int NOT NULL AUTO_INCREMENT,
  `asset_name` varchar(100) NOT NULL,
  `creation_date` date NOT NULL,
  `asset_cost` decimal(10,2) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `asset_code` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `owner_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  UNIQUE KEY `asset_code` (`asset_code`),
  KEY `fk_assets_category` (`category_id`),
  CONSTRAINT `fk_assets_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
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
  `tmp_id` bigint unsigned DEFAULT NULL,
  `tmpp_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`destinationId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Corbett2','IND','India',0,NULL,NULL),(2,'New York','USA','United States of America',1,NULL,NULL),(3,'Muradabad','IND','India',1,NULL,NULL),(4,'Corbett','IND','India',1,NULL,NULL),(5,'New Jersy','USA','United States of America',1,NULL,NULL),(6,'Chicago','USA','United States of America',1,NULL,NULL),(7,'Corbett3','IND','India',0,NULL,NULL),(8,'Unknown','IND','India',1,NULL,NULL),(9,'Noida','IND','India',1,NULL,NULL),(10,'Delhi','IND','India',1,NULL,NULL),(11,'Mumbai','IND','India',1,NULL,NULL),(12,'Ghaziabad','IND','India',1,NULL,NULL),(13,'Mohali','IND','India',1,NULL,NULL),(14,'Ramnagar','IND','India',1,NULL,NULL),(15,'Chandigarh','IND','India',1,NULL,NULL),(16,'Patna','IND','India',1,NULL,NULL),(17,'Gujarat','IND','India',1,NULL,NULL),(18,'Rajasthan','IND','India',1,NULL,NULL),(19,'punjab','IND','India',1,NULL,NULL),(20,'Pune','IND','India',1,NULL,NULL),(21,'Maharashtra','IND','India',NULL,NULL,NULL),(22,'Lucknow','IND','India',NULL,NULL,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_allowed_users`
--

DROP TABLE IF EXISTS `document_allowed_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_allowed_users` (
  `document_id` int NOT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`document_id`,`userId`),
  KEY `fk_user` (`userId`),
  CONSTRAINT `fk_document` FOREIGN KEY (`document_id`) REFERENCES `document_category` (`document_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_allowed_users`
--

LOCK TABLES `document_allowed_users` WRITE;
/*!40000 ALTER TABLE `document_allowed_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_allowed_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_categories_master`
--

DROP TABLE IF EXISTS `document_categories_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_categories_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_categories_master`
--

LOCK TABLES `document_categories_master` WRITE;
/*!40000 ALTER TABLE `document_categories_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_categories_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_category`
--

DROP TABLE IF EXISTS `document_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_category` (
  `document_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `uploaded_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_data` longblob,
  `is_deleted` tinyint(1) DEFAULT '0',
  `restricted` tinyint(1) DEFAULT '0',
  `category_id` int DEFAULT NULL,
  `document_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`document_id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `document_categories_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_category`
--

LOCK TABLES `document_category` WRITE;
/*!40000 ALTER TABLE `document_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_details`
--

DROP TABLE IF EXISTS `event_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_type` varchar(50) NOT NULL,
  `banner_image` longblob,
  `banner_mime_type` varchar(100) DEFAULT NULL,
  `resort_info` text,
  `celebration_highlight` text,
  `testimonial` text,
  `terms_conditions` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `event_type` (`event_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_details`
--

LOCK TABLES `event_details` WRITE;
/*!40000 ALTER TABLE `event_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_images`
--

DROP TABLE IF EXISTS `event_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `event_id` bigint NOT NULL,
  `image_index` int NOT NULL,
  `image_data` longblob,
  `image_url` varchar(500) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_event_image` (`event_id`,`image_index`),
  CONSTRAINT `fk_event` FOREIGN KEY (`event_id`) REFERENCES `event_details` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_images`
--

LOCK TABLES `event_images` WRITE;
/*!40000 ALTER TABLE `event_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_images` ENABLE KEYS */;
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
  `packageName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `guestName` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotationAudienceType` int DEFAULT NULL,
  `contactMethod` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `createdBy` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_ep_event_type` (`package_type`),
  KEY `fk_ep_created_by` (`createdBy`),
  CONSTRAINT `fk_ep_created_by` FOREIGN KEY (`createdBy`) REFERENCES `ashokateam` (`userId`),
  CONSTRAINT `fk_ep_event_type` FOREIGN KEY (`package_type`) REFERENCES `eventtype` (`eventTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `serviceName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `service_type` int DEFAULT NULL,
  `costPerUnit` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `totalCost` int DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `package_id` (`package_id`),
  CONSTRAINT `event_package_service_ibfk_1` FOREIGN KEY (`package_id`) REFERENCES `event_package` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_package_service`
--

LOCK TABLES `event_package_service` WRITE;
/*!40000 ALTER TABLE `event_package_service` DISABLE KEYS */;
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
  `eventServiceCostTypeName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`eventServiceCostTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
  `eventTypeId` int NOT NULL AUTO_INCREMENT,
  `eventTypeName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`eventTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtype`
--

LOCK TABLES `eventtype` WRITE;
/*!40000 ALTER TABLE `eventtype` DISABLE KEYS */;
INSERT INTO `eventtype` VALUES (1,'Wedding','Wedding Event',1),(2,'GROUP_EVENT','Corporate Event management',1);
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
INSERT INTO `hibernate_sequence` VALUES (1);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_central_config`
--

DROP TABLE IF EXISTS `hotel_central_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_central_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logo_path` varchar(255) DEFAULT NULL,
  `baseUrl` varchar(500) DEFAULT NULL,
  `escalationEmail` varchar(250) DEFAULT NULL,
  `escalationPhone` varchar(45) DEFAULT NULL,
  `accountName` varchar(500) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `ifsc_code` varchar(20) DEFAULT NULL,
  `branch` varchar(100) DEFAULT NULL,
  `global_watcher_emails` text,
  `hotel_name` varchar(150) DEFAULT NULL,
  `hotelInfo` text,
  `hotel_address` varchar(255) DEFAULT NULL,
  `hotel_central_number` varchar(20) DEFAULT NULL,
  `website` varchar(250) DEFAULT NULL,
  `companyName` varchar(500) DEFAULT NULL,
  `global_watcher_enabled` tinyint(1) DEFAULT '0',
  `facebook_link` varchar(255) DEFAULT NULL,
  `instagram_link` varchar(255) DEFAULT NULL,
  `linkedin_link` varchar(255) DEFAULT NULL,
  `youtube_link` varchar(255) DEFAULT NULL,
  `x_link` varchar(255) DEFAULT NULL,
  `quotationTopCover` text,
  `inclusions` text,
  `tnc` text,
  `usp` text,
  `centralized_email` varchar(150) DEFAULT NULL,
  `resort_gst_number` varchar(30) DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_central_config`
--

LOCK TABLES `hotel_central_config` WRITE;
/*!40000 ALTER TABLE `hotel_central_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_central_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_fh_quotation`
--

DROP TABLE IF EXISTS `lead_fh_quotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_fh_quotation`
--

LOCK TABLES `lead_fh_quotation` WRITE;
/*!40000 ALTER TABLE `lead_fh_quotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_fh_quotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lead_fh_quotation_room_details`
--

DROP TABLE IF EXISTS `lead_fh_quotation_room_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_fh_quotation_room_details` (
  `lfqrd` bigint NOT NULL AUTO_INCREMENT,
  `lfhqid` bigint NOT NULL,
  `roomCategoryName` varchar(250) NOT NULL,
  `noOfRooms` int DEFAULT '0',
  `mealPlanId` int DEFAULT NULL,
  `adults` int DEFAULT '0',
  `noOfChild` int DEFAULT '0',
  `checkInDate` date NOT NULL,
  `checkOutDate` date NOT NULL,
  `totalPrice` int DEFAULT '0',
  PRIMARY KEY (`lfqrd`),
  KEY `fk_lfqid` (`lfhqid`),
  CONSTRAINT `fk_lfhqid` FOREIGN KEY (`lfhqid`) REFERENCES `lead_fh_quotation` (`lfhqid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_fh_quotation_room_details`
--

LOCK TABLES `lead_fh_quotation_room_details` WRITE;
/*!40000 ALTER TABLE `lead_fh_quotation_room_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `lead_fh_quotation_room_details` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lead_master`
--

LOCK TABLES `lead_master` WRITE;
/*!40000 ALTER TABLE `lead_master` DISABLE KEYS */;
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
  `clientId` int DEFAULT NULL,
  `grandTotal` int DEFAULT NULL,
  `discount` int DEFAULT NULL,
  `remarks` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lsqid`),
  KEY `fk_lead` (`leadId`),
  KEY `fk_client_sq` (`clientId`),
  CONSTRAINT `fk_client_sq` FOREIGN KEY (`clientId`) REFERENCES `client` (`clientId`),
  CONSTRAINT `fk_lead` FOREIGN KEY (`leadId`) REFERENCES `lead_master` (`leadId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leads_followup`
--

LOCK TABLES `leads_followup` WRITE;
/*!40000 ALTER TABLE `leads_followup` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
INSERT INTO `mealplan` VALUES (1,'EPAI',1,'2026-01-09 09:34:59','2026-01-09 09:34:59'),(2,'CPAI',1,'2026-01-09 09:34:59','2026-01-09 09:34:59'),(3,'MAPI',1,'2026-01-09 09:34:59','2026-01-09 09:34:59'),(4,'APAI',1,'2026-01-09 09:34:59','2026-01-09 09:34:59');
/*!40000 ALTER TABLE `mealplan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_claims`
--

DROP TABLE IF EXISTS `my_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_claims` (
  `claimId` bigint NOT NULL AUTO_INCREMENT,
  `claimdetails` varchar(500) DEFAULT NULL,
  `claimamount` int DEFAULT NULL,
  `claimtype` int DEFAULT NULL,
  `approvedamount` int DEFAULT NULL,
  `claimdate` date DEFAULT NULL,
  `claimdecisiondate` date DEFAULT NULL,
  `claimstatus` int DEFAULT NULL,
  `expensestartdate` date DEFAULT NULL,
  `expenseenddate` date DEFAULT NULL,
  `managementremarks` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `claimentId` int DEFAULT NULL,
  `decisionmakerid` int DEFAULT NULL,
  PRIMARY KEY (`claimId`),
  KEY `fk_myclaims_claiment` (`claimentId`),
  KEY `fk_myclaims_decisionmaker` (`decisionmakerid`),
  CONSTRAINT `fk_myclaims_claiment` FOREIGN KEY (`claimentId`) REFERENCES `ashokateam` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_myclaims_decisionmaker` FOREIGN KEY (`decisionmakerid`) REFERENCES `ashokateam` (`userId`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_claims`
--

LOCK TABLES `my_claims` WRITE;
/*!40000 ALTER TABLE `my_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_travel_claims`
--

DROP TABLE IF EXISTS `my_travel_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `my_travel_claims` (
  `travelClaimId` bigint NOT NULL AUTO_INCREMENT,
  `source` varchar(250) DEFAULT NULL,
  `destination` varchar(250) DEFAULT NULL,
  `expenseStartDate` date DEFAULT NULL,
  `expenseEndDate` date DEFAULT NULL,
  `claimDetails` varchar(500) DEFAULT NULL,
  `travelMode` int DEFAULT NULL,
  `kms` int NOT NULL DEFAULT '0',
  `travelExpense` int NOT NULL DEFAULT '0',
  `foodExpense` int NOT NULL DEFAULT '0',
  `parkingExpense` int NOT NULL DEFAULT '0',
  `otherExpense1` int NOT NULL DEFAULT '0',
  `otherExpense2` int NOT NULL DEFAULT '0',
  `otherExpense3` int NOT NULL,
  `otherExpensesDetails` varchar(500) DEFAULT NULL,
  `claimentId` int DEFAULT NULL,
  `claimStatus` int DEFAULT NULL,
  `approverId` int DEFAULT NULL,
  `approverRemarks` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`travelClaimId`),
  KEY `FK_ClaimentId_idx` (`claimentId`),
  KEY `FK_ApproverID_idx` (`approverId`),
  CONSTRAINT `FK_ApproverID` FOREIGN KEY (`approverId`) REFERENCES `ashokateam` (`userId`),
  CONSTRAINT `FK_ClaimentId` FOREIGN KEY (`claimentId`) REFERENCES `ashokateam` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_travel_claims`
--

LOCK TABLES `my_travel_claims` WRITE;
/*!40000 ALTER TABLE `my_travel_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_travel_claims` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=5106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN','PRIV'),(2,'USER','PRIV'),(3,'CLIENT_CREATE','CLIENT'),(4,'CLIENT_MANAGE','CLIENT'),(5,'USER_MANAGE','USER'),(6,'LEADS_MANAGE','LEADS'),(7,'COST_MANAGE','COST'),(8,'SALES_PARTNER_CREATE','SALES'),(9,'SALES_PARTNER_MANAGE','SALES'),(10,'RATE_TYPE_MANAGE','SALES'),(11,'ROOMS_MANAGE','SALES'),(12,'EVENT_MANAGE','EVENT'),(43,'SUPERADMIN','PRIV'),(5000,'EXPENSE_APPROVER','EXPENSE-SAR'),(5100,'CAN_CLAIM','EXPENSE-SAR'),(5101,'ASSET_MANAGER','ASSETS'),(5102,'ASSET_ALLOWED','ASSETS'),(5103,'DOCUMENT_ALLOWED','KNOWLEDGE REPOSITORY'),(5104,'DOCUMENT_MANAGER','KNOWLEDGE REPOSITORY'),(5105,'RESTRICTED_DOC_ACCESS','KNOWLEDGE REPOSITORY');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `sessionId` int NOT NULL AUTO_INCREMENT,
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
-- Table structure for table `status_master`
--

DROP TABLE IF EXISTS `status_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_master` (
  `statusId` int NOT NULL AUTO_INCREMENT,
  `status_obj` varchar(45) DEFAULT NULL,
  `status_obj_type` varchar(150) DEFAULT NULL,
  `statusName` varchar(250) DEFAULT NULL,
  `master_status` tinyint DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  PRIMARY KEY (`statusId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_master`
--

LOCK TABLES `status_master` WRITE;
/*!40000 ALTER TABLE `status_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `status_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_claim_bills`
--

DROP TABLE IF EXISTS `travel_claim_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `travel_claim_bills` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `travelClaimId` bigint NOT NULL,
  `bill_file` longblob NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_travel_claims_idx` (`travelClaimId`),
  CONSTRAINT `fk_travel_claims` FOREIGN KEY (`travelClaimId`) REFERENCES `my_travel_claims` (`travelClaimId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `travel_claim_bills`
--

LOCK TABLES `travel_claim_bills` WRITE;
/*!40000 ALTER TABLE `travel_claim_bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `travel_claim_bills` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workload_status`
--

LOCK TABLES `workload_status` WRITE;
/*!40000 ALTER TABLE `workload_status` DISABLE KEYS */;
INSERT INTO `workload_status` VALUES (1,101,'LEAD_STATUS','LEAD_STATUS','Open',1000,1),(2,102,'LEAD_STATUS','LEAD_STATUS','Work In Progress',1000,1),(3,103,'LEAD_STATUS','LEAD_STATUS','Failed-Closed',2000,1),(4,104,'LEAD_STATUS','LEAD_STATUS','Won-Converted',2000,1),(5,105,'LEAD_STATUS','LEAD_STATUS','Duplicate',2000,1);
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

-- Dump completed on 2026-01-20 11:24:57
