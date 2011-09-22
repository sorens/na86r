require 'spec_helper'

describe User do

  it "is valid" do
    a = User.create( :email => "a@b.com" )
    a.reset_password!( "1234567", "1234567" )
    a.should be_valid
  end
end