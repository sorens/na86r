class Unit < ActiveRecord::Base
  include Parsed
  
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
    cargo_capacity
  end
  
  # we need a method to apply damage so that we can set the
  # unit status appropriately
  def apply_damage( value )
    self.current_damage = value
    if self.utype == TYPE_SHIP_COMBAT or self.utype == TYPE_SHIP_TRANSPORT
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
  def initialize( options = {} )

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
    
    # call our super
    super( options )
    # load our parsed data
    load_parsed_data
    # if this is a first time setup, make sure we set an initial
    # current_damage of 0
    if @parsed_data and ! @parsed_data.has_key?( CURRENT_DAMAGE )
      self.current_damage = 0
      save
    end
  end
  
  # def method_missing( name, *args, &block )
  #   setter = false
  #   method_name = name.to_s
  #   setter = true if method_name and method_name[-1,1] == "="
  #   method_name = method_name[0,method_name.length-1] if setter
  #   if @parsed_data and @parsed_data.has_key?( method_name )
  #     if setter
  #       # a store function
  #       store_data( method_name, args[0] )
  #     else
  #       # a fetch function
  #       fetch_data( method_name )
  #     end
  #   else
  #     Rails.logger.debug "tried to handle [#{method_name}] with args: %p" % [args] unless args.empty?
  #     super
  #   end
  # end
  
  private
  
  # def fetch_data( key )
  #   if @parsed_data and @parsed_data.has_key?( key )
  #     @parsed_data[key]
  #   else
  #     nil
  #   end
  # end
  # 
  # def store_data( key, value )
  #   if @parsed_data
  #     @parsed_data[key] = value
  #     save
  #   end
  # end
  
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
