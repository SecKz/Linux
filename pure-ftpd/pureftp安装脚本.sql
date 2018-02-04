
create database pureftpd;
grant all privileges on pureftpd.* to 'pureftpd'@'localhost' identified by '456uytrop3kjh4ty';
flush privileges;
use pureftpd;

CREATE TABLE IF NOT EXISTS `ftpusers` (
  `User` varchar(16) NOT NULL DEFAULT '',
  `Password` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `Uid` int(11) NOT NULL,
  `Gid` int(11) NOT NULL,
  `Dir` varchar(128) NOT NULL DEFAULT '',
  `QuotaFiles` int(10) NOT NULL DEFAULT '0',
  `QuotaSize` int(10) NOT NULL DEFAULT '0',
  `ULBandwidth` int(10) NOT NULL DEFAULT '0',
  `DLBandwidth` int(10) NOT NULL DEFAULT '0',
  `Ipaddress` varchar(15) NOT NULL DEFAULT '*',
  `Comment` tinytext,
  `Status` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`User`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


insert into `pureftpd`.`ftpusers` values( 'zrw', MD5('fyzc982521aJ5aYuY'), '506', '506', '/home/zrw/', '0', '0', '0', '0', '*', '' , '1');



insert into `pureftpd`.`ftpusers` (`User` , `Password` , `Uid` , `Gid` , `Dir` , `QuotaFiles` , `QuotaSize` , `ULBandwidth` , `DLBandwidth` , `Ipaddress` , `Comment` , `Status`) 
values( 'zrw', MD5('fyzc982521aJ5aYuY'), '506', '506', '/home/zrw/', '0', '0', '0', '0', '*', '' , '1');


drop user 'pureftpd'@'localhost';
create database pureftpd;
delete from mysql.user where User = 'pureftpd' limit 1;


User:虚拟pureftpd用户名。
status:0或1,0表示用户禁用。
Password:虚拟用户密码，确保把密码转成MD5再插入。
UID：ftp用户的ID。
GID：ftp用户组的ID。
Dir:ftp用户对应的根目录。
ULBandwidth:上传最大速度，单位为KB/s。
DLBandwidth:下载最大速度，单位为KB/s。
comment:备注。
Ipaddress:可以连接ftp服务器的IP。“*”表示任何IP可以连接。
QuotaSize:最大存储空间，单位为MB。“0”表示不限制。
QuotaFiles:最大建立的文件数量。“0”表示不限制。


在pure-ftpd.conf修改
DontResolve，内容为yes（否则连接时速度很慢）


