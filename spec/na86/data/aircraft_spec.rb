require 'spec_helper'

RSpec.describe NA86::Aircraft do

    let (:tomcat_params) { options = 
        {
            :name => "Tomcat",
            :designation => "F-14",
            :range => 1000,
            :weapon_system => "Phoenix",
            :carrier_aircraft => true,
            :affiliation => "NATO",
            :ecm_rating => 3,
            :dog_fighting_rating => 4,
            :bomber_accuracy => 10,
            :radar_capability => 8,
            :lrcap_missile_ew_avg => 450,
            :lrcap_missile_ew_max => 550,
            :lrcap_missile_avg => 70,
            :lrcap_missile_max => 75,
            :lrcap_dogfight_ew_avg => 125,
            :lrcap_dogfight_ew_max => 250,
            :lrcap_dogfight_avg => 30,
            :lrcap_dogfight_max => 60,
            :cap_missile_ew_avg => 160,
            :cap_missile_ew_max => 300,
            :cap_missile_avg => 27,
            :cap_missile_max => 55,
            :cap_dogfight_ew_avg => 35,
            :cap_dogfight_ew_max => 70,
            :cap_dogfight_avg => 25,
            :cap_dogfight_max => 50,
            :utype => NA86::Aircraft::TYPE_AIRCRAFT_COMBAT
        }
    }

    before (:each) do 
        NA86::Aircraft.setup
        @tomcat = NA86::Aircraft.new(tomcat_params)
    end

    context "attributes" do
        it "is valid" do
            @tomcat.should_not be_nil
        end

        it "should have a name" do 
            @tomcat.name == "Tomcat"
        end
    end
end