# Class wds::config
class wds::config inherits wds {
  exec { 'Initialize WDS Server':
    command => "wdsutil.exe /Initialize-Server /reminst:\"${::wds::remote_install_location}\"",
  }->
  exec { 'Update WDS Server Files':
    command => 'wdsutil.exe /Disable-Server',
  }

  if $::wds::enable_service {
    exec { 'Enable WDS Services':
      command => 'wdsutil.exe /Enable-Server',
    }
  } else {
    exec { 'Disable WDS Services':
      command => 'wdsutil.exe /Disable-Server',
    }
  }
}
