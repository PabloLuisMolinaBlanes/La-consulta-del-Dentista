-- MariaDB dump 10.17  Distrib 10.4.6-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: consultadeldentista
-- ------------------------------------------------------
-- Server version       10.4.6-MariaDB

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
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consulta` (
  `idPaciente` int(11) NOT NULL,
  `idDentista` int(11) NOT NULL,
  `fechaConsulta` date NOT NULL,
  `idConsulta` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idConsulta`),
  KEY `fk_Paciente_has_Dentista_Dentista1_idx` (`idDentista`),
  KEY `fk_Paciente_has_Dentista_Paciente1_idx` (`idPaciente`),
  CONSTRAINT `fk_Paciente_has_Dentista_Dentista1` FOREIGN KEY (`idDentista`) REFERENCES `dentista` (`idDentista`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Paciente_has_Dentista_Paciente1` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
INSERT INTO `consulta` VALUES (1,3,'2019-06-06',2);
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cookie`
--

DROP TABLE IF EXISTS `cookie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cookie` (
  `cookie` varchar(200) NOT NULL,
  `username` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`cookie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cookie`
--

LOCK TABLES `cookie` WRITE;
/*!40000 ALTER TABLE `cookie` DISABLE KEYS */;
INSERT INTO `cookie` VALUES ('fc5010455d6a265cc733d7d941a9','sysadmin');
/*!40000 ALTER TABLE `cookie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dentista`
--

DROP TABLE IF EXISTS `dentista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dentista` (
  `nomDentista` varchar(45) NOT NULL,
  `fecNac` date NOT NULL,
  `idDentista` int(11) NOT NULL AUTO_INCREMENT,
  `fecLicenciado` date NOT NULL,
  `idUsuario` int(10) DEFAULT NULL,
  PRIMARY KEY (`idDentista`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dentista`
--

LOCK TABLES `dentista` WRITE;
/*!40000 ALTER TABLE `dentista` DISABLE KEYS */;
INSERT INTO `dentista` VALUES ('Roberto','1980-03-03',1,'2009-01-01',1),('David','2001-01-01',2,'2024-02-02',NULL),('Peter','1989-02-02',3,'2011-02-02',NULL),('Thomas','1991-05-05',4,'2018-02-02',NULL),('Tartara','2001-01-01',5,'2025-05-05',NULL),('Rocambolesco','2004-02-02',6,'2009-02-02',NULL);
/*!40000 ALTER TABLE `dentista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicacion`
--

DROP TABLE IF EXISTS `medicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicacion` (
  `idMedicacion` int(11) NOT NULL AUTO_INCREMENT,
  `nomMedicacion` varchar(45) NOT NULL,
  PRIMARY KEY (`idMedicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicacion`
--

LOCK TABLES `medicacion` WRITE;
/*!40000 ALTER TABLE `medicacion` DISABLE KEYS */;
INSERT INTO `medicacion` VALUES (1,'Paidoterin');
/*!40000 ALTER TABLE `medicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `idPaciente` int(11) NOT NULL AUTO_INCREMENT,
  `nomPaciente` varchar(45) NOT NULL,
  `fecNac` date NOT NULL,
  `apelPaciente` varchar(45) NOT NULL,
  `DNI` char(9) NOT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (1,'Pepe','2019-01-01','Morilla','22446688P');
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescripcion`
--

DROP TABLE IF EXISTS `prescripcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescripcion` (
  `idPaciente` int(11) NOT NULL,
  `idMedicacion` int(11) NOT NULL,
  `inicioDosis` date NOT NULL,
  `finDosis` date NOT NULL,
  `miligramosPrescritos` int(11) NOT NULL,
  `idDentista` int(11) NOT NULL,
  PRIMARY KEY (`idPaciente`,`idMedicacion`),
  KEY `fk_Paciente_has_Medicacion_Medicacion1_idx` (`idMedicacion`),
  KEY `fk_Paciente_has_Medicacion_Paciente_idx` (`idPaciente`),
  KEY `fk_Prescripcion_Dentista1_idx` (`idDentista`),
  CONSTRAINT `fk_Paciente_has_Medicacion_Medicacion1` FOREIGN KEY (`idMedicacion`) REFERENCES `medicacion` (`idMedicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Paciente_has_Medicacion_Paciente` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescripcion_Dentista1` FOREIGN KEY (`idDentista`) REFERENCES `dentista` (`idDentista`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescripcion`
--

LOCK TABLES `prescripcion` WRITE;
/*!40000 ALTER TABLE `prescripcion` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescripcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `username` varchar(16) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `dateOfCreation` timestamp NULL DEFAULT current_timestamp(),
  `userID` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userID` (`userID`),
  KEY `pk_Dentista_Usuario1_idx` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('sysadmin','webmaster@webmaster.com','Mrhacker,thisisasmallproject.','2020-03-03 14:36:00',0000000001),('Robert','roberto@gmail.com','robert','2020-03-03 14:37:24',0000000002),('George','george@barrigaalegre.com','georgio','2020-03-05 19:21:53',0000000003),('Peter','petey@gmail.com','peter','2020-03-06 09:34:36',0000000004),('Robertito','roberty@bmail.com','robertito','2020-03-06 09:35:04',0000000005),('test','test@gmail.com','test','2020-03-06 12:21:47',0000000013);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-07 18:10:22