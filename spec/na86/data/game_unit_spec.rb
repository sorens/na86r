require 'spec_helper'

describe NA86::GameUnit do
    
    let( :game_unit_01 )            { NA86::GameUnit.new }
    let( :game_unit_02 )            { NA86::GameUnit.new }

    it "should have a uuid" do
        game_unit_01.uuid.should be_truthy
    end

    it "should have a unique uuid" do
        game_unit_01.uuid.should_not == game_unit_02.uuid
    end

    it "should have unique uuids in large data sets", :speed => 'slow' do
        gua = {}
        for i in 1..100000 do
            gu = NA86::GameUnit.new
            gua.key?(gu.uuid).should be_falsey
            gua[gu.uuid] = gu
        end
    end
end
