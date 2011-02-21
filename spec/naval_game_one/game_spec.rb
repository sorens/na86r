require 'spec_helper'

module NavalGameOne
  describe Game do
    describe "#start" do
        let( :output )    { double( 'output' ).as_null_object }
        let( :game )      { Game.new( output ) }
      
      it "shows initial setup screen" do
        game.setup()
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( ' ===>   NEW GAME' )
        output.should_receive( :puts ).with( '        SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( ' ===>   COLOR')
        output.should_receive( :puts ).with( '        BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( ' ===>   SOLITAIRE')
        output.should_receive( :puts ).with( '        TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( ' ===>   3')
        output.should_receive( :puts ).with( '        4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( ' ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end
      
      it "saved game setup screen" do
        game.setup( :saved )
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( '        NEW GAME' )
        output.should_receive( :puts ).with( ' ===>   SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( ' ===>   COLOR')
        output.should_receive( :puts ).with( '        BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( ' ===>   SOLITAIRE')
        output.should_receive( :puts ).with( '        TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( ' ===>   3')
        output.should_receive( :puts ).with( '        4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( ' ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end

      it "new game black and white setup screen" do
        game.setup( :new, :black_and_white )
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( ' ===>   NEW GAME' )
        output.should_receive( :puts ).with( '        SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( '        COLOR')
        output.should_receive( :puts ).with( ' ===>   BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( ' ===>   SOLITAIRE')
        output.should_receive( :puts ).with( '        TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( ' ===>   3')
        output.should_receive( :puts ).with( '        4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( ' ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end

      it "new game, color and two player setup screen" do
        game.setup( :new, :color, :two_player )
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( ' ===>   NEW GAME' )
        output.should_receive( :puts ).with( '        SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( ' ===>   COLOR')
        output.should_receive( :puts ).with( '        BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( '        SOLITAIRE')
        output.should_receive( :puts ).with( ' ===>   TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( ' ===>   3')
        output.should_receive( :puts ).with( '        4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( ' ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end

      it "new game, color, solitaire, level 4 setup screen" do
        game.setup( :new, :color, :solitaire, :four )
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( ' ===>   NEW GAME' )
        output.should_receive( :puts ).with( '        SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( ' ===>   COLOR')
        output.should_receive( :puts ).with( '        BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( ' ===>   SOLITAIRE')
        output.should_receive( :puts ).with( '        TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( '        3')
        output.should_receive( :puts ).with( ' ===>   4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( ' ===> ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end

      it "new game, color, solitaire, level 4, campaign.2 setup screen" do
        game.setup( :new, :color, :solitaire, :three, :campaign2 )
        output.should_receive( :puts ).with( '            NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( '            COPYRIGHT 1982' )
        output.should_receive( :puts ).with( '            BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '           (redux by skorens)' )
        output.should_receive( :puts ).with( '      ( 1 ) GAME TYPE:' )
        output.should_receive( :puts ).with( ' ===>   NEW GAME' )
        output.should_receive( :puts ).with( '        SAVED GAME' )
        output.should_receive( :puts ).with( '      ( 2 ) SCREEN TYPE:' )
        output.should_receive( :puts ).with( ' ===>   COLOR')
        output.should_receive( :puts ).with( '        BLACK AND WHITE' )
        output.should_receive( :puts ).with( '      ( 3 ) PLAYER TYPE:' )
        output.should_receive( :puts ).with( ' ===>   SOLITAIRE')
        output.should_receive( :puts ).with( '        TWO PLAYER')
        output.should_receive( :puts ).with( '      ( 4 ) SOLITAIRE LEVEL (1=HARDEST 4=EASIEST):' )
        output.should_receive( :puts ).with( '        1')
        output.should_receive( :puts ).with( '        2')
        output.should_receive( :puts ).with( ' ===>   3')
        output.should_receive( :puts ).with( '        4')
        output.should_receive( :puts ).with( 'SCENARIOS:' )
        output.should_receive( :puts ).with( '      ( 5 ) CAMPAIGN.1     (SEP07-DEC31 1986)' )
        output.should_receive( :puts ).with( ' ===> ( 6 ) CAMPAIGN.2     (NOV01-DEC31 1986)' )
        output.should_receive( :puts ).with( '      ( 7 ) CONVOY QR.44   (SEP25-SEP30 1986)' )
        output.should_receive( :puts ).with( '      ( 8 ) ICELAND        (NOV11-NOV20 1986)' )
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end
    end
  
		# describe "#run" do
		#         let( :output )    { double( 'output' ).as_null_object }
		#         let( :game )      { Game.new( output ) }
		#       	
		# 		it "should print the score screen" do
		# 			output.should_receive( :puts ).with( '7 SEP 86  AM' )
		# 			output.should_receive( :puts ).with( 'SCORE:' )
		# 			output.should_receive( :puts ).with( 'NATO		0' )
		# 			output.should_receive( :puts ).with( 'SOVIET	0' )
		# 			output.should_receive( :puts ).with( 'CLEAR' )
		# 			output.should_receive( :puts ).with( 'PRESS <C> TO CONTINUE' )
		# 		end
		# end

	end
end