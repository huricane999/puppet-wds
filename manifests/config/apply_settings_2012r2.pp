# Class wds::config::apply_settings_2012r2
# Applies settings to clients running Server 2012 R2 or earlier
class wds::config::apply_settings_2012r2 {
  #Allow N12 for New Clients
  if !has_key($::wds_conf, 'boot_program_policy') or !has_key($::wds_conf[boot_program_policy], 'allow_n12_for_new_clients') or $::wds_conf[boot_program_policy][allow_n12_for_new_clients] != '<Not Applicable>' {
    if $::wds::config::allow_n12_for_new_clients and (!has_key($::wds_conf, 'boot_program_policy') or !has_key($::wds_conf[boot_program_policy], 'allow_n12_for_new_clients') or $::wds_conf[boot_program_policy][allow_n12_for_new_clients] == 'No') {
      exec { 'WDS Server - Allow N12 for New Clients':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AllowN12ForNewClients:Yes',
      }
    } elsif !$::wds::config::allow_n12_for_new_clients and (!has_key($::wds_conf, 'boot_program_policy') or !has_key($::wds_conf[boot_program_policy], 'allow_n12_for_new_clients') or $::wds_conf[boot_program_policy][allow_n12_for_new_clients] == 'Yes') {
      exec { 'WDS Server - Disallow N12 for New Clients':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AllowN12ForNewClients:No',
      }
    }
  }

  #Transport Profile
  if !has_key($::wds_conf, 'wds_transport_server_policy') or !has_key($::wds_conf[wds_transport_server_policy], 'network_profile') or $::wds_conf[wds_transport_server_policy][network_profile] != '<Not Applicable>' {
    if !has_key($::wds_conf, 'wds_transport_server_policy') or !has_key($::wds_conf[wds_transport_server_policy], 'network_profile') or $::wds_conf[wds_transport_server_policy][network_profile] != $::wds::config::transport_profile {
      exec { 'WDS Server - Transport Profile':
        command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /Profile:${::wds::config::transport_profile}",
      }
    }
  }
}
