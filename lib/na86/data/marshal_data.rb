module NA86
  class MarshalData
    
    # MarshalData.factory creates a MarshalData object from
    # parameter `data`. if the object created is not of kind
    # MarshalData, NotMarshalData exception is raised.
    def self.factory( data=nil )
      unless data.nil?
      md = Marshal::load data
      unless md.kind_of? MarshalData
        raise Exceptions::NotMarshalData.new
      end
      return md
      end

      # no data to marshal from, create a new one anyway
      return MarshalData.new
    end

    # serialize the data returned from serialize_data
    def serialize
      return Marshal::dump self.serialize_data
    end

    # clients: extend MarshalData and override this method
    # to return the data which should be serialized
    def serialize_data
      # default to serialize everything
      return self
    end
  end
end
