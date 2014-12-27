class phpmoadmin {
  require phpmoadmin::php
  require phpmoadmin::httpd

  exec { 'pecl install mongo':
    timeout => 0,
    path => ['/usr/bin']
  }
}
