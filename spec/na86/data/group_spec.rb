require 'spec_helper'

describe NA86::Group do

  let( :group_port_params ) { options =
    {
      :gtype => NA86::Group::TYPE_GROUP_PORT,
      :name => "Scapa Flow"
    }
  }

  let( :group_combat_params ) { options = 
    { 
      :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF16", 
      :mission => NA86::Group::TASK_FORCE_MISSION_COMBAT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }

  let( :group_transport_params ) { options = 
    { 
      :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF14", 
      :mission => NA86::Group::TASK_FORCE_MISSION_TRANSPORT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }
  
  let( :group_submarine_params ) { options = 
    { 
      :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF21", 
      :mission => NA86::Group::TASK_FORCE_MISSION_SUBMARINE, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }
  
  let( :group_bombardment_params ) { options = 
    { 
      :gtype => NA86::Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF14", 
      :mission => NA86::Group::TASK_FORCE_MISSION_BOMBARDMENT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }

  let( :ship_combat_params ) { options = 
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
    
  before( :each ) do
    @ship_combat = NA86::Unit.new( ship_combat_params )
    @group_port = NA86::Group.new( group_port_params )
    @group_transport = NA86::Group.new( group_transport_params )
    @group_combat = NA86::Group.new( group_combat_params )
  end

  it "is valid" do
    @group_combat.should_not be_nil
  end
  
  it "should have a name" do
    @group_combat.name.should == "TF16"
  end
  
  it "should have a gtype" do
    @group_combat.gtype.should == NA86::Group::TYPE_GROUP_TASK_FORCE
  end
  
  it "is a task force, it should have a mission" do
    @group_combat.mission.should == NA86::Group::TASK_FORCE_MISSION_COMBAT
  end
  
  it "should belong to a user" do
    # TODO: fix the spec for user association testing
    pending "not implemented yet"
    fail
  end
  
  it "should have a location_x and location_y" do
    @group_combat.location_x.should > 0 and @group_combat.location_y.should > 0
  end
  
  it "should have a condition of active eletronic warfare" do
    @group_combat.active_ew()
    @group_combat.sensor_state.should == NA86::Group::SENSOR_STATE_ACTIVE_EW
  end
  
  it "should have a condition of passive eletronic warfare" do
    @group_combat.passive_ew()
    @group_combat.sensor_state.should == NA86::Group::SENSOR_STATE_PASSIVE_EW
  end
  
  it "is a task force, it should have an endurance" do
    @group_combat.endurance.should == 60
  end

  it "max speed of group is the curent speed of the slowest ship" do
    @ship_combat.current_speed = 10
    @ship_combat.attach @group_combat
    @group_combat.max_speed.should == @ship_combat.current_speed
  end

  it "max speed should never be lower than crippled speed" do
    @ship_combat.current_speed = 0
    @ship_combat.attach @group_combat
    @group_combat.max_speed.should == NA86::Unit::UNIT_MIN_SPEED
  end

  it "should reduce endurance" do
    @ship_combat.attach @group_combat
    @group_combat.reduce_endurance
    @group_combat.endurance.should == 59
  end

  it "should reduce endurance multiple times" do
    @ship_combat.attach @group_combat
    @group_combat.reduce_endurance
    @group_combat.reduce_endurance
    @group_combat.reduce_endurance
    @group_combat.endurance.should == 57
  end

  it "should reduce endurance by more than 1" do
    @ship_combat.attach @group_combat
    @group_combat.reduce_endurance 2
    @group_combat.endurance.should == 58
  end

  it "endurance should not go below 0" do
    @ship_combat.attach @group_combat
    @group_combat.reduce_endurance 61
    @group_combat.endurance.should == 0
  end
  
end
