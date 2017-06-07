# Class wds::service
class wds::service inherits wds {
  if $::wds::ensure_service == 'running' {
    exec { 'Start WDS Service':
      command => 'wdsutil.exe /Start-Server',
    }
  } else {
    exec { 'Stop WDS Service':
      command => 'wdsutil.exe /Stop-Server',
    }
  }
}
