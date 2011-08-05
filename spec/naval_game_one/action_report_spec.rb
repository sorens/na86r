require 'spec_helper'

# I've changed how I want to implement this...
module NavalGameOne
  describe ActionReport do
    # CVN-NIMITZ HAS BEEN SUNK BY AN AS-6 MISSILE LAUNCHED FROM RAID #123.
    # AP-BASKUNCHAK HAS BEEN SUNK BY A TORPEDO FROM SSN-SWIFTSURE.
    # AEW AIRCRAFT FROM SCAPA FLOW DETECTS MISSILES APPROACHING TF #20
    
    it "should report a a ship sunk by a missile launched from a raid" do
      report = ActionReport.new
      report.target = "cvn68"
      report.action = "sunk"
      report.source = "raid_123"
      report.target_origin = nil
      report.source_origin = "iceland"
      report.actor = nil
      report.actor_origin = nil
      report.method = "missile"
      report.method_type = "as6"
      report.message = "CVN-NIMITZ HAS BEEN SUNK BY AS-6 MISSILES LAUNCHED FROM RAID #123."
      report.to_s.should == "CVN-NIMITZ HAS BEEN SUNK BY AS-6 MISSILES LAUNCHED FROM RAID #123."
    end
    
    it "should report a ship sunk by a torpedo launched from a submarine" do
      report = ActionReport.new
      report.target = "cvn68"
      report.action = "sunk"
      report.source = "ssn126"
      report.method = "torpedo"
      report.message = "CVN-NIMITZ HAS BEEN SUNK BY TORPEDOS LAUNCHED FROM SSN-SWIFTSURE."
      report.to_s.should == "CVN-NIMITZ HAS BEEN SUNK BY TORPEDOS LAUNCHED FROM SSN-SWIFTSURE."
    end
    
    it "should report a ship hit by a missile" do
      report = ActionReport.new
      report.target = "cvn68"
      report.action = "hit"
      report.source = "raid_123"
      report.method = "missile"
      report.method_type = "as6"
      report.message = "CVN-NIMITZ HAS BEEN HIT BY AS-6 MISSILES LAUNCHED FROM RAID #123."
      report.to_s.should == "CVN-NIMITZ HAS BEEN HIT BY AS-6 MISSILES LAUNCHED FROM RAID #123."
    end
    
    it "should report inbound missiles detected" do
      report = ActionReport.new
      report.target = "tf_11"
      report.action = "detected"
      report.source = "raid_123"
      report.target_origin = nil
      report.source_origin = "iceland"
      report.actor = "aew"
      report.actor_origin = "scapa_flow"
      report.method = "aircraft"
      report.method_type = nil
      report.message = "AEW AIRCRAFT FROM SCAPA FLOW DETECTS MISSILES LAUNCHED FROM RAID #123 APPROACHING TF #11."
      report.to_s.should == "AEW AIRCRAFT FROM SCAPA FLOW DETECTS MISSILES LAUNCHED FROM RAID #123 APPROACHING TF #11."
    end
    
  end
end 