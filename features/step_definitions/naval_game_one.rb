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
  NavalGameOne::Game.new( output )
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include( message )
end