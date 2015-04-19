-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 19, 2015 at 01:39 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `autosubscribe`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `autosubscribe`(IN `uid` INT UNSIGNED)
BEGIN
DECLARE dept INT;
DECLARE department VARCHAR(255);
DECLARE forums VARCHAR(255);
DECLARE yj INT;
DECLARE ye INT;
DECLARE section INT;
DECLARE id INT;
INSERT IGNORE  INTO um_user_subscriptions(uid,fid) SELECT uid,forumid from fo_mandate_subscriptions;
SET dept=(SELECT department from um_user_details where id=uid);
SET yj=(SELECT year_join from um_user_details where id=uid);
SET ye=(SELECT year_end from um_user_details where id=uid);
SET department=(select name from um_department where id=dept);
SET forums=concat(department," ",yj,"-",ye);
SELECT forums;
INSERT IGNORE INTO fo_forums(name,description,type) VALUES(forums,forums,'3');
SET id=(SELECT id from fo_forums where name=forums LIMIT 1);
INSERT INTO um_user_subscriptions VALUES(uid,id);
SET forums=("SNIST ",yj,"-",ye);
INSERT IGNORE INTO fo_forums(name,description,type) VALUES(forums,forums,'3'); 
SET id=(SELECT id from fo_forums where name=forums LIMIT 1);
INSERT INTO um_user_subscriptions VALUES(uid,id);
END$$

DROP PROCEDURE IF EXISTS `fillBatches`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fillBatches`()
BEGIN
   DECLARE dept INT;
   DECLARE yj INT;
   DECLARE section INT;
   SET dept=2;
   SET yj=1998;
   SET section=1;
   TRUNCATE TABLE um_batches;
   WHILE yj<=YEAR(CURDATE()) DO
   WHILE dept<=9 DO
   WHILE section<=5 DO
   INSERT INTO um_batches VALUES(null,dept,yj,yj+4,section);
   SET section=section+1;
   END WHILE;
   SET section=1;
   SET dept=dept+1;
   END WHILE;
   SET dept=2;
   SET yj=yj+1;
   END WHILE;
   END$$

DROP PROCEDURE IF EXISTS `fillLevels`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fillLevels`(IN `uid` INT UNSIGNED)
    NO SQL
BEGIN
DECLARE noPosts INT;
DECLARE ulevel INT;
DECLARE newTitle VARCHAR(50);
SET noPosts=(SELECT count(*) from fo_posts where added_by=uid);
SET ulevel=(noPosts/100)+1;
SET newTitle=(SELECT title from um_user_levels where id=ulevel);
UPDATE um_users SET TITLE=newTitle where id=uid and title!="Master Account";
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_curriculim`
--

DROP TABLE IF EXISTS `fb_alumni_curriculim`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_employability`
--

DROP TABLE IF EXISTS `fb_alumni_employability`;
CREATE TABLE IF NOT EXISTS `fb_alumni_employability` (
  `uid` int(11) NOT NULL,
  `1` int(11) NOT NULL,
  `2` int(11) NOT NULL,
  `3` int(11) NOT NULL,
  `4` int(11) NOT NULL,
  `5` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_impression`
--

DROP TABLE IF EXISTS `fb_alumni_impression`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_objectives`
--

DROP TABLE IF EXISTS `fb_alumni_objectives`;
CREATE TABLE IF NOT EXISTS `fb_alumni_objectives` (
  `uid` int(11) NOT NULL,
  `peoa` int(11) NOT NULL,
  `peob` int(11) NOT NULL,
  `peoc` int(11) NOT NULL,
  `peod` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_outcomes`
--

DROP TABLE IF EXISTS `fb_alumni_outcomes`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_objectives`
--

DROP TABLE IF EXISTS `fb_employer_objectives`;
CREATE TABLE IF NOT EXISTS `fb_employer_objectives` (
  `uid` int(11) NOT NULL,
  `peoa` int(11) NOT NULL,
  `peob` int(11) NOT NULL,
  `peoc` int(11) NOT NULL,
  `peod` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_outcomes`
--

DROP TABLE IF EXISTS `fb_employer_outcomes`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fb_employer_skills`
--

DROP TABLE IF EXISTS `fb_employer_skills`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fb_parent_college`
--

DROP TABLE IF EXISTS `fb_parent_college`;
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

-- --------------------------------------------------------

--
-- Table structure for table `fo_forums`
--

DROP TABLE IF EXISTS `fo_forums`;
CREATE TABLE IF NOT EXISTS `fo_forums` (
`id` int(10) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `description` text COLLATE latin1_general_ci,
  `type` int(5) NOT NULL DEFAULT '1',
  `threads` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_forums`
--

INSERT INTO `fo_forums` (`id`, `name`, `description`, `type`, `threads`) VALUES
(17, 'beggarss', 'bigga', 3, 2),
(18, '', NULL, 3, 0),
(20, 'beggarssz', 'bigga', 3, 0),
(22, 'beggarsszhkas', 'bigga', 3, 0),
(24, 'babyegg', 'forum for dev', 3, 0),
(25, 'beby', 'hdh', 3, 0),
(26, 'nwo', 'new world order', 3, 0),
(27, 'Dev', 'demo forum just for fun', 3, 0),
(28, 'nsfw', 'not safe for work', 2, 8),
(29, 'devForum', 'dev forum', 1, 0),
(31, 'devthreads', 'dev', 1, 1),
(32, 'devthreadsz', 'dev', 1, 14),
(34, '111', '11', 1, 0),
(35, 'forum123', 'dljllsjd', 2, 1),
(36, 'SNISTUPDATES', 'snist updates', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_mandate_subscriptions`
--

DROP TABLE IF EXISTS `fo_mandate_subscriptions`;
CREATE TABLE IF NOT EXISTS `fo_mandate_subscriptions` (
  `forumid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_mandate_subscriptions`
--

INSERT INTO `fo_mandate_subscriptions` (`forumid`) VALUES
(36);

-- --------------------------------------------------------

--
-- Table structure for table `fo_mods`
--

DROP TABLE IF EXISTS `fo_mods`;
CREATE TABLE IF NOT EXISTS `fo_mods` (
  `fid` int(10) NOT NULL,
  `uid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_mods`
--

INSERT INTO `fo_mods` (`fid`, `uid`) VALUES
(32, 2),
(17, 1),
(18, 1),
(20, 1),
(22, 1),
(24, 1),
(34, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_posts`
--

DROP TABLE IF EXISTS `fo_posts`;
CREATE TABLE IF NOT EXISTS `fo_posts` (
`id` int(10) NOT NULL,
  `thread_id` int(10) NOT NULL,
  `content` longtext COLLATE latin1_general_ci NOT NULL,
  `added_by` int(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_posts`
--

INSERT INTO `fo_posts` (`id`, `thread_id`, `content`, `added_by`, `timestamp`, `likes`) VALUES
(1, 1, 'demoPost', 2, '2015-04-05 04:39:07', 0),
(2, 1, 'stupid idiot baka', 2, '2015-04-11 15:35:29', 0),
(3, 2, 'this is the first thread', 2, '2015-04-11 15:36:20', 0),
(4, 2, 'its not thread, its post you dumbass', 2, '2015-04-11 15:36:54', 0),
(5, 2, 'rofl idiots', 2, '2015-04-11 15:37:04', 0),
(6, 2, 'does smily work :)', 2, '2015-04-11 15:37:16', 0),
(7, 2, 'it doesnt work nigger', 2, '2015-04-11 15:39:45', 0),
(8, 7, 'demo post', 1, '2015-04-12 06:18:26', 0),
(9, 14, 'new post', 1, '2015-04-12 06:32:16', 0),
(10, 14, 'haha goku, over 9000', 2, '2015-04-12 06:34:14', 0),
(11, 14, 'fuck off demo', 1, '2015-04-12 06:44:20', 0),
(12, 16, 'op is dumb ass', 2, '2015-04-12 06:50:30', 0),
(13, 2, 'haha', 1, '2015-04-12 07:43:04', 0),
(14, 3, 'demo', 2, '2015-04-14 13:26:58', 0),
(15, 3, '\\:P', 2, '2015-04-14 13:27:02', 0),
(16, 8, 'new post', 2, '2015-04-16 15:23:00', 0),
(17, 8, 'new post 2', 2, '2015-04-16 15:23:15', 0),
(18, 8, 'new post 3', 2, '2015-04-16 15:23:22', 0),
(19, 8, 'new post 4', 2, '2015-04-16 15:23:27', 0),
(20, 8, 'new post 5', 2, '2015-04-16 15:23:33', 0),
(21, 8, 'new post 6', 2, '2015-04-16 15:23:40', 0),
(22, 8, 'new post 7', 2, '2015-04-16 15:23:46', 0),
(23, 8, 'new post 9', 2, '2015-04-16 15:23:52', 0),
(24, 8, 'new post 10', 2, '2015-04-16 15:23:59', 0),
(25, 8, 'new post 11', 2, '2015-04-16 15:24:06', 0),
(26, 18, 'this is new post', 2, '2015-04-16 15:38:35', 0),
(27, 18, 'e sure to add role=&quot;dialog&quot; to .modal, aria-labelledby=&quot;myModalLabel&quot; attribute to reference the modal title, and aria-hidden=&quot;true&quot; to tell assistive technologies to skip the modal''s DOM elements.\n\nAdditionally, you may give a description of your modal dialog with aria-describedby on .modal.', 2, '2015-04-16 15:42:52', 0),
(28, 21, 'this is thread post', 2, '2015-04-16 15:49:52', 0),
(29, 21, 'gaga', 2, '2015-04-16 16:01:08', 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_threads`
--

DROP TABLE IF EXISTS `fo_threads`;
CREATE TABLE IF NOT EXISTS `fo_threads` (
`id` int(10) NOT NULL,
  `forum_id` int(10) NOT NULL,
  `name` text COLLATE latin1_general_ci NOT NULL,
  `added_by` int(10) NOT NULL,
  `time_Stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_threads`
--

INSERT INTO `fo_threads` (`id`, `forum_id`, `name`, `added_by`, `time_Stamp`) VALUES
(1, 32, 'demoThread', 2, '2015-04-05 04:35:15'),
(2, 32, 'demoThread2', 2, '2015-04-05 08:21:38'),
(3, 17, 'demoThread', 2, '2015-04-05 08:22:46'),
(4, 31, 'demoThread', 2, '2015-04-05 08:24:02'),
(5, 31, 'demoThread2', 2, '2015-04-05 08:25:18'),
(6, 31, 'demoThread3', 1, '2015-04-06 14:29:39'),
(7, 28, 'demo thread', 1, '2015-04-12 06:18:20'),
(8, 28, 'next thread', 1, '2015-04-12 06:24:39'),
(9, 28, 'next thread', 1, '2015-04-12 06:24:41'),
(10, 28, 'next thread', 1, '2015-04-12 06:24:51'),
(11, 28, 'next thread', 1, '2015-04-12 06:24:52'),
(12, 28, 'next thread', 1, '2015-04-12 06:24:52'),
(13, 28, 'next thread', 1, '2015-04-12 06:24:52'),
(14, 28, 'next thread3', 1, '2015-04-12 06:26:02'),
(15, 17, 'new thread', 2, '2015-04-12 06:49:56'),
(16, 17, 'simple therad', 2, '2015-04-12 06:50:12'),
(17, 32, 'demoThread3', 2, '2015-04-16 15:37:14'),
(18, 32, 'demotThread4', 2, '2015-04-16 15:38:26'),
(19, 32, 'demo thread', 2, '2015-04-16 15:44:14'),
(20, 35, 'big title for this forum thread, so that dumb people can post content in the entire thing dammit', 2, '2015-04-16 15:45:48'),
(21, 32, 'this is thread name', 2, '2015-04-16 15:49:52');

-- --------------------------------------------------------

--
-- Table structure for table `fo_thread_stats`
--

DROP TABLE IF EXISTS `fo_thread_stats`;
CREATE TABLE IF NOT EXISTS `fo_thread_stats` (
  `tid` int(11) NOT NULL,
  `posts` int(11) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_thread_stats`
--

INSERT INTO `fo_thread_stats` (`tid`, `posts`, `views`, `last_updated`) VALUES
(14, 3, 8, '2015-04-12 06:44:20'),
(15, 0, 0, '2015-04-12 06:49:56'),
(16, 1, 3, '2015-04-12 06:50:30'),
(17, 0, 0, '2015-04-16 15:37:14'),
(18, 2, 16, '2015-04-16 15:42:52'),
(19, 0, 0, '2015-04-16 15:44:14'),
(20, 0, 1, '2015-04-16 15:45:48'),
(21, 1, 4, '2015-04-16 16:01:08');

-- --------------------------------------------------------

--
-- Table structure for table `fo_type`
--

DROP TABLE IF EXISTS `fo_type`;
CREATE TABLE IF NOT EXISTS `fo_type` (
`id` int(5) NOT NULL,
  `type` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_type`
--

INSERT INTO `fo_type` (`id`, `type`) VALUES
(1, 'General'),
(2, 'Announcements'),
(3, 'Interactions'),
(4, 'NULL');

-- --------------------------------------------------------

--
-- Table structure for table `uf_invites`
--

DROP TABLE IF EXISTS `uf_invites`;
CREATE TABLE IF NOT EXISTS `uf_invites` (
`id` int(11) NOT NULL,
  `inviterId` int(11) NOT NULL,
  `invitedEmail` text NOT NULL,
  `status` int(11) NOT NULL,
  `inviteToken` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepted` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `message` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `uf_invites`
--

INSERT INTO `uf_invites` (`id`, `inviterId`, `invitedEmail`, `status`, `inviteToken`, `created`, `accepted`, `message`) VALUES
(1, 1, 'demo2@localhost', 0, 'a6a7ff6ed955a78fc83c6c27ed457835', '2015-04-14 12:55:06', '0000-00-00 00:00:00', 'join bro'),
(2, 1, 'uvinaykumaru@gmail.com', 0, '761977d229f2ce5573a35e66d1b78ddc', '2015-04-14 13:06:47', '0000-00-00 00:00:00', 'come bava'),
(3, 1, 'smarthavoc@gmail.com', 0, 'df976a6f0fcf15769a24d61a7bac5868', '2015-04-14 13:07:10', '0000-00-00 00:00:00', 'come'),
(4, 1, 'smarthavoc@gmail.com', 0, 'e26907198cbf89fdee75bb938f3fbd89', '2015-04-14 13:17:06', '0000-00-00 00:00:00', 'welcome');

-- --------------------------------------------------------

--
-- Table structure for table `uf_user_invites`
--

DROP TABLE IF EXISTS `uf_user_invites`;
CREATE TABLE IF NOT EXISTS `uf_user_invites` (
  `userId` int(11) NOT NULL,
  `invitesLeft` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `uf_user_invites`
--

INSERT INTO `uf_user_invites` (`userId`, `invitesLeft`) VALUES
(1, 100);

-- --------------------------------------------------------

--
-- Table structure for table `um_batches`
--

DROP TABLE IF EXISTS `um_batches`;
CREATE TABLE IF NOT EXISTS `um_batches` (
`id` int(11) NOT NULL,
  `deptid` int(11) NOT NULL,
  `yearJ` int(11) NOT NULL,
  `yearE` int(11) NOT NULL,
  `section` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=721 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `um_batches`
--

INSERT INTO `um_batches` (`id`, `deptid`, `yearJ`, `yearE`, `section`) VALUES
(1, 2, 1998, 2002, 1),
(2, 2, 1998, 2002, 2),
(3, 2, 1998, 2002, 3),
(4, 2, 1998, 2002, 4),
(5, 2, 1998, 2002, 5),
(6, 3, 1998, 2002, 1),
(7, 3, 1998, 2002, 2),
(8, 3, 1998, 2002, 3),
(9, 3, 1998, 2002, 4),
(10, 3, 1998, 2002, 5),
(11, 4, 1998, 2002, 1),
(12, 4, 1998, 2002, 2),
(13, 4, 1998, 2002, 3),
(14, 4, 1998, 2002, 4),
(15, 4, 1998, 2002, 5),
(16, 5, 1998, 2002, 1),
(17, 5, 1998, 2002, 2),
(18, 5, 1998, 2002, 3),
(19, 5, 1998, 2002, 4),
(20, 5, 1998, 2002, 5),
(21, 6, 1998, 2002, 1),
(22, 6, 1998, 2002, 2),
(23, 6, 1998, 2002, 3),
(24, 6, 1998, 2002, 4),
(25, 6, 1998, 2002, 5),
(26, 7, 1998, 2002, 1),
(27, 7, 1998, 2002, 2),
(28, 7, 1998, 2002, 3),
(29, 7, 1998, 2002, 4),
(30, 7, 1998, 2002, 5),
(31, 8, 1998, 2002, 1),
(32, 8, 1998, 2002, 2),
(33, 8, 1998, 2002, 3),
(34, 8, 1998, 2002, 4),
(35, 8, 1998, 2002, 5),
(36, 9, 1998, 2002, 1),
(37, 9, 1998, 2002, 2),
(38, 9, 1998, 2002, 3),
(39, 9, 1998, 2002, 4),
(40, 9, 1998, 2002, 5),
(41, 2, 1999, 2003, 1),
(42, 2, 1999, 2003, 2),
(43, 2, 1999, 2003, 3),
(44, 2, 1999, 2003, 4),
(45, 2, 1999, 2003, 5),
(46, 3, 1999, 2003, 1),
(47, 3, 1999, 2003, 2),
(48, 3, 1999, 2003, 3),
(49, 3, 1999, 2003, 4),
(50, 3, 1999, 2003, 5),
(51, 4, 1999, 2003, 1),
(52, 4, 1999, 2003, 2),
(53, 4, 1999, 2003, 3),
(54, 4, 1999, 2003, 4),
(55, 4, 1999, 2003, 5),
(56, 5, 1999, 2003, 1),
(57, 5, 1999, 2003, 2),
(58, 5, 1999, 2003, 3),
(59, 5, 1999, 2003, 4),
(60, 5, 1999, 2003, 5),
(61, 6, 1999, 2003, 1),
(62, 6, 1999, 2003, 2),
(63, 6, 1999, 2003, 3),
(64, 6, 1999, 2003, 4),
(65, 6, 1999, 2003, 5),
(66, 7, 1999, 2003, 1),
(67, 7, 1999, 2003, 2),
(68, 7, 1999, 2003, 3),
(69, 7, 1999, 2003, 4),
(70, 7, 1999, 2003, 5),
(71, 8, 1999, 2003, 1),
(72, 8, 1999, 2003, 2),
(73, 8, 1999, 2003, 3),
(74, 8, 1999, 2003, 4),
(75, 8, 1999, 2003, 5),
(76, 9, 1999, 2003, 1),
(77, 9, 1999, 2003, 2),
(78, 9, 1999, 2003, 3),
(79, 9, 1999, 2003, 4),
(80, 9, 1999, 2003, 5),
(81, 2, 2000, 2004, 1),
(82, 2, 2000, 2004, 2),
(83, 2, 2000, 2004, 3),
(84, 2, 2000, 2004, 4),
(85, 2, 2000, 2004, 5),
(86, 3, 2000, 2004, 1),
(87, 3, 2000, 2004, 2),
(88, 3, 2000, 2004, 3),
(89, 3, 2000, 2004, 4),
(90, 3, 2000, 2004, 5),
(91, 4, 2000, 2004, 1),
(92, 4, 2000, 2004, 2),
(93, 4, 2000, 2004, 3),
(94, 4, 2000, 2004, 4),
(95, 4, 2000, 2004, 5),
(96, 5, 2000, 2004, 1),
(97, 5, 2000, 2004, 2),
(98, 5, 2000, 2004, 3),
(99, 5, 2000, 2004, 4),
(100, 5, 2000, 2004, 5),
(101, 6, 2000, 2004, 1),
(102, 6, 2000, 2004, 2),
(103, 6, 2000, 2004, 3),
(104, 6, 2000, 2004, 4),
(105, 6, 2000, 2004, 5),
(106, 7, 2000, 2004, 1),
(107, 7, 2000, 2004, 2),
(108, 7, 2000, 2004, 3),
(109, 7, 2000, 2004, 4),
(110, 7, 2000, 2004, 5),
(111, 8, 2000, 2004, 1),
(112, 8, 2000, 2004, 2),
(113, 8, 2000, 2004, 3),
(114, 8, 2000, 2004, 4),
(115, 8, 2000, 2004, 5),
(116, 9, 2000, 2004, 1),
(117, 9, 2000, 2004, 2),
(118, 9, 2000, 2004, 3),
(119, 9, 2000, 2004, 4),
(120, 9, 2000, 2004, 5),
(121, 2, 2001, 2005, 1),
(122, 2, 2001, 2005, 2),
(123, 2, 2001, 2005, 3),
(124, 2, 2001, 2005, 4),
(125, 2, 2001, 2005, 5),
(126, 3, 2001, 2005, 1),
(127, 3, 2001, 2005, 2),
(128, 3, 2001, 2005, 3),
(129, 3, 2001, 2005, 4),
(130, 3, 2001, 2005, 5),
(131, 4, 2001, 2005, 1),
(132, 4, 2001, 2005, 2),
(133, 4, 2001, 2005, 3),
(134, 4, 2001, 2005, 4),
(135, 4, 2001, 2005, 5),
(136, 5, 2001, 2005, 1),
(137, 5, 2001, 2005, 2),
(138, 5, 2001, 2005, 3),
(139, 5, 2001, 2005, 4),
(140, 5, 2001, 2005, 5),
(141, 6, 2001, 2005, 1),
(142, 6, 2001, 2005, 2),
(143, 6, 2001, 2005, 3),
(144, 6, 2001, 2005, 4),
(145, 6, 2001, 2005, 5),
(146, 7, 2001, 2005, 1),
(147, 7, 2001, 2005, 2),
(148, 7, 2001, 2005, 3),
(149, 7, 2001, 2005, 4),
(150, 7, 2001, 2005, 5),
(151, 8, 2001, 2005, 1),
(152, 8, 2001, 2005, 2),
(153, 8, 2001, 2005, 3),
(154, 8, 2001, 2005, 4),
(155, 8, 2001, 2005, 5),
(156, 9, 2001, 2005, 1),
(157, 9, 2001, 2005, 2),
(158, 9, 2001, 2005, 3),
(159, 9, 2001, 2005, 4),
(160, 9, 2001, 2005, 5),
(161, 2, 2002, 2006, 1),
(162, 2, 2002, 2006, 2),
(163, 2, 2002, 2006, 3),
(164, 2, 2002, 2006, 4),
(165, 2, 2002, 2006, 5),
(166, 3, 2002, 2006, 1),
(167, 3, 2002, 2006, 2),
(168, 3, 2002, 2006, 3),
(169, 3, 2002, 2006, 4),
(170, 3, 2002, 2006, 5),
(171, 4, 2002, 2006, 1),
(172, 4, 2002, 2006, 2),
(173, 4, 2002, 2006, 3),
(174, 4, 2002, 2006, 4),
(175, 4, 2002, 2006, 5),
(176, 5, 2002, 2006, 1),
(177, 5, 2002, 2006, 2),
(178, 5, 2002, 2006, 3),
(179, 5, 2002, 2006, 4),
(180, 5, 2002, 2006, 5),
(181, 6, 2002, 2006, 1),
(182, 6, 2002, 2006, 2),
(183, 6, 2002, 2006, 3),
(184, 6, 2002, 2006, 4),
(185, 6, 2002, 2006, 5),
(186, 7, 2002, 2006, 1),
(187, 7, 2002, 2006, 2),
(188, 7, 2002, 2006, 3),
(189, 7, 2002, 2006, 4),
(190, 7, 2002, 2006, 5),
(191, 8, 2002, 2006, 1),
(192, 8, 2002, 2006, 2),
(193, 8, 2002, 2006, 3),
(194, 8, 2002, 2006, 4),
(195, 8, 2002, 2006, 5),
(196, 9, 2002, 2006, 1),
(197, 9, 2002, 2006, 2),
(198, 9, 2002, 2006, 3),
(199, 9, 2002, 2006, 4),
(200, 9, 2002, 2006, 5),
(201, 2, 2003, 2007, 1),
(202, 2, 2003, 2007, 2),
(203, 2, 2003, 2007, 3),
(204, 2, 2003, 2007, 4),
(205, 2, 2003, 2007, 5),
(206, 3, 2003, 2007, 1),
(207, 3, 2003, 2007, 2),
(208, 3, 2003, 2007, 3),
(209, 3, 2003, 2007, 4),
(210, 3, 2003, 2007, 5),
(211, 4, 2003, 2007, 1),
(212, 4, 2003, 2007, 2),
(213, 4, 2003, 2007, 3),
(214, 4, 2003, 2007, 4),
(215, 4, 2003, 2007, 5),
(216, 5, 2003, 2007, 1),
(217, 5, 2003, 2007, 2),
(218, 5, 2003, 2007, 3),
(219, 5, 2003, 2007, 4),
(220, 5, 2003, 2007, 5),
(221, 6, 2003, 2007, 1),
(222, 6, 2003, 2007, 2),
(223, 6, 2003, 2007, 3),
(224, 6, 2003, 2007, 4),
(225, 6, 2003, 2007, 5),
(226, 7, 2003, 2007, 1),
(227, 7, 2003, 2007, 2),
(228, 7, 2003, 2007, 3),
(229, 7, 2003, 2007, 4),
(230, 7, 2003, 2007, 5),
(231, 8, 2003, 2007, 1),
(232, 8, 2003, 2007, 2),
(233, 8, 2003, 2007, 3),
(234, 8, 2003, 2007, 4),
(235, 8, 2003, 2007, 5),
(236, 9, 2003, 2007, 1),
(237, 9, 2003, 2007, 2),
(238, 9, 2003, 2007, 3),
(239, 9, 2003, 2007, 4),
(240, 9, 2003, 2007, 5),
(241, 2, 2004, 2008, 1),
(242, 2, 2004, 2008, 2),
(243, 2, 2004, 2008, 3),
(244, 2, 2004, 2008, 4),
(245, 2, 2004, 2008, 5),
(246, 3, 2004, 2008, 1),
(247, 3, 2004, 2008, 2),
(248, 3, 2004, 2008, 3),
(249, 3, 2004, 2008, 4),
(250, 3, 2004, 2008, 5),
(251, 4, 2004, 2008, 1),
(252, 4, 2004, 2008, 2),
(253, 4, 2004, 2008, 3),
(254, 4, 2004, 2008, 4),
(255, 4, 2004, 2008, 5),
(256, 5, 2004, 2008, 1),
(257, 5, 2004, 2008, 2),
(258, 5, 2004, 2008, 3),
(259, 5, 2004, 2008, 4),
(260, 5, 2004, 2008, 5),
(261, 6, 2004, 2008, 1),
(262, 6, 2004, 2008, 2),
(263, 6, 2004, 2008, 3),
(264, 6, 2004, 2008, 4),
(265, 6, 2004, 2008, 5),
(266, 7, 2004, 2008, 1),
(267, 7, 2004, 2008, 2),
(268, 7, 2004, 2008, 3),
(269, 7, 2004, 2008, 4),
(270, 7, 2004, 2008, 5),
(271, 8, 2004, 2008, 1),
(272, 8, 2004, 2008, 2),
(273, 8, 2004, 2008, 3),
(274, 8, 2004, 2008, 4),
(275, 8, 2004, 2008, 5),
(276, 9, 2004, 2008, 1),
(277, 9, 2004, 2008, 2),
(278, 9, 2004, 2008, 3),
(279, 9, 2004, 2008, 4),
(280, 9, 2004, 2008, 5),
(281, 2, 2005, 2009, 1),
(282, 2, 2005, 2009, 2),
(283, 2, 2005, 2009, 3),
(284, 2, 2005, 2009, 4),
(285, 2, 2005, 2009, 5),
(286, 3, 2005, 2009, 1),
(287, 3, 2005, 2009, 2),
(288, 3, 2005, 2009, 3),
(289, 3, 2005, 2009, 4),
(290, 3, 2005, 2009, 5),
(291, 4, 2005, 2009, 1),
(292, 4, 2005, 2009, 2),
(293, 4, 2005, 2009, 3),
(294, 4, 2005, 2009, 4),
(295, 4, 2005, 2009, 5),
(296, 5, 2005, 2009, 1),
(297, 5, 2005, 2009, 2),
(298, 5, 2005, 2009, 3),
(299, 5, 2005, 2009, 4),
(300, 5, 2005, 2009, 5),
(301, 6, 2005, 2009, 1),
(302, 6, 2005, 2009, 2),
(303, 6, 2005, 2009, 3),
(304, 6, 2005, 2009, 4),
(305, 6, 2005, 2009, 5),
(306, 7, 2005, 2009, 1),
(307, 7, 2005, 2009, 2),
(308, 7, 2005, 2009, 3),
(309, 7, 2005, 2009, 4),
(310, 7, 2005, 2009, 5),
(311, 8, 2005, 2009, 1),
(312, 8, 2005, 2009, 2),
(313, 8, 2005, 2009, 3),
(314, 8, 2005, 2009, 4),
(315, 8, 2005, 2009, 5),
(316, 9, 2005, 2009, 1),
(317, 9, 2005, 2009, 2),
(318, 9, 2005, 2009, 3),
(319, 9, 2005, 2009, 4),
(320, 9, 2005, 2009, 5),
(321, 2, 2006, 2010, 1),
(322, 2, 2006, 2010, 2),
(323, 2, 2006, 2010, 3),
(324, 2, 2006, 2010, 4),
(325, 2, 2006, 2010, 5),
(326, 3, 2006, 2010, 1),
(327, 3, 2006, 2010, 2),
(328, 3, 2006, 2010, 3),
(329, 3, 2006, 2010, 4),
(330, 3, 2006, 2010, 5),
(331, 4, 2006, 2010, 1),
(332, 4, 2006, 2010, 2),
(333, 4, 2006, 2010, 3),
(334, 4, 2006, 2010, 4),
(335, 4, 2006, 2010, 5),
(336, 5, 2006, 2010, 1),
(337, 5, 2006, 2010, 2),
(338, 5, 2006, 2010, 3),
(339, 5, 2006, 2010, 4),
(340, 5, 2006, 2010, 5),
(341, 6, 2006, 2010, 1),
(342, 6, 2006, 2010, 2),
(343, 6, 2006, 2010, 3),
(344, 6, 2006, 2010, 4),
(345, 6, 2006, 2010, 5),
(346, 7, 2006, 2010, 1),
(347, 7, 2006, 2010, 2),
(348, 7, 2006, 2010, 3),
(349, 7, 2006, 2010, 4),
(350, 7, 2006, 2010, 5),
(351, 8, 2006, 2010, 1),
(352, 8, 2006, 2010, 2),
(353, 8, 2006, 2010, 3),
(354, 8, 2006, 2010, 4),
(355, 8, 2006, 2010, 5),
(356, 9, 2006, 2010, 1),
(357, 9, 2006, 2010, 2),
(358, 9, 2006, 2010, 3),
(359, 9, 2006, 2010, 4),
(360, 9, 2006, 2010, 5),
(361, 2, 2007, 2011, 1),
(362, 2, 2007, 2011, 2),
(363, 2, 2007, 2011, 3),
(364, 2, 2007, 2011, 4),
(365, 2, 2007, 2011, 5),
(366, 3, 2007, 2011, 1),
(367, 3, 2007, 2011, 2),
(368, 3, 2007, 2011, 3),
(369, 3, 2007, 2011, 4),
(370, 3, 2007, 2011, 5),
(371, 4, 2007, 2011, 1),
(372, 4, 2007, 2011, 2),
(373, 4, 2007, 2011, 3),
(374, 4, 2007, 2011, 4),
(375, 4, 2007, 2011, 5),
(376, 5, 2007, 2011, 1),
(377, 5, 2007, 2011, 2),
(378, 5, 2007, 2011, 3),
(379, 5, 2007, 2011, 4),
(380, 5, 2007, 2011, 5),
(381, 6, 2007, 2011, 1),
(382, 6, 2007, 2011, 2),
(383, 6, 2007, 2011, 3),
(384, 6, 2007, 2011, 4),
(385, 6, 2007, 2011, 5),
(386, 7, 2007, 2011, 1),
(387, 7, 2007, 2011, 2),
(388, 7, 2007, 2011, 3),
(389, 7, 2007, 2011, 4),
(390, 7, 2007, 2011, 5),
(391, 8, 2007, 2011, 1),
(392, 8, 2007, 2011, 2),
(393, 8, 2007, 2011, 3),
(394, 8, 2007, 2011, 4),
(395, 8, 2007, 2011, 5),
(396, 9, 2007, 2011, 1),
(397, 9, 2007, 2011, 2),
(398, 9, 2007, 2011, 3),
(399, 9, 2007, 2011, 4),
(400, 9, 2007, 2011, 5),
(401, 2, 2008, 2012, 1),
(402, 2, 2008, 2012, 2),
(403, 2, 2008, 2012, 3),
(404, 2, 2008, 2012, 4),
(405, 2, 2008, 2012, 5),
(406, 3, 2008, 2012, 1),
(407, 3, 2008, 2012, 2),
(408, 3, 2008, 2012, 3),
(409, 3, 2008, 2012, 4),
(410, 3, 2008, 2012, 5),
(411, 4, 2008, 2012, 1),
(412, 4, 2008, 2012, 2),
(413, 4, 2008, 2012, 3),
(414, 4, 2008, 2012, 4),
(415, 4, 2008, 2012, 5),
(416, 5, 2008, 2012, 1),
(417, 5, 2008, 2012, 2),
(418, 5, 2008, 2012, 3),
(419, 5, 2008, 2012, 4),
(420, 5, 2008, 2012, 5),
(421, 6, 2008, 2012, 1),
(422, 6, 2008, 2012, 2),
(423, 6, 2008, 2012, 3),
(424, 6, 2008, 2012, 4),
(425, 6, 2008, 2012, 5),
(426, 7, 2008, 2012, 1),
(427, 7, 2008, 2012, 2),
(428, 7, 2008, 2012, 3),
(429, 7, 2008, 2012, 4),
(430, 7, 2008, 2012, 5),
(431, 8, 2008, 2012, 1),
(432, 8, 2008, 2012, 2),
(433, 8, 2008, 2012, 3),
(434, 8, 2008, 2012, 4),
(435, 8, 2008, 2012, 5),
(436, 9, 2008, 2012, 1),
(437, 9, 2008, 2012, 2),
(438, 9, 2008, 2012, 3),
(439, 9, 2008, 2012, 4),
(440, 9, 2008, 2012, 5),
(441, 2, 2009, 2013, 1),
(442, 2, 2009, 2013, 2),
(443, 2, 2009, 2013, 3),
(444, 2, 2009, 2013, 4),
(445, 2, 2009, 2013, 5),
(446, 3, 2009, 2013, 1),
(447, 3, 2009, 2013, 2),
(448, 3, 2009, 2013, 3),
(449, 3, 2009, 2013, 4),
(450, 3, 2009, 2013, 5),
(451, 4, 2009, 2013, 1),
(452, 4, 2009, 2013, 2),
(453, 4, 2009, 2013, 3),
(454, 4, 2009, 2013, 4),
(455, 4, 2009, 2013, 5),
(456, 5, 2009, 2013, 1),
(457, 5, 2009, 2013, 2),
(458, 5, 2009, 2013, 3),
(459, 5, 2009, 2013, 4),
(460, 5, 2009, 2013, 5),
(461, 6, 2009, 2013, 1),
(462, 6, 2009, 2013, 2),
(463, 6, 2009, 2013, 3),
(464, 6, 2009, 2013, 4),
(465, 6, 2009, 2013, 5),
(466, 7, 2009, 2013, 1),
(467, 7, 2009, 2013, 2),
(468, 7, 2009, 2013, 3),
(469, 7, 2009, 2013, 4),
(470, 7, 2009, 2013, 5),
(471, 8, 2009, 2013, 1),
(472, 8, 2009, 2013, 2),
(473, 8, 2009, 2013, 3),
(474, 8, 2009, 2013, 4),
(475, 8, 2009, 2013, 5),
(476, 9, 2009, 2013, 1),
(477, 9, 2009, 2013, 2),
(478, 9, 2009, 2013, 3),
(479, 9, 2009, 2013, 4),
(480, 9, 2009, 2013, 5),
(481, 2, 2010, 2014, 1),
(482, 2, 2010, 2014, 2),
(483, 2, 2010, 2014, 3),
(484, 2, 2010, 2014, 4),
(485, 2, 2010, 2014, 5),
(486, 3, 2010, 2014, 1),
(487, 3, 2010, 2014, 2),
(488, 3, 2010, 2014, 3),
(489, 3, 2010, 2014, 4),
(490, 3, 2010, 2014, 5),
(491, 4, 2010, 2014, 1),
(492, 4, 2010, 2014, 2),
(493, 4, 2010, 2014, 3),
(494, 4, 2010, 2014, 4),
(495, 4, 2010, 2014, 5),
(496, 5, 2010, 2014, 1),
(497, 5, 2010, 2014, 2),
(498, 5, 2010, 2014, 3),
(499, 5, 2010, 2014, 4),
(500, 5, 2010, 2014, 5),
(501, 6, 2010, 2014, 1),
(502, 6, 2010, 2014, 2),
(503, 6, 2010, 2014, 3),
(504, 6, 2010, 2014, 4),
(505, 6, 2010, 2014, 5),
(506, 7, 2010, 2014, 1),
(507, 7, 2010, 2014, 2),
(508, 7, 2010, 2014, 3),
(509, 7, 2010, 2014, 4),
(510, 7, 2010, 2014, 5),
(511, 8, 2010, 2014, 1),
(512, 8, 2010, 2014, 2),
(513, 8, 2010, 2014, 3),
(514, 8, 2010, 2014, 4),
(515, 8, 2010, 2014, 5),
(516, 9, 2010, 2014, 1),
(517, 9, 2010, 2014, 2),
(518, 9, 2010, 2014, 3),
(519, 9, 2010, 2014, 4),
(520, 9, 2010, 2014, 5),
(521, 2, 2011, 2015, 1),
(522, 2, 2011, 2015, 2),
(523, 2, 2011, 2015, 3),
(524, 2, 2011, 2015, 4),
(525, 2, 2011, 2015, 5),
(526, 3, 2011, 2015, 1),
(527, 3, 2011, 2015, 2),
(528, 3, 2011, 2015, 3),
(529, 3, 2011, 2015, 4),
(530, 3, 2011, 2015, 5),
(531, 4, 2011, 2015, 1),
(532, 4, 2011, 2015, 2),
(533, 4, 2011, 2015, 3),
(534, 4, 2011, 2015, 4),
(535, 4, 2011, 2015, 5),
(536, 5, 2011, 2015, 1),
(537, 5, 2011, 2015, 2),
(538, 5, 2011, 2015, 3),
(539, 5, 2011, 2015, 4),
(540, 5, 2011, 2015, 5),
(541, 6, 2011, 2015, 1),
(542, 6, 2011, 2015, 2),
(543, 6, 2011, 2015, 3),
(544, 6, 2011, 2015, 4),
(545, 6, 2011, 2015, 5),
(546, 7, 2011, 2015, 1),
(547, 7, 2011, 2015, 2),
(548, 7, 2011, 2015, 3),
(549, 7, 2011, 2015, 4),
(550, 7, 2011, 2015, 5),
(551, 8, 2011, 2015, 1),
(552, 8, 2011, 2015, 2),
(553, 8, 2011, 2015, 3),
(554, 8, 2011, 2015, 4),
(555, 8, 2011, 2015, 5),
(556, 9, 2011, 2015, 1),
(557, 9, 2011, 2015, 2),
(558, 9, 2011, 2015, 3),
(559, 9, 2011, 2015, 4),
(560, 9, 2011, 2015, 5),
(561, 2, 2012, 2016, 1),
(562, 2, 2012, 2016, 2),
(563, 2, 2012, 2016, 3),
(564, 2, 2012, 2016, 4),
(565, 2, 2012, 2016, 5),
(566, 3, 2012, 2016, 1),
(567, 3, 2012, 2016, 2),
(568, 3, 2012, 2016, 3),
(569, 3, 2012, 2016, 4),
(570, 3, 2012, 2016, 5),
(571, 4, 2012, 2016, 1),
(572, 4, 2012, 2016, 2),
(573, 4, 2012, 2016, 3),
(574, 4, 2012, 2016, 4),
(575, 4, 2012, 2016, 5),
(576, 5, 2012, 2016, 1),
(577, 5, 2012, 2016, 2),
(578, 5, 2012, 2016, 3),
(579, 5, 2012, 2016, 4),
(580, 5, 2012, 2016, 5),
(581, 6, 2012, 2016, 1),
(582, 6, 2012, 2016, 2),
(583, 6, 2012, 2016, 3),
(584, 6, 2012, 2016, 4),
(585, 6, 2012, 2016, 5),
(586, 7, 2012, 2016, 1),
(587, 7, 2012, 2016, 2),
(588, 7, 2012, 2016, 3),
(589, 7, 2012, 2016, 4),
(590, 7, 2012, 2016, 5),
(591, 8, 2012, 2016, 1),
(592, 8, 2012, 2016, 2),
(593, 8, 2012, 2016, 3),
(594, 8, 2012, 2016, 4),
(595, 8, 2012, 2016, 5),
(596, 9, 2012, 2016, 1),
(597, 9, 2012, 2016, 2),
(598, 9, 2012, 2016, 3),
(599, 9, 2012, 2016, 4),
(600, 9, 2012, 2016, 5),
(601, 2, 2013, 2017, 1),
(602, 2, 2013, 2017, 2),
(603, 2, 2013, 2017, 3),
(604, 2, 2013, 2017, 4),
(605, 2, 2013, 2017, 5),
(606, 3, 2013, 2017, 1),
(607, 3, 2013, 2017, 2),
(608, 3, 2013, 2017, 3),
(609, 3, 2013, 2017, 4),
(610, 3, 2013, 2017, 5),
(611, 4, 2013, 2017, 1),
(612, 4, 2013, 2017, 2),
(613, 4, 2013, 2017, 3),
(614, 4, 2013, 2017, 4),
(615, 4, 2013, 2017, 5),
(616, 5, 2013, 2017, 1),
(617, 5, 2013, 2017, 2),
(618, 5, 2013, 2017, 3),
(619, 5, 2013, 2017, 4),
(620, 5, 2013, 2017, 5),
(621, 6, 2013, 2017, 1),
(622, 6, 2013, 2017, 2),
(623, 6, 2013, 2017, 3),
(624, 6, 2013, 2017, 4),
(625, 6, 2013, 2017, 5),
(626, 7, 2013, 2017, 1),
(627, 7, 2013, 2017, 2),
(628, 7, 2013, 2017, 3),
(629, 7, 2013, 2017, 4),
(630, 7, 2013, 2017, 5),
(631, 8, 2013, 2017, 1),
(632, 8, 2013, 2017, 2),
(633, 8, 2013, 2017, 3),
(634, 8, 2013, 2017, 4),
(635, 8, 2013, 2017, 5),
(636, 9, 2013, 2017, 1),
(637, 9, 2013, 2017, 2),
(638, 9, 2013, 2017, 3),
(639, 9, 2013, 2017, 4),
(640, 9, 2013, 2017, 5),
(641, 2, 2014, 2018, 1),
(642, 2, 2014, 2018, 2),
(643, 2, 2014, 2018, 3),
(644, 2, 2014, 2018, 4),
(645, 2, 2014, 2018, 5),
(646, 3, 2014, 2018, 1),
(647, 3, 2014, 2018, 2),
(648, 3, 2014, 2018, 3),
(649, 3, 2014, 2018, 4),
(650, 3, 2014, 2018, 5),
(651, 4, 2014, 2018, 1),
(652, 4, 2014, 2018, 2),
(653, 4, 2014, 2018, 3),
(654, 4, 2014, 2018, 4),
(655, 4, 2014, 2018, 5),
(656, 5, 2014, 2018, 1),
(657, 5, 2014, 2018, 2),
(658, 5, 2014, 2018, 3),
(659, 5, 2014, 2018, 4),
(660, 5, 2014, 2018, 5),
(661, 6, 2014, 2018, 1),
(662, 6, 2014, 2018, 2),
(663, 6, 2014, 2018, 3),
(664, 6, 2014, 2018, 4),
(665, 6, 2014, 2018, 5),
(666, 7, 2014, 2018, 1),
(667, 7, 2014, 2018, 2),
(668, 7, 2014, 2018, 3),
(669, 7, 2014, 2018, 4),
(670, 7, 2014, 2018, 5),
(671, 8, 2014, 2018, 1),
(672, 8, 2014, 2018, 2),
(673, 8, 2014, 2018, 3),
(674, 8, 2014, 2018, 4),
(675, 8, 2014, 2018, 5),
(676, 9, 2014, 2018, 1),
(677, 9, 2014, 2018, 2),
(678, 9, 2014, 2018, 3),
(679, 9, 2014, 2018, 4),
(680, 9, 2014, 2018, 5),
(681, 2, 2015, 2019, 1),
(682, 2, 2015, 2019, 2),
(683, 2, 2015, 2019, 3),
(684, 2, 2015, 2019, 4),
(685, 2, 2015, 2019, 5),
(686, 3, 2015, 2019, 1),
(687, 3, 2015, 2019, 2),
(688, 3, 2015, 2019, 3),
(689, 3, 2015, 2019, 4),
(690, 3, 2015, 2019, 5),
(691, 4, 2015, 2019, 1),
(692, 4, 2015, 2019, 2),
(693, 4, 2015, 2019, 3),
(694, 4, 2015, 2019, 4),
(695, 4, 2015, 2019, 5),
(696, 5, 2015, 2019, 1),
(697, 5, 2015, 2019, 2),
(698, 5, 2015, 2019, 3),
(699, 5, 2015, 2019, 4),
(700, 5, 2015, 2019, 5),
(701, 6, 2015, 2019, 1),
(702, 6, 2015, 2019, 2),
(703, 6, 2015, 2019, 3),
(704, 6, 2015, 2019, 4),
(705, 6, 2015, 2019, 5),
(706, 7, 2015, 2019, 1),
(707, 7, 2015, 2019, 2),
(708, 7, 2015, 2019, 3),
(709, 7, 2015, 2019, 4),
(710, 7, 2015, 2019, 5),
(711, 8, 2015, 2019, 1),
(712, 8, 2015, 2019, 2),
(713, 8, 2015, 2019, 3),
(714, 8, 2015, 2019, 4),
(715, 8, 2015, 2019, 5),
(716, 9, 2015, 2019, 1),
(717, 9, 2015, 2019, 2),
(718, 9, 2015, 2019, 3),
(719, 9, 2015, 2019, 4),
(720, 9, 2015, 2019, 5);

-- --------------------------------------------------------

--
-- Table structure for table `um_configuration`
--

DROP TABLE IF EXISTS `um_configuration`;
CREATE TABLE IF NOT EXISTS `um_configuration` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(150) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_configuration`
--

INSERT INTO `um_configuration` (`id`, `name`, `value`) VALUES
(1, 'website_name', 'SNISTAA'),
(2, 'website_url', 'localhost/snistaf/'),
(3, 'email', 'forums@sreenidhi.edu.in'),
(4, 'activation', '0'),
(5, 'resend_activation_threshold', '0'),
(6, 'language', '../models/languages/en.php'),
(8, 'can_register', '1'),
(9, 'new_user_title', 'Potato'),
(11, 'email_login', '1'),
(12, 'token_timeout', '10800'),
(13, 'version', '0.2.2');

-- --------------------------------------------------------

--
-- Table structure for table `um_department`
--

DROP TABLE IF EXISTS `um_department`;
CREATE TABLE IF NOT EXISTS `um_department` (
`id` int(2) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `um_department`
--

INSERT INTO `um_department` (`id`, `name`) VALUES
(1, 'SH'),
(2, 'CSE'),
(3, 'IT'),
(4, 'ME'),
(5, 'BT'),
(6, 'Avionics'),
(7, 'ECE'),
(8, 'ECM'),
(9, 'EEE');

-- --------------------------------------------------------

--
-- Table structure for table `um_filelist`
--

DROP TABLE IF EXISTS `um_filelist`;
CREATE TABLE IF NOT EXISTS `um_filelist` (
`id` int(11) NOT NULL,
  `path` varchar(150) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `um_filelist`
--

INSERT INTO `um_filelist` (`id`, `path`) VALUES
(1, 'account'),
(2, 'forms');

-- --------------------------------------------------------

--
-- Table structure for table `um_groups`
--

DROP TABLE IF EXISTS `um_groups`;
CREATE TABLE IF NOT EXISTS `um_groups` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `can_delete` tinyint(1) NOT NULL,
  `home_page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_groups`
--

INSERT INTO `um_groups` (`id`, `name`, `is_default`, `can_delete`, `home_page_id`) VALUES
(1, 'User', 2, 0, 4),
(2, 'Administrator', 0, 0, 5),
(3, 'Faculty', 0, 1, 9),
(4, 'Moderatiors', 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `um_group_action_permits`
--

DROP TABLE IF EXISTS `um_group_action_permits`;
CREATE TABLE IF NOT EXISTS `um_group_action_permits` (
`id` int(10) unsigned NOT NULL,
  `group_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `permits` varchar(400) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_group_action_permits`
--

INSERT INTO `um_group_action_permits` (`id`, `group_id`, `action`, `permits`) VALUES
(1, 1, 'updateUserEmail', 'isLoggedInUser(user_id)'),
(2, 1, 'updateUserPassword', 'isLoggedInUser(user_id)'),
(3, 1, 'loadUser', 'isUserPrimaryGroup(user_id,''1'')'),
(4, 1, 'loadUserGroups', 'isLoggedInUser(user_id)'),
(5, 2, 'updateUserEmail', 'always()'),
(6, 2, 'updateUserPassword', 'always()'),
(7, 2, 'updateUser', 'always()'),
(8, 2, 'updateUserDisplayName', 'always()'),
(9, 2, 'updateUserTitle', 'always()'),
(10, 2, 'updateUserEnabled', 'always()'),
(11, 2, 'loadUser', 'always()'),
(12, 2, 'loadUserGroups', 'always()'),
(13, 2, 'loadUsers', 'always()'),
(14, 2, 'deleteUser', 'always()'),
(15, 2, 'activateUser', 'always()'),
(16, 2, 'loadGroups', 'always()'),
(17, 2, 'createForum', 'always()'),
(18, 2, 'createUserActionPermit', 'always()');

-- --------------------------------------------------------

--
-- Table structure for table `um_group_page_matches`
--

DROP TABLE IF EXISTS `um_group_page_matches`;
CREATE TABLE IF NOT EXISTS `um_group_page_matches` (
`id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_group_page_matches`
--

INSERT INTO `um_group_page_matches` (`id`, `group_id`, `page_id`) VALUES
(3, 2, 3),
(4, 2, 4),
(5, 2, 5),
(6, 2, 6),
(7, 2, 7),
(8, 2, 8),
(9, 2, 9),
(10, 2, 10),
(11, 2, 11),
(12, 2, 12),
(13, 2, 13),
(14, 2, 14),
(15, 2, 15),
(16, 2, 16),
(19, 1, 3),
(20, 1, 4),
(21, 1, 6),
(22, 1, 13),
(23, 1, 15),
(24, 1, 17),
(25, 2, 17),
(26, 3, 17),
(27, 4, 17),
(28, 1, 10),
(29, 1, 19),
(30, 1, 20),
(31, 1, 22);

-- --------------------------------------------------------

--
-- Table structure for table `um_nav`
--

DROP TABLE IF EXISTS `um_nav`;
CREATE TABLE IF NOT EXISTS `um_nav` (
`id` int(11) NOT NULL,
  `menu` varchar(75) NOT NULL,
  `page` varchar(175) NOT NULL,
  `name` varchar(150) NOT NULL,
  `position` int(11) NOT NULL,
  `class_name` varchar(150) NOT NULL,
  `icon` varchar(150) NOT NULL,
  `parent_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_nav`
--

INSERT INTO `um_nav` (`id`, `menu`, `page`, `name`, `position`, `class_name`, `icon`, `parent_id`) VALUES
(1, 'left', 'account/dashboard_admin.php', 'Admin Dashboard', 1, 'dashboard-admin', 'fa fa-dashboard', 0),
(2, 'left', 'account/users.php', 'Users', 2, 'users', 'fa fa-users', 0),
(3, 'left', 'account/dashboard.php', 'Dashboard', 3, 'dashboard', 'fa fa-dashboard', 0),
(4, 'left', 'account/account_settings.php', 'Account Settings', 4, 'settings', 'fa fa-gear', 0),
(5, 'left-sub', '#', 'Site Settings', 5, '', 'fa fa-wrench', 0),
(6, 'left-sub', 'account/site_settings.php', 'Site Configuration', 6, 'site-settings', 'fa fa-globe', 5),
(7, 'left-sub', 'account/groups.php', 'Groups', 7, 'groups', 'fa fa-users', 5),
(8, 'left-sub', 'account/site_authorization.php', 'Authorization', 8, 'site-pages', 'fa fa-key', 5),
(9, 'top-main-sub', '#', '#USERNAME#', 1, 'site-settings', 'fa fa-user', 0),
(10, 'top-main-sub', 'account/account_settings.php', 'Account Settings', 1, '', 'fa fa-gear', 9),
(11, 'top-main-sub', 'account/logout.php', 'Log Out', 2, '', 'fa fa-power-off', 9),
(12, 'left', 'forum/index.php', 'Forum', 3, '', 'fa fa-globe', 0),
(13, 'top-main', 'privatemessages/pm.php', 'Private Messages', -1, 'pms', 'fa fa-envelope', 0),
(14, 'left', 'modules/invite/account/invite.php', 'Invite friends', 11, 'invite', 'fa fa-user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `um_nav_group_matches`
--

DROP TABLE IF EXISTS `um_nav_group_matches`;
CREATE TABLE IF NOT EXISTS `um_nav_group_matches` (
`id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_nav_group_matches`
--

INSERT INTO `um_nav_group_matches` (`id`, `menu_id`, `group_id`) VALUES
(1, 3, 1),
(2, 4, 1),
(3, 9, 1),
(4, 10, 1),
(5, 11, 1),
(6, 1, 2),
(7, 2, 2),
(8, 5, 2),
(9, 6, 2),
(10, 7, 2),
(11, 8, 2),
(12, 12, 1),
(13, 13, 1),
(14, 0, 1),
(15, 14, 2);

-- --------------------------------------------------------

--
-- Table structure for table `um_pages`
--

DROP TABLE IF EXISTS `um_pages`;
CREATE TABLE IF NOT EXISTS `um_pages` (
`id` int(11) NOT NULL,
  `page` varchar(150) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_pages`
--

INSERT INTO `um_pages` (`id`, `page`, `private`) VALUES
(1, 'forms/table_users.php', 1),
(3, 'account/logout.php', 1),
(4, 'account/dashboard.php', 1),
(5, 'account/dashboard_admin.php', 1),
(6, 'account/account_settings.php', 1),
(7, 'account/site_authorization.php', 1),
(8, 'account/site_settings.php', 1),
(9, 'account/users.php', 1),
(10, 'account/user_details.php', 1),
(11, 'account/index.php', 0),
(12, 'account/groups.php', 1),
(13, 'forms/form_user.php', 1),
(14, 'forms/form_group.php', 1),
(15, 'forms/form_confirm_delete.php', 1),
(16, 'forms/form_action_permits.php', 1),
(17, 'account/404.php', 1),
(18, 'privatemessages/index.php', 0),
(19, 'privatemessages/pm.php', 1),
(20, 'privatemessages/forms/form_message.php', 1),
(21, 'modules/invite/account/invite.php', 1),
(22, 'account/Profile.php', 0);

-- --------------------------------------------------------

--
-- Table structure for table `um_plugin_configuration`
--

DROP TABLE IF EXISTS `um_plugin_configuration`;
CREATE TABLE IF NOT EXISTS `um_plugin_configuration` (
`id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(150) NOT NULL,
  `binary` int(1) NOT NULL,
  `variable` varchar(150) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_plugin_configuration`
--

INSERT INTO `um_plugin_configuration` (`id`, `name`, `value`, `binary`, `variable`) VALUES
(1, 'PM System', '1', 1, '$pmsystem');

-- --------------------------------------------------------

--
-- Table structure for table `um_plugin_pm`
--

DROP TABLE IF EXISTS `um_plugin_pm`;
CREATE TABLE IF NOT EXISTS `um_plugin_pm` (
`id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `time_sent` int(11) NOT NULL,
  `time_read` int(11) NOT NULL DEFAULT '0',
  `receiver_read` tinyint(1) DEFAULT '0',
  `sender_deleted` tinyint(1) DEFAULT '0',
  `receiver_deleted` tinyint(1) DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_plugin_pm`
--

INSERT INTO `um_plugin_pm` (`id`, `sender_id`, `receiver_id`, `title`, `message`, `time_sent`, `time_read`, `receiver_read`, `sender_deleted`, `receiver_deleted`, `parent_id`) VALUES
(1, 1, 1, 'demo mesage', 'demo', 1428822744, 0, 0, 0, 0, NULL),
(2, 2, 1, 'dude', 'hello dude', 1428823148, 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `um_users`
--

DROP TABLE IF EXISTS `um_users`;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_users`
--

INSERT INTO `um_users` (`id`, `user_name`, `display_name`, `password`, `email`, `activation_token`, `last_activation_request`, `lost_password_request`, `lost_password_timestamp`, `active`, `title`, `sign_up_stamp`, `last_sign_in_stamp`, `enabled`, `primary_group_id`) VALUES
(1, 'goku', 'Goku', '$2y$10$alYFtsgzj4q2zkrfoQU2.eOX2q/LiXDesu/lOdsyekD2HCxisRLo.', 'srikanthkasukurti@gmail.com', '2ea9269b4e0b275d109962db23c10824', 1426868943, 0, 1426868943, 1, 'Master Account', 1426868943, 1429443345, 1, 2),
(2, 'demo', 'demouser', '$2y$10$Z56GefM9ke/Jt3EFRK2qCOodCkCdGjTPjtCJ9tWGK8UmfrTfp5RAa', 'demo@localhost.com', '312bd281cbd3f3bec2be3433967071da', 1428119642, 0, 1428119642, 1, 'Idly', 1428119642, 1429437098, 1, 1),
(7, 'demo23', 'demoUser23', '$2y$10$5d2V5Zzue7/XTrDqErJAgeR9RMupdOCKyPEvdpQc8bq550/CFRd3i', 'demo23@localhost.loc', 'b2b4aa468cce977e320db0f347a12772', 1429424595, 0, 1429424595, 1, 'Potato', 1429424595, 0, 1, 1),
(8, 'demo2', 'demouser2', '$2y$10$zSkYSNCKJuBWHdSNjs0Bteks2QFxouFXLfG20gOTtGmAFDz0K60p2', 'demo2@localhost.loc', '9e6cac099e839a89e9733694b4130344', 1429424757, 0, 1429424757, 1, 'Potato', 1429424757, 1429424767, 1, 1),
(9, 'demoalumni', 'AlumniDemoUser', '$2y$10$OwxSC2LAahUItK0dmxxtN.qhaOXTNPg7sofHIeY.rtMSXHaUq54Sa', 'alumni@localhost.loc', 'f577cb8a54ba47f5ccb787042c9bff2c', 1429429111, 0, 1429429111, 1, 'Potato', 1429429111, 0, 1, 1),
(10, 'demoalumni2', 'alumua', '$2y$10$yXnmTTVv3nXHbSGWmAqfi.uyoqUUTpyu1wYsY6tW3Xfnms.IzpUvO', 'almu@loclhost.loc', 'a2379402ef2106636c057dd3b68d4bed', 1429429373, 0, 1429429373, 1, 'Potato', 1429429373, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `um_user_action_permits`
--

DROP TABLE IF EXISTS `um_user_action_permits`;
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

DROP TABLE IF EXISTS `um_user_details`;
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
-- Dumping data for table `um_user_details`
--

INSERT INTO `um_user_details` (`id`, `full_name`, `roll_no`, `department`, `year_join`, `year_end`, `isAlumni`, `feedback_done`) VALUES
(10, 'almund', '0147852369', 2, 2000, 2004, 1, 0),
(9, 'Alumni Anthony', '0701010101', 2, 2007, 2011, 1, 0),
(8, 'demodabidi', '11311A05H2', 2, 2000, 2004, 1, 0),
(7, 'demoramu23', 'a123487776', 2, 2012, 2015, 0, 0),
(1, 'Son Goku', '1', 2, 0, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `um_user_group_matches`
--

DROP TABLE IF EXISTS `um_user_group_matches`;
CREATE TABLE IF NOT EXISTS `um_user_group_matches` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_user_group_matches`
--

INSERT INTO `um_user_group_matches` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 4),
(5, 7, 1),
(6, 8, 1),
(7, 9, 1),
(8, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `um_user_levels`
--

DROP TABLE IF EXISTS `um_user_levels`;
CREATE TABLE IF NOT EXISTS `um_user_levels` (
`id` int(11) NOT NULL,
  `title` varchar(50) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `um_user_levels`
--

INSERT INTO `um_user_levels` (`id`, `title`) VALUES
(1, 'Potato'),
(2, 'Stone'),
(3, 'Rabbit'),
(4, 'Noob'),
(5, 'Wizard'),
(6, 'Dragon'),
(7, 'King'),
(8, 'OverLord'),
(9, 'Chuck Norris'),
(10, 'Rajni Kanth');

-- --------------------------------------------------------

--
-- Table structure for table `um_user_subscriptions`
--

DROP TABLE IF EXISTS `um_user_subscriptions`;
CREATE TABLE IF NOT EXISTS `um_user_subscriptions` (
  `uid` int(10) NOT NULL,
  `fid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `um_user_subscriptions`
--

INSERT INTO `um_user_subscriptions` (`uid`, `fid`) VALUES
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 32),
(1, 34),
(1, 36),
(2, 17),
(2, 28),
(2, 32),
(2, 34),
(2, 35),
(9, 36);

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
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`), ADD UNIQUE KEY `name_2` (`name`), ADD KEY `type` (`type`);

--
-- Indexes for table `fo_mandate_subscriptions`
--
ALTER TABLE `fo_mandate_subscriptions`
 ADD KEY `forumid` (`forumid`);

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
-- Indexes for table `fo_thread_stats`
--
ALTER TABLE `fo_thread_stats`
 ADD KEY `tid` (`tid`);

--
-- Indexes for table `fo_type`
--
ALTER TABLE `fo_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uf_invites`
--
ALTER TABLE `uf_invites`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uf_user_invites`
--
ALTER TABLE `uf_user_invites`
 ADD UNIQUE KEY `userId` (`userId`);

--
-- Indexes for table `um_batches`
--
ALTER TABLE `um_batches`
 ADD PRIMARY KEY (`id`), ADD KEY `deptid` (`deptid`);

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
-- Indexes for table `um_plugin_pm`
--
ALTER TABLE `um_plugin_pm`
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
-- Indexes for table `um_user_levels`
--
ALTER TABLE `um_user_levels`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_user_subscriptions`
--
ALTER TABLE `um_user_subscriptions`
 ADD UNIQUE KEY `uid_2` (`uid`,`fid`), ADD UNIQUE KEY `uid_3` (`uid`,`fid`), ADD KEY `uid` (`uid`), ADD KEY `fid` (`fid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fo_forums`
--
ALTER TABLE `fo_forums`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `fo_posts`
--
ALTER TABLE `fo_posts`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `fo_threads`
--
ALTER TABLE `fo_threads`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `fo_type`
--
ALTER TABLE `fo_type`
MODIFY `id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `uf_invites`
--
ALTER TABLE `uf_invites`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `um_batches`
--
ALTER TABLE `um_batches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=721;
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `um_nav`
--
ALTER TABLE `um_nav`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `um_nav_group_matches`
--
ALTER TABLE `um_nav_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `um_pages`
--
ALTER TABLE `um_pages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT for table `um_plugin_configuration`
--
ALTER TABLE `um_plugin_configuration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `um_plugin_pm`
--
ALTER TABLE `um_plugin_pm`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `um_users`
--
ALTER TABLE `um_users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `um_user_action_permits`
--
ALTER TABLE `um_user_action_permits`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `um_user_group_matches`
--
ALTER TABLE `um_user_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `um_user_levels`
--
ALTER TABLE `um_user_levels`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
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
-- Constraints for table `fo_mandate_subscriptions`
--
ALTER TABLE `fo_mandate_subscriptions`
ADD CONSTRAINT `fo_mandate_subscriptions_ibfk_1` FOREIGN KEY (`forumid`) REFERENCES `fo_forums` (`id`);

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
-- Constraints for table `fo_thread_stats`
--
ALTER TABLE `fo_thread_stats`
ADD CONSTRAINT `fo_thread_stats_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `fo_threads` (`id`);

--
-- Constraints for table `um_batches`
--
ALTER TABLE `um_batches`
ADD CONSTRAINT `um_batches_ibfk_1` FOREIGN KEY (`deptid`) REFERENCES `um_department` (`id`);

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
