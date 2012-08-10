# Unit can be a ship or aircraft
# 
# TODO: add fields for aircraft in schema
class Unit

  attr_accessor :main_gun, :anti_aircraft, :missile_defense, :max_speed, :cargo_capacity, :defense_factor, :initial_task_force, :arrival_days, :current_damage, :max_damage, :current_cargo_supplies, :current_cargo_troops, :current_cargo_aircraft, :name, :hull_symbol, :hull_number, :current_damage, :status, :utype, :group, :current_speed

  # unit status
  STATUS_UNKOWN       = "unknown"
  STATUS_SUNK         = "sunk"
  STATUS_AVAILABLE    = "available"
  STATUS_CRIPPLED     = "crippled"
  STATUS_SCUTTLED     = "scuttled"
  STATUS_IN_PIPELINE  = "in_pipeline"
  STATUS_DESTROYED    = "destroyed"
  STATUS_CRASHED      = "crashed"
  STATUS_IN_PORT      = "in_port"

  #unit types
  TYPE_SHIP_COMBAT              = "ship_combat"
  TYPE_SHIP_BOMBARDMENT         = "ship_bombardment"
  TYPE_SHIP_AIRCRAFT_CARRIER    = "ship_aircraft_carrier"
  TYPE_SHIP_TRANSPORT           = "ship_transport"
  TYPE_SHIP_SUBMARINE           = "ship_submarine"
  TYPE_AIRCRAFT_COMBAT          = "aircraft_combat"
  TYPE_AIRCRAFT_UTIL            = "aircraft_util"
  TYPE_AIRCRAFT_TRANSPORT       = "aircraft_transport"
  TYPE_BASE_FLIGHT_OPERATIONS   = "base_flight_ops"
  TYPE_BASE_NAVAL               = "base_naval"

  # surface ship types
  TYPE_SHIPS_SURFACE = [
    TYPE_SHIP_COMBAT,
    TYPE_SHIP_BOMBARDMENT,
    TYPE_SHIP_AIRCRAFT_CARRIER,
    TYPE_SHIP_TRANSPORT
  ]

  # status that represent an inactive unit
  STATUS_INACTIVE = [
    STATUS_SUNK,
    STATUS_SCUTTLED,
    STATUS_DESTROYED,
    STATUS_CRASHED
  ]

  # status that represent an active unit
  STATUS_ACTIVE = [
    STATUS_AVAILABLE,
    STATUS_CRIPPLED,
    STATUS_IN_PORT,
    STATUS_IN_PIPELINE
  ]

  # unit max speed
  UNIT_MAX_SPEED              = 30
  # unit crippled (min) speed
  UNIT_MIN_SPEED              = 5

  # max damage is special, it's based on the cargo capacity
  # of our unit in this version
  def max_damage
    self.defense_factor
  end
  
  # we need a method to apply damage so that we can set the
  # unit status appropriately
  def apply_damage( value )
    self.current_damage += value
    Rails.logger.info "[#{self.display_name}] takes[#{value}] damage, current damage is now [#{self.current_damage}]"
    # update our status
    update_ship_status()
  end
  
  # is this unit active?
  def active?
    return false if STATUS_INACTIVE.include? self.status
    return true
  end

  # is this a surface shio?
  def surface_ship?
    return false unless TYPE_SHIPS_SURFACE.include? self.utype
    return true
  end
  
  #
  def load_supplies( value )
    raise Exceptions::CannotLoad.new( self, "supplies" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise Exceptions::NotEnoughCargoCapacity.new( self, "supplies" ) if value  > self.remaining_cargo_capacity
    self.current_cargo_supplies = self.current_cargo_supplies + value
  end
  
  #
  def load_troops( value )
    raise Exceptions::CannotLoad.new( self, "troops" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise Exceptions::NotEnoughCargoCapacity.new( self, "troops" ) if value  > self.remaining_cargo_capacity
    self.current_cargo_troops = self.current_cargo_troops + value
  end
  
  #
  def load_aircraft( value )
    raise Exceptions::CannotLoad.new( self, "aircraft" ) if self.utype != TYPE_SHIP_AIRCRAFT_CARRIER
    raise Exceptions::NotEnoughCargoCapacity.new( self, "aircraft" ) if value  > self.remaining_cargo_capacity
    self.current_cargo_aircraft = self.current_cargo_aircraft + value
  end
  
  #
  def remaining_cargo_capacity
    self.cargo_capacity - (self.current_cargo_troops + self.current_cargo_supplies + self.current_cargo_aircraft)
  end
  
  # attach this unit to the specified group
  def attach( group )
    if group
      raise Exceptions::UnitAlreadyAttached.new( self, group ) if group.include_unit? self
      if can_unit_join_group?( group )
        group.add_unit( self )
        self.group = group
        Rails.logger.info "[#{self.display_name}] attached to [#{self.group.display_name}]"
      end
    end
  end
  
  # scuttle a ship
  def scuttle
    if self.active?
      if self.surface_ship?
        # unattach it from its group
        self.unattach
        # mark its status as scuttled
        self.status = STATUS_SCUTTLED
      end
    end
  end

  # dettach this unit from it's group
  def unattach
    if self.group
      raise Exceptions::UnitNotAttached.new( self, self.group ) unless self.group.include_unit? self
      Rails.logger.info "[#{self.display_name}] unattaching from [#{self.group.display_name}]"
      self.group.remove_unit( self )
      self.group = nil
    else
      raise Exceptions::UnitNotAttached.new( self, nil )
    end
  end
  
  # display the unit's as an upcase hull classification (hull symbol + hull number)
  def display_name
    "#{self.hull_class.upcase}"
  end

  # the hull_class is the combination of the hull_symbol and hull_number
  def hull_class
    "#{self.hull_symbol}#{self.hull_number}"
  end

  def initialize( options )
    @current_damage = 0
    @defense_factor = 0
    @main_gun = 0
    @anti_aircraft = 0
    @missile_defense = 0
    @status = STATUS_UNKOWN
    @current_cargo_troops = 0
    @current_cargo_supplies = 0
    @current_cargo_aircraft = 0
    @current_speed = 0
    if options and options.is_a? Hash
      @name = options[:name]
      @hull_symbol = options[:hull_symbol]
      @hull_number = options[:hull_number]
      @max_speed = options[:max_speed]
      @defense_factor = options[:defense_factor]
      @main_gun = options[:main_gun]
      @anti_aircraft = options[:anti_aircraft]
      @missile_defense = options[:missile_defense]
      @initial_task_force = options[:initial_task_force]
      @arrival_days = options[:arrival_days]
      @utype = options[:utype]
      @cargo_capacity = options[:cargo_capacity]
      @status = options[:status]
    end
  end

  # compare units
  def  ==(unit)
    return self.hull_class == unit.hull_class
  end
 
private

  # be sure to load our JSON data into
  # into a hash that we can easily utilize
  # def unit_init

  #   # initialize our module
  #   parsed_initialize
  #   # add the attributes that we're expecting
  #   ATTRIBUTE_ARRAY.each do |abute|
  #     add_attribute( abute )
  #   end
    
  #   # load our parsed data
  #   load_parsed_data
  #   # if this is a first time setup, make sure we set an initial
  #   # current_damage of 0
  #   if @parsed_data and ! @parsed_data.has_key?( CURRENT_DAMAGE )
  #     self.current_damage = 0
  #   end
  # end

  # turn our hash into JSON data, ready for strorage
  # def unit_save
  #   self.data = @parsed_data.to_json unless @parsed_data.nil?
  # end
  
  # check to make sure this unit can join the group
  def can_unit_join_group?( group )
    result = false
    if group
      case group.gtype
      when Group::TYPE_GROUP_PORT
        result = true # everything can be assigned to one of the ports
      when Group::TYPE_GROUP_AIRFIELD
        # only aircraft
        if self.utype == TYPE_AIRCRAFT_COMBAT or self.utype == TYPE_AIRCRAFT_UTIL or self.utype == TYPE_AIRCRAFT_TRANSPORT
          result = true
        end
      when Group::TYPE_GROUP_TASK_FORCE
        # depends on the task force mission
        case group.mission
        when Group::TASK_FORCE_MISSION_COMBAT
          if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_BOMBARDMENT or self.utype == TYPE_SHIP_AIRCRAFT_CARRIER
            result = true
          end
        when Group::TASK_FORCE_MISSION_BOMBARDMENT
          if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_BOMBARDMENT
            result = true
          end
        when Group::TASK_FORCE_MISSION_TRANSPORT
          if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_TRANSPORT
            result = true
          end
        when Group::TASK_FORCE_MISSION_EVACUATION
          if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_TRANSPORT
            result = true
          end
        when Group::TASK_FORCE_MISSION_SUBMARINE
          if self.utype == TYPE_SHIP_SUBMARINE
            result = true
          end
        when Group::TASK_FORCE_MISSION_RETURN
          result = true
        end
      end
    end
    Rails.logger.info "[#{self.display_name}] can #{result ? '' : 'not '}attach to [#{group.display_name}]"
    result
  end
  
  # grab the string data in self.data and parse it as
  # JSON data. if valid, load it into our @parsed_data
  # attribute for ready use
  # def load_parsed_data
  #   if @parsed_data.nil? and ! self.data.nil?
  #     begin
  #       @parsed_data = JSON.parse( self.data )
  #     rescue JSON::ParserError
  #       @parsed_data = nil
  #     end
  #   end
  # end
  
  # update the ship status with respect to damage
  def update_ship_status
    current_status = self.status
    if self.current_damage >= ( self.max_damage / 2 )
      self.status = STATUS_CRIPPLED
    end
    if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_TRANSPORT or self.utype == TYPE_SHIP_AIRCRAFT_CARRIER
      self.status= STATUS_SUNK if ( self.current_damage >= self.max_damage )
    elsif self.utype == TYPE_SHIP_SUBMARINE
      self.status = STATUS_SUNK if self.current_damage > 0
    elsif self.utype == TYPE_AIRCRAFT_COMBAT or self.utype == TYPE_AIRCRAFT_UTIL or self.utype == TYPE_AIRCRAFT_TRANSPORT
      self.status = STATUS_DESTROYED if self.current_damage > 0
    end
    Rails.logger.info "[#{self.display_name}] status is now [#{self.status.upcase}]" if current_status != self.status
    
    if self.status == STATUS_SUNK
      # sunken ships must be removed from their current group
      if self.group
        unattach
      end
    end
  end
end