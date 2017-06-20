# Class wds::install
class wds::install inherits wds {
  if $::wds::install_feature {
    dsc_windowsfeature { $::wds::feature_name:
      dsc_ensure => 'present',
      dsc_name   => $::wds::feature_name,
    }
  }
}
