require 'spec_helper'

describe Ordance do
	
	before(:each) do
		Ordance.setup
	end

	it "should raise NoWeaponSystem when an unknown type is requested" do
    	lambda { Ordance.system( 199999 ) }.should raise_error( Exceptions::WeaponSystemInvalid )
	end

	it "should be valid" do
		ordance = Ordance.new( Ordance::TYPE_ASROC, Ordance::WEAPON_ASW, 20, 1, 4, 1, true )
		ordance.ordance_type.should == Ordance::TYPE_ASROC
		ordance.ordance_class.should == Ordance::WEAPON_ASW
		ordance.range.should == 20
		ordance.damage.should == 1
		ordance.accuracy.should == 4
		ordance.salvo.should == 1
		ordance.surface_skimming.should be_true
	end

	it "should return a ordance system" do
		ordance = Ordance.system( Ordance::TYPE_STANDARD )
		ordance.ordance_class.should == Ordance::WEAPON_SAM
		ordance.range.should == 50
		ordance.damage.should == 1
		ordance.accuracy.should == 4
		ordance.salvo.should == 4
		ordance.surface_skimming.should be_false
	end

end