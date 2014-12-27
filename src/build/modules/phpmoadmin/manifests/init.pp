class phpmoadmin {
  require phpmoadmin::php
  require phpmoadmin::httpd

  exec { '/bin/su - root -c "echo \"no\" | pecl install mongo"':
    timeout => 0
  }

  file { '/etc/php5/apache2/conf.d/mongo.ini':
    ensure => present,
    source => 'puppet:///modules/phpmoadmin/etc/php5/apache2/conf.d/mongo.ini',
    mode => 644,
    require => Exec['/bin/su - root -c "echo \"no\" | pecl install mongo"']
  }

  file { '/etc/php5/cli/conf.d/mongo.ini':
    ensure => present,
    source => 'puppet:///modules/phpmoadmin/etc/php5/cli/conf.d/mongo.ini',
    mode => 644,
    require => Exec['/bin/su - root -c "echo \"no\" | pecl install mongo"']
  }
}
