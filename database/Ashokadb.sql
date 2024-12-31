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
  `deleted` tinyint DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam`
--

LOCK TABLES `ashokateam` WRITE;
/*!40000 ALTER TABLE `ashokateam` DISABLE KEYS */;
INSERT INTO `ashokateam` VALUES (1,'Sushil','$2a$10$3zMTkSVpm7yBDehJ.wTbJOnEyYzNCWgC/vYB4wwr9JYFaKhUxuGoi','Sushil Chugh','Vikas Puriu',9999449267,'Partner','Confirmed','First',450000,NULL,NULL,NULL,NULL,'sushil@vistaluxhotel.com',0,NULL,NULL,NULL,NULL,NULL,1,0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ashokateam_role`
--

LOCK TABLES `ashokateam_role` WRITE;
/*!40000 ALTER TABLE `ashokateam_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `ashokateam_role` ENABLE KEYS */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-31 19:37:14
