module NA86
    class GameUnit
        # use ModelUuid to generate the uuid
        include NA86::ModelUuid

        attr_accessor :uuid

        def initialize
            if @uuid.nil? or @uuid == ""
                @uuid = generate_uuid( self.to_s )
            end
        end
    end
end
