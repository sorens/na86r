module NA86
    # Sortie contains a list of aircraft
    #   
    #   each aircraft can act independently with respect to combat
    #   each aircraft starts and returns to the same base/field
    #   sorties perform one mission, then return to refuel/rearm
    class Sortie
        attr_accessor :squadrons
        attr_accessor :mission_type
        attr_accessor :target
            # target could reflect a target to attack or protect depending on mission_type

        # sortie missions
        SORTIE_MISSION_LR_CAP               = "lr_cap"
        SORTIE_MISSION_CAP                  = "cap"
        SORTIE_MISSION_ATTACK               = "attack"
        SORTIE_MISSION_ESCORT               = "escort"
        SORTIE_MISSION_GROUND_SUPPRESSION   = "ground_suppression"
        SORTIE_MISSION_TRANSPORT            = "transport"
        SORTIE_MISSION_TRANSFER             = "transfer"

        def initialize(options=nil)
        end

        def display_name()
        end

        def to_string()
        end

        def missiles_remaining()
        end

        def aircraft_remaining()
        end

        def patrol_area()
        end
    end
end