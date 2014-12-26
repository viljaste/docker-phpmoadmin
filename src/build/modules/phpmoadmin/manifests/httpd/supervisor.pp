class phpmoadmin::httpd::supervisor {
  file { '/etc/supervisor/conf.d/httpd.conf':
    ensure => present,
    source => 'puppet:///modules/phpmoadmin/etc/supervisor/conf.d/httpd.conf',
    mode => 644
  }
}
