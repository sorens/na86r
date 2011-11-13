require 'spec_helper'

    # t.string   "name"
    # t.string   "gtype"
    # t.string   "mission"
    # t.integer  "user_id"
    # t.integer  "sensor_state"
    # t.integer  "location_x"
    # t.integer  "location_y"
    # t.integer  "condition"
    # t.integer  "endurance"
    # t.datetime "created_at"
    # t.datetime "updated_at"

describe Group do

  let( :options_group_port ) { options = { :gtype => Group::TYPE_GROUP_PORT, :name => "Scapa Flow"} }
  let( :options_group_combat ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF16", :mission => Group::TASK_FORCE_MISSION_COMBAT, :endurance => 60, :location_x => 1, :location_y => 1 } }
  let( :options_group_transport ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF14", :mission => Group::TASK_FORCE_MISSION_TRANSPORT, :endurance => 60, :location_x => 1, :location_y => 1 } }
  let( :options_group_submarine ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF21", :mission => Group::TASK_FORCE_MISSION_SUBMARINE, :endurance => 60, :location_x => 1, :location_y => 1 } }
  let( :options_group_bombardment ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF14", :mission => Group::TASK_FORCE_MISSION_BOMBARDMENT, :endurance => 60, :location_x => 1, :location_y => 1 } }

  let( :options_ship_combat ) { 
    options = { 
      :guid => "CGN154",
      :name => "Texas", 
      :uclass => "CGN",
      :maker => nil,
      :number => "154",
      :utype => Unit::TYPE_SHIP_COMBAT,
      :version => 1,
      :data => "{\"max_speed\":35, \"cargo_capacity\":0, \"main_gun\":0, \"anti_aircraft\":2, 
                \"missile_defense\":30, \"initial_task_force\":16, \"arrival_days\":7, \"status\":\"in_pipeline\", 
                \"defense_factor\":14, \"current_cargo_troops\":0, \"current_cargo_supplies\":0,
                \"current_cargo_aircraft\":0}"
    }
  }
    
  before( :each ) do
    @user = User.create
    @ship_combat = Unit.create( options_ship_combat )
    @group_port = Group.create( options_group_port )
    @group_transport = Group.create( options_group_transport )
    @group_combat = Group.create( options_group_combat )
  end

  it "is valid" do
    @group_combat.should be_valid
  end
  
  it "should have a name" do
    @group_combat.name.should == "TF16"
  end
  
  it "should have a gtype" do
    @group_combat.gtype.should == Group::TYPE_GROUP_TASK_FORCE
  end
  
  it "is a task force, it should have a mission" do
    @group_combat.mission.should == Group::TASK_FORCE_MISSION_COMBAT
  end
  
  it "should belong to a user" do
    # TODO: fix the spec for user association testing
    pending
  end
  
  it "should have a location_x and location_y" do
    @group_combat.location_x.should > 0 and @group_combat.location_y.should > 0
  end
  
  it "should have a condition" do
    # TODO: fix the spec for conditions
    pending
  end
  
  it "is a task force, it should have an endurance" do
    @group_combat.endurance.should == 60
  end
  
end