-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 08, 2019 at 11:17 AM
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
(1, 1, 1, 0x30, 1, 'Array And Math', 2),
(2, 1, 2, 0x30, 1, 'Array And Math', 2),
(3, 1, 3, 0x30, 1, 'Array And Math', 2),
(4, 1, 4, 0x30, 1, 'Array And Math', 2),
(5, 1, 5, 0x30, 1, 'Array And Math', 2),
(6, 1, 6, 0x31, 1, 'Array And Math', 2),
(7, 1, 7, 0x31, 1, 'Array And Math', 2),
(8, 1, 8, 0x31, 1, 'Array And Math', 2),
(9, 1, 9, 0x31, 1, 'Array And Math', 2),
(10, 1, 10, 0x30, 2, '2 Pointers & Bit Manipulation', 9),
(11, 1, 11, 0x30, 2, '2 Pointers & Bit Manipulation', 9),
(12, 1, 12, 0x30, 2, '2 Pointers & Bit Manipulation', 9),
(13, 1, 13, 0x30, 2, '2 Pointers & Bit Manipulation', 9),
(14, 1, 14, 0x31, 2, '2 Pointers & Bit Manipulation', 9),
(15, 1, 15, 0x31, 2, '2 Pointers & Bit Manipulation', 9),
(16, 1, 16, 0x30, 3, 'Searching Algorithms', 11),
(17, 2, 17, 0x30, 2, 'Searching Algorithms', 11),
(18, 2, 18, 0x30, 3, 'Searching Algorithms', 11),
(19, 1, 19, 0x30, 3, 'Searching Algorithms', 11),
(20, 1, 20, 0x31, 3, 'Backtracking', 13),
(21, 1, 21, 0x31, 3, 'Backtracking', 13),
(22, 1, 22, 0x31, 3, 'Backtracking', 13),
(23, 1, 23, 0x30, 3, 'Backtracking', 13);

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
(1, 'Amazon'),
(2, 'Google'),
(3, 'Microsoft'),
(4, 'Uber'),
(5, 'Youtube'),
(6, 'Facebook'),
(7, 'Goldman Sachs');

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
(1, 1, 1),
(2, 2, 4),
(3, 3, 5),
(4, 4, 8),
(5, 5, 10),
(6, 6, 12),
(7, 4, 13),
(8, 7, 14),
(9, 5, 14),
(10, 1, 15),
(11, 6, 15),
(12, 1, 16),
(13, 2, 18),
(14, 3, 19);

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
(1, 'Max Non Negative SubArray', 'Array', 'Find out the maximum sub-array of non negative numbers from an array. The sub-array should be continuous. That is, a sub-array created by choosing the second and fourth element and skipping the third element is invalid. Maximum sub-array is defined in terms of the sum of the elements in the sub-array. Sub-array A is greater than sub-array B if sum(A) > sum(B)'),
(2, 'Merge Overlapping Intervals', 'Array', 'Given a collection of intervals, merge all overlapping intervals.'),
(3, 'Wave Array', 'Array', 'Given an array of integers, sort the array into a wave like array and return it, In other words, arrange the elements into a sequence such that a1 >= a2 <= a3 >= a4 <= a5'),
(4, 'Min Jumps Array', 'Math', 'Given an array of non-negative integers, you are initially positioned at the first index of the array. Each element in the array represents your maximum jump length at that position. Your goal is to reach the last index in the minimum number of jumps. '),
(5, 'Merge Intervals', 'Array', 'Given a set of non-overlapping intervals, insert a new interval into the intervals (merge if necessary). You may assume that the intervals were initially sorted according to their start times.'),
(6, 'Move all zeroes to end of the array', 'Array', 'Given an array of integers A, push all the zeroes in the array to the end of the array keeping the order of all the remaining elements same. More formally, if A[i] and A[j] are two non zero elements and A[i] is in the left A[j] in the original array then A[i] will be in the left of A[j] in the final answer as well.'),
(7, 'Minimum Absolute Difference', 'Array', 'Given an array of integers A, find and return the minimum value of | A [ i ] - A [ j ] | where i != j and |x| denotes the absolute value of x.'),
(8, 'Rain Water Trapped', 'Stack', 'Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.'),
(9, 'Rotate Matrix', 'Array', 'You are given an n x n 2D matrix representing an image. Rotate the image by 90 degrees (clockwise).'),
(10, 'Count of pairs with the given sum', 'Two Pointers', 'Given a sorted array of distinct integers A and an integer B, find and return how many pair of integers ( A[i], A[j] ) such that i != j have sum equal to B.'),
(11, 'Count of rectangles with area less than the given number', 'Two Pointers', 'Given a sorted array of distinct integers A and an integer B, find and return how many rectangles with distinct configurations can be created using elements of this array as length and breadth whose area is lesser than B.'),
(12, 'Min XOR value', 'Two Pointers', 'Given an array of N integers, find the pair of integers in the array which have minimum XOR value. Report the minimum XOR value.'),
(13, 'Single Number II', 'Hashing', 'Given an array of integers, every element appears thrice except for one which occurs once.  Find that element which does not appear thrice. '),
(14, 'Find sub-array with the given sum', 'Two Pointers', 'Given an array of positive integers A and an integer B, find and return first continuous subarray which adds to B. If the answer does not exist return an array with a single element \"-1\"'),
(15, 'Find the closest pair from two sorted arrays', 'Two Pointers', 'Given two sorted arrays of distinct integers, A and B, and an integer C, find and return the pair whose sum is closest to C and the pair has one element from each array. More formally, find A[i] and B[j] such that abs((A[i] + B[j]) - C) has minimum value. If there are multiple solutions find the one with minimum i and even if there are multiple values of j for the same i then return the one with minimum j.'),
(16, 'Find a peak element', 'Binary Search', 'Given an array of integers A, find and return the peak element in it. An array element is peak if it is NOT smaller than its neighbors. For corner elements, we need to consider only one neighbor.'),
(17, 'Single Element in a Sorted Array', 'Binary Search', 'Given a sorted array of integers A where every element appears twice except for one element which appears once, find and return this single element that appears only once.'),
(18, 'Matrix Median', 'Binary Search', 'Given a N cross M matrix in which each row is sorted, find the overall median of the matrix. Assume N*M is odd.'),
(19, 'Rotated Sorted Array Search', 'Binary Search', 'Suppose a sorted array is rotated at some pivot unknown to you beforehand. (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2 ). You are given a target value to search. If found in the array, return its index, otherwise return -1. You may assume no duplicate exists in the array.'),
(20, 'Kth Permutation Sequence', 'Backtracking', 'Given n and k, return the kth permutation sequence. '),
(21, 'Palindrome Partitioning', 'Backtracking', 'Given a string s, partition s such that every string of the partition is a palindrome. Return all possible palindrome partitioning of s.'),
(22, 'Number of Squareful Arrays', 'Backtracking', 'Given an array of integers A, the array is squareful if for every pair of adjacent elements, their sum is a perfect square. Find and return the number of permutations of A that are squareful. Two permutations A1 and A2 differ if and only if there is some index i such that A1[ i ] != A2[ i ].'),
(23, 'Combination Sum II', 'Backtracking', 'Given a collection of intervals, merge all overlapping intervals.');

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
(2, 2, 1, 1),
(3, 1, 2, 0),
(4, 2, 2, 1),
(5, 1, 3, -1),
(6, 2, 3, 0),
(7, 1, 4, 1),
(8, 2, 4, 1),
(9, 1, 5, -1),
(10, 2, 5, 1),
(11, 1, 6, 0),
(12, 2, 6, 1),
(13, 1, 7, 0),
(14, 2, 7, 0),
(15, 1, 8, -1),
(16, 2, 8, 0),
(17, 1, 9, 1),
(18, 2, 9, 0),
(19, 1, 10, -1),
(20, 2, 10, 0),
(21, 1, 11, 1),
(22, 2, 11, 0),
(23, 1, 12, -1),
(24, 2, 12, 0),
(25, 1, 13, -1),
(26, 2, 13, 0),
(27, 1, 14, 0),
(28, 2, 14, 0),
(29, 1, 15, 0),
(30, 2, 15, 0),
(31, 1, 16, 0),
(32, 2, 16, 0),
(33, 3, 17, 0),
(34, 4, 17, 0),
(35, 3, 18, 0),
(36, 4, 18, 0),
(37, 1, 19, 0),
(38, 2, 19, 0),
(39, 1, 20, 0),
(40, 2, 20, 0),
(41, 1, 21, 0),
(42, 2, 21, 0),
(43, 1, 22, 0),
(44, 2, 22, 0),
(45, 1, 23, 0),
(46, 2, 23, 0);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `company_table`
--
ALTER TABLE `company_table`
  MODIFY `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `company_wise_question`
--
ALTER TABLE `company_wise_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `question_table`
--
ALTER TABLE `question_table`
  MODIFY `q_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users_in_batches`
--
ALTER TABLE `users_in_batches`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_wise_question`
--
ALTER TABLE `user_wise_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
