require 'spec_helper'

describe Game do
  # let( :var ) { options = { } }
  
  before( :all ) do
    @user = User.create
    @scenario = Scenario.create
    @game = Game.create( :scenario_id => @scenario.id )
  end
  
  before( :each ) do
  end

  it "is valid" do
    @game.should be_valid
  end
  
  it "should have a valid guid" do
    @game.uuid.should_not be_nil
  end
  
  it "should have a scenario id" do
    @game.scenario_id.should_not be_nil
  end
end