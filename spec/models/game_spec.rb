require 'spec_helper'

# create_table "games", :force => true do |t|
#   t.string   "guid"
#   t.integer  "time"
#   t.integer  "scenario_id"
#   t.integer  "state"
#   t.text     "setup"
#   t.text     "data"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

describe Game do
  # let( :options_group_port ) { options = { :gtype => Group::TYPE_GROUP_PORT, :name => "Scapa Flow"} }
  
  before( :all ) do
    @user = User.create
    @game = Game.create( :scenario_id => 1 )
    Rails.logger.info "g: [#{@game.inspect}]"
  end
  
  before( :each ) do
  end

  it "is valid" do
    @game.should be_valid
  end
  
  it "should have a valid guid" do
    @game.guid.should_not be_nil
  end
  
  it "should have a scenario id" do
    @game.scenario_id.should_not be_nil
  end
end