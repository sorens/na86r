require 'spec_helper'

module NavalGameOne
  describe Raid do
    let( :base )     { double( 'base', :name => "Scapa Flow" ) }
    let( :target )  { double( 'target', :id => 11, :name => "Task Force #{:id}")}
    let( :raid )     { Raid.new( base, [[24, "F14"], [24, "F15"]], target, 100 ) } 
    
    it "should reference a base" do
      raid.base.should equal( base )
    end
    
    it "should use the originators's name" do
      raid.from.should =~ /^Scapa Flow/
    end
    
    it "should report the number of assigned units" do
      raid.count.should equal( 48 )
    end
    
    it "should allow a base to add different aircraft types" do
      raid.squadrons.length.should equal(2)
    end
    
    it "should reference squadrons by type" do
      a = raid.squadron( "F14" )
      a[0].should equal( 24 )
      a[1].should == "F14"
    end
    
    it "should keep track of destroyed units" do
      raid.destroy_unit( "F14" )
      raid.squadron( "F14" )[0].should equal( 23 )
    end
    
    it "should keep track of multiple destroyed units" do
      raid.destroy_unit( "F14", 20 )
      raid.squadron( "F14" )[0].should equal( 4 )
    end
    
    it "should fail to destroy units if you try to destroy too many" do
      expect { raid.destroy_unit( "F14", 48 ) }.to raise_error( Raid::NotEnoughUnitsInRaid )
    end
    
    it "should have a target" do
      raid.target.should equal( target )
    end
    
    it "should have a stand-off range" do
      raid.standoff_range.should equal( 100 )
    end

  end
end