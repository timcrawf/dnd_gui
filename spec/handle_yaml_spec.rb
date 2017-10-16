require 'Handle_yaml'

TEST_FILE_PATH = '/Users/tim/Desktop/dnd_gui/test_files/test.yaml'

describe HandleYaml do
  test_YAML = HandleYaml.new(TEST_FILE_PATH)
  describe 'YAML' do
    it 'save location' do
      expect(test_YAML.save_path).to eql(TEST_FILE_PATH)
    end
    it 'false response for save location' do
      expect(HandleYaml.new('/nowhere').save_file_exists).to eql(false)
    end
    it 'checks for save' do
      expect(test_YAML.save_file_exists).to eql(true)
    end
    it 'class of loaded YAML' do
      expect(test_YAML.load_yaml.class).to eql(Hash)
    end
    ## TODO Add test for saveing YAML
  end
end
