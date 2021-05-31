-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2021 at 03:19 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cimo`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acc_acc_ID` varchar(60) NOT NULL,
  `acc_logo` varchar(255) DEFAULT NULL,
  `acc_user` varchar(255) NOT NULL,
  `acc_pass` varchar(60) NOT NULL,
  `acc_date_time_cr` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `count_info`
--

CREATE TABLE `count_info` (
  `count_info_ID` varchar(60) NOT NULL,
  `count_allowable_capacity` int(11) DEFAULT NULL,
  `count_current` int(11) DEFAULT NULL,
  `count_available` int(11) DEFAULT NULL,
  `count_date_time_cr` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `establishment`
--

CREATE TABLE `establishment` (
  `est_ID` varchar(60) NOT NULL,
  `est_name` varchar(255) NOT NULL,
  `est_type` varchar(60) NOT NULL,
  `est_count_info_ID` varchar(60) NOT NULL,
  `est_loc_ID` varchar(60) NOT NULL,
  `est_acc_ID` varchar(60) NOT NULL,
  `est_date_time_cr` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `loc_loc_ID` varchar(60) NOT NULL,
  `loc_city` varchar(255) NOT NULL,
  `loc_branch_str` varchar(255) NOT NULL,
  `loc_brgy` varchar(255) NOT NULL,
  `loc_lat` decimal(8,6) NOT NULL,
  `loc_long` decimal(9,6) NOT NULL,
  `loc_date_time_cr` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acc_acc_ID`);

--
-- Indexes for table `count_info`
--
ALTER TABLE `count_info`
  ADD PRIMARY KEY (`count_info_ID`);

--
-- Indexes for table `establishment`
--
ALTER TABLE `establishment`
  ADD PRIMARY KEY (`est_ID`),
  ADD KEY `est_acc_ID` (`est_acc_ID`),
  ADD KEY `est_loc_ID` (`est_loc_ID`),
  ADD KEY `est_count_info_ID` (`est_count_info_ID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`loc_loc_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `establishment`
--
ALTER TABLE `establishment`
  ADD CONSTRAINT `establishment_ibfk_1` FOREIGN KEY (`est_loc_ID`) REFERENCES `location` (`loc_loc_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `establishment_ibfk_2` FOREIGN KEY (`est_count_info_ID`) REFERENCES `count_info` (`count_info_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `establishment_ibfk_3` FOREIGN KEY (`est_acc_ID`) REFERENCES `account` (`acc_acc_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
