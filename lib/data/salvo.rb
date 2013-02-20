class Salvo < GameUnit
	attr_accessor :ordnance, :number, :number_destroyed, :target, :source, :number_hits, :number_misses, :number_intercepts, :number_jammed

	def number_active
		number = self.number - self.number_destroyed - self.number_hits - self.number_misses
		return number if number >= 0
		return 0
	end

	def destroy_element( number_to_destroy )
		return self.number_destroyed += number_to_destroy if (self.number - self.number_destroyed - number_to_destroy ) >= 0
		raise Exceptions::NotEnoughElements.new( self, "not enough elements to destroy" )
	end

	def hits( number_hits )
		if ( self.number_active >= number_hits )
			self.number_hits += number_hits
		else
			raise Exceptions::NotEnoughElements.new( self, "not enough active elements" )
		end
	end

	def misses( number_misses )
		if ( self.number_active >= number_misses )
			self.number_misses += number_misses
		else
			raise Exceptions::NotEnoughElements.new( self, "not enough active elements" )
		end
	end

	def intercepts( number_intercepts )
		if ( self.number_active >= number_intercepts )
			self.number_intercepts += number_intercepts
		else
			raise Exceptions::NotEnoughElements.new( self, "not enough active elements" )
		end
	end

	def jammed( number_jammed )
		if ( self.number_active >= number_jammed )
			self.number_jammed += number_jammed
		else
			raise Exceptions::NotEnoughElements.new( self, "not enough active elements" )
		end
	end

	def initialize( ordnance, number, target, source )
		super()
		@ordnance = ordnance
		@number = number
		@target = target
		@source = source
		@number_destroyed = 0
		@number_hits = 0
		@number_misses = 0
		@number_intercepts = 0
		@number_jammed = 0
	end
end