# = Class: mcollective
#
# This class is the default class for mcollective servers and clients.
# It requires RabbitMQ-Server version 2.8 and above.
#
# == Parameters:
#
#   $presharedkey::             RabbitMQ Pre-Shared Key.
#   $stompport::                RabbitMQ stomp port.
#   $stompuser::                RabbitMQ stomp username.
#   $stomppassword::            RabbitMQ stomp user password.
#   $stomphost::                RabbitMQ stomp host.
#
#
# == Actions:
#   Installs and configures to mcollective.
#
# == Requires:
#   - Package["rabbitmq-server" => 2.8.3 ]
#
# == Sample Usage:
#
# site.pp:
#    import "mcollective" (optional since it's in autoload format)
#
# nodes.pp:
#    class mcollective-client{
#        $stomphost     = RabbitMQ Server (defaults to mcollective)
#        $stompport     = RabbitMQ Stomp Port (defaults to 61613)
#        $stompuser     = RabbitMQ Mcollective User (defaults to mcollective)
#        $stomppassword = RabbitMQ Mcollective User Password (has default)
#        $presharedkey  = Mcollective Pre-Shared Key (has default)
#        include mcollective::client
#    }
#
#    class mcollective-server{
#        $stomphost     = RabbitMQ Server (defaults to mcollective)
#        $stompport     = RabbitMQ Stomp Port (defaults to 61613)
#        $stompuser     = RabbitMQ Mcollective User (defaults to mcollective)
#        $stomppassword = RabbitMQ Mcollective User Password (has default)
#        $presharedkey  = Mcollective Pre-Shared Key (has default)
#        include mcollective::server
#        include mcollective::rabbitmq
#    }
#
class mcollective { }
