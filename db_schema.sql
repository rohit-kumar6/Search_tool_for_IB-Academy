-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 06, 2019 at 05:24 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ib`
--

-- --------------------------------------------------------

--
-- Table structure for table `batch_wise_question`
--

CREATE TABLE `batch_wise_question` (
  `id` int(11) NOT NULL,
  `batch_id` int(11) DEFAULT NULL,
  `q_id` int(11) DEFAULT NULL,
  `question_type` binary(1) DEFAULT NULL,
  `Week_number` int(11) DEFAULT NULL,
  `question_topic` varchar(30) DEFAULT NULL,
  `day_number` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `batch_wise_question`
--

INSERT INTO `batch_wise_question` (`id`, `batch_id`, `q_id`, `question_type`, `Week_number`, `question_topic`, `day_number`) VALUES
(1, 1, 1, 0x30, 1, 'Array And Math', 2);

-- --------------------------------------------------------

--
-- Table structure for table `company_table`
--

CREATE TABLE `company_table` (
  `company_id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_table`
--

INSERT INTO `company_table` (`company_id`, `company_name`) VALUES
(1, 'Amazon');

-- --------------------------------------------------------

--
-- Table structure for table `company_wise_question`
--

CREATE TABLE `company_wise_question` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `q_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company_wise_question`
--

INSERT INTO `company_wise_question` (`id`, `company_id`, `q_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `question_table`
--

CREATE TABLE `question_table` (
  `q_id` int(10) UNSIGNED NOT NULL,
  `question_name` varchar(250) NOT NULL,
  `question_tag` varchar(30) DEFAULT NULL,
  `question_content` varchar(2000) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `question_table`
--

INSERT INTO `question_table` (`q_id`, `question_name`, `question_tag`, `question_content`) VALUES
(1, 'Max Non Negative SubArray', 'Array', 'Find out the maximum sub-array of non negative numbers from an array. The sub-array should be continuous. That is, a sub-array created by choosing the second and fourth element and skipping the third element is invalid. Maximum sub-array is defined in terms of the sum of the elements in the sub-array. Sub-array A is greater than sub-array B if sum(A) > sum(B)');

-- --------------------------------------------------------

--
-- Table structure for table `users_in_batches`
--

CREATE TABLE `users_in_batches` (
  `batch_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users_in_batches`
--

INSERT INTO `users_in_batches` (`batch_id`, `user_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_wise_question`
--

CREATE TABLE `user_wise_question` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `q_id` int(11) DEFAULT NULL,
  `question_status` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_wise_question`
--

INSERT INTO `user_wise_question` (`id`, `user_id`, `q_id`, `question_status`) VALUES
(1, 1, 1, 0),
(2, 2, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `batch_wise_question`
--
ALTER TABLE `batch_wise_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `q_id` (`q_id`);

--
-- Indexes for table `company_table`
--
ALTER TABLE `company_table`
  ADD PRIMARY KEY (`company_id`);

--
-- Indexes for table `company_wise_question`
--
ALTER TABLE `company_wise_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_t1_t2_tt` (`company_id`),
  ADD KEY `fk_t2_t2_tt` (`q_id`);

--
-- Indexes for table `question_table`
--
ALTER TABLE `question_table`
  ADD PRIMARY KEY (`q_id`),
  ADD KEY `q_name` (`question_name`),
  ADD KEY `q_tag` (`question_tag`);

--
-- Indexes for table `users_in_batches`
--
ALTER TABLE `users_in_batches`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `user_wise_question`
--
ALTER TABLE `user_wise_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `q_id` (`q_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `batch_wise_question`
--
ALTER TABLE `batch_wise_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `company_table`
--
ALTER TABLE `company_table`
  MODIFY `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `company_wise_question`
--
ALTER TABLE `company_wise_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `question_table`
--
ALTER TABLE `question_table`
  MODIFY `q_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users_in_batches`
--
ALTER TABLE `users_in_batches`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_wise_question`
--
ALTER TABLE `user_wise_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
