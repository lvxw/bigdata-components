-- ----------------------------
-- Database test
-- ----------------------------
DROP DATABASE IF EXISTS `test` cascade;
CREATE DATABASE `test`;

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `test`.`worker`;
CREATE TABLE `test`.`worker`(
  `id` int,
  `name` string,
  `salary` decimal(8,2),
  `desc` string,
  `ts` timestamp
);

-- ----------------------------
-- Records of worker
-- ----------------------------
INSERT INTO `test`.`worker` VALUES (1, 'zs', 12.00, NULL, '2022-04-07 12:38:42'), (2, 'ls', 45.00, 'good', '2022-04-07 12:38:55'), (3, 'ww', 100.00, NULL, '2022-04-07 12:39:10');