require 'spec_helper'

module NavalGameOne
  describe Game do
    describe "#start" do
        let( :output )    { double( 'output' ).as_null_object }
        let( :game )      { Game.new( output ) }
      
      it "shows setup screen" do
        output.should_receive( :puts ).with( 'NORTH ATLANTIC 86' )
        output.should_receive( :puts ).with( 'COPYRIGHT 1982' )
        output.should_receive( :puts ).with( 'BY GARY GRIGSBY' )
        output.should_receive( :puts ).with( '(redux by skorens)' )
        output.should_receive( :puts ).with( '( 1 ) NEW GAME        SAVED GAME' )
        output.should_receive( :puts ).with( '( 2 ) COLOR           BLACK AND WHITE' )
        output.should_receive( :puts ).with( '( 3 ) SOLITAIRE       TWO PLAYER' )
        output.should_receive( :puts ).with( '( 4 ) SOLITAIRE LEVEL 1  2  3  4' )
        output.should_receive( :puts ).with( '      (1=HARDEST 4=EASIEST)' )
        output.should_receive( :puts ).with( 'SCENARIOS' )
        output.should_receive( :puts ).with( ' ( 5 ) CAMPAIGN.1 (SEP07-DEC31 1986)' )
        
        game.start
      end
      
      it "prompts for settings" do
        output.should_receive( :puts ).with( 'PRESS A NUMBER TO ALTER THE SETUP. PRESS THE < SPC > BAR TO BEGIN.' )
        game.start
      end
    end
  end
end