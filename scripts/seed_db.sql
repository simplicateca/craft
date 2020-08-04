-- Adminer 4.6.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `assetindexdata`;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `assets`;
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


DROP TABLE IF EXISTS `assettransformindex`;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `assettransforms`;
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


DROP TABLE IF EXISTS `categories`;
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


DROP TABLE IF EXISTS `categorygroups`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `categorygroups_sites`;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `changedattributes`;
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


DROP TABLE IF EXISTS `changedfields`;
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


DROP TABLE IF EXISTS `content`;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	1,	1,	NULL,	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'783aa1ef-ac70-4eb6-a286-236c2fa01266');

DROP TABLE IF EXISTS `craftidtokens`;
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


DROP TABLE IF EXISTS `deprecationerrors`;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `drafts`;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `elementindexsettings`;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `elements`;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `elements` (`id`, `draftId`, `revisionId`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1,	NULL,	NULL,	NULL,	'craft\\elements\\User',	1,	0,	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	NULL,	'11a86659-4de5-426a-94ce-a3e8d99f824e');

DROP TABLE IF EXISTS `elements_sites`;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	1,	1,	NULL,	NULL,	1,	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a17acdb3-c07c-4ce6-bdcf-4a7154db8180');

DROP TABLE IF EXISTS `entries`;
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
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `entrytypes`;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fieldgroups`;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldgroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	'Common',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e0dac603-c510-4bb5-8701-e25672d93744');

DROP TABLE IF EXISTS `fieldlayoutfields`;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `fieldlayouts`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1,	'craft\\elements\\Asset',	'2020-08-04 20:30:39',	'2020-08-04 20:30:39',	NULL,	'155d9590-a8a9-44a0-b379-c089f17b9c37');

DROP TABLE IF EXISTS `fieldlayouttabs`;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `elements`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	1,	'Content',	'[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autofocus\":false,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100}]',	1,	'2020-08-04 20:30:39',	'2020-08-04 20:30:39',	'f7e39fcf-abc1-4032-92a2-a18a281b2a2a');

DROP TABLE IF EXISTS `fields`;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fields_handle_context_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `globalsets`;
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


DROP TABLE IF EXISTS `gqlschemas`;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `gqltokens`;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `info`;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	'3.5.0',	'3.5.12',	0,	'smkwnrmbxtwz',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3360e9a1-2c7b-4cd1-8634-4d02436d2a85');

DROP TABLE IF EXISTS `matrixblocks`;
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


DROP TABLE IF EXISTS `matrixblocktypes`;
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
  KEY `matrixblocktypes_name_fieldId_idx` (`name`,`fieldId`),
  KEY `matrixblocktypes_handle_fieldId_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `migrations`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `migrations` (`id`, `track`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	'craft',	'Install',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'66c89541-2aed-4601-bf3e-48b2055984b6'),
(2,	'craft',	'm150403_183908_migrations_table_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'b12b9533-4c9b-40c7-b359-6b1ab660c091'),
(3,	'craft',	'm150403_184247_plugins_table_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4a648ab4-c838-4c76-9311-2e154cea7f87'),
(4,	'craft',	'm150403_184533_field_version',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'6ab5be35-05bb-48e4-b7cf-9f547a5abdf7'),
(5,	'craft',	'm150403_184729_type_columns',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'09f951ff-be59-4b6a-8795-2bb7c2090ce5'),
(6,	'craft',	'm150403_185142_volumes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cec15148-3b44-4882-a9a4-262bc52c50a9'),
(7,	'craft',	'm150428_231346_userpreferences',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'9972eccf-fc40-41e6-b1aa-61d2c56bfae7'),
(8,	'craft',	'm150519_150900_fieldversion_conversion',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'33d5e353-f78e-4ab4-8b49-8a279244b26a'),
(9,	'craft',	'm150617_213829_update_email_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'b6fd956d-4344-45a3-b8b0-878deda31bed'),
(10,	'craft',	'm150721_124739_templatecachequeries',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'9e73e26a-89b5-46f2-af26-6a96672d259d'),
(11,	'craft',	'm150724_140822_adjust_quality_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'd3daa084-f892-45c8-84d8-858a754aa87b'),
(12,	'craft',	'm150815_133521_last_login_attempt_ip',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'8578e673-dfa4-4cd2-b7b6-2b0ca9359ef9'),
(13,	'craft',	'm151002_095935_volume_cache_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e69d60cc-dfb1-4de8-9238-85913275a0a2'),
(14,	'craft',	'm151005_142750_volume_s3_storage_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'6bd14eac-d2d9-44c4-8993-8d24866f910a'),
(15,	'craft',	'm151016_133600_delete_asset_thumbnails',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7a9366cb-4718-4f2b-ad8b-7b934e4b8f18'),
(16,	'craft',	'm151209_000000_move_logo',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e036483d-6bff-4297-b513-a9582a100a0c'),
(17,	'craft',	'm151211_000000_rename_fileId_to_assetId',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cc644278-ad01-4f15-8465-8f4737679429'),
(18,	'craft',	'm151215_000000_rename_asset_permissions',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'c687aeeb-30f8-4fc5-bd68-f6c3ab3b6a6c'),
(19,	'craft',	'm160707_000001_rename_richtext_assetsource_setting',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'017efd7f-0c11-4cf3-bb3b-95dad9ba564c'),
(20,	'craft',	'm160708_185142_volume_hasUrls_setting',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'25f66501-c776-4a88-bdc8-a632ce75515a'),
(21,	'craft',	'm160714_000000_increase_max_asset_filesize',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'69e3104e-c3d2-4577-bb2b-c766cdb962b0'),
(22,	'craft',	'm160727_194637_column_cleanup',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4590fa1f-d46d-419d-a3f7-d3aec08cefca'),
(23,	'craft',	'm160804_110002_userphotos_to_assets',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'601c923d-730c-4d22-8420-d2c6c0fb375c'),
(24,	'craft',	'm160807_144858_sites',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'aab6b36f-7f09-4633-aa25-0ecb1dc85608'),
(25,	'craft',	'm160829_000000_pending_user_content_cleanup',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2a1a91c3-dc19-46a2-b1d1-97ce68ab9a6b'),
(26,	'craft',	'm160830_000000_asset_index_uri_increase',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'fbb45020-633c-4d51-983f-c7c86635f48b'),
(27,	'craft',	'm160912_230520_require_entry_type_id',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'28ba7c06-8689-46eb-8f87-41240817843d'),
(28,	'craft',	'm160913_134730_require_matrix_block_type_id',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'86db3d05-03c1-44b9-b46d-88c50d1c097a'),
(29,	'craft',	'm160920_174553_matrixblocks_owner_site_id_nullable',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4728f779-4399-4f7d-b17e-bc9a83aaf7ca'),
(30,	'craft',	'm160920_231045_usergroup_handle_title_unique',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3a621c7f-7b7a-48ac-9c85-3d7173db1fd1'),
(31,	'craft',	'm160925_113941_route_uri_parts',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'c5323872-6bb9-432d-8011-46bfed5d75e3'),
(32,	'craft',	'm161006_205918_schemaVersion_not_null',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1875452e-a9d5-4dfd-b342-dd3382a6410f'),
(33,	'craft',	'm161007_130653_update_email_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'6ecdffe6-9d19-4fe1-9d90-7cea69fa9a83'),
(34,	'craft',	'm161013_175052_newParentId',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'c08b4e2f-9ab1-4434-8a01-896051c82efe'),
(35,	'craft',	'm161021_102916_fix_recent_entries_widgets',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'55973a35-f3d3-4cd3-8ea2-3abdcdfdb7f4'),
(36,	'craft',	'm161021_182140_rename_get_help_widget',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a95928c5-5357-4b68-a487-1c62109f0780'),
(37,	'craft',	'm161025_000000_fix_char_columns',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'9423de50-5944-4a3f-abbb-0baee4d48290'),
(38,	'craft',	'm161029_124145_email_message_languages',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7ef82439-e608-4489-a827-0560efd57ab5'),
(39,	'craft',	'm161108_000000_new_version_format',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3eb085e0-6d34-4fb2-92db-3584837d28e8'),
(40,	'craft',	'm161109_000000_index_shuffle',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'78213206-1dcd-4a72-81a7-4bcf8aee7b0a'),
(41,	'craft',	'm161122_185500_no_craft_app',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'49b1ebc9-a5ef-48ff-a977-1445a857c902'),
(42,	'craft',	'm161125_150752_clear_urlmanager_cache',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'201e3ff6-974f-4996-aef6-dc1a167e31ab'),
(43,	'craft',	'm161220_000000_volumes_hasurl_notnull',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'837bad68-56b5-4d3d-940d-24244e18a43f'),
(44,	'craft',	'm170114_161144_udates_permission',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'718a411a-13f4-4a81-b646-1e1a40c82553'),
(45,	'craft',	'm170120_000000_schema_cleanup',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'427c2349-bd5c-4f6b-ae89-6fd9bca40df6'),
(46,	'craft',	'm170126_000000_assets_focal_point',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'079411d2-d419-471a-b77c-87da2d5017cd'),
(47,	'craft',	'm170206_142126_system_name',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a249e800-4b29-400e-bf47-838d357d248f'),
(48,	'craft',	'm170217_044740_category_branch_limits',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a7ab992f-c19f-4f4c-b7aa-085fb5980332'),
(49,	'craft',	'm170217_120224_asset_indexing_columns',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'328ead08-d5c6-4e2f-b8c4-57e871257c6b'),
(50,	'craft',	'm170223_224012_plain_text_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'03b145ee-906e-4d58-a53f-69de088b9aeb'),
(51,	'craft',	'm170227_120814_focal_point_percentage',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7e5b28ad-9997-4d2b-928e-88aa8bf36574'),
(52,	'craft',	'm170228_171113_system_messages',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a703f55f-5e25-4fce-a87c-56f76a6b847b'),
(53,	'craft',	'm170303_140500_asset_field_source_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'28457986-8a22-4569-9129-98fd0487ea85'),
(54,	'craft',	'm170306_150500_asset_temporary_uploads',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cdd6e32e-0a7c-4db1-8447-69f7b434aab6'),
(55,	'craft',	'm170523_190652_element_field_layout_ids',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'be06052c-56ab-4d3e-a600-c9159b2a4c58'),
(56,	'craft',	'm170612_000000_route_index_shuffle',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e07bfecd-f70e-4f95-92ac-b47e44b9837f'),
(57,	'craft',	'm170621_195237_format_plugin_handles',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1c01712f-6a76-459c-879f-c82f44aeb9ce'),
(58,	'craft',	'm170630_161027_deprecation_line_nullable',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3271b5ac-de05-4b15-bb52-0ab0514cbd0e'),
(59,	'craft',	'm170630_161028_deprecation_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'98758f47-c842-47ce-acef-a493df6c380b'),
(60,	'craft',	'm170703_181539_plugins_table_tweaks',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'903c9049-e3a4-4c7c-8a8e-882e1afa6315'),
(61,	'craft',	'm170704_134916_sites_tables',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'586d6bbd-3960-4435-96da-59bc88caee5f'),
(62,	'craft',	'm170706_183216_rename_sequences',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'fe75a096-3d32-485c-b160-37e878e58d58'),
(63,	'craft',	'm170707_094758_delete_compiled_traits',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'ec65ad1b-edc2-4384-ab19-4f6941012393'),
(64,	'craft',	'm170731_190138_drop_asset_packagist',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'89a878fc-8bfa-41f8-8b52-01b1f8b43e28'),
(65,	'craft',	'm170810_201318_create_queue_table',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'6ebb17bc-3585-4d81-a97a-874082a2d918'),
(66,	'craft',	'm170903_192801_longblob_for_queue_jobs',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'fd8b54d6-7141-438d-bda6-4ba13bb26cc7'),
(67,	'craft',	'm170914_204621_asset_cache_shuffle',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'25279ecb-5d9a-40c2-8b1d-d7fbe12408a9'),
(68,	'craft',	'm171011_214115_site_groups',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'555ec8a2-b198-4df9-8a35-259a8981ce0b'),
(69,	'craft',	'm171012_151440_primary_site',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'10b084af-8371-4ab7-9812-a5db98bc08d2'),
(70,	'craft',	'm171013_142500_transform_interlace',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4caef809-3a01-484e-9cb0-5e3a19df171b'),
(71,	'craft',	'm171016_092553_drop_position_select',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f33e260d-cd42-4f89-b5cf-bd5a905105c1'),
(72,	'craft',	'm171016_221244_less_strict_translation_method',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'9ac1cf3a-7e49-4c4f-8520-7452ebcf3a99'),
(73,	'craft',	'm171107_000000_assign_group_permissions',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'ed65a112-fb8f-4cd6-8c6d-6b3732652a92'),
(74,	'craft',	'm171117_000001_templatecache_index_tune',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f0d4623b-2f93-423e-a65f-b4f44d5749ad'),
(75,	'craft',	'm171126_105927_disabled_plugins',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2a11c30b-cedf-4eb3-baaf-45b9c75b0795'),
(76,	'craft',	'm171130_214407_craftidtokens_table',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3efcb8ec-7c77-4e05-857f-8fe47120b6a3'),
(77,	'craft',	'm171202_004225_update_email_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'70621778-db6a-48ac-a2db-6b85c2ad515e'),
(78,	'craft',	'm171204_000001_templatecache_index_tune_deux',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'8406dfb2-9fb2-4377-802b-07553786d4fb'),
(79,	'craft',	'm171205_130908_remove_craftidtokens_refreshtoken_column',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'ed763197-8027-4e09-ad46-ee152f98e3e6'),
(80,	'craft',	'm171218_143135_longtext_query_column',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'ced6e8da-6c8d-4a33-aeab-cec5410bb570'),
(81,	'craft',	'm171231_055546_environment_variables_to_aliases',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'87516f37-b33b-4bba-acdc-5f340b97f6db'),
(82,	'craft',	'm180113_153740_drop_users_archived_column',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1ece23e7-f695-488f-b062-60dc91a6945e'),
(83,	'craft',	'm180122_213433_propagate_entries_setting',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'8789bce9-46e4-42a6-9155-181e80d06375'),
(84,	'craft',	'm180124_230459_fix_propagate_entries_values',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7b292879-cd9a-465a-b0d8-38f9f2d7ccb4'),
(85,	'craft',	'm180128_235202_set_tag_slugs',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7632b126-06cf-4111-9b51-3d342f75c1de'),
(86,	'craft',	'm180202_185551_fix_focal_points',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7c63d615-7e7f-4514-8fba-17b3da48c187'),
(87,	'craft',	'm180217_172123_tiny_ints',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'31c89e71-0004-4fd6-87d4-86105328e866'),
(88,	'craft',	'm180321_233505_small_ints',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'b117976b-991f-4173-a123-1ab882795d3f'),
(89,	'craft',	'm180328_115523_new_license_key_statuses',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'84b716bd-f7d8-4920-bffe-d9a351876e07'),
(90,	'craft',	'm180404_182320_edition_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'65bc2488-14e2-4770-889a-0751d5afcdfe'),
(91,	'craft',	'm180411_102218_fix_db_routes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'68a49b17-9fb1-4796-b192-a01449eab0f8'),
(92,	'craft',	'm180416_205628_resourcepaths_table',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'280a117b-7637-44c6-a670-23e70adda7d5'),
(93,	'craft',	'm180418_205713_widget_cleanup',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cf5892d6-3017-4902-a802-64f7371542c4'),
(94,	'craft',	'm180425_203349_searchable_fields',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'bd4e960b-b065-4593-9aa0-69a26334a622'),
(95,	'craft',	'm180516_153000_uids_in_field_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7fe03b31-2fec-423b-ad35-08f787194c8e'),
(96,	'craft',	'm180517_173000_user_photo_volume_to_uid',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'b9d12cc2-7c0e-4532-a24b-4a5e7e10de65'),
(97,	'craft',	'm180518_173000_permissions_to_uid',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'30f36f2b-c875-4a92-9958-140ee7fed5ff'),
(98,	'craft',	'm180520_173000_matrix_context_to_uids',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'bbdd6749-002c-4216-88d1-ae47086a48e4'),
(99,	'craft',	'm180521_172900_project_config_table',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'434c0d8f-0971-4cb7-871f-e65eba2d4bd5'),
(100,	'craft',	'm180521_173000_initial_yml_and_snapshot',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4c56e9a2-cdf4-490d-83d8-d66a5b1bd5e4'),
(101,	'craft',	'm180731_162030_soft_delete_sites',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e31f4a10-2950-4245-ba3f-8b58f8360995'),
(102,	'craft',	'm180810_214427_soft_delete_field_layouts',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f13ec39c-c9e6-441f-95cf-8c114cd55b74'),
(103,	'craft',	'm180810_214439_soft_delete_elements',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2139b446-0f21-4d58-91c2-7c48a4dbbbe1'),
(104,	'craft',	'm180824_193422_case_sensitivity_fixes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f7ad0422-78da-41b6-8595-a359ab520e68'),
(105,	'craft',	'm180901_151639_fix_matrixcontent_tables',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'5b4c39ed-93b0-4beb-b2b7-e308f7c0946d'),
(106,	'craft',	'm180904_112109_permission_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cf061847-22fc-443b-ba0c-91f063511fd5'),
(107,	'craft',	'm180910_142030_soft_delete_sitegroups',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'753cdb0e-6940-43ec-a74c-4a2000ed8e0d'),
(108,	'craft',	'm181011_160000_soft_delete_asset_support',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'334b0be1-b0a2-4151-a479-f3b24dcec396'),
(109,	'craft',	'm181016_183648_set_default_user_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1fa7dcba-319f-4627-a7e7-395f7551780a'),
(110,	'craft',	'm181017_225222_system_config_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'6d0ceecc-f199-4962-8fb0-aefb3616f2ef'),
(111,	'craft',	'm181018_222343_drop_userpermissions_from_config',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2934f345-9edd-418d-acc5-6436c8062414'),
(112,	'craft',	'm181029_130000_add_transforms_routes_to_config',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'd957ce44-66c1-45b1-94ec-fd39319a06e6'),
(113,	'craft',	'm181112_203955_sequences_table',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a65f73da-2067-4100-aacf-300ceeacd4f5'),
(114,	'craft',	'm181121_001712_cleanup_field_configs',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1964a10d-a9af-4cc6-9079-ffc4fea1d03e'),
(115,	'craft',	'm181128_193942_fix_project_config',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'95be72fb-13fc-4268-a8e9-c08f55c0e20f'),
(116,	'craft',	'm181130_143040_fix_schema_version',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'7ef4974f-330a-4a2b-b865-9fa0e062c9f8'),
(117,	'craft',	'm181211_143040_fix_entry_type_uids',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'3aad1d63-7860-46d4-bfb1-37a2e3a40c0e'),
(118,	'craft',	'm181217_153000_fix_structure_uids',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'78ca47a0-314c-4a7b-ac72-bf1ae7492323'),
(119,	'craft',	'm190104_152725_store_licensed_plugin_editions',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'c752e6ab-0282-488b-8feb-8f5906fa50b0'),
(120,	'craft',	'm190108_110000_cleanup_project_config',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'00f790ea-ada7-435f-978c-986d071d468d'),
(121,	'craft',	'm190108_113000_asset_field_setting_change',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e50d6eb9-3221-409f-8334-0b11e21b6043'),
(122,	'craft',	'm190109_172845_fix_colspan',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'cc79806d-8111-4d91-83e0-a5167f4d772a'),
(123,	'craft',	'm190110_150000_prune_nonexisting_sites',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f4e95ef3-ac66-43ff-804a-d4f09530a57e'),
(124,	'craft',	'm190110_214819_soft_delete_volumes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'618bd97e-94bd-4967-b452-eef326237781'),
(125,	'craft',	'm190112_124737_fix_user_settings',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4aac039c-4ec2-4c25-b70a-2992bb0fe6b4'),
(126,	'craft',	'm190112_131225_fix_field_layouts',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'd293192a-0f60-4ea3-a806-8d2e2c85f5ee'),
(127,	'craft',	'm190112_201010_more_soft_deletes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2802ae2c-9de4-4c87-af8f-fe73ddfd14d3'),
(128,	'craft',	'm190114_143000_more_asset_field_setting_changes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'663dc7f9-c685-4add-94d8-5ef5816350ea'),
(129,	'craft',	'm190121_120000_rich_text_config_setting',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1ce65333-12cb-4955-bab8-cf960d5cea0c'),
(130,	'craft',	'm190125_191628_fix_email_transport_password',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'1e83f355-7aca-456a-83f6-bece74f9fbd8'),
(131,	'craft',	'm190128_181422_cleanup_volume_folders',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'417ad901-2e82-426b-b4be-61432905fde4'),
(132,	'craft',	'm190205_140000_fix_asset_soft_delete_index',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'a5ea41cc-2350-46cd-879b-7bfe40ef89ff'),
(133,	'craft',	'm190218_143000_element_index_settings_uid',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'707d0dc4-70b5-495f-9cc0-2ab6453ade3d'),
(134,	'craft',	'm190312_152740_element_revisions',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'b7a455c8-efc6-4d69-9ca5-df887f710578'),
(135,	'craft',	'm190327_235137_propagation_method',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'628d9448-959b-47d0-a36d-216a4cfdba11'),
(136,	'craft',	'm190401_223843_drop_old_indexes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'8f03041f-b3cb-4239-82d2-e3173b154c57'),
(137,	'craft',	'm190416_014525_drop_unique_global_indexes',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'35b6366e-72f7-4236-bb08-3b8be2a3b081'),
(138,	'craft',	'm190417_085010_add_image_editor_permissions',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'66fbd67d-e031-4e71-b814-9e695b49bc45'),
(139,	'craft',	'm190502_122019_store_default_user_group_uid',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'c32a1cbe-5b48-4a80-9ad9-55e037e29e2d'),
(140,	'craft',	'm190504_150349_preview_targets',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'4d602ff1-05b6-46d4-8186-9f6875bfafba'),
(141,	'craft',	'm190516_184711_job_progress_label',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'e8dfc489-2f98-4804-9b00-e302c2cb88ae'),
(142,	'craft',	'm190523_190303_optional_revision_creators',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'f1fd247d-03b6-4340-a35f-6c1ff2050654'),
(143,	'craft',	'm190529_204501_fix_duplicate_uids',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'ce95b757-1138-4750-97c0-0ce5496587e5'),
(144,	'craft',	'm190605_223807_unsaved_drafts',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'd4553215-593d-4566-a0a1-244a699a7892'),
(145,	'craft',	'm190607_230042_entry_revision_error_tables',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'e509b13c-b8db-49e6-8de4-53ff2da7e3b0'),
(146,	'craft',	'm190608_033429_drop_elements_uid_idx',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'46c789f9-0ce2-4e53-aaa2-e8f61efb88a8'),
(147,	'craft',	'm190617_164400_add_gqlschemas_table',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'f21407ad-8774-4f3b-857d-d37d611422a9'),
(148,	'craft',	'm190624_234204_matrix_propagation_method',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'b18dadfe-f1b0-4946-bb6d-387695220e27'),
(149,	'craft',	'm190711_153020_drop_snapshots',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'b3ada3e6-caf1-4641-a550-b712bfee226a'),
(150,	'craft',	'm190712_195914_no_draft_revisions',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'd8631725-30f4-4076-985f-ddb12a82f79c'),
(151,	'craft',	'm190723_140314_fix_preview_targets_column',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'8abf9cc9-96cc-496a-b9d8-b8f99fd08064'),
(152,	'craft',	'm190820_003519_flush_compiled_templates',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'e351c82d-beba-4e99-9d32-0d4fe563ca69'),
(153,	'craft',	'm190823_020339_optional_draft_creators',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'7b4963f9-63d9-40f4-9873-a48eed18389b'),
(154,	'craft',	'm190913_152146_update_preview_targets',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'8b725547-c5c4-4094-b0e3-4f142fd99b3c'),
(155,	'craft',	'm191107_122000_add_gql_project_config_support',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'26940f0d-f1a9-44ba-bf99-e2e8d276a072'),
(156,	'craft',	'm191204_085100_pack_savable_component_settings',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'582c499e-d5f1-4b06-bf85-f3145508fb34'),
(157,	'craft',	'm191206_001148_change_tracking',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'a17d8cf3-d7c0-49fc-a34f-6a36ef2aa996'),
(158,	'craft',	'm191216_191635_asset_upload_tracking',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'96c4c8c1-41f5-4950-a229-177bc3ce8608'),
(159,	'craft',	'm191222_002848_peer_asset_permissions',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'56eefae8-85e3-44e8-b3cc-5abda1db61a4'),
(160,	'craft',	'm200127_172522_queue_channels',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'65e727f8-23d3-4c6e-9502-474f30ad84e6'),
(161,	'craft',	'm200211_175048_truncate_element_query_cache',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'b246ac3a-08f3-498c-b971-ad80937bce48'),
(162,	'craft',	'm200213_172522_new_elements_index',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'f7b8062a-abd8-44ea-b221-4bd174438b80'),
(163,	'craft',	'm200228_195211_long_deprecation_messages',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'a1ee127e-03d5-4002-844a-9a3e03844e85'),
(164,	'craft',	'm200306_054652_disabled_sites',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'042f1519-4f64-42ce-9da6-9c32edaff5fe'),
(165,	'craft',	'm200522_191453_clear_template_caches',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'75790594-45c6-41b0-89d4-5032c711b759'),
(166,	'craft',	'm200606_231117_migration_tracks',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'11678a55-986c-4368-a002-f713249b2795'),
(167,	'craft',	'm200619_215137_title_translation_method',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'8366a69c-a816-4c48-8b1e-12a3cdcc8c9e'),
(168,	'craft',	'm200620_005028_user_group_descriptions',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'f67f726d-19ba-47f1-921f-d5cc3d539981'),
(169,	'craft',	'm200620_230205_field_layout_changes',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'e7b0a880-55c0-4c71-813d-af9522d77a28'),
(170,	'craft',	'm200625_131100_move_entrytypes_to_top_project_config',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'b5c34363-12c0-4e3a-88d0-8060f8abc0ec'),
(171,	'craft',	'm200629_112700_remove_project_config_legacy_files',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'e19d2710-e809-4ab3-a0b7-40c6b6ed8a4b'),
(172,	'craft',	'm200630_183000_drop_configmap',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'b97b5fbc-cd16-40a8-ae48-a3057ab06b3a'),
(173,	'craft',	'm200715_113400_transform_index_error_flag',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'7a8a1035-f965-4cba-8c24-f5bb952d6aa1'),
(174,	'craft',	'm200716_110900_replace_file_asset_permissions',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'85a60e7d-1ba0-4a31-8635-270a6d0c1ae5'),
(175,	'craft',	'm200716_153800_public_token_settings_in_project_config',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'6e65777b-60e4-47ce-8613-d9066d0578f4'),
(176,	'craft',	'm200720_175543_drop_unique_constraints',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'2020-08-04 20:15:30',	'1e2af842-1dee-443e-94e6-ae09914eb610'),
(177,	'plugin:reasons',	'Install',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'01dc56cc-9947-4f58-adfe-05eb0038c156'),
(178,	'plugin:reasons',	'm200601_000000_fix_conditionals_column_type',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'fbaf960e-feb0-4868-9ec4-7b394c1a7e7b'),
(179,	'plugin:reasons',	'm200603_004000_projectconfig',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'6048b945-08a2-43f1-bf8a-04beaeb8341f'),
(180,	'plugin:redactor',	'm180430_204710_remove_old_plugins',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'22bbd47b-7588-4c0c-beb7-4028a9d9344b'),
(181,	'plugin:redactor',	'Install',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'07af81e8-869e-44fb-a556-db367ccd1531'),
(182,	'plugin:redactor',	'm190225_003922_split_cleanup_html_settings',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'8580feab-863b-4808-bae9-66c98d2a9523'),
(183,	'plugin:seomatic',	'Install',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'61ea5933-f4f3-45cf-bc98-f12a40c12c4e'),
(184,	'plugin:seomatic',	'm180314_002755_field_type',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'b523d685-66f7-4ada-8c7c-7d9a426da868'),
(185,	'plugin:seomatic',	'm180314_002756_base_install',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'31ae0d64-5236-4d5c-8e6e-8f9dc9314311'),
(186,	'plugin:seomatic',	'm180502_202319_remove_field_metabundles',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'e167d6db-a6fe-4c9f-a3a2-586bb458c7aa'),
(187,	'plugin:seomatic',	'm180711_024947_commerce_products',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'e8f0a516-8bf4-4110-bb37-f4786019c0ea'),
(188,	'plugin:seomatic',	'm190401_220828_longer_handles',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'f85937c0-2551-45b6-9a1f-bb53518026d5'),
(189,	'plugin:seomatic',	'm190518_030221_calendar_events',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'3685e7c4-a251-47ae-ab79-0292fe53b680'),
(190,	'plugin:seomatic',	'm200419_203444_add_type_id',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'51c83b75-e3b6-462e-807d-736725db0d99');

DROP TABLE IF EXISTS `plugins`;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKeyStatus`, `licensedEdition`, `installDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	'dospaces',	'1.1.2',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:22:13',	'2020-08-04 20:22:13',	'2020-08-04 20:24:28',	'bae215e9-7367-478d-8df6-c59b6ff7c9b3'),
(2,	'fastcgi-cache-bust',	'1.0.9',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:22:26',	'2020-08-04 20:22:26',	'2020-08-04 20:24:28',	'fab89b09-aa16-4431-be87-eb6fe571ece5'),
(3,	'matrixmate',	'1.2.6',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:22:40',	'2020-08-04 20:22:40',	'2020-08-04 20:24:28',	'c769f429-4395-491d-ae39-4450584a41d6'),
(4,	'minify',	'1.2.10',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:22:53',	'2020-08-04 20:22:53',	'2020-08-04 20:24:28',	'0779954e-6297-404e-b193-9e9ee2d1c7c6'),
(5,	'reasons',	'2.2.0',	'2.1.1',	'unknown',	NULL,	'2020-08-04 20:23:11',	'2020-08-04 20:23:11',	'2020-08-04 20:24:28',	'b124fdcc-69a4-4a8b-9736-6e11e376603f'),
(6,	'redactor',	'2.6.1',	'2.3.0',	'unknown',	NULL,	'2020-08-04 20:23:24',	'2020-08-04 20:23:24',	'2020-08-04 20:24:28',	'0347484e-38e9-410e-b70d-0e5bdf3df5f0'),
(7,	'seomatic',	'3.3.13',	'3.0.9',	'invalid',	NULL,	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'2020-08-04 20:24:28',	'0b6a2c89-1faf-416b-b20d-63a60c3e1013'),
(8,	'twigpack',	'1.2.3',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:24:06',	'2020-08-04 20:24:06',	'2020-08-04 20:24:28',	'c9671369-32e5-4332-9d77-f0ec63cd212b'),
(9,	'typogrify',	'1.1.18',	'1.0.0',	'unknown',	NULL,	'2020-08-04 20:24:25',	'2020-08-04 20:24:25',	'2020-08-04 20:24:28',	'08f96edd-9b8b-4310-afe0-be9b3c3ff2dc');

DROP TABLE IF EXISTS `projectconfig`;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `projectconfig` (`path`, `value`) VALUES
('dateModified',	'1596573039'),
('email.fromEmail',	'\"steve@simplicate.ca\"'),
('email.fromName',	'\"Local Cms Sandbox\"'),
('email.transportType',	'\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),
('fieldGroups.e0dac603-c510-4bb5-8701-e25672d93744.name',	'\"Common\"'),
('plugins.dospaces.edition',	'\"standard\"'),
('plugins.dospaces.enabled',	'true'),
('plugins.dospaces.schemaVersion',	'\"1.0.0\"'),
('plugins.fastcgi-cache-bust.edition',	'\"standard\"'),
('plugins.fastcgi-cache-bust.enabled',	'true'),
('plugins.fastcgi-cache-bust.schemaVersion',	'\"1.0.0\"'),
('plugins.matrixmate.edition',	'\"standard\"'),
('plugins.matrixmate.enabled',	'true'),
('plugins.matrixmate.schemaVersion',	'\"1.0.0\"'),
('plugins.minify.edition',	'\"standard\"'),
('plugins.minify.enabled',	'true'),
('plugins.minify.schemaVersion',	'\"1.0.0\"'),
('plugins.reasons.edition',	'\"standard\"'),
('plugins.reasons.enabled',	'true'),
('plugins.reasons.schemaVersion',	'\"2.1.1\"'),
('plugins.redactor.edition',	'\"standard\"'),
('plugins.redactor.enabled',	'true'),
('plugins.redactor.schemaVersion',	'\"2.3.0\"'),
('plugins.seomatic.edition',	'\"standard\"'),
('plugins.seomatic.enabled',	'true'),
('plugins.seomatic.schemaVersion',	'\"3.0.9\"'),
('plugins.twigpack.edition',	'\"standard\"'),
('plugins.twigpack.enabled',	'true'),
('plugins.twigpack.schemaVersion',	'\"1.0.0\"'),
('plugins.typogrify.edition',	'\"standard\"'),
('plugins.typogrify.enabled',	'true'),
('plugins.typogrify.schemaVersion',	'\"1.0.0\"'),
('siteGroups.bcb40c76-f64f-408f-b1da-edb455b3588d.name',	'\"Local Cms Sandbox\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.baseUrl',	'\"$DEFAULT_SITE_URL\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.handle',	'\"default\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.hasUrls',	'true'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.language',	'\"en-GB\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.name',	'\"Local Cms Sandbox\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.primary',	'true'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.siteGroup',	'\"bcb40c76-f64f-408f-b1da-edb455b3588d\"'),
('sites.34463b82-dd3f-441c-b9c6-59c351e847aa.sortOrder',	'1'),
('system.edition',	'\"solo\"'),
('system.live',	'true'),
('system.name',	'\"Local Cms Sandbox\"'),
('system.schemaVersion',	'\"3.5.12\"'),
('system.timeZone',	'\"America/Los_Angeles\"'),
('users.allowPublicRegistration',	'false'),
('users.defaultGroup',	'null'),
('users.photoSubpath',	'null'),
('users.photoVolumeUid',	'null'),
('users.requireEmailVerification',	'true'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocapitalize',	'true'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocomplete',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autocorrect',	'true'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.autofocus',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.class',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.disabled',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.id',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.instructions',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.label',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.max',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.min',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.name',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.orientation',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.placeholder',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.readonly',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.requirable',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.required',	'false'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.size',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.step',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.tip',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.title',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.type',	'\"craft\\\\fieldlayoutelements\\\\TitleField\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.warning',	'null'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.elements.0.width',	'100'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.name',	'\"Content\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.fieldLayouts.155d9590-a8a9-44a0-b379-c089f17b9c37.tabs.0.sortOrder',	'1'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.handle',	'\"digitalOceanSpaces\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.hasUrls',	'true'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.name',	'\"Site\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.bucket',	'\"$DO_SPACES_BUCKET\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.contentDisposition',	'\"\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.endpoint',	'\"$DO_SPACES_ENDPOINT\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.expires',	'\"\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.keyId',	'\"$DO_SPACES_KEY\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.region',	'\"$DO_SPACES_REGION\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.secret',	'\"$DO_SPACES_SECRET\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.settings.subfolder',	'\"@cdnSub/site\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.sortOrder',	'1'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.type',	'\"vaersaagod\\\\dospaces\\\\Volume\"'),
('volumes.a4f97962-52de-4b53-8422-5b833d1cd5fd.url',	'\"$DO_CDN_URL\"');

DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `reasons`;
CREATE TABLE `reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) NOT NULL,
  `conditionals` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `reasons_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `reasons_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `relations`;
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


DROP TABLE IF EXISTS `resourcepaths`;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `resourcepaths` (`hash`, `path`) VALUES
('13abbff0',	'@app/web/assets/plugins/dist'),
('2166727f',	'@craft/web/assets/pluginstore/dist'),
('245e23c1',	'@lib/xregexp'),
('281d4202',	'@craft/web/assets/cp/dist'),
('2e32674b',	'@lib/selectize'),
('3791c057',	'@lib/datepicker-i18n'),
('47547d18',	'@lib/garnishjs'),
('5160f2e3',	'@app/web/assets/dashboard/dist'),
('51a9fa2',	'@craft/web/assets/updater/dist'),
('5212a926',	'@lib/fabric'),
('62a44b31',	'@lib/fileupload'),
('6e077426',	'@lib/iframe-resizer'),
('74e96a9e',	'@lib/d3'),
('7a4c4acf',	'@lib/picturefill'),
('7de8760d',	'@lib/jquery-touch-events'),
('8955f184',	'@app/web/assets/pluginstore/dist'),
('8efcf9ac',	'@lib/vue'),
('8f209b22',	'@app/web/assets/recententries/dist'),
('926dbcaf',	'@app/web/assets/cp/dist'),
('a1cf8b73',	'@app/web/assets/updater/dist'),
('a3175ad9',	'@lib/axios'),
('a9c01a90',	'@lib/jquery-ui'),
('b19ad94c',	'@app/web/assets/updateswidget/dist'),
('be26cba0',	'@vaersaagod/dospaces/resources'),
('bf08758d',	'@app/web/assets/craftsupport/dist'),
('d1d51ff6',	'@mmikkel/reasons/assetbundles/reasons/dist'),
('d976ddbd',	'@lib/element-resize-detector'),
('e7698135',	'@lib/velocity'),
('eb76f711',	'@app/web/assets/feed/dist'),
('f016fe3e',	'@app/web/assets/utilities/dist'),
('f2e76b71',	'@nystudio107/seomatic/assetbundles/seomatic/dist'),
('f6e67648',	'@bower/jquery/dist'),
('fa536b3',	'@app/web/assets/admintable/dist'),
('fb4e2edd',	'@lib/jquery.payment');

DROP TABLE IF EXISTS `revisions`;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `searchindex`;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`) VALUES
(1,	'username',	0,	1,	' admin '),
(1,	'firstname',	0,	1,	''),
(1,	'lastname',	0,	1,	''),
(1,	'fullname',	0,	1,	''),
(1,	'email',	0,	1,	' steve simplicate ca '),
(1,	'slug',	0,	1,	'');

DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sections_sites`;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `seomatic_metabundles`;
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
  `sourceAltSiteSettings` text,
  `sourceDateUpdated` datetime NOT NULL,
  `metaGlobalVars` text,
  `metaSiteVars` text,
  `metaSitemapVars` text,
  `metaContainers` text,
  `redirectsContainer` text,
  `frontendTemplatesContainer` text,
  `metaBundleSettings` text,
  PRIMARY KEY (`id`),
  KEY `seomatic_metabundles_sourceBundleType_idx` (`sourceBundleType`),
  KEY `seomatic_metabundles_sourceId_idx` (`sourceId`),
  KEY `seomatic_metabundles_sourceSiteId_idx` (`sourceSiteId`),
  KEY `seomatic_metabundles_sourceHandle_idx` (`sourceHandle`),
  CONSTRAINT `seomatic_metabundles_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `seomatic_metabundles` (`id`, `dateCreated`, `dateUpdated`, `uid`, `bundleVersion`, `sourceBundleType`, `sourceId`, `sourceName`, `sourceHandle`, `sourceType`, `typeId`, `sourceTemplate`, `sourceSiteId`, `sourceAltSiteSettings`, `sourceDateUpdated`, `metaGlobalVars`, `metaSiteVars`, `metaSitemapVars`, `metaContainers`, `redirectsContainer`, `frontendTemplatesContainer`, `metaBundleSettings`) VALUES
(1,	'2020-08-04 20:23:45',	'2020-08-04 20:23:45',	'5f207a2b-a1b4-4aca-b8fb-94ff770d8f0d',	'1.0.47',	'__GLOBAL_BUNDLE__',	1,	'__GLOBAL_BUNDLE__',	'__GLOBAL_BUNDLE__',	'__GLOBAL_BUNDLE__',	NULL,	'',	1,	'[]',	'2020-08-04 20:23:45',	'{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{seomatic.helper.safeCanonicalUrl()}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{seomatic.meta.seoTitle}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{seomatic.meta.seoDescription}\",\"ogImage\":\"{seomatic.meta.seoImage}\",\"ogImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"ogImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"ogImageDescription\":\"{seomatic.meta.seoImageDescription}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{seomatic.site.twitterHandle}\",\"twitterTitle\":\"{seomatic.meta.seoTitle}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{seomatic.meta.seoDescription}\",\"twitterImage\":\"{seomatic.meta.seoImage}\",\"twitterImageWidth\":\"{seomatic.meta.seoImageWidth}\",\"twitterImageHeight\":\"{seomatic.meta.seoImageHeight}\",\"twitterImageDescription\":\"{seomatic.meta.seoImageDescription}\"}',	'{\"siteName\":\"Local Cms Sandbox\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}',	'{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}]}',	'{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]}},\"keywords\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoKeywords}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null},\"description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.seoDescription}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null},\"referrer\":{\"charset\":\"\",\"content\":\"{seomatic.site.referrer}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null},\"robots\":{\"charset\":\"\",\"content\":\"none\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{seomatic.meta.robots}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookProfileId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{seomatic.site.facebookAppId}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null},\"og:site_name\":{\"charset\":\"\",\"content\":\"{seomatic.site.siteName}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null},\"og:type\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogType}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null},\"og:url\":{\"charset\":\"\",\"content\":\"{seomatic.meta.canonicalUrl}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null},\"og:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.ogSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.ogTitle}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null},\"og:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null},\"og:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImage}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null},\"og:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageWidth}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageHeight}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.ogImageDescription}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]}},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterCard}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{seomatic.site.twitterHandle}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]}},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{seomatic.meta.twitterCreator}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]}},\"twitter:title\":{\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.twitterSiteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"charset\":\"\",\"content\":\"{seomatic.meta.twitterTitle}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null},\"twitter:description\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null},\"twitter:image\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImage}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageWidth}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageHeight}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{seomatic.meta.twitterImageDescription}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]}}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.googleSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]}},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.bingSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]}},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{seomatic.site.pinterestSiteVerification}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]}}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{seomatic.meta.canonicalUrl}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]}},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{seomatic.site.googlePublisherLink}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]}}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"googleAnalytics\":{\"name\":\"Google Analytics\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ?? googleAdWordsId.value ?? dcFloodlightId.value ?? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"issn\":null,\"about\":null,\"abstract\":null,\"accessMode\":null,\"accessModeSufficient\":null,\"accessibilityAPI\":null,\"accessibilityControl\":null,\"accessibilityFeature\":null,\"accessibilityHazard\":null,\"accessibilitySummary\":null,\"accountablePerson\":null,\"acquireLicensePage\":null,\"aggregateRating\":null,\"alternativeHeadline\":null,\"associatedMedia\":null,\"audience\":null,\"audio\":null,\"author\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"award\":null,\"character\":null,\"citation\":null,\"comment\":null,\"commentCount\":null,\"conditionsOfAccess\":null,\"contentLocation\":null,\"contentRating\":null,\"contentReferenceTime\":null,\"contributor\":null,\"copyrightHolder\":{\"id\":\"{seomatic.site.identity.genericUrl}#identity\"},\"copyrightYear\":null,\"correction\":null,\"creativeWorkStatus\":null,\"creator\":{\"id\":\"{seomatic.site.creator.genericUrl}#creator\"},\"dateCreated\":null,\"dateModified\":null,\"datePublished\":null,\"discussionUrl\":null,\"editor\":null,\"educationalAlignment\":null,\"educationalUse\":null,\"encoding\":null,\"encodingFormat\":null,\"exampleOfWork\":null,\"expires\":null,\"funder\":null,\"genre\":null,\"hasPart\":null,\"headline\":null,\"inLanguage\":\"{seomatic.meta.language}\",\"interactionStatistic\":null,\"interactivityType\":null,\"isAccessibleForFree\":null,\"isBasedOn\":null,\"isFamilyFriendly\":null,\"isPartOf\":null,\"keywords\":null,\"learningResourceType\":null,\"license\":null,\"locationCreated\":null,\"mainEntity\":null,\"maintainer\":null,\"material\":null,\"materialExtent\":null,\"mentions\":null,\"offers\":null,\"position\":null,\"producer\":null,\"provider\":null,\"publication\":null,\"publisher\":null,\"publisherImprint\":null,\"publishingPrinciples\":null,\"recordedAt\":null,\"releasedEvent\":null,\"review\":null,\"schemaVersion\":null,\"sdDatePublished\":null,\"sdLicense\":null,\"sdPublisher\":null,\"sourceOrganization\":null,\"spatial\":null,\"spatialCoverage\":null,\"sponsor\":null,\"temporal\":null,\"temporalCoverage\":null,\"text\":null,\"thumbnailUrl\":null,\"timeRequired\":null,\"translationOfWork\":null,\"translator\":null,\"typicalAgeRange\":null,\"usageInfo\":null,\"version\":null,\"video\":null,\"workExample\":null,\"workTranslation\":null,\"additionalType\":null,\"alternateName\":null,\"description\":\"{seomatic.meta.seoDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.meta.seoImage}\"},\"mainEntityOfPage\":\"{seomatic.meta.canonicalUrl}\",\"name\":\"{seomatic.meta.seoTitle}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{seomatic.site.siteLinksSearchTarget}\",\"query-input\":\"{seomatic.helper.siteLinksQueryInput()}\"},\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.meta.canonicalUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.meta.mainEntityOfPage}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"identity\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.identity.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.identity.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.identity.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.identity.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.identity.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.identity.organizationDuns}\",\"email\":\"{seomatic.site.identity.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.identity.organizationFounder}\",\"foundingDate\":\"{seomatic.site.identity.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.identity.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.identity.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.identity.genericAlternateName}\",\"description\":\"{seomatic.site.identity.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.identity.genericImage}\",\"width\":\"{seomatic.site.identity.genericImageWidth}\",\"height\":\"{seomatic.site.identity.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.identity.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.identity.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.identity.computedType}\",\"id\":\"{seomatic.site.identity.genericUrl}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"nonce\":null},\"creator\":{\"actionableFeedbackPolicy\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{seomatic.site.creator.genericStreetAddress}\",\"addressLocality\":\"{seomatic.site.creator.genericAddressLocality}\",\"addressRegion\":\"{seomatic.site.creator.genericAddressRegion}\",\"postalCode\":\"{seomatic.site.creator.genericPostalCode}\",\"addressCountry\":\"{seomatic.site.creator.genericAddressCountry}\"},\"aggregateRating\":null,\"alumni\":null,\"areaServed\":null,\"award\":null,\"brand\":null,\"contactPoint\":null,\"correctionsPolicy\":null,\"department\":null,\"dissolutionDate\":null,\"diversityPolicy\":null,\"diversityStaffingReport\":null,\"duns\":\"{seomatic.site.creator.organizationDuns}\",\"email\":\"{seomatic.site.creator.genericEmail}\",\"employee\":null,\"ethicsPolicy\":null,\"event\":null,\"faxNumber\":null,\"founder\":\"{seomatic.site.creator.organizationFounder}\",\"foundingDate\":\"{seomatic.site.creator.organizationFoundingDate}\",\"foundingLocation\":\"{seomatic.site.creator.organizationFoundingLocation}\",\"funder\":null,\"globalLocationNumber\":null,\"hasCredential\":null,\"hasMerchantReturnPolicy\":null,\"hasOfferCatalog\":null,\"hasPOS\":null,\"interactionStatistic\":null,\"isicV4\":null,\"knowsAbout\":null,\"knowsLanguage\":null,\"legalName\":null,\"leiCode\":null,\"location\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"width\":\"{seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\",\"height\":\"{seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\")}\"},\"makesOffer\":null,\"member\":null,\"memberOf\":null,\"naics\":null,\"numberOfEmployees\":null,\"ownershipFundingInfo\":null,\"owns\":null,\"parentOrganization\":null,\"publishingPrinciples\":null,\"review\":null,\"seeks\":null,\"slogan\":null,\"sponsor\":null,\"subOrganization\":null,\"taxID\":null,\"telephone\":\"{seomatic.site.creator.genericTelephone}\",\"unnamedSourcesPolicy\":null,\"vatID\":null,\"additionalType\":null,\"alternateName\":\"{seomatic.site.creator.genericAlternateName}\",\"description\":\"{seomatic.site.creator.genericDescription}\",\"disambiguatingDescription\":null,\"identifier\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{seomatic.site.creator.genericImage}\",\"width\":\"{seomatic.site.creator.genericImageWidth}\",\"height\":\"{seomatic.site.creator.genericImageHeight}\"},\"mainEntityOfPage\":null,\"name\":\"{seomatic.site.creator.genericName}\",\"potentialAction\":null,\"sameAs\":null,\"subjectOf\":null,\"url\":\"{seomatic.site.creator.genericUrl}\",\"context\":\"http://schema.org\",\"type\":\"{seomatic.site.creator.computedType}\",\"id\":\"{seomatic.site.creator.genericUrl}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"nonce\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{seomatic.meta.seoTitle}\",\"siteName\":\"{seomatic.site.siteName}\",\"siteNamePosition\":\"{seomatic.meta.siteNamePosition}\",\"separatorChar\":\"{seomatic.config.separatorChar}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}',	'[]',	'{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ seomatic.site.creator.genericUrl ?? \\\"n/a\\\" }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 3, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ siteUrl }}\\n\\nSitemap: {{ seomatic.helper.sitemapIndexForSiteId() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ siteUrl }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ siteUrl }},123,DIRECT\\n\",\"siteId\":null,\"include\":true,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}',	'{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');

DROP TABLE IF EXISTS `sequences`;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sessions`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sessions` (`id`, `userId`, `token`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	1,	'1aRaIjQyEW3llutLncm0KNYOxQTq7-pXxSHDZMLPfMkPjdeYKqLL8-uEm9m9_cjpbdqDO87IeNdaAih9XSCNxkKu8Oys_oQS6eKC',	'2020-08-04 20:15:29',	'2020-08-04 20:30:39',	'2b3457e2-84a5-465d-a340-c1cb7fc88db4');

DROP TABLE IF EXISTS `shunnedmessages`;
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


DROP TABLE IF EXISTS `sitegroups`;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sitegroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1,	'Local Cms Sandbox',	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	NULL,	'bcb40c76-f64f-408f-b1da-edb455b3588d');

DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sites` (`id`, `groupId`, `primary`, `enabled`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1,	1,	1,	1,	'Local Cms Sandbox',	'default',	'en-GB',	1,	'$DEFAULT_SITE_URL',	1,	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	NULL,	'34463b82-dd3f-441c-b9c6-59c351e847aa');

DROP TABLE IF EXISTS `structureelements`;
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


DROP TABLE IF EXISTS `structures`;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `systemmessages`;
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


DROP TABLE IF EXISTS `taggroups`;
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


DROP TABLE IF EXISTS `tags`;
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


DROP TABLE IF EXISTS `templatecacheelements`;
CREATE TABLE `templatecacheelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `templatecachequeries`;
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


DROP TABLE IF EXISTS `templatecaches`;
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


DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
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


DROP TABLE IF EXISTS `usergroups`;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `usergroups_handle_idx` (`handle`),
  KEY `usergroups_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `usergroups_users`;
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


DROP TABLE IF EXISTS `userpermissions`;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `userpermissions_usergroups`;
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


DROP TABLE IF EXISTS `userpermissions_users`;
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


DROP TABLE IF EXISTS `userpreferences`;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `userpreferences` (`userId`, `preferences`) VALUES
(1,	'{\"language\":\"en-GB\"}');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
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

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `locked`, `suspended`, `pending`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `hasDashboard`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	'admin',	NULL,	NULL,	NULL,	'steve@simplicate.ca',	'$2y$13$GOtMzRzj4XVU.tBCHsnuMeSAhbavZbVLarw78reNHDxZxXkXTADxS',	1,	0,	0,	0,	'2020-08-04 20:15:29',	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	0,	'2020-08-04 20:15:29',	'2020-08-04 20:15:29',	'2020-08-04 20:15:31',	'dbd99e31-a7d8-4b32-8ce9-9fc644ad9145');

DROP TABLE IF EXISTS `volumefolders`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	NULL,	1,	'Site',	'',	'2020-08-04 20:30:39',	'2020-08-04 20:30:39',	'9896d296-3e31-4fb1-a41e-ace3f3b3f849');

DROP TABLE IF EXISTS `volumes`;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `dateDeleted`, `uid`) VALUES
(1,	1,	'Site',	'digitalOceanSpaces',	'vaersaagod\\dospaces\\Volume',	1,	'$DO_CDN_URL',	'{\"bucket\":\"$DO_SPACES_BUCKET\",\"contentDisposition\":\"\",\"endpoint\":\"$DO_SPACES_ENDPOINT\",\"expires\":\"\",\"keyId\":\"$DO_SPACES_KEY\",\"region\":\"$DO_SPACES_REGION\",\"secret\":\"$DO_SPACES_SECRET\",\"subfolder\":\"@cdnSub/site\"}',	1,	'2020-08-04 20:30:39',	'2020-08-04 20:30:39',	NULL,	'a4f97962-52de-4b53-8422-5b833d1cd5fd');

DROP TABLE IF EXISTS `widgets`;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`) VALUES
(1,	1,	'craft\\widgets\\RecentEntries',	1,	NULL,	'{\"siteId\":1,\"section\":\"*\",\"limit\":10}',	1,	'2020-08-04 20:15:31',	'2020-08-04 20:15:31',	'fcffd453-0f79-4a31-a9c6-d9b0e6ee4d50'),
(2,	1,	'craft\\widgets\\CraftSupport',	2,	NULL,	'[]',	1,	'2020-08-04 20:15:31',	'2020-08-04 20:15:31',	'31916571-e15e-4add-a3a1-29d4db7bfc49'),
(3,	1,	'craft\\widgets\\Updates',	3,	NULL,	'[]',	1,	'2020-08-04 20:15:31',	'2020-08-04 20:15:31',	'96fe185a-4b8c-4430-a803-cf67df348372'),
(4,	1,	'craft\\widgets\\Feed',	4,	NULL,	'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',	1,	'2020-08-04 20:15:31',	'2020-08-04 20:15:31',	'7f10fcee-9323-4827-b7d5-7907385950a9');

-- 2020-08-04 20:35:28