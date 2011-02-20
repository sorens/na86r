module NavalGameOne
  class Game
    def initialize( output )
      @output = output
    end
    
    def start
      @output.puts ""
      @output.puts "NORTH ATLANTIC 86"
      @output.puts ""
      @output.puts "COPYRIGHT 1982"
      @output.puts "BY GARY GRIGSBY"
      @output.puts "(redux by skorens)"
      @output.puts ""
      @output.puts "( 1 ) NEW GAME        SAVED GAME"
      @output.puts "( 2 ) COLOR           BLACK AND WHITE"
      @output.puts "( 3 ) SOLITAIRE       TWO PLAYER"
      @output.puts "( 4 ) SOLITAIRE LEVEL 1  2  3  4"
      @output.puts "      (1=HARDEST 4=EASIEST)"
      @output.puts ""
      @output.puts "SCENARIOS"
      @output.puts " ( 5 ) CAMPAIGN.1 (SEP07-DEC31 1986)"
      @output.puts ""
      @output.puts "PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN."
    end
  end
end