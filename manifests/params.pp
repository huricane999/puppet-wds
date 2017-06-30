# Class wds::params
class wds::params {
  $install_feature = true

  $ensure_service = 'running'
  $enable_service = true

  $feature_name = 'WDS'

  $remote_install_path = 'C:\RemoteInstall'

  #==== Config Settings ====#
  # NOTE: For String values, case *IS* important for checking against current state

  # Initialize from scratch (needed if remote_install_path is not default)
  $initialize = true

  #== DHCP Server ==#

  # Requires access in AD
  $authorize = false

  $rogue_detection = false

  #== PXE Options ==#

  # All | Known | None
  $answer_clients = 'All'

  # Time in Seconds
  $response_delay = 0

  # No F12 key
  $allow_n12_for_new_clients = true

  #Determines whether the boot path will be erased for a client that has just booted without requiring an F12 key press.
  $reset_boot_program = false

  # Controls boot image for x64 clients (x86 | x64 | Both)
  $default_x86_x64_image_type = 'Both'

  # Should PXE bind to port 67
  $use_dhcp_ports = true

  # Only if DHCP is running on the same machine
  $dhcp_option_60 = false

  $rpc_port = 5040

  # How clients initiate PXE boot (OptIn | NoPrompt | OptOut)
  $pxe_prompt_policy_known = 'OptOut'
  $pxe_prompt_policy_new = 'OptOut'

  #Specifies the relative path to the boot programs in the RemoteInstall folder
  $boot_program_x86 = 'Boot\x86\pxeboot.com'
  $boot_program_x86uefi = 'Boot\x86\bootmgfw.efi'
  $boot_program_x64 = 'Boot\x64\pxeboot.com'
  $boot_program_x64uefi = 'Boot\x64\bootmgfw.efi'
  $boot_program_ia64 = 'Boot\ia64\bootmgfw.efi'
  $boot_program_arm = 'Boot\arm\bootmgfw.efi'
  $n12_boot_program_x86 = 'Boot\x86\pxeboot.n12'
  $n12_boot_program_x86uefi = 'Boot\x86\bootmgfw.efi'
  $n12_boot_program_x64 = 'Boot\x64\pxeboot.n12'
  $n12_boot_program_x64uefi = 'Boot\x64\bootmgfw.efi'
  $n12_boot_program_ia64 = 'Boot\ia64\bootmgfw.efi'
  $n12_boot_program_arm = 'Boot\arm\bootmgfw.efi'

  #Specifies the relative path to the boot image that booting clients should receive
  $boot_image_x86 = ''
  $boot_image_x86uefi = ''
  $boot_image_x64 = ''
  $boot_image_x64uefi = ''
  $boot_image_ia64 = ''
  $boot_image_arm = ''

  $preferred_dc = ''
  $preferred_gc = ''

  $prestage_using_mac = false

  $new_machine_naming_policy = '%61Username%#'

  # ServerDomain | UserDomain | UserOU | Custom
  $new_machine_type = 'UserOU'

  # OU when new_machine_type is set to custom
  $new_machine_ou = ''

  # Specifies the policy for searching computer accounts in AD (GCOnly | DCFirst)
  $domain_search_order = 'GCOnly'

  $new_machine_domain_join = true

  $wds_client_logging = true
  # (None | Errors | Warnings | Info)
  $wds_client_logging_level = 'Info'

  $wds_unattend_policy = false
  $wds_unattend_commandline_precedence = false
  $wds_unattend_file_x86 = ''
  $wds_unattend_file_x64 = ''
  $wds_unattend_file_ia64 = ''

  # (AdminApproval | Disabled)
  $auto_add_policy = 'Disabled'

  #Time in seconds
  $auto_add_policy_poll_interval = 10
  $auto_add_policy_max_retry_count = 2160
  $auto_add_policy_message = ''

  #Time in days
  $auto_add_policy_retention_period_approved = 30
  $auto_add_policy_retention_period_others = 1

  $auto_add_settings_x86 = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }
  $auto_add_settings_x86uefi = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }
  $auto_add_settings_x64 = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }
  $auto_add_settings_x64uefi = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }
  $auto_add_settings_ia64 = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }
  $auto_add_settings_arm = {
    boot_program        => '',
    wds_client_unattend => '',
    referral_server     => '',
    boot_image          => '',
    user                => 'Domain Admins',
    join_rights         => 'Full',
    join_domain         => true,
  }

  # Define the interfaces the PXE listens on (Include | Exclude)
  $bind_policy = 'Exclude'

  #Array of Hashes ({type => (IP | MAC), address => ''})
  $bind_policy_addresses = []

  # How often the server refreshes its settings (Time in seconds)
  $refresh_period = 900

  # GUIDS not allowed to connect to the server (Array of GUID strings)
  $banned_guids = []

  #Time in minutes (0 to disable)
  $bcd_refresh_policy_period = 0

  # (Dhcp | Range)
  $transport_obtain_ipv4_from = 'Range'
  # transport_obtain_ipv4_from set to range
  $transport_obtain_ipv4_from_start = '239.192.0.2'
  $transport_obtain_ipv4_from_end = '239.192.0.254'

  # (Dhcp | Range)
  $transport_obtain_ipv6_from = 'Range'
  # transport_obtain_ipv6_from set to range
  $transport_obtain_ipv6_from_start = 'FF15::1:1'
  $transport_obtain_ipv6_from_end = 'FF15::1:FF'

  $transport_start_port = 1025
  $transport_end_port = 65536

  # (10Mbps | 100Mbps | 1Gbps | custom)
  $transport_profile = '1Gbps'

  # (None | AutoDisconnect | Multistream)
  $transport_multicast_session_policy = 'None'

  # For Auto Disconnect (Speed in KBps)
  $transport_multicast_session_policy_threshold = 256

  # For Multistream (2 - Fast, Slow | 3 - Fast, Medium, Slow)
  $transport_multicast_session_policy_stream_count = 2

  # Fall back to unicast
  $transport_multicast_session_policy_fallback = true

  #Should be Native by default without setting this
  $transport_force_native = false
}
