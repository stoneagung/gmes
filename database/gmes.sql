-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2021 at 01:11 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gmes`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getMenuName` (`p_id` VARCHAR(7)) RETURNS VARCHAR(20) CHARSET utf8mb4 BEGIN
	DECLARE name varchar(20);
    DECLARE cnt INT;
        
    SELECT a.group_name, COUNT(*)
        INTO name, cnt
    FROM msbs_group_menu a 
    WHERE 1=1
        AND a.group_id = p_id
    #GROUP BY a.group_name
    ;
    
    IF cnt = 0 THEN
        SELECT a.menu_name INTO name
        FROM msbs_menu a
        WHERE 1=1
        	AND a.menu_id = p_id
        ;
    END IF;
    
    RETURN name;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `msbs_group_menu`
--

CREATE TABLE `msbs_group_menu` (
  `group_id` char(7) NOT NULL,
  `group_name` varchar(20) NOT NULL,
  `group_description` text NOT NULL,
  `group_status` char(1) DEFAULT 'Y',
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `msbs_group_menu`
--

INSERT INTO `msbs_group_menu` (`group_id`, `group_name`, `group_description`, `group_status`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('gid_001', 'Production', 'Production', 'Y', 'admin', '2021-05-15 21:47:57', '', NULL),
('gid_002', 'Semi Good', 'Semi Good', 'Y', 'admin', '2021-05-15 21:47:57', '', NULL),
('gid_003', 'Finish Good', '', 'Y', 'admin', '2021-05-15 21:48:41', '', NULL),
('gid_004', 'Export', '', 'Y', 'admin', '2021-05-15 21:48:41', '', NULL),
('gid_005', 'Cross Check', 'Cross Check', 'Y', 'admin', '2021-05-15 21:49:37', '', NULL),
('gid_006', 'Inventory', 'Inventory', 'Y', 'admin', '2021-05-15 21:49:37', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `msbs_menu`
--

CREATE TABLE `msbs_menu` (
  `menu_id` char(7) NOT NULL,
  `menu_name` varchar(20) NOT NULL,
  `menu_description` text NOT NULL,
  `menu_status` char(1) NOT NULL DEFAULT 'Y',
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `msbs_menu`
--

INSERT INTO `msbs_menu` (`menu_id`, `menu_name`, `menu_description`, `menu_status`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('mid_001', 'P-O Cross Check', 'P-O Cross Check', 'Y', 'admin', '2021-05-15 21:41:31', '', '2021-05-15 16:41:19'),
('mid_002', 'O-I Cross Check', 'O-I Cross Check', 'Y', 'admin', '2021-05-15 21:42:16', '', '2021-05-15 16:41:47'),
('mid_003', 'T-P Cross Check', 'T-P Cross Check', 'Y', 'admin', '2021-05-15 21:43:51', '', NULL),
('mid_004', 'SG Inventory', 'SG Inventory', 'Y', 'admin', '2021-05-15 21:43:51', '', NULL),
('mid_005', 'FG Inventory', 'FG Inventory', 'Y', 'admin', '2021-05-15 21:45:19', '', NULL),
('mid_006', 'In Out Report', 'In Out Report', 'Y', 'admin', '2021-05-15 21:45:19', '', NULL),
('mid_007', 'Status By GAC Size', 'Status By GAC Size', 'Y', 'admin', '2021-05-15 21:46:11', '', NULL),
('mid_008', 'Status By UCC', 'Status By UCC', 'Y', 'admin', '2021-05-15 21:46:11', '', NULL),
('mid_009', 'In Out Rack', 'In Out Rack', 'Y', 'admin', '2021-05-15 21:46:38', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `msbs_menu_role`
--

CREATE TABLE `msbs_menu_role` (
  `mrole_id` char(8) NOT NULL,
  `role_id` char(6) NOT NULL,
  `tree_id` char(7) NOT NULL,
  `role_status` char(1) NOT NULL DEFAULT 'Y',
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `msbs_menu_role`
--

INSERT INTO `msbs_menu_role` (`mrole_id`, `role_id`, `tree_id`, `role_status`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('mrid_001', 'rid_01', 'trid_01', 'Y', 'admin', '2021-05-30 20:01:39', NULL, NULL),
('mrid_002', 'rid_01', 'trid_02', 'Y', 'admin', '2021-05-30 20:01:39', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `msbs_tree_menu`
--

CREATE TABLE `msbs_tree_menu` (
  `tree_id` char(7) NOT NULL,
  `parent_id` char(7) NOT NULL,
  `child_id1` char(7) NOT NULL,
  `child_id2` char(7) NOT NULL,
  `child_id3` char(7) NOT NULL,
  `child_id4` char(7) NOT NULL,
  `child_id5` char(7) NOT NULL,
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `msbs_tree_menu`
--

INSERT INTO `msbs_tree_menu` (`tree_id`, `parent_id`, `child_id1`, `child_id2`, `child_id3`, `child_id4`, `child_id5`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('trid_01', 'gid_001', 'gid_002', 'gid_005', 'mid_001', '', '', 'admin', '2021-05-16 14:16:26', '', NULL),
('trid_02', 'gid_001', 'gid_002', 'gid_005', 'mid_002', '', '', 'admin', '2021-05-16 14:16:26', '', NULL),
('trid_03', 'gid_001', 'gid_002', 'gid_005', 'mid_003', '', '', 'admin', '2021-05-16 14:18:29', '', NULL),
('trid_04', 'gid_001', 'gid_006', 'mid_004', '', '', '', 'admin', '2021-05-16 14:18:29', '', NULL),
('trid_05', 'gid_001', 'gid_006', 'mid_005', '', '', '', 'admin', '2021-05-16 14:23:24', '', NULL),
('trid_06', 'gid_004', 'mid_006', '', '', '', '', 'admin', '2021-05-16 14:23:24', '', NULL),
('trid_07', 'gid_004', 'mid_007', '', '', '', '', 'admin', '2021-05-16 14:23:24', '', NULL),
('trid_08', 'gid_004', 'mid_008', '', '', '', '', 'admin', '2021-05-16 14:23:24', '', NULL),
('trid_09', 'gid_004', 'mid_009', '', '', '', '', 'admin', '2021-05-16 14:23:24', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `tree_menu`
-- (See below for the actual view)
--
CREATE TABLE `tree_menu` (
`tree_id` char(7)
,`parent` varchar(20)
,`child1` varchar(20)
,`child2` varchar(20)
,`child3` varchar(20)
,`child4` varchar(20)
,`child5` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` varchar(12) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role_id` char(6) NOT NULL DEFAULT 'uid_02',
  `user_status` char(1) NOT NULL DEFAULT 'Y',
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `role_id`, `user_status`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('admin', 'Administrator', '1', 'rid_01', 'Y', '', '2021-05-14 17:35:26', '', '2021-05-14 17:35:26'),
('user', 'Guest', '2', 'rid_02', 'Y', '', '2021-05-14 17:35:58', '', '2021-05-14 17:35:58');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `role_id` char(6) NOT NULL,
  `role_name` varchar(20) NOT NULL,
  `role_description` text NOT NULL,
  `role_status` char(1) NOT NULL DEFAULT 'Y',
  `create_user` varchar(50) NOT NULL,
  `create_dt` datetime NOT NULL DEFAULT current_timestamp(),
  `update_user` varchar(50) DEFAULT NULL,
  `update_dt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`role_id`, `role_name`, `role_description`, `role_status`, `create_user`, `create_dt`, `update_user`, `update_dt`) VALUES
('rid_01', 'Administrator', 'For Administrator / Super Admin', 'Y', '', '2021-05-14 17:43:10', '', '2021-05-14 17:43:10'),
('rid_02', 'Guest User', 'For General User', 'Y', '', '2021-05-14 17:43:10', '', '2021-05-14 17:43:10');

-- --------------------------------------------------------

--
-- Structure for view `tree_menu`
--
DROP TABLE IF EXISTS `tree_menu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tree_menu`  AS SELECT `a`.`tree_id` AS `tree_id`, `fn_getMenuName`(`a`.`parent_id`) AS `parent`, `fn_getMenuName`(`a`.`child_id1`) AS `child1`, `fn_getMenuName`(`a`.`child_id2`) AS `child2`, `fn_getMenuName`(`a`.`child_id3`) AS `child3`, `fn_getMenuName`(`a`.`child_id4`) AS `child4`, `fn_getMenuName`(`a`.`child_id5`) AS `child5` FROM `msbs_tree_menu` AS `a` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `msbs_group_menu`
--
ALTER TABLE `msbs_group_menu`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `msbs_menu`
--
ALTER TABLE `msbs_menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `msbs_menu_role`
--
ALTER TABLE `msbs_menu_role`
  ADD PRIMARY KEY (`mrole_id`,`role_id`,`tree_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `tree_id` (`tree_id`);

--
-- Indexes for table `msbs_tree_menu`
--
ALTER TABLE `msbs_tree_menu`
  ADD PRIMARY KEY (`tree_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_ibfk_1` (`role_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `msbs_menu_role`
--
ALTER TABLE `msbs_menu_role`
  ADD CONSTRAINT `msbs_menu_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`),
  ADD CONSTRAINT `msbs_menu_role_ibfk_2` FOREIGN KEY (`tree_id`) REFERENCES `msbs_tree_menu` (`tree_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
