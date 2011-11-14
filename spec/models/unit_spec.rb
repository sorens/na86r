require 'spec_helper'

describe Unit do
  let( :options_ship_carrier )   { options = { :guid => "CVN68", 
      :name => "Nimitz", 
      :uclass => "CVN",
      :maker => nil,
      :number => "68",
      :utype => Unit::TYPE_SHIP_AIRCRAFT_CARRIER,
      :version => 1,
      :data => "{\"max_speed\":30, \"cargo_capacity\":72, \"main_gun\":0, \"anti_aircraft\":0, 
                \"missile_defense\":75, \"initial_task_force\":16, \"arrival_days\":7, \"status\":\"in_pipeline\", 
                \"defense_factor\":97, \"current_cargo_troops\":0, \"current_cargo_supplies\":0, 
                \"current_cargo_aircraft\":0}"
      }
    }
    
  let( :options_ship_transport ) { options = { :guid => "LPD247",
      :name => "Fearless", 
      :uclass => "LPD",
      :maker => nil,
      :number => "247",
      :utype => Unit::TYPE_SHIP_TRANSPORT,
      :version => 1,
      :data => "{\"max_speed\":20, \"cargo_capacity\":6, \"main_gun\":0, \"anti_aircraft\":0, 
                \"missile_defense\":22, \"initial_task_force\":14, \"arrival_days\":15, \"status\":\"in_pipeline\", 
                \"defense_factor\":14, \"current_cargo_troops\":0, \"current_cargo_supplies\":0,
                \"current_cargo_aircraft\":0}"
      }
    }

  let( :options_ship_submarine ) { options = { :guid => "SSN279",
      :name => "Swiftsure", 
      :uclass => "SSN",
      :maker => nil,
      :number => "279",
      :utype => Unit::TYPE_SHIP_SUBMARINE,
      :version => 1,
      :data => "{\"max_speed\":30, \"cargo_capacity\":0, \"main_gun\":0, \"anti_aircraft\":0, 
                \"missile_defense\":0, \"initial_task_force\":21, \"arrival_days\":0, \"status\":\"available\", 
                \"defense_factor\":30, \"current_cargo_troops\":0, \"current_cargo_supplies\":0,
                \"current_cargo_aircraft\":0}"
      }
    }
    
  let( :options_ship_combat ) { options = { :guid => "CGN154",
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

  let( :options_group_port ) { options = { :gtype => Group::TYPE_GROUP_PORT, :name => "Scapa Flow"} }
  let( :options_group_combat ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF16", :mission => Group::TASK_FORCE_MISSION_COMBAT } }
  let( :options_group_transport ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF14", :mission => Group::TASK_FORCE_MISSION_TRANSPORT } }
  let( :options_group_submarine ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF21", :mission => Group::TASK_FORCE_MISSION_SUBMARINE } }
  let( :options_group_bombardment ) { options = { :gtype => Group::TYPE_GROUP_TASK_FORCE, :name => "TF14", :mission => Group::TASK_FORCE_MISSION_BOMBARDMENT } }
  
  before( :each ) do
    @ship_combat = Unit.create( options_ship_combat )
    @ship_carrier = Unit.create( options_ship_carrier )
    @ship_transport = Unit.create( options_ship_transport )
    @ship_submarine = Unit.create( options_ship_submarine )
    @group_port = Group.create( options_group_port )
    @group_transport = Group.create( options_group_transport )
    @group_combat = Group.create( options_group_combat )
    @group_bombardment = Group.create( options_group_bombardment )
    @group_submarine = Group.create( options_group_submarine )
  end
  
  it "is valid" do
    @ship_combat.should be_valid
  end
  
  it "should have a name" do
    @ship_carrier.name.should == "Nimitz"
  end
  
  it "should have a uclass" do
    @ship_carrier.uclass.should == "CVN"
  end
  
  it "should have an id" do
    @ship_carrier.number.should == "68"
  end
  
  it "should have a guid" do
    @ship_carrier.guid.should == "CVN68"
  end
  
  it "should have data" do
    @ship_carrier.data.length.should > 0
  end
  
  it "should have valid JSON data" do
    JSON.parse( @ship_carrier.data ).empty?.should == false
  end
  
  it "should belong to a player" do
    pending
  end
  
  it "should have a maximum speed" do
    @ship_carrier.max_speed.should == 30
  end
  
  it "should have a current damage" do
    @ship_carrier.current_damage.should >= 0
  end
  
  it "should have a defense factor" do
    @ship_carrier.defense_factor.should >= 0
  end
  
  it "should have a main gun value" do
    @ship_carrier.main_gun.should >= 0
  end
  
  it "should have an anti aircraft value" do
    @ship_carrier.anti_aircraft.should >= 0
  end
  
  it "should have a missile defense value" do
    @ship_carrier.missile_defense.should >= 0
  end
  
  it "should have an initial task force value" do
    @ship_carrier.initial_task_force.should >= 0
  end
  
  it "should have an arrival days value" do
    @ship_carrier.arrival_days.should >= 0
  end
  
  it "should withstand sinking if damage taken is less than maximum allowed damage and it is combat ship" do
    @ship_combat.apply_damage 1
    @ship_combat.status.should_not == Unit::STATUS_SUNK
  end
  
  it "should accumulate damage from multiple hits" do
    @ship_combat.apply_damage 1
    @ship_combat.apply_damage 1
    @ship_combat.apply_damage 1
    @ship_combat.apply_damage 1
    @ship_combat.current_damage.should == 4
  end
  
  it "should withstand sinking if damage taken is less than maximum allowed damage and it is transport ship" do
    @ship_transport.apply_damage 1
    @ship_transport.status.should_not == Unit::STATUS_SUNK
  end
  
  it "should sink if damage taken is greater than 1 and it is a submarine" do
    @ship_submarine.apply_damage 1
    @ship_submarine.status.should == Unit::STATUS_SUNK
  end
  
  it "should sink if damage taken is greater than maximum allowed damage" do
    @ship_combat.apply_damage 100
    @ship_combat.status.should == Unit::STATUS_SUNK
  end
  
  it "should automatically unattach from group when sunk" do
    @ship_combat.attach( @group_combat )
    @ship_combat.apply_damage 100
    @group_combat.include?( @ship_combat ).should be_false
  end
  
  it "should have a cargo capacity" do
    @ship_carrier.cargo_capacity.should == 72
  end
  
  it "should have a status" do
    @ship_combat.status.should == Unit::STATUS_IN_PIPELINE
  end
  
  it "ship can be assigned to a port" do
    @ship_combat.attach( @group_port )
    @group_port.units.include?( @ship_combat ).should be_true
  end
  
  it "a transport/supply ship can be added to a task force with a transport mission" do
    @ship_transport.attach( @group_transport )
    @group_transport.units.include?( @ship_transport ).should be_true
  end
  
  it "a transport/supply ship cannot be added to a task force that does not have transport mission" do
    @ship_transport.attach( @group_combat )
    @group_transport.units.include?( @ship_transport ).should be_false
  end
  
  it "an aircraft carrier can be added to a task force with a combat mission" do
    @ship_carrier.attach( @group_combat )
    @group_combat.units.include?( @ship_carrier ).should be_true
  end

  it "an aircraft carrier can not be added to a task force with a transport mission" do
    @ship_carrier.attach( @group_transport )
    @group_transport.units.include?( @ship_carrier ).should be_false
  end
  
  it "an aircraft carrier can not be added to a task force with a bombardment mission" do
    @ship_carrier.attach( @group_bombardment )
    @group_bombardment.units.include?( @ship_carrier ).should be_false
  end
  
  it "an aircraft carrier can not be added to a task force with a submarine mission" do
    @ship_carrier.attach( @group_submarine )
    @group_submarine.units.include?( @ship_carrier ).should be_false
  end
  
  it "a submarine can be added to a task force with a submarine mission" do
    @ship_submarine.attach( @group_submarine )
    @group_submarine.units.include?( @ship_submarine ).should be_true
  end
  
  it "a submarine can not be added to a task force with a combat mission" do
    @ship_submarine.attach( @group_combat )
    @group_combat.units.include?( @ship_submarine ).should be_false
  end
  
  it "a submarine can not be added to a task force with a bombardment mission" do
    @ship_submarine.attach( @group_bombardment )
    @group_bombardment.units.include?( @ship_submarine ).should be_false
  end
  
  it "a submarine can not be added to a task force with a transport mission" do
    @ship_submarine.attach( @group_transport )
    @group_transport.units.include?( @ship_submarine ).should be_false
  end
  
  it "should have valid JSON data after updating a field" do
    @ship_combat.max_speed = 1
    JSON.parse( @ship_combat.data ).empty?.should == false
  end
  
  it "should raise NoMethodError for an unknown field" do
    lambda { @ship_combat.blah }.should raise_error( NoMethodError )
  end
  
  it "should not have more troops than cargo capacity" do
    lambda { @ship_transport.load_troops( 100 ) }.should raise_error( Exceptions::NotEnoughCargoCapacity )
  end
  
  it "should not have more supplies than cargo capacity" do
    lambda { @ship_transport.load_supplies( 100 ) }.should raise_error( Exceptions::NotEnoughCargoCapacity )
  end
  
  it "should not have more troops and supplies than cargo capacity" do
    lambda { @ship_transport.load_supplies( 100 ).load_troops( 100 ) }.should raise_error( Exceptions::NotEnoughCargoCapacity )
  end
  
  it "transports should now allow aircraft to be loaded" do
    lambda { @ship_transport.load_aircraft( 1 ) }.should raise_error( Exceptions::CannotLoad )
  end
  
  it "aircraft carriers should not allow troops or supplies to be loaded" do
    lambda { @ship_carrier.load_supplies( 1 ) }.should raise_error( Exceptions::CannotLoad )
    lambda { @ship_carrier.load_troops( 1 ) }.should raise_error( Exceptions::CannotLoad )
  end

  it "should not allow the same unit to be added more than once" do
    @ship_combat.attach( @group_port ) # first time should succeed
    lambda { @ship_combat.attach( @group_port ) }.should raise_error( Exceptions::UnitAlreadyAttached ) # second time should fail
  end
  
  it "should allow a unit to be removed" do
    @ship_combat.attach( @group_port )
    @ship_combat.unattach( @group_port )
    @group_port.units.include?( @ship_combat ).should be_false
  end
  
  it "should not allow a unit to be removed if it is not attached" do
    lambda {@ship_combat.unattach( @group_port )}.should raise_error( Exceptions::UnitNotAttached )
  end
end