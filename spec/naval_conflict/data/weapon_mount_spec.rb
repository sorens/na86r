require 'spec_helper'

describe NavalConflict::WeaponMount do
    before(:each) do
        NavalConflict::Ordnance.setup
        @weapon_mount = NavalConflict::WeaponMount.new( NavalConflict::Ordnance::TYPE_HARPOON_SSM, 10, 20 )
        @torpedo = NavalConflict::WeaponMount.new( NavalConflict::Ordnance::TYPE_MK48_TORPEDO, 2 )
    end

    it "should be valid" do
        @weapon_mount.should_not be_nil
        @weapon_mount.ordnance.ordnance_type.should == NavalConflict::Ordnance::TYPE_HARPOON_SSM
        @weapon_mount.max_salvo.should == 10
        @weapon_mount.max_loadout.should == 20
    end

    it "should deduct ordnance when a weapon is fired" do
        @weapon_mount.fire_salvo( 1 )
        @weapon_mount.remaining.should == 19
        @weapon_mount.remaining_salvo.should == 9
        @weapon_mount.is_salvo?.should be_truthy
    end

    it "should fire a max salvo" do
        @weapon_mount.fire_salvo
        @weapon_mount.remaining.should == 10
        @weapon_mount.remaining_salvo.should == 0
        @weapon_mount.is_salvo?.should be_falsey
    end

    it "should allow multiple salvos to be fired" do
        @weapon_mount.fire_salvo
        @weapon_mount.reset_salvo
        @weapon_mount.remaining_salvo.should == 10
        @weapon_mount.fire_salvo
        @weapon_mount.remaining.should == 0
    end

    it "should raise an error when salvo is greater than max allowed salvo size" do
        lambda { @weapon_mount.fire_salvo( 100 ) }.should raise_error( NavalConflict::Exceptions::WeaponMountSalvoLimit )
    end

    it "should raise an error when ordnance has been depleted" do
        @weapon_mount.fire_salvo
        @weapon_mount.reset_salvo
        @weapon_mount.fire_salvo
        @weapon_mount.reset_salvo
        lambda { @weapon_mount.fire_salvo }.should raise_error( NavalConflict::Exceptions::WeaponMountordnanceDepleted )
    end

    it "should raise an error when the salvo has been depleted" do
        @weapon_mount.fire_salvo
        lambda { @weapon_mount.fire_salvo }.should raise_error( NavalConflict::Exceptions::WeaponMountSalvoDepleted )
    end

    it "should allow access to ordnance information" do
        harpoon_ssm = NavalConflict::Ordnance.system( NavalConflict::Ordnance::TYPE_HARPOON_SSM )
        ordnance = @weapon_mount.ordnance
        ordnance.ordnance_class.should == harpoon_ssm.ordnance_class
        ordnance.range.should == harpoon_ssm.range
        ordnance.damage.should == harpoon_ssm.damage
        ordnance.accuracy.should == harpoon_ssm.accuracy
        ordnance.salvo.should == harpoon_ssm.salvo
        ordnance.surface_skimming.should == harpoon_ssm.surface_skimming
    end

    it "should track the total ordnance fired" do
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.fire_salvo 1
        @weapon_mount.ordnance_fired.should == 8
    end

    it "should reset during refit" do
        @weapon_mount.fire_salvo 10
        @weapon_mount.reset_salvo
        @weapon_mount.fire_salvo 10
        @weapon_mount.refit
        @weapon_mount.remaining_salvo.should == 10
        @weapon_mount.remaining.should == 20
    end
end