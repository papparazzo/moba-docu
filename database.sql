-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 24, 2023 at 07:16 PM
-- Server version: 10.6.11-MariaDB-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `moba`
--
CREATE DATABASE IF NOT EXISTS `moba` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `moba`;

-- --------------------------------------------------------

--
-- Table structure for table `BlockSections`
--

DROP TABLE IF EXISTS `BlockSections`;
CREATE TABLE `BlockSections` (
  `Id` int(10) UNSIGNED NOT NULL,
  `BrakeTriggerContactId` int(10) UNSIGNED NOT NULL,
  `BlockContactId` int(10) UNSIGNED NOT NULL,
  `TrainId` int(10) UNSIGNED DEFAULT NULL,
  `Locked` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `FeedbackContacts`
--

DROP TABLE IF EXISTS `FeedbackContacts`;
CREATE TABLE `FeedbackContacts` (
  `Id` int(10) UNSIGNED NOT NULL,
  `ModulAddress` int(10) UNSIGNED NOT NULL,
  `ContactNumber` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SwitchDrive`
--

DROP TABLE IF EXISTS `SwitchDrive`;
CREATE TABLE `SwitchDrive` (
  `Id` int(11) UNSIGNED NOT NULL,
  `SwitchStand` enum('STRAIGHT_1','BEND_1','STRAIGHT_2','BEND_2') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TrackLayouts`
--

DROP TABLE IF EXISTS `TrackLayouts`;
CREATE TABLE `TrackLayouts` (
  `Id` int(11) UNSIGNED NOT NULL,
  `Name` varchar(256) NOT NULL,
  `Description` text NOT NULL,
  `Locked` int(11) UNSIGNED DEFAULT NULL,
  `ModificationDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CreationDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TrackLayoutSymbols`
--

DROP TABLE IF EXISTS `TrackLayoutSymbols`;
CREATE TABLE `TrackLayoutSymbols` (
  `Id` int(11) UNSIGNED NOT NULL,
  `TrackLayoutId` int(11) UNSIGNED NOT NULL,
  `XPos` int(10) UNSIGNED NOT NULL,
  `YPos` int(10) UNSIGNED NOT NULL,
  `Symbol` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Trains`
--

DROP TABLE IF EXISTS `Trains`;
CREATE TABLE `Trains` (
  `Id` int(10) UNSIGNED NOT NULL,
  `Address` int(11) UNSIGNED NOT NULL,
  `Speed` int(11) UNSIGNED NOT NULL,
  `DrivingDirection` enum('FORWARD','BACKWARD') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;


--
-- Indexes for dumped tables
--

--
-- Indexes for table `BlockSections`
--
ALTER TABLE `BlockSections`
  ADD UNIQUE KEY `index` (`Id`) USING BTREE,
  ADD UNIQUE KEY `Contact1` (`BlockContactId`) USING BTREE,
  ADD UNIQUE KEY `Contact2` (`BrakeTriggerContactId`) USING BTREE,
  ADD UNIQUE KEY `Train` (`TrainId`) USING BTREE;

--
-- Indexes for table `FeedbackContacts`
--
ALTER TABLE `FeedbackContacts`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `SwitchDrive`
--
ALTER TABLE `SwitchDrive`
  ADD UNIQUE KEY `Id` (`Id`) USING BTREE;

--
-- Indexes for table `TrackLayouts`
--
ALTER TABLE `TrackLayouts`
  ADD PRIMARY KEY (`Id`) USING BTREE;

--
-- Indexes for table `TrackLayoutSymbols`
--
ALTER TABLE `TrackLayoutSymbols`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Unique` (`TrackLayoutId`,`XPos`,`YPos`) USING BTREE,
  ADD KEY `TrackLayoutIdIndex` (`TrackLayoutId`) USING BTREE;

--
-- Indexes for table `Trains`
--
ALTER TABLE `Trains`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `FeedbackContacts`
--
ALTER TABLE `FeedbackContacts`
  MODIFY `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TrackLayouts`
--
ALTER TABLE `TrackLayouts`
  MODIFY `Id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TrackLayoutSymbols`
--
ALTER TABLE `TrackLayoutSymbols`
  MODIFY `Id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Trains`
--
ALTER TABLE `Trains`
  MODIFY `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `BlockSections`
--
ALTER TABLE `BlockSections`
  ADD CONSTRAINT `Contact1` FOREIGN KEY (`BlockContactId`) REFERENCES `FeedbackContacts` (`Id`),
  ADD CONSTRAINT `Contact2` FOREIGN KEY (`BrakeTriggerContactId`) REFERENCES `FeedbackContacts` (`Id`),
  ADD CONSTRAINT `Symbol` FOREIGN KEY (`Id`) REFERENCES `TrackLayoutSymbols` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Train` FOREIGN KEY (`TrainId`) REFERENCES `Trains` (`Id`) ON DELETE SET NULL;

--
-- Constraints for table `SwitchDrive`
--
ALTER TABLE `SwitchDrive`
  ADD CONSTRAINT `Symbols1` FOREIGN KEY (`Id`) REFERENCES `TrackLayoutSymbols` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TrackLayoutSymbols`
--
ALTER TABLE `TrackLayoutSymbols`
  ADD CONSTRAINT `A` FOREIGN KEY (`TrackLayoutId`) REFERENCES `TrackLayouts` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

