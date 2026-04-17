SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS event_management_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE event_management_db;

DROP TABLE IF EXISTS contact_messages;
CREATE TABLE contact_messages (
  id int(11) NOT NULL,
  name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  message text NOT NULL,
  submitted_at timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS events;
CREATE TABLE `events` (
  id int(11) NOT NULL,
  title varchar(150) NOT NULL,
  description text NOT NULL,
  location varchar(200) NOT NULL,
  event_date date NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL,
  capacity int(11) NOT NULL DEFAULT 100,
  status enum('upcoming','ongoing','completed','cancelled') DEFAULT 'upcoming',
  created_by int(11) NOT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO events (id, title, description, location, event_date, start_time, end_time, capacity, status, created_by, created_at) VALUES
(1, 'Tech Summit 2026', 'Annual technology summit featuring talks on AI, web development and data science.', 'Kathmandu Convention Center', '2026-05-15', '09:00:00', '17:00:00', 200, 'upcoming', 1, '2026-04-15 11:50:19'),
(3, 'Startup Pitch Competition', 'Young entrepreneurs pitch their startup ideas to a panel of investors.', 'Islington College, Kamalpokhari', '2026-06-01', '10:00:00', '16:00:00', 150, 'upcoming', 1, '2026-04-15 11:50:19'),
(4, 'MESS x CCN - Tech Carnival 2026', 'School Collaboration', 'Thali, Kathmandu', '2026-04-19', '10:15:00', '12:16:00', 200, 'upcoming', 1, '2026-04-15 14:32:03');

DROP TABLE IF EXISTS event_registrations;
CREATE TABLE event_registrations (
  id int(11) NOT NULL,
  event_id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  registration_date timestamp NOT NULL DEFAULT current_timestamp(),
  status enum('confirmed','cancelled') DEFAULT 'confirmed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO event_registrations (id, event_id, user_id, registration_date, status) VALUES
(1, 1, 2, '2026-04-15 11:50:19', 'confirmed'),
(2, 1, 3, '2026-04-15 11:50:19', 'confirmed'),
(4, 3, 3, '2026-04-15 11:50:19', 'confirmed');

DROP TABLE IF EXISTS login_attempts;
CREATE TABLE login_attempts (
  id int(11) NOT NULL,
  email varchar(100) NOT NULL,
  attempt_time timestamp NOT NULL DEFAULT current_timestamp(),
  is_successful tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO login_attempts (id, email, attempt_time, is_successful) VALUES
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
(54, 'admin@eventflow.com', '2026-04-17 01:31:14', 1);

DROP TABLE IF EXISTS password_reset_tokens;
CREATE TABLE password_reset_tokens (
  id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  token varchar(255) NOT NULL,
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  expires_at datetime NOT NULL,
  is_used tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id int(11) NOT NULL,
  full_name varchar(100) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(20) NOT NULL,
  password varchar(255) NOT NULL,
  role enum('admin','attendee','volunteer','vendor') NOT NULL DEFAULT 'attendee',
  profile_image varchar(255) DEFAULT NULL,
  is_active tinyint(1) DEFAULT 1,
  is_locked tinyint(1) DEFAULT 0,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO users (id, full_name, email, phone, password, role, profile_image, is_active, is_locked, created_at) VALUES
(1, 'System Admin', 'admin@eventflow.com', '9800000000', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'admin', NULL, 1, 0, '2026-04-15 11:50:19'),
(2, 'Ram Sharma', 'ram@gmail.com', '9801111111', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'attendee', NULL, 1, 1, '2026-04-15 11:50:19'),
(3, 'Sita Thapa', 'sita@gmail.com', '9802222222', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'attendee', NULL, 1, 0, '2026-04-15 11:50:19'),
(4, 'Hari Karki', 'hari@gmail.com', '9803333333', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'volunteer', NULL, 1, 0, '2026-04-15 11:50:19'),
(5, 'Gita Rai', 'gita@gmail.com', '9804444444', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh7y', 'volunteer', NULL, 1, 0, '2026-04-15 11:50:19'),
(6, 'Sunrise Catering', 'sunrise@gmail.com', '9805555555', '$2a$10$OmpODgCuW1b7ifKU2z9dlO1VLcAFynJHO9xKX81V/Jwo3wcrkoVmi', 'vendor', NULL, 1, 0, '2026-04-15 11:50:19'),
(7, 'Nepal Decor', 'nepaldecor@gmail.com', '9806666666', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lh7y', 'vendor', NULL, 1, 0, '2026-04-15 11:50:19'),
(8, 'Bikram Tamang', 'createbikram@gmail.com', '9766562005', '$2a$10$Sjh61ETQmzC3P2IwadNjDegnGPYoOzMARhCtXLYiVTq0.ssQY8eZS', 'volunteer', NULL, 1, 0, '2026-04-15 14:18:35'),
(9, 'Central Cee', 'central@gmail.com', '9766562000', '$2a$10$y.nzMYybmMpAfVazeDnSp.3wtXnsNlAjRESCHo2pn3ZfUpuaRIrHW', 'attendee', NULL, 1, 0, '2026-04-17 01:00:18'),
(10, 'Bob Marley', 'bob@gmail.com', '9766500000', '$2a$10$qRZIhFarWVzc1sz8H6olJujJSZA2zFrN6HLyO8xHHP5vLlOzCh6FG', 'volunteer', NULL, 1, 0, '2026-04-17 01:07:56'),
(11, 'vendor', 'vendor@gmail.com', '9766561111', '$2a$10$BG0/FkcIetO1clNsY0GAn.i147YSU.1wes8oU8dI1PpaNLTa1EEzm', 'vendor', NULL, 1, 0, '2026-04-17 01:10:34');

DROP TABLE IF EXISTS vendor_applications;
CREATE TABLE vendor_applications (
  id int(11) NOT NULL,
  event_id int(11) NOT NULL,
  vendor_id int(11) NOT NULL,
  service_description text NOT NULL,
  status enum('pending','approved','rejected') DEFAULT 'pending',
  applied_at timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO vendor_applications (id, event_id, vendor_id, service_description, status, applied_at) VALUES
(1, 1, 6, 'Providing lunch and refreshments for 200 attendees', 'approved', '2026-04-15 11:50:19'),
(3, 3, 6, 'Snacks and drinks for participants and judges', 'pending', '2026-04-15 11:50:19');

DROP TABLE IF EXISTS volunteer_assignments;
CREATE TABLE volunteer_assignments (
  id int(11) NOT NULL,
  event_id int(11) NOT NULL,
  volunteer_id int(11) NOT NULL,
  assigned_at timestamp NOT NULL DEFAULT current_timestamp(),
  status enum('assigned','completed','removed') DEFAULT 'assigned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO volunteer_assignments (id, event_id, volunteer_id, assigned_at, status) VALUES
(1, 1, 4, '2026-04-15 11:50:19', 'assigned'),
(3, 3, 4, '2026-04-15 11:50:19', 'assigned');

DROP TABLE IF EXISTS volunteer_tasks;
CREATE TABLE volunteer_tasks (
  id int(11) NOT NULL,
  assignment_id int(11) NOT NULL,
  task_title varchar(150) NOT NULL,
  task_description text DEFAULT NULL,
  is_completed tinyint(1) DEFAULT 0,
  created_at timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT DELAYED IGNORE INTO volunteer_tasks (id, assignment_id, task_title, task_description, is_completed, created_at) VALUES
(1, 1, 'Registration Desk', 'Manage attendee check-in at the front desk', 0, '2026-04-15 11:50:19'),
(2, 1, 'Stage Setup', 'Assist with setting up the main stage before the event', 0, '2026-04-15 11:50:19'),
(4, 3, 'Logistics Support', 'Help with arranging chairs and tables in the hall', 0, '2026-04-15 11:50:19');


ALTER TABLE contact_messages
  ADD PRIMARY KEY (id);

ALTER TABLE events
  ADD PRIMARY KEY (id),
  ADD KEY created_by (created_by);

ALTER TABLE event_registrations
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY unique_registration (event_id,user_id),
  ADD KEY user_id (user_id);

ALTER TABLE login_attempts
  ADD PRIMARY KEY (id);

ALTER TABLE password_reset_tokens
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY token (token),
  ADD KEY user_id (user_id);

ALTER TABLE users
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY email (email),
  ADD UNIQUE KEY phone (phone);

ALTER TABLE vendor_applications
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY unique_application (event_id,vendor_id),
  ADD KEY vendor_id (vendor_id);

ALTER TABLE volunteer_assignments
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY unique_assignment (event_id,volunteer_id),
  ADD KEY volunteer_id (volunteer_id);

ALTER TABLE volunteer_tasks
  ADD PRIMARY KEY (id),
  ADD KEY assignment_id (assignment_id);


ALTER TABLE contact_messages
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE events
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE event_registrations
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

ALTER TABLE login_attempts
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

ALTER TABLE password_reset_tokens
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE users
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE vendor_applications
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE volunteer_assignments
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE volunteer_tasks
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;


ALTER TABLE events
  ADD CONSTRAINT events_ibfk_1 FOREIGN KEY (created_by) REFERENCES `users` (id);

ALTER TABLE event_registrations
  ADD CONSTRAINT event_registrations_ibfk_1 FOREIGN KEY (event_id) REFERENCES `events` (id),
  ADD CONSTRAINT event_registrations_ibfk_2 FOREIGN KEY (user_id) REFERENCES `users` (id);

ALTER TABLE password_reset_tokens
  ADD CONSTRAINT password_reset_tokens_ibfk_1 FOREIGN KEY (user_id) REFERENCES `users` (id);

ALTER TABLE vendor_applications
  ADD CONSTRAINT vendor_applications_ibfk_1 FOREIGN KEY (event_id) REFERENCES `events` (id),
  ADD CONSTRAINT vendor_applications_ibfk_2 FOREIGN KEY (vendor_id) REFERENCES `users` (id);

ALTER TABLE volunteer_assignments
  ADD CONSTRAINT volunteer_assignments_ibfk_1 FOREIGN KEY (event_id) REFERENCES `events` (id),
  ADD CONSTRAINT volunteer_assignments_ibfk_2 FOREIGN KEY (volunteer_id) REFERENCES `users` (id);

ALTER TABLE volunteer_tasks
  ADD CONSTRAINT volunteer_tasks_ibfk_1 FOREIGN KEY (assignment_id) REFERENCES volunteer_assignments (id);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
