class mcollective::server::install{
  $packagelist = ['mcollective', 'rubygem-amqp']
  package{ $packagelist: ensure => installed }
}

class mcollective::server::config{
  $presharedkey  = $mcollective::params::presharedkey
  $stompport     = $mcollective::params::stompport
  $stompuser     = $mcollective::params::stompuser
  $stomppassword = $mcollective::params::stomppassword
  $stomphost     = $mcollective::params::stomphost

  File{
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
  }

  file{'/etc/mcollective/server.cfg':
    content => template('mcollective/server.cfg.erb'),
    notify => Class['mcollective::server::service']
  }
}

class mcollective::server::service{
  service{'mcollective':
    enable     => 'true',
    hasrestart => 'true',
    hasstatus  => 'true',
    status     => 'true'
  }
}

class mcollective::server{
  include mcollective::params
  include mcollective::server::install
  include mcollective::server::config
  include mcollective::server::service

  Class['mcollective::params'] -> Class['mcollective::server::install'] -> Class['mcollective::server::config'] -> Class['mcollective::server::service'] 
}

