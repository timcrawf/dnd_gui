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
    flow do
      button 'Load Player' do
         player = loaded_player.text
         player.sub!(' ', '_') if player.include?(' ')
        visit "/load_player/#{player}"
      end
      button 'New Player' do
        visit '/new_player'
      end
    end
      # button 'ANOTHER!' do
      #   window do
      #     DNDCharacterStats.new
      #   end
      # end
    end
  end

  def load_player(loaded_player)
    loaded_player.sub!('_', ' ') if loaded_player.include?('_')
    player = Player.load(MAIN_SAVE_LOCATION, loaded_player)
    stack do
      caption player.name.to_s
      current_health = caption player.health.current_health
      current_health.click do
        window width: 300, height: 100 do
          caption "Enter Change to Health"
          health_change = edit_line width: 25
          button "Submit" do
            player.health.add(health_change.text.to_i)
            player.save
            current_health.text = player.health.current_health
            close
          end
        end
      end
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

Shoes.app width: 225, height: 100
