module NavalConflict
  class Unit
    
    attr_accessor :name, :classification, :id, :player
    
    def initialize( options )
      @name = options[:name]
      @classification = options[:classification]
      @id = options[:id]
    end
  end
end