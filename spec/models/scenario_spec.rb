require 'spec_helper'

# create_table "scenarios", :force => true do |t|
#   t.string   "guid"
#   t.integer  "owner_id"
#   t.text     "data"
#   t.integer  "state"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

describe Scenario do
  # let( :options ) { options = { :data => "1" } }
  
  before( :all ) do
    @owner = User.create!( :email => "a@b.com", :password => "123457" )
    @scenario = @owner.scenario.create!( :data => "1", :state => Scenario::SCENARIO_STATE_APPROVED )
  end
  
  before( :each ) do
  end
  
  it "should be valid" do
    @scenario.should be_valid
  end
  
  it "should have a valid guid" do
    @scenario.guid.should_not be_nil
  end
  
  it "should have an owner" do
    @scenario.owner_id.should_not be_nil
  end
  
  it "should have data" do
    @scenario.data.should_not be_nil
  end
  
  it "should have a valid state" do
    @scenario.state.should_not be_nil
  end

end