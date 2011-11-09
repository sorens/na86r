class Unit < ActiveRecord::Base
  belongs_to :user
  
  include Parsed
  include Exceptions
  
  MAIN_GUN        = "main_gun"
  ANTI_AIRCRAFT   = "anti_aircraft"
  MISSILE_DEFENSE = "missile_defense"
  MAX_SPEED       = "max_speed"
  CARGO_CAPACITY  = "cargo_capacity"
  DEFENSE_FACTOR  = "defense_factor"
  TASK_FORCE      = "task_force"
  ARRIVAL_DAYS    = "arrival_days"
  CURRENT_DAMAGE  = "current_damage"
  STATUS          = "status"
  MAX_DAMAGE      = "max_damage"
  CURRENT_CARGO_S = "current_cargo_supplies"
  CURRENT_CARGO_T = "current_cargo_troops"
  CURRENT_CARGO_A = "current_cargo_aircraft"
  
  # unit status
  STATUS_AVAILABLE    = "available"
  STATUS_SUNK         = "sunk"
  STATUS_SCUTTLED     = "scuttled"
  STATUS_UNKOWN       = "unknown"
  STATUS_IN_PIPELINE  = "in_pipeline"
  STATUS_DESTROYED    = "destroyed"
  STATUS_CRASHED      = "crashed"
  STATUS_IN_PORT      = "in_port"
  
  #unit types
  TYPE_SHIP_COMBAT              = "ship_combat"
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
    self.cargo_capacity
  end
  
  # we need a method to apply damage so that we can set the
  # unit status appropriately
  def apply_damage( value )
    self.current_damage = value
    if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_TRANSPORT or self.utype == TYPE_SHIP_AIRCRAFT_CARRIER
      self.status= STATUS_SUNK if ( self.current_damage >= self.max_damage )
    elsif self.utype == TYPE_SHIP_SUBMARINE
      self.status = STATUS_SUNK if value > 0
    elsif self.utype == TYPE_AIRCRAFT_COMBAT or self.utype == TYPE_AIRCRAFT_UTIL or self.utype == TYPE_AIRCRAFT_TRANSPORT
      self.status = STATUS_DESTROYED if value > 0
    end
  end
  
  # is this unit active?
  def active?
    return false if self.status == STATUS_SUNK or self.status == STATUS_DESTROYED
    return true
  end
  
  # be sure to load our JSON data into
  # into a hash that we can easily utilize
  def initialize( user, options = {} )

    # initialize our module
    parsed_initialize
    # add the attributes that we're expecting
    add_attribute MAIN_GUN
    add_attribute ANTI_AIRCRAFT
    add_attribute MISSILE_DEFENSE
    add_attribute MAX_SPEED
    add_attribute CARGO_CAPACITY
    add_attribute DEFENSE_FACTOR
    add_attribute TASK_FORCE
    add_attribute ARRIVAL_DAYS
    add_attribute CURRENT_DAMAGE
    add_attribute STATUS
    add_attribute MAX_DAMAGE
    add_attribute CURRENT_CARGO_S
    add_attribute CURRENT_CARGO_T
    add_attribute CURRENT_CARGO_A
    
    # call our super
    super( user, options )
    # load our parsed data
    load_parsed_data
    # if this is a first time setup, make sure we set an initial
    # current_damage of 0
    if @parsed_data and ! @parsed_data.has_key?( CURRENT_DAMAGE )
      self.current_damage = 0
      save
    end
  end
  
  #
  def load_supplies( value )
    raise CannotLoad.new( "supplies" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise NotEnoughCargoCapacity.new( "supplies" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_supplies = value
  end
  
  #
  def load_troops( value )
    raise CannotLoad.new( "troops" ) if self.utype != TYPE_SHIP_TRANSPORT
    raise NotEnoughCargoCapacity.new( "troops" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_troops = value
  end
  
  #
  def load_aircraft( value )
    raise CannotLoad.new( "aircraft" ) if self.utype != TYPE_SHIP_AIRCRAFT_CARRIER
    raise NotEnoughCargoCapacity.new( "aircraft" ) if (value + remaining_cargo_capacity) > self.cargo_capacity
    self.current_cargo_aircraft = value
  end
  
  #
  def remaining_cargo_capacity
    self.current_cargo_troops + self.current_cargo_supplies + self.current_cargo_aircraft
  end
  
  private
  
  # override our save function to make sure that we
  # have a chance to turn our hash back into JSON data
  # for storage
  def save
    self.data = @parsed_data.to_json
    super
  end
  
  # grab the string data in self.data and parse it as
  # JSON data. if valid, load it into our @parsed_data
  # attribute for ready use
  def load_parsed_data
    if @parsed_data.nil? and ! self.data.nil?
      begin
        @parsed_data = JSON.parse( self.data )
        save
      rescue JSON::ParserError
        @parsed_data = nil
      end
    end
  end
end