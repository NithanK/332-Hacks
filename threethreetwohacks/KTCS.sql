-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: KTCS
-- ------------------------------------------------------
-- Server version	5.7.17

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
INSERT INTO `car` VALUES ('1000','110','Nissan','Altima',2003,30,'ASH456','beige'),('1010','100','Tesla','Model X',2016,60,'ELON000','white'),('1020','100','Toyota','Camry',2016,30,'TOY056','silver'),('1030','150','Honda','Odyssey',2012,25,'VAN9A1','silver'),('1040','110','Kia','Forte',2015,22,'KIA877','orange'),('1050','150','Honda','Accord',2010,20,'ACC003','black');
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
INSERT INTO `car_rental_history` VALUES ('1000','2017-02-09','50010',450.2,510.9,'normal',60.7),('1020','2017-02-14','50010',310.9,350.1,'normal',39.2),('1020','2017-02-16','50030',350.1,531.2,'normal',21.1),('1030','2017-02-10','50000',10020,10074.7,'normal',54.7),('1040','2017-03-04','50010',191,298.5,'normal',107.5);
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
INSERT INTO `maintenance_history` VALUES ('1010','2017-01-14',3034.6,'scheduled','oil change');
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
INSERT INTO `member` VALUES ('50000','Mike Williams','490 Princess Street','6134445555','mike@queensu.ca','1234987',100),('50010','Bart Simpson','29 Union Street','6139998888','bart@simpsons.com','5547382',120),('50020','Jon Nicolson','14 Victoria Street','6139877792','jon@yahoo.com','7918237',100),('50030','Paulina Cruse','51 Frontenac Street','6131244245','pualina@databases.net','5028880',105);
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
INSERT INTO `parking_location` VALUES ('100','4300 Princess Street',12),('110','33 University Avenue',5),('150','40 Earl Street',6);
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
INSERT INTO `rental_comment` VALUES ('1000','50010',4,'Nice sound system!'),('1020','50010',4,'Fast!'),('1030','50000',3,'Satisfied'),('1040','50010',3,'Interesting colour choice');
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
INSERT INTO `reservation` VALUES ('10','1000','50010','2017-02-25','KTCS60abc',3),('20','1020','50030','2017-03-12','KTSC09car',4),('30','1010','50020','2017-03-24','NNN002',2);
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

-- Dump completed on 2017-03-25 16:28:39
