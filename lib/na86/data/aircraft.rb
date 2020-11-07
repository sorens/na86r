module NA86
    class Aircraft
        attr_accessor :name, :designation, :range, :weapon_system
        attr_accessor :carrier_aircraft, :affiliation, :ecm_rating
        attr_accessor :dog_fighting_rating, :bomber_accuracy, :radar_capability
        attr_accessor :lrcap_missile_ew_avg, :lrcap_missile_ew_max, :lrcap_missile_avg, :lrcap_missile_ew_max
        attr_accessor :lrcap_dogfight_ew_avg, :lrcap_dogfight_ew_max, :lrcap_dogfight_avg, :lrcap_dogfight_ew_max
        attr_accessor :cap_missile_ew_avg, :cap_missile_ew_max, :cap_missile_avg, :cap_missile_ew_max
        attr_accessor :cap_dogfight_ew_avg, :cap_dogfight_ew_max, :cap_dogfight_avg, :cap_dogfight_ew_max
        attr_accessor :utype

        def Aircraft.setup
            # TODO read in aircraft data from a csv
        end
        
        def initialize(options)
            # TODO initialize each aircraft from supplied options
        end
    end
end
