# Class: wds
# Initialize WDS
class wds(
  Boolean $install_feature     = $::wds::params::install_feature,
  String $ensure_service      = $::wds::params::ensure_service,
  Boolean $enable_service      = $::wds::params::enable_service,
  String $feature_name        = $::wds::params::feature_name,
) inherits wds::params {
  if $::osfamily == 'Windows' {
    anchor{'wds::begin':}
    -> class{'::wds::install':}
    -> class{'::wds::config':}
    ~> class{'::wds::service':}
    -> anchor{'wds::end':}
  } else {
    fail { "This operating system family (${::osfamily}) is not supported.": }
  }
}
