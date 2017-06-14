# Class wds::install
class wds::install inherits wds {
  if $::wds::install_feature {
    dsc_windowsfeature { $::wds::feature_name:
      dsc_ensure => 'present',
      dsc_name   => $::wds::feature_name,
    }

    file { ['C:\ProgramData\PuppetLabs\facter', 'C:\ProgramData\PuppetLabs\facter\facts.d']:
      ensure => directory,
      owner  => 'SYSTEM',
    }->
    file { 'C:\ProgramData\PuppetLabs\facter\facts.d\wds_conf_fact.ps1':
      ensure => file,
      owner  => 'SYSTEM',
      source => 'puppet:///modules/wds/wds_conf_fact.ps1',
    }
  }
}
