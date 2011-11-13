# Unit can be a ship or aircraft
# 
# TODO: add fields for aircraft in schema
class Unit < ActiveRecord::Base
  belongs_to :group
  
  include Parsed
  include Exceptions
  
  after_initialize  :unit_init
  after_save        :unit_save
  
  MAIN_GUN            = "main_gun"
  ANTI_AIRCRAFT       = "anti_aircraft"
  MISSILE_DEFENSE     = "missile_defense"
  MAX_SPEED           = "max_speed"
  CARGO_CAPACITY      = "cargo_capacity"
  DEFENSE_FACTOR      = "defense_factor"
  INITIAL_TASK_FORCE  = "initial_task_force"
  ARRIVAL_DAYS        = "arrival_days"
  CURRENT_DAMAGE      = "current_damage"
  STATUS              = "status"
  MAX_DAMAGE          = "max_damage"
  CURRENT_CARGO_S     = "current_cargo_supplies"
  CURRENT_CARGO_T     = "current_cargo_troops"
  CURRENT_CARGO_A     = "current_cargo_aircraft"
  
  # unit status
  STATUS_AVAILABLE    = "available"
  STATUS_SUNK         = "sunk"
  STATUS_CRIPPLED     = "crippled"
  STATUS_SCUTTLED     = "scuttled"
  STATUS_UNKOWN       = "unknown"
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
    return false if self.status == STATUS_SUNK or self.status == STATUS_DESTROYED
    return true
  end
  
  #
  def load_supplies( value )
    raise CannotLoad.new( self, "supplies" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise NotEnoughCargoCapacity.new( self, "supplies" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_supplies = value
  end
  
  #
  def load_troops( value )
    raise CannotLoad.new( self, "troops" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise NotEnoughCargoCapacity.new( self, "troops" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_troops = value
  end
  
  #
  def load_aircraft( value )
    raise CannotLoad.new( self, "aircraft" ) if self.utype != TYPE_SHIP_AIRCRAFT_CARRIER
    raise NotEnoughCargoCapacity.new( self, "aircraft" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_aircraft = value
  end
  
  #
  def remaining_cargo_capacity
    self.current_cargo_troops + self.current_cargo_supplies + self.current_cargo_aircraft
  end
  
  # attach this unit to the specified group
  def attach( group )
    if group
      raise UnitAlreadyAttached.new( self, group ) if group.units.include? self
      if can_unit_join_group?( group )
        group.units << self
        group.save
        Rails.logger.info "[#{self.display_name}] attached to [#{group.display_name}]"
      end
    end
  end
  
  # dettach this unit from the specified group
  def unattach( group )
    if group
      raise UnitNotAttached.new( self, group ) unless group.units.include? self
      group.units.delete self
      group.save
      Rails.logger.info "[#{self.display_name}] unattached from [#{group.display_name}]"
    end
  end
  
  # display the unit's as an upcase GUID
  def display_name
    "#{self.guid.upcase}"
  end
  
  private

  # be sure to load our JSON data into
  # into a hash that we can easily utilize
  def unit_init

    # initialize our module
    parsed_initialize
    # add the attributes that we're expecting
    add_attribute MAIN_GUN
    add_attribute ANTI_AIRCRAFT
    add_attribute MISSILE_DEFENSE
    add_attribute MAX_SPEED
    add_attribute CARGO_CAPACITY
    add_attribute DEFENSE_FACTOR
    add_attribute INITIAL_TASK_FORCE
    add_attribute ARRIVAL_DAYS
    add_attribute CURRENT_DAMAGE
    add_attribute STATUS
    add_attribute MAX_DAMAGE
    add_attribute CURRENT_CARGO_S
    add_attribute CURRENT_CARGO_T
    add_attribute CURRENT_CARGO_A
    
    # load our parsed data
    load_parsed_data
    # if this is a first time setup, make sure we set an initial
    # current_damage of 0
    if @parsed_data and ! @parsed_data.has_key?( CURRENT_DAMAGE )
      self.current_damage = 0
    end
  end

  # turn our hash into JSON data, ready for strorage
  def unit_save
    self.data = @parsed_data.to_json unless @parsed_data.nil?
  end
  
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
  def load_parsed_data
    if @parsed_data.nil? and ! self.data.nil?
      begin
        @parsed_data = JSON.parse( self.data )
      rescue JSON::ParserError
        @parsed_data = nil
      end
    end
  end
  
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
      self.unattach( self.group ) if self.group
    end
  end
end