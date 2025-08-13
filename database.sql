/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: moba
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BlockSections`
--

DROP TABLE IF EXISTS `BlockSections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `BlockSections` (
  `Id` int(10) UNSIGNED NOT NULL,
  `BrakeTriggerContactId` int(10) UNSIGNED NOT NULL,
  `BlockContactId` int(10) UNSIGNED NOT NULL,
  `TrainId` int(10) UNSIGNED DEFAULT NULL,
  `Locked` int(10) UNSIGNED DEFAULT NULL,
  UNIQUE KEY `index` (`Id`) USING BTREE,
  UNIQUE KEY `Contact1` (`BlockContactId`) USING BTREE,
  UNIQUE KEY `Contact2` (`BrakeTriggerContactId`) USING BTREE,
  UNIQUE KEY `Train` (`TrainId`) USING BTREE,
  CONSTRAINT `Contact1` FOREIGN KEY (`BlockContactId`) REFERENCES `FeedbackContacts` (`Id`),
  CONSTRAINT `Contact2` FOREIGN KEY (`BrakeTriggerContactId`) REFERENCES `FeedbackContacts` (`Id`),
  CONSTRAINT `Symbol` FOREIGN KEY (`Id`) REFERENCES `TrackLayoutSymbols` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `Train` FOREIGN KEY (`TrainId`) REFERENCES `Trains` (`Id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FeedbackContacts`
--

DROP TABLE IF EXISTS `FeedbackContacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FeedbackContacts` (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ModulAddress` int(10) UNSIGNED NOT NULL,
  `ContactNumber` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=1017 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

-- --------------------------------------------------------

--
-- Table structure for table `FunctionAddress`
--

DROP TABLE IF EXISTS `FunctionAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FunctionAddress` (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LocalId` int(10) UNSIGNED DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `TagId` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TagId` (`TagId`),
  CONSTRAINT `FunctionAddress_ibfk_1` FOREIGN KEY (`TagId`) REFERENCES `FunctionTags` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FunctionCycleTime`
--

DROP TABLE IF EXISTS `FunctionCycleTime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FunctionCycleTime` (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `FunctionAddressId` int(10) UNSIGNED NOT NULL,
  `Time` time NOT NULL,
  `Weekdays` set('SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY') NOT NULL,
  `SwitchOn` tinyint(1) NOT NULL,
  `AtRandom` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `FunctionAddressId` (`FunctionAddressId`),
  CONSTRAINT `FunctionCycleTime_ibfk_1` FOREIGN KEY (`FunctionAddressId`) REFERENCES `FunctionCycleTime` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `FunctionTags`
--

DROP TABLE IF EXISTS `FunctionTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FunctionTags` (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ParentId` int(11) UNSIGNED NOT NULL,
  `Name` varchar(25) NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `ParentId` (`ParentId`),
  CONSTRAINT `FunctionTags_ibfk_1` FOREIGN KEY (`ParentId`) REFERENCES `FunctionTags` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--

--
-- Table structure for table `SwitchDrive`
--

DROP TABLE IF EXISTS `SwitchDrive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SwitchDrive` (
  `Id` int(11) UNSIGNED NOT NULL,
  `SwitchStand` enum('STRAIGHT_1','BEND_1','STRAIGHT_2','BEND_2') NOT NULL,
  UNIQUE KEY `Id` (`Id`) USING BTREE,
  CONSTRAINT `Symbols1` FOREIGN KEY (`Id`) REFERENCES `TrackLayoutSymbols` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SwitchDrive`
--

LOCK TABLES `SwitchDrive` WRITE;
/*!40000 ALTER TABLE `SwitchDrive` DISABLE KEYS */;
INSERT INTO `SwitchDrive` VALUES
(1192,'BEND_1'),
(1203,'BEND_1');
/*!40000 ALTER TABLE `SwitchDrive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TrackLayoutSymbols`
--

DROP TABLE IF EXISTS `TrackLayoutSymbols`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TrackLayoutSymbols` (
  `Id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `TrackLayoutId` int(11) UNSIGNED NOT NULL,
  `XPos` int(10) UNSIGNED NOT NULL,
  `YPos` int(10) UNSIGNED NOT NULL,
  `Symbol` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Unique` (`TrackLayoutId`,`XPos`,`YPos`) USING BTREE,
  KEY `TrackLayoutIdIndex` (`TrackLayoutId`) USING BTREE,
  CONSTRAINT `A` FOREIGN KEY (`TrackLayoutId`) REFERENCES `TrackLayouts` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1204 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TrackLayoutSymbols`
--


--
-- Table structure for table `TrackLayouts`
--

DROP TABLE IF EXISTS `TrackLayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TrackLayouts` (
  `Id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(256) NOT NULL,
  `Description` text NOT NULL,
  `Locked` int(11) UNSIGNED DEFAULT NULL,
  `ModificationDate` timestamp /* mariadb-5.3 */ NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CreationDate` timestamp /* mariadb-5.3 */ NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TrackLayouts`
--

LOCK TABLES `TrackLayouts` WRITE;
/*!40000 ALTER TABLE `TrackLayouts` DISABLE KEYS */;
INSERT INTO `TrackLayouts` VALUES
(10,'Testanlange','Testanalage',NULL,'2023-04-07 05:50:44','2020-11-15 21:39:18'),
(103,'4','5',NULL,'2023-01-31 19:45:11','2023-01-31 19:44:47');
/*!40000 ALTER TABLE `TrackLayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Trains`
--

DROP TABLE IF EXISTS `Trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Trains` (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Address` int(11) UNSIGNED NOT NULL,
  `Speed` int(11) UNSIGNED NOT NULL,
  `DrivingDirection` enum('FORWARD','BACKWARD') NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trains`
--

LOCK TABLES `Trains` WRITE;
/*!40000 ALTER TABLE `Trains` DISABLE KEYS */;
INSERT INTO `Trains` VALUES
(1,16410,0,'FORWARD');
/*!40000 ALTER TABLE `Trains` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-13  6:59:30
