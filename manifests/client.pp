class mcollective::client::install{
  $packagelist = ['mcollective-client']
  package{ $packagelist: ensure => installed }
}

class mcollective::client::config{
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

  file{'/etc/mcollective/client.cfg':
    content => template('mcollective/client.cfg.erb'),
  }
}

class mcollective::client{
  include mcollective::params
  include mcollective::client::install
  include mcollective::client::config

  Class['mcollective::params'] -> Class['mcollective::client::install'] -> Class['mcollective::client::config']
}

