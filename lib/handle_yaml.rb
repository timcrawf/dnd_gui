require 'yaml'

## Class to handle YAML insteractions
class HandleYaml
  attr_accessor :save_dir
  def initialize(path)
    @save_dir = File.path(path)
    create_main_directory
  end

  def create_main_directory
    Dir.mkdir(@save_dir) unless Dir.exist?(@save_dir)
  end

  def all_players
    Dir.glob(File.join(@save_dir, '*')).each do |player|
      player.sub!(@save_dir, '').sub!('.yaml', '')
    end
  end

  def player(player_name)
    players = all_players
    players[players.index(player_name)]
  end

  def save_file_exists(path)
    File.file?(path)
  end

  def load_yaml(path)
    YAML.load_file(path) if save_file_exists(path)
  end

  def player_path(player_name)
    File.join(@save_dir, "#{player_name}.yaml")
  end

  def load_player(player_name)
    load_yaml(player_path(player_name))
  end

  def save_yaml(player_name, save_data)
    File.open(player_path(player_name), 'w') { |f| f.write(save_data) }
  end
end
