-- MariaDB dump 10.19  Distrib 10.6.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `ownerId` int DEFAULT NULL,
  `countryCode` varchar(255) NOT NULL,
  `administrativeArea` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `dependentLocality` varchar(255) DEFAULT NULL,
  `postalCode` varchar(255) DEFAULT NULL,
  `sortingCode` varchar(255) DEFAULT NULL,
  `addressLine1` varchar(255) DEFAULT NULL,
  `addressLine2` varchar(255) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `organizationTaxId` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_jrwsmdihxfetoflmrjxvjskrlaupqbwujztv` (`ownerId`),
  CONSTRAINT `fk_jrwsmdihxfetoflmrjxvjskrlaupqbwujztv` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yuohiixyptfrotkxvdfwgcezxqbpdriwehri` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `pluginId` int DEFAULT NULL,
  `heading` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `unread` tinyint(1) NOT NULL DEFAULT '1',
  `dateRead` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_tyzednyrqsckelyvrgbkodbbtwltgngeucdm` (`userId`,`unread`,`dateRead`,`dateCreated`),
  KEY `idx_nxiyuqrqfgzyinicfprgqxxawinwewludhru` (`dateRead`),
  KEY `fk_xszawzzjtbeksehnvhyamnftnhvhjwsjnhsu` (`pluginId`),
  CONSTRAINT `fk_asaepkjypsempljwojuqyeudrawqywztuuiy` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_xszawzzjtbeksehnvhyamnftnhvhjwsjnhsu` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` int NOT NULL,
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `isDir` tinyint(1) DEFAULT '0',
  `recordId` int DEFAULT NULL,
  `isSkipped` tinyint(1) DEFAULT '0',
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lyibobfxuedctqoxcbdmxpbrsttnqucyszdc` (`sessionId`,`volumeId`),
  KEY `idx_tbikkqnxopcpiwzehrbwhzylzbsredytzizm` (`volumeId`),
  CONSTRAINT `fk_kqwfcjrcophvohpdfohujhgbutninrinhjop` FOREIGN KEY (`sessionId`) REFERENCES `assetindexingsessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tvihrzgieqqtrpzusazxxwjircfjghknmgyf` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetindexingsessions`
--

DROP TABLE IF EXISTS `assetindexingsessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexingsessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `indexedVolumes` text,
  `totalEntries` int DEFAULT NULL,
  `processedEntries` int NOT NULL DEFAULT '0',
  `cacheRemoteImages` tinyint(1) DEFAULT NULL,
  `isCli` tinyint(1) DEFAULT '0',
  `actionRequired` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `alt` text,
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vlojqmtbiybfibplwcqennkibwuarsrzcobl` (`filename`,`folderId`),
  KEY `idx_olamhgpgjaermrfyiuohgthsoaqsbhwnwssa` (`folderId`),
  KEY `idx_dgxusbxxozpzptozazpamsyrxlvlbbheolxw` (`volumeId`),
  KEY `fk_nniqotqiyvwejngzgsurnudojkqxmaoyultp` (`uploaderId`),
  CONSTRAINT `fk_fvncwhkcpjqwesjnookgsfibvwkqzrjoljpf` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nniqotqiyvwejngzgsurnudojkqxmaoyultp` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qslwctghaieifjqzxgzwyjlufxuidhkpgozs` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vwqgbfhjcbxhplmincwctakznnobqmargqyo` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_dzwvbniisbqkqnjrvxxdxlvfbfcqtkbzftyt` (`groupId`),
  KEY `fk_nzfwfyjskkyxmmlojsegmfzgmzyduumclokl` (`parentId`),
  CONSTRAINT `fk_nzfwfyjskkyxmmlojsegmfzgmzyduumclokl` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_swrjilcnpgxdgtcvyjwjojanlaagwvogiyzj` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zgyofzkicovlxmepsbgsfrmiskikbncbymlf` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uayzqfbmwohznneintagucsvudgdkzwwbond` (`name`),
  KEY `idx_nrxldtszmarviehwxjamypasctmzxkdmjphb` (`handle`),
  KEY `idx_vbgozjbadspwufrsckbozzihtffhfxkkrykd` (`structureId`),
  KEY `idx_vgzpxfbgyrihpwvnntxwzwkfdyvqttnzrwfe` (`fieldLayoutId`),
  KEY `idx_ewxypfxhbrwusasygekoymzxfiuovlwstasl` (`dateDeleted`),
  CONSTRAINT `fk_buvucbgtglzqrwmbwywzglhyplxtckyxspoz` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_licaaeqvkrbwmwvdykxzucqckyiojjgqlrvj` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dovtopdalwuyzgnaltwumlrtpxnasygpcgxz` (`groupId`,`siteId`),
  KEY `idx_hkhfexohfmrlgqcphjdazmpkclnjzdolvxyk` (`siteId`),
  CONSTRAINT `fk_jsfustswxwxbdtvfnxmutcqbxfbtgstflwqd` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ngukujzpjahnkxdzhsexykhvmoawmleslxij` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_awrzsisaggmtncxtcyyiqbqovptdxebrsyce` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_qnbdhcyjqfwqaywmbhbuunaobkxhbvwsfbcn` (`siteId`),
  KEY `fk_yxprsuryxspttaxtklcaftclybxxntzvtycf` (`userId`),
  CONSTRAINT `fk_dewncwzhrzlggrheiyhdahmoqycpbyjdhdjl` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_qnbdhcyjqfwqaywmbhbuunaobkxhbvwsfbcn` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_yxprsuryxspttaxtklcaftclybxxntzvtycf` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_kqmqplceblouoxkbxrcvudppqsqrcadtgdok` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_ykflkvjqbavhndrruwpznixyhwydakkmpiyq` (`siteId`),
  KEY `fk_wioooaidyeyxqvovzgagutcktylnthuhvcgf` (`fieldId`),
  KEY `fk_xbhqjlzjabxdxsbypsomcmqeynphtlmogwzr` (`userId`),
  CONSTRAINT `fk_rzrfzwfctqlmumakgrhdylsdsxccphicwztv` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_wioooaidyeyxqvovzgagutcktylnthuhvcgf` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_xbhqjlzjabxdxsbypsomcmqeynphtlmogwzr` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_ykflkvjqbavhndrruwpznixyhwydakkmpiyq` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_showBlockMeta_cvrpdgoz` tinyint(1) DEFAULT NULL,
  `field_seo` text,
  `field_dek` text,
  `field_eMsgLayout_zfkvvptv` varchar(255) DEFAULT NULL,
  `field_text_qieovwoa` text,
  `field_summary_wtwwruam` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wederzbeqywhqvwqgeckwvrcfpjnjuawgjzx` (`elementId`,`siteId`),
  KEY `idx_krilxeibmluxrjgvsvtaqzknzkwarvwcvewu` (`siteId`),
  KEY `idx_bohewybombvmjretrfmpbyqusxwihoexmffi` (`title`),
  CONSTRAINT `fk_dyblaqpwbpjxvelnjfimfhyvvjwzetfpzbkd` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_eaimgobjwnzacgejgnsatkcwqyncbrmmhhhq` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_xpzbnsxravpeosztogzmnuadruggkkwrfkez` (`userId`),
  CONSTRAINT `fk_xpzbnsxravpeosztogzmnuadruggkkwrfkez` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rmobbptjlzxckffqqethmjhnynxyuwxpyqcb` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dolphiq_redirects`
--

DROP TABLE IF EXISTS `dolphiq_redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceUrl` varchar(255) DEFAULT NULL,
  `destinationUrl` varchar(255) DEFAULT NULL,
  `statusCode` varchar(255) DEFAULT NULL,
  `hitCount` int unsigned NOT NULL DEFAULT '0',
  `hitAt` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_avmzeviqsrwswlcoradrqzxmkcsfmqxxzjcj` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dolphiq_redirects_catch_all_urls`
--

DROP TABLE IF EXISTS `dolphiq_redirects_catch_all_urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dolphiq_redirects_catch_all_urls` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL DEFAULT '',
  `uid` char(36) NOT NULL DEFAULT '0',
  `siteId` int unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `hitCount` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `provisional` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_cykaskfleazeeipeobkekkvswasvuhztyrou` (`creatorId`,`provisional`),
  KEY `idx_vwainbiemvfkcrbwpfcgtsefazmjvjlrhdtw` (`saved`),
  KEY `fk_irndsoezpubjjztlbgqsenubazwhvpgykyaw` (`canonicalId`),
  CONSTRAINT `fk_irndsoezpubjjztlbgqsenubazwhvpgykyaw` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tfcrabpjxegyermnmwywprrbivvwjyqqnuxk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int DEFAULT NULL,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateLastMerged` datetime DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_hgnmdjltfxgczjbtklqrlpbpiqcpzavekcll` (`dateDeleted`),
  KEY `idx_tkruouoecraehpcixcxcwhobcbklynbnnkwr` (`fieldLayoutId`),
  KEY `idx_vbkdlotjutftrvbaxhjaaigbefjrvppnqkyw` (`type`),
  KEY `idx_eqkggaakmzszbodreppxmngnxzumbxujptzc` (`enabled`),
  KEY `idx_tjndekarfxtrbaweuthmfydlnixnyzrtujew` (`archived`,`dateCreated`),
  KEY `idx_xifqwjrkmdkksvcwqddfzyybwpqhsxyrhtuy` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`),
  KEY `idx_rxqbmqxcvircmykforzlbejypxoyzsbsfelj` (`archived`,`dateDeleted`,`draftId`,`revisionId`,`canonicalId`,`enabled`),
  KEY `fk_yftnpxgtxpinacopiyiexclfvrxthmlhibge` (`canonicalId`),
  KEY `fk_qygkmcxnnasnznpzldcsiayzhmbmjumourwe` (`draftId`),
  KEY `fk_fkcufrstxtmhkwunqhegvzpstxmcrbpunopw` (`revisionId`),
  CONSTRAINT `fk_fkcufrstxtmhkwunqhegvzpstxmcrbpunopw` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qygkmcxnnasnznpzldcsiayzhmbmjumourwe` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tkrhoaeuhyebusxjzbfwldbihsxxcsbcakly` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_yftnpxgtxpinacopiyiexclfvrxthmlhibge` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_flnsckztbrddftywulikexuoxhxwhxvaswyo` (`elementId`,`siteId`),
  KEY `idx_thfdwravccqkbglxtedqbjjtmesjfkoediyj` (`siteId`),
  KEY `idx_hztbzzghgjghsnfzmptlwjhrojczyargoxur` (`slug`,`siteId`),
  KEY `idx_vjrcwoufgtknbounjpistlohqavgsmlvhfcz` (`enabled`),
  KEY `idx_lrxtepdpbcqrjcmqbyyhyisferegptopapsq` (`uri`,`siteId`),
  CONSTRAINT `fk_eihqdushqcvsdjhjhfperrswwncscmboespw` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jevlueaxbrrbywclyewhmxggaymboqhufjni` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_oxuhzymibobpgctjqxiwzwzottefpajesthv` (`postDate`),
  KEY `idx_ivpbrxglaqpeypwdmlrgmonynhsqngqtisco` (`expiryDate`),
  KEY `idx_zagmppzptmnyaysaxwixaoojgncivipjzwfc` (`authorId`),
  KEY `idx_wpnsicuzbfxsktnaiwhlposfwpwbfmxuibyi` (`sectionId`),
  KEY `idx_bgauqihfmbcwllshwwcoclfucnifsbktdvib` (`typeId`),
  KEY `fk_qfankzhitjkyrkcyuebedqrikzlwcullgivy` (`parentId`),
  CONSTRAINT `fk_bsrbarcynnxvwirboqfgpkftvjaoqhnxzstn` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_gehmphowgldxqtfcfbyrwfdfvdxbnhlsdwhq` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nrwpyseclqhwflykmwvozfkfcpepfnkzdxel` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qfankzhitjkyrkcyuebedqrikzlwcullgivy` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_rjctiyvfsubqbijmqwittasioatujqhzqbfm` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_krifbcpdohyhiakxdqgnydlgjfactrpyjxve` (`name`,`sectionId`),
  KEY `idx_ozsxkukvywrwblcnxzydrrprtgvlpblpapll` (`handle`,`sectionId`),
  KEY `idx_zhnhpydgstipcvcknrxqszpmywbqlzcnlzei` (`sectionId`),
  KEY `idx_uzwazehmwyczvuoqtbwpbxgvhowvbpmhlgek` (`fieldLayoutId`),
  KEY `idx_mabldqxbtkzzyyapcpfrplcwuzgmkqiqdcvt` (`dateDeleted`),
  CONSTRAINT `fk_cfjavacejwdwkgwgonjnefxclmxvphimskhq` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ftlspyhrmxngweymadtyhcpfiytzsmtirjvc` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_iyggapuvynutjmtzqbunzzheamabiornqxig` (`name`),
  KEY `idx_rxfcfevkdqlofdarnqgkkugrfkcftlbrkykp` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vlloxywkxmbqthtctrdvsotcuuuwsnqjlcxy` (`layoutId`,`fieldId`),
  KEY `idx_boiwljpittfwxdsqcyrnwrlrytwrpyhbardo` (`sortOrder`),
  KEY `idx_wgdayufoflgefnqqdtrobdymwziqpoppljpo` (`tabId`),
  KEY `idx_gizjhanwxwhdffamgesmylvewikiikchcgsg` (`fieldId`),
  CONSTRAINT `fk_rxheedahnrfqvjeuetyierodolotpfrpqqjm` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ttcpzfraxmmjyokazwyboqquezmuuntouuai` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yweozdwadofxolqsjvxevfbbhzohoqpmebyn` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zksnscqqpabkwhzmmfitdxaasrwlgdrpxtez` (`dateDeleted`),
  KEY `idx_bcksacziexkvkcxinqjhwjxdphjplevifjqu` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `settings` text,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lgintndpcmkggxkvljclbzgubndrkicqlhiu` (`sortOrder`),
  KEY `idx_rcipcscjnxjegjnvptooqmvoiooehdivsbev` (`layoutId`),
  CONSTRAINT `fk_rguxzogrxygcrbxoutatchfxnzesasizuytk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `columnSuffix` char(8) DEFAULT NULL,
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
  KEY `idx_jkexlqfnduoqmcslgacjdtugglugudlisvgk` (`handle`,`context`),
  KEY `idx_ghgdltvuhjhkjcgygjkteidcxlaprrwfahdq` (`groupId`),
  KEY `idx_oiwygyxumqyseabnzmefmjkrepgzrherqotm` (`context`),
  CONSTRAINT `fk_uuaqatmckqptknerzbvpcnyddnaoetbgbotb` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_emailtemplates`
--

DROP TABLE IF EXISTS `formie_emailtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_emailtemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_forms`
--

DROP TABLE IF EXISTS `formie_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_forms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(64) NOT NULL,
  `fieldContentTable` varchar(74) NOT NULL,
  `settings` mediumtext,
  `templateId` int DEFAULT NULL,
  `submitActionEntryId` int DEFAULT NULL,
  `submitActionEntrySiteId` int DEFAULT NULL,
  `defaultStatusId` int DEFAULT NULL,
  `dataRetention` enum('forever','minutes','hours','days','weeks','months','years') NOT NULL DEFAULT 'forever',
  `dataRetentionValue` int DEFAULT NULL,
  `userDeletedAction` enum('retain','delete') NOT NULL DEFAULT 'retain',
  `fileUploadsAction` enum('retain','delete') NOT NULL DEFAULT 'retain',
  `fieldLayoutId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tzbwbkypcfjsxsgkrffmybmzgtfrdbvtkuqu` (`templateId`),
  KEY `idx_cwxwfbnpgbyyrjxlyutlpitymrpvqnaptizj` (`defaultStatusId`),
  KEY `idx_kldgffcrukpwzlakobsefrfcnxtqrpmbrmdr` (`submitActionEntryId`),
  KEY `idx_ooaegqxqmpgvezpyztubtduudpkbhfqddfqz` (`submitActionEntrySiteId`),
  KEY `idx_ocpvtvnrlssisrjuzzivedgcdkpyffewcemd` (`fieldLayoutId`),
  CONSTRAINT `fk_cuwnsttktnqebgcaalndgkxmumovlwbuzvtc` FOREIGN KEY (`defaultStatusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_mzenicixcmwjgiflqgctbzxzxsbkcymueqtb` FOREIGN KEY (`templateId`) REFERENCES `formie_formtemplates` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_nmrzwbgefzpvvnmfdqraeumifhuycggbyaeh` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tucgafpeewxctttonpuedukbkkgvtilzfbel` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yspgcfyrirskcqkrlbyohaadwxsamrdrctas` FOREIGN KEY (`submitActionEntryId`) REFERENCES `entries` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_formtemplates`
--

DROP TABLE IF EXISTS `formie_formtemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_formtemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) DEFAULT NULL,
  `useCustomTemplates` tinyint(1) DEFAULT '1',
  `outputCssLayout` tinyint(1) DEFAULT '1',
  `outputCssTheme` tinyint(1) DEFAULT '1',
  `outputJsBase` tinyint(1) DEFAULT '1',
  `outputJsTheme` tinyint(1) DEFAULT '1',
  `outputCssLocation` varchar(255) DEFAULT NULL,
  `outputJsLocation` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bvxucjismdyerbqtkrgrcekngidzvjhxxnga` (`fieldLayoutId`),
  CONSTRAINT `fk_ppgcpheksyznuxbmiwtdycvdmrhczgnzjxyt` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_integrations`
--

DROP TABLE IF EXISTS `formie_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_integrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `enabled` varchar(255) NOT NULL DEFAULT 'true',
  `settings` text,
  `cache` longtext,
  `tokenId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_nested`
--

DROP TABLE IF EXISTS `formie_nested`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_nested` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ejdsbgphqhbqdexnavmodvszybdfbqimgthb` (`fieldId`),
  KEY `idx_vcxhlwszgnixzwbeetllcxfahasefomjlwex` (`fieldLayoutId`),
  CONSTRAINT `fk_vfubupiwrrvecyfrnvupaljuzikxjugtbrji` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zxmldfsaysemhrkvzrykhjzpcfxszbfyquvd` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_nestedfieldrows`
--

DROP TABLE IF EXISTS `formie_nestedfieldrows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_nestedfieldrows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_cewozkpgxobprtakfxztychixgzlkzvprzda` (`ownerId`),
  KEY `idx_xmjmyocsdbvbzwjoicqwanalorvncjpipywn` (`fieldId`),
  KEY `idx_tgncsmfbskkkzgzappesntekphquwerccytm` (`sortOrder`),
  CONSTRAINT `fk_pquwabeiorfoojzewbbtgsqksjdrviewgsze` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qfujkaqktihvmqstbnorqdnszwwmcpxwukxs` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ustrelmsarsbhyzodmwlmfdkyhxrdnrwyere` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_notifications`
--

DROP TABLE IF EXISTS `formie_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formId` int NOT NULL,
  `templateId` int DEFAULT NULL,
  `pdfTemplateId` int DEFAULT NULL,
  `name` text NOT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `subject` text,
  `recipients` enum('email','conditions') NOT NULL DEFAULT 'email',
  `to` text,
  `toConditions` text,
  `cc` text,
  `bcc` text,
  `replyTo` text,
  `replyToName` text,
  `from` text,
  `fromName` text,
  `sender` text,
  `content` text,
  `attachFiles` tinyint(1) DEFAULT '1',
  `attachPdf` tinyint(1) DEFAULT '0',
  `attachAssets` text,
  `enableConditions` tinyint(1) DEFAULT '0',
  `conditions` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_pvqizwhujdhymnhwqcfvnaveqyjnpbsofibr` (`formId`),
  KEY `idx_tqsdlfidmxwbhspyjzdegpfkxtpxqubqhddy` (`templateId`),
  KEY `fk_vkndxnnohkwhtqldesliorfgxiffnsgkyrlh` (`pdfTemplateId`),
  CONSTRAINT `fk_oxgizibtpvuwrklvqwvqaaliwqvgnoahjuie` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rirncczmryanshvhhmwrixnsczbkozxmunbv` FOREIGN KEY (`templateId`) REFERENCES `formie_emailtemplates` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vkndxnnohkwhtqldesliorfgxiffnsgkyrlh` FOREIGN KEY (`pdfTemplateId`) REFERENCES `formie_pdftemplates` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_pagesettings`
--

DROP TABLE IF EXISTS `formie_pagesettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_pagesettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int NOT NULL,
  `fieldLayoutTabId` int NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_yxbklranccyjokrubatofbivjvwhfsnbrgtl` (`fieldLayoutTabId`),
  KEY `idx_uvvzlnptthpuzxdjweyolufmecfctfdncypm` (`fieldLayoutId`),
  CONSTRAINT `fk_hseuexezijquihbcsaldfscfhcuwuwfvcanp` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_oncngisalcquqfdzxpaehqgkhlpvtjsnbaog` FOREIGN KEY (`fieldLayoutTabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments`
--

DROP TABLE IF EXISTS `formie_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int NOT NULL,
  `submissionId` int NOT NULL,
  `fieldId` int NOT NULL,
  `subscriptionId` int DEFAULT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed','processing') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `note` mediumtext,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ajtbuwlzlwtlpmtrybruchcwypbooivowiyv` (`integrationId`),
  KEY `idx_woalflnceatwlxqtizfiiswhherzagxvsnpl` (`fieldId`),
  KEY `idx_vwtzmozrmvugjaztylwutmgrqbfirzfekolq` (`reference`),
  KEY `fk_dyzndtpttqucfkpcvrshybkqouyqxfuhnvkm` (`submissionId`),
  KEY `fk_wmjxgrunttwfeanxtgqazqbijxotprpzxtis` (`subscriptionId`),
  CONSTRAINT `fk_dyzndtpttqucfkpcvrshybkqouyqxfuhnvkm` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ufmaoxtakaylrkhablmoutvsqctumbqbufgg` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uzvzyboljbxlbhmjmlgbsxszpcayfbfnekrl` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wmjxgrunttwfeanxtgqazqbijxotprpzxtis` FOREIGN KEY (`subscriptionId`) REFERENCES `formie_payments_subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments_plans`
--

DROP TABLE IF EXISTS `formie_payments_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `planData` text,
  `isArchived` tinyint(1) NOT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hboicjlamqsadhmhptkantvnighhrruygfoo` (`handle`),
  KEY `idx_bstaowzusxejsvdtikhbugrumnwyzkxwxrbh` (`integrationId`),
  KEY `idx_rynpbbsvimhotoxrsevjwswqpllbvosgsmpy` (`reference`),
  CONSTRAINT `fk_wyyevljuaorhmrhllgnwlnreefgpucczcwnx` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_payments_subscriptions`
--

DROP TABLE IF EXISTS `formie_payments_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_payments_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `integrationId` int DEFAULT NULL,
  `submissionId` int DEFAULT NULL,
  `fieldId` int DEFAULT NULL,
  `planId` int DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `subscriptionData` text,
  `trialDays` int NOT NULL,
  `nextPaymentDate` datetime DEFAULT NULL,
  `hasStarted` tinyint(1) NOT NULL DEFAULT '1',
  `isSuspended` tinyint(1) NOT NULL DEFAULT '0',
  `dateSuspended` datetime DEFAULT NULL,
  `isCanceled` tinyint(1) NOT NULL,
  `dateCanceled` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL,
  `dateExpired` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lxamlvgfynmckvjkwhxlclarizmccpsfiukg` (`integrationId`),
  KEY `idx_nctlunmfhmijzknwxeyxptgbtxeqaylnoosc` (`submissionId`),
  KEY `idx_zskeuqcefjucnaosvncwnkwhjquekxqzwxtf` (`fieldId`),
  KEY `idx_eeooazahprsumesdbzjkczutmsaawahmqtsj` (`planId`),
  KEY `idx_nykebczfxaliazwxsneibpgasnzyykjvgtfi` (`reference`),
  KEY `idx_uwykvxphwzkquwuerqsrckqdaxpdyxfakjxt` (`nextPaymentDate`),
  KEY `idx_kqvlwtdfyngoenxsjgamnwkgxxarkcyskobd` (`dateExpired`),
  KEY `idx_vdakqhrbmpujcwcgfghynhkzjakdzdqvnxoa` (`dateExpired`),
  CONSTRAINT `fk_gzkmjxgzpsihtbnjoypjpohdxcrtxnldebaz` FOREIGN KEY (`planId`) REFERENCES `formie_payments_plans` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_reakggeyoesjjydihsvlbmcgjjnlejfbgqts` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_rkwpnlbdksswffhgayfpjfghzsbhberdysic` FOREIGN KEY (`integrationId`) REFERENCES `formie_integrations` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `fk_uriykafqfrxrwmmttjlogfiacvqkmwopkhfy` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_pdftemplates`
--

DROP TABLE IF EXISTS `formie_pdftemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_pdftemplates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `template` varchar(255) NOT NULL,
  `filenameFormat` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_relations`
--

DROP TABLE IF EXISTS `formie_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mbvljtmqujmpzgaglwxwkizhejzvlauobsob` (`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_wwoxrxkwatezkwziyfhhzvnxpsymktrmptji` (`sourceId`),
  KEY `idx_gdhkwcatdjffpuuduimqfudnxooozdxnecpc` (`targetId`),
  KEY `idx_salnzhxungyesetaipocsiaffxvusejdgoin` (`sourceSiteId`),
  CONSTRAINT `fk_drrslhrohxucsiotnbplhrkfkxurcnxuhghu` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_vzhkypubiesmvjlsslmckypgnshpgtuxnark` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zotisducpneblbnojcatilzvzmfgrxxzcogw` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_rows`
--

DROP TABLE IF EXISTS `formie_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_rows` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int NOT NULL,
  `fieldLayoutFieldId` int NOT NULL,
  `row` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_eaehpzyrqvhulxdqoqnipfqtkleqvypgeiod` (`fieldLayoutFieldId`),
  KEY `idx_oahtwciqxusxaxgitzdimfwtfgmdbygoozpi` (`fieldLayoutId`),
  CONSTRAINT `fk_nyuzmwdcohyjgjpalevbdqduuyiyphpoirfo` FOREIGN KEY (`fieldLayoutFieldId`) REFERENCES `fieldlayoutfields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tdeyetduvcmfenykrzukkinjtfeaggwsvwmy` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_sentnotifications`
--

DROP TABLE IF EXISTS `formie_sentnotifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_sentnotifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `formId` int DEFAULT NULL,
  `submissionId` int DEFAULT NULL,
  `notificationId` int DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `replyTo` varchar(255) DEFAULT NULL,
  `replyToName` varchar(255) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `fromName` varchar(255) DEFAULT NULL,
  `sender` varchar(255) DEFAULT NULL,
  `body` mediumtext,
  `htmlBody` mediumtext,
  `info` text,
  `success` tinyint(1) DEFAULT NULL,
  `message` text,
  `dateCreated` datetime DEFAULT NULL,
  `dateUpdated` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_duzqbrzrrogpmidlfulygqpysepyvnsludti` (`formId`),
  KEY `fk_miixbkaphlhshqweotquobdqwlwpnskeputc` (`submissionId`),
  KEY `fk_sztafztxoupjstvziofbjajklsstdzhbswvr` (`notificationId`),
  CONSTRAINT `fk_duzqbrzrrogpmidlfulygqpysepyvnsludti` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_miixbkaphlhshqweotquobdqwlwpnskeputc` FOREIGN KEY (`submissionId`) REFERENCES `formie_submissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rbhrqqjlfelxliqxcfellzexqwheaipbgmbv` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_sztafztxoupjstvziofbjajklsstdzhbswvr` FOREIGN KEY (`notificationId`) REFERENCES `formie_notifications` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_statuses`
--

DROP TABLE IF EXISTS `formie_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `description` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_stencils`
--

DROP TABLE IF EXISTS `formie_stencils`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_stencils` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `data` mediumtext,
  `templateId` int DEFAULT NULL,
  `submitActionEntryId` int DEFAULT NULL,
  `submitActionEntrySiteId` int DEFAULT NULL,
  `defaultStatusId` int DEFAULT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dvdsvtuqhnoxdigrgwocaspircblrktswidv` (`templateId`),
  KEY `idx_xbpeiabmqelohscayupljojoylregqrjonga` (`defaultStatusId`),
  CONSTRAINT `fk_ftfmrisnvxvcstbhcxffiqqroogzcwmyxlzl` FOREIGN KEY (`templateId`) REFERENCES `formie_formtemplates` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_lacbdjekmfqlojmgkgjoqrredjptpbekjrwp` FOREIGN KEY (`defaultStatusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_submissions`
--

DROP TABLE IF EXISTS `formie_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_submissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `formId` int NOT NULL,
  `statusId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `isIncomplete` tinyint(1) DEFAULT '0',
  `isSpam` tinyint(1) DEFAULT '0',
  `spamReason` text,
  `spamClass` varchar(255) DEFAULT NULL,
  `snapshot` text,
  `ipAddress` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zpfgyfckqruuczbrvxmdavclkseoiwkuvxir` (`formId`),
  KEY `idx_awhcrrgebwlferavchrvvmrmhgehijlipaxm` (`statusId`),
  KEY `idx_zasmlugarlhovwmsrhvaaczvcyyeziyofjkv` (`userId`),
  CONSTRAINT `fk_kphzewtrjizjtttrxrsesxsqhpszwexdcvox` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mwszpduobuuuzzydrcvdwfsdwjplmyezfrfn` FOREIGN KEY (`formId`) REFERENCES `formie_forms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nozhkyvjhmnmlibbdikvvyuchglpvelmunxd` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_nummumqboyjxweybmbptlguvbdieogzgubbz` FOREIGN KEY (`statusId`) REFERENCES `formie_statuses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_syncfields`
--

DROP TABLE IF EXISTS `formie_syncfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_syncfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `syncId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_myxywdaoaznwciqavlibwbqomagdvyszqjbp` (`syncId`,`fieldId`),
  KEY `fk_wpmlhnezbjilhzkijwtdlweooncuquwmyevu` (`fieldId`),
  CONSTRAINT `fk_dghlfzujgzyqstqlrcitdzsbowfpwbgdskic` FOREIGN KEY (`syncId`) REFERENCES `formie_syncs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wpmlhnezbjilhzkijwtdlweooncuquwmyevu` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_syncs`
--

DROP TABLE IF EXISTS `formie_syncs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_syncs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formie_tokens`
--

DROP TABLE IF EXISTS `formie_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formie_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `accessToken` text,
  `secret` text,
  `endOfLife` varchar(255) DEFAULT NULL,
  `refreshToken` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_corvacvovsadrxduunbjkdzshuzypzgogxdx` (`name`),
  KEY `idx_lzixoggtfjdkorpmnpgsrlgenopuxtkclytu` (`handle`),
  KEY `idx_kdbaxpcihvxwrvxjxjbqnnpbdqtjffgxakzh` (`fieldLayoutId`),
  KEY `idx_feebqfwfwgeouqrhgjpfjcnqlrfkvaelxywz` (`sortOrder`),
  CONSTRAINT `fk_rlrxmdhsqwyryizsggyuvknfhbbvmibiyrzv` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_veawubrsrojvepazmrmmivyvlzsmhnwauhnc` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dchgrlbchgokfyjfvhsfilbpzjjymnfksuub` (`accessToken`),
  UNIQUE KEY `idx_lhjnhxfxdqtmtpwrjickvpdfjdvprywcteyg` (`name`),
  KEY `fk_jcntjdnarggtwefcpizpuiamlpwvpodcduui` (`schemaId`),
  CONSTRAINT `fk_jcntjdnarggtwefcpizpuiamlpwvpodcduui` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagetransformindex`
--

DROP TABLE IF EXISTS `imagetransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagetransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `transformer` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `transformString` varchar(255) NOT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rmchaazhvsgyhutueugrswgeithxgtyzlrux` (`assetId`,`transformString`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imagetransforms`
--

DROP TABLE IF EXISTS `imagetransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imagetransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `parameterChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gqlrhdgdevqjvxqiursalzvznqifhlgiphib` (`name`),
  KEY `idx_cdnmxcxjlweakhtysryhsuzrzwrpdbdabvug` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `knockknock_logins`
--

DROP TABLE IF EXISTS `knockknock_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `knockknock_logins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ipAddress` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `loginPath` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lenz_linkfield`
--

DROP TABLE IF EXISTS `lenz_linkfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lenz_linkfield` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `type` varchar(63) DEFAULT NULL,
  `linkedUrl` text,
  `linkedId` int DEFAULT NULL,
  `linkedSiteId` int DEFAULT NULL,
  `linkedTitle` varchar(255) DEFAULT NULL,
  `payload` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_rxrarmoncuarjuuipfknzlkmzdgkyltjjjkx` (`elementId`,`siteId`,`fieldId`),
  KEY `idx_ldkpnqtdgfhpykggpnovrnmqpgluqbbmoidn` (`fieldId`),
  KEY `idx_ylvnpkzguokqbtvdjhtidgeqneodxeiraeqc` (`siteId`),
  KEY `fk_vxtqggyktfkwvzeodxcznqdqkrkaqaegovis` (`linkedId`),
  KEY `fk_rddfrlhmcnspbxtoxjtsmoknldoywzubxfgz` (`linkedSiteId`),
  CONSTRAINT `fk_kxrgqinxbifklphdsxicgmjywjhrztofbgst` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rddfrlhmcnspbxtoxjtsmoknldoywzubxfgz` FOREIGN KEY (`linkedSiteId`) REFERENCES `sites` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_vxtqggyktfkwvzeodxcznqdqkrkaqaegovis` FOREIGN KEY (`linkedId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_wuuzjdrhfgbycinkfzfuxksbbpqkggxuswbh` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int NOT NULL,
  `primaryOwnerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_vjzvbezncgszjrwzcclezmguowwwycwsybpl` (`primaryOwnerId`),
  KEY `idx_qlsjzyxobthwzvpyjtblcrrkmjlilzbwihxo` (`fieldId`),
  KEY `idx_bbbtrrmjzsfccikrzhmlivuloiuxdwjekwes` (`typeId`),
  CONSTRAINT `fk_bjcjboivdhyahztpdyfmvlurlehtchsszgrn` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_emuliyoejikpmgwzuzytpjeoorsfyycwvrkm` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jbbssgwufholpkfeyuawmdbpzzhkrukanfrq` FOREIGN KEY (`primaryOwnerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_oomfhamdqclviuotwtfwiwulnlzojoizszza` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks_owners`
--

DROP TABLE IF EXISTS `matrixblocks_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks_owners` (
  `blockId` int NOT NULL,
  `ownerId` int NOT NULL,
  `sortOrder` smallint unsigned NOT NULL,
  PRIMARY KEY (`blockId`,`ownerId`),
  KEY `fk_zqusprmvtziemphovsmdkwiechuykkwtcvcp` (`ownerId`),
  CONSTRAINT `fk_acempiqfkgsxsaqdgmzwtojzijvtoqcedwku` FOREIGN KEY (`blockId`) REFERENCES `matrixblocks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zqusprmvtziemphovsmdkwiechuykkwtcvcp` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_owwbbdjxtrerdfdjrovtoqtbbqxeblohqubp` (`name`,`fieldId`),
  KEY `idx_ezrmqracxwtgdnyjyyngfobpvfdlpqnbwjgi` (`handle`,`fieldId`),
  KEY `idx_suexizqnuogviauuewylumoddkaatovicrjm` (`fieldId`),
  KEY `idx_qcygjhltbdallsqtbqoejipdzwywenjcjqgt` (`fieldLayoutId`),
  CONSTRAINT `fk_ncgqrskdywacotznbqqribobmkwgeezlhcfa` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_twgrpvfyoltdmddutrioicvntqdrtovacydm` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_contentblocks`
--

DROP TABLE IF EXISTS `matrixcontent_contentblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_contentblocks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_textImage_text` text,
  `field_textImage_eyebrow` text,
  `field_textImage_variant_payanbyx` varchar(255) DEFAULT NULL,
  `field_textImage_anchor` text,
  `field_textImage_bg_cpekkbhk` varchar(255) DEFAULT NULL,
  `field_textImage_spacing_eqfigngd` varchar(255) DEFAULT NULL,
  `field_text_bg_dqtdfrpw` varchar(255) DEFAULT NULL,
  `field_text_text` text,
  `field_text_variant_qfgjxwao` varchar(255) DEFAULT NULL,
  `field_text_spacing_lhqmhzea` varchar(255) DEFAULT NULL,
  `field_text_anchor` text,
  `field_text_eyebrow` text,
  `field_fragment_spacing_gslywyag` varchar(255) DEFAULT NULL,
  `field_fragment_bg_nfwtlclo` varchar(255) DEFAULT NULL,
  `field_tagListing_bg_fwxmzlie` varchar(255) DEFAULT NULL,
  `field_tagListing_variant_kpwsojnc` varchar(255) DEFAULT NULL,
  `field_tagListing_spacing_rirvtxji` varchar(255) DEFAULT NULL,
  `field_tagListing_text_kwmvoeva` text,
  `field_tagListing_hasPagination_twdfutkz` tinyint(1) DEFAULT NULL,
  `field_tagListing_order_lppqelbx` varchar(255) DEFAULT NULL,
  `field_tagListing_limit_mcovhmgu` int DEFAULT NULL,
  `field_tagListing_hasSearch_ayojqsiw` tinyint(1) DEFAULT NULL,
  `field_faqListing_order_jidmezte` varchar(255) DEFAULT NULL,
  `field_faqListing_variant_afglrhoj` varchar(255) DEFAULT NULL,
  `field_faqListing_limit_ajwnsacs` int DEFAULT NULL,
  `field_faqListing_spacing_wbmfjcuh` varchar(255) DEFAULT NULL,
  `field_faqListing_hasSearch_sfmlstuo` tinyint(1) DEFAULT NULL,
  `field_faqListing_text_hyzrszln` text,
  `field_faqListing_hasPagination_qqtvixca` tinyint(1) DEFAULT NULL,
  `field_faqListing_bg_fjmlbprp` varchar(255) DEFAULT NULL,
  `field_entries_layout` varchar(255) DEFAULT NULL,
  `field_entries_background` varchar(255) DEFAULT NULL,
  `field_entries_text` text,
  `field_entries_edges` varchar(255) DEFAULT NULL,
  `field_entries_eyebrow` text,
  `field_entries_anchor` text,
  `field_newsListing_text_tzocwopw` text,
  `field_newsListing_variant_lmsffoac` varchar(255) DEFAULT NULL,
  `field_newsListing_spacing_kbibsqwh` varchar(255) DEFAULT NULL,
  `field_newsListing_hasPagination_kdjpooyf` tinyint(1) DEFAULT NULL,
  `field_newsListing_bg_sufzuzdu` varchar(255) DEFAULT NULL,
  `field_newsListing_limit_njtiaavk` int DEFAULT NULL,
  `field_newsListing_order_youtxjmv` varchar(255) DEFAULT NULL,
  `field_newsListing_hasSearch_pkgeltqc` tinyint(1) DEFAULT NULL,
  `field_repeater_anchor` text,
  `field_repeater_bg_ngczrvyg` varchar(255) DEFAULT NULL,
  `field_repeater_eyebrow` text,
  `field_repeater_spacing_vdailebf` varchar(255) DEFAULT NULL,
  `field_repeater_variant_ulxtrpcp` varchar(255) DEFAULT NULL,
  `field_repeater_text` text,
  `field_image_anchor` text,
  `field_image_layout` varchar(255) DEFAULT NULL,
  `field_image_background` varchar(255) DEFAULT NULL,
  `field_image_eyebrow` text,
  `field_image_edges` varchar(255) DEFAULT NULL,
  `field_textText_anchor` text,
  `field_textText_eyebrow` text,
  `field_textText_background` varchar(255) DEFAULT NULL,
  `field_textText_layout` varchar(255) DEFAULT NULL,
  `field_textText_text2` text,
  `field_textText_text` text,
  `field_textText_edges` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_aitzkclsukgbwmodnexyoktzosqiqpirleub` (`elementId`,`siteId`),
  KEY `fk_masaddjtpzdwmsytyjcikiicbplsbwmtfogy` (`siteId`),
  CONSTRAINT `fk_masaddjtpzdwmsytyjcikiicbplsbwmtfogy` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_stqqmsuojocfpucjsmjwjvnfffyssnynzlkb` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_heroblock`
--

DROP TABLE IF EXISTS `matrixcontent_heroblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_heroblock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_text` text,
  `field_text_variant_ntqzccqg` varchar(255) DEFAULT NULL,
  `field_text_headline` text,
  `field_text_eyebrow` text,
  `field_text_bg_unpwravq` varchar(255) DEFAULT NULL,
  `field_textImage_variant_udmwrcap` varchar(255) DEFAULT NULL,
  `field_textImage_eyebrow` text,
  `field_textImage_headline` text,
  `field_textImage_text` text,
  `field_textImage_bg_rqyqbtbd` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_hmfrdnxtepexpeexnbioczxuavadldgfjppp` (`elementId`,`siteId`),
  KEY `fk_biluyhszkpmqbxhbseayhkexwriqoazmecng` (`siteId`),
  CONSTRAINT `fk_biluyhszkpmqbxhbseayhkexwriqoazmecng` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_yeizroziyklckcpppxhgqknuuoqfqhouqwpm` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_listingblock`
--

DROP TABLE IF EXISTS `matrixcontent_listingblock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_listingblock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_faqs_hasSearch` tinyint(1) DEFAULT NULL,
  `field_faqs_limit` int DEFAULT NULL,
  `field_news_layout_hujeyyhb` varchar(255) DEFAULT NULL,
  `field_news_hasSearch` tinyint(1) DEFAULT NULL,
  `field_news_limit` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_khclszmrzlazptwjbhimhbnayhxfpeuuialf` (`elementId`,`siteId`),
  KEY `fk_lauuqcdkuhzgwysuchjhqnyykidacvoluqvp` (`siteId`),
  CONSTRAINT `fk_fuqcczavktnulpsipsjtyjakkqmrlglkuuzc` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lauuqcdkuhzgwysuchjhqnyykidacvoluqvp` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixcontent_sidebarblocks`
--

DROP TABLE IF EXISTS `matrixcontent_sidebarblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixcontent_sidebarblocks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_text_text` text,
  `field_headline_headline` text,
  `field_headline_eyebrow` text,
  `field_headline_background` varchar(255) DEFAULT NULL,
  `field_headline_anchor` text,
  `field_headline_edges` varchar(255) DEFAULT NULL,
  `field_headline_layout` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_raxplwvbxdecnqdbuymfezfkeaimzeknjokx` (`elementId`,`siteId`),
  KEY `fk_tbenjdqoonvllsjiixpjihbennrfjakllnpf` (`siteId`),
  CONSTRAINT `fk_llqzbwwhzgsrreigwmnkrqdxcewnekhnlpem` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tbenjdqoonvllsjiixpjihbennrfjakllnpf` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_mbmttnolubflcsvmndaoacrqeydczscmkbrh` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_navs`
--

DROP TABLE IF EXISTS `navigation_navs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_navs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `instructions` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `propagateNodes` tinyint(1) DEFAULT '0',
  `maxNodes` int DEFAULT NULL,
  `permissions` text,
  `fieldLayoutId` int DEFAULT NULL,
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ebgqnydxfvtiznirtqjfmsvqcvxsvzntstmj` (`handle`),
  KEY `idx_oynhrwghdzuibhxflfurvvccdlprmkcjpzoi` (`structureId`),
  KEY `idx_zozurxywcyvhetvbfdonauvdvskorzqmdinx` (`fieldLayoutId`),
  KEY `idx_upmypaycahisaaqnpjefajiigtcvvhwimeil` (`dateDeleted`),
  CONSTRAINT `fk_loysnngpjtqlnosqhvatzbjcbgsiasleiwnx` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_sywlydcoeaqspsghdmhuhdnygnfnonumbpbf` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_navs_sites`
--

DROP TABLE IF EXISTS `navigation_navs_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_navs_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `navId` int NOT NULL,
  `siteId` int NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_iysrxuotoojfgbtukzwhwprxyteyfpqudkko` (`navId`,`siteId`),
  KEY `idx_vcqxmdxurpkwbcubiyzcpirclsxoeyqroncu` (`siteId`),
  CONSTRAINT `fk_fgnydfauoerdeqomcltkulrhpmmhsdahqhfa` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lbykyzcxndylitqorzlyolcyvoohekvejste` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `navigation_nodes`
--

DROP TABLE IF EXISTS `navigation_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_nodes` (
  `id` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `navId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `classes` varchar(255) DEFAULT NULL,
  `urlSuffix` varchar(255) DEFAULT NULL,
  `customAttributes` text,
  `data` text,
  `newWindow` tinyint(1) DEFAULT '0',
  `deletedWithNav` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_tgojtwjmhtgclaqrthqtrgeoaplyozlulmth` (`navId`),
  KEY `fk_aaaihrlvfzcwdozgscbexhdnxifmfabfsymn` (`elementId`),
  CONSTRAINT `fk_aaaihrlvfzcwdozgscbexhdnxifmfabfsymn` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_hurwjbbqvlhjntzgggfciiynthuleugmpiox` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qfnickragftibgsigqmrghrlznadxfmlzsci` FOREIGN KEY (`navId`) REFERENCES `navigation_navs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  UNIQUE KEY `idx_qrwixjcljggawnqfncgqhlukxybgmhvfjjgc` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_xfowozyignbivjmkazjlpgxregqiumpdmnsl` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_oncksfnvipedxrwtsluksdzfejoiopfsdbzx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ruethdsomyftgerrvjqhiubwojfmpdlvncxb` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_ojmstdqelhwwyhdtndcszlkzcjtdakocnsfq` (`sourceId`),
  KEY `idx_qesnyqfzgtbvslizafsebkinnydkkutfqchx` (`targetId`),
  KEY `idx_laytguirotageqfjzvpkkmnmmezoisbcdkhd` (`sourceSiteId`),
  CONSTRAINT `fk_ggplettuinorjnfadpolkepzvickrgfhcsft` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nlinykoxmvnmqvncbwukzdjdgqvydafbwrce` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nqxovvnyhgjawtjalwbinvuotmivmpmzdgyw` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tzxkthqwnqycowyepbxiihwmaiumxobvwqpx` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `canonicalId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bureemwirkhhkudbvijjntbkhjoslpugisgx` (`canonicalId`,`num`),
  KEY `fk_nfggsvlvzmqxxxffylqutxgmhmlsbgflpkss` (`creatorId`),
  CONSTRAINT `fk_nfggsvlvzmqxxxffylqutxgmhmlsbgflpkss` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_xyoaemjdupmezwlrdaorxmwieuughueybktf` FOREIGN KEY (`canonicalId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_tjlrnyyzktoeymrabxczqndvrpmaqawelqgq` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `defaultPlacement` enum('beginning','end') NOT NULL DEFAULT 'end',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_qguwzbbfxltofigtwbkoyowtzbmegihtdnfj` (`handle`),
  KEY `idx_fhtqrxilrvmkwtdeaspwjmahlmilxpgbopsq` (`name`),
  KEY `idx_yzaczyaolcmetrtvpninoenzfurtrypdmamp` (`structureId`),
  KEY `idx_ofmcoxwzlxukwanbuodnzffplokcfhbnnhux` (`dateDeleted`),
  CONSTRAINT `fk_mpmjxykrelnndknemgymzcctobceafoqsoio` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_etihjynlncipplpyiekqcialqdwcmiyqkmwg` (`sectionId`,`siteId`),
  KEY `idx_cfdgtlkmyflaulpepopzollvelxwlutkhhth` (`siteId`),
  CONSTRAINT `fk_gzxcxctdsipegagfdnpdqruiafbbimgcntpj` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ryjniuguvmjtngozzlashhrzcxrpxslnxdlw` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seomatic_metabundles`
--

DROP TABLE IF EXISTS `seomatic_metabundles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seomatic_metabundles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `bundleVersion` varchar(255) NOT NULL DEFAULT '',
  `sourceBundleType` varchar(255) NOT NULL DEFAULT '',
  `sourceId` int DEFAULT NULL,
  `sourceName` varchar(255) NOT NULL DEFAULT '',
  `sourceHandle` varchar(255) NOT NULL DEFAULT '',
  `sourceType` varchar(64) NOT NULL DEFAULT '',
  `typeId` int DEFAULT NULL,
  `sourceTemplate` varchar(500) DEFAULT '',
  `sourceSiteId` int DEFAULT NULL,
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
  KEY `idx_jpxjoicdiaxevgvytzmkdztvpppulymfykdo` (`sourceBundleType`),
  KEY `idx_ywajyeaqimlzhsltobcmxgiqllukrjgwdbot` (`sourceId`),
  KEY `idx_wajuvxwfhekcgspbrhvjyjdegjlmbjohvtgp` (`sourceSiteId`),
  KEY `idx_qgtscalmfpcikuppxdnerixuvbuliiemwhdq` (`sourceHandle`),
  CONSTRAINT `fk_flgqmwqbqegoukredgxvjrbnducbyohkbolr` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ksnddctukzpmuxlsqnbzlvvktskirjlewila` (`uid`),
  KEY `idx_gxestzsugtwihgvlrhnyilmzpddscehbmwmq` (`token`),
  KEY `idx_xfvyztbzpzztxtwipijlpcyabeeeqpukrtab` (`dateUpdated`),
  KEY `idx_xaqwqyqegtktzxzjwqmndcohgpqkyyryshng` (`userId`),
  CONSTRAINT `fk_qjnhkmulxlkrzcdbzhsguqfroniceoblgtcz` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sherlock`
--

DROP TABLE IF EXISTS `sherlock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sherlock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `highSecurityLevel` tinyint(1) NOT NULL,
  `pass` tinyint(1) NOT NULL,
  `warning` tinyint(1) NOT NULL,
  `results` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_lgxnenussvqncnworikwowptmeqewloxotta` (`siteId`),
  CONSTRAINT `fk_clugauxogjenqnktntwkyvpnnvhjjqddhxww` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_yzllpjllhyfgmxtxsukbflipukkyrosjnyaa` (`userId`,`message`),
  CONSTRAINT `fk_exdrikriqwmtarcwvutaqqlovyhhchdaxldo` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_khfcnzohlhxndulfuinwdgddnlbzdfjbcebl` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` varchar(255) NOT NULL DEFAULT 'true',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_zmqdqknstezwzkfkczhlxsubnhxlvulgpxhi` (`dateDeleted`),
  KEY `idx_wxbppjmngdwzlhcuabilyngzmxaqvnsyamnv` (`handle`),
  KEY `idx_uwfogjqyemcvgqdqnbhrluopkuqmzcrvfkiv` (`sortOrder`),
  KEY `fk_knylnlmqlbjufhgikuatqzihjkknqlpnzshf` (`groupId`),
  CONSTRAINT `fk_knylnlmqlbjufhgikuatqzihjkknqlpnzshf` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sprig_playgrounds`
--

DROP TABLE IF EXISTS `sprig_playgrounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sprig_playgrounds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `component` text,
  `variables` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stc_6_items`
--

DROP TABLE IF EXISTS `stc_6_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stc_6_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_headline` text,
  `field_text` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_xrxoilqzxvtpagkbxhsbjlnzfekutfngmmfc` (`elementId`,`siteId`),
  KEY `fk_cioioeyaykxgfopqkdjfbarzqjicxwpfaiqy` (`siteId`),
  CONSTRAINT `fk_cioioeyaykxgfopqkdjfbarzqjicxwpfaiqy` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_omszpokoimnptbqsuimheqeiqmxvoiuybnme` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tzactttkvfqzadocpgtwyrgwdpzsydfdzzaw` (`structureId`,`elementId`),
  KEY `idx_sqdshbzdwqdvdhrilnmjtrfuggpgantxznlm` (`root`),
  KEY `idx_kbptguwacxenzilexygzxroonujguyvebkmm` (`lft`),
  KEY `idx_ufhltitsbitchtjhjxcbfmekfxaiikbcuwdd` (`rgt`),
  KEY `idx_uugxjbmfwvsqxqbyqfyngbrxdgejikgklaxo` (`level`),
  KEY `idx_nyzpurmeypitoeljsmdxhhfvwqzveyrejfso` (`elementId`),
  CONSTRAINT `fk_kceelolpvvyzhedwbjxogqpukwlaxnvoseug` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qvqbslkyfmznqurimaffjthjjndtxgdafjsk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_nhkwoqrtzkycqddswfvljcylioenttedwbtq` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocks`
--

DROP TABLE IF EXISTS `supertableblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocks` (
  `id` int NOT NULL,
  `primaryOwnerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_zshipimdkrdqxtvtfnunadycauxcmdiyxrkv` (`primaryOwnerId`),
  KEY `idx_wvvcwbdsusmwjhevssmbvygmbjnfqdgssvtz` (`fieldId`),
  KEY `idx_qigkozfzydrqwhpaxjiyynhvgqppgyfdxsoe` (`typeId`),
  CONSTRAINT `fk_diridqcencljtzbxipeflqvtezzlzjexduqm` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_dnwctkxbteerwaljvimtbhslrlruerzjnsep` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wggvuhrioinpoorxbbivyocrwhnqaneycens` FOREIGN KEY (`typeId`) REFERENCES `supertableblocktypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_znvxtazkwcshubgxcvveyconsklgjtblrvnu` FOREIGN KEY (`primaryOwnerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocks_owners`
--

DROP TABLE IF EXISTS `supertableblocks_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocks_owners` (
  `blockId` int NOT NULL,
  `ownerId` int NOT NULL,
  `sortOrder` smallint unsigned NOT NULL,
  PRIMARY KEY (`blockId`,`ownerId`),
  KEY `fk_tfywwhtdgywaaobswfaoiolvvownmxpjwxel` (`ownerId`),
  CONSTRAINT `fk_foyhxseeuciijkyyhccukffxvbwaespsdefh` FOREIGN KEY (`blockId`) REFERENCES `supertableblocks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tfywwhtdgywaaobswfaoiolvvownmxpjwxel` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supertableblocktypes`
--

DROP TABLE IF EXISTS `supertableblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supertableblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mnfwxlydufhtqyeusadvjhgmzonapwpewysv` (`fieldId`),
  KEY `idx_fnhsepnfpzjyprahugehcoqlseeevqbficea` (`fieldLayoutId`),
  CONSTRAINT `fk_pysmezcuevcdslwoxixflgtyulsfxmokmsoq` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yaimwviiaiqtpfbbeukujfdwdpaiqbzymmdz` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_dlfkaryyqjrmyexsdbugafgeuqjnhqdpflfd` (`key`,`language`),
  KEY `idx_czbxumisxpjqixnuitoutraaywhppjtquspp` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ittkjxsbptczfkbfkklbogttfrhozsmcgwhv` (`name`),
  KEY `idx_udqhyybkzrktdftyltcdbwijucjmmbstexnw` (`handle`),
  KEY `idx_grgafbndnjqtqivxgbopiufqhconleixbdej` (`dateDeleted`),
  KEY `fk_kvcdjezwdxjpsuqpzcuhkotszbsowwayetqy` (`fieldLayoutId`),
  CONSTRAINT `fk_kvcdjezwdxjpsuqpzcuhkotszbsowwayetqy` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_fnzzudncxwaktkcpzxoxkoqfsjatjiylqwgy` (`groupId`),
  CONSTRAINT `fk_poglzgypluybtndjdxeffbrpkekqmwmoydmm` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_skrabojeordtmrfffbwcvxbtylpkrrffyuwe` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vhgmbeflbzrtikrfelyyylaimawasxqryhst` (`token`),
  KEY `idx_mcdqueuvqjsptcnrgoqhjqfzkdfyullrykwu` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_shunypqvsnquoxuwgryleqketfqnejqcxslm` (`handle`),
  KEY `idx_fidwunzcadfmcccrxjybhuzpafzbbrhbicnx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_yhjnmjomiyfmdwqsytxlfqvuzvyuvvqcnmuz` (`groupId`,`userId`),
  KEY `idx_bvsznsrubsoywxdqbkwjpuikbmstuxsmvwah` (`userId`),
  CONSTRAINT `fk_eqjnpsuaxrsxhychzfjwkmisraxxmblmkkvj` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_usnotuizixfvwwmzxcymaygxwrkdhhsasdsz` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_argjspgjmbvpgonuijjravgiqdbrnqoelots` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_vdnfbbnsvtsedqghrqktuhlclikkgsgkquzt` (`permissionId`,`groupId`),
  KEY `idx_jrpghasyatqhrftyibyfwickkbgpkubnksyy` (`groupId`),
  CONSTRAINT `fk_jtkgvitnieiapxbngpbattwpvqoqedlxswlm` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_yfdtwyazezujtnnveknfczxcczeificigphb` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_tzflkszyciyfxhzwtdpzskmgatszbynvmjpo` (`permissionId`,`userId`),
  KEY `idx_khqagoncjgdgoiowfediobiqtcambrtzgfvc` (`userId`),
  CONSTRAINT `fk_awohiugmgbtxhnsscwdfoaupoymgwhgxoauj` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fndbnjflqicadsgzlldjrnqldcdqfstauqer` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_enwdpdmsehrvzlshesnlvgdbgvtekqwomhhy` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `photoId` int DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `username` varchar(255) DEFAULT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
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
  PRIMARY KEY (`id`),
  KEY `idx_wnhwkgsmfollxgsbetqywostqnkkaetaiamw` (`active`),
  KEY `idx_gdpiomjqnjzklcbelpqbgolcoegyldaasgfn` (`locked`),
  KEY `idx_zxjjrucgazddvifevexwcodxqtbvuwhgloqc` (`pending`),
  KEY `idx_bcpfzixjrswemsngiifagnwoyabvzfojgfur` (`suspended`),
  KEY `idx_yyhvrmujclbtuimdsgosfsavayyladjrpijr` (`verificationCode`),
  KEY `idx_nivycexcorkanuwyuuqxltkedtkvghmkejgj` (`email`),
  KEY `idx_hiujudhwqdhmehnnpbugyesxetxuabmednku` (`username`),
  KEY `fk_pglerqwbrjmtzxlzcvddjuothcxemvlrobzo` (`photoId`),
  CONSTRAINT `fk_pglerqwbrjmtzxlzcvddjuothcxemvlrobzo` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_wdqugvoavembmsxhnjherwbipzreibslqecr` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_wcmaegbqeojknpfhekfdjixoysuivsmudvvg` (`name`,`parentId`,`volumeId`),
  KEY `idx_nkzjtcqpepdanslluegqlulidjxkdiphiagm` (`parentId`),
  KEY `idx_kvzaopzhahekkfmhwvwwfqdcjhrqtkvezbqy` (`volumeId`),
  CONSTRAINT `fk_dzotcgrwcaarpftnwmprcwnwpdvytzlwumea` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wmcyfjoirzxmsppqsbifkjzyofabwcchjunb` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fs` varchar(255) NOT NULL,
  `transformFs` varchar(255) DEFAULT NULL,
  `transformSubpath` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jxyczipixzmhxgtahjkhgapfnnoskbdegoam` (`name`),
  KEY `idx_iprrdjjmdwgxvzjaotvqvdvkxcugyhvoacbg` (`handle`),
  KEY `idx_jkvetyoxeugfmayzsggsfzmlwqifegozsupr` (`fieldLayoutId`),
  KEY `idx_bygutrxghyohqwctggenidvdqbvehezpjzss` (`dateDeleted`),
  CONSTRAINT `fk_itcphnnuumnyrbxhzmbjvowqoqsmotqyxqwz` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_nalsermnmcjfmnpevpxioqeomqgsticlciou` (`userId`),
  CONSTRAINT `fk_izfajinbdlmshllcbdpwitkawajequvezwzr` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
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

-- Dump completed on 2022-10-05 22:31:58
-- MariaDB dump 10.19  Distrib 10.6.9-MariaDB, for Linux (x86_64)
--
-- Host: mysql    Database: project
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assetindexingsessions`
--

LOCK TABLES `assetindexingsessions` WRITE;
/*!40000 ALTER TABLE `assetindexingsessions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assetindexingsessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

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
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedattributes` VALUES (17,2,'postDate','2022-10-05 22:22:58',0,16),(17,2,'slug','2022-10-05 22:23:58',0,16),(17,2,'title','2022-10-05 22:22:58',0,16),(17,2,'uri','2022-10-05 22:22:58',0,16);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `changedfields` VALUES (17,2,2,'2022-10-05 22:22:58',0,16),(17,2,4,'2022-10-05 22:22:58',0,16),(17,2,5,'2022-10-05 22:22:58',0,16),(17,2,6,'2022-10-05 22:22:58',0,16),(17,2,8,'2022-10-05 22:22:58',0,16);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,2,'Alert Message','2022-10-05 22:19:08','2022-10-05 22:19:42','204fa955-6286-498c-9a70-465059ba4909',NULL,NULL,NULL,NULL,NULL,NULL),(2,2,2,'Alert Message','2022-10-05 22:19:08','2022-10-05 22:19:08','05c0bd45-ba74-495f-a46b-c9cf2c3d9546',NULL,NULL,NULL,NULL,NULL,NULL),(3,3,2,'Alert Message','2022-10-05 22:19:09','2022-10-05 22:19:09','6cd0f11a-fa20-474b-bf10-c5c13c01dc0c',NULL,NULL,NULL,NULL,NULL,NULL),(4,4,2,'Error 404','2022-10-05 22:19:09','2022-10-05 22:19:43','26a75d83-78b5-4f46-ae76-3e63afade740',NULL,NULL,NULL,NULL,NULL,NULL),(5,5,2,'Error 404','2022-10-05 22:19:09','2022-10-05 22:19:09','d27bfcdf-be03-4ea2-9e2c-bf35868d5253',NULL,NULL,NULL,NULL,NULL,NULL),(6,6,2,'Error 404','2022-10-05 22:19:10','2022-10-05 22:19:10','809ae683-778b-4f37-80c5-34952c2783fa',NULL,NULL,NULL,NULL,NULL,NULL),(7,7,2,'Search','2022-10-05 22:19:10','2022-10-05 22:19:44','f8f98869-8032-48e4-8d1d-c93e5f036080',NULL,NULL,NULL,NULL,NULL,NULL),(8,8,2,'Search','2022-10-05 22:19:10','2022-10-05 22:19:10','df81a723-1587-4ad1-b682-9d8c1a4afdbe',NULL,NULL,NULL,NULL,NULL,NULL),(9,9,2,'Search','2022-10-05 22:19:11','2022-10-05 22:19:11','f104bf7b-d614-4d46-9f8d-9eda0a2b2db9',NULL,NULL,NULL,NULL,NULL,NULL),(10,10,2,'Alert Message','2022-10-05 22:19:41','2022-10-05 22:19:41','fc7c04cf-c38d-4057-93f4-8ea869bfffed',NULL,NULL,NULL,NULL,NULL,NULL),(11,11,2,'Alert Message','2022-10-05 22:19:42','2022-10-05 22:19:42','3f25aa31-d191-47e8-aa8b-555bfefb8030',NULL,NULL,NULL,NULL,NULL,NULL),(12,12,2,'Error 404','2022-10-05 22:19:42','2022-10-05 22:19:42','328b0fe5-c406-44f7-9d93-91b9055cab9a',NULL,NULL,NULL,NULL,NULL,NULL),(13,13,2,'Error 404','2022-10-05 22:19:43','2022-10-05 22:19:43','285cb045-182e-46f9-96f9-5c33dbdfcfef',NULL,NULL,NULL,NULL,NULL,NULL),(14,14,2,'Search','2022-10-05 22:19:44','2022-10-05 22:19:44','1e29a2b5-5b38-47a2-aa52-c8de2407a574',NULL,NULL,NULL,NULL,NULL,NULL),(15,15,2,'Search','2022-10-05 22:19:44','2022-10-05 22:19:44','ad2ef1c5-da34-4cd2-b434-8efe520bc0f2',NULL,NULL,NULL,NULL,NULL,NULL),(16,16,2,NULL,'2022-10-05 22:20:07','2022-10-05 22:20:07','7094fabd-e6c6-4d6a-bc03-4a076993113f',0,NULL,NULL,NULL,NULL,NULL),(17,17,2,'Home','2022-10-05 22:22:41','2022-10-05 22:23:58','1097c5cb-307e-48cf-805e-af7fc53670e6',NULL,'{\"bundleVersion\":\"1.0.23\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2022-10-05T18:22:57-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\",\"inherited\":{\"seoTitle\":true,\"seoDescription\":true,\"seoImage\":true},\"overrides\":[]},\"metaSiteVars\":{\"siteName\":\"Wireframe Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":null,\"sitemapAssets\":null,\"sitemapFiles\":null,\"sitemapAltLinks\":null,\"sitemapChangeFreq\":\"\",\"sitemapPriority\":\"\",\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[],\"inherited\":[],\"overrides\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"title\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":\"\",\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"images\",\"seoImageTransform\":\"1\",\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"\",\"twitterDescriptionSource\":\"\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"\",\"ogDescriptionSource\":\"\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL,NULL,NULL),(18,18,2,'Home','2022-10-05 22:22:58','2022-10-05 22:22:58','4f0858ff-6c52-4d25-9a66-0c66ee3c37ed',NULL,'{\"bundleVersion\":\"1.0.23\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2022-10-05T18:22:57-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\",\"inherited\":{\"seoTitle\":true,\"seoDescription\":true,\"seoImage\":true},\"overrides\":[]},\"metaSiteVars\":{\"siteName\":\"Wireframe Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":null,\"sitemapAssets\":null,\"sitemapFiles\":null,\"sitemapAltLinks\":null,\"sitemapChangeFreq\":\"\",\"sitemapPriority\":\"\",\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[],\"inherited\":[],\"overrides\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"title\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":\"\",\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"images\",\"seoImageTransform\":\"1\",\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"\",\"twitterDescriptionSource\":\"\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"\",\"ogDescriptionSource\":\"\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL,NULL,NULL),(20,20,2,'Home','2022-10-05 22:23:58','2022-10-05 22:23:58','751efbe8-00fe-429d-93b6-3081c34f98c0',NULL,'{\"bundleVersion\":\"1.0.23\",\"sourceBundleType\":\"field\",\"sourceId\":null,\"sourceName\":null,\"sourceHandle\":null,\"sourceType\":\"field\",\"typeId\":null,\"sourceTemplate\":\"\",\"sourceSiteId\":null,\"sourceAltSiteSettings\":[],\"sourceDateUpdated\":\"2022-10-05T18:22:57-04:00\",\"metaGlobalVars\":{\"language\":null,\"mainEntityOfPage\":\"\",\"seoTitle\":\"\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"\",\"robots\":\"\",\"ogType\":\"\",\"ogTitle\":\"\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"\",\"ogImage\":\"\",\"ogImageWidth\":\"\",\"ogImageHeight\":\"\",\"ogImageDescription\":\"\",\"twitterCard\":\"\",\"twitterCreator\":\"\",\"twitterTitle\":\"\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"\",\"twitterImage\":\"\",\"twitterImageWidth\":\"\",\"twitterImageHeight\":\"\",\"twitterImageDescription\":\"\",\"inherited\":{\"seoTitle\":true,\"seoDescription\":true,\"seoImage\":true},\"overrides\":[]},\"metaSiteVars\":{\"siteName\":\"Wireframe Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]},\"metaSitemapVars\":{\"sitemapUrls\":null,\"sitemapAssets\":null,\"sitemapFiles\":null,\"sitemapAltLinks\":null,\"sitemapChangeFreq\":\"\",\"sitemapPriority\":\"\",\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[],\"sitemapVideoFieldMap\":[],\"inherited\":[],\"overrides\":[]},\"metaContainers\":{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}},\"redirectsContainer\":[],\"frontendTemplatesContainer\":{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false},\"metaBundleSettings\":{\"siteType\":\"\",\"siteSubType\":\"\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"title\",\"siteNamePositionSource\":\"\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"title\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":\"\",\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"images\",\"seoImageTransform\":\"1\",\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"\",\"twitterDescriptionSource\":\"\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"\",\"ogDescriptionSource\":\"\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"\",\"ogImageDescriptionField\":\"\"}}',NULL,NULL,NULL,NULL);
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
-- Dumping data for table `dolphiq_redirects`
--

LOCK TABLES `dolphiq_redirects` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dolphiq_redirects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `dolphiq_redirects_catch_all_urls`
--

LOCK TABLES `dolphiq_redirects_catch_all_urls` WRITE;
/*!40000 ALTER TABLE `dolphiq_redirects_catch_all_urls` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `dolphiq_redirects_catch_all_urls` ENABLE KEYS */;
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
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,17,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:08','2022-10-05 22:19:42',NULL,NULL,'c03e65b9-a05e-48ce-bd7f-3f0a77bd7d14'),(2,1,NULL,1,17,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,NULL,'4e0c0a2d-a872-487d-b7f6-cd1d7fe733a0'),(3,1,NULL,2,17,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,NULL,'5401b83d-92b6-43f3-bff4-320019a2054f'),(4,NULL,NULL,NULL,19,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:09','2022-10-05 22:19:43',NULL,NULL,'e6800874-1578-4a4b-9c4e-61e66106dae0'),(5,4,NULL,3,19,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,NULL,'55fbd93e-eea2-4464-8d61-6762bf8a2e58'),(6,4,NULL,4,19,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,NULL,'9ad1952b-64a0-46fe-b540-e0b5151dd7cf'),(7,NULL,NULL,NULL,21,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:10','2022-10-05 22:19:44',NULL,NULL,'fe5f3ffa-73d6-4fa7-9de2-64f29196f98b'),(8,7,NULL,5,21,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,NULL,'b0eed2c2-fb68-44cd-b6c1-31e86f4ee4d4'),(9,7,NULL,6,21,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,NULL,'e25ed7a1-919b-4dd7-89d2-f6d605f6b2cc'),(10,1,NULL,7,17,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:41','2022-10-05 22:19:41',NULL,NULL,'dce81d34-9825-4567-8ed6-047442d98502'),(11,1,NULL,8,17,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:42','2022-10-05 22:19:42',NULL,NULL,'6713542c-c7f8-4bb3-ac53-4084eb157054'),(12,4,NULL,9,19,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:42','2022-10-05 22:19:42',NULL,NULL,'3bb61437-d5e1-4382-9801-0e864d7019b8'),(13,4,NULL,10,19,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:43','2022-10-05 22:19:43',NULL,NULL,'9837b69d-b923-48e6-803c-69e20a4400e1'),(14,7,NULL,11,21,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:44','2022-10-05 22:19:44',NULL,NULL,'c87efa5c-e03b-426a-806c-b0f7a2029be4'),(15,7,NULL,12,21,'craft\\elements\\Entry',1,0,'2022-10-05 22:19:44','2022-10-05 22:19:44',NULL,NULL,'1e0952f9-f481-4f01-86a5-447d2fa9f96c'),(16,NULL,NULL,NULL,26,'craft\\elements\\User',1,0,'2022-10-05 22:20:07','2022-10-05 22:20:07',NULL,NULL,'4be0f578-1057-4862-be1f-6a7345cc7a7d'),(17,NULL,NULL,NULL,16,'craft\\elements\\Entry',1,0,'2022-10-05 22:22:41','2022-10-05 22:23:58',NULL,NULL,'69774045-a950-4bd0-906f-3731d3ae541f'),(18,17,NULL,13,16,'craft\\elements\\Entry',1,0,'2022-10-05 22:22:58','2022-10-05 22:22:58',NULL,NULL,'8d8c9659-ebdc-4ce3-b41d-4d0cbe034276'),(20,17,NULL,14,16,'craft\\elements\\Entry',1,0,'2022-10-05 22:23:58','2022-10-05 22:23:58',NULL,NULL,'723729d4-ffe7-46c6-bdef-6096f50a13b4');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,2,'alert-message',NULL,1,'2022-10-05 22:19:08','2022-10-05 22:19:08','f113127c-6446-40da-8f6a-1b13be52aa39'),(2,2,2,'alert-message',NULL,1,'2022-10-05 22:19:08','2022-10-05 22:19:08','a5802249-729a-4b82-a8a7-a64d34ac5c5b'),(3,3,2,'alert-message',NULL,1,'2022-10-05 22:19:09','2022-10-05 22:19:09','5bbe8e30-a544-4d81-bc90-0ee311dabee2'),(4,4,2,'error-404',NULL,1,'2022-10-05 22:19:09','2022-10-05 22:19:09','290f5f67-a9e3-4643-98da-ad9881b37d61'),(5,5,2,'error-404',NULL,1,'2022-10-05 22:19:09','2022-10-05 22:19:09','c42435f1-8252-4fa9-ade0-1f452f4a3fe9'),(6,6,2,'error-404',NULL,1,'2022-10-05 22:19:10','2022-10-05 22:19:10','ac1ea81c-b5d6-48df-8923-47c21096d57c'),(7,7,2,'search','search',1,'2022-10-05 22:19:10','2022-10-05 22:19:10','73337070-0337-4474-a91d-1b0f84c23171'),(8,8,2,'search','search',1,'2022-10-05 22:19:10','2022-10-05 22:19:10','765aab4e-afc2-46dc-99e5-7044d06601b4'),(9,9,2,'search','search',1,'2022-10-05 22:19:11','2022-10-05 22:19:11','014a9a0b-c756-4b14-81d0-656fa39cb42d'),(10,10,2,'alert-message',NULL,1,'2022-10-05 22:19:41','2022-10-05 22:19:41','6c346444-061b-4838-960e-460578cdb773'),(11,11,2,'alert-message',NULL,1,'2022-10-05 22:19:42','2022-10-05 22:19:42','8f31e523-9ead-463a-a9ad-c1caaf3dd3f0'),(12,12,2,'error-404',NULL,1,'2022-10-05 22:19:42','2022-10-05 22:19:42','5b182bcf-8368-4282-abf8-ea5954eac833'),(13,13,2,'error-404',NULL,1,'2022-10-05 22:19:43','2022-10-05 22:19:43','2f58ea39-75ce-4bf7-b0dc-8e0769b11221'),(14,14,2,'search','search',1,'2022-10-05 22:19:44','2022-10-05 22:19:44','be67e853-b155-41cd-9150-ca4ab1713847'),(15,15,2,'search','search',1,'2022-10-05 22:19:44','2022-10-05 22:19:44','fbe5bf43-ea16-4913-a824-1e97fd2bdc6a'),(16,16,2,NULL,NULL,1,'2022-10-05 22:20:07','2022-10-05 22:20:07','63e503cf-8f9f-4342-8577-9dbfd3b39864'),(17,17,2,'__home__','__home__',1,'2022-10-05 22:22:41','2022-10-05 22:23:58','f6ae6be9-1356-48d1-b1b1-b0d9b537ef97'),(18,18,2,'home','home',1,'2022-10-05 22:22:58','2022-10-05 22:22:58','cc78d9e9-7cf3-4938-88a0-ac153212a7e4'),(20,20,2,'__home__','__home__',1,'2022-10-05 22:23:58','2022-10-05 22:23:58','32cd8bc1-2665-49a2-bfea-61246b25ddf4');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (1,2,NULL,2,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08'),(2,2,NULL,2,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08'),(3,2,NULL,2,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:09','2022-10-05 22:19:09'),(4,3,NULL,4,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:09','2022-10-05 22:19:09'),(5,3,NULL,4,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:10','2022-10-05 22:19:10'),(6,3,NULL,4,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:10','2022-10-05 22:19:10'),(7,4,NULL,6,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:10','2022-10-05 22:19:10'),(8,4,NULL,6,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:10','2022-10-05 22:19:10'),(9,4,NULL,6,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:11','2022-10-05 22:19:11'),(10,2,NULL,2,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:41','2022-10-05 22:19:41'),(11,2,NULL,2,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:42','2022-10-05 22:19:42'),(12,3,NULL,4,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:42','2022-10-05 22:19:42'),(13,3,NULL,4,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:43','2022-10-05 22:19:43'),(14,4,NULL,6,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:44','2022-10-05 22:19:44'),(15,4,NULL,6,NULL,'2022-10-05 22:19:00',NULL,NULL,'2022-10-05 22:19:44','2022-10-05 22:19:44'),(17,8,NULL,1,16,'2022-10-05 22:22:00',NULL,NULL,'2022-10-05 22:22:41','2022-10-05 22:22:58'),(18,8,NULL,1,16,'2022-10-05 22:22:00',NULL,NULL,'2022-10-05 22:22:58','2022-10-05 22:22:58'),(20,8,NULL,1,16,'2022-10-05 22:22:00',NULL,NULL,'2022-10-05 22:23:58','2022-10-05 22:23:58');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,8,16,'Basic','basic',1,'site',NULL,NULL,1,'2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'e0521335-ccc2-4893-a505-4baacf112dee'),(2,2,17,'Alert Message','alertMessage',0,'site',NULL,'{section.name|raw}',1,'2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'fb1d50db-864b-4553-9fb0-d1d784dd98d9'),(3,7,18,'Content Fragment','default',1,'site',NULL,NULL,1,'2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,'174cd975-f457-4998-8bcc-3d25963f9c3b'),(4,3,19,'Error 404','error404',1,'site',NULL,NULL,1,'2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,'ecafdb45-55b7-4568-b087-9c19bc75197a'),(5,6,20,'Basic','basic',1,'site',NULL,NULL,1,'2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,'2c133977-4e62-45df-af34-a21ab5afed67'),(6,4,21,'Search','search',0,'site',NULL,'{section.name|raw}',1,'2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,'7c143451-c641-4b9e-9b70-317f53656197'),(7,5,22,'Default','default',1,'site',NULL,NULL,1,'2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,'64029a67-3d0c-4cad-8fc6-dc0eec8c112c'),(8,1,23,'Default','default',1,'site',NULL,NULL,1,'2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,'d3282cfb-d044-4890-b553-9a0b87393027'),(9,8,24,'With Sidebar','withSidebar',1,'site',NULL,NULL,3,'2022-10-05 22:19:12','2022-10-05 22:19:12',NULL,'1da13089-e303-46d0-930f-aefd062df474'),(10,8,25,'Redirect','redirect',1,'site',NULL,NULL,5,'2022-10-05 22:19:12','2022-10-05 22:19:12',NULL,'986a0a6d-c09c-4a78-b259-2190a004b305');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Users','2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'8dfe3044-fa11-4189-8229-57e400ec874a'),(2,'Common','2022-10-05 22:18:54','2022-10-05 22:18:54',NULL,'e0dac603-c510-4bb5-8701-e25672d93744'),(3,'Content Builders','2022-10-05 22:18:54','2022-10-05 22:18:54',NULL,'ea1a69ed-b5c5-46cf-a629-4435f7f7cad0');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayoutfields` VALUES (142,26,68,3,0,0,'2022-10-05 22:19:12','2022-10-05 22:19:12','adee8b13-e300-4b0b-8994-6b9b66646875'),(147,4,82,13,0,1,'2022-10-05 22:19:16','2022-10-05 22:19:16','64a66e3a-4815-492f-aca6-cfe595cf75d9'),(148,4,82,4,0,2,'2022-10-05 22:19:16','2022-10-05 22:19:16','137ce5ba-6ea3-4ee0-a5c2-6edc127507e1'),(149,4,82,8,0,3,'2022-10-05 22:19:16','2022-10-05 22:19:16','29291bb3-f485-4aaf-a43f-123a7958862c'),(150,4,82,2,0,4,'2022-10-05 22:19:16','2022-10-05 22:19:16','58fcbd10-2912-4006-891c-c970586fb13b'),(158,7,88,17,0,0,'2022-10-05 22:19:18','2022-10-05 22:19:18','6e0e3193-b73c-4b6b-b836-1d74c943d7f8'),(159,7,88,15,0,1,'2022-10-05 22:19:18','2022-10-05 22:19:18','63c226b6-a01e-404d-8fdb-83f84c6dd06d'),(160,7,88,20,0,2,'2022-10-05 22:19:18','2022-10-05 22:19:18','d41731a3-413e-4aa4-b092-f84607a91689'),(161,7,88,16,0,3,'2022-10-05 22:19:18','2022-10-05 22:19:18','9e451dca-3f5a-4476-abf1-348402f06795'),(162,7,88,18,0,4,'2022-10-05 22:19:18','2022-10-05 22:19:18','e6527c26-452c-43a3-8198-79945b395bd3'),(163,7,88,21,0,5,'2022-10-05 22:19:18','2022-10-05 22:19:18','83c93450-0e1a-414b-9990-b5136ee4974c'),(164,7,88,19,0,6,'2022-10-05 22:19:18','2022-10-05 22:19:18','75f15988-75d9-4573-80af-9562b7d50cc6'),(207,8,94,23,0,0,'2022-10-05 22:19:23','2022-10-05 22:19:23','85860b5e-8e6e-489a-83b9-32a142d15a6e'),(208,8,94,27,0,1,'2022-10-05 22:19:23','2022-10-05 22:19:23','b20cc77e-74d4-4079-b284-1b53f89794d5'),(209,8,94,26,0,2,'2022-10-05 22:19:23','2022-10-05 22:19:23','daf18795-de5c-4ff8-96d0-29126484f0c5'),(210,8,94,22,0,3,'2022-10-05 22:19:23','2022-10-05 22:19:23','c7b361f3-f87d-44e2-b1fb-d74d5c10be4e'),(211,8,94,25,0,4,'2022-10-05 22:19:23','2022-10-05 22:19:23','e58bc832-56f9-47c1-8704-a4a00990806c'),(212,8,94,24,0,5,'2022-10-05 22:19:23','2022-10-05 22:19:23','5d9c26ce-9177-4d3e-a177-adbf55adc2f4'),(218,9,96,30,1,0,'2022-10-05 22:19:24','2022-10-05 22:19:24','d550fd42-753c-4815-ac69-d33adfb3a537'),(219,9,96,28,0,1,'2022-10-05 22:19:24','2022-10-05 22:19:24','682980c8-0a2a-420c-a623-d7e25060a846'),(220,9,96,31,0,2,'2022-10-05 22:19:24','2022-10-05 22:19:24','79d0313c-4181-490f-8ef8-b442a8ffcef4'),(221,9,96,32,0,3,'2022-10-05 22:19:24','2022-10-05 22:19:24','fcdc2f97-4153-4445-90a0-37ae7d834bc2'),(222,9,96,29,0,4,'2022-10-05 22:19:24','2022-10-05 22:19:24','116c1f8b-4141-4d3f-b89f-6586a05fa07d'),(224,10,98,33,0,0,'2022-10-05 22:19:25','2022-10-05 22:19:25','5cfa12df-f505-4915-be1b-c3a68dfa8e28'),(274,11,106,36,0,0,'2022-10-05 22:19:33','2022-10-05 22:19:33','da457e3b-7b34-4941-abdf-cb467c003225'),(275,11,106,34,0,1,'2022-10-05 22:19:33','2022-10-05 22:19:33','c67141d4-fb54-4eeb-a6be-1e90539eb7c9'),(276,11,106,35,0,2,'2022-10-05 22:19:33','2022-10-05 22:19:33','e8905c4a-0056-4868-922a-78573df29d5b'),(291,12,110,38,1,0,'2022-10-05 22:19:35','2022-10-05 22:19:35','adfe9b1c-fbc7-4a5d-935d-eebed16249fb'),(292,12,110,37,0,1,'2022-10-05 22:19:35','2022-10-05 22:19:35','56dd95b5-f1f6-4d1a-982b-779bd9677ba0'),(299,13,112,42,1,0,'2022-10-05 22:19:36','2022-10-05 22:19:36','d41292b0-10b2-4037-a727-1b8e0ab83c2a'),(300,13,112,39,0,1,'2022-10-05 22:19:36','2022-10-05 22:19:36','a973d027-9775-4089-9cd9-e60a3bf9f7f6'),(301,13,112,43,0,2,'2022-10-05 22:19:36','2022-10-05 22:19:36','b7b541ff-0c83-4407-94c5-1aefde1d299c'),(302,13,112,41,0,3,'2022-10-05 22:19:36','2022-10-05 22:19:36','a91897bc-fd84-4930-8fc4-6d169173967f'),(303,13,112,40,0,4,'2022-10-05 22:19:36','2022-10-05 22:19:36','9f577e56-e1ae-48d4-b6dd-f27c4a639a4c'),(304,13,112,44,0,5,'2022-10-05 22:19:36','2022-10-05 22:19:36','ddf9fd7a-d2c4-4f87-82ea-4eac9718cb45'),(318,14,116,45,0,0,'2022-10-05 22:19:38','2022-10-05 22:19:38','d54082ec-c2bf-4862-ba51-f348a2dfc450'),(322,15,118,48,1,0,'2022-10-05 22:19:39','2022-10-05 22:19:39','84321526-d343-4562-a236-8d8be866ebff'),(323,15,118,47,0,1,'2022-10-05 22:19:39','2022-10-05 22:19:39','83b22d18-56d0-4457-beb7-ac8df128eeda'),(324,15,118,46,1,2,'2022-10-05 22:19:39','2022-10-05 22:19:39','713b72c3-2a52-4121-940d-b6b85643e75d'),(344,16,123,8,0,2,'2022-10-05 22:19:41','2022-10-05 22:19:41','c944ecbc-5b60-4448-a194-8745bcccd8e5'),(345,16,123,2,0,4,'2022-10-05 22:19:41','2022-10-05 22:19:41','dc5b3f33-f7c0-4ea2-9dce-1c7827c67448'),(346,16,124,4,0,0,'2022-10-05 22:19:41','2022-10-05 22:19:41','28b30f59-5a9c-4220-aa54-89b3b9f3ff86'),(347,16,124,6,0,1,'2022-10-05 22:19:41','2022-10-05 22:19:41','b670d00b-1a4d-4b47-9b75-21ab1f84da32'),(348,16,124,5,0,2,'2022-10-05 22:19:41','2022-10-05 22:19:41','161e9fd3-555e-4ca9-870e-6b37c6f1a3d3'),(352,17,126,7,0,1,'2022-10-05 22:19:42','2022-10-05 22:19:42','c4b878c9-7d4d-49a4-a8bb-a9a9608959a3'),(353,17,126,6,0,3,'2022-10-05 22:19:42','2022-10-05 22:19:42','2f475dc4-6829-448b-abde-e1e344083107'),(354,17,126,1,0,4,'2022-10-05 22:19:42','2022-10-05 22:19:42','4a4608bf-a1dc-4a35-bd80-fe10ccea0e63'),(356,18,128,2,0,1,'2022-10-05 22:19:42','2022-10-05 22:19:42','94b11c0b-8126-4584-ab12-b7f7c91d28da'),(359,19,130,8,0,1,'2022-10-05 22:19:43','2022-10-05 22:19:43','f6ce7a18-e5a6-4094-9d18-f0b657c26cff'),(360,19,130,12,0,2,'2022-10-05 22:19:43','2022-10-05 22:19:43','f82f5932-0b2e-4451-8580-fe593b6a88c5'),(363,20,132,8,0,1,'2022-10-05 22:19:43','2022-10-05 22:19:43','5c1b2358-9a2c-41c7-9cdf-7d07ef8f5b88'),(364,20,132,2,0,2,'2022-10-05 22:19:43','2022-10-05 22:19:43','29817ec8-f3f0-4dcf-bfd5-0d055352965a'),(367,21,134,8,0,1,'2022-10-05 22:19:44','2022-10-05 22:19:44','a6684d97-84d7-4304-86b9-ef2afd1d539f'),(368,21,134,12,0,2,'2022-10-05 22:19:44','2022-10-05 22:19:44','867d0403-88b1-4082-8515-fbdb77cbfd4a'),(373,22,137,4,0,1,'2022-10-05 22:19:44','2022-10-05 22:19:44','b6ba3553-a818-46c3-9b10-b77623cf5d04'),(374,22,137,12,0,2,'2022-10-05 22:19:44','2022-10-05 22:19:44','9b407955-85a6-41e4-b194-349fea3ab33e'),(375,22,138,11,0,0,'2022-10-05 22:19:44','2022-10-05 22:19:44','28d92f49-b1c3-44d2-bd19-51c41e59a19a'),(376,22,138,5,0,1,'2022-10-05 22:19:44','2022-10-05 22:19:44','4fcbf3fd-937e-4b4d-8717-9f0b5a21ce01'),(383,23,141,4,0,1,'2022-10-05 22:19:45','2022-10-05 22:19:45','f29f102c-469a-45b4-ba48-46817ceef407'),(384,23,141,6,1,2,'2022-10-05 22:19:45','2022-10-05 22:19:45','0a7c79b6-34b0-4dc3-aa76-d74931f9044c'),(385,23,141,8,0,5,'2022-10-05 22:19:45','2022-10-05 22:19:45','f6de9213-4c22-42fc-803c-408200ece407'),(386,23,141,2,0,7,'2022-10-05 22:19:45','2022-10-05 22:19:45','05afa117-b683-47f4-b905-a8e1e2570237'),(387,23,142,11,0,0,'2022-10-05 22:19:45','2022-10-05 22:19:45','87037654-07fe-4d3c-b08e-acf5833eae66'),(388,23,142,5,0,1,'2022-10-05 22:19:45','2022-10-05 22:19:45','ed67179c-fe27-4d0e-b4a8-ad64446f5abc'),(395,24,146,8,0,2,'2022-10-05 22:19:45','2022-10-05 22:19:45','886a0fc2-5d3b-4579-b97f-15a0203098a5'),(396,24,146,2,0,4,'2022-10-05 22:19:45','2022-10-05 22:19:45','e47c2681-ffa2-473d-a140-6000a985e30a'),(397,24,147,14,0,1,'2022-10-05 22:19:45','2022-10-05 22:19:45','8d4b875b-a46b-41ab-adae-126403a3f1b5'),(398,24,148,4,0,0,'2022-10-05 22:19:45','2022-10-05 22:19:45','88baffae-b6aa-4406-bff7-37c85f171501'),(399,24,148,6,0,1,'2022-10-05 22:19:45','2022-10-05 22:19:45','3bb69e4d-081b-4ff8-9e5f-f78f6a9134ec'),(400,24,148,5,0,2,'2022-10-05 22:19:45','2022-10-05 22:19:45','9ccae50f-80a8-4aa9-be95-01fc7accb54b'),(402,25,150,10,0,1,'2022-10-05 22:19:46','2022-10-05 22:19:46','b6a0650c-c9b9-4289-a5a5-6272e96e8b71'),(410,31,152,89,0,0,'2022-10-05 22:19:49','2022-10-05 22:19:49','bf51e1d9-ab89-4ea6-86e4-3dd374dfb1eb'),(411,31,152,85,0,1,'2022-10-05 22:19:49','2022-10-05 22:19:49','d3a1d805-f512-42f3-82c8-c9f66cf11190'),(412,31,152,86,0,2,'2022-10-05 22:19:49','2022-10-05 22:19:49','01574f7f-d903-4dd5-8068-47f0cd496a94'),(413,31,152,83,0,3,'2022-10-05 22:19:49','2022-10-05 22:19:49','acc832fa-8158-43ca-ac9d-bcadff7872d4'),(414,31,152,87,0,4,'2022-10-05 22:19:49','2022-10-05 22:19:49','6979dde5-1c7c-4410-92b7-294ca80d4cd6'),(415,31,152,84,0,5,'2022-10-05 22:19:49','2022-10-05 22:19:49','7381cf4e-7f2c-4c9a-9553-38a160606bf8'),(416,31,152,88,0,6,'2022-10-05 22:19:49','2022-10-05 22:19:49','ad91bdd4-3760-4af8-8e13-3ccaa964d42e'),(426,27,154,53,0,0,'2022-10-05 22:19:51','2022-10-05 22:19:51','acde2afc-b232-4afe-964a-5b164ce8e325'),(427,27,154,50,0,1,'2022-10-05 22:19:51','2022-10-05 22:19:51','7d1bb0e6-33de-4bef-9074-99c1baa06297'),(428,27,154,51,1,2,'2022-10-05 22:19:51','2022-10-05 22:19:51','4de7e03f-3ee3-4c44-b9c3-5d1bb0bf0a40'),(429,27,154,56,1,3,'2022-10-05 22:19:51','2022-10-05 22:19:51','d36a37f0-5e81-438a-81b8-1ed6c43417e2'),(430,27,154,55,1,4,'2022-10-05 22:19:52','2022-10-05 22:19:52','c3d81872-1021-4009-9a66-68183cd6d515'),(431,27,154,57,0,5,'2022-10-05 22:19:52','2022-10-05 22:19:52','b3a39543-3259-4415-abdb-a0200ca26deb'),(432,27,154,54,0,6,'2022-10-05 22:19:52','2022-10-05 22:19:52','715d50b0-e4f4-4f92-89bf-48d31594cce8'),(433,27,154,49,0,7,'2022-10-05 22:19:52','2022-10-05 22:19:52','dbfc59dc-5efa-48b8-9a80-b06fd7dddb6a'),(434,27,154,52,0,8,'2022-10-05 22:19:52','2022-10-05 22:19:52','7e51db81-e7d4-44a5-9a82-5be2a53a9e8f'),(444,28,156,63,0,0,'2022-10-05 22:19:54','2022-10-05 22:19:54','741682a9-0209-48f7-a7af-34581d3f5487'),(445,28,156,59,0,1,'2022-10-05 22:19:54','2022-10-05 22:19:54','17406ba8-5b4b-41f4-85d6-b5d90c93f5d1'),(446,28,156,66,0,2,'2022-10-05 22:19:54','2022-10-05 22:19:54','0537ef2c-f977-4468-9cb0-2a0010795b8c'),(447,28,156,60,1,3,'2022-10-05 22:19:54','2022-10-05 22:19:54','96afaab2-7b67-40cb-9526-194f9e829287'),(448,28,156,58,1,4,'2022-10-05 22:19:54','2022-10-05 22:19:54','40dd211d-af89-4c4b-be3f-1519a3119a13'),(449,28,156,62,0,5,'2022-10-05 22:19:54','2022-10-05 22:19:54','91bf6cee-65e0-4156-8210-fa2d9603dccc'),(450,28,156,64,0,6,'2022-10-05 22:19:54','2022-10-05 22:19:54','5ad021d7-d545-4605-ab30-f9743b04bb02'),(451,28,156,65,0,7,'2022-10-05 22:19:54','2022-10-05 22:19:54','dfa055d4-a8d8-4f3a-b40f-a8b95c1d5dae'),(452,28,156,61,0,8,'2022-10-05 22:19:54','2022-10-05 22:19:54','ac7dff62-b046-444f-b013-c49ee2f33cd0'),(460,29,158,70,0,0,'2022-10-05 22:19:56','2022-10-05 22:19:56','9cf50ac5-c05f-4fa6-b5df-27a9080eb662'),(461,29,158,68,0,1,'2022-10-05 22:19:56','2022-10-05 22:19:56','d81ce816-56f1-480e-80ed-38d3f7faeaec'),(462,29,158,72,0,2,'2022-10-05 22:19:56','2022-10-05 22:19:56','8809f67a-a8d7-47a7-985f-4e35f65c6722'),(463,29,158,73,0,3,'2022-10-05 22:19:56','2022-10-05 22:19:56','a7c2a9bd-049e-4a84-8a85-3f6a24f621ee'),(464,29,158,67,0,4,'2022-10-05 22:19:56','2022-10-05 22:19:56','bcdefa04-452e-43a8-b89b-e5a97edc9fda'),(465,29,158,69,0,5,'2022-10-05 22:19:56','2022-10-05 22:19:56','06a65a9f-b0b9-455c-b201-bc06d791ca5b'),(466,29,158,71,0,6,'2022-10-05 22:19:56','2022-10-05 22:19:56','16918876-0110-4606-bc20-71cee58cbd20'),(476,30,160,74,0,0,'2022-10-05 22:19:58','2022-10-05 22:19:58','9600aa49-becc-4941-b68c-3ba88a5b479e'),(477,30,160,75,0,1,'2022-10-05 22:19:58','2022-10-05 22:19:58','f102f9f2-ce98-4f31-aa86-966234b5075c'),(478,30,160,79,0,2,'2022-10-05 22:19:58','2022-10-05 22:19:58','ef838686-9aa5-4e58-888f-4bfaf2b10ada'),(479,30,160,80,1,3,'2022-10-05 22:19:58','2022-10-05 22:19:58','71c42fb2-e79d-4db2-8bb2-fdeec839f00b'),(480,30,160,81,1,4,'2022-10-05 22:19:58','2022-10-05 22:19:58','797b5670-a59e-41b1-984f-564003b3e77f'),(481,30,160,82,0,5,'2022-10-05 22:19:58','2022-10-05 22:19:58','4fad15b0-2765-4be8-9b8a-ebb32dd2c8e3'),(482,30,160,77,0,6,'2022-10-05 22:19:58','2022-10-05 22:19:58','a2076f6d-8333-4660-aeef-d6aa3aabbd87'),(483,30,160,78,0,7,'2022-10-05 22:19:58','2022-10-05 22:19:58','a3cf0016-4018-4010-8221-2330127e30e2'),(484,30,160,76,0,8,'2022-10-05 22:19:58','2022-10-05 22:19:58','37d27b1b-9bdf-4bf3-9907-8c5e62b5d139'),(491,32,162,92,0,0,'2022-10-05 22:20:00','2022-10-05 22:20:00','c276691b-db19-468d-af6b-730861db4875'),(492,32,162,94,0,1,'2022-10-05 22:20:00','2022-10-05 22:20:00','81467176-a102-4703-b8bc-2076786b313b'),(493,32,162,90,0,2,'2022-10-05 22:20:00','2022-10-05 22:20:00','fb15bd84-c8da-4802-9994-85fee3ad59e0'),(494,32,162,91,0,3,'2022-10-05 22:20:00','2022-10-05 22:20:00','48b05ade-3170-4807-9a2b-0dd1c30e729e'),(495,32,162,93,0,4,'2022-10-05 22:20:00','2022-10-05 22:20:00','45977706-5a80-4d3f-8b71-bb44148756fb'),(496,32,162,95,0,5,'2022-10-05 22:20:00','2022-10-05 22:20:00','93f0ab47-c8cd-4f28-947d-3d3d94387d1d'),(503,33,164,96,1,0,'2022-10-05 22:20:01','2022-10-05 22:20:01','ab28ee6e-b576-4ef5-a43c-c4db7b57272a'),(504,33,164,97,0,1,'2022-10-05 22:20:01','2022-10-05 22:20:01','a8bb4a5d-8a9a-4769-809f-837dfc5cf52f'),(505,33,164,99,0,2,'2022-10-05 22:20:01','2022-10-05 22:20:01','4b2427e1-4a3c-4782-bc34-87dbdba43392'),(506,33,164,101,0,3,'2022-10-05 22:20:01','2022-10-05 22:20:01','74ddba6e-d17e-41ca-9916-877e7a657d0a'),(507,33,164,98,0,4,'2022-10-05 22:20:01','2022-10-05 22:20:01','91d1f232-1008-4f6d-a9c1-3feb85058dcc'),(508,33,164,100,0,5,'2022-10-05 22:20:01','2022-10-05 22:20:01','8e30f6b4-cbc8-4ac4-bac3-753d2b29c813'),(516,34,166,107,0,0,'2022-10-05 22:20:03','2022-10-05 22:20:03','f6cd5d6b-e936-4493-af3e-d83597b46a48'),(517,34,166,106,0,1,'2022-10-05 22:20:03','2022-10-05 22:20:03','a5900581-70f3-4445-89bc-e6b62ad7bc42'),(518,34,166,103,0,2,'2022-10-05 22:20:03','2022-10-05 22:20:03','308aa7ae-9e90-4b2f-bba2-7d8a21259c4b'),(519,34,166,102,0,3,'2022-10-05 22:20:03','2022-10-05 22:20:03','70e1e685-e40c-4de7-931d-52be894cbc16'),(520,34,166,105,0,4,'2022-10-05 22:20:04','2022-10-05 22:20:04','bda901f6-5536-44ad-a585-d030dec1a587'),(521,34,166,104,0,5,'2022-10-05 22:20:04','2022-10-05 22:20:04','3bc7c0a6-0bd0-4bb8-a955-e0ae6ca8fe3a'),(522,34,166,108,0,6,'2022-10-05 22:20:04','2022-10-05 22:20:04','faa3572e-16d8-487d-85cd-750f92b775e9'),(544,35,174,109,0,0,'2022-10-05 22:20:07','2022-10-05 22:20:07','833ef8b6-04cf-4322-a635-a0ab67070ad2'),(545,35,174,110,0,1,'2022-10-05 22:20:07','2022-10-05 22:20:07','830517c0-c22e-44f9-8c01-0974b13e752b'),(546,35,174,111,0,2,'2022-10-05 22:20:07','2022-10-05 22:20:07','93fb68c6-f84e-4524-b662-10cc0c6283a4');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'verbb\\navigation\\elements\\Node','2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'1b65b6d9-e336-4a82-9d66-028627711de3'),(2,'verbb\\navigation\\elements\\Node','2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'0f011426-dd35-4fed-8537-da22c7740bce'),(3,'verbb\\navigation\\elements\\Node','2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'5a222860-a794-4ec1-8f37-9f94f6dff7de'),(4,'craft\\elements\\Tag','2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'d86979c9-3a6d-4414-94e5-740a83004249'),(5,'craft\\elements\\Asset','2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'155d9590-a8a9-44a0-b379-c089f17b9c37'),(6,'craft\\elements\\Asset','2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'453ddd73-5986-4ead-a737-8a2775163520'),(7,'craft\\elements\\MatrixBlock','2022-10-05 22:18:59','2022-10-05 22:18:59',NULL,'a067cac1-ec42-43cc-b56a-f98e3b5b7803'),(8,'craft\\elements\\MatrixBlock','2022-10-05 22:19:01','2022-10-05 22:19:01',NULL,'030b6d0b-c5dc-459c-b3e0-6e508313ca31'),(9,'craft\\elements\\MatrixBlock','2022-10-05 22:19:02','2022-10-05 22:19:02',NULL,'71a6d7a6-25ac-452b-be15-ac1e85ee1f0c'),(10,'craft\\elements\\MatrixBlock','2022-10-05 22:19:03','2022-10-05 22:19:03',NULL,'6dad8a0b-5ca1-4007-a9e7-52e3a6af16d2'),(11,'craft\\elements\\MatrixBlock','2022-10-05 22:19:03','2022-10-05 22:19:03',NULL,'564ddb22-070a-4f59-9191-678a9a6aa04c'),(12,'craft\\elements\\MatrixBlock','2022-10-05 22:19:04','2022-10-05 22:19:04',NULL,'cf0f3bed-f2ac-4664-920e-bb3e9f6739fa'),(13,'craft\\elements\\MatrixBlock','2022-10-05 22:19:05','2022-10-05 22:19:05',NULL,'95d89b00-d16f-4739-a893-bc7118fdb3e9'),(14,'craft\\elements\\MatrixBlock','2022-10-05 22:19:06','2022-10-05 22:19:06',NULL,'f4131d69-6976-4341-a01d-54d1b40e0c06'),(15,'craft\\elements\\MatrixBlock','2022-10-05 22:19:07','2022-10-05 22:19:07',NULL,'a08af1ae-a627-450a-8b50-2e6d5b29b245'),(16,'craft\\elements\\Entry','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'0e6296a2-ebef-4158-ba3d-e196af38899e'),(17,'craft\\elements\\Entry','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'44a33a2f-7625-459e-aed6-bd555138cbec'),(18,'craft\\elements\\Entry','2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,'240ed303-f7fd-4dc9-bffa-07b489cb529e'),(19,'craft\\elements\\Entry','2022-10-05 22:19:09','2022-10-05 22:19:09',NULL,'3047450d-a8c1-4a0f-abac-55c4c060904f'),(20,'craft\\elements\\Entry','2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,'4eb05feb-a6cd-4c12-81bc-f604d8ae3919'),(21,'craft\\elements\\Entry','2022-10-05 22:19:10','2022-10-05 22:19:10',NULL,'c07a4b2a-7329-47f6-99b5-a3b36287892e'),(22,'craft\\elements\\Entry','2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,'40286c86-e98b-4ded-a26d-b9e7c32862f0'),(23,'craft\\elements\\Entry','2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,'428ba83c-5ca7-4751-9529-c3d5c77739fc'),(24,'craft\\elements\\Entry','2022-10-05 22:19:11','2022-10-05 22:19:11',NULL,'1a82b273-bb1c-458c-b9a5-2722aa9e1020'),(25,'craft\\elements\\Entry','2022-10-05 22:19:12','2022-10-05 22:19:12',NULL,'3f206f90-5a6c-4c30-a73d-4ed5e65796db'),(26,'craft\\elements\\User','2022-10-05 22:19:12','2022-10-05 22:19:12',NULL,'ca66fe73-6c5b-416c-9ddf-3b94de104a52'),(27,'craft\\elements\\MatrixBlock','2022-10-05 22:19:19','2022-10-05 22:19:19',NULL,'1d75efde-1bad-4bf8-8155-0ddd2612c9e5'),(28,'craft\\elements\\MatrixBlock','2022-10-05 22:19:21','2022-10-05 22:19:21',NULL,'315c14e5-c16f-44d7-b169-8e74920df021'),(29,'craft\\elements\\MatrixBlock','2022-10-05 22:19:26','2022-10-05 22:19:26',NULL,'740cffdc-873e-42da-ab3b-9f6a01003077'),(30,'craft\\elements\\MatrixBlock','2022-10-05 22:19:28','2022-10-05 22:19:28',NULL,'5c81451a-e63d-4966-9100-ae781bf92ed9'),(31,'craft\\elements\\MatrixBlock','2022-10-05 22:19:31','2022-10-05 22:19:31',NULL,'a1f0f4d1-9056-4f56-b262-8722794749a3'),(32,'craft\\elements\\MatrixBlock','2022-10-05 22:19:33','2022-10-05 22:19:33',NULL,'4b0e5059-247d-4ef8-a8a6-3d1c7461be34'),(33,'craft\\elements\\MatrixBlock','2022-10-05 22:19:37','2022-10-05 22:19:37',NULL,'8729952a-d918-4fb7-bf8e-fad40d92d3f5'),(34,'craft\\elements\\MatrixBlock','2022-10-05 22:19:40','2022-10-05 22:19:40',NULL,'ddb9be0d-9c71-4e4a-82c1-e7bae599e577'),(35,'verbb\\supertable\\elements\\SuperTableBlockElement','2022-10-05 22:20:04','2022-10-05 22:20:04',NULL,'79dd7d9f-7ef5-438e-9e9f-d231cc488aca');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouttabs` VALUES (68,26,'Content Admin','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"453bde0e-a795-4633-8040-222e1c3b8f8e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b181050f-eab8-45f0-906a-c8241c2d3cf2\"}]',1,'2022-10-05 22:19:12','2022-10-05 22:19:12','89de91e6-9ff7-4611-aad2-6091680ede55'),(72,1,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"66bdaf44-647f-4a16-9a48-8728e53668f5\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"uid\":\"cf10bde2-037a-4050-9296-d13a1f59331f\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-10-05 22:19:15','2022-10-05 22:19:15','d36aafbb-41e1-4cc0-82e1-0bdd5fe8e389'),(76,2,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"320e7aae-ec30-4a96-8377-1a805fb9eeb4\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"uid\":\"8b5c0542-d26e-4860-b3d0-612be166767c\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','490f1cc3-c84f-4152-8ce3-837a0bf953bc'),(80,3,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"7b1ad96e-a48e-4f0a-8dc9-1e13bcb4f3d8\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"verbb\\\\navigation\\\\fieldlayoutelements\\\\NodeTypeElements\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"uid\":\"27befde0-c1d2-4676-932c-18679a91cf44\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','c1dae2bc-759c-4d6e-9e6b-86a4f54421a4'),(82,4,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\TitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"a625b38c-0014-407b-906a-fbaf8f242b3a\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"73fb60c9-cf55-4350-aa14-a2fcc8428a5d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e47b95bf-7a74-49e3-afa3-a938bd733ef7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"1eef252a-37e3-4fd5-b568-1dde952f360f\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"a5b64bea-a1c5-4e7a-9441-a431a6f45999\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"6c620460-c590-4098-b23a-de518414d7c1\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','06209fac-a320-462f-a584-bb31888d7fc3'),(84,5,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\assets\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"c38c79bd-37a2-436d-b5b2-425ffbcff512\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','259afe9f-bdf2-48fc-bb4b-23537e764dfa'),(86,6,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\assets\\\\AssetTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"52e15e4f-4d53-4b8d-8106-654d6e621e0c\",\"userCondition\":null,\"elementCondition\":null}]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','eeefc0c2-8e1c-4607-94af-2574c13d09fe'),(88,7,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"9ebdf9f9-f485-4eaa-8d3f-3dfbcb3e859a\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"30b5253e-1f74-41f3-b484-e6c82e3210d5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"25e6f7b0-ef21-41a3-bde5-2f2646a2779e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1d242d6f-f863-4979-b2af-bb1da5c2aee2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"482f9cf0-2950-4e81-a1ee-4dcd8c1a4597\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dda1fa64-dd45-42b6-8df9-476cbac15152\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"05a0cf91-efa2-4744-8d50-f71766696876\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"b614bdcb-6def-4673-9490-60b1fd22d225\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"54aa6fb8-4a59-4704-9956-2c47eb2f5ceb\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"adf55cbb-40d8-4b6c-9618-e0f89cde467c\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e826463c-c088-426d-be5d-9630e1b872c9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"db705720-4f45-4505-8b23-dd8e4c9fd2b0\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b8f98eab-bd44-4073-b73b-c5c394a00643\"}]',1,'2022-10-05 22:19:18','2022-10-05 22:19:18','cac765d1-21c1-46d6-addb-0dfd3c50eb9e'),(94,8,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"d1935261-af10-4a93-9d6e-ac4e9cd50639\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"07a0012a-4bdf-4aaa-8415-bbe06adaf62c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"e3ab6a2c-4965-47f8-890c-f5e000459e4e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e2e0830e-80f8-4dfd-8edf-45b6f917cd2d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"563eb588-0587-49d9-b9fe-6772469f8f2b\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"bb08d0c0-bcc3-4d96-b172-572ca8f601a1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"58085824-b0ac-4ccb-be35-e8f3181916d5\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0dabdba1-b0ed-4220-8bfd-115e5127ee42\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"8819b91b-089d-4d95-b23f-752efb7df8bb\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a7b99dca-7b58-438c-b57e-9d7965c3093b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"1ab4375b-4552-4f3d-be6c-051e5f50b17d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9d4f8876-987f-46fc-9042-aaf824a7131d\"}]',1,'2022-10-05 22:19:23','2022-10-05 22:19:23','17da5594-72ac-4f5d-9596-133476199500'),(96,9,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"e9097578-15ac-44ef-87fd-cc84292d97e2\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d08c5ca6-5020-4ac5-9460-c831d0921585\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"0312ee83-431f-46df-8213-cda6f2af4ed2\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6bd61b45-415d-4702-8b93-c734e25ed41e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"56ae1f90-e19f-455d-94de-686fa6a0689c\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e6d20858-c077-4e76-b107-03166b8ba61d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"78543238-2420-49c8-b9c8-9c94fb98ce92\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ea2610d5-eecb-4d99-916e-90ce7e2c2bbc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"bcd0b055-368d-4601-a190-ccedeb506394\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"34c8b184-a3df-4101-9525-d2c4a65aa9cb\"}]',1,'2022-10-05 22:19:24','2022-10-05 22:19:24','7d750c4a-98f2-471f-b70b-27b31afd4974'),(98,10,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"ab9bf92b-9057-4e4d-b4ad-8612f449095b\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"4ebdb729-ea5a-4ff4-b10f-e4b2d0da2292\"}]',1,'2022-10-05 22:19:25','2022-10-05 22:19:25','cace9df3-a737-44e2-8ad5-ad5495c87c33'),(106,11,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"cf64b0c8-2197-4b35-882d-1efa6ff77c73\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e2cdac24-87bd-4a5b-be66-d991b0323794\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"41cfa4e2-45bf-495a-8ef7-5181c17669d7\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"abf72c9c-cdfc-4765-b71d-a03735da679d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"32fc547d-c5c4-4205-a400-fed243e51d88\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"bf152e62-fb69-4e45-836d-7546488987e6\"}]',1,'2022-10-05 22:19:33','2022-10-05 22:19:33','d9dcfac7-2f95-4e7f-8dff-5e8f93eb6332'),(110,12,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"cae29da4-e73f-4c1a-8e05-cf76067aa06a\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"625a205f-5664-4223-840b-ec4c4e73b1bb\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"672d88c1-77be-4fb2-95b2-c753d9101053\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9d81e4ce-5846-4157-aebc-c26abc01d16e\"}]',1,'2022-10-05 22:19:35','2022-10-05 22:19:35','995f18ea-0ffe-4619-b6fa-863df1deb71a'),(112,13,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"834dbe1f-7223-4c42-8f85-a2d0c90841c6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c1193bb1-b500-4050-8b68-a0a7bee4594f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"77234ae4-bd4c-458b-8160-c7ce2ce03346\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"468a14eb-fb24-4d42-85ea-51a108f68949\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"47b29ed0-d72a-4b71-8929-6df841e61907\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ec26ccd6-8b77-446f-83e4-5a157ab84ee5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"62df11bc-39f6-447f-9ece-b024dd93def8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"25414516-f079-42de-9891-f9dd403af271\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"79101fb3-3c5f-4d5f-b1c0-66f9f96c507d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5252a6fb-4088-4f59-980a-0d5f910ab392\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"da21838e-b116-4936-b3a5-42bdd92af0f3\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fb8236c7-dc6f-45c6-b62d-6d6ffaaf1657\"}]',1,'2022-10-05 22:19:36','2022-10-05 22:19:36','70caaf25-ddf7-4109-b3f1-81e24c4423f5'),(116,14,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"1a76002d-b814-4b0a-a9aa-61601ef9d468\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dc845fdf-e229-4765-9b4c-c77ca578bd52\"}]',1,'2022-10-05 22:19:38','2022-10-05 22:19:38','ba46e525-f3fd-43ed-88f1-891a4ff38dbb'),(118,15,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"d36170ef-8a2f-474d-9f6b-ae1c3340faff\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c25e161a-2f9c-406c-9ace-21fa7f000c4a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"ef40e410-c600-447a-bf04-d1281c8f19cd\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"29f0f7bf-a7d4-4015-9ea2-cfd8f1530b1b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"7d50ad6c-86dc-4ec5-a9d9-69f1c38b7489\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"2e0671a7-eba0-42c5-a5ab-2b30a6fc1bf6\"}]',1,'2022-10-05 22:19:39','2022-10-05 22:19:39','5f60d17b-cbec-4677-8f2e-9e7d7081c2fc'),(123,16,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":\"This is the main page title. It will appear on the page unless a hero block is added.\",\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"7f78bbcb-7f32-477a-ba16-b79baf60d778\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Hero Content\",\"uid\":\"3f7530e7-7389-41a8-b396-277ba5798321\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":\"Use the block below to customize the hero section for this page\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"618ae43d-0a54-4835-a637-3662dbf41d4d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Page Content\",\"uid\":\"2450bbcd-9d94-4929-b258-5357a7bada4f\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"Body Content Blocks\",\"instructions\":\"Use the blocks below to construct the body of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"7ac47f09-ee20-4f31-93a1-d14442cfdd2f\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:41','2022-10-05 22:19:41','818faf38-587a-432a-ae15-0223cdae2343'),(124,16,'SEO','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"fc50be8e-c504-4f3f-aa26-ba68f45b4f80\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"d7777e9e-253d-42bc-92ba-52af6fb6bf4d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"3a08d1a5-d7f0-4bc8-a76e-bf56684014b6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2022-10-05 22:19:41','2022-10-05 22:19:41','a533ce47-f77f-4d3b-add6-fa261e2823b1'),(126,17,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"77d04eff-cd3c-4a0c-ae93-84839425651c\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"77905452-fd8c-4240-bf16-405547d53ffd\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"69ac403d-1688-46dc-ab62-a46257cb4e1b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\HorizontalRule\",\"uid\":\"76b95bbb-28ab-4496-922b-3f28af9c2e67\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"Message\",\"instructions\":\"A short one sentence message (80 characters)\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"059fc1cc-7bc5-49db-b9ea-de548210dc96\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"58735c29-ebe5-47e8-9b0f-e9a5733458a5\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d339dd86-5cec-4889-b2d2-81f993979c61\"}]',1,'2022-10-05 22:19:42','2022-10-05 22:19:42','bb87b4cb-d2c3-4675-907e-f0d5a9bd8f90'),(128,18,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"8534454a-8dda-4499-8321-155586e2654c\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"4886831b-bb98-4016-8f27-ae84c1314744\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:42','2022-10-05 22:19:42','c51ca2c5-e211-4b0f-aedb-ec23acc395a9'),(130,19,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"a94d8351-801a-48e7-b4d4-63bd171c0305\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"093a37c4-c5a0-4faa-a2cf-0053ab10a554\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"efb821b0-0d1d-4e26-8104-69187c662545\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-10-05 22:19:43','2022-10-05 22:19:43','c4455f3e-a54b-45c1-b400-de704e346a49'),(132,20,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"2a865b39-062a-4e2f-8afa-b1b684e6b97b\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"1691971d-5ec2-4dfe-9569-6d08f2accace\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"f5e8c637-aee6-4b2b-b992-24d7578140ab\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:43','2022-10-05 22:19:43','18961cb4-a0bd-4fa2-a431-193ca4b99cc8'),(134,21,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"cb05178f-1b70-401c-b614-ebf53f33a2a1\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"1ef221ce-d267-4c49-8a9a-1cb45f8500d7\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"d64199e8-1588-4e7b-93a5-8bde2af6e3ba\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-10-05 22:19:44','2022-10-05 22:19:44','c9dfb4a7-fbc1-41cb-8e49-6ebde7c55e97'),(137,22,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"53cb8baa-f384-4ef0-b722-6e76955c4341\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"314a12d3-18cf-445e-b040-c503f62a36ed\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"abeaf090-977e-4282-b84c-2feef8674c73\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6a1ab78a-ce1d-4e06-944f-7fa172aaa06a\"}]',1,'2022-10-05 22:19:44','2022-10-05 22:19:44','3d99a854-f397-48f2-bb53-3be188f296d1'),(138,22,'SEO','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"7625b54c-ea41-4033-8f06-ce4e1c2225bd\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"103a727c-7397-4a17-91fe-fa2c4e2d7ff4\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2022-10-05 22:19:44','2022-10-05 22:19:44','8c962eba-4012-42b8-8b82-8a42123a74bb'),(141,23,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"dd4c06b0-4735-4900-b07d-48ba38231994\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"5bf51005-3bb9-412e-adf4-7f150865f2ef\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":50,\"uid\":\"a8eeeea5-3bf1-46eb-8f82-8abc84922946\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\HorizontalRule\",\"uid\":\"8b88d056-bc41-4d86-9d5f-898e1bfc4bc8\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Hero Content\",\"uid\":\"499c7d7c-e78f-4db1-907f-40830f2933ac\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":\"Use the block below to customize the hero section for this page\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"bb156ffb-d69e-44cc-ad8c-5217d827f31d\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Page Content\",\"uid\":\"03355186-b876-4871-b747-0a024a4ea616\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"Article Content Blocks\",\"instructions\":\"Use the blocks below to construct the body of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"7d767a26-af52-4bce-8587-abff92061600\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:45','2022-10-05 22:19:45','100480a7-38f5-4090-8ea7-6b1e1f466a64'),(142,23,'SEO','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"76184b30-8fd7-4592-9f15-c8ed69afc161\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"772247d2-d67e-40f2-a243-6e6eca55c5f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"__blank__\",\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"526646d2-5a6d-4ea5-bc58-be49bd705b8a\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',2,'2022-10-05 22:19:45','2022-10-05 22:19:45','85ed043d-21f9-434f-89bd-47ecd8b3630d'),(146,24,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"aff7c356-6d38-41f0-8ad6-1611b9d0470f\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Hero Content\",\"uid\":\"ec0a2b85-d5e9-4651-91bc-d4c499b6f4f5\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":\"Use the block below to customize the hero section for this page\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"45d1c2b8-3ae2-4ac7-b698-663d5e301564\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d05f4009-0b38-4065-a1b1-65221aa65e63\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Page Content\",\"uid\":\"758fff07-757a-4f14-8716-aab3810be64d\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":\"Body Content Blocks\",\"instructions\":\"Use the blocks below to construct the body of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"5f1c3647-1a55-497b-a7c2-33cbf90ecae4\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a4fe99b5-7832-4eb2-9833-f551177bb821\"}]',1,'2022-10-05 22:19:45','2022-10-05 22:19:45','7309709a-e27a-4226-a2c1-5685670c4c51'),(147,24,'Sidebar','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\Heading\",\"heading\":\"Sidebar Content\",\"uid\":\"9def0cc4-c28d-4b42-9039-959af7a8b101\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":\"Use the blocks below to construct the sidebar of your entry. Each block contains specific settings and content requirements.\",\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"f6cccab6-cc19-437f-84cc-fcbd912b8ae6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a35a0beb-0cf7-4a2b-9ec3-91e953a18116\"}]',2,'2022-10-05 22:19:45','2022-10-05 22:19:45','e6f941ab-670b-4aa1-83f6-1ebb29e90282'),(148,24,'SEO','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"645515ab-242d-4610-a4e6-2238a3f66628\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"adcea45e-bf40-4faf-b0c8-4ce089696971\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"d29e982c-a5a6-4cf0-979c-70c6ce0cf0fb\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b1c52a06-4990-43f5-90d3-898a48789556\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"be768740-44fb-422a-9841-f5f120ee410a\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d79b3073-00bf-430c-95d5-6d03d8303032\"}]',3,'2022-10-05 22:19:45','2022-10-05 22:19:45','25183390-3692-4379-9b10-d39ff01ebbbb'),(150,25,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\entries\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100,\"uid\":\"9ec137fd-9aca-4b45-bf1f-b627c9679d47\",\"userCondition\":null,\"elementCondition\":null},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"9cef4421-3b31-422a-ae46-d6e5363185f1\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"14d7d858-e4eb-4c44-90bc-a606a5a2372a\"}]',1,'2022-10-05 22:19:46','2022-10-05 22:19:46','c7a33653-3ea2-44ad-ab45-1b76935b4ac4'),(152,31,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"6017252d-7c65-4716-8587-0267805477aa\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c6677eab-6c78-4ca1-93cd-0faa266d1c45\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"4043fe8b-846c-4408-af28-90d689ede417\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5347a201-6da8-47ff-bc5b-20a0dc63d44e\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"95c71aec-6877-427f-86ed-e1ce45dc6760\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"7506709b-79c3-40ab-b4d3-5ce0fa5ba5bc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"deac4011-9701-4387-8e61-da8b1269fd8e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"05fb8aa2-0c98-4cee-93c3-5ad2f2709822\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"d6cead47-c085-40f3-975f-ce5f00b44f23\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a1a62d7a-5173-4caf-8d92-423b6dc0dede\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"a9125f69-85d0-464d-a645-9adf0935f0d9\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"7b72b671-dcdc-49b2-95cd-44a8e8be7cad\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"33aeadab-024e-46c6-9f23-3bdae21f68da\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ae3f34db-5fe5-4438-86f0-377cfaebf02a\"}]',1,'2022-10-05 22:19:49','2022-10-05 22:19:49','6272049f-8eaf-4847-a1fc-52a1f881a7a9'),(154,27,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"86557008-7633-4b84-9cd5-3694a9e2d137\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"61d7345d-34c5-4c93-8ae0-9f9b5f3b166b\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"2964c8db-044d-4d06-9671-ccf395e27b28\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"8eee0057-f0e3-4674-8fd8-6eae3cc9ae0d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"2d4a9273-97d7-4423-b3d0-5f07c1086c43\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9f0a0dc0-db3f-49d5-9656-b61ad0d5c452\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"c8b6bffb-e4e9-4e2b-8287-785abe1b2905\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b6015f85-adad-474b-afb4-ac34bb560c0c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"37f90003-f571-4b8f-9c7f-cba06d05bf96\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b161b327-4669-4d08-b51f-7b8c7091a2d4\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"ab165e2d-4fdd-4ae0-8ea3-faa14a3d4b70\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f981cb80-dd00-4b09-b682-78bfa0abccad\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"a80c2691-c238-4da8-a848-76f29a8b4e1e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a479dbe3-176d-4b5b-b5e6-f6f5dab262ec\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"313f2e13-8943-491b-b9c0-6e7eb7929248\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0d2936c9-42b4-467f-9004-678230db8291\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"f87ddca5-5d77-45b2-892a-e01cf43cc06f\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"39b3d1e6-0464-44f3-803e-8bf88da46270\"}]',1,'2022-10-05 22:19:51','2022-10-05 22:19:51','f55acb64-6c3a-483a-b5c1-2d0b59dd5d72'),(156,28,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"41be2032-3dea-4fe0-adb5-c0c7eaf8fcd1\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"26431232-d9c5-41cd-9cad-3647ec59afbd\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"7ce93d6f-29e0-4ac4-9ec6-fe068dfc2dff\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"055d3887-062f-4180-bac4-65a9670f0440\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"2148e91a-9dca-400f-a187-d950e8770650\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e8196605-52ba-47d2-ba43-8dc77de92903\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"4c24c8bd-8b10-47c4-b679-8b9ff820fca6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9844b6dc-6dbb-4203-9eec-5507fcee91f7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"13497fc7-23d7-4c7d-bea4-3e969338d002\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"09e29257-428d-40f2-81a3-c594a739de68\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"e9fd208b-643b-4416-9cf4-2503b4565435\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9305104a-d7ea-4f07-b6a5-4f02e3232cbd\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"da780989-1020-4dc5-af0a-bde0cb88b420\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"d29c3934-5af7-4d49-9515-9dea41e6d3c2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"860dee8f-67ee-403c-b90c-9c8a01147044\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"dd06e3eb-fff5-4c16-b219-b53867573f86\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"2b199b5e-c75a-4a5a-ab8a-670cb0e73e95\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"43048f2c-3b11-44e7-8c32-29d991c819cc\"}]',1,'2022-10-05 22:19:54','2022-10-05 22:19:54','b835d646-e8f5-48a6-9bed-53d86f303a3f'),(158,29,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"8681f02a-2210-4f45-9404-ca6b2379ba31\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b911f8a5-3dbc-4aa9-8be2-9eb2c9c8a2ed\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"33fad8c0-e55c-48fa-a820-4a3b1170da8e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"a1609989-70ec-42e9-a2d0-ce1a902593c7\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"b1fff6d4-13c6-4486-9253-3b57c0938486\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c4d11cc3-ff49-4b48-ad2a-d5a30294d552\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"c0a4744a-f5be-4ecd-a39e-b056d94bedd2\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"cd660f34-a88e-4f6f-a63d-dac487f3c1b3\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"7721d025-f700-44b7-8ab2-c920c8f2f7a5\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"07fd881e-0862-439b-a7f3-7232454c1947\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"b327ec65-2b08-42c3-99b7-28846c7708d8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b99b85fc-06c0-4960-bcda-7f07690ef20d\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"77f51075-54de-4ad6-a232-9d1d1d844ec8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b947d0e1-da59-4426-bb04-17175245afa2\"}]',1,'2022-10-05 22:19:56','2022-10-05 22:19:56','d1aaa0a6-b73f-406c-bc76-8576bc43d59b'),(160,30,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"acb31ed2-94c4-4136-bb42-5b55ffa91749\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"0bcee758-a660-4162-8172-61eb22e388b1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"25e29ab4-1e4e-444e-8911-07aae91c12ba\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1a985008-f76e-481c-8f5b-0d30aec5998f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"3c5d67d0-093b-42e4-8707-bf28d163639c\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"9bc3780c-8a26-4b34-964e-9afe3f249654\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"83b8b4ee-afe8-4be5-8bc7-c24374bc5c6a\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"69a283b4-6d7c-4669-895c-8474a32201f8\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":25,\"uid\":\"bd35df7c-729b-4f74-9e7b-fa641ccb0ff6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"041164a1-2d58-4fa0-9493-2de14aabe9ea\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"5855838f-8e9d-42f6-b070-9401e96591e2\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"e1f06878-5f13-4be3-a010-2741b9b3c7f5\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"a7a2ab93-7d7d-46cd-9a7e-cb3332bde0cd\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5af7b832-6533-4a17-8189-4cb4f8a8f712\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"34b8b9e2-3c8e-435d-b2dc-45d319d794e0\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"6f23d0a6-104c-41be-8d66-f5e9a9a260ac\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"1a442921-0be1-4e36-9891-4d363f48a858\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1da11484-e4d8-4414-9b03-6dc1be10a931\"}]',1,'2022-10-05 22:19:58','2022-10-05 22:19:58','1b905d20-6fce-410e-8ace-f0ecdbeb1e39'),(162,32,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"f037bcf9-aaf4-45cd-90c7-d310d4f4679c\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"aa5de47f-bd21-4e66-9e6b-93f174062abc\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"0c6dbddb-f57b-44ad-b265-69503e9f8842\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"de3083f1-a02b-4884-ae77-ddd215b34e40\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"49a42673-9cbc-43b4-b5db-09e356a96248\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1edf3767-b37f-430e-8ffd-4bd1a3b9f478\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"59b3fdec-f245-4581-84b4-f2a9c7597db8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"7b0a973f-bff0-4f46-bfb0-b6a50c8fe28a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"601a0eb8-a158-4297-9942-72da6f94f1f6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b90dc7a3-3d38-40c1-81e0-0ff813fb6fd9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"7ab9b1bc-e91f-4b65-8e17-7bf8c68587fb\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f2bf26d7-ca02-4ca1-be4f-08d37fad24b4\"}]',1,'2022-10-05 22:20:00','2022-10-05 22:20:00','06fcfa84-a4b0-40d3-9fa4-5e8e032778cd'),(164,33,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":true,\"width\":100,\"uid\":\"c36e3c68-cd86-4d37-b173-d001a58140c4\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"3abe1fa4-77c1-4d66-a3da-ad8dc475b818\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"8ddf2a55-05ba-4143-94ac-f52a22b8b549\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"38b98344-6260-45e3-92ea-d455cfa4afe1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"66a9432d-a3c8-4ac9-8103-53e6b2eda06e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"751770b9-039b-4d3b-8f92-3e31d5c0fba9\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"82393b65-44f2-4658-9f97-b3ab9db431d1\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"f800cb7c-e505-4e86-ae6a-31a286813755\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"4e4760b1-1d37-4220-a1e8-4e05086116f8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"267e0240-5cf1-4d41-b3ed-86fb8328dc1a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"697de0b2-ac9b-4eec-96e4-d2f432267bad\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"c4e2b9d0-07cf-41e9-9dc7-2d4e215bd72c\"}]',1,'2022-10-05 22:20:01','2022-10-05 22:20:01','3546847d-b2b2-4111-b3ae-21cd4045b5bb'),(166,34,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"e1606cf7-2992-4c96-99b3-6d962ecf7b8e\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"b431aa28-7fd8-4a95-8ace-467582d8e01f\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"e6db4a45-0247-4c09-918e-9dd563db1fa0\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"79001047-67b4-4b93-825f-333664a55c70\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"4404315a-453e-403a-872f-44f9c409467b\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"5ff7eb60-d8c3-46aa-812a-d1e865a3f872\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":50,\"uid\":\"84efce44-e8a5-48e8-bec3-f1725adda571\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1bd5ff27-b43b-4768-8fdd-170cf3a12f81\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"ee2516da-3a83-4f1a-a18b-8f525ab60336\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"86da4c73-7a95-496d-9abe-cd3807a11ead\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"baa2c968-cc46-4165-858a-45ae29d7bd8c\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"67a0e610-9765-4200-9b9f-e59e4130f652\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":25,\"uid\":\"ac0272a1-1399-43f3-ae6c-19587d710ab8\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"ba25b35f-89c4-4230-96a4-31904c63bbf7\"}]',1,'2022-10-05 22:20:03','2022-10-05 22:20:03','fdd84f30-2bdd-479e-be58-143b9b45dbfd'),(174,35,'Content','{\"userCondition\":null,\"elementCondition\":null}','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"61cadeca-8dfa-4a6e-86ec-b11ac8f1e6a4\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"1ddd814c-a3f1-4689-bb67-33d04ad8307a\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"69ae4ad8-d5b8-4026-a6cd-9eccd9a8f0be\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"69c2d7dc-3df8-4df1-a444-d2ae376da00c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"uid\":\"d93f1dbf-17fa-41ab-b73e-bdf543d358d6\",\"userCondition\":null,\"elementCondition\":null,\"fieldUid\":\"fd647249-c4ea-4ade-99ab-13f9e53bba3f\"}]',1,'2022-10-05 22:20:07','2022-10-05 22:20:07','0e802755-824f-48de-979f-ee9d5fd2bf97');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fields` VALUES (1,2,'Button','button','global','lvxnzhkr',NULL,0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":true,\"allowTarget\":true,\"autoNoReferrer\":true,\"customTextMaxLength\":0,\"customTextRequired\":false,\"defaultLinkName\":\"url\",\"defaultText\":\"Click here\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"},\"category\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"custom\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"email\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"entry\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"site\":{\"enabled\":true,\"sites\":\"*\"},\"tel\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"url\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"user\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"}}}','2022-10-05 22:18:54','2022-10-05 22:18:54','d339dd86-5cec-4889-b2d2-81f993979c61'),(2,3,'Content Builder','contentBlocks','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_contentblocks}}\",\"maxBlocks\":null,\"minBlocks\":null,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\"}','2022-10-05 22:18:54','2022-10-05 22:18:54','a4fe99b5-7832-4eb2-9833-f551177bb821'),(3,3,'Show Block Meta','showBlockMeta','global','cvrpdgoz','When enabled, you will see the setting information for each content block through-out the site.',0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:18:54','2022-10-05 22:18:54','b181050f-eab8-45f0-906a-c8241c2d3cf2'),(4,2,'Lead Image(s)','images','global',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{section.handle}/{owner.slug}/\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionLabel\":\"Choose image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":[\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"volume:3c05e593-d621-444e-8fb9-ddbb1b356a43\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-10-05 22:18:55','2022-10-05 22:18:55','adcea45e-bf40-4faf-b0c8-4ce089696971'),(5,2,'SEO','seo','global',NULL,NULL,0,'none',NULL,'nystudio107\\seomatic\\fields\\SeoSettings','{\"elementDisplayPreviewType\":\"google\",\"facebookTabEnabled\":\"\",\"generalEnabledFields\":[\"seoTitle\",\"seoDescription\",\"seoImage\"],\"generalTabEnabled\":\"1\",\"sitemapTabEnabled\":\"\",\"twitterTabEnabled\":\"\"}','2022-10-05 22:18:55','2022-10-05 22:18:55','d79b3073-00bf-430c-95d5-6d03d8303032'),(6,2,'Dek','dek','global',NULL,'A short one or two sentence description or summary of the content. ',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Dek.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:18:55','2022-10-05 22:18:55','b1c52a06-4990-43f5-90d3-898a48789556'),(7,2,'Emergency Message Layout','eMsgLayout','global','zfkvvptv',NULL,0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"All Pages\",\"value\":\"allPages\",\"default\":\"\"},{\"label\":\"Home Page Only\",\"value\":\"homePageOnly\",\"default\":\"\"}]}','2022-10-05 22:18:55','2022-10-05 22:18:55','69ac403d-1688-46dc-ab62-a46257cb4e1b'),(8,3,'Hero Block','heroBlock','global',NULL,'(Optional) The entry `Title` will be used as the headline if no hero block is added.',1,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_heroblock}}\",\"maxBlocks\":1,\"minBlocks\":0,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\"}','2022-10-05 22:18:55','2022-10-05 22:18:55','d05f4009-0b38-4065-a1b1-65221aa65e63'),(9,3,'Listing Block','listingBlock','global',NULL,NULL,0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_listingblock}}\",\"maxBlocks\":null,\"minBlocks\":null,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\"}','2022-10-05 22:18:56','2022-10-05 22:18:56','0cf8a6fe-e260-4ded-9320-9db2b141edcc'),(10,2,'Redirect','redirect','global','hjoahmzs',NULL,0,'none',NULL,'lenz\\linkfield\\fields\\LinkField','{\"allowCustomText\":false,\"allowTarget\":false,\"autoNoReferrer\":false,\"customTextMaxLength\":0,\"customTextRequired\":false,\"defaultLinkName\":\"entry\",\"defaultText\":\"\",\"enableAllLinkTypes\":false,\"enableAriaLabel\":false,\"enableElementCache\":false,\"enableTitle\":false,\"typeSettings\":{\"asset\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"},\"category\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"custom\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"email\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":false},\"entry\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":true,\"sources\":\"*\"},\"site\":{\"enabled\":true,\"sites\":\"*\"},\"tel\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":false},\"url\":{\"allowAliases\":false,\"disableValidation\":false,\"enabled\":true},\"user\":{\"allowCrossSiteLink\":false,\"allowCustomQuery\":false,\"enabled\":false,\"sources\":\"*\"}}}','2022-10-05 22:18:57','2022-10-05 22:18:57','14d7d858-e4eb-4c44-90bc-a606a5a2372a'),(11,2,'Topics','topics','global',NULL,NULL,0,'site',NULL,'craft\\fields\\Tags','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionLabel\":null,\"showSiteMenu\":false,\"source\":\"taggroup:309b4130-a979-4b2c-8a72-971bbeb15553\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:18:57','2022-10-05 22:18:57','772247d2-d67e-40f2-a243-6e6eca55c5f5'),(12,2,'Text','text','global','qieovwoa',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:18:57','2022-10-05 22:18:57','6a1ab78a-ce1d-4e06-944f-7fa172aaa06a'),(13,2,'Summary','summary','global','wtwwruam',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:18:57','2022-10-05 22:18:57','e47b95bf-7a74-49e3-afa3-a938bd733ef7'),(14,3,'Sidebar Blocks','sidebarBlocks','global',NULL,NULL,0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_sidebarblocks}}\",\"maxBlocks\":null,\"minBlocks\":null,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\"}','2022-10-05 22:18:57','2022-10-05 22:18:57','a35a0beb-0cf7-4a2b-9ec3-91e953a18116'),(15,NULL,'Text','text','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','1d242d6f-f863-4979-b2af-bb1da5c2aee2'),(16,NULL,'Eyebrow','eyebrow','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','20aa7fd2-2f1f-4b3f-b505-a14c1c3cc164'),(17,NULL,'Variant','variant','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','payanbyx',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/textImage.json\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','30b5253e-1f74-41f3-b484-e6c82e3210d5'),(18,NULL,'Anchor Link','anchor','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','54aa6fb8-4a59-4704-9956-2c47eb2f5ceb'),(19,NULL,'Background','bg','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','cpekkbhk',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','b8f98eab-bd44-4073-b73b-c5c394a00643'),(20,NULL,'Image(s)','images','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"{owner.owner.type.handle}/{owner.owner.slug}/\",\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','dda1fa64-dd45-42b6-8df9-476cbac15152'),(21,NULL,'Spacing','spacing','matrixBlockType:a39c9c32-2acb-47fd-ad36-7980c445a44e','eqfigngd',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:18:59','2022-10-05 22:18:59','e826463c-c088-426d-be5d-9630e1b872c9'),(22,NULL,'Background','bg','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','dqtdfrpw',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:19:00','2022-10-05 22:19:00','0dabdba1-b0ed-4220-8bfd-115e5127ee42'),(23,NULL,'Text','text','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":\"allow.iframes.json\",\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:00','2022-10-05 22:19:00','07a0012a-4bdf-4aaa-8415-bbe06adaf62c'),(24,NULL,'Variant','variant','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','qfgjxwao',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/text.json\"}','2022-10-05 22:19:00','2022-10-05 22:19:00','9d4f8876-987f-46fc-9042-aaf824a7131d'),(25,NULL,'Spacing','spacing','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91','lhqmhzea',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:19:00','2022-10-05 22:19:00','a7b99dca-7b58-438c-b57e-9d7965c3093b'),(26,NULL,'Anchor Link','anchor','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:19:01','2022-10-05 22:19:01','bb08d0c0-bcc3-4d96-b172-572ca8f601a1'),(27,NULL,'Eyebrow','eyebrow','matrixBlockType:a345255e-6a6e-450c-8f3f-bd44bd0d7a91',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:01','2022-10-05 22:19:01','e2e0830e-80f8-4dfd-8edf-45b6f917cd2d'),(28,NULL,'Text','text','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:01','2022-10-05 22:19:01','6bd61b45-415d-4702-8b93-c734e25ed41e'),(29,NULL,'Variant','variant','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31','ntqzccqg',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/text.json\"}','2022-10-05 22:19:02','2022-10-05 22:19:02','34c8b184-a3df-4101-9525-d2c4a65aa9cb'),(30,NULL,'Headline','headline','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31',NULL,'This will replace the \"Title\" field to act as the primary headline for the page and the SEO <h1> tag.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:02','2022-10-05 22:19:02','d08c5ca6-5020-4ac5-9460-c831d0921585'),(31,NULL,'Eyebrow','eyebrow','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31',NULL,'Creates a URL `#hash-tag` for linking directly to this block',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:02','2022-10-05 22:19:02','e6d20858-c077-4e76-b107-03166b8ba61d'),(32,NULL,'Background','bg','matrixBlockType:0ad703e2-37a9-478e-9ad4-b6b00485da31','unpwravq','How the block background should look.',0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/hero-backgrounds.json\"}','2022-10-05 22:19:02','2022-10-05 22:19:02','ea2610d5-eecb-4d99-916e-90ce7e2c2bbc'),(33,NULL,'Entry','items','matrixBlockType:4bff5ba2-d958-41db-a23e-5f04f5c07d06',NULL,NULL,0,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":null,\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:a52e2b08-2e30-4b00-8784-4104c409d3ed\",\"section:3721b4d6-42d5-41fc-b6e7-76204b42c91a\",\"section:650e7d1d-63e5-42f9-b3ab-4febfb502723\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:03','2022-10-05 22:19:03','4ebdb729-ea5a-4ff4-b10f-e4b2d0da2292'),(34,NULL,'Spacing','spacing','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','gslywyag',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/fragment-spacing.json\"}','2022-10-05 22:19:03','2022-10-05 22:19:03','abf72c9c-cdfc-4765-b71d-a03735da679d'),(35,NULL,'Background','bg','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab','nfwtlclo',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/fragment-backgrounds.json\"}','2022-10-05 22:19:03','2022-10-05 22:19:03','bf152e62-fb69-4e45-836d-7546488987e6'),(36,NULL,'Fragment(s)','fragments','matrixBlockType:d7da6677-ed4d-4768-8519-8c3123f108ab',NULL,NULL,0,'site',NULL,'nfourtythree\\entriessubset\\fields\\EntriesSubsetField','{\"allowSelfRelations\":false,\"entryTypes\":[\"174cd975-f457-4998-8bcc-3d25963f9c3b\"],\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":null,\"showSiteMenu\":false,\"source\":null,\"sources\":[\"section:89093e20-515d-4e3c-b4c4-c6733d8ab56f\"],\"targetSiteId\":null,\"userGroups\":null,\"users\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:03','2022-10-05 22:19:03','e2cdac24-87bd-4a5b-be66-d991b0323794'),(37,NULL,'Has Search?','hasSearch','matrixBlockType:85eec3ec-1883-4c10-af75-90414406842a',NULL,NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:04','2022-10-05 22:19:04','9d81e4ce-5846-4157-aebc-c26abc01d16e'),(38,NULL,'Limit','limit','matrixBlockType:85eec3ec-1883-4c10-af75-90414406842a',NULL,NULL,0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":3,\"max\":null,\"min\":1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":null,\"suffix\":null}','2022-10-05 22:19:04','2022-10-05 22:19:04','625a205f-5664-4223-840b-ec4c4e73b1bb'),(39,NULL,'Variant','variant','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','udmwrcap',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/textImage.json\"}','2022-10-05 22:19:04','2022-10-05 22:19:04','468a14eb-fb24-4d42-85ea-51a108f68949'),(40,NULL,'Eyebrow','eyebrow','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:04','2022-10-05 22:19:04','5252a6fb-4088-4f59-980a-0d5f910ab392'),(41,NULL,'Image(s)','images','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,NULL,0,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":null,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":[\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"volume:3c05e593-d621-444e-8fb9-ddbb1b356a43\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-10-05 22:19:04','2022-10-05 22:19:04','25414516-f079-42de-9891-f9dd403af271'),(42,NULL,'Headline','headline','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,'This will replace the \"Title\" field to act as the primary headline for the page and the SEO <h1> tag.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:05','2022-10-05 22:19:05','c1193bb1-b500-4050-8b68-a0a7bee4594f'),(43,NULL,'Text','text','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:05','2022-10-05 22:19:05','ec26ccd6-8b77-446f-83e4-5a157ab84ee5'),(44,NULL,'Background','bg','matrixBlockType:c00d6261-7e8e-413b-816c-41326575c213','rqyqbtbd','How the block background should look.',0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/hero-backgrounds.json\"}','2022-10-05 22:19:05','2022-10-05 22:19:05','fb8236c7-dc6f-45c6-b62d-6d6ffaaf1657'),(45,NULL,'Text','text','matrixBlockType:568005e9-0360-4053-b2e8-85db17dc554b',NULL,NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:06','2022-10-05 22:19:06','dc845fdf-e229-4765-9b4c-c77ca578bd52'),(46,NULL,'Layout','layout','matrixBlockType:decb9b0a-5710-46ed-a447-bc2856783123','hujeyyhb','How do you want to display the individual records on the page?',0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/listing-formats.json\"}','2022-10-05 22:19:06','2022-10-05 22:19:06','2e0671a7-eba0-42c5-a5ab-2b30a6fc1bf6'),(47,NULL,'Has Search?','hasSearch','matrixBlockType:decb9b0a-5710-46ed-a447-bc2856783123',NULL,NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:06','2022-10-05 22:19:06','29f0f7bf-a7d4-4015-9ea2-cfd8f1530b1b'),(48,NULL,'Limit','limit','matrixBlockType:decb9b0a-5710-46ed-a447-bc2856783123',NULL,NULL,0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":6,\"max\":null,\"min\":1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":null,\"suffix\":null}','2022-10-05 22:19:07','2022-10-05 22:19:07','c25e161a-2f9c-406c-9ace-21fa7f000c4a'),(49,NULL,'Background','bg','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','fwxmzlie',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:19:18','2022-10-05 22:19:18','0d2936c9-42b4-467f-9004-678230db8291'),(50,NULL,'Variant','variant','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','kpwsojnc',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/listing-formats.json\"}','2022-10-05 22:19:18','2022-10-05 22:19:18','8eee0057-f0e3-4674-8fd8-6eae3cc9ae0d'),(51,NULL,'Filter by Topic','topic','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77',NULL,NULL,1,'site',NULL,'craft\\fields\\Tags','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionLabel\":\"Choose topic\",\"showSiteMenu\":false,\"source\":\"taggroup:309b4130-a979-4b2c-8a72-971bbeb15553\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:18','2022-10-05 22:19:18','9f0a0dc0-db3f-49d5-9656-b61ad0d5c452'),(52,NULL,'Spacing','spacing','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','rirvtxji',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:19:18','2022-10-05 22:19:18','39b3d1e6-0464-44f3-803e-8bf88da46270'),(53,NULL,'Text','text','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','kwmvoeva',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:18','2022-10-05 22:19:18','61d7345d-34c5-4c93-8ae0-9f9b5f3b166b'),(54,NULL,'Include Pagination?','hasPagination','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','twdfutkz',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:18','2022-10-05 22:19:18','a479dbe3-176d-4b5b-b5e6-f6f5dab262ec'),(55,NULL,'Order','order','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','lppqelbx',NULL,0,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Most Recent\",\"value\":\"mostRecent\",\"default\":\"\"},{\"label\":\"Random\",\"value\":\"random\",\"default\":\"\"}]}','2022-10-05 22:19:18','2022-10-05 22:19:18','b161b327-4669-4d08-b51f-7b8c7091a2d4'),(56,NULL,'Limit','limit','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','mcovhmgu',NULL,0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":12,\"max\":null,\"min\":-1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":null,\"suffix\":null}','2022-10-05 22:19:19','2022-10-05 22:19:19','b6015f85-adad-474b-afb4-ac34bb560c0c'),(57,NULL,'Include Search?','hasSearch','matrixBlockType:e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77','ayojqsiw',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:19','2022-10-05 22:19:19','f981cb80-dd00-4b09-b682-78bfa0abccad'),(58,NULL,'Order','order','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','jidmezte',NULL,0,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Most Recent\",\"value\":\"mostRecent\",\"default\":\"\"},{\"label\":\"Random\",\"value\":\"random\",\"default\":\"\"}]}','2022-10-05 22:19:20','2022-10-05 22:19:20','09e29257-428d-40f2-81a3-c594a739de68'),(59,NULL,'Variant','variant','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','afglrhoj',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/listing-formats.json\"}','2022-10-05 22:19:20','2022-10-05 22:19:20','055d3887-062f-4180-bac4-65a9670f0440'),(60,NULL,'Limit','limit','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','ajwnsacs',NULL,0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":12,\"max\":null,\"min\":-1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":null,\"suffix\":null}','2022-10-05 22:19:20','2022-10-05 22:19:20','9844b6dc-6dbb-4203-9eec-5507fcee91f7'),(61,NULL,'Spacing','spacing','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','wbmfjcuh',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:19:20','2022-10-05 22:19:20','43048f2c-3b11-44e7-8c32-29d991c819cc'),(62,NULL,'Include Search?','hasSearch','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','sfmlstuo',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:20','2022-10-05 22:19:20','9305104a-d7ea-4f07-b6a5-4f02e3232cbd'),(63,NULL,'Text','text','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','hyzrszln',NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:20','2022-10-05 22:19:20','26431232-d9c5-41cd-9cad-3647ec59afbd'),(64,NULL,'Include Pagination?','hasPagination','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','qqtvixca',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:21','2022-10-05 22:19:21','d29c3934-5af7-4d49-9515-9dea41e6d3c2'),(65,NULL,'Background','bg','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7','fjmlbprp',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:19:21','2022-10-05 22:19:21','dd06e3eb-fff5-4c16-b219-b53867573f86'),(66,NULL,'Filter by Topic','topic','matrixBlockType:15d89a79-046e-425e-abe1-4ead065697b7',NULL,NULL,1,'site',NULL,'craft\\fields\\Tags','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionLabel\":\"Choose topic\",\"showSiteMenu\":false,\"source\":\"taggroup:309b4130-a979-4b2c-8a72-971bbeb15553\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:21','2022-10-05 22:19:21','e8196605-52ba-47d2-ba43-8dc77de92903'),(67,NULL,'Layout Variations','layout','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'How the content lays out inside the block.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Cards\",\"value\":\"cards\",\"default\":\"\"},{\"label\":\"Carousel\",\"value\":\"carousel\",\"default\":\"\"}]}','2022-10-05 22:19:25','2022-10-05 22:19:25','07fd881e-0862-439b-a7f3-7232454c1947'),(68,NULL,'Items','items','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,NULL,1,'site',NULL,'craft\\fields\\Entries','{\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Entry\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\entries\\\\EntryCondition\"},\"selectionLabel\":null,\"showSiteMenu\":true,\"source\":null,\"sources\":[\"section:a52e2b08-2e30-4b00-8784-4104c409d3ed\",\"section:3721b4d6-42d5-41fc-b6e7-76204b42c91a\",\"section:650e7d1d-63e5-42f9-b3ab-4febfb502723\"],\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:25','2022-10-05 22:19:25','a1609989-70ec-42e9-a2d0-ce1a902593c7'),(69,NULL,'Background','background','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'How the block background should look.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Band\",\"value\":\"band\",\"default\":\"\"},{\"label\":\"Box\",\"value\":\"box\",\"default\":\"\"},{\"label\":\"Outline\",\"value\":\"outline\",\"default\":\"\"}]}','2022-10-05 22:19:25','2022-10-05 22:19:25','b99b85fc-06c0-4960-bcda-7f07690ef20d'),(70,NULL,'Intro Text','text','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:25','2022-10-05 22:19:25','b911f8a5-3dbc-4aa9-8be2-9eb2c9c8a2ed'),(71,NULL,'Edges','edges','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'How the block interacts with elements around it.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Line Before\",\"value\":\"lineBefore\",\"default\":\"\"},{\"label\":\"No Gap Before\",\"value\":\"noGapBefore\",\"default\":\"\"},{\"label\":\"Extra Space\",\"value\":\"extraSpace\",\"default\":\"\"}]}','2022-10-05 22:19:25','2022-10-05 22:19:25','b947d0e1-da59-4426-bb04-17175245afa2'),(72,NULL,'Eyebrow','eyebrow','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:25','2022-10-05 22:19:25','c4d11cc3-ff49-4b48-ad2a-d5a30294d552'),(73,NULL,'Anchor Link','anchor','matrixBlockType:4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:19:25','2022-10-05 22:19:25','cd660f34-a88e-4f6f-a63d-dac487f3c1b3'),(74,NULL,'Text','text','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','tzocwopw',NULL,0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":false,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:27','2022-10-05 22:19:27','0bcee758-a660-4162-8172-61eb22e388b1'),(75,NULL,'Variant','variant','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','lmsffoac',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/listing-formats.json\"}','2022-10-05 22:19:27','2022-10-05 22:19:27','1a985008-f76e-481c-8f5b-0d30aec5998f'),(76,NULL,'Spacing','spacing','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','kbibsqwh',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:19:27','2022-10-05 22:19:27','1da11484-e4d8-4414-9b03-6dc1be10a931'),(77,NULL,'Include Pagination?','hasPagination','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','kdjpooyf',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:27','2022-10-05 22:19:27','5af7b832-6533-4a17-8189-4cb4f8a8f712'),(78,NULL,'Background','bg','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','sufzuzdu',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:19:27','2022-10-05 22:19:27','6f23d0a6-104c-41be-8d66-f5e9a9a260ac'),(79,NULL,'Filter by Topic','topic','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99',NULL,NULL,1,'site',NULL,'craft\\fields\\Tags','{\"allowLimit\":false,\"allowMultipleSources\":false,\"allowSelfRelations\":false,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"selectionLabel\":\"Choose topic\",\"showSiteMenu\":false,\"source\":\"taggroup:309b4130-a979-4b2c-8a72-971bbeb15553\",\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":null}','2022-10-05 22:19:27','2022-10-05 22:19:27','9bc3780c-8a26-4b34-964e-9afe3f249654'),(80,NULL,'Limit / Per Page','limit','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','njtiaavk',NULL,0,'none',NULL,'craft\\fields\\Number','{\"decimals\":0,\"defaultValue\":12,\"max\":null,\"min\":-1,\"prefix\":null,\"previewCurrency\":null,\"previewFormat\":\"decimal\",\"size\":null,\"suffix\":null}','2022-10-05 22:19:27','2022-10-05 22:19:27','69a283b4-6d7c-4669-895c-8474a32201f8'),(81,NULL,'Order','order','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','youtxjmv',NULL,0,'none',NULL,'craft\\fields\\RadioButtons','{\"options\":[{\"label\":\"Most Recent\",\"value\":\"mostRecent\",\"default\":\"1\"},{\"label\":\"Random\",\"value\":\"random\",\"default\":\"\"}]}','2022-10-05 22:19:28','2022-10-05 22:19:28','041164a1-2d58-4fa0-9493-2de14aabe9ea'),(82,NULL,'Include Search?','hasSearch','matrixBlockType:9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99','pkgeltqc',NULL,0,'none',NULL,'craft\\fields\\Lightswitch','{\"default\":false,\"offLabel\":null,\"onLabel\":null}','2022-10-05 22:19:28','2022-10-05 22:19:28','e1f06878-5f13-4be3-a010-2741b9b3c7f5'),(83,NULL,'Anchor Link','anchor','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:19:29','2022-10-05 22:19:29','05fb8aa2-0c98-4cee-93c3-5ad2f2709822'),(84,NULL,'Background','bg','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','ngczrvyg',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/backgrounds.json\"}','2022-10-05 22:19:29','2022-10-05 22:19:29','7b72b671-dcdc-49b2-95cd-44a8e8be7cad'),(85,NULL,'Items','items','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,NULL,1,'site',NULL,'verbb\\supertable\\fields\\SuperTableField','{\"blockTypeFields\":0,\"changedFieldIndicator\":1012369959,\"columns\":{\"1ddd814c-a3f1-4689-bb67-33d04ad8307a\":{\"width\":\"\"},\"69c2d7dc-3df8-4df1-a444-d2ae376da00c\":{\"width\":\"\"},\"fd647249-c4ea-4ade-99ab-13f9e53bba3f\":{\"width\":\"\"}},\"contentTable\":\"{{%stc_6_items}}\",\"fieldLayout\":\"matrix\",\"maxRows\":null,\"minRows\":null,\"propagationKeyFormat\":null,\"propagationMethod\":\"all\",\"selectionLabel\":null,\"staticField\":null}','2022-10-05 22:19:29','2022-10-05 22:19:29','5347a201-6da8-47ff-bc5b-20a0dc63d44e'),(86,NULL,'Eyebrow','eyebrow','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:31','2022-10-05 22:19:31','7506709b-79c3-40ab-b4d3-5ce0fa5ba5bc'),(87,NULL,'Spacing','spacing','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','vdailebf',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/spacing.json\"}','2022-10-05 22:19:31','2022-10-05 22:19:31','a1a62d7a-5173-4caf-8d92-423b6dc0dede'),(88,NULL,'Variant','variant','matrixBlockType:213c9175-81d2-4141-8993-904e59925583','ulxtrpcp',NULL,0,'none',NULL,'trendyminds\\designtokens\\fields\\DesignTokensField','{\"config\":\"blocks/content-repeater.json\"}','2022-10-05 22:19:31','2022-10-05 22:19:31','ae3f34db-5fe5-4438-86f0-377cfaebf02a'),(89,NULL,'Intro Text','text','matrixBlockType:213c9175-81d2-4141-8993-904e59925583',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:31','2022-10-05 22:19:31','c6677eab-6c78-4ca1-93cd-0faa266d1c45'),(90,NULL,'Anchor Link','anchor','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:19:33','2022-10-05 22:19:33','1edf3767-b37f-430e-8ffd-4bd1a3b9f478'),(91,NULL,'Layout Variations','layout','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'How the content lays out inside the block.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Circles\",\"value\":\"circles\",\"default\":\"\"},{\"label\":\"Gallery\",\"value\":\"gallery\",\"default\":\"\"},{\"label\":\"Carousel\",\"value\":\"carousel\",\"default\":\"\"}]}','2022-10-05 22:19:33','2022-10-05 22:19:33','7b0a973f-bff0-4f46-bfb0-b6a50c8fe28a'),(92,NULL,'Image(s)','images','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":null,\"localizeRelations\":false,\"maxRelations\":null,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"large\"}','2022-10-05 22:19:33','2022-10-05 22:19:33','aa5de47f-bd21-4e66-9e6b-93f174062abc'),(93,NULL,'Background','background','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'How the block background should look.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Band\",\"value\":\"band\",\"default\":\"\"},{\"label\":\"Box\",\"value\":\"box\",\"default\":\"\"},{\"label\":\"Outline\",\"value\":\"outline\",\"default\":\"\"}]}','2022-10-05 22:19:33','2022-10-05 22:19:33','b90dc7a3-3d38-40c1-81e0-0ff813fb6fd9'),(94,NULL,'Eyebrow','eyebrow','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:33','2022-10-05 22:19:33','de3083f1-a02b-4884-ae77-ddd215b34e40'),(95,NULL,'Edges','edges','matrixBlockType:7593ee0e-5c97-47ca-a580-35990cabaffe',NULL,'How the block interacts with elements around it.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Line Before\",\"value\":\"lineBefore\",\"default\":\"\"},{\"label\":\"No Gap Before\",\"value\":\"noGapBefore\",\"default\":\"\"},{\"label\":\"Extra Space\",\"value\":\"extraSpace\",\"default\":\"\"}]}','2022-10-05 22:19:33','2022-10-05 22:19:33','f2bf26d7-ca02-4ca1-be4f-08d37fad24b4'),(96,NULL,'Headline','headline','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'Used to create a large headline break between blocks.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:36','2022-10-05 22:19:36','3abe1fa4-77c1-4d66-a3da-ad8dc475b818'),(97,NULL,'Eyebrow','eyebrow','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'A small line of sub-text that appears above a headline.',0,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:36','2022-10-05 22:19:36','38b98344-6260-45e3-92ea-d455cfa4afe1'),(98,NULL,'Background','background','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'How the block background should look.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"\"},{\"label\":\"Band\",\"value\":\"band\",\"default\":\"\"},{\"label\":\"Box\",\"value\":\"box\",\"default\":\"\"},{\"label\":\"Outline\",\"value\":\"outline\",\"default\":\"\"}]}','2022-10-05 22:19:36','2022-10-05 22:19:36','267e0240-5cf1-4d41-b3ed-86fb8328dc1a'),(99,NULL,'Anchor Link','anchor','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":false,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-10-05 22:19:37','2022-10-05 22:19:37','751770b9-039b-4d3b-8f92-3e31d5c0fba9'),(100,NULL,'Edges','edges','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'How the block interacts with elements around it.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"\"},{\"label\":\"Line Before\",\"value\":\"lineBefore\",\"default\":\"\"},{\"label\":\"No Gap Before\",\"value\":\"noGapBefore\",\"default\":\"\"},{\"label\":\"Extra Space\",\"value\":\"extraSpace\",\"default\":\"\"}]}','2022-10-05 22:19:37','2022-10-05 22:19:37','c4e2b9d0-07cf-41e9-9dc7-2d4e215bd72c'),(101,NULL,'Layout Variations','layout','matrixBlockType:c223fda9-a939-46a4-8969-a240d2d54f07',NULL,'How the content lays out inside the block.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"\"}]}','2022-10-05 22:19:37','2022-10-05 22:19:37','f800cb7c-e505-4e86-ae6a-31a286813755'),(102,NULL,'Anchor Link','anchor','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,'Creates a URL `#hash-tag` for linking directly to this block',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":true,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":\"#example-link\",\"uiMode\":\"normal\"}','2022-10-05 22:19:39','2022-10-05 22:19:39','1bd5ff27-b43b-4768-8fdd-170cf3a12f81'),(103,NULL,'Eyebrow','eyebrow','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,'A small line of sub-text that appears above a headline.',1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Headline.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":false,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:19:39','2022-10-05 22:19:39','5ff7eb60-d8c3-46aa-812a-d1e865a3f872'),(104,NULL,'Background','background','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,'How the block background should look.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Band\",\"value\":\"band\",\"default\":\"\"},{\"label\":\"Box\",\"value\":\"box\",\"default\":\"\"},{\"label\":\"Box Left\",\"value\":\"boxLeft\",\"default\":\"\"},{\"label\":\"Box Right\",\"value\":\"boxRight\",\"default\":\"\"},{\"label\":\"Outline\",\"value\":\"outline\",\"default\":\"\"},{\"label\":\"Vertical Line\",\"value\":\"verticalLine\",\"default\":\"\"}]}','2022-10-05 22:19:39','2022-10-05 22:19:39','67a0e610-9765-4200-9b9f-e59e4130f652'),(105,NULL,'Layout Variations','layout','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,'How the content lays out inside the block.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Even Width\",\"value\":\"evenWidth\",\"default\":\"1\"},{\"label\":\"Heavy Left\",\"value\":\"heavyLeft\",\"default\":\"\"},{\"label\":\"Heavy Right\",\"value\":\"heavyRight\",\"default\":\"\"}]}','2022-10-05 22:19:39','2022-10-05 22:19:39','86da4c73-7a95-496d-9abe-cd3807a11ead'),(106,NULL,'Text (Right)','text2','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:39','2022-10-05 22:19:39','79001047-67b4-4b93-825f-333664a55c70'),(107,NULL,'Text (Left)','text','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":\"*\",\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Standard.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"enlarged\"}','2022-10-05 22:19:40','2022-10-05 22:19:40','b431aa28-7fd8-4a95-8ace-467582d8e01f'),(108,NULL,'Edges','edges','matrixBlockType:4fa97a99-7fb7-479d-aa34-e020e16ab4b8',NULL,'How the block interacts with elements around it.',0,'none',NULL,'craft\\fields\\Dropdown','{\"options\":[{\"label\":\"Normal\",\"value\":\"normal\",\"default\":\"1\"},{\"label\":\"Line Before\",\"value\":\"lineBefore\",\"default\":\"\"},{\"label\":\"No Gap Before\",\"value\":\"noGapBefore\",\"default\":\"\"},{\"label\":\"Extra Space\",\"value\":\"extraSpace\",\"default\":\"\"}]}','2022-10-05 22:19:40','2022-10-05 22:19:40','ba25b35f-89c4-4230-96a4-31904c63bbf7'),(109,NULL,'Headline','headline','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":false,\"columnType\":null,\"initialRows\":4,\"multiline\":false,\"placeholder\":null,\"uiMode\":\"normal\"}','2022-10-05 22:20:04','2022-10-05 22:20:04','1ddd814c-a3f1-4689-bb67-33d04ad8307a'),(110,NULL,'Text','text','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'none',NULL,'craft\\redactor\\Field','{\"availableTransforms\":\"*\",\"availableVolumes\":[\"a4f97962-52de-4b53-8422-5b833d1cd5fd\"],\"columnType\":\"text\",\"configSelectionMode\":\"choose\",\"defaultTransform\":\"\",\"manualConfig\":\"\",\"purifierConfig\":null,\"purifyHtml\":true,\"redactorConfig\":\"Simple.json\",\"removeEmptyTags\":true,\"removeInlineStyles\":true,\"removeNbsp\":true,\"showHtmlButtonForNonAdmins\":false,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"uiMode\":\"normal\"}','2022-10-05 22:20:04','2022-10-05 22:20:04','69c2d7dc-3df8-4df1-a444-d2ae376da00c'),(111,NULL,'Image / Icon','images','superTableBlockType:d5468b8f-24c2-45c5-a377-ac0da764cbb1',NULL,NULL,1,'site',NULL,'craft\\fields\\Assets','{\"allowSelfRelations\":false,\"allowSubfolders\":false,\"allowUploads\":true,\"allowedKinds\":[\"image\"],\"defaultUploadLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"defaultUploadLocationSubpath\":\"icons/\",\"localizeRelations\":false,\"maxRelations\":1,\"minRelations\":null,\"previewMode\":\"full\",\"restrictFiles\":true,\"restrictLocation\":false,\"restrictedDefaultUploadSubpath\":null,\"restrictedLocationSource\":\"volume:a4f97962-52de-4b53-8422-5b833d1cd5fd\",\"restrictedLocationSubpath\":null,\"selectionCondition\":{\"elementType\":\"craft\\\\elements\\\\Asset\",\"fieldContext\":\"global\",\"class\":\"craft\\\\elements\\\\conditions\\\\assets\\\\AssetCondition\"},\"selectionLabel\":\"Choose Image\",\"showSiteMenu\":true,\"showUnpermittedFiles\":false,\"showUnpermittedVolumes\":false,\"source\":null,\"sources\":\"*\",\"targetSiteId\":null,\"validateRelatedElements\":false,\"viewMode\":\"list\"}','2022-10-05 22:20:04','2022-10-05 22:20:04','fd647249-c4ea-4ade-99ab-13f9e53bba3f');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_emailtemplates`
--

LOCK TABLES `formie_emailtemplates` WRITE;
/*!40000 ALTER TABLE `formie_emailtemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_emailtemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_forms`
--

LOCK TABLES `formie_forms` WRITE;
/*!40000 ALTER TABLE `formie_forms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_forms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_formtemplates`
--

LOCK TABLES `formie_formtemplates` WRITE;
/*!40000 ALTER TABLE `formie_formtemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_formtemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_integrations`
--

LOCK TABLES `formie_integrations` WRITE;
/*!40000 ALTER TABLE `formie_integrations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_integrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_nested`
--

LOCK TABLES `formie_nested` WRITE;
/*!40000 ALTER TABLE `formie_nested` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_nested` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_nestedfieldrows`
--

LOCK TABLES `formie_nestedfieldrows` WRITE;
/*!40000 ALTER TABLE `formie_nestedfieldrows` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_nestedfieldrows` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_notifications`
--

LOCK TABLES `formie_notifications` WRITE;
/*!40000 ALTER TABLE `formie_notifications` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_notifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_pagesettings`
--

LOCK TABLES `formie_pagesettings` WRITE;
/*!40000 ALTER TABLE `formie_pagesettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_pagesettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments`
--

LOCK TABLES `formie_payments` WRITE;
/*!40000 ALTER TABLE `formie_payments` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments_plans`
--

LOCK TABLES `formie_payments_plans` WRITE;
/*!40000 ALTER TABLE `formie_payments_plans` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments_plans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_payments_subscriptions`
--

LOCK TABLES `formie_payments_subscriptions` WRITE;
/*!40000 ALTER TABLE `formie_payments_subscriptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_payments_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_pdftemplates`
--

LOCK TABLES `formie_pdftemplates` WRITE;
/*!40000 ALTER TABLE `formie_pdftemplates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_pdftemplates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_relations`
--

LOCK TABLES `formie_relations` WRITE;
/*!40000 ALTER TABLE `formie_relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_rows`
--

LOCK TABLES `formie_rows` WRITE;
/*!40000 ALTER TABLE `formie_rows` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_rows` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_sentnotifications`
--

LOCK TABLES `formie_sentnotifications` WRITE;
/*!40000 ALTER TABLE `formie_sentnotifications` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_sentnotifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_statuses`
--

LOCK TABLES `formie_statuses` WRITE;
/*!40000 ALTER TABLE `formie_statuses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_statuses` VALUES (1,'New','new','green',NULL,1,1,NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53','537988be-e9c5-43e8-8611-2256a41a72fe');
/*!40000 ALTER TABLE `formie_statuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_stencils`
--

LOCK TABLES `formie_stencils` WRITE;
/*!40000 ALTER TABLE `formie_stencils` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `formie_stencils` VALUES (1,'Contact Form','contactForm','{\"dataRetention\":\"forever\",\"dataRetentionValue\":null,\"fileUploadsAction\":\"retain\",\"notifications\":[{\"attachFiles\":true,\"attachPdf\":false,\"bcc\":null,\"cc\":null,\"conditions\":\"{\\\"sendRule\\\":\\\"send\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"content\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"A user submission has been made on the \\\\\\\"\\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Form Name\\\",\\\"value\\\":\\\"{formName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"\\\\\\\" form on \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Site Name\\\",\\\"value\\\":\\\"{siteName}\\\"}},{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\" at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Their submission details are:\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\",\"enableConditions\":false,\"enabled\":true,\"formId\":null,\"from\":\"{field.emailAddress}\",\"fromName\":null,\"id\":\"new981-8077\",\"name\":\"Admin Notification\",\"pdfTemplateId\":null,\"recipients\":\"email\",\"replyTo\":\"{field.emailAddress}\",\"replyToName\":null,\"subject\":\"A new submission was made on \\\"{formName}\\\"\",\"templateId\":null,\"to\":\"{systemEmail}\",\"toConditions\":\"{\\\"toRecipients\\\":[]}\",\"uid\":null},{\"attachFiles\":true,\"attachPdf\":false,\"bcc\":null,\"cc\":null,\"conditions\":\"{\\\"sendRule\\\":\\\"send\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"content\":\"[{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"Thanks again for contacting us. Our team will get back to you as soon as we can.\\\"}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"text\\\",\\\"text\\\":\\\"As a reminder, you submitted the following details at \\\"},{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"Timestamp (yyyy-mm-dd hh:mm:ss)\\\",\\\"value\\\":\\\"{timestamp}\\\"}}]},{\\\"type\\\":\\\"paragraph\\\",\\\"content\\\":[{\\\"type\\\":\\\"variableTag\\\",\\\"attrs\\\":{\\\"label\\\":\\\"All Form Fields\\\",\\\"value\\\":\\\"{allFields}\\\"}}]}]\",\"enableConditions\":false,\"enabled\":true,\"formId\":null,\"from\":null,\"fromName\":null,\"id\":\"new7052-5168\",\"name\":\"User Notification\",\"pdfTemplateId\":\"\",\"recipients\":\"email\",\"replyTo\":null,\"replyToName\":null,\"subject\":\"Thanks for contacting us!\",\"templateId\":\"\",\"to\":\"{field.emailAddress}\",\"toConditions\":\"{\\\"toRecipients\\\":[]}\",\"uid\":null}],\"pages\":[{\"id\":\"new1272610411\",\"label\":\"Page 1\",\"notificationFlag\":true,\"rows\":[{\"fields\":[{\"brandNewField\":false,\"handle\":\"yourName\",\"hasLabel\":true,\"id\":\"new7715-7348\",\"label\":\"Your Name\",\"settings\":{\"conditions\":\"{\\\"showRule\\\":\\\"show\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"firstNameCollapsed\":false,\"firstNameDefaultValue\":\"\",\"firstNameEnabled\":true,\"firstNameLabel\":\"First Name\",\"firstNamePlaceholder\":\"e.g. Peter\",\"firstNameRequired\":true,\"handle\":\"yourName\",\"instructions\":\"Please enter your full name.\",\"instructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"label\":\"Your Name\",\"labelPosition\":\"verbb\\\\formie\\\\positions\\\\Hidden\",\"lastNameCollapsed\":false,\"lastNameDefaultValue\":\"\",\"lastNameEnabled\":true,\"lastNameLabel\":\"Last Name\",\"lastNamePlaceholder\":\"e.g. Sherman\",\"lastNameRequired\":true,\"maxType\":\"characters\",\"middleNameCollapsed\":true,\"middleNameDefaultValue\":\"\",\"middleNameEnabled\":false,\"middleNameLabel\":\"Middle Name\",\"placeholder\":\"Your name\",\"prefixCollapsed\":true,\"prefixDefaultValue\":\"\",\"prefixEnabled\":false,\"prefixLabel\":\"Prefix\",\"subfieldLabelPosition\":\"\",\"useMultipleFields\":true,\"visibility\":\"\"},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\Name\"}],\"id\":\"new8990-9934\"},{\"fields\":[{\"brandNewField\":false,\"handle\":\"emailAddress\",\"hasLabel\":true,\"id\":\"new6482-9528\",\"label\":\"Email Address\",\"settings\":{\"handle\":\"emailAddress\",\"instructions\":\"Please enter your email so we can get in touch.\",\"instructionsPosition\":\"\",\"label\":\"Email Address\",\"labelPosition\":\"\",\"maxType\":\"characters\",\"placeholder\":\"e.g. psherman@wallaby.com\",\"required\":true},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\Email\"}],\"id\":\"new9524-8509\"},{\"fields\":[{\"brandNewField\":false,\"handle\":\"message\",\"hasLabel\":true,\"id\":\"new982-7322\",\"label\":\"Message\",\"settings\":{\"conditions\":\"{\\\"showRule\\\":\\\"show\\\",\\\"conditionRule\\\":\\\"all\\\",\\\"conditions\\\":[]}\",\"handle\":\"message\",\"instructions\":\"Please enter your comments.\",\"instructionsPosition\":\"\",\"label\":\"Message\",\"labelPosition\":\"\",\"maxType\":\"characters\",\"placeholder\":\"e.g. The reason for my enquiry is...\",\"required\":true,\"visibility\":\"\"},\"type\":\"verbb\\\\formie\\\\fields\\\\formfields\\\\MultiLineText\"}],\"id\":\"new2177-9685\"}],\"settings\":{\"backButtonLabel\":\"Back\",\"buttonsPosition\":\"left\",\"label\":\"Page 1\",\"showBackButton\":false,\"submitButtonLabel\":\"Contact us\"},\"sortOrder\":0}],\"settings\":{\"collectIp\":false,\"collectUser\":false,\"dataRetention\":null,\"dataRetentionValue\":null,\"defaultEmailTemplateId\":null,\"defaultInstructionsPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"defaultLabelPosition\":\"verbb\\\\formie\\\\positions\\\\AboveInput\",\"disableCaptchas\":false,\"displayCurrentPageTitle\":false,\"displayFormTitle\":false,\"displayPageProgress\":false,\"displayPageTabs\":false,\"errorMessage\":[{\"content\":[{\"text\":\"Couldn’t save submission due to errors.\",\"type\":\"text\"}],\"type\":\"paragraph\"}],\"errorMessagePosition\":\"top-form\",\"fileUploadsAction\":null,\"integrations\":{\"\":{\"enabled\":true}},\"limitSubmissions\":false,\"limitSubmissionsMessage\":null,\"limitSubmissionsNumber\":null,\"limitSubmissionsType\":null,\"loadingIndicator\":\"spinner\",\"loadingIndicatorText\":null,\"progressPosition\":\"end\",\"redirectUrl\":null,\"requireUser\":false,\"requireUserMessage\":null,\"scheduleForm\":false,\"scheduleFormEnd\":null,\"scheduleFormExpiredMessage\":null,\"scheduleFormPendingMessage\":null,\"scheduleFormStart\":null,\"scrollToTop\":true,\"submissionTitleFormat\":\"{timestamp}\",\"submitAction\":\"message\",\"submitActionFormHide\":false,\"submitActionMessage\":[{\"content\":[{\"text\":\"Thank you for contacting us! Our team will get in touch shortly to follow up on your message.\",\"type\":\"text\"}],\"type\":\"paragraph\"}],\"submitActionMessagePosition\":\"top-form\",\"submitActionMessageTimeout\":null,\"submitActionTab\":null,\"submitActionUrl\":null,\"submitMethod\":\"ajax\",\"validationOnFocus\":true,\"validationOnSubmit\":true},\"userDeletedAction\":\"retain\"}',NULL,NULL,NULL,1,NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53','b97d889b-174a-4908-b53e-13fbe7ad2d73');
/*!40000 ALTER TABLE `formie_stencils` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_submissions`
--

LOCK TABLES `formie_submissions` WRITE;
/*!40000 ALTER TABLE `formie_submissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_submissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_syncfields`
--

LOCK TABLES `formie_syncfields` WRITE;
/*!40000 ALTER TABLE `formie_syncfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_syncfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_syncs`
--

LOCK TABLES `formie_syncs` WRITE;
/*!40000 ALTER TABLE `formie_syncs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_syncs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `formie_tokens`
--

LOCK TABLES `formie_tokens` WRITE;
/*!40000 ALTER TABLE `formie_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `formie_tokens` ENABLE KEYS */;
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
INSERT INTO `gqlschemas` VALUES (1,'Public Schema','[]',1,'2022-10-05 22:19:16','2022-10-05 22:19:16','6996714c-bbb3-4367-9b3f-90be15abbbee');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `imagetransforms`
--

LOCK TABLES `imagetransforms` WRITE;
/*!40000 ALTER TABLE `imagetransforms` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `imagetransforms` VALUES (1,'Square','square','crop','center-center',350,350,NULL,NULL,'none','2022-10-05 22:19:16','2022-10-05 22:19:16','2022-10-05 22:19:16','e2d14d09-0715-4ab2-b3ea-5bea36055901');
/*!40000 ALTER TABLE `imagetransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'4.2.5.2','4.0.0.9',0,'tuurulrucglq','3@jilhnhtjet','2022-10-05 22:18:14','2022-10-05 22:31:39','ed079760-0efc-4b6a-b77c-7e8d156c4be8');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `knockknock_logins`
--

LOCK TABLES `knockknock_logins` WRITE;
/*!40000 ALTER TABLE `knockknock_logins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `knockknock_logins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `lenz_linkfield`
--

LOCK TABLES `lenz_linkfield` WRITE;
/*!40000 ALTER TABLE `lenz_linkfield` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `lenz_linkfield` VALUES (1,1,1,2,'url',NULL,NULL,NULL,NULL,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08','39add9a1-329e-4da8-86f5-c105b062467c'),(2,2,1,2,'url',NULL,NULL,NULL,NULL,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08','faaa347f-946d-460e-9c4f-f92ee8731ced'),(3,3,1,2,'url',NULL,NULL,NULL,NULL,NULL,'2022-10-05 22:19:09','2022-10-05 22:19:09','03e4f12f-966e-434b-816c-7c70167876ba'),(4,10,1,2,'url',NULL,NULL,NULL,NULL,NULL,'2022-10-05 22:19:41','2022-10-05 22:19:41','77c74a02-0432-44ca-9e0a-2739cf7b4fad'),(5,11,1,2,'url',NULL,NULL,NULL,NULL,NULL,'2022-10-05 22:19:42','2022-10-05 22:19:42','10bd2075-0bf6-48a3-808e-0bc650632f0d');
/*!40000 ALTER TABLE `lenz_linkfield` ENABLE KEYS */;
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
-- Dumping data for table `matrixblocks_owners`
--

LOCK TABLES `matrixblocks_owners` WRITE;
/*!40000 ALTER TABLE `matrixblocks_owners` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks_owners` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `matrixblocktypes` VALUES (1,2,7,'Text + Image','textImage',2,'2022-10-05 22:18:59','2022-10-05 22:18:59','a39c9c32-2acb-47fd-ad36-7980c445a44e'),(2,2,8,'Text','text',1,'2022-10-05 22:19:01','2022-10-05 22:19:01','a345255e-6a6e-450c-8f3f-bd44bd0d7a91'),(3,8,9,'Text','text',2,'2022-10-05 22:19:02','2022-10-05 22:19:02','0ad703e2-37a9-478e-9ad4-b6b00485da31'),(4,14,10,'Entry','entries',3,'2022-10-05 22:19:03','2022-10-05 22:19:03','4bff5ba2-d958-41db-a23e-5f04f5c07d06'),(5,2,11,'Fragment','fragment',7,'2022-10-05 22:19:03','2022-10-05 22:19:03','d7da6677-ed4d-4768-8519-8c3123f108ab'),(6,9,12,'FAQs','faqs',2,'2022-10-05 22:19:04','2022-10-05 22:19:04','85eec3ec-1883-4c10-af75-90414406842a'),(7,8,13,'Text + Image','textImage',1,'2022-10-05 22:19:05','2022-10-05 22:19:05','c00d6261-7e8e-413b-816c-41326575c213'),(8,14,14,'Text','text',2,'2022-10-05 22:19:06','2022-10-05 22:19:06','568005e9-0360-4053-b2e8-85db17dc554b'),(9,9,15,'News','news',1,'2022-10-05 22:19:07','2022-10-05 22:19:07','decb9b0a-5710-46ed-a447-bc2856783123'),(10,2,27,'Tag Listing','tagListing',10,'2022-10-05 22:19:19','2022-10-05 22:19:19','e6b72bb3-6c4d-4e64-9e55-4dfbd97f2a77'),(11,2,28,'Faq Listing','faqListing',9,'2022-10-05 22:19:21','2022-10-05 22:19:21','15d89a79-046e-425e-abe1-4ead065697b7'),(12,2,29,'Embedded Entries','entries',5,'2022-10-05 22:19:26','2022-10-05 22:19:26','4ede4f3a-bc76-433d-b9b0-c7e35bc7ac5f'),(13,2,30,'News Listing','newsListing',8,'2022-10-05 22:19:28','2022-10-05 22:19:28','9a3e230d-cfa4-4cb5-ba2d-52e3f036ec99'),(14,2,31,'Content Repeater','repeater',6,'2022-10-05 22:19:31','2022-10-05 22:19:31','213c9175-81d2-4141-8993-904e59925583'),(15,2,32,'Image','image',4,'2022-10-05 22:19:34','2022-10-05 22:19:34','7593ee0e-5c97-47ca-a580-35990cabaffe'),(16,14,33,'Headline','headline',1,'2022-10-05 22:19:37','2022-10-05 22:19:37','c223fda9-a939-46a4-8969-a240d2d54f07'),(17,2,34,'Text + Text','textText',3,'2022-10-05 22:19:40','2022-10-05 22:19:40','4fa97a99-7fb7-479d-aa34-e020e16ab4b8');
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
-- Dumping data for table `matrixcontent_heroblock`
--

LOCK TABLES `matrixcontent_heroblock` WRITE;
/*!40000 ALTER TABLE `matrixcontent_heroblock` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_heroblock` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_listingblock`
--

LOCK TABLES `matrixcontent_listingblock` WRITE;
/*!40000 ALTER TABLE `matrixcontent_listingblock` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_listingblock` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixcontent_sidebarblocks`
--

LOCK TABLES `matrixcontent_sidebarblocks` WRITE;
/*!40000 ALTER TABLE `matrixcontent_sidebarblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixcontent_sidebarblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,'plugin:dospaces','m220426_100557_update_volume_to_fs','2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:18:14','342623d6-4bd0-4774-97cf-19bc95cd4aad'),(2,'plugin:formie','Install','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','bdf1aabb-c5d8-479b-9233-740adb6d74bf'),(3,'plugin:formie','m220420_000000_stencil_add_entryid','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','f80ec47a-cea1-4b5f-a91d-0fc82fd082ae'),(4,'plugin:formie','m220422_000000_migrate_asset_fields','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','4f886bbe-8caa-4b4a-a1f0-3096e50d07fb'),(5,'plugin:formie','m220530_000000_payments','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','89538ccd-8bf4-419c-98a4-9d872112a1f3'),(6,'plugin:formie','m220727_000000_hubspot','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','3fdaae42-dfca-4e63-9379-0b34fe92999d'),(7,'plugin:formie','m220903_000000_remove_old_form_settings','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','40bee0e9-02fa-43fd-8ec4-5a47fe6d82c6'),(8,'plugin:formie','m220904_000000_add_siteid_entry_redirect','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','b1b2e058-cbf3-40f9-9827-dd7f73db9964'),(9,'plugin:formie','m220905_000000_integration_enabled','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','276c62d2-d51d-4e68-884d-16d1c0343013'),(10,'plugin:formie','m220917_000000_submission_spamclass','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','e70269ff-1b4f-4129-bbac-123d04e110c6'),(11,'plugin:formie','m220918_000000_email_sender','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','1b205f5b-f03e-413e-969a-2eb9f336b789'),(12,'plugin:knock-knock','Install','2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:18:39','d4852264-94da-45c2-aab8-35f186be330e'),(13,'plugin:navigation','Install','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','7e1e6247-0676-4882-ac90-f81f6575b105'),(14,'plugin:navigation','m220427_000000_navs_site_settings','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','5fb483ad-50fe-41a5-87d6-53b403e1b876'),(15,'plugin:navigation','m220427_100000_navs_placement','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','cde1b196-718b-4e14-98fb-7c2d2b682a88'),(16,'plugin:navigation','m220428_000000_custom_node_type','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','b6cc2307-8cf6-4e4b-a70b-f0557e7b7f3a'),(17,'plugin:navigation','m220831_000000_fix_nav_sites','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','2cc03156-d2e3-433e-98e2-5503c0aea488'),(18,'plugin:navigation','m220902_000000_fix_empty_nav_sites','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','278ecba1-f5b2-4076-b540-25fce51bc4c1'),(19,'plugin:redactor','m180430_204710_remove_old_plugins','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','9deef4f7-5783-4900-a518-cea9c0448100'),(20,'plugin:redactor','Install','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','15a6dc40-3732-473c-a519-2d4162e1342b'),(21,'plugin:redactor','m190225_003922_split_cleanup_html_settings','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','46a5dbc7-286c-4d1b-8916-061c95e0fcc0'),(22,'plugin:redirect','Install','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','195a7ed8-7a9e-4279-8860-400389804976'),(23,'plugin:redirect','m170602_080218_redirect_1_0_1','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','4a321fc1-3cfd-4556-ad67-84e59e5636ee'),(24,'plugin:redirect','m170707_211256_count_fix','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','2aa41ed8-299a-4d95-b16a-3a4b952ac7e4'),(25,'plugin:redirect','m171003_120604_createmultisiteurls','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','a669d9a1-d374-463f-8578-efd6a96961b0'),(26,'plugin:redirect','m180104_143118_c_redirects_catch_all_urls','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','43107727-a00c-47ae-8eb9-4b70171b1b00'),(27,'plugin:redirect','m190426_121317_change_url_size_to_1000','2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:18:45','9972bfb8-17dd-4160-a69f-dee90b01608a'),(28,'plugin:seomatic','Install','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','ccd3d830-1816-4e25-a132-ba763e822439'),(29,'plugin:seomatic','m180314_002755_field_type','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','e95d886b-a57e-45d1-82ea-3d99a871d8d2'),(30,'plugin:seomatic','m180314_002756_base_install','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','249fa602-cb81-4d54-80d5-8a3cb479e317'),(31,'plugin:seomatic','m180502_202319_remove_field_metabundles','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','4d883581-7cfd-4238-9638-4f0bc1289376'),(32,'plugin:seomatic','m180711_024947_commerce_products','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','56f07734-8cc3-4cd6-8ac9-f9f5f3cbf45c'),(33,'plugin:seomatic','m190401_220828_longer_handles','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','70179342-9632-47f3-a61c-1d7063b80a9e'),(34,'plugin:seomatic','m190518_030221_calendar_events','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','9d718300-4099-41ae-b171-b5bbe1394407'),(35,'plugin:seomatic','m200419_203444_add_type_id','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','1f154bf2-e2ee-4ebf-9cfa-674b8904a1fd'),(36,'plugin:seomatic','m210603_213100_add_gql_schema_components','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','0b892328-7630-400e-a16a-cf21e6ca9e48'),(37,'plugin:seomatic','m210817_230853_announcement_v3_4','2022-10-05 22:18:46','2022-10-05 22:18:46','2022-10-05 22:18:46','ee003914-ba1c-4365-961e-9b5403827c84'),(38,'plugin:sherlock','Install','2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:18:47','625dcf2e-1672-4a4b-b904-6ad43d727b07'),(39,'plugin:sherlock','m220330_120000_update_setting','2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:18:47','2d76d458-d663-4422-a16b-54a5d2b6ac9b'),(40,'plugin:sprig','Install','2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:18:47','af4b9d7d-5ce1-440b-95e9-d8c52415bd75'),(41,'plugin:super-table','Install','2022-10-05 22:18:50','2022-10-05 22:18:50','2022-10-05 22:18:50','6476b9a6-0963-4a0e-87a5-f7473c9c4c41'),(42,'plugin:super-table','m220308_000000_remove_superfluous_uids','2022-10-05 22:18:51','2022-10-05 22:18:51','2022-10-05 22:18:51','1036fca6-018f-4942-8b46-ec36bcdedabf'),(43,'plugin:super-table','m220308_100000_owners_table','2022-10-05 22:18:51','2022-10-05 22:18:51','2022-10-05 22:18:51','fde70bee-c88f-408a-b854-794538f48b7b'),(44,'plugin:typedlinkfield','Install','2022-10-05 22:18:52','2022-10-05 22:18:52','2022-10-05 22:18:52','ea134e25-be1d-4e72-b6e3-99a9c01bd796'),(45,'plugin:typedlinkfield','m190417_202153_migrateDataToTable','2022-10-05 22:18:52','2022-10-05 22:18:52','2022-10-05 22:18:52','2d6411ee-d244-40a5-ad3b-54bb5fcedcca'),(46,'craft','Install','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','bb9b7082-0edb-4228-8a45-eede190f41cd'),(47,'craft','m210121_145800_asset_indexing_changes','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','2028ae26-bf8e-40db-82bc-373dc752e8b5'),(48,'craft','m210624_222934_drop_deprecated_tables','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','81b158f4-6b97-4315-928d-2f4275a1da58'),(49,'craft','m210724_180756_rename_source_cols','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','882ead5e-bd7e-4708-beae-e96fa788e477'),(50,'craft','m210809_124211_remove_superfluous_uids','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','ba47d46a-abf2-4fa0-ac39-d10c7abb066b'),(51,'craft','m210817_014201_universal_users','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','231f41a1-d7d9-4e61-9a0f-2d4f3a34134f'),(52,'craft','m210904_132612_store_element_source_settings_in_project_config','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','882ddded-3eb5-474b-aadc-bb5e1cfd09c5'),(53,'craft','m211115_135500_image_transformers','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','57f01ff7-8f97-41d3-92ea-4ebea9af7fb6'),(54,'craft','m211201_131000_filesystems','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','55c69e20-a1f2-476c-9c29-a8e2f0dd278e'),(55,'craft','m220103_043103_tab_conditions','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','9b30b2d6-6334-439d-86bf-4acc815b88b3'),(56,'craft','m220104_003433_asset_alt_text','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','7648612d-4388-4d17-a9d6-fac484fcaa30'),(57,'craft','m220123_213619_update_permissions','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','0dc5b50e-8b8b-4f8d-a22c-bc6deb3a6fbb'),(58,'craft','m220126_003432_addresses','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','42eb6329-ce66-4eef-9d4f-46aacc678c3c'),(59,'craft','m220209_095604_add_indexes','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','34f4013c-98c7-47ab-8928-271a5a9b07cf'),(60,'craft','m220213_015220_matrixblocks_owners_table','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','4c3dde30-bc27-470a-83ee-ca73e959958e'),(61,'craft','m220214_000000_truncate_sessions','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','2c06e26f-63df-42ee-ad09-d5420712d652'),(62,'craft','m220222_122159_full_names','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','1ac399cc-3d43-462a-90ff-edf5c18fba2b'),(63,'craft','m220223_180559_nullable_address_owner','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','a5f11563-088a-4246-8659-6cb6568f1085'),(64,'craft','m220225_165000_transform_filesystems','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','02ae41b0-777e-414e-b2dc-73bd72201209'),(65,'craft','m220309_152006_rename_field_layout_elements','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','f7da6921-dc26-4e50-a029-ab2440464487'),(66,'craft','m220314_211928_field_layout_element_uids','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','496d32ff-450b-4de6-9766-1baf433da429'),(67,'craft','m220316_123800_transform_fs_subpath','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','e4f13ad8-10fd-4a01-903f-3a18e4fbcd6f'),(68,'craft','m220317_174250_release_all_jobs','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','d75a3ff2-8932-4bad-9e94-87069f03cc05'),(69,'craft','m220330_150000_add_site_gql_schema_components','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','942d9acb-78ce-4fcb-b8be-f36e579ea288'),(70,'craft','m220413_024536_site_enabled_string','2022-10-05 22:20:08','2022-10-05 22:20:08','2022-10-05 22:20:08','faa8599d-99ad-41ce-a430-2c70a12147c0');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_navs`
--

LOCK TABLES `navigation_navs` WRITE;
/*!40000 ALTER TABLE `navigation_navs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `navigation_navs` VALUES (1,1,'Legal','legal',NULL,2,0,NULL,'{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"1\"}}',1,'end','2022-10-05 22:18:53','2022-10-05 22:19:15',NULL,'d1f62e57-fa7c-44d0-8deb-ce19e5ff24f4'),(2,2,'Primary Navigation','primaryNavigation',NULL,1,0,NULL,'{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"}}',2,'end','2022-10-05 22:18:53','2022-10-05 22:19:16',NULL,'bf54b939-18ca-4edf-a1ac-956f04744f8e'),(3,3,'Primary','primary',NULL,1,0,NULL,'{\"craft\\\\elements\\\\Asset\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Category\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Entry\":{\"enabled\":\"1\",\"permissions\":\"*\"},\"craft\\\\elements\\\\Tag\":{\"enabled\":\"\",\"permissions\":\"*\"},\"verbb\\\\navigation\\\\nodetypes\\\\CustomType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\PassiveType\":{\"enabled\":\"1\"},\"verbb\\\\navigation\\\\nodetypes\\\\SiteType\":{\"enabled\":\"1\"}}',3,'end','2022-10-05 22:18:53','2022-10-05 22:19:16',NULL,'c631ebbf-3bef-4266-8a8b-5d9087223423');
/*!40000 ALTER TABLE `navigation_navs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `navigation_navs_sites`
--

LOCK TABLES `navigation_navs_sites` WRITE;
/*!40000 ALTER TABLE `navigation_navs_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `navigation_navs_sites` VALUES (1,1,2,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','723e2acb-f004-40f7-917b-5fcc23e0e531'),(2,1,1,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','f413f16b-f6d1-4445-8fc4-34ee38b8eeb8'),(3,2,2,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','d301113b-4c7f-410b-9ae5-2f2ebee2cc2e'),(4,2,1,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','a78bf6c5-e52b-414b-9c4d-1a88afeecfdf'),(5,3,2,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','ba3e05b5-2423-43b4-ba01-d04f9ff7a816'),(6,3,1,1,'2022-10-05 22:18:53','2022-10-05 22:18:53','01651d72-475b-4dec-bde9-69c584940a66');
/*!40000 ALTER TABLE `navigation_navs_sites` ENABLE KEYS */;
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
INSERT INTO `plugins` VALUES (1,'designtokens','1.0.3','1.0.0','unknown',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','44e80bd5-4e32-4b4c-be26-7e510d5de225'),(2,'dospaces','2.0.0','2.0.0','unknown',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','80cf80b4-88e9-46d2-84da-c56c8e54c82f'),(3,'empty-coalesce','4.0.0','1.0.0','unknown',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','3a5d61ac-8cc2-4a5f-86fd-3f15c2e7f562'),(4,'entriessubset','2.1.0','1.1.1','trial',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','07d7b4c2-e7c2-47e6-b7fd-49c868e0ce13'),(5,'environment-label','4.0.2','1.0.0','unknown',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','51b8b2ef-4cec-4ae3-8658-d73b09a8cb3b'),(6,'fastcgi-cache-bust','4.0.0-beta.1','1.0.0','unknown',NULL,'2022-10-05 22:18:14','2022-10-05 22:18:14','2022-10-05 22:21:31','5a9393bd-d135-4883-a34a-df7ab18bb90b'),(7,'formie','2.0.12','2.0.8','trial',NULL,'2022-10-05 22:18:15','2022-10-05 22:18:15','2022-10-05 22:21:31','eb49c928-7b46-4bf3-b8fb-16225e775e72'),(8,'knock-knock','2.0.2','1.1.1','unknown',NULL,'2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:21:31','0c58b480-1530-4d24-9bf5-2ff4c527fb08'),(9,'matrixmate','2.1.1','1.0.0','unknown',NULL,'2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:21:31','3c3fbcd5-ed2d-402e-a240-98c0d02dc25e'),(10,'minify','4.0.0-beta.2','1.0.0','unknown',NULL,'2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:21:31','9d450acf-4db8-47e6-a25a-1db4fe18e329'),(11,'navigation','2.0.6','2.0.4','trial',NULL,'2022-10-05 22:18:39','2022-10-05 22:18:39','2022-10-05 22:21:31','ba69362b-7a01-41fb-bdd9-3c9ade328cca'),(12,'redactor','3.0.2','2.3.0','unknown',NULL,'2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:21:31','cfb595e5-5d36-48bd-80fc-e09e4e104e89'),(13,'redirect','2.0.0','1.0.5','unknown',NULL,'2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:21:31','d284dfcb-b1c2-4854-8d3e-be4e466b2e4b'),(14,'retcon','2.5.0','1.0.0','unknown',NULL,'2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:21:31','8fa5bf99-31b5-4598-8d89-444cd78cce2c'),(15,'seomatic','4.0.9','3.0.11','trial',NULL,'2022-10-05 22:18:45','2022-10-05 22:18:45','2022-10-05 22:21:31','e97afee4-a0af-40b1-bb9a-64783f165106'),(16,'sherlock','4.2.0','4.1.0','unknown',NULL,'2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:21:31','c6e031a6-3f70-4ef5-843d-2d2452b1f4bf'),(17,'sprig','2.2.0','1.0.1','unknown',NULL,'2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:21:31','5829813f-7a57-4866-b859-a1eb6f6aeaad'),(18,'super-table','3.0.1','3.0.0','unknown',NULL,'2022-10-05 22:18:47','2022-10-05 22:18:47','2022-10-05 22:21:31','c5146e59-7b43-4b49-a1b1-dd95683200b1'),(19,'twigpack','4.0.0-beta.4','1.0.0','unknown',NULL,'2022-10-05 22:18:51','2022-10-05 22:18:51','2022-10-05 22:21:31','88bb5070-a384-4a2d-97cc-cabbc025c460'),(20,'typedlinkfield','2.1.4','2.0.0','unknown',NULL,'2022-10-05 22:18:51','2022-10-05 22:18:51','2022-10-05 22:21:31','805a9495-ca9f-4acd-ae06-67dec8d22177'),(21,'typogrify','4.0.0','1.0.0','unknown',NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53','2022-10-05 22:21:31','7f097588-a730-4619-af8a-ba3fdc96f989');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
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
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `revisions` VALUES (1,1,NULL,1,NULL),(2,1,NULL,2,NULL),(3,4,NULL,1,NULL),(4,4,NULL,2,NULL),(5,7,NULL,1,NULL),(6,7,NULL,2,NULL),(7,1,NULL,3,NULL),(8,1,NULL,4,NULL),(9,4,NULL,3,NULL),(10,4,NULL,4,NULL),(11,7,NULL,3,NULL),(12,7,NULL,4,NULL),(13,17,16,1,''),(14,17,16,2,'Applied “Draft 1”');
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'field',6,2,''),(1,'slug',0,2,' alert message '),(1,'title',0,2,' alert message '),(4,'field',8,2,''),(4,'field',12,2,''),(4,'slug',0,2,' error 404 '),(4,'title',0,2,' error 404 '),(7,'field',8,2,''),(7,'field',12,2,''),(7,'slug',0,2,' search '),(7,'title',0,2,' search '),(16,'email',0,2,' steve simplicate ca '),(16,'firstname',0,2,''),(16,'fullname',0,2,''),(16,'lastname',0,2,''),(16,'slug',0,2,''),(16,'username',0,2,' steve simplicate ca '),(17,'field',2,2,''),(17,'field',4,2,''),(17,'field',6,2,''),(17,'field',8,2,''),(17,'slug',0,2,' home '),(17,'title',0,2,' home ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'News','news','channel',1,'all','end',NULL,'2022-10-05 22:19:07','2022-10-05 22:19:07',NULL,'3721b4d6-42d5-41fc-b6e7-76204b42c91a'),(2,NULL,'Alert Message','alertMessage','single',1,'all','end',NULL,'2022-10-05 22:19:07','2022-10-05 22:19:07',NULL,'7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c'),(3,NULL,'Error 404','error404','single',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'16422b2c-c780-4355-b3a5-44a1cc28ba36'),(4,NULL,'Search','search','single',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'4faab281-22d5-4b78-a310-d3f84c34aa67'),(5,NULL,'FAQs','faqs','channel',1,'all','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'a52e2b08-2e30-4b00-8784-4104c409d3ed'),(6,4,'Documentation','documentation','structure',1,'none','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'cd395274-64b5-4e73-aeb8-7e99e6d8148e'),(7,NULL,'Fragments','fragments','channel',1,'siteGroup','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'89093e20-515d-4e3c-b4c4-c6733d8ab56f'),(8,5,'Pages','pages','structure',1,'siteGroup','end','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'650e7d1d-63e5-42f9-b3ab-4febfb502723');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,2,1,'news/{slug}','_sections/news/_entry.twig',1,'2022-10-05 22:19:07','2022-10-05 22:19:07','25058131-c4ee-4b03-a927-6a4a4692b1bd'),(2,1,1,1,'news/{slug}','_sections/news/_entry.twig',1,'2022-10-05 22:19:07','2022-10-05 22:19:07','e79e067a-08ea-43f0-9c2b-68025d4503c3'),(3,2,2,0,NULL,NULL,1,'2022-10-05 22:19:07','2022-10-05 22:19:07','03e34da1-a8b5-4e88-be8d-7447aa261d77'),(4,3,2,0,NULL,NULL,1,'2022-10-05 22:19:08','2022-10-05 22:19:08','a717ff9d-58cb-4c60-9a10-4ce3aee8e8bd'),(5,4,2,1,'search','_sections/search.twig',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','648171fb-37ff-46f0-aaef-7d203b9dcc76'),(6,5,2,1,'faqs/{slug}','_sections/faqs/_entry.twig',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','a598a9db-8af9-47a2-a187-cf56240b03c9'),(7,5,1,1,'faqs/{slug}','_sections/faqs/_entry.twig',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','a4d1dc53-f57a-45f5-b395-78f090b8404c'),(8,6,1,1,'{parent.uri}/{slug}','_page',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','39725de5-e243-48ed-abe1-1cc48d769320'),(9,7,2,1,'fragments/{slug}','_sections/fragments/_entry.twig',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','99e25bef-e15a-4563-92ca-4d00bbbfa0ee'),(10,7,1,1,'fragments/{slug}','_sections/fragments/_entry.twig',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','bb7e1a9c-a948-45ed-b82e-8517b55b9d13'),(11,8,2,1,'{parent.uri}/{slug}','_page',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','6b93dd61-19d5-4d89-b0dc-58d08b5c683a'),(12,8,1,1,'{parent.uri}/{slug}','_page',1,'2022-10-05 22:19:08','2022-10-05 22:19:08','f16e7edd-c8cd-4c72-b8cb-2632ad040a72');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `seomatic_metabundles`
--

LOCK TABLES `seomatic_metabundles` WRITE;
/*!40000 ALTER TABLE `seomatic_metabundles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `seomatic_metabundles` VALUES (1,'2022-10-05 22:18:46','2022-10-05 22:18:46','3b4a9636-af9a-4c5d-9d51-0e4df03293fc','1.0.61','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',1,'[]','2022-10-05 22:18:46','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ seomatic.helper.safeCanonicalUrl() }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Wireframe Site\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoKeywords }}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoDescription }}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.referrer }}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.robots }}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{{ seomatic.meta.robots }}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookProfileId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookAppId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.siteName }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogType }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.canonicalUrl }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.ogSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogTitle }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImage }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterCard }}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{{ seomatic.site.twitterHandle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{{ seomatic.meta.twitterCreator }}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.twitterSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterTitle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImage }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.googleSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.bingSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.pinterestSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.meta.canonicalUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.site.googlePublisherLink }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Measurement/Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `G-XXXXXXXXXX` or `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"pinterestTag\":{\"name\":\"Pinterest Tag\",\"description\":\"The Pinterest tag allows you to track actions people take on your website after viewing your Promoted Pin. You can use this information to measure return on ad spend (RoAS) and create audiences to target on your Promoted Pins. [Learn More](https://help.pinterest.com/en/business/article/track-conversions-with-pinterest-tag)\",\"templatePath\":\"_frontend/scripts/pinterestTagHead.twig\",\"templateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n!function(e){if(!window.pintrk){window.pintrk=function(){window.pintrk.queue.push(\\nArray.prototype.slice.call(arguments))};var\\nn=window.pintrk;n.queue=[],n.version=\\\"3.0\\\";var\\nt=document.createElement(\\\"script\\\");t.async=!0,t.src=e;var\\nr=document.getElementsByTagName(\\\"script\\\")[0];r.parentNode.insertBefore(t,r)}}(\\\"{{ pinterestTagUrl.value }}\\\");\\npintrk(\'load\', \'{{ pinterestTagId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\npintrk(\'page\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/pinterestTagBody.twig\",\"bodyTemplateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ pinterestTagNoScriptUrl.value }}?tid={{ pinterestTagId.value }}&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"pinterestTagId\":{\"title\":\"Pinterest Tag ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.pinterest.com/docs/ad-tools/conversion-tag/)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Pinterest Tag PageView\",\"instructions\":\"Controls whether the Pinterest Tag script automatically sends a PageView to when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"pinterestTagUrl\":{\"title\":\"Pinterest Tag Script URL\",\"instructions\":\"The URL to the Pinterest Tag script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://s.pinimg.com/ct/core.js\"},\"pinterestTagNoScriptUrl\":{\"title\":\"Pinterest Tag Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Pinterest Tag `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://ct.pinterest.com/v3/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"pinterestTag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"{{ scriptUrl.value }}\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics (old)\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"issn\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":null,\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":null,\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":null,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":null,\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":null,\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":null,\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":{\"type\":\"EntryPoint\",\"urlTemplate\":\"{{ seomatic.site.siteLinksSearchTarget }}\"},\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"identity\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.identity.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.identity.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.identity.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.identity.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.identity.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.identity.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.identity.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.identity.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.identity.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.identity.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.identity.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.identity.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.identity.genericAlternateName }}\",\"name\":\"{{ seomatic.site.identity.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.identity.genericImage }}\",\"width\":\"{{ seomatic.site.identity.genericImageWidth }}\",\"height\":\"{{ seomatic.site.identity.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.identity.genericUrl }}\",\"description\":\"{{ seomatic.site.identity.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"creator\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.creator.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.creator.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.creator.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.creator.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.creator.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.creator.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.creator.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.creator.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.creator.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.creator.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.creator.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.creator.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.creator.genericAlternateName }}\",\"name\":\"{{ seomatic.site.creator.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.creator.genericImage }}\",\"width\":\"{{ seomatic.site.creator.genericImageWidth }}\",\"height\":\"{{ seomatic.site.creator.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.creator.genericUrl }}\",\"description\":\"{{ seomatic.site.creator.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ parseEnv(seomatic.site.creator.genericUrl ?? \\\"n/a\\\") }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 4, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ seomatic.helper.baseSiteUrl(\\\"/\\\") }},123,DIRECT\\n\",\"siteId\":null,\"include\":false,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"},\"security\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# security.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }} - more info: https://securitytxt.org/\\n\\n# (required) Contact email address for security issues\\nContact: mailto:user@example.com\\n\\n# (required) Expiration date for the security information herein\\nExpires: {{ date(\'+1 year\')|atom }}\\n\\n# (optional) OpenPGP key:\\nEncryption: {{ url(\'pgp-key.txt\') }}\\n\\n# (optional) Security policy page:\\nPolicy: {{ url(\'security-policy\') }}\\n\\n# (optional) Security acknowledgements page:\\nAcknowledgements: {{ url(\'hall-of-fame\') }}\\n\",\"siteId\":null,\"include\":false,\"handle\":\"security\",\"path\":\"security.txt\",\"template\":\"_frontend/pages/security.twig\",\"controller\":\"frontend-template\",\"action\":\"security\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(2,'2022-10-05 22:18:46','2022-10-05 22:18:46','cd150d5e-ded3-4e3d-9d14-2131e6c27c5c','1.0.61','__GLOBAL_BUNDLE__',1,'__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__','__GLOBAL_BUNDLE__',NULL,'',2,'[]','2022-10-05 22:18:46','{\"language\":null,\"mainEntityOfPage\":\"WebSite\",\"seoTitle\":\"\",\"siteNamePosition\":\"before\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ seomatic.helper.safeCanonicalUrl() }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"none\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"none\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Wireframe Site\",\"identity\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"creator\":{\"siteType\":\"Organization\",\"siteSubType\":\"LocalBusiness\",\"siteSpecificType\":\"\",\"computedType\":\"Organization\",\"genericName\":\"\",\"genericAlternateName\":\"\",\"genericDescription\":\"\",\"genericUrl\":\"\",\"genericImage\":\"\",\"genericImageWidth\":\"\",\"genericImageHeight\":\"\",\"genericImageIds\":[],\"genericTelephone\":\"\",\"genericEmail\":\"\",\"genericStreetAddress\":\"\",\"genericAddressLocality\":\"\",\"genericAddressRegion\":\"\",\"genericPostalCode\":\"\",\"genericAddressCountry\":\"\",\"genericGeoLatitude\":\"\",\"genericGeoLongitude\":\"\",\"personGender\":\"\",\"personBirthPlace\":\"\",\"organizationDuns\":\"\",\"organizationFounder\":\"\",\"organizationFoundingDate\":\"\",\"organizationFoundingLocation\":\"\",\"organizationContactPoints\":[],\"corporationTickerSymbol\":\"\",\"localBusinessPriceRange\":\"\",\"localBusinessOpeningHours\":[],\"restaurantServesCuisine\":\"\",\"restaurantMenuUrl\":\"\",\"restaurantReservationsUrl\":\"\"},\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":{\"twitter\":{\"siteName\":\"Twitter\",\"handle\":\"twitter\",\"url\":\"\"},\"facebook\":{\"siteName\":\"Facebook\",\"handle\":\"facebook\",\"url\":\"\"},\"wikipedia\":{\"siteName\":\"Wikipedia\",\"handle\":\"wikipedia\",\"url\":\"\"},\"linkedin\":{\"siteName\":\"LinkedIn\",\"handle\":\"linkedin\",\"url\":\"\"},\"googleplus\":{\"siteName\":\"Google+\",\"handle\":\"googleplus\",\"url\":\"\"},\"youtube\":{\"siteName\":\"YouTube\",\"handle\":\"youtube\",\"url\":\"\"},\"instagram\":{\"siteName\":\"Instagram\",\"handle\":\"instagram\",\"url\":\"\"},\"pinterest\":{\"siteName\":\"Pinterest\",\"handle\":\"pinterest\",\"url\":\"\"},\"github\":{\"siteName\":\"GitHub\",\"handle\":\"github\",\"url\":\"\"},\"vimeo\":{\"siteName\":\"Vimeo\",\"handle\":\"vimeo\",\"url\":\"\"}},\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":{\"generator\":{\"charset\":\"\",\"content\":\"SEOmatic\",\"httpEquiv\":\"\",\"name\":\"generator\",\"property\":null,\"include\":true,\"key\":\"generator\",\"environment\":null,\"dependencies\":{\"config\":[\"generatorEnabled\"]},\"tagAttrs\":[]},\"keywords\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoKeywords }}\",\"httpEquiv\":\"\",\"name\":\"keywords\",\"property\":null,\"include\":true,\"key\":\"keywords\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.seoDescription }}\",\"httpEquiv\":\"\",\"name\":\"description\",\"property\":null,\"include\":true,\"key\":\"description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"referrer\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.referrer }}\",\"httpEquiv\":\"\",\"name\":\"referrer\",\"property\":null,\"include\":true,\"key\":\"referrer\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"robots\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.robots }}\",\"httpEquiv\":\"\",\"name\":\"robots\",\"property\":null,\"include\":true,\"key\":\"robots\",\"environment\":{\"live\":{\"content\":\"{{ seomatic.meta.robots }}\"},\"staging\":{\"content\":\"none\"},\"local\":{\"content\":\"none\"}},\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":{\"fb:profile_id\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookProfileId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:profile_id\",\"include\":true,\"key\":\"fb:profile_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"fb:app_id\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookAppId }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"fb:app_id\",\"include\":true,\"key\":\"fb:app_id\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale\":{\"charset\":\"\",\"content\":\"{{ craft.app.language |replace({\\\"-\\\": \\\"_\\\"}) }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale\",\"include\":true,\"key\":\"og:locale\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:locale:alternate\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:locale:alternate\",\"include\":true,\"key\":\"og:locale:alternate\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:site_name\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.siteName }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:site_name\",\"include\":true,\"key\":\"og:site_name\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:type\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogType }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:type\",\"include\":true,\"key\":\"og:type\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:url\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.canonicalUrl }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:url\",\"include\":true,\"key\":\"og:url\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:title\":{\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.ogSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogTitle }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:title\",\"include\":true,\"key\":\"og:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:description\",\"include\":true,\"key\":\"og:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImage }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image\",\"include\":true,\"key\":\"og:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"og:image:width\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:width\",\"include\":true,\"key\":\"og:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:height\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:height\",\"include\":true,\"key\":\"og:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:image:alt\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.ogImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:image:alt\",\"include\":true,\"key\":\"og:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"og:image\"]},\"tagAttrs\":[]},\"og:see_also\":{\"charset\":\"\",\"content\":\"\",\"httpEquiv\":\"\",\"name\":\"\",\"property\":\"og:see_also\",\"include\":true,\"key\":\"og:see_also\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"facebook-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.facebookSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"facebook-domain-verification\",\"property\":null,\"include\":true,\"key\":\"facebook-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"facebookSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":{\"twitter:card\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterCard }}\",\"httpEquiv\":\"\",\"name\":\"twitter:card\",\"property\":null,\"include\":true,\"key\":\"twitter:card\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:site\":{\"charset\":\"\",\"content\":\"@{{ seomatic.site.twitterHandle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:site\",\"property\":null,\"include\":true,\"key\":\"twitter:site\",\"environment\":null,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"tagAttrs\":[]},\"twitter:creator\":{\"charset\":\"\",\"content\":\"@{{ seomatic.meta.twitterCreator }}\",\"httpEquiv\":\"\",\"name\":\"twitter:creator\",\"property\":null,\"include\":true,\"key\":\"twitter:creator\",\"environment\":null,\"dependencies\":{\"meta\":[\"twitterCreator\"]},\"tagAttrs\":[]},\"twitter:title\":{\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.twitterSiteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterTitle }}\",\"httpEquiv\":\"\",\"name\":\"twitter:title\",\"property\":null,\"include\":true,\"key\":\"twitter:title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:description\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:description\",\"property\":null,\"include\":true,\"key\":\"twitter:description\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImage }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image\",\"property\":null,\"include\":true,\"key\":\"twitter:image\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"twitter:image:width\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageWidth }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:width\",\"property\":null,\"include\":true,\"key\":\"twitter:image:width\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:height\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageHeight }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:height\",\"property\":null,\"include\":true,\"key\":\"twitter:image:height\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]},\"twitter:image:alt\":{\"charset\":\"\",\"content\":\"{{ seomatic.meta.twitterImageDescription }}\",\"httpEquiv\":\"\",\"name\":\"twitter:image:alt\",\"property\":null,\"include\":true,\"key\":\"twitter:image:alt\",\"environment\":null,\"dependencies\":{\"tag\":[\"twitter:image\"]},\"tagAttrs\":[]}},\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":{\"site\":[\"twitterHandle\"]},\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":{\"google-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.googleSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"google-site-verification\",\"property\":null,\"include\":true,\"key\":\"google-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"googleSiteVerification\"]},\"tagAttrs\":[]},\"bing-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.bingSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"msvalidate.01\",\"property\":null,\"include\":true,\"key\":\"bing-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"bingSiteVerification\"]},\"tagAttrs\":[]},\"pinterest-site-verification\":{\"charset\":\"\",\"content\":\"{{ seomatic.site.pinterestSiteVerification }}\",\"httpEquiv\":\"\",\"name\":\"p:domain_verify\",\"property\":null,\"include\":true,\"key\":\"pinterest-site-verification\",\"environment\":null,\"dependencies\":{\"site\":[\"pinterestSiteVerification\"]},\"tagAttrs\":[]}},\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":{\"canonical\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.meta.canonicalUrl }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"canonical\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"canonical\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"home\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"home\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"home\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]},\"author\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.helper.siteUrl(\\\"/humans.txt\\\") }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"author\",\"sizes\":\"\",\"type\":\"text/plain\",\"include\":true,\"key\":\"author\",\"environment\":null,\"dependencies\":{\"frontend_template\":[\"humans\"]},\"tagAttrs\":[]},\"publisher\":{\"crossorigin\":\"\",\"href\":\"{{ seomatic.site.googlePublisherLink }}\",\"hreflang\":\"\",\"media\":\"\",\"rel\":\"publisher\",\"sizes\":\"\",\"type\":\"\",\"include\":true,\"key\":\"publisher\",\"environment\":null,\"dependencies\":{\"site\":[\"googlePublisherLink\"]},\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":{\"gtag\":{\"name\":\"Google gtag.js\",\"description\":\"The global site tag (gtag.js) is a JavaScript tagging framework and API that allows you to send event data to AdWords, DoubleClick, and Google Analytics. Instead of having to manage multiple tags for different products, you can use gtag.js and more easily benefit from the latest tracking features and integrations as they become available. [Learn More](https://developers.google.com/gtagjs/)\",\"templatePath\":\"_frontend/scripts/gtagHead.twig\",\"templateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\nwindow.dataLayer = window.dataLayer || [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\nfunction gtag(){dataLayer.push(arguments)};\\ngtag(\'js\', new Date());\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if googleAnalyticsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'anonymize_ip\': #{ipAnonymization.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'link_attribution\': #{enhancedLinkAttribution.value ? \'true\' : \'false\'},\\\"\\n    ~ \\\"\'allow_display_features\': #{displayFeatures.value ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAnalyticsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if googleAdWordsId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ googleAdWordsId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% if dcFloodlightId.value %}\\n{%- set gtagConfig = \\\"{\\\"\\n    ~ \\\"\'send_page_view\': #{pageView ? \'true\' : \'false\'}\\\"\\n    ~ \\\"}\\\"\\n-%}\\ngtag(\'config\', \'{{ dcFloodlightId.value }}\', {{ gtagConfig }});\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/gtagBody.twig\",\"bodyTemplateString\":\"{% set gtagProperty = googleAnalyticsId.value ??? googleAdWordsId.value ??? dcFloodlightId.value ??? null %}\\n{% if gtagProperty %}\\n<script async src=\\\"{{ gtagScriptUrl.value }}?id={{ gtagProperty }}\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleAnalyticsId\":{\"title\":\"Google Analytics Measurement/Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `G-XXXXXXXXXX` or `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"googleAdWordsId\":{\"title\":\"AdWords Conversion ID\",\"instructions\":\"Only enter the ID, e.g.: `AW-XXXXXXXX`, not the entire script code. [Learn More](https://developers.google.com/adwords-remarketing-tag/)\",\"type\":\"string\",\"value\":\"\"},\"dcFloodlightId\":{\"title\":\"DoubleClick Floodlight ID\",\"instructions\":\"Only enter the ID, e.g.: `DC-XXXXXXXX`, not the entire script code. [Learn More](https://support.google.com/dcm/partner/answer/7568534)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send PageView\",\"instructions\":\"Controls whether the `gtag.js` script automatically sends a PageView to Google Analytics, AdWords, and DoubleClick Floodlight when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"In some cases, you might need to anonymize the IP addresses of hits sent to Google Analytics. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/ip-anonymization)\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Google Analytics Display Features\",\"instructions\":\"The display features plugin for gtag.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/display-features)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Google Analytics Enhanced Link Attribution\",\"instructions\":\"Enhanced link attribution improves click track reporting by automatically differentiating between multiple link clicks that have the same URL on a given page. [Learn More](https://developers.google.com/analytics/devguides/collection/gtagjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"gtagScriptUrl\":{\"title\":\"Google gtag.js Script URL\",\"instructions\":\"The URL to the Google gtag.js tracking script. Normally this should not be changed, unless you locally cache it. The JavaScript `dataLayer` will automatically be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtag/js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"gtag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleTagManager\":{\"name\":\"Google Tag Manager\",\"description\":\"Google Tag Manager is a tag management system that allows you to quickly and easily update tags and code snippets on your website. Once the Tag Manager snippet has been added to your website or mobile app, you can configure tags via a web-based user interface without having to alter and deploy additional code. [Learn More](https://support.google.com/tagmanager/answer/6102821?hl=en)\",\"templatePath\":\"_frontend/scripts/googleTagManagerHead.twig\",\"templateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n{{ dataLayerVariableName.value }} = [{% if dataLayer is defined and dataLayer %}{{ dataLayer |json_encode() |raw }}{% endif %}];\\n(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({\'gtm.start\':\\nnew Date().getTime(),event:\'gtm.js\'});var f=d.getElementsByTagName(s)[0],\\nj=d.createElement(s),dl=l!=\'dataLayer\'?\'&l=\'+l:\'\';j.async=true;j.src=\\n\'{{ googleTagManagerUrl.value }}?id=\'+i+dl;f.parentNode.insertBefore(j,f);\\n})(window,document,\'script\',\'{{ dataLayerVariableName.value }}\',\'{{ googleTagManagerId.value }}\');\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/googleTagManagerBody.twig\",\"bodyTemplateString\":\"{% if googleTagManagerId.value is defined and googleTagManagerId.value and not seomatic.helper.isPreview %}\\n<noscript><iframe src=\\\"{{ googleTagManagerNoScriptUrl.value }}?id={{ googleTagManagerId.value }}\\\"\\nheight=\\\"0\\\" width=\\\"0\\\" style=\\\"display:none;visibility:hidden\\\"></iframe></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"googleTagManagerId\":{\"title\":\"Google Tag Manager ID\",\"instructions\":\"Only enter the ID, e.g.: `GTM-XXXXXX`, not the entire script code. [Learn More](https://developers.google.com/tag-manager/quickstart)\",\"type\":\"string\",\"value\":\"\"},\"dataLayerVariableName\":{\"title\":\"DataLayer Variable Name\",\"instructions\":\"The name to use for the JavaScript DataLayer variable. The value of this variable will be set to the `dataLayer` Twig template variable.\",\"type\":\"string\",\"value\":\"dataLayer\"},\"googleTagManagerUrl\":{\"title\":\"Google Tag Manager Script URL\",\"instructions\":\"The URL to the Google Tag Manager script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/gtm.js\"},\"googleTagManagerNoScriptUrl\":{\"title\":\"Google Tag Manager Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Google Tag Manager `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.googletagmanager.com/ns.html\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleTagManager\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"facebookPixel\":{\"name\":\"Facebook Pixel\",\"description\":\"The Facebook pixel is an analytics tool that helps you measure the effectiveness of your advertising. You can use the Facebook pixel to understand the actions people are taking on your website and reach audiences you care about. [Learn More](https://www.facebook.com/business/help/651294705016616)\",\"templatePath\":\"_frontend/scripts/facebookPixelHead.twig\",\"templateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\\nn.push=n;n.loaded=!0;n.version=\'2.0\';n.queue=[];t=b.createElement(e);t.async=!0;\\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\\ndocument,\'script\',\'{{ facebookPixelUrl.value }}\');\\nfbq(\'init\', \'{{ facebookPixelId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nfbq(\'track\', \'PageView\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/facebookPixelBody.twig\",\"bodyTemplateString\":\"{% if facebookPixelId.value is defined and facebookPixelId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none\\\"\\nsrc=\\\"{{ facebookPixelNoScriptUrl.value }}?id={{ facebookPixelId.value }}&ev=PageView&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"facebookPixelId\":{\"title\":\"Facebook Pixel ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.facebook.com/docs/facebook-pixel/api-reference)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Facebook Pixel PageView\",\"instructions\":\"Controls whether the Facebook Pixel script automatically sends a PageView to Facebook Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"facebookPixelUrl\":{\"title\":\"Facebook Pixel Script URL\",\"instructions\":\"The URL to the Facebook Pixel script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://connect.facebook.net/en_US/fbevents.js\"},\"facebookPixelNoScriptUrl\":{\"title\":\"Facebook Pixel Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Facebook Pixel `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.facebook.com/tr\"}},\"dataLayer\":[],\"include\":false,\"key\":\"facebookPixel\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"linkedInInsight\":{\"name\":\"LinkedIn Insight\",\"description\":\"The LinkedIn Insight Tag is a lightweight JavaScript tag that powers conversion tracking, retargeting, and web analytics for LinkedIn ad campaigns.\",\"templatePath\":\"_frontend/scripts/linkedInInsightHead.twig\",\"templateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n_linkedin_data_partner_id = \\\"{{ dataPartnerId.value }}\\\";\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/linkedInInsightBody.twig\",\"bodyTemplateString\":\"{% if dataPartnerId.value is defined and dataPartnerId.value %}\\n<script type=\\\"text/javascript\\\">\\n(function(){var s = document.getElementsByTagName(\\\"script\\\")[0];\\n    var b = document.createElement(\\\"script\\\");\\n    b.type = \\\"text/javascript\\\";b.async = true;\\n    b.src = \\\"{{ linkedInInsightUrl.value }}\\\";\\n    s.parentNode.insertBefore(b, s);})();\\n</script>\\n<noscript>\\n<img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ linkedInInsightNoScriptUrl.value }}?pid={{ dataPartnerId.value }}&fmt=gif\\\" />\\n</noscript>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"dataPartnerId\":{\"title\":\"LinkedIn Data Partner ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://www.linkedin.com/help/lms/answer/65513/adding-the-linkedin-insight-tag-to-your-website?lang=en)\",\"type\":\"string\",\"value\":\"\"},\"linkedInInsightUrl\":{\"title\":\"LinkedIn Insight Script URL\",\"instructions\":\"The URL to the LinkedIn Insight script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://snap.licdn.com/li.lms-analytics/insight.min.js\"},\"linkedInInsightNoScriptUrl\":{\"title\":\"LinkedIn Insight &lt;noscript&gt; URL\",\"instructions\":\"The URL to the LinkedIn Insight `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://dc.ads.linkedin.com/collect/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"linkedInInsight\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"hubSpot\":{\"name\":\"HubSpot\",\"description\":\"If you\'re not hosting your entire website on HubSpot, or have pages on your website that are not hosted on HubSpot, you\'ll need to install the HubSpot tracking code on your non-HubSpot pages in order to capture those analytics.\",\"templatePath\":null,\"templateString\":null,\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/hubSpotBody.twig\",\"bodyTemplateString\":\"{% if hubSpotId.value is defined and hubSpotId.value %}\\n<script type=\\\"text/javascript\\\" id=\\\"hs-script-loader\\\" async defer src=\\\"{{ hubSpotUrl.value }}{{ hubSpotId.value }}.js\\\"></script>\\n{% endif %}\\n\",\"bodyPosition\":3,\"vars\":{\"hubSpotId\":{\"title\":\"HubSpot ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://knowledge.hubspot.com/articles/kcs_article/reports/install-the-hubspot-tracking-code)\",\"type\":\"string\",\"value\":\"\"},\"hubSpotUrl\":{\"title\":\"HubSpot Script URL\",\"instructions\":\"The URL to the HubSpot script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"//js.hs-scripts.com/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"hubSpot\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"pinterestTag\":{\"name\":\"Pinterest Tag\",\"description\":\"The Pinterest tag allows you to track actions people take on your website after viewing your Promoted Pin. You can use this information to measure return on ad spend (RoAS) and create audiences to target on your Promoted Pins. [Learn More](https://help.pinterest.com/en/business/article/track-conversions-with-pinterest-tag)\",\"templatePath\":\"_frontend/scripts/pinterestTagHead.twig\",\"templateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n!function(e){if(!window.pintrk){window.pintrk=function(){window.pintrk.queue.push(\\nArray.prototype.slice.call(arguments))};var\\nn=window.pintrk;n.queue=[],n.version=\\\"3.0\\\";var\\nt=document.createElement(\\\"script\\\");t.async=!0,t.src=e;var\\nr=document.getElementsByTagName(\\\"script\\\")[0];r.parentNode.insertBefore(t,r)}}(\\\"{{ pinterestTagUrl.value }}\\\");\\npintrk(\'load\', \'{{ pinterestTagId.value }}\');\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\npintrk(\'page\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":\"_frontend/scripts/pinterestTagBody.twig\",\"bodyTemplateString\":\"{% if pinterestTagId.value is defined and pinterestTagId.value %}\\n<noscript><img height=\\\"1\\\" width=\\\"1\\\" style=\\\"display:none;\\\" alt=\\\"\\\" src=\\\"{{ pinterestTagNoScriptUrl.value }}?tid={{ pinterestTagId.value }}&noscript=1\\\" /></noscript>\\n{% endif %}\\n\",\"bodyPosition\":2,\"vars\":{\"pinterestTagId\":{\"title\":\"Pinterest Tag ID\",\"instructions\":\"Only enter the ID, e.g.: `XXXXXXXXXX`, not the entire script code. [Learn More](https://developers.pinterest.com/docs/ad-tools/conversion-tag/)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Pinterest Tag PageView\",\"instructions\":\"Controls whether the Pinterest Tag script automatically sends a PageView to when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"pinterestTagUrl\":{\"title\":\"Pinterest Tag Script URL\",\"instructions\":\"The URL to the Pinterest Tag script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://s.pinimg.com/ct/core.js\"},\"pinterestTagNoScriptUrl\":{\"title\":\"Pinterest Tag Script &lt;noscript&gt; URL\",\"instructions\":\"The URL to the Pinterest Tag `&lt;noscript&gt;`. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://ct.pinterest.com/v3/\"}},\"dataLayer\":[],\"include\":false,\"key\":\"pinterestTag\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"fathom\":{\"name\":\"Fathom\",\"description\":\"Fathom is a simple, light-weight, privacy-first alternative to Google Analytics. So, stop scrolling through pages of reports and collecting gobs of personal data about your visitors, both of which you probably don’t need. [Learn More](https://usefathom.com/)\",\"templatePath\":\"_frontend/scripts/fathomAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-site\\\", \\\"{{ siteId.value | raw }}\\\");\\n{% if honorDnt.value %}\\ntag.setAttribute(\\\"data-honor-dnt\\\", \\\"true\\\");\\n{% endif %}\\n{% if disableAutoTracking.value %}\\ntag.setAttribute(\\\"data-auto\\\", \\\"false\\\");\\n{% endif %}\\n{% if ignoreCanonicals.value %}\\ntag.setAttribute(\\\"data-canonical\\\", \\\"false\\\");\\n{% endif %}\\n{% if excludedDomains.value | length %}\\ntag.setAttribute(\\\"data-excluded-domains\\\", \\\"{{ excludedDomains.value | raw }}\\\");\\n{% endif %}\\n{% if includedDomains.value | length %}\\ntag.setAttribute(\\\"data-included-domains\\\", \\\"{{ includedDomains.value | raw }}\\\");\\n{% endif %}\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://usefathom.com/support/tracking)\",\"type\":\"string\",\"value\":\"\"},\"honorDnt\":{\"title\":\"Honoring Do Not Track (DNT)\",\"instructions\":\"By default we track every visitor to your website, regardless of them having DNT turned on or not. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"disableAutoTracking\":{\"title\":\"Disable automatic tracking\",\"instructions\":\"By default, we track a page view every time a visitor to your website loads a page with our script on it. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"ignoreCanonicals\":{\"title\":\"Ignore canonicals\",\"instructions\":\"If there’s a canonical URL in place, then by default we use it instead of the current URL. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"bool\",\"value\":false},\"excludedDomains\":{\"title\":\"Excluded Domains\",\"instructions\":\"You exclude one or several domains, so our tracker will track things on every domain, except the ones excluded. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"includedDomains\":{\"title\":\"Included Domains\",\"instructions\":\"If you want to go in the opposite direction and only track stats on a specific domain. [Learn More](https://usefathom.com/support/tracking-advanced)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Fathom Script URL\",\"instructions\":\"The URL to the Fathom tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://cdn.usefathom.com/script.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"fathom\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"matomo\":{\"name\":\"Matomo\",\"description\":\"Matomo is a Google Analytics alternative that protects your data and your customers\' privacy [Learn More](https://matomo.org/)\",\"templatePath\":\"_frontend/scripts/matomoAnalytics.twig\",\"templateString\":\"{% if siteId.value is defined and siteId.value and scriptUrl.value is defined and scriptUrl.value | length %}\\nvar _paq = window._paq = window._paq || [];\\n{% if sendPageView.value %}\\n_paq.push([\'trackPageView\']);\\n{% endif %}\\n{% if sendPageView.value %}\\n_paq.push([\'enableLinkTracking\']);\\n{% endif %}\\n(function() {\\nvar u=\\\"{{ scriptUrl.value }}\\\";\\n_paq.push([\'setTrackerUrl\', u+\'matomo.php\']);\\n_paq.push([\'setSiteId\', {{ siteId.value }}]);\\nvar d=document, g=d.createElement(\'script\'), s=d.getElementsByTagName(\'script\')[0];\\ng.type=\'text/javascript\'; g.async=true; g.src=u+\'matomo.js\'; s.parentNode.insertBefore(g,s);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteId\":{\"title\":\"Site ID\",\"instructions\":\"Only enter the Site ID, not the entire script code. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Matomo PageView\",\"instructions\":\"Controls whether the Matomo script automatically sends a PageView when your pages are loaded. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"enableLinkTracking\":{\"title\":\"Enable Link Tracking\",\"instructions\":\"Install link tracking on all applicable link elements. [Learn More](https://developer.matomo.org/api-reference/tracking-javascript)\",\"type\":\"bool\",\"value\":true},\"scriptUrl\":{\"title\":\"Matomo Script URL\",\"instructions\":\"The URL to the Matomo tracking script. This will vary depending on whether you are using Matomo Cloud or Matomo On-Premise. [Learn More](https://developer.matomo.org/guides/tracking-javascript-guide)\",\"type\":\"string\",\"value\":\"\"}},\"dataLayer\":[],\"include\":false,\"key\":\"matomo\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"plausible\":{\"name\":\"Plausible\",\"description\":\"Plausible is a lightweight and open-source website analytics tool. No cookies and fully compliant with GDPR, CCPA and PECR. [Learn More](https://plausible.io/)\",\"templatePath\":\"_frontend/scripts/plausibleAnalytics.twig\",\"templateString\":\"{% if siteDomain.value is defined and siteDomain.value %}\\n(function() {\\nvar tag = document.createElement(\'script\');\\ntag.src = \\\"{{ scriptUrl.value }}\\\";\\ntag.defer = true;\\ntag.setAttribute(\\\"data-domain\\\", \\\"{{ siteDomain.value | raw }}\\\");\\nvar firstScriptTag = document.getElementsByTagName(\'script\')[0];\\nfirstScriptTag.parentNode.insertBefore(tag, firstScriptTag);\\n})();\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"siteDomain\":{\"title\":\"Site Domain\",\"instructions\":\"Only enter the site domain, not the entire script code. [Learn More](https://plausible.io/docs/plausible-script)\",\"type\":\"string\",\"value\":\"\"},\"scriptUrl\":{\"title\":\"Plausible Script URL\",\"instructions\":\"The URL to the Plausible tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://plausible.io/js/plausible.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"plausible\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null},\"googleAnalytics\":{\"name\":\"Google Analytics (old)\",\"description\":\"Google Analytics gives you the digital analytics tools you need to analyze data from all touchpoints in one place, for a deeper understanding of the customer experience. You can then share the insights that matter with your whole organization. [Learn More](https://www.google.com/analytics/analytics/)\",\"templatePath\":\"_frontend/scripts/googleAnalytics.twig\",\"templateString\":\"{% if trackingId.value is defined and trackingId.value %}\\n(function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\\n(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\\nm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\\n})(window,document,\'script\',\'{{ analyticsUrl.value }}\',\'ga\');\\nga(\'create\', \'{{ trackingId.value |raw }}\', \'auto\'{% if linker.value %}, {allowLinker: true}{% endif %});\\n{% if ipAnonymization.value %}\\nga(\'set\', \'anonymizeIp\', true);\\n{% endif %}\\n{% if displayFeatures.value %}\\nga(\'require\', \'displayfeatures\');\\n{% endif %}\\n{% if ecommerce.value %}\\nga(\'require\', \'ecommerce\');\\n{% endif %}\\n{% if enhancedEcommerce.value %}\\nga(\'require\', \'ec\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linkid\');\\n{% endif %}\\n{% if enhancedLinkAttribution.value %}\\nga(\'require\', \'linker\');\\n{% endif %}\\n{% set pageView = (sendPageView.value and not seomatic.helper.isPreview) %}\\n{% if pageView %}\\nga(\'send\', \'pageview\');\\n{% endif %}\\n{% endif %}\\n\",\"position\":1,\"bodyTemplatePath\":null,\"bodyTemplateString\":null,\"bodyPosition\":2,\"vars\":{\"trackingId\":{\"title\":\"Google Analytics Tracking ID\",\"instructions\":\"Only enter the ID, e.g.: `UA-XXXXXX-XX`, not the entire script code. [Learn More](https://support.google.com/analytics/answer/1032385?hl=e)\",\"type\":\"string\",\"value\":\"\"},\"sendPageView\":{\"title\":\"Automatically send Google Analytics PageView\",\"instructions\":\"Controls whether the Google Analytics script automatically sends a PageView to Google Analytics when your pages are loaded.\",\"type\":\"bool\",\"value\":true},\"ipAnonymization\":{\"title\":\"Google Analytics IP Anonymization\",\"instructions\":\"When a customer of Analytics requests IP address anonymization, Analytics anonymizes the address as soon as technically feasible at the earliest possible stage of the collection network.\",\"type\":\"bool\",\"value\":false},\"displayFeatures\":{\"title\":\"Display Features\",\"instructions\":\"The display features plugin for analytics.js can be used to enable Advertising Features in Google Analytics, such as Remarketing, Demographics and Interest Reporting, and more. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/display-features)\",\"type\":\"bool\",\"value\":false},\"ecommerce\":{\"title\":\"Ecommerce\",\"instructions\":\"Ecommerce tracking allows you to measure the number of transactions and revenue that your website generates. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedEcommerce\":{\"title\":\"Enhanced Ecommerce\",\"instructions\":\"The enhanced ecommerce plug-in for analytics.js enables the measurement of user interactions with products on ecommerce websites across the user\'s shopping experience, including: product impressions, product clicks, viewing product details, adding a product to a shopping cart, initiating the checkout process, transactions, and refunds. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)\",\"type\":\"bool\",\"value\":false},\"enhancedLinkAttribution\":{\"title\":\"Enhanced Link Attribution\",\"instructions\":\"Enhanced Link Attribution improves the accuracy of your In-Page Analytics report by automatically differentiating between multiple links to the same URL on a single page by using link element IDs. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-link-attribution)\",\"type\":\"bool\",\"value\":false},\"linker\":{\"title\":\"Linker\",\"instructions\":\"The linker plugin simplifies the process of implementing cross-domain tracking as described in the Cross-domain Tracking guide for analytics.js. [Learn More](https://developers.google.com/analytics/devguides/collection/analyticsjs/linker)\",\"type\":\"bool\",\"value\":false},\"analyticsUrl\":{\"title\":\"Google Analytics Script URL\",\"instructions\":\"The URL to the Google Analytics tracking script. Normally this should not be changed, unless you locally cache it.\",\"type\":\"string\",\"value\":\"https://www.google-analytics.com/analytics.js\"}},\"dataLayer\":[],\"include\":false,\"key\":\"googleAnalytics\",\"environment\":{\"staging\":{\"include\":false},\"local\":{\"include\":false}},\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null}},\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"issn\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":null,\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":null,\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":null,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":null,\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":null,\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":null,\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":{\"type\":\"EntryPoint\",\"urlTemplate\":\"{{ seomatic.site.siteLinksSearchTarget }}\"},\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"identity\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.identity.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\",\"graph\":null,\"include\":true,\"key\":\"identity\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.identity.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.identity.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.identity.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.identity.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.identity.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.identity.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.identity.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.identity.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.identity.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.identity.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.identity.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.identity.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.identity.genericAlternateName }}\",\"name\":\"{{ seomatic.site.identity.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.identity.genericImage }}\",\"width\":\"{{ seomatic.site.identity.genericImageWidth }}\",\"height\":\"{{ seomatic.site.identity.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.identity.genericUrl }}\",\"description\":\"{{ seomatic.site.identity.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null},\"creator\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.site.creator.computedType }}\",\"id\":\"{{ parseEnv(seomatic.site.creator.genericUrl) }}#creator\",\"graph\":null,\"include\":true,\"key\":\"creator\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"ownershipFundingInfo\":null,\"hasCredential\":null,\"founders\":null,\"telephone\":\"{{ seomatic.site.creator.genericTelephone }}\",\"review\":null,\"knowsAbout\":null,\"award\":null,\"member\":null,\"employee\":null,\"dissolutionDate\":null,\"funding\":null,\"vatID\":null,\"globalLocationNumber\":null,\"keywords\":null,\"contactPoints\":[],\"subOrganization\":null,\"awards\":null,\"numberOfEmployees\":null,\"funder\":null,\"makesOffer\":null,\"legalName\":null,\"correctionsPolicy\":null,\"aggregateRating\":null,\"interactionStatistic\":null,\"location\":null,\"address\":{\"type\":\"PostalAddress\",\"streetAddress\":\"{{ seomatic.site.creator.genericStreetAddress }}\",\"addressLocality\":\"{{ seomatic.site.creator.genericAddressLocality }}\",\"addressRegion\":\"{{ seomatic.site.creator.genericAddressRegion }}\",\"postalCode\":\"{{ seomatic.site.creator.genericPostalCode }}\",\"addressCountry\":\"{{ seomatic.site.creator.genericAddressCountry }}\"},\"memberOf\":null,\"publishingPrinciples\":null,\"diversityStaffingReport\":null,\"diversityPolicy\":null,\"email\":\"{{ seomatic.site.creator.genericEmail }}\",\"employees\":null,\"nonprofitStatus\":null,\"slogan\":null,\"ethicsPolicy\":null,\"brand\":null,\"sponsor\":null,\"logo\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.helper.socialTransform(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"width\":\"{{ seomatic.helper.socialTransformWidth(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\",\"height\":\"{{ seomatic.helper.socialTransformHeight(seomatic.site.creator.genericImageIds[0], \\\"schema-logo\\\") }}\"},\"actionableFeedbackPolicy\":null,\"naics\":null,\"contactPoint\":null,\"serviceArea\":null,\"isicV4\":null,\"hasMerchantReturnPolicy\":null,\"hasPOS\":null,\"founder\":\"{{ seomatic.site.creator.organizationFounder }}\",\"unnamedSourcesPolicy\":null,\"foundingLocation\":\"{{ seomatic.site.creator.organizationFoundingLocation }}\",\"duns\":\"{{ seomatic.site.creator.organizationDuns }}\",\"parentOrganization\":null,\"alumni\":null,\"leiCode\":null,\"areaServed\":null,\"foundingDate\":\"{{ seomatic.site.creator.organizationFoundingDate }}\",\"knowsLanguage\":null,\"reviews\":null,\"seeks\":null,\"taxID\":null,\"owns\":null,\"hasOfferCatalog\":null,\"members\":null,\"events\":null,\"iso6523Code\":null,\"department\":null,\"faxNumber\":null,\"event\":null,\"mainEntityOfPage\":null,\"alternateName\":\"{{ seomatic.site.creator.genericAlternateName }}\",\"name\":\"{{ seomatic.site.creator.genericName }}\",\"potentialAction\":null,\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.site.creator.genericImage }}\",\"width\":\"{{ seomatic.site.creator.genericImageWidth }}\",\"height\":\"{{ seomatic.site.creator.genericImageHeight }}\"},\"url\":\"{{ seomatic.site.creator.genericUrl }}\",\"description\":\"{{ seomatic.site.creator.genericDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":{\"humans\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"/* TEAM */\\n\\nCreator: {{ seomatic.site.creator.genericName ?? \\\"n/a\\\" }}\\nURL: {{ parseEnv(seomatic.site.creator.genericUrl ?? \\\"n/a\\\") }}\\nDescription: {{ seomatic.site.creator.genericDescription ?? \\\"n/a\\\" }}\\n\\n/* THANKS */\\n\\nCraft CMS - https://craftcms.com\\nPixel & Tonic - https://pixelandtonic.com\\n\\n/* SITE */\\n\\nStandards: HTML5, CSS3\\nComponents: Craft CMS 4, Yii2, PHP, JavaScript, SEOmatic\\n\",\"siteId\":null,\"include\":true,\"handle\":\"humans\",\"path\":\"humans.txt\",\"template\":\"_frontend/pages/humans.twig\",\"controller\":\"frontend-template\",\"action\":\"humans\"},\"robots\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# robots.txt for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n\\n{{ seomatic.helper.sitemapIndex() }}\\n{% switch seomatic.config.environment %}\\n\\n{% case \\\"live\\\" %}\\n\\n# live - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% case \\\"staging\\\" %}\\n\\n# staging - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% case \\\"local\\\" %}\\n\\n# local - disallow all\\n\\nUser-agent: *\\nDisallow: /\\n\\n{% default %}\\n\\n# default - don\'t allow web crawlers to index cpresources/ or vendor/\\n\\nUser-agent: *\\nDisallow: /cpresources/\\nDisallow: /vendor/\\nDisallow: /.env\\nDisallow: /cache/\\n\\n{% endswitch %}\\n\",\"siteId\":null,\"include\":true,\"handle\":\"robots\",\"path\":\"robots.txt\",\"template\":\"_frontend/pages/robots.twig\",\"controller\":\"frontend-template\",\"action\":\"robots\"},\"ads\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# ads.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }}\\n# More info: https://support.google.com/admanager/answer/7441288?hl=en\\n{{ seomatic.helper.baseSiteUrl(\\\"/\\\") }},123,DIRECT\\n\",\"siteId\":null,\"include\":false,\"handle\":\"ads\",\"path\":\"ads.txt\",\"template\":\"_frontend/pages/ads.twig\",\"controller\":\"frontend-template\",\"action\":\"ads\"},\"security\":{\"templateVersion\":\"1.0.0\",\"templateString\":\"# security.txt file for {{ seomatic.helper.baseSiteUrl(\\\"/\\\") }} - more info: https://securitytxt.org/\\n\\n# (required) Contact email address for security issues\\nContact: mailto:user@example.com\\n\\n# (required) Expiration date for the security information herein\\nExpires: {{ date(\'+1 year\')|atom }}\\n\\n# (optional) OpenPGP key:\\nEncryption: {{ url(\'pgp-key.txt\') }}\\n\\n# (optional) Security policy page:\\nPolicy: {{ url(\'security-policy\') }}\\n\\n# (optional) Security acknowledgements page:\\nAcknowledgements: {{ url(\'hall-of-fame\') }}\\n\",\"siteId\":null,\"include\":false,\"handle\":\"security\",\"path\":\"security.txt\",\"template\":\"_frontend/pages/security.twig\",\"controller\":\"frontend-template\",\"action\":\"security\"}},\"name\":\"Frontend Templates\",\"description\":\"Templates that are rendered on the frontend\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":\"SeomaticEditableTemplate\",\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}'),(3,'2022-10-05 22:22:42','2022-10-05 22:23:58','5f151646-2c12-46af-999f-8b587b01b454','1.0.30','section',8,'Pages','pages','structure',NULL,'_page',2,'{\"2\":{\"id\":11,\"sectionId\":8,\"siteId\":2,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{parent.uri}/{slug}\",\"template\":\"_page\",\"language\":\"en-ca\"},\"1\":{\"id\":12,\"sectionId\":8,\"siteId\":1,\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"{parent.uri}/{slug}\",\"template\":\"_page\",\"language\":\"en-ca\"}}','2022-10-05 22:23:58','{\"language\":null,\"mainEntityOfPage\":\"WebPage\",\"seoTitle\":\"{{ entry.title }}\",\"siteNamePosition\":\"\",\"seoDescription\":\"\",\"seoKeywords\":\"\",\"seoImage\":\"\",\"seoImageWidth\":\"\",\"seoImageHeight\":\"\",\"seoImageDescription\":\"\",\"canonicalUrl\":\"{{ entry.url }}\",\"robots\":\"all\",\"ogType\":\"website\",\"ogTitle\":\"{{ seomatic.meta.seoTitle }}\",\"ogSiteNamePosition\":\"\",\"ogDescription\":\"{{ seomatic.meta.seoDescription }}\",\"ogImage\":\"{{ seomatic.meta.seoImage }}\",\"ogImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"ogImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"ogImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"twitterCard\":\"summary_large_image\",\"twitterCreator\":\"{{ seomatic.site.twitterHandle }}\",\"twitterTitle\":\"{{ seomatic.meta.seoTitle }}\",\"twitterSiteNamePosition\":\"\",\"twitterDescription\":\"{{ seomatic.meta.seoDescription }}\",\"twitterImage\":\"{{ seomatic.meta.seoImage }}\",\"twitterImageWidth\":\"{{ seomatic.meta.seoImageWidth }}\",\"twitterImageHeight\":\"{{ seomatic.meta.seoImageHeight }}\",\"twitterImageDescription\":\"{{ seomatic.meta.seoImageDescription }}\",\"inherited\":[],\"overrides\":[]}','{\"siteName\":\"Wireframe Site\",\"identity\":null,\"creator\":null,\"twitterHandle\":\"\",\"facebookProfileId\":\"\",\"facebookAppId\":\"\",\"googleSiteVerification\":\"\",\"bingSiteVerification\":\"\",\"pinterestSiteVerification\":\"\",\"facebookSiteVerification\":\"\",\"sameAsLinks\":[],\"siteLinksSearchTarget\":\"\",\"siteLinksQueryInput\":\"\",\"referrer\":\"no-referrer-when-downgrade\",\"additionalSitemapUrls\":[],\"additionalSitemapUrlsDateUpdated\":null,\"additionalSitemaps\":[]}','{\"sitemapUrls\":true,\"sitemapAssets\":true,\"sitemapFiles\":true,\"sitemapAltLinks\":true,\"sitemapChangeFreq\":\"weekly\",\"sitemapPriority\":0.5,\"sitemapLimit\":null,\"structureDepth\":null,\"sitemapImageFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"caption\",\"field\":\"\"},{\"property\":\"geo_location\",\"field\":\"\"},{\"property\":\"license\",\"field\":\"\"}],\"sitemapVideoFieldMap\":[{\"property\":\"title\",\"field\":\"title\"},{\"property\":\"description\",\"field\":\"\"},{\"property\":\"thumbnailLoc\",\"field\":\"\"},{\"property\":\"duration\",\"field\":\"\"},{\"property\":\"category\",\"field\":\"\"}],\"inherited\":[],\"overrides\":[]}','{\"MetaTagContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"General Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContaineropengraph\":{\"data\":[],\"name\":\"Facebook\",\"description\":\"Facebook OpenGraph Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"opengraph\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainertwitter\":{\"data\":[],\"name\":\"Twitter\",\"description\":\"Twitter Card Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"twitter\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTagContainermiscellaneous\":{\"data\":[],\"name\":\"Miscellaneous\",\"description\":\"Miscellaneous Meta Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTagContainer\",\"handle\":\"miscellaneous\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaLinkContainergeneral\":{\"data\":[],\"name\":\"General\",\"description\":\"Link Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaLinkContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaScriptContainergeneral\":{\"data\":[],\"position\":1,\"name\":\"General\",\"description\":\"Script Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaScriptContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaJsonLdContainergeneral\":{\"data\":{\"mainEntityOfPage\":{\"context\":\"http://schema.org\",\"type\":\"{{ seomatic.meta.mainEntityOfPage }}\",\"id\":null,\"graph\":null,\"include\":true,\"key\":\"mainEntityOfPage\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[],\"nonce\":null,\"lastReviewed\":null,\"specialty\":null,\"primaryImageOfPage\":null,\"significantLink\":null,\"reviewedBy\":null,\"mainContentOfPage\":null,\"relatedLink\":null,\"speakable\":null,\"breadcrumb\":null,\"significantLinks\":null,\"teaches\":null,\"educationalLevel\":null,\"abstract\":null,\"creativeWorkStatus\":null,\"expires\":null,\"contentReferenceTime\":null,\"material\":null,\"review\":null,\"fileFormat\":null,\"text\":null,\"translator\":null,\"award\":null,\"assesses\":null,\"copyrightNotice\":null,\"schemaVersion\":null,\"countryOfOrigin\":null,\"pattern\":null,\"accountablePerson\":null,\"funding\":null,\"educationalUse\":null,\"genre\":null,\"keywords\":null,\"position\":null,\"accessibilityHazard\":null,\"alternativeHeadline\":null,\"audience\":null,\"offers\":null,\"locationCreated\":null,\"associatedMedia\":null,\"materialExtent\":null,\"mainEntity\":null,\"copyrightHolder\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"awards\":null,\"contentLocation\":null,\"sdDatePublished\":null,\"producer\":null,\"spatial\":null,\"publisher\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"sourceOrganization\":null,\"character\":null,\"funder\":null,\"exampleOfWork\":null,\"usageInfo\":null,\"provider\":null,\"sdPublisher\":null,\"comment\":null,\"accessibilityFeature\":null,\"publication\":null,\"translationOfWork\":null,\"interactivityType\":null,\"commentCount\":null,\"accessMode\":null,\"aggregateRating\":null,\"timeRequired\":null,\"typicalAgeRange\":null,\"interactionStatistic\":null,\"copyrightYear\":\"{{ entry.postDate | date(\\\"Y\\\") }}\",\"isBasedOn\":null,\"workExample\":null,\"publishingPrinciples\":null,\"discussionUrl\":null,\"releasedEvent\":null,\"dateCreated\":false,\"workTranslation\":null,\"editor\":null,\"creditText\":null,\"recordedAt\":null,\"editEIDR\":null,\"author\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#identity\"},\"dateModified\":\"{{ entry.dateUpdated |atom }}\",\"sponsor\":null,\"accessibilitySummary\":null,\"encodingFormat\":null,\"maintainer\":null,\"educationalAlignment\":null,\"acquireLicensePage\":null,\"isAccessibleForFree\":null,\"datePublished\":\"{{ entry.postDate |atom }}\",\"spatialCoverage\":null,\"sdLicense\":null,\"conditionsOfAccess\":null,\"correction\":null,\"contentRating\":null,\"size\":null,\"isPartOf\":null,\"temporal\":null,\"thumbnailUrl\":null,\"inLanguage\":\"{{ seomatic.meta.language }}\",\"license\":null,\"creator\":{\"id\":\"{{ parseEnv(seomatic.site.identity.genericUrl) }}#creator\"},\"reviews\":null,\"about\":null,\"isFamilyFriendly\":null,\"headline\":\"{{ seomatic.meta.seoTitle }}\",\"accessibilityAPI\":null,\"publisherImprint\":null,\"isBasedOnUrl\":null,\"encodings\":null,\"interpretedAsClaim\":null,\"accessibilityControl\":null,\"citation\":null,\"version\":null,\"archivedAt\":null,\"learningResourceType\":null,\"encoding\":null,\"audio\":null,\"mentions\":null,\"accessModeSufficient\":null,\"hasPart\":null,\"temporalCoverage\":null,\"contributor\":null,\"video\":null,\"mainEntityOfPage\":\"{{ seomatic.meta.canonicalUrl }}\",\"alternateName\":null,\"name\":\"{{ seomatic.meta.seoTitle }}\",\"potentialAction\":{\"type\":\"SearchAction\",\"target\":\"{{ seomatic.site.siteLinksSearchTarget }}\",\"query-input\":\"{{ seomatic.helper.siteLinksQueryInput() }}\"},\"image\":{\"type\":\"ImageObject\",\"url\":\"{{ seomatic.meta.seoImage }}\"},\"url\":\"{{ seomatic.meta.canonicalUrl }}\",\"description\":\"{{ seomatic.meta.seoDescription }}\",\"subjectOf\":null,\"additionalType\":null,\"disambiguatingDescription\":null,\"sameAs\":null,\"identifier\":null}},\"name\":\"General\",\"description\":\"JsonLd Tags\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaJsonLdContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false},\"MetaTitleContainergeneral\":{\"data\":{\"title\":{\"title\":\"{{ seomatic.meta.seoTitle }}\",\"siteName\":\"{{ seomatic.site.siteName }}\",\"siteNamePosition\":\"{{ seomatic.meta.siteNamePosition }}\",\"separatorChar\":\"{{ seomatic.config.separatorChar }}\",\"include\":true,\"key\":\"title\",\"environment\":null,\"dependencies\":null,\"tagAttrs\":[]}},\"name\":\"General\",\"description\":\"Meta Title Tag\",\"class\":\"nystudio107\\\\seomatic\\\\models\\\\MetaTitleContainer\",\"handle\":\"general\",\"include\":true,\"dependencies\":[],\"clearCache\":false}}','[]','{\"data\":[],\"name\":null,\"description\":null,\"class\":\"nystudio107\\\\seomatic\\\\models\\\\FrontendTemplateContainer\",\"handle\":null,\"include\":true,\"dependencies\":null,\"clearCache\":false}','{\"siteType\":\"CreativeWork\",\"siteSubType\":\"WebSite\",\"siteSpecificType\":\"\",\"seoTitleSource\":\"fromCustom\",\"seoTitleField\":\"\",\"siteNamePositionSource\":\"fromCustom\",\"seoDescriptionSource\":\"fromCustom\",\"seoDescriptionField\":\"\",\"seoKeywordsSource\":\"fromCustom\",\"seoKeywordsField\":\"\",\"seoImageIds\":[],\"seoImageSource\":\"fromAsset\",\"seoImageField\":\"\",\"seoImageTransform\":true,\"seoImageTransformMode\":\"crop\",\"seoImageDescriptionSource\":\"fromCustom\",\"seoImageDescriptionField\":\"\",\"twitterCreatorSource\":\"sameAsSite\",\"twitterCreatorField\":\"\",\"twitterTitleSource\":\"sameAsSeo\",\"twitterTitleField\":\"\",\"twitterSiteNamePositionSource\":\"fromCustom\",\"twitterDescriptionSource\":\"sameAsSeo\",\"twitterDescriptionField\":\"\",\"twitterImageIds\":[],\"twitterImageSource\":\"sameAsSeo\",\"twitterImageField\":\"\",\"twitterImageTransform\":true,\"twitterImageTransformMode\":\"crop\",\"twitterImageDescriptionSource\":\"sameAsSeo\",\"twitterImageDescriptionField\":\"\",\"ogTitleSource\":\"sameAsSeo\",\"ogTitleField\":\"\",\"ogSiteNamePositionSource\":\"fromCustom\",\"ogDescriptionSource\":\"sameAsSeo\",\"ogDescriptionField\":\"\",\"ogImageIds\":[],\"ogImageSource\":\"sameAsSeo\",\"ogImageField\":\"\",\"ogImageTransform\":true,\"ogImageTransformMode\":\"crop\",\"ogImageDescriptionSource\":\"sameAsSeo\",\"ogImageDescriptionField\":\"\"}');
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
-- Dumping data for table `sherlock`
--

LOCK TABLES `sherlock` WRITE;
/*!40000 ALTER TABLE `sherlock` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sherlock` ENABLE KEYS */;
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
INSERT INTO `sitegroups` VALUES (1,'Primary Site','2022-10-05 22:18:14','2022-10-05 22:18:14',NULL,'bcb40c76-f64f-408f-b1da-edb455b3588d'),(2,'Documentation','2022-10-05 22:18:14','2022-10-05 22:18:14',NULL,'a9201360-fe99-432b-9f60-dcceb22f2919');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,2,0,'1','Site Guide','guide','en-CA',1,'@web',2,'2022-10-05 22:18:14','2022-10-05 22:18:14',NULL,'cc8cbe25-440c-439e-a58b-6515a3b420d0'),(2,1,1,'1','Wireframe Site','default','en-CA',1,'@web',1,'2022-10-05 22:18:14','2022-10-05 22:19:16',NULL,'34463b82-dd3f-441c-b9c6-59c351e847aa');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sprig_playgrounds`
--

LOCK TABLES `sprig_playgrounds` WRITE;
/*!40000 ALTER TABLE `sprig_playgrounds` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sprig_playgrounds` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `stc_6_items`
--

LOCK TABLES `stc_6_items` WRITE;
/*!40000 ALTER TABLE `stc_6_items` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `stc_6_items` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structureelements` VALUES (1,5,NULL,1,1,4,0,'2022-10-05 22:22:41','2022-10-05 22:22:41','7d8a5be4-4c66-4078-8424-a6656db04715'),(2,5,17,1,2,3,1,'2022-10-05 22:22:41','2022-10-05 22:22:41','796ce921-2d97-43ac-b153-c8eedd43c881');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `structures` VALUES (1,NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'d38282dc-c747-4b18-9cc3-81089a42e2b7'),(2,NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'e65a3b8e-1725-430e-8cdd-219eb8728a82'),(3,NULL,'2022-10-05 22:18:53','2022-10-05 22:18:53',NULL,'4fe70de7-32cb-4d01-b895-5bb4b2f49d08'),(4,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'8db16329-d7e8-40ce-aece-45f9da88cdbe'),(5,NULL,'2022-10-05 22:19:08','2022-10-05 22:19:08',NULL,'0f9bddc9-659f-4907-82a2-028748c7f504');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocks`
--

LOCK TABLES `supertableblocks` WRITE;
/*!40000 ALTER TABLE `supertableblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `supertableblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocks_owners`
--

LOCK TABLES `supertableblocks_owners` WRITE;
/*!40000 ALTER TABLE `supertableblocks_owners` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `supertableblocks_owners` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `supertableblocktypes`
--

LOCK TABLES `supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `supertableblocktypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `supertableblocktypes` VALUES (1,85,35,'2022-10-05 22:20:04','2022-10-05 22:20:04','d5468b8f-24c2-45c5-a377-ac0da764cbb1');
/*!40000 ALTER TABLE `supertableblocktypes` ENABLE KEYS */;
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
INSERT INTO `taggroups` VALUES (1,'Content Topics','topics',4,'2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'309b4130-a979-4b2c-8a72-971bbeb15553');
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
INSERT INTO `usergroups` VALUES (1,'Content Editor','contentEditor',NULL,'2022-10-05 22:19:12','2022-10-05 22:19:12','a9eefedb-b175-4baa-a9ee-903aa94e9c9b'),(2,'Site Owner','siteOwner',NULL,'2022-10-05 22:19:12','2022-10-05 22:19:12','e511df66-41ea-4d8f-bfa5-538fec0fc45f'),(3,'SEO Editor','seoEditor',NULL,'2022-10-05 22:19:12','2022-10-05 22:19:12','43406218-0e65-4e33-bd0a-df130a7d2e6c');
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
INSERT INTO `userpermissions` VALUES (1,'accesscp','2022-10-05 22:19:12','2022-10-05 22:19:12','d44f7384-8e8c-475f-a3d8-9774b60b023a'),(2,'accesscpwhensystemisoff','2022-10-05 22:19:12','2022-10-05 22:19:12','823c5c6a-039b-44ba-8859-0662d6d0f326'),(3,'accessplugin-navigate','2022-10-05 22:19:12','2022-10-05 22:19:12','53bfdf10-2812-486f-b120-b9b6dc341668'),(4,'accessplugin-redirect','2022-10-05 22:19:12','2022-10-05 22:19:12','69a48a78-e1e8-4afa-93af-adcf610844e6'),(5,'accesssitewhensystemisoff','2022-10-05 22:19:12','2022-10-05 22:19:12','bbf2fe02-f014-433f-b926-aa377e1497b7'),(6,'assignusergroup:a9eefedb-b175-4baa-a9ee-903aa94e9c9b','2022-10-05 22:19:12','2022-10-05 22:19:12','348ad65c-0345-446c-93ea-ed24b2b36a13'),(7,'createentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:12','2022-10-05 22:19:12','777bd90c-12ec-4ace-895a-53c3a95448a1'),(8,'createentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:12','2022-10-05 22:19:12','3fc0ed18-3530-40e2-8dbe-20b6925c1e08'),(9,'createentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:12','2022-10-05 22:19:12','6cb21585-3626-40ad-a607-a374caf84b75'),(10,'createentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:12','2022-10-05 22:19:12','2a9ec10a-3ba0-4cea-bb64-be0cebf113e2'),(11,'createfolders:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:12','2022-10-05 22:19:12','37b6924e-4a9a-428d-9d6a-9b9d9cf0d82b'),(12,'createfolders:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','d1d1c0af-8776-4418-bc66-088e05aa0a75'),(13,'deleteassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','43f420bb-8696-4014-be75-432ffddf30cc'),(14,'deleteassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','f0db5bce-0123-4e5c-a8b5-73e574ed9249'),(15,'deleteentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','76aeae89-f1db-4ac2-b62d-fa46d57e9c94'),(16,'deleteentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','01f1622a-2f88-4fae-b897-e0ecd9cdee61'),(17,'deleteentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:13','2022-10-05 22:19:13','7f785dc0-ad33-4f93-b7b0-0ffabd060fa7'),(18,'deleteentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','cdefccfb-628e-4a08-a095-1febdd3b1d29'),(19,'deletepeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','92a152d3-d30a-4a0d-acd1-d0a4416ea4a7'),(20,'deletepeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','2217d6b4-cd2c-4be2-b808-f0716c915a35'),(21,'deletepeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','79a843f3-cacc-4197-8853-216ce77641fc'),(22,'deletepeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','70cef7b6-9cb4-4fe8-a716-de80d8f3674c'),(23,'deletepeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-10-05 22:19:13','2022-10-05 22:19:13','5e8f48c1-4824-413a-840f-3f65686dd9c0'),(24,'deletepeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','47b67c35-3e0f-470a-91e8-4296a91b0898'),(25,'deletepeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-10-05 22:19:13','2022-10-05 22:19:13','74e99c1c-cdeb-425f-bdc4-81915611ec95'),(26,'deletepeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','46774d6e-94ce-4d78-abd9-e58ea6cf16d1'),(27,'deletepeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-10-05 22:19:13','2022-10-05 22:19:13','ca6f358f-618d-4acc-99c9-860e3968b3f0'),(28,'deletepeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:13','2022-10-05 22:19:13','5b465277-d902-466d-95f6-4593ee7e687a'),(29,'deletepeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','312f0fd8-6f50-4dbd-8eeb-17bbfa1d7e3b'),(30,'editimages:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','1690dffe-3e9f-4e76-9048-a6d27f9c5ee4'),(31,'editimages:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','33f97ae1-73cf-40d9-84a9-bd4666be34b6'),(32,'editpeerimages:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','0dccc23e-e22e-4ff2-ab83-34b97e9c95d3'),(33,'editpeerimages:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','671e2f4b-df8a-469f-9525-c930c08ac1c3'),(34,'editsite:34463b82-dd3f-441c-b9c6-59c351e847aa','2022-10-05 22:19:13','2022-10-05 22:19:13','48a7ef14-7a67-469a-8551-12769254060b'),(35,'replacefiles:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','df5d73a1-69a7-451c-bf94-3602a66858cf'),(36,'replacefiles:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','4ec16e34-6396-413d-b279-ed20966abf1c'),(37,'replacepeerfiles:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','7f74de58-0be2-4e34-97e6-1ba61c4a6503'),(38,'replacepeerfiles:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','0d77feb6-d8c6-4ea2-bd0e-3aed21bd1208'),(39,'saveassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','b6c3ccdc-9a1b-4a73-b3b9-4c37f1cf40fb'),(40,'saveassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','d8d6b5ce-2509-417d-a1b1-195df1a1a332'),(41,'saveentries:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-10-05 22:19:13','2022-10-05 22:19:13','8fbf2969-eff8-45bb-a078-28b5e9b45cf0'),(42,'saveentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','98c7fe4b-8572-4bd5-8094-839d35ca7755'),(43,'saveentries:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-10-05 22:19:13','2022-10-05 22:19:13','2962dc94-75ef-4608-87c0-14e86f5f1808'),(44,'saveentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','5ffcbdad-c75c-45de-9721-17ce9446e1a5'),(45,'saveentries:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-10-05 22:19:13','2022-10-05 22:19:13','256cd2f0-e484-4046-a6bb-28d49882be5e'),(46,'saveentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:13','2022-10-05 22:19:13','19ef9b88-b11e-4baa-98f9-c75bbe41e449'),(47,'saveentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','48b0fa04-cc76-434c-a9a8-015ff3c024ec'),(48,'savepeerassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:13','2022-10-05 22:19:13','f56bfc5d-0fed-4ffe-ac3f-4bd723c592f8'),(49,'savepeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:13','2022-10-05 22:19:13','240dd5f9-97d7-4a4d-9755-cf180eb6ac88'),(50,'savepeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','38d80e40-f5f5-4636-a60f-c07f624499bf'),(51,'savepeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','a2f3e0af-a879-4171-ab6e-f74b08ffd433'),(52,'savepeerentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:13','2022-10-05 22:19:13','a15ffeaa-60b9-41ef-8212-c524069d7470'),(53,'savepeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','d5ac92c4-3b84-4892-92d3-aff5010be875'),(54,'savepeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-10-05 22:19:13','2022-10-05 22:19:13','5ffccf0b-431f-4ea7-8532-eb9c5e1d7c3a'),(55,'savepeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:13','2022-10-05 22:19:13','89dc9b30-8267-4556-acbf-69f975bbf831'),(56,'savepeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-10-05 22:19:13','2022-10-05 22:19:13','10ac90fc-1698-4c97-800c-23305b383763'),(57,'savepeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:13','2022-10-05 22:19:13','ba937657-c9c9-4d39-9b61-73c0f822d6fc'),(58,'savepeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-10-05 22:19:13','2022-10-05 22:19:13','0493743a-e3bd-4784-8589-a277dacbce87'),(59,'savepeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:13','2022-10-05 22:19:13','680a011e-c61e-4e6b-9e6a-5f76d3c3e885'),(60,'savepeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:13','2022-10-05 22:19:13','49dd4b38-ff48-4956-b6bd-1ac2ae3a9b70'),(61,'utility:clear-caches','2022-10-05 22:19:13','2022-10-05 22:19:13','fd049313-4ebc-4472-92fc-a4a5edc22852'),(62,'viewassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:14','2022-10-05 22:19:14','b3858fdf-5c07-4220-b080-fd723c50e0da'),(63,'viewassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:14','2022-10-05 22:19:14','b242da22-b215-41f4-8791-4c9f16e62e51'),(64,'viewentries:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-10-05 22:19:14','2022-10-05 22:19:14','b7c58e2c-4191-4bb3-b3e6-e748931755bb'),(65,'viewentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:14','2022-10-05 22:19:14','e2d15b8b-1220-4ef5-a4c0-0fe676da1988'),(66,'viewentries:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-10-05 22:19:14','2022-10-05 22:19:14','5a8d49e9-646d-422b-8bed-a3b74377f3bd'),(67,'viewentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:14','2022-10-05 22:19:14','a967be30-bca5-48e4-bdd4-077c4ecbd647'),(68,'viewentries:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-10-05 22:19:14','2022-10-05 22:19:14','06ee1bd7-5e6f-42c0-a970-58398fc9bd74'),(69,'viewentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:14','2022-10-05 22:19:14','10223b60-2c08-4160-9446-1931fda0f95c'),(70,'viewentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:14','2022-10-05 22:19:14','8ed3c070-9a16-4b8e-a3ef-2d160f9f264f'),(71,'viewpeerassets:3c05e593-d621-444e-8fb9-ddbb1b356a43','2022-10-05 22:19:14','2022-10-05 22:19:14','d2ef69f6-10a3-49a1-9b4b-4ee7423a33b0'),(72,'viewpeerassets:a4f97962-52de-4b53-8422-5b833d1cd5fd','2022-10-05 22:19:14','2022-10-05 22:19:14','3b15ec3f-9986-4904-8506-2f9c6dda7c06'),(73,'viewpeerentries:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:14','2022-10-05 22:19:14','64f9c545-7d6f-4284-aba4-8e56a977daa9'),(74,'viewpeerentries:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:14','2022-10-05 22:19:14','755f87a4-f03e-4ccb-bec6-832d48df9b4d'),(75,'viewpeerentries:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:14','2022-10-05 22:19:14','bcbef071-abaa-45a7-81df-52e3e2e43802'),(76,'viewpeerentries:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:14','2022-10-05 22:19:14','ec893c5f-d7a3-40f4-9f65-56d882f80d51'),(77,'viewpeerentrydrafts:16422b2c-c780-4355-b3a5-44a1cc28ba36','2022-10-05 22:19:14','2022-10-05 22:19:14','2a197205-6606-44e3-ac4c-c610f009615f'),(78,'viewpeerentrydrafts:3721b4d6-42d5-41fc-b6e7-76204b42c91a','2022-10-05 22:19:14','2022-10-05 22:19:14','c6c19fee-6e30-433b-a1f9-d26bcf716c12'),(79,'viewpeerentrydrafts:4faab281-22d5-4b78-a310-d3f84c34aa67','2022-10-05 22:19:14','2022-10-05 22:19:14','f044163c-d8e7-4123-b7f3-1f67527bc3ac'),(80,'viewpeerentrydrafts:650e7d1d-63e5-42f9-b3ab-4febfb502723','2022-10-05 22:19:14','2022-10-05 22:19:14','8c1bc8ad-2a57-407b-86fc-735cd60ee727'),(81,'viewpeerentrydrafts:7fa68ddc-cf1c-4e9b-9ce7-b8865ca9d48c','2022-10-05 22:19:14','2022-10-05 22:19:14','523dab4d-4f5b-4495-bcef-a32f73c731b9'),(82,'viewpeerentrydrafts:89093e20-515d-4e3c-b4c4-c6733d8ab56f','2022-10-05 22:19:14','2022-10-05 22:19:14','091b05e4-0a2c-4a06-8991-997becdc70bf'),(83,'viewpeerentrydrafts:a52e2b08-2e30-4b00-8784-4104c409d3ed','2022-10-05 22:19:14','2022-10-05 22:19:14','0f25bea7-cbcd-4f57-8225-057d93c7cd25'),(84,'administrateusers','2022-10-05 22:19:14','2022-10-05 22:19:14','ae18f992-c3ee-4484-a9d6-6c3c6befbd8e'),(85,'assignusergroup:e511df66-41ea-4d8f-bfa5-538fec0fc45f','2022-10-05 22:19:14','2022-10-05 22:19:14','c089b6eb-366a-478d-ac54-e369459de2c2'),(86,'assignuserpermissions','2022-10-05 22:19:14','2022-10-05 22:19:14','ba61f689-0261-4980-9ce4-d4ea95bbc345'),(87,'deleteusers','2022-10-05 22:19:14','2022-10-05 22:19:14','ffe75bef-cdc7-4ab9-9619-cbc721da992e'),(88,'editusers','2022-10-05 22:19:14','2022-10-05 22:19:14','2bd77714-c87b-411b-a1b6-78b3ea9ad4c3'),(89,'impersonateusers','2022-10-05 22:19:14','2022-10-05 22:19:14','a0d9d174-9858-48cd-928a-f191675b6a65'),(90,'moderateusers','2022-10-05 22:19:14','2022-10-05 22:19:14','6e4077a1-ad19-49f9-8551-a4c8a635fbb6'),(91,'registerusers','2022-10-05 22:19:14','2022-10-05 22:19:14','9ec8b534-f786-4765-85b2-9c1b07dbde96'),(92,'utility:asset-indexes','2022-10-05 22:19:14','2022-10-05 22:19:14','adc3aed2-310f-4123-813c-3a323cea18ea'),(93,'utility:db-backup','2022-10-05 22:19:14','2022-10-05 22:19:14','7e45f7f9-53fd-4f19-bfa5-76fb51427b4e'),(94,'utility:deprecation-errors','2022-10-05 22:19:14','2022-10-05 22:19:14','08413dfd-fea4-486a-ab2f-2d928259a26d'),(95,'utility:php-info','2022-10-05 22:19:14','2022-10-05 22:19:14','8b57e37c-a62a-4860-aee1-c24c5d20c4cc'),(96,'utility:queue-manager','2022-10-05 22:19:14','2022-10-05 22:19:14','afd4ce6b-7210-4b2f-b32d-d93d65649feb'),(97,'utility:system-messages','2022-10-05 22:19:14','2022-10-05 22:19:14','3c08b9ff-9a29-463a-a4a2-1e9f35814732'),(98,'utility:system-report','2022-10-05 22:19:14','2022-10-05 22:19:14','132b12c6-8304-45c7-90cc-7629217bc158'),(99,'accessplugin-seomatic','2022-10-05 22:19:14','2022-10-05 22:19:14','dc337f34-112d-4b64-b2e4-636e065948fc'),(100,'assignusergroup:43406218-0e65-4e33-bd0a-df130a7d2e6c','2022-10-05 22:19:14','2022-10-05 22:19:14','675c3a56-0412-43c1-a03a-ff06205e2dfe'),(101,'seomatic:content-meta','2022-10-05 22:19:14','2022-10-05 22:19:14','0f76d0ac-1444-4ed9-999c-4508358a6d8f'),(102,'seomatic:content-meta:facebook','2022-10-05 22:19:14','2022-10-05 22:19:14','fb49be59-8e2f-4544-8191-f005792626b5'),(103,'seomatic:content-meta:general','2022-10-05 22:19:14','2022-10-05 22:19:14','b2b88538-de7e-45fa-9b02-b4276090a204'),(104,'seomatic:content-meta:sitemap','2022-10-05 22:19:14','2022-10-05 22:19:14','c572479f-4c4e-4deb-a12f-4ee2c264a6f6'),(105,'seomatic:content-meta:twitter','2022-10-05 22:19:14','2022-10-05 22:19:14','8729f496-fbef-45d1-9235-7efa7d2e8771'),(106,'seomatic:dashboard','2022-10-05 22:19:14','2022-10-05 22:19:14','a8ef6da4-a4ae-4291-bc31-23e89041ca87'),(107,'seomatic:global-meta','2022-10-05 22:19:14','2022-10-05 22:19:14','40388c7f-ce6d-45e3-a98a-360944a81938'),(108,'seomatic:global-meta:ads','2022-10-05 22:19:14','2022-10-05 22:19:14','0ce717d6-afff-4bb0-aaa3-83e5fea91ba0'),(109,'seomatic:global-meta:facebook','2022-10-05 22:19:14','2022-10-05 22:19:14','ef335ad6-8dd0-40cd-a997-ee0e2f5646cc'),(110,'seomatic:global-meta:general','2022-10-05 22:19:14','2022-10-05 22:19:14','6144e2aa-02c7-4a98-8f24-f3a6c18d323d'),(111,'seomatic:global-meta:humans','2022-10-05 22:19:15','2022-10-05 22:19:15','ad49f3f8-8477-48a2-9bd3-a3e4b9857b9e'),(112,'seomatic:global-meta:robots','2022-10-05 22:19:15','2022-10-05 22:19:15','eb04a7bc-25a7-4773-991a-c78f95ec83bf'),(113,'seomatic:global-meta:security','2022-10-05 22:19:15','2022-10-05 22:19:15','386829d0-dc42-4a15-b482-c866a8f215ac'),(114,'seomatic:global-meta:twitter','2022-10-05 22:19:15','2022-10-05 22:19:15','1e752b41-f0f4-4d88-99c5-90028a335947'),(115,'seomatic:plugin-settings','2022-10-05 22:19:15','2022-10-05 22:19:15','29f64bf4-7224-411f-8440-0f8b5dcc8676'),(116,'seomatic:site-settings','2022-10-05 22:19:15','2022-10-05 22:19:15','cc264c13-9d66-422b-b21a-fde132fdae26'),(117,'seomatic:site-settings:creator','2022-10-05 22:19:15','2022-10-05 22:19:15','22c0efe8-621b-4a36-b587-eb146ecbc5ea'),(118,'seomatic:site-settings:identity','2022-10-05 22:19:15','2022-10-05 22:19:15','bc941737-1251-4efb-a51d-b303ca97ac8e'),(119,'seomatic:site-settings:miscellaneous','2022-10-05 22:19:15','2022-10-05 22:19:15','dd0874f9-9379-4018-8582-ca89e7e249fa'),(120,'seomatic:site-settings:sitemap','2022-10-05 22:19:15','2022-10-05 22:19:15','11b6b687-e4b2-4f0e-af84-213be98100c0'),(121,'seomatic:site-settings:social','2022-10-05 22:19:15','2022-10-05 22:19:15','b711a51c-6689-4d89-bc15-2322faef5af5'),(122,'seomatic:tracking-scripts','2022-10-05 22:19:15','2022-10-05 22:19:15','1ad43022-39ce-45ea-9b64-76c89097dc32'),(123,'seomatic:tracking-scripts:facebookpixel','2022-10-05 22:19:15','2022-10-05 22:19:15','1564aa70-d346-4a2f-b7ce-7867b2fdbe2f'),(124,'seomatic:tracking-scripts:fathom','2022-10-05 22:19:15','2022-10-05 22:19:15','62906377-82cf-4ca2-a74c-309f86ed19c7'),(125,'seomatic:tracking-scripts:googleanalytics','2022-10-05 22:19:15','2022-10-05 22:19:15','5eeaa338-45fb-4cd0-8167-6c44f0a576b1'),(126,'seomatic:tracking-scripts:googletagmanager','2022-10-05 22:19:15','2022-10-05 22:19:15','6eb44368-8c84-4ff3-894f-3ee1c329ad27'),(127,'seomatic:tracking-scripts:gtag','2022-10-05 22:19:15','2022-10-05 22:19:15','68596bf9-ad08-4b4e-ae2c-288062a925c3'),(128,'seomatic:tracking-scripts:hubspot','2022-10-05 22:19:15','2022-10-05 22:19:15','97184d2c-a9f7-4798-ba1b-134cb0ed8f0d'),(129,'seomatic:tracking-scripts:linkedininsight','2022-10-05 22:19:15','2022-10-05 22:19:15','9abec750-858b-4147-80e3-a355d73355ad'),(130,'seomatic:tracking-scripts:matomo','2022-10-05 22:19:15','2022-10-05 22:19:15','29e887b6-4525-44d9-8a38-dd50d52f57c0'),(131,'seomatic:tracking-scripts:pinteresttag','2022-10-05 22:19:15','2022-10-05 22:19:15','b9f44c7c-2131-441a-9699-ea54724ed1df'),(132,'seomatic:tracking-scripts:plausible','2022-10-05 22:19:15','2022-10-05 22:19:15','a7e8883c-4744-4ddf-96fd-506f0a5d5b0a');
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpermissions_usergroups` VALUES (84,1,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','06478949-1b68-494d-a552-3bc9eb53a473'),(85,2,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b6bbefe8-662f-4801-bfcd-a1344e72af89'),(86,3,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','ac451e73-b083-4fb1-888c-f3abb2f173e3'),(87,4,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','d55127f3-0e98-4b18-9847-b758de83c819'),(88,5,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','31bb4fea-9f6a-41b5-8a48-bcbaff3650cc'),(89,6,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','6d2565d8-c209-4763-b92a-232dd2020b06'),(90,7,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','6e2281ff-e0fe-4bbe-ae26-c72993c0a430'),(91,8,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','12baa3fd-c9cc-45da-9677-8180b74dba44'),(92,9,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','5f28098d-9600-4dee-8b5f-1fde5e17cce7'),(93,10,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','ab9c52cc-baa3-47ed-9a8b-1ba44d434f73'),(94,11,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','1c084ee4-57fe-4d65-977e-5c52fa02945a'),(95,12,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','e849a941-827e-46f2-bba2-fd8504240a20'),(96,13,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','391a182d-11f9-497f-9cd5-e018e57596fa'),(97,14,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b67e9058-d480-4b26-890e-644e3bbf8c5c'),(98,15,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','5fb26733-5034-4929-bc90-7d42a5e4e2c1'),(99,16,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','4656f7d5-5739-43b0-9854-c8c4143f5bc1'),(100,17,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','5b9c3b27-d9f1-40d0-8fc2-aaf3f1a7f655'),(101,18,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','68c914bc-3943-439d-a033-79eb9993018d'),(102,19,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','4ede285f-da86-4ab3-8e4c-9b852dacf390'),(103,20,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','dc5c3d20-52e1-426c-a0d5-bd72694f63b9'),(104,21,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','ff3e223a-1a00-4fb6-88b6-9fd110120ae9'),(105,22,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','0264e318-aa15-4237-a15c-e784159a047d'),(106,23,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','880f743c-d1c3-4e5d-891b-c1d88a884a99'),(107,24,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','28cc65fb-5829-4acc-ac8d-1eaf85098f96'),(108,25,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','bcb25d14-08bf-4788-8186-8a6d53f3c8a5'),(109,26,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','83852a56-d45a-4b21-b46b-22df44349603'),(110,27,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','57cfec29-5bb6-4e33-a03a-ec7326e6a6c7'),(111,28,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','e7c87158-943d-47c6-8c0c-2fff4c3f1e84'),(112,29,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','e10e5de9-376c-4197-a991-81af6c7cda21'),(113,30,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','fd8fadef-872a-4f74-8cd6-6231a8da5957'),(114,31,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','e133e6cf-5ea1-49cc-ab27-91c35ffcdeb6'),(115,32,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','59f6b25b-61c9-4c6c-afdb-00809d2fb9b0'),(116,33,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','17a9c6b6-8286-44e9-a0d5-9afcb89ea72f'),(117,34,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','08d7617c-f382-4b9f-ac97-d9aafc64d495'),(118,35,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','02a2a5ad-b61d-4aec-a35d-f0e714206594'),(119,36,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','821b4e41-9954-43f8-b774-eabb324fc4d0'),(120,37,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','1a5c3b3b-ff2d-4b6e-9f90-43e54c50cd80'),(121,38,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','8eb0ebb1-4deb-4082-9bb9-4abd031cb375'),(122,39,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','c452aba8-cdac-4d93-a649-229f9f6ecc31'),(123,40,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','d219b299-54c3-4ab7-8759-5052c93dfb43'),(124,41,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','949193c3-9c79-4401-8f13-993719d0fca6'),(125,42,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','77bb0b3d-f9f6-4b1e-95cd-a59a1b11ea50'),(126,43,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','d68d1b61-5f59-4a96-8b69-275f706c1ccc'),(127,44,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','e426dba8-a11c-42ee-96c3-f89fab0c3cf9'),(128,45,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','ca234898-4ddc-49bc-9632-b2ebe00d17f7'),(129,46,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','6a4b6c76-9e2c-4451-9bbe-dcea6f79f3a8'),(130,47,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','6db29fe3-84dc-4c27-8872-aed26b5eb266'),(131,48,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','88a30694-87b7-4a4f-86da-6890116fc62a'),(132,49,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','975c1b19-e61f-4a3f-8b1a-576c23c6cb26'),(133,50,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','0aaa1eaf-9a28-4af6-98c6-2d7137513d0e'),(134,51,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','438026b2-1a66-4180-86d4-93f4a9d1a9a6'),(135,52,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','5b9596f4-57cc-4f02-b8c1-5bb22015dd4e'),(136,53,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','36c8269a-dd29-473a-bcef-4e38c0721c3c'),(137,54,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b8f85d9a-230c-4c8c-993f-91dd4b8b4be5'),(138,55,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','74e61245-2a38-4567-9e50-3902efe365d2'),(139,56,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','15e9995b-3f1f-4ef1-a767-43b9afd9ff4c'),(140,57,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','95bea453-9588-42a2-a41c-e81a8f8dc3e1'),(141,58,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','73ea4c42-b416-4642-8739-c36c428563b1'),(142,59,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','a781a6bd-538f-43c7-be93-dc56d322b4de'),(143,60,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','a367200b-ffa2-4c34-9562-7359414fffad'),(144,61,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','686e627d-32e4-455b-99ef-e9ed79b689f4'),(145,62,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','dac81401-f057-4c8e-8bb3-da4dfc89ea5e'),(146,63,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b8fe05a1-a6c3-40c9-8875-00bb7223b539'),(147,64,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','bbe74d62-2981-47bd-b651-a859d0eac061'),(148,65,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','2fbb60b2-88c2-4ead-9e86-de53619cb848'),(149,66,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','6a19763b-b70d-4398-b6c2-8b436b99f4a1'),(150,67,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','cbd757c1-e87c-4425-a68c-1bcba184d523'),(151,68,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','fdcb911a-d2b9-4395-83b9-72acb01443fb'),(152,69,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','85e07b86-d282-4b4d-86cd-855a6b5560ff'),(153,70,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','64b561ce-bf18-43f6-8cd2-804d42dfd727'),(154,71,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b3029207-9ddc-4cea-9ec9-b2a1a1a7c9e2'),(155,72,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','f24d2dbe-0adf-439c-8d52-b5c6426c0d12'),(156,73,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b65c67ff-4a83-46d2-94ee-28ae054e37fe'),(157,74,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','dc30a263-28f1-4aae-80c0-c1f35a85b215'),(158,75,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','4049b7c9-5918-4978-9401-81168b5e2bed'),(159,76,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','9d4cbe49-dea8-4d1d-bb4d-65bfcae26bab'),(160,77,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','c305e8d0-8c91-4cac-aba3-4b133e133a2f'),(161,78,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','49e475f5-2736-482f-bec6-691dc7ae7f36'),(162,79,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','19d65332-648f-4023-8c4f-2a9da34e5664'),(163,80,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','7975406f-47ff-4a96-8448-6a60b98f4ae1'),(164,81,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','460c8a82-8d15-48ff-a54e-ff7689b7a3d1'),(165,82,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','80472cf2-0b2d-4cc5-8009-23a37f630350'),(166,83,1,'2022-10-05 22:19:14','2022-10-05 22:19:14','b573367d-3d9c-4a8c-9565-632a4cf83f7c'),(188,1,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','61d53d90-a2df-4682-be1c-63f2d07fe49a'),(189,2,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','166b9759-9d83-488a-9807-06df0df64cd1'),(190,5,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','0aa49712-5f3c-4495-a95c-7c64c8e533fb'),(191,84,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','d6fda2ca-3fe1-4d06-8883-bea62d4c1b3d'),(192,6,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','54e7ad8e-d97c-44e6-8e88-fd72b5c5b838'),(193,85,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','58446814-4cc3-417e-87eb-620d3db2d1d7'),(194,86,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','1afe3720-ead8-4503-99c0-d827e99ce1ea'),(195,87,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','19a76d06-2344-438b-a3bb-d60d59cafc98'),(196,34,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','6cd6a4c2-152c-4629-80d6-61032fbbfd58'),(197,88,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','b4dcb606-2cc8-49b4-92ef-aeaec4e447c0'),(198,89,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','c52c6382-3c64-4b40-adec-4c11e6f84b4e'),(199,90,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','f8515cf2-d20c-4bb9-8fc7-2897336e593d'),(200,91,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','79b944b1-5f7f-401c-9da1-eb0309fe039d'),(201,92,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','a694a745-2f1e-4bb7-a7de-1280c4b0bd6c'),(202,61,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','805d8c1e-0907-4884-8b3d-69589864e81b'),(203,93,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','96fb0cf4-bba4-48d0-bca5-9ef7d01e7bd6'),(204,94,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','060a7a24-21b1-424b-b1e6-c5a9fe031102'),(205,95,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','461447a3-e59b-46b4-8a09-799d325ed4fd'),(206,96,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','3cc80b5a-6745-4afc-8f92-e63f7f057772'),(207,97,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','903c02fa-0a2c-4c3b-946d-1b14d62e9de0'),(208,98,2,'2022-10-05 22:19:14','2022-10-05 22:19:14','a01b2517-52c5-4177-83e0-c4b2ebe8e97d'),(245,1,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','0a46b24a-add7-4be5-8a49-8332adf28961'),(246,99,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','46cc2405-ee70-44ab-81d7-b923a3efd5e1'),(247,5,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','04118980-a647-4ee9-9c11-447d571ee31d'),(248,100,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','4c25d585-c5f0-4cd4-95c8-1d68d7a042f4'),(249,101,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','33b0ae23-a1b9-4c94-8cff-135d78a90dcf'),(250,102,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','2dd00c2f-498f-4ced-8b87-bbc59a3e9856'),(251,103,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','67cdfa9e-1e96-42e9-a6d4-a92efff77820'),(252,104,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','be3ba250-fb55-4076-a3d5-012d66461ddf'),(253,105,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','ef42fd7c-65fb-45ac-a9ad-4e1d9752e02f'),(254,106,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','155db4fb-e25e-4e99-b28f-405432a4267d'),(255,107,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','39c9f105-611d-43f0-bd3b-bac138015872'),(256,108,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','9fac1a3b-9a26-4fba-ae52-a68d74d67df1'),(257,109,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','aaac1ea7-278a-4f2f-a1b2-ce8b4bdf8ca3'),(258,110,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','230b73db-bbd2-4725-8caf-c40a7fbac9e5'),(259,111,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','75c410a7-1b2b-455a-88bd-c68f5f9f55fd'),(260,112,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','2ca16069-2305-4618-8cae-254e5d744c7b'),(261,113,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','add985d4-82bd-4e2c-b732-5e42dc1f5e9d'),(262,114,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','f378dd46-c4d9-414b-876a-0d9e2dc32887'),(263,115,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','58d7a66e-b85f-4221-9381-e02cdb6572cc'),(264,116,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','e1ca8ac8-633c-42ad-834a-64b8118c1f91'),(265,117,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','af6642ff-d225-4771-a727-62615d581798'),(266,118,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','3da2bb34-41cd-45a2-8e3e-45850599f721'),(267,119,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','32eaca67-ac6e-48cd-a58c-4f8d55115f32'),(268,120,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','78e73331-1393-453a-9cc3-2497b84acb42'),(269,121,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','3cca032c-9574-4c74-b15c-dcf60796a9c5'),(270,122,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','303290b2-dc55-4cca-b2b7-fb4131ad98c4'),(271,123,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','79f65c97-5444-4296-bf08-5df11e9289bc'),(272,124,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','77ee1797-1272-441d-9302-0b4221d2098c'),(273,125,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','774fbbac-41d2-4660-b66f-173645dce3d6'),(274,126,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','f6cf4099-72e5-42ba-aa96-caa79be9317b'),(275,127,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','3ed06317-1fca-43ee-8e46-2f037941072f'),(276,128,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','2c98cb2f-5330-4c91-9606-54b2f048cabc'),(277,129,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','c2d1b664-018a-43c4-b905-beb436b23614'),(278,130,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','b7b7eae6-c9f8-468a-a6a5-c5d8a3e247fb'),(279,131,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','4224fa6c-2f52-4ad6-9325-af6c7a237b67'),(280,132,3,'2022-10-05 22:19:15','2022-10-05 22:19:15','70cec7e9-9532-42e0-ab08-0f50c8b92cbf');
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
INSERT INTO `userpreferences` VALUES (16,'{\"language\":\"en-CA\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (16,NULL,1,0,0,0,1,'steve@simplicate.ca',NULL,NULL,NULL,'steve@simplicate.ca','$2y$13$DmNDbRkoEKre07pO1.SqiugbGMnHPedRgZMpH1DvZZjJzK.jONgYW','2022-10-05 22:31:46',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2022-10-05 22:20:07','2022-10-05 22:20:07','2022-10-05 22:31:46');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Uploads',NULL,'2022-10-05 22:18:58','2022-10-05 22:18:58','466265af-2988-4c42-b3e7-8566eb748260'),(2,NULL,2,'Static Assets',NULL,'2022-10-05 22:18:58','2022-10-05 22:18:58','7968968e-e76d-4f59-b846-0df8e17c9769'),(3,NULL,NULL,'Temporary filesystem',NULL,'2022-10-05 22:22:42','2022-10-05 22:22:42','eef4fe49-19f7-418c-bcc9-ab23b70ad823'),(4,3,NULL,'user_16','user_16/','2022-10-05 22:22:42','2022-10-05 22:22:42','0010325a-323f-4888-ac64-38d809e12773'),(5,1,1,'icons','icons/','2022-10-05 22:22:42','2022-10-05 22:22:42','98b53fda-8e82-4cb4-853e-a10ca82b369e');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,5,'Uploads','contentAssets','contentAssets',NULL,'','site',NULL,0,'2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'a4f97962-52de-4b53-8422-5b833d1cd5fd'),(2,6,'Static Assets','staticAssets','staticAssets',NULL,'','site',NULL,0,'2022-10-05 22:18:58','2022-10-05 22:18:58',NULL,'3c05e593-d621-444e-8fb9-ddbb1b356a43');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,16,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":2,\"section\":\"*\",\"limit\":10}',1,'2022-10-05 22:21:28','2022-10-05 22:21:28','9014ab15-f5f0-4158-8fcb-b412140dc38f'),(2,16,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2022-10-05 22:21:28','2022-10-05 22:21:28','56c836eb-1577-44f7-8618-2afaf3e6af30'),(3,16,'craft\\widgets\\Updates',3,NULL,'[]',1,'2022-10-05 22:21:28','2022-10-05 22:21:28','36c48ef9-a3dd-4f19-a37e-066ea6725cdc'),(4,16,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2022-10-05 22:21:28','2022-10-05 22:21:28','292a7f60-2067-4768-bc43-ef090c8f6e23');
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

-- Dump completed on 2022-10-05 22:31:58