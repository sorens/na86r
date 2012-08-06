require 'spec_helper'

describe WeaponMount do
	before(:each) do
		Ordance.setup
		@weapon_mount = WeaponMount.new( Ordance::TYPE_HARPOON_SSM, 10, 20 )
		@torpedo = WeaponMount.new( Ordance::TYPE_MK48_TORPEDO, 2 )
	end

	it "should be valid" do
		@weapon_mount.should_not be_nil
		@weapon_mount.ordance.ordance_type.should == Ordance::TYPE_HARPOON_SSM
		@weapon_mount.max_salvo.should == 10
		@weapon_mount.max_loadout.should == 20
	end

	it "should deduct ordance when a weapon is fired" do
		@weapon_mount.fire_salvo( 1 )
		@weapon_mount.remaining.should == 19
		@weapon_mount.remaining_salvo.should == 9
		@weapon_mount.is_salvo?.should be_true
	end

	it "should fire a max salvo" do
		@weapon_mount.fire_salvo
		@weapon_mount.remaining.should == 10
		@weapon_mount.remaining_salvo.should == 0
		@weapon_mount.is_salvo?.should be_false
	end

	it "should allow multiple salvos to be fired" do
		@weapon_mount.fire_salvo
		@weapon_mount.reset_salvo
		@weapon_mount.remaining_salvo.should == 10
		@weapon_mount.fire_salvo
		@weapon_mount.remaining.should == 0
	end

	it "should raise an error when salvo is greater than max allowed salvo size" do
    	lambda { @weapon_mount.fire_salvo( 100 ) }.should raise_error( Exceptions::WeaponMountSalvoLimit )
	end

	it "should raise an error when ordance has been depleted" do
		@weapon_mount.fire_salvo
		@weapon_mount.reset_salvo
		@weapon_mount.fire_salvo
		@weapon_mount.reset_salvo
    	lambda { @weapon_mount.fire_salvo }.should raise_error( Exceptions::WeaponMountOrdanceDepleted )
	end

	it "should raise an error when the salvo has been depleted" do
		@weapon_mount.fire_salvo
    	lambda { @weapon_mount.fire_salvo }.should raise_error( Exceptions::WeaponMountSalvoDepleted )
	end

	it "should allow access to ordance information" do
		harpoon_ssm = Ordance.system( Ordance::TYPE_HARPOON_SSM )
		ordance = @weapon_mount.ordance
		ordance.ordance_class.should == harpoon_ssm.ordance_class
		ordance.range.should == harpoon_ssm.range
		ordance.damage.should == harpoon_ssm.damage
		ordance.accuracy.should == harpoon_ssm.accuracy
		ordance.salvo.should == harpoon_ssm.salvo
		ordance.surface_skimming.should == harpoon_ssm.surface_skimming
	end

	it "should track the total ordance fired" do
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.fire_salvo 1
		@weapon_mount.ordance_fired.should == 8
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