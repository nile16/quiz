-- MySQL dump 10.13  Distrib 5.5.52, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: quiz
-- ------------------------------------------------------
-- Server version	5.5.52-0+deb8u1

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `answer_id` int(4) DEFAULT NULL,
  `answer_text` text COLLATE utf8mb4_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (100,'Intrig'),(101,'Brott'),(102,'Dödsfall'),(104,'Driva handligen'),(105,'Driva huvudpersonen i fördärv'),(106,'Driva antagonisten i fördärv'),(108,'Ständigt stigande'),(109,'Ständigt fallande'),(110,'Den är konstant'),(112,'Med värdighet'),(113,'Plågsamt'),(114,'Genom mord'),(1,'Angular'),(2,'Flask'),(3,'Python'),(4,'XMLHttpRequest'),(5,'Raspberry Pi'),(6,'UNIX'),(7,'Windows'),(8,'Ramverk'),(9,'Javascript'),(10,'C++'),(11,'Express'),(12,'TCP/IP'),(13,'HTML'),(14,'CSS'),(15,'MySQL'),(16,'SQL'),(17,'MongoDB'),(18,'PHP'),(19,'Java'),(20,'PostgreSQL'),(21,'sort()'),(22,'splice()'),(23,'split()'),(24,'document.getElement(\'p\').innerHTML = \'Hello World!\';'),(25,'document.getElementById(\'demo\').innerHTML = \'Hello World!\';'),(26,'document.getElementByName(\'p\').innerHTML = \'Hello World!\';'),(27,'demo.innerHTML = \'Hello World!\';'),(28,'for (i = 0; i <= 5; i++)'),(29,'for (i = 0; i <= 5)'),(30,'for i = 1 to 5'),(31,'for (i <= 5; i++)'),(32,'int(x)'),(33,'string(x)'),(34,'float(x)'),(35,'str(x)'),(36,'Object Oriented Principles'),(37,'Object Oriented Programming'),(38,'Out of Process'),(39,'Out of Program'),(40,'choice(random)'),(41,'randrange ([start,] stop [,step])'),(42,'random()'),(43,'seed([x])'),(44,'Ja'),(45,'Nej'),(46,'Går ej att svara på'),(47,'Strong Question Language'),(48,'Structured Query Language'),(49,'Structured Question Language'),(50,'GET'),(51,'EXTRACT'),(52,'OPEN'),(53,'SELECT'),(54,'ADD NEW'),(55,'INSERT NEW'),(56,'INSERT INTO'),(57,'ADD RECORD'),(58,'Antagonisten'),(59,'Protagonisten'),(60,'Räddaren'),(61,'Handlingen'),(62,'Karaktären'),(63,'Räddare, förföljare, offer'),(64,'Huvudperson, Hjälte, Bi-roll'),(65,'Ond, god, likgiltig'),(66,'Verkan på grund av orsak'),(67,'Orsak till följd av verkan'),(68,'Rörelse bakåt'),(69,'Rörelse framåt'),(70,'Desorientera publiken'),(71,'För lång historia'),(72,'Sidospår'),(73,'Åhörarens fantasi'),(74,'Salongen'),(75,'En extra scen'),(76,'Stol');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `question_id` int(4) DEFAULT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'Vilket språk är detta?<br><i>SELECT * FROM users LIMIT 8;</i>'),(2,'Vilket språk är detta?<br><i>cout << \'Hello\' << endl;</i>'),(3,'Vilket språk är detta?<br><i>document.getElementById(\'input\').value</i>'),(4,'Vilket språk är detta?<br><i>FOR x IN listofx:<br>&nbsp;&nbsp;&nbsp;&nbsp;PRINT x</i>'),(5,'Vilket språk är detta?<br><i>echo \'Hello\';</i>'),(6,'Vad är Flask?'),(7,'Vad är Angular?'),(8,'Vad används för AJAX?'),(9,'Vilka är relationsdatabaser?'),(10,'vilken funktion av följande lägger till eller tar bort element i en Array?'),(11,'vilket är rätt syntax för att ändra innehållet på följande HTML tagg<br>\n< p id=\'demo\'>This is a demonstration.< /p >'),(12,'Hur startas en For Loop?'),(13,'Vilken av följande funktioner konverterar ett objekt till en string i Python?'),(14,'Vilket programmeringsspråk är väldigt likt Python?'),(15,'Vad betyder OOP?'),(16,'Vilken funktion returnerar ett slumpmässigt objekt från en tuple, list eller string?'),(17,'Kan en använda flera joins i ett SQL kommando?'),(18,'Vad betyder SQL?'),(19,'Vilket kommando använder man för att hämta data från databasen?'),(20,'Vilket kommando använder en för att lägga till ny data i databasen?'),(21,'Vilken person får huvudpersonen att börja handla i ett drama?'),(22,'Vad kommer först i ett dramatiskt berättande?'),(23,'Hur är den dramatiska triangeln uppbyggd?'),(24,'Vad innebär omvänd tid?'),(25,'Kan tiden vara irreversibel i ett dramatiskt berättande?'),(26,'Varför ska man undvika för beskrivande miljöer i sitt berättande?'),(27,'Vilken är den andra scenen en menar när en talar om den dubbla scenen?'),(100,'Vilket är nödvändigt och ofrånkomligt i allt dramatiskt berättande?'),(101,'Vad är intrigens uppgift?'),(102,'Vad kan sägas om spänningen i ett perfekt uppbyggt drama?'),(103,'Om huvudpersonen dör, på vilket sätt måste det ske enligt Wells Roots dramamodell?');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz` (
  `quiz_id` int(4) DEFAULT NULL,
  `name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `questions` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (1,'MiniWebbQuiz','[1,3,4,6,9]'),(2,'DramatisktQuiz','[100,101,102,103]'),(3,'MegaWebbQuiz','[1,2,3,4,5,6,7,8,9]'),(4,'JavascriptQuiz','[3,7,8,10,11,12]'),(5,'PythonQuiz','[4,6,13,14,15,16]'),(6,'SQLQuiz','[1,9,17,18,19,20]'),(7,'MegaDramatisktQuiz','[100,101,102,103,21,22,23,24,25,26,27]');
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `right`
--

DROP TABLE IF EXISTS `right`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `right` (
  `question_id` int(4) DEFAULT NULL,
  `answer_id` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `right`
--

LOCK TABLES `right` WRITE;
/*!40000 ALTER TABLE `right` DISABLE KEYS */;
INSERT INTO `right` VALUES (1,16),(2,10),(3,9),(4,3),(5,18),(6,8),(7,8),(8,4),(8,9),(9,15),(9,20),(10,22),(11,25),(12,28),(13,35),(14,18),(15,37),(16,42),(17,44),(18,47),(19,53),(20,56),(21,58),(22,61),(23,63),(24,66),(24,68),(25,44),(26,70),(27,73),(100,100),(101,104),(102,108),(103,112);
/*!40000 ALTER TABLE `right` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stats` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kent','5701c6993265d3630e540840dbdfced62423d1b5','[73]'),(2,'Knut','5701c6993265d3630e540840dbdfced62423d1b5','[]');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wrong`
--

DROP TABLE IF EXISTS `wrong`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wrong` (
  `question_id` int(4) DEFAULT NULL,
  `answer_id` int(4) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wrong`
--

LOCK TABLES `wrong` WRITE;
/*!40000 ALTER TABLE `wrong` DISABLE KEYS */;
INSERT INTO `wrong` VALUES (1,3),(1,9),(1,10),(2,9),(2,3),(2,18),(3,10),(3,16),(3,18),(4,9),(4,11),(4,16),(5,3),(5,9),(5,10),(5,16),(6,9),(6,12),(6,16),(7,13),(7,14),(8,15),(8,16),(8,17),(9,17),(10,21),(10,23),(11,24),(11,26),(11,27),(12,29),(12,30),(12,31),(13,32),(13,33),(13,34),(14,9),(14,10),(14,19),(14,16),(15,36),(15,38),(15,39),(16,40),(16,41),(16,43),(17,45),(17,46),(18,48),(18,49),(19,50),(19,51),(19,52),(20,54),(20,55),(20,57),(21,59),(21,60),(21,62),(22,62),(22,46),(22,59),(23,64),(23,65),(23,46),(24,67),(24,69),(25,45),(25,46),(26,71),(26,72),(26,46),(27,74),(27,75),(27,46),(100,101),(100,102),(101,105),(101,106),(101,46),(102,109),(102,110),(102,46),(103,113),(103,114),(103,46);
/*!40000 ALTER TABLE `wrong` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-22 22:22:16
