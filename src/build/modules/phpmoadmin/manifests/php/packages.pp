class phpmoadmin::php::packages {
  package {[
      'php5',
      'php5-dev',
      'php5-cli',
      'php-pear'
    ]:
    ensure => present
  }
}
