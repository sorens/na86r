require 'spec_helper'

describe NavalConflict::Ordnance do
    
    before(:each) do
        NavalConflict::Ordnance.setup
    end

    it "should raise NoWeaponSystem when an unknown type is requested" do
        lambda { NavalConflict::Ordnance.system( 199999 ) }.should raise_error( NavalConflict::Exceptions::WeaponSystemInvalid )
    end

    it "should be valid" do
        ordnance = NavalConflict::Ordnance.new( NavalConflict::Ordnance::TYPE_ASROC, NavalConflict::Ordnance::WEAPON_ASW, 20, 1, 4, 1, true )
        ordnance.ordnance_type.should == NavalConflict::Ordnance::TYPE_ASROC
        ordnance.ordnance_class.should == NavalConflict::Ordnance::WEAPON_ASW
        ordnance.range.should == 20
        ordnance.damage.should == 1
        ordnance.accuracy.should == 4
        ordnance.salvo.should == 1
        ordnance.surface_skimming.should be_truthy
    end

    it "should return a ordnance system" do
        ordnance = NavalConflict::Ordnance.system( NavalConflict::Ordnance::TYPE_STANDARD )
        ordnance.ordnance_class.should == NavalConflict::Ordnance::WEAPON_SAM
        ordnance.range.should == 50
        ordnance.damage.should == 1
        ordnance.accuracy.should == 4
        ordnance.salvo.should == 4
        ordnance.surface_skimming.should be_falsey
    end

end