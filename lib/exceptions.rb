module Exceptions

  class GameUnitException < StandardError
    attr_accessor :game_unit
    def initialize( game_unit=nil, msg=nil )
      @game_unit = game_unit
      msg = "[#{@game_unit.class} <#{@game_unit.uuid}>]: #{msg}"
      super( msg ) unless msg.nil?
    end
  end
  
  class UnitException < GameUnitException
    def initialize( game_unit=nil, msg=nil )
      super(game_unit, msg)
    end
  end
  
  class CannotLoad < UnitException
    def initialize( unit, msg )
      super( unit, "cannot load #{msg} into #{unit.display_name}" )
    end
  end
  
  class NotEnoughCargoCapacity < UnitException
    def initialize( unit, msg )
      super( unit, "too many #{msg} for #{unit.display_name}" )
    end
  end
  
  class UnitAlreadyAttached < UnitException
    def initialize( unit, group )
      super( unit, "#{unit.display_name} already attached to #{group.display_name}" )
    end
  end
  
  class UnitNotAttached < UnitException
    def initialize( unit, group )
      if group
        super( unit, "#{unit.display_name} is not attached to #{group.display_name}" )
      else
        super( unit, "#{unit.display_name} is not attached to any group" )
      end
    end
  end

  # raised when the class is not MarshalData
  class NotMarshalData < StandardError
  end

  # weapon system doesn't exist
  class WeaponSystemInvalid < StandardError
  end

  # request to fire more ordnance than allowed in a salvo
  class WeaponMountSalvoLimit < StandardError
  end

  # weapon mount ordnance has been depleted
  class WeaponMountordnanceDepleted < StandardError
  end

  # weapon mount salvo ordnance has been depleted
  class WeaponMountSalvoDepleted < StandardError
  end

  # not enough elements
  class NotEnoughElements < GameUnitException
  end

  # not configured
  class NotConfigured < StandardError
  end

  # bad parameter
  class BadParameter < StandardError
  end  
end