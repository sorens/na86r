require 'spec_helper'

describe NA86::Pipeline do

    let( :ship_carrier_params ) { options = 
        { 
          :name => "Nimitz",
          :hull_symbol => "CVN",
          :hull_number => "68",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_AIRCRAFT_CARRIER,
          :version => 1,
          :status => NA86::Unit::STATUS_IN_PIPELINE,
          :max_speed => 30,
          :cargo_capacity => 72,
          :main_gun => 0,
          :anti_aircraft => 0,
          :missile_defense => 75,
          :initial_task_force => "16",
          :arrival_days => 7,
          :defense_factor => 97,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 6,
          :sonar => 0
        }
    }

    let( :ship_transport_params ) { options = 
        { 
          :name => "Fearless",
          :hull_symbol => "LPD",
          :hull_number => "247",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_TRANSPORT,
          :version => 1,
          :status => NA86::Unit::STATUS_IN_PIPELINE,
          :max_speed => 20,
          :cargo_capacity => 6,
          :main_gun => 0,
          :anti_aircraft => 0,
          :missile_defense => 22,
          :initial_task_force => "14",
          :arrival_days => 15,
          :defense_factor => 14,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 4,
          :sonar => 0
        }
    }

    let( :ship_submarine_params ) { options = 
        { 
          :name => "Swiftsure",
          :hull_symbol => "SSN",
          :hull_number => "279",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_SUBMARINE,
          :version => 1,
          :status => NA86::Unit::STATUS_AVAILABLE,
          :max_speed => 30,
          :cargo_capacity => 0,
          :main_gun => 0,
          :anti_aircraft => 0,
          :missile_defense => 0,
          :initial_task_force => "21",
          :arrival_days => 0,
          :defense_factor => 30,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 5,
          :sonar => 4
        }
    }

    let( :ship_combat_params_01 ) { options = 
        { 
          :name => "Texas",
          :hull_symbol => "CGN",
          :hull_number => "164",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_COMBAT,
          :version => 1,
          :status => NA86::Unit::STATUS_IN_PIPELINE,
          :max_speed => 35,
          :cargo_capacity => 0,
          :main_gun => 0,
          :anti_aircraft => 2,
          :missile_defense => 30,
          :initial_task_force => "16",
          :arrival_days => 7,
          :defense_factor => 14,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 4,
          :sonar => 1
        }
    }

    let( :ship_combat_params_02 ) { options = 
        { 
          :name => "Halsey",
          :hull_symbol => "CG",
          :hull_number => "23",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_COMBAT,
          :version => 1,
          :status => NA86::Unit::STATUS_IN_PIPELINE,
          :max_speed => 35,
          :cargo_capacity => 0,
          :main_gun => 0,
          :anti_aircraft => 2,
          :missile_defense => 30,
          :initial_task_force => "16",
          :arrival_days => 55,
          :defense_factor => 12,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 4,
          :sonar => 1
        }
    }

    let( :ship_combat_params_03 ) { options = 
        { 
          :name => "Exeter",
          :hull_symbol => "DDG",
          :hull_number => "89",
          :maker => nil,
          :utype => NA86::Unit::TYPE_SHIP_COMBAT,
          :version => 1,
          :status => NA86::Unit::STATUS_AVAILABLE,
          :max_speed => 30,
          :cargo_capacity => 0,
          :main_gun => 0,
          :anti_aircraft => 1,
          :missile_defense => 2,
          :initial_task_force => "16",
          :arrival_days => 0,
          :defense_factor => 8,
          :current_cargo_troops => 0,
          :current_cargo_supplies => 0,
          :current_cargo_aircraft => 0,
          :electronic_warfare => 5,
          :sonar => 2
        }
    }

    before( :each ) do
        #@ships = GameData.nato_ships
        nato = data("NATO-ships.csv")
        soviet = data("SOVIET-ships.csv")
        @game = NA86::GameData.new(nato, soviet)
        @unit01 = NA86::Unit.new( ship_carrier_params )
        @unit02 = NA86::Unit.new( ship_transport_params )
        @unit03 = NA86::Unit.new( ship_submarine_params )
        @unit04 = NA86::Unit.new( ship_combat_params_01 )
        @unit05 = NA86::Unit.new( ship_combat_params_02 )
        @unit06 = NA86::Unit.new( ship_combat_params_03 )
        @ships = {}
        @ships_array = [@unit01,@unit02,@unit03,@unit04,@unit05,@unit06]
        @ships.store( @unit01.hull_class, @unit01 )
        @ships.store( @unit02.hull_class, @unit02 )
        @ships.store( @unit03.hull_class, @unit03 )
        @ships.store( @unit04.hull_class, @unit04 )
        @ships.store( @unit05.hull_class, @unit05 )
        @ships.store( @unit06.hull_class, @unit06 )
    end

    it "should be valid" do
        NA86::Pipeline.factory.should_not be_nil
    end

    it "should allow adding ships via the factory" do
        pipeline = NA86::Pipeline.factory( @ships )
        pipeline.count.should == 6
        pipeline.ships.member?( @unit01.hull_class ).should be_truthy
        pipeline.ships.member?( @unit02.hull_class ).should be_truthy
        pipeline.ships.member?( @unit03.hull_class ).should be_truthy
        pipeline.ships.member?( @unit04.hull_class ).should be_truthy
        pipeline.ships.member?( @unit05.hull_class ).should be_truthy
        pipeline.ships.member?( @unit06.hull_class ).should be_truthy
    end

    it "should allow adding ships one at a time" do
        pipeline = NA86::Pipeline.factory
        pipeline.add_unit( @unit01 )
        pipeline.add_unit( @unit02 )
        pipeline.add_unit( @unit03 )
        pipeline.add_unit( @unit04 )
        pipeline.add_unit( @unit05 )
        pipeline.add_unit( @unit06 )
        pipeline.count.should == @ships_array.count
        pipeline.ships.member?( @unit01.hull_class ).should be_truthy
        pipeline.ships.member?( @unit02.hull_class ).should be_truthy
        pipeline.ships.member?( @unit03.hull_class ).should be_truthy
        pipeline.ships.member?( @unit04.hull_class ).should be_truthy
        pipeline.ships.member?( @unit05.hull_class ).should be_truthy
        pipeline.ships.member?( @unit06.hull_class ).should be_truthy
    end

    it "should only add a unit once" do
        pipeline = NA86::Pipeline.factory
        pipeline.add_unit( @unit01 )
        pipeline.add_unit( @unit01 )
        pipeline.add_unit( @unit01 )
        pipeline.count.should == 1
        pipeline.ships.member?( @unit01.hull_class ).should be_truthy
        pipeline.ships.member?( @unit02.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit03.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit04.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit05.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit06.hull_class ).should_not be_truthy
    end

    it "should remove ships from the pipeline" do
        pipeline = NA86::Pipeline.factory( @ships )
        pipeline.remove_unit( @unit01.hull_class )
        pipeline.remove_unit( @unit03.hull_class )
        pipeline.count.should == 4
        pipeline.ships.member?( @unit01.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit02.hull_class ).should be_truthy
        pipeline.ships.member?( @unit03.hull_class ).should_not be_truthy
        pipeline.ships.member?( @unit04.hull_class ).should be_truthy
        pipeline.ships.member?( @unit05.hull_class ).should be_truthy
        pipeline.ships.member?( @unit06.hull_class ).should be_truthy
    end

    it "should return the ships available by days in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_in_days( 7 )
        ships.count.should == 4
        ships.include?( @unit01 ).should be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should be_truthy
        ships.include?( @unit04 ).should be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should be_truthy
    end

    it "should return all of the ships available" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_in_days
        ships.count.should == @ships_array.count
        ships.include?( @unit01 ).should be_truthy
        ships.include?( @unit02 ).should be_truthy
        ships.include?( @unit03 ).should be_truthy
        ships.include?( @unit04 ).should be_truthy
        ships.include?( @unit05 ).should be_truthy
        ships.include?( @unit06 ).should be_truthy
    end

    it "should return `C` (all combat type) ships available by any day in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "C" )
        ships.count.should == 3
        ships.include?( @unit01 ).should be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should be_truthy
        ships.include?( @unit05 ).should be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `CG` (guided-missile cruisers) ships available by any day in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "CG" )
        ships.count.should == 2
        ships.include?( @unit01 ).should_not be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should be_truthy
        ships.include?( @unit05 ).should be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `CV` (aircraft carriers) ships available by any day in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "CV" )
        ships.count.should == 1
        ships.include?( @unit01 ).should be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should_not be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `L` (landing craft) ships available by any day in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "L" )
        ships.count.should == 1
        ships.include?( @unit01 ).should_not be_truthy
        ships.include?( @unit02 ).should be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should_not be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `C` (all combat) ships available by seven days in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "C", 7 )
        ships.count.should == 2
        ships.include?( @unit01 ).should be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `C` (all combat) ships available by zero days in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "C", 0 )
        ships.count.should == 0
        ships.include?( @unit01 ).should_not be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should_not be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should_not be_truthy
    end

    it "should return `D` (destroyers) ships available by zero days in the future" do
        pipeline = NA86::Pipeline.factory( @ships )
        ships = pipeline.ships_by_type_in_days( "D", 0 )
        ships.count.should == 1
        ships.include?( @unit01 ).should_not be_truthy
        ships.include?( @unit02 ).should_not be_truthy
        ships.include?( @unit03 ).should_not be_truthy
        ships.include?( @unit04 ).should_not be_truthy
        ships.include?( @unit05 ).should_not be_truthy
        ships.include?( @unit06 ).should be_truthy
    end

    it "should decrease the pipeline time by 0.5 days for each turn" do
        pipeline = NA86::Pipeline.factory( @ships )
        current_days = {}
        pipeline.ships.values do |ship| 
            current_days[ship.hull_class] = ship.arrival_days
        end
        pipeline.next_turn
        current_days.keys.each do |key|
            if current_days[key] > 0
                pipeline.ships[key].arrival_days.should == current_days[key] - 0.5
            else
                pipeline.ships[key].arrival_days.should == current_days[key]
            end
        end
    end

    it "should decrease the pipeline time by 1.0 days" do
        pipeline = NA86::Pipeline.factory( @ships )
        current_days = {}
        pipeline.ships.values do |ship| 
            current_days[ship.hull_class] = ship.arrival_days
        end
        pipeline.next_turn
        pipeline.next_turn
        current_days.keys.each do |key|
            if current_days[key] > 0
                pipeline.ships[key].arrival_days.should == current_days[key] - 1.0
            else
                pipeline.ships[key].arrival_days.should == current_days[key]
            end
        end
    end

end
