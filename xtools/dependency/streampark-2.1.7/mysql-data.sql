/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

use streampark;

set names utf8mb4;
set foreign_key_checks = 0;


-- ----------------------------
-- Records of t_team
-- ----------------------------
insert into `t_team` values (100000, 'default', null, now(), now());


-- ----------------------------
-- Records of t_flink_app
-- ----------------------------
INSERT INTO `t_flink_app` VALUES (100000,100000,2,4,NULL,NULL,'Flink SQL Demo',NULL,NULL,NULL,NULL,NULL,NULL,'{}',NULL,100000,1,NULL,NULL,NULL,100001,NULL,'default',NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'Flink SQL Demo',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,'2026-09-10 15:27:32','2026-09-10 15:38:11',NULL,1,1,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'streampark,test');

-- ----------------------------
-- Records of t_flink_effective
-- ----------------------------
insert into `t_flink_effective` values (100000, 100000, 2, 100000, now());

-- ----------------------------
-- Records of t_flink_project
-- ----------------------------
insert into `t_flink_project` values (100000, 100000, 'streampark-quickstart', 'https://github.com/apache/streampark-quickstart', 'release-2.0.0', null, null, null, null, null, 1, 1, null, 'streampark-quickstart', -1, now(), now());

-- ----------------------------
-- Records of t_flink_sql
-- ----------------------------
insert into `t_flink_sql` values (100000, 100000, 'eNqlUUtPhDAQvu+vmFs1AYIHT5s94AaVqGxSSPZIKgxrY2mxrdGfb4GS3c0+LnJo6Mz36syapkmZQpk8vKbQMMt2KOFmAe5rK4Nf3yhrhCwvA1/TTDaqO61UxmooSprlT1PDGkgKEKpmwvIOjWVdP3W2zpG+JfQFHjfU46xxrVvYZuWztye1khJrqzSBFRCfjUwSYQiqt1xJJvyPcbWJp9WPCXvUoUEn0ZAVufcs0nIUjYn2L4s++YiY75eBLr+2Dnl3GYKTWRyfQKYRRR2XZxXmNvu9yh9GHAmUO/sxyMRkGNly4c714RZ7zaWtLHsX+N9NjvVrWxm99jmyvEhpOUhujmIYFI5zkCOYzYIj11a7QH7Tyz+nE8bw', null, 1, 1, now());

-- ----------------------------
-- Records of t_menu
-- ----------------------------
insert into `t_menu` values (110000, 0, 'menu.system', '/system', 'PageView', null, null, '0', 1, 3, now(), now());
insert into `t_menu` values (120000, 0, 'Apache Flink', '/flink', 'PageView', null, null, '0', 1, 1, now(), now());
insert into `t_menu` values (130000, 0, 'menu.setting', '/setting', 'PageView', null, null, '0', 1, 2, now(), now());

insert into `t_menu` values (110100, 110000, 'menu.userManagement', '/system/user', 'system/user/User', null, 'user', '0', 1, 1, now(), now());
insert into `t_menu` values (110200, 110000, 'menu.roleManagement', '/system/role', 'system/role/Role', null, 'smile', '0', 1, 2, now(), now());
insert into `t_menu` values (110300, 110000, 'menu.menuManagement', '/system/menu', 'system/menu/Menu', 'menu:view', 'bars', '0', 1, 3, now(), now());
insert into `t_menu` values (110400, 110000, 'menu.tokenManagement', '/system/token', 'system/token/Token', null, 'lock', '0', 1, 1, now(), now());
insert into `t_menu` values (110500, 110000, 'menu.teamManagement', '/system/team', 'system/team/Team', null, 'team', '0', 1, 2, now(), now());
insert into `t_menu` values (110600, 110000, 'menu.memberManagement', '/system/member', 'system/member/Member', null, 'usergroup-add', '0', 1, 2, now(), now());
insert into `t_menu` values (120100, 120000, 'menu.project', '/flink/project', 'flink/project/View', null, 'github', '0', 1, 1, now(), now());
insert into `t_menu` values (120200, 120000, 'menu.application', '/flink/app', 'flink/app/View', null, 'mobile', '0', 1, 2, now(), now());
insert into `t_menu` values (120300, 120000, 'menu.variable', '/flink/variable', 'flink/variable/View', null, 'code', '0', 1, 3, now(), now());
insert into `t_menu` values (130100, 130000, 'setting.system', '/setting/system', 'setting/System/index', null, 'database', '0', 1, 1, now(), now());
insert into `t_menu` values (130200, 130000, 'setting.alarm', '/setting/alarm', 'setting/Alarm/index', null, 'alert', '0', 1, 2, now(), now());
insert into `t_menu` values (130300, 130000, 'setting.flinkHome', '/setting/flinkHome', 'setting/FlinkHome/index', null, 'desktop', '0', 1, 3, now(), now());
insert into `t_menu` values (130400, 130000, 'setting.flinkCluster', '/setting/flinkCluster', 'setting/FlinkCluster/index', 'menu:view', 'cluster', '0', 1, 4, now(), now());
insert into `t_menu` values (130500, 130000, 'setting.externalLink', '/setting/externalLink', 'setting/ExternalLink/index', 'menu:view', 'link', '0', 1, 5, now(), now());
insert into `t_menu` values (130600, 130000, 'setting.yarnQueue', '/setting/yarnQueue', 'setting/YarnQueue/index', 'menu:view', 'bars', '0', 1, 6, now(), now());
insert into `t_menu` values (110101, 110100, 'add', null, null, 'user:add', null, '1', 1, null, now(), now());
insert into `t_menu` values (110102, 110100, 'update', null, null, 'user:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (110103, 110100, 'delete', null, null, 'user:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (110104, 110100, 'reset', null, null, 'user:reset', null, '1', 1, null, now(), now());
insert into `t_menu` values (110105, 110100, 'types', null, null, 'user:types', null, '1', 1, null, now(), now());
insert into `t_menu` values (110106, 110100, 'view', null, null, 'user:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (110201, 110200, 'add', null, null, 'role:add', null, '1', 1, null, now(), now());
insert into `t_menu` values (110202, 110200, 'update', null, null, 'role:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (110203, 110200, 'delete', null, null, 'role:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (110204, 110200, 'view', null, null, 'role:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (110401, 110400, 'add', null, null, 'token:add', null, '1', 1, null, now(), now());
insert into `t_menu` values (110402, 110400, 'delete', null, null, 'token:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (110403, 110400, 'view', null, null, 'token:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (110501, 110500, 'add', null, null, 'team:add', null, '1', 1, null, now(), now());
insert into `t_menu` values (110502, 110500, 'update', null, null, 'team:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (110503, 110500, 'delete', null, null, 'team:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (110504, 110500, 'view', null, null, 'team:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (110601, 110600, 'add', null, null, 'member:add', null, '1', 1, null, now(), now());
insert into `t_menu` values (110602, 110600, 'update', null, null, 'member:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (110603, 110600, 'delete', null, null, 'member:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (110604, 110600, 'role view', null, null, 'role:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (110605, 110600, 'view', null, null, 'member:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (120101, 120100, 'add', '/flink/project/add', 'flink/project/Add', 'project:create', '', '0', 0, null, now(), now());
insert into `t_menu` values (120102, 120100, 'build', null, null, 'project:build', null, '1', 1, null, now(), now());
insert into `t_menu` values (120103, 120100, 'delete', null, null, 'project:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120104, 120100, 'edit', '/flink/project/edit', 'flink/project/Edit', 'project:update', null, '0', 0, null, now(), now());
insert into `t_menu` values (120105, 120100, 'view', null, null, 'project:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (120201, 120200, 'add', '/flink/app/add', 'flink/app/Add', 'app:create', '', '0', 0, null, now(), now());
insert into `t_menu` values (120202, 120200, 'detail app', '/flink/app/detail', 'flink/app/Detail', 'app:detail', '', '0', 0, null, now(), now());
insert into `t_menu` values (120203, 120200, 'edit flink', '/flink/app/edit_flink', 'flink/app/EditFlink', 'app:update', '', '0', 0, null, now(), now());
insert into `t_menu` values (120204, 120200, 'edit streampark', '/flink/app/edit_streampark', 'flink/app/EditStreamPark', 'app:update', '', '0', 0, null, now(), now());
insert into `t_menu` values (120205, 120200, 'mapping', null, null, 'app:mapping', null, '1', 1, null, now(), now());
insert into `t_menu` values (120206, 120200, 'release', null, null, 'app:release', null, '1', 1, null, now(), now());
insert into `t_menu` values (120207, 120200, 'start', null, null, 'app:start', null, '1', 1, null, now(), now());
insert into `t_menu` values (120208, 120200, 'clean', null, null, 'app:clean', null, '1', 1, null, now(), now());
insert into `t_menu` values (120209, 120200, 'cancel', null, null, 'app:cancel', null, '1', 1, null, now(), now());
insert into `t_menu` values (120210, 120200, 'savepoint delete', null, null, 'savepoint:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120211, 120200, 'backup rollback', null, null, 'backup:rollback', null, '1', 1, null, now(), now());
insert into `t_menu` values (120212, 120200, 'backup delete', null, null, 'backup:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120213, 120200, 'conf delete', null, null, 'conf:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120214, 120200, 'delete', null, null, 'app:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120215, 120200, 'copy', null, null, 'app:copy', null, '1', 1, null, now(), now());
insert into `t_menu` values (120216, 120200, 'view', null, null, 'app:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (120217, 120200, 'savepoint trigger', null, null, 'savepoint:trigger', null, '1', 1, null, now(), now());
insert into `t_menu` values (120218, 120200, 'sql delete', null, null, 'sql:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (120301, 120300, 'add', NULL, NULL, 'variable:add', NULL, '1', 1, NULL, now(), now());
insert into `t_menu` values (120302, 120300, 'update', NULL, NULL, 'variable:update', NULL, '1', 1, NULL, now(), now());
insert into `t_menu` values (120303, 120300, 'delete', NULL, NULL, 'variable:delete', NULL, '1', 1, NULL, now(), now());
insert into `t_menu` values (120304, 120300, 'depend apps', '/flink/variable/depend_apps', 'flink/variable/DependApps', 'variable:depend_apps', '', '0', 0, NULL, now(), now());
insert into `t_menu` values (120305, 120300, 'show original', NULL, NULL, 'variable:show_original', NULL, '1', 1, NULL, now(), now());
insert into `t_menu` values (120306, 120300, 'view', NULL, NULL, 'variable:view', NULL, '1', 1, null, now(), now());
insert into `t_menu` values (120307, 120300, 'depend view', null, null, 'variable:depend_apps', null, '1', 1, NULL, now(), now());
insert into `t_menu` values (130101, 130100, 'view', null, null, 'setting:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (130102, 130100, 'setting update', null, null, 'setting:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (130401, 130400, 'add cluster', '/setting/add_cluster', 'setting/FlinkCluster/AddCluster', 'cluster:create', '', '0', 0, null, now(), now());
insert into `t_menu` values (130402, 130400, 'edit cluster', '/setting/edit_cluster', 'setting/FlinkCluster/EditCluster', 'cluster:update', '', '0', 0, null, now(), now());
insert into `t_menu` values (130501, 130500, 'link view', null, null, 'externalLink:view', null, '1', 1, null, now(), now());
insert into `t_menu` values (130502, 130500, 'link create', null, null, 'externalLink:create', null, '1', 1, null, now(), now());
insert into `t_menu` values (130503, 130500, 'link update', null, null, 'externalLink:update', null, '1', 1, null, now(), now());
insert into `t_menu` values (130504, 130500, 'link delete', null, null, 'externalLink:delete', null, '1', 1, null, now(), now());
insert into `t_menu` values (130601, 130600, 'add yarn queue', null, null, 'yarnQueue:create', '', '1', 0, null, now(), now());
insert into `t_menu` values (130602, 130600, 'edit yarn queue', null, null, 'yarnQueue:update', '', '1', 0, null, now(), now());
insert into `t_menu` values (130603, 130600, 'delete yarn queue', null, null, 'yarnQueue:delete', '', '1', 0, null, now(), now());

-- ----------------------------
-- Records of t_role
-- ----------------------------
insert into `t_role` values (100001, 'developer', now(), now(), 'developer');
insert into `t_role` values (100002, 'team admin', now(), now(), 'Team Admin has all permissions inside the team.');

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
insert into `t_role_menu` (role_id, menu_id) values (100001, 120000);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120100);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120101);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120102);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120104);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120105);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120200);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120201);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120202);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120203);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120204);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120206);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120207);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120208);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120209);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120210);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120211);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120212);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120213);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120215);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120216);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120217);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120300);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120304);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120306);
insert into `t_role_menu` (role_id, menu_id) values (100001, 120307);
insert into `t_role_menu` (role_id, menu_id) values (100001, 130000);
insert into `t_role_menu` (role_id, menu_id) values (100001, 130100);
insert into `t_role_menu` (role_id, menu_id) values (100001, 130101);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110000);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110600);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110601);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110602);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110603);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110604);
insert into `t_role_menu` (role_id, menu_id) values (100002, 110605);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120000);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120100);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120101);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120102);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120103);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120104);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120105);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120200);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120201);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120202);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120203);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120204);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120205);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120206);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120207);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120208);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120209);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120210);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120211);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120212);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120213);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120214);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120215);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120216);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120217);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120218);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120300);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120301);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120302);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120303);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120304);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120305);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120306);
insert into `t_role_menu` (role_id, menu_id) values (100002, 120307);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130000);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130100);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130101);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130200);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130300);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130400);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130401);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130402);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130500);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130501);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130502);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130503);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130504);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130600);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130601);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130602);
insert into `t_role_menu` (role_id, menu_id) values (100002, 130603);

-- ----------------------------
-- Records of t_setting
-- ----------------------------
insert into `t_setting` values (1, 'streampark.maven.settings', null, 'Maven Settings File Path', 'Maven Settings.xml full path', 1);
insert into `t_setting` values (2, 'streampark.maven.central.repository', null, 'Maven Central Repository', 'Maven private server address', 1);
insert into `t_setting` values (3, 'streampark.maven.auth.user', null, 'Maven Central Repository Auth User', 'Maven private server authentication username', 1);
insert into `t_setting` values (4, 'streampark.maven.auth.password', null, 'Maven Central Repository Auth Password', 'Maven private server authentication password', 1);
insert into `t_setting` values (5, 'alert.email.host', null, 'Alert Email Smtp Host', 'Alert Mailbox Smtp Host', 1);
insert into `t_setting` values (6, 'alert.email.port', null, 'Alert Email Smtp Port', 'Smtp Port of the alarm mailbox', 1);
insert into `t_setting` values (7, 'alert.email.from', null, 'Alert Sender Email', 'Email to send alerts', 1);
insert into `t_setting` values (8, 'alert.email.userName', null, 'Alert  Email User', 'Authentication username used to send alert emails', 1);
insert into `t_setting` values (9, 'alert.email.password', null, 'Alert Email Password', 'Authentication password used to send alarm email', 1);
insert into `t_setting` values (10, 'alert.email.ssl', 'false', 'Alert Email SSL', 'Whether to enable SSL in the mailbox that sends the alert', 2);
insert into `t_setting` values (11, 'docker.register.address', null, 'Docker Register Address', 'Docker container service address', 1);
insert into `t_setting` values (12, 'docker.register.user', null, 'Docker Register User', 'Docker container service authentication username', 1);
insert into `t_setting` values (13, 'docker.register.password', null, 'Docker Register Password', 'Docker container service authentication password', 1);
insert into `t_setting` values (14, 'docker.register.namespace', null, 'Docker namespace', 'Namespace for docker image used in docker building env and target image register', 1);
insert into `t_setting` values (15, 'ingress.mode.default', null, 'Ingress domain address', 'Automatically generate an nginx-based ingress by passing in a domain name', 1);

-- ----------------------------
-- Records of t_member
-- ----------------------------
insert into `t_member` values (100000, 100000, 100000, 100001, now(), now());

-- ----------------------------
-- Records of t_user
-- ----------------------------
insert into `t_user` values (100000, 'admin', '', 'rh8b1ojwog777yrg0daesf04gk', '2513f3748847298ea324dffbf67fe68681dd92315bda830065facd8efe08f54f', null, 1, 0, 100000, '1', now(), now(),null,0,null,null);

-- ----------------------------
-- Records of t_flink_env
-- ----------------------------
INSERT INTO `t_flink_env` (`id`, `flink_name`, `flink_home`, `version`, `scala_version`, `flink_conf`, `is_default`, `description`, `create_time`) VALUES (100001,'flink-1.20','/usr/local/flink-1.20.3/','1.20.3','2.12','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',1,NULL,'2026-09-10 14:27:29');

-- ----------------------------
-- Records of t_flink_cluster
-- ----------------------------
INSERT INTO `t_flink_cluster` (`id`, `address`, `cluster_id`, `cluster_name`, `options`, `yarn_queue`, `execution_mode`, `version_id`, `k8s_namespace`, `service_account`, `description`, `user_id`, `flink_image`, `dynamic_properties`, `k8s_rest_exposed_type`, `k8s_hadoop_integration`, `k8s_conf`, `resolve_order`, `exception`, `cluster_state`, `create_time`) VALUES (100000,NULL,NULL,'Flink-Yarn-Session','{}','default',3,100001,'default',NULL,NULL,100000,NULL,NULL,2,0,NULL,NULL,NULL,0,'2026-09-10 15:31:01');


set foreign_key_checks = 1;
