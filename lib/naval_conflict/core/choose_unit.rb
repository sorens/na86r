module NavalConflict
    class ChooseUnit

        # random
        METHOD_RANDOM       = :random

        # which unit
        METHOD              = METHOD_RANDOM

        def self.which_unit( group_or_unit_array, params={} )
            raise Exceptions::NotConfigured if (METHOD.nil? and params[:method].blank?)
            raise Exceptions::NotEnoughElements if group_or_unit_array.nil?

            # make sure we have an array of units
            if group_or_unit_array.is_a? Group
                units = group_or_unit_array.units
            elsif group_or_unit_array.is_a? Array
                units = group_or_unit_array
            else
                raise Exceptions::BadParameter
            end

            # which method?
            method = METHOD
            # did we override?
            if params[:method]
                case params[:method].to_sym
                when :random
                METHOD_RANDOM
                    method = CHOOSE_RANDOM
                end
            end

            case method
            # choose a random unti
            when METHOD_RANDOM
                which = Random.new(Time.now.to_i).rand(0..units.length-1)
            else
                which = Random.new(Time.now.to_i).rand(0..units.length-1)
            end

            raise Exceptions::BadParameter if which.nil? or which < 0
            which
        end
    end
end