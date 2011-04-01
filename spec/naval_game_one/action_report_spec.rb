require 'spec_helper'

module NavalGameOne
	describe ActionReport do
		# let( :options )					{ options = { :name => 'Scapa Flow', 
		# 												:max_allowed_combat_aircraft => 100 }  }
		# let( :strike_aircraft )	{ ["F15", 10] }
		# let( :target )					{ double( 'target', :id => 11, :name => "Task Force #{:id}" ) }
		# 
		# before( :each ) do
		# 	@airbase = Airbase.new( options )
		# 	@airbase.add_aircraft( "F14", 20 )
		# 	@airbase.add_aircraft( "F15", 20 )
		# end
		
		# CVN-NIMITZ HAS BEEN SUNK BY AN AS-6 MISSILE LAUNCHED FROM RAID #123.
		# AP-BASKUNCHAK HAS BEEN SUNK BY A TORPEDO FROM SSN-SWIFTSURE.
		# AEW AIRCRAFT FROM SCAPA FLOW DETECTS MISSILES APPROACHING TF #20
		
		it "should report a a ship sunk by a missile launched from a raid" do
			report = ActionReport.new
			report.target_key = "cvn68"
			report.action_key = "sunk"
			report.source_key = "raid_123"
			report.target_origin_key = nil
			report.source_origin_key = "iceland"
			report.actor_key = nil
			report.actor_origin_key = nil
			report.method_key = "missile"
			report.method_type_key = "as6"
			report.to_s.should == "CVN-NIMITZ HAS BEEN SUNK BY AS-6 MISSILES LAUNCHED FROM RAID #123."
		end
		
		it "should report a ship sunk by a torpedo launched from a submarine" do
		  report = ActionReport.new
		  report.target_key = "cvn68"
		  report.action_key = "sunk"
		  report.source_key = "ssn126"
		  report.method_key = "torpedo"
		  report.to_s.should == "CVN-NIMITZ HAS BEEN SUNK BY TORPEDOS LAUNCHED FROM SSN-SWIFTSURE."
	  end
		
	end
end 