require 'spec_helper'

describe NA86::Ordnance do
    
    before(:each) do
        NA86::Ordnance.setup
    end

    it "should raise NoWeaponSystem when an unknown type is requested" do
        lambda { NA86::Ordnance.system( 199999 ) }.should raise_error( NA86::Exceptions::WeaponSystemInvalid )
    end

    it "should be valid" do
        ordnance = NA86::Ordnance.new( NA86::Ordnance::TYPE_ASROC, NA86::Ordnance::WEAPON_ASW, 20, 1, 4, 1, true )
        ordnance.ordnance_type.should == NA86::Ordnance::TYPE_ASROC
        ordnance.ordnance_class.should == NA86::Ordnance::WEAPON_ASW
        ordnance.range.should == 20
        ordnance.damage.should == 1
        ordnance.accuracy.should == 4
        ordnance.salvo.should == 1
        ordnance.surface_skimming.should be_truthy
    end

    it "should return a ordnance system" do
        ordnance = NA86::Ordnance.system( NA86::Ordnance::TYPE_STANDARD )
        ordnance.ordnance_class.should == NA86::Ordnance::WEAPON_SAM
        ordnance.range.should == 50
        ordnance.damage.should == 1
        ordnance.accuracy.should == 4
        ordnance.salvo.should == 4
        ordnance.surface_skimming.should be_falsey
    end

end
