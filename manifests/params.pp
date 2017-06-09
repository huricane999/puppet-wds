# Class wds::params
class wds::params {
  $install_feature = true

  $ensure_service = 'running'
  $enable_service = true

  $feature_name = 'WDS'

  $remote_install_path = 'C:\RemoteInstall'

  #==== Config Settings ====#

  # Initialize from scratch (needed if remote_install_path is not default)
  $initialize = true

  #== DHCP Server ==#

  # Requires access in AD
  $authorize = false

  $rogue_detection = false

  #== PXE Options ==#

  # all | known | none
  $answer_clients = 'all'

  # Time in Seconds
  $response_delay = 0

  # No F12 key
  $allow_n12_for_new_clients = true

  # For x64 clients that do no broadcast their arch
  $architecture_discovery = true

  #Determines whether the boot path will be erased for a client that has just booted without requiring an F12 key press.
  $reset_boot_program = false

  # Controls boot image for x64 clients (x86 | x64 | both)
  $default_x86_x64_image_type = 'both'

  # Should PXE bind to port 67
  $use_dhcp_ports = true

  # Only if DHCP is running on the same machine
  $dhcp_option_60 = false

  $rpc_port = 0

  # How clients initiate PXE boot (optin | noprompt | optout)
  $pxe_prompt_policy_known = 'optout'
  $pxe_prompt_policy_new = 'optout'

  #Specifies the relative path to the boot programs in the RemoteInstall folder
  $boot_program_x86 = ''
  $boot_program_x64 = ''
  $boot_program_ia64 = ''
  $n12_boot_program_x86 = ''
  $n12_boot_program_x64 = ''
  $n12_boot_program_ia64 = ''

  #Specifies the relative path to the boot image that booting clients should receive
  $boot_image_x86 = ''
  $boot_image_x64 = ''
  $boot_image_ia64 = ''

  $preferred_dc = ''
  $preferred_gc = ''

  $prestage_using_mac = false

  $new_machine_naming_policy = '%61Username%#'

  # serverdomain | userdomain | userou | custom
  $new_machine_type = 'userou'

  # OU when new_machine_type is set to cusom
  $new_machine_ou = ''

  # Specifies the policy for searching computer accounts in AD (gconly | dcfirst)
  $domain_search_order = 'dcfirst'

  $new_machine_domain_join = true

  $ocs_menu_name = ''

  $wds_client_logging = true
  # (none | errors | warnings | info)
  $wds_client_logging_level = 'errors'

  $wds_unattend_policy = false
  $wds_unattend_commandline_precedence = false
  $wds_unattend_file_x86 = ''
  $wds_unattend_file_x64 = ''
  $wds_unattend_file_ia64 = ''

  # (adminapproval | disabled)
  $auto_add_policy = 'disabled'
  $auto_add_policy_poll_interval = 15
  $auto_add_policy_max_retry = 10
  $auto_add_policy_message = ''
  $auto_add_policy_retention_period_approved = 7
  $auto_add_policy_retention_period_others = 7

  $auto_add_settings_defaults = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => '',
    join_rights         => 'full',
    join_domain         => true,
  }
  $auto_add_settings_x86 = {}
  $auto_add_settings_x64 = {}
  $auto_add_settings_ia64 = {}

  # Define the interfaces the PXE listens on
  $bind_policy = 'include'
  $bind_policy_addresses = []

  # How often the server refreshes its settings
  $refresh_period = 600

  # GUIDS not allowed to connect to the server
  $banned_guids = []

  $bcd_refresh_policy_period = 0

  # (dhcp | range)
  $transport_obtain_ipv4_from = 'dhcp'
  # transport_obtain_ipv4_from set to range
  $transport_obtain_ipv4_from_start = ''
  $transport_obtain_ipv4_from_end = ''

  # (dhcp | range)
  $transport_obtain_ipv6_from = 'dhcp'
  # transport_obtain_ipv6_from set to range
  $transport_obtain_ipv6_from_start = ''
  $transport_obtain_ipv6_from_end = ''

  $transport_start_port = 0
  $transport_end_port = 0

  # (10Mbps | 100Mbps | 1Gbps | custom)
  $transport_profile = '1Gbps'

  # (none | autodisconnect | multistream)
  $transport_multicast_session_policy = 'multistream'

  # For Auto Disconnect (Speed in KBps)
  $transport_multicast_session_policy_threshold = 500

  # For Multistream (2 - Fast, Slow | 3 - Fast, Medium, Slow)
  $transport_multicast_session_policy_stream_count = 2

  # Fall back to unicast
  $transport_multicast_session_policy_fallback = true

  $transport_force_native = false
}
