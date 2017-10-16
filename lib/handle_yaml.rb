require 'yaml'

## Class to handle YAML insteractions
class HandleYaml
  attr_accessor :save_path
  def initialize(path)
    @save_path = path
  end

  def save_file_exists
    File.file?(@save_path)
  end

  def load_yaml
    YAML.load_file(@save_path) if save_file_exists
  end

  def save_yaml(save_data)
    File.open(@save_path, 'w') { |f| f.write(save_data) }
  end
end
