module NavalGameOne
	class Airbase
		
		# squadron fields
		SQUADRON_FIELD_TYPE			= 0
		SQUADRON_FIELD_COUNT		= 1
		
		attr_accessor :name, :squadrons, :max_allowed_combat_aircraft, :aircraft_roles, :raids
		
		def initialize( options )
			@name = options[:name]
			@max_allowed_combat_aircraft = options[:max_allowed_combat_aircraft]
			@squadrons = {}
			# aircraft roles :combat, :transport, :search, :aew
			@aircraft_roles = [:combat, :transport, :search, :aew]
			@raids = []
		end
		
		def add_aircraft( type, count, role=:combat )
			if :combat == role
				if squadrons[type].nil?
					squadrons[type] = []
					squadrons[type][SQUADRON_FIELD_TYPE] = type
					squadrons[type][SQUADRON_FIELD_COUNT] = 0
				end
				squadrons[type][SQUADRON_FIELD_COUNT] += count
			elsif :transport == role
			elsif :search == role
			elsif :aew == role
			end
		end
		
		def total_combat_aircraft
			count = 0
			if not squadrons.nil?
				squadrons.each do |key, value|
					count += value[SQUADRON_FIELD_COUNT]
				end
			end
			return count
		end
		
		def create_raid( target, strike_aircraft, standoff_range )
			raise NoAircraftAssigned if 0 == strike_aircraft[1]
			
			aircraft = squadrons[strike_aircraft[0]]
			if not aircraft.nil?
				raise NotEnoughAircraft if strike_aircraft[1] > aircraft[1]
			end
			
			r = Raid.new( self, strike_aircraft, target, standoff_range )
			raids << r
			aircraft[1] -= strike_aircraft[1]
		end
		
		class NotEnoughAircraft < Exception
		end
		
		class NoAircraftAssigned < Exception
		end
		
	end
end
