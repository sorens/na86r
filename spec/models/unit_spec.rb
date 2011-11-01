require 'spec_helper'

# create_table "units", :force => true do |t|
#   t.string   "guid"
#   t.string   "name"
#   t.string   "uclass"
#   t.string   "maker"
#   t.string   "number"
#   t.string   "utype"
#   t.integer  "version"
#   t.text     "data"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

describe Unit do
  let( :options )   { options = { :guid => "CVN68", 
      :name => "Nimitz", 
      :uclass => "CVN",
      :maker => nil,
      :number => "68",
      :utype => "SHIP",
      :version => 1,
      :data => "{\"max_speed\":30, \"cargo_capacity\":72, \"main_gun\":0, \"anti_aircraft\":0, \"missile_defense\":75, \"task_force\":16, \"arrival_days\":7, \"status\":\"in_pipeline\", \"defense_factor\":97}"
    }
  }
  
  before( :each ) do
    @unit = Unit.new( options )
  end
  
  it "is valid" do
    @unit.should be_valid
  end
  
  it "should have a name" do
    @unit.name.should == "Nimitz"
  end
  
  it "should have a uclass" do
    @unit.uclass.should == "CVN"
  end
  
  it "should have an id" do
    @unit.number.should == "68"
  end
  
  it "should have a guid" do
    @unit.guid.should == "CVN68"
  end
  
  it "should have data" do
    @unit.data.length.should > 0
  end
  
  it "should have valid JSON data" do
    JSON.parse( @unit.data ).empty?.should == false
  end
  
  it "should belong to only one player" do
    pending
  end
  
  it "should have a maximum speed" do
    @unit.max_speed.should == 30
  end
  
  it "should have a current damage" do
    @unit.current_damage.should >= 0
  end
  
  it "should have a defense factor" do
    @unit.defense_factor.should >= 0
  end
  
  it "should have a main gun value" do
    @unit.main_gun.should >= 0
  end
  
  it "should have an anti aircraft value" do
    @unit.anti_aircraft.should >= 0
  end
  
  it "should have a missile defense value" do
    @unit.missile_defense.should >= 0
  end
  
  it "should have a task force value" do
    @unit.task_force.should >= 0
  end
  
  it "should have an arrival days value" do
    @unit.arrival_days.should >= 0
  end
  
  it "should withstand sinking if damage taken is less than maximum allowed damage" do
    @unit.status.should_not == Unit::STATUS_SUNK
  end
  
  it "should sink if damage taken is greater than maximum allowed damage" do
    @unit.apply_damage 100
    @unit.status.should == Unit::STATUS_SUNK
  end
  
  it "should have a cargo capacity" do
    @unit.cargo_capacity.should == 72
  end
  
  it "should have a maximum allowed damage equal to its cargo capacity" do
    @unit.max_damage.should == @unit.cargo_capacity
  end
  
  it "should have a status" do
    @unit.status.should == Unit::STATUS_IN_PIPELINE
  end
  
  it "can be added to a single task force just once" do
    pending
  end
  
  it "can only be added to a transport task force if it is either a troop or supply ship" do
    pending
  end
  
  it "can only be added to a combat task force if it is an aircraft carrier" do
    pending
  end
  
  it "can only be added to an underwater task force if it is a submarine" do
    pending
  end
  
  it "should have valid JSON data after updating a field" do
    @unit.max_speed = 1
    JSON.parse( @unit.data ).empty?.should == false
  end
  
  it "should raise NoMethodError for an unknown field" do
    lambda { @unit.blah }.should raise_error( NoMethodError )
  end
  
end