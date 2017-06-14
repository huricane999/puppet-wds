<#
.SYNOPSIS
    Generates a JSON Hash describing the current configuration of a local WDS Service
.DESCRIPTION
    This script parses the out put of "wdsutil.exe /Get-Server /Show:Config" to generate a JSON Hash for use with facter.
.NOTES
    Additional Notes, eg
    File Name  : wds_conf_fact.ps1
    Author     : Chris Smith <huricane@huricane-development.com>
.LINK
    https://github.com/huricane999/puppet-wds
.RETURNVALUE
   wds = [JSON Hash]
#>

function processLines($pl)
{
    $section = @{}
    $level = 0
    $previousLevel = $pl

    For ($i=1; $i -gt $pl; $i--){
        $levelMarker = "-"
    }
    
    For ($global:ln; $global:ln -le $global:WDSSettingsRaw.length; $global:ln++)
    {
        $line = $global:WDSSettingsRaw[$global:ln]

        If ($line) {
            $level = $line.length - $line.TrimStart().length

            If ($level -lt $previousLevel) {
                $global:ln--
                Break
            }

            If ($line.Contains(":") -And $($global:WDSSettingsRaw[$global:ln+1].length - $global:WDSSettingsRaw[$global:ln+1].TrimStart().length) -gt $level) {
                $new_section = $line.Trim().ToLower() -Replace ":","" -Replace " ","_"
                $global:ln++

                If ($new_section.CompareTo("banned_guids_list") -And !$global:WDSSettingsRaw[$global:ln].StartsWith(" ")) {
                    $section[$new_section] = @{}
                } Else {
                    $section[$new_section] = processLines($level)
                }
            } ElseIf ($line.StartsWith(" ")) {
                If ($line.Contains(":")) {
                    $setting = $line.Trim() -Replace ":.*",""
                    $value = $($line -Replace $setting + ":","").Trim()

                    If ($value.Contains(" second")) {
                        $value = $value -Replace " second.*",""
                    } ElseIf ($value.Contains(" minute")) {
                        $value = $value -Replace " minute.*",""
                        $value = ([TimeSpan]$value).TotalSeconds
                    } ElseIf ($value.Contains(" hour")) {
                        $value = $value -Replace " hour.*",""
                        $value = ([TimeSpan]$value).TotalSeconds
                    } ElseIf ($value.Contains(" day")) {
                        $value = $value -Replace " day.*",""
                        $value = ([TimeSpan]$value).TotalSeconds
                    } ElseIf ($value.Contains(" time")) {
                        $value = $value -Replace " time.*",""
                    }

                    $setting = $setting.ToLower() -Replace " ","_"
                    $section[$setting] = $value
                } ElseIf ($line.Contains(" - ")) {
                    $setting = $line.Trim() -Replace "[ ]+-.*",""
                    $value = $($line -Replace $setting + "[ ]*-","").Trim()
                    $setting = $setting.ToLower() -Replace " ","_"
                    $section[$setting] = $value
                }
            }

            $previousLevel = $level
        }
    }

    return $section
}

$WDSSettingsRaw = ((wdsutil /Get-Server /Show:Config) | Out-String) -split "`r`n"

$ln = 0

$WDSSettings = processLines(0)

Write-Host "wds_conf=$(ConvertTo-JSON -InputObject $WDSSettings -Compress)"
