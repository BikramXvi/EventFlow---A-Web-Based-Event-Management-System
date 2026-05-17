-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2026 at 10:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `event_management_db`
--
CREATE DATABASE IF NOT EXISTS `event_management_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `event_management_db`;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

DROP TABLE IF EXISTS `contact_messages`;
CREATE TABLE IF NOT EXISTS `contact_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`, `submitted_at`) VALUES
(1, 'Bikram Tamang', 'createbikram@gmail.com', 'adsf', 'asdf', '2026-05-03 13:27:42'),
(2, 'bikram', 'createbikram@gmail.com', 'adf', 'adfadf', '2026-05-16 15:46:52');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(300) DEFAULT NULL,
  `location` varchar(200) NOT NULL,
  `event_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `capacity` int(11) NOT NULL DEFAULT 100,
  `status` enum('upcoming','ongoing','completed','cancelled') DEFAULT 'upcoming',
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `image_path`, `location`, `event_date`, `start_time`, `end_time`, `capacity`, `status`, `created_by`, `created_at`) VALUES
(10, 'Music Fest KTM 2026', 'Three days of live music featuring 20+ bands from Nepal and India. Rock, jazz, folk, and electronic across four open-air stages at Tundikhel.', 'evt_003.jpg', 'Tundikhel, Kathmandu', '2026-05-20', '17:00:00', '23:00:00', 500, 'ongoing', 1, '2026-05-16 16:00:47'),
(11, 'Startup Expo Nepal', 'Meet 60+ Nepali startups, connect with investors, and attend pitch sessions across fintech, agritech, healthtech, and edtech sectors.', 'evt_004.jpg', 'Bhrikuti Mandap, Kathmandu', '2026-05-28', '09:00:00', '17:00:00', 300, 'upcoming', 1, '2026-05-16 16:00:47'),
(12, 'Photography Masterclass', 'Learn landscape and portrait photography with professional photographers from National Geographic Nepal. Bring your own camera. All skill levels welcome.', NULL, 'Patan Durbar Square, Lalitpur', '2026-06-03', '10:00:00', '16:00:00', 20, 'upcoming', 1, '2026-05-16 16:00:47'),
(13, 'Poets of Kathmandu', 'An evening of spoken word, poetry readings, and open mic performances in Nepali and English. A celebration of local literary voices.', NULL, 'Mandala Theatre, Kathmandu', '2026-06-08', '18:00:00', '21:00:00', 80, 'upcoming', 1, '2026-05-16 16:00:47'),
(14, 'Himalayan Trail Run 2026', '5km, 10km, and 21km trail running routes around the Shivapuri hills. Registration includes timing chip, race bib, and finisher medal.', NULL, 'Shivapuri National Park, Kathmandu', '2026-06-15', '06:00:00', '13:00:00', 150, 'upcoming', 1, '2026-05-16 16:00:47'),
(15, 'Nepal Food Festival', 'A three-day celebration of Nepali cuisine featuring 40+ food stalls, cooking demonstrations by top chefs, and cultural performances.', NULL, 'Ranipokhari Ground, Kathmandu', '2026-06-20', '11:00:00', '21:00:00', 1000, 'upcoming', 1, '2026-05-16 16:00:47'),
(16, 'Women in Tech Nepal', 'A full-day conference dedicated to celebrating and empowering women in technology. Keynotes, panels, workshops, and networking sessions.', NULL, 'Hotel Radisson, Lazimpat, Kathmandu', '2026-06-25', '09:00:00', '17:30:00', 120, 'upcoming', 1, '2026-05-16 16:00:47'),
(17, 'Yoga and Wellness Retreat', 'A weekend wellness retreat combining morning yoga, guided meditation, breathwork sessions, and nutrition workshops in a peaceful setting.', NULL, 'Nagarkot Hill Resort, Bhaktapur', '2026-07-05', '07:00:00', '19:00:00', 40, 'upcoming', 1, '2026-05-16 16:00:47'),
(18, 'Dance Battle - NP vs IND', 'India vs Nepal Dance Battle', 'evt_bf8474466410.jpg', 'Skate Park - Thali', '2026-05-19', '10:00:00', '01:59:00', 60, 'upcoming', 1, '2026-05-17 04:54:02'),
(20, 'Event', 'Description', 'evt_aab891fcbe9c.jpg', 'Kathmandu', '2026-05-22', '11:53:00', '11:47:00', 2, 'upcoming', 1, '2026-05-17 06:09:20');

-- --------------------------------------------------------

--
-- Table structure for table `event_registrations`
--

DROP TABLE IF EXISTS `event_registrations`;
CREATE TABLE IF NOT EXISTS `event_registrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('confirmed','cancelled') DEFAULT 'confirmed',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_registration` (`event_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_registrations`
--

INSERT INTO `event_registrations` (`id`, `event_id`, `user_id`, `registration_date`, `status`) VALUES
(9, 20, 18, '2026-05-17 06:10:53', 'cancelled');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `attempt_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_successful` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `email`, `attempt_time`, `is_successful`) VALUES
(1, 'createbikram@gmail.com', '2026-04-15 12:59:41', 0),
(2, 'admin@eventflow.com', '2026-04-15 13:00:34', 0),
(3, 'admin@eventflow.com', '2026-04-15 13:00:47', 0),
(4, 'admin@eventflow.com', '2026-04-15 13:04:00', 0),
(5, 'admin@eventflow.com', '2026-04-15 13:04:09', 1),
(6, 'admin@eventflow.com', '2026-04-15 13:06:37', 1),
(7, 'ram@gmail.com', '2026-04-15 13:11:06', 0),
(8, 'ram@gmail.com', '2026-04-15 13:11:13', 0),
(9, 'ram@gmail.com', '2026-04-15 13:12:16', 0),
(10, 'ram@gmail.com', '2026-04-15 13:12:20', 0),
(11, 'ram@gmail.com', '2026-04-15 13:12:23', 0),
(12, 'ram@gmail.com', '2026-04-15 13:12:28', 0),
(13, 'ram@gmail.com', '2026-04-15 13:13:15', 0),
(14, 'ram@gmail.com', '2026-04-15 13:13:18', 0),
(15, 'ram@gmail.com', '2026-04-15 13:13:21', 0),
(16, 'ram@gmail.com', '2026-04-15 13:13:38', 0),
(17, 'ram@gmail.com', '2026-04-15 13:13:44', 0),
(18, 'admin@eventflow.com', '2026-04-15 13:13:45', 1),
(19, 'ram@gmail.com', '2026-04-15 13:13:58', 0),
(20, 'ram@gmail.com', '2026-04-15 13:14:18', 0),
(21, 'ram@gmail.com', '2026-04-15 13:14:43', 0),
(22, 'ram@gmail.com', '2026-04-15 13:14:47', 0),
(23, 'ram@gmail.com', '2026-04-15 13:14:58', 0),
(24, 'ram@gmail.com', '2026-04-15 13:15:07', 0),
(25, 'ram@gmail.com', '2026-04-15 13:17:19', 0),
(26, 'admin@eventflow.com', '2026-04-15 13:17:23', 1),
(27, 'ram@gmail.com', '2026-04-15 13:18:26', 0),
(28, 'ram@gmail.com', '2026-04-15 13:18:38', 0),
(29, 'ram@gmail.com', '2026-04-15 13:20:31', 0),
(30, 'ram@gmail.com', '2026-04-15 13:20:37', 0),
(31, 'ram@gmail.com', '2026-04-15 13:21:32', 0),
(32, 'sita@gmail.com', '2026-04-15 13:21:43', 1),
(33, 'ram@gmail.com', '2026-04-15 13:21:58', 0),
(34, 'createbikram@gmail.com', '2026-04-15 14:18:38', 1),
(35, 'createbikram@gmail.com', '2026-04-15 14:21:27', 1),
(36, 'admin@eventflow.com', '2026-04-15 14:30:26', 1),
(37, 'admin@eventflow.com', '2026-04-15 14:30:45', 1),
(38, 'admin@eventflow.com', '2026-04-15 15:26:21', 1),
(39, 'admin@eventflow.com', '2026-04-15 16:38:10', 1),
(40, 'admin@eventflow.com', '2026-04-16 03:19:36', 1),
(41, 'admin@eventflow.com', '2026-04-16 03:20:10', 1),
(42, 'admin@eventflow.com', '2026-04-16 04:18:58', 1),
(43, 'admin@eventflow.com', '2026-04-17 00:58:08', 1),
(44, 'central@gmail.com', '2026-04-17 01:00:24', 1),
(45, 'central@gmail.com', '2026-04-17 01:06:35', 1),
(46, 'bob@gmail.com', '2026-04-17 01:07:59', 1),
(47, 'bob@gmail.com', '2026-04-17 01:10:38', 1),
(48, 'vendor@gmail.com', '2026-04-17 01:10:43', 1),
(49, 'admin@eventflow.com', '2026-04-17 01:11:50', 1),
(50, 'admin@eventflow.com', '2026-04-17 01:12:32', 1),
(51, 'central@gmail.com', '2026-04-17 01:30:15', 1),
(52, 'bob@gmail.com', '2026-04-17 01:30:34', 1),
(53, 'vendor@gmail.com', '2026-04-17 01:30:47', 1),
(54, 'admin@eventflow.com', '2026-04-17 01:31:14', 1),
(55, 'admin@eventflow.com', '2026-04-17 03:20:31', 1),
(56, 'central@gmail.com', '2026-04-17 03:20:51', 1),
(57, 'admin@eventflow.com', '2026-04-17 03:22:15', 1),
(58, 'admin@eventflow.com', '2026-04-17 03:24:16', 1),
(59, 'admin@eventflow.com', '2026-04-17 03:24:19', 1),
(60, 'admin@eventflow.com', '2026-04-17 03:27:32', 1),
(61, 'admin@eventflow.com', '2026-05-03 10:50:13', 1),
(62, 'superadmin@demo.com', '2026-05-03 10:51:17', 0),
(63, 'superadmin@demo.com', '2026-05-03 10:51:21', 0),
(64, 'vendor@gmail.com', '2026-05-03 10:51:23', 1),
(65, 'neha@gmail.com', '2026-05-03 10:51:42', 0),
(66, 'neha@gmail.com', '2026-05-03 10:51:45', 0),
(67, 'central@gmail.com', '2026-05-03 10:51:48', 1),
(68, 'bob@gmail.com', '2026-05-03 10:52:07', 1),
(69, 'createbikram@gmail.com', '2026-05-03 10:52:23', 1),
(70, 'createbikram@gmail.com', '2026-05-03 10:54:19', 1),
(71, 'admin@gmail.com', '2026-05-03 10:54:30', 0),
(72, 'admin@eventflow.com', '2026-05-03 10:54:36', 1),
(73, 'admin@eventflow.com', '2026-05-03 11:00:30', 1),
(74, 'admin@eventflow.com', '2026-05-03 11:01:56', 1),
(75, 'bob@gmail.com', '2026-05-03 11:02:04', 1),
(76, 'neha@gmail.com', '2026-05-03 11:02:20', 0),
(77, 'vendor@gmail.com', '2026-05-03 11:02:24', 1),
(78, 'vendor@gmail.com', '2026-05-03 12:16:35', 1),
(79, 'vendor@gmail.com', '2026-05-03 12:17:04', 1),
(80, 'admin@eventflow.com', '2026-05-03 12:19:22', 1),
(81, 'admin@eventflow.com', '2026-05-03 12:34:21', 1),
(82, 'admin@eventflow.com', '2026-05-03 12:52:50', 1),
(83, 'admin@eventflow.com', '2026-05-03 12:53:45', 1),
(84, 'admin@eventflow.com', '2026-05-03 12:56:20', 1),
(85, 'admin@eventflow.com', '2026-05-03 13:10:02', 1),
(86, 'vendor@gmail.com', '2026-05-03 13:14:08', 1),
(87, 'vendor@gmail.com', '2026-05-03 13:21:36', 1),
(88, 'vendor@gmail.com', '2026-05-03 13:28:12', 1),
(89, 'admin@gmail.com', '2026-05-03 13:28:19', 0),
(90, 'admin@eventflow.com', '2026-05-03 13:28:25', 1),
(91, 'bob@gmail.com', '2026-05-03 13:29:25', 1),
(92, 'central@gmail.com', '2026-05-03 13:29:38', 1),
(93, 'createbikram@gmail.com', '2026-05-03 13:29:54', 1),
(94, 'bob@gmail.com', '2026-05-03 13:30:49', 1),
(95, 'createbikram@gmail.com', '2026-05-03 13:30:59', 1),
(96, 'central@gmail.com', '2026-05-03 13:31:05', 1),
(97, 'createbikram@gmail.com', '2026-05-03 14:01:58', 1),
(98, 'createbikram@gmail.com', '2026-05-03 14:02:32', 1),
(99, 'admin@eventflow.com', '2026-05-03 14:02:40', 1),
(100, 'admin@eventflow.com', '2026-05-03 14:08:21', 1),
(101, 'central@gmail.com', '2026-05-03 14:25:23', 1),
(102, 'central@gmail.com', '2026-05-03 14:27:34', 1),
(103, 'central@gmail.com', '2026-05-03 14:33:11', 1),
(104, 'createbikram@gmail.com', '2026-05-03 14:33:19', 1),
(105, 'createbikram@gmail.com', '2026-05-03 14:36:37', 1),
(106, 'bob@gmail.com', '2026-05-03 14:37:00', 1),
(107, 'central@gmail.com', '2026-05-03 14:37:13', 1),
(108, 'central@gmail.com', '2026-05-03 14:40:05', 1),
(109, 'central@gmail.com', '2026-05-03 15:29:52', 1),
(110, 'central@gmail.com', '2026-05-03 15:29:59', 1),
(111, 'admin@eventflow.com', '2026-05-03 16:26:36', 1),
(112, 'bob@gmail.com', '2026-05-03 16:26:58', 1),
(113, 'vendor@gmail.com', '2026-05-03 16:27:09', 1),
(114, 'central@gmail.com', '2026-05-03 16:27:36', 1),
(115, 'bikram@gmail.com', '2026-05-04 03:41:34', 0),
(116, 'bikram@gmail.com', '2026-05-04 03:41:41', 0),
(117, 'admin@eventflow.com', '2026-05-04 03:42:10', 1),
(118, 'vendor@gmail.com', '2026-05-04 03:42:54', 1),
(119, 'bob@gmail.com', '2026-05-04 03:43:21', 1),
(120, 'central@gmail.com', '2026-05-04 03:43:41', 1),
(121, 'admin@demo.com', '2026-05-04 06:49:35', 0),
(122, 'admin@demo.com', '2026-05-04 06:49:39', 0),
(123, 'admin@demo.com', '2026-05-04 06:49:42', 0),
(124, 'admin@eventflow.com', '2026-05-04 06:49:47', 1),
(125, 'admin@eventflow.com', '2026-05-04 07:41:18', 1),
(126, 'central@gmail.com', '2026-05-04 07:41:39', 1),
(127, 'bob@gmail.com', '2026-05-04 07:41:57', 1),
(128, 'vendor@gmail.com', '2026-05-04 07:42:11', 1),
(129, 'admin@eventflow.com', '2026-05-04 07:42:33', 1),
(130, 'admin@eventflow.com', '2026-05-04 07:45:39', 0),
(131, 'admin@eventflow.com', '2026-05-04 07:45:42', 0),
(132, 'admin@eventflow.com', '2026-05-04 07:45:44', 0),
(133, 'admin@eventflow.com', '2026-05-04 07:45:47', 0),
(134, 'admin@eventflow.com', '2026-05-04 07:45:49', 0),
(135, 'central@gmail.com', '2026-05-04 07:49:17', 1),
(136, 'central@gmail.com', '2026-05-04 08:18:35', 1),
(137, 'bob@gmail.com', '2026-05-04 08:19:13', 1),
(138, 'vendor@gmail.com', '2026-05-04 08:19:24', 1),
(139, 'admin@demo.com', '2026-05-04 11:18:29', 0),
(140, 'bob@gmail.com', '2026-05-04 11:18:43', 1),
(141, 'bob@gmail.com', '2026-05-07 04:28:35', 1),
(142, 'admin@eventflow.com', '2026-05-07 04:30:23', 1),
(143, 'central@gmail.com', '2026-05-07 04:31:23', 1),
(144, 'admin@eventflow.com', '2026-05-07 04:34:31', 1),
(145, 'createbikram@gmail.com', '2026-05-07 04:39:52', 1),
(146, 'createbikram@gmail.com', '2026-05-07 04:40:06', 1),
(147, 'admin@eventflow.com', '2026-05-16 04:25:39', 1),
(148, 'admin@eventflow.com', '2026-05-16 04:25:54', 1),
(149, 'admin@eventflow.com', '2026-05-16 04:26:22', 1),
(150, 'bob@gmail.com', '2026-05-16 04:27:25', 1),
(151, 'bob@gmail.com', '2026-05-16 04:33:46', 1),
(152, 'bob@gmail.com', '2026-05-16 04:33:50', 1),
(153, 'bob@gmail.com', '2026-05-16 04:33:50', 1),
(154, 'bob@gmail.com', '2026-05-16 04:42:07', 1),
(155, 'bob@gmail.com', '2026-05-16 04:42:57', 1),
(156, 'bob@gmail.com', '2026-05-16 04:43:02', 1),
(157, 'bob@gmail.com', '2026-05-16 04:43:51', 1),
(158, 'superadmin@demo.com', '2026-05-16 04:45:42', 0),
(159, 'admin@gmail.com', '2026-05-16 04:45:45', 0),
(160, 'admin@demo.com', '2026-05-16 04:45:47', 0),
(161, 'vendor@gmail.com', '2026-05-16 04:45:50', 1),
(162, 'admin@eventflow.com', '2026-05-16 04:46:05', 1),
(163, 'admin@eventflow.com', '2026-05-16 04:46:53', 1),
(164, 'admin@eventflow.com', '2026-05-16 04:48:30', 1),
(165, 'admin@eventflow.com', '2026-05-16 04:49:52', 1),
(166, 'admin@eventflow.com', '2026-05-16 04:51:08', 1),
(167, 'bob@gmail.com', '2026-05-16 04:51:28', 1),
(168, 'central@gmail.com', '2026-05-16 04:51:38', 1),
(169, 'central@gmail.com', '2026-05-16 12:52:18', 1),
(170, 'admin@eventflow.com', '2026-05-16 12:52:32', 1),
(171, 'admin@eventflow.com', '2026-05-16 13:14:38', 1),
(172, 'admin@eventflow.com', '2026-05-16 13:16:43', 1),
(173, 'admin@eventflow.com', '2026-05-16 14:01:00', 1),
(174, 'admin@eventflow.com', '2026-05-16 14:01:41', 1),
(175, 'bob@gmail.com', '2026-05-16 14:01:50', 1),
(176, 'bob@gmail.com', '2026-05-16 14:02:07', 1),
(177, 'central@gmail.com', '2026-05-16 14:02:15', 1),
(178, 'admin@eventflow.com', '2026-05-16 14:06:08', 1),
(179, 'bob@gmail.com', '2026-05-16 14:20:25', 1),
(180, 'bob@gmail.com', '2026-05-16 15:06:17', 1),
(181, 'admin@eventflow.com', '2026-05-16 15:06:42', 1),
(182, 'vendor@gmail.com', '2026-05-16 15:07:30', 1),
(183, 'vendor@gmail.com', '2026-05-16 15:13:52', 1),
(184, 'vendor@gmail.com', '2026-05-16 15:15:11', 1),
(185, 'vendor@gmail.com', '2026-05-16 15:16:39', 1),
(186, 'vendor@gmail.com', '2026-05-16 15:24:06', 1),
(187, 'vendor@gmail.com', '2026-05-16 15:29:31', 1),
(188, 'admin@eventflow.com', '2026-05-16 15:29:44', 1),
(189, 'vendor@gmail.com', '2026-05-16 15:33:09', 1),
(190, 'admin@eventflow.com', '2026-05-16 15:34:14', 0),
(191, 'admin@eventflow.com', '2026-05-16 15:34:23', 1),
(192, 'admin@eventflow.com', '2026-05-16 15:35:34', 1),
(193, 'admin@eventflow.com', '2026-05-16 15:37:21', 1),
(194, 'vendor@gmail.com', '2026-05-16 15:38:35', 1),
(195, 'admin@eventflow.com', '2026-05-16 15:39:41', 1),
(196, 'bob@gmail.com', '2026-05-16 15:39:58', 1),
(197, 'bob@gmail.com', '2026-05-16 15:41:17', 1),
(198, 'admin@eventflow.com', '2026-05-16 15:44:27', 1),
(199, 'admin@eventflow.com', '2026-05-16 15:47:01', 1),
(200, 'admin@eventflow.com', '2026-05-16 15:58:45', 1),
(201, 'admin@eventflow.com', '2026-05-16 16:02:48', 1),
(202, 'admin@eventflow.com', '2026-05-16 16:03:17', 1),
(203, 'admin@eventflow.com', '2026-05-16 16:07:37', 1),
(204, 'admin@eventflow.com', '2026-05-16 16:10:36', 1),
(205, 'admin@eventflow.com', '2026-05-16 16:15:54', 1),
(206, 'admin@eventflow.com', '2026-05-16 16:17:16', 1),
(207, 'admin@eventflow.com', '2026-05-16 16:17:20', 1),
(208, 'admin@eventflow.com', '2026-05-16 16:19:50', 1),
(209, 'admin@eventflow.com', '2026-05-16 16:21:46', 1),
(210, 'admin@eventflow.com', '2026-05-16 16:22:38', 1),
(211, 'admin@eventflow.com', '2026-05-16 16:29:01', 1),
(212, 'admin@eventflow.com', '2026-05-16 16:29:44', 1),
(213, 'admin@eventflow.com', '2026-05-16 16:32:20', 1),
(214, 'admin@eventflow.com', '2026-05-16 16:34:29', 1),
(215, 'admin@eventflow.com', '2026-05-16 16:34:52', 1),
(216, 'admin@eventflow.com', '2026-05-16 16:44:06', 1),
(217, 'admin@eventflow.com', '2026-05-16 16:46:14', 1),
(218, 'admin@eventflow.com', '2026-05-16 16:46:36', 1),
(219, 'admin@eventflow.com', '2026-05-16 16:46:56', 1),
(220, 'admin@eventflow.com', '2026-05-16 16:50:38', 1),
(221, 'admin@eventflow.com', '2026-05-16 16:54:17', 1),
(222, 'admin@eventflow.com', '2026-05-16 16:57:49', 1),
(223, 'admin@eventflow.com', '2026-05-16 17:01:47', 1),
(224, 'admin@eventflow.com', '2026-05-16 17:02:07', 1),
(225, 'admin@eventflow.com', '2026-05-16 17:05:51', 1),
(226, 'admin@eventflow.com', '2026-05-16 17:07:24', 1),
(227, 'admin@eventflow.com', '2026-05-16 17:13:43', 1),
(228, 'admin@eventflow.com', '2026-05-16 17:17:05', 1),
(229, 'admin@eventflow.com', '2026-05-16 17:17:46', 1),
(230, 'admin@eventflow.com', '2026-05-16 17:17:53', 1),
(231, 'admin@eventflow.com', '2026-05-16 17:18:41', 1),
(232, 'admin@eventflow.com', '2026-05-16 17:19:35', 1),
(233, 'admin@eventflow.com', '2026-05-16 17:19:50', 1),
(234, 'central@gmail.com', '2026-05-16 17:25:48', 1),
(235, 'central@gmail.com', '2026-05-16 17:27:12', 1),
(236, 'admin@eventflow.com', '2026-05-17 02:15:22', 1),
(237, 'admin@eventflow.com', '2026-05-17 02:18:27', 1),
(238, 'admin@eventflow.com', '2026-05-17 02:31:57', 1),
(239, 'central@gmail.com', '2026-05-17 02:32:10', 1),
(240, 'central@gmail.com', '2026-05-17 02:32:16', 1),
(241, 'vendor@gmail.com', '2026-05-17 02:32:22', 1),
(242, 'vendor@gmail.com', '2026-05-17 02:34:09', 1),
(243, 'central@gmail.com', '2026-05-17 02:34:21', 1),
(244, 'admin@eventflow.com', '2026-05-17 02:34:29', 1),
(245, 'createbikram@gmail.com', '2026-05-17 02:34:42', 1),
(246, 'admin@eventflow.com', '2026-05-17 02:54:07', 1),
(247, 'admin@eventflow.com', '2026-05-17 03:21:14', 1),
(248, 'central@gmail.com', '2026-05-17 03:21:40', 1),
(249, 'bob@gmail.com', '2026-05-17 03:21:57', 1),
(250, 'vendor@gmail.com', '2026-05-17 03:22:12', 1),
(251, 'admin@eventflow.com', '2026-05-17 03:23:14', 1),
(252, 'admin@eventflow.com', '2026-05-17 03:25:47', 1),
(253, 'admin@eventflow.com', '2026-05-17 03:25:53', 1),
(254, 'admin@eventflow.com', '2026-05-17 04:37:55', 1),
(255, 'admin@eventflow.com', '2026-05-17 04:38:05', 1),
(256, 'superadmin@demo.com', '2026-05-17 04:39:17', 0),
(257, 'admin@eventflow.com', '2026-05-17 04:39:35', 1),
(258, 'central@gmail.com', '2026-05-17 04:48:05', 1),
(259, 'admin@eventflow.com', '2026-05-17 04:48:25', 1),
(260, 'central@gmail.com', '2026-05-17 04:48:35', 1),
(261, 'central@gmail.com', '2026-05-17 04:49:42', 1),
(262, 'admin@eventflow.com', '2026-05-17 04:49:48', 1),
(263, 'admin@eventflow.com', '2026-05-17 05:53:37', 0),
(264, 'admin@eventflow.com', '2026-05-17 05:56:06', 1),
(265, 'central@gmail.com', '2026-05-17 05:56:52', 1),
(266, 'neha@gmail.com', '2026-05-17 05:57:09', 0),
(267, 'central@gmail.com', '2026-05-17 05:57:12', 1),
(268, 'central@gmail.com', '2026-05-17 05:57:54', 1),
(269, 'bob@gmail.com', '2026-05-17 05:58:06', 1),
(270, 'admin@eventflow.com', '2026-05-17 05:59:25', 1),
(271, 'admin@eventflow.com', '2026-05-17 06:03:51', 1),
(272, 'admin@eventflow.com', '2026-05-17 06:04:46', 1),
(273, 'hritik@gmail.com', '2026-05-17 06:05:16', 1),
(274, 'ram@gmail.com', '2026-05-17 06:06:13', 1),
(275, 'admin@gmail.com', '2026-05-17 06:07:59', 0),
(276, 'admin@eventflow.com', '2026-05-17 06:08:02', 1),
(277, 'hritik@gmail.com', '2026-05-17 06:10:47', 1),
(278, 'ram@gmail.com', '2026-05-17 06:13:05', 0),
(279, 'ram@gmail.com', '2026-05-17 06:13:13', 0),
(280, 'ram@gmail.com', '2026-05-17 06:13:18', 0),
(281, 'ram@gmail.com', '2026-05-17 06:13:50', 0),
(282, 'ram@gmail.com', '2026-05-17 06:13:54', 0),
(283, 'admin@eventflow.com', '2026-05-17 06:14:19', 1),
(284, 'central@gmail.com', '2026-05-17 06:24:05', 1),
(285, 'bob@gmail.com', '2026-05-17 06:25:17', 1),
(286, 'hritik@gmail.com', '2026-05-17 06:25:26', 1),
(287, 'bob@gmail.com', '2026-05-17 06:26:21', 1),
(288, 'central@gmail.com', '2026-05-17 06:28:26', 1),
(289, 'bob@gmail.com', '2026-05-17 06:28:31', 1),
(290, 'admin@gmail.com', '2026-05-17 06:29:43', 0),
(291, 'admin@eventflow.com', '2026-05-17 06:29:46', 1),
(292, 'admin@eventflow.com', '2026-05-17 06:30:30', 1),
(293, 'admin@gmail.com', '2026-05-17 06:31:08', 0),
(294, 'admin@eventflow.com', '2026-05-17 06:31:10', 1),
(295, 'hritik@gmail.com', '2026-05-17 06:31:31', 1),
(296, 'admin@gmail.com', '2026-05-17 06:35:14', 0),
(297, 'admin@eventflow.com', '2026-05-17 06:35:16', 1),
(298, 'admin@eventflow.com', '2026-05-17 06:38:41', 1),
(299, 'hritik@gmail.com', '2026-05-17 06:41:52', 1),
(300, 'admin@eventflow.com', '2026-05-17 06:46:09', 1),
(301, 'bob@gmail.com', '2026-05-17 06:47:44', 1),
(302, 'central@gmail.com', '2026-05-17 06:47:48', 1),
(303, 'bob@gmail.com', '2026-05-17 06:49:14', 1),
(304, 'admin@gmail.com', '2026-05-17 06:49:29', 0),
(305, 'admin@eventflow.com', '2026-05-17 06:49:32', 1),
(306, 'admin@eventflow.com', '2026-05-17 06:49:50', 1),
(307, 'bob@gmail.com', '2026-05-17 06:49:57', 1),
(308, 'vendor@gmail.com', '2026-05-17 06:51:26', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime NOT NULL,
  `is_used` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','attendee','volunteer','vendor') NOT NULL DEFAULT 'attendee',
  `profile_image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `is_locked` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `role`, `profile_image`, `is_active`, `is_locked`, `created_at`) VALUES
(1, 'System Admin', 'admin@eventflow.com', '9800000000', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'admin', NULL, 1, 0, '2026-04-15 11:50:19'),
(2, 'Ram Sharma', 'ram@gmail.com', '9801111111', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'attendee', NULL, 1, 0, '2026-04-15 11:50:19'),
(3, 'Sita Thapa', 'sita@gmail.com', '9802222222', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'attendee', NULL, 1, 0, '2026-04-15 11:50:19'),
(4, 'Hari Karki', 'hari@gmail.com', '9803333333', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'volunteer', NULL, 1, 0, '2026-04-15 11:50:19'),
(5, 'Gita Rai', 'gita@gmail.com', '9804444444', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh7y', 'volunteer', NULL, 1, 0, '2026-04-15 11:50:19'),
(6, 'Sunrise Catering', 'sunrise@gmail.com', '9805555555', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'vendor', NULL, 1, 0, '2026-04-15 11:50:19'),
(7, 'Nepal Decor', 'nepaldecor@gmail.com', '9806666666', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh7y', 'vendor', NULL, 1, 0, '2026-04-15 11:50:19'),
(8, 'Bikram Tamang', 'createbikram@gmail.com', '9766562005', '$2a$10$Sjh61ETQmzC3P2IwadNjDegnGPYoOzMARhCtXLYiVTq0.ssQY8eZS', 'volunteer', NULL, 1, 0, '2026-04-15 14:18:35'),
(9, 'Central Cee', 'central@gmail.com', '9766562000', '$2a$10$y.nzMYybmMpAfVazeDnSp.3wtXnsNlAjRESCHo2pn3ZfUpuaRIrHW', 'attendee', NULL, 1, 0, '2026-04-17 01:00:18'),
(10, 'Bob Marley', 'bob@gmail.com', '9766500000', '$2a$10$qRZIhFarWVzc1sz8H6olJujJSZA2zFrN6HLyO8xHHP5vLlOzCh6FG', 'volunteer', NULL, 1, 0, '2026-04-17 01:07:56'),
(11, 'vendor', 'vendor@gmail.com', '9766561111', '$2a$10$BG0/FkcIetO1clNsY0GAn.i147YSU.1wes8oU8dI1PpaNLTa1EEzm', 'vendor', NULL, 1, 0, '2026-04-17 01:10:34'),
(18, 'Hritik Roshan', 'hritik@gmail.com', '9766562001', '$2a$10$BYZPvANKHZuGy1xiKY4ua.QIwzbNpBaMYcS6Q1DwnG7v2cgmuHMZ6', 'attendee', NULL, 1, 0, '2026-05-17 06:05:14');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_applications`
--

DROP TABLE IF EXISTS `vendor_applications`;
CREATE TABLE IF NOT EXISTS `vendor_applications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  `service_description` text NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_application` (`event_id`,`vendor_id`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor_applications`
--

INSERT INTO `vendor_applications` (`id`, `event_id`, `vendor_id`, `service_description`, `status`, `applied_at`) VALUES
(7, 10, 11, 'Providing Proper food stalls for 250 people with proper hygeine.', 'pending', '2026-05-17 06:51:53');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer_assignments`
--

DROP TABLE IF EXISTS `volunteer_assignments`;
CREATE TABLE IF NOT EXISTS `volunteer_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `volunteer_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('assigned','completed','removed') DEFAULT 'assigned',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_assignment` (`event_id`,`volunteer_id`),
  KEY `volunteer_id` (`volunteer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `volunteer_assignments`
--

INSERT INTO `volunteer_assignments` (`id`, `event_id`, `volunteer_id`, `assigned_at`, `status`) VALUES
(10, 18, 10, '2026-05-17 06:49:38', 'assigned');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer_tasks`
--

DROP TABLE IF EXISTS `volunteer_tasks`;
CREATE TABLE IF NOT EXISTS `volunteer_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_id` int(11) NOT NULL,
  `task_title` varchar(150) NOT NULL,
  `task_description` text DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `assignment_id` (`assignment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `volunteer_tasks`
--

INSERT INTO `volunteer_tasks` (`id`, `assignment_id`, `task_title`, `task_description`, `is_completed`, `created_at`) VALUES
(10, 10, 'Stage Setup & Management', '', 0, '2026-05-17 06:49:44');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Constraints for table `event_registrations`
--
ALTER TABLE `event_registrations`
  ADD CONSTRAINT `event_registrations_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `event_registrations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `vendor_applications`
--
ALTER TABLE `vendor_applications`
  ADD CONSTRAINT `vendor_applications_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `vendor_applications_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `volunteer_assignments`
--
ALTER TABLE `volunteer_assignments`
  ADD CONSTRAINT `volunteer_assignments_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `volunteer_assignments_ibfk_2` FOREIGN KEY (`volunteer_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `volunteer_tasks`
--
ALTER TABLE `volunteer_tasks`
  ADD CONSTRAINT `volunteer_tasks_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `volunteer_assignments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
