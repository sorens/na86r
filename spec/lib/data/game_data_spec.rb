# game_data_spec.rb

require 'spec_helper'

describe GameData do

	before( :each ) do
		@resource = GameData.new
	end

	it "should support ships sunk" do
		@resource.respond_to?( "sunk" ).should be_true
		@resource.sunk.class.should == Hash
	end

	it "should support bases" do
		@resource.respond_to?( "bases" ).should be_true
		@resource.bases.class.should == Hash
	end

	it "should support fleets" do
		@resource.respond_to?( "fleets" ).should be_true
		@resource.fleets.class.should == Hash
	end

	it "should support troops" do
		@resource.respond_to?( "troops" ).should be_true
		@resource.troops.class.should == Hash
	end

	it "should support score" do
		@resource.respond_to?( "score" ).should be_true
		@resource.score.class.should == Fixnum
	end

	it "should support game time" do
		@resource.respond_to?( "game_time" ).should be_true
		@resource.game_time.class.should == Time
	end

	it "should support game start time" do
		@resource.respond_to?( "game_start_time" ).should be_true
		@resource.game_start_time.class.should == Time
	end

	it "should suppot after action reports" do
		@resource.respond_to?( "aar" ).should be_true
		@resource.aar.class.should == Array
	end

	it "should serialize and restore data" do
		@resource.sunk["1"] = "DDDD"
		@resource.sunk["2"] = "EEEE"
		@resource.sunk["3"] = "FFFF"
		@resource.bases["1"] = "EEEE"
		@resource.bases["2"] = "GGGG"
		@resource.bases["3"] = "HHHH"
		@resource.fleets["1"] = "IIII"
		@resource.fleets["2"] = "JJJJ"
		@resource.fleets["3"] = "KKKK"
		@resource.troops["1"] = "LLLL"
		@resource.troops["2"] = "MMMM"
		@resource.troops["3"] = "NNNN"
		@resource.score = 100
		@resource.game_time = Time.parse( "1 Jan 2000" )
		@resource.aar << "OOOO"
		@resource.aar << "PPPP"
		@resource.aar << "QQQQ"
		data = @resource.serialize
		data.should_not be_nil
		data.class.should == String

		gd = GameData.factory data
		gd.should_not be_nil
		gd.sunk["1"].should == "DDDD"
		gd.sunk["2"].should == "EEEE"
		gd.sunk["3"].should == "FFFF"
		gd.bases["1"].should == "EEEE"
		gd.bases["2"].should == "GGGG"
		gd.bases["3"].should == "HHHH"
		gd.fleets["1"].should == "IIII"
		gd.fleets["2"].should == "JJJJ"
		gd.fleets["3"].should == "KKKK"
		gd.troops["1"].should == "LLLL"
		gd.troops["2"].should == "MMMM"
		gd.troops["3"].should == "NNNN"
		gd.score.should == 100
		gd.game_time.should == Time.parse( "1 Jan 2000" )
		gd.aar.include?( "OOOO" ).should be_true
		gd.aar.include?( "PPPP" ).should be_true
		gd.aar.include?( "QQQQ" ).should be_true
	end

	it "should support a hash of NATO units" do
		GameData.respond_to?( "nato_ships" ).should be_true
		GameData.nato_ships.class.should == Hash
	end

	it "should support a hash of SOVIET units" do
		GameData.respond_to?( "soviet_ships" ).should be_true
		GameData.soviet_ships.class.should == Hash
	end

	it "should load NATO ship units from CSV data" do
		ns = GameData.nato_ships
		nimitz = ns["CVN-68"]
		nimitz.class.should == Unit
		nimitz.surface_ship?.should be_true
		nimitz.main_gun.should == 0
		nimitz.anti_aircraft.should == 0
		nimitz.missile_defense.should == 75
		nimitz.max_speed.should == 30
		nimitz.cargo_capacity.should ==72
		nimitz.defense_factor.should == 97
		nimitz.initial_task_force.should == "16"
		nimitz.arrival_days.should == 7
		nimitz.hull_number.should == "68"
		nimitz.hull_symbol.should == "CVN"
	end

	it "should load the ship data only once" do
		GameData.ship_data_loaded?.should be_true
	end

	it "should load SOVIET ship units from CSV data" do
		ss = GameData.soviet_ships
		kiev = ss["CVG-Kiev"]
		kiev.class.should == Unit
		kiev.surface_ship?.should be_true
		kiev.main_gun.should == 0
		kiev.anti_aircraft.should == 4
		kiev.missile_defense.should == 94
		kiev.max_speed.should == 30
		kiev.cargo_capacity.should ==15
		kiev.defense_factor.should == 50
		kiev.initial_task_force.should == "1"
		kiev.arrival_days.should == 0
		kiev.hull_number.should == nil
		kiev.hull_symbol.should == "CVG"
	end

	it "should put delayed NATO ships into the pipeline" do
		ns = GameData.nato_ships
	end

	it "should return the current game time" do
		@resource.game_time.should == Time.parse( GameData::GAME_STARTING_TIME )
	end

	it "should return the current game starting time" do
		@resource.game_start_time.should == Time.parse( GameData::GAME_STARTING_TIME )
	end

	it "should track the number of turns" do
		@resource.turn_count.should == 0
		turns = 13
		@resource.advance_turns(turns)
		@resource.turn_count.should == turns
	end

	it "should advance the game one turn" do
		@resource.next_turn
		@resource.game_time.should == @resource.game_start_time + GameData::ONE_TURN_IN_HOURS.hours
		@resource.game_start_time.should == Time.parse( GameData::GAME_STARTING_TIME )
		@resource.turn_count.should == 1
	end

	it "should advance the game two turns" do
		@resource.next_turn
		@resource.next_turn
		@resource.game_time.should == @resource.game_start_time + (GameData::ONE_TURN_IN_HOURS * 2).hours
		@resource.game_start_time.should == Time.parse( GameData::GAME_STARTING_TIME )
		@resource.turn_count.should == 2
	end

	it "should advance many turns" do
		turns = 13
		@resource.advance_turns(turns)
		@resource.game_time.should == @resource.game_start_time + (GameData::ONE_TURN_IN_HOURS * turns).hours 
		@resource.game_start_time.should == Time.parse( GameData::GAME_STARTING_TIME )
		@resource.turn_count.should == 13
	end

end