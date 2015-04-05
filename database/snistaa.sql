-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 05, 2015 at 02:06 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `snistaa`
--
CREATE DATABASE IF NOT EXISTS `snistaa` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `snistaa`;

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_curriculim`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_alumni_curriculim` (
  `uid` int(11) NOT NULL,
  `1` int(11) NOT NULL,
  `2` int(11) NOT NULL,
  `3` int(11) NOT NULL,
  `4` int(11) NOT NULL,
  `5` int(11) NOT NULL,
  `6` int(11) NOT NULL,
  `7` int(11) NOT NULL,
  `8` int(11) NOT NULL,
  `9` int(11) NOT NULL,
  `10` int(11) NOT NULL,
  `11` int(11) NOT NULL,
  `12` int(11) NOT NULL,
  `13` int(11) NOT NULL,
  `14` int(11) NOT NULL,
  `15` int(11) NOT NULL,
  `16` int(11) NOT NULL,
  `17` int(11) NOT NULL,
  `18` int(11) NOT NULL,
  `19` int(11) NOT NULL,
  `20` int(11) NOT NULL,
  `21` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_alumni_curriculim`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_employability`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_alumni_employability` (
  `uid` int(11) NOT NULL,
  `1` int(11) NOT NULL,
  `2` int(11) NOT NULL,
  `3` int(11) NOT NULL,
  `4` int(11) NOT NULL,
  `5` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_alumni_employability`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_impression`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_alumni_impression` (
  `uid` int(11) NOT NULL,
  `1` int(11) NOT NULL,
  `2` int(11) NOT NULL,
  `3` int(11) NOT NULL,
  `4` int(11) NOT NULL,
  `5` int(11) NOT NULL,
  `6` int(11) NOT NULL,
  `7` int(11) NOT NULL,
  `8` int(11) NOT NULL,
  `9` int(11) NOT NULL,
  `10` int(11) NOT NULL,
  `11` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_alumni_impression`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_objectives`
--
-- Creation: Apr 05, 2015 at 11:58 AM
--

CREATE TABLE IF NOT EXISTS `fb_alumni_objectives` (
  `uid` int(11) NOT NULL,
  `peoa` int(11) NOT NULL,
  `peob` int(11) NOT NULL,
  `peoc` int(11) NOT NULL,
  `peod` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_alumni_objectives`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_outcomes`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_alumni_outcomes` (
  `uid` int(10) NOT NULL,
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `e` int(11) NOT NULL,
  `f` int(11) NOT NULL,
  `g` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `i` int(11) NOT NULL,
  `j` int(11) NOT NULL,
  `k` int(11) NOT NULL,
  `l` int(11) NOT NULL,
  `m` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_alumni_outcomes`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_objectives`
--
-- Creation: Apr 05, 2015 at 11:46 AM
--

CREATE TABLE IF NOT EXISTS `fb_employer_objectives` (
  `uid` int(11) NOT NULL,
  `peoa` int(11) NOT NULL,
  `peob` int(11) NOT NULL,
  `peoc` int(11) NOT NULL,
  `peod` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_employer_objectives`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_outcomes`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_employer_outcomes` (
  `uid` int(10) NOT NULL,
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `e` int(11) NOT NULL,
  `f` int(11) NOT NULL,
  `g` int(11) NOT NULL,
  `h` int(11) NOT NULL,
  `i` int(11) NOT NULL,
  `j` int(11) NOT NULL,
  `k` int(11) NOT NULL,
  `l` int(11) NOT NULL,
  `m` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_employer_outcomes`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_skills`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_employer_skills` (
  `uid` int(11) NOT NULL,
  `1` int(11) NOT NULL,
  `2` int(11) NOT NULL,
  `3` int(11) NOT NULL,
  `4` int(11) NOT NULL,
  `5` int(11) NOT NULL,
  `6` int(11) NOT NULL,
  `7` int(11) NOT NULL,
  `8` int(11) NOT NULL,
  `9` int(11) NOT NULL,
  `10` int(11) NOT NULL,
  `11` int(11) NOT NULL,
  `12` int(11) NOT NULL,
  `13` int(11) NOT NULL,
  `14` int(11) NOT NULL,
  `15` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_employer_skills`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fb_parent_college`
--
-- Creation: Apr 05, 2015 at 11:57 AM
--

CREATE TABLE IF NOT EXISTS `fb_parent_college` (
  `uid` int(11) NOT NULL,
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `e` int(11) NOT NULL,
  `f` int(11) NOT NULL,
  `g` int(11) NOT NULL,
  `h` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fb_parent_college`:
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_forums`
--
-- Creation: Apr 04, 2015 at 05:42 AM
--

CREATE TABLE IF NOT EXISTS `fo_forums` (
`id` int(10) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `description` text COLLATE latin1_general_ci,
  `type` int(5) NOT NULL DEFAULT '1',
  `posts` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fo_forums`:
--   `type`
--       `fo_type` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_mods`
--
-- Creation: Apr 05, 2015 at 08:04 AM
--

CREATE TABLE IF NOT EXISTS `fo_mods` (
  `fid` int(10) NOT NULL,
  `uid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fo_mods`:
--   `fid`
--       `fo_forums` -> `id`
--   `uid`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_posts`
--
-- Creation: Mar 31, 2015 at 12:45 PM
--

CREATE TABLE IF NOT EXISTS `fo_posts` (
`id` int(10) NOT NULL,
  `thread_id` int(10) NOT NULL,
  `content` longtext COLLATE latin1_general_ci NOT NULL,
  `added_by` int(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fo_posts`:
--   `thread_id`
--       `fo_threads` -> `id`
--   `added_by`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_threads`
--
-- Creation: Mar 31, 2015 at 12:43 PM
--

CREATE TABLE IF NOT EXISTS `fo_threads` (
`id` int(10) NOT NULL,
  `forum_id` int(10) NOT NULL,
  `name` text COLLATE latin1_general_ci NOT NULL,
  `added_by` int(10) NOT NULL,
  `time_Stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `fo_threads`:
--   `forum_id`
--       `fo_forums` -> `id`
--   `added_by`
--       `um_users` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `fo_type`
--
-- Creation: Mar 31, 2015 at 12:38 PM
--

CREATE TABLE IF NOT EXISTS `fo_type` (
`id` int(5) NOT NULL,
  `type` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `um_configuration`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_configuration` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_department`
--
-- Creation: Mar 31, 2015 at 12:29 PM
--

CREATE TABLE IF NOT EXISTS `um_department` (
`id` int(2) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `um_filelist`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_filelist` (
`id` int(11) NOT NULL,
  `path` varchar(150) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `um_groups`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_groups` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `home_page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_group_action_permits`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_group_action_permits` (
`id` int(10) unsigned NOT NULL,
  `group_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `permits` varchar(400) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_group_page_matches`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_group_page_matches` (
`id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_nav`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_nav` (
`id` int(11) NOT NULL,
  `menu` varchar(75) NOT NULL,
  `page` varchar(175) NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` int(11) NOT NULL,
  `class_name` varchar(150) NOT NULL,
  `icon` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_nav_group_matches`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_nav_group_matches` (
`id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_pages`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_pages` (
`id` int(11) NOT NULL,
  `page` varchar(150) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_plugin_configuration`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_plugin_configuration` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(150) NOT NULL,
  `binary` int(1) NOT NULL,
  `variable` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_users`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_users` (
`id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `display_name` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `activation_token` varchar(225) NOT NULL,
  `last_activation_request` int(11) NOT NULL,
  `lost_password_request` tinyint(1) NOT NULL,
  `lost_password_timestamp` int(11) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `title` varchar(150) NOT NULL,
  `sign_up_stamp` int(11) NOT NULL,
  `last_sign_in_stamp` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Specifies if the account is enabled.  Disabled accounts cannot be logged in to, but they retain all of their data and settings.',
  `primary_group_id` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Specifies the primary group for the user.'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_user_action_permits`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_user_action_permits` (
`id` int(10) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `permits` varchar(400) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_user_details`
--
-- Creation: Mar 31, 2015 at 12:33 PM
--

CREATE TABLE IF NOT EXISTS `um_user_details` (
  `id` int(11) NOT NULL,
  `full_name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `roll_no` varchar(12) COLLATE latin1_general_ci NOT NULL,
  `department` int(3) NOT NULL DEFAULT '1',
  `year_join` int(4) NOT NULL DEFAULT '2015',
  `year_end` int(4) NOT NULL DEFAULT '2018',
  `isAlumni` int(1) NOT NULL DEFAULT '0',
  `feedback_done` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='User details definition';

--
-- RELATIONS FOR TABLE `um_user_details`:
--   `id`
--       `um_users` -> `id`
--   `department`
--       `um_department` -> `id`
--

-- --------------------------------------------------------

--
-- Table structure for table `um_user_group_matches`
--
-- Creation: Mar 20, 2015 at 04:28 PM
--

CREATE TABLE IF NOT EXISTS `um_user_group_matches` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `um_user_subscriptions`
--
-- Creation: Apr 04, 2015 at 05:00 AM
--

CREATE TABLE IF NOT EXISTS `um_user_subscriptions` (
  `uid` int(10) NOT NULL,
  `fid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- RELATIONS FOR TABLE `um_user_subscriptions`:
--   `uid`
--       `um_users` -> `id`
--   `fid`
--       `fo_forums` -> `id`
--

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fb_alumni_curriculim`
--
ALTER TABLE `fb_alumni_curriculim`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_alumni_employability`
--
ALTER TABLE `fb_alumni_employability`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_alumni_impression`
--
ALTER TABLE `fb_alumni_impression`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_alumni_objectives`
--
ALTER TABLE `fb_alumni_objectives`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_alumni_outcomes`
--
ALTER TABLE `fb_alumni_outcomes`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_employer_objectives`
--
ALTER TABLE `fb_employer_objectives`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_employer_outcomes`
--
ALTER TABLE `fb_employer_outcomes`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_employer_skills`
--
ALTER TABLE `fb_employer_skills`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fb_parent_college`
--
ALTER TABLE `fb_parent_college`
 ADD KEY `uid` (`uid`);

--
-- Indexes for table `fo_forums`
--
ALTER TABLE `fo_forums`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`), ADD KEY `type` (`type`);

--
-- Indexes for table `fo_mods`
--
ALTER TABLE `fo_mods`
 ADD KEY `fid` (`fid`), ADD KEY `uid` (`uid`);

--
-- Indexes for table `fo_posts`
--
ALTER TABLE `fo_posts`
 ADD PRIMARY KEY (`id`), ADD KEY `thread_id` (`thread_id`), ADD KEY `added_by` (`added_by`);

--
-- Indexes for table `fo_threads`
--
ALTER TABLE `fo_threads`
 ADD PRIMARY KEY (`id`), ADD KEY `forum_id` (`forum_id`), ADD KEY `added_by` (`added_by`);

--
-- Indexes for table `fo_type`
--
ALTER TABLE `fo_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_configuration`
--
ALTER TABLE `um_configuration`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_department`
--
ALTER TABLE `um_department`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_filelist`
--
ALTER TABLE `um_filelist`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `path` (`path`);

--
-- Indexes for table `um_groups`
--
ALTER TABLE `um_groups`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_group_action_permits`
--
ALTER TABLE `um_group_action_permits`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_group_page_matches`
--
ALTER TABLE `um_group_page_matches`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_nav`
--
ALTER TABLE `um_nav`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_nav_group_matches`
--
ALTER TABLE `um_nav_group_matches`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_pages`
--
ALTER TABLE `um_pages`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_plugin_configuration`
--
ALTER TABLE `um_plugin_configuration`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_users`
--
ALTER TABLE `um_users`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_user_action_permits`
--
ALTER TABLE `um_user_action_permits`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_user_details`
--
ALTER TABLE `um_user_details`
 ADD UNIQUE KEY `full_name` (`full_name`), ADD KEY `id` (`id`), ADD KEY `department` (`department`);

--
-- Indexes for table `um_user_group_matches`
--
ALTER TABLE `um_user_group_matches`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_user_subscriptions`
--
ALTER TABLE `um_user_subscriptions`
 ADD KEY `uid` (`uid`), ADD KEY `fid` (`fid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fo_forums`
--
ALTER TABLE `fo_forums`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `fo_posts`
--
ALTER TABLE `fo_posts`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `fo_threads`
--
ALTER TABLE `fo_threads`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `fo_type`
--
ALTER TABLE `fo_type`
MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `um_configuration`
--
ALTER TABLE `um_configuration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `um_department`
--
ALTER TABLE `um_department`
MODIFY `id` int(2) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `um_filelist`
--
ALTER TABLE `um_filelist`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `um_groups`
--
ALTER TABLE `um_groups`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `um_group_action_permits`
--
ALTER TABLE `um_group_action_permits`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `um_group_page_matches`
--
ALTER TABLE `um_group_page_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `um_nav`
--
ALTER TABLE `um_nav`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `um_nav_group_matches`
--
ALTER TABLE `um_nav_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `um_pages`
--
ALTER TABLE `um_pages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `um_plugin_configuration`
--
ALTER TABLE `um_plugin_configuration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `um_users`
--
ALTER TABLE `um_users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `um_user_action_permits`
--
ALTER TABLE `um_user_action_permits`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `um_user_group_matches`
--
ALTER TABLE `um_user_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `fb_alumni_curriculim`
--
ALTER TABLE `fb_alumni_curriculim`
ADD CONSTRAINT `fb_alumni_curriculim_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `fb_alumni_curriculim_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_alumni_employability`
--
ALTER TABLE `fb_alumni_employability`
ADD CONSTRAINT `fb_alumni_employability_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `fb_alumni_employability_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_alumni_impression`
--
ALTER TABLE `fb_alumni_impression`
ADD CONSTRAINT `fb_alumni_impression_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `fb_alumni_impression_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_alumni_objectives`
--
ALTER TABLE `fb_alumni_objectives`
ADD CONSTRAINT `fb_alumni_objectives_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_alumni_outcomes`
--
ALTER TABLE `fb_alumni_outcomes`
ADD CONSTRAINT `fb_alumni_outcomes_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `fb_alumni_outcomes_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_employer_objectives`
--
ALTER TABLE `fb_employer_objectives`
ADD CONSTRAINT `fb_employer_objectives_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_employer_outcomes`
--
ALTER TABLE `fb_employer_outcomes`
ADD CONSTRAINT `fb_employer_outcomes_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `fb_employer_outcomes_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_employer_skills`
--
ALTER TABLE `fb_employer_skills`
ADD CONSTRAINT `fb_employer_skills_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fb_parent_college`
--
ALTER TABLE `fb_parent_college`
ADD CONSTRAINT `fb_parent_college_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fo_forums`
--
ALTER TABLE `fo_forums`
ADD CONSTRAINT `fo_forums_ibfk_1` FOREIGN KEY (`type`) REFERENCES `fo_type` (`id`);

--
-- Constraints for table `fo_mods`
--
ALTER TABLE `fo_mods`
ADD CONSTRAINT `fo_mods_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `fo_forums` (`id`),
ADD CONSTRAINT `fo_mods_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fo_posts`
--
ALTER TABLE `fo_posts`
ADD CONSTRAINT `fo_posts_ibfk_1` FOREIGN KEY (`thread_id`) REFERENCES `fo_threads` (`id`),
ADD CONSTRAINT `fo_posts_ibfk_2` FOREIGN KEY (`added_by`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `fo_threads`
--
ALTER TABLE `fo_threads`
ADD CONSTRAINT `fo_threads_ibfk_1` FOREIGN KEY (`forum_id`) REFERENCES `fo_forums` (`id`),
ADD CONSTRAINT `fo_threads_ibfk_2` FOREIGN KEY (`added_by`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `um_user_details`
--
ALTER TABLE `um_user_details`
ADD CONSTRAINT `um_user_details_ibfk_1` FOREIGN KEY (`id`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `um_user_details_ibfk_2` FOREIGN KEY (`department`) REFERENCES `um_department` (`id`);

--
-- Constraints for table `um_user_subscriptions`
--
ALTER TABLE `um_user_subscriptions`
ADD CONSTRAINT `um_user_subscriptions_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`),
ADD CONSTRAINT `um_user_subscriptions_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `fo_forums` (`id`);
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
