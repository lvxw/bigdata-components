-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: mysql    Database: grafana
-- ------------------------------------------------------
-- Server version	5.7.36-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `panel_id` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` mediumtext COLLATE utf8mb4_unicode_ci,
  `frequency` bigint(20) NOT NULL,
  `handler` bigint(20) NOT NULL,
  `severity` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `silenced` tinyint(1) NOT NULL,
  `execution_error` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `eval_data` text COLLATE utf8mb4_unicode_ci,
  `eval_date` datetime DEFAULT NULL,
  `new_state_date` datetime NOT NULL,
  `state_changes` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `for` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_alert_org_id_id` (`org_id`,`id`),
  KEY `IDX_alert_state` (`state`),
  KEY `IDX_alert_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_configuration`
--

DROP TABLE IF EXISTS `alert_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alertmanager_configuration` mediumtext COLLATE utf8mb4_unicode_ci,
  `configuration_version` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  `configuration_hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-yet-calculated',
  PRIMARY KEY (`id`),
  KEY `IDX_alert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_configuration`
--

LOCK TABLES `alert_configuration` WRITE;
/*!40000 ALTER TABLE `alert_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_instance`
--

DROP TABLE IF EXISTS `alert_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_instance` (
  `rule_org_id` bigint(20) NOT NULL,
  `rule_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `labels_hash` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_state_since` bigint(20) NOT NULL,
  `last_eval_time` bigint(20) NOT NULL,
  `current_state_end` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rule_org_id`,`rule_uid`,`labels_hash`),
  KEY `IDX_alert_instance_rule_org_id_rule_uid_current_state` (`rule_org_id`,`rule_uid`,`current_state`),
  KEY `IDX_alert_instance_rule_org_id_current_state` (`rule_org_id`,`current_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_instance`
--

LOCK TABLES `alert_instance` WRITE;
/*!40000 ALTER TABLE `alert_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_notification`
--

DROP TABLE IF EXISTS `alert_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `frequency` bigint(20) DEFAULT NULL,
  `send_reminder` tinyint(1) DEFAULT '0',
  `disable_resolve_message` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secure_settings` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_notification`
--

LOCK TABLES `alert_notification` WRITE;
/*!40000 ALTER TABLE `alert_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_notification_state`
--

DROP TABLE IF EXISTS `alert_notification_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_notification_state` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) NOT NULL,
  `notifier_id` bigint(20) NOT NULL,
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint(20) NOT NULL,
  `updated_at` bigint(20) NOT NULL,
  `alert_rule_state_updated_version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_notification_state_org_id_alert_id_notifier_id` (`org_id`,`alert_id`,`notifier_id`),
  KEY `IDX_alert_notification_state_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_notification_state`
--

LOCK TABLES `alert_notification_state` WRITE;
/*!40000 ALTER TABLE `alert_notification_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_notification_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_rule`
--

DROP TABLE IF EXISTS `alert_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `updated` datetime NOT NULL,
  `interval_seconds` bigint(20) NOT NULL DEFAULT '60',
  `version` int(11) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `namespace_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_data_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint(20) NOT NULL DEFAULT '0',
  `annotations` text COLLATE utf8mb4_unicode_ci,
  `labels` text COLLATE utf8mb4_unicode_ci,
  `dashboard_uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `panel_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_org_id_uid` (`org_id`,`uid`),
  UNIQUE KEY `UQE_alert_rule_org_id_namespace_uid_title` (`org_id`,`namespace_uid`,`title`),
  KEY `IDX_alert_rule_org_id_namespace_uid_rule_group` (`org_id`,`namespace_uid`,`rule_group`),
  KEY `IDX_alert_rule_org_id_dashboard_uid_panel_id` (`org_id`,`dashboard_uid`,`panel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_rule`
--

LOCK TABLES `alert_rule` WRITE;
/*!40000 ALTER TABLE `alert_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_rule_tag`
--

DROP TABLE IF EXISTS `alert_rule_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_rule_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alert_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_tag_alert_id_tag_id` (`alert_id`,`tag_id`),
  KEY `IDX_alert_rule_tag_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_rule_tag`
--

LOCK TABLES `alert_rule_tag` WRITE;
/*!40000 ALTER TABLE `alert_rule_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_rule_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert_rule_version`
--

DROP TABLE IF EXISTS `alert_rule_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert_rule_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rule_org_id` bigint(20) NOT NULL,
  `rule_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `rule_namespace_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rule_group` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_version` int(11) NOT NULL,
  `restored_from` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `title` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  `interval_seconds` bigint(20) NOT NULL,
  `no_data_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NoData',
  `exec_err_state` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Alerting',
  `for` bigint(20) NOT NULL DEFAULT '0',
  `annotations` text COLLATE utf8mb4_unicode_ci,
  `labels` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_alert_rule_version_rule_org_id_rule_uid_version` (`rule_org_id`,`rule_uid`,`version`),
  KEY `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` (`rule_org_id`,`rule_namespace_uid`,`rule_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert_rule_version`
--

LOCK TABLES `alert_rule_version` WRITE;
/*!40000 ALTER TABLE `alert_rule_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert_rule_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `annotation`
--

DROP TABLE IF EXISTS `annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `annotation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `dashboard_id` bigint(20) DEFAULT NULL,
  `panel_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `metric` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prev_state` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `new_state` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `epoch` bigint(20) NOT NULL,
  `region_id` bigint(20) DEFAULT '0',
  `tags` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` bigint(20) DEFAULT '0',
  `updated` bigint(20) DEFAULT '0',
  `epoch_end` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_annotation_org_id_alert_id` (`org_id`,`alert_id`),
  KEY `IDX_annotation_org_id_type` (`org_id`,`type`),
  KEY `IDX_annotation_org_id_created` (`org_id`,`created`),
  KEY `IDX_annotation_org_id_updated` (`org_id`,`updated`),
  KEY `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_org_id_epoch_end_epoch` (`org_id`,`epoch_end`,`epoch`),
  KEY `IDX_annotation_alert_id` (`alert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `annotation`
--

LOCK TABLES `annotation` WRITE;
/*!40000 ALTER TABLE `annotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `annotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `annotation_tag`
--

DROP TABLE IF EXISTS `annotation_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `annotation_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `annotation_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_annotation_tag_annotation_id_tag_id` (`annotation_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `annotation_tag`
--

LOCK TABLES `annotation_tag` WRITE;
/*!40000 ALTER TABLE `annotation_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `annotation_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_key`
--

DROP TABLE IF EXISTS `api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_key` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `expires` bigint(20) DEFAULT NULL,
  `service_account_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_api_key_key` (`key`),
  UNIQUE KEY `UQE_api_key_org_id_name` (`org_id`,`name`),
  KEY `IDX_api_key_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_key`
--

LOCK TABLES `api_key` WRITE;
/*!40000 ALTER TABLE `api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `builtin_role`
--

DROP TABLE IF EXISTS `builtin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `builtin_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `org_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_builtin_role_org_id_role_id_role` (`org_id`,`role_id`,`role`),
  KEY `IDX_builtin_role_role_id` (`role_id`),
  KEY `IDX_builtin_role_role` (`role`),
  KEY `IDX_builtin_role_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `builtin_role`
--

LOCK TABLES `builtin_role` WRITE;
/*!40000 ALTER TABLE `builtin_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `builtin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_data`
--

DROP TABLE IF EXISTS `cache_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_data` (
  `cache_key` varchar(168) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expires` int(255) NOT NULL,
  `created_at` int(255) NOT NULL,
  PRIMARY KEY (`cache_key`),
  UNIQUE KEY `UQE_cache_data_cache_key` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_data`
--

LOCK TABLES `cache_data` WRITE;
/*!40000 ALTER TABLE `cache_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `slug` varchar(189) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(189) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `gnet_id` bigint(20) DEFAULT NULL,
  `plugin_id` varchar(189) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder_id` bigint(20) NOT NULL DEFAULT '0',
  `is_folder` tinyint(1) NOT NULL DEFAULT '0',
  `has_acl` tinyint(1) NOT NULL DEFAULT '0',
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_org_id_folder_id_title` (`org_id`,`folder_id`,`title`),
  UNIQUE KEY `UQE_dashboard_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_dashboard_org_id` (`org_id`),
  KEY `IDX_dashboard_gnet_id` (`gnet_id`),
  KEY `IDX_dashboard_org_id_plugin_id` (`org_id`,`plugin_id`),
  KEY `IDX_dashboard_title` (`title`),
  KEY `IDX_dashboard_is_folder` (`is_folder`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard`
--

LOCK TABLES `dashboard` WRITE;
/*!40000 ALTER TABLE `dashboard` DISABLE KEYS */;
INSERT INTO `dashboard` (`id`, `version`, `slug`, `title`, `data`, `org_id`, `created`, `updated`, `updated_by`, `created_by`, `gnet_id`, `plugin_id`, `folder_id`, `is_folder`, `has_acl`, `uid`) VALUES (1,1,'bigdata-flink','bigdata-flink','{\"schemaVersion\":17,\"title\":\"bigdata-flink\",\"uid\":\"rZdqgaYIz\",\"version\":1}',1,'2024-05-10 11:27:54','2024-05-10 11:27:54',1,1,0,'',0,1,0,'rZdqgaYIz');
INSERT INTO `dashboard` (`id`, `version`, `slug`, `title`, `data`, `org_id`, `created`, `updated`, `updated_by`, `created_by`, `gnet_id`, `plugin_id`, `folder_id`, `is_folder`, `has_acl`, `uid`) VALUES (3,4,'flink-app-metrics','flink-app-metrics','{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":3,\"iteration\":1715312524226,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"barAlignment\":0,\"drawStyle\":\"line\",\"fillOpacity\":0,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineInterpolation\":\"linear\",\"lineWidth\":1,\"pointSize\":5,\"scaleDistribution\":{\"type\":\"linear\"},\"showPoints\":\"auto\",\"spanNulls\":false,\"stacking\":{\"group\":\"A\",\"mode\":\"none\"},\"thresholdsStyle\":{\"mode\":\"off\"}},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"bottom\"},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"targets\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"expr\":\"flink_jobmanager_job_numberOfCompletedCheckpoints{job_name=\\\"$jobName\\\",runEnv=\\\"$runEnv\\\"}\",\"hide\":false,\"refId\":\"Prometheus\"}],\"title\":\"Panel Title\",\"type\":\"timeseries\"}],\"refresh\":\"\",\"schemaVersion\":36,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"current\":{\"selected\":false,\"text\":\"sep\",\"value\":\"sep\"},\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"hide\":0,\"includeAll\":false,\"label\":\"环境\",\"multi\":false,\"name\":\"runEnv\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"},{\"current\":{\"selected\":false,\"text\":\"sep_SocketWindowWordCount2\",\"value\":\"sep_SocketWindowWordCount2\"},\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"hide\":0,\"includeAll\":false,\"label\":\"作业\",\"multi\":false,\"name\":\"jobName\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"flink-app-metrics\",\"uid\":\"EfegkaYSz\",\"version\":4,\"weekStart\":\"\"}',1,'2024-05-10 11:29:22','2024-05-10 11:45:15',1,1,0,'',1,0,0,'EfegkaYSz');
/*!40000 ALTER TABLE `dashboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_acl`
--

DROP TABLE IF EXISTS `dashboard_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_acl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  `permission` smallint(6) NOT NULL DEFAULT '4',
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_user_id` (`dashboard_id`,`user_id`),
  UNIQUE KEY `UQE_dashboard_acl_dashboard_id_team_id` (`dashboard_id`,`team_id`),
  KEY `IDX_dashboard_acl_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_acl_user_id` (`user_id`),
  KEY `IDX_dashboard_acl_team_id` (`team_id`),
  KEY `IDX_dashboard_acl_org_id_role` (`org_id`,`role`),
  KEY `IDX_dashboard_acl_permission` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_acl`
--

LOCK TABLES `dashboard_acl` WRITE;
/*!40000 ALTER TABLE `dashboard_acl` DISABLE KEYS */;
INSERT INTO `dashboard_acl` (`id`, `org_id`, `dashboard_id`, `user_id`, `team_id`, `permission`, `role`, `created`, `updated`) VALUES (1,-1,-1,NULL,NULL,1,'Viewer','2017-06-20 00:00:00','2017-06-20 00:00:00');
INSERT INTO `dashboard_acl` (`id`, `org_id`, `dashboard_id`, `user_id`, `team_id`, `permission`, `role`, `created`, `updated`) VALUES (2,-1,-1,NULL,NULL,2,'Editor','2017-06-20 00:00:00','2017-06-20 00:00:00');
/*!40000 ALTER TABLE `dashboard_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_provisioning`
--

DROP TABLE IF EXISTS `dashboard_provisioning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_provisioning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `external_id` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int(11) NOT NULL DEFAULT '0',
  `check_sum` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_provisioning_dashboard_id` (`dashboard_id`),
  KEY `IDX_dashboard_provisioning_dashboard_id_name` (`dashboard_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_provisioning`
--

LOCK TABLES `dashboard_provisioning` WRITE;
/*!40000 ALTER TABLE `dashboard_provisioning` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_provisioning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_snapshot`
--

DROP TABLE IF EXISTS `dashboard_snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_snapshot` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delete_key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `external` tinyint(1) NOT NULL,
  `external_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires` datetime NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external_delete_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_encrypted` mediumblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_snapshot_key` (`key`),
  UNIQUE KEY `UQE_dashboard_snapshot_delete_key` (`delete_key`),
  KEY `IDX_dashboard_snapshot_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_snapshot`
--

LOCK TABLES `dashboard_snapshot` WRITE;
/*!40000 ALTER TABLE `dashboard_snapshot` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_snapshot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_tag`
--

DROP TABLE IF EXISTS `dashboard_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) NOT NULL,
  `term` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_dashboard_tag_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_tag`
--

LOCK TABLES `dashboard_tag` WRITE;
/*!40000 ALTER TABLE `dashboard_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usage_by_day`
--

DROP TABLE IF EXISTS `dashboard_usage_by_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_usage_by_day` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) NOT NULL,
  `day` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `views` bigint(20) NOT NULL,
  `queries` bigint(20) NOT NULL,
  `errors` bigint(20) NOT NULL,
  `load_duration` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_usage_by_day_dashboard_id_day` (`dashboard_id`,`day`),
  KEY `IDX_dashboard_usage_by_day_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usage_by_day`
--

LOCK TABLES `dashboard_usage_by_day` WRITE;
/*!40000 ALTER TABLE `dashboard_usage_by_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_usage_by_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_usage_sums`
--

DROP TABLE IF EXISTS `dashboard_usage_sums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_usage_sums` (
  `dashboard_id` bigint(20) NOT NULL,
  `updated` datetime NOT NULL,
  `views_last_1_days` bigint(20) NOT NULL,
  `views_last_7_days` bigint(20) NOT NULL,
  `views_last_30_days` bigint(20) NOT NULL,
  `views_total` bigint(20) NOT NULL,
  `queries_last_1_days` bigint(20) NOT NULL,
  `queries_last_7_days` bigint(20) NOT NULL,
  `queries_last_30_days` bigint(20) NOT NULL,
  `queries_total` bigint(20) NOT NULL,
  `errors_last_1_days` bigint(20) NOT NULL DEFAULT '0',
  `errors_last_7_days` bigint(20) NOT NULL DEFAULT '0',
  `errors_last_30_days` bigint(20) NOT NULL DEFAULT '0',
  `errors_total` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_usage_sums`
--

LOCK TABLES `dashboard_usage_sums` WRITE;
/*!40000 ALTER TABLE `dashboard_usage_sums` DISABLE KEYS */;
/*!40000 ALTER TABLE `dashboard_usage_sums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dashboard_version`
--

DROP TABLE IF EXISTS `dashboard_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboard_version` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dashboard_id` bigint(20) NOT NULL,
  `parent_version` int(11) NOT NULL,
  `restored_from` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_dashboard_version_dashboard_id_version` (`dashboard_id`,`version`),
  KEY `IDX_dashboard_version_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboard_version`
--

LOCK TABLES `dashboard_version` WRITE;
/*!40000 ALTER TABLE `dashboard_version` DISABLE KEYS */;
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES (1,1,0,0,1,'2024-05-10 11:27:54',1,'','{\"schemaVersion\":17,\"title\":\"bigdata-flink\",\"uid\":\"rZdqgaYIz\",\"version\":1}');
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES (3,3,0,0,1,'2024-05-10 11:29:22',1,'','{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"hideControls\":false,\"id\":null,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"datasource\",\"uid\":\"grafana\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"barAlignment\":0,\"drawStyle\":\"line\",\"fillOpacity\":0,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineInterpolation\":\"linear\",\"lineWidth\":1,\"pointSize\":5,\"scaleDistribution\":{\"type\":\"linear\"},\"showPoints\":\"auto\",\"spanNulls\":false,\"stacking\":{\"group\":\"A\",\"mode\":\"none\"},\"thresholdsStyle\":{\"mode\":\"off\"}},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"bottom\"},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"title\":\"Panel Title\",\"type\":\"timeseries\"}],\"refresh\":\"\",\"schemaVersion\":36,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"flink-app-metrics\",\"uid\":\"EfegkaYSz\",\"version\":1,\"weekStart\":\"\"}');
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES (4,3,1,0,2,'2024-05-10 11:35:33',1,'','{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":3,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"barAlignment\":0,\"drawStyle\":\"line\",\"fillOpacity\":0,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineInterpolation\":\"linear\",\"lineWidth\":1,\"pointSize\":5,\"scaleDistribution\":{\"type\":\"linear\"},\"showPoints\":\"auto\",\"spanNulls\":false,\"stacking\":{\"group\":\"A\",\"mode\":\"none\"},\"thresholdsStyle\":{\"mode\":\"off\"}},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"bottom\"},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"targets\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"hide\":false,\"refId\":\"Prometheus\"}],\"title\":\"Panel Title\",\"type\":\"timeseries\"}],\"refresh\":\"\",\"schemaVersion\":36,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"flink-app-metrics\",\"uid\":\"EfegkaYSz\",\"version\":2,\"weekStart\":\"\"}');
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES (5,3,2,0,3,'2024-05-10 11:39:24',1,'','{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":3,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"barAlignment\":0,\"drawStyle\":\"line\",\"fillOpacity\":0,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineInterpolation\":\"linear\",\"lineWidth\":1,\"pointSize\":5,\"scaleDistribution\":{\"type\":\"linear\"},\"showPoints\":\"auto\",\"spanNulls\":false,\"stacking\":{\"group\":\"A\",\"mode\":\"none\"},\"thresholdsStyle\":{\"mode\":\"off\"}},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"bottom\"},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"targets\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"hide\":false,\"refId\":\"Prometheus\"}],\"title\":\"Panel Title\",\"type\":\"timeseries\"}],\"refresh\":\"\",\"schemaVersion\":36,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"current\":{\"selected\":false,\"text\":\"sep\",\"value\":\"sep\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"hide\":0,\"includeAll\":false,\"label\":\"环境\",\"multi\":false,\"name\":\"runEnv\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"},{\"current\":{\"selected\":false,\"text\":\"sep_SocketWindowWordCount2\",\"value\":\"sep_SocketWindowWordCount2\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"hide\":0,\"includeAll\":false,\"label\":\"作业\",\"multi\":false,\"name\":\"jobName\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"flink-app-metrics\",\"uid\":\"EfegkaYSz\",\"version\":3,\"weekStart\":\"\"}');
INSERT INTO `dashboard_version` (`id`, `dashboard_id`, `parent_version`, `restored_from`, `version`, `created`, `created_by`, `message`, `data`) VALUES (7,3,3,0,4,'2024-05-10 11:45:15',1,'','{\"annotations\":{\"list\":[{\"builtIn\":1,\"datasource\":{\"type\":\"grafana\",\"uid\":\"-- Grafana --\"},\"enable\":true,\"hide\":true,\"iconColor\":\"rgba(0, 211, 255, 1)\",\"name\":\"Annotations \\u0026 Alerts\",\"target\":{\"limit\":100,\"matchAny\":false,\"tags\":[],\"type\":\"dashboard\"},\"type\":\"dashboard\"}]},\"editable\":true,\"fiscalYearStartMonth\":0,\"graphTooltip\":0,\"id\":3,\"iteration\":1715312524226,\"links\":[],\"liveNow\":false,\"panels\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"fieldConfig\":{\"defaults\":{\"color\":{\"mode\":\"palette-classic\"},\"custom\":{\"axisLabel\":\"\",\"axisPlacement\":\"auto\",\"barAlignment\":0,\"drawStyle\":\"line\",\"fillOpacity\":0,\"gradientMode\":\"none\",\"hideFrom\":{\"legend\":false,\"tooltip\":false,\"viz\":false},\"lineInterpolation\":\"linear\",\"lineWidth\":1,\"pointSize\":5,\"scaleDistribution\":{\"type\":\"linear\"},\"showPoints\":\"auto\",\"spanNulls\":false,\"stacking\":{\"group\":\"A\",\"mode\":\"none\"},\"thresholdsStyle\":{\"mode\":\"off\"}},\"mappings\":[],\"thresholds\":{\"mode\":\"absolute\",\"steps\":[{\"color\":\"green\",\"value\":null},{\"color\":\"red\",\"value\":80}]}},\"overrides\":[]},\"gridPos\":{\"h\":9,\"w\":12,\"x\":0,\"y\":0},\"id\":2,\"options\":{\"legend\":{\"calcs\":[],\"displayMode\":\"list\",\"placement\":\"bottom\"},\"tooltip\":{\"mode\":\"single\",\"sort\":\"none\"}},\"targets\":[{\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"expr\":\"flink_jobmanager_job_numberOfCompletedCheckpoints{job_name=\\\"$jobName\\\",runEnv=\\\"$runEnv\\\"}\",\"hide\":false,\"refId\":\"Prometheus\"}],\"title\":\"Panel Title\",\"type\":\"timeseries\"}],\"refresh\":\"\",\"schemaVersion\":36,\"style\":\"dark\",\"tags\":[],\"templating\":{\"list\":[{\"current\":{\"selected\":false,\"text\":\"sep\",\"value\":\"sep\"},\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"hide\":0,\"includeAll\":false,\"label\":\"环境\",\"multi\":false,\"name\":\"runEnv\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},runEnv)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"},{\"current\":{\"selected\":false,\"text\":\"sep_SocketWindowWordCount2\",\"value\":\"sep_SocketWindowWordCount2\"},\"datasource\":{\"type\":\"prometheus\",\"uid\":\"nyOzk-LIk\"},\"definition\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"hide\":0,\"includeAll\":false,\"label\":\"作业\",\"multi\":false,\"name\":\"jobName\",\"options\":[],\"query\":{\"query\":\"label_values({__name__=\\\"flink_jobmanager_job_deployingTime\\\"},job_name)\",\"refId\":\"StandardVariableQuery\"},\"refresh\":1,\"regex\":\"\",\"skipUrlSync\":false,\"sort\":0,\"type\":\"query\"}]},\"time\":{\"from\":\"now-6h\",\"to\":\"now\"},\"timepicker\":{},\"timezone\":\"\",\"title\":\"flink-app-metrics\",\"uid\":\"EfegkaYSz\",\"version\":4,\"weekStart\":\"\"}');
/*!40000 ALTER TABLE `dashboard_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_keys`
--

DROP TABLE IF EXISTS `data_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_keys` (
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `scope` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `encrypted_data` blob NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_keys`
--

LOCK TABLES `data_keys` WRITE;
/*!40000 ALTER TABLE `data_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_source`
--

DROP TABLE IF EXISTS `data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_source` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `database` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth` tinyint(1) NOT NULL,
  `basic_auth_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_auth_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `json_data` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `with_credentials` tinyint(1) NOT NULL DEFAULT '0',
  `secure_json_data` text COLLATE utf8mb4_unicode_ci,
  `read_only` tinyint(1) DEFAULT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_data_source_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_data_source_org_id_uid` (`org_id`,`uid`),
  KEY `IDX_data_source_org_id` (`org_id`),
  KEY `IDX_data_source_org_id_is_default` (`org_id`,`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source`
--

LOCK TABLES `data_source` WRITE;
/*!40000 ALTER TABLE `data_source` DISABLE KEYS */;
INSERT INTO `data_source` (`id`, `org_id`, `version`, `type`, `name`, `access`, `url`, `password`, `user`, `database`, `basic_auth`, `basic_auth_user`, `basic_auth_password`, `is_default`, `json_data`, `created`, `updated`, `with_credentials`, `secure_json_data`, `read_only`, `uid`) VALUES (1,1,4,'prometheus','Prometheus','proxy','http://prometheus:9090','','','',0,'','',1,'{\"httpMethod\":\"POST\"}','2024-05-10 11:29:33','2024-05-10 11:34:22',0,'{}',0,'nyOzk-LIk');
/*!40000 ALTER TABLE `data_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_source_acl`
--

DROP TABLE IF EXISTS `data_source_acl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_source_acl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `data_source_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission` smallint(6) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_data_source_acl_data_source_id_team_id_user_id` (`data_source_id`,`team_id`,`user_id`),
  KEY `IDX_data_source_acl_data_source_id` (`data_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source_acl`
--

LOCK TABLES `data_source_acl` WRITE;
/*!40000 ALTER TABLE `data_source_acl` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_source_acl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_source_cache`
--

DROP TABLE IF EXISTS `data_source_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_source_cache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_source_id` bigint(20) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `ttl_ms` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `use_default_ttl` tinyint(1) NOT NULL DEFAULT '1',
  `data_source_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `ttl_resources_ms` bigint(20) NOT NULL DEFAULT '300000',
  PRIMARY KEY (`id`),
  KEY `IDX_data_source_cache_data_source_id` (`data_source_id`),
  KEY `IDX_data_source_cache_data_source_uid` (`data_source_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source_cache`
--

LOCK TABLES `data_source_cache` WRITE;
/*!40000 ALTER TABLE `data_source_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_source_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_source_usage_by_day`
--

DROP TABLE IF EXISTS `data_source_usage_by_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_source_usage_by_day` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_source_id` bigint(20) NOT NULL,
  `day` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queries` bigint(20) NOT NULL,
  `errors` bigint(20) NOT NULL,
  `load_duration_ms` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_data_source_usage_by_day_data_source_id_day` (`data_source_id`,`day`),
  KEY `IDX_data_source_usage_by_day_data_source_id` (`data_source_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source_usage_by_day`
--

LOCK TABLES `data_source_usage_by_day` WRITE;
/*!40000 ALTER TABLE `data_source_usage_by_day` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_source_usage_by_day` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kv_store`
--

DROP TABLE IF EXISTS `kv_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kv_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `namespace` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_kv_store_org_id_namespace_key` (`org_id`,`namespace`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kv_store`
--

LOCK TABLES `kv_store` WRITE;
/*!40000 ALTER TABLE `kv_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `kv_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_element`
--

DROP TABLE IF EXISTS `library_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_element` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `folder_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kind` bigint(20) NOT NULL,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `updated` datetime NOT NULL,
  `updated_by` bigint(20) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_org_id_folder_id_name_kind` (`org_id`,`folder_id`,`name`,`kind`),
  UNIQUE KEY `UQE_library_element_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_element`
--

LOCK TABLES `library_element` WRITE;
/*!40000 ALTER TABLE `library_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_element_connection`
--

DROP TABLE IF EXISTS `library_element_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_element_connection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `element_id` bigint(20) NOT NULL,
  `kind` bigint(20) NOT NULL,
  `connection_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `created_by` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_library_element_connection_element_id_kind_connection_id` (`element_id`,`kind`,`connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_element_connection`
--

LOCK TABLES `library_element_connection` WRITE;
/*!40000 ALTER TABLE `library_element_connection` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_element_connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `license_token`
--

DROP TABLE IF EXISTS `license_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `license_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `license_token`
--

LOCK TABLES `license_token` WRITE;
/*!40000 ALTER TABLE `license_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `license_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempt`
--

DROP TABLE IF EXISTS `login_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_attempt` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_login_attempt_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempt`
--

LOCK TABLES `login_attempt` WRITE;
/*!40000 ALTER TABLE `login_attempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration_log`
--

DROP TABLE IF EXISTS `migration_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migration_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `migration_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sql` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `success` tinyint(1) NOT NULL,
  `error` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=462 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration_log`
--

LOCK TABLES `migration_log` WRITE;
/*!40000 ALTER TABLE `migration_log` DISABLE KEYS */;
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (1,'create migration_log table','CREATE TABLE IF NOT EXISTS `migration_log` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `migration_id` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `sql` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `success` TINYINT(1) NOT NULL\n, `error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `timestamp` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (2,'create user table','CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `account_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (3,'add unique index user.login','CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (4,'add unique index user.email','CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (5,'drop index UQE_user_login - v1','DROP INDEX `UQE_user_login` ON `user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (6,'drop index UQE_user_email - v1','DROP INDEX `UQE_user_email` ON `user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (7,'Rename table user to user_v1 - v1','ALTER TABLE `user` RENAME TO `user_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (8,'create user table v2','CREATE TABLE IF NOT EXISTS `user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `org_id` BIGINT(20) NOT NULL\n, `is_admin` TINYINT(1) NOT NULL\n, `email_verified` TINYINT(1) NULL\n, `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (9,'create index UQE_user_login - v2','CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (10,'create index UQE_user_email - v2','CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (11,'copy data_source v1 to v2','INSERT INTO `user` (`version`\n, `email`\n, `password`\n, `company`\n, `is_admin`\n, `created`\n, `updated`\n, `id`\n, `name`\n, `salt`\n, `rands`\n, `org_id`\n, `login`) SELECT `version`\n, `email`\n, `password`\n, `company`\n, `is_admin`\n, `created`\n, `updated`\n, `id`\n, `name`\n, `salt`\n, `rands`\n, `account_id`\n, `login` FROM `user_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (12,'Drop old table user_v1','DROP TABLE IF EXISTS `user_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (13,'Add column help_flags1 to user table','alter table `user` ADD COLUMN `help_flags1` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (14,'Update user table charset','ALTER TABLE `user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `login` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `salt` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `rands` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `company` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `theme` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (15,'Add last_seen_at column to user','alter table `user` ADD COLUMN `last_seen_at` DATETIME NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (16,'Add missing user data','code migration',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (17,'Add is_disabled column to user','alter table `user` ADD COLUMN `is_disabled` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (18,'Add index user.login/user.email','CREATE INDEX `IDX_user_login_email` ON `user` (`login`,`email`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (19,'Add is_service_account column to user','alter table `user` ADD COLUMN `is_service_account` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (20,'Update is_service_account column to nullable','ALTER TABLE user MODIFY is_service_account BOOLEAN DEFAULT 0;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (21,'create temp user table v1-7','CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (22,'create index IDX_temp_user_email - v1-7','CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (23,'create index IDX_temp_user_org_id - v1-7','CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (24,'create index IDX_temp_user_code - v1-7','CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (25,'create index IDX_temp_user_status - v1-7','CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (26,'Update temp_user table charset','ALTER TABLE `temp_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (27,'drop index IDX_temp_user_email - v1','DROP INDEX `IDX_temp_user_email` ON `temp_user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (28,'drop index IDX_temp_user_org_id - v1','DROP INDEX `IDX_temp_user_org_id` ON `temp_user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (29,'drop index IDX_temp_user_code - v1','DROP INDEX `IDX_temp_user_code` ON `temp_user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (30,'drop index IDX_temp_user_status - v1','DROP INDEX `IDX_temp_user_status` ON `temp_user`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (31,'Rename table temp_user to temp_user_tmp_qwerty - v1','ALTER TABLE `temp_user` RENAME TO `temp_user_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (32,'create temp_user v2','CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `code` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `status` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `invited_by_user_id` BIGINT(20) NULL\n, `email_sent` TINYINT(1) NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` INT NOT NULL DEFAULT 0\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (33,'create index IDX_temp_user_email - v2','CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (34,'create index IDX_temp_user_org_id - v2','CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (35,'create index IDX_temp_user_code - v2','CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (36,'create index IDX_temp_user_status - v2','CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (37,'copy temp_user v1 to v2','INSERT INTO `temp_user` (`invited_by_user_id`\n, `email_sent`\n, `email_sent_on`\n, `remote_addr`\n, `version`\n, `email`\n, `code`\n, `role`\n, `status`\n, `id`\n, `org_id`\n, `name`) SELECT `invited_by_user_id`\n, `email_sent`\n, `email_sent_on`\n, `remote_addr`\n, `version`\n, `email`\n, `code`\n, `role`\n, `status`\n, `id`\n, `org_id`\n, `name` FROM `temp_user_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (38,'drop temp_user_tmp_qwerty','DROP TABLE IF EXISTS `temp_user_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (39,'Set created for temp users that will otherwise prematurely expire','code migration',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (40,'create star table','CREATE TABLE IF NOT EXISTS `star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (41,'add unique index star.user_id_dashboard_id','CREATE UNIQUE INDEX `UQE_star_user_id_dashboard_id` ON `star` (`user_id`,`dashboard_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (42,'create org table v1','CREATE TABLE IF NOT EXISTS `org` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (43,'create index UQE_org_name - v1','CREATE UNIQUE INDEX `UQE_org_name` ON `org` (`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (44,'create org_user table v1','CREATE TABLE IF NOT EXISTS `org_user` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (45,'create index IDX_org_user_org_id - v1','CREATE INDEX `IDX_org_user_org_id` ON `org_user` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (46,'create index UQE_org_user_org_id_user_id - v1','CREATE UNIQUE INDEX `UQE_org_user_org_id_user_id` ON `org_user` (`org_id`,`user_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (47,'create index IDX_org_user_user_id - v1','CREATE INDEX `IDX_org_user_user_id` ON `org_user` (`user_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (48,'Update org table charset','ALTER TABLE `org` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `address1` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `address2` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `city` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `state` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `zip_code` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `country` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `billing_email` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (49,'Update org_user table charset','ALTER TABLE `org_user` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (50,'Migrate all Read Only Viewers to Viewers','UPDATE org_user SET role = \'Viewer\' WHERE role = \'Read Only Editor\'',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (51,'create dashboard table','CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (52,'add index dashboard.account_id','CREATE INDEX `IDX_dashboard_account_id` ON `dashboard` (`account_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (53,'add unique index dashboard_account_id_slug','CREATE UNIQUE INDEX `UQE_dashboard_account_id_slug` ON `dashboard` (`account_id`,`slug`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (54,'create dashboard_tag table','CREATE TABLE IF NOT EXISTS `dashboard_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (55,'add unique index dashboard_tag.dasboard_id_term','CREATE UNIQUE INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag` (`dashboard_id`,`term`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (56,'drop index UQE_dashboard_tag_dashboard_id_term - v1','DROP INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (57,'Rename table dashboard to dashboard_v1 - v1','ALTER TABLE `dashboard` RENAME TO `dashboard_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (58,'create dashboard v2','CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` INT NOT NULL\n, `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (59,'create index IDX_dashboard_org_id - v2','CREATE INDEX `IDX_dashboard_org_id` ON `dashboard` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (60,'create index UQE_dashboard_org_id_slug - v2','CREATE UNIQUE INDEX `UQE_dashboard_org_id_slug` ON `dashboard` (`org_id`,`slug`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (61,'copy dashboard v1 to v2','INSERT INTO `dashboard` (`data`\n, `org_id`\n, `created`\n, `updated`\n, `id`\n, `version`\n, `slug`\n, `title`) SELECT `data`\n, `account_id`\n, `created`\n, `updated`\n, `id`\n, `version`\n, `slug`\n, `title` FROM `dashboard_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (62,'drop table dashboard_v1','DROP TABLE IF EXISTS `dashboard_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (63,'alter dashboard.data to mediumtext v1','ALTER TABLE dashboard MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (64,'Add column updated_by in dashboard - v2','alter table `dashboard` ADD COLUMN `updated_by` INT NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (65,'Add column created_by in dashboard - v2','alter table `dashboard` ADD COLUMN `created_by` INT NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (66,'Add column gnetId in dashboard','alter table `dashboard` ADD COLUMN `gnet_id` BIGINT(20) NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (67,'Add index for gnetId in dashboard','CREATE INDEX `IDX_dashboard_gnet_id` ON `dashboard` (`gnet_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (68,'Add column plugin_id in dashboard','alter table `dashboard` ADD COLUMN `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (69,'Add index for plugin_id in dashboard','CREATE INDEX `IDX_dashboard_org_id_plugin_id` ON `dashboard` (`org_id`,`plugin_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (70,'Add index for dashboard_id in dashboard_tag','CREATE INDEX `IDX_dashboard_tag_dashboard_id` ON `dashboard_tag` (`dashboard_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (71,'Update dashboard table charset','ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `slug` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `plugin_id` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `data` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (72,'Update dashboard_tag table charset','ALTER TABLE `dashboard_tag` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `term` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (73,'Add column folder_id in dashboard','alter table `dashboard` ADD COLUMN `folder_id` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (74,'Add column isFolder in dashboard','alter table `dashboard` ADD COLUMN `is_folder` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (75,'Add column has_acl in dashboard','alter table `dashboard` ADD COLUMN `has_acl` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (76,'Add column uid in dashboard','alter table `dashboard` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (77,'Update uid column values in dashboard','UPDATE dashboard SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (78,'Add unique index dashboard_org_id_uid','CREATE UNIQUE INDEX `UQE_dashboard_org_id_uid` ON `dashboard` (`org_id`,`uid`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (79,'Remove unique index org_id_slug','DROP INDEX `UQE_dashboard_org_id_slug` ON `dashboard`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (80,'Update dashboard title length','ALTER TABLE `dashboard` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `title` VARCHAR(189) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (81,'Add unique index for dashboard_org_id_title_folder_id','CREATE UNIQUE INDEX `UQE_dashboard_org_id_folder_id_title` ON `dashboard` (`org_id`,`folder_id`,`title`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (82,'create dashboard_provisioning','CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (83,'Rename table dashboard_provisioning to dashboard_provisioning_tmp_qwerty - v1','ALTER TABLE `dashboard_provisioning` RENAME TO `dashboard_provisioning_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (84,'create dashboard_provisioning v2','CREATE TABLE IF NOT EXISTS `dashboard_provisioning` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `external_id` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (85,'create index IDX_dashboard_provisioning_dashboard_id - v2','CREATE INDEX `IDX_dashboard_provisioning_dashboard_id` ON `dashboard_provisioning` (`dashboard_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (86,'create index IDX_dashboard_provisioning_dashboard_id_name - v2','CREATE INDEX `IDX_dashboard_provisioning_dashboard_id_name` ON `dashboard_provisioning` (`dashboard_id`,`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (87,'copy dashboard_provisioning v1 to v2','INSERT INTO `dashboard_provisioning` (`id`\n, `dashboard_id`\n, `name`\n, `external_id`) SELECT `id`\n, `dashboard_id`\n, `name`\n, `external_id` FROM `dashboard_provisioning_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (88,'drop dashboard_provisioning_tmp_qwerty','DROP TABLE IF EXISTS `dashboard_provisioning_tmp_qwerty`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (89,'Add check_sum column','alter table `dashboard_provisioning` ADD COLUMN `check_sum` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (90,'Add index for dashboard_title','CREATE INDEX `IDX_dashboard_title` ON `dashboard` (`title`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (91,'delete tags for deleted dashboards','DELETE FROM dashboard_tag WHERE dashboard_id NOT IN (SELECT id FROM dashboard)',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (92,'delete stars for deleted dashboards','DELETE FROM star WHERE dashboard_id NOT IN (SELECT id FROM dashboard)',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (93,'Add index for dashboard_is_folder','CREATE INDEX `IDX_dashboard_is_folder` ON `dashboard` (`is_folder`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (94,'create data_source table','CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (95,'add index data_source.account_id','CREATE INDEX `IDX_data_source_account_id` ON `data_source` (`account_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (96,'add unique index data_source.account_id_name','CREATE UNIQUE INDEX `UQE_data_source_account_id_name` ON `data_source` (`account_id`,`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (97,'drop index IDX_data_source_account_id - v1','DROP INDEX `IDX_data_source_account_id` ON `data_source`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (98,'drop index UQE_data_source_account_id_name - v1','DROP INDEX `UQE_data_source_account_id_name` ON `data_source`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (99,'Rename table data_source to data_source_v1 - v1','ALTER TABLE `data_source` RENAME TO `data_source_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (100,'create data_source table v2','CREATE TABLE IF NOT EXISTS `data_source` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth` TINYINT(1) NOT NULL\n, `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `is_default` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (101,'create index IDX_data_source_org_id - v2','CREATE INDEX `IDX_data_source_org_id` ON `data_source` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (102,'create index UQE_data_source_org_id_name - v2','CREATE UNIQUE INDEX `UQE_data_source_org_id_name` ON `data_source` (`org_id`,`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (103,'copy data_source v1 to v2','INSERT INTO `data_source` (`org_id`\n, `version`\n, `name`\n, `url`\n, `user`\n, `basic_auth_user`\n, `created`\n, `password`\n, `basic_auth_password`\n, `is_default`\n, `type`\n, `basic_auth`\n, `updated`\n, `id`\n, `access`\n, `database`) SELECT `account_id`\n, `version`\n, `name`\n, `url`\n, `user`\n, `basic_auth_user`\n, `created`\n, `password`\n, `basic_auth_password`\n, `is_default`\n, `type`\n, `basic_auth`\n, `updated`\n, `id`\n, `access`\n, `database` FROM `data_source_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (104,'Drop old table data_source_v1 #2','DROP TABLE IF EXISTS `data_source_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (105,'Add column with_credentials','alter table `data_source` ADD COLUMN `with_credentials` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (106,'Add secure json data column','alter table `data_source` ADD COLUMN `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (107,'Update data_source table charset','ALTER TABLE `data_source` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `access` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `database` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_user` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `basic_auth_password` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (108,'Update initial version to 1','UPDATE data_source SET version = 1 WHERE version = 0',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (109,'Add read_only data column','alter table `data_source` ADD COLUMN `read_only` TINYINT(1) NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (110,'Migrate logging ds to loki ds','UPDATE data_source SET type = \'loki\' WHERE type = \'logging\'',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (111,'Update json_data with nulls','UPDATE data_source SET json_data = \'{}\' WHERE json_data is null',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (112,'Add uid column','alter table `data_source` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (113,'Update uid value','UPDATE data_source SET uid=lpad(id,9,\'0\');',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (114,'Add unique index datasource_org_id_uid','CREATE UNIQUE INDEX `UQE_data_source_org_id_uid` ON `data_source` (`org_id`,`uid`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (115,'add unique index datasource_org_id_is_default','CREATE INDEX `IDX_data_source_org_id_is_default` ON `data_source` (`org_id`,`is_default`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (116,'create api_key table','CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `account_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (117,'add index api_key.account_id','CREATE INDEX `IDX_api_key_account_id` ON `api_key` (`account_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (118,'add index api_key.key','CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (119,'add index api_key.account_id_name','CREATE UNIQUE INDEX `UQE_api_key_account_id_name` ON `api_key` (`account_id`,`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (120,'drop index IDX_api_key_account_id - v1','DROP INDEX `IDX_api_key_account_id` ON `api_key`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (121,'drop index UQE_api_key_key - v1','DROP INDEX `UQE_api_key_key` ON `api_key`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (122,'drop index UQE_api_key_account_id_name - v1','DROP INDEX `UQE_api_key_account_id_name` ON `api_key`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (123,'Rename table api_key to api_key_v1 - v1','ALTER TABLE `api_key` RENAME TO `api_key_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (124,'create api_key table v2','CREATE TABLE IF NOT EXISTS `api_key` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (125,'create index IDX_api_key_org_id - v2','CREATE INDEX `IDX_api_key_org_id` ON `api_key` (`org_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (126,'create index UQE_api_key_key - v2','CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (127,'create index UQE_api_key_org_id_name - v2','CREATE UNIQUE INDEX `UQE_api_key_org_id_name` ON `api_key` (`org_id`,`name`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (128,'copy api_key v1 to v2','INSERT INTO `api_key` (`org_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated`\n, `id`) SELECT `account_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated`\n, `id` FROM `api_key_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (129,'Drop old table api_key_v1','DROP TABLE IF EXISTS `api_key_v1`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (130,'Update api_key table charset','ALTER TABLE `api_key` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `role` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (131,'Add expires to api_key table','alter table `api_key` ADD COLUMN `expires` BIGINT(20) NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (132,'Add service account foreign key','alter table `api_key` ADD COLUMN `service_account_id` BIGINT(20) NULL ',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (133,'set service account foreign key to nil if 0','UPDATE api_key SET service_account_id = NULL WHERE service_account_id = 0;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (134,'create dashboard_snapshot table v4','CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (135,'drop table dashboard_snapshot_v4 #1','DROP TABLE IF EXISTS `dashboard_snapshot`',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (136,'create dashboard_snapshot table v5 #2','CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `external` TINYINT(1) NOT NULL\n, `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `dashboard` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (137,'create index UQE_dashboard_snapshot_key - v5','CREATE UNIQUE INDEX `UQE_dashboard_snapshot_key` ON `dashboard_snapshot` (`key`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (138,'create index UQE_dashboard_snapshot_delete_key - v5','CREATE UNIQUE INDEX `UQE_dashboard_snapshot_delete_key` ON `dashboard_snapshot` (`delete_key`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (139,'create index IDX_dashboard_snapshot_user_id - v5','CREATE INDEX `IDX_dashboard_snapshot_user_id` ON `dashboard_snapshot` (`user_id`);',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (140,'alter dashboard_snapshot to mediumtext v2','ALTER TABLE dashboard_snapshot MODIFY dashboard MEDIUMTEXT;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (141,'Update dashboard_snapshot table charset','ALTER TABLE `dashboard_snapshot` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `delete_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `external_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `dashboard` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:25');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (142,'Add column external_delete_url to dashboard_snapshots table','alter table `dashboard_snapshot` ADD COLUMN `external_delete_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (143,'Add encrypted dashboard json column','alter table `dashboard_snapshot` ADD COLUMN `dashboard_encrypted` BLOB NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (144,'Change dashboard_encrypted column to MEDIUMBLOB','ALTER TABLE dashboard_snapshot MODIFY dashboard_encrypted MEDIUMBLOB;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (145,'create quota table v1','CREATE TABLE IF NOT EXISTS `quota` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `limit` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (146,'create index UQE_quota_org_id_user_id_target - v1','CREATE UNIQUE INDEX `UQE_quota_org_id_user_id_target` ON `quota` (`org_id`,`user_id`,`target`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (147,'Update quota table charset','ALTER TABLE `quota` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `target` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (148,'create plugin_setting table','CREATE TABLE IF NOT EXISTS `plugin_setting` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NULL\n, `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `enabled` TINYINT(1) NOT NULL\n, `pinned` TINYINT(1) NOT NULL\n, `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (149,'create index UQE_plugin_setting_org_id_plugin_id - v1','CREATE UNIQUE INDEX `UQE_plugin_setting_org_id_plugin_id` ON `plugin_setting` (`org_id`,`plugin_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (150,'Add column plugin_version to plugin_settings','alter table `plugin_setting` ADD COLUMN `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (151,'Update plugin_setting table charset','ALTER TABLE `plugin_setting` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `plugin_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `secure_json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `plugin_version` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (152,'create session table','CREATE TABLE IF NOT EXISTS `session` (\n`key` CHAR(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expiry` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (153,'Drop old table playlist table','DROP TABLE IF EXISTS `playlist`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (154,'Drop old table playlist_item table','DROP TABLE IF EXISTS `playlist_item`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (155,'create playlist table v2','CREATE TABLE IF NOT EXISTS `playlist` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (156,'create playlist item table v2','CREATE TABLE IF NOT EXISTS `playlist_item` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `playlist_id` BIGINT(20) NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `order` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (157,'Update playlist table charset','ALTER TABLE `playlist` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `interval` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (158,'Update playlist_item table charset','ALTER TABLE `playlist_item` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (159,'drop preferences table v2','DROP TABLE IF EXISTS `preferences`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (160,'drop preferences table v3','DROP TABLE IF EXISTS `preferences`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (161,'create preferences table v3','CREATE TABLE IF NOT EXISTS `preferences` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `version` INT NOT NULL\n, `home_dashboard_id` BIGINT(20) NOT NULL\n, `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (162,'Update preferences table charset','ALTER TABLE `preferences` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `theme` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (163,'Add column team_id in preferences','alter table `preferences` ADD COLUMN `team_id` BIGINT(20) NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (164,'Update team_id column values in preferences','UPDATE preferences SET team_id=0 WHERE team_id IS NULL;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (165,'Add column week_start in preferences','alter table `preferences` ADD COLUMN `week_start` VARCHAR(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (166,'Add column preferences.json_data','alter table `preferences` ADD COLUMN `json_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (167,'alter preferences.json_data to mediumtext v1','ALTER TABLE preferences MODIFY json_data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (168,'create alert table v1','CREATE TABLE IF NOT EXISTS `alert` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `panel_id` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `frequency` BIGINT(20) NOT NULL\n, `handler` BIGINT(20) NOT NULL\n, `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `silenced` TINYINT(1) NOT NULL\n, `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `eval_date` DATETIME NULL\n, `new_state_date` DATETIME NOT NULL\n, `state_changes` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (169,'add index alert org_id & id ','CREATE INDEX `IDX_alert_org_id_id` ON `alert` (`org_id`,`id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (170,'add index alert state','CREATE INDEX `IDX_alert_state` ON `alert` (`state`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (171,'add index alert dashboard_id','CREATE INDEX `IDX_alert_dashboard_id` ON `alert` (`dashboard_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (172,'Create alert_rule_tag table v1','CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (173,'Add unique index alert_rule_tag.alert_id_tag_id','CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (174,'drop index UQE_alert_rule_tag_alert_id_tag_id - v1','DROP INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (175,'Rename table alert_rule_tag to alert_rule_tag_v1 - v1','ALTER TABLE `alert_rule_tag` RENAME TO `alert_rule_tag_v1`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (176,'Create alert_rule_tag table v2','CREATE TABLE IF NOT EXISTS `alert_rule_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (177,'create index UQE_alert_rule_tag_alert_id_tag_id - Add unique index alert_rule_tag.alert_id_tag_id V2','CREATE UNIQUE INDEX `UQE_alert_rule_tag_alert_id_tag_id` ON `alert_rule_tag` (`alert_id`,`tag_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (178,'copy alert_rule_tag v1 to v2','INSERT INTO `alert_rule_tag` (`alert_id`\n, `tag_id`) SELECT `alert_id`\n, `tag_id` FROM `alert_rule_tag_v1`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (179,'drop table alert_rule_tag_v1','DROP TABLE IF EXISTS `alert_rule_tag_v1`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (180,'create alert_notification table v1','CREATE TABLE IF NOT EXISTS `alert_notification` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (181,'Add column is_default','alter table `alert_notification` ADD COLUMN `is_default` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (182,'Add column frequency','alter table `alert_notification` ADD COLUMN `frequency` BIGINT(20) NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (183,'Add column send_reminder','alter table `alert_notification` ADD COLUMN `send_reminder` TINYINT(1) NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (184,'Add column disable_resolve_message','alter table `alert_notification` ADD COLUMN `disable_resolve_message` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (185,'add index alert_notification org_id & name','CREATE UNIQUE INDEX `UQE_alert_notification_org_id_name` ON `alert_notification` (`org_id`,`name`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (186,'Update alert table charset','ALTER TABLE `alert` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `severity` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `execution_error` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `eval_data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (187,'Update alert_notification table charset','ALTER TABLE `alert_notification` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `type` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (188,'create notification_journal table v1','CREATE TABLE IF NOT EXISTS `alert_notification_journal` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `sent_at` BIGINT(20) NOT NULL\n, `success` TINYINT(1) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (189,'add index notification_journal org_id & alert_id & notifier_id','CREATE INDEX `IDX_alert_notification_journal_org_id_alert_id_notifier_id` ON `alert_notification_journal` (`org_id`,`alert_id`,`notifier_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (190,'drop alert_notification_journal','DROP TABLE IF EXISTS `alert_notification_journal`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (191,'create alert_notification_state table v1','CREATE TABLE IF NOT EXISTS `alert_notification_state` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NOT NULL\n, `notifier_id` BIGINT(20) NOT NULL\n, `state` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `updated_at` BIGINT(20) NOT NULL\n, `alert_rule_state_updated_version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (192,'add index alert_notification_state org_id & alert_id & notifier_id','CREATE UNIQUE INDEX `UQE_alert_notification_state_org_id_alert_id_notifier_id` ON `alert_notification_state` (`org_id`,`alert_id`,`notifier_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (193,'Add for to alert table','alter table `alert` ADD COLUMN `for` BIGINT(20) NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (194,'Add column uid in alert_notification','alter table `alert_notification` ADD COLUMN `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (195,'Update uid column values in alert_notification','UPDATE alert_notification SET uid=lpad(id,9,\'0\') WHERE uid IS NULL;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (196,'Add unique index alert_notification_org_id_uid','CREATE UNIQUE INDEX `UQE_alert_notification_org_id_uid` ON `alert_notification` (`org_id`,`uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (197,'Remove unique index org_id_name','DROP INDEX `UQE_alert_notification_org_id_name` ON `alert_notification`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (198,'Add column secure_settings in alert_notification','alter table `alert_notification` ADD COLUMN `secure_settings` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (199,'alter alert.settings to mediumtext','ALTER TABLE alert MODIFY settings MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (200,'Add non-unique index alert_notification_state_alert_id','CREATE INDEX `IDX_alert_notification_state_alert_id` ON `alert_notification_state` (`alert_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (201,'Add non-unique index alert_rule_tag_alert_id','CREATE INDEX `IDX_alert_rule_tag_alert_id` ON `alert_rule_tag` (`alert_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (202,'Drop old annotation table v4','DROP TABLE IF EXISTS `annotation`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (203,'create annotation table v5','CREATE TABLE IF NOT EXISTS `annotation` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alert_id` BIGINT(20) NULL\n, `user_id` BIGINT(20) NULL\n, `dashboard_id` BIGINT(20) NULL\n, `panel_id` BIGINT(20) NULL\n, `category_id` BIGINT(20) NULL\n, `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `epoch` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (204,'add index annotation 0 v3','CREATE INDEX `IDX_annotation_org_id_alert_id` ON `annotation` (`org_id`,`alert_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (205,'add index annotation 1 v3','CREATE INDEX `IDX_annotation_org_id_type` ON `annotation` (`org_id`,`type`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (206,'add index annotation 2 v3','CREATE INDEX `IDX_annotation_org_id_category_id` ON `annotation` (`org_id`,`category_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (207,'add index annotation 3 v3','CREATE INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation` (`org_id`,`dashboard_id`,`panel_id`,`epoch`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (208,'add index annotation 4 v3','CREATE INDEX `IDX_annotation_org_id_epoch` ON `annotation` (`org_id`,`epoch`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (209,'Update annotation table charset','ALTER TABLE `annotation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `type` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `title` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `metric` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL , MODIFY `prev_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `new_state` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL , MODIFY `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (210,'Add column region_id to annotation table','alter table `annotation` ADD COLUMN `region_id` BIGINT(20) NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (211,'Drop category_id index','DROP INDEX `IDX_annotation_org_id_category_id` ON `annotation`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (212,'Add column tags to annotation table','alter table `annotation` ADD COLUMN `tags` VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (213,'Create annotation_tag table v2','CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (214,'Add unique index annotation_tag.annotation_id_tag_id','CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (215,'drop index UQE_annotation_tag_annotation_id_tag_id - v2','DROP INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (216,'Rename table annotation_tag to annotation_tag_v2 - v2','ALTER TABLE `annotation_tag` RENAME TO `annotation_tag_v2`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (217,'Create annotation_tag table v3','CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `annotation_id` BIGINT(20) NOT NULL\n, `tag_id` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (218,'create index UQE_annotation_tag_annotation_id_tag_id - Add unique index annotation_tag.annotation_id_tag_id V3','CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (219,'copy annotation_tag v2 to v3','INSERT INTO `annotation_tag` (`annotation_id`\n, `tag_id`) SELECT `annotation_id`\n, `tag_id` FROM `annotation_tag_v2`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (220,'drop table annotation_tag_v2','DROP TABLE IF EXISTS `annotation_tag_v2`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (221,'Update alert annotations and set TEXT to empty','UPDATE annotation SET TEXT = \'\' WHERE alert_id > 0',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (222,'Add created time to annotation table','alter table `annotation` ADD COLUMN `created` BIGINT(20) NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (223,'Add updated time to annotation table','alter table `annotation` ADD COLUMN `updated` BIGINT(20) NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (224,'Add index for created in annotation table','CREATE INDEX `IDX_annotation_org_id_created` ON `annotation` (`org_id`,`created`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (225,'Add index for updated in annotation table','CREATE INDEX `IDX_annotation_org_id_updated` ON `annotation` (`org_id`,`updated`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (226,'Convert existing annotations from seconds to milliseconds','UPDATE annotation SET epoch = (epoch*1000) where epoch < 9999999999',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (227,'Add epoch_end column','alter table `annotation` ADD COLUMN `epoch_end` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (228,'Add index for epoch_end','CREATE INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation` (`org_id`,`epoch`,`epoch_end`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (229,'Make epoch_end the same as epoch','UPDATE annotation SET epoch_end = epoch',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (230,'Move region to single row','code migration',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (231,'Remove index org_id_epoch from annotation table','DROP INDEX `IDX_annotation_org_id_epoch` ON `annotation`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (232,'Remove index org_id_dashboard_id_panel_id_epoch from annotation table','DROP INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (233,'Add index for org_id_dashboard_id_epoch_end_epoch on annotation table','CREATE INDEX `IDX_annotation_org_id_dashboard_id_epoch_end_epoch` ON `annotation` (`org_id`,`dashboard_id`,`epoch_end`,`epoch`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (234,'Add index for org_id_epoch_end_epoch on annotation table','CREATE INDEX `IDX_annotation_org_id_epoch_end_epoch` ON `annotation` (`org_id`,`epoch_end`,`epoch`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (235,'Remove index org_id_epoch_epoch_end from annotation table','DROP INDEX `IDX_annotation_org_id_epoch_epoch_end` ON `annotation`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (236,'Add index for alert_id on annotation table','CREATE INDEX `IDX_annotation_alert_id` ON `annotation` (`alert_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (237,'create test_data table','CREATE TABLE IF NOT EXISTS `test_data` (\n`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `metric1` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `metric2` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `value_big_int` BIGINT(20) NULL\n, `value_double` DOUBLE NULL\n, `value_float` FLOAT NULL\n, `value_int` INT NULL\n, `time_epoch` BIGINT(20) NOT NULL\n, `time_date_time` DATETIME NOT NULL\n, `time_time_stamp` TIMESTAMP NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (238,'create dashboard_version table v1','CREATE TABLE IF NOT EXISTS `dashboard_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (239,'add index dashboard_version.dashboard_id','CREATE INDEX `IDX_dashboard_version_dashboard_id` ON `dashboard_version` (`dashboard_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (240,'add unique index dashboard_version.dashboard_id and dashboard_version.version','CREATE UNIQUE INDEX `UQE_dashboard_version_dashboard_id_version` ON `dashboard_version` (`dashboard_id`,`version`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (241,'Set dashboard version to 1 where 0','UPDATE dashboard SET version = 1 WHERE version = 0',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (242,'save existing dashboard data in dashboard_version table v1','INSERT INTO dashboard_version\n(\n	dashboard_id,\n	version,\n	parent_version,\n	restored_from,\n	created,\n	created_by,\n	message,\n	data\n)\nSELECT\n	dashboard.id,\n	dashboard.version,\n	dashboard.version,\n	dashboard.version,\n	dashboard.updated,\n	COALESCE(dashboard.updated_by, -1),\n	\'\',\n	dashboard.data\nFROM dashboard;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (243,'alter dashboard_version.data to mediumtext v1','ALTER TABLE dashboard_version MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (244,'create team table','CREATE TABLE IF NOT EXISTS `team` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (245,'add index team.org_id','CREATE INDEX `IDX_team_org_id` ON `team` (`org_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (246,'add unique index team_org_id_name','CREATE UNIQUE INDEX `UQE_team_org_id_name` ON `team` (`org_id`,`name`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (247,'create team member table','CREATE TABLE IF NOT EXISTS `team_member` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (248,'add index team_member.org_id','CREATE INDEX `IDX_team_member_org_id` ON `team_member` (`org_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (249,'add unique index team_member_org_id_team_id_user_id','CREATE UNIQUE INDEX `UQE_team_member_org_id_team_id_user_id` ON `team_member` (`org_id`,`team_id`,`user_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (250,'add index team_member.team_id','CREATE INDEX `IDX_team_member_team_id` ON `team_member` (`team_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (251,'Add column email to team table','alter table `team` ADD COLUMN `email` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (252,'Add column external to team_member table','alter table `team_member` ADD COLUMN `external` TINYINT(1) NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (253,'Add column permission to team_member table','alter table `team_member` ADD COLUMN `permission` SMALLINT NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (254,'create dashboard acl table','CREATE TABLE IF NOT EXISTS `dashboard_acl` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NULL\n, `team_id` BIGINT(20) NULL\n, `permission` SMALLINT NOT NULL DEFAULT 4\n, `role` VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (255,'add index dashboard_acl_dashboard_id','CREATE INDEX `IDX_dashboard_acl_dashboard_id` ON `dashboard_acl` (`dashboard_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (256,'add unique index dashboard_acl_dashboard_id_user_id','CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_user_id` ON `dashboard_acl` (`dashboard_id`,`user_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (257,'add unique index dashboard_acl_dashboard_id_team_id','CREATE UNIQUE INDEX `UQE_dashboard_acl_dashboard_id_team_id` ON `dashboard_acl` (`dashboard_id`,`team_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (258,'add index dashboard_acl_user_id','CREATE INDEX `IDX_dashboard_acl_user_id` ON `dashboard_acl` (`user_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (259,'add index dashboard_acl_team_id','CREATE INDEX `IDX_dashboard_acl_team_id` ON `dashboard_acl` (`team_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (260,'add index dashboard_acl_org_id_role','CREATE INDEX `IDX_dashboard_acl_org_id_role` ON `dashboard_acl` (`org_id`,`role`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (261,'add index dashboard_permission','CREATE INDEX `IDX_dashboard_acl_permission` ON `dashboard_acl` (`permission`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (262,'save default acl rules in dashboard_acl table','\nINSERT INTO dashboard_acl\n	(\n		org_id,\n		dashboard_id,\n		permission,\n		role,\n		created,\n		updated\n	)\n	VALUES\n		(-1,-1, 1,\'Viewer\',\'2017-06-20\',\'2017-06-20\'),\n		(-1,-1, 2,\'Editor\',\'2017-06-20\',\'2017-06-20\')\n	',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (263,'delete acl rules for deleted dashboards and folders','DELETE FROM dashboard_acl WHERE dashboard_id NOT IN (SELECT id FROM dashboard) AND dashboard_id != -1',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (264,'create tag table','CREATE TABLE IF NOT EXISTS `tag` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `key` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (265,'add index tag.key_value','CREATE UNIQUE INDEX `UQE_tag_key_value` ON `tag` (`key`,`value`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (266,'create login attempt table','CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (267,'add index login_attempt.username','CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (268,'drop index IDX_login_attempt_username - v1','DROP INDEX `IDX_login_attempt_username` ON `login_attempt`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (269,'Rename table login_attempt to login_attempt_tmp_qwerty - v1','ALTER TABLE `login_attempt` RENAME TO `login_attempt_tmp_qwerty`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (270,'create login_attempt v2','CREATE TABLE IF NOT EXISTS `login_attempt` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `username` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `ip_address` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` INT NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (271,'create index IDX_login_attempt_username - v2','CREATE INDEX `IDX_login_attempt_username` ON `login_attempt` (`username`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (272,'copy login_attempt v1 to v2','INSERT INTO `login_attempt` (`id`\n, `username`\n, `ip_address`) SELECT `id`\n, `username`\n, `ip_address` FROM `login_attempt_tmp_qwerty`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (273,'drop login_attempt_tmp_qwerty','DROP TABLE IF EXISTS `login_attempt_tmp_qwerty`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (274,'create user auth table','CREATE TABLE IF NOT EXISTS `user_auth` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_module` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_id` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (275,'create index IDX_user_auth_auth_module_auth_id - v1','CREATE INDEX `IDX_user_auth_auth_module_auth_id` ON `user_auth` (`auth_module`,`auth_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (276,'alter user_auth.auth_id to length 190','ALTER TABLE user_auth MODIFY auth_id VARCHAR(190);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (277,'Add OAuth access token to user_auth','alter table `user_auth` ADD COLUMN `o_auth_access_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (278,'Add OAuth refresh token to user_auth','alter table `user_auth` ADD COLUMN `o_auth_refresh_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (279,'Add OAuth token type to user_auth','alter table `user_auth` ADD COLUMN `o_auth_token_type` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (280,'Add OAuth expiry to user_auth','alter table `user_auth` ADD COLUMN `o_auth_expiry` DATETIME NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (281,'Add index to user_id column in user_auth','CREATE INDEX `IDX_user_auth_user_id` ON `user_auth` (`user_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (282,'Add OAuth ID token to user_auth','alter table `user_auth` ADD COLUMN `o_auth_id_token` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (283,'create server_lock table','CREATE TABLE IF NOT EXISTS `server_lock` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `operation_uid` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `version` BIGINT(20) NOT NULL\n, `last_execution` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (284,'add index server_lock.operation_uid','CREATE UNIQUE INDEX `UQE_server_lock_operation_uid` ON `server_lock` (`operation_uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (285,'create user auth token table','CREATE TABLE IF NOT EXISTS `user_auth_token` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `prev_auth_token` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_agent` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `client_ip` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `auth_token_seen` TINYINT(1) NOT NULL\n, `seen_at` INT NULL\n, `rotated_at` INT NOT NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (286,'add unique index user_auth_token.auth_token','CREATE UNIQUE INDEX `UQE_user_auth_token_auth_token` ON `user_auth_token` (`auth_token`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (287,'add unique index user_auth_token.prev_auth_token','CREATE UNIQUE INDEX `UQE_user_auth_token_prev_auth_token` ON `user_auth_token` (`prev_auth_token`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (288,'add index user_auth_token.user_id','CREATE INDEX `IDX_user_auth_token_user_id` ON `user_auth_token` (`user_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (289,'Add revoked_at to the user auth token','alter table `user_auth_token` ADD COLUMN `revoked_at` INT NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (290,'create cache_data table','CREATE TABLE IF NOT EXISTS `cache_data` (\n`cache_key` VARCHAR(168) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expires` INTEGER(255) NOT NULL\n, `created_at` INTEGER(255) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (291,'add unique index cache_data.cache_key','CREATE UNIQUE INDEX `UQE_cache_data_cache_key` ON `cache_data` (`cache_key`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (292,'create short_url table v1','CREATE TABLE IF NOT EXISTS `short_url` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `path` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `last_seen_at` INT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (293,'add index short_url.org_id-uid','CREATE UNIQUE INDEX `UQE_short_url_org_id_uid` ON `short_url` (`org_id`,`uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (294,'delete alert_definition table','DROP TABLE IF EXISTS `alert_definition`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (295,'recreate alert_definition table','CREATE TABLE IF NOT EXISTS `alert_definition` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (296,'add index in alert_definition on org_id and title columns','CREATE INDEX `IDX_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (297,'add index in alert_definition on org_id and uid columns','CREATE INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (298,'alter alert_definition table data column to mediumtext in mysql','ALTER TABLE alert_definition MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (299,'drop index in alert_definition on org_id and title columns','DROP INDEX `IDX_alert_definition_org_id_title` ON `alert_definition`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (300,'drop index in alert_definition on org_id and uid columns','DROP INDEX `IDX_alert_definition_org_id_uid` ON `alert_definition`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (301,'add unique index in alert_definition on org_id and title columns','CREATE UNIQUE INDEX `UQE_alert_definition_org_id_title` ON `alert_definition` (`org_id`,`title`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (302,'add unique index in alert_definition on org_id and uid columns','CREATE UNIQUE INDEX `UQE_alert_definition_org_id_uid` ON `alert_definition` (`org_id`,`uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (303,'Add column paused in alert_definition','alter table `alert_definition` ADD COLUMN `paused` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (304,'drop alert_definition table','DROP TABLE IF EXISTS `alert_definition`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (305,'delete alert_definition_version table','DROP TABLE IF EXISTS `alert_definition_version`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (306,'recreate alert_definition_version table','CREATE TABLE IF NOT EXISTS `alert_definition_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alert_definition_id` BIGINT(20) NOT NULL\n, `alert_definition_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (307,'add index in alert_definition_version table on alert_definition_id and version columns','CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_id_version` ON `alert_definition_version` (`alert_definition_id`,`version`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (308,'add index in alert_definition_version table on alert_definition_uid and version columns','CREATE UNIQUE INDEX `UQE_alert_definition_version_alert_definition_uid_version` ON `alert_definition_version` (`alert_definition_uid`,`version`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (309,'alter alert_definition_version table data column to mediumtext in mysql','ALTER TABLE alert_definition_version MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (310,'drop alert_definition_version table','DROP TABLE IF EXISTS `alert_definition_version`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (311,'create alert_instance table','CREATE TABLE IF NOT EXISTS `alert_instance` (\n`def_org_id` BIGINT(20) NOT NULL\n, `def_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `labels_hash` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `current_state_since` BIGINT(20) NOT NULL\n, `last_eval_time` BIGINT(20) NOT NULL\n, PRIMARY KEY ( `def_org_id`,`def_uid`,`labels_hash` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (312,'add index in alert_instance table on def_org_id, def_uid and current_state columns','CREATE INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance` (`def_org_id`,`def_uid`,`current_state`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (313,'add index in alert_instance table on def_org_id, current_state columns','CREATE INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance` (`def_org_id`,`current_state`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (314,'add column current_state_end to alert_instance','alter table `alert_instance` ADD COLUMN `current_state_end` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (315,'remove index def_org_id, def_uid, current_state on alert_instance','DROP INDEX `IDX_alert_instance_def_org_id_def_uid_current_state` ON `alert_instance`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (316,'remove index def_org_id, current_state on alert_instance','DROP INDEX `IDX_alert_instance_def_org_id_current_state` ON `alert_instance`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (317,'rename def_org_id to rule_org_id in alert_instance','ALTER TABLE alert_instance CHANGE def_org_id rule_org_id BIGINT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (318,'rename def_uid to rule_uid in alert_instance','ALTER TABLE alert_instance CHANGE def_uid rule_uid VARCHAR(40);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (319,'add index rule_org_id, rule_uid, current_state on alert_instance','CREATE INDEX `IDX_alert_instance_rule_org_id_rule_uid_current_state` ON `alert_instance` (`rule_org_id`,`rule_uid`,`current_state`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (320,'add index rule_org_id, current_state on alert_instance','CREATE INDEX `IDX_alert_instance_rule_org_id_current_state` ON `alert_instance` (`rule_org_id`,`current_state`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (321,'create alert_rule table','CREATE TABLE IF NOT EXISTS `alert_rule` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `updated` DATETIME NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL DEFAULT 60\n, `version` INT NOT NULL DEFAULT 0\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (322,'add index in alert_rule on org_id and title columns','CREATE UNIQUE INDEX `UQE_alert_rule_org_id_title` ON `alert_rule` (`org_id`,`title`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (323,'add index in alert_rule on org_id and uid columns','CREATE UNIQUE INDEX `UQE_alert_rule_org_id_uid` ON `alert_rule` (`org_id`,`uid`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (324,'add index in alert_rule on org_id, namespace_uid, group_uid columns','CREATE INDEX `IDX_alert_rule_org_id_namespace_uid_rule_group` ON `alert_rule` (`org_id`,`namespace_uid`,`rule_group`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (325,'alter alert_rule table data column to mediumtext in mysql','ALTER TABLE alert_rule MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (326,'add column for to alert_rule','alter table `alert_rule` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (327,'add column annotations to alert_rule','alter table `alert_rule` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (328,'add column labels to alert_rule','alter table `alert_rule` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (329,'remove unique index from alert_rule on org_id, title columns','DROP INDEX `UQE_alert_rule_org_id_title` ON `alert_rule`',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (330,'add index in alert_rule on org_id, namespase_uid and title columns','CREATE UNIQUE INDEX `UQE_alert_rule_org_id_namespace_uid_title` ON `alert_rule` (`org_id`,`namespace_uid`,`title`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (331,'add dashboard_uid column to alert_rule','alter table `alert_rule` ADD COLUMN `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (332,'add panel_id column to alert_rule','alter table `alert_rule` ADD COLUMN `panel_id` BIGINT(20) NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (333,'add index in alert_rule on org_id, dashboard_uid and panel_id columns','CREATE INDEX `IDX_alert_rule_org_id_dashboard_uid_panel_id` ON `alert_rule` (`org_id`,`dashboard_uid`,`panel_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (334,'create alert_rule_version table','CREATE TABLE IF NOT EXISTS `alert_rule_version` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `rule_org_id` BIGINT(20) NOT NULL\n, `rule_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0\n, `rule_namespace_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `rule_group` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `parent_version` INT NOT NULL\n, `restored_from` INT NOT NULL\n, `version` INT NOT NULL\n, `created` DATETIME NOT NULL\n, `title` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `condition` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `interval_seconds` BIGINT(20) NOT NULL\n, `no_data_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'NoData\'\n, `exec_err_state` VARCHAR(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Alerting\'\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (335,'add index in alert_rule_version table on rule_org_id, rule_uid and version columns','CREATE UNIQUE INDEX `UQE_alert_rule_version_rule_org_id_rule_uid_version` ON `alert_rule_version` (`rule_org_id`,`rule_uid`,`version`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (336,'add index in alert_rule_version table on rule_org_id, rule_namespace_uid and rule_group columns','CREATE INDEX `IDX_alert_rule_version_rule_org_id_rule_namespace_uid_rule_group` ON `alert_rule_version` (`rule_org_id`,`rule_namespace_uid`,`rule_group`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (337,'alter alert_rule_version table data column to mediumtext in mysql','ALTER TABLE alert_rule_version MODIFY data MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (338,'add column for to alert_rule_version','alter table `alert_rule_version` ADD COLUMN `for` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (339,'add column annotations to alert_rule_version','alter table `alert_rule_version` ADD COLUMN `annotations` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (340,'add column labels to alert_rule_version','alter table `alert_rule_version` ADD COLUMN `labels` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (341,'create_alert_configuration_table','CREATE TABLE IF NOT EXISTS `alert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `alertmanager_configuration` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `configuration_version` VARCHAR(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (342,'Add column default in alert_configuration','alter table `alert_configuration` ADD COLUMN `default` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (343,'alert alert_configuration alertmanager_configuration column from TEXT to MEDIUMTEXT if mysql','ALTER TABLE alert_configuration MODIFY alertmanager_configuration MEDIUMTEXT;',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (344,'add column org_id in alert_configuration','alter table `alert_configuration` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (345,'add index in alert_configuration table on org_id column','CREATE INDEX `IDX_alert_configuration_org_id` ON `alert_configuration` (`org_id`);',1,'','2024-05-10 11:26:26');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (346,'add configuration_hash column to alert_configuration','alter table `alert_configuration` ADD COLUMN `configuration_hash` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'not-yet-calculated\' ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (347,'create_ngalert_configuration_table','CREATE TABLE IF NOT EXISTS `ngalert_configuration` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `alertmanagers` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `created_at` INT NOT NULL\n, `updated_at` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (348,'add index in ngalert_configuration on org_id column','CREATE UNIQUE INDEX `UQE_ngalert_configuration_org_id` ON `ngalert_configuration` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (349,'add column send_alerts_to in ngalert_configuration','alter table `ngalert_configuration` ADD COLUMN `send_alerts_to` SMALLINT NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (350,'create provenance_type table','CREATE TABLE IF NOT EXISTS `provenance_type` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `record_key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `record_type` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provenance` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (351,'add index to uniquify (record_key, record_type, org_id) columns','CREATE UNIQUE INDEX `UQE_provenance_type_record_type_record_key_org_id` ON `provenance_type` (`record_type`,`record_key`,`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (352,'create library_element table v1','CREATE TABLE IF NOT EXISTS `library_element` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `folder_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `type` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `model` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n, `updated` DATETIME NOT NULL\n, `updated_by` BIGINT(20) NOT NULL\n, `version` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (353,'add index library_element org_id-folder_id-name-kind','CREATE UNIQUE INDEX `UQE_library_element_org_id_folder_id_name_kind` ON `library_element` (`org_id`,`folder_id`,`name`,`kind`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (354,'create library_element_connection table v1','CREATE TABLE IF NOT EXISTS `library_element_connection` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `element_id` BIGINT(20) NOT NULL\n, `kind` BIGINT(20) NOT NULL\n, `connection_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (355,'add index library_element_connection element_id-kind-connection_id','CREATE UNIQUE INDEX `UQE_library_element_connection_element_id_kind_connection_id` ON `library_element_connection` (`element_id`,`kind`,`connection_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (356,'add unique index library_element org_id_uid','CREATE UNIQUE INDEX `UQE_library_element_org_id_uid` ON `library_element` (`org_id`,`uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (357,'increase max description length to 2048','ALTER TABLE `library_element` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci, MODIFY `description` VARCHAR(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL ;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (358,'create data_keys table','CREATE TABLE IF NOT EXISTS `data_keys` (\n`name` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci PRIMARY KEY NOT NULL\n, `active` TINYINT(1) NOT NULL\n, `scope` VARCHAR(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `provider` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `encrypted_data` BLOB NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (359,'create kv_store table v1','CREATE TABLE IF NOT EXISTS `kv_store` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `namespace` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` MEDIUMTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (360,'add index kv_store.org_id-namespace-key','CREATE UNIQUE INDEX `UQE_kv_store_org_id_namespace_key` ON `kv_store` (`org_id`,`namespace`,`key`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (361,'create permission table','CREATE TABLE IF NOT EXISTS `permission` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `action` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `scope` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (362,'add unique index permission.role_id','CREATE INDEX `IDX_permission_role_id` ON `permission` (`role_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (363,'add unique index role_id_action_scope','CREATE UNIQUE INDEX `UQE_permission_role_id_action_scope` ON `permission` (`role_id`,`action`,`scope`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (364,'create role table','CREATE TABLE IF NOT EXISTS `role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `version` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (365,'add column display_name','alter table `role` ADD COLUMN `display_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (366,'add column group_name','alter table `role` ADD COLUMN `group_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (367,'add index role.org_id','CREATE INDEX `IDX_role_org_id` ON `role` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (368,'add unique index role_org_id_name','CREATE UNIQUE INDEX `UQE_role_org_id_name` ON `role` (`org_id`,`name`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (369,'add index role_org_id_uid','CREATE UNIQUE INDEX `UQE_role_org_id_uid` ON `role` (`org_id`,`uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (370,'create team role table','CREATE TABLE IF NOT EXISTS `team_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (371,'add index team_role.org_id','CREATE INDEX `IDX_team_role_org_id` ON `team_role` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (372,'add unique index team_role_org_id_team_id_role_id','CREATE UNIQUE INDEX `UQE_team_role_org_id_team_id_role_id` ON `team_role` (`org_id`,`team_id`,`role_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (373,'add index team_role.team_id','CREATE INDEX `IDX_team_role_team_id` ON `team_role` (`team_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (374,'create user role table','CREATE TABLE IF NOT EXISTS `user_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (375,'add index user_role.org_id','CREATE INDEX `IDX_user_role_org_id` ON `user_role` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (376,'add unique index user_role_org_id_user_id_role_id','CREATE UNIQUE INDEX `UQE_user_role_org_id_user_id_role_id` ON `user_role` (`org_id`,`user_id`,`role_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (377,'add index user_role.user_id','CREATE INDEX `IDX_user_role_user_id` ON `user_role` (`user_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (378,'create builtin role table','CREATE TABLE IF NOT EXISTS `builtin_role` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_id` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (379,'add index builtin_role.role_id','CREATE INDEX `IDX_builtin_role_role_id` ON `builtin_role` (`role_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (380,'add index builtin_role.name','CREATE INDEX `IDX_builtin_role_role` ON `builtin_role` (`role`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (381,'Add column org_id to builtin_role table','alter table `builtin_role` ADD COLUMN `org_id` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (382,'add index builtin_role.org_id','CREATE INDEX `IDX_builtin_role_org_id` ON `builtin_role` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (383,'add unique index builtin_role_org_id_role_id_role','CREATE UNIQUE INDEX `UQE_builtin_role_org_id_role_id_role` ON `builtin_role` (`org_id`,`role_id`,`role`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (384,'Remove unique index role_org_id_uid','DROP INDEX `UQE_role_org_id_uid` ON `role`',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (385,'add unique index role.uid','CREATE UNIQUE INDEX `UQE_role_uid` ON `role` (`uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (386,'create seed assignment table','CREATE TABLE IF NOT EXISTS `seed_assignment` (\n`builtin_role` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `role_name` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (387,'add unique index builtin_role_role_name','CREATE UNIQUE INDEX `UQE_seed_assignment_builtin_role_role_name` ON `seed_assignment` (`builtin_role`,`role_name`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (388,'add column hidden to role table','alter table `role` ADD COLUMN `hidden` TINYINT(1) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (389,'create query_history table v1','CREATE TABLE IF NOT EXISTS `query_history` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `datasource_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created_by` INT NOT NULL\n, `created_at` INT NOT NULL\n, `comment` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `queries` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (390,'add index query_history.org_id-created_by-datasource_uid','CREATE INDEX `IDX_query_history_org_id_created_by_datasource_uid` ON `query_history` (`org_id`,`created_by`,`datasource_uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (391,'create query_history_star table v1','CREATE TABLE IF NOT EXISTS `query_history_star` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `query_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `user_id` INT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (392,'add index query_history.user_id-query_uid','CREATE UNIQUE INDEX `UQE_query_history_star_user_id_query_uid` ON `query_history_star` (`user_id`,`query_uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (393,'create data_source_usage_by_day table','CREATE TABLE IF NOT EXISTS `data_source_usage_by_day` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `data_source_id` BIGINT(20) NOT NULL\n, `day` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `queries` BIGINT(20) NOT NULL\n, `errors` BIGINT(20) NOT NULL\n, `load_duration_ms` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (394,'create data_source_usage_by_day(data_source_id) index','CREATE INDEX `IDX_data_source_usage_by_day_data_source_id` ON `data_source_usage_by_day` (`data_source_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (395,'create data_source_usage_by_day(data_source_id, day) unique index','CREATE UNIQUE INDEX `UQE_data_source_usage_by_day_data_source_id_day` ON `data_source_usage_by_day` (`data_source_id`,`day`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (396,'create dashboard_usage_by_day table','CREATE TABLE IF NOT EXISTS `dashboard_usage_by_day` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `day` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `views` BIGINT(20) NOT NULL\n, `queries` BIGINT(20) NOT NULL\n, `errors` BIGINT(20) NOT NULL\n, `load_duration` FLOAT NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (397,'create dashboard_usage_sums table','CREATE TABLE IF NOT EXISTS `dashboard_usage_sums` (\n`dashboard_id` BIGINT(20) PRIMARY KEY NOT NULL\n, `updated` DATETIME NOT NULL\n, `views_last_1_days` BIGINT(20) NOT NULL\n, `views_last_7_days` BIGINT(20) NOT NULL\n, `views_last_30_days` BIGINT(20) NOT NULL\n, `views_total` BIGINT(20) NOT NULL\n, `queries_last_1_days` BIGINT(20) NOT NULL\n, `queries_last_7_days` BIGINT(20) NOT NULL\n, `queries_last_30_days` BIGINT(20) NOT NULL\n, `queries_total` BIGINT(20) NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (398,'create dashboard_usage_by_day(dashboard_id) index','CREATE INDEX `IDX_dashboard_usage_by_day_dashboard_id` ON `dashboard_usage_by_day` (`dashboard_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (399,'create dashboard_usage_by_day(dashboard_id, day) index','CREATE UNIQUE INDEX `UQE_dashboard_usage_by_day_dashboard_id_day` ON `dashboard_usage_by_day` (`dashboard_id`,`day`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (400,'add column errors_last_1_days to dashboard_usage_sums','alter table `dashboard_usage_sums` ADD COLUMN `errors_last_1_days` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (401,'add column errors_last_7_days to dashboard_usage_sums','alter table `dashboard_usage_sums` ADD COLUMN `errors_last_7_days` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (402,'add column errors_last_30_days to dashboard_usage_sums','alter table `dashboard_usage_sums` ADD COLUMN `errors_last_30_days` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (403,'add column errors_total to dashboard_usage_sums','alter table `dashboard_usage_sums` ADD COLUMN `errors_total` BIGINT(20) NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (404,'create user_dashboard_views table','CREATE TABLE IF NOT EXISTS `user_dashboard_views` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `viewed` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (405,'add index user_dashboard_views.user_id','CREATE INDEX `IDX_user_dashboard_views_user_id` ON `user_dashboard_views` (`user_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (406,'add index user_dashboard_views.dashboard_id','CREATE INDEX `IDX_user_dashboard_views_dashboard_id` ON `user_dashboard_views` (`dashboard_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (407,'add unique index user_dashboard_views_user_id_dashboard_id','CREATE UNIQUE INDEX `UQE_user_dashboard_views_user_id_dashboard_id` ON `user_dashboard_views` (`user_id`,`dashboard_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (408,'create user_stats table','CREATE TABLE IF NOT EXISTS `user_stats` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `billing_role` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (409,'add unique index user_stats(user_id)','CREATE UNIQUE INDEX `UQE_user_stats_user_id` ON `user_stats` (`user_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (410,'create data_source_cache table','CREATE TABLE IF NOT EXISTS `data_source_cache` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `data_source_id` BIGINT(20) NOT NULL\n, `enabled` TINYINT(1) NOT NULL\n, `ttl_ms` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (411,'add index data_source_cache.data_source_id','CREATE INDEX `IDX_data_source_cache_data_source_id` ON `data_source_cache` (`data_source_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (412,'add use_default_ttl column','alter table `data_source_cache` ADD COLUMN `use_default_ttl` TINYINT(1) NOT NULL DEFAULT true ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (413,'add data_source_cache.data_source_uid column','alter table `data_source_cache` ADD COLUMN `data_source_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 0 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (414,'remove abandoned data_source_cache records','DELETE FROM data_source_cache WHERE NOT EXISTS (SELECT 1 FROM data_source WHERE id = data_source_cache.data_source_id);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (415,'update data_source_cache.data_source_uid value','UPDATE data_source_cache JOIN data_source ON data_source_cache.data_source_id = data_source.id SET data_source_cache.data_source_uid = data_source.uid;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (416,'add index data_source_cache.data_source_uid','CREATE INDEX `IDX_data_source_cache_data_source_uid` ON `data_source_cache` (`data_source_uid`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (417,'add data_source_cache.ttl_resources_ms column','alter table `data_source_cache` ADD COLUMN `ttl_resources_ms` BIGINT(20) NOT NULL DEFAULT 300000 ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (418,'update data_source_cache.ttl_resources_ms to have the same value as ttl_ms','UPDATE data_source_cache SET ttl_resources_ms = ttl_ms;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (419,'create data_source_acl table','CREATE TABLE IF NOT EXISTS `data_source_acl` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `data_source_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `permission` SMALLINT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (420,'add index data_source_acl.data_source_id','CREATE INDEX `IDX_data_source_acl_data_source_id` ON `data_source_acl` (`data_source_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (421,'add unique index datasource_acl.unique','CREATE UNIQUE INDEX `UQE_data_source_acl_data_source_id_team_id_user_id` ON `data_source_acl` (`data_source_id`,`team_id`,`user_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (422,'create license_token table','CREATE TABLE IF NOT EXISTS `license_token` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `token` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (423,'drop recorded_queries table v14','DROP TABLE IF EXISTS `recorded_queries`',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (424,'drop recording_rules table v14','DROP TABLE IF EXISTS `recording_rules`',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (425,'create recording_rules table v14','CREATE TABLE IF NOT EXISTS `recording_rules` (\n`id` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `target_ref_id` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `name` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `description` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `interval` BIGINT(20) NOT NULL\n, `range` BIGINT(20) NOT NULL\n, `active` TINYINT(1) NOT NULL DEFAULT false\n, `count` TINYINT(1) NOT NULL DEFAULT false\n, `queries` BLOB NOT NULL\n, `created_at` DATETIME NOT NULL\n, PRIMARY KEY ( `id`,`target_ref_id` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (426,'create remote_write_targets table v1','CREATE TABLE IF NOT EXISTS `remote_write_targets` (\n`id` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data_source_uid` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `write_path` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` INT NOT NULL\n, PRIMARY KEY ( `id`,`data_source_uid`,`write_path` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (427,'Add prom_name to recording_rules table','alter table `recording_rules` ADD COLUMN `prom_name` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (428,'ensure remote_write_targets table','CREATE TABLE IF NOT EXISTS `remote_write_targets` (\n`id` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `data_source_uid` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `write_path` VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `org_id` INT NOT NULL\n, PRIMARY KEY ( `id`,`data_source_uid`,`write_path` )) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (429,'create report config table v1','CREATE TABLE IF NOT EXISTS `report` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `dashboard_id` BIGINT(20) NOT NULL\n, `name` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `recipients` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `reply_to` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `message` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `schedule_frequency` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `schedule_day` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `schedule_hour` BIGINT(20) NOT NULL\n, `schedule_minute` BIGINT(20) NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (430,'Add index report.user_id','CREATE INDEX `IDX_report_user_id` ON `report` (`user_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (431,'add index to dashboard_id','CREATE INDEX `IDX_report_dashboard_id` ON `report` (`dashboard_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (432,'add index to org_id','CREATE INDEX `IDX_report_org_id` ON `report` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (433,'Add timezone to the report','alter table `report` ADD COLUMN `schedule_timezone` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT \'Europe/Stockholm\' ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (434,'Add time_from to the report','alter table `report` ADD COLUMN `time_from` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (435,'Add time_to to the report','alter table `report` ADD COLUMN `time_to` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (436,'Add PDF landscape option to the report','alter table `report` ADD COLUMN `pdf_landscape` TINYINT(1) NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (437,'Add monthly day scheduling option to the report','alter table `report` ADD COLUMN `schedule_day_of_month` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (438,'Add PDF layout option to the report','alter table `report` ADD COLUMN `pdf_layout` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (439,'Add PDF orientation option to the report','alter table `report` ADD COLUMN `pdf_orientation` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (440,'Update report pdf_orientation from pdf_landscape','UPDATE report SET pdf_orientation = \'landscape\' WHERE pdf_landscape = 1',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (441,'create report settings table','CREATE TABLE IF NOT EXISTS `report_settings` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `user_id` BIGINT(20) NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `branding_report_logo_url` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `branding_email_logo_url` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `branding_email_footer_link` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `branding_email_footer_text` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n, `branding_email_footer_mode` VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (442,'Add dashboard_uid field to the report','alter table `report` ADD COLUMN `dashboard_uid` VARCHAR(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (443,'Add template_vars field to the report','alter table `report` ADD COLUMN `template_vars` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (444,'Add option to include dashboard url in the report','alter table `report` ADD COLUMN `enable_dashboard_url` TINYINT(1) NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (445,'Add state field to the report','alter table `report` ADD COLUMN `state` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (446,'Add option to add CSV files to the report','alter table `report` ADD COLUMN `enable_csv` TINYINT(1) NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (447,'Add scheduling start date','alter table `report` ADD COLUMN `schedule_start` INT NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (448,'Add missing schedule_start date for old reports','code migration',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (449,'Add scheduling end date','alter table `report` ADD COLUMN `schedule_end` INT NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (450,'Add schedulinng custom interval frequency','alter table `report` ADD COLUMN `schedule_interval_frequency` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (451,'Add scheduling custom interval amount','alter table `report` ADD COLUMN `schedule_interval_amount` BIGINT(20) NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (452,'Add workdays only flag to report','alter table `report` ADD COLUMN `schedule_workdays_only` TINYINT(1) NULL ',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (453,'create team group table','CREATE TABLE IF NOT EXISTS `team_group` (\n`id` BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL\n, `org_id` BIGINT(20) NOT NULL\n, `team_id` BIGINT(20) NOT NULL\n, `group_id` VARCHAR(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (454,'add index team_group.org_id','CREATE INDEX `IDX_team_group_org_id` ON `team_group` (`org_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (455,'add unique index team_group.org_id_team_id_group_id','CREATE UNIQUE INDEX `UQE_team_group_org_id_team_id_group_id` ON `team_group` (`org_id`,`team_id`,`group_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (456,'add index team_group.group_id','CREATE INDEX `IDX_team_group_group_id` ON `team_group` (`group_id`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (457,'create settings table','CREATE TABLE IF NOT EXISTS `setting` (\n`section` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `key` VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n, `value` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL\n) ENGINE=InnoDB DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (458,'add unique index settings.section_key','CREATE UNIQUE INDEX `UQE_setting_section_key` ON `setting` (`section`,`key`);',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (459,'migrate role names','code migration',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (460,'rename orgs roles','code migration',1,'','2024-05-10 11:26:27');
INSERT INTO `migration_log` (`id`, `migration_id`, `sql`, `success`, `error`, `timestamp`) VALUES (461,'remove duplicated org role','code migration',1,'','2024-05-10 11:26:27');
/*!40000 ALTER TABLE `migration_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ngalert_configuration`
--

DROP TABLE IF EXISTS `ngalert_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ngalert_configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `alertmanagers` text COLLATE utf8mb4_unicode_ci,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `send_alerts_to` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_ngalert_configuration_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ngalert_configuration`
--

LOCK TABLES `ngalert_configuration` WRITE;
/*!40000 ALTER TABLE `ngalert_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `ngalert_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org`
--

DROP TABLE IF EXISTS `org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `org` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org`
--

LOCK TABLES `org` WRITE;
/*!40000 ALTER TABLE `org` DISABLE KEYS */;
INSERT INTO `org` (`id`, `version`, `name`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`, `billing_email`, `created`, `updated`) VALUES (1,0,'Main Org.','','','','','','',NULL,'2024-05-10 11:26:27','2024-05-10 11:26:27');
/*!40000 ALTER TABLE `org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org_user`
--

DROP TABLE IF EXISTS `org_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `org_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_org_user_org_id_user_id` (`org_id`,`user_id`),
  KEY `IDX_org_user_org_id` (`org_id`),
  KEY `IDX_org_user_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org_user`
--

LOCK TABLES `org_user` WRITE;
/*!40000 ALTER TABLE `org_user` DISABLE KEYS */;
INSERT INTO `org_user` (`id`, `org_id`, `user_id`, `role`, `created`, `updated`) VALUES (1,1,1,'Admin','2024-05-10 11:26:27','2024-05-10 11:26:27');
/*!40000 ALTER TABLE `org_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NOT NULL,
  `action` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_permission_role_id_action_scope` (`role_id`,`action`,`scope`),
  KEY `IDX_permission_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist_item`
--

DROP TABLE IF EXISTS `playlist_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playlist_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `playlist_id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist_item`
--

LOCK TABLES `playlist_item` WRITE;
/*!40000 ALTER TABLE `playlist_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `playlist_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_setting`
--

DROP TABLE IF EXISTS `plugin_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin_setting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `plugin_id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `pinned` tinyint(1) NOT NULL,
  `json_data` text COLLATE utf8mb4_unicode_ci,
  `secure_json_data` text COLLATE utf8mb4_unicode_ci,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `plugin_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_plugin_setting_org_id_plugin_id` (`org_id`,`plugin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_setting`
--

LOCK TABLES `plugin_setting` WRITE;
/*!40000 ALTER TABLE `plugin_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preferences` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `home_dashboard_id` bigint(20) NOT NULL,
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  `week_start` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `json_data` mediumtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preferences`
--

LOCK TABLES `preferences` WRITE;
/*!40000 ALTER TABLE `preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provenance_type`
--

DROP TABLE IF EXISTS `provenance_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provenance_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `record_key` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_type` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provenance` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_provenance_type_record_type_record_key_org_id` (`record_type`,`record_key`,`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provenance_type`
--

LOCK TABLES `provenance_type` WRITE;
/*!40000 ALTER TABLE `provenance_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `provenance_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_history`
--

DROP TABLE IF EXISTS `query_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `datasource_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queries` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_query_history_org_id_created_by_datasource_uid` (`org_id`,`created_by`,`datasource_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_history`
--

LOCK TABLES `query_history` WRITE;
/*!40000 ALTER TABLE `query_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `query_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_history_star`
--

DROP TABLE IF EXISTS `query_history_star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query_history_star` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `query_uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_query_history_star_user_id_query_uid` (`user_id`,`query_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_history_star`
--

LOCK TABLES `query_history_star` WRITE;
/*!40000 ALTER TABLE `query_history_star` DISABLE KEYS */;
/*!40000 ALTER TABLE `query_history_star` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quota`
--

DROP TABLE IF EXISTS `quota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quota` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `target` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `limit` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_quota_org_id_user_id_target` (`org_id`,`user_id`,`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quota`
--

LOCK TABLES `quota` WRITE;
/*!40000 ALTER TABLE `quota` DISABLE KEYS */;
/*!40000 ALTER TABLE `quota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recording_rules`
--

DROP TABLE IF EXISTS `recording_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recording_rules` (
  `id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_ref_id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `interval` bigint(20) NOT NULL,
  `range` bigint(20) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `count` tinyint(1) NOT NULL DEFAULT '0',
  `queries` blob NOT NULL,
  `created_at` datetime NOT NULL,
  `prom_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`,`target_ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recording_rules`
--

LOCK TABLES `recording_rules` WRITE;
/*!40000 ALTER TABLE `recording_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `recording_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_write_targets`
--

DROP TABLE IF EXISTS `remote_write_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remote_write_targets` (
  `id` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_source_uid` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `write_path` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`data_source_uid`,`write_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_write_targets`
--

LOCK TABLES `remote_write_targets` WRITE;
/*!40000 ALTER TABLE `remote_write_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_write_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipients` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reply_to` text COLLATE utf8mb4_unicode_ci,
  `message` text COLLATE utf8mb4_unicode_ci,
  `schedule_frequency` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule_day` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule_hour` bigint(20) NOT NULL,
  `schedule_minute` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `schedule_timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Europe/Stockholm',
  `time_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_landscape` tinyint(1) DEFAULT NULL,
  `schedule_day_of_month` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pdf_orientation` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboard_uid` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_vars` text COLLATE utf8mb4_unicode_ci,
  `enable_dashboard_url` tinyint(1) DEFAULT NULL,
  `state` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_csv` tinyint(1) DEFAULT NULL,
  `schedule_start` int(11) DEFAULT NULL,
  `schedule_end` int(11) DEFAULT NULL,
  `schedule_interval_frequency` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_interval_amount` bigint(20) DEFAULT NULL,
  `schedule_workdays_only` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_report_user_id` (`user_id`),
  KEY `IDX_report_dashboard_id` (`dashboard_id`),
  KEY `IDX_report_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report`
--

LOCK TABLES `report` WRITE;
/*!40000 ALTER TABLE `report` DISABLE KEYS */;
/*!40000 ALTER TABLE `report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_settings`
--

DROP TABLE IF EXISTS `report_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `branding_report_logo_url` text COLLATE utf8mb4_unicode_ci,
  `branding_email_logo_url` text COLLATE utf8mb4_unicode_ci,
  `branding_email_footer_link` text COLLATE utf8mb4_unicode_ci,
  `branding_email_footer_text` text COLLATE utf8mb4_unicode_ci,
  `branding_email_footer_mode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_settings`
--

LOCK TABLES `report_settings` WRITE;
/*!40000 ALTER TABLE `report_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `version` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `display_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_role_org_id_name` (`org_id`,`name`),
  UNIQUE KEY `UQE_role_uid` (`uid`),
  KEY `IDX_role_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seed_assignment`
--

DROP TABLE IF EXISTS `seed_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seed_assignment` (
  `builtin_role` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_seed_assignment_builtin_role_role_name` (`builtin_role`,`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seed_assignment`
--

LOCK TABLES `seed_assignment` WRITE;
/*!40000 ALTER TABLE `seed_assignment` DISABLE KEYS */;
/*!40000 ALTER TABLE `seed_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_lock`
--

DROP TABLE IF EXISTS `server_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `server_lock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operation_uid` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` bigint(20) NOT NULL,
  `last_execution` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_server_lock_operation_uid` (`operation_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_lock`
--

LOCK TABLES `server_lock` WRITE;
/*!40000 ALTER TABLE `server_lock` DISABLE KEYS */;
INSERT INTO `server_lock` (`id`, `operation_uid`, `version`, `last_execution`) VALUES (1,'metaanalytics-daily-rollup',1,1715311587);
INSERT INTO `server_lock` (`id`, `operation_uid`, `version`, `last_execution`) VALUES (2,'delete old login attempts',8,1715316387);
/*!40000 ALTER TABLE `server_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `key` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` blob NOT NULL,
  `expiry` int(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `section` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  UNIQUE KEY `UQE_setting_section_key` (`section`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `short_url`
--

DROP TABLE IF EXISTS `short_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `short_url` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `uid` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `last_seen_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_short_url_org_id_uid` (`org_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `short_url`
--

LOCK TABLES `short_url` WRITE;
/*!40000 ALTER TABLE `short_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `short_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `star`
--

DROP TABLE IF EXISTS `star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `star` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_star_user_id_dashboard_id` (`user_id`,`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `star`
--

LOCK TABLES `star` WRITE;
/*!40000 ALTER TABLE `star` DISABLE KEYS */;
/*!40000 ALTER TABLE `star` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_tag_key_value` (`key`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_org_id_name` (`org_id`,`name`),
  KEY `IDX_team_org_id` (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_group`
--

DROP TABLE IF EXISTS `team_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `group_id` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_group_org_id_team_id_group_id` (`org_id`,`team_id`,`group_id`),
  KEY `IDX_team_group_org_id` (`org_id`),
  KEY `IDX_team_group_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_group`
--

LOCK TABLES `team_group` WRITE;
/*!40000 ALTER TABLE `team_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_member`
--

DROP TABLE IF EXISTS `team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `permission` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_member_org_id_team_id_user_id` (`org_id`,`team_id`,`user_id`),
  KEY `IDX_team_member_org_id` (`org_id`),
  KEY `IDX_team_member_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_member`
--

LOCK TABLES `team_member` WRITE;
/*!40000 ALTER TABLE `team_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_role`
--

DROP TABLE IF EXISTS `team_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `team_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_team_role_org_id_team_id_role_id` (`org_id`,`team_id`,`role_id`),
  KEY `IDX_team_role_org_id` (`org_id`),
  KEY `IDX_team_role_team_id` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_role`
--

LOCK TABLES `team_role` WRITE;
/*!40000 ALTER TABLE `team_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_user`
--

DROP TABLE IF EXISTS `temp_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invited_by_user_id` bigint(20) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL,
  `email_sent_on` datetime DEFAULT NULL,
  `remote_addr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_temp_user_email` (`email`),
  KEY `IDX_temp_user_org_id` (`org_id`),
  KEY `IDX_temp_user_code` (`code`),
  KEY `IDX_temp_user_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_user`
--

LOCK TABLES `temp_user` WRITE;
/*!40000 ALTER TABLE `temp_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_data`
--

DROP TABLE IF EXISTS `test_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `metric1` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metric2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_big_int` bigint(20) DEFAULT NULL,
  `value_double` double DEFAULT NULL,
  `value_float` float DEFAULT NULL,
  `value_int` int(11) DEFAULT NULL,
  `time_epoch` bigint(20) NOT NULL,
  `time_date_time` datetime NOT NULL,
  `time_time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_data`
--

LOCK TABLES `test_data` WRITE;
/*!40000 ALTER TABLE `test_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `login` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salt` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rands` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `org_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `theme` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `help_flags1` bigint(20) NOT NULL DEFAULT '0',
  `last_seen_at` datetime DEFAULT NULL,
  `is_disabled` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_login` (`login`),
  UNIQUE KEY `UQE_user_email` (`email`),
  KEY `IDX_user_login_email` (`login`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `version`, `login`, `email`, `name`, `password`, `salt`, `rands`, `company`, `org_id`, `is_admin`, `email_verified`, `theme`, `created`, `updated`, `help_flags1`, `last_seen_at`, `is_disabled`, `is_service_account`) VALUES (1,0,'admin','admin@localhost','','47dcca0d4e1455f6d3e27df7b6a80334bd9bde6117dd735d34d7f7bc5c982a6a07bcdc96501142a9083c592f498622b00872','gz8zLwODUQ','39MuRmfHZK','',1,1,0,'','2024-05-10 11:26:27','2024-05-10 11:26:27',0,'2024-05-10 12:43:39',0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_auth` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `auth_module` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_id` varchar(190) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `o_auth_access_token` text COLLATE utf8mb4_unicode_ci,
  `o_auth_refresh_token` text COLLATE utf8mb4_unicode_ci,
  `o_auth_token_type` text COLLATE utf8mb4_unicode_ci,
  `o_auth_expiry` datetime DEFAULT NULL,
  `o_auth_id_token` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_user_auth_auth_module_auth_id` (`auth_module`,`auth_id`),
  KEY `IDX_user_auth_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

LOCK TABLES `user_auth` WRITE;
/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_auth_token`
--

DROP TABLE IF EXISTS `user_auth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_auth_token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `auth_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prev_auth_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth_token_seen` tinyint(1) NOT NULL,
  `seen_at` int(11) DEFAULT NULL,
  `rotated_at` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `revoked_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_auth_token_auth_token` (`auth_token`),
  UNIQUE KEY `UQE_user_auth_token_prev_auth_token` (`prev_auth_token`),
  KEY `IDX_user_auth_token_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth_token`
--

LOCK TABLES `user_auth_token` WRITE;
/*!40000 ALTER TABLE `user_auth_token` DISABLE KEYS */;
INSERT INTO `user_auth_token` (`id`, `user_id`, `auth_token`, `prev_auth_token`, `user_agent`, `client_ip`, `auth_token_seen`, `seen_at`, `rotated_at`, `created_at`, `updated_at`, `revoked_at`) VALUES (1,1,'55c8f3fb7a251f7ce8c89faeecdb8dcb993fa65f2394d2694d628bfe14f695d6','8cb058e7766d6d78e12a4733c14ebfdf2814cf4d141522d2ba6deb6c1bceb831','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0','10.10.52.13',1,1715315911,1715315847,1715311639,1715311639,0);
/*!40000 ALTER TABLE `user_auth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dashboard_views`
--

DROP TABLE IF EXISTS `user_dashboard_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_dashboard_views` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `dashboard_id` bigint(20) NOT NULL,
  `viewed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_dashboard_views_user_id_dashboard_id` (`user_id`,`dashboard_id`),
  KEY `IDX_user_dashboard_views_user_id` (`user_id`),
  KEY `IDX_user_dashboard_views_dashboard_id` (`dashboard_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dashboard_views`
--

LOCK TABLES `user_dashboard_views` WRITE;
/*!40000 ALTER TABLE `user_dashboard_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_dashboard_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_role_org_id_user_id_role_id` (`org_id`,`user_id`,`role_id`),
  KEY `IDX_user_role_org_id` (`org_id`),
  KEY `IDX_user_role_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_stats`
--

DROP TABLE IF EXISTS `user_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_stats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `billing_role` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_user_stats_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_stats`
--

LOCK TABLES `user_stats` WRITE;
/*!40000 ALTER TABLE `user_stats` DISABLE KEYS */;
INSERT INTO `user_stats` (`id`, `user_id`, `billing_role`, `created`, `updated`) VALUES (1,1,'server_admin','2024-05-10 03:27:20','2024-05-10 03:27:20');
/*!40000 ALTER TABLE `user_stats` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-10 12:47:32
