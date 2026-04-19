CREATE DATABASE  IF NOT EXISTS `martialartsschooldb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `martialartsschooldb`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: martialartsschooldb
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `enrolled`
--

DROP TABLE IF EXISTS `enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrolled` (
  `StudentID` int NOT NULL,
  `MAID` int NOT NULL,
  `Enroll_Date` date NOT NULL,
  PRIMARY KEY (`StudentID`,`MAID`),
  KEY `fk_enrolled_martialart` (`MAID`),
  CONSTRAINT `fk_enrolled_martialart` FOREIGN KEY (`MAID`) REFERENCES `martialarts` (`MAID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enrolled_student` FOREIGN KEY (`StudentID`) REFERENCES `students` (`StudentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrolled`
--

LOCK TABLES `enrolled` WRITE;
/*!40000 ALTER TABLE `enrolled` DISABLE KEYS */;
INSERT INTO `enrolled` VALUES (1,1,'2026-01-10'),(1,2,'2026-03-08'),(2,1,'2026-01-15'),(3,2,'2026-02-01'),(4,3,'2026-02-10'),(5,4,'2026-03-20'),(6,5,'2026-04-01');
/*!40000 ALTER TABLE `enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `instructorassignmentview`
--

DROP TABLE IF EXISTS `instructorassignmentview`;
/*!50001 DROP VIEW IF EXISTS `instructorassignmentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `instructorassignmentview` AS SELECT 
 1 AS `InstructorID`,
 1 AS `iname`,
 1 AS `MAID`,
 1 AS `ClassName`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructors` (
  `InstructorID` int NOT NULL AUTO_INCREMENT,
  `iname` varchar(100) NOT NULL,
  `DOB` date NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`InstructorID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT INTO `instructors` VALUES (1,'Sensei Jahani','1985-09-12','4075552003','132 Visual Arts Building'),(2,'Coach Lee','1940-11-27','4075552005','500 New Dojo Ave'),(3,'Master Jonathan','1982-03-21','4075531982','78 Black Belt Blvd'),(4,'Sensei Po','1988-12-11','3215452004','998 Dragon Warrior Way'),(5,'Sensei Miyagi','1932-09-19','4075552155','150 Palm Ave');
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `martialarts`
--

DROP TABLE IF EXISTS `martialarts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `martialarts` (
  `MAID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`MAID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `martialarts`
--

LOCK TABLES `martialarts` WRITE;
/*!40000 ALTER TABLE `martialarts` DISABLE KEYS */;
INSERT INTO `martialarts` VALUES (4,'Brazilian Jiu-Jitsu'),(1,'Goju-Ryu'),(3,'Judo'),(5,'Kickboxing'),(2,'Taekwondo');
/*!40000 ALTER TABLE `martialarts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `martialartsranksview`
--

DROP TABLE IF EXISTS `martialartsranksview`;
/*!50001 DROP VIEW IF EXISTS `martialartsranksview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `martialartsranksview` AS SELECT 
 1 AS `MAID`,
 1 AS `name`,
 1 AS `RankName`,
 1 AS `level`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rank_ids`
--

DROP TABLE IF EXISTS `rank_ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rank_ids` (
  `RankID` int NOT NULL AUTO_INCREMENT,
  `Rank_MAID` int NOT NULL,
  `Rank_levelID` int NOT NULL,
  PRIMARY KEY (`RankID`),
  KEY `fk_rank_maid_idx` (`Rank_MAID`),
  KEY `fk_rank_level_idx` (`Rank_levelID`),
  CONSTRAINT `fk_rank_level` FOREIGN KEY (`Rank_levelID`) REFERENCES `rank_level` (`levelID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rank_maid` FOREIGN KEY (`Rank_MAID`) REFERENCES `martialarts` (`MAID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank_ids`
--

LOCK TABLES `rank_ids` WRITE;
/*!40000 ALTER TABLE `rank_ids` DISABLE KEYS */;
INSERT INTO `rank_ids` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,2,1),(7,2,2),(8,2,3),(9,2,4),(10,2,5),(11,3,1),(12,3,2),(13,3,3),(14,3,4),(15,3,5),(16,4,1),(17,4,2),(18,4,3),(19,4,4),(20,4,5),(21,5,6),(22,5,7),(23,5,8);
/*!40000 ALTER TABLE `rank_ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank_level`
--

DROP TABLE IF EXISTS `rank_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rank_level` (
  `levelID` int NOT NULL AUTO_INCREMENT,
  `RankName` varchar(50) NOT NULL,
  `level` int NOT NULL,
  PRIMARY KEY (`levelID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank_level`
--

LOCK TABLES `rank_level` WRITE;
/*!40000 ALTER TABLE `rank_level` DISABLE KEYS */;
INSERT INTO `rank_level` VALUES (1,'White Belt',1),(2,'Yellow Belt',2),(3,'Green Belt',3),(4,'Brown Belt',4),(5,'Black Belt',5),(6,'Beginner',1),(7,'Intermediate',2),(8,'Advanced',3);
/*!40000 ALTER TABLE `rank_level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `studentenrollmentview`
--

DROP TABLE IF EXISTS `studentenrollmentview`;
/*!50001 DROP VIEW IF EXISTS `studentenrollmentview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `studentenrollmentview` AS SELECT 
 1 AS `StudentID`,
 1 AS `sname`,
 1 AS `MAID`,
 1 AS `ClassName`,
 1 AS `Enroll_Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `StudentID` int NOT NULL AUTO_INCREMENT,
  `sname` varchar(100) NOT NULL,
  `DOB` date NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`StudentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Riley Parkin','2003-12-29','3215551111','123 Sesame St'),(2,'Ryan Acevedo','2004-09-22','3215551002','456 Oak Ave'),(3,'Carly Simpson','2004-02-24','7195551003','789 Pine Rd'),(4,'Daniel LaRusso','1995-11-18','3215551004','222 Lake Dr'),(5,'Shaggy Rogers','1950-07-09','3215551005','901 Palm St'),(6,'Johnny Lawrence','2006-05-14','3215551006','45 Sunset Blvd');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teaches`
--

DROP TABLE IF EXISTS `teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teaches` (
  `InstructorID` int NOT NULL,
  `MAID` int NOT NULL,
  PRIMARY KEY (`InstructorID`,`MAID`),
  KEY `fk_teaches_martialart` (`MAID`),
  CONSTRAINT `fk_teaches_instructor` FOREIGN KEY (`InstructorID`) REFERENCES `instructors` (`InstructorID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_teaches_martialart` FOREIGN KEY (`MAID`) REFERENCES `martialarts` (`MAID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teaches`
--

LOCK TABLES `teaches` WRITE;
/*!40000 ALTER TABLE `teaches` DISABLE KEYS */;
INSERT INTO `teaches` VALUES (1,1),(3,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `teaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'martialartsschooldb'
--

--
-- Dumping routines for database 'martialartsschooldb'
--

--
-- Final view structure for view `instructorassignmentview`
--

/*!50001 DROP VIEW IF EXISTS `instructorassignmentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `instructorassignmentview` AS select `i`.`InstructorID` AS `InstructorID`,`i`.`iname` AS `iname`,`m`.`MAID` AS `MAID`,`m`.`name` AS `ClassName` from ((`instructors` `i` join `teaches` `t` on((`i`.`InstructorID` = `t`.`InstructorID`))) join `martialarts` `m` on((`t`.`MAID` = `m`.`MAID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `martialartsranksview`
--

/*!50001 DROP VIEW IF EXISTS `martialartsranksview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `martialartsranksview` AS select `m`.`MAID` AS `MAID`,`m`.`name` AS `name`,`l`.`RankName` AS `RankName`,`l`.`level` AS `level` from ((`martialarts` `m` join `rank_ids` `i` on((`m`.`MAID` = `i`.`Rank_MAID`))) join `rank_level` `l` on((`i`.`Rank_levelID` = `l`.`levelID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentenrollmentview`
--

/*!50001 DROP VIEW IF EXISTS `studentenrollmentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentenrollmentview` AS select `s`.`StudentID` AS `StudentID`,`s`.`sname` AS `sname`,`m`.`MAID` AS `MAID`,`m`.`name` AS `ClassName`,`e`.`Enroll_Date` AS `Enroll_Date` from ((`students` `s` join `enrolled` `e` on((`s`.`StudentID` = `e`.`StudentID`))) join `martialarts` `m` on((`e`.`MAID` = `m`.`MAID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-19 18:49:27
