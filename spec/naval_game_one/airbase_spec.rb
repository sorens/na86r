require 'spec_helper'

module NavalGameOne
	describe Airbase do
		let( :options )					{ options = { :name => 'Scapa Flow', 
														:max_allowed_combat_aircraft => 100 }  }
		let( :strike_aircraft )	{ ["F15", 10] }
		let( :target )					{ double( 'target', :id => 11, :name => "Task Force #{:id}")}
		
		before( :each ) do
			@airbase = Airbase.new( options )
			@airbase.add_aircraft( "F14", 20 )
			@airbase.add_aircraft( "F15", 20 )
		end
		
		it "should have a name" do
			@airbase.name.should == "Scapa Flow"
		end
		
		it "should count the total number of combat aircraft" do
			@airbase.total_combat_aircraft().should equal( 40 )
		end
		
		it "should be able to add squadrons" do
			@airbase.add_aircraft( "A6E", 20 )
			@airbase.total_combat_aircraft().should equal( 60 )
		end
		
		it "should have a maximum combat aircraft limitation" do
			@airbase.max_allowed_combat_aircraft.should equal( 100 )
		end
		
		it "should support multiple roles" do
			@airbase.aircraft_roles.should include( :combat )
			@airbase.aircraft_roles.should include( :transport )
			@airbase.aircraft_roles.should include( :search )
			@airbase.aircraft_roles.should include( :aew )
		end
		
		it "should be able to create a raid" do
			@airbase.create_raid( target, strike_aircraft, 100 )
			@airbase.raids.length.should equal(1)
		end
		
		it "should remove aircraft when it creates a raid" do
			@airbase.create_raid( target, strike_aircraft, 100 )
			@airbase.raids.length.should equal(1)
			@airbase.raids[0].squadrons[1].should equal( 10 )
			@airbase.total_combat_aircraft().should equal( 30 )
			@airbase.raids[0].standoff_range.should equal( 100 )
		end
		
		it "should prevent a raid from being created if there are not enough aircraft" do
			strike_aircraft = [ "F15", 50 ]
			expect { @airbase.create_raid( target, strike_aircraft, 100 ) }.to raise_error( Airbase::NotEnoughAircraft)
		end
		
	end
end