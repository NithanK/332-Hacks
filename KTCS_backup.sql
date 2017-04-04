-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: 0.0.0.0    Database: KTCS
-- ------------------------------------------------------
-- Server version	5.5.54-0ubuntu0.14.04.1

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
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
  `VIN` varchar(50) NOT NULL,
  `parking_locations_pl_id` varchar(50) NOT NULL,
  `make` varchar(45) NOT NULL,
  `model` varchar(45) NOT NULL,
  `year` year(4) NOT NULL,
  `daily_fee` double NOT NULL,
  `license_plate` varchar(45) NOT NULL,
  `colour` varchar(45) NOT NULL,
  PRIMARY KEY (`VIN`,`parking_locations_pl_id`),
  UNIQUE KEY `VIN_UNIQUE` (`VIN`),
  KEY `fk_cars_parking_locations_idx` (`parking_locations_pl_id`),
  CONSTRAINT `fk_cars_parking_locations` FOREIGN KEY (`parking_locations_pl_id`) REFERENCES `parking_location` (`pl_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('1000','110','Nissan','Altima',2003,30,'ASH456','beige'),('1010','100','Tesla','Model X',2016,60,'ELON000','white'),('1020','100','Toyota','Camry',2016,30,'TOY056','silver'),('1030','150','Honda','Odyssey',2012,25,'VAN9A1','silver'),('1040','110','Kia','Forte',2015,22,'KIA877','orange'),('1050','150','Honda','Accord',2010,20,'ACC003','black'),('3378166401','4997049585258','Ford','Focus',2010,35,'20PLATE','Grey'),('476582901','100','Lancia','Beta',1975,10,'DMTRI55','Grey'),('5862142648','110','Toyota','Matrix',2012,50,'bbq69','blue'),('7137821063','4997049585258','Lexus','IS250',2017,60,'LEX500','Black');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_rental_history`
--

DROP TABLE IF EXISTS `car_rental_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car_rental_history` (
  `car_VIN` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `member_member_number` varchar(50) NOT NULL,
  `pu_reading` double NOT NULL,
  `do_reading` double NOT NULL,
  `status_on_return` varchar(45) NOT NULL,
  `distance` double NOT NULL,
  `pu_time` datetime DEFAULT NULL,
  `do_time` datetime DEFAULT NULL,
  `status_on_pickup` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`car_VIN`,`date`,`member_member_number`),
  KEY `fk_car_rental_history_car1_idx` (`car_VIN`),
  KEY `fk_car_rental_history_member1_idx` (`member_member_number`),
  CONSTRAINT `fk_car_rental_history_car1` FOREIGN KEY (`car_VIN`) REFERENCES `car` (`VIN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_rental_history_member1` FOREIGN KEY (`member_member_number`) REFERENCES `member` (`member_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_rental_history`
--

LOCK TABLES `car_rental_history` WRITE;
/*!40000 ALTER TABLE `car_rental_history` DISABLE KEYS */;
INSERT INTO `car_rental_history` VALUES ('1000','2017-02-09','50010',450.2,510.9,'normal',60.7,NULL,NULL,NULL),('1000','2017-03-24','50000',100,1010,'normal',910,'2017-04-01 17:56:46','2017-04-01 17:56:57','normal'),('1010','2017-03-31','4338111426',510.4,529,'normal',18.600000000000023,NULL,'2017-04-02 16:44:48',NULL),('1010','2017-04-03','50000',45,50,'damaged',5,'2017-04-03 14:23:29','2017-04-03 14:23:44','normal'),('1020','2017-02-14','50010',310.9,350.1,'normal',39.2,NULL,NULL,NULL),('1020','2017-02-16','50030',350.1,531.2,'normal',21.1,NULL,NULL,NULL),('1030','2017-02-10','50000',10020,10074.7,'normal',54.7,NULL,NULL,NULL),('1030','2017-04-02','4338111426',85000,85001,'normal',1,'2017-04-02 17:48:14','2017-04-02 17:48:29','normal'),('1030','2017-04-04','4442521040',98,198,'normal',100,'2017-04-04 13:17:12','2017-04-04 13:17:58','normal'),('1030','2017-04-04','50000',30,6030,'damaged',6000,'2017-04-04 13:00:31','2017-04-04 13:00:39','normal'),('1040','2017-03-04','50010',191,298.5,'normal',107.5,NULL,NULL,NULL),('1040','2017-04-02','50000',999,1999,'normal',1000,'2017-04-03 18:39:08','2017-04-03 18:39:14','normal'),('1040','2017-04-03','50000',12,14,'normal',2,'2017-04-03 19:02:22','2017-04-03 19:02:28','normal'),('1050','2017-03-30','50000',10,20,'not running',10,'2017-04-03 14:24:15','2017-04-03 14:24:24','normal'),('1050','2017-03-31','4338111426',900,1200,'not running',300,'2017-04-02 16:51:53','2017-04-02 17:21:58','normal'),('1050','2017-04-03','4338111426',700,740,'normal',40,'2017-04-04 13:04:35','2017-04-04 13:04:43','normal'),('3378166401','2017-04-02','4338111426',1111,1500,'normal',389,'2017-04-01 17:54:26','2017-04-03 13:32:58','normal'),('3378166401','2017-04-03','50000',700,702,'normal',2,'2017-04-03 18:38:45','2017-04-03 18:38:58','normal'),('3378166401','2017-04-04','50000',45,5045,'normal',5000,'2017-04-04 12:58:03','2017-04-04 12:58:15','normal'),('476582901','2017-04-04','50000',30,30,'not_yet_returned',0,'2017-04-04 12:59:01',NULL,'normal'),('5862142648','2017-03-31','4338111426',1900,2100,'damaged',200,'2017-04-01 14:31:26','2017-04-01 15:23:14','normal'),('7137821063','2017-04-01','50000',8000,15000,'normal',7000,'2017-04-04 11:59:11','2017-04-04 11:59:31','normal');
/*!40000 ALTER TABLE `car_rental_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_history`
--

DROP TABLE IF EXISTS `maintenance_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenance_history` (
  `cars_VIN` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `odometer_reading` double NOT NULL,
  `type` varchar(45) NOT NULL,
  `description` varchar(250) NOT NULL,
  PRIMARY KEY (`cars_VIN`,`date`),
  KEY `fk_maintenance_history_cars1_idx` (`cars_VIN`),
  CONSTRAINT `fk_maintenance_history_cars1` FOREIGN KEY (`cars_VIN`) REFERENCES `car` (`VIN`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_history`
--

LOCK TABLES `maintenance_history` WRITE;
/*!40000 ALTER TABLE `maintenance_history` DISABLE KEYS */;
INSERT INTO `maintenance_history` VALUES ('1000','2017-01-01',0,'N/A','initial maintenance'),('1010','2017-01-14',3034.6,'scheduled','oil change'),('1010','2017-04-03',50,'Body Work','dents'),('1020','2017-01-01',0,'N/A','initial maintenance'),('1030','2017-01-01',0,'N/A','initial maintenance'),('1030','2017-04-04',6030,'Body Work','dents'),('1040','2017-01-01',0,'N/A','initial maintenance'),('1050','2017-01-01',0,'N/A','initial maintenance'),('3378166401','2017-01-01',0,'N/A','initial maintenance'),('3378166401','2017-04-04',0,'Body Work','dents'),('476582901','2017-04-04',0,'N/A','Working Fine'),('5862142648','2017-01-01',0,'N/A','initial maintenance'),('7137821063','2017-01-01',0,'N/A','initial maintenance');
/*!40000 ALTER TABLE `maintenance_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `member_number` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `license_number` varchar(10) NOT NULL,
  `annual_fee` double NOT NULL,
  PRIMARY KEY (`member_number`),
  UNIQUE KEY `member_number_UNIQUE` (`member_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('1888158023','Admin','N/A','N/A','admin@queensu.ca','N/A',150),('4338111426','332 Student','fake','fake','noam@fake.com','fake',150),('4442521040','Dmitri','904 Braelorne Place','6138887654','dmitri@dota.com','0398743987',150),('50000','Mike Williams','490 Princess Street','6134445555','mike@queensu.ca','1234987',100),('50010','Bart Simpson','29 Union Street','6139998888','bart@simpsons.com','5547382',120),('50020','Jon Nicolson','14 Victoria Street','6139877792','jon@yahoo.com','7918237',100),('50030','Paulina Cruse','51 Frontenac Street','6131244245','pualina@databases.net','5028880',105);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_location`
--

DROP TABLE IF EXISTS `parking_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parking_location` (
  `pl_id` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `num_spaces` int(11) NOT NULL,
  PRIMARY KEY (`pl_id`),
  UNIQUE KEY `pl_id_UNIQUE` (`pl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_location`
--

LOCK TABLES `parking_location` WRITE;
/*!40000 ALTER TABLE `parking_location` DISABLE KEYS */;
INSERT INTO `parking_location` VALUES ('100','4300 Princess Street',12),('110','33 University Avenue',5),('150','40 Earl Street',6),('4997049585258','91 Brock Street',8);
/*!40000 ALTER TABLE `parking_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rental_comment`
--

DROP TABLE IF EXISTS `rental_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rental_comment` (
  `car_VIN` varchar(50) NOT NULL,
  `member_member_number` varchar(50) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `comment_reply` varchar(200) NOT NULL,
  PRIMARY KEY (`car_VIN`,`member_member_number`),
  KEY `fk_rental_comment_member1_idx` (`member_member_number`),
  KEY `fk_rental_comment_car1_idx` (`car_VIN`),
  CONSTRAINT `fk_rental_comment_car1` FOREIGN KEY (`car_VIN`) REFERENCES `car` (`VIN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_comment_member1` FOREIGN KEY (`member_member_number`) REFERENCES `member` (`member_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_comment`
--

LOCK TABLES `rental_comment` WRITE;
/*!40000 ALTER TABLE `rental_comment` DISABLE KEYS */;
INSERT INTO `rental_comment` VALUES ('1000','50010',4,'Nice sound system!',''),('1010','4338111426',5,'fun car!','hello'),('1020','50010',4,'Fast!',''),('1030','4338111426',2,'testing','what?'),('1030','4442521040',4,'good safety features','thanks for your feedback!'),('1030','50000',3,'Satisfied',''),('1040','50010',3,'Interesting colour choice',''),('1050','4338111426',2,'what','what?'),('3378166401','4338111426',2,'what','what?');
/*!40000 ALTER TABLE `rental_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `res_number` varchar(50) NOT NULL,
  `car_VIN` varchar(50) NOT NULL,
  `member_member_number` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `access_code` varchar(45) NOT NULL,
  `length_days` int(11) NOT NULL,
  `unlocked` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`res_number`,`car_VIN`,`member_member_number`),
  UNIQUE KEY `res_number_UNIQUE` (`res_number`),
  KEY `fk_reservation_member1_idx` (`member_member_number`),
  KEY `fk_reservation_car1_idx` (`car_VIN`),
  CONSTRAINT `fk_reservation_car1` FOREIGN KEY (`car_VIN`) REFERENCES `car` (`VIN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_member1` FOREIGN KEY (`member_member_number`) REFERENCES `member` (`member_number`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES ('122476262','1050','50000','2017-04-09','393320479454421388',1,NULL),('124474731','1020','50010','2017-04-03','95773469592256649',1,NULL),('125024742','1050','50000','2017-04-11','393320479454421388',1,NULL),('125138647','1000','50010','2017-04-06','75166022976637416',1,NULL),('125303437','1050','4338111426','2017-04-07','102103571629028212',1,NULL),('125544921','1050','50010','2017-04-18','49686650065180996',1,NULL),('143574418','1050','50010','2017-04-19','49686650065180996',1,NULL),('144820017','1010','1888158023','2017-04-06','298000794224540551',1,NULL),('15044568','1050','50010','2017-04-15','49686650065180996',1,NULL),('151620106','1050','50000','2017-04-10','393320479454421388',1,NULL),('15989269','476582901','50010','2017-04-05','193102305083065492',1,NULL),('167965456','1020','4442521040','2017-04-05','305947431363383927',1,NULL),('205571358','1020','50010','2017-04-07','195332954973615390',1,NULL),('213219337','1030','50000','2017-04-07','131976591595964697',1,NULL),('215616903','1000','50010','2017-04-07','75166022976637416',1,NULL),('22156798','476582901','50010','2017-04-08','193102305083065492',1,NULL),('229448307','1030','50010','2017-03-30','184964137379271492',1,NULL),('236985160','1050','50010','2017-04-17','49686650065180996',1,NULL),('242118394','3378166401','4442521040','2017-04-04','235273991669865615',1,NULL),('261791715','1020','50010','2017-04-06','195332954973615390',1,NULL),('27251102','476582901','50010','2017-04-06','193102305083065492',1,NULL),('278205764','1050','50000','2017-04-08','393320479454421388',1,NULL),('283450040','1020','4442521040','2017-04-04','305947431363383927',1,NULL),('325823164','1000','50000','2017-04-14','198047127380262395',1,NULL),('328915074','1010','4338111426','2017-06-01','343723719556202814',1,NULL),('367851088','1050','50010','2017-04-16','49686650065180996',1,NULL),('41244179','476582901','50010','2017-04-07','193102305083065492',1,NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-04 18:40:57
