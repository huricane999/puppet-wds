# Class wds::service
class wds::service inherits wds {
  if $::wds::ensure_service == 'running' {
    exec { 'Start WDS Service':
      command => 'C:\Windows\System32\wdsutil.exe /Start-Server',
    }
  } else {
    exec { 'Stop WDS Service':
      command => 'C:\Windows\System32\wdsutil.exe /Stop-Server',
    }
  }
}
