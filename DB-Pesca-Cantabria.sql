-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: pesca
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `peces`
--

DROP TABLE IF EXISTS `peces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peces` (
  `idpeces` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombrecientifico` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `talla` int NOT NULL DEFAULT '0',
  `fini` date NOT NULL,
  `ffin` date DEFAULT NULL,
  `notas` varchar(500) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `imageurl` varchar(200) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idpeces`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `idpeces_UNIQUE` (`idpeces`),
  UNIQUE KEY `nombre_cientifico_UNIQUE` (`nombrecientifico`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peces`
--

LOCK TABLES `peces` WRITE;
/*!40000 ALTER TABLE `peces` DISABLE KEYS */;
INSERT INTO `peces` VALUES (1,'Trucha arco-iris','Oncorhynchus mykiss',0,'2025-04-01','2025-07-31',NULL,'Trucha-arcoiris.png'),(5,'Salmón atlántico','Salmo salar',45,'2025-04-30',NULL,'cupo maximo por persona de 1 en zona libre y 1 en coto','Salmon-atlantico.png'),(6,'Trucha común','Salmo trutta',21,'2025-04-01','2025-07-31',NULL,'Trucha-comun.png'),(7,'Barbo','Barbus spp.',0,'2025-04-01','2025-07-31',NULL,'Barbo.png'),(8,'Carpa','Cyprinus carpio',0,'2025-04-01','2025-07-31',NULL,'Carpa.png'),(9,'Gobio','Gobio lozanoi',0,'2025-04-01','2025-07-31',NULL,'Gobio.png'),(10,'Cacho o Bordallo','Leuciscus carolitertii',0,'2025-04-01','2025-07-31',NULL,'Cacho.png'),(11,'Piscardo','Phoxinus phoxinus',0,'2025-04-01','2025-07-31',NULL,'Piscardo.png'),(12,'Black-bass','Micropterus salmoides',0,'2025-04-01','2025-07-31',NULL,'Black-bass.png'),(13,'Lubina','Dicentrarchus labrax',36,'2025-04-01','2025-07-31',NULL,'Lubina.png'),(14,'Platija o Solla','Platichtys fl esus',25,'2025-04-01','2025-07-31',NULL,'Platija.png'),(15,'Múgil','Mugil spp.',20,'2025-04-01','2025-07-31',NULL,'Mugil.png'),(17,'Corcón','Chelon spp.',0,'2025-04-01','2025-07-31',NULL,'Corcon.png'),(18,'Cangrejo señal','Pacifastacus leniusculus',0,'2025-06-01','2025-10-13','debe ser sacrificado antes de transportarlo','Cangrejo.png');
/*!40000 ALTER TABLE `peces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peces_zona`
--

DROP TABLE IF EXISTS `peces_zona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peces_zona` (
  `idpeces_zona` int NOT NULL AUTO_INCREMENT,
  `zona_pez` int NOT NULL,
  `pez_zona` int NOT NULL,
  PRIMARY KEY (`idpeces_zona`),
  UNIQUE KEY `idpeces_zona_UNIQUE` (`idpeces_zona`),
  KEY `zona_fk_idx` (`zona_pez`),
  KEY `pesca_fk_idx` (`pez_zona`),
  CONSTRAINT `pesca_fk` FOREIGN KEY (`pez_zona`) REFERENCES `peces` (`idpeces`),
  CONSTRAINT `zona_fk` FOREIGN KEY (`zona_pez`) REFERENCES `zona` (`idzona`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peces_zona`
--

LOCK TABLES `peces_zona` WRITE;
/*!40000 ALTER TABLE `peces_zona` DISABLE KEYS */;
INSERT INTO `peces_zona` VALUES (1,1,9),(2,1,10),(4,1,12),(5,1,13),(6,1,14),(7,1,15),(9,1,17),(10,1,18),(11,2,9),(12,2,10),(14,2,13),(15,2,14),(16,2,15),(18,2,17),(19,2,18),(20,3,9),(21,3,10),(23,3,13),(24,3,14),(25,3,15),(27,3,17),(28,3,18),(29,4,9),(30,4,10),(32,4,13),(33,4,14),(34,4,15),(36,4,17),(37,4,18),(38,5,9),(39,5,10),(41,5,13),(42,5,14),(43,5,15),(45,5,17),(46,5,18),(47,6,1),(48,7,1),(49,8,1),(50,9,1),(51,10,1),(52,11,1),(53,12,1),(54,13,1),(55,14,1),(56,15,1),(57,16,1),(58,17,1),(59,18,1),(60,19,1),(61,20,1),(62,21,1),(63,22,1),(64,23,1),(65,24,1),(66,25,1),(67,26,1),(68,27,1),(69,28,1),(70,29,1),(71,30,1),(72,31,1),(73,42,1),(74,43,1),(75,44,1),(77,46,1),(80,49,1),(83,42,5),(84,43,5),(85,44,5),(87,46,5),(90,49,5),(92,24,6),(93,25,6),(94,26,6),(95,27,6),(96,28,6),(97,29,6),(98,30,6),(99,31,6),(100,42,6),(101,43,6),(102,44,6),(104,46,6),(107,49,6),(108,24,7),(109,25,7),(110,26,7),(111,27,7),(112,28,7),(113,29,7),(114,30,7),(115,31,7),(116,24,8),(117,25,8),(118,26,8),(119,27,8),(120,28,8),(121,29,8),(122,30,8),(123,31,8),(124,24,9),(125,25,9),(126,26,9),(127,27,9),(128,28,9),(129,29,9),(130,30,9),(131,31,9),(132,24,10),(133,25,10),(134,26,10),(135,27,10),(136,28,10),(137,29,10),(138,30,10),(139,31,10),(140,24,11),(141,25,11),(142,26,11),(143,27,11),(144,28,11),(145,29,11),(146,30,11),(147,31,11),(148,6,12),(149,7,12),(150,8,12),(151,9,12),(152,10,12),(153,11,12),(154,12,12),(155,13,12),(156,14,12),(157,15,12),(158,16,12),(159,17,12),(160,18,12),(161,19,12),(162,20,12),(163,21,12),(164,22,12),(165,23,12),(166,6,13),(167,7,13),(168,8,13),(169,9,13),(170,10,13),(171,11,13),(172,12,13),(173,13,13),(174,14,13),(175,15,13),(176,16,13),(177,17,13),(178,18,13),(179,19,13),(180,20,13),(181,21,13),(182,22,13),(183,23,13),(184,6,14),(185,7,14),(186,8,14),(187,9,14),(188,10,14),(189,11,14),(190,12,14),(191,13,14),(192,14,14),(193,15,14),(194,16,14),(195,17,14),(196,18,14),(197,19,14),(198,20,14),(199,21,14),(200,22,14),(201,23,14),(202,6,15),(203,7,15),(204,8,15),(205,9,15),(206,10,15),(207,11,15),(208,12,15),(209,13,15),(210,14,15),(211,15,15),(212,16,15),(213,17,15),(214,18,15),(215,19,15),(216,20,15),(217,21,15),(218,22,15),(219,23,15),(238,6,17),(239,7,17),(240,8,17),(241,9,17),(242,10,17),(243,11,17),(244,12,17),(245,13,17),(246,14,17),(247,15,17),(248,16,17),(249,17,17),(250,18,17),(251,19,17),(252,20,17),(253,21,17),(254,22,17),(255,23,17),(256,6,18),(257,7,18),(258,8,18),(259,9,18),(260,10,18),(261,11,18),(262,12,18),(263,13,18),(264,14,18),(265,15,18),(266,16,18),(267,17,18),(268,18,18),(269,19,18),(270,20,18),(271,21,18),(272,22,18),(273,23,18);
/*!40000 ALTER TABLE `peces_zona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zona`
--

DROP TABLE IF EXISTS `zona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zona` (
  `idzona` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('rio','embalse','playa','puerto') COLLATE utf8mb4_spanish_ci NOT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_spanish_ci NOT NULL,
  `imageurl` varchar(200) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  PRIMARY KEY (`idzona`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  UNIQUE KEY `id_UNIQUE` (`idzona`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zona`
--

LOCK TABLES `zona` WRITE;
/*!40000 ALTER TABLE `zona` DISABLE KEYS */;
INSERT INTO `zona` VALUES (1,'puerto','Puerto de Santander','Santander.png',43.43230807509232,-3.8096501686511197),(2,'puerto','Puerto de Santoña','Santona.png',43.44084107160685,-3.4620605807151423),(3,'puerto','Puerto de Laredo','Laredo.png',43.41495331514655,-3.418774585788962),(4,'puerto','Puerto de Castro Urdiales','Castro.png',43.383413996661375,-3.2169755658756034),(5,'puerto','Puerto de Colindres','Colindres.png',43.39431087508951,-3.4618516942121613),(6,'playa','Playa de Oyambre','Oyambre.png',43.39738862957304,-4.338508765944673),(7,'playa','Playa de El Sardinero','Sardinero.png',43.47554034194371,-3.783983485597154),(8,'playa','Playa de Los Locos','Locos.png',43.43852894513434,-4.047573625175448),(9,'playa','Playa de Merón','Meron.png',43.3907954052815,-4.378427381712621),(10,'playa','Playa de Somo','Somo.png',43.45843690285161,-3.7350325738772017),(11,'playa','Playa de Loredo','Loredo.png',43.46497167446358,-3.7260505040241636),(12,'playa','Playa de Langre','Langre.png',43.475351908244825,-3.6916578611110102),(13,'playa','Playa de La Salvé','Salve.png',43.42203615367627,-3.4406292175115754),(14,'playa','Playa de Mataleñas','Matalenas.png',43.486280828655644,-3.787471256286404),(15,'playa','Playa del Puntal','Puntal.png',43.38660340475008,-4.387126061239975),(16,'playa','Playa de Liencres','Liencres.png',43.452319169509785,-3.9627234731198273),(17,'playa','Playa de Valdearenas','Valdearenas.png',43.44243617304307,-3.9779490021020063),(18,'playa','Playa de Trengandín','Trengadin.png',43.4792669653509,-3.5135759026382285),(19,'playa','Playa de Cuberris','Cuberris.png',43.49920626404103,-3.615888228431498),(20,'playa','Playa de Berria','Berria.png',43.464732564615026,-3.4643169890158143),(21,'playa','Playa de La Arnía','Arnia.png',43.47442864656129,-3.9160048233268463),(22,'playa','Playa de Covachos','Covachos.png',43.47276556532183,-3.911628176698876),(23,'playa','Playa de Usgo','Usgo.png',43.43954649838692,-4.001088621263237),(24,'rio','Río Asón','Ason.png',43.283632299409575,-3.52507377571114),(25,'rio','Río Besaya','Besaya.png',43.28161385249127,-4.063727048040662),(26,'rio','Río Deva','Deva.png',43.29560702595463,-4.607383445304709),(27,'rio','Río Miera','Miera.png',43.30633098796292,-3.7073716012729117),(28,'rio','Río Nansa','Nansa.png',43.109720891318474,-4.435907255432372),(29,'rio','Río Pas','Pas.png',43.16150032847205,-3.7789030349092414),(30,'rio','Río Saja','Saja.png',43.12385574291446,-4.29561837500141),(31,'rio','Río Yera','Yera.png',43.136276309054345,-3.758795443854684),(42,'embalse','Embalse del Ebro','Ebro.png',42.99885693701013,-3.945708339991381),(43,'embalse','Embalse de Alsa','Alsa.png',43.08487038088548,-4.004339554650093),(44,'embalse','Embalse de La Cohílla','Cohila.png',43.1330456844062,-4.390810893958827),(46,'embalse','Embalse de Palombera','Palombera.png',43.289427684312926,-4.4532993056834895),(49,'embalse','Embalse de Tarriba','Tarriba.png',43.36491947035665,-3.7856824799101667);
/*!40000 ALTER TABLE `zona` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-24 15:38:45
