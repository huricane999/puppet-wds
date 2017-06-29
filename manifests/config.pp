# Class wds::config
class wds::config (
  Boolean $initialize = $::wds::params::initialize,
  String $remote_install_path = $::wds::params::remote_install_path,
  Boolean $authorize = $::wds::params::authorize,
  Boolean $rogue_detection = $::wds::params::rogue_detection,
  String $answer_clients = $::wds::params::answer_clients,
  Integer $response_delay = $::wds::params::response_delay,
  Boolean $allow_n12_for_new_clients = $::wds::params::allow_n12_for_new_clients,
  Boolean $reset_boot_program = $::wds::params::reset_boot_program,
  String $default_x86_x64_image_type = $::wds::params::default_x86_x64_image_type,
  Boolean $use_dhcp_ports = $::wds::params::use_dhcp_ports,
  Boolean $dhcp_option_60 = $::wds::params::dhcp_option_60,
  Integer $rpc_port = $::wds::params::rpc_port,
  String $pxe_prompt_policy_known = $::wds::params::pxe_prompt_policy_known,
  String $pxe_prompt_policy_new = $::wds::params::pxe_prompt_policy_new,
  String $boot_program_x86 = $::wds::params::boot_program_x86,
  String $boot_program_x86uefi = $::wds::params::boot_program_x86uefi,
  String $boot_program_x64 = $::wds::params::boot_program_x64,
  String $boot_program_x64uefi = $::wds::params::boot_program_x64uefi,
  String $boot_program_ia64 = $::wds::params::boot_program_ia64,
  String $boot_program_arm = $::wds::params::boot_program_arm,
  String $n12_boot_program_x86 = $::wds::params::n12_boot_program_x86,
  String $n12_boot_program_x86uefi = $::wds::params::n12_boot_program_x86uefi,
  String $n12_boot_program_x64 = $::wds::params::n12_boot_program_x64,
  String $n12_boot_program_x64uefi = $::wds::params::n12_boot_program_x64uefi,
  String $n12_boot_program_ia64 = $::wds::params::n12_boot_program_ia64,
  String $n12_boot_program_arm = $::wds::params::n12_boot_program_arm,
  String $boot_image_x86 = $::wds::params::boot_image_x86,
  String $boot_image_x86uefi = $::wds::params::boot_image_x86uefi,
  String $boot_image_x64 = $::wds::params::boot_image_x64,
  String $boot_image_x64uefi = $::wds::params::boot_image_x64uefi,
  String $boot_image_ia64 = $::wds::params::boot_image_ia64,
  String $boot_image_arm = $::wds::params::boot_image_arm,
  String $preferred_dc = $::wds::params::preferred_dc,
  String $preferred_gc = $::wds::params::preferred_gc,
  Boolean $prestage_using_mac = $::wds::params::prestage_using_mac,
  String $new_machine_naming_policy = $::wds::params::new_machine_naming_policy,
  String $new_machine_type = $::wds::params::new_machine_type,
  String $new_machine_ou = $::wds::params::new_machine_ou,
  String $domain_search_order = $::wds::params::domain_search_order,
  Boolean $new_machine_domain_join = $::wds::params::new_machine_domain_join,
  Boolean $wds_client_logging = $::wds::params::wds_client_logging,
  String $wds_client_logging_level = $::wds::params::wds_client_logging_level,
  Boolean $wds_unattend_policy = $::wds::params::wds_unattend_policy,
  Boolean $wds_unattend_commandline_precedence = $::wds::params::wds_unattend_commandline_precedence,
  String $wds_unattend_file_x86 = $::wds::params::wds_unattend_file_x86,
  String $wds_unattend_file_x64 = $::wds::params::wds_unattend_file_x64,
  String $wds_unattend_file_ia64 = $::wds::params::wds_unattend_file_ia64,
  String $auto_add_policy = $::wds::params::auto_add_policy,
  Integer $auto_add_policy_poll_interval = $::wds::params::auto_add_policy_poll_interval,
  Integer $auto_add_policy_max_retry_count = $::wds::params::auto_add_policy_max_retry_count,
  String $auto_add_policy_message = $::wds::params::auto_add_policy_message,
  Integer $auto_add_policy_retention_period_approved = $::wds::params::auto_add_policy_retention_period_approved,
  Integer $auto_add_policy_retention_period_others = $::wds::params::auto_add_policy_retention_period_others,
  Hash $auto_add_settings_x86 = $::wds::params::auto_add_settings_x86,
  Hash $auto_add_settings_x64 = $::wds::params::auto_add_settings_x64,
  Hash $auto_add_settings_ia64 = $::wds::params::auto_add_settings_ia64,
  String $bind_policy = $::wds::params::bind_policy,
  Array $bind_policy_addresses = $::wds::params::bind_policy_addresses,
  Integer $refresh_period = $::wds::params::refresh_period,
  Array $banned_guids = $::wds::params::banned_guids,
  Integer $bcd_refresh_policy_period = $::wds::params::bcd_refresh_policy_period,
  String $transport_obtain_ipv4_from = $::wds::params::transport_obtain_ipv4_from,
  String $transport_obtain_ipv4_from_start = $::wds::params::transport_obtain_ipv4_from_start,
  String $transport_obtain_ipv4_from_end = $::wds::params::transport_obtain_ipv4_from_end,
  String $transport_obtain_ipv6_from = $::wds::params::transport_obtain_ipv6_from,
  String $transport_obtain_ipv6_from_start = $::wds::params::transport_obtain_ipv6_from_start,
  String $transport_obtain_ipv6_from_end = $::wds::params::transport_obtain_ipv6_from_end,
  Integer $transport_start_port = $::wds::params::transport_start_port,
  Integer $transport_end_port = $::wds::params::transport_end_port,
  String $transport_profile = $::wds::params::transport_profile,
  String $transport_multicast_session_policy = $::wds::params::transport_multicast_session_policy,
  Integer $transport_multicast_session_policy_threshold = $::wds::params::transport_multicast_session_policy_threshold,
  Integer $transport_multicast_session_policy_stream_count = $::wds::params::transport_multicast_session_policy_stream_count,
  Boolean $transport_multicast_session_policy_fallback = $::wds::params::transport_multicast_session_policy_fallback,
  Boolean $transport_force_native = $::wds::params::transport_force_native,
) inherits wds {
  if $initialize {
    exec { 'Initialize WDS Server':
      command  => "C:\\Windows\\System32\\wdsutil.exe /Initialize-Server /reminst:\"${remote_install_path}\"",
      unless   => '[Void]$(C:\\Windows\\System32\\wdsutil.exe /Get-Server /Show:All); Exit $LastExitCode',
      provider => powershell,
    }
  }

  if $answer_clients != 'All' and $answer_clients != 'Known' and $answer_clients != 'None' {
    fail("::wds::config::answer_clients (${answer_clients}) must be one of 'All', 'Known', or 'None'")
  }

  if $response_delay < 0 {
    fail("::wds::config::response_delay (${response_delay}) must be greater than or equal to 0")
  }

  if $default_x86_x64_image_type != 'x86' and $default_x86_x64_image_type != 'x64' and $default_x86_x64_image_type != 'Both' {
    fail("::wds::config::default_x86_x64_image_type (${default_x86_x64_image_type}) must be one of 'x86', 'x64', or 'Both'")
  }

  if $rpc_port <= 0 {
    fail("::wds::config::rpc_port (${rpc_port}) must be greater than 0")
  }

  if $pxe_prompt_policy_known != 'OptIn' and $pxe_prompt_policy_known != 'NoPrompt' and $pxe_prompt_policy_known != 'OptOut' {
    fail("::wds::config::default_x86_x64_image_type (${pxe_prompt_policy_known}) must be one of 'OptIn', 'NoPrompt', or 'OptOut'")
  }

  if $pxe_prompt_policy_new != 'OptIn' and $pxe_prompt_policy_new != 'NoPrompt' and $pxe_prompt_policy_new != 'OptOut' {
    fail("::wds::config::default_x86_x64_image_type (${pxe_prompt_policy_new}) must be one of 'OptIn', 'NoPrompt', or 'OptOut'")
  }

  if $new_machine_type != 'ServerDomain' and $new_machine_type != 'UserDomain' and $new_machine_type != 'UserOU' and $new_machine_type != 'Custom' {
    fail("::wds::config::default_x86_x64_image_type (${new_machine_type}) must be one of 'ServerDomain', 'UserDomain', 'UserOU', or 'Custom'")
  }

  if $domain_search_order != 'GCOnly' and $domain_search_order != 'DCFirst' {
    fail("::wds::config::domain_search_order (${domain_search_order}) must be 'GCOnly' or 'DCFirst'")
  }

  if $wds_client_logging_level != 'None' and $wds_client_logging_level != 'Errors' and $wds_client_logging_level != 'Warnings' and $wds_client_logging_level != 'Info' {
    fail("::wds::config::wds_client_logging_level (${wds_client_logging_level}) must be one of 'None', 'Errors', 'Warnings', or 'Info'")
  }

  if $auto_add_policy != 'AdminApproval' and $auto_add_policy != 'Disabled' {
    fail("::wds::config::auto_add_policy (${auto_add_policy}) must be 'AdminApproval' or 'Disabled'")
  }

  if $auto_add_policy_poll_interval < 0 {
    fail("::wds::config::auto_add_policy_poll_interval (${auto_add_policy_poll_interval}) must be greater than or equal to 0")
  }

  if $auto_add_policy_max_retry_count < 0 {
    fail("::wds::config::auto_add_policy_max_retry_count (${auto_add_policy_max_retry_count}) must be greater than or equal to 0")
  }

  if $auto_add_policy_retention_period_approved < 0 {
    fail("::wds::config::auto_add_policy_retention_period_approved (${auto_add_policy_retention_period_approved}) must be greater than or equal to 0")
  }

  if $auto_add_policy_retention_period_others < 0 {
    fail("::wds::config::auto_add_policy_retention_period_others (${auto_add_policy_retention_period_others}) must be greater than or equal to 0")
  }

  if $bind_policy != 'Include' and $bind_policy != 'Exclude' {
    fail("::wds::config::bind_policy (${bind_policy}) must be 'Include' or 'Exclude'")
  }

  if $refresh_period < 0 {
    fail("::wds::config::refresh_period (${refresh_period}) must be greater than or equal to 0")
  }

  if $bcd_refresh_policy_period < 0 {
    fail("::wds::config::bcd_refresh_policy_period (${bcd_refresh_policy_period}) must be greater than or equal to 0")
  }

  if $transport_obtain_ipv4_from != 'Dhcp' and $transport_obtain_ipv4_from != 'Range' {
    fail("::wds::config::transport_obtain_ipv4_from (${transport_obtain_ipv4_from}) must be 'Dhcp' or 'Range'")
  }

  if $transport_obtain_ipv6_from != 'Dhcp' and $transport_obtain_ipv6_from != 'Range' {
    fail("::wds::config::transport_obtain_ipv6_from (${transport_obtain_ipv6_from}) must be 'Dhcp' or 'Range'")
  }

  if $transport_start_port < 0 {
    fail("::wds::config::transport_start_port (${transport_start_port}) must be greater than or equal to 0")
  }

  if $transport_end_port < 0 {
    fail("::wds::config::transport_end_port (${transport_end_port}) must be greater than or equal to 0")
  }

  if $transport_profile != '10Mbps' and $transport_profile != '100Mbps' and $transport_profile != '1Gbps' and $transport_profile != 'Custom' {
    fail("::wds::config::transport_profile (${transport_profile}) must be one of '10Mbps', '100Mbps', '1Gbps', or 'Custom'")
  }

  if $transport_multicast_session_policy != 'None' and $transport_multicast_session_policy != 'AutoDisconnect' and $transport_multicast_session_policy != 'Multistream' {
    fail("::wds::config::transport_multicast_session_policy (${transport_multicast_session_policy}) must be one of 'None', 'AutoDisconnect', or 'Multistream'")
  }

  if $transport_multicast_session_policy_threshold < 0 {
    fail("::wds::config::transport_multicast_session_policy_threshold (${transport_multicast_session_policy_threshold}) must be greater than or equal to 0")
  }

  if $transport_multicast_session_policy_stream_count != 2 and $transport_multicast_session_policy_stream_count != 3 {
    fail("::wds::config::transport_multicast_session_policy_stream_count (${transport_multicast_session_policy_stream_count}) must be 2 or 3")
  }

  if $::wds_conf {
    if has_key($::wds_conf, 'installation_state') and has_key($::wds_conf['installation_state'], 'remoteinstall_location') and $remote_install_path != $::wds_conf['installation_state']['remoteinstall_location'] {
      exec { 'Uninitialize WDS Server - Remote Install Path Change':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Uninitialize-Server',
        before  => Exec['Initialize WDS Server'],
      }
    }

    class { '::wds::config::apply_settings':
      require => Exec['Initialize WDS Server'],
    }
  }
}
