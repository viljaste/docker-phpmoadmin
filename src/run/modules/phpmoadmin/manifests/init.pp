class phpmoadmin {
  if ! file_exists('/phpmoadmin/ssl/certs/phpmoadmin.crt') {
    require phpmoadmin::httpd::ssl
  }

  file { '/phpmoadmin/data/index.php':
    ensure  => present,
    content => template('phpmoadmin/moadmin.php.erb')
  }
}
