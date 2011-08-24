module NavalConflict
  class Game

    SELECTED    = "===>"
    UNSELECTED  = "    "

    attr_accessor :game_type, :screen_type, :player_type, :level, :scenario

    def initialize( output )
      @output = output
      @game_type = :new
      @screen_type = :color
      @player_type = :solitaire
      @level = :three
      @scenario = :campaign1
    end

    def start
      clear_screen( @output )
      @output.puts ""
      @output.puts "            NORTH ATLANTIC 86"
      @output.puts ""
      @output.puts "            COPYRIGHT 1982"
      @output.puts "            BY GARY GRIGSBY"
      @output.puts "           (redux by skorens)"
      @output.puts ""
      @output.puts "      ( 1 ) GAME TYPE:"
      @output.puts " #{game_type_selected( :new )}   NEW GAME"
      @output.puts " #{game_type_selected( :saved )}   SAVED GAME"
      @output.puts "      ( 2 ) SCREEN TYPE:"
      @output.puts " #{screen_type_selected( :color )}   COLOR"
      @output.puts " #{screen_type_selected( :black_and_white )}   BLACK AND WHITE"
      @output.puts "      ( 3 ) PLAYER TYPE:"
      @output.puts " #{player_type_selected( :solitaire )}   SOLITAIRE"
      @output.puts " #{player_type_selected( :two_player )}   TWO PLAYER"
      @output.puts "      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):"
      @output.puts " #{level_type_selected( :one )}   1"
      @output.puts " #{level_type_selected( :two )}   2"
      @output.puts " #{level_type_selected( :three )}   3"
      @output.puts " #{level_type_selected( :four )}   4"
      @output.puts ""
      @output.puts "SCENARIOS:"
      @output.puts " #{scenario_selected( :campaign1 )} ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)"
      @output.puts " #{scenario_selected( :campaign2 )} ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)"
      @output.puts " #{scenario_selected( :convoy_qr44 )} ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)"
      @output.puts " #{scenario_selected( :iceland )} ( 8 ) ICELAND        (NOV11-NOV20 1986)"
      @output.puts ""
      @output.puts "PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN."
    end

    def setup( game=:new, screen=:color, player=:solitaire, level=:three, scenario=:campaign1)
      @game_type = game
      @screen_type = screen
      @player_type = player
      @level = level
      @scenario = scenario
    end

    def toggle_game
      if :new == @game_type
        @game_type = :saved
      else
        @game_type = :new
      end
    end

    def toggle_player
      if :solitaire == @player_type
        @player_type = :two_player
      else
        @player_type = :solitaire
      end
    end

    def toggle_screen
      if :color == @screen_type
        @screen_type = :black_and_white
      else
        @screen_type = :color
      end
    end

    def toggle_level
      case @level
      when :one
        @level = :two
      when :two
        @level = :three
      when :three
        @level = :four
      when :four
        @level = :one
      end
    end

    private
    # clears the screen
    def clear_screen( output )
      if output
        output.puts "\e[H\e[2J"
      end
    end

    def game_type_selected( type )
      selected( game_type, type )
    end

    def screen_type_selected( type )
      selected( screen_type, type )
    end

    def player_type_selected( type )
      selected( player_type, type )
    end

    def level_type_selected( type )
      selected( level, type )
    end

    def scenario_selected( type )
      selected( scenario, type )
    end

    def selected( field, type )
      if field == type
        Game::SELECTED
      else
        Game::UNSELECTED
      end
    end
  end
end