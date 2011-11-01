module Parsed

  def valid_attribute?( name )
    # return false if @fields.nil?
    @fields.include?( name )
  end
  
  def add_attribute( name )
    unless @fields.include?( name )
      @fields << name
    end
  end
  
  def method_missing( name_symbol, *params )
    name = name_symbol.to_s
    Rails.logger.info "method_missing [#{name}]"
    return if name =~ /^A-Z/
    if name.to_s[-1] == ( '='[0] )    # we have a setter
      is_setter = true
      name.sub!( /=$/, '' )
    end
    
    if valid_attribute?( name )
      if is_setter
        instance_variable_set( "@parsed_data[#{name}]", *params )
      else
        instance_variable_get( "@parsed_data[#{name}]", *params )
      end
    # else
    #   super( name_symbol, *params )
    end
  end
end