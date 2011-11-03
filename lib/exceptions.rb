module Exceptions
  
  class UnitException < StandardError
  end
  
  class CannotLoad < UnitException
    def initialize( msg )
      super( "cannot load #{msg} into that" )
    end
  end
  
  class NotEnoughCargoCapacity < UnitException
    def initialize( msg )
      super( "too many #{msg}" )
    end
  end
  
end