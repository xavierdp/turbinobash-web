<?php
class JConfig {
	function __construct() 
	{
		$user = $_SERVER["USER"];

		$this->user = $user;
		$this->db = $user;
		$this->log_path = "/apps/$user/app/webroot/administrator/logs";
		$this->tmp_path = "/apps/$user/app/webroot/tmp";
		$this->password = trim(file_get_contents("/apps/$user/etc/mysql/localhost/passwd"));
		
	}


	public $offline = false;
	public $offline_message = 'Ce site est en maintenance.<br>Merci de revenir ultérieurement.';
	public $display_offline_message = 1;
	public $offline_image = '';
	public $sitename = 'JOOMLAZEST';
	public $editor = 'tinymce';
	public $captcha = '0';
	public $list_limit = 20;
	public $access = 1;
	public $debug = true;
	public $debug_lang = false;
	public $debug_lang_const = true;
	public $dbtype = 'mysqli';
	public $host = 'localhost';
	// public $user = 'USER';
	public $password = 'FBbWdZRlob';
	// public $db = 'USER';
	public $dbprefix = 'btod7_';
	public $dbencryption = 0;
	public $dbsslverifyservercert = false;
	public $dbsslkey = '';
	public $dbsslcert = '';
	public $dbsslca = '';
	public $dbsslcipher = '';
	public $force_ssl = 0;
	public $live_site = '';
	public $secret = 'TB_SECRET';
	public $gzip = false;
	public $error_reporting = 'default';
	public $helpurl = 'https://help.joomla.org/proxy?keyref=Help{major}{minor}:{keyref}&lang={langcode}';
	public $offset = 'UTC';
	public $mailonline = true;
	public $mailer = 'mail';
	public $mailfrom = 'xavier@ooo.ovh';
	public $fromname = 'JOOMLAZEST';
	public $sendmail = '/usr/sbin/sendmail';
	public $smtpauth = false;
	public $smtpuser = '';
	public $smtppass = '';
	public $smtphost = 'localhost';
	public $smtpsecure = 'none';
	public $smtpport = 25;
	public $caching = 0;
	public $cache_handler = 'file';
	public $cachetime = 15;
	public $cache_platformprefix = false;
	public $MetaDesc = '';
	public $MetaAuthor = true;
	public $MetaVersion = false;
	public $robots = '';
	public $sef = true;
	public $sef_rewrite = false;
	public $sef_suffix = false;
	public $unicodeslugs = false;
	public $feed_limit = 10;
	public $feed_email = 'none';
	public $log_path = null;
	public $tmp_path = null;
	// public $log_path = '/apps/USER/app/webroot/administrator/logs';
	// public $tmp_path = '/apps/USER/app/webroot/tmp';
	public $lifetime = 15;
	public $session_handler = 'database';
	public $shared_session = false;
	public $session_metadata = true;
}




