require 'CSV'

# Unit can be a ship or aircraft
# 
# TODO: add fields for aircraft in schema
class Unit

  attr_accessor :main_gun, :anti_aircraft, :missile_defense, :max_speed, :cargo_capacity
  attr_accessor :defense_factor, :initial_task_force, :arrival_days, :current_damage
  attr_accessor :max_damage, :current_cargo_supplies, :current_cargo_troops, :current_cargo_aircraft
  attr_accessor :name, :hull_symbol, :hull_number, :current_damage, :status, :utype, :group, :current_speed
  attr_accessor :electronic_warfare, :sonar, :class_id, :id, :weapons

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

  # load as an integer
  LOAD_AS_INTEGER             = true

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
    return "#{self.hull_symbol}-#{self.hull_number}" if self.hull_symbol.present? and self.hull_number.present?
    return "#{self.hull_symbol}-#{self.name}" if self.hull_symbol.present? and self.name.present?
    return "#{self.name}" if self.name.present?
  end

  # attach a weapon system
  def attach_weapon( weapon_mount )
    @weapons << weapon_mount unless @weapons.include? weapon_mount
  end

  def weapons( ordance_class, range )
    mounts_by_class = []
    mounts_by_class = @weapons.reject do |weapon|
      weapon.weapon_class != ordance_class
    end

    mounts_by_range = mounts_by_class.reject do |weapon|
      range > weapon.weapon_range
    end
    return mounts_by_range
  end

  def initialize( options )
    @weapons = []
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
      @name = load_ship_data_from_options( options, "name" )
      @hull_symbol = load_ship_data_from_options( options, "hull_symbol" )
      @hull_number = load_ship_data_from_options( options, "hull_number" )
      @max_speed = load_ship_data_from_options( options, "max_speed", LOAD_AS_INTEGER )
      @defense_factor = load_ship_data_from_options( options, "defense_factor", LOAD_AS_INTEGER )
      @main_gun = load_ship_data_from_options( options, "main_gun", LOAD_AS_INTEGER )
      @anti_aircraft = load_ship_data_from_options( options, "anti_aircraft", LOAD_AS_INTEGER )
      @missile_defense = load_ship_data_from_options( options, "missile_defense", LOAD_AS_INTEGER )
      @initial_task_force = load_ship_data_from_options( options, "initial_task_force" )
      @arrival_days = load_ship_data_from_options( options, "arrival_days", LOAD_AS_INTEGER )
      @utype = load_ship_data_from_options( options, "utype" )
      @cargo_capacity = load_ship_data_from_options( options, "cargo_capacity", LOAD_AS_INTEGER )
      @status = load_ship_data_from_options( options, "status" )
      @electronic_warfare = load_ship_data_from_options( options, "electronic_warfare", LOAD_AS_INTEGER )
      @sonar = load_ship_data_from_options( options, "sonar", LOAD_AS_INTEGER )
      @class_id = load_ship_data_from_options( options, "class_id" )
      @id = load_ship_data_from_options( options, "id" )
    end
  end

  def to_summary
    "#{("%-30s" % self.hull_class)}#{"%2s" % self.main_gun}   #{"%2s" % self.anti_aircraft}   #{"%2s" % self.missile_defense}   #{"%2s" % self.max_speed}   #{"%2s" % self.cargo_capacity}   #{"%2s" % self.defense_factor}   #{"%2s" % self.initial_task_force}     #{"%2s" % self.arrival_days}      #{"%2s" % self.class_id}   #{"%3s" % self.id}"
  end

  # compare units
  def  ==(unit)
    return self.hull_class == unit.hull_class
  end

  def self.load_ships( file, ships )
    Rails.logger.info "loading ships form [#{file}]"
    begin
    CSV.foreach( file, { :headers => :first_row, :return_headers => false } ) do |row|
      unit = load_ship_row( row )
      unless unit.nil?
        ships[unit.hull_class] = unit
        Rails.logger.info unit.to_summary
      end
    end
    rescue Exception => e
      Rails.logger.error e.inspect
    end
  end

  def load_ship_data_from_options_as_integer( options, key )
    return load_ship_data_from_options( options, key, LOAD_AS_INTEGER )
  end

  def load_ship_data_from_options( options, key, as_integer=false )
    value = 0 if as_integer
    value = nil unless as_integer
    value = options[key] if options.has_key? key
    value = options[key.to_sym] if options.has_key? key.to_sym
    value = value.to_i if as_integer
    value = value.to_s unless as_integer or value.nil?
    return value
  end

  def self.load_ship_row( row )
    return nil if row["Class"] == "TOTALS"
    options = {}
    options["hull_symbol"] = load_ship_field("Class", row)
    options["hull_number"] = load_ship_field("Hull #", row)
    options["name"] = load_ship_field("Ship Name", row)
    options["utype"] = load_ship_field("Unit Type", row)
    options["class_name"] = load_ship_field("Class Name", row)
    options["main_gun"] = load_ship_field("MG", row, true)
    options["anti_aircraft"] = load_ship_field("AA", row, true)
    options["missile_defense"] = load_ship_field("MD", row, true)
    options["max_speed"] = load_ship_field("MS", row, true)
    options["cargo_capacity"] = load_ship_field("CC", row, true)
    options["defense_factor"] = load_ship_field("DF", row, true)
    options["initial_task_force"] = load_ship_field("TF", row)
    options["arrival_days"] = load_ship_field("ARV", row, true)
    options["class_id"] = load_ship_field("Class ID", row)
    options["id"] = load_ship_field("ID", row)
    options["electronic_warfare"] = load_ship_field("EW", row, true)
    options["sonar"] = load_ship_field("SONAR", row, true)
    options["ssm_type"] = load_ship_field("SSM Type", row)
    options["ssm_salvo_size"] = load_ship_field("SSM Salvo Size", row, true)
    options["ssm_total"] = load_ship_field("SSM Total", row, true)
    options["aws_type"] = load_ship_field("AWS Type", row)
    options["aws_salvo_size"] = load_ship_field("AWS Salvo Size", row, true)
    options["aws_total"] = load_ship_field("AWS Total", row, true)
    options["ast_type"] = load_ship_field("AST Type", row)
    options["ast_salvo_size"] = load_ship_field("AST Salvo Size", row, true)
    options["ast_total"] = load_ship_field("AST Total", row, true)
    options["helos"] = load_ship_field("HELOs", row, true)
    options["air_recon"] = load_ship_field("AIR RECON", row, true)
    options["air_ew"] = load_ship_field("AIR EW", row, true)
    options["air_asw"] = load_ship_field("AIR ASW", row, true)
    options["air_early_warning"] = load_ship_field("AIR EARLY WARNING", row)
    unit = Unit.new options
    unit
  end

  def self.load_ship_field( field_name, row, as_integer=false )
    value = row[field_name]
    if value.blank? or value == "" or value == "-"
      return nil
    end
    return value.to_i if as_integer
    return value.to_s 
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
    Rails.logger.info "[#{self.hull_class}] can #{result ? '' : 'not '}attach to [#{group.display_name}]"
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