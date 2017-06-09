# Class wds::config
class wds::config inherits wds (
  $initialize = true,
){
  exec { 'Initialize WDS Server':
    command => "C:\\Windows\\System32\\wdsutil.exe /Initialize-Server /reminst:\"${::wds::remote_install_location}\"",
    unless  => 'C:\\Windows\\System32\\wdsutil.exe /Get-Server /Show:All',
  }->
  exec { 'Update WDS Server Files':
    command => 'C:\Windows\System32\wdsutil.exe /Update-ServerFiles',
  }

  if $::wds::enable_service {
    exec { 'Enable WDS Services':
      command => 'C:\Windows\System32\wdsutil.exe /Enable-Server',
    }
  } else {
    exec { 'Disable WDS Services':
      command => 'C:\Windows\System32\wdsutil.exe /Disable-Server',
    }
  }
}
