class phpmoadmin::php {
  require phpmoadmin::php::packages

  file { '/etc/php5/apache2/php.ini':
    ensure => present,
    source => 'puppet:///modules/phpmoadmin/etc/php5/apache2/php.ini',
    mode => 644
  }
}
