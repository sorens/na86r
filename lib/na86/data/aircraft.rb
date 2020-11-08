module NA86
    class Aircraft
        attr_accessor :name, :designation, :range, :weapon_system
        attr_accessor :carrier_aircraft, :affiliation, :ecm_rating
        attr_accessor :dog_fighting_rating, :bomber_accuracy, :radar_capability
        attr_accessor :lrcap_missile_ew_avg, :lrcap_missile_ew_max, :lrcap_missile_avg, :lrcap_missile_max
        attr_accessor :lrcap_dogfight_ew_avg, :lrcap_dogfight_ew_max, :lrcap_dogfight_avg, :lrcap_dogfight_ew_max
        attr_accessor :cap_missile_ew_avg, :cap_missile_ew_max, :cap_missile_avg, :cap_missile_max
        attr_accessor :cap_dogfight_ew_avg, :cap_dogfight_ew_max, :cap_dogfight_avg, :cap_dogfight_max
        attr_accessor :utype
        attr_accessor :missiles_remaining

        # aircraft unit types
        TYPE_AIRCRAFT_COMBAT          = "aircraft_combat"
        TYPE_AIRCRAFT_UTIL            = "aircraft_util"
        TYPE_AIRCRAFT_TRANSPORT       = "aircraft_transport"

        MAX_MISSILES        = 10
    
        def Aircraft.setup
            # TODO read in aircraft data from a csv
        end
        
        def initialize(options=nil)
            super()
            return if options.nil?
            self.name = options[:name]
            self.designation = options[:designation]
            self.range = options[:range]
            # TODO look up weapon system indexed by options[:weapon_system], assign to self.weapon_system
            self.carrier_aircraft = options[:carrier_aircraft]
            self.affiliation = options[:affiliation]
            self.ecm_rating = options[:ecm_rating]
            self.dog_fighting_rating = options[:dog_fighting_rating]
            self.bomber_accuracy = options[:bomber_accuracy]
            self.radar_capability = options[:radar_capability]
            self.lrcap_missile_ew_avg = options[:lrcap_missile_ew_avg]
            self.lrcap_missile_ew_max = options[:lrcap_missile_ew_max]
            self.cap_missile_ew_avg = options[:cap_missile_ew_avg]
            self.cap_missile_ew_max = options[:cap_missile_ew_max]
            self.cap_missile_avg = options[:cap_missile_avg]
            self.cap_missile_max = options[:cap_missile_max]
            self.cap_dogfight_ew_avg = options[:cap_dogfight_ew_avg]
            self.cap_dogfight_ew_max = options[:cap_dogfight_ew_max]
            self.cap_dogfight_avg = options[:cap_dogfight_avg]
            self.cap_dogfight_max = options[:cap_dogfight_max]
        end

        def fire_missile(number)
        end
    end
end
