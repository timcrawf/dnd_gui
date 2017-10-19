require 'Handle_yaml'

TEST_SAVE_DIR_PATH = '/Users/tim.crawford/dnd_gui/test_files/'

describe HandleYaml do
  test_YAML = HandleYaml.new(TEST_SAVE_DIR_PATH)
  describe 'YAML' do
    it 'save location' do
      expect(test_YAML.save_dir).to eql(TEST_SAVE_DIR_PATH)
    end
    # it 'false response for save location' do
    #   expect(HandleYaml.new('/nowhere').save_file_exists).to eql(false)
    # end
    it 'checks for save' do
      expect(test_YAML.save_file_exists(
        File.join(TEST_SAVE_DIR_PATH, "John Smith.yaml"))).to eql(true)
    end
    it 'class of loaded YAML' do
      expect(test_YAML.load_player("John Smith").class).to eql(Hash)
    end
    it 'returns list of all saved players' do
      expect(test_YAML.all_players.class).to eql(Array)
    end
    it 'returns player name' do
      expect(test_YAML.all_players[0]).to eql("John Smith")
    end
    it 'retruns player with name John Smith' do
      expect(test_YAML.player("John Smith")).to eql("John Smith")
    end
    ## TODO Add test for saveing YAML
  end
end
