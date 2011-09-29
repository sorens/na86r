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
      :data => "{}"
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
  
  it "should belong to only one player" do
    pending
  end
  
  it "should have a maximum speed" do
    pending
  end
  
  it "should withstand sinking if damage taken is less than maximum allowed damage" do
    pending
  end
  
  it "should sink if damage taken is greater than maximum allowed damage" do
    pending
  end
  
  it "should have a cargo capacity" do
    pending
  end
  
  it "should have a maximum allowed damage equal to its cargo capacity" do
    pending
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
  
end