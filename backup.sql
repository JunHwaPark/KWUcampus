-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: UNIVERSITY
-- ------------------------------------------------------
-- Server version	10.3.15-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `Cid` char(10) NOT NULL,
  `Mno` int(11) NOT NULL,
  `Ano` int(11) NOT NULL,
  `Aname` varchar(50) NOT NULL,
  PRIMARY KEY (`Cid`,`Mno`,`Ano`),
  CONSTRAINT `attachments_ibfk_1` FOREIGN KEY (`Cid`, `Mno`) REFERENCES `materials` (`Cid`, `Mno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` VALUES ('H030336631',1,1,'att.txt'),('H030336631',1,2,'att2.txt');
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `Cid` char(10) NOT NULL,
  `CName` varchar(15) DEFAULT NULL,
  `Pid` char(10) NOT NULL,
  PRIMARY KEY (`Cid`),
  KEY `Pid` (`Pid`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `professor` (`Pid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('H030309692','알고리즘','3456789012'),('H030336631','DB','1234567890');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enroll`
--

DROP TABLE IF EXISTS `enroll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enroll` (
  `Sid` char(10) NOT NULL,
  `Cid` char(10) NOT NULL,
  PRIMARY KEY (`Sid`,`Cid`),
  KEY `Cid` (`Cid`),
  CONSTRAINT `enroll_ibfk_1` FOREIGN KEY (`Sid`) REFERENCES `student` (`Sid`) ON DELETE CASCADE,
  CONSTRAINT `enroll_ibfk_2` FOREIGN KEY (`Cid`) REFERENCES `course` (`Cid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enroll`
--

LOCK TABLES `enroll` WRITE;
/*!40000 ALTER TABLE `enroll` DISABLE KEYS */;
INSERT INTO `enroll` VALUES ('2015202065','H030336631'),('2015508126','H030309682'),('2015508126','H030336631'),('2018203090','H030309682');
/*!40000 ALTER TABLE `enroll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materials` (
  `Cid` char(10) NOT NULL,
  `Mno` int(11) NOT NULL,
  `Title` varchar(30) NOT NULL,
  `Content` varchar(512) NOT NULL,
  `Date` date NOT NULL,
  `Views` int(11) DEFAULT NULL,
  PRIMARY KEY (`Cid`,`Mno`),
  CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`Cid`) REFERENCES `course` (`Cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES ('H030309692',1,'This is first','This is 1st algorithm material.','2019-06-01',0),('H030336631',1,'This is first','This is 1st database material.','2019-06-01',0),('H030336631',2,'This is second','This is 2nd database material.','2019-06-01',0);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note` (
  `Sid` char(10) NOT NULL,
  `Nno` int(11) NOT NULL,
  `Content` varchar(512) DEFAULT NULL,
  `Cid` char(10) NOT NULL,
  PRIMARY KEY (`Sid`,`Nno`),
  KEY `Cid` (`Cid`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`Sid`) REFERENCES `student` (`Sid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `note_ibfk_2` FOREIGN KEY (`Cid`) REFERENCES `course` (`Cid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES ('2015508126',1,'This is first note.','H030336631');
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `Pid` char(10) NOT NULL,
  `Ppassword` varchar(20) NOT NULL,
  `Pname` varchar(5) NOT NULL,
  PRIMARY KEY (`Pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('1234567890','thisispassword','김우생'),('2345678901','thatispassword','안우현'),('3456789012','thiswaspassword','김용혁');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `Sid` char(10) NOT NULL,
  `Spassword` varchar(20) NOT NULL,
  `Sname` varchar(5) NOT NULL,
  `Year` int(11) NOT NULL,
  `Email` varchar(30) DEFAULT NULL,
  `Pno` char(11) DEFAULT NULL,
  `Dept` varchar(15) NOT NULL,
  PRIMARY KEY (`Sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2015202065','whatthepassword','윤홍찬',3,'hongchan@gmail.com','01012123434','소프트웨어학부'),('2015508126','whatispassword','박준화',3,'a28165415@gmail.com','01048278274','소프트웨어학부'),('2018203090','passwordispassword','김광호',2,'kwang@gmail.com','01034341212','소프트웨어학부'),('2019101001','1styearstudentwow','홍길동',1,'hong@gmail.com','01012345678','경영학부'),('2019111001','insertdbisdifficult','도깨비',1,'dockeabee@gmail.com','01044527782','컴퓨터정보공학부');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-01  2:13:15
