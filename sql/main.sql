-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: 67to
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `67to`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `67to` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `67to`;

--
-- Table structure for table `tour_members`
--

DROP TABLE IF EXISTS `tour_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tour_members` (
  `user_id` int(11) NOT NULL,
  `tour_id` int(11) NOT NULL,
  `status` enum('1','2','3','4') NOT NULL COMMENT '1：確定參加  2：尚未確定  3：僅追蹤  4：取消參加',
  `created_on` datetime NOT NULL COMMENT '新增時間'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='旅行團參加成員';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_members`
--

LOCK TABLES `tour_members` WRITE;
/*!40000 ALTER TABLE `tour_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `tour_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tours`
--

DROP TABLE IF EXISTS `tours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tours` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `title` varchar(100) NOT NULL COMMENT '團名',
  `user_id` int(11) NOT NULL COMMENT '開團者 ID ',
  `city_id` int(11) NOT NULL COMMENT '要遊覽的城市 ID，開立後不能更改',
  `start_from` datetime NOT NULL COMMENT '預計出遊日起',
  `end_to` datetime NOT NULL COMMENT '預計出遊日迄',
  `created_on` datetime NOT NULL COMMENT '新增時間，不得在出遊日前24小時開團',
  `modified_on` datetime NOT NULL COMMENT '修改時間，不得在出遊日前24小時修改',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='揪團資料表主檔';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tours`
--

LOCK TABLES `tours` WRITE;
/*!40000 ALTER TABLE `tours` DISABLE KEYS */;
/*!40000 ALTER TABLE `tours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_modify_history`
--

DROP TABLE IF EXISTS `user_modify_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_modify_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `user_id` int(11) NOT NULL COMMENT '使用者 ID',
  `fielld_name` int(11) NOT NULL COMMENT '修改的欄位名稱',
  `original_content` text NOT NULL COMMENT '修改前的值',
  `modify_content` text NOT NULL COMMENT '修改後的值',
  `created_on` datetime NOT NULL COMMENT '修改時間',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='使用者資料修改紀錄';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_modify_history`
--

LOCK TABLES `user_modify_history` WRITE;
/*!40000 ALTER TABLE `user_modify_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_modify_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_options`
--

DROP TABLE IF EXISTS `user_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '使用者 ID',
  `field_name` varchar(50) NOT NULL,
  `value_type` enum('json','string','integer','float') NOT NULL COMMENT '欄位屬性',
  `value_content` text NOT NULL COMMENT '欄位值',
  `created_on` datetime NOT NULL COMMENT '塞入時間，若要查變更紀錄，則去 user_modify_history',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main_unique` (`user_id`,`field_name`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='使用者其餘特定選項修改內容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_options`
--

LOCK TABLES `user_options` WRITE;
/*!40000 ALTER TABLE `user_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主鍵',
  `username` varchar(30) NOT NULL COMMENT '帳號，英數字圓，最多三十個 bytes',
  `userpass` varchar(60) NOT NULL COMMENT '密碼，內容會加 salt',
  `created_on` datetime NOT NULL COMMENT '新增時間',
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='使用者帳戶資料';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-18 16:21:46
