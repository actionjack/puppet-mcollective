class mcollective::rabbitmq::install{
  $packagelist = ['rabbitmq-server']
  package{ $packagelist: ensure => installed }
}

class mcollective::rabbitmq::config{
  $stompport     = $mcollective::params::stompport

  File{
    owner => 'root',
    group => 'root',
    mode  => '0644',
    notify  => Class['mcollective::rabbitmq::service']
  }

  file{'/etc/rabbitmq/rabbitmq-env.conf':
    content => "SERVER_START_ARGS=\"-rabbit_stomp listeners [{\\\"0.0.0.0\\\",$stompport}]\"\n"
  }

  exec{'enable-amqp-client':
    unless  => 'rabbitmq-plugins list | grep amqp_client | grep [E]',
    command => 'rabbitmq-plugins enable amqp_client',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Class['mcollective::rabbitmq::install']
  }

  exec{'enable-rabbitmq-stomp':
    unless  => 'rabbitmq-plugins list | grep rabbitmq_stomp | grep [E]',
    command => 'rabbitmq-plugins enable rabbitmq_stomp',
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Class['mcollective::rabbitmq::install']
  }

}

class mcollective::rabbitmq::service{
  service{'rabbitmq-server':
    enable     => 'true',
    hasrestart => 'true',
    hasstatus  => 'true',
    status     => 'true'
  }
}

class mcollective::rabbitmq::user{
  $stompuser     = $mcollective::params::stompuser
  $stomppassword = $mcollective::params::stomppassword
    
  exec{'add-mcollective-user':
    unless  => "rabbitmqctl list_users | grep $stompuser",
    command => "rabbitmqctl add_user $stompuser $stomppassword",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Class['mcollective::rabbitmq::service']
  }

  exec{'set-mcollective-permissions':
    unless  => "rabbitmqctl list_user_permissions $stompuser | grep amq.gen",
    command => "rabbitmqctl set_permissions -p / $stompuser \"^amq.gen-.*\" \".*\" \".*\"",
    path    => '/usr/bin:/usr/sbin:/bin:/sbin',
    require => Exec['add-mcollective-user']
  }
}

class mcollective::rabbitmq{
  include mcollective::params
  include mcollective::rabbitmq::install
  include mcollective::rabbitmq::config
  include mcollective::rabbitmq::service
  include mcollective::rabbitmq::user

  Class['mcollective::params'] -> Class['mcollective::rabbitmq::install'] -> Class['mcollective::rabbitmq::config'] -> Class['mcollective::rabbitmq::service'] 
}

