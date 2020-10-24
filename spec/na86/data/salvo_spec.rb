require 'spec_helper'

describe NA86::Salvo do

    let( :ship_cgn_texas ) { options =
        {
            :name => "Texas",
            :hull_symbol => "CGN",
            :hull_number => "39",
            :maker => nil,
            :utype => NA86::Unit::TYPE_SHIP_COMBAT,
            :version => 1,
            :status => NA86::Unit::STATUS_AVAILABLE,
            :max_speed => 35,
            :cargo_capacity => 0,
            :main_gun => 0,
            :anti_aircraft => 2,
            :missile_defense => 30,
            :initial_task_force => "16",
            :arrival_days => 0,
            :defense_factor => 14,
            :current_cargo_troops => 0,
            :current_cargo_supplies => 0,
            :current_cargo_aircraft => 0,
            :electronic_warfare => 4,
            :sonar => 1
        }
    }

    let( :ship_cgn_kirov ) { options =
        {
            :name => "Kirov",
            :hull_symbol => "CGN",
            :hull_number => "",
            :maker => nil,
            :utype => NA86::Unit::TYPE_SHIP_COMBAT,
            :version => 1,
            :status => NA86::Unit::STATUS_AVAILABLE,
            :max_speed => 35,
            :cargo_capacity => 0,
            :main_gun => 0,
            :anti_aircraft => 2,
            :missile_defense => 94,
            :initial_task_force => "1",
            :arrival_days => 0,
            :defense_factor => 50,
            :current_cargo_troops => 0,
            :current_cargo_supplies => 0,
            :current_cargo_aircraft => 0,
            :electronic_warfare => 5,
            :sonar => 2
        }
    }

    let( :source )          { NA86::Unit.new( ship_cgn_texas )}
    let( :target )          { NA86::Unit.new( ship_cgn_kirov )}
    let( :number )          { 4 }
    let( :ordnance )        { NA86::Ordnance.system( NA86::Ordnance::TYPE_HARPOON_SSM ) }

    before( :each ) do
        @salvo = NA86::Salvo.new( ordnance, number, target, source )
    end

    it "should be valid" do
        @salvo.ordnance.should == ordnance
        @salvo.number.should == number
        @salvo.number_active.should == number
        @salvo.number_destroyed.should == 0
        @salvo.target.should == target
        @salvo.source.should == source
    end

    it "should track destroyed elements" do
        number_to_destroy = 1
        @salvo.destroy_element( number_to_destroy )
        @salvo.number_active.should == number - number_to_destroy
    end

    it "should destroy all the elements" do
        number_to_destroy = @salvo.number
        @salvo.destroy_element( number_to_destroy )
        @salvo.number_active.should == number - number_to_destroy
    end

    it "should raise NotEnoughElements when too many elements are destroyed" do
        number_to_destroy = @salvo.number + 1
        lambda { @salvo.destroy_element( number_to_destroy ) }.should raise_error( NA86::Exceptions::NotEnoughElements )
    end

    it "should track hits" do
        number_hit = 1
        @salvo.hits( number_hit )
        @salvo.number_active.should == number - number_hit
        @salvo.number_hits.should == number_hit
    end

    it "should track misses" do
        number_misses = 1
        @salvo.misses( number_misses )
        @salvo.number_active.should == number - number_misses
        @salvo.number_misses.should == number_misses
    end
end
