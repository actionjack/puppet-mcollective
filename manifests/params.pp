class mcollective::params{
  if $presharedkey == undef {
    notice 'Pre-Shared Key not defined using defaults'
    $presharedkey = esyapveOvVocveldUcOajIrdyetpik
  }
  if $stompport == undef {
    notice 'Stomp Port not defined defaulting to 61613'
    $stompport = 61613
  }
  if $stompuser == undef {
    notice 'Stomp user not defined defaulting to "mcollective"'
    $stompuser = mcollective
  }
  if $stomppassword == undef {
    notice 'Stomp password not defined using defaults'
    $stomppassword = jarOynZigHuf
  }
  if $stomphost == undef {
    notice 'Stomp Host not defined defaulting to mcollective'
    $stomphost = 'mcollective'
  }
}
