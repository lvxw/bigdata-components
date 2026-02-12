SET GLOBAL enable_profile = true;
SET GLOBAL enable_audit_plugin = true;


-- ----------------------------
-- Database test
-- ----------------------------
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE `test`;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `test`.`person`;
CREATE TABLE `test`.`person`(
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `age` int(4) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `ts` DATETIME
)
UNIQUE KEY(`id`)
DISTRIBUTED BY HASH(`id`) BUCKETS 1
PROPERTIES (
"replication_num" = "1"
);

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `test`.`worker`;
CREATE TABLE IF NOT EXISTS `test`.`worker` (
    `id` INT(11) NOT NULL,
    `name` VARCHAR(255) NULL,
    `salary` decimal(8,2),
    `desc` varchar(255) NULL,
    `ts` varchar(255)
) ENGINE=OLAP
UNIQUE KEY(`id`)
    COMMENT 'OLAP'
    DISTRIBUTED BY HASH(`id`) BUCKETS 1
    PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

-- ----------------------------
-- Records of worker
-- ----------------------------
INSERT INTO `test`.`person` VALUES (1, 'zs', 18, NULL, '2022-04-07 12:38:42');
INSERT INTO `test`.`person` VALUES (2, 'ls', 16, 'good', '2022-04-07 12:38:55');
INSERT INTO `test`.`person` VALUES (3, 'ww', 22, NULL, '2022-04-07 12:39:10');
