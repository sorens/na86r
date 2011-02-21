class Output 
  def messages
    @messages ||= []
  end
  
  def puts(message) 
    messages << message
  end 
end

def output 
  @output ||= Output.new
end

Given /^I am not yet playing$/ do
end

When /^I start a new game$/ do
  game = NavalGameOne::Game.new( output )
  game.start
end

Given /^I have setup an easy game$/ do
  game = NavalGameOne::Game.new( output )
  game.setup( :new, :color, :solitaire, :four )
	game.start
end

Given /^I have setup a custom game$/ do
  game = NavalGameOne::Game.new( output )
  game.setup( :saved, :black_and_white, :two_player, :one, :campaign2 )
	game.start
end

Then /^I should see \"([^\"]*)"$/ do |message|
  output.messages.should include( message )
end

Given /^I setup a default game$/ do
  @game = NavalGameOne::Game.new( output )
  @game.start
end

Given /^I run game$/ do
  @game.run
end
