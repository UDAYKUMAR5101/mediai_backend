-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: medi
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add profile',7,'add_profile'),(26,'Can change profile',7,'change_profile'),(27,'Can delete profile',7,'delete_profile'),(28,'Can view profile',7,'view_profile'),(29,'Can add symptoms',8,'add_symptoms'),(30,'Can change symptoms',8,'change_symptoms'),(31,'Can delete symptoms',8,'delete_symptoms'),(32,'Can view symptoms',8,'view_symptoms'),(33,'Can add medical image',9,'add_medicalimage'),(34,'Can change medical image',9,'change_medicalimage'),(35,'Can delete medical image',9,'delete_medicalimage'),(36,'Can view medical image',9,'view_medicalimage'),(37,'Can add password reset otp',10,'add_passwordresetotp'),(38,'Can change password reset otp',10,'change_passwordresetotp'),(39,'Can delete password reset otp',10,'delete_passwordresetotp'),(40,'Can view password reset otp',10,'view_passwordresetotp'),(41,'Can add risk result',11,'add_riskresult'),(42,'Can change risk result',11,'change_riskresult'),(43,'Can delete risk result',11,'delete_riskresult'),(44,'Can view risk result',11,'view_riskresult'),(45,'Can add diagnosis record',12,'add_diagnosisrecord'),(46,'Can change diagnosis record',12,'change_diagnosisrecord'),(47,'Can delete diagnosis record',12,'delete_diagnosisrecord'),(48,'Can view diagnosis record',12,'view_diagnosisrecord'),(49,'Can add prediction result',13,'add_predictionresult'),(50,'Can change prediction result',13,'change_predictionresult'),(51,'Can delete prediction result',13,'delete_predictionresult'),(52,'Can view prediction result',13,'view_predictionresult'),(53,'Can add risk assessment',14,'add_riskassessment'),(54,'Can change risk assessment',14,'change_riskassessment'),(55,'Can delete risk assessment',14,'delete_riskassessment'),(56,'Can view risk assessment',14,'view_riskassessment'),(57,'Can add image risk assessment',15,'add_imageriskassessment'),(58,'Can change image risk assessment',15,'change_imageriskassessment'),(59,'Can delete image risk assessment',15,'delete_imageriskassessment'),(60,'Can view image risk assessment',15,'view_imageriskassessment'),(61,'Can add symptoms risk assessment',16,'add_symptomsriskassessment'),(62,'Can change symptoms risk assessment',16,'change_symptomsriskassessment'),(63,'Can delete symptoms risk assessment',16,'delete_symptomsriskassessment'),(64,'Can view symptoms risk assessment',16,'view_symptomsriskassessment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$xSWNgIaOxXGMnaDwHg4leG$APWms2lj1ja2aI21K3PyevWSHHMPKf2gqXYd9pfpPCE=',NULL,1,'naveen','','','naveen@gmail.com',1,1,'2025-07-16 09:22:36.589926'),(2,'pbkdf2_sha256$1000000$i0dRoQPQTQgjWS7iHHsFa8$kM01wKzp08pYR/sZZvjPzxgFt/eMjtv3uylQSZHjjLo=',NULL,0,'uday','','','udaykumar9@gmail.com',0,1,'2025-07-16 09:27:43.661206'),(4,'pbkdf2_sha256$1000000$akTf7XbotRZw3KQCj6hLxF$7tnSlr/M0WbdyBU6bRvrldnbc+UZQTDkL5jXkHeUM2I=',NULL,1,'haneef','','','haneef@gmail.com',1,1,'2025-07-23 04:14:21.392129'),(5,'pbkdf2_sha256$1000000$Y7ZR3mx2gAdqEZ5erT7Riz$xU07MhpzXBz0VLmXz3k6bTpMpKWvkB7RYVOYfxnAN1U=',NULL,0,'sree','','','sree@gmail.com',0,1,'2025-07-26 05:45:19.052968'),(6,'pbkdf2_sha256$1000000$kL46VdhMxvKjTM1D9Zc61R$vDzOCi0llPj5iac/fxTfZaBpkmWZC4qMpLsu4LlftUY=',NULL,0,'sreevani','','','sreevani@gmail.com',0,1,'2025-07-26 06:03:36.684657'),(7,'pbkdf2_sha256$1000000$a6Crestv3dCwOfknjb7bQg$phlEmyg1574w0I+38lSEGz3ampodUl87aUwGBfLYgp8=',NULL,0,'udaykumar','','','sunkaraudaykumar9@gmail.com',0,1,'2025-07-28 03:37:16.221259'),(8,'pbkdf2_sha256$1000000$cv006u08zLR3L72C2DcDQj$WUQ9hYvFrrEWpA6ByXreCypPBRBmr7I+riLDtfO8bOE=',NULL,0,'chintu','','','bandipottigarinaveen@gmail.com',0,1,'2025-07-28 07:57:19.601870'),(9,'pbkdf2_sha256$1000000$W4eTbS7kuOkOiW3zbl8eX4$q5yayco2GgERr7jwNSt+fTlkl9w1qh5fxZjONE84iOA=',NULL,0,'vinay','','','vinay@gmail.com',0,1,'2025-07-30 05:00:56.630511'),(11,'pbkdf2_sha256$1000000$nh1StTN9rI2gJKU2QK63tM$MwhxiuKHCl94kVUbmW6B07xkBOUSusScA0yzfTPZK+g=',NULL,0,'itachi','','','bandipottigari@gmail.com',0,1,'2025-07-30 05:06:48.889966');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(12,'medi','diagnosisrecord'),(15,'medi','imageriskassessment'),(9,'medi','medicalimage'),(10,'medi','passwordresetotp'),(13,'medi','predictionresult'),(7,'medi','profile'),(14,'medi','riskassessment'),(11,'medi','riskresult'),(8,'medi','symptoms'),(16,'medi','symptomsriskassessment'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-07-16 09:21:14.784131'),(2,'auth','0001_initial','2025-07-16 09:21:15.785179'),(3,'admin','0001_initial','2025-07-16 09:21:16.026986'),(4,'admin','0002_logentry_remove_auto_add','2025-07-16 09:21:16.041348'),(5,'admin','0003_logentry_add_action_flag_choices','2025-07-16 09:21:16.063219'),(6,'contenttypes','0002_remove_content_type_name','2025-07-16 09:21:16.258828'),(7,'auth','0002_alter_permission_name_max_length','2025-07-16 09:21:16.393394'),(8,'auth','0003_alter_user_email_max_length','2025-07-16 09:21:16.452841'),(9,'auth','0004_alter_user_username_opts','2025-07-16 09:21:16.469303'),(10,'auth','0005_alter_user_last_login_null','2025-07-16 09:21:16.597498'),(11,'auth','0006_require_contenttypes_0002','2025-07-16 09:21:16.601748'),(12,'auth','0007_alter_validators_add_error_messages','2025-07-16 09:21:16.617035'),(13,'auth','0008_alter_user_username_max_length','2025-07-16 09:21:16.758562'),(14,'auth','0009_alter_user_last_name_max_length','2025-07-16 09:21:16.891984'),(15,'auth','0010_alter_group_name_max_length','2025-07-16 09:21:16.941521'),(16,'auth','0011_update_proxy_permissions','2025-07-16 09:21:16.962235'),(17,'auth','0012_alter_user_first_name_max_length','2025-07-16 09:21:17.084105'),(18,'sessions','0001_initial','2025-07-16 09:21:17.151317'),(19,'medi','0001_initial','2025-07-18 04:36:56.206114'),(20,'medi','0002_symptoms','2025-07-23 04:13:05.316592'),(21,'medi','0003_medicalimage','2025-07-23 05:49:50.690957'),(22,'medi','0004_passwordresetotp','2025-07-26 06:31:40.261306'),(23,'medi','0005_riskresult_diagnosisrecord','2025-07-28 05:13:07.498232'),(24,'medi','0006_predictionresult_remove_diagnosisrecord_user_and_more','2025-07-30 04:08:42.217070'),(25,'medi','0007_riskassessment','2025-08-01 13:15:57.057843'),(26,'medi','0008_rename_level_percent_riskassessment_percentage_and_more','2025-08-01 13:26:23.556328'),(27,'medi','0009_rename_percentage_riskassessment_prediction_percentage_and_more','2025-08-01 13:40:49.097548'),(28,'medi','0010_symptoms_breast_cancer','2025-08-02 03:15:01.180776'),(29,'medi','0011_riskassessment_image_alter_riskassessment_risk_level','2025-08-02 03:33:56.847472'),(30,'medi','0012_remove_riskassessment_image_and_more','2025-08-02 03:45:25.082193');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('bq1d0stj5a5v97yntlfnnn9bhp6jzuaz','eyJyZXNldF9lbWFpbCI6InN1bmthcmF1ZGF5a3VtYXI5QGdtYWlsLmNvbSJ9:1ugjsu:MwIMnnyP4-F75v87bTMDJAhbWVA3OQOStYvqnGk_A4o','2025-08-12 12:56:48.387811'),('f8eqcz8cmulo6u8prn1tzhotwjj6jfv5','eyJyZXNldF9lbWFpbCI6InN1bmthcmF1ZGF5a3VtYXI5QGdtYWlsLmNvbSJ9:1ugyts:_tMProHXbReFoPQYk6GMJYIR_U_f__kMtugBxm3eGtg','2025-08-13 04:58:48.329723');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_imageriskassessment`
--

DROP TABLE IF EXISTS `medi_imageriskassessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_imageriskassessment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `risk_level` varchar(20) NOT NULL,
  `prediction_percentage` double NOT NULL,
  `image` varchar(100) NOT NULL,
  `mode` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_imageriskassessment_user_id_89582565_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_imageriskassessment_user_id_89582565_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_imageriskassessment`
--

LOCK TABLES `medi_imageriskassessment` WRITE;
/*!40000 ALTER TABLE `medi_imageriskassessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `medi_imageriskassessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_medicalimage`
--

DROP TABLE IF EXISTS `medi_medicalimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_medicalimage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_medicalimage_user_id_8190aeed_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_medicalimage_user_id_8190aeed_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_medicalimage`
--

LOCK TABLES `medi_medicalimage` WRITE;
/*!40000 ALTER TABLE `medi_medicalimage` DISABLE KEYS */;
INSERT INTO `medi_medicalimage` VALUES (6,'medical_images/image_on_mammography_P7BDgHS.jpg','2025-07-25 05:56:42.703789',4),(7,'medical_images/image_on_mammography_zY0aCs6.jpg','2025-07-29 11:59:19.647025',7);
/*!40000 ALTER TABLE `medi_medicalimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_passwordresetotp`
--

DROP TABLE IF EXISTS `medi_passwordresetotp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_passwordresetotp` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_passwordresetotp`
--

LOCK TABLES `medi_passwordresetotp` WRITE;
/*!40000 ALTER TABLE `medi_passwordresetotp` DISABLE KEYS */;
INSERT INTO `medi_passwordresetotp` VALUES (8,'haneef@gmail.com','830403','2025-07-28 03:07:09.602315');
/*!40000 ALTER TABLE `medi_passwordresetotp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_predictionresult`
--

DROP TABLE IF EXISTS `medi_predictionresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_predictionresult` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `risk_level` varchar(20) NOT NULL,
  `prediction_percentage` double NOT NULL,
  `mode` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_predictionresult_user_id_b56b7573_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_predictionresult_user_id_b56b7573_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_predictionresult`
--

LOCK TABLES `medi_predictionresult` WRITE;
/*!40000 ALTER TABLE `medi_predictionresult` DISABLE KEYS */;
INSERT INTO `medi_predictionresult` VALUES (1,'High',90,'symptoms','2025-07-30 04:09:25.434653',7),(2,'High',90,'symptoms','2025-08-01 13:34:48.271041',7),(3,'High',90,'symptoms','2025-08-02 03:18:22.688750',1);
/*!40000 ALTER TABLE `medi_predictionresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_profile`
--

DROP TABLE IF EXISTS `medi_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_profile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `age` int unsigned DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `notes` longtext,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `medi_profile_user_id_b0348124_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `medi_profile_chk_1` CHECK ((`age` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_profile`
--

LOCK TABLES `medi_profile` WRITE;
/*!40000 ALTER TABLE `medi_profile` DISABLE KEYS */;
INSERT INTO `medi_profile` VALUES (1,37,'profile_images/20250603_OHR_pJM4zdZ.CalaLuna_EN-IN7826704026_UHD_bing.jpg','F','1998-05-20','Hello, this is my profile.',1),(3,37,'','F','1998-05-20','Hello, this is my profile.',4),(4,40,'profile_images/20250603_OHR_2DqsZov.CalaLuna_EN-IN7826704026_UHD_bing.jpg','F','1998-05-20','Hello, this is my profile.',7);
/*!40000 ALTER TABLE `medi_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_riskassessment`
--

DROP TABLE IF EXISTS `medi_riskassessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_riskassessment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `risk_level` varchar(20) NOT NULL,
  `prediction_percentage` double NOT NULL,
  `mode` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_riskassessment_user_id_89378839_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_riskassessment_user_id_89378839_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_riskassessment`
--

LOCK TABLES `medi_riskassessment` WRITE;
/*!40000 ALTER TABLE `medi_riskassessment` DISABLE KEYS */;
INSERT INTO `medi_riskassessment` VALUES (1,'Unknown',0,'image','2025-08-01 13:41:02.954347',1),(2,'Low',20,'image','2025-08-02 03:04:47.509118',1),(3,'Unknown',0,'image','2025-08-02 03:19:48.066184',1),(4,'Low',20,'image','2025-08-02 03:20:28.909980',1);
/*!40000 ALTER TABLE `medi_riskassessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_symptoms`
--

DROP TABLE IF EXISTS `medi_symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_symptoms` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `age` int unsigned DEFAULT NULL,
  `menopausal_status` varchar(10) DEFAULT NULL,
  `family_history` varchar(3) DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `menarche_age` int unsigned DEFAULT NULL,
  `breastfeeding_history` varchar(3) DEFAULT NULL,
  `alcohol_consumption` varchar(3) DEFAULT NULL,
  `hormonal_treatment_history` varchar(3) DEFAULT NULL,
  `physical_activity` varchar(10) DEFAULT NULL,
  `breast_pain` varchar(3) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `breast_cancer` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_symptoms_user_id_54774daf_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_symptoms_user_id_54774daf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `medi_symptoms_chk_1` CHECK ((`age` >= 0)),
  CONSTRAINT `medi_symptoms_chk_2` CHECK ((`menarche_age` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_symptoms`
--

LOCK TABLES `medi_symptoms` WRITE;
/*!40000 ALTER TABLE `medi_symptoms` DISABLE KEYS */;
INSERT INTO `medi_symptoms` VALUES (2,42,'Post','Yes',26.4,13,'No','No','Yes','Moderate','Yes','2025-07-24 03:35:50.508862',4,NULL),(3,42,'Post','Yes',26.4,13,'No','No','Yes','Moderate','Yes','2025-07-26 06:16:14.415054',4,NULL),(4,42,'Post','Yes',26.4,13,'No','No','Yes','Moderate','Yes','2025-07-29 04:04:55.292413',7,NULL),(5,42,'Post','Yes',26.4,13,'No','No','Yes','Moderate','Yes','2025-07-29 04:05:40.719940',7,NULL),(6,42,'Post','Yes',26.4,13,'No','No','Yes','Moderate','Yes','2025-08-02 03:15:36.503240',1,'Yes');
/*!40000 ALTER TABLE `medi_symptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medi_symptomsriskassessment`
--

DROP TABLE IF EXISTS `medi_symptomsriskassessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medi_symptomsriskassessment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `risk_level` varchar(20) NOT NULL,
  `prediction_percentage` double NOT NULL,
  `mode` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `medi_symptomsriskassessment_user_id_b191fa15_fk_auth_user_id` (`user_id`),
  CONSTRAINT `medi_symptomsriskassessment_user_id_b191fa15_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medi_symptomsriskassessment`
--

LOCK TABLES `medi_symptomsriskassessment` WRITE;
/*!40000 ALTER TABLE `medi_symptomsriskassessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `medi_symptomsriskassessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'medi'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-02 10:15:43
