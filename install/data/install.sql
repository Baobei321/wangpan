-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2023-04-19 10:48:50
-- 服务器版本： 5.7.26
-- PHP 版本： 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------

--
-- 表的结构 `dzz_admincp_session`
--

DROP TABLE IF EXISTS `dzz_admincp_session`;
CREATE TABLE `dzz_admincp_session` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `adminid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `panel` tinyint(1) NOT NULL DEFAULT '0',
  `ip` char(40) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `errorcount` tinyint(1) NOT NULL DEFAULT '0',
  `storage` mediumtext default NULL,
  PRIMARY KEY (`uid`,`panel`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_market`
--

DROP TABLE IF EXISTS `dzz_app_market`;
CREATE TABLE `dzz_app_market` (
  `appid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '云端应用ID',
  `appname` varchar(255) NOT NULL,
  `appico` varchar(255) NOT NULL,
  `appdesc` text default NULL,
  `appurl` varchar(255) NOT NULL,
  `appadminurl` varchar(255) DEFAULT NULL COMMENT '管理设置地址',
  `noticeurl` varchar(255) NOT NULL DEFAULT '' COMMENT '通知接口地址',
  `dateline` int(10) UNSIGNED NOT NULL,
  `disp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `vendor` varchar(255) NOT NULL COMMENT '提供商',
  `haveflash` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `isshow` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否显示应用图标',
  `havetask` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否显示任务栏',
  `hideInMarket` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '应用市场里不显示',
  `feature` text default NULL COMMENT '窗体feature',
  `fileext` text default NULL COMMENT '可以打开的文件类型',
  `group` tinyint(1) NOT NULL DEFAULT '1' COMMENT '应用的分组:0:全部；-1:游客可用，3:系统管理员可用;2：部门管理员可用;1:所有成员可用',
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '可以使用的部门id，为0表示不限制',
  `position` tinyint(1) NOT NULL DEFAULT '0' COMMENT '2：desktop,3:taskbar,1：apparea',
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `notdelete` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '0',
  `nodup` tinyint(1) NOT NULL DEFAULT '0',
  `identifier` varchar(40) NOT NULL DEFAULT '',
  `app_path` varchar(50) DEFAULT NULL COMMENT 'APP路劲',
  `available` tinyint(1) NOT NULL DEFAULT '1',
  `version` varchar(20) NOT NULL DEFAULT '',
  `upgrade_version` text default NULL COMMENT '升级版本',
  `check_upgrade_time` int(11) NOT NULL DEFAULT '0' COMMENT '最近次检测升级时间',
  `extra` text default NULL,
  `uids` text COMMENT '访问用户',
  `showadmin` tinyint(3) UNSIGNED DEFAULT '0' COMMENT '0不显示在后台管理，1显示在后台管理',
  PRIMARY KEY (`appid`),
  UNIQUE KEY `appurl` (`appurl`) USING BTREE,
  KEY `available` (`available`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_open`
--

DROP TABLE IF EXISTS `dzz_app_open`;
CREATE TABLE `dzz_app_open` (
  `ext` varchar(255) NOT NULL DEFAULT '',
  `appid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `disp` smallint(6) NOT NULL DEFAULT '0',
  `extid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `isdefault` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`extid`),
  KEY `appid` (`appid`) USING BTREE,
  KEY `ext` (`ext`,`disp`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_open_default`
--

DROP TABLE IF EXISTS `dzz_app_open_default`;
CREATE TABLE `dzz_app_open_default` (
  `uid` int(10) UNSIGNED NOT NULL,
  `ext` varchar(255) NOT NULL DEFAULT '',
  `extid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `defaultext` (`ext`,`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_organization`
--

DROP TABLE IF EXISTS `dzz_app_organization`;
CREATE TABLE `dzz_app_organization` (
  `appid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) NOT NULL DEFAULT '0',
  UNIQUE KEY `orgid` (`appid`,`orgid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_pic`
--

DROP TABLE IF EXISTS `dzz_app_pic`;
CREATE TABLE `dzz_app_pic` (
  `picid` mediumint(8) NOT NULL AUTO_INCREMENT,
  `appid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` varchar(15) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`picid`),
  KEY `uid` (`uid`) USING BTREE,
  KEY `idtype` (`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_relative`
--

DROP TABLE IF EXISTS `dzz_app_relative`;
CREATE TABLE `dzz_app_relative` (
  `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tagid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `appid` (`appid`,`tagid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_tag`
--

DROP TABLE IF EXISTS `dzz_app_tag`;
CREATE TABLE `dzz_app_tag` (
  `tagid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hot` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `tagname` char(15) NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`tagid`),
  KEY `appid` (`hot`) USING BTREE,
  KEY `classid` (`tagname`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_app_user`
--

DROP TABLE IF EXISTS `dzz_app_user`;
CREATE TABLE `dzz_app_user` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lasttime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `num` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `appuser` (`appid`,`uid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_attach`
--

DROP TABLE IF EXISTS `dzz_attach`;
CREATE TABLE `dzz_attach` (
  `qid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT '0',
  `username` char(30) NOT NULL DEFAULT '',
  `fid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `filename` char(80) NOT NULL DEFAULT '',
  `area` char(15) NOT NULL DEFAULT '',
  `areaid` int(10) NOT NULL DEFAULT '0',
  `reversion` smallint(6) NOT NULL DEFAULT '0',
  `downloads` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deletetime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `deleteuid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`qid`),
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `tid` (`fid`) USING BTREE,
  KEY `area` (`area`) USING BTREE,
  KEY `areaid` (`areaid`,`area`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_attachment`
--

DROP TABLE IF EXISTS `dzz_attachment`;
CREATE TABLE `dzz_attachment` (
  `aid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` char(100) NOT NULL DEFAULT '',
  `filetype` char(15) NOT NULL DEFAULT '',
  `filesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `attachment` char(60) NOT NULL DEFAULT '',
  `remote` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `copys` smallint(6) NOT NULL DEFAULT '0',
  `md5` char(32) NOT NULL,
  `thumb` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `unrun` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`),
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `md5` (`md5`,`filesize`) USING BTREE,
  KEY `filetype` (`filetype`) USING BTREE,
  KEY `unrun` (`unrun`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_billfish_folderrecord`
--

DROP TABLE IF EXISTS `dzz_billfish_folderrecord`;
CREATE TABLE `dzz_billfish_folderrecord` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bfid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'billfish目录id',
  `fid` char(19) NOT NULL DEFAULT '' COMMENT 'pichome目录id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `bfid` (`bfid`,`appid`),
  KEY `fid` (`fid`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_billfish_record`
--

DROP TABLE IF EXISTS `dzz_billfish_record`;
CREATE TABLE `dzz_billfish_record` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `bid` int(11) UNSIGNED NOT NULL,
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '对应resources表id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `thumb` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '缩略图id',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `appid` (`appid`),
  KEY `bid` (`bid`,`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_billfish_taggrouprecord`
--

DROP TABLE IF EXISTS `dzz_billfish_taggrouprecord`;
CREATE TABLE `dzz_billfish_taggrouprecord` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `cid` char(19) NOT NULL DEFAULT '' COMMENT '标签分类id',
  `bcid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'billfish标签分类id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT 'appid',
  PRIMARY KEY (`id`),
  KEY `bcid` (`bcid`,`appid`),
  KEY `appid` (`appid`),
  KEY `cid` (`cid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_billfish_tagrecord`
--

DROP TABLE IF EXISTS `dzz_billfish_tagrecord`;
CREATE TABLE `dzz_billfish_tagrecord` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `lid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签id',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'billfish标签',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `btid` (`name`,`appid`),
  KEY `tid` (`lid`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_cache`
--

DROP TABLE IF EXISTS `dzz_cache`;
CREATE TABLE `dzz_cache` (
  `cachekey` varchar(255) NOT NULL DEFAULT '',
  `cachevalue` mediumblob NOT NULL,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`cachekey`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_collect`
--

DROP TABLE IF EXISTS `dzz_collect`;
CREATE TABLE `dzz_collect` (
  `cid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ourl` varchar(255) NOT NULL DEFAULT '',
  `data` text default NULL,
  `dateline` int(10) UNSIGNED NOT NULL,
  `copys` int(10) UNSIGNED NOT NULL,
  `type` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_connect`
--

DROP TABLE IF EXISTS `dzz_connect`;
CREATE TABLE `dzz_connect` (
  `name` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '',
  `secret` varchar(255) NOT NULL DEFAULT '',
  `type` varchar(255) NOT NULL COMMENT 'pan,mail,storage,web',
  `bz` varchar(255) NOT NULL COMMENT 'Dropbox,Box,Google,Aliyun,Grandcloud',
  `root` varchar(255) NOT NULL DEFAULT '',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否可用',
  `dname` varchar(255) NOT NULL COMMENT '数据库名称',
  `curl` varchar(255) NOT NULL COMMENT '授权地址',
  `disp` smallint(6) NOT NULL DEFAULT '0',
  UNIQUE KEY `bz` (`bz`) USING BTREE,
  KEY `disp` (`disp`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_connect_storage`
--

DROP TABLE IF EXISTS `dzz_connect_storage`;
CREATE TABLE `dzz_connect_storage` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL,
  `cloudname` varchar(255) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `perm` int(10) UNSIGNED NOT NULL DEFAULT '29751',
  `access_id` varchar(255) NOT NULL,
  `access_key` varchar(255) NOT NULL,
  `bucket` char(30) NOT NULL DEFAULT '',
  `bz` varchar(30) NOT NULL DEFAULT '',
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `internalhostname` varchar(255) NOT NULL DEFAULT '',
  `host` varchar(255) NOT NULL DEFAULT '',
  `internalhost` varchar(255) NOT NULL DEFAULT '',
  `extra` varchar(150) NOT NULL DEFAULT '',
  `mediastatus` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否开启媒体处理',
  `docstatus` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否开启文档处理',
  `imagestatus` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否开启图片处理',
  `disp` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `videoquality` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '视频转换质量',
  `specialext` text COMMENT '额外拓展参数',
  `isdefault` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认存储位置',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_cron`
--

DROP TABLE IF EXISTS `dzz_cron`;
CREATE TABLE `dzz_cron` (
  `cronid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `available` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('user','system','app') NOT NULL DEFAULT 'user',
  `name` char(50) NOT NULL DEFAULT '',
  `filename` char(50) NOT NULL DEFAULT '',
  `lastrun` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `nextrun` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `weekday` tinyint(1) NOT NULL DEFAULT '0',
  `day` tinyint(2) NOT NULL DEFAULT '0',
  `hour` tinyint(2) NOT NULL DEFAULT '0',
  `minute` char(36) NOT NULL DEFAULT '',
  PRIMARY KEY (`cronid`),
  KEY `nextrun` (`available`,`nextrun`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_district`
--

DROP TABLE IF EXISTS `dzz_district`;
CREATE TABLE `dzz_district` (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `level` tinyint(4) UNSIGNED NOT NULL DEFAULT '0',
  `usetype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `upid` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `displayorder` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `upid` (`upid`,`displayorder`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_document`
--

DROP TABLE IF EXISTS `dzz_document`;
CREATE TABLE `dzz_document` (
  `did` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` int(10) UNSIGNED NOT NULL,
  `fid` smallint(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文库分类id',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` char(30) NOT NULL DEFAULT '',
  `area` char(15) NOT NULL DEFAULT '',
  `areaid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `version` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `isdelete` tinyint(10) UNSIGNED NOT NULL DEFAULT '0',
  `disp` smallint(6) NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`did`),
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `disp` (`disp`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_document_event`
--

DROP TABLE IF EXISTS `dzz_document_event`;
CREATE TABLE `dzz_document_event` (
  `eid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `did` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `action` char(15) NOT NULL DEFAULT '',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` char(30) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`eid`),
  KEY `did` (`did`,`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_document_reversion`
--

DROP TABLE IF EXISTS `dzz_document_reversion`;
CREATE TABLE `dzz_document_reversion` (
  `did` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `revid` int(10) NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` varchar(30) NOT NULL DEFAULT '',
  `version` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `attachs` text default NULL,
  PRIMARY KEY (`revid`),
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `qid` (`did`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_eagle_folderrecord`
--

DROP TABLE IF EXISTS `dzz_eagle_folderrecord`;
CREATE TABLE `dzz_eagle_folderrecord` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `efid` char(64) NOT NULL DEFAULT '0' COMMENT 'eagle目录id',
  `fid` char(19) NOT NULL DEFAULT '' COMMENT 'pichome目录id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `bfid` (`efid`,`appid`),
  KEY `fid` (`fid`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_eagle_record`
--

DROP TABLE IF EXISTS `dzz_eagle_record`;
CREATE TABLE `dzz_eagle_record` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rid` char(32) NOT NULL DEFAULT '',
  `eid` char(64) NOT NULL DEFAULT '',
  `dateline` int(11) UNSIGNED DEFAULT '0' COMMENT '时间',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `eid` (`eid`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_failedlogin`
--

DROP TABLE IF EXISTS `dzz_failedlogin`;
CREATE TABLE `dzz_failedlogin` (
  `ip` char(40) NOT NULL DEFAULT '',
  `username` char(32) NOT NULL DEFAULT '',
  `count` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `lastupdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`ip`,`username`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_ffmpegimage_cache`
--

DROP TABLE IF EXISTS `dzz_ffmpegimage_cache`;
CREATE TABLE `dzz_ffmpegimage_cache` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '附件路径',
  `info` text COMMENT '数据值',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`,`path`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_form_setting`
--

DROP TABLE IF EXISTS `dzz_form_setting`;
CREATE TABLE `dzz_form_setting` (
  `flag` varchar(30) NOT NULL COMMENT '表单项标识符，不能重复',
  `labelname` varchar(60) NOT NULL DEFAULT '' COMMENT '表单名称',
  `type` varchar(30) NOT NULL DEFAULT 'input' COMMENT 'input:单行文本；textarea:多行文本；select:单选；multiselect:多选；date:日期类型；user:用户选择类型',
  `length` int(10) NOT NULL DEFAULT '0' COMMENT '限制长度，如果是上传类型单位为M',
  `regex` varchar(255) NOT NULL DEFAULT '' COMMENT '正则验证表达式',
  `multiple` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否支持多选，如果支持多选的话，最多可以选择几项',
  `options` text default NULL COMMENT '多选单选选项，数组形式序列化存储',
  `required` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为必填项',
  `extra` text default NULL COMMENT '其他扩展字段',
  `disp` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `system` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0:自定义；1：系统内置',
  `incard` tinyint(1) NOT NULL DEFAULT '0' COMMENT '在列表显示',
  `catid` int(10) NOT NULL DEFAULT '0' COMMENT '分类id',
  `filedtype` varchar(120) NOT NULL DEFAULT 'string' COMMENT '字段类型',
  `appid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '应用id,标识该字段归属应用，为用户自定义',
  `isdefault` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否为默认标注字段',
  `allowsearch` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '是否允许搜索，0不允许，1允许',
  `tabgroupid` int(11) UNSIGNED DEFAULT '0' COMMENT 'tabid',
  `filedcat` int(11) UNSIGNED DEFAULT '0' COMMENT '字段分类',
  `isdel` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`flag`),
  KEY `disp` (`disp`)
) ENGINE=MyISAM;

-- --------------------------------------------------------
DROP TABLE IF EXISTS `dzz_form_setting_filedcat`;
CREATE TABLE `dzz_form_setting_filedcat` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `catname` varchar(120) DEFAULT '' COMMENT '分类名称',
  `cat` int(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT '所属分类 1，tab,0系统',
  `disp` int(11) UNSIGNED DEFAULT '0' COMMENT '排序',
  `appid` int(11) UNSIGNED DEFAULT '0' COMMENT '库id',
  `tabgroupid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '卡片id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `tabgroupid` (`tabgroupid`) USING BTREE
) ENGINE=MyISAM;
--
-- 表的结构 `dzz_hooks`
--

DROP TABLE IF EXISTS `dzz_hooks`;
CREATE TABLE `dzz_hooks` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_market_id` int(11) NOT NULL COMMENT '应用ID',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text default NULL COMMENT '描述',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子对应程序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态1正常;-1删除',
  `priority` smallint(6) NOT NULL DEFAULT '0' COMMENT '运行优先级，挂载点下的钩子按优先级从高到低顺序执行',
  PRIMARY KEY (`id`),
  KEY `app_market_id` (`name`) USING BTREE,
  KEY `priority` (`priority`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_icon`
--

DROP TABLE IF EXISTS `dzz_icon`;
CREATE TABLE `dzz_icon` (
  `did` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) NOT NULL,
  `reg` varchar(255) NOT NULL DEFAULT '' COMMENT '匹配正则表达式',
  `ext` varchar(30) NOT NULL DEFAULT '',
  `pic` varchar(255) NOT NULL,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `check` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` varchar(255) NOT NULL,
  `copys` int(10) NOT NULL DEFAULT '0',
  `disp` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`did`),
  KEY `domain` (`domain`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `copys` (`copys`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_iconview`
--

DROP TABLE IF EXISTS `dzz_iconview`;
CREATE TABLE `dzz_iconview` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `width` smallint(6) UNSIGNED NOT NULL DEFAULT '64',
  `height` smallint(6) UNSIGNED NOT NULL DEFAULT '64',
  `divwidth` smallint(6) UNSIGNED NOT NULL DEFAULT '100',
  `divheight` smallint(6) UNSIGNED NOT NULL DEFAULT '100',
  `paddingtop` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `paddingleft` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `textlength` smallint(6) UNSIGNED NOT NULL DEFAULT '30',
  `align` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `avaliable` tinyint(1) UNSIGNED NOT NULL DEFAULT '1',
  `disp` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `cssname` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `avaliable` (`avaliable`,`disp`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_imagetype`
--

DROP TABLE IF EXISTS `dzz_imagetype`;
CREATE TABLE `dzz_imagetype` (
  `typeid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `available` tinyint(1) NOT NULL DEFAULT '0',
  `name` char(20) NOT NULL,
  `type` enum('smiley','icon','avatar') NOT NULL DEFAULT 'smiley',
  `displayorder` tinyint(3) NOT NULL DEFAULT '0',
  `directory` char(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_local_record`
--

DROP TABLE IF EXISTS `dzz_local_record`;
CREATE TABLE `dzz_local_record` (
  `id` char(32) NOT NULL DEFAULT '' COMMENT '主键id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '时间',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `path` blob COMMENT '路径',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `dateline` (`dateline`),
  KEY `rid` (`rid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_local_router`
--

DROP TABLE IF EXISTS `dzz_local_router`;
CREATE TABLE `dzz_local_router` (
  `routerid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(60) NOT NULL DEFAULT '',
  `remoteid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `router` text default NULL,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `available` tinyint(1) NOT NULL DEFAULT '0',
  `priority` smallint(6) UNSIGNED NOT NULL DEFAULT '100',
  PRIMARY KEY (`routerid`),
  KEY `priority` (`priority`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_local_storage`
--

DROP TABLE IF EXISTS `dzz_local_storage`;
CREATE TABLE `dzz_local_storage` (
  `remoteid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bz` varchar(255) NOT NULL COMMENT 'Dropbox,Box,Google,Aliyun,Grandcloud',
  `isdefault` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '默认',
  `dname` varchar(255) NOT NULL COMMENT '数据库名称',
  `did` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `disp` smallint(6) NOT NULL DEFAULT '0',
  `usesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `totalsize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastupdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`remoteid`),
  KEY `disp` (`disp`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_mailcron`
--

DROP TABLE IF EXISTS `dzz_mailcron`;
CREATE TABLE `dzz_mailcron` (
  `cid` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `touid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(100) NOT NULL DEFAULT '',
  `sendtime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`),
  KEY `sendtime` (`sendtime`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_mailqueue`
--

DROP TABLE IF EXISTS `dzz_mailqueue`;
CREATE TABLE `dzz_mailqueue` (
  `qid` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `subject` text default NULL,
  `message` text default NULL,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`qid`),
  KEY `mcid` (`cid`,`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_notification`
--

DROP TABLE IF EXISTS `dzz_notification`;
CREATE TABLE `dzz_notification` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `type` varchar(60) NOT NULL DEFAULT '',
  `new` tinyint(1) NOT NULL DEFAULT '0',
  `authorid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `author` varchar(30) NOT NULL DEFAULT '',
  `note` text default NULL,
  `wx_note` text default NULL,
  `wx_new` tinyint(1) NOT NULL DEFAULT '1',
  `redirecturl` varchar(255) NOT NULL DEFAULT '' COMMENT '跳转地址',
  `title` varchar(255) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `from_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `from_idtype` varchar(20) NOT NULL DEFAULT '',
  `from_num` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 提醒分类 1系统消息 0应用消息',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`,`new`) USING BTREE,
  KEY `category` (`uid`,`dateline`) USING BTREE,
  KEY `by_type` (`uid`,`type`,`dateline`) USING BTREE,
  KEY `from_id` (`from_id`,`from_idtype`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_onlinetime`
--

DROP TABLE IF EXISTS `dzz_onlinetime`;
CREATE TABLE `dzz_onlinetime` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `thismonth` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `total` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `lastupdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization`
--

DROP TABLE IF EXISTS `dzz_organization`;
CREATE TABLE `dzz_organization` (
  `orgid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orgname` varchar(255) NOT NULL DEFAULT '',
  `forgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `worgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `fid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `disp` smallint(6) NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `usesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `maxspacesize` bigint(20) NOT NULL DEFAULT '0' COMMENT '0：不限制，-1表示無空間',
  `indesk` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否创建快捷方式',
  `available` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `pathkey` varchar(255) NOT NULL DEFAULT '',
  `type` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0一般机构，1群组机构',
  `desc` varchar(200) NOT NULL DEFAULT '' COMMENT '群组描述',
  `groupback` int(11) UNSIGNED NOT NULL COMMENT '群组背景图',
  `aid` varchar(30) NOT NULL DEFAULT '' COMMENT '群组缩略图,可以是aid,也可以是颜色值',
  `manageon` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '群組管理员开启关闭0关闭，1开启',
  `syatemon` tinyint(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT '系统管理员开启群组，关闭群组，0关闭，1开启',
  `diron` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '群组管理员共享目录开启，0关闭，1开启',
  `extraspace` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '机构群组额外空间大小',
  `buyspace` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '购买空间',
  `allotspace` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分配空间大小',
  PRIMARY KEY (`orgid`),
  KEY `disp` (`disp`) USING BTREE,
  KEY `pathkey` (`pathkey`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization_admin`
--

DROP TABLE IF EXISTS `dzz_organization_admin`;
CREATE TABLE `dzz_organization_admin` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `opuid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `admintype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0管理员，1群组创始人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orgid` (`orgid`,`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization_guser`
--

DROP TABLE IF EXISTS `dzz_organization_guser`;
CREATE TABLE `dzz_organization_guser` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `guid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `opuid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `admintype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0:普通成员，1：管理员，2群组创始人',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orgid` (`orgid`,`guid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization_job`
--

DROP TABLE IF EXISTS `dzz_organization_job`;
CREATE TABLE `dzz_organization_job` (
  `jobid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `opuid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`jobid`),
  KEY `orgid` (`orgid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization_upjob`
--

DROP TABLE IF EXISTS `dzz_organization_upjob`;
CREATE TABLE `dzz_organization_upjob` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `jobid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) NOT NULL DEFAULT '0',
  `opuid` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_organization_user`
--

DROP TABLE IF EXISTS `dzz_organization_user`;
CREATE TABLE `dzz_organization_user` (
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `jobid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `orgid` (`orgid`,`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_banner`
--

DROP TABLE IF EXISTS `dzz_pichome_banner`;
CREATE TABLE `dzz_pichome_banner` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(11) UNSIGNED DEFAULT '0' COMMENT '栏目父级id',
  `icon` int(11) UNSIGNED DEFAULT '0' COMMENT '栏目图标',
  `bannername` varchar(255) DEFAULT NULL COMMENT '栏目名称',
  `btype` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '0,库栏目，1智能数据，2单页栏目，3链接栏目',
  `isbottom` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '0顶部导航，1底部导航',
  `isshow` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否显示',
  `dateline` int(11) UNSIGNED DEFAULT '0' COMMENT '添加时间，修改时间',
  `issystem` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否系统栏目',
  `bdata` varchar(255) DEFAULT NULL COMMENT '栏目数据',
  `pathkey` varchar(255) DEFAULT '' COMMENT '路径',
  `disp` int(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT '排序',
  `notallowedit` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否允许修改,默认允许修改',
  `showchildren` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否显示下级',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_bannertag`
--

DROP TABLE IF EXISTS `dzz_pichome_bannertag`;
CREATE TABLE `dzz_pichome_bannertag` (
  `tid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `bid` int(11) UNSIGNED DEFAULT '0' COMMENT '栏目id',
  `tagname` char(50) DEFAULT '' COMMENT '标签名称',
  `tagtype` int(11) UNSIGNED DEFAULT '0' COMMENT '标签类型',
  `tagval` text COMMENT '标签值',
  `disp` int(11) UNSIGNED DEFAULT '0' COMMENT '排序',
  `dateline` int(11) UNSIGNED DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_bannertagcat`
--

DROP TABLE IF EXISTS `dzz_pichome_bannertagcat`;
CREATE TABLE `dzz_pichome_bannertagcat` (
  `cid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `catname` char(30) NOT NULL DEFAULT '' COMMENT '模板分类名称',
  `cattype` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '模板分类类型',
  `cattag` char(30) DEFAULT '' COMMENT '分类标识',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_collect`
--

DROP TABLE IF EXISTS `dzz_pichome_collect`;
CREATE TABLE `dzz_pichome_collect` (
  `clid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '收藏夹id',
  `name` char(120) NOT NULL DEFAULT '' COMMENT '收藏名称',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '添加时间',
  `filenum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件数',
  `covert` text default NULL COMMENT '封面图地址',
  `covert1` text default NULL COMMENT '封面图地址1',
  `covert2` text default NULL COMMENT '封面图地址2',
  `lid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '封面地址1对应id',
  `lid1` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '封面地址2对应id',
  `lid2` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '封面地址3对应id',
  PRIMARY KEY (`clid`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `clid` (`clid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_collectcat`
--

DROP TABLE IF EXISTS `dzz_pichome_collectcat`;
CREATE TABLE `dzz_pichome_collectcat` (
  `cid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `pcid` int(11) UNSIGNED NOT NULL,
  `catname` char(120) NOT NULL DEFAULT '' COMMENT '分类名称',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '时间',
  `clid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏夹id',
  `filenum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类下文件数',
  `disp` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序方式',
  `pathkey` varchar(255) NOT NULL DEFAULT '' COMMENT '路径关系',
  PRIMARY KEY (`cid`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE,
  KEY `pcid` (`pcid`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `clid` (`clid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_collectevent`
--

DROP TABLE IF EXISTS `dzz_pichome_collectevent`;
CREATE TABLE `dzz_pichome_collectevent` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '操作用户名',
  `do` char(60) NOT NULL DEFAULT '' COMMENT '操作',
  `do_obj` varchar(60) NOT NULL DEFAULT '' COMMENT '操作对象',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0，操作，1评论',
  `eventbody` varchar(60) NOT NULL DEFAULT '' COMMENT '事体',
  `bodydata` text default NULL COMMENT '操作数据',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '操作时间',
  `state` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0对象存在，1已删除',
  `clid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏id',
  `cid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `do` (`do`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_collectlist`
--

DROP TABLE IF EXISTS `dzz_pichome_collectlist`;
CREATE TABLE `dzz_pichome_collectlist` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `clid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏夹id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `cid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '分类id',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '添加时间',
  `appid` char(32) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `clid` (`clid`) USING BTREE,
  KEY `cid` (`cid`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_collectuser`
--

DROP TABLE IF EXISTS `dzz_pichome_collectuser`;
CREATE TABLE `dzz_pichome_collectuser` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `clid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏夹id',
  `perm` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '权限值，1参与者，2协作成员，3，管理员,4创建者，5超级管理员',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `clid` (`clid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_comments`
--

DROP TABLE IF EXISTS `dzz_pichome_comments`;
CREATE TABLE `dzz_pichome_comments` (
  `id` char(19) NOT NULL DEFAULT '' COMMENT '标注id',
  `x` float(11,2) NOT NULL DEFAULT '0.00' COMMENT 'x轴位置',
  `y` float(11,2) NOT NULL DEFAULT '0.00' COMMENT 'y轴位置',
  `width` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '宽',
  `height` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '高度',
  `annotation` varchar(255) NOT NULL DEFAULT '' COMMENT '标注内容',
  `lastModified` char(13) NOT NULL DEFAULT '' COMMENT '最后更改时间',
  `appid` char(19) NOT NULL DEFAULT '' COMMENT '库id',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_ffmpeg_record`
--

DROP TABLE IF EXISTS `dzz_pichome_ffmpeg_record`;
CREATE TABLE `dzz_pichome_ffmpeg_record` (
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `stype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '0，获取信息；1获取缩略图',
  `ext` char(15) NOT NULL DEFAULT '' COMMENT '文件类型',
  `thumbdonum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '执行次数',
  `thumbstatus` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '缩略图是否完成',
  `infodonum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '获取信息执行次数',
  `infostatus` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '获取信息是否完成',
  `thumb` blob COMMENT '缩略图路径',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`rid`),
  KEY `thumbdonum` (`thumbdonum`) USING BTREE,
  KEY `infodonum` (`infodonum`) USING BTREE,
  KEY `thumbstatus` (`thumbstatus`,`infostatus`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_folder`
--

DROP TABLE IF EXISTS `dzz_pichome_folder`;
CREATE TABLE `dzz_pichome_folder` (
  `fid` char(19) NOT NULL COMMENT '目录id',
  `pfid` char(19) NOT NULL DEFAULT '' COMMENT '父级目录id',
  `fname` varchar(255) NOT NULL DEFAULT '' COMMENT '目录名称',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '对应库id',
  `perm` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '权限值',
  `pathkey` varchar(255) NOT NULL DEFAULT '' COMMENT '路径关系',
  `dateline` bigint(13) UNSIGNED NOT NULL DEFAULT '0' COMMENT '更新时间',
  `cover` char(32) NOT NULL DEFAULT '' COMMENT '封面，文件rid',
  `password` char(4) NOT NULL DEFAULT '' COMMENT '密码',
  `passwordtips` varchar(120) NOT NULL DEFAULT '' COMMENT '密码提示',
  `filenum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '包含文件数',
  `disp` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '目录排序',
  `level` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '默认权限',
  `tag` text COMMENT '目录标签列表',
  PRIMARY KEY (`fid`),
  KEY `pfid` (`pfid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `pathkey` (`pathkey`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_folderresources`
--

DROP TABLE IF EXISTS `dzz_pichome_folderresources`;
CREATE TABLE `dzz_pichome_folderresources` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `fid` char(19) NOT NULL DEFAULT '' COMMENT '目录id',
  `appid` char(19) NOT NULL DEFAULT '' COMMENT '库id',
  `pathkey` varchar(255) NOT NULL COMMENT '目录路径',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`) USING BTREE,
  KEY `fid` (`fid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE,
  KEY `pathkey` (`pathkey`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_foldertag`
--

DROP TABLE IF EXISTS `dzz_pichome_foldertag`;
CREATE TABLE `dzz_pichome_foldertag` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `fid` char(19) NOT NULL DEFAULT '' COMMENT '分类id',
  `tid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签id',
  PRIMARY KEY (`id`),
  KEY `fid` (`fid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_folder_tag`
--

DROP TABLE IF EXISTS `dzz_pichome_folder_tag`;
CREATE TABLE `dzz_pichome_folder_tag` (
 `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` char(6) DEFAULT '' COMMENT '库id',
  `tid` int(11) UNSIGNED DEFAULT NULL COMMENT '标签id',
  `hots` int(11) UNSIGNED DEFAULT '0' COMMENT '使用数',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_palette`
--

DROP TABLE IF EXISTS `dzz_pichome_palette`;
CREATE TABLE `dzz_pichome_palette` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `color` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '颜色整型值',
  `r` smallint(6) NOT NULL DEFAULT '0',
  `g` smallint(6) NOT NULL DEFAULT '0',
  `b` smallint(6) NOT NULL DEFAULT '0',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `weight` float(5,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '颜色百分比',
  `p` int(11) UNSIGNED DEFAULT NULL COMMENT '颜色调色板号',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`) USING BTREE,
  KEY `p` (`p`),
  KEY `weight` (`weight`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_resources`
--

DROP TABLE IF EXISTS `dzz_pichome_resources`;
CREATE TABLE `dzz_pichome_resources` (
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件主键id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名称',
  `type` char(15) NOT NULL DEFAULT '' COMMENT '文件类型',
  `ext` char(15) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `height` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '高度',
  `width` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '宽度',
  `dateline` bigint(13) UNSIGNED NOT NULL DEFAULT '0' COMMENT '修改时间',
  `hasthumb` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否有缩略图',
  `grade` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评分',
  `size` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT '大小',
  `mtime` bigint(13) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
  `isdelete` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否为删除状态',
  `btime` bigint(13) UNSIGNED NOT NULL COMMENT '添加时间',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5值',
  `lastdate` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '最后更改时间',
  `apptype` smallint(1) UNSIGNED DEFAULT '0' COMMENT '0，eagle文件；1，本地文件',
  `level` int(11) UNSIGNED DEFAULT '0' COMMENT '权限值',
  `fids` text COMMENT '文件目录数据',
  `thumbdonum` int(11) UNSIGNED DEFAULT '0' COMMENT '缩略图执行次数',
  `thumbdotime` int(11) UNSIGNED DEFAULT '0' COMMENT '缩略图执行时间',
  `lang` char(30) NOT NULL DEFAULT 'all' COMMENT '文件对应语言',
  PRIMARY KEY (`rid`),
  KEY `appid_2` (`appid`,`isdelete`) USING BTREE,
  KEY `mtime` (`mtime`) USING BTREE,
  KEY `btime` (`btime`) USING BTREE,
  KEY `dateline` (`dateline`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  KEY `ext` (`ext`) USING BTREE,
  KEY `height` (`height`,`width`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `level` (`level`),
  KEY `isdelete` (`isdelete`),
  KEY `namerid` (`name`,`rid`),
  KEY `datelinerid` (`dateline`,`rid`),
  KEY `mtimerid` (`mtime`,`rid`),
  KEY `btimerid` (`btime`,`rid`),
  KEY `sizerid` (`size`,`rid`),
  KEY `whrid` (`width`,`height`,`rid`),
  KEY `lang` (`lang`)  USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_resourcestag`
--

DROP TABLE IF EXISTS `dzz_pichome_resourcestag`;
CREATE TABLE `dzz_pichome_resourcestag` (
   `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签id',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_resources_attr`
--

DROP TABLE IF EXISTS `dzz_pichome_resources_attr`;
CREATE TABLE `dzz_pichome_resources_attr` (
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '应用id',
  `shape` char(10) NOT NULL DEFAULT '' COMMENT '图片形状',
  `gray` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否黑白色',
  `colors` text COMMENT '颜色值',
  `duration` float(11,2) UNSIGNED NOT NULL DEFAULT '0.00' COMMENT '时长',
  `desc` text COMMENT '描述',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '链接',
  `tag` text default NULL COMMENT '标签id',
  `path` blob NOT NULL COMMENT '路径',
  `isget` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已获取数据',
  `searchval` text COMMENT '关键词',
  `pathmd5` char(32) DEFAULT NULL COMMENT '对比md5',
  `getdonum` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '获取信息次数',
  `getinfotime` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '获取信息时间',
  `smallthumb` tinyint(1) DEFAULT '0' COMMENT '是否已生成小图缩略图',
  `largethumb` tinyint(1) DEFAULT NULL COMMENT '是否已生成大图缩略图',
  `thumbdonum` int(11) DEFAULT NULL COMMENT '缩略图执行次数',
  `thumbdotime` int(11) DEFAULT NULL COMMENT '缩略图最后一次执行时间',
  PRIMARY KEY (`rid`),
  KEY `appid` (`appid`) USING BTREE,
  KEY `duration` (`duration`) USING BTREE,
  KEY `isget` (`isget`) USING BTREE,
  KEY `pathmd5` (`pathmd5`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_resources_tag`
--

DROP TABLE IF EXISTS `dzz_pichome_resources_tag`;
CREATE TABLE `dzz_pichome_resources_tag` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `tid` int(11) UNSIGNED DEFAULT '0' COMMENT '标签id',
  `hots` int(11) UNSIGNED DEFAULT '0' COMMENT '标签使用数',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_searchrecent`
--

DROP TABLE IF EXISTS `dzz_pichome_searchrecent`;
CREATE TABLE `dzz_pichome_searchrecent` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词',
  `ktype` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '关键词类型，0普通关键词，1标签,2分类',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '搜索时间',
  `hots` int(11) UNSIGNED NOT NULL DEFAULT '1' COMMENT '搜索次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_share`
--

DROP TABLE IF EXISTS dzz_pichome_share;
CREATE TABLE IF NOT EXISTS dzz_pichome_share (
    id int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
    title varchar(120) NOT NULL DEFAULT '',
    filepath char(32) NOT NULL,
    appid char(6) NOT NULL DEFAULT '',
    dateline int(11) UNSIGNED NOT NULL DEFAULT '0',
    times smallint(6) UNSIGNED NOT NULL DEFAULT '0',
    endtime int(11) UNSIGNED NOT NULL DEFAULT '0',
    username char(60) NOT NULL DEFAULT '',
    uid int(11) UNSIGNED NOT NULL DEFAULT '0',
    password char(32) DEFAULT '',
    status tinyint(1) NOT NULL DEFAULT '0' COMMENT '-3:已屏蔽;-2：次数到；-1：已过期；0：正常	',
    count smallint(6) UNSIGNED NOT NULL DEFAULT '0',
    downloads smallint(6) UNSIGNED NOT NULL DEFAULT '0',
    views smallint(6) UNSIGNED NOT NULL DEFAULT '0',
    stype smallint(1) UNSIGNED NOT NULL DEFAULT '0',
    clid int(11) UNSIGNED NOT NULL DEFAULT '0',
    perm int(10) NOT NULL DEFAULT '1' COMMENT '分享权限',
    PRIMARY KEY (id),
    KEY appid (appid) USING BTREE,
    KEY uid (uid) USING BTREE,
    KEY dateline (dateline),
    KEY stype (stype)
    ) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_tag`
--

DROP TABLE IF EXISTS `dzz_pichome_tag`;
CREATE TABLE `dzz_pichome_tag` (
  `tid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签id',
  `tagname` varchar(120) NOT NULL DEFAULT '' COMMENT '标签名称',
  `hots` smallint(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '使用次数',
  `initial` varchar(1) NOT NULL DEFAULT '' COMMENT '标签首字母',
  `lang` char(30) NOT NULL DEFAULT 'zh-CN' COMMENT '默认语言',
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_taggroup`
--

DROP TABLE IF EXISTS `dzz_pichome_taggroup`;
CREATE TABLE `dzz_pichome_taggroup` (
  `cid` char(19) NOT NULL COMMENT '主键id',
  `catname` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `pcid` char(19) NOT NULL DEFAULT '0' COMMENT '父级分类id',
  `appid` char(13) NOT NULL DEFAULT '' COMMENT '应用id',
  `dateline` char(13) NOT NULL DEFAULT '0' COMMENT '最后修改时间',
  `disp` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`cid`),
  KEY `pcid` (`pcid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_tagrelation`
--

DROP TABLE IF EXISTS `dzz_pichome_tagrelation`;
CREATE TABLE `dzz_pichome_tagrelation` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '0主键id',
  `tid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签id',
  `cid` char(19) NOT NULL DEFAULT '' COMMENT '分类id',
  `appid` char(13) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`) USING BTREE
) ENGINE=MyISAM;

--
-- 表的结构 `dzz_pichome_templatepage`
--

DROP TABLE IF EXISTS `dzz_pichome_templatepage`;
CREATE TABLE `dzz_pichome_templatepage` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pagename` varchar(255) DEFAULT NULL COMMENT '单页名称',
  `dateline` int(11) DEFAULT NULL COMMENT '添加时间',
  `disp` int(11) UNSIGNED DEFAULT '1' COMMENT '排序',
  `issystem` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否为系统',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;



-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_templatetag`
--

DROP TABLE IF EXISTS `dzz_pichome_templatetag`;
CREATE TABLE `dzz_pichome_templatetag` (
  `tid` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '标签位id',
  `pageid` int(11) UNSIGNED DEFAULT '0' COMMENT '单页id',
  `tagflag` varchar(255) DEFAULT NULL COMMENT '模板标签标志',
  `tagname` varchar(255) DEFAULT NULL COMMENT '模板标签名称',
  `tagtype` varchar(255) DEFAULT '' COMMENT '模板标签类型',
  `tagval` text COMMENT '模板标签值',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `disp` int(11) UNSIGNED DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`tid`) USING BTREE,
  KEY `tid` (`tid`),
  KEY `disp` (`disp`)
) ENGINE=MyISAM;



-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_templatetagdata`
--

DROP TABLE IF EXISTS `dzz_pichome_templatetagdata`;
CREATE TABLE `dzz_pichome_templatetagdata` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tdataname` varchar(255) DEFAULT NULL COMMENT '数据名称',
  `tid` int(11) UNSIGNED DEFAULT NULL COMMENT '标签位id',
  `tdata` text COMMENT '数据',
  `disp` int(11) UNSIGNED DEFAULT '0' COMMENT '排序',
  `cachetime` int(11) UNSIGNED DEFAULT '0' COMMENT '缓存时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


--
-- 表的结构 `dzz_pichome_templatetagtheme`
--

DROP TABLE IF EXISTS `dzz_pichome_templatetagtheme`;
CREATE TABLE `dzz_pichome_templatetagtheme` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` int(11) UNSIGNED DEFAULT '0' COMMENT '单页模块id',
  `themeid` int(11) UNSIGNED DEFAULT '0' COMMENT '主题id',
  `style` varchar(255) DEFAULT NULL COMMENT '样式值',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;



-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_theme`
--

DROP TABLE IF EXISTS `dzz_pichome_theme`;
CREATE TABLE `dzz_pichome_theme` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `themename` varchar(255) DEFAULT NULL COMMENT '主题名称',
  `colors` text COMMENT '主题颜色选项',
  `templates` text COMMENT '单页列表',
  `selcolor` char(10) DEFAULT NULL COMMENT '当前主题色',
  `themestyle` text COMMENT '主题标签',
  `themefolder` char(50) DEFAULT NULL COMMENT '主题目录',
  `dateline` int(11) UNSIGNED DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_vapp`
--

DROP TABLE IF EXISTS `dzz_pichome_vapp`;
CREATE TABLE `dzz_pichome_vapp`  (
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `appname` varchar(255) NOT NULL DEFAULT '',
  `personal` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0公开，1私有',
  `path` blob NOT NULL COMMENT '对应目录路径',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `extra` text NULL COMMENT '拓展数据',
  `perm` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '权限值',
  `filenum` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件个数',
  `lastid` text NULL  COMMENT '最后执行位置id',
  `percent` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '导入百分比',
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0，未导入，1准备中，2导入中，3校验中，4已完成,-1导入失败',
  `filter` text NULL COMMENT '筛选项',
  `share` text default NULL COMMENT '分享权限',
  `download` text default NULL COMMENT '下载权限',
  `view` text default NULL COMMENT '访问权限',
  `donum` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '已导入文件数',
  `charset` char(15) NOT NULL DEFAULT '' COMMENT '库编码类型',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0，eagle库，1本地目录库，2，billfish库，3pichome库',
  `isdelete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否已删除',
  `sort` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序，值越大越靠前',
  `allowext` text NULL COMMENT '允许导入后缀',
  `notallowext` text NULL COMMENT '不允许后缀',
  `iswebsitefile` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否是站点下文件',
  `getinfonum` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '获取信息文件数',
  `getinfo` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否获取信息',
  `nosubfilenum` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '未分类文件总数',
  `disp` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `deluid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除用户id',
  `delusername` char(30) NOT NULL DEFAULT '' COMMENT '删除用户名',
  `version` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '版本号',
  `pagesetting` text NULL,
  `screen` text NULL,
  `crontype` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '计划任务运行方式，0，固定时间，1，固定频率',
  `crontime` char(36) NULL DEFAULT '' COMMENT '计划任务运行时间',
  `cronlast` int(11) NULL DEFAULT NULL COMMENT '最后一次运行时间',
  `cronrun` int(11) NULL DEFAULT NULL COMMENT '下次执行时间',
  `cron` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否开启0关闭',
  `fileds` text NULL COMMENT '标注设置',
  PRIMARY KEY (`appid`) USING BTREE
) ENGINE = MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_vappmember`
--

DROP TABLE IF EXISTS `dzz_pichome_vappmember`;
CREATE TABLE `dzz_pichome_vappmember` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '用户id',
  `appid` char(6) DEFAULT '' COMMENT '库id',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '添加时间',
  `perm` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '权限值,默认0，协作成员',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_pichome_vapp_tag`
--

DROP TABLE IF EXISTS `dzz_pichome_vapp_tag`;
CREATE TABLE `dzz_pichome_vapp_tag` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '标签id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  `hots` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '使用次数',
  PRIMARY KEY (`id`),
  KEY `tappid` (`tid`,`appid`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `dzz_pichome_resourcestab`;
CREATE TABLE `dzz_pichome_resourcestab`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `tid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '标签id',
  `gid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '标签组id',
  `appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE,
  KEY `tid` (`tid`) USING BTREE,
  KEY `gid` (`gid`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE
) ENGINE = MyISAM;
-- --------------------------------------------------------

DROP TABLE IF EXISTS `dzz_pichome_views`;
CREATE TABLE `dzz_pichome_views` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` char(6) DEFAULT NULL COMMENT '库id',
  `fid` char(19) DEFAULT '' COMMENT '目录id',
  `rid` char(32) DEFAULT NULL COMMENT '文件id',
  `filename` varchar(255) DEFAULT NULL COMMENT '文件名',
  `uid` int(11) UNSIGNED DEFAULT '0' COMMENT '用户id',
  `dateline` int(11) UNSIGNED DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `dateline` (`dateline`),
  KEY `fid` (`fid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_process`
--

DROP TABLE IF EXISTS `dzz_process`;
CREATE TABLE `dzz_process` (
  `processid` char(60) NOT NULL,
  `expiry` int(10) DEFAULT NULL,
  `extra` int(10) DEFAULT NULL,
  PRIMARY KEY (`processid`),
  KEY `expiry` (`expiry`) USING HASH
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_session`
--

DROP TABLE IF EXISTS `dzz_session`;
CREATE TABLE `dzz_session` (
  `sid` char(6) NOT NULL DEFAULT '',
  `ip1` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ip2` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ip3` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `ip4` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` char(15) NOT NULL DEFAULT '',
  `ip` char(40) NOT NULL DEFAULT '',
  `groupid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `invisible` tinyint(1) NOT NULL DEFAULT '0',
  `action` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `lastactivity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastolupdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `sid` (`sid`) USING HASH,
  KEY `uid` (`uid`) USING HASH
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_setting`
--

DROP TABLE IF EXISTS `dzz_setting`;
CREATE TABLE `dzz_setting` (
  `skey` varchar(255) NOT NULL DEFAULT '',
  `svalue` text default NULL,
  PRIMARY KEY (`skey`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_shorturl`
--

DROP TABLE IF EXISTS `dzz_shorturl`;
CREATE TABLE `dzz_shorturl` (
  `sid` char(10) NOT NULL,
  `url` text default NULL,
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_syscache`
--

DROP TABLE IF EXISTS `dzz_syscache`;
CREATE TABLE `dzz_syscache` (
  `cname` varchar(32) NOT NULL,
  `ctype` tinyint(3) UNSIGNED NOT NULL,
  `dateline` int(10) UNSIGNED NOT NULL,
  `data` mediumblob NOT NULL,
  PRIMARY KEY (`cname`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_thame`
--

DROP TABLE IF EXISTS `dzz_thame`;
CREATE TABLE `dzz_thame` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `folder` varchar(255) NOT NULL DEFAULT 'window_jd',
  `backimg` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `btype` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) NOT NULL,
  `default` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `disp` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `modules` text default NULL,
  `color` varchar(255) NOT NULL DEFAULT '',
  `enable_color` tinyint(1) NOT NULL DEFAULT '0',
  `vendor` varchar(255) NOT NULL,
  `version` varchar(15) NOT NULL DEFAULT '1.0',
  PRIMARY KEY (`id`),
  KEY `disp` (`disp`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_thumb_cache`
--

DROP TABLE IF EXISTS `dzz_thumb_cache`;
CREATE TABLE `dzz_thumb_cache`  (
  `id` char(32) NOT NULL DEFAULT '' COMMENT '主键id',
  `aid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '附件id',
  `width` int(11) NULL DEFAULT NULL COMMENT '宽度',
  `height` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '高度',
  `remoteid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '空间id',
  `path` char(150) NOT NULL DEFAULT '' COMMENT '缩略图路径',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后一次生成时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `aid` (`aid`) USING BTREE
) ENGINE = MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_thumb_record`
--

DROP TABLE IF EXISTS `dzz_thumb_record`;
CREATE TABLE `dzz_thumb_record`  (
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
  `filesize` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `width` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原图宽度',
  `height` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原图高度',
  `opath` varchar(255) NOT NULL DEFAULT '' COMMENT '原图地址',
  `lthumbtype` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '大图生成方式',
  `sthumbtype` tinyint(1) NOT NULL DEFAULT 1 COMMENT '小图生成方式',
  `lstatus` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未生成，1已生成，-1生成失败',
  `sstatus` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未生成，1已生成，-1生成失败',
  `lwidth` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大图宽度',
  `lheight` int(11) NOT NULL DEFAULT 0 COMMENT '大图高度',
  `lwaterposition` tinyint(1) NOT NULL DEFAULT 0 COMMENT '大图水印位置',
  `lwatertype` tinyint(1) NOT NULL DEFAULT 0 COMMENT '大图水印类型',
  `lwatercontent` varchar(255) NOT NULL DEFAULT '' COMMENT '大图水印内容',
  `swidth` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图宽度',
  `sheight` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图高度',
  `swaterposition` tinyint(1) NOT NULL DEFAULT 0 COMMENT '小图水印位置',
  `swatertype` tinyint(1) NOT NULL DEFAULT 0 COMMENT '小图水印类型',
  `swatercontent` varchar(255) NOT NULL DEFAULT '' COMMENT '小图水印内容',
  `lpath` char(150) NOT NULL DEFAULT '' COMMENT '大图地址',
  `spath` char(150) NOT NULL DEFAULT '' COMMENT '小图地址',
  `ltimes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图执行次数',
  `stimes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大图执行次数',
  `ext` varchar(30) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `isupload` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为上传文件图标 0不是，1是',
  `sdateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图最后一次执行时间',
  `ldateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大图最后执行时间',
  `checktime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '检查缩略图时间',
  `schk` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '需要更新小图',
  `lchk` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '需要更新大图',
  `schktimes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图更新次数',
  `lchktimes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大图更新次数',
  `sremoteid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '存储位置id',
  `lremoteid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '存储位置id',
  `oremoteid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '存储位置id',
  `scacheid` char(32) NOT NULL DEFAULT '' COMMENT '小图缓存id',
  `lcacheid` char(32) NOT NULL DEFAULT '' COMMENT '大图缓存id',
  `ocacheid` char(32) NOT NULL DEFAULT '' COMMENT '原图缓存id',
  PRIMARY KEY (`rid`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE,
  KEY `sstatus` (`sstatus`) USING BTREE,
  KEY `lstatus` (`lstatus`) USING BTREE
) ENGINE = MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user`
--

DROP TABLE IF EXISTS `dzz_user`;
CREATE TABLE `dzz_user` (
  `uid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` char(60) NOT NULL DEFAULT '',
  `phone` varchar(255) NOT NULL DEFAULT '',
  `weixinid` varchar(255) NOT NULL DEFAULT '' COMMENT '微信号',
  `wechat_userid` varchar(255) NOT NULL DEFAULT '',
  `wechat_status` tinyint(1) NOT NULL DEFAULT '4' COMMENT '1:已关注；2：已冻结；4：未关注',
  `nickname` char(30) NOT NULL DEFAULT '',
  `username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `phonestatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '手机绑定状态',
  `emailsenddate` varchar(50) NOT NULL DEFAULT '0',
  `emailstatus` tinyint(1) NOT NULL DEFAULT '0' COMMENT '邮箱绑定状态',
  `avatarstatus` tinyint(1) NOT NULL DEFAULT '0',
  `adminid` tinyint(1) NOT NULL DEFAULT '0',
  `groupid` smallint(6) UNSIGNED NOT NULL DEFAULT '9',
  `language` varchar(12) NOT NULL DEFAULT 'zh-cn' COMMENT '语言',
  `regip` char(40) NOT NULL DEFAULT '',
  `regdate` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `secques` char(8) NOT NULL DEFAULT '',
  `salt` char(6) NOT NULL DEFAULT '',
  `authstr` char(30) NOT NULL DEFAULT '',
  `newprompt` smallint(6) UNSIGNED NOT NULL DEFAULT '0' COMMENT '消息数',
  `timeoffset` char(4) NOT NULL DEFAULT '9999',
  `grid` smallint(6) NOT NULL DEFAULT '0',
  `uploads` int(11) NOT NULL DEFAULT '0',
  `downloads` smallint(6) NOT NULL DEFAULT '0',
  `collects` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  KEY `groupid` (`groupid`) USING BTREE,
  KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_usergroup`
--

DROP TABLE IF EXISTS `dzz_usergroup`;
CREATE TABLE `dzz_usergroup` (
  `groupid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `radminid` tinyint(3) NOT NULL DEFAULT '0',
  `type` enum('system','special','member') NOT NULL DEFAULT 'member',
  `system` varchar(255) NOT NULL DEFAULT 'private',
  `grouptitle` varchar(255) NOT NULL DEFAULT '',
  `creditshigher` int(10) NOT NULL DEFAULT '0',
  `creditslower` int(10) NOT NULL DEFAULT '0',
  `stars` tinyint(3) NOT NULL DEFAULT '0',
  `color` varchar(255) NOT NULL DEFAULT '',
  `icon` varchar(255) NOT NULL DEFAULT '',
  `allowvisit` tinyint(1) NOT NULL DEFAULT '0',
  `allowsendpm` tinyint(1) NOT NULL DEFAULT '1',
  `allowinvite` tinyint(1) NOT NULL DEFAULT '0',
  `allowmailinvite` tinyint(1) NOT NULL DEFAULT '0',
  `maxinvitenum` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `inviteprice` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `maxinviteday` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `creditsrange` (`creditshigher`,`creditslower`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_usergroup_field`
--

DROP TABLE IF EXISTS `dzz_usergroup_field`;
CREATE TABLE `dzz_usergroup_field` (
  `groupid` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `maxspacesize` int(10) NOT NULL DEFAULT '0',
  `attachextensions` varchar(255) NOT NULL,
  `maxattachsize` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `perm` int(10) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `groupid` (`groupid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_field`
--

DROP TABLE IF EXISTS `dzz_user_field`;
CREATE TABLE `dzz_user_field` (
  `uid` int(10) UNSIGNED NOT NULL,
  `docklist` text default NULL,
  `screenlist` text default NULL,
  `applist` text default NULL,
  `noticebanlist` text default NULL,
  `iconview` tinyint(1) NOT NULL DEFAULT '2',
  `iconposition` tinyint(1) NOT NULL DEFAULT '0',
  `direction` tinyint(1) NOT NULL DEFAULT '0',
  `autolist` tinyint(1) NOT NULL DEFAULT '1',
  `taskbar` enum('bottom','left','top','right') NOT NULL DEFAULT 'bottom',
  `dateline` int(10) UNSIGNED NOT NULL,
  `updatetime` int(10) UNSIGNED NOT NULL,
  `attachextensions` varchar(255) NOT NULL DEFAULT '-1',
  `maxattachsize` int(10) NOT NULL DEFAULT '-1',
  `usesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `addsize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `buysize` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `wins` text default NULL,
  `perm` int(10) NOT NULL DEFAULT '0',
  `privacy` text default NULL,
  `userspace` int(11) NOT NULL DEFAULT '0' COMMENT '用户空间大小，-1表示无空间，0表示不限制',
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_profile`
--

DROP TABLE IF EXISTS `dzz_user_profile`;
CREATE TABLE `dzz_user_profile` (
  `uid` int(10) UNSIGNED NOT NULL,
  `fieldid` varchar(30) NOT NULL DEFAULT '',
  `value` text default NULL,
  `privacy` smallint(3) NOT NULL DEFAULT '0' COMMENT '资料权限',
  PRIMARY KEY (`uid`,`fieldid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_profile_setting`
--

DROP TABLE IF EXISTS `dzz_user_profile_setting`;
CREATE TABLE `dzz_user_profile_setting` (
  `fieldid` varchar(255) NOT NULL DEFAULT '',
  `available` tinyint(1) NOT NULL DEFAULT '0',
  `invisible` tinyint(1) NOT NULL DEFAULT '0',
  `needverify` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `displayorder` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `unchangeable` tinyint(1) NOT NULL DEFAULT '0',
  `showincard` tinyint(1) NOT NULL DEFAULT '0',
  `showinthread` tinyint(1) NOT NULL DEFAULT '0',
  `showinregister` tinyint(1) NOT NULL DEFAULT '0',
  `allowsearch` tinyint(1) NOT NULL DEFAULT '0',
  `formtype` varchar(255) NOT NULL DEFAULT 'text',
  `size` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  `choices` text default NULL,
  `privacy` smallint(3) NOT NULL DEFAULT '0' COMMENT '资料权限',
  `validate` text default NULL,
  `customable` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`fieldid`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_setting`
--

DROP TABLE IF EXISTS `dzz_user_setting`;
CREATE TABLE `dzz_user_setting` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(10) UNSIGNED NOT NULL COMMENT '用户id',
  `skey` varchar(30) NOT NULL DEFAULT '' COMMENT '用户设置选项键',
  `svalue` text COMMENT '用户设置值',
  PRIMARY KEY (`id`),
  UNIQUE KEY `skey` (`skey`,`uid`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_status`
--

DROP TABLE IF EXISTS `dzz_user_status`;
CREATE TABLE `dzz_user_status` (
  `uid` int(10) UNSIGNED NOT NULL,
  `regip` char(40) NOT NULL DEFAULT '',
  `lastip` char(40) NOT NULL DEFAULT '',
  `lastvisit` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastactivity` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `lastsendmail` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `invisible` tinyint(1) NOT NULL DEFAULT '0',
  `profileprogress` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `lastactivity` (`lastactivity`,`invisible`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_thame`
--

DROP TABLE IF EXISTS `dzz_user_thame`;
CREATE TABLE `dzz_user_thame` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `custom_backimg` varchar(255) NOT NULL,
  `custom_url` varchar(255) NOT NULL,
  `custom_btype` tinyint(1) UNSIGNED NOT NULL,
  `custom_color` varchar(255) NOT NULL DEFAULT '',
  `thame` smallint(6) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_verify`
--

DROP TABLE IF EXISTS `dzz_user_verify`;
CREATE TABLE `dzz_user_verify` (
  `uid` int(10) UNSIGNED NOT NULL,
  `verify1` tinyint(1) NOT NULL DEFAULT '0' COMMENT '-1:已拒绝，0：待审核，1认证通过',
  `verify2` tinyint(1) NOT NULL DEFAULT '0',
  `verify3` tinyint(1) NOT NULL DEFAULT '0',
  `verify4` tinyint(1) NOT NULL DEFAULT '0',
  `verify5` tinyint(1) NOT NULL DEFAULT '0',
  `verify6` tinyint(1) NOT NULL DEFAULT '0',
  `verify7` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `verify1` (`verify1`) USING BTREE,
  KEY `verify2` (`verify2`) USING BTREE,
  KEY `verify3` (`verify3`) USING BTREE,
  KEY `verify4` (`verify4`) USING BTREE,
  KEY `verify5` (`verify5`) USING BTREE,
  KEY `verify6` (`verify6`) USING BTREE,
  KEY `verify7` (`verify7`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_verify_info`
--

DROP TABLE IF EXISTS `dzz_user_verify_info`;
CREATE TABLE `dzz_user_verify_info` (
  `vid` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` varchar(30) NOT NULL DEFAULT '',
  `verifytype` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 审核类型0:资料审核, 1:认证1, 2:认证2, 3:认证3, 4:认证4, 5:认证5',
  `flag` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' -1:被拒绝 0:待审核 1:审核通过',
  `field` text default NULL,
  `orgid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`vid`),
  KEY `verifytype` (`verifytype`,`flag`) USING BTREE,
  KEY `uid` (`uid`,`verifytype`,`dateline`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_user_wechat`
--

DROP TABLE IF EXISTS `dzz_user_wechat`;
CREATE TABLE `dzz_user_wechat` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `openid` char(28) NOT NULL DEFAULT '',
  `appid` char(18) NOT NULL DEFAULT '',
  `unionid` char(29) NOT NULL DEFAULT '',
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT '0',
  UNIQUE KEY `uid` (`uid`) USING BTREE,
  UNIQUE KEY `openid` (`openid`,`appid`) USING BTREE
) ENGINE=MyISAM;

-- --------------------------------------------------------

--
-- 表的结构 `dzz_video_record`
--

DROP TABLE IF EXISTS `dzz_video_record`;
CREATE TABLE IF NOT EXISTS `dzz_video_record` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '唯一id',
  `aid` int(11) UNSIGNED DEFAULT '0' COMMENT '附件id',
  `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件rid',
  `path` char(200) NOT NULL DEFAULT '' COMMENT '文件路径',
  `ctype` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '转换方式，0本地，1阿里云，2腾讯云',
  `status` smallint(1) NOT NULL DEFAULT '0' COMMENT '视频状态，0未转换，1转换中，2转换成功，-1转换失败',
  `endtime` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '转换成功时间',
  `dateline` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '时间',
  `jobid` char(34) NOT NULL DEFAULT '' COMMENT '任务id,腾讯云长度33位，阿里云长度32位',
  `waterstatus` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '水印状态',
  `waterid` char(34) NOT NULL DEFAULT '' COMMENT '水印id,腾讯云34位，阿里云32位',
  `templateid` char(34) NOT NULL DEFAULT '' COMMENT '模板id腾讯云长度34,阿里云长度32',
  `width` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '视频宽度',
  `height` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '视频高度',
  `format` char(30) NOT NULL DEFAULT '' COMMENT '格式',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT '百分比',
  `jobnum` smallint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '尝试转换次数',
  `error` char(60) NOT NULL DEFAULT '' COMMENT '错误信息',
  `videoquality` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT '视频质量',
  `remoteid` int(11) UNSIGNED DEFAULT '0' COMMENT '文件空间位置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `awaf` (`rid`,`width`,`waterstatus`,`format`) USING BTREE
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_pichome_route`;
CREATE TABLE `dzz_pichome_route` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT '' COMMENT '原始路径',
  `path` varchar(255) DEFAULT NULL COMMENT '映射路径',
  `dateline` int(11) UNSIGNED DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_pichome_resourcestab`;
CREATE TABLE `dzz_pichome_resourcestab` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rid` char(32) DEFAULT '' COMMENT '文件id',
  `tid` int(11) UNSIGNED DEFAULT '0' COMMENT '标签id',
  `gid` int(11) UNSIGNED DEFAULT '0' COMMENT '标签组id',
  `appid` char(6) DEFAULT '' COMMENT '库id',
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `tid` (`tid`),
  KEY `gid` (`gid`),
  KEY `appid` (`appid`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_tab_rangedate`;
CREATE TABLE `dzz_tab_rangedate` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `start` int(11) UNSIGNED DEFAULT '0' COMMENT '开始时间',
  `end` int(11) UNSIGNED DEFAULT '0' COMMENT '结束时间',
  `tid` int(11) UNSIGNED DEFAULT '0' COMMENT '卡片id',
  `filedname` varchar(120) DEFAULT NULL COMMENT '字段名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;
--
-- 表的结构 `dzz_keyword_hots`
--

DROP TABLE IF EXISTS `dzz_keyword_hots`;
CREATE TABLE `dzz_keyword_hots` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idtype` smallint(1) UNSIGNED DEFAULT '0' COMMENT '0,库统计，1标签组统计，2项目关键词统计,3全部搜索',
  `idval` char(11) DEFAULT NULL COMMENT '库id或者标签组id',
  `keyword` char(60) DEFAULT NULL COMMENT '关键词',
  `nums` int(11) UNSIGNED DEFAULT '0' COMMENT '搜索热度',
   PRIMARY KEY (`id`)
) ENGINE=MyISAM;


-- --------------------------------------------------------

DROP TABLE IF EXISTS `dzz_stats_keyword`;
CREATE TABLE `dzz_stats_keyword` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`keyword` char(60) NOT NULL DEFAULT '' COMMENT '关键词',
`idtype` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0,库统计，1标签组统计，2项目关键词统计,3全部搜索',
`idval` char(11) NOT NULL DEFAULT '0' COMMENT '库id或标签组id或标签id',
`uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
`isadmin` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否是管理端',
`username` char(30) NOT NULL DEFAULT '' COMMENT '用户名',
`dateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '时间',
PRIMARY KEY (`id`) USING BTREE,
KEY `keyword` (`keyword`) USING BTREE,
KEY `gid` (`idval`) USING BTREE,
KEY `username` (`username`) USING BTREE,
KEY `uid` (`uid`) USING BTREE
) ENGINE = MyISAM;

-- ----------------------------
-- Table structure for pichome_stats_token
-- ----------------------------
DROP TABLE IF EXISTS `dzz_stats_token`;
CREATE TABLE `dzz_stats_token` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`uid` int(11) UNSIGNED NULL DEFAULT 0,
`dateline` int(11) UNSIGNED NULL DEFAULT 0,
`gettype` tinyint(1) NOT NULL COMMENT '根据app定义，如果为图片理解0为获取标签，1为描述；对话则为0',
`app` varchar(255) NULL DEFAULT NULL COMMENT '应用，暂时记录为应用名称',
`totaltoken` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '消耗token总数',
PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM;

-- ----------------------------
-- Table structure for dzz_stats_userlogin
-- ----------------------------
DROP TABLE IF EXISTS `dzz_stats_userlogin`;
CREATE TABLE `dzz_stats_userlogin`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
`username` char(30)  NOT NULL DEFAULT '' COMMENT '用户名',
`ip` char(40) NOT NULL  DEFAULT '' COMMENT '登录ip',
`dateline` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '登录时间',
`machine` char(15) NOT NULL  DEFAULT '' COMMENT '登录设备',
`isadmin` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否为后端登录',
`msg` varchar(255) NOT NULL  DEFAULT '' COMMENT '登录提示信息',
PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM;

-- ----------------------------
-- Table structure for dzz_stats_view
-- ----------------------------
DROP TABLE IF EXISTS `dzz_stats_view`;
CREATE TABLE `dzz_stats_view`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`idtype` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0文件，1文件下载，2卡片,3上传统计',
`idval` char(32)  NOT NULL DEFAULT '0' COMMENT 'id值',
`name` char(120) NOT NULL DEFAULT '' COMMENT '名字',
`uid` int(11) NOT NULL COMMENT '用户id',
`username` char(30)  NOT NULL DEFAULT '' COMMENT '用户名',
`isadmin` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否后端访问',
`dateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '时间',
`ip` char(40) NOT NULL DEFAULT '' COMMENT 'ip地址',
PRIMARY KEY (`id`) USING BTREE,
KEY `idtype` (`idtype`) USING BTREE,
KEY `uid` (`uid`) USING BTREE,
KEY `username` (`username`) USING BTREE,
KEY `idval` (`idval`) USING BTREE
) ENGINE = MyISAM;

--
-- 表的结构 `dzz_views`
--

DROP TABLE IF EXISTS `dzz_views`;
CREATE TABLE `dzz_views` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idtype` smallint(1) UNSIGNED DEFAULT '0' COMMENT '0文件浏览，1文件下载，2卡片浏览',
  `idval` char(32) DEFAULT NULL COMMENT 'id值',
  `nums` int(11) UNSIGNED DEFAULT '0' COMMENT '次数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `dzz_my_file`;
CREATE TABLE `dzz_my_file` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `username` char(30) NOT NULL DEFAULT '',
  `source` varchar(30) NOT NULL DEFAULT '' COMMENT '来源',
  `aid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '文件AID',
  `filetype` char(15) NOT NULL DEFAULT '' COMMENT '文件类型',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名称',
  `dateline` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (id)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_search_template`;
CREATE TABLE dzz_search_template (
    tid int(10) NOT NULL AUTO_INCREMENT COMMENT '模板TID自增',
    title varchar(255) NOT NULL DEFAULT '' COMMENT '模板名称',
    data text default NULL,
    screen text default NULL COMMENT '筛选项',
    pagesetting text default NULL COMMENT '偏好设置',
    searchRange text default NULL COMMENT '搜索范围',
    exts text default NULL COMMENT '限制的文件后缀',
    dateline int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '创建时间',
    disp smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
    PRIMARY KEY (tid),
    KEY disp (disp,dateline) USING BTREE
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_language`;
CREATE TABLE `dzz_language` (
`langflag` char(30) NOT NULL DEFAULT '' COMMENT '语言标识',
`isdefault` tinyint(1) unsigned DEFAULT '0' COMMENT '是否默认',
`state` tinyint(1) unsigned DEFAULT '0' COMMENT '是否开启',
PRIMARY KEY (`langflag`) USING BTREE
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang`;
CREATE TABLE `dzz_lang` (
`skey` varchar(255) NOT NULL,
`idtype` tinyint(1) NOT NULL COMMENT '0,文件，1tab字段，2tab字段值，3标签分类,4标签，5库',
`svalue` mediumtext,
`idvalue` char(32) DEFAULT NULL COMMENT 'id值',
`valtype` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '0值，1搜索',
`filed` varchar(100) DEFAULT '' COMMENT '字段值',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
`deldate` int(11) unsigned DEFAULT '0' COMMENT '删除时间',
PRIMARY KEY (`skey`) USING BTREE,
KEY `idtype` (`idtype`),
KEY `idval` (`idvalue`),
KEY `valtype` (`valtype`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_en_us`;
CREATE TABLE `dzz_lang_en_us` (
`skey` VARCHAR ( 255 ) NOT NULL,
`idtype` TINYINT ( 1 ) NOT NULL,
`idvalue` CHAR ( 32 ) DEFAULT NULL,
`svalue` MEDIUMTEXT,
`valtype` TINYINT ( 1 ) UNSIGNED DEFAULT '0',
`filed` VARCHAR ( 100 ) DEFAULT '' COMMENT '字段值',
`dateline` INT ( 11 ) UNSIGNED DEFAULT '0' COMMENT '更新时间',
`deldate` INT ( 11 ) UNSIGNED DEFAULT '0' COMMENT '删除时间',
`chkdate` INT ( 11 ) UNSIGNED DEFAULT '0' COMMENT '检测时间',
PRIMARY KEY ( `skey` ) USING BTREE,
KEY `idtype` ( `idtype` ),
KEY `idvalue` ( `idvalue` ),
KEY `valtype` ( `valtype` )
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_zh_cn`;
CREATE TABLE `dzz_lang_zh_cn` (
`skey` varchar(255) NOT NULL,
`idtype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0,文件，1tab字段，2tab字段值，3标签分类,4标签，5库',
`idvalue` char(32) DEFAULT NULL,
`svalue` mediumtext,
`valtype` tinyint(1) unsigned DEFAULT '0',
`filed` varchar(100) DEFAULT '' COMMENT '字段值',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
`deldate` int(11) unsigned DEFAULT '0' COMMENT '删除时间',
`chkdate` int(11) unsigned DEFAULT '0' COMMENT '检查时间',
PRIMARY KEY (`skey`) USING BTREE,
KEY `idtype` (`idtype`),
KEY `idvalue` (`idvalue`),
KEY `valtype` (`valtype`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_search`;
CREATE TABLE `dzz_lang_search` (
`skey` varchar(100) NOT NULL,
`idtype` tinyint(1) unsigned DEFAULT '0',
`idvalue` char(32) DEFAULT NULL,
`svalue` mediumtext,
`lang` varchar(60) DEFAULT NULL COMMENT '对应语言',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
PRIMARY KEY (`skey`),
KEY `idtype` (`idtype`),
KEY `idvalue` (`idvalue`),
FULLTEXT KEY `svalue` (`svalue`)
) ENGINE=MyISAM;



DROP TABLE IF EXISTS `dzz_ai_cron`;
CREATE TABLE `dzz_ai_cron`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`idtype` tinyint(1) NOT NULL COMMENT '0,文件，1目录，2库',
`idval` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'id值',
`getContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '获取参数',
`docount` int(11) NULL DEFAULT NULL COMMENT '执行条数',
`totalcount` int(11) NULL DEFAULT NULL COMMENT '总条数',
`uid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '用户id',
`dateline` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '添加时间',
PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM;

-- ----------------------------
-- Table structure for dzz_ai_task
-- ----------------------------
DROP TABLE IF EXISTS `dzz_ai_task`;
CREATE TABLE `dzz_ai_task` (
 `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
 `rid` char(32) NOT NULL DEFAULT '' COMMENT '文件id',
 `gettype` tinyint(1) NULL DEFAULT NULL COMMENT '0获取文件名，1获取标签，2获取描述',
 `tplid` int(11) NULL DEFAULT NULL COMMENT '模板id',
 `appid` char(6) NULL DEFAULT NULL COMMENT '库id',
 `uid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户id',
 `dateline` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '添加时间',
 `aikey` char(32) NULL DEFAULT NULL COMMENT '获取的ai',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rid` (`rid`) USING BTREE,
  KEY `gettype` (`gettype`) USING BTREE,
  KEY `appid` (`appid`) USING BTREE
) ENGINE = MyISAM;


DROP TABLE IF EXISTS `dzz_ai_model`;
CREATE TABLE `dzz_ai_model` (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`name` varchar(120) NULL DEFAULT '' COMMENT '名称',
`content` text NULL COMMENT '内容',
`desc` varchar(255) NULL DEFAULT NULL COMMENT '描述',
`pcontent` text NULL COMMENT '转换内容',
`formdata` text NULL COMMENT '表单项',
`dateline` int(11) NULL DEFAULT NULL COMMENT '时间',
PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM;

DROP TABLE IF EXISTS `dzz_ai_xhimageprompt`;
CREATE TABLE `dzz_ai_xhimageprompt` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`name` char(30) DEFAULT NULL,
`prompt` text,
`cate` tinyint(1) DEFAULT NULL COMMENT '0，文件名，1标签，2描述，3标签分类',
`isdefault` tinyint(1) unsigned DEFAULT '0' COMMENT '是否默认',
`status` tinyint(1) unsigned DEFAULT '0',
`disp` int(11) unsigned DEFAULT '0' COMMENT '排序数字越小越靠前',
`dateline` int(11) unsigned DEFAULT '0',
PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_ai_xhchat`;
CREATE TABLE `dzz_ai_xhchat`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`idtype` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '0,aid,1,rid,2对话id',
`idval` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'id值',
`uid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '用户id',
`role` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色，user,assistant',
`dateline` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '时间',
`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
`totaltoken` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '消耗token数',
PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM;

DROP TABLE IF EXISTS `dzz_ai_imageparse`;
CREATE TABLE IF NOT EXISTS `dzz_ai_imageparse`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`aid` int(11) UNSIGNED NULL DEFAULT 0,
`tplid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '模板id',
`rid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件id',
`aikey` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'ai标识',
`gettype` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '获取方式',
`dateline` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '添加时间',
`isget` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否已经获取到',
`data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
`totaltoken` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '总消耗token数',
 PRIMARY KEY (`id`) USING BTREE,
 KEY `rid` (`rid`) USING BTREE,
 KEY `aid` (`aid`) USING BTREE,
 KEY `isget` (`isget`) USING BTREE
) ENGINE = MyISAM;

DROP TABLE IF EXISTS `dzz_thumb_preview`;
CREATE TABLE `dzz_thumb_preview`  (
`id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
`rid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件id',
`filesize` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
`width` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原图宽度',
`height` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原图高度',
`aid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '原图aid',
`lthumbtype` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '大图生成方式',
`sthumbtype` tinyint(1) NOT NULL DEFAULT 1 COMMENT '小图生成方式',
`lstatus` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未生成，1已生成，-1生成失败',
`sstatus` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0未生成，1已生成，-1生成失败',
`lwidth` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '大图宽度',
`lheight` int(11) NULL DEFAULT NULL COMMENT '大图高度',
`lwaterposition` tinyint(1) NULL DEFAULT 0 COMMENT '大图水印位置',
`lwatertype` tinyint(1) NULL DEFAULT 0 COMMENT '大图水印类型',
`lwatercontent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '大图水印内容',
`swidth` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '小图宽度',
`sheight` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '小图高度',
`swaterposition` tinyint(1) NULL DEFAULT 0 COMMENT '小图水印位置',
`swatertype` tinyint(1) NULL DEFAULT 0 COMMENT '小图水印类型',
`swatercontent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小图水印内容',
`opath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原图地址',
`lpath` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '大图地址',
`spath` char(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小图地址',
`ltimes` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图执行次数',
`stimes` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '大图执行次数',
`ext` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件后缀',
`isupload` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为上传文件图标 0不是，1是',
`sdateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小图最后一次执行时间',
`ldateline` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '大图最后执行时间',
`checktime` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '检查缩略图时间',
`schk` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '需要更新小图',
`lchk` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '需要更新大图',
`schktimes` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '小图更新次数',
`lchktimes` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '大图更新次数',
`sremoteid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '存储位置id',
`lremoteid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '存储位置id',
`oremoteid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '存储位置id',
`scacheid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小图缓存id',
`lcacheid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '大图缓存id',
`ocacheid` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '原图缓存id',
`iscover` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否是封面图',
`disp` int(11) NULL DEFAULT NULL COMMENT '排序',
PRIMARY KEY (`id`) USING BTREE,
KEY `rid` (`rid`) USING BTREE
) ENGINE = MyISAM;

DROP TABLE IF EXISTS `dzz_lang`;
CREATE TABLE `dzz_lang` (
`skey` varchar(255) NOT NULL,
`idtype` tinyint(1) NOT NULL COMMENT '0,文件，1tab字段，2tab字段值，3标签分类,4标签，5库',
`svalue` mediumtext,
`idvalue` char(32) DEFAULT NULL COMMENT 'id值',
`valtype` tinyint(1) UNSIGNED DEFAULT '0' COMMENT '0值，1搜索',
`filed` varchar(100) DEFAULT '' COMMENT '字段值',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
`deldate` int(11) unsigned DEFAULT '0' COMMENT '删除时间',
PRIMARY KEY (`skey`) USING BTREE,
KEY `idtype` (`idtype`),
KEY `idval` (`idvalue`),
KEY `valtype` (`valtype`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_en_us`;
CREATE TABLE `dzz_lang_en_us` (
`skey` varchar(255) NOT NULL,
`idtype` tinyint(1) NOT NULL COMMENT '',
`idvalue` char(32) DEFAULT NULL,
`svalue` mediumtext,
`valtype` tinyint(1) UNSIGNED DEFAULT '0',
`filed` varchar(100) DEFAULT '' COMMENT '字段值',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
`deldate` int(11) unsigned DEFAULT '0' COMMENT '删除时间',
PRIMARY KEY (`skey`) USING BTREE,
KEY `idtype` (`idtype`),
KEY `idvalue` (`idvalue`),
KEY `valtype` (`valtype`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_zh_cn`;
CREATE TABLE `dzz_lang_zh_cn` (
`skey` varchar(255) NOT NULL,
`idtype` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0,文件，1tab字段，2tab字段值，3标签分类,4标签，5库',
`idvalue` char(32) DEFAULT NULL,
`svalue` mediumtext,
`valtype` tinyint(1) UNSIGNED DEFAULT '0',
`filed` varchar(100) DEFAULT '' COMMENT '字段值',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
`deldate` int(11) unsigned DEFAULT '0' COMMENT '删除时间',
PRIMARY KEY (`skey`) USING BTREE,
KEY `idtype` (`idtype`),
KEY `idvalue` (`idvalue`),
KEY `valtype` (`valtype`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_lang_search`;
CREATE TABLE `dzz_lang_search` (
`skey` varchar(50) NOT NULL,
`idtype` tinyint(1) UNSIGNED DEFAULT '0',
`idvalue` char(32) DEFAULT NULL,
`svalue` mediumtext,
`lang` varchar(60) DEFAULT NULL COMMENT '对应语言',
`dateline` int(11) unsigned DEFAULT '0' COMMENT '更新时间',
PRIMARY KEY (`skey`),
KEY `idtype` (`idtype`),
KEY `idvalue` (`idvalue`),
FULLTEXT KEY `svalue` (`svalue`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `dzz_task_record`;
CREATE TABLE `dzz_task_record` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`idtype` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '0,目录自动标注任务',
`idvalue` varchar(255) NOT NULL COMMENT '任务目标id',
`dateline` int(11) unsigned NOT NULL COMMENT '任务添加时间',
`donum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任务执行个数',
`totalnum` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任务待执行总个数',
`lastid` varchar(255) NOT NULL DEFAULT '' COMMENT '最后执行的任务对应id值',
`lastdate` bigint(15) unsigned NOT NULL DEFAULT '0' COMMENT '最后执行的任务对应时间',
`appid` char(6) NOT NULL DEFAULT '' COMMENT '库id',
PRIMARY KEY (`id`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_pichome_folder_autodata`;
CREATE TABLE `dzz_pichome_folder_autodata` (
`id` int(11) unsigned NOT NULL  AUTO_INCREMENT,
`fid` char(19) NOT NULL DEFAULT '' COMMENT '目录id',
`skey` varchar(255) DEFAULT NULL COMMENT '字段名称',
`svalue` text COMMENT '字段值',
`appid` char(6) DEFAULT NULL COMMENT '库id',
PRIMARY KEY (`id`),
KEY `fid` (`fid`),
KEY `appid` (`appid`)
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_ollama_chat`;
CREATE TABLE dzz_ollama_chat (
id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
idtype tinyint(1) UNSIGNED DEFAULT '0' COMMENT '0,aid,1,rid,2对话id',
idval char(32) DEFAULT NULL COMMENT 'id值',
uid int(11) UNSIGNED DEFAULT '0' COMMENT '用户id',
role char(15) DEFAULT NULL COMMENT '角色，user,assistant',
dateline int(11) UNSIGNED DEFAULT '0' COMMENT '时间',
content mediumtext COMMENT '内容',
totaltoken int(11) UNSIGNED DEFAULT '0' COMMENT '消耗token数',
PRIMARY KEY (id) USING BTREE
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `dzz_ollama_imageprompt`;
CREATE TABLE dzz_ollama_imageprompt (
id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
name varchar(60) DEFAULT '',
prompt text,
prompts text default NULL COMMENT 'json数据',
cate tinyint(1) DEFAULT NULL COMMENT '0，文件名，1标签，2描述，3标签分类',
isdefault tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否默认',
status tinyint(1) UNSIGNED DEFAULT '0' COMMENT '是否开启',
disp int(11) UNSIGNED DEFAULT '0' COMMENT '排序数字越小越靠前',
dateline int(11) UNSIGNED DEFAULT '0',
PRIMARY KEY (id) USING BTREE
) ENGINE=MyISAM;


COMMIT;
