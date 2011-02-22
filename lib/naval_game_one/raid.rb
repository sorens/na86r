module NavalGameOne
	class Raid
		
		attr_accessor :base, :squadrons, :target, :designated_name, :standoff_range

		def initialize( base, squadrons, target, standoff_range )
			@base = base
			setup_squadrons( squadrons )
			@target = target
			@designated_name = rand( 400 ) + 1
			@standoff_range = standoff_range
		end
		
		def from
			if base
				return base.name
			else
				return "Raid #{designated_name}"
			end
		end
		
		def count
			count = 0
			if squadrons
				squadrons.each do |s|
					count += s[0]
				end
			end
			return count
		end
		
		def squadron( type )
			if not squadrons.nil?
				squadrons.each do |s|
					if type == s[1]
						return s
					end
				end
			end
			return []
		end
		
		def add_squadron( count, type )
			squadrons = [] if squadrons.nil?
			a = [count,type]
			squadrons << a
		end
		
		def destroy_unit( type, count=1 )
			squad = squadron( type )
			raise NotEnoughUnitsInRaid if count > squad[0] 
			squad[0] -= count if squad and squad[0]
		end
		
		private
		def setup_squadrons( squadrons )
			@squadrons = squadrons
		end
		
		class NotEnoughUnitsInRaid < Exception
		end
		
	end
end
