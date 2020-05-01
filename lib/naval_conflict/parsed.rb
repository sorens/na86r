# defines methods and attributes used to manage a string of data
# that is turned into a Hash at load time. This facilitates having
# to expand our data structures without having to add columns to our
# database tables
module Parsed

  # attributes that this module is expecting to have provided
  # by the including class
  attr :parsed_fields
  attr :parsed_data
  
  # initialize our module
  def parsed_initialize
    @parsed_fields = []
  end
  
  # validate that this key is could exist in our
  # @parsed_data hash
  def valid_attribute?( name )
    # Rails.logger.debug "validating attribute [#{name}]"
    # Rails.logger.debug "fields was nil" if @parsed_fields.nil?
    return false if @parsed_fields.nil?
    # Rails.logger.info "fields includes [#{name}]" if @parsed_fields.include?( name )
    return @parsed_fields.include?( name )
  end
  
  # store which attributes we're expecting so we
  # can pre-determine if we should look up a key
  # in our @parsed_data
  def add_attribute( name )
    unless @parsed_fields.include?( name )
      @parsed_fields << name
    end
  end
  
  # fetch the value for this key from our @parsed_data
  # hash
  def fetch_data( key )
    # Rails.logger.debug "[#{@parsed_data.inspect}]"
    if @parsed_data and @parsed_data.has_key?( key )
      return @parsed_data[key]
    else
      # Rails.logger.debug "no value for [#{key}]"
      nil
    end
  end
  
  # store this key/value pair in our @parsed_data
  # hash for later serialization
  def store_data( key, value )
    if @parsed_data
      # Rails.logger.info "parsed_data is non-nil"
      @parsed_data[key] = value
      save
      # Rails.logger.debug "saved [#{key}] with [#{value}]"
    # else
    #   Rails.logger.debug "parsed_data is nil"
    end
  end
  
  # use method_missing to intercept would-be getters/setter
  # calls via straight-forward syntax such as:
  #
  # self.a = "blah"
  # puts "#{self.a}"
  #
  def method_missing( name_symbol, *params, &block )
    name = name_symbol.to_s
    # Rails.logger.debug "method_missing [#{name}]"
    return if name =~ /^A-Z/
    if name.to_s[-1] == ( '='[0] )    # we have a setter
      # Rails.logger.debug "setter!"
      is_setter = true
      name.sub!( /=$/, '' )
    end
    
    if valid_attribute?( name )
      if is_setter
        # Rails.logger.debug "storing data [#{name}] [#{params}]"
        store_data( name, *params )
      else
        # Rails.logger.debug "fetching data [#{name}]"
        fetch_data( name )
      end
    else
      super( name_symbol, *params, &block )
    end
  end
end