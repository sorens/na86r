# game_data_spec.rb

require 'spec_helper'

describe GameData do

	before( :each ) do
		@resource = GameData.new
	end

	it "should support units" do
		@resource.respond_to?( "units" ).should be_true
		@resource.units.class.should == Hash
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

	it "should suppot after action reports" do
		@resource.respond_to?( "aar" ).should be_true
		@resource.aar.class.should == Array
	end

	it "should serialize and restore data" do
		@resource.units["1"] = "AAAA"
		@resource.units["2"] = "BBBB"
		@resource.units["3"] = "CCCC"
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
		gd.units["1"].should == "AAAA"
		gd.units["2"].should == "BBBB"
		gd.units["3"].should == "CCCC"
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

	it "should allow setting a unit" do
		@resource.respond_to?( "add_unit" ).should be_true
		@resource.add_unit( "XXXX" )
		@resource.units.values.include?( "XXXX" ).should be_true
	end
end