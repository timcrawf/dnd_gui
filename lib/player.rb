require_relative 'health'
require_relative 'handle_yaml'

## Class to control player stats
class Player
  attr_accessor :health
  attr_reader :name
  def initialize(name, max_health, save_path, current_health = nil)
    @name = name
    @health = Health.new(max_health, current_health)
    @yaml = HandleYaml.new(save_path)
  end

  def to_hash
    {
      name: @name,
      current_health: @health.current_health,
      max_health: @health.max_health
    }
  end

  def to_yaml
    to_hash.to_yaml
  end

  def save
    @yaml.save_yaml(to_yaml)
  end

  def self.load(path)
    loaded_hash = HandleYaml.new(path).load_yaml
    Player.new(
      loaded_hash[:name],
      loaded_hash[:max_health],
      path,
      loaded_hash[:current_health]
    )
  end
end
