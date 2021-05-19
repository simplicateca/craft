-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: project
-- ------------------------------------------------------
-- Server version	10.5.10-MariaDB-1:10.5.10+maria~focal

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `error` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransforms_name_idx` (`name`),
  KEY `assettransforms_handle_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_summary` text DEFAULT NULL,
  `field_emergencyMessageText` text DEFAULT NULL,
  `field_emergencyMessageUrl` varchar(255) DEFAULT NULL,
  `field_seo` text DEFAULT NULL,
  `field_emergencyMessagePlacement` varchar(255) DEFAULT NULL,
  `field_emergencyMessageLink` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  KEY `idx_dwkppiyhximvvuajiebdhagzfnpbmahvypao` (`saved`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xxoijryybwivcameqecpjrmpemcbmvkimiub` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text DEFAULT NULL,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldgroups_name_idx` (`name`),
  KEY `idx_kqzaeepteqvixictdyjxvonkauuboxdbqboj` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  KEY `fields_handle_context_idx` (`handle`,`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_contentblocks`
--

DROP TABLE IF EXISTS `matrixcontent_contentblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_textImage_text_old` text DEFAULT NULL,
  `field_textImage_headline_old` text DEFAULT NULL,
  `field_textImage_headlineStyle_old` varchar(255) DEFAULT NULL,
  `field_textImage_layout_old` varchar(255) DEFAULT NULL,
  `field_textImage_background_old` varchar(255) DEFAULT NULL,
  `field_textImage_buttons_old` text DEFAULT NULL,
  `field_textImage_spacing_old` varchar(255) DEFAULT NULL,
  `field_text_text_old` text DEFAULT NULL,
  `field_text_layout_old` varchar(255) DEFAULT NULL,
  `field_text_background_old` varchar(255) DEFAULT NULL,
  `field_text_buttons_old` text DEFAULT NULL,
  `field_text_headline_old` text DEFAULT NULL,
  `field_text_headlineStyle_old` varchar(255) DEFAULT NULL,
  `field_text_spacing_old` varchar(255) DEFAULT NULL,
  `field_textImage_text_old2` text DEFAULT NULL,
  `field_textImage_headline_old2` text DEFAULT NULL,
  `field_textImage_headlineStyle_old2` varchar(255) DEFAULT NULL,
  `field_textImage_layout_old2` varchar(255) DEFAULT NULL,
  `field_textImage_background_old2` varchar(255) DEFAULT NULL,
  `field_textImage_buttons_old2` text DEFAULT NULL,
  `field_textImage_spacing_old2` varchar(255) DEFAULT NULL,
  `field_text_text_old2` text DEFAULT NULL,
  `field_text_layout_old2` varchar(255) DEFAULT NULL,
  `field_text_background_old2` varchar(255) DEFAULT NULL,
  `field_text_buttons_old2` text DEFAULT NULL,
  `field_text_headline_old2` text DEFAULT NULL,
  `field_text_headlineStyle_old2` varchar(255) DEFAULT NULL,
  `field_text_spacing_old2` varchar(255) DEFAULT NULL,
  `field_text_layout` varchar(255) DEFAULT NULL,
  `field_text_text` text DEFAULT NULL,
  `field_text_background` varchar(255) DEFAULT NULL,
  `field_text_buttons` text DEFAULT NULL,
  `field_text_headline` text DEFAULT NULL,
  `field_text_headlineStyle` varchar(255) DEFAULT NULL,
  `field_text_spacing` varchar(255) DEFAULT NULL,
  `field_textImage_text` text DEFAULT NULL,
  `field_textImage_headline` text DEFAULT NULL,
  `field_textImage_headlineStyle` varchar(255) DEFAULT NULL,
  `field_textImage_layout` varchar(255) DEFAULT NULL,
  `field_textImage_background` varchar(255) DEFAULT NULL,
  `field_textImage_buttons` text DEFAULT NULL,
  `field_textImage_spacing` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixcontent_contentblocks_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `matrixcontent_contentblocks_siteId_fk` (`siteId`),
  CONSTRAINT `matrixcontent_contentblocks_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixcontent_contentblocks_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `migrations_track_name_unq_idx` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_navs`
--

DROP TABLE IF EXISTS `navigation_navs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_navs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `instructions` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `propagateNodes` tinyint(1) DEFAULT 0,
  `maxNodes` int(11) DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `siteSettings` text DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `navigation_navs_handle_idx` (`handle`),
  KEY `navigation_navs_structureId_idx` (`structureId`),
  KEY `navigation_navs_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `navigation_navs_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `navigation_navs_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `navigation_navs_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_nodes`
--

DROP TABLE IF EXISTS `navigation_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_nodes` (
  `id` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `navId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `urlSuffix` varchar(255) DEFAULT NULL,
  `customAttributes` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `newWindow` tinyint(1) DEFAULT 0,
  `deletedWithNav` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `navigation_nodes_navId_idx` (`navId`),
  KEY `navigation_nodes_elementId_fk` (`elementId`),
  CONSTRAINT `navigation_nodes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `navigation_nodes_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `navigation_nodes_navId_fk` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectconfignames`
--

DROP TABLE IF EXISTS `projectconfignames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfignames` (
  `uid` char(36) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reasons`
--

DROP TABLE IF EXISTS `reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) NOT NULL,
  `conditionals` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `reasons_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `reasons_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_redirects`
--

DROP TABLE IF EXISTS `retour_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_redirects_siteId_idx` (`siteId`),
  KEY `retour_redirects_associatedElementId_fk` (`associatedElementId`),
  CONSTRAINT `retour_redirects_associatedElementId_fk` FOREIGN KEY (`associatedElementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_static_redirects`
--

DROP TABLE IF EXISTS `retour_static_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_static_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `associatedElementId` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `redirectSrcUrlParsed` varchar(255) DEFAULT '',
  `redirectSrcMatch` varchar(32) DEFAULT 'pathonly',
  `redirectMatchType` varchar(32) DEFAULT 'exactmatch',
  `redirectDestUrl` varchar(255) DEFAULT '',
  `redirectHttpCode` int(11) DEFAULT 301,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `retour_static_redirects_redirectSrcUrlParsed_idx` (`redirectSrcUrlParsed`),
  KEY `retour_static_redirects_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_static_redirects_siteId_idx` (`siteId`),
  CONSTRAINT `retour_static_redirects_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `retour_stats`
--

DROP TABLE IF EXISTS `retour_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `retour_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int(11) DEFAULT NULL,
  `redirectSrcUrl` varchar(255) DEFAULT '',
  `referrerUrl` varchar(2000) DEFAULT '',
  `remoteIp` varchar(45) DEFAULT '',
  `userAgent` varchar(255) DEFAULT '',
  `exceptionMessage` varchar(255) DEFAULT '',
  `exceptionFilePath` varchar(255) DEFAULT '',
  `exceptionFileLine` int(11) DEFAULT 0,
  `hitCount` int(11) DEFAULT 1,
  `hitLastTime` datetime DEFAULT NULL,
  `handledByRetour` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `retour_stats_redirectSrcUrl_idx` (`redirectSrcUrl`),
  KEY `retour_stats_siteId_idx` (`siteId`),
  CONSTRAINT `retour_stats_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int(11) DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int(11) DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int(11) DEFAULT NULL,
  `sourceAltSiteSettings` text DEFAULT NULL,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text DEFAULT NULL,
  `metaSiteVars` text DEFAULT NULL,
  `metaSitemapVars` text DEFAULT NULL,
  `metaContainers` text DEFAULT NULL,
  `redirectsContainer` text DEFAULT NULL,
  `frontendTemplatesContainer` text DEFAULT NULL,
  `metaBundleSettings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `usergroups_handle_idx` (`handle`),
  KEY `usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_data_samples`
--

DROP TABLE IF EXISTS `webperf_data_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webperf_data_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `dns` int(11) DEFAULT NULL,
  `connect` int(11) DEFAULT NULL,
  `firstByte` int(11) DEFAULT NULL,
  `firstPaint` int(11) DEFAULT NULL,
  `firstContentfulPaint` int(11) DEFAULT NULL,
  `domInteractive` int(11) DEFAULT NULL,
  `pageLoad` int(11) DEFAULT NULL,
  `countryCode` varchar(2) DEFAULT NULL,
  `device` varchar(50) DEFAULT NULL,
  `browser` varchar(50) DEFAULT NULL,
  `os` varchar(50) DEFAULT NULL,
  `mobile` tinyint(1) DEFAULT NULL,
  `craftTotalMs` int(11) DEFAULT NULL,
  `craftDbMs` int(11) DEFAULT NULL,
  `craftDbCnt` int(11) DEFAULT NULL,
  `craftTwigMs` int(11) DEFAULT NULL,
  `craftTwigCnt` int(11) DEFAULT NULL,
  `craftOtherMs` int(11) DEFAULT NULL,
  `craftOtherCnt` int(11) DEFAULT NULL,
  `craftTotalMemory` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_data_samples_url_idx` (`url`),
  KEY `webperf_data_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_data_samples_requestId_idx` (`requestId`),
  KEY `webperf_data_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_data_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webperf_error_samples`
--

DROP TABLE IF EXISTS `webperf_error_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webperf_error_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `requestId` bigint(20) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `title` varchar(120) DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `queryString` varchar(255) DEFAULT '',
  `type` varchar(16) DEFAULT '',
  `pageErrors` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webperf_error_samples_url_idx` (`url`),
  KEY `webperf_error_samples_dateCreated_idx` (`dateCreated`),
  KEY `webperf_error_samples_requestId_idx` (`requestId`),
  KEY `webperf_error_samples_siteId_fk` (`siteId`),
  CONSTRAINT `webperf_error_samples_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-19  4:31:31
-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Linux (x86_64)
--
-- Host: mariadb    Database: project
-- ------------------------------------------------------
-- Server version	10.5.10-MariaDB-1:10.5.10+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups` VALUES (1,1,3,'Topics','topics','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'28948fc8-a354-4c75-a861-b11dda3c6929');
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `categorygroups_sites` VALUES (1,1,2,1,'topics/{slug}','pages/topic','2021-05-18 19:10:51','2021-05-18 19:10:51','99cb78e3-1bc8-470a-8be0-9cc9c6de16a0');
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,2,NULL,'2020-03-27 13:22:43','2020-03-27 13:22:43','b77b0362-fbf0-45dd-a5d7-e1b0c971eb48',NULL,NULL,NULL,NULL,NULL,NULL),(2,2,1,'Homepage','2020-03-27 13:38:49','2020-10-16 15:16:16','7fa40164-962a-4e1b-804a-245447006340',NULL,NULL,NULL,NULL,NULL,NULL),(3,3,2,'Home','2021-05-18 19:10:51','2021-05-18 19:10:51','1c6eaa8f-5ec9-4b40-91b9-705dfe1c7481',NULL,NULL,NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-05-18T15:10:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"\",\"sitemapPriority\":\"\",\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL),(4,4,2,'Home','2021-05-18 19:10:51','2021-05-18 19:10:51','1e66b826-7506-4c5c-b041-8e934e19ba45',NULL,NULL,NULL,'{\"bundleVersion\":\"1.0.22\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2021-05-18T15:10:51-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\"},\"metaSiteVars\":{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"\",\"sitemapPriority\":\"\",\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL),(5,5,2,'Emergency Message','2021-05-18 19:10:51','2021-05-18 19:10:51','05a41a36-1e38-4ed3-8751-f42726fb9fbb',NULL,NULL,NULL,NULL,'allPages',NULL),(6,6,2,'Emergency Message','2021-05-18 19:10:51','2021-05-18 19:10:51','8472e81c-b5a4-44b7-bbbf-3be81230c820',NULL,NULL,NULL,NULL,'allPages',NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-03-27 13:22:43','2020-03-27 13:22:43',NULL,'9c39b369-6229-4753-83e1-afd4da7acf29'),(2,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-03-27 13:38:49','2020-10-16 15:16:16','2021-05-18 19:10:50','7526d70b-8b45-4af6-b5b8-c56c6a44e34c'),(3,NULL,NULL,6,'craft\\elements\\Entry',1,0,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'fd5a3a9f-fd09-4e58-8622-7681cd38eb3b'),(4,NULL,1,6,'craft\\elements\\Entry',1,0,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'248d6325-dc54-49b1-81ff-e2e1dea2b8e2'),(5,NULL,NULL,7,'craft\\elements\\Entry',1,0,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'59931736-5871-472d-9535-966cc19845ee'),(6,NULL,2,7,'craft\\elements\\Entry',1,0,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'0640bba4-829f-4d6d-bcf5-748a5698004a');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,2,NULL,NULL,1,'2020-03-27 13:22:43','2020-03-27 13:22:43','b03adee1-4d8e-41c3-bcab-890c732ef44d'),(2,2,1,'homepage','__home__',1,'2020-03-27 13:38:49','2020-03-27 13:38:49','40928c54-598c-421b-9a79-3605cfbbcc8b'),(3,3,2,'home','__home__',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','69148d12-fb4f-400e-b16d-a7ab358b872d'),(4,4,2,'home','__home__',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','11118e6b-456f-44c4-a1c7-2e20ac075c4a'),(5,5,2,'emergency-message',NULL,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','83cd7fe0-6c6f-431e-b4d1-b640e60cce15'),(6,6,2,'emergency-message',NULL,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','ca433aeb-97bf-4c60-be6b-1dd52b90a0ba');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (2,5,NULL,2,NULL,'2020-03-27 13:38:00',NULL,0,'2020-03-27 13:38:49','2020-03-27 13:38:49','478eec4c-16e8-46f1-8ad5-4d4d00f7ece1'),(3,7,NULL,5,NULL,'2021-05-18 19:10:00',NULL,NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51','21d90343-8d4d-458d-ba76-252213fa4e4a'),(4,7,NULL,5,NULL,'2021-05-18 19:10:00',NULL,NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51','f01cb98c-4b76-4dda-8b1d-f0b8aa4681bf'),(5,8,NULL,6,NULL,'2021-05-18 19:10:00',NULL,NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51','2a630d40-7fa9-4f3d-b4ee-29c981aa02c8'),(6,8,NULL,6,NULL,'2021-05-18 19:10:00',NULL,NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51','f32eb745-13e6-4189-a558-3a9fd5b8e0cd');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,4,NULL,'Errors','errors',1,'',NULL,NULL,1,'2020-03-27 13:38:49','2020-10-16 15:16:16','2021-05-18 19:10:51','faceb3ed-6771-453c-9c2a-aa330847f6db'),(2,5,NULL,'Homepage','homepage',0,'',NULL,'{section.name|raw}',1,'2020-03-27 13:38:49','2020-10-16 15:16:16','2021-05-18 19:10:51','fb3a8f31-d1cc-4c13-903b-a501f7e51f54'),(3,9,4,'News','news',1,'site',NULL,NULL,1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'d3282cfb-d044-4890-b553-9a0b87393027'),(4,6,5,'Pages','page',1,'site',NULL,NULL,1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'e0521335-ccc2-4893-a505-4baacf112dee'),(5,7,6,'Home','home',0,'site',NULL,'{section.name|raw}',1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'b51219b5-c15b-4ce1-ab72-ad00a1b7a25e'),(6,8,7,'Emergency Message','emergencyMessage',0,'site',NULL,'{section.name|raw}',1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'fb1d50db-864b-4553-9fb0-d1d784dd98d9'),(7,6,8,'Topics Index','topicsIndex',1,'site',NULL,NULL,3,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'d25e2e5d-90aa-4551-bbb2-2ef3300099d1'),(8,6,9,'News Index','newsIndex',1,'site',NULL,NULL,2,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'0adda131-0527-467d-8935-110db8ed3aad');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-03-27 13:22:43','2020-03-27 13:22:43','2021-05-18 19:10:51','94b4d5ac-d7ea-4241-a6cb-92b39f482f99'),(2,'Errors','2020-03-27 13:30:08','2020-03-27 13:30:08','2021-05-18 19:10:51','d08a0d16-0e00-49e6-9cd4-465fa2d65d7d'),(3,'Emergency Message','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'1e0f22f0-2c77-45f2-a8dd-9405520e5ce0'),(4,'Common','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'e0dac603-c510-4bb5-8701-e25672d93744');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (2,3,4,5,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','703303d0-83e9-4787-a1aa-b6b863e901f8'),(3,4,5,5,1,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','7acde63a-5cc0-4599-bbbd-c850fd493eea'),(4,4,5,4,0,2,'2021-05-18 19:10:51','2021-05-18 19:10:51','7873074e-04d8-4423-bf66-753725c33322'),(5,4,5,10,0,3,'2021-05-18 19:10:51','2021-05-18 19:10:51','49b868a6-f857-4202-8f97-b4780a9b5707'),(6,4,6,8,0,0,'2021-05-18 19:10:51','2021-05-18 19:10:51','2c68f5b3-1399-4c2a-bce6-51b2d5d46cb2'),(7,5,8,4,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','d79be116-9d02-4b39-b144-9d6b84c13df9'),(8,5,9,8,0,0,'2021-05-18 19:10:51','2021-05-18 19:10:51','86bb59c4-4391-46a2-aa63-51d4ef8fd250'),(9,6,10,4,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','e9468943-284e-4c81-b1d2-9a13d5e4e8ab'),(10,6,11,8,0,0,'2021-05-18 19:10:51','2021-05-18 19:10:51','3bad3224-8c34-42a2-a182-f5d5f109c8ed'),(11,7,12,6,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','6d7b51e5-a7d1-45cc-ad3e-e1702dcd88e2'),(12,7,12,11,0,2,'2021-05-18 19:10:51','2021-05-18 19:10:51','c7633ddf-03df-4b7a-ba42-26fc73952bab'),(13,7,12,7,0,3,'2021-05-18 19:10:51','2021-05-18 19:10:51','1fccdde8-c375-4987-8944-3a5653eeca7f'),(14,7,12,9,0,4,'2021-05-18 19:10:51','2021-05-18 19:10:51','f8f9dcbe-d6eb-4983-95a7-bd1c2c8f14b1'),(15,8,13,4,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','3951cca9-d80a-4689-a249-df5ae5387cc5'),(16,8,14,8,0,0,'2021-05-18 19:10:51','2021-05-18 19:10:51','a4d18920-e81c-4b8b-bb50-c8dfec771999'),(17,9,15,4,0,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','90b26ba7-953c-430a-aef2-fa20ab11b6a2'),(18,9,16,8,0,0,'2021-05-18 19:10:51','2021-05-18 19:10:51','ee9cc413-7f5c-45d0-9218-3c7eb262beef'),(34,11,20,20,0,0,'2021-05-18 19:10:52','2021-05-18 19:10:52','54731656-702c-41eb-a3cc-6eadcc528096'),(35,11,20,21,0,1,'2021-05-18 19:10:52','2021-05-18 19:10:52','719e5f44-ddde-4cfa-b6dc-95ef30c2b907'),(36,11,20,19,0,2,'2021-05-18 19:10:52','2021-05-18 19:10:52','b6fcb419-4832-4d74-a345-b24d63faecb9'),(37,11,20,25,1,3,'2021-05-18 19:10:52','2021-05-18 19:10:52','496cd376-74d8-4621-a3b0-72e907de34d6'),(38,11,20,24,0,4,'2021-05-18 19:10:52','2021-05-18 19:10:52','dd2ab6b0-d4d5-4923-9779-539d20b87956'),(39,11,20,22,0,5,'2021-05-18 19:10:52','2021-05-18 19:10:52','16034cb0-c47f-4e50-af50-660ce37e6f2f'),(40,11,20,26,0,6,'2021-05-18 19:10:52','2021-05-18 19:10:52','c0d800f7-8eca-4464-95af-c8dad43706a3'),(41,11,20,23,0,7,'2021-05-18 19:10:52','2021-05-18 19:10:52','a5cac01a-b14b-4b6f-8064-e17708e4d0bf'),(42,10,21,16,0,0,'2021-05-18 19:10:52','2021-05-18 19:10:52','c3f558e3-02e7-4115-aeb1-059565917c95'),(43,10,21,17,0,1,'2021-05-18 19:10:52','2021-05-18 19:10:52','5bf4fc7e-77b1-499f-bfc8-71296832ad7c'),(44,10,21,13,0,2,'2021-05-18 19:10:52','2021-05-18 19:10:52','bf00f2e4-68c1-4b2c-8f6e-67b8d197056c'),(45,10,21,15,0,3,'2021-05-18 19:10:52','2021-05-18 19:10:52','1464d554-6688-4db0-9da7-30107f2415a2'),(46,10,21,12,0,4,'2021-05-18 19:10:52','2021-05-18 19:10:52','e7ccab7e-f816-4a11-8134-b43070149d86'),(47,10,21,18,0,5,'2021-05-18 19:10:52','2021-05-18 19:10:52','43f97bca-6acc-469c-80fe-d3acf5986d05'),(48,10,21,14,0,6,'2021-05-18 19:10:52','2021-05-18 19:10:52','2e7968ef-4f8d-4b6c-8a01-163e0e5ec367');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Asset','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'f7245cee-41f8-4db2-8e8c-97be66059bcd'),(2,'craft\\elements\\Asset','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'155d9590-a8a9-44a0-b379-c089f17b9c37'),(3,'craft\\elements\\Category','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'4d1bca6d-66f6-47d1-ae49-cd32793634e2'),(4,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'428ba83c-5ca7-4751-9529-c3d5c77739fc'),(5,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'0e6296a2-ebef-4158-ba3d-e196af38899e'),(6,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'519dbeb4-c6da-4d96-812b-ef982ec0d2fd'),(7,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'44a33a2f-7625-459e-aed6-bd555138cbec'),(8,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'89885d4f-8b0f-4133-b6a0-1632b3f78fa0'),(9,'craft\\elements\\Entry','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'b0caa612-277a-4220-8f06-afd248e6840b'),(10,'craft\\elements\\MatrixBlock','2021-05-18 19:10:52','2021-05-18 19:10:52',NULL,'030b6d0b-c5dc-459c-b3e0-6e508313ca31'),(11,'craft\\elements\\MatrixBlock','2021-05-18 19:10:52','2021-05-18 19:10:52',NULL,'a067cac1-ec42-43cc-b56a-f98e3b5b7803');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (4,3,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','8211125b-ea9e-4303-b4dc-c3c3c6e18684'),(5,4,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"1\",\"width\":100,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"7e15e458-b87d-4706-988c-83f1ba50204c\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','7bfded55-7fbd-4207-9995-4e8a9609161c'),(6,4,'SEO','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"\",\"width\":100,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2021-05-18 19:10:51','2021-05-18 19:10:51','5fb4131c-c97a-4d33-9943-1026c6061d5f'),(7,2,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','b4016672-c84a-46b0-944c-79438a6ba174'),(8,5,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','484e6f97-54da-4d40-9bc0-d35f7aadc37a'),(9,5,'SEO','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"\",\"width\":100,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2021-05-18 19:10:51','2021-05-18 19:10:51','d3c1ac0b-54fc-4af8-ad30-006b84a02dcf'),(10,6,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','8057f950-afd9-49df-a21f-6f669111a624'),(11,6,'SEO','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"\",\"width\":100,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2021-05-18 19:10:51','2021-05-18 19:10:51','726fe46d-d6c3-438b-bab6-dba250a185f3'),(12,7,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"0cdabc70-da3d-4a31-b6b7-dad81aabc3a8\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"fieldUid\":\"ac5efc25-68b4-4028-b704-548cebcb183f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"fieldUid\":\"4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','24a2baf2-76aa-4257-ad67-6a19af5af81d'),(13,8,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','8d896863-9b3d-40d7-baf3-df996e357f61'),(14,8,'SEO','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"\",\"width\":100,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2021-05-18 19:10:51','2021-05-18 19:10:51','8ab3a119-0c5b-461f-90a5-0ad6641bea58'),(15,9,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','d55d27c1-092e-4fb4-a861-0aa7dcb06e88'),(16,9,'SEO','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":\"\",\"tip\":null,\"warning\":null,\"required\":\"\",\"width\":100,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2021-05-18 19:10:51','2021-05-18 19:10:51','1e88f59e-e557-4190-92e4-ef5b453732e7'),(19,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100}]',1,'2021-05-18 19:10:52','2021-05-18 19:10:52','044c5cab-85d2-4122-9de5-c6639836c185'),(20,11,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":75,\"fieldUid\":\"20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"7574f2c5-ebea-4c7c-9efb-fabe0fc82275\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"1d242d6f-f863-4979-b2af-bb1da5c2aee2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"fieldUid\":\"dda1fa64-dd45-42b6-8df9-476cbac15152\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"c9c14235-dfc3-4c81-bb97-f3e3be70fb14\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"b0be437c-c9b7-4725-b61e-01ae79d26892\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"e8279648-aafc-4293-a410-7e3c587f89c2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"c2aae972-6c74-45e4-a721-cb093d6508db\"}]',1,'2021-05-18 19:10:52','2021-05-18 19:10:52','63ea2588-98ee-4671-8ea1-1c56b573e42a'),(21,10,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":75,\"fieldUid\":\"e2e0830e-80f8-4dfd-8edf-45b6f917cd2d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"e3ee13e0-fc9a-44f0-bc39-783e24026d9c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"07a0012a-4bdf-4aaa-8415-bbe06adaf62c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"5ad1a48a-0387-4098-89e7-bf69eed8508e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"fdddeb54-6dc3-4563-a953-78d9c99db44a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"fieldUid\":\"b2c539bf-f3bf-4c27-81e6-cffc9cb8657d\"}]',1,'2021-05-18 19:10:52','2021-05-18 19:10:52','d01219ea-5c1d-4801-8e98-bdd4629ea47e');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (4,4,'Content Blocks','contentBlocks','global','',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_contentblocks}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','a4fe99b5-7832-4eb2-9833-f551177bb821'),(5,4,'Summary','summary','global','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','b1c52a06-4990-43f5-90d3-898a48789556'),(6,3,'Message Text','emergencyMessageText','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"The important thing you want to tell people\",\"uiMode\":\"normal\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','0cdabc70-da3d-4a31-b6b7-dad81aabc3a8'),(7,3,'Link URL to \"Learn More\"','emergencyMessageUrl','global','',0,'none',NULL,'craft\\fields\\Url','{\"maxLength\":\"255\",\"placeholder\":\"https://www.example.com\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca'),(8,4,'SEO','seo','global','',0,'none',NULL,'nystudio107\\seomatic\\fields\\SeoSettings','{\"elementDisplayPreviewType\":\"google\",\"facebookTabEnabled\":\"\",\"generalEnabledFields\":[\"seoTitle\",\"seoDescription\",\"seoImage\"],\"generalTabEnabled\":\"1\",\"sitemapTabEnabled\":\"\",\"twitterTabEnabled\":\"\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','d79b3073-00bf-430c-95d5-6d03d8303032'),(9,3,'Where should it appear?','emergencyMessagePlacement','global','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"All Pages\",\"value\":\"allPages\",\"default\":\"1\"},{\"label\":\"Home Page Only\",\"value\":\"homePage\",\"default\":\"\"},{\"label\":\"\",\"value\":\"\",\"default\":\"\"}]}','2021-05-18 19:10:51','2021-05-18 19:10:51','2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c'),(10,4,'Topics','topics','global','',1,'site',NULL,'craft\\fields\\Categories','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"branchLimit\":\"\",\"limit\":null,\"localizeRelations\":false,\"selectionLabel\":\"Add topic\",\"showSiteMenu\":true,\"source\":\"group:28948fc8-a354-4c75-a861-b11dda3c6929\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2021-05-18 19:10:51','2021-05-18 19:10:51','7e15e458-b87d-4706-988c-83f1ba50204c'),(11,3,'\"Learn More\" Call-to-Action','emergencyMessageLink','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"Details / Subscribe / Buy Now / etc\",\"uiMode\":\"normal\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','ac5efc25-68b4-4028-b704-548cebcb183f'),(12,NULL,'Layout','layout','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','Some components can have different layout variations.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:51','2021-05-18 19:10:51','5ad1a48a-0387-4098-89e7-bf69eed8508e'),(13,NULL,'Text','text','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','07a0012a-4bdf-4aaa-8415-bbe06adaf62c'),(14,NULL,'Background','background','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','Some components have different background options.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:51','2021-05-18 19:10:51','b2c539bf-f3bf-4c27-81e6-cffc9cb8657d'),(15,NULL,'Buttons','buttons','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add Button\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Label\",\"handle\":\"label\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"URL\",\"handle\":\"url\",\"width\":\"\",\"type\":\"url\"}},\"maxRows\":\"2\",\"minRows\":\"\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b'),(16,NULL,'Headline','headline','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"2\",\"multiline\":\"1\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2021-05-18 19:10:51','2021-05-18 19:10:51','e2e0830e-80f8-4dfd-8edf-45b6f917cd2d'),(17,NULL,'Headline Style','headlineStyle','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','e3ee13e0-fc9a-44f0-bc39-783e24026d9c'),(18,NULL,'Spacing','spacing','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','How much spacing appears around the component.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','fdddeb54-6dc3-4563-a953-78d9c99db44a'),(19,NULL,'Text','text','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"cleanupHtml\":true,\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"\",\"purifyHtml\":\"1\",\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":\"1\",\"removeInlineStyles\":\"1\",\"removeNbsp\":\"1\",\"showHtmlButtonForNonAdmins\":\"\",\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2021-05-18 19:10:52','2021-05-18 19:10:52','1d242d6f-f863-4979-b2af-bb1da5c2aee2'),(20,NULL,'Headline','headline','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','',1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"2\",\"multiline\":\"1\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2021-05-18 19:10:52','2021-05-18 19:10:52','20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164'),(21,NULL,'Headline Style','headlineStyle','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','7574f2c5-ebea-4c7c-9efb-fabe0fc82275'),(22,NULL,'Layout','layout','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','Some components can have different layout variations.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','b0be437c-c9b7-4725-b61e-01ae79d26892'),(23,NULL,'Background','background','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','Some components have different background options.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','c2aae972-6c74-45e4-a721-cb093d6508db'),(24,NULL,'Buttons','buttons','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','',1,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add Button\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Label\",\"handle\":\"label\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"URL\",\"handle\":\"url\",\"width\":\"\",\"type\":\"url\"}},\"maxRows\":\"2\",\"minRows\":\"\"}','2021-05-18 19:10:52','2021-05-18 19:10:52','c9c14235-dfc3-4c81-bb97-f3e3be70fb14'),(25,NULL,'Image(s)','images','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','',1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\",\"defaultUploadLocationSubpath\":\"{owner.owner.type.handle}/{owner.owner.slug}/\",\"limit\":\"\",\"localizeRelations\":false,\"previewMode\":\"full\",\"restrictFiles\":\"1\",\"selectionLabel\":\"Add Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"singleUploadLocationSource\":\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\",\"singleUploadLocationSubpath\":\"\",\"source\":null,\"sources\":[\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\"],\"targetSiteId\":null,\"useSingleFolder\":false,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2021-05-18 19:10:52','2021-05-18 19:10:52','dda1fa64-dd45-42b6-8df9-476cbac15152'),(26,NULL,'Spacing','spacing','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','How much spacing appears around the component.',0,'none',NULL,'craft\\fields\\Dropdown','{\"optgroups\":true,\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"\"}]}','2021-05-18 19:10:52','2021-05-18 19:10:52','e8279648-aafc-4293-a410-7e3c587f89c2');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `gqltokens` VALUES (1,'Public Token','__PUBLIC__',0,NULL,NULL,NULL,'2020-10-16 15:16:16','2020-10-16 15:16:16','1b9fd892-85aa-46c0-9bed-c7c82bf46416');
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.6.14','3.6.8',0,'rfkxrwsaersi','bygpptpkdaek','2020-03-27 13:22:43','2021-05-18 20:14:06','85f4c669-6b2b-4771-976e-a4bcdd2bd77b');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,4,10,'Text','text',1,'2021-05-18 19:10:52','2021-05-18 19:10:52','a345255e-6a6e-450c-8f3f-bd44bd0d7a91'),(2,4,11,'Text + Image','textImage',2,'2021-05-18 19:10:52','2021-05-18 19:10:52','a39c9c32-2acb-47fd-ad36-7980c445a44e');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_contentblocks`
--

LOCK TABLES `matrixcontent_contentblocks` WRITE;
/*!40000 ALTER TABLE `matrixcontent_contentblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_contentblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'craft','Install','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','255a7bd9-4a6a-445c-bac0-ec5c80eff1ca'),(2,'craft','m150403_183908_migrations_table_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','81cb0aab-bfa1-482f-a797-8ebd6913b240'),(3,'craft','m150403_184247_plugins_table_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5aea1857-8cf1-419c-9c08-fc68d91fe5f4'),(4,'craft','m150403_184533_field_version','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0f589dd7-da06-4d0f-bf2a-93eaaddcd2ad'),(5,'craft','m150403_184729_type_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8b25192b-bb45-40ed-bd4a-32f4ddac5aa9'),(6,'craft','m150403_185142_volumes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','66017e13-b70d-49ac-a668-097db57528f9'),(7,'craft','m150428_231346_userpreferences','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','39fd1888-30b1-42a5-93ce-f7d34cfb1310'),(8,'craft','m150519_150900_fieldversion_conversion','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','86bcf854-22b0-4a70-96bc-2044611c597b'),(9,'craft','m150617_213829_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a0c8e602-0468-49fe-8c16-fdffa82b4643'),(10,'craft','m150721_124739_templatecachequeries','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f320738-c1e5-46a2-bc27-91c7c1926dd2'),(11,'craft','m150724_140822_adjust_quality_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1af6d726-306c-4bf5-8cfd-eb434ab616d1'),(12,'craft','m150815_133521_last_login_attempt_ip','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2d4ec2a2-98c1-4c8a-ab2b-020217a6cf70'),(13,'craft','m151002_095935_volume_cache_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eff78c75-bac8-4447-9a3c-3ce5702ffa10'),(14,'craft','m151005_142750_volume_s3_storage_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b701ae4c-63b1-48cc-8267-59085e643f81'),(15,'craft','m151016_133600_delete_asset_thumbnails','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','af500463-3e1a-46c3-b7c9-6bd5d7a4db71'),(16,'craft','m151209_000000_move_logo','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e9fdda5e-9b99-4d7b-b09d-5cfa95b48c7b'),(17,'craft','m151211_000000_rename_fileId_to_assetId','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','75df1e70-a409-4c90-b7d8-ee19ed7b401c'),(18,'craft','m151215_000000_rename_asset_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','14e72674-0ccb-42b0-98de-9b70dbe6dd2c'),(19,'craft','m160707_000001_rename_richtext_assetsource_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7123c498-b5b5-41fb-9fa3-f7bb31c4d248'),(20,'craft','m160708_185142_volume_hasUrls_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','148932ce-bafe-414d-8020-4bd04635da04'),(21,'craft','m160714_000000_increase_max_asset_filesize','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0e377531-0a70-462f-bab2-f3ab80986ccf'),(22,'craft','m160727_194637_column_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','cb7e9397-4728-43b5-b974-ccbd9e08797f'),(23,'craft','m160804_110002_userphotos_to_assets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','72a8bc4b-2064-45fe-b857-349cd7241a5b'),(24,'craft','m160807_144858_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','30b17f8b-3acd-4b10-8394-1ad35cee1139'),(25,'craft','m160829_000000_pending_user_content_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5ef2a4c5-1e2f-4337-b249-c667627886df'),(26,'craft','m160830_000000_asset_index_uri_increase','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b009b29a-1e7f-48e9-9d8f-2a50466b16b8'),(27,'craft','m160912_230520_require_entry_type_id','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','057f602e-2110-4b74-a9b6-794e1972f92f'),(28,'craft','m160913_134730_require_matrix_block_type_id','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c67eaec1-a102-40c3-a7d5-f4a3400fbf7e'),(29,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','be379f74-f2cd-4400-8884-4dc0b2bd2114'),(30,'craft','m160920_231045_usergroup_handle_title_unique','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8373c373-51d7-4c3c-b3da-65af03c1cab3'),(31,'craft','m160925_113941_route_uri_parts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','cff3b8d3-60ae-490c-89ad-2b8317a8ce11'),(32,'craft','m161006_205918_schemaVersion_not_null','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d4e67e40-90c6-490b-98bb-ed4586b1d764'),(33,'craft','m161007_130653_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b789a9b3-8114-4d63-9bd8-9c2112323dba'),(34,'craft','m161013_175052_newParentId','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','15b96b1d-f810-4f22-a3cd-0ac21cd3bf65'),(35,'craft','m161021_102916_fix_recent_entries_widgets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','603a7ae6-a3a3-4836-a363-dea7c9d4ea8e'),(36,'craft','m161021_182140_rename_get_help_widget','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f5a896c-06e1-454d-8eb8-1b716d3eb64f'),(37,'craft','m161025_000000_fix_char_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','232f4ee5-f823-4421-9fab-9460a1bf2a7c'),(38,'craft','m161029_124145_email_message_languages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d9721ac1-3111-4005-9ddf-d75ba11c4b83'),(39,'craft','m161108_000000_new_version_format','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','faf44e8e-d227-4152-9778-2294550479a5'),(40,'craft','m161109_000000_index_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0e4dcb9b-2b4c-4403-991b-58a44f5e0c0e'),(41,'craft','m161122_185500_no_craft_app','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4330d3bc-67bb-44e2-bc71-7689150cdc14'),(42,'craft','m161125_150752_clear_urlmanager_cache','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','273b17f6-fd34-47a9-b66e-0e15c6c8b5e3'),(43,'craft','m161220_000000_volumes_hasurl_notnull','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e5304c92-fc2a-479e-8aab-0e5bc9851d47'),(44,'craft','m170114_161144_udates_permission','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','ee9efd39-5f71-4fee-bd70-b7b2da3641c4'),(45,'craft','m170120_000000_schema_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5047cbb6-5a6f-4868-8e05-655046bad66c'),(46,'craft','m170126_000000_assets_focal_point','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1ebab523-177b-43bc-a707-e2a172ab5ccc'),(47,'craft','m170206_142126_system_name','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','56bae875-93b7-446a-8cb5-3fe91fd0fc92'),(48,'craft','m170217_044740_category_branch_limits','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','fa730cd1-4608-476f-a041-1a192406e634'),(49,'craft','m170217_120224_asset_indexing_columns','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c706d06a-9fa7-4502-afe6-90b23a651a72'),(50,'craft','m170223_224012_plain_text_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','459a346a-43c6-4f0f-aaa0-c863cb13a73b'),(51,'craft','m170227_120814_focal_point_percentage','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e24f0c44-46bc-4bc5-a6bc-5044981382b5'),(52,'craft','m170228_171113_system_messages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','071c531e-e2bb-48ec-9efd-fcab056d6a26'),(53,'craft','m170303_140500_asset_field_source_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7b6dcde0-b522-44a6-916e-438f05d9d586'),(54,'craft','m170306_150500_asset_temporary_uploads','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','ffc146b0-577b-4e6e-9c53-73c19007bc58'),(55,'craft','m170523_190652_element_field_layout_ids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','101e4d6c-ac3b-40c8-8f0f-7b0411fc5191'),(56,'craft','m170612_000000_route_index_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','51522a51-bd55-47e3-97de-daadb68f43f7'),(57,'craft','m170621_195237_format_plugin_handles','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a32776a8-5419-42e4-a2e8-f7a0a52d8307'),(58,'craft','m170630_161027_deprecation_line_nullable','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','428a77ea-a40f-4c28-8d85-9af37bd53d23'),(59,'craft','m170630_161028_deprecation_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0257f4e3-0265-4f2f-9a1b-3088ae972348'),(60,'craft','m170703_181539_plugins_table_tweaks','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','954fa697-9999-4583-b39b-b5ff9d62d4f6'),(61,'craft','m170704_134916_sites_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2f968f14-db59-4421-978a-87fa06690e07'),(62,'craft','m170706_183216_rename_sequences','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5e6c9484-b078-4c80-b28a-e90bc53db103'),(63,'craft','m170707_094758_delete_compiled_traits','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','2c0bbe6e-73bf-4dd1-94a7-c29b8764f89b'),(64,'craft','m170731_190138_drop_asset_packagist','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','241e0eff-622d-4a45-b5da-8ae74c7ee587'),(65,'craft','m170810_201318_create_queue_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5697abc2-9558-4bcf-b141-f7370b59bd31'),(66,'craft','m170903_192801_longblob_for_queue_jobs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','dab06800-69cd-4c56-a7f4-f7b692512cd1'),(67,'craft','m170914_204621_asset_cache_shuffle','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','15267267-1409-4375-86e5-629713cd31fb'),(68,'craft','m171011_214115_site_groups','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4752ee77-3835-469c-a871-f814b09e30e8'),(69,'craft','m171012_151440_primary_site','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f593dbc-14e0-48d3-99a9-05d381f8d2ec'),(70,'craft','m171013_142500_transform_interlace','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4da5a8e2-3a1b-46b6-b23c-89234119bc88'),(71,'craft','m171016_092553_drop_position_select','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3c2970ed-345f-4d3b-ac7e-cffdfa2942f0'),(72,'craft','m171016_221244_less_strict_translation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','afa9a878-dbee-4064-9777-0bd8ddbd0720'),(73,'craft','m171107_000000_assign_group_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0ff13617-ceac-405e-8458-0baeb2f269cd'),(74,'craft','m171117_000001_templatecache_index_tune','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','77d0e773-5c44-4048-b5f4-934772d85fbe'),(75,'craft','m171126_105927_disabled_plugins','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8690b346-0b5c-4a8e-9ff2-8804a5d136c5'),(76,'craft','m171130_214407_craftidtokens_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5f38b70d-2fec-4fbd-9bf9-cfb37c621fba'),(77,'craft','m171202_004225_update_email_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','07fe7680-763c-4f8b-bbb2-ace8bfe411eb'),(78,'craft','m171204_000001_templatecache_index_tune_deux','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a6c74f57-4c1c-44fb-8421-d7bd70312d32'),(79,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d6026314-995a-4815-9b18-ce2aa676655f'),(80,'craft','m171218_143135_longtext_query_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f747f8e-c5b3-4fea-b886-83e18d38df8f'),(81,'craft','m171231_055546_environment_variables_to_aliases','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','074ae9a8-f9ea-429c-845a-ebabaa1e0264'),(82,'craft','m180113_153740_drop_users_archived_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','94d3dcb0-87d6-473d-b0f2-47f3e4a52314'),(83,'craft','m180122_213433_propagate_entries_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','54968ca4-e5a5-4d24-8c74-fe558c83c29f'),(84,'craft','m180124_230459_fix_propagate_entries_values','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eb0b9ea6-3870-4f0c-95a6-be9dcf9cdcb2'),(85,'craft','m180128_235202_set_tag_slugs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3f0a065b-7ca2-4a1c-8305-418e15bc0053'),(86,'craft','m180202_185551_fix_focal_points','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','152a8537-f013-4cf8-811c-6e5841c3efff'),(87,'craft','m180217_172123_tiny_ints','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c3e99dd8-f2be-470e-a5ba-ecef98230ef4'),(88,'craft','m180321_233505_small_ints','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','64a53868-a156-4b99-994a-6201dae965c1'),(89,'craft','m180328_115523_new_license_key_statuses','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6f94253a-9490-4514-810f-e612432eba56'),(90,'craft','m180404_182320_edition_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','095c2e7e-e262-4d27-9f4e-a6889211e77e'),(91,'craft','m180411_102218_fix_db_routes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','731742bc-8e59-405e-b1e6-c111d243e2a2'),(92,'craft','m180416_205628_resourcepaths_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6e06ec91-db04-44db-a85d-1f370aeb2df5'),(93,'craft','m180418_205713_widget_cleanup','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','31f47605-5041-4181-a9a3-7881d11d31c1'),(94,'craft','m180425_203349_searchable_fields','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','dc4704d5-dcc9-422c-8a87-132be84fce1a'),(95,'craft','m180516_153000_uids_in_field_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3b4774d6-4654-4463-b2f1-97f726b62362'),(96,'craft','m180517_173000_user_photo_volume_to_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','48aaf568-9b71-4dbb-b398-23ea179761ab'),(97,'craft','m180518_173000_permissions_to_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8c132a81-a3d6-495b-8266-cb3304906c7e'),(98,'craft','m180520_173000_matrix_context_to_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7cb3202e-0875-489a-a5b3-2d8a69450b2c'),(99,'craft','m180521_172900_project_config_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8ddfe078-e983-44b3-8b73-6b8c3e7f8ba8'),(100,'craft','m180521_173000_initial_yml_and_snapshot','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e44637ee-d8f3-420a-84bc-59e94f33096a'),(101,'craft','m180731_162030_soft_delete_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','64b3c4ed-b2f0-4e9a-a79a-af12fc83dd7d'),(102,'craft','m180810_214427_soft_delete_field_layouts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','76cbbfc5-0745-4ed2-8fd4-9bd227c0c0b4'),(103,'craft','m180810_214439_soft_delete_elements','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a03e5d4d-5c49-42c4-a71a-69db678a8224'),(104,'craft','m180824_193422_case_sensitivity_fixes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c675d233-cde2-4c93-b3ca-9b37bb434053'),(105,'craft','m180901_151639_fix_matrixcontent_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3ef9239e-4fdb-4613-8e7c-15a3f4125de8'),(106,'craft','m180904_112109_permission_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5f3c9a1a-11d2-478c-b049-ad6334598763'),(107,'craft','m180910_142030_soft_delete_sitegroups','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','066fac48-7b3e-47f9-b85f-6b717b7925f4'),(108,'craft','m181011_160000_soft_delete_asset_support','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a4c72873-ccef-484e-8e2d-930ad5215921'),(109,'craft','m181016_183648_set_default_user_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','028d4e4c-c46f-45cf-9d78-7a1753c2b098'),(110,'craft','m181017_225222_system_config_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','230b6760-a134-400b-8428-fbd7ae846bce'),(111,'craft','m181018_222343_drop_userpermissions_from_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e7c9b7ec-aa66-49bd-a7eb-3915aeabb975'),(112,'craft','m181029_130000_add_transforms_routes_to_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','599bc463-b22f-487c-8a42-aca50d00e71e'),(113,'craft','m181112_203955_sequences_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','882f7e42-1fd5-4400-bf17-f4c1cdc33033'),(114,'craft','m181121_001712_cleanup_field_configs','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','78c5b189-03f7-4708-a650-b38f69d029e7'),(115,'craft','m181128_193942_fix_project_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','9dc406f3-6c6f-4059-b44d-59d16b0eb2b1'),(116,'craft','m181130_143040_fix_schema_version','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','55663d4f-27ff-411e-956c-e14655ecac0b'),(117,'craft','m181211_143040_fix_entry_type_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b1d4d9a4-6316-413a-945e-2feac788829b'),(118,'craft','m181213_102500_config_map_aliases','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','89bf7bbb-44a6-443c-8206-af3ff2989eba'),(119,'craft','m181217_153000_fix_structure_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','846a472a-95f5-4f1f-a4f7-ca5184f269aa'),(120,'craft','m190104_152725_store_licensed_plugin_editions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','5c209aff-00dd-42d9-8a42-b6564d100cc0'),(121,'craft','m190108_110000_cleanup_project_config','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d327fadd-76d7-4503-be11-81da8a912af6'),(122,'craft','m190108_113000_asset_field_setting_change','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','695f277a-ab68-4a83-82f2-e936295adb3d'),(123,'craft','m190109_172845_fix_colspan','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','43910cd4-5e83-4b6d-855a-8f7b88b6247f'),(124,'craft','m190110_150000_prune_nonexisting_sites','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4cd71f29-f98a-4899-a2b4-238a61c4db65'),(125,'craft','m190110_214819_soft_delete_volumes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8335956a-2c49-4a40-8b0e-e68b208e1c30'),(126,'craft','m190112_124737_fix_user_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','4698b045-e5ee-4a56-bff7-c1fff754a9f1'),(127,'craft','m190112_131225_fix_field_layouts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','902d60e1-8e2c-4f4a-9055-8f83c85f6e6d'),(128,'craft','m190112_201010_more_soft_deletes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','7f9961ac-e762-4ef5-9a7a-fa1817d26bf4'),(129,'craft','m190114_143000_more_asset_field_setting_changes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e8cf4c8b-8f82-472d-b39d-f896cfc6d226'),(130,'craft','m190121_120000_rich_text_config_setting','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0dec2485-9aab-4d9d-8d46-6756b44eeb93'),(131,'craft','m190125_191628_fix_email_transport_password','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','1cc76fe6-e762-4c91-beec-702c1b984b44'),(132,'craft','m190128_181422_cleanup_volume_folders','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','692967b5-27b0-432e-a903-069ba83f074c'),(133,'craft','m190205_140000_fix_asset_soft_delete_index','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8ab58617-1897-42ae-94ae-0db48629922b'),(134,'craft','m190208_140000_reset_project_config_mapping','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d9b0e8dd-3d94-416f-89f5-45df90281cf2'),(135,'craft','m190218_143000_element_index_settings_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','76cc86f7-0364-4afe-90a6-6316792c9bdd'),(136,'craft','m190312_152740_element_revisions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','bb233c1e-c672-4022-834d-955b2f2b2c5b'),(137,'craft','m190327_235137_propagation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','be267a4a-fe8d-49a7-8d8f-db65a9a40281'),(138,'craft','m190401_223843_drop_old_indexes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8a3991de-610a-4423-bab3-0d7af54a2bd9'),(139,'craft','m190416_014525_drop_unique_global_indexes','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','17772379-ba34-4e84-b8e1-0515ad2af06e'),(140,'craft','m190417_085010_add_image_editor_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3701bce4-d093-4d7a-adf6-fbb44d3c3696'),(141,'craft','m190502_122019_store_default_user_group_uid','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','241e3fa0-c65d-44ba-93c5-7017f358b17d'),(142,'craft','m190504_150349_preview_targets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','0bc04b28-b115-4ee9-b48d-13e4f61f6553'),(143,'craft','m190516_184711_job_progress_label','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','fd29213c-6dca-4b79-9a1a-6153444036ef'),(144,'craft','m190523_190303_optional_revision_creators','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6ffbf76b-3eda-4c76-a528-e8e4b5a03d16'),(145,'craft','m190529_204501_fix_duplicate_uids','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','af69fe27-56cc-4d3d-9acf-9a0b395274d0'),(146,'craft','m190605_223807_unsaved_drafts','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','674c3d9e-8a8d-4789-9cf2-304de25ce61d'),(147,'craft','m190607_230042_entry_revision_error_tables','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','c2e80144-eafe-4417-8e5d-68ab36613f48'),(148,'craft','m190608_033429_drop_elements_uid_idx','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b46a28ab-4748-49d0-baf4-2259b7aaeda8'),(149,'craft','m190617_164400_add_gqlschemas_table','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e4256312-0939-4eaa-af6e-46e7e333887b'),(150,'craft','m190624_234204_matrix_propagation_method','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','e2fdceea-2402-4dfc-b8ad-91a5bb6081ea'),(151,'craft','m190711_153020_drop_snapshots','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','eabbd986-c254-43b4-9293-617dec6ced0f'),(152,'craft','m190712_195914_no_draft_revisions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b9fa515f-0b21-4e90-8b24-55ce3b20fbdf'),(153,'craft','m190723_140314_fix_preview_targets_column','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','617fa9ec-59ff-48a6-9f37-0d058a8cf10f'),(154,'craft','m190820_003519_flush_compiled_templates','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','d6355a46-1036-4f2c-849c-31c1c744d5cf'),(155,'craft','m190823_020339_optional_draft_creators','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','8f291ec6-25df-48b1-b0fd-832c222067cc'),(156,'craft','m190913_152146_update_preview_targets','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','708fc9d8-e029-4b1b-9a8e-47e74fb3da23'),(157,'craft','m191107_122000_add_gql_project_config_support','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','378c63e4-b06d-4aaf-8432-2264aeb67810'),(158,'craft','m191204_085100_pack_savable_component_settings','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','6a175408-6d11-408d-b252-0604dd85b192'),(159,'craft','m191206_001148_change_tracking','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','a0e210b7-bd80-4b35-8559-9cdc1da25b54'),(160,'craft','m191216_191635_asset_upload_tracking','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','89b3dda9-0fa6-4741-8987-3aa30bfde7ee'),(161,'craft','m191222_002848_peer_asset_permissions','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','03c80884-65ce-47b0-98cc-a7a7049a8d82'),(162,'craft','m200127_172522_queue_channels','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','3fba8b65-7b25-4114-b773-430aaffc50b5'),(163,'craft','m200211_175048_truncate_element_query_cache','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','79e5d574-6170-42b0-920f-e63fae0baa9d'),(164,'craft','m200213_172522_new_elements_index','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','b8f132e5-cf07-4758-b90b-f0b691227577'),(165,'craft','m200228_195211_long_deprecation_messages','2020-03-27 13:22:44','2020-03-27 13:22:44','2020-03-27 13:22:44','63b1b93f-c645-4d76-9eee-9f5cda47dbd1'),(176,'plugin:seomatic','Install','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a5c88b79-d692-4f09-8186-8f11687f95ac'),(177,'plugin:seomatic','m180314_002755_field_type','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','e8fd3d69-80fe-4b77-bd6e-881bd95395ef'),(178,'plugin:seomatic','m180314_002756_base_install','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','13faed23-cc8a-430f-b785-9a9919007553'),(179,'plugin:seomatic','m180502_202319_remove_field_metabundles','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','6a20cccd-6655-453b-899d-e9681d2a1c5c'),(180,'plugin:seomatic','m180711_024947_commerce_products','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','2cf8cde9-e8f4-4997-9014-4a154a3f5361'),(181,'plugin:seomatic','m190401_220828_longer_handles','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','a52c8755-967a-41cf-abb1-7a63c06754f6'),(182,'plugin:seomatic','m190518_030221_calendar_events','2020-03-27 13:29:52','2020-03-27 13:29:52','2020-03-27 13:29:52','ab6d63b2-fe21-4fb3-bbe2-4ebd3a6ffef9'),(185,'craft','m200306_054652_disabled_sites','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','abc2f9d4-4653-4583-82f4-7e483a13f888'),(186,'craft','m200522_191453_clear_template_caches','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','b3cf261a-7c72-494f-b0d3-f90f37dd8697'),(187,'craft','m200606_231117_migration_tracks','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','bc34bce4-9616-413c-8c68-5e9b60eb7210'),(188,'craft','m200619_215137_title_translation_method','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','d7391893-a7b0-481b-bac7-bb8124f56aa2'),(189,'craft','m200620_005028_user_group_descriptions','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','abd003bc-e99d-4929-8d42-fdb5adfa8c90'),(190,'craft','m200620_230205_field_layout_changes','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','43b71a32-5238-4c70-90a2-6531b2042268'),(191,'craft','m200625_131100_move_entrytypes_to_top_project_config','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','2b86d78a-0825-4c90-acf7-629463148de8'),(192,'craft','m200629_112700_remove_project_config_legacy_files','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','35da89d2-87af-4f31-98d4-d028e5f44f03'),(193,'craft','m200630_183000_drop_configmap','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','6e888e11-fff0-4cf6-83ed-ac62cce76ef0'),(194,'craft','m200715_113400_transform_index_error_flag','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','b7bae372-1ba0-4109-ade5-b1f9af4a63a6'),(195,'craft','m200716_110900_replace_file_asset_permissions','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','3a1671c1-3334-478b-92d3-35dce55d87ae'),(196,'craft','m200716_153800_public_token_settings_in_project_config','2020-10-16 15:16:14','2020-10-16 15:16:14','2020-10-16 15:16:14','9fcbf070-3ff5-40a0-910b-ed0c0e5ad88d'),(197,'craft','m200720_175543_drop_unique_constraints','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','deaeab5a-092d-4e0f-95fb-18ef08d6489e'),(198,'craft','m200825_051217_project_config_version','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','6e096de1-fcd8-4f96-92b3-37db41a29a25'),(199,'plugin:seomatic','m200419_203444_add_type_id','2020-10-16 15:16:15','2020-10-16 15:16:15','2020-10-16 15:16:15','25f0ab31-c74b-40da-b18b-e82f19c3855c'),(204,'craft','m201116_190500_asset_title_translation_method','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','7a993ecc-15d2-47c3-a8b7-8f8eb896f89f'),(205,'craft','m201124_003555_plugin_trials','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','2c2247ff-1fb4-41a4-8d51-66927b38f29b'),(206,'craft','m210209_135503_soft_delete_field_groups','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','497361c7-8e1a-42be-83bf-ade2015c63f2'),(207,'craft','m210212_223539_delete_invalid_drafts','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','f6ae2816-d6a6-4744-b8d4-90a00895e143'),(208,'craft','m210214_202731_track_saved_drafts','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','2366a901-96d9-474d-8d64-aba376748ac5'),(209,'craft','m210223_150900_add_new_element_gql_schema_components','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','b858a32c-23ac-45a8-8441-9e16082970a4'),(210,'craft','m210224_162000_add_projectconfignames_table','2021-03-07 19:19:55','2021-03-07 19:19:55','2021-03-07 19:19:55','89337f8a-6ddd-4341-a650-a4263c6cb230'),(211,'craft','m210326_132000_invalidate_projectconfig_cache','2021-05-18 19:07:08','2021-05-18 19:07:08','2021-05-18 19:07:08','8bc10989-7550-4976-bb20-87cd41d6c494'),(212,'craft','m210331_220322_null_author','2021-05-18 19:07:08','2021-05-18 19:07:08','2021-05-18 19:07:08','536e0e6f-3825-41d7-89b8-36a3c646c58c'),(213,'plugin:reasons','Install','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','7ddfa2ed-9d19-4ae1-83b7-7f932946d0f6'),(214,'plugin:reasons','m200601_000000_fix_conditionals_column_type','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','55157545-8241-468e-bff7-935ab9122c3a'),(215,'plugin:reasons','m200603_004000_projectconfig','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','a1d025f9-f5ce-4322-8d4e-24181d99ab17'),(216,'plugin:redactor','m180430_204710_remove_old_plugins','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','9cd426d2-358b-4682-8d57-7de72d9a2412'),(217,'plugin:redactor','Install','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','21a9dca7-04f3-4d4e-8fa4-935e08837963'),(218,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-18 19:10:50','bac67e31-ab5a-44a7-b406-2d4f2927e1a5');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_navs`
--

LOCK TABLES `navigation_navs` WRITE;
/*!40000 ALTER TABLE `navigation_navs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `navigation_navs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_nodes`
--

LOCK TABLES `navigation_nodes` WRITE;
/*!40000 ALTER TABLE `navigation_nodes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `navigation_nodes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'minify','1.2.10','1.0.0','unknown',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2021-05-19 04:31:30','e3c115e9-20f8-4e22-844e-30e17ef57531'),(2,'fastcgi-cache-bust','1.0.9','1.0.0','unknown',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2021-05-19 04:31:30','181a837f-d581-4b8f-a41f-c42ac5024864'),(5,'seomatic','3.3.42','3.0.9','trial',NULL,'2020-03-27 13:29:52','2020-03-27 13:29:52','2021-05-19 04:31:30','1f2b10de-d456-42a8-816e-278d5516bcdd'),(7,'typogrify','1.1.18','1.0.0','unknown',NULL,'2020-03-27 13:30:07','2020-03-27 13:30:07','2021-05-19 04:31:30','77df8ab1-431b-47c6-9652-3b7f85c6ce9f'),(9,'twigpack','1.2.14','1.0.0','unknown',NULL,'2020-10-16 15:31:32','2020-10-16 15:31:32','2021-05-19 04:31:30','08169dff-2660-4224-bd82-b9a0a82101f2'),(13,'dospaces','1.1.3','1.0.0','unknown',NULL,'2021-05-18 19:07:08','2021-05-18 19:07:08','2021-05-19 04:31:30','f83eab70-007b-4b69-ab9c-683314ab9824'),(14,'expanded-search','1.3.7','0.0.1','unknown',NULL,'2021-05-18 19:07:08','2021-05-18 19:07:08','2021-05-19 04:31:30','9d34f77a-eb4a-4b80-ac24-a53a85a9c628'),(15,'reasons','2.2.4','2.1.1','unknown',NULL,'2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-19 04:31:30','461b78e3-9711-4d6b-8f40-7cfab7c01f47'),(16,'redactor','2.8.7','2.3.0','unknown',NULL,'2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-19 04:31:30','6dd5655e-5bd4-44a6-8c54-698d6a24f1c6'),(17,'retcon','2.2.3','1.0.0','unknown',NULL,'2021-05-18 19:10:50','2021-05-18 19:10:50','2021-05-19 04:31:30','25d3a845-5123-4f55-a25e-89580861cb49'),(18,'matrixmate','1.2.7','1.0.0','unknown',NULL,'2021-05-18 20:14:06','2021-05-18 20:14:06','2021-05-19 04:31:30','8e361486-240a-42b1-a344-51310f41ff5e');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.autocapitalize','true'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.autocomplete','false'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.autocorrect','true'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.class','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.disabled','false'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.id','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.instructions','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.label','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.max','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.min','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.name','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.orientation','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.placeholder','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.readonly','false'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.requirable','false'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.size','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.step','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.tip','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.title','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\TitleField\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.warning','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.0.width','100'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.fieldUid','\"b1c52a06-4990-43f5-90d3-898a48789556\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.instructions','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.label','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.required','false'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.tip','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.warning','null'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.elements.1.width','100'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.name','\"Content\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.fieldLayouts.4d1bca6d-66f6-47d1-ae49-cd32793634e2.tabs.0.sortOrder','1'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.handle','\"topics\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.name','\"Topics\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','true'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.template','\"pages/topic\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.uriFormat','\"topics/{slug}\"'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.structure.maxLevels','1'),('categoryGroups.28948fc8-a354-4c75-a861-b11dda3c6929.structure.uid','\"2b4d73cc-b09e-4bae-8a4d-5a7b6190a358\"'),('dateModified','1621368846'),('email.fromEmail','\"steve@simplicate.ca\"'),('email.fromName','\"admin\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.autocapitalize','true'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.autocomplete','false'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.autocorrect','true'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.class','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.disabled','false'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.id','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.instructions','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.label','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.max','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.min','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.name','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.orientation','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.placeholder','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.readonly','false'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.requirable','false'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.size','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.step','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.tip','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.title','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.warning','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.0.width','100'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.fieldUid','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.instructions','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.label','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.required','false'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.tip','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.warning','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.elements.1.width','100'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.name','\"Content\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.0.sortOrder','1'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.fieldUid','\"d79b3073-00bf-430c-95d5-6d03d8303032\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.instructions','\"\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.label','\"__blank__\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.required','\"\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.tip','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.warning','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.elements.0.width','100'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.name','\"SEO\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.fieldLayouts.b0caa612-277a-4220-8f06-afd248e6840b.tabs.1.sortOrder','2'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.handle','\"newsIndex\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.hasTitleField','true'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.name','\"News Index\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.section','\"650e7d1d-63e5-42f9-b3ab-4febfb502723\"'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.sortOrder','2'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.titleFormat','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.titleTranslationKeyFormat','null'),('entryTypes.0adda131-0527-467d-8935-110db8ed3aad.titleTranslationMethod','\"site\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.autocapitalize','true'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.autocomplete','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.autocorrect','true'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.class','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.disabled','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.id','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.instructions','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.label','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.max','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.min','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.name','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.orientation','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.placeholder','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.readonly','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.requirable','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.size','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.step','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.tip','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.title','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.warning','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.0.width','100'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.fieldUid','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.instructions','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.label','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.required','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.tip','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.warning','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.elements.1.width','100'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.name','\"Content\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.0.sortOrder','1'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.fieldUid','\"d79b3073-00bf-430c-95d5-6d03d8303032\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.instructions','\"\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.label','\"__blank__\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.required','\"\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.tip','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.warning','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.elements.0.width','100'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.name','\"SEO\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.fieldLayouts.519dbeb4-c6da-4d96-812b-ef982ec0d2fd.tabs.1.sortOrder','2'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.handle','\"home\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.hasTitleField','false'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.name','\"Home\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.section','\"6ec26690-b0b1-410f-9bc5-1a5512e6dc3e\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.sortOrder','1'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.titleFormat','\"{section.name|raw}\"'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.titleTranslationKeyFormat','null'),('entryTypes.b51219b5-c15b-4ce1-ab72-ad00a1b7a25e.titleTranslationMethod','\"site\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.autocapitalize','true'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.autocomplete','false'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.autocorrect','true'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.class','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.disabled','false'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.id','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.instructions','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.label','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.max','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.min','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.name','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.orientation','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.placeholder','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.readonly','false'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.requirable','false'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.size','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.step','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.tip','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.title','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.warning','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.0.width','100'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.fieldUid','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.instructions','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.label','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.required','false'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.tip','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.warning','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.elements.1.width','100'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.name','\"Content\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.0.sortOrder','1'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.fieldUid','\"d79b3073-00bf-430c-95d5-6d03d8303032\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.instructions','\"\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.label','\"__blank__\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.required','\"\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.tip','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.warning','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.elements.0.width','100'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.name','\"SEO\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.fieldLayouts.89885d4f-8b0f-4133-b6a0-1632b3f78fa0.tabs.1.sortOrder','2'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.handle','\"topicsIndex\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.hasTitleField','true'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.name','\"Topics Index\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.section','\"650e7d1d-63e5-42f9-b3ab-4febfb502723\"'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.sortOrder','3'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.titleFormat','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.titleTranslationKeyFormat','null'),('entryTypes.d25e2e5d-90aa-4551-bbb2-2ef3300099d1.titleTranslationMethod','\"site\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.autocapitalize','true'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.autocomplete','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.autocorrect','true'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.class','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.disabled','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.id','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.instructions','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.label','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.max','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.min','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.name','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.orientation','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.placeholder','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.readonly','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.requirable','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.size','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.step','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.tip','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.title','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.warning','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.0.width','100'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.fieldUid','\"b1c52a06-4990-43f5-90d3-898a48789556\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.instructions','\"\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.label','\"\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.required','\"1\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.tip','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.warning','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.1.width','100'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.fieldUid','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.instructions','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.label','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.required','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.tip','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.warning','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.2.width','100'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.fieldUid','\"7e15e458-b87d-4706-988c-83f1ba50204c\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.instructions','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.label','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.required','false'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.tip','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.warning','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.elements.3.width','100'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.name','\"Content\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.0.sortOrder','1'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.fieldUid','\"d79b3073-00bf-430c-95d5-6d03d8303032\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.instructions','\"\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.label','\"__blank__\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.required','\"\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.tip','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.warning','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.elements.0.width','100'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.name','\"SEO\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.fieldLayouts.428ba83c-5ca7-4751-9529-c3d5c77739fc.tabs.1.sortOrder','2'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.handle','\"news\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.hasTitleField','true'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.name','\"News\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.section','\"3721b4d6-42d5-41fc-b6e7-76204b42c91a\"'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.sortOrder','1'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.titleFormat','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.titleTranslationKeyFormat','null'),('entryTypes.d3282cfb-d044-4890-b553-9a0b87393027.titleTranslationMethod','\"site\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.autocapitalize','true'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.autocomplete','false'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.autocorrect','true'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.class','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.disabled','false'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.id','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.instructions','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.label','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.max','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.min','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.name','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.orientation','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.placeholder','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.readonly','false'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.requirable','false'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.size','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.step','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.tip','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.title','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.warning','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.0.width','100'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.fieldUid','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.instructions','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.label','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.required','false'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.tip','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.warning','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.elements.1.width','100'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.name','\"Content\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.0.sortOrder','1'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.fieldUid','\"d79b3073-00bf-430c-95d5-6d03d8303032\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.instructions','\"\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.label','\"__blank__\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.required','\"\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.tip','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.warning','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.elements.0.width','100'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.name','\"SEO\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.fieldLayouts.0e6296a2-ebef-4158-ba3d-e196af38899e.tabs.1.sortOrder','2'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.handle','\"page\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.hasTitleField','true'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.name','\"Pages\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.section','\"650e7d1d-63e5-42f9-b3ab-4febfb502723\"'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.sortOrder','1'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.titleFormat','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.titleTranslationKeyFormat','null'),('entryTypes.e0521335-ccc2-4893-a505-4baacf112dee.titleTranslationMethod','\"site\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.autocapitalize','true'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.autocomplete','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.autocorrect','true'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.class','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.disabled','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.id','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.instructions','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.label','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.max','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.min','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.name','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.orientation','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.placeholder','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.readonly','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.requirable','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.size','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.step','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.tip','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.title','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.warning','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.0.width','100'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.fieldUid','\"0cdabc70-da3d-4a31-b6b7-dad81aabc3a8\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.instructions','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.label','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.required','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.tip','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.warning','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.1.width','100'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.fieldUid','\"ac5efc25-68b4-4028-b704-548cebcb183f\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.instructions','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.label','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.required','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.tip','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.warning','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.2.width','50'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.fieldUid','\"4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.instructions','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.label','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.required','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.tip','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.warning','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.3.width','50'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.fieldUid','\"2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.instructions','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.label','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.required','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.tip','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.warning','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.elements.4.width','100'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.name','\"Content\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.fieldLayouts.44a33a2f-7625-459e-aed6-bd555138cbec.tabs.0.sortOrder','1'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.handle','\"emergencyMessage\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.hasTitleField','false'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.name','\"Emergency Message\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.section','\"7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.sortOrder','1'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.titleFormat','\"{section.name|raw}\"'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.titleTranslationKeyFormat','null'),('entryTypes.fb1d50db-864b-4553-9fb0-d1d784dd98d9.titleTranslationMethod','\"site\"'),('fieldGroups.1e0f22f0-2c77-45f2-a8dd-9405520e5ce0.name','\"Emergency Message\"'),('fieldGroups.e0dac603-c510-4bb5-8701-e25672d93744.name','\"Common\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.contentColumnType','\"text\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.fieldGroup','\"1e0f22f0-2c77-45f2-a8dd-9405520e5ce0\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.handle','\"emergencyMessageText\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.instructions','\"\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.name','\"Message Text\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.searchable','false'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.byteLimit','null'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.charLimit','null'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.code','\"\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.columnType','null'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.initialRows','\"4\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.multiline','\"\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.placeholder','\"The important thing you want to tell people\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.settings.uiMode','\"normal\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.translationKeyFormat','null'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.translationMethod','\"none\"'),('fields.0cdabc70-da3d-4a31-b6b7-dad81aabc3a8.type','\"craft\\\\fields\\\\PlainText\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.contentColumnType','\"string\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.fieldGroup','\"1e0f22f0-2c77-45f2-a8dd-9405520e5ce0\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.handle','\"emergencyMessagePlacement\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.instructions','\"\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.name','\"Where should it appear?\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.searchable','false'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.optgroups','true'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.0.0','\"label\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.0.1','\"All Pages\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.1.0','\"value\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.1.1','\"allPages\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.2.0','\"default\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.0.__assoc__.2.1','\"1\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.0.0','\"label\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.0.1','\"Home Page Only\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.1.0','\"value\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.1.1','\"homePage\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.2.0','\"default\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.1.__assoc__.2.1','\"\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.0.0','\"label\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.0.1','\"\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.1.0','\"value\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.1.1','\"\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.2.0','\"default\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.settings.options.2.__assoc__.2.1','\"\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.translationKeyFormat','null'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.translationMethod','\"none\"'),('fields.2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c.type','\"craft\\\\fields\\\\Dropdown\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.contentColumnType','\"string(255)\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.fieldGroup','\"1e0f22f0-2c77-45f2-a8dd-9405520e5ce0\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.handle','\"emergencyMessageUrl\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.instructions','\"\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.name','\"Link URL to \\\"Learn More\\\"\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.searchable','false'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.settings.maxLength','\"255\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.settings.placeholder','\"https://www.example.com\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.translationKeyFormat','null'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.translationMethod','\"none\"'),('fields.4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca.type','\"craft\\\\fields\\\\Url\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.contentColumnType','\"string\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.fieldGroup','\"e0dac603-c510-4bb5-8701-e25672d93744\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.handle','\"topics\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.instructions','\"\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.name','\"Topics\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.searchable','true'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.allowLimit','false'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.allowMultipleSources','false'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.allowSelfRelations','false'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.branchLimit','\"\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.limit','null'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.localizeRelations','false'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.selectionLabel','\"Add topic\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.showSiteMenu','true'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.source','\"group:28948fc8-a354-4c75-a861-b11dda3c6929\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.sources','\"*\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.targetSiteId','null'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.validateRelatedElements','false'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.settings.viewMode','null'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.translationKeyFormat','null'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.translationMethod','\"site\"'),('fields.7e15e458-b87d-4706-988c-83f1ba50204c.type','\"craft\\\\fields\\\\Categories\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.contentColumnType','\"string\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.fieldGroup','\"e0dac603-c510-4bb5-8701-e25672d93744\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.handle','\"contentBlocks\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.instructions','\"\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.name','\"Content Blocks\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.searchable','true'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.settings.contentTable','\"{{%matrixcontent_contentblocks}}\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.settings.maxBlocks','\"\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.settings.minBlocks','\"\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.settings.propagationMethod','\"all\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.translationKeyFormat','null'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.translationMethod','\"site\"'),('fields.a4fe99b5-7832-4eb2-9833-f551177bb821.type','\"craft\\\\fields\\\\Matrix\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.contentColumnType','\"text\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.fieldGroup','\"1e0f22f0-2c77-45f2-a8dd-9405520e5ce0\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.handle','\"emergencyMessageLink\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.instructions','\"\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.name','\"\\\"Learn More\\\" Call-to-Action\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.searchable','false'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.byteLimit','null'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.charLimit','null'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.code','\"\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.columnType','null'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.initialRows','\"4\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.multiline','\"\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.placeholder','\"Details / Subscribe / Buy Now / etc\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.settings.uiMode','\"normal\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.translationKeyFormat','null'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.translationMethod','\"none\"'),('fields.ac5efc25-68b4-4028-b704-548cebcb183f.type','\"craft\\\\fields\\\\PlainText\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.contentColumnType','\"text\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.fieldGroup','\"e0dac603-c510-4bb5-8701-e25672d93744\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.handle','\"summary\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.instructions','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.name','\"Summary\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.searchable','true'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.availableTransforms','\"*\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.availableVolumes','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.cleanupHtml','true'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.columnType','\"text\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.configSelectionMode','\"choose\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.defaultTransform','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.manualConfig','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.purifierConfig','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.purifyHtml','\"1\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.redactorConfig','\"Simple.json\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.removeEmptyTags','\"1\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.removeInlineStyles','\"1\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.removeNbsp','\"1\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.showHtmlButtonForNonAdmins','\"\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.showUnpermittedFiles','false'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.showUnpermittedVolumes','false'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.settings.uiMode','\"enlarged\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.translationKeyFormat','null'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.translationMethod','\"none\"'),('fields.b1c52a06-4990-43f5-90d3-898a48789556.type','\"craft\\\\redactor\\\\Field\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.contentColumnType','\"text\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.fieldGroup','\"e0dac603-c510-4bb5-8701-e25672d93744\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.handle','\"seo\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.instructions','\"\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.name','\"SEO\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.searchable','false'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.elementDisplayPreviewType','\"google\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.facebookTabEnabled','\"\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.generalEnabledFields.0','\"seoTitle\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.generalEnabledFields.1','\"seoDescription\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.generalEnabledFields.2','\"seoImage\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.generalTabEnabled','\"1\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.sitemapTabEnabled','\"\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.settings.twitterTabEnabled','\"\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.translationKeyFormat','null'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.translationMethod','\"none\"'),('fields.d79b3073-00bf-430c-95d5-6d03d8303032.type','\"nystudio107\\\\seomatic\\\\fields\\\\SeoSettings\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.field','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.fieldUid','\"e2e0830e-80f8-4dfd-8edf-45b6f917cd2d\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.0.width','75'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.fieldUid','\"e3ee13e0-fc9a-44f0-bc39-783e24026d9c\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.1.width','25'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.fieldUid','\"07a0012a-4bdf-4aaa-8415-bbe06adaf62c\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.2.width','100'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.fieldUid','\"c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.3.width','100'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.fieldUid','\"5ad1a48a-0387-4098-89e7-bf69eed8508e\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.4.width','25'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.fieldUid','\"fdddeb54-6dc3-4563-a953-78d9c99db44a\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.5.width','25'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.fieldUid','\"b2c539bf-f3bf-4c27-81e6-cffc9cb8657d\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.instructions','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.label','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.required','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.tip','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.warning','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.elements.6.width','25'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.name','\"Content\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fieldLayouts.030b6d0b-c5dc-459c-b3e0-6e508313ca31.tabs.0.sortOrder','1'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.contentColumnType','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.handle','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.instructions','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.name','\"Text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.searchable','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.availableTransforms','\"*\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.availableVolumes','\"*\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.cleanupHtml','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.columnType','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.configSelectionMode','\"choose\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.defaultTransform','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.manualConfig','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.purifierConfig','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.purifyHtml','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.redactorConfig','\"Standard.json\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.removeEmptyTags','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.removeInlineStyles','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.removeNbsp','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.showHtmlButtonForNonAdmins','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.showUnpermittedFiles','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.settings.uiMode','\"enlarged\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.07a0012a-4bdf-4aaa-8415-bbe06adaf62c.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.contentColumnType','\"string\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.handle','\"layout\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.instructions','\"Some components can have different layout variations.\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.name','\"Layout\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.searchable','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.optgroups','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.5ad1a48a-0387-4098-89e7-bf69eed8508e.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.contentColumnType','\"string\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.handle','\"background\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.instructions','\"Some components have different background options.\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.name','\"Background\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.searchable','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.optgroups','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.b2c539bf-f3bf-4c27-81e6-cffc9cb8657d.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.contentColumnType','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.handle','\"buttons\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.instructions','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.name','\"Buttons\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.searchable','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.addRowLabel','\"Add Button\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.0','\"col1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.1.1','\"label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.0.1.__assoc__.3.1','\"singleline\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.0','\"col2\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.0.0','\"heading\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.0.1','\"URL\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.1.0','\"handle\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.1.1','\"url\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.2.0','\"width\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.3.0','\"type\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columns.__assoc__.1.1.__assoc__.3.1','\"url\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.columnType','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.maxRows','\"2\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.settings.minRows','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b.type','\"craft\\\\fields\\\\Table\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.contentColumnType','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.handle','\"headline\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.instructions','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.name','\"Headline\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.searchable','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.byteLimit','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.charLimit','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.code','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.columnType','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.initialRows','\"2\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.multiline','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.placeholder','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.settings.uiMode','\"normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e2e0830e-80f8-4dfd-8edf-45b6f917cd2d.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.contentColumnType','\"string\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.handle','\"headlineStyle\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.instructions','\"\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.name','\"Headline Style\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.searchable','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.optgroups','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.e3ee13e0-fc9a-44f0-bc39-783e24026d9c.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.contentColumnType','\"string\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.fieldGroup','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.handle','\"spacing\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.instructions','\"How much spacing appears around the component.\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.name','\"Spacing\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.searchable','false'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.optgroups','true'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.translationKeyFormat','null'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.translationMethod','\"none\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.fields.fdddeb54-6dc3-4563-a953-78d9c99db44a.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.handle','\"text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.name','\"Text\"'),('matrixBlockTypes.a345255e-6a6e-450c-8f3f-bd44bd0d7a91.sortOrder','1'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.field','\"a4fe99b5-7832-4eb2-9833-f551177bb821\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.fieldUid','\"20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.0.width','75'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.fieldUid','\"7574f2c5-ebea-4c7c-9efb-fabe0fc82275\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.1.width','25'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.fieldUid','\"1d242d6f-f863-4979-b2af-bb1da5c2aee2\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.2.width','100'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.fieldUid','\"dda1fa64-dd45-42b6-8df9-476cbac15152\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.required','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.3.width','100'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.fieldUid','\"c9c14235-dfc3-4c81-bb97-f3e3be70fb14\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.4.width','100'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.fieldUid','\"b0be437c-c9b7-4725-b61e-01ae79d26892\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.5.width','25'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.fieldUid','\"e8279648-aafc-4293-a410-7e3c587f89c2\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.6.width','25'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.fieldUid','\"c2aae972-6c74-45e4-a721-cb093d6508db\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.instructions','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.label','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.required','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.tip','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.warning','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.elements.7.width','25'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.name','\"Content\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fieldLayouts.a067cac1-ec42-43cc-b56a-f98e3b5b7803.tabs.0.sortOrder','1'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.contentColumnType','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.handle','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.instructions','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.name','\"Text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.searchable','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.availableTransforms','\"*\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.availableVolumes','\"*\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.cleanupHtml','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.columnType','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.configSelectionMode','\"choose\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.defaultTransform','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.manualConfig','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.purifierConfig','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.purifyHtml','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.redactorConfig','\"Standard.json\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.removeEmptyTags','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.removeInlineStyles','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.removeNbsp','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.showHtmlButtonForNonAdmins','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.showUnpermittedFiles','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.settings.uiMode','\"enlarged\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.1d242d6f-f863-4979-b2af-bb1da5c2aee2.type','\"craft\\\\redactor\\\\Field\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.contentColumnType','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.handle','\"headline\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.instructions','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.name','\"Headline\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.searchable','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.byteLimit','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.charLimit','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.code','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.columnType','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.initialRows','\"2\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.multiline','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.placeholder','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.settings.uiMode','\"normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.contentColumnType','\"string\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.handle','\"headlineStyle\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.instructions','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.name','\"Headline Style\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.searchable','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.optgroups','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.7574f2c5-ebea-4c7c-9efb-fabe0fc82275.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.contentColumnType','\"string\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.handle','\"layout\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.instructions','\"Some components can have different layout variations.\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.name','\"Layout\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.searchable','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.optgroups','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.b0be437c-c9b7-4725-b61e-01ae79d26892.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.contentColumnType','\"string\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.handle','\"background\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.instructions','\"Some components have different background options.\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.name','\"Background\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.searchable','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.optgroups','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.settings.options.0.__assoc__.2.1','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c2aae972-6c74-45e4-a721-cb093d6508db.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.contentColumnType','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.handle','\"buttons\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.instructions','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.name','\"Buttons\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.searchable','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.addRowLabel','\"Add Button\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.0','\"col1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.1.1','\"label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.0.1.__assoc__.3.1','\"singleline\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.0','\"col2\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.0.0','\"heading\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.0.1','\"URL\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.1.0','\"handle\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.1.1','\"url\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.2.0','\"width\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.2.1','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.3.0','\"type\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columns.__assoc__.1.1.__assoc__.3.1','\"url\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.columnType','\"text\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.maxRows','\"2\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.settings.minRows','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.c9c14235-dfc3-4c81-bb97-f3e3be70fb14.type','\"craft\\\\fields\\\\Table\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.contentColumnType','\"string\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.handle','\"images\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.instructions','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.name','\"Image(s)\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.searchable','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.allowedKinds.0','\"image\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.allowSelfRelations','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.allowUploads','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.defaultUploadLocationSource','\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.defaultUploadLocationSubpath','\"{owner.owner.type.handle}/{owner.owner.slug}/\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.limit','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.localizeRelations','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.previewMode','\"full\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.restrictFiles','\"1\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.selectionLabel','\"Add Image\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.showSiteMenu','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.showUnpermittedFiles','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.showUnpermittedVolumes','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.singleUploadLocationSource','\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.singleUploadLocationSubpath','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.source','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.sources.0','\"volume:dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.targetSiteId','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.useSingleFolder','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.validateRelatedElements','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.settings.viewMode','\"large\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.translationMethod','\"site\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.dda1fa64-dd45-42b6-8df9-476cbac15152.type','\"craft\\\\fields\\\\Assets\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.contentColumnType','\"string\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.fieldGroup','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.handle','\"spacing\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.instructions','\"How much spacing appears around the component.\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.name','\"Spacing\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.searchable','false'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.optgroups','true'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.0.0','\"label\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.0.1','\"Normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.1.0','\"value\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.1.1','\"normal\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.2.0','\"default\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.settings.options.0.__assoc__.2.1','\"\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.translationKeyFormat','null'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.translationMethod','\"none\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.fields.e8279648-aafc-4293-a410-7e3c587f89c2.type','\"craft\\\\fields\\\\Dropdown\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.handle','\"textImage\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.name','\"Text + Image\"'),('matrixBlockTypes.a39c9c32-2acb-47fd-ad36-7980c445a44e.sortOrder','2'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.handle','\"primaryNavigation\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.instructions','\"\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.maxNodes','\"\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.name','\"Primary Navigation\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Asset.enabled','\"\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Asset.permissions','\"*\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Category.enabled','\"1\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Category.permissions','\"*\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Entry.enabled','\"1\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.craft\\elements\\Entry.permissions','\"*\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.custom.enabled','\"1\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.permissions.verbb\\navigation\\nodetypes\\PassiveType.enabled','\"1\"'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.propagateNodes','false'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa','null'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.sortOrder','1'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.structure.maxLevels','null'),('navigation.navs.bf54b939-18ca-4edf-a1ac-956f04744f8e.structure.uid','\"e65a3b8e-1725-430e-8cdd-219eb8728a82\"'),('plugins.dospaces.edition','\"standard\"'),('plugins.dospaces.enabled','true'),('plugins.dospaces.schemaVersion','\"1.0.0\"'),('plugins.expanded-search.edition','\"standard\"'),('plugins.expanded-search.enabled','true'),('plugins.expanded-search.schemaVersion','\"0.0.1\"'),('plugins.fastcgi-cache-bust.edition','\"standard\"'),('plugins.fastcgi-cache-bust.enabled','true'),('plugins.fastcgi-cache-bust.schemaVersion','\"1.0.0\"'),('plugins.matrixmate.edition','\"standard\"'),('plugins.matrixmate.enabled','true'),('plugins.matrixmate.schemaVersion','\"1.0.0\"'),('plugins.minify.edition','\"standard\"'),('plugins.minify.enabled','true'),('plugins.minify.schemaVersion','\"1.0.0\"'),('plugins.reasons.edition','\"standard\"'),('plugins.reasons.enabled','true'),('plugins.reasons.schemaVersion','\"2.1.1\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.retcon.edition','\"standard\"'),('plugins.retcon.enabled','true'),('plugins.retcon.schemaVersion','\"1.0.0\"'),('plugins.seomatic.edition','\"standard\"'),('plugins.seomatic.enabled','true'),('plugins.seomatic.licenseKey','\"EWN15KQL316V7LBU4SWYKUUH\"'),('plugins.seomatic.schemaVersion','\"3.0.9\"'),('plugins.seomatic.settings.addHrefLang','true'),('plugins.seomatic.settings.addPaginatedHreflang','true'),('plugins.seomatic.settings.addXDefaultHrefLang','true'),('plugins.seomatic.settings.cpTitlePrefix','\"⚙ \"'),('plugins.seomatic.settings.cspNonce','\"\"'),('plugins.seomatic.settings.cspScriptSrcPolicies.0.__assoc__.0.0','\"policy\"'),('plugins.seomatic.settings.cspScriptSrcPolicies.0.__assoc__.0.1','\"\'self\'\"'),('plugins.seomatic.settings.devModeCpTitlePrefix','\"&#x1f6a7;⚙ \"'),('plugins.seomatic.settings.devModeTitlePrefix','\"&#x1f6a7; \"'),('plugins.seomatic.settings.displayAnalysisSidebar','true'),('plugins.seomatic.settings.displayPreviewSidebar','true'),('plugins.seomatic.settings.enableJsonLdEndpoint','false'),('plugins.seomatic.settings.enableMetaContainerEndpoint','false'),('plugins.seomatic.settings.enableSeoFileLinkEndpoint','false'),('plugins.seomatic.settings.environment','\"live\"'),('plugins.seomatic.settings.generatorEnabled','true'),('plugins.seomatic.settings.headersEnabled','true'),('plugins.seomatic.settings.lowercaseCanonicalUrl','\"1\"'),('plugins.seomatic.settings.maxDescriptionLength','155'),('plugins.seomatic.settings.maxTitleLength','70'),('plugins.seomatic.settings.metaCacheDuration','\"null\"'),('plugins.seomatic.settings.pluginName','\"SEOmatic\"'),('plugins.seomatic.settings.regenerateSitemapsAutomatically','true'),('plugins.seomatic.settings.renderEnabled','true'),('plugins.seomatic.settings.separatorChar','\"|\"'),('plugins.seomatic.settings.sidebarDisplayPreviewTypes.0','\"google\"'),('plugins.seomatic.settings.sidebarDisplayPreviewTypes.1','\"twitter\"'),('plugins.seomatic.settings.sidebarDisplayPreviewTypes.2','\"facebook\"'),('plugins.seomatic.settings.siteGroupsSeparate','\"1\"'),('plugins.seomatic.settings.sitemapsEnabled','true'),('plugins.seomatic.settings.siteUrlOverride','\"\"'),('plugins.seomatic.settings.socialMediaPreviewTarget','true'),('plugins.seomatic.settings.submitSitemaps','true'),('plugins.twigpack.edition','\"standard\"'),('plugins.twigpack.enabled','true'),('plugins.twigpack.schemaVersion','\"1.0.0\"'),('plugins.typogrify.edition','\"standard\"'),('plugins.typogrify.enabled','true'),('plugins.typogrify.schemaVersion','\"1.0.0\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.enableVersioning','true'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.handle','\"news\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.name','\"News\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.propagationMethod','\"all\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.enabledByDefault','true'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','true'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.template','\"_page\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.uriFormat','\"news/{slug}\"'),('sections.3721b4d6-42d5-41fc-b6e7-76204b42c91a.type','\"channel\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.enableVersioning','true'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.handle','\"pages\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.name','\"Pages\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.propagationMethod','\"all\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.enabledByDefault','true'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','true'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.template','\"_page\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.uriFormat','\"{parent.uri}/{slug}\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.structure.maxLevels','null'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.structure.uid','\"0f9bddc9-659f-4907-82a2-028748c7f504\"'),('sections.650e7d1d-63e5-42f9-b3ab-4febfb502723.type','\"structure\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.enableVersioning','true'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.handle','\"home\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.name','\"Home\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.propagationMethod','\"all\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.enabledByDefault','true'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','true'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.template','\"_page\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.uriFormat','\"__home__\"'),('sections.6ec26690-b0b1-410f-9bc5-1a5512e6dc3e.type','\"single\"'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.enableVersioning','true'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.handle','\"emergencyMessage\"'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.name','\"Emergency Message\"'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.propagationMethod','\"all\"'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.enabledByDefault','true'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','false'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.template','null'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.siteSettings.34463b82-dd3f-441c-b9c6-59c351e847aa.uriFormat','null'),('sections.7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c.type','\"single\"'),('siteGroups.bcb40c76-f64f-408f-b1da-edb455b3588d.name','\"Craft\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.baseUrl','\"@web\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.handle','\"default\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls','true'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.language','\"en-CA\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.name','\"Craft\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.primary','true'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.siteGroup','\"bcb40c76-f64f-408f-b1da-edb455b3588d\"'),('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Craft\"'),('system.schemaVersion','\"3.6.8\"'),('system.timeZone','\"America/Toronto\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocapitalize','true'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocomplete','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocorrect','true'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autofocus','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.class','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.disabled','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.id','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.instructions','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.label','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.max','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.min','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.name','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.orientation','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.placeholder','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.readonly','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.requirable','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.required','false'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.size','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.step','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.tip','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.title','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.warning','null'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.width','100'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.name','\"Content\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.sortOrder','1'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.handle','\"digitalOceanSpaces\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.hasUrls','true'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.name','\"Site\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.bucket','\"$DO_SPACES_BUCKET\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.contentDisposition','\"\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.endpoint','\"$DO_SPACES_ENDPOINT\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.expires','\"\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.keyId','\"$DO_SPACES_KEY\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.region','\"$DO_SPACES_REGION\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.secret','\"$DO_SPACES_SECRET\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.subfolder','\"@cdnSub/site\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.sortOrder','1'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.type','\"vaersaagod\\\\dospaces\\\\Volume\"'),('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.url','\"$DO_CDN_URL\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.autocapitalize','true'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.autocomplete','false'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.autocorrect','true'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.class','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.disabled','false'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.id','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.instructions','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.label','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.max','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.min','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.name','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.orientation','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.placeholder','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.readonly','false'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.requirable','false'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.size','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.step','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.tip','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.title','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\AssetTitleField\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.warning','null'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.elements.0.width','100'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.name','\"Content\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.fieldLayouts.f7245cee-41f8-4db2-8e8c-97be66059bcd.tabs.0.sortOrder','1'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.handle','\"images\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.hasUrls','true'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.name','\"Images\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.settings.path','\"images\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.sortOrder','2'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.type','\"craft\\\\volumes\\\\Local\"'),('volumes.dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60.url','\"/images/\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfignames`
--

LOCK TABLES `projectconfignames` WRITE;
/*!40000 ALTER TABLE `projectconfignames` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfignames` VALUES ('07a0012a-4bdf-4aaa-8415-bbe06adaf62c','Text'),('0adda131-0527-467d-8935-110db8ed3aad','News Index'),('0cdabc70-da3d-4a31-b6b7-dad81aabc3a8','Message Text'),('1d242d6f-f863-4979-b2af-bb1da5c2aee2','Text'),('1e0f22f0-2c77-45f2-a8dd-9405520e5ce0','Emergency Message'),('20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164','Headline'),('28948fc8-a354-4c75-a861-b11dda3c6929','Topics'),('2edaff57-1ee7-4c19-a3c9-7b8f0e40e49c','Where should it appear?'),('34463b82-dd3f-441c-b9c6-59c351e847aa','Craft'),('3721b4d6-42d5-41fc-b6e7-76204b42c91a','News'),('4e5aed85-0e72-4702-9a1a-3e9f3dfb55ca','Link URL to \"Learn More\"'),('5ad1a48a-0387-4098-89e7-bf69eed8508e','Layout'),('650e7d1d-63e5-42f9-b3ab-4febfb502723','Pages'),('6ec26690-b0b1-410f-9bc5-1a5512e6dc3e','Home'),('7574f2c5-ebea-4c7c-9efb-fabe0fc82275','Headline Style'),('7e15e458-b87d-4706-988c-83f1ba50204c','Topics'),('7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','Emergency Message'),('a345255e-6a6e-450c-8f3f-bd44bd0d7a91','Text'),('a39c9c32-2acb-47fd-ad36-7980c445a44e','Text + Image'),('a4f97962-52de-4b53-8422-5b833d1cd5fd','Site'),('a4fe99b5-7832-4eb2-9833-f551177bb821','Content Blocks'),('ac5efc25-68b4-4028-b704-548cebcb183f','\"Learn More\" Call-to-Action'),('b0be437c-c9b7-4725-b61e-01ae79d26892','Layout'),('b1c52a06-4990-43f5-90d3-898a48789556','Summary'),('b2c539bf-f3bf-4c27-81e6-cffc9cb8657d','Background'),('b51219b5-c15b-4ce1-ab72-ad00a1b7a25e','Home'),('bcb40c76-f64f-408f-b1da-edb455b3588d','Craft'),('bf54b939-18ca-4edf-a1ac-956f04744f8e','Primary Navigation'),('c0bba8e0-117d-4192-b3a3-ac1a1ed80a6b','Buttons'),('c2aae972-6c74-45e4-a721-cb093d6508db','Background'),('c9c14235-dfc3-4c81-bb97-f3e3be70fb14','Buttons'),('d25e2e5d-90aa-4551-bbb2-2ef3300099d1','Topics Index'),('d3282cfb-d044-4890-b553-9a0b87393027','News'),('d79b3073-00bf-430c-95d5-6d03d8303032','SEO'),('dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60','Images'),('dda1fa64-dd45-42b6-8df9-476cbac15152','Image(s)'),('e0521335-ccc2-4893-a505-4baacf112dee','Pages'),('e0dac603-c510-4bb5-8701-e25672d93744','Common'),('e2e0830e-80f8-4dfd-8edf-45b6f917cd2d','Headline'),('e3ee13e0-fc9a-44f0-bc39-783e24026d9c','Headline Style'),('e8279648-aafc-4293-a410-7e3c587f89c2','Spacing'),('fb1d50db-864b-4553-9fb0-d1d784dd98d9','Emergency Message'),('fdddeb54-6dc3-4563-a953-78d9c99db44a','Spacing');
/*!40000 ALTER TABLE `projectconfignames` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `reasons`
--

LOCK TABLES `reasons` WRITE;
/*!40000 ALTER TABLE `reasons` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `reasons` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('10344b9e','@bower/jquery/dist'),('1133e210','@app/web/assets/craftsupport/dist'),('131a9fec','@craft/web/assets/admintable/dist'),('18034672','@lib/garnishjs'),('1983f511','@app/web/assets/dashboard/dist'),('1a346739','@craft/web/assets/fields/dist'),('1af1aed4','@lib/fabric'),('1bbbce3','@lib/velocity'),('1d9c130b','@lib/jquery.payment'),('1fa14ed1','@app/web/assets/updateswidget/dist'),('20c76e31','@lib/vue'),('211b0cbf','@app/web/assets/recententries/dist'),('22bf4d67','@lib/jquery-touch-events'),('251b71a5','@lib/picturefill'),('25c2fc0','@nystudio107/webperf/assetbundles/webperf/dist'),('26a94552','@bower/jquery/dist'),('26cb7a32','@app/web/assets/dbbackup/dist'),('26e473d4','@lib/iframe-resizer'),('285126a','@appicons'),('2a474cc3','@lib/fileupload'),('2b011dc7','@lib/jquery.payment'),('2bbe51f4','@lib/d3'),('31504f4c','@lib/iframe-resizer'),('32af4d3d','@lib/picturefill'),('32d7a943','@craft/web/assets/matrix/dist'),('350b71ff','@lib/jquery-touch-events'),('36071525','@app/web/assets/matrix/dist'),('3726b22f','@lib/velocity'),('378d7b76','@lib/prismjs'),('37e0f16b','@mmikkel/reasons/assetbundles/reasons/dist'),('38683e4c','@app/web/assets/login/dist'),('3c0a6d6c','@lib/d3'),('3c562b32','@app/web/assets/cp/dist'),('3d6450f','@craft/web/assets/dashboard/dist'),('3df3705b','@lib/fileupload'),('3e69c922','@modules/sitemodule/assetbundles/sitemodule/dist'),('3fa4e06b','@lib/element-resize-detector'),('454d608c','@app/web/assets/feed/dist'),('45805e80','@craft/web/assets/craftsupport/dist'),('45c5670f','@lib/axios'),('47463141','@app/web/assets/admintable/dist'),('495216a8','@lib/velocity'),('4d86e94d','@craft/web/assets/login/dist'),('4f05ec27','@vaersaagod/matrixmate/assetbundles/matrixmate/dist'),('4f122746','@lib/jquery-ui'),('4f17798c','@craft/web/assets/dbbackup/dist'),('53427c46','@lib/timepicker'),('538ee297','@craft/web/assets/recententries/dist'),('5575b940','@lib/jquery.payment'),('5741c00','@nystudio107/seomatic/assetbundles/seomatic/dist'),('58dde1d5','@bower/jquery/dist'),('5e2d69a3','@app/web/assets/utilities/dist'),('5eb3cab6','@lib/vue'),('60fe45f0','@craft/web/assets/cp/dist'),('66d160b9','@lib/selectize'),('67e3a60','@app/web/assets/updates/dist'),('6985758d','@craft/web/assets/pluginstore/dist'),('6a66eac5','@modules/sitemodule/assetbundles/sitemodule/dist'),('6cbd2433','@lib/xregexp'),('6d34a0f9','@craft/web/assets/updateswidget/dist'),('71655c21','@lib/selectize'),('735869c3','@lib/axios'),('73afc83a','@craft/web/assets/generalsettings/dist'),('774a7968','@craft/web/assets/cp/dist'),('774d4a20','@lib/element-resize-detector'),('798a7740','@craft/web/assets/dbbackup/dist'),('798f298a','@lib/jquery-ui'),('7a9563c4','@craft/web/assets/feed/dist'),('7b0918ab','@lib/xregexp'),('7b1be781','@craft/web/assets/login/dist'),('7f72c7a5','@lib/datepicker-i18n'),('7fb8d0d','@lib/jquery-ui'),('8009f0d6','@lib/selectize'),('825d9a3c','@lib/fabric'),('847676e7','@lib/fileupload'),('8621e6d7','@lib/element-resize-detector'),('88d549f0','@lib/iframe-resizer'),('8a65b45c','@lib/xregexp'),('8cce4d7f','@craft/web/assets/dashboard/dist'),('9195da4f','@lib/element-resize-detector'),('923b5748','@lib/d3'),('939eea7','@lib/element-resize-detector'),('943d471e','@craft/web/assets/utilities/dist'),('971b4e02','@lib/garnishjs'),('9b3a4bdb','@lib/jquery-touch-events'),('9c9e7719','@lib/picturefill'),('a18640ce','@lib/garnishjs'),('a2a049d2','@craft/web/assets/utilities/dist'),('a395f0e3','@app/web/assets/feed/dist'),('a41915b7','@lib/jquery.payment'),('a4a65984','@lib/d3'),('a9b14d22','@bower/jquery/dist'),('aa0379d5','@lib/picturefill'),('ada74517','@lib/jquery-touch-events'),('af214f9e','@lib/prismjs'),('af8a86c7','@lib/velocity'),('b2eb782b','@lib/fileupload'),('b3ad292f','@lib/jquery.payment'),('b4c094f0','@lib/fabric'),('b7336580','@modules/sitemodule/assetbundles/sitemodule/dist'),('b83eba5f','@lib/velocity'),('b8f5f9cc','@app/web/assets/utilities/dist'),('ba6cbd29','@modules/sitemodule/assetbundles/sitemodule/dist'),('be0571ba','@bower/jquery/dist'),('c013ea5d','@app/web/assets/dbbackup/dist'),('c03ce3bb','@lib/iframe-resizer'),('c1b6f676','@app/web/assets/pluginstore/dist'),('c28c1e17','@lib/xregexp'),('c29ee13d','@craft/web/assets/login/dist'),('c3e36e54','@nystudio107/retour/assetbundles/retour/dist'),('c61ffe5e','@lib/vue'),('c7c39cd0','@app/web/assets/recententries/dist'),('c8e05a9d','@lib/selectize'),('ca9856f0','@craft/web/assets/craftsupport/dist'),('cc9fdcac','@lib/fileupload'),('cd1276b8','@modules/sitemodule/assetbundles/sitemodule/dist'),('cecf7fd4','@craft/web/assets/cp/dist'),('d2ccd44','@lib/axios'),('d3d3e190','@lib/jquery-touch-events'),('d45924c','@lib/fabric'),('d477dd52','@lib/picturefill'),('da8ebb5d','@app/web/assets/cp/dist'),('dad2fd03','@lib/d3'),('dc96eae7','@craft/web/assets/recententries/dist'),('deb0ae23','@app/web/assets/login/dist'),('df8aed21','@nystudio107/seomatic/assetbundles/seomatic/dist'),('e1231d62','@lib/jquery-ui'),('e22ca889','@craft/web/assets/updateswidget/dist'),('e829904b','@craft/web/assets/plugins/dist'),('e900d280','@nystudio107/seomatic/assetbundles/seomatic/dist'),('e92c8c81','@app/web/assets/updater/dist'),('e96fea85','@lib/garnishjs'),('ebf45d2b','@lib/axios'),('f1294165','@craft/web/assets/pluginstore/dist'),('f40fcc9d','@nystudio107/webperf/assetbundles/boomerang/dist/js'),('f41110db','@lib/xregexp'),('f58d6bb4','@craft/web/assets/feed/dist'),('f665e8ae','@nystudio107/seomatic/assetbundles/seomatic/dist'),('f69721fa','@lib/jquery-ui'),('f7eb727f','@app/web/assets/craftsupport/dist'),('f8527118','@craft/web/assets/cp/dist'),('f979debe','@app/web/assets/updateswidget/dist'),('fb77aea','@lib/garnishjs'),('fc293ebb','@lib/fabric'),('fc4061b3','@lib/axios'),('fe7d5451','@lib/selectize'),('ff5b657e','@app/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_redirects`
--

LOCK TABLES `retour_redirects` WRITE;
/*!40000 ALTER TABLE `retour_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_static_redirects`
--

LOCK TABLES `retour_static_redirects` WRITE;
/*!40000 ALTER TABLE `retour_static_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `retour_static_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `retour_stats`
--

LOCK TABLES `retour_stats` WRITE;
/*!40000 ALTER TABLE `retour_stats` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `retour_stats` VALUES (1,'2020-03-27 13:32:33','2020-11-18 21:37:47','d51a6505-12b4-479c-8521-90eec927b370',1,'/favicon.ico','http://localhost:8000/','172.26.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36','Template not found: favicon.ico','/var/www/project/cms/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,7,'2020-11-18 21:37:47',0),(2,'2020-10-16 15:31:42','2020-10-16 15:31:42','32f201b5-aa6a-47cb-9167-8f4455303414',1,'/webperf/metrics/beacon','http://localhost:8000/','172.26.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36','Template not found: webperf/metrics/beacon','/var/www/project/cms/vendor/craftcms/cms/src/controllers/TemplatesController.php',92,1,'2020-10-16 15:31:42',0);
/*!40000 ALTER TABLE `retour_stats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,3,NULL,1,NULL),(2,5,NULL,1,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,2,' admin '),(1,'firstname',0,2,''),(1,'lastname',0,2,''),(1,'fullname',0,2,''),(1,'email',0,2,' steve simplicate ca '),(1,'slug',0,2,''),(2,'title',0,1,' homepage '),(2,'slug',0,1,' homepage '),(3,'slug',0,2,' home '),(3,'title',0,2,' home '),(3,'field',4,2,''),(5,'slug',0,2,' emergency message '),(5,'title',0,2,' emergency message ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (4,NULL,'Errors','errors','channel',0,'all',NULL,'2020-03-27 13:38:49','2020-03-27 13:38:49','2021-05-18 19:10:50','a72bfe0c-3389-4f9f-8ec1-ab318ec10b29'),(5,NULL,'Homepage','homepage','single',0,'all',NULL,'2020-03-27 13:38:49','2020-03-27 13:38:49','2021-05-18 19:10:51','54e60257-f31a-44aa-960e-bbd364197e28'),(6,2,'Pages','pages','structure',1,'all',NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'650e7d1d-63e5-42f9-b3ab-4febfb502723'),(7,NULL,'Home','home','single',1,'all',NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'6ec26690-b0b1-410f-9bc5-1a5512e6dc3e'),(8,NULL,'Emergency Message','emergencyMessage','single',1,'all',NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c'),(9,NULL,'News','news','channel',1,'all',NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'3721b4d6-42d5-41fc-b6e7-76204b42c91a');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,4,1,0,NULL,NULL,1,'2020-03-27 13:38:49','2020-03-27 13:38:49','c343dc66-853c-45b7-bde8-93a71c6d7d5a'),(2,5,1,1,'__home__','index',1,'2020-03-27 13:38:49','2020-03-27 13:38:49','94d75213-7345-4ed4-9251-15f5d2f8a915'),(3,6,2,1,'{parent.uri}/{slug}','_page',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','44eb44c9-767c-4710-b314-7e7d4f2b5463'),(4,7,2,1,'__home__','_page',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','f4cc25f1-1558-4b06-9f16-4fa3a58c8614'),(5,8,2,0,NULL,NULL,1,'2021-05-18 19:10:51','2021-05-18 19:10:51','385df5d3-eaff-4195-a3b0-2de4b623623d'),(6,9,2,1,'news/{slug}','_page',1,'2021-05-18 19:10:51','2021-05-18 19:10:51','1ae8e545-b02f-45f8-889b-16c4a57fe9a0');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2020-03-27 13:29:52','2021-05-18 19:10:51','54bcfb25-90fc-40ce-8a49-7ff73bee5bd6','1.0.56','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2021-05-18 19:10:51','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Project\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"nystudio107\",\"genericAlternateName\":\"nys\",\"genericDescription\":\"We do technology-based consulting, branding, design, and development. Making the web better one site at a time, with a focus on performance, usability & SEO\",\"genericUrl\":\"https://nystudio107.com/\",\"genericImage\":\"https://nystudio107-ems2qegf7x6qiqq.netdna-ssl.com/img/site/nys_logo_seo.png\",\"genericImageWidth\":\"1042\",\"genericImageHeight\":\"1042\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"info@nystudio107.com\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"Webster\",\"genericAddressRegion\":\"NY\",\"genericPostalCode\":\"14580\",\"genericAddressCountry\":\"US\",\"genericGeoLatitude\":\"43.2365384\",\"genericGeoLongitude\":\"-77.49211620000001\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"Andrew Welch, Polly Welch\",\"organizationFoundingDate\":\"2013-05-02\",\"organizationFoundingLocation\":\"Webster, NY\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{seomatic.meta.robots}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"//{{ scriptUrl.value }}/\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2020-03-27 13:38:49','2021-05-18 19:10:51','5e1950fb-88fb-41ee-8b5f-051ba6490e0c','1.0.29','section',5,'Homepage','homepage','single',NULL,'index',1,'{\"1\":{\"id\":2,\"sectionId\":5,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"index\",\"language\":\"en-us\"}}','2020-10-16 15:16:16','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Friends of Webster Trails\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(3,'2021-05-18 19:10:51','2021-05-18 19:10:51','1d6e47ef-31e3-4738-92f2-dc8e986072fc','1.0.29','section',7,'Home','home','single',NULL,'_page',2,'{\"2\":{\"id\":4,\"sectionId\":7,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"_page\",\"language\":\"en-ca\"}}','2021-05-18 19:10:51','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{entry.title}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{entry.url}\",\"robots\":\"\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"breadcrumb\":null,\"lastReviewed\":null,\"mainContentOfPage\":null,\"primaryImageOfPage\":null,\"relatedLink\":null,\"reviewedBy\":null,\"significantLink\":null,\"speakable\":null,\"specialty\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":\"{entry.postDate | date(\\\"Y\\\")}\",\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"dateCreated\":false,\"dateModified\":\"{entry.dateUpdated |atom}\",\"datePublished\":\"{entry.postDate |atom}\",\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":\"{seomatic.meta.seoTitle}\",\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#creator\"},\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebPage\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromField\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"sameAsGlobal\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"sameAsGlobal\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"sameAsGlobal\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(4,'2021-05-18 19:11:05','2021-05-18 19:11:05','716eaca8-1e58-4804-b46f-ec90cfb4eb98','1.0.56','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',2,'[]','2021-05-18 19:11:05','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}','{\"siteName\":\"Craft\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{seomatic.meta.robots}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Measurement/Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `G-XXXXXXXXXX` or `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"//{{ scriptUrl.value }}/\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics (old)\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{parseEnv(seomatic.site.identity.genericUrl)}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{parseEnv(seomatic.site.creator.genericUrl)}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
/*!40000 ALTER TABLE `seomatic_metabundles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'$SITE_NAME','2020-03-27 13:22:43','2021-05-18 19:10:51','2021-05-18 19:10:51','f89601e9-4ba9-4a48-9e99-350aa9914912'),(2,'Craft','2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'bcb40c76-f64f-408f-b1da-edb455b3588d');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,0,1,'$SITE_NAME','default','en-US',1,'$SITE_URL',1,'2020-03-27 13:22:43','2021-05-18 19:10:51','2021-05-18 19:10:51','5da841b1-ca0d-46ff-8bb1-04d6c889ac54'),(2,2,1,1,'Craft','default','en-CA',1,'@web',1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'34463b82-dd3f-441c-b9c6-59c351e847aa');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'2b4d73cc-b09e-4bae-8a4d-5a7b6190a358'),(2,NULL,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'0f9bddc9-659f-4907-82a2-028748c7f504');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'steve@simplicate.ca','$2y$13$1T4tNxdkGV329wX0I0nDtekV7lr97dEQUL/TNdo4cVdhoitgSYIRC',1,0,0,0,'2021-05-19 04:31:28',NULL,NULL,NULL,'2020-12-06 22:48:03',NULL,1,NULL,NULL,NULL,0,'2020-03-27 13:22:44','2020-03-27 13:22:44','2021-05-19 04:31:28','6aaac777-3f7f-4a59-9f21-06bcb8de9a13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Site','','2020-03-27 13:38:49','2020-03-27 13:38:49','06e0e3c7-6e7a-4bdd-8f29-c732a9b33766'),(2,NULL,NULL,'Temporary source',NULL,'2020-03-27 13:39:48','2020-03-27 13:39:48','2bb19851-ae57-499e-adf9-c1d0aec186ae'),(3,2,NULL,'user_1','user_1/','2020-03-27 13:39:48','2020-03-27 13:39:48','34f058d0-d16c-436b-8513-c46d815c95d0'),(4,NULL,2,'Images','','2021-05-18 19:10:51','2021-05-18 19:10:51','bb28f31c-32c2-4b2e-8c9d-86388699652f'),(5,NULL,3,'Site','','2021-05-18 19:10:51','2021-05-18 19:10:51','4c320b31-f062-4b59-a43f-969f0b7d9975');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Site','site','craft\\volumes\\Local',1,'@assetsUrl/assets/site','site',NULL,'{\"path\":\"@webroot/assets/site\"}',1,'2020-03-27 13:38:49','2020-03-27 13:38:49','2021-05-18 19:10:51','5c642d7e-b16b-4836-9575-668d75d242e5'),(2,1,'Images','images','craft\\volumes\\Local',1,'/images/','site',NULL,'{\"path\":\"images\"}',2,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'dbe1ed1e-73d5-4e8e-a67a-3928f44b1a60'),(3,2,'Site','digitalOceanSpaces','vaersaagod\\dospaces\\Volume',1,'$DO_CDN_URL','site',NULL,'{\"bucket\":\"$DO_SPACES_BUCKET\",\"contentDisposition\":\"\",\"endpoint\":\"$DO_SPACES_ENDPOINT\",\"expires\":\"\",\"keyId\":\"$DO_SPACES_KEY\",\"region\":\"$DO_SPACES_REGION\",\"secret\":\"$DO_SPACES_SECRET\",\"subfolder\":\"@cdnSub/site\"}',1,'2021-05-18 19:10:51','2021-05-18 19:10:51',NULL,'a4f97962-52de-4b53-8422-5b833d1cd5fd');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_data_samples`
--

LOCK TABLES `webperf_data_samples` WRITE;
/*!40000 ALTER TABLE `webperf_data_samples` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `webperf_data_samples` VALUES (1,'2020-11-18 21:37:26','2020-11-18 21:37:27','ea0ce6d2-0729-438c-a965-aa494b278c10',8947159563722028624,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1587,1736,1736,1689,2022,'??','Macintosh','Chrome 86.0.4240.198','OS X Catalina 10.15',0,1722,50,49,0,0,1672,488,9581568),(3,'2020-12-02 16:08:42','2020-12-02 16:08:42','4a9f192e-8cfa-4a02-8710-90cf1a0816cf',8824185223071447740,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1189,1329,1329,1282,1525,'??','Macintosh','Chrome 87.0.4280.67','OS X Catalina 10.15',0,971,36,49,0,0,935,487,8870288),(4,'2020-12-06 22:47:55','2020-12-06 22:47:56','97d226f0-3c08-4411-864e-4c83a52fe704',5704165093160125832,1,'&#x1f6a7; Project | Homepage','http://localhost:8000/',NULL,NULL,NULL,1211,1409,1409,1308,1539,'??','Macintosh','Chrome 87.0.4280.67','OS X Catalina 10.15',0,1031,28,45,0,0,1002,488,8758504);
/*!40000 ALTER TABLE `webperf_data_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `webperf_error_samples`
--

LOCK TABLES `webperf_error_samples` WRITE;
/*!40000 ALTER TABLE `webperf_error_samples` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `webperf_error_samples` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','2f8142d5-2827-4555-a01d-6febb92a5a37'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','ce3eb9de-186b-4978-afa5-ec0ed9dc8ddb'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','8fe2cacd-6ad5-45be-a48d-c9c9ba814765'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-03-27 13:39:27','2020-03-27 13:39:27','fc1f719e-cf8d-4f24-a58f-d980812b3b32');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'project'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-19  4:31:31
