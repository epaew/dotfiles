#!/usr/bin/env ruby

require 'yaml'

presets = YAML.safe_load(File.read(File.join(__dir__, 'ssh_window_presets.yml')),
                         symbolize_names: true)
profiles = presets[:profiles]

selected_profile_name =
  `echo "\n#{profiles.map { |p| p[:name] }.join("\n")}" | fzf`.chomp
exit unless selected_profile_name

selected_profile = profiles.find { |p| p[:name] == selected_profile_name }
selected_profile[:windows].each do |w|
  `tmux new-window #{%(-n "#{w[:name]}") if w[:name]}`

  w[:panes].each_with_index do |p, i|
    `tmux split-window -fv` unless i.zero?
    `tmux send-keys "#{p}" C-m`
  end
end

`tmux select-layout tiled`
