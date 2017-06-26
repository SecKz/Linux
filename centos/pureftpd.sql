create database pureftpd;
flush privileges;
use pureftpd;
create table if not exists `ftpusers` (
`User` char(50) NOT NULL DEFAULT '',
`Password` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
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



