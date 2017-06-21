Facter.add(:wds_conf) do
  confine :osfamily => "Windows"
  
  setcode do
    $settingsRaw = Facter::Util::Resolution.exec('wdsutil /Get-Server /Show:Config')
    $settingsRaw.encode!('UTF-8', 'UTF-16', :invalid => :replace, :undef => :replace, :replace => '', :universal_newline => true)
    $settings = $settingsRaw.split("\n")
    
    def processLines(pl)
      section = {}
      level = 0
      previousLevel = pl

      while $ln < $settings.length do
        line = $settings[$ln]
        
        if !line.to_s.strip.empty?
          level = line.length - line.lstrip.length

          if level < previousLevel
            $ln -= 1
            break
          end

          if line.include? ':' and ($ln+1) < $settings.length and ($settings[$ln+1].length - $settings[$ln+1].lstrip.length) > level
            new_section = line.strip.downcase.gsub(':','').gsub(' ','_')
            $ln += 1

            if new_section == 'banned_guids_list' and !($settings[$ln].index(' ') == 0)
                section[new_section] = {}
            else
              section[new_section] = processLines(level)
            end

            if new_section == 'wds_unattend_files' and section[new_section].length = 0
              section[new_section] = { 'x86'=>'', 'x64'=>'', 'ia64'=>'' }
            end
          elsif line.index(' ') == 0
            if line.include? ':'
              setting = line.strip.sub(/:.*/,'')
              value = line.sub(setting + ':','').strip

              if value.include? ' second'
                value = value.sub(/ second.*/,'')
              elsif value.include? ' minute'
                value = value.sub(/ minute.*/,'')
              elsif value.include? ' hour'
                value = value.sub(/ hour.*/,'')
              elsif value.include? ' day'
                value = value.sub(/ day.*/,'')
              elsif value.include? ' time'
                value = value.sub(/ time.*/,'')
              elsif value.include? ' KBps'
                value = value.sub(/ KBps.*/,'')
              end

              setting = setting.downcase.gsub(' ','_')
              section[setting] = value
            elsif line.include? ' - '
              setting = line.strip.sub(/[ ]+-.*/,'')
              value = line.sub(/{Regexp.escape(setting)}[ ]*-/,'').strip
              setting = setting.downcase.gsub(' ','_')
              section[setting] = value
            end
          end

          previousLevel = level
        end

        $ln += 1
      end

      section
    end

    $ln = 0
    processLines(0)
  end
end
