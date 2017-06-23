# Class wds::service
class wds::service inherits wds {
  service { 'WDSServer':
    ensure => $::wds::ensure_service,
    enable => $::wds::enable_service,
  }
}
