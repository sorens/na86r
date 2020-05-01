# A Group is a collection of ships (task force), a port or an airfield.
# Basically, anything that will hold units of some type
#
# TODO: need to add attr fields for aircraft in schema
# TODO: fix the user association
# TODO: conditions?
module NavalConflict
  class Group < GameUnit

    attr_accessor :units, :name, :mission, :sensor_state, :gtype, :location_x, :location_y, :endurance

    # group types
    TYPE_GROUP_PORT                   = "port"
    TYPE_GROUP_AIRFIELD               = "airfield"
    TYPE_GROUP_TASK_FORCE             = "task_force"

    # task force missions
    TASK_FORCE_MISSION_COMBAT         = "combat"
    TASK_FORCE_MISSION_BOMBARDMENT    = "bombardment"
    TASK_FORCE_MISSION_TRANSPORT      = "transport"
    TASK_FORCE_MISSION_EVACUATION     = "evacuation"
    TASK_FORCE_MISSION_SUBMARINE      = "submarine"
    TASK_FORCE_MISSION_RETURN         = "return"

    # sensor_state
    SENSOR_STATE_PASSIVE_EW           = 0
    SENSOR_STATE_ACTIVE_EW            = 1

    # display the name of the group as combination
    # of it's name and mission (if it has a mission)
    def display_name
      unless self.mission.nil?
        return "#{@name.upcase}/#{@mission.upcase}"
      else
        return "#{@name.upcase}" if @name
        return "unknown group".upcase if @name.nil?
      end
    end

    # set the task force's electronic warfare systems to ACTIVE
    def active_ew()
      return unless self.gtype == TYPE_GROUP_TASK_FORCE
      self.sensor_state = SENSOR_STATE_ACTIVE_EW
    end

    # set the task force's electronic warfare systems to PASSIVE
    def passive_ew()  
      return unless self.gtype == TYPE_GROUP_TASK_FORCE
      self.sensor_state = SENSOR_STATE_PASSIVE_EW
    end

    # does this group include the unit?
    def include_unit?( unit )
      @units.include? unit
    end

    # add the unit to the group
    def add_unit( unit )
      unless unit.nil?
        unless self.include_unit? unit
          # only if it doens't include the unit already
          self.units << unit
        end
      end
    end

    # remove the unit from the group
    def remove_unit( unit )
      unless unit.nil?
        if self.include_unit? unit
          self.units.delete unit
        end
      end
    end

    # the max speed of the group is the current speed
    # of the slowest ship in the group. it should never
    # be slower than the UNIT_MIN_SPEED, which is the
    # speed for crippled ship
    def max_speed
      speed = Unit::UNIT_MAX_SPEED
      if self.units
        self.units.each do |unit|
          speed = unit.current_speed if unit.current_speed < speed
        end
      end

      # make sure we're not slower than the speed for crippled
      speed = Unit::UNIT_MIN_SPEED if speed < Unit::UNIT_MIN_SPEED

      return speed
    end

    # reduce endurance
    def reduce_endurance( endurance=1 )
      self.endurance = self.endurance - endurance
      self.endurance = 0 if self.endurance < 0
    end

    def to_string()
      "<group name: #{@name}, x: #{@location_x}, y: #{@location_y}, type: #{@gtype}, mission: #{@mission}, display_name #{self.display_name}>"
    end

    # initialize
    def initialize( options=nil )
      super()
      @units ||= Array.new
      @location_x = 0
      @location_y = 0
      @endurance = 0
      if options and options.is_a? Hash
        @name = options[:name]
        @mission = options[:mission]
        @sensor_state = options[:sensor_state]
        @gtype = options[:gtype]
        @location_x = options[:location_x]
        @location_y = options[:location_y]
        @endurance = options[:endurance]
      end
    end
  end
end