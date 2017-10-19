require 'player'

describe Player do
  ## Tests player stats
  describe 'player' do
    ## Create test character
    test_player = Player.new("John Smith", 50, TEST_SAVE_DIR_PATH)
    test_player.health.current_health = 32
    test_player.save

    it 'returns name' do
      expect(test_player.name).to eql('John Smith')
    end
    ## Tests Health stats
    describe 'player_health' do
      it 'returns health class item' do
        expect(test_player.health.class).to eql(Health)
      end
      it 'returns current_health' do
        expect(test_player.health.current_health).to eql(32)
      end
    end
    ## Tests Hash and YAML conversions
    describe 'conversions' do
      describe 'Hash Tests' do
        test_hash = test_player.to_hash
        it 'returns hash' do
          expect(test_hash.class).to eql(Hash)
        end
        it 'returns player_name' do
          expect(test_hash[:name]).to eql('John Smith')
        end
        it 'returns current health' do
          expect(test_hash[:current_health]).to eql(32)
        end
        it 'returns current health' do
          expect(test_hash[:max_health]).to eql(50)
        end
      end
      describe 'YAML Tests' do
        it 'returns String class' do
          expect(test_player.to_yaml.class).to eql(String)
        end
      end
    end
    describe 'I/O Tests' do
      test_load = Player.load(TEST_SAVE_DIR_PATH, "John Smith")
      it 'returns loaded Player class' do
        expect(test_load.class).to eql(Player)
      end
      it 'returns loaded Player name' do
        expect(test_load.name).to eql("John Smith")
      end
      it 'returns loaded player max health' do
        expect(test_load.health.max_health).to eql(50)
      end
      it 'returns loaded player current health' do
        expect(test_load.health.current_health).to eql(32)
      end
    end
  end
end
