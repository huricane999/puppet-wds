Facter.add(:wds_conf) do
  setcode do
          $settingsRaw = Facter::Util::Resolution.exec('wdsutil /Get-Server /Show:Config').split('\r\n').encode!('UTF-8')

    def processLines(pl)
      $section = {}
      $level = 0
      $previousLevel = pl

      while $ln <= $settingsRaw.length do
        $line = $settingsRaw[ln]

        if $line
          $level = $line.length - $line.lstrip.length

          if $level < $previousLevel
            $ln -= 1
            break
          end

          if $line.include? ":" and ($settingsRaw[ln+1].length - $settingsRaw[ln+1].lstrip.length) > $level
            $new_section = $line.strip.downcase.sub(":","").sub(" ","_")
            $ln += 1

            if $new_section == "banned_guids_list" and !($settingsRaw[ln].index(" ") == 0)
                $section[$new_section] = {}
            else
              $section[$new_section] = processLines($level)
            end

            if $new_section == "wds_unattend_files" and $section[$new_section].length = 0
              $section[$new_section] = { 'x86'=>'', 'x64'=>'', 'ia64'=>'' }
            end
          elsif $line.index(" ") == 0
            if $line.include? ":"
              $setting = $line.strip.sub(":.*","")
              $value = $line.sub($setting + ":","").strip

              if $value.include? " second"
                $value = $value.sub(" second.*","")
              elsif $value.index? " minute"
                $value = $value.sub(" minute.*","")
              elsif $value.index? " hour"
                $value = $value.sub(" hour.*","")
              elsif $value.index? " day"
                $value = $value.sub(" day.*","")
              elsif $value.index? " time"
                $value = $value.sub(" time.*","")
              end

              $setting = $setting.downcase.sub(" ","_")
              $section[$setting] = $value
            elsif $line.index? " - "
              $setting = $line.strip.sub("[ ]+-.*","")
              $value = $line.sub($setting + "[ ]*-","").strip
              $setting = $setting.downcase.sub(" ","_")
              $section[$setting] = $value
            end
          end

          $previousLevel = $level
        end

        $ln += 1
      end

      $section
    end

    $ln = 0
    processLines(0)
  end
end
