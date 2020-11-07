require 'spec_helper'

RSpec.describe "Combat" do

    let( :group_01_combat_params ) { options =
        {
            :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE,
            :name => "TF16",
            :mission => NA86::Group::TASK_FORCE_MISSION_COMBAT,
            :endurance => 60,
            :location_x => 1,
            :location_y => 1
        }
    }

    let( :group_02_combat_params ) { options =
        {
            :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE,
            :name => "TF01",
            :mission => NA86::Group::TASK_FORCE_MISSION_COMBAT,
            :endurance => 60,
            :location_x => 1,
            :location_y => 1
        }
    }

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

    let( :ship_cgn_arkansas ) { options =
        {
            :name => "Arkansas",
            :hull_symbol => "CGN",
            :hull_number => "41",
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

    let( :ship_cgn_frunze ) { options =
        {
            :name => "Frunze",
            :hull_symbol => "CGN",
            :hull_number => "164",
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

    let( :group_combat_01 )     { NA86::Group.new( group_01_combat_params ) }
    let( :group_combat_02 )     { NA86::Group.new( group_02_combat_params ) }
    let( :texas )               { NA86::Unit.new( ship_cgn_texas ) }
    let( :arkansas )            { NA86::Unit.new( ship_cgn_arkansas ) }
    let( :kirov )               { NA86::Unit.new( ship_cgn_kirov ) }
    let( :ssn19 )               { NA86::Ordnance.system( NA86::Ordnance::TYPE_SS_N_19 ) }
    let( :harpoon_ssm )         { NA86::Ordnance.system( NA86::Ordnance::TYPE_HARPOON_SSM ) }
    let( :frunze )              { NA86::Unit.new( ship_cgn_frunze ) }
    let( :salvo )               { NA86::Salvo.new( harpoon_ssm, 4, group_combat_02, group_combat_01 ) }

    before( :each ) do
        NA86::Ordnance.setup
        nato = data("NATO-ships.csv")
        soviet = data("SOVIET-ships.csv")
        @resource = NA86::GameData.new(nato, soviet)
        group_combat_01.add_unit texas
        # @group_combat_01.add_unit @arkansas
        group_combat_02.add_unit kirov
        # @group_combat_02.add_unit @frunze
    end

    # Combat.surface_attack( @group_combat_01, salvo, @group_combat_02, { :resolve => hitOne } )

    context "missiles" do
        context "target: surface group" do
            context "source: surface group" do
                it "should hit a unit" do
                    Combat.surface_attack( group_combat_01, salvo, group_combat_02, { :resolve => :hit_one } )
                    group_combat_02.units[0].current_damage.should == salvo.ordnance.damage
                end
                it "should miss a unit" do
                    Combat.surface_attack( group_combat_01, salvo, group_combat_02, { :resolve => :miss_one } )
                    salvo.number_misses.should == 1
                end
                it "should be intercepted" do
                    Combat.surface_attack( group_combat_01, salvo, group_combat_02, { :resolve => :intercept_one } )
                    salvo.number_intercepts.should == 1
                end
                it "should be jammed" do
                    Combat.surface_attack( group_combat_01, salvo, group_combat_02, { :resolve => :jam_one } )
                    salvo.number_jammed.should == 1
                end
            end
            context "source: air group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
                it "should be jammed" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: submarine group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
                it "should be jammed" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "target: submarine group" do
            context "source: surface group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: air group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: submarine group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "target: air group" do
            context "source: surface group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
                it "should be jammed" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: air group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
                it "should be jammed" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
    end

    context "torpedoes" do
        context "target: surface group" do
            context "source: submarine group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "target: submarine group" do
            context "source: surface group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: submarine group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
    end

    context "projectiles" do
        context "target: surface group" do
            context "source: surface group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: air group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: submarine group" do
                it "should throw InvalidCombatError" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "target: submarine group" do
            context "source: surface group" do
                it "should throw InvalidCombatError" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: air group" do
                it "should throw InvalidCombatError" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: submarine group" do
                it "should throw InvalidCombatError" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "target: air group" do
            context "source: surface group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "source: air group" do
                it "should hit a unit" do
                    pending "not yet implemented"
                    fail
                end
                it "should miss a unit" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
    end

    context "aircraft" do
        context "LR-CAP" do
            context "launch inside LR-CAP range" do
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "launch outside LR-CAP range" do
                it "should not be intercepted" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "CAP" do
            context "launch inside CAP range" do
                it "should be intercepted" do
                    pending "not yet implemented"
                    fail
                end
            end
            context "launch outside CAP range" do
                it "should be not be intercepted" do
                    pending "not yet implemented"
                    fail
                end
            end
        end
        context "range 0" do
            it "should be engaged by surface units" do
                pending "not yet implemented"
                fail
            end
        end
    end

    context "surface group v. surface group" do
        it "should fire missiles" do
            #@group_combat_01.mounts[0].fire( :all, @group_combat_02 )
            #Combat.surface_group_attack( @group1, @group2 )
            pending "not yet implemented"
            fail 
        end

        it "should allow a surface fleet to fire a SAM at an incoming missile" do
            pending "not yet implemented"
            fail 
        end

        it "should allow a surface fleet to fire a torpedo at a submarine" do
            pending "not yet implemented"
            fail 
        end

        it "should allow a surface fleet to fire SSM at another surface fleet" do
            pending "not yet implemented"
            fail 
        end

        it "should allow a surface fleet to fire SAM at an incoming aircraft" do
            pending "not yet implemented"
            fail 
        end

        it "should allow a submarine fleet to fire torpedoes at a surface fleet" do
            pending "not yet implemented"
            fail 
        end

        it "should allow a submarine fleet to fire torpedoes at a submarine fleet" do
            pending "not yet implemented"
            fail 
        end

        it "shoulw allow a submarine fleet to fire SSM missiles at a surface fleet" do
            pending "not yet implemented"
            fail 
        end
    end
end
