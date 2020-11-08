module NA86
    class Squadron
        attr_accessor :aircraft
        attr_accessor :assigned_aircraft
        attr_accessor :number_of_aircraft_assigned

        def initialize(options=nil)
            super()
            return if options.nil?
            self.aircraft = options[:aircraft]
            self.assigned_aircraft = options[:assigned_aircraft]
            self.number_of_aircraft_assigned = self.assigned.length
        end

        def display_name()
            unless self.aircraft.nil?
                return "#{self.designation} x#{self.assigned_aircraft.length}"
            end
                
            return "unknown sortie".upcase
        end

        def to_string()
            return "<sortie aircraft: unknown assigned: #{self.number_of_aircraft_assigned} remaining: #{self.assigned_aircraft.length}>" if self.aircraft.nil?
            "<sortie aircraft: #{self.aircraft.name} #{self.aircraft.designation} assigned: #{self.number_of_aircraft_assigned} remaining: #{self.assigned_aircraft.length}>"
        end

        def missiles_remaining()
            # request number of missiles remaining on each aircraft
            remaining = 0
            self.assigned_aircraft.each do |aircraft|
                remaining += aircraft.missiles_remaining
            end
            return remaining
        end

        def aircraft_remaining()
            return self.assigned_aircraft.length
        end

        def fire_missiles(number)
            raise Exceptions::MissilesExhaustedException(self,nil) if number > self.missiles_remaining()
            remaining = number
            self.aircraft.each do |aircraft|
                missiles_fired = aircraft.fire_number(remaining)
                remaining -= missiles_fired
            end
            return remaining
        end

        def destroy_aircraft(index)
            return if index >= self.assigned_aircraft.length
            self.assigned_aircraft.delete_at(index)
        end
    end
end