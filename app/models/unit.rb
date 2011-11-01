class Unit < ActiveRecord::Base
  # include Parsed
  @parsed_data
  
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
  
  # status
  STATUS_AVAILABLE    = "available"
  STATUS_SUNK         = "sunk"
  STATUS_SCUTTLED     = "scuttled"
  STATUS_UNKOWN       = "unknown"
  STATUS_IN_PIPELINE  = "in_pipeline"
  
  #
  def max_damage
    cargo_capacity
  end
  
  #
  def apply_damage( value )
    Rails.logger.debug "applying damage [#{value}]"
    self.current_damage= value
    Rails.logger.debug "current_damage is now [#{current_damage}]"
    self.status= STATUS_SUNK if ( current_damage >= max_damage )
    Rails.logger.debug "status is now [#{status}]"
  end
  
  # be sure to load our JSON data into
  # into a hash that we can easily utilize
  def initialize( options = {} )
    @fields = []
    super( options )
    load_parsed_data
    if @parsed_data and ! @parsed_data.has_key?( CURRENT_DAMAGE )
      @parsed_data[CURRENT_DAMAGE] = 0
      save
    end
  end
  
  def method_missing( name, *args, &block )
    setter = false
    method_name = name.to_s
    setter = true if method_name and method_name[-1,1] == "="
    method_name = method_name[0,method_name.length-1] if setter
    if @parsed_data and @parsed_data.has_key?( method_name )
      if setter
        # a store function
        store_data( method_name, args[0] )
      else
        # a fetch function
        fetch_data( method_name )
      end
    else
      Rails.logger.debug "tried to handle [#{method_name}] with args: %p" % [args] unless args.empty?
      super
    end
  end
  
  private
  
  def fetch_data( key )
    if @parsed_data and @parsed_data.has_key?( key )
      @parsed_data[key]
    else
      nil
    end
  end
  
  def store_data( key, value )
    if @parsed_data
      @parsed_data[key] = value
      save
    end
  end
  
  def save
    data = @parsed_data.to_json
    super
  end
  
  def load_parsed_data
    if @parsed_data.nil? and ! self.data.nil?
      begin
        @parsed_data = JSON.parse( self.data )
      rescue JSON::ParserError
        @parsed_data = nil
      end
    end
  end
end
