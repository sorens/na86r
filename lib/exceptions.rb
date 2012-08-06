module Exceptions
  
  class UnitException < StandardError
  end
  
  class CannotLoad < UnitException
    def initialize( unit, msg )
      super( "cannot load #{msg} into #{unit.display_name}" )
    end
  end
  
  class NotEnoughCargoCapacity < UnitException
    def initialize( unit, msg )
      super( "too many #{msg} for #{unit.display_name}" )
    end
  end
  
  class UnitAlreadyAttached < UnitException
    def initialize( unit, group )
      super( "#{unit.display_name} already attached to #{group.display_name}" )
    end
  end
  
  class UnitNotAttached < UnitException
    def initialize( unit, group )
      if group
        super( "#{unit.display_name} is not attached to #{group.display_name}" )
      else
        super( "#{unit.display_name} is not attached to any group" )
      end
    end
  end

  # raised when the class is not MarshalData
  class NotMarshalData < StandardError
  end

  # weapon system doesn't exist
  class WeaponSystemInvalid < StandardError
  end

  # request to fire more ordance than allowed in a salvo
  class WeaponMountSalvoLimit < StandardError
  end

  # weapon mount ordance has been depleted
  class WeaponMountOrdanceDepleted < StandardError
  end

  # weapon mount salvo ordance has been depleted
  class WeaponMountSalvoDepleted < StandardError
  end
  
end