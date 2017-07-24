# Class wds::install
class wds::install inherits wds {
  if !$::wds_conf and $::wds::install_feature {
    exec { "Install ${::wds::feature_name}":
      command  => "Install-WindowsFeature -Name '${::wds::feature_name}' -IncludeAllSubFeature -IncludeManagementTools",
      unless   => "if((Get-WindowsFeature '${::wds::feature_name}').Installed){exit 1}",
      provider => powershell,
    }
  }
}
