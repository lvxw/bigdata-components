GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Database test
-- ----------------------------
DROP DATABASE IF EXISTS `test`;
CREATE DATABASE `test`;

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `test`.`worker`;
CREATE TABLE `test`.`worker`(
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of worker
-- ----------------------------
INSERT INTO `test`.`worker` VALUES (1, 'zs', 12.00, NULL, '2022-04-07 12:38:42');
INSERT INTO `test`.`worker` VALUES (2, 'ls', 45.00, 'good', '2022-04-07 12:38:55');
INSERT INTO `test`.`worker` VALUES (3, 'ww', 100.00, NULL, '2022-04-07 12:39:10');