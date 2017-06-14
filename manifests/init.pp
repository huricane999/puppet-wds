# Class: wds
# Initialize WDS
class wds(
  $install_feature     = $::wds::params::install_feature,
  $ensure_service      = $::wds::params::ensure_service,
  $enable_service      = $::wds::params::enable_service,
  $feature_name        = $::wds::params::feature_name,
  $remote_install_path = $::wds::params::remote_install_path,
) inherits wds::params {
  if $::osfamily == 'Windows' {
    validate_boolean($install_feature)
    validate_string($ensure_service)
    validate_boolean($enable_service)
    validate_string($feature_name)
    validate_string($remote_install_path)

    anchor{'wds::begin':} ->
    class{'::wds::install':} ->
    class{'::wds::config':} ~>
    class{'::wds::service':} ->
    anchor{'wds::end':}
  } else {
    fail { "This operating system family (${::osfamily}) is not supported.": }
  }
}
