-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2021 at 08:56 AM
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

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acc_acc_ID`, `acc_logo`, `acc_user`, `acc_pass`, `acc_date_time_cr`) VALUES
('IDacc=60b6e5ef52eeczH7CBvY5l4Q', 'None', '123', '$2y$10$h.GMLdb7q/ECIi19VCVuQOaxSRp5LBnro9o74Tgc2okNhVQCRnn56', '2021-06-02 09:59:11'),
('IDacc=60b6ea2e449efEfGy9Z8OjLA', 'None', '1234', '$2y$10$yHGpptwJCF3KEKRLhGclOuDndQpu.OZqHwHMWbrVAl5BD2Hd1LIU6', '2021-06-02 10:17:18');

-- --------------------------------------------------------

--
-- Table structure for table `count_info`
--

CREATE TABLE `count_info` (
  `count_info_ID` varchar(60) NOT NULL,
  `count_allowable_capacity` decimal(2,1) DEFAULT NULL,
  `count_normal_capacity` int(11) NOT NULL,
  `count_current` int(11) DEFAULT NULL,
  `count_available` int(11) DEFAULT NULL,
  `count_date_time_cr` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `count_info`
--

INSERT INTO `count_info` (`count_info_ID`, `count_allowable_capacity`, `count_normal_capacity`, `count_current`, `count_available`, `count_date_time_cr`) VALUES
('IDcnt=60b6e5ef52ee18CrxgR4PVMB', '0.9', 100, 0, 0, '2021-06-02 01:59:11'),
('IDcnt=60b6ea2e449ecebuxVDlakUF', '0.3', 50, 0, 0, '2021-06-02 02:17:18');

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

--
-- Dumping data for table `establishment`
--

INSERT INTO `establishment` (`est_ID`, `est_name`, `est_type`, `est_count_info_ID`, `est_loc_ID`, `est_acc_ID`, `est_date_time_cr`) VALUES
('IDest=60b6e5ef52eefLWS2F9sjbHw', 'Mang inasal', 'Fast food', 'IDcnt=60b6e5ef52ee18CrxgR4PVMB', 'IDloc=60b6e5ef52ee9GK4NgaiIEpb', 'IDacc=60b6e5ef52eeczH7CBvY5l4Q', '2021-06-02 09:59:11'),
('IDest=60b6ea2e449f0cDd4Bgqsv9m', 'Jolibee', 'Fast food', 'IDcnt=60b6ea2e449ecebuxVDlakUF', 'IDloc=60b6ea2e449eexf4a7NpRGyM', 'IDacc=60b6ea2e449efEfGy9Z8OjLA', '2021-06-02 10:17:18');

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
-- Dumping data for table `location`
--

INSERT INTO `location` (`loc_loc_ID`, `loc_city`, `loc_branch_str`, `loc_brgy`, `loc_lat`, `loc_long`, `loc_date_time_cr`) VALUES
('IDloc=60b6e5ef52ee9GK4NgaiIEpb', 'Bacolod', 'Mabini', 'Savemore', '10.659989', '122.948861', '2021-06-02 09:59:11'),
('IDloc=60b6ea2e449eexf4a7NpRGyM', 'Bacolod', 'Lacson', 'Barangay 40', '10.661731', '122.946963', '2021-06-02 10:17:18');

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
