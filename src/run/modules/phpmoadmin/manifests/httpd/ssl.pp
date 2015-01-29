class phpmoadmin::httpd::ssl {
  exec { 'mkdir -p /phpmoadmin/ssl':
    path => ['/bin']
  }

  exec { 'mkdir -p /phpmoadmin/ssl/private':
    path => ['/bin'],
    require => Exec['mkdir -p /phpmoadmin/ssl']
  }

  exec { 'mkdir -p /phpmoadmin/ssl/certs':
    path => ['/bin'],
    require => Exec['mkdir -p /phpmoadmin/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('phpmoadmin/opensslCA.cnf.erb'),
    require => Exec['mkdir -p /phpmoadmin/ssl/certs']
  }

  exec { 'openssl genrsa -out /phpmoadmin/ssl/private/phpmoadminCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /phpmoadmin/ssl/private/phpmoadminCA.key -out /phpmoadmin/ssl/certs/phpmoadminCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /phpmoadmin/ssl/private/phpmoadminCA.key 4096']
  }

  exec { 'openssl genrsa -out /phpmoadmin/ssl/private/phpmoadmin.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /phpmoadmin/ssl/private/phpmoadminCA.key -out /phpmoadmin/ssl/certs/phpmoadminCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('phpmoadmin/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /phpmoadmin/ssl/private/phpmoadmin.key 4096']
  }

  exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /phpmoadmin/ssl/private/phpmoadmin.key -out /phpmoadmin/ssl/certs/phpmoadmin.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /phpmoadmin/ssl/certs/phpmoadmin.csr -CA /phpmoadmin/ssl/certs/phpmoadminCA.crt -CAkey /phpmoadmin/ssl/private/phpmoadminCA.key -out /phpmoadmin/ssl/certs/phpmoadmin.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -config /root/openssl.cnf -key /phpmoadmin/ssl/private/phpmoadmin.key -out /phpmoadmin/ssl/certs/phpmoadmin.csr"]
  }
}
