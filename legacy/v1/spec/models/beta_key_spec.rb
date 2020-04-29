require 'spec_helper'

describe BetaKey do

  it "is valid" do
    BetaKey.new.should be_valid
  end
end