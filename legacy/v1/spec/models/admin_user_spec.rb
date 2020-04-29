require 'spec_helper'

describe AdminUser do

  it "is valid" do
    a = AdminUser.create( :email => "a@b.com" )
    a.reset_password!( "1234567", "1234567" )
    a.should be_valid
  end
end