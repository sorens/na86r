require 'spec_helper'

describe Unit do

  let( :ship_carrier_params ) { options = 
    { 
      :name => "Nimitz",
      :hull_symbol => "CVN",
      :hull_number => "68",
      :maker => nil,
      :utype => Unit::TYPE_SHIP_AIRCRAFT_CARRIER,
      :version => 1,
      :status => Unit::STATUS_IN_PIPELINE,
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
      :current_cargo_aircraft => 0
    }
  }
    
  let( :ship_transport_params ) { options = 
    { 
      :name => "Fearless",
      :hull_symbol => "LPD",
      :hull_number => "247",
      :maker => nil,
      :utype => Unit::TYPE_SHIP_TRANSPORT,
      :version => 1,
      :status => Unit::STATUS_IN_PIPELINE,
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
      :current_cargo_aircraft => 0
    }
  }
    
  # let( : ) { options = 
  #   { 
  #     :name => "",
  #     :hull_symbol => "",
  #     :hull_number => "",
  #     :maker => nil,
  #     :utype => Unit::TYPE_SHIP_TRANSPORT,
  #     :version => 1,
  #     :status => Unit::STATUS_IN_PIPELINE,
  #     :max_speed => 20,
  #     :cargo_capacity => 6,
  #     :main_gun => 0,
  #     :anti_aircraft => 0,
  #     :missile_defense => 22,
  #     :initial_task_force => "14",
  #     :arrival_days => 15,
  #     :defense_factor => 14,
  #     :current_cargo_troops => 0,
  #     :current_cargo_supplies => 0,
  #     :current_cargo_aircraft => 0
  #   }
  # }

  let( :ship_submarine_params ) { options = 
    { 
      :name => "Swiftsure",
      :hull_symbol => "SSN",
      :hull_number => "279",
      :maker => nil,
      :utype => Unit::TYPE_SHIP_SUBMARINE,
      :version => 1,
      :status => Unit::STATUS_AVAILABLE,
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
      :current_cargo_aircraft => 0
    }
  }
    
  let( :ship_combat_params ) { options = 
    { 
      :name => "Texas",
      :hull_symbol => "CGN",
      :hull_number => "164",
      :maker => nil,
      :utype => Unit::TYPE_SHIP_COMBAT,
      :version => 1,
      :status => Unit::STATUS_IN_PIPELINE,
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
      :current_cargo_aircraft => 0
    }
  }
    
  let( :group_port_params ) { options =
    {
      :gtype => Group::TYPE_GROUP_PORT,
      :name => "Scapa Flow"
    }
  }

  let( :group_combat_params ) { options = 
    { 
      :gtype => Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF16", 
      :mission => Group::TASK_FORCE_MISSION_COMBAT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }

  let( :group_transport_params ) { options = 
    { 
      :gtype => Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF14", 
      :mission => Group::TASK_FORCE_MISSION_TRANSPORT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }
  
  let( :group_submarine_params ) { options = 
    { 
      :gtype => Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF21", 
      :mission => Group::TASK_FORCE_MISSION_SUBMARINE, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }
  
  let( :group_bombardment_params ) { options = 
    { 
      :gtype => Group::TYPE_GROUP_TASK_FORCE, 
      :name => "TF14", 
      :mission => Group::TASK_FORCE_MISSION_BOMBARDMENT, 
      :endurance => 60, 
      :location_x => 1, 
      :location_y => 1 
    } 
  }
  
  before( :each ) do
    @ship_combat = Unit.new( ship_combat_params )
    @ship_carrier = Unit.new( ship_carrier_params )
    @ship_transport = Unit.new( ship_transport_params )
    @ship_submarine = Unit.new( ship_submarine_params )
    @group_port = Group.new( group_port_params )
    @group_transport = Group.new( group_transport_params )
    @group_combat = Group.new( group_combat_params )
    @group_bombardment = Group.new( group_bombardment_params )
    @group_submarine = Group.new( group_submarine_params )
  end
  
  it "is valid" do
    @ship_carrier.should_not be_nil
  end

  it "should have a name" do
    @ship_carrier.name.should == ship_carrier_params[:name]
  end
  
  it "should have a hull symbol" do
    @ship_carrier.hull_symbol.should == ship_carrier_params[:hull_symbol]
  end
  
  it "should have a hull number" do
    @ship_carrier.hull_number.should == ship_carrier_params[:hull_number]
  end
  
  it "should have a hull classification" do
    @ship_carrier.hull_class.should == "#{ship_carrier_params[:hull_symbol]}#{ship_carrier_params[:hull_number]}"
  end
  
  # it "should belong to a player" do
  #   pending
  # end
  
  it "should have a maximum speed" do
    @ship_carrier.max_speed.should == ship_carrier_params[:max_speed]
  end
  
  it "should have a current damage" do
    @ship_carrier.current_damage.should >= 0
  end
  
  it "should have a defense factor" do
    @ship_carrier.defense_factor.should == ship_carrier_params[:defense_factor]
  end
  
  it "should have a main gun value" do
    @ship_carrier.main_gun.should == ship_carrier_params[:main_gun]
  end
  
  it "should have an anti aircraft value" do
    @ship_carrier.anti_aircraft.should == ship_carrier_params[:anti_aircraft]
  end
  
  it "should have a missile defense value" do
    @ship_carrier.missile_defense.should == ship_carrier_params[:missile_defense]
  end
  
  it "should have an initial task force value" do
    @ship_carrier.initial_task_force.should == ship_carrier_params[:initial_task_force]
  end
  
  it "should have an arrival days value" do
    @ship_carrier.arrival_days.should == ship_carrier_params[:arrival_days]
  end

  it "should have a unit type" do
    @ship_carrier.utype.should == ship_carrier_params[:utype]
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
    @group_combat.include_unit?( @ship_combat ).should be_false
  end
  
  it "should have a cargo capacity" do
    @ship_carrier.cargo_capacity.should == 72
  end
  
  it "should have a status" do
    @ship_combat.status.should == Unit::STATUS_IN_PIPELINE
  end
  
  it "ship can be assigned to a port" do
    @ship_combat.attach( @group_port )
    @group_port.include_unit?( @ship_combat ).should be_true
  end
  
  it "a transport/supply ship can be added to a task force with a transport mission" do
    @ship_transport.attach( @group_transport )
    @group_transport.include_unit?( @ship_transport ).should be_true
  end
  
  it "a transport/supply ship cannot be added to a task force that does not have transport mission" do
    @ship_transport.attach( @group_combat )
    @group_transport.include_unit?( @ship_transport ).should be_false
  end
  
  it "an aircraft carrier can be added to a task force with a combat mission" do
    @ship_carrier.attach( @group_combat )
    @group_combat.include_unit?( @ship_carrier ).should be_true
  end

  it "an aircraft carrier can not be added to a task force with a transport mission" do
    @ship_carrier.attach( @group_transport )
    @group_transport.include_unit?( @ship_carrier ).should be_false
  end
  
  it "an aircraft carrier can not be added to a task force with a bombardment mission" do
    @ship_carrier.attach( @group_bombardment )
    @group_bombardment.include_unit?( @ship_carrier ).should be_false
  end
  
  it "an aircraft carrier can not be added to a task force with a submarine mission" do
    @ship_carrier.attach( @group_submarine )
    @group_submarine.include_unit?( @ship_carrier ).should be_false
  end
  
  it "a submarine can be added to a task force with a submarine mission" do
    @ship_submarine.attach( @group_submarine )
    @group_submarine.include_unit?( @ship_submarine ).should be_true
  end
  
  it "a submarine can not be added to a task force with a combat mission" do
    @ship_submarine.attach( @group_combat )
    @group_combat.include_unit?( @ship_submarine ).should be_false
  end
  
  it "a submarine can not be added to a task force with a bombardment mission" do
    @ship_submarine.attach( @group_bombardment )
    @group_bombardment.include_unit?( @ship_submarine ).should be_false
  end
  
  it "a submarine can not be added to a task force with a transport mission" do
    @ship_submarine.attach( @group_transport )
    @group_transport.include_unit?( @ship_submarine ).should be_false
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
    @ship_combat.unattach
    @group_port.include_unit?( @ship_combat ).should be_false
  end
  
  it "should not allow a unit to be removed if it is not attached" do
    lambda { @ship_combat.unattach }.should raise_error( Exceptions::UnitNotAttached )
  end

  it "should be scuttled" do
    @ship_combat.attach @group_combat
    @ship_combat.scuttle
    @ship_combat.status.should == Unit::STATUS_SCUTTLED
    @ship_combat.group.should be_nil
    @ship_combat.active?.should be_false
  end

end