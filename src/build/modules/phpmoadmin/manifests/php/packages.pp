class phpmoadmin::php::packages {
  package {[
      'php5',
      'php5-mysql'
    ]:
    ensure => present
  }
}
