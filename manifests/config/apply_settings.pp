# Class wds::config
class wds::config::apply_settings {
  #Authorize
  if $::wds::config::authorize and $::wds_conf[server_authorization][authorization_state] == 'Not Authorized' {
    exec { 'WDS Server - Authorize':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /Authorize:Yes',
    }
  } elsif !$::wds::config::authorize and $::wds_conf[server_authorization][authorization_state] != 'Not Authorized' {
    exec { 'WDS Server - Deauthorize':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /Authorize:No',
    }
  }

  #Rogue Detection
  if $::wds_conf[pxe_bind_policy][rogue_detection] != 'Not Authorized' {
    if $::wds::config::rogue_detection and $::wds_conf[pxe_bind_policy][rogue_detection] == 'Disabled' {
      exec { 'WDS Server - Enable Rogue Detection':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /RogueDetection:Yes',
      }
    } elsif !$::wds::config::rogue_detection and $::wds_conf[pxe_bind_policy][rogue_detection] != 'Disabled' {
      exec { 'WDS Server - Disable Rogue Detection':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /RogueDetection:No',
      }
    }
  }

  #Answer Clients
  case $::wds::config::answer_clients {
    'Known': {
      if $::wds_conf[answer_policy][answer_clients] == 'No' or $::wds_conf[answer_policy][answer_only_known_clients] == 'No' {
        exec { 'WDS Server - Answer Known Clients':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AnswerClients:Known',
        }
      }
    }
    'None': {
      if $::wds_conf[answer_policy][answer_clients] == 'Yes' or $::wds_conf[answer_policy][answer_only_known_clients] == 'Yes' {
        exec { 'WDS Server - Do Not Answer Clients':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AnswerClients:None',
        }
      }
    }
    default: {
      if $::wds_conf[answer_policy][answer_clients] == 'No' or $::wds_conf[answer_policy][answer_only_known_clients] == 'Yes' {
        exec { 'WDS Server - Answer All Clients':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AnswerClients:All',
        }
      }
    }
  }

  #Response Delay
  if $::wds::config::response_delay != $::wds_conf[answer_policy][response_delay] {
    exec { 'WDS Server - Response Delay':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /ResponseDelay:${::wds::config::response_delay}",
    }
  }

  #Allow N12 for New Clients
  if $::wds_conf[boot_program_policy][allow_n12_for_new_clients] != '<Not Applicable>' {
    if $::wds::config::allow_n12_for_new_clients and $::wds_conf[boot_program_policy][allow_n12_for_new_clients] == 'No' {
      exec { 'WDS Server - Allow N12 for New Clients':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AllowN12ForNewClients:Yes',
      }
    } elsif !$::wds::config::allow_n12_for_new_clients and $::wds_conf[boot_program_policy][allow_n12_for_new_clients] == 'Yes' {
      exec { 'WDS Server - Disallow N12 for New Clients':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AllowN12ForNewClients:No',
      }
    }
  }

  #Reset Boot Program
  if $::wds::config::reset_boot_program and $::wds_conf[boot_program_policy][reset_boot_program] == 'No' {
    exec { 'WDS Server - Reset Boot Program':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /ResetBootProgram:Yes',
    }
  } elsif !$::wds::config::reset_boot_program and $::wds_conf[boot_program_policy][reset_boot_program] == 'Yes' {
    exec { 'WDS Server - Do Not Reset Boot Program':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /ResetBootProgram:No',
    }
  }

  #Default X86 X64 Image Type
  if $::wds::config::default_x86_x64_image_type != $::wds_conf[boot_image_policy][default_image_type_for_x64_clients] {
    exec { 'WDS Server - Default X86 X64 Image Type':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /DefaultX86X64ImageType:${::wds::config::default_x86_x64_image_type}",
    }
  }

  #Use DHCP Ports
  if $::wds::config::use_dhcp_ports and $::wds_conf[pxe_bind_policy][use_dhcp_ports] == 'No' {
    exec { 'WDS Server - Use DHCP Ports':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /UseDhcpPorts:Yes',
    }
  } elsif !$::wds::config::use_dhcp_ports and $::wds_conf[pxe_bind_policy][use_dhcp_ports] == 'Yes' {
    exec { 'WDS Server - Do Not Use DHCP Ports':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /UseDhcpPorts:No',
    }
  }

  #Set DHCP Option 60
  if $::wds_conf[dhcp_configuration][dhcp_service_status] == 'Installed' {
    if $::wds::config::dhcp_option_60 and $::wds_conf[dhcp_configuration][dhcp_option_60_configured] == 'No' {
      exec { 'WDS Server - Set DHCP Option 60':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /DhcpOption60:Yes',
      }
    } elsif !$::wds::config::dhcp_option_60 and $::wds_conf[dhcp_configuration][dhcp_option_60_configured] == 'Yes' {
      exec { 'WDS Server - Do Not Set DHCP Option 60':
        command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /DhcpOption60:No',
      }
    }
  }

  #RPC Port
  if $::wds::config::rpc_port != $::wds_conf[pxe_bind_policy][rpc_port] {
    exec { 'WDS Server - RPC Port':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /RpcPort:${::wds::config::rpc_port}",
    }
  }

  #PXE Prompt Policy - Known
  if $::wds::config::pxe_prompt_policy_known != $::wds_conf[boot_program_policy][known_client_pxe_prompt_policy] {
    exec { 'WDS Server - PXE Prompt Policy - Known':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /PxePromptPolicy /Known:${::wds::config::pxe_prompt_policy_known}",
    }
  }

  #PXE Prompt Policy - New
  if $::wds::config::pxe_prompt_policy_new != $::wds_conf[boot_program_policy][new_client_pxe_prompt_policy] {
    exec { 'WDS Server - PXE Prompt Policy - New':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /PxePromptPolicy /New:${::wds::config::pxe_prompt_policy_new}",
    }
  }

  #Boot Program - x86
  if $::wds::config::boot_program_x86 != $::wds_conf[boot_program_policy][default_boot_programs][x86] {
    exec { 'WDS Server - Boot Program - x86':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootProgram:${::wds::config::boot_program_x86} /Architecture:x86",
    }
  }

  #Boot Program - x64
  if $::wds::config::boot_program_x64 != $::wds_conf[boot_program_policy][default_boot_programs][x64] {
    exec { 'WDS Server - Boot Program - x64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootProgram:${::wds::config::boot_program_x64} /Architecture:x64",
    }
  }

  #Boot Program - ia64
  if $::wds::config::boot_program_ia64 != $::wds_conf[boot_program_policy][default_boot_programs][ia64] {
    exec { 'WDS Server - Boot Program - ia64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootProgram:${::wds::config::boot_program_ia64} /Architecture:ia64",
    }
  }

  #N12 Boot Program - x86
  if $::wds::config::n12_boot_program_x86 != $::wds_conf[boot_program_policy][default_n12_boot_programs][x86] {
    exec { 'WDS Server - N12 Boot Program - x86':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /N12BootProgram:${::wds::config::n12_boot_program_x86} /Architecture:x86",
    }
  }

  #N12 Boot Program - x64
  if $::wds::config::n12_boot_program_x64 != $::wds_conf[boot_program_policy][default_n12_boot_programs][x64] {
    exec { 'WDS Server - N12 Boot Program - x64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /N12BootProgram:${::wds::config::n12_boot_program_x64} /Architecture:x64",
    }
  }

  #N12 Boot Program - ia64
  if $::wds::config::n12_boot_program_ia64 != $::wds_conf[boot_program_policy][default_n12_boot_programs][ia64] {
    exec { 'WDS Server - N12 Boot Program - ia64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /N12BootProgram:${::wds::config::n12_boot_program_ia64} /Architecture:ia64",
    }
  }

  #Boot Image - x86
  if $::wds::config::boot_image_x86 != $::wds_conf[boot_image_policy][default_boot_images][x86] {
    exec { 'WDS Server - Boot Image - x86':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootImage:${::wds::config::boot_image_x86} /Architecture:x86",
    }
  }

  #Boot Image - x64
  if $::wds::config::boot_image_x64 != $::wds_conf[boot_image_policy][default_boot_images][x64] {
    exec { 'WDS Server - Boot Image - x64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootImage:${::wds::config::boot_image_x64} /Architecture:x64",
    }
  }

  #Boot Image - ia64
  if $::wds::config::boot_image_ia64 != $::wds_conf[boot_image_policy][default_boot_images][ia64] {
    exec { 'WDS Server - Boot Image - ia64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BootImage:${::wds::config::boot_image_ia64} /Architecture:ia64",
    }
  }

  #Preferred DC
  if $::wds::config::preferred_dc != $::wds_conf[active_directory_use_policy][preferred_dc] {
    exec { 'WDS Server - Preferred DC':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /PreferredDC:${::wds::config::preferred_dc}",
    }
  }

  #Preferred GC
  if $::wds::config::preferred_gc != $::wds_conf[active_directory_use_policy][preferred_gc] {
    exec { 'WDS Server - Preferred GC':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /PreferredGC:${::wds::config::preferred_gc}",
    }
  }

  #Prestage Using MAC
  if $::wds::config::prestage_using_mac and $::wds_conf[active_directory_use_policy][prestage_devices_using_mac] == 'No' {
    exec { 'WDS Server - Prestage Using MAC':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /PrestageUsingMAC:Yes',
    }
  } elsif !$::wds::config::prestage_using_mac and $::wds_conf[active_directory_use_policy][prestage_devices_using_mac] == 'Yes' {
    exec { 'WDS Server - Do Not Prestage Using MAC':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /PrestageUsingMAC:No',
    }
  }

  #New Machine Naming Policy
  if $::wds::config::new_machine_naming_policy != $::wds_conf[active_directory_use_policy][new_computer_naming_policy] {
    exec { 'WDS Server - New Machine Naming Policy':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /NewMachineNamingPolicy:${::wds::config::new_machine_naming_policy}",
    }
  }

  #New Machine Type
  if $::wds::config::new_machine_type != $::wds_conf[new_computer_ou][ou_type] {
    exec { 'WDS Server - New Machine Type':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /NewMachineOU /Type:${::wds::config::new_machine_type}",
    }
  }

  #New Machine OU
  if $::wds::config::new_machine_ou != $::wds_conf[new_computer_ou][ou] {
    exec { 'WDS Server - New Machine OU':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /NewMachineOU /OU:${::wds::config::new_machine_ou}",
    }
  }

  #Domain Search Order
  case $::wds::config::domain_search_order {
    'DCFirst': {
      if $::wds_conf[active_directory_use_policy][domain_search_order] != 'Domain Controller First' {
        exec { 'WDS Server - Domain Search Order':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /DomainSearchOrder:DCFirst',
        }
      }
    }
    default: {
      if $::wds_conf[active_directory_use_policy][domain_search_order] != 'Global Catalog Only' {
        exec { 'WDS Server - Domain Search Order':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /DomainSearchOrder:GCOnly',
        }
      }
    }
  }

  #New Machine Domain Join
  if $::wds::config::new_machine_domain_join and $::wds_conf[active_directory_use_policy][new_computers_join_domain] == 'No' {
    exec { 'WDS Server - New Machine Domain Join':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /NewMachineDomainJoin:Yes',
    }
  } elsif !$::wds::config::new_machine_domain_join and $::wds_conf[active_directory_use_policy][new_computers_join_domain] == 'Yes' {
    exec { 'WDS Server - New Machine No Domain Join':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /NewMachineDomainJoin:No',
    }
  }

  #WDS Client Logging
  if $::wds::config::wds_client_logging and $::wds_conf[wds_client_policy][logging_policy][enabled] == 'No' {
    exec { 'WDS Server - WDS Client Logging Enabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsClientLogging /Enabled:Yes',
    }
  } elsif !$::wds::config::wds_client_logging and $::wds_conf[wds_client_policy][logging_policy][enabled] == 'Yes' {
    exec { 'WDS Server - WDS Client Logging Disabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsClientLogging /Enabled:No',
    }
  }

  #WDS Client Logging Level
  if $::wds::config::wds_client_logging_level != $::wds_conf[wds_client_policy][logging_policy][loging_level] {
    exec { 'WDS Server - WDS Client Logging Level':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsClientLogging /LoggingLevel:${::wds::config::wds_client_logging_level}",
    }
  }

  #WDS Unattend Policy
  if $::wds::config::wds_unattend_policy and $::wds_conf[wds_client_policy][unattend_policy][enabled] == 'No' {
    exec { 'WDS Server - WDS Unattend Policy Enabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /Policy:Enabled',
    }
  } elsif !$::wds::config::wds_unattend_policy and $::wds_conf[wds_client_policy][unattend_policy][enabled] == 'Yes' {
    exec { 'WDS Server - WDS Unattend Policy Disabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /Policy:Disabled',
    }
  }

  #WDS Unattend Policy Command Line Precedence
  if $::wds::config::wds_unattend_commandline_precedence and $::wds_conf[wds_client_policy][unattend_policy][command-line_precedence] == 'No' {
    exec { 'WDS Server - WDS Unattend Policy Command Line Precedence Enabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /CommandlinePrecedence:Yes',
    }
  } elsif !$::wds::config::wds_unattend_commandline_precedence and $::wds_conf[wds_client_policy][unattend_policy][command-line_precedence] == 'Yes' {
    exec { 'WDS Server - WDS Unattend Policy Command Line Precedence Disabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /CommandlinePrecedence:No',
    }
  }

  #WDS Unattend File - x86
  if is_hash($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files]) and has_key($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files], 'x86') {
    if $::wds::config::wds_unattend_file_x86 != $::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files][x86] {
      exec { 'WDS Server - WDS Unattend File - x86':
        command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /File:${::wds::config::wds_unattend_file_x86} /Architecture:x86",
      }
    }
  }

  #WDS Unattend File - x64
  if is_hash($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files]) and has_key($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files], 'x64') {
  if $::wds::config::wds_unattend_file_x64 != $::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files][x64] {
    exec { 'WDS Server - WDS Unattend File - x64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /File:${::wds::config::wds_unattend_file_x64} /Architecture:x64",
    }
  }
  }

  #WDS Unattend File - ia64
  if is_hash($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files]) and has_key($::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files], 'ia64') {
  if $::wds::config::wds_unattend_file_ia64 != $::wds_conf[wds_client_policy][unattend_policy][wds_unattend_files][ia64] {
    exec { 'WDS Server - WDS Unattend File - ia64':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /WdsUnattend /File:${::wds::config::wds_unattend_file_ia64} /Architecture:ia64",
    }
  }
  }

  #Auto Add Policy
  if $::wds::config::auto_add_policy != $::wds_conf[pending_device_policy][policy] {
    exec { 'WDS Server - Auto Add Policy':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /Policy:${::wds::config::auto_add_policy}",
    }
  }

  #Auto Add Policy Poll Interval
  if $::wds::config::auto_add_policy_poll_interval != $::wds_conf[pending_device_policy][poll_interval] {
    exec { 'WDS Server - Auto Add Policy Poll Interval':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /PollInterval:${::wds::config::auto_add_policy_poll_interval}",
    }
  }

  #Auto Add Policy Max Retry Count
  if $::wds::config::auto_add_policy_max_retry_count != $::wds_conf[pending_device_policy][max_retry_count] {
    exec { 'WDS Server - Auto Add Policy Max Retry Count':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /MaxRetry:${::wds::config::auto_add_policy_max_retry_count}",
    }
  }

  #Auto Add Policy Message
  if $::wds::config::auto_add_policy_message != $::wds_conf[pending_device_policy][message_to_pending_clients] {
    exec { 'WDS Server - Auto Add Policy Message':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /Message:${::wds::config::auto_add_policy_message}",
    }
  }

  #Auto Add Policy Retention Period - Approved
  if $::wds::config::auto_add_policy_retention_period_approved != $::wds_conf[pending_device_policy][retention_period][approved_devices] {
    exec { 'WDS Server - Auto Add Policy Retention Period - Approved':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /RetentionPeriod /Approved:${::wds::config::auto_add_policy_retention_period_approved}",
    }
  }

  #Auto Add Policy Retention Period - Others
  if $::wds::config::auto_add_policy_retention_period_others != $::wds_conf[pending_device_policy][retention_period][other_devices] {
    exec { 'WDS Server - Auto Add Policy Retention Period - Others':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddPolicy /RetentionPeriod /Others:${::wds::config::auto_add_policy_retention_period_others}",
    }
  }

  #### Auto Add Settings - x86
  #Auto Add Settings - x86 - Boot Program
  if $::wds::config::auto_add_settings_combined_x86[boot_program] != $::wds_conf[pending_device_policy][defaults_for_x86][boot_program_path] {
    exec { 'WDS Server - Auto Add Settings - x86 - Boot Program':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootProgram:${::wds::config::auto_add_settings_combined_x86[boot_program]} /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - Boot Image
  if $::wds::config::auto_add_settings_combined_x86[boot_image] != $::wds_conf[pending_device_policy][defaults_for_x86][boot_image_path] {
    exec { 'WDS Server - Auto Add Settings - x86 - Boot Image':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootImage:${::wds::config::auto_add_settings_combined_x86[boot_image]} /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - Referral Server
  if $::wds::config::auto_add_settings_combined_x86[referral_server] != $::wds_conf[pending_device_policy][defaults_for_x86][referral_server] {
    exec { 'WDS Server - Auto Add Settings - x86 - Referral Server':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /ReferralServer:${::wds::config::auto_add_settings_combined_x86[referral_server]} /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - WDS Client Unattend File
  if $::wds::config::auto_add_settings_combined_x86[wds_client_unattend] != $::wds_conf[pending_device_policy][defaults_for_x86][wds_client_unattend_file_path] {
    exec { 'WDS Server - Auto Add Settings - x86 - WDS Client Unattend File':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /WdsClientUnattend:${::wds::config::auto_add_settings_combined_x86[wds_client_unattend]} /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - User
  if $::wds::config::auto_add_settings_combined_x86[user] != $::wds_conf[pending_device_policy][defaults_for_x86][user] {
    $auto_add_settings_x86_user = $::wds::config::auto_add_settings_combined_x86[user]
    exec { 'WDS Server - Auto Add Settings - x86 - User':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /User:\"${auto_add_settings_x86_user}\" /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - Join Rights
  if $::wds::config::auto_add_settings_combined_x86[join_rights] != $::wds_conf[pending_device_policy][defaults_for_x86][join_rights] {
    exec { 'WDS Server - Auto Add Settings - x86 - Join Rights':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinRights:${::wds::config::auto_add_settings_combined_x86[join_rights]} /Architecture:x86",
    }
  }

  #Auto Add Settings - x86 - Join Domain
  if $::wds::config::auto_add_settings_combined_x86[join_domain] and $::wds_conf[pending_device_policy][defaults_for_x86][join_domain] == 'No' {
    exec { 'WDS Server - Auto Add Settings - x86 - Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:Yes /Architecture:x86',
    }
  } elsif !$::wds::config::auto_add_settings_combined_x86[join_domain] and $::wds_conf[pending_device_policy][defaults_for_x86][join_domain] == 'Yes' {
    exec { 'WDS Server - Auto Add Settings - x86 - Do Not Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:No /Architecture:x86',
    }
  }

  #### Auto Add Settings - x64
  #Auto Add Settings - x64 - Boot Program
  if $::wds::config::auto_add_settings_combined_x64[boot_program] != $::wds_conf[pending_device_policy][defaults_for_x64][boot_program_path] {
    exec { 'WDS Server - Auto Add Settings - x64 - Boot Program':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootProgram:${::wds::config::auto_add_settings_combined_x64[boot_program]} /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - Boot Image
  if $::wds::config::auto_add_settings_combined_x64[boot_image] != $::wds_conf[pending_device_policy][defaults_for_x64][boot_image_path] {
    exec { 'WDS Server - Auto Add Settings - x64 - Boot Image':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootImage:${::wds::config::auto_add_settings_combined_x64[boot_image]} /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - Referral Server
  if $::wds::config::auto_add_settings_combined_x64[referral_server] != $::wds_conf[pending_device_policy][defaults_for_x64][referral_server] {
    exec { 'WDS Server - Auto Add Settings - x64 - Referral Server':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /ReferralServer:${::wds::config::auto_add_settings_combined_x64[referral_server]} /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - WDS Client Unattend File
  if $::wds::config::auto_add_settings_combined_x64[wds_client_unattend] != $::wds_conf[pending_device_policy][defaults_for_x64][wds_client_unattend_file_path] {
    exec { 'WDS Server - Auto Add Settings - x64 - WDS Client Unattend File':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /WdsClientUnattend:${::wds::config::auto_add_settings_combined_x64[wds_client_unattend]} /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - User
  if $::wds::config::auto_add_settings_combined_x64[user] != $::wds_conf[pending_device_policy][defaults_for_x64][user] {
    exec { 'WDS Server - Auto Add Settings - x64 - User':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /User:\"${::wds::config::auto_add_settings_combined_x64[user]}\" /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - Join Rights
  if $::wds::config::auto_add_settings_combined_x64[join_rights] != $::wds_conf[pending_device_policy][defaults_for_x64][join_rights] {
    exec { 'WDS Server - Auto Add Settings - x64 - Join Rights':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinRights:${::wds::config::auto_add_settings_combined_x64[join_rights]} /Architecture:x64",
    }
  }

  #Auto Add Settings - x64 - Join Domain
  if $::wds::config::auto_add_settings_combined_x64[join_domain] and $::wds_conf[pending_device_policy][defaults_for_x64][join_domain] == 'No' {
    exec { 'WDS Server - Auto Add Settings - x64 - Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:Yes /Architecture:x64',
    }
  } elsif !$::wds::config::auto_add_settings_combined_x64[join_domain] and $::wds_conf[pending_device_policy][defaults_for_x64][join_domain] == 'Yes' {
    exec { 'WDS Server - Auto Add Settings - x64 - Do Not Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:No /Architecture:x64',
    }
  }

  #### Auto Add Settings - ia64
  #Auto Add Settings - ia64 - Boot Program
  if $::wds::config::auto_add_settings_combined_ia64[boot_program] != $::wds_conf[pending_device_policy][defaults_for_ia64][boot_program_path] {
    exec { 'WDS Server - Auto Add Settings - ia64 - Boot Program':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootProgram:${::wds::config::auto_add_settings_combined_ia64[boot_program]} /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - Boot Image
  if $::wds::config::auto_add_settings_combined_ia64[boot_image] != $::wds_conf[pending_device_policy][defaults_for_ia64][boot_image_path] {
    exec { 'WDS Server - Auto Add Settings - ia64 - Boot Image':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /BootImage:${::wds::config::auto_add_settings_combined_ia64[boot_image]} /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - Referral Server
  if $::wds::config::auto_add_settings_combined_ia64[referral_server] != $::wds_conf[pending_device_policy][defaults_for_ia64][referral_server] {
    exec { 'WDS Server - Auto Add Settings - ia64 - Referral Server':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /ReferralServer:${::wds::config::auto_add_settings_combined_ia64[referral_server]} /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - WDS Client Unattend File
  if $::wds::config::auto_add_settings_combined_ia64[wds_client_unattend] != $::wds_conf[pending_device_policy][defaults_for_ia64][wds_client_unattend_file_path] {
    exec { 'WDS Server - Auto Add Settings - ia64 - WDS Client Unattend File':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /WdsClientUnattend:${::wds::config::auto_add_settings_combined_ia64[wds_client_unattend]} /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - User
  if $::wds::config::auto_add_settings_combined_ia64[user] != $::wds_conf[pending_device_policy][defaults_for_ia64][user] {
    exec { 'WDS Server - Auto Add Settings - ia64 - User':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /User:\"${::wds::config::auto_add_settings_combined_ia64[user]}\" /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - Join Rights
  if $::wds::config::auto_add_settings_combined_ia64[join_rights] != $::wds_conf[pending_device_policy][defaults_for_ia64][join_rights] {
    exec { 'WDS Server - Auto Add Settings - ia64 - Join Rights':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinRights:${::wds::config::auto_add_settings_combined_ia64[join_rights]} /Architecture:ia64",
    }
  }

  #Auto Add Settings - ia64 - Join Domain
  if $::wds::config::auto_add_settings_combined_ia64[join_domain] and $::wds_conf[pending_device_policy][defaults_for_ia64][join_domain] == 'No' {
    exec { 'WDS Server - Auto Add Settings - ia64 - Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:Yes /Architecture:ia64',
    }
  } elsif !$::wds::config::auto_add_settings_combined_ia64[join_domain] and $::wds_conf[pending_device_policy][defaults_for_ia64][join_domain] == 'Yes' {
    exec { 'WDS Server - Auto Add Settings - ia64 - Do Not Join Domain':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /AutoAddSettings /JoinDomain:No /Architecture:ia64',
    }
  }

  #Bind Policy
  if $::wds::config::bind_policy == 'Include' and $::wds_conf[interface_bind_policy][policy] == 'Exclude Registered' {
    exec { 'WDS Server - Bind Policy - Include Registered':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /BindPolicy /Policy:Include',
    }
  } elsif $::wds::config::bind_policy == 'Exclude' and $::wds_conf[interface_bind_policy][policy] == 'Include Registered' {
    exec { 'WDS Server - Bind Policy - Exclude Registered':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /BindPolicy /Policy:Exclude',
    }
  }

  #### TODO: Add/Remove Bound IP/MAC Addresses

  #Refresh Period
  if $::wds::config::refresh_period != $::wds_conf[server_automatic_refresh_policy][refresh_period] {
    exec { 'WDS Server - Refresh Period':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /RefreshPeriod:${::wds::config::refresh_period}",
    }
  }

  #### TODO: Banned GUIDs

  #BCD Refresh Policy
  if $::wds::config::bcd_refresh_policy_period == 0 and $::wds::config::bcd_refresh_policy_period != $::wds_conf[bcd_refresh_policy][enabled] == 'Yes' {
    exec { 'WDS Server - BCD Refresh Policy Disabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /BcdRefreshPolicy /Enabled:No',
    }
  } elsif $::wds::config::bcd_refresh_policy_period > 0 and $::wds::config::bcd_refresh_policy_period != $::wds_conf[bcd_refresh_policy][enabled] == 'No' {
    exec { 'WDS Server - BCD Refresh Policy Enabled':
      command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /BcdRefreshPolicy /Enabled:Yes',
    }
  }

  #BCD Refresh Policy Period
  if $::wds::config::bcd_refresh_policy_period > 0 and $::wds::config::bcd_refresh_policy_period != $::wds_conf[bcd_refresh_policy][refresh_period] {
    exec { 'WDS Server - BCD Refresh Period':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /BcdRefreshPolicy /RefreshPeriod:${::wds::config::bcd_refresh_policy_period}",
    }
  }

  #Transport Obtain IPv4 From
  case $::wds::config::transport_obtain_ipv4_from {
    'Dhcp': {
      if !has_key($::wds_conf[wds_transport_server_policy], 'ipv4_source_dhcp') {
        exec { 'WDS Server - Transport Obtain IPv4 From DHCP':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /ObtainIpv4From:Dhcp',
        }
      }
    }
    default: {
      if !has_key($::wds_conf[wds_transport_server_policy], 'ipv4_source_range') or $::wds::config::transport_obtain_ipv4_from_start != $::wds_conf[wds_transport_server_policy][ipv4_source_range][start_address] or $::wds::config::transport_obtain_ipv4_from_end != $::wds_conf[wds_transport_server_policy][ipv4_source_range][end_address] {
        exec { 'WDS Server - Transport Obtain IPv4 From Range':
          command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /ObtainIpv4From:Range /Start:${::wds::config::transport_obtain_ipv4_from_start} /End:${::wds::config::transport_obtain_ipv4_from_end}",
        }
      }
    }
  }

  #Transport Obtain IPv6 From
  case $::wds::config::transport_obtain_ipv6_from {
    'Dhcp': {
      if !has_key($::wds_conf[wds_transport_server_policy], 'ipv6_source_dhcp') {
        exec { 'WDS Server - Transport Obtain IPv6 From DHCP':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /ObtainIpv6From:Dhcp',
        }
      }
    }
    default: {
      if !has_key($::wds_conf[wds_transport_server_policy], 'ipv6_source_range') or $::wds::config::transport_obtain_ipv6_from_start != $::wds_conf[wds_transport_server_policy][ipv6_source_range][start_address] or $::wds::config::transport_obtain_ipv6_from_end != $::wds_conf[wds_transport_server_policy][ipv6_source_range][end_address] {
        exec { 'WDS Server - Transport Obtain IPv6 From Range':
          command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /ObtainIpv6From:Range /Start:${::wds::config::transport_obtain_ipv6_from_start} /End:${::wds::config::transport_obtain_ipv6_from_end}",
        }
      }
    }
  }

  #Transport Start/End Port
  if !has_key($::wds_conf[wds_transport_server_policy], 'udp_port_policy_dynamic') {
    if $::wds::config::transport_start_port != $::wds_conf[wds_transport_server_policy][udp_port_policy_dynamic][start_port] or $::wds::config::transport_end_port != $::wds_conf[wds_transport_server_policy][udp_port_policy_dynamic][end_port] {
      exec { 'WDS Server - Transport Start/End Port':
        command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /StartPort:${::wds::config::transport_start_port} /EndPort:${::wds::config::transport_end_port}",
      }
    }
  }

  #Transport Profile
  if $::wds_conf[wds_transport_server_policy][network_profile] != '<Not Applicable>' {
    if $::wds::config::transport_profile != $::wds_conf[wds_transport_server_policy][network_profile] {
      exec { 'WDS Server - Transport Profile':
        command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /Profile:${::wds::config::transport_profile}",
      }
    }
  }

  #Transport Multicast Session Policy
  case $::wds::config::transport_multicast_session_policy {
    'AutoDisconnect': {
      if $::wds_conf[wds_transport_server_policy][multicast_session_policy][slow_client_handling_policy] != 'AutoDisconnect' or $::wds::config::transport_multicast_session_policy_threshold != $::wds_conf[wds_transport_server_policy][multicast_session_policy][autodisconnect_threshold] {
        exec { 'WDS Server - Transport Multicast Session Policy - Auto Disconnect':
          command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /MulticastSessionPolicy /Policy:AutoDisconnect /Threshold:${::wds::config::transport_multicast_session_policy_threshold}",
        }
      }
    }
    'Multistream': {
      if $::wds_conf[wds_transport_server_policy][multicast_session_policy][slow_client_handling_policy] != 'Multistream' or $::wds::config::transport_multicast_session_policy_stream_count != $::wds_conf[wds_transport_server_policy][multicast_session_policy][multistream_stream_count] {
        if $::wds::config::transport_multicast_session_policy_fallback and $::wds_conf[wds_transport_server_policy][multicast_session_policy][slow_client_fallback] == 'No' {
          exec { 'WDS Server - Transport Multicast Session Policy - Multistream':
            command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /MulticastSessionPolicy /Policy:AutoDisconnect /Threshold:${::wds::config::transport_multicast_session_policy_threshold}",
          }
        } elsif !$::wds::config::transport_multicast_session_policy_fallback and $::wds_conf[wds_transport_server_policy][multicast_session_policy][slow_client_fallback] == 'Yes' {
          exec { 'WDS Server - Transport Multicast Session Policy - Multistream':
            command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /MulticastSessionPolicy /Policy:AutoDisconnect /Threshold:${::wds::config::transport_multicast_session_policy_threshold}",
          }
        }
      }
    }
    default: {
      if $::wds_conf[wds_transport_server_policy][multicast_session_policy][slow_client_handling_policy] != 'None' {
        exec { 'WDS Server - Transport Multicast Session Policy - None':
          command => 'C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /MulticastSessionPolicy /Policy:None',
        }
      }
    }
  }

  #Transport Force Native
  if $::wds::config::transport_force_native and $::wds_conf[server_state][wds_operational_mode] != 'Native' {
    exec { 'WDS Server - Transport Force Native':
      command => "C:\\Windows\\System32\\wdsutil.exe /Set-Server /Transport /ForceNative",
    }
  }
}
