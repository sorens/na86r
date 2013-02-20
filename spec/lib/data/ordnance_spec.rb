require 'spec_helper'

describe Ordnance do
	
	before(:each) do
		Ordnance.setup
	end

	it "should raise NoWeaponSystem when an unknown type is requested" do
    	lambda { Ordnance.system( 199999 ) }.should raise_error( Exceptions::WeaponSystemInvalid )
	end

	it "should be valid" do
		ordnance = Ordnance.new( Ordnance::TYPE_ASROC, Ordnance::WEAPON_ASW, 20, 1, 4, 1, true )
		ordnance.ordnance_type.should == Ordnance::TYPE_ASROC
		ordnance.ordnance_class.should == Ordnance::WEAPON_ASW
		ordnance.range.should == 20
		ordnance.damage.should == 1
		ordnance.accuracy.should == 4
		ordnance.salvo.should == 1
		ordnance.surface_skimming.should be_true
	end

	it "should return a ordnance system" do
		ordnance = Ordnance.system( Ordnance::TYPE_STANDARD )
		ordnance.ordnance_class.should == Ordnance::WEAPON_SAM
		ordnance.range.should == 50
		ordnance.damage.should == 1
		ordnance.accuracy.should == 4
		ordnance.salvo.should == 4
		ordnance.surface_skimming.should be_false
	end

end