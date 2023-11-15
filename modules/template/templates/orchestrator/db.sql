DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `status` set('TODO','DOING','DONE','ERROR') NOT NULL DEFAULT 'TODO',
  `command` varchar(1024) NOT NULL,
  `mode` set('MULTI','MONO') NOT NULL DEFAULT 'MULTI',
  `log` mediumtext DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `message` varchar(1024) NOT NULL,
  `toasted` int(11) NOT NULL,
  `from` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

