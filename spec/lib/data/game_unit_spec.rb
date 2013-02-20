require 'spec_helper'

describe GameUnit do
	
	let( :game_unit_01 )			{ GameUnit.new }
	let( :game_unit_02 )			{ GameUnit.new }

	it "should have a uuid" do
		game_unit_01.uuid.should be_present
	end

	it "should have a unique uuid" do
		game_unit_01.uuid.should_not == game_unit_02.uuid
	end

	it "should have unique uuids in large data sets", :speed => 'slow' do
		gua = {}
		for i in 1..100000 do
			gu = GameUnit.new
			gua.key?(gu.uuid).should be_false
			gua[gu.uuid] = gu
		end
	end
end