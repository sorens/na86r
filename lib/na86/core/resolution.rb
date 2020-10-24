module NA86
    class Resolution

        def self.which_unit( units )
            raise Exceptions::BadParameter if units.nil? or ! units.is_a? Array or units.empty?
            ChooseUnit.which_unit( units )
        end

        def self.resolve( source, target, salvo )
            raise 'method not implemented'
        end
    end
end
