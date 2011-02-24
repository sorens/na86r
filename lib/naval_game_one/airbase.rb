module NavalGameOne
	class Airbase
		
		attr_accessor :name, :squadrons, :max_allowed_combat_aircraft, :aircraft_roles, :raids
		
		def initialize( options )
			@name = options[:name]
			@max_allowed_combat_aircraft = options[:max_allowed_combat_aircraft]
			@squadrons = Hash.new
			@squadrons.default = 0
			# aircraft roles :combat, :transport, :search, :aew
			@aircraft_roles = [:combat, :transport, :search, :aew]
			@raids = []
		end
		
		def add_aircraft( type, count, role=:combat )
			if ! squadrons.key?( type )
				squadrons[type] = 0
			end
			squadrons[type] += count
			if :combat == role
			elsif :transport == role
			elsif :search == role
			elsif :aew == role
			end
		end
		
		def total_combat_aircraft
			count = 0
			if not squadrons.nil?
				squadrons.each do |key, value|
					count += value
				end
			end
			return count
		end
		
		def create_raid( target, strike_aircraft, standoff_range )
			raise NoAircraftAssigned if 0 == strike_aircraft[1]
			strike_aircraft_type = strike_aircraft[0]
			strike_aircraft_count = strike_aircraft[1]
			aircraft_available = 0
			aircraft_available = squadrons[strike_aircraft_type]
			raise NotEnoughAircraft if aircraft_available < strike_aircraft_count
			
			r = Raid.new( self, strike_aircraft, target, standoff_range )
			raids << r
			squadrons[strike_aircraft_type] -= strike_aircraft_count
		end
		
		class NotEnoughAircraft < Exception
		end
		
		class NoAircraftAssigned < Exception
		end
		
	end
end
