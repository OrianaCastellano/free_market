CREATE DATABASE  IF NOT EXISTS `db_free_market` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `db_free_market`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: db_free_market
-- ------------------------------------------------------
-- Server version	5.7.32

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
-- Table structure for table `tbl_category`
--

DROP TABLE IF EXISTS `tbl_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `category_decription` text NOT NULL,
  `category_image` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_category`
--

LOCK TABLES `tbl_category` WRITE;
/*!40000 ALTER TABLE `tbl_category` DISABLE KEYS */;
INSERT INTO `tbl_category` VALUES (5,'Tecnologia','catálogo variado de productos con la más alta tecnología. En esta sección encontrarás televisores con resolución 4k UHD, smartphones con el mayor desempeño, así como con diseños elegantes y mucho mas',NULL),(6,'Jugueteria & Accesorios','Encuentra diferentes tipos de juguetes para la diversión de niños y niñas de todas las edades. Carros, muñecas, juguetes lúdicos, juegos de mesa o para disfrutar en exteriores son algunos de los productos que podrás encontrar en nuestro catálogo',NULL),(7,'Hogar y Decoración','diferentes productos que logran renovar tus espacios y darle un nuevo aire a cada espacio. Encuentra aquí elementos de organización o decoración',NULL);
/*!40000 ALTER TABLE `tbl_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detail_notifactions`
--

DROP TABLE IF EXISTS `tbl_detail_notifactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_detail_notifactions` (
  `tbl_notification_notification_id` int(11) NOT NULL,
  `tbl_user_user_id` int(11) NOT NULL,
  `detail_notifcation_product` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`tbl_notification_notification_id`,`tbl_user_user_id`),
  KEY `fk_tbl_notification_has_tbl_user_tbl_user1_idx` (`tbl_user_user_id`),
  KEY `fk_tbl_notification_has_tbl_user_tbl_notification1_idx` (`tbl_notification_notification_id`),
  CONSTRAINT `fk_tbl_notification_has_tbl_user_tbl_notification1` FOREIGN KEY (`tbl_notification_notification_id`) REFERENCES `tbl_notification` (`notification_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_notification_has_tbl_user_tbl_user1` FOREIGN KEY (`tbl_user_user_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detail_notifactions`
--

LOCK TABLES `tbl_detail_notifactions` WRITE;
/*!40000 ALTER TABLE `tbl_detail_notifactions` DISABLE KEYS */;
INSERT INTO `tbl_detail_notifactions` VALUES (1,2,'Notificaion del producto tal');
/*!40000 ALTER TABLE `tbl_detail_notifactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detail_review_product`
--

DROP TABLE IF EXISTS `tbl_detail_review_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_detail_review_product` (
  `tbl_product_product_id` int(11) NOT NULL,
  `tbl_review_review_id` int(11) NOT NULL,
  PRIMARY KEY (`tbl_product_product_id`,`tbl_review_review_id`),
  KEY `fk_tbl_product_has_tbl_review_tbl_review1_idx` (`tbl_review_review_id`),
  KEY `fk_tbl_product_has_tbl_review_tbl_product1_idx` (`tbl_product_product_id`),
  CONSTRAINT `fk_tbl_product_has_tbl_review_tbl_product1` FOREIGN KEY (`tbl_product_product_id`) REFERENCES `tbl_product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_product_has_tbl_review_tbl_review1` FOREIGN KEY (`tbl_review_review_id`) REFERENCES `tbl_review` (`review_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detail_review_product`
--

LOCK TABLES `tbl_detail_review_product` WRITE;
/*!40000 ALTER TABLE `tbl_detail_review_product` DISABLE KEYS */;
INSERT INTO `tbl_detail_review_product` VALUES (1,1);
/*!40000 ALTER TABLE `tbl_detail_review_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_detail_user_product`
--

DROP TABLE IF EXISTS `tbl_detail_user_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_detail_user_product` (
  `tbl_user_user_id` int(11) NOT NULL,
  `tbl_product_product_id` int(11) NOT NULL,
  PRIMARY KEY (`tbl_user_user_id`,`tbl_product_product_id`),
  KEY `fk_tbl_user_has_tbl_product_tbl_product1_idx` (`tbl_product_product_id`),
  KEY `fk_tbl_user_has_tbl_product_tbl_user1_idx` (`tbl_user_user_id`),
  CONSTRAINT `fk_tbl_user_has_tbl_product_tbl_product1` FOREIGN KEY (`tbl_product_product_id`) REFERENCES `tbl_product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_user_has_tbl_product_tbl_user1` FOREIGN KEY (`tbl_user_user_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_detail_user_product`
--

LOCK TABLES `tbl_detail_user_product` WRITE;
/*!40000 ALTER TABLE `tbl_detail_user_product` DISABLE KEYS */;
INSERT INTO `tbl_detail_user_product` VALUES (2,1);
/*!40000 ALTER TABLE `tbl_detail_user_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_notification`
--

DROP TABLE IF EXISTS `tbl_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_notification` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_title` varchar(200) NOT NULL,
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_notification`
--

LOCK TABLES `tbl_notification` WRITE;
/*!40000 ALTER TABLE `tbl_notification` DISABLE KEYS */;
INSERT INTO `tbl_notification` VALUES (1,'Nueva reseñea del producto tal');
/*!40000 ALTER TABLE `tbl_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_product`
--

DROP TABLE IF EXISTS `tbl_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_title` varchar(50) NOT NULL,
  `product_description` text NOT NULL,
  `product_image` text,
  `product_price` double NOT NULL,
  `tbl_category_category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`tbl_category_category_id`),
  KEY `fk_tbl_product_tbl_category1_idx` (`tbl_category_category_id`),
  CONSTRAINT `fk_tbl_product_tbl_category1` FOREIGN KEY (`tbl_category_category_id`) REFERENCES `tbl_category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product`
--

LOCK TABLES `tbl_product` WRITE;
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT INTO `tbl_product` VALUES (1,'\nRompecabezas 24 piezas blister Avengers - Toyng','Rompecabezas 24 piezas blister Avengers',NULL,8.99,6);
/*!40000 ALTER TABLE `tbl_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_request_review`
--

DROP TABLE IF EXISTS `tbl_request_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_request_review` (
  `request_id` int(11) NOT NULL AUTO_INCREMENT,
  `request_description` text NOT NULL,
  `request_vote_good` int(11) NOT NULL,
  `request_vote_bad` int(11) NOT NULL,
  `tbl_review_review_id` int(11) NOT NULL,
  PRIMARY KEY (`request_id`,`tbl_review_review_id`),
  KEY `fk_tbl_request_review_tbl_review1_idx` (`tbl_review_review_id`),
  CONSTRAINT `fk_tbl_request_review_tbl_review1` FOREIGN KEY (`tbl_review_review_id`) REFERENCES `tbl_review` (`review_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_request_review`
--

LOCK TABLES `tbl_request_review` WRITE;
/*!40000 ALTER TABLE `tbl_request_review` DISABLE KEYS */;
INSERT INTO `tbl_request_review` VALUES (1,'-transporte y calidad de caja',1,0,1);
/*!40000 ALTER TABLE `tbl_request_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_review`
--

DROP TABLE IF EXISTS `tbl_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_review` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `review_title` varchar(100) NOT NULL,
  `review_description` text NOT NULL,
  `review_qualification` int(11) NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_review`
--

LOCK TABLES `tbl_review` WRITE;
/*!40000 ALTER TABLE `tbl_review` DISABLE KEYS */;
INSERT INTO `tbl_review` VALUES (1,'Competentes','Excelente producto tiene muy buena duración de batería, la caja los carga unas 4 veces, ',5);
/*!40000 ALTER TABLE `tbl_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_subcategory`
--

DROP TABLE IF EXISTS `tbl_subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_subcategory` (
  `subcategory_id` int(11) NOT NULL AUTO_INCREMENT,
  `subcategory_name` varchar(50) NOT NULL,
  `subcategory_description` text NOT NULL,
  `tbl_category_category_id` int(11) NOT NULL,
  PRIMARY KEY (`subcategory_id`,`tbl_category_category_id`),
  KEY `fk_tbl_subcategory_tbl_category1_idx` (`tbl_category_category_id`),
  CONSTRAINT `fk_tbl_subcategory_tbl_category1` FOREIGN KEY (`tbl_category_category_id`) REFERENCES `tbl_category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_subcategory`
--

LOCK TABLES `tbl_subcategory` WRITE;
/*!40000 ALTER TABLE `tbl_subcategory` DISABLE KEYS */;
INSERT INTO `tbl_subcategory` VALUES (1,'Informatica','portátiles que se adaptan a tus necesidades. Con procesadores de última generación, opciones gráficas avanzadas, tamaños variados de pantalla, altas capacidades de memoria interna, RAM y mayor durabilidad con sus baterías',5),(2,'Consolas',' encuentras múltiples opciones para agregar a tus partidas. Encuentra diferentes tipos de mouse alámbricos, que se adaptan a tus necesidades y a los tipos de juegos que lo necesitan, como botones de respuesta o de selección de velocidad.',5),(3,'Colchones','Tu casa es el lugar perfecto para que la comodidad, el descanso y la inspiración se hagan notar',7),(4,'Lúdicos','diferentes tipos de juguetes para la diversión de niños y niñas de todas las edades',6),(5,'Carros & Muñecos','diferentes tipos de juguetes para la diversión de niños y niñas de todas las edades',6);
/*!40000 ALTER TABLE `tbl_subcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_lastname` varchar(50) NOT NULL,
  `user_type_document` int(1) NOT NULL,
  `user_document_id` int(50) NOT NULL,
  `user_email` varchar(50) NOT NULL,
  `user_phone` bigint(20) NOT NULL,
  `user_date_register` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_pass` varchar(500) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (2,'admin','admin',1,1037659975,'tafursla@outlook.com',3232860831,'2021-04-11 16:56:05','admin');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-11 13:47:06
