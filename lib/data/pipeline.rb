# Pipeline helps manage those units which are not available at the start
# of the game but instead are available at a later date
class Pipeline < GameUnit

	attr_accessor :ships

	MAX_DAYS_IN_FUTURE = 1000

	@ships

	def self.factory( units=nil )
		pipeline = Pipeline.new
		# loop over the existing hash of units
		# find the ones with arrival days > 0
		if units
			units.each do |key,unit|
				pipeline.add_unit( unit )
			end
		end

		pipeline
	end

	# add a unit to our pipeline
	def add_unit( unit)
		if unit and unit.is_a? Unit
			if unit.status == Unit::STATUS_IN_PIPELINE or unit.status == Unit::STATUS_AVAILABLE
				unless self.ships.member?( unit.hull_class )
					self.ships[unit.hull_class] = unit
				end
			end
		end
	end

	# remove a unit from our pipeline
	def remove_unit( key )
		if self.ships.member?( key )
			self.ships.delete( key )
		end
	end

	# the number of ships in the pipeline
	def count
		return self.ships.count unless self.ships.nil?
		return 0
	end

	# return an array of ships that match the time to available
	def ships_in_days( days=MAX_DAYS_IN_FUTURE, pipeline_ships=nil )
		pipeline_ships = self.ships if pipeline_ships.nil?
		ships = pipeline_ships.values.reject{ |x| x.arrival_days > days }.collect {|x| x if x.arrival_days <= days}
		ships
	end

	# returns an array of ships that match the hull_symbol and time to available
	def ships_by_type_in_days( hull_symbol, days=MAX_DAYS_IN_FUTURE )
		pipeline_ships = ships_in_days( days )
		ships = pipeline_ships.reject{ |x| ! x.hull_symbol.starts_with?( hull_symbol ) }
		ships
	end

	# advance the pipeline by one turn
	def next_turn
		# reduce everyone's arrival days by 0.5
		if self.ships
			self.ships.values.each do |unit|
				if unit.arrival_days > 0
					unit.arrival_days = unit.arrival_days - 0.5
					unit.arrival_days = 0 if unit.arrival_days < 0
				end
			end
		end
	end

	private
	def initialize
		super()
		@ships = {}
	end

end