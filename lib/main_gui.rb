require 'shoes'
require_relative '/Users/tim.crawford/dnd_gui/lib/player'

HOME_FOLDER = File.path(Dir.home)
MAIN_SAVE_LOCATION = File.join(HOME_FOLDER, '/dnd/')

# Main UI
class DNDCharacterStats < Shoes
  url '/',                    :index
  url '/load_player/(\w+)',   :load_player
  url '/new_player',          :new_player

  def index
    background blue
    flow do
      all_players = HandleYaml.new(MAIN_SAVE_LOCATION).all_players
      loaded_player = list_box items: all_players
      loaded_player.choose(all_players[0])
      button 'Load Player' do
        # @@loaded_player = loaded_player.text
        # puts @@loaded_player
        visit "/load_player/#{loaded_player.text.sub!(' ', '_')}"
      end
      button 'New Player' do
        visit '/new_player'
      end
    end
  end

  def load_player(loaded_player)
    player = Player.load(MAIN_SAVE_LOCATION, loaded_player.sub!('_', ' '))
    stack do
      caption player.name.to_s
      caption player.health.max_health
      button 'Back' do
        visit '/'
      end
    end
  end

  def new_player
    stack do
      flow do
        caption 'Name: '
        @player_name = edit_line width: 150
      end
      flow do
        caption 'Max Health: '
        @player_max_health = edit_line width: 50
      end
      flow do
        button 'Cancel' do
          visit '/'
        end
        button 'Submit' do
          puts @player_name.text
          puts @player_max_health.text
          test_player = Player.new(
            @player_name.text,
            @player_max_health.text,
            MAIN_SAVE_LOCATION
          )
          test_player.save
          visit '/'
        end
      end
    end
  end
end

Shoes.app width: 400, height: 300
