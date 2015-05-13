-- phpMyAdmin SQL Dump
-- version 4.2.12deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 13, 2015 at 01:56 PM
-- Server version: 5.6.24-0ubuntu2
-- PHP Version: 5.6.4-4ubuntu6

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
SET forums=department+"_";
SET forums=forums+yj;
SET forums=forums+"-";
SET forums=forums+ye;
INSERT IGNORE INTO fo_forums(name,description,type) VALUES(forums,forums,'3');
SET id=(SELECT id from fo_forums where name=forums LIMIT 1);
INSERT INTO um_user_subscriptions VALUES(uid,id);
SET forums="snist ";
SET forums=forums+yj;
SET forums=forums+"-";
SET forums=forums+ye;
INSERT IGNORE INTO fo_forums(name,description,type) VALUES(forums,forums,'3'); 
SET id=(SELECT id from fo_forums where name=forums LIMIT 1);
INSERT INTO um_user_subscriptions VALUES(uid,id);
END$$

DROP PROCEDURE IF EXISTS `feedbackBasic`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `feedbackBasic`(IN `id` INT UNSIGNED, OUT `count` FLOAT UNSIGNED)
    READS SQL DATA
    COMMENT 'returns feedback statistics for feedback template'
BEGIN
set count=(SELECT avg(answer) from fb_question_answers where tid=id);
END$$

DROP PROCEDURE IF EXISTS `feedbackQuestion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `feedbackQuestion`(IN `id` INT UNSIGNED, OUT `count` FLOAT UNSIGNED)
    READS SQL DATA
    COMMENT 'returns feedback average for each question'
BEGIN
set count=(SELECT avg(answer) from fb_question_answers where wid=id);
END$$

DROP PROCEDURE IF EXISTS `feedbackUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `feedbackUser`(IN `id` INT UNSIGNED, OUT `count` FLOAT UNSIGNED)
    READS SQL DATA
    COMMENT 'reads feedback stats based on userr id'
BEGIN
DECLARE sessionid INT;
SET sessionid=(SELECT id from fb_session WHERE userId=id);
SET count=(SELECT avg(answer) from fb_question_answer where uid=sessionid);
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
  `m` int(11) NOT NULL,
  `n` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `q` int(11) NOT NULL,
  `r` int(11) NOT NULL,
  `s` int(11) NOT NULL,
  `t` int(11) NOT NULL,
  `u` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_alumni_curriculim`
--

INSERT INTO `fb_alumni_curriculim` (`uid`, `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`, `l`, `m`, `n`, `o`, `p`, `q`, `r`, `s`, `t`, `u`) VALUES
(9, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_employability`
--

DROP TABLE IF EXISTS `fb_alumni_employability`;
CREATE TABLE IF NOT EXISTS `fb_alumni_employability` (
  `uid` int(11) NOT NULL,
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL,
  `e` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_alumni_employability`
--

INSERT INTO `fb_alumni_employability` (`uid`, `a`, `b`, `c`, `d`, `e`) VALUES
(9, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_impression`
--

DROP TABLE IF EXISTS `fb_alumni_impression`;
CREATE TABLE IF NOT EXISTS `fb_alumni_impression` (
  `uid` int(11) NOT NULL,
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
  `k` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_alumni_impression`
--

INSERT INTO `fb_alumni_impression` (`uid`, `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`) VALUES
(9, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_objectives`
--

DROP TABLE IF EXISTS `fb_alumni_objectives`;
CREATE TABLE IF NOT EXISTS `fb_alumni_objectives` (
  `uid` int(11) NOT NULL,
  `a` int(11) NOT NULL,
  `b` int(11) NOT NULL,
  `c` int(11) NOT NULL,
  `d` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_alumni_objectives`
--

INSERT INTO `fb_alumni_objectives` (`uid`, `a`, `b`, `c`, `d`) VALUES
(2, 5, 5, 5, 5),
(2, 0, 0, 0, 0),
(2, 0, 0, 0, 0),
(2, 0, 0, 0, 0),
(2, 0, 0, 0, 0),
(9, 4, 4, 4, 4),
(25, 5, 5, 5, 5);

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

--
-- Dumping data for table `fb_alumni_outcomes`
--

INSERT INTO `fb_alumni_outcomes` (`uid`, `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`, `l`, `m`) VALUES
(9, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4),
(25, 5, 5, 55, 5, 5, 55, 5, 55, 5, 5, 5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `fb_alumni_suggestion`
--

DROP TABLE IF EXISTS `fb_alumni_suggestion`;
CREATE TABLE IF NOT EXISTS `fb_alumni_suggestion` (
  `uid` int(11) NOT NULL,
  `a` text COLLATE latin1_general_ci NOT NULL,
  `b` text COLLATE latin1_general_ci NOT NULL,
  `c` text COLLATE latin1_general_ci NOT NULL,
  `d` text COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_alumni_suggestion`
--

INSERT INTO `fb_alumni_suggestion` (`uid`, `a`, `b`, `c`, `d`) VALUES
(9, 'blah blah', 'blah blah blah', 'blah ', 'blaah blah bluh bla'),
(9, 'blah blah', 'blah blah blah', 'blah ', 'blaah blah bluh bla'),
(9, 'blah blah', 'blah blah blah', 'blah ', 'blaah blah bluh bla'),
(9, 'blah blah', 'blah blah blah', 'blah ', 'blaah blah bluh bla'),
(9, 'blah blah', 'blah blah blah', 'blah ', 'blaah blah bluh bla');

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

--
-- Dumping data for table `fb_employer_objectives`
--

INSERT INTO `fb_employer_objectives` (`uid`, `peoa`, `peob`, `peoc`, `peod`) VALUES
(9, 4, 4, 4, 4),
(9, 5, 5, 5, 5);

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

--
-- Dumping data for table `fb_employer_outcomes`
--

INSERT INTO `fb_employer_outcomes` (`uid`, `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`, `l`, `m`) VALUES
(9, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4);

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

--
-- Dumping data for table `fb_employer_skills`
--

INSERT INTO `fb_employer_skills` (`uid`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`, `13`, `14`, `15`) VALUES
(9, 4, 4, 4, 4, 44, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0);

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

--
-- Dumping data for table `fb_parent_college`
--

INSERT INTO `fb_parent_college` (`uid`, `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`) VALUES
(9, 4, 4, 4, 4, 4, 4, 4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_answers`
--

DROP TABLE IF EXISTS `fb_question_answers`;
CREATE TABLE IF NOT EXISTS `fb_question_answers` (
`id` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `qid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `answer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_options`
--

DROP TABLE IF EXISTS `fb_question_options`;
CREATE TABLE IF NOT EXISTS `fb_question_options` (
`id` int(11) NOT NULL,
  `options` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_question_options`
--

INSERT INTO `fb_question_options` (`id`, `options`, `status`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_options_mapping`
--

DROP TABLE IF EXISTS `fb_question_options_mapping`;
CREATE TABLE IF NOT EXISTS `fb_question_options_mapping` (
  `qid` int(11) NOT NULL,
  `oid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_question_options_mapping`
--

INSERT INTO `fb_question_options_mapping` (`qid`, `oid`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(26, 2),
(27, 2),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(33, 2),
(34, 2),
(35, 2),
(36, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(49, 2),
(50, 2),
(51, 2),
(52, 2),
(53, 2),
(54, 2),
(55, 2),
(56, 2),
(57, 2),
(58, 2),
(59, 2),
(60, 2),
(61, 2),
(62, 2),
(63, 2),
(64, 2),
(65, 2),
(66, 2),
(67, 2),
(68, 2),
(69, 2),
(70, 2),
(71, 2),
(72, 2),
(73, 2),
(74, 2),
(75, 2),
(76, 2),
(77, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(31, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 3),
(40, 3),
(41, 3),
(42, 3),
(43, 3),
(44, 3),
(45, 3),
(46, 3),
(47, 3),
(48, 3),
(49, 3),
(50, 3),
(51, 3),
(52, 3),
(53, 3),
(54, 3),
(55, 3),
(56, 3),
(57, 3),
(58, 3),
(59, 3),
(60, 3),
(61, 3),
(62, 3),
(63, 3),
(64, 3),
(65, 3),
(66, 3),
(67, 3),
(68, 3),
(69, 3),
(70, 3),
(71, 3),
(72, 3),
(73, 3),
(74, 3),
(75, 3),
(76, 3),
(77, 3),
(1, 4),
(2, 4),
(3, 4),
(4, 4),
(5, 4),
(6, 4),
(7, 4),
(8, 4),
(9, 4),
(10, 4),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4),
(19, 4),
(20, 4),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 4),
(27, 4),
(28, 4),
(29, 4),
(30, 4),
(31, 4),
(32, 4),
(33, 4),
(34, 4),
(35, 4),
(36, 4),
(37, 4),
(38, 4),
(39, 4),
(40, 4),
(41, 4),
(42, 4),
(43, 4),
(44, 4),
(45, 4),
(46, 4),
(47, 4),
(48, 4),
(49, 4),
(50, 4),
(51, 4),
(52, 4),
(53, 4),
(54, 4),
(55, 4),
(56, 4),
(57, 4),
(58, 4),
(59, 4),
(60, 4),
(61, 4),
(62, 4),
(63, 4),
(64, 4),
(65, 4),
(66, 4),
(67, 4),
(68, 4),
(69, 4),
(70, 4),
(71, 4),
(72, 4),
(73, 4),
(74, 4),
(75, 4),
(76, 4),
(77, 4),
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5),
(7, 5),
(8, 5),
(9, 5),
(10, 5),
(11, 5),
(12, 5),
(13, 5),
(14, 5),
(15, 5),
(16, 5),
(17, 5),
(18, 5),
(19, 5),
(20, 5),
(21, 5),
(22, 5),
(23, 5),
(24, 5),
(25, 5),
(26, 5),
(27, 5),
(28, 5),
(29, 5),
(30, 5),
(31, 5),
(32, 5),
(33, 5),
(34, 5),
(35, 5),
(36, 5),
(37, 5),
(38, 5),
(39, 5),
(40, 5),
(41, 5),
(42, 5),
(43, 5),
(44, 5),
(45, 5),
(46, 5),
(47, 5),
(48, 5),
(49, 5),
(50, 5),
(51, 5),
(52, 5),
(53, 5),
(54, 5),
(55, 5),
(56, 5),
(57, 5),
(58, 5),
(59, 5),
(60, 5),
(61, 5),
(62, 5),
(63, 5),
(64, 5),
(65, 5),
(66, 5),
(67, 5),
(68, 5),
(69, 5),
(70, 5),
(71, 5),
(72, 5),
(73, 5),
(74, 5),
(75, 5),
(76, 5),
(77, 5);

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_template`
--

DROP TABLE IF EXISTS `fb_question_template`;
CREATE TABLE IF NOT EXISTS `fb_question_template` (
`id` int(11) NOT NULL,
  `question_template` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_question_template`
--

INSERT INTO `fb_question_template` (`id`, `question_template`, `status`) VALUES
(1, 'alumni_objectives', 1),
(2, 'alumni_outcomes', 1),
(3, 'alumni_curriculum', 1),
(4, 'alumni_impression', 1),
(5, 'alumni_employability', 1),
(6, 'alumni_suggestion', 1),
(7, 'employer_objectives', 1),
(8, 'employer_outcomes', 1),
(9, 'employer_skills', 1),
(10, 'parent_college', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_template_mapping`
--

DROP TABLE IF EXISTS `fb_question_template_mapping`;
CREATE TABLE IF NOT EXISTS `fb_question_template_mapping` (
  `qid` int(11) NOT NULL,
  `tid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_question_template_mapping`
--

INSERT INTO `fb_question_template_mapping` (`qid`, `tid`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 5),
(19, 3),
(20, 3),
(21, 3),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(31, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 4),
(40, 4),
(41, 4),
(42, 4),
(43, 4),
(44, 4),
(45, 4),
(46, 4),
(47, 4),
(48, 4),
(49, 4),
(50, 5),
(51, 5),
(52, 5),
(53, 5),
(54, 5),
(1, 7),
(2, 7),
(3, 7),
(4, 7),
(5, 8),
(6, 8),
(7, 8),
(8, 8),
(9, 8),
(10, 8),
(11, 8),
(12, 8),
(13, 8),
(14, 8),
(15, 8),
(16, 8),
(17, 8),
(55, 9),
(56, 9),
(57, 9),
(58, 9),
(59, 9),
(60, 9),
(61, 9),
(62, 9),
(63, 9),
(64, 9),
(65, 9),
(66, 9),
(67, 9),
(68, 9),
(69, 9),
(70, 10),
(71, 10),
(72, 10),
(73, 10),
(74, 10),
(75, 10),
(76, 10),
(77, 10);

-- --------------------------------------------------------

--
-- Table structure for table `fb_question_type`
--

DROP TABLE IF EXISTS `fb_question_type`;
CREATE TABLE IF NOT EXISTS `fb_question_type` (
`id` int(11) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_question_type`
--

INSERT INTO `fb_question_type` (`id`, `name`) VALUES
(1, 'Rating'),
(2, 'Text'),
(3, 'Boolean'),
(4, 'CheckBox'),
(5, 'RadioBox');

-- --------------------------------------------------------

--
-- Table structure for table `fb_session`
--

DROP TABLE IF EXISTS `fb_session`;
CREATE TABLE IF NOT EXISTS `fb_session` (
`id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `done` int(11) NOT NULL DEFAULT '0',
  `nonUMUser` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fb_snist_questions`
--

DROP TABLE IF EXISTS `fb_snist_questions`;
CREATE TABLE IF NOT EXISTS `fb_snist_questions` (
`id` int(11) NOT NULL,
  `question` varchar(2048) COLLATE latin1_general_ci NOT NULL,
  `type` int(2) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fb_snist_questions`
--

INSERT INTO `fb_snist_questions` (`id`, `question`, `type`, `status`) VALUES
(1, 'PEO –A: Graduates of the program will have requisite engineering knowledge with abilities for analysis of the problem and to design, development of solutions and to arrive at an optimal solution using modern tools which help them to be employable.', 1, 1),
(2, 'PEO–B: Ability to work in a team/ lead a team which needs effective communication skills and knowledge of project management, finance and entrepreneurial abilities.', 1, 1),
(3, 'PEO-C: Graduates should have abilities to conduct investigation of complex problems and attitude for lifelong learning skills which will enable them to pursue advanced studies, Research and Development.	', 1, 1),
(4, 'PEO-D: The graduates must be aware of the engineering professional ethics, the impact of engineering profession on the society and the need for environmental protection and sustainable development', 1, 1),
(5, 'An ability to apply knowledge of basic sciences, mathematics and engineering in the area of Computer Science.', 1, 1),
(6, 'An ability to design, implement and evaluate a software or software / hardware system to meet the desired needs within realistic constraints such as space and time.', 1, 1),
(7, 'An ability to use the techniques, skills, and modern engineering tools such as software testing tools, data warehousing and mining tools, necessary for practice as a CSE professional.', 1, 1),
(8, 'An ability to analyze and solve open-ended problems using mathematical foundations, algorithmic principles, and computer science theory in the modeling and design of computer-based systems in a way that demonstrates comprehension of the tradeoffs involved in design choices and to arrive at an optimal solution', 1, 1),
(9, 'To understand principles of engineering, entrepreneurship with emphasis on women, and financial management through relevant management courses to demonstrate knowledge in the conceptualization and realizing group projects, mini & main projects.', 1, 1),
(10, 'An ability to function effectively as individual and as a member or leader in diverse team in achieving multidisciplinary tasks.', 1, 1),
(11, 'Learn to communicate effectively on complex engineering activities through report writing, experimental work, assignments, seminars, group projects, mini & main projects.', 1, 1),
(12, 'To recognize the need for and have the preparation and ability to be a life-long learner through the courses such as seminars & projects.', 1, 1),
(13, 'An ability to identify, formulate and analyze engineering problems.', 1, 1),
(14, 'An ability to conduct investigation of complex problems in multidisciplinary areas.', 1, 1),
(15, 'An understanding of professional ethics and responsibilities.', 1, 1),
(16, 'An engineer should be aware of social, safety, cultural and information security issues and also responsibilities relevant to professional practice and skills.', 1, 1),
(17, 'An ability to understand the impact of environmental protection and sustainable development', 1, 1),
(18, 'Rate the syllabus of the programme with regard to proper distribution of the subjects in the areas of basic sciences including mathematics, humanities and management courses, interdisciplinary courses, departmental core courses, electives and projects', 1, 1),
(19, 'Rate your opinion on % of credits given in your curriculum for Basic Sciences including Mathematics - Presently about 15%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]', 1, 1),
(20, 'Rate your opinion on % of credits given in your curriculum for Humanities and Management courses - Presently about 10%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]', 1, 1),
(21, 'Rate your opinion on % of credits given in your curriculum for Professional Core - Presently about 50%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1].', 1, 1),
(22, 'Rate your opinion on % of credits given in your curriculum for Electives - Presently about 15%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]', 1, 1),
(23, 'Rate your opinion on % of credits given in your curriculum for Other inter disciplinary Courses - Presently about 10%. If you think this proportion is OK pl. Rank as 5 or else [4/3/2/1]', 1, 1),
(24, 'Rate the extent of usefulness with regard to Basic Sciences including Mathematics .', 1, 1),
(25, 'Rate the extent of usefulness with regard to Humanities and Management courses.', 1, 1),
(26, 'Rate the extent of usefulness with regard to Professional Core ', 1, 1),
(27, 'Rate the extent of usefulness with regard to Electives.', 1, 1),
(28, 'Rate the extent of usefulness with regard to inter disciplinary Courses .', 1, 1),
(29, 'Rate the syllabus content of Basic Sciences including Mathematics was easy or difficult.', 1, 1),
(30, 'Rate the syllabus content of Humanities and Management courses was easy or difficult.', 1, 1),
(31, 'Rate the syllabus content of Professional Core was easy or difficult.', 1, 1),
(32, 'Rate the syllabus content of Electives was easy or difficult.', 1, 1),
(33, 'Rate the syllabus content of inter disciplinary Courses was easy or difficult.', 1, 1),
(34, 'Rate the overall programme', 1, 1),
(35, 'Rate the extent of Opportunities given to you to perform as team member / team leader.[group, mini , major project, co-curricular and extra-curricular activities such as ADASTRA, SREEVISION, ARTS CLUB, ROBOVEDA, SPARDHA etc..', 1, 1),
(36, 'Rate the extent of conduct of Seminars, workshops and student development programmes has enabled you to improve oral, written communication and technical skills.', 1, 1),
(37, 'Rate the extent of attainment of technical abilities through group, mini and main projects to face the challenges of taking up new projects in your professional career .', 1, 1),
(38, 'Rate the extent of utility of IT courses and software tools to design and develop the application were adequate in your professional advancement .', 1, 1),
(39, 'Pl. rate the facilities provided in the class rooms [ LCDs’ , OHPs’, Lighting etc..]', 1, 1),
(40, 'Rate the functioning of the Laboratory equipment [Facility for conduct of experiment ]', 1, 1),
(41, 'Rate the services provided by the library[ book bank schemes etc]', 1, 1),
(42, 'Rate the computing services at SNIST ?[Software facilities, Internet , WiFi , Xerox facility , Printing facility ]', 1, 1),
(43, 'Pl. rate the encouragement given by the Executive Director / Principal and others in the Co-Curricular activities under the banner of IEEE, ISTE, IETE etc.', 1, 1),
(44, 'Pl. rate the extent of facilities provided to you for sports and games at SNIST ?', 1, 1),
(45, 'Rate the encouragement given for Extra-Curricular activities for personality development activities under ARTS CLUB, SPARDA etc.', 1, 1),
(46, 'Rate encouragement given engaging in service given to society . [ Bachpan Bachao, Street Cause, NSS etc.]', 1, 1),
(47, 'Rate the quality of Hostel facilities available ?[pl. answer if you are using this]', 1, 1),
(48, 'Rate the Canteen facilities available at SNIST. [pl. answer if you are using this]', 1, 1),
(49, 'Rate the administration services provided by the college. [Physical Education , Transport , Accounts etc.]', 1, 1),
(50, 'Pl. rate provision of employability enhancement activity through curriculum itself [ LR, QA, Soft skills]', 1, 1),
(51, 'Rate provision of employability enhancement activity through external experts [ CRT etc.]', 1, 1),
(52, 'Rate the study/practice material given to you for employability enhancement.', 1, 1),
(53, 'Rate the Career Guidance received through faculty and External Trainers', 1, 1),
(54, 'Rate the Placement services , Placement intimation / off campus placement etc.', 1, 1),
(55, 'Pl. rate the ability to use technology such as Information Technology tools and other office technology.', 1, 1),
(56, 'Pl. rate the ability to complete tasks accurately with few errors; making sure established standards and processes are met.', 1, 1),
(57, 'Pl. rate the ability to utilize the time in a productive way and Prioritize responsibilities effectively', 1, 1),
(58, 'Rate the oral and written communication skills', 1, 1),
(59, 'Rate the ability to evaluate a situation objectively and decide upon an appropriate course of action or solution to a problem', 1, 1),
(60, 'Rate the extent of ownership of the job and accepts the related responsibilities in their entirety. Takes responsibility for the both the successes and mistakes that are realized', 1, 1),
(61, 'Rate his/her privacy of others and follows office’s guidelines for confidentiality', 1, 1),
(62, 'Rate his/her ability to be proactive or asks supervisor for new tasks after all assigned work is completed.', 1, 1),
(63, 'Rate his/her cooperation with other team members in tasks, sharing responsibilities, and working towards common goals.', 1, 1),
(64, 'Rate his/her ability to get along with others and sensitivity to different ethnic, cultural, age, gender, education. Willingness to ask supervisor for clarification when unsure of responsibilities', 1, 1),
(65, 'Rate his/her attitude on being punctual.', 1, 1),
(66, 'Rate his/her ability to accept new assignments/respond well to changes in policy or process, integrates easily with new people, readily agrees to revision in schedule.', 1, 1),
(67, 'Rate his/her ability to collaborate and engage in multidisciplinary tasks', 1, 1),
(68, 'Rate his/her ability to acquire professional ethics and intellectual integrity and good conduct', 1, 1),
(69, 'Rate his/her compliance to organizational policies regarding professional office decorum i.e. dress code, visitor policy.', 1, 1),
(70, 'Infrastructure of the College', 1, 1),
(71, 'Faculty', 1, 1),
(72, 'Curricular aspects of the college', 1, 1),
(73, 'Placement', 1, 1),
(74, 'Discipline of the College', 1, 1),
(75, 'Library', 1, 1),
(76, 'Cocurricular and extra curricular activities (Sports/Games/NSS/Cultural)', 1, 1),
(77, 'Development of Employability skills (Campus recruitment training facilities)', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `fb_user_type_template_mapping`
--

DROP TABLE IF EXISTS `fb_user_type_template_mapping`;
CREATE TABLE IF NOT EXISTS `fb_user_type_template_mapping` (
  `tid` int(11) NOT NULL,
  `gid` int(11) NOT NULL
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
  `threads` int(10) NOT NULL DEFAULT '0',
  `helpdesk` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_forums`
--

INSERT INTO `fo_forums` (`id`, `name`, `description`, `type`, `threads`, `helpdesk`) VALUES
(17, 'beggarss', 'bigga', 3, 5, 0),
(18, '', NULL, 3, 0, 0),
(20, 'beggarssz', 'bigga', 3, 0, 0),
(22, 'beggarsszhkas', 'bigga', 3, 0, 0),
(24, 'babyegg', 'forum for dev', 3, 0, 0),
(25, 'beby', 'hdh', 3, 1, 0),
(26, 'nwo', 'new world order', 3, 0, 0),
(27, 'Dev', 'demo forum just for fun', 3, 0, 0),
(28, 'nsfw', 'not safe for work', 2, 8, 0),
(29, 'devForum', 'dev forum', 1, 0, 0),
(31, 'devthreads', 'dev', 1, 1, 0),
(32, 'devthreadsz', 'dev', 1, 14, 0),
(34, '111', '11', 1, 0, 0),
(35, 'forum123', 'dljllsjd', 2, 2, 0),
(36, 'SNISTUPDATES', 'snist updates', 1, 1, 0),
(37, '_-', '_-', 3, 0, 0),
(38, 'snist -', 'snist -', 3, 0, 0),
(39, '2_2011-2015', '2_2011-2015', 3, 0, 0),
(40, 'snist 2011-2015', 'snist 2011-2015', 3, 1, 0),
(43, '7_2011-2015', '7_2011-2015', 3, 0, 0),
(45, 'ME_2011-2015', 'ME_2011-2015', 3, 1, 0),
(46, 'HELPDESK_management', 'Admin Helpdesk portal', 3, 11, 1),
(47, 'HELPDESK_examination', 'Examination branch helpdesk portsl', 4, 3, 1),
(48, 'HELPDESK_SAP', 'SAP Helpdesk portal', 4, 3, 1),
(49, 'CSE_0-0', 'CSE_0-0', 3, 0, 0),
(50, 'snist 0-0', 'snist 0-0', 3, 0, 0),
(51, 'CSE_2001-2005', 'CSE_2001-2005', 3, 0, 0),
(52, 'snist 2001-2005', 'snist 2001-2005', 3, 0, 0),
(53, 'CSE_2011-2015', 'CSE_2011-2015', 3, 0, 0),
(55, 'CSE C_2011-2015', 'CSE C_2011-2015', 3, 0, 0),
(58, 'CSE-C_2011-2015', 'CSE-C_2011-2015', 3, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_helpdesk_status`
--

DROP TABLE IF EXISTS `fo_helpdesk_status`;
CREATE TABLE IF NOT EXISTS `fo_helpdesk_status` (
  `tid` int(11) NOT NULL,
  `stat` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_helpdesk_status`
--

INSERT INTO `fo_helpdesk_status` (`tid`, `stat`) VALUES
(1, 0),
(17, 0),
(31, 0),
(40, 1),
(41, 1),
(42, 0),
(43, 0),
(46, 0),
(47, 1),
(48, 1);

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
(36),
(46),
(47),
(48);

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
(18, 1),
(20, 1),
(22, 1),
(24, 1),
(34, 1),
(36, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
(14, 3, 'demo', 2, '2015-04-14 13:26:58', 13),
(15, 3, '\\:P', 2, '2015-04-14 13:27:02', 1),
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
(26, 18, 'this is new post', 2, '2015-04-16 15:38:35', 2),
(27, 18, 'e sure to add role=&quot;dialog&quot; to .modal, aria-labelledby=&quot;myModalLabel&quot; attribute to reference the modal title, and aria-hidden=&quot;true&quot; to tell assistive technologies to skip the modal''s DOM elements.\n\nAdditionally, you may give a description of your modal dialog with aria-describedby on .modal.', 2, '2015-04-16 15:42:52', 2),
(28, 21, 'this is thread post', 2, '2015-04-16 15:49:52', 0),
(29, 21, 'gaga', 2, '2015-04-16 16:01:08', 0),
(30, 3, 'shvbhfbvfjvnzjdnuibvvujv', 2, '2015-04-19 16:17:27', 0),
(31, 22, '', 2, '2015-04-19 16:27:50', 1),
(32, 17, 'hello\n', 1, '2015-04-20 02:45:24', 0),
(33, 23, 'i am the mod', 1, '2015-04-20 16:31:00', 1),
(34, 24, '', 1, '2015-04-20 16:36:32', 0),
(35, 22, 'hello\n', 1, '2015-04-22 13:26:10', 0),
(36, 25, 'added by goku\n', 1, '2015-04-22 13:39:23', 1),
(37, 25, 'hello\n', 1, '2015-04-22 13:39:33', 0),
(38, 25, 'demo post', 2, '2015-04-22 14:13:35', 0),
(39, 25, 'demo\n', 1, '2015-04-22 14:14:30', 0),
(40, 25, 'hello', 9, '2015-04-22 14:15:48', 0),
(41, 23, 'fuck off', 9, '2015-04-22 14:16:26', 0),
(42, 3, 'dexter', 1, '2015-04-22 15:39:49', 0),
(43, 15, 'hello\n', 9, '2015-04-22 15:43:21', 0),
(44, 1, 'this is gokus dp', 1, '2015-04-23 14:44:26', 0),
(45, 1, 'this id dp', 1, '2015-04-23 14:47:28', 0),
(46, 1, '', 1, '2015-04-23 14:48:53', 0),
(47, 1, '', 1, '2015-04-23 14:58:21', 0),
(48, 3, 'content', 1, '2015-04-23 15:19:06', 0),
(49, 3, 'image', 1, '2015-04-23 15:19:37', 0),
(50, 3, 'img', 1, '2015-04-23 15:20:56', 0),
(51, 3, 'i', 1, '2015-04-23 15:28:24', 0),
(52, 3, 'i2', 1, '2015-04-23 15:28:35', 0),
(53, 3, 'sd', 1, '2015-04-23 15:37:03', 0),
(54, 3, 'z', 1, '2015-04-23 15:46:28', 0),
(55, 3, 'y', 1, '2015-04-23 15:46:42', 0),
(56, 3, 'y', 1, '2015-04-23 15:48:00', 0),
(57, 3, 'y', 1, '2015-04-23 15:48:11', 0),
(58, 3, 'ds', 1, '2015-04-23 15:49:05', 0),
(59, 3, 'x', 1, '2015-04-23 15:51:49', 0),
(60, 3, 'x', 1, '2015-04-23 15:52:14', 0),
(61, 3, 'x', 1, '2015-04-23 15:53:25', 0),
(62, 3, 'hello\n', 1, '2015-04-23 15:57:26', 0),
(63, 3, 'hello', 1, '2015-04-23 15:58:03', 0),
(64, 3, 'x', 1, '2015-04-23 15:59:17', 1),
(65, 3, 'x', 1, '2015-04-23 15:59:53', 0),
(66, 3, 'yy', 1, '2015-04-23 16:05:25', 0),
(67, 22, '<img width="100" height="100" src="image.php?id=1"></img>', 1, '2015-04-24 13:05:47', 0),
(68, 3, '<img width="100" height="100"  src="image.php?id=1"></img>', 1, '2015-04-24 13:10:18', 0),
(69, 3, '<img width="100" height="100" src="image.php?id=1"></img>', 1, '2015-04-24 13:23:59', 0),
(70, 3, '<img src="image.php?id=1" width="100px" height="100px" />', 1, '2015-04-24 13:43:29', 0),
(71, 3, '<img src="image.php?id=6" width="100px" height="100px" />', 1, '2015-04-24 13:52:13', 0),
(72, 3, '<img src="image.php?id=7" width="100px" height="100px" />', 1, '2015-04-24 13:53:32', 0),
(73, 3, '<img src="image.php?id=8" width="100px" height="100px" />', 1, '2015-04-24 13:55:37', 0),
(74, 3, '<img src="image.php?id=9" width="100px" height="100px" />', 1, '2015-04-24 13:59:42', 0),
(75, 26, 'first thread of our batch snist 2011-2015', 12, '2015-04-25 14:51:34', 0),
(76, 26, '<img src="image.php?id=10" width="100px" height="100px" />', 12, '2015-04-25 14:51:48', 0),
(77, 26, '<img src="image.php?id=11" width="100px" height="100px" />', 14, '2015-04-25 14:57:42', 0),
(78, 27, 'im the first user in me', 24, '2015-04-26 05:24:06', 1),
(79, 27, 'hello', 24, '2015-04-26 05:31:35', 0),
(80, 27, 'yami ', 24, '2015-04-26 05:32:06', 0),
(81, 15, '', 1, '2015-04-26 05:58:48', 0),
(82, 15, '', 1, '2015-04-26 05:59:20', 0),
(83, 23, 'rofl', 9, '2015-04-26 08:38:38', 0),
(84, 23, '', 9, '2015-04-26 08:40:05', 0),
(85, 23, 'suddenly files are broken, i have no fucking idea', 9, '2015-04-26 08:40:34', 1),
(86, 28, 'lets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev thingslets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev thingslets create a dev forum where we can interact about dev things\nvlets create a dev forum where we can interact about dev thingslets create a dev forum where we can interact about dev thingslets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev things\nlets create a dev forum where we can interact about dev thingslets create a dev forum where we can interact about dev things', 2, '2015-04-26 09:56:34', 0),
(87, 28, 'lets create a dev forum where we can interact about dev things\n\n\nlets create a dev forum where we can interact about dev things', 2, '2015-04-26 09:56:51', 0),
(88, 28, 'now this shit preserves things exactly :)', 2, '2015-04-26 10:01:29', 0),
(89, 28, 'but this shit is exactly why like and replay doesnt like forums', 2, '2015-04-26 10:06:04', 0),
(90, 3, '&lt;p class=''bg-info''&gt;demo&lt;/p&gt;\n\ncomment', 1, '2015-04-26 14:59:13', 0),
(91, 3, '&quot;&lt;p class=''bg-info''&gt;demo&lt;/p&gt;\n\ncomment&quot;\nthis is how it should work', 1, '2015-04-26 15:00:15', 0),
(92, 3, '&quot;x&quot;\n\nthis is x', 1, '2015-04-26 15:01:16', 0),
(93, 27, '&quot;im the first user in me&quot;\n\nreply', 24, '2015-04-26 15:43:50', 0),
(94, 3, '&lt;blockquote&gt;&quot;x&quot;\n\nthis is x&lt;/blockquote&gt;\n\nis this better', 1, '2015-04-27 13:18:23', 0),
(95, 29, 'please post your questions here', 2, '2015-04-28 01:42:59', 0),
(96, 30, 'y u guys take money', 2, '2015-04-28 01:44:18', 0),
(97, 31, 'y', 2, '2015-04-28 01:49:36', 0),
(98, 32, 'z', 2, '2015-04-28 01:50:16', 0),
(99, 33, 'z', 2, '2015-04-28 01:50:54', 0),
(100, 34, 'z', 2, '2015-04-28 01:52:26', 0),
(101, 35, 'z', 2, '2015-04-28 01:52:27', 0),
(102, 36, 'z', 2, '2015-04-28 01:52:59', 0),
(103, 37, 'po', 2, '2015-04-28 02:02:31', 0),
(104, 38, 'no2', 2, '2015-04-28 02:03:00', 0),
(105, 39, 'na', 2, '2015-04-28 02:04:52', 0),
(106, 40, 'ello', 2, '2015-04-28 13:32:28', 0),
(107, 41, 'ello\n', 2, '2015-04-28 13:34:34', 0),
(108, 42, 'require a name change operation', 1, '2015-04-30 15:55:49', 0),
(109, 42, 'come to sap with all details', 1, '2015-04-30 16:00:10', 0),
(110, 43, 'second name change', 1, '2015-04-30 16:03:35', 1),
(111, 43, 'done', 1, '2015-04-30 16:04:06', 0),
(112, 43, 'okay', 1, '2015-04-30 16:05:59', 1),
(113, 43, 'to public', 1, '2015-04-30 16:07:56', 0),
(114, 18, 'when does image support will be given', 1, '2015-05-01 14:32:55', 2),
(115, 18, '', 1, '2015-05-01 14:33:54', 0),
(116, 18, 'post to test timestamp', 1, '2015-05-01 15:41:16', 0),
(117, 44, 'gokus thread', 1, '2015-05-01 16:03:23', 0),
(118, 41, 'hh', 2, '2015-05-02 01:43:16', 0),
(119, 23, 'but', 2, '2015-05-02 01:44:05', 0),
(120, 43, '&quot;second name change&quot;', 2, '2015-05-02 04:43:37', 0),
(121, 45, 'roll no:110101', 25, '2015-05-02 05:53:15', 0),
(122, 45, 'pay 100', 25, '2015-05-02 05:53:56', 0),
(123, 22, '<img src="http://localhost/snistaf/forum/files/85e12f46737a305b6ed1382f4022b615.png"> </img>', 2, '2015-05-06 12:17:02', 0),
(124, 3, 'echo &quot;http://localhost/snistaf/forum/files/85e12f46737a305b6ed1382f4022b615.png&quot;;', 2, '2015-05-06 12:23:39', 1),
(125, 22, '[object Object]', 2, '2015-05-06 14:44:25', 0),
(126, 22, '[object Object][object Object]', 2, '2015-05-06 14:56:25', 0),
(127, 21, 'hello', 2, '2015-05-09 05:49:12', 0),
(128, 22, '<a href="image.php?id=2"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=2" alt="click to enlarge"></img></a>', 2, '2015-05-09 12:35:28', 0),
(129, 22, '<a href="image.php?id=3"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=3" alt="click to enlarge"></img></a>', 2, '2015-05-09 12:40:54', 0),
(130, 22, '<a href="image.php?id=4"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=4" alt="click to enlarge"></img></a>', 2, '2015-05-09 12:43:55', 0),
(131, 22, 'am john snow<a href="image.php?id=5"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=5" alt="click to enlarge"></img></a>', 2, '2015-05-10 05:31:42', 1),
(132, 39, 'this is public', 2, '2015-05-10 06:17:04', 0),
(133, 46, 'world', 2, '2015-05-12 08:37:26', 0),
(134, 31, 'to public', 2, '2015-05-12 08:40:19', 0),
(135, 31, 'to public debug 2', 2, '2015-05-12 08:43:17', 0),
(136, 46, 'to make public', 2, '2015-05-12 13:18:36', 0),
(137, 47, 'testing thread', 2, '2015-05-12 13:20:59', 0),
(138, 47, 'make public', 2, '2015-05-12 13:21:18', 0),
(139, 47, 'sdsd', 2, '2015-05-12 13:22:56', 0),
(140, 47, 'sddsds', 2, '2015-05-12 13:23:25', 0),
(141, 47, '', 2, '2015-05-12 13:25:48', 0),
(142, 47, '', 2, '2015-05-12 13:28:44', 0),
(143, 47, 'hello', 2, '2015-05-12 13:34:44', 0),
(144, 47, 'not resolved so open again', 2, '2015-05-12 13:36:02', 0),
(145, 48, 'who is rebecca', 2, '2015-05-13 04:45:15', 0),
(146, 48, 'is solved', 2, '2015-05-13 04:45:24', 0),
(147, 48, 'not solved', 1, '2015-05-13 04:46:04', 0),
(148, 48, 'solved re', 1, '2015-05-13 04:46:27', 0),
(149, 15, '<a href="image.php?id=6"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=6" alt="click to enlarge"></img></a>', 1, '2015-05-13 04:49:20', 0),
(150, 22, '<a href="image.php?id=7"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=7" alt="click to enlarge"></img></a>', 2, '2015-05-13 04:51:58', 0),
(151, 22, 'its happening<a href="image.php?id=8"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=8" alt="click to enlarge"></img></a>', 2, '2015-05-13 04:53:41', 0),
(152, 22, '<a href="image.php?id=9"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=9" alt="click to enlarge"></img></a>', 2, '2015-05-13 04:55:10', 0),
(153, 15, '<a href="image.php?id=10"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=10" alt="click to enlarge"></img></a>', 1, '2015-05-13 04:56:28', 0),
(154, 15, '<a href="image.php?id=11"	 id="imagePop"><img class="img-responsive" id="postImage" src="image.php?id=11" alt="click to enlarge"></img></a>', 1, '2015-05-13 04:57:38', 1);

-- --------------------------------------------------------

--
-- Table structure for table `fo_posts_banned`
--

DROP TABLE IF EXISTS `fo_posts_banned`;
CREATE TABLE IF NOT EXISTS `fo_posts_banned` (
  `id` int(11) NOT NULL,
  `stat` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_posts_banned`
--

INSERT INTO `fo_posts_banned` (`id`, `stat`) VALUES
(41, 0),
(83, 0),
(119, 0);

-- --------------------------------------------------------

--
-- Table structure for table `fo_post_likes`
--

DROP TABLE IF EXISTS `fo_post_likes`;
CREATE TABLE IF NOT EXISTS `fo_post_likes` (
  `pid` int(11) NOT NULL,
  `uid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_post_likes`
--

INSERT INTO `fo_post_likes` (`pid`, `uid`) VALUES
(64, 1),
(26, 1),
(27, 1),
(31, 1),
(110, 2),
(36, 2),
(85, 1),
(124, 2),
(131, 2),
(154, 1),
(33, 27);

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
  `time_Stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sticky` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `fo_threads`
--

INSERT INTO `fo_threads` (`id`, `forum_id`, `name`, `added_by`, `time_Stamp`, `sticky`) VALUES
(1, 32, 'demoThread', 2, '2015-04-05 04:35:15', 0),
(2, 32, 'demoThread2', 2, '2015-04-05 08:21:38', 0),
(3, 17, 'demoThread', 2, '2015-05-06 12:23:39', 0),
(4, 31, 'demoThread', 2, '2015-04-05 08:24:02', 0),
(5, 31, 'demoThread2', 2, '2015-04-05 08:25:18', 0),
(6, 31, 'demoThread3', 1, '2015-04-06 14:29:39', 0),
(7, 28, 'demo thread', 1, '2015-04-12 06:18:20', 0),
(8, 28, 'next thread', 1, '2015-04-12 06:24:39', 0),
(9, 28, 'next thread', 1, '2015-04-12 06:24:41', 0),
(10, 28, 'next thread', 1, '2015-04-12 06:24:51', 0),
(11, 28, 'next thread', 1, '2015-04-12 06:24:52', 0),
(12, 28, 'next thread', 1, '2015-04-12 06:24:52', 0),
(13, 28, 'next thread', 1, '2015-04-12 06:24:52', 0),
(14, 28, 'next thread3', 1, '2015-04-12 06:26:02', 0),
(15, 17, 'new thread', 2, '2015-05-13 04:57:38', 0),
(16, 17, 'simple therad', 2, '2015-04-12 06:50:12', 1),
(17, 32, 'demoThread3', 2, '2015-04-16 15:37:14', 0),
(18, 32, 'demotThread4', 2, '2015-05-01 15:41:16', 0),
(19, 32, 'demo thread', 2, '2015-04-16 15:44:14', 0),
(20, 35, 'big title for this forum thread, so that dumb people can post content in the entire thing dammit', 2, '2015-04-16 15:45:48', 0),
(21, 32, 'this is thread name', 2, '2015-04-16 15:49:52', 0),
(22, 17, 'sticky', 2, '2015-05-10 05:31:42', 1),
(23, 36, 'new thread', 1, '2015-05-02 01:44:05', 0),
(24, 25, 'thread', 1, '2015-04-20 16:36:32', 0),
(25, 17, 'new thread', 1, '2015-04-22 13:39:23', 0),
(26, 40, 'hello', 12, '2015-04-25 14:51:34', 0),
(27, 45, 'first user in me', 24, '2015-04-26 05:24:06', 0),
(28, 35, 'dev forum', 2, '2015-04-26 09:56:34', 0),
(29, 46, 'helpdesk', 2, '2015-04-28 01:42:59', 0),
(30, 46, 'help', 2, '2015-04-28 01:44:18', 0),
(31, 46, 'x', 2, '2015-05-12 08:43:17', 0),
(32, 46, 'y', 2, '2015-04-28 01:50:16', 0),
(33, 46, 'z', 2, '2015-04-28 01:50:54', 0),
(34, 46, 'z2', 2, '2015-04-28 01:52:26', 0),
(35, 46, 'z2', 2, '2015-04-28 01:52:27', 0),
(36, 46, 'z2', 2, '2015-04-28 01:52:59', 0),
(37, 46, 'yo', 2, '2015-04-28 02:02:31', 0),
(38, 46, 'yo2', 2, '2015-04-28 02:03:00', 0),
(39, 46, 'ney', 2, '2015-05-10 06:17:04', 0),
(40, 47, 'hello', 2, '2015-04-28 13:32:28', 0),
(41, 47, 'hello1', 2, '2015-05-02 01:43:16', 0),
(42, 48, 'name change', 1, '2015-04-30 15:55:49', 0),
(43, 48, 'second name change', 1, '2015-05-02 04:43:37', 0),
(44, 17, 'demo', 1, '2015-05-01 16:03:23', 0),
(45, 47, 'forgost ht', 25, '2015-05-02 05:53:56', 0),
(46, 46, 'hello', 2, '2015-05-12 13:18:36', 0),
(47, 46, 'test thread', 2, '2015-05-12 13:36:02', 0),
(48, 48, 'new private qestion', 2, '2015-05-13 04:45:15', 0);

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
(14, 3, 9, '2015-04-12 06:44:20'),
(15, 6, 14, '2015-05-13 04:57:38'),
(16, 1, 3, '2015-04-12 06:50:30'),
(17, 1, 3, '2015-04-20 02:45:24'),
(18, 5, 35, '2015-05-01 15:41:16'),
(19, 0, 0, '2015-04-16 15:44:14'),
(20, 0, 2, '2015-04-16 15:45:48'),
(21, 1, 5, '2015-04-16 16:01:08'),
(22, 12, 100, '2015-05-13 04:55:10'),
(23, 5, 119, '2015-05-02 01:44:05'),
(24, 0, 2, '2015-04-20 16:36:32'),
(25, 4, 25, '2015-04-22 14:15:48'),
(26, 2, 6, '2015-04-25 14:57:42'),
(27, 3, 10, '2015-04-26 15:43:50'),
(28, 3, 13, '2015-04-26 10:06:04'),
(29, 0, 1, '2015-04-28 01:42:59'),
(30, 0, 0, '2015-04-28 01:44:18'),
(31, 2, 4, '2015-05-12 08:43:17'),
(32, 0, 0, '2015-04-28 01:50:16'),
(33, 0, 1, '2015-04-28 01:50:54'),
(36, 0, 0, '2015-04-28 01:52:59'),
(37, 0, 0, '2015-04-28 02:02:31'),
(38, 0, 1, '2015-04-28 02:03:00'),
(39, 1, 5, '2015-05-10 06:17:04'),
(40, 0, 1, '2015-04-28 13:32:28'),
(41, 1, 2, '2015-05-02 01:43:16'),
(42, 1, 6, '2015-04-30 16:00:10'),
(43, 4, 9, '2015-05-02 04:43:37'),
(44, 0, 0, '2015-05-01 16:03:23'),
(45, 1, 2, '2015-05-02 05:53:56'),
(46, 1, 3, '2015-05-12 13:18:36'),
(47, 7, 12, '2015-05-12 13:36:02'),
(48, 3, 5, '2015-05-13 04:46:27');

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
-- Stand-in structure for view `um_address`
--
DROP VIEW IF EXISTS `um_address`;
CREATE TABLE IF NOT EXISTS `um_address` (
`id` int(11)
,`address` text
);
-- --------------------------------------------------------

--
-- Table structure for table `um_alumni_employment`
--

DROP TABLE IF EXISTS `um_alumni_employment`;
CREATE TABLE IF NOT EXISTS `um_alumni_employment` (
  `id` int(11) NOT NULL,
  `role` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `employer` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `isCurrent` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
-- Stand-in structure for view `um_employement`
--
DROP VIEW IF EXISTS `um_employement`;
CREATE TABLE IF NOT EXISTS `um_employement` (
`id` int(11)
,`role` varchar(255)
,`employer` varchar(255)
);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_groups`
--

INSERT INTO `um_groups` (`id`, `name`, `is_default`, `can_delete`, `home_page_id`) VALUES
(1, 'User', 2, 0, 4),
(2, 'Administrator', 0, 0, 5),
(3, 'Faculty', 0, 1, 4),
(4, 'Moderatiors', 0, 1, 0),
(5, 'alumni', 0, 0, 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

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
(18, 2, 'createUserActionPermit', 'always()'),
(19, 4, 'createGroup', 'always()'),
(20, 4, 'addUserToGroup', 'isSameGroup(group_id,''1'')'),
(21, 4, 'removeUserFromGroup', 'isSameGroup(group_id,''1'')'),
(22, 4, 'deleteGroup', 'isSameGroup(group_id,''1'')'),
(23, 4, 'loadUsersInGroup', 'isSameGroup(group_id,''1'')');

-- --------------------------------------------------------

--
-- Table structure for table `um_group_page_matches`
--

DROP TABLE IF EXISTS `um_group_page_matches`;
CREATE TABLE IF NOT EXISTS `um_group_page_matches` (
`id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

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
(31, 1, 22),
(32, 2, 22),
(33, 1, 26),
(34, 5, 27),
(35, 2, 27);

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_nav`
--

INSERT INTO `um_nav` (`id`, `menu`, `page`, `name`, `position`, `class_name`, `icon`, `parent_id`) VALUES
(1, 'left', 'account/dashboard_admin.php', 'Admin Dashboard', 1, 'dashboard-admin', 'fa fa-dashboard', 0),
(2, 'left', 'account/users.php', 'Users', 2, 'users', 'fa fa-users', 0),
(3, 'left', 'account/dashboard.php', 'Dashboard', 3, 'dashboard', 'fa fa-dashboard', 0),
(4, 'left', 'account/account_settings.php', 'Account Settings', 5, 'settings', 'fa fa-gear', 0),
(5, 'left-sub', '#', 'Site Settings', 5, '', 'fa fa-wrench', 0),
(6, 'left-sub', 'account/site_settings.php', 'Site Configuration', 6, 'site-settings', 'fa fa-globe', 5),
(7, 'left-sub', 'account/groups.php', 'Groups', 7, 'groups', 'fa fa-users', 5),
(8, 'left-sub', 'account/site_authorization.php', 'Authorization', 8, 'site-pages', 'fa fa-key', 5),
(9, 'top-main-sub', '#', '#USERNAME#', 1, 'site-settings', 'fa fa-user', 0),
(10, 'top-main-sub', 'account/account_settings.php', 'Account Settings', 1, '', 'fa fa-gear', 9),
(11, 'top-main-sub', 'account/logout.php', 'Log Out', 2, '', 'fa fa-power-off', 9),
(12, 'left', 'forum/index.php', 'Forum', 4, '', 'fa fa-university', 0),
(13, 'top-main', 'privatemessages/pm.php', 'Private Messages', -1, 'pms', 'fa fa-envelope', 0),
(14, 'left', 'modules/invite/account/invite.php', 'Invite friends', 9, 'invite', 'fa fa-user', 0),
(15, 'left', 'feedback/Alumni.php?step=1', 'Feedback', 6, '', 'fa fa-table', 0),
(16, 'left', 'forum/helpDesk.php', 'HelpDesk', 6, '', 'fa fa-info-circle', 0);

-- --------------------------------------------------------

--
-- Table structure for table `um_nav_group_matches`
--

DROP TABLE IF EXISTS `um_nav_group_matches`;
CREATE TABLE IF NOT EXISTS `um_nav_group_matches` (
`id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
(15, 14, 2),
(16, 15, 5),
(17, 16, 1),
(18, 14, 5);

-- --------------------------------------------------------

--
-- Table structure for table `um_other_auth`
--

DROP TABLE IF EXISTS `um_other_auth`;
CREATE TABLE IF NOT EXISTS `um_other_auth` (
`id` int(11) NOT NULL,
  `refer_id` int(11) NOT NULL,
  `email` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `auth_key` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `isActive` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `um_pages`
--

DROP TABLE IF EXISTS `um_pages`;
CREATE TABLE IF NOT EXISTS `um_pages` (
`id` int(11) NOT NULL,
  `page` varchar(150) NOT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

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
(22, 'account/Profile.php', 0),
(23, 'account/includes.php', 0),
(25, 'account/image.php', 0),
(26, 'forum/helpDesk.php', 0),
(27, 'modules/invite/account/invite.php', 0);

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
-- Table structure for table `um_port_student_db`
--

DROP TABLE IF EXISTS `um_port_student_db`;
CREATE TABLE IF NOT EXISTS `um_port_student_db` (
  `rollno` varchar(11) COLLATE latin1_general_ci NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `department` varchar(11) COLLATE latin1_general_ci NOT NULL,
  `section` varchar(1) COLLATE latin1_general_ci NOT NULL,
  `yearJoin` int(4) NOT NULL,
  `yearEnd` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `um_port_student_db`
--

INSERT INTO `um_port_student_db` (`rollno`, `name`, `department`, `section`, `yearJoin`, `yearEnd`) VALUES
('11311A05C1', 'Somisetty SaiBharath', 'CSE', 'C', 2011, 2015),
('11311A05C2', 'Miryala Sai Goutham', 'CSE', 'C', 2011, 2015),
('11311A05C3', 'Neelam Samanth', 'CSE', 'C', 2011, 2015),
('11311A05C4', 'Kasam Samhita Reddy', 'CSE', 'C', 2011, 2015),
('11311A05C5', 'M.R. Krishna Chaitanya', 'CSE', 'C', 2011, 2015),
('11311A05C6', 'Sandhya Rani', 'CSE', 'C', 2011, 2015),
('11311A05C7', 'Sabhavat Sangeetha', 'CSE', 'C', 2011, 2015),
('11311A05C8', 'Muppidi Sannihitha Reddy', 'CSE', 'C', 2011, 2015),
('11311A05C9', 'Viswanatham Santosh ', 'CSE', 'C', 2011, 2015),
('11311A05D0', 'D Sharanya Rao', 'CSE', 'C', 2011, 2015),
('11311A05D1', 'P Shivani Reddy', 'CSE', 'C', 2011, 2015),
('11311A05D2', 'Mantri ShivaSai', 'CSE', 'C', 2011, 2015),
('11311A05D3', 'Karpuram NagaShravya', 'CSE', 'C', 2011, 2015),
('11311A05D4', 'Lankapalli Shravya', 'CSE', 'C', 2011, 2015),
('11311A05D5', 'Shruthi Srigadi', 'CSE', 'C', 2011, 2015),
('11311A05D6', 'Katta Shyam Prasad', 'CSE', 'C', 2011, 2015),
('11311A05D7', 'Vineesha K', 'CSE', 'C', 2011, 2015),
('11311A05D8', 'Banuka Sireesha', 'CSE', 'C', 2011, 2015),
('11311A05D9', 'M N Siri', 'CSE', 'C', 2011, 2015),
('11311A05E0', 'M Sreeja', 'CSE', 'C', 2011, 2015),
('11311A05E1', 'Ankitha Mahajan', 'CSE', 'C', 2011, 2015),
('11311A05E2', 'Kasukurthi Srikanth', 'CSE', 'C', 2011, 2015),
('11311A05E3', 'S Srikanth', 'CSE', 'C', 2011, 2015),
('11311A05E4', 'Nagella Srinath', 'CSE', 'C', 2011, 2015),
('11311A05E5', 'K Sukanya Reddy', 'CSE', 'C', 2011, 2015),
('11311A05E6', 'Yama Sukanya', 'CSE', 'C', 2011, 2015),
('11311A05E7', 'Tirunagaru Sumanjali', 'CSE', 'C', 2011, 2015),
('11311A05E8', 'Mohan Kumar Bhupathi', 'CSE', 'C', 2011, 2015),
('11311A05E9', 'Matha Sushmitha', 'CSE', 'C', 2011, 2015),
('11311A05F0', 'Swathi Pulikurthi', 'CSE', 'C', 2011, 2015),
('11311A05F1', 'B Swetha', 'CSE', 'C', 2011, 2015),
('11311A05F2', 'Gandla Thirupathi', 'CSE', 'C', 2011, 2015),
('11311A05F3', 'Nalla Usha Rani', 'CSE', 'C', 2011, 2015),
('11311A05F4', 'Vasima Mohammed', 'CSE', 'C', 2011, 2015),
('11311A05F5', 'Ummaneni Vinay Kumar', 'CSE', 'C', 2011, 2015),
('11311A05F6', 'Talupula Vineel', 'CSE', 'C', 2011, 2015),
('11311A05F7', 'Yerekar VishwaBhushan', 'CSE', 'C', 2011, 2015),
('11311A05F8', 'Vivek Sharma', 'CSE', 'C', 2011, 2015),
('11311A05F9', 'Parasa Yaswanth Kumar', 'CSE', 'C', 2011, 2015),
('11311A05G0', 'G Yojana', 'CSE', 'C', 2011, 2015),
('11311A05G1', 'Abhilash Chepur', 'CSE', 'C', 2011, 2015),
('11311A05G2', 'Manideep Rao', 'CSE', 'C', 2011, 2015),
('11311A05G3', 'Chittakula Rohini', 'CSE', 'C', 2011, 2015),
('11311A05G4', 'Theegala Mounica', 'CSE', 'C', 2011, 2015),
('11311A05G5', 'Akhila Reddy Kowkkutla', 'CSE', 'C', 2011, 2015),
('11311A05G6', 'Thakkallapally Rohit Rao', 'CSE', 'C', 2011, 2015),
('11311A05G7', 'Bokkadi Srikanth Reddy', 'CSE', 'C', 2011, 2015),
('11311A05G8', 'K Devi ', 'CSE', 'C', 2011, 2015),
('11311A05G9', 'Akhil Laxman', 'CSE', 'C', 2011, 2015),
('11311A05H0', 'Nithin Sai', 'CSE', 'C', 2011, 2015),
('11311A05H1', 'Singamaneni Sandeep', 'CSE', 'C', 2011, 2015),
('11311A05H2', 'Therala Sai Vivek', 'CSE', 'C', 2011, 2015),
('11311A05H3', 'Gangishetty Shreya', 'CSE', 'C', 2011, 2015),
('11311A05H4', 'Podiyam VenkataRamana', 'CSE', 'C', 2011, 2015),
('11311A05H5', 'Luvudaya Vidya Sri', 'CSE', 'C', 2011, 2015),
('11311A05H6', 'Katta Vinod Reddy', 'CSE', 'C', 2011, 2015),
('11311A05H7', 'Masetty Dharma Teja', 'CSE', 'C', 2011, 2015),
('11311A05H8', 'G Sri Sneha Varsha', 'CSE', 'C', 2011, 2015),
('11311A05I0', 'Nelaballi SaiBhanu', 'CSE', 'C', 2011, 2015),
('12315A0525', 'Gundu Santosh', 'CSE', 'C', 2012, 2015),
('12315A0526', 'Karthik Ragula', 'CSE', 'C', 2012, 2015),
('12315A0527', 'Sravan Kumar', 'CSE', 'C', 2012, 2015),
('12315A0528', 'G Madhuri', 'CSE', 'C', 2012, 2015),
('12315A0529', 'Narasimha Jarupula', 'CSE', 'C', 2012, 2015),
('12315A0530', 'Durbesh Mohammed', 'CSE', 'C', 2012, 2015),
('12315A0532', 'P Naresh Kumar', 'CSE', 'C', 2012, 2015),
('12315A0533', 'GVS Ramu', 'CSE', 'C', 2012, 2015),
('12315A0534', 'Qamar Mohammed', 'CSE', 'C', 2012, 2015),
('12315A0535', 'A Adithya ', 'CSE', 'C', 2012, 2015),
('12315A0536', 'V Ramesh', 'CSE', 'C', 2012, 2015);

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `um_users`
--

INSERT INTO `um_users` (`id`, `user_name`, `display_name`, `password`, `email`, `activation_token`, `last_activation_request`, `lost_password_request`, `lost_password_timestamp`, `active`, `title`, `sign_up_stamp`, `last_sign_in_stamp`, `enabled`, `primary_group_id`) VALUES
(1, 'goku', 'Goku', '$2y$10$alYFtsgzj4q2zkrfoQU2.eOX2q/LiXDesu/lOdsyekD2HCxisRLo.', 'srikanthkasukurti@gmail.com', '2ea9269b4e0b275d109962db23c10824', 1426868943, 0, 1426868943, 1, 'Master Account', 1426868943, 1431492344, 1, 2),
(2, 'demo', 'demouser', '$2y$10$Z56GefM9ke/Jt3EFRK2qCOodCkCdGjTPjtCJ9tWGK8UmfrTfp5RAa', 'demo@localhost.com', '312bd281cbd3f3bec2be3433967071da', 1428119642, 0, 1428119642, 1, 'Stone', 1428119642, 1431492295, 1, 1),
(7, 'demo23', 'demoUser23', '$2y$10$5d2V5Zzue7/XTrDqErJAgeR9RMupdOCKyPEvdpQc8bq550/CFRd3i', 'demo23@localhost.loc', 'b2b4aa468cce977e320db0f347a12772', 1429424595, 0, 1429424595, 1, 'Potato', 1429424595, 0, 1, 1),
(8, 'demo2', 'demouser2', '$2y$10$zSkYSNCKJuBWHdSNjs0Bteks2QFxouFXLfG20gOTtGmAFDz0K60p2', 'demo2@localhost.loc', '9e6cac099e839a89e9733694b4130344', 1429424757, 0, 1429424757, 1, 'Potato', 1429424757, 1429424767, 1, 1),
(9, 'demoalumni', 'AlumniDemoUser', '$2y$10$OwxSC2LAahUItK0dmxxtN.qhaOXTNPg7sofHIeY.rtMSXHaUq54Sa', 'alumni@localhost.loc', 'f577cb8a54ba47f5ccb787042c9bff2c', 1429429111, 0, 1429429111, 1, 'Potato', 1429429111, 1430545274, 1, 1),
(10, 'demoalumni2', 'alumua', '$2y$10$yXnmTTVv3nXHbSGWmAqfi.uyoqUUTpyu1wYsY6tW3Xfnms.IzpUvO', 'almu@loclhost.loc', 'a2379402ef2106636c057dd3b68d4bed', 1429429373, 0, 1429429373, 1, 'Potato', 1429429373, 0, 1, 1),
(11, 'frankey', 'SrikanthK', '$2y$10$q/EaWsQRSz0gmQMqCyd/dukWuVGKIXXiwfKTZ4eViF4L25PK/nPxu', 'srikanth@opensnist.org', 'a152e7f048644dff88caa85890ec945d', 1429801263, 0, 1429801263, 1, 'senpai', 1429801263, 1430062917, 1, 1),
(12, 'vinayu7', 'vinay', '$2y$10$eLN4P5I4xtu6DExrgckQP.exmHth4324wZ8GvWwrRlrj/lZaZAfee', 'uvinaykumaru@gmail.com', 'db1a9b93f43ffd16d1ed6bc70cf6f16e', 1429945404, 0, 1429945404, 1, 'Potato', 1429945404, 1429972998, 1, 1),
(13, 'shreya', 'shreyaG', '$2y$10$DN.rKL041eSfcsvI3/v6Su3kZVDib9f9pu6PnpVpkJdI2p57LWdZi', 'shreya@opensnist.org', '2bcf88f2d50956784c033b34d08006f8', 1429973707, 0, 1429973707, 1, 'Potato', 1429973707, 1429973713, 1, 1),
(14, 'bava', 'shyam', '$2y$10$CTiFuNOBf437xlxbvV2Lqeorn8QlvBLK9ncN6EAYEX4/FJ7HYKIW.', 's@opensnist.org', '6c27c3a25ab1ccd7c580971a96c6a0df', 1429973822, 0, 1429973822, 1, 'Potato', 1429973822, 1429973844, 1, 1),
(15, 'momu', 'momonosuke', '$2y$10$Za3hWpTClq/Asu8VC/31Muo1.znk6MToGjKM1sPC3zm3rTQwGtjtG', 'momu@opensnist.org', 'cf4270b586250d7418de2ed8c34661cf', 1430020497, 0, 1430020497, 1, 'Potato', 1430020497, 1430020504, 1, 1),
(19, 'demoece23', 'demoECE23', '$2y$10$8zQPBg/tDmhN80vJNgKl.uBW.hjgCAMvVPm.Lvzwe6EjDEvb5za0K', 'demoece23@opensnist.org', '076ab5f3c44e227ca129be8ef5b3708a', 1430024510, 0, 1430024510, 1, 'Potato', 1430024510, 1430024560, 1, 1),
(24, 'demome', 'demoME', '$2y$10$fcbS07vQl9.KvV1p2CgEweDMM4ckgF5frwDVpTMZAoc/vT0pvx5rK', 'demome@opensnist.org', 'fad5318f592c84a942aa38023d3d09ea', 1430025793, 0, 1430025793, 1, 'Potato', 1430025793, 1430062974, 1, 1),
(25, 'xyz', 'alumnixyz', '$2y$10$c.AVK763g0U0dG6A588N6er4r3ilqeeVN9S7ZDlGBFn6Xc58sIQTO', 'xyz@loclahost.loc', '6552c3dc1c0f7dd99688ff6d7a52b50a', 1430043215, 0, 1430043215, 1, 'Potato', 1430043215, 1430545302, 1, 1),
(27, 'shreyah3', 'Shreya', '$2y$10$OyrRfggPDRooV6Sx40OSxufOMUhRQKx3ro5tKoBDWJotH7HHGN81O', '11311a05h3@sreenidhi.edu.in', 'e4b71395ec3fadb503b90d77e58bd58a', 1431504607, 0, 1431504607, 1, 'Potato', 1431504607, 1431504822, 1, 1),
(28, 'saibharathc1', 'SaiBharath', '$2y$10$DkS6WiLCdjn1WuBAVggBG.xfHaKXl8Qb16WjSCtETRFq4tw./6PLi', '11311a05c1@sreenidhi.edu.in', '45a9fb441bd39e9ae7cb3f0d03941480', 1431504768, 0, 1431504768, 1, 'Potato', 1431504768, 0, 1, 1);

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
-- Table structure for table `um_user_address`
--

DROP TABLE IF EXISTS `um_user_address`;
CREATE TABLE IF NOT EXISTS `um_user_address` (
  `id` int(11) NOT NULL,
  `address` text COLLATE latin1_general_ci NOT NULL,
  `isCurrent` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

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
  `section` varchar(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'A',
  `year_join` int(4) NOT NULL DEFAULT '2015',
  `year_end` int(4) NOT NULL DEFAULT '2018',
  `isAlumni` int(1) NOT NULL DEFAULT '0',
  `feedback_done` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='User details definition';

--
-- Dumping data for table `um_user_details`
--

INSERT INTO `um_user_details` (`id`, `full_name`, `roll_no`, `department`, `section`, `year_join`, `year_end`, `isAlumni`, `feedback_done`) VALUES
(10, 'almund', '0147852369', 2, 'a', 2000, 2004, 1, 0),
(9, 'Alumni Anthony', '0701010101', 2, 'a', 2007, 2011, 1, 0),
(19, 'demo ECE2', '11311A0434', 7, 'a', 2011, 2015, 0, 0),
(24, 'demo ME', '11311a05me', 4, 'a', 2011, 2015, 0, 0),
(8, 'demodabidi', '11311A05H2', 2, 'a', 2000, 2004, 1, 0),
(7, 'demoramu23', 'a123487776', 2, 'a', 2012, 2015, 0, 0),
(27, 'Gangishetty Shreya', '11311A05H3', 2, 'C', 2011, 2015, 0, 0),
(15, 'Momu Nomu', '11311a0500', 2, 'a', 2011, 2015, 0, 0),
(13, 'Shreya Gangishetty', '11311A05H3', 2, 'a', 2011, 2015, 0, 0),
(14, 'Shyam Prasad', '11311a05d6', 2, 'a', 2011, 2015, 0, 0),
(28, 'Somisetty SaiBharath', '11311A05C1', 2, 'C', 2011, 2015, 0, 0),
(1, 'Son Goku', '1', 2, 'a', 0, 0, 1, 0),
(11, 'Srikanth Kasukurthi', '11311A05E2', 2, 'a', 2011, 2015, 0, 0),
(12, 'Vinay Ummaneni', '11311A05F5', 2, 'a', 2011, 2015, 0, 0),
(25, 'xyz', '1234567890', 2, 'a', 2001, 2005, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `um_user_group_matches`
--

DROP TABLE IF EXISTS `um_user_group_matches`;
CREATE TABLE IF NOT EXISTS `um_user_group_matches` (
`id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

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
(8, 10, 1),
(9, 11, 1),
(10, 12, 1),
(11, 13, 1),
(12, 14, 1),
(13, 15, 1),
(14, 19, 1),
(15, 24, 1),
(16, 25, 5),
(17, 25, 1),
(18, 27, 1),
(19, 28, 1);

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
(9, 'BatMan'),
(10, 'Senpai');

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
(1, 0),
(1, 17),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 32),
(1, 34),
(1, 36),
(1, 37),
(1, 38),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(2, 0),
(2, 17),
(2, 28),
(2, 32),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 46),
(2, 47),
(2, 48),
(9, 17),
(9, 36),
(11, 39),
(11, 40),
(12, 36),
(12, 39),
(12, 40),
(13, 36),
(13, 39),
(13, 40),
(14, 36),
(14, 39),
(14, 40),
(15, 0),
(15, 36),
(15, 39),
(15, 40),
(19, 0),
(19, 36),
(19, 40),
(19, 43),
(24, 0),
(24, 36),
(24, 40),
(24, 45),
(25, 36),
(25, 46),
(25, 47),
(25, 48),
(25, 51),
(25, 52),
(27, 0),
(27, 36),
(27, 40),
(27, 46),
(27, 47),
(27, 48),
(27, 53),
(27, 55),
(28, 0),
(28, 36),
(28, 40),
(28, 46),
(28, 47),
(28, 48),
(28, 53),
(28, 58);

-- --------------------------------------------------------

--
-- Structure for view `um_address`
--
DROP TABLE IF EXISTS `um_address`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `um_address` AS select `um_user_address`.`id` AS `id`,`um_user_address`.`address` AS `address` from `um_user_address` where (`um_user_address`.`isCurrent` = 1);

-- --------------------------------------------------------

--
-- Structure for view `um_employement`
--
DROP TABLE IF EXISTS `um_employement`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `um_employement` AS select `um_alumni_employment`.`id` AS `id`,`um_alumni_employment`.`role` AS `role`,`um_alumni_employment`.`employer` AS `employer` from `um_alumni_employment` where (`um_alumni_employment`.`isCurrent` = 1);

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
-- Indexes for table `fb_alumni_suggestion`
--
ALTER TABLE `fb_alumni_suggestion`
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
-- Indexes for table `fb_question_answers`
--
ALTER TABLE `fb_question_answers`
 ADD PRIMARY KEY (`id`), ADD KEY `uid` (`uid`), ADD KEY `qid` (`qid`), ADD KEY `tid` (`tid`);

--
-- Indexes for table `fb_question_options`
--
ALTER TABLE `fb_question_options`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fb_question_options_mapping`
--
ALTER TABLE `fb_question_options_mapping`
 ADD KEY `qid` (`qid`), ADD KEY `oid` (`oid`);

--
-- Indexes for table `fb_question_template`
--
ALTER TABLE `fb_question_template`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fb_question_template_mapping`
--
ALTER TABLE `fb_question_template_mapping`
 ADD KEY `qid` (`qid`), ADD KEY `tid` (`tid`);

--
-- Indexes for table `fb_question_type`
--
ALTER TABLE `fb_question_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fb_session`
--
ALTER TABLE `fb_session`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fb_snist_questions`
--
ALTER TABLE `fb_snist_questions`
 ADD PRIMARY KEY (`id`), ADD KEY `type` (`type`);

--
-- Indexes for table `fb_user_type_template_mapping`
--
ALTER TABLE `fb_user_type_template_mapping`
 ADD KEY `tid` (`tid`), ADD KEY `gid` (`gid`);

--
-- Indexes for table `fo_forums`
--
ALTER TABLE `fo_forums`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`), ADD UNIQUE KEY `name_2` (`name`), ADD KEY `type` (`type`);

--
-- Indexes for table `fo_helpdesk_status`
--
ALTER TABLE `fo_helpdesk_status`
 ADD UNIQUE KEY `tid` (`tid`);

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
-- Indexes for table `fo_posts_banned`
--
ALTER TABLE `fo_posts_banned`
 ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `fo_post_likes`
--
ALTER TABLE `fo_post_likes`
 ADD KEY `pid` (`pid`), ADD KEY `uid` (`uid`);

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
-- Indexes for table `um_alumni_employment`
--
ALTER TABLE `um_alumni_employment`
 ADD KEY `id` (`id`);

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
-- Indexes for table `um_other_auth`
--
ALTER TABLE `um_other_auth`
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
-- Indexes for table `um_user_address`
--
ALTER TABLE `um_user_address`
 ADD KEY `id` (`id`);

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
-- AUTO_INCREMENT for table `fb_question_answers`
--
ALTER TABLE `fb_question_answers`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `fb_question_options`
--
ALTER TABLE `fb_question_options`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `fb_question_template`
--
ALTER TABLE `fb_question_template`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `fb_question_type`
--
ALTER TABLE `fb_question_type`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `fb_session`
--
ALTER TABLE `fb_session`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `fb_snist_questions`
--
ALTER TABLE `fb_snist_questions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `fo_forums`
--
ALTER TABLE `fo_forums`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `fo_posts`
--
ALTER TABLE `fo_posts`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=155;
--
-- AUTO_INCREMENT for table `fo_threads`
--
ALTER TABLE `fo_threads`
MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=49;
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `um_group_action_permits`
--
ALTER TABLE `um_group_action_permits`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `um_group_page_matches`
--
ALTER TABLE `um_group_page_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `um_nav`
--
ALTER TABLE `um_nav`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `um_nav_group_matches`
--
ALTER TABLE `um_nav_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `um_other_auth`
--
ALTER TABLE `um_other_auth`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `um_pages`
--
ALTER TABLE `um_pages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
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
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `um_user_action_permits`
--
ALTER TABLE `um_user_action_permits`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `um_user_group_matches`
--
ALTER TABLE `um_user_group_matches`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
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
-- Constraints for table `fb_alumni_suggestion`
--
ALTER TABLE `fb_alumni_suggestion`
ADD CONSTRAINT `fb_alumni_suggestion_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

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
-- Constraints for table `fb_question_answers`
--
ALTER TABLE `fb_question_answers`
ADD CONSTRAINT `fb_question_answers_ibfk_2` FOREIGN KEY (`qid`) REFERENCES `fb_snist_questions` (`id`),
ADD CONSTRAINT `fb_question_answers_ibfk_3` FOREIGN KEY (`tid`) REFERENCES `fb_question_template` (`id`),
ADD CONSTRAINT `fb_question_answers_ibfk_4` FOREIGN KEY (`uid`) REFERENCES `fb_session` (`id`);

--
-- Constraints for table `fb_question_options_mapping`
--
ALTER TABLE `fb_question_options_mapping`
ADD CONSTRAINT `fb_question_options_mapping_ibfk_1` FOREIGN KEY (`qid`) REFERENCES `fb_snist_questions` (`id`),
ADD CONSTRAINT `fb_question_options_mapping_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `fb_question_options` (`id`);

--
-- Constraints for table `fb_question_template_mapping`
--
ALTER TABLE `fb_question_template_mapping`
ADD CONSTRAINT `fb_question_template_mapping_ibfk_1` FOREIGN KEY (`qid`) REFERENCES `fb_snist_questions` (`id`),
ADD CONSTRAINT `fb_question_template_mapping_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `fb_question_template` (`id`);

--
-- Constraints for table `fb_snist_questions`
--
ALTER TABLE `fb_snist_questions`
ADD CONSTRAINT `fb_snist_questions_ibfk_1` FOREIGN KEY (`type`) REFERENCES `fb_question_type` (`id`);

--
-- Constraints for table `fb_user_type_template_mapping`
--
ALTER TABLE `fb_user_type_template_mapping`
ADD CONSTRAINT `fb_user_type_template_mapping_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `fb_question_template` (`id`),
ADD CONSTRAINT `fb_user_type_template_mapping_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `fb_question_template` (`id`),
ADD CONSTRAINT `fb_user_type_template_mapping_ibfk_3` FOREIGN KEY (`tid`) REFERENCES `fb_question_template` (`id`),
ADD CONSTRAINT `fb_user_type_template_mapping_ibfk_4` FOREIGN KEY (`gid`) REFERENCES `um_groups` (`id`);

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
-- Constraints for table `fo_posts_banned`
--
ALTER TABLE `fo_posts_banned`
ADD CONSTRAINT `fo_posts_banned_ibfk_1` FOREIGN KEY (`id`) REFERENCES `fo_posts` (`id`);

--
-- Constraints for table `fo_post_likes`
--
ALTER TABLE `fo_post_likes`
ADD CONSTRAINT `fo_post_likes_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `fo_posts` (`id`),
ADD CONSTRAINT `fo_post_likes_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);

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
-- Constraints for table `um_alumni_employment`
--
ALTER TABLE `um_alumni_employment`
ADD CONSTRAINT `um_alumni_employment_ibfk_1` FOREIGN KEY (`id`) REFERENCES `um_users` (`id`);

--
-- Constraints for table `um_batches`
--
ALTER TABLE `um_batches`
ADD CONSTRAINT `um_batches_ibfk_1` FOREIGN KEY (`deptid`) REFERENCES `um_department` (`id`);

--
-- Constraints for table `um_user_address`
--
ALTER TABLE `um_user_address`
ADD CONSTRAINT `um_user_address_ibfk_1` FOREIGN KEY (`id`) REFERENCES `um_users` (`id`);

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
ADD CONSTRAINT `um_user_subscriptions_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `um_users` (`id`);
--
-- Table structure for table `fo_post_images`
--

DROP TABLE IF EXISTS `fo_post_images`;
CREATE TABLE IF NOT EXISTS `fo_post_images` (
`id` int(11) NOT NULL,
  `image` longblob NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `um_images`
--

DROP TABLE IF EXISTS `um_images`;
CREATE TABLE IF NOT EXISTS `um_images` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `image` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fo_post_images`
--
ALTER TABLE `fo_post_images`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `um_images`
--
ALTER TABLE `um_images`
 ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fo_post_images`
--
ALTER TABLE `fo_post_images`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `um_images`
--
ALTER TABLE `um_images`
ADD CONSTRAINT `um_images_ibfk_1` FOREIGN KEY (`id`) REFERENCES `um_users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

