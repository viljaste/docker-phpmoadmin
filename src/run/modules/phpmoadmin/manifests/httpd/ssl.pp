class phpmoadmin::httpd::ssl {
  exec { 'openssl genrsa -out /phpmoadmin/ssl/private/phpmoadminCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  exec { "openssl req -x509 -new -nodes -key /phpmoadmin/ssl/private/phpmoadminCA.key -days 365 -subj /C=/ST=/L=/O=/CN=phpmoadmin -out /phpmoadmin/ssl/certs/phpmoadminCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /phpmoadmin/ssl/private/phpmoadminCA.key 4096']
  }

  exec { 'openssl genrsa -out /phpmoadmin/ssl/private/phpmoadmin.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /phpmoadmin/ssl/private/phpmoadminCA.key -days 365 -subj /C=/ST=/L=/O=/CN=phpmoadmin -out /phpmoadmin/ssl/certs/phpmoadminCA.crt"]
  }

  $subj = "/C=/ST=/L=/O=/CN=$server_name"

  exec { "openssl req -sha256 -new -key /phpmoadmin/ssl/private/phpmoadmin.key -subj $subj -out /phpmoadmin/ssl/certs/phpmoadmin.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /phpmoadmin/ssl/private/phpmoadmin.key 4096']
  }

  exec { "openssl x509 -req -in /phpmoadmin/ssl/certs/phpmoadmin.csr -CA /phpmoadmin/ssl/certs/phpmoadminCA.crt -CAkey /phpmoadmin/ssl/private/phpmoadminCA.key -CAcreateserial -out /phpmoadmin/ssl/certs/phpmoadmin.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -key /phpmoadmin/ssl/private/phpmoadmin.key -subj $subj -out /phpmoadmin/ssl/certs/phpmoadmin.csr"]
  }
}
