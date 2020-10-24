class Combat::JamOne < NA86::Resolution
	def self.resolve( source, target, salvo )
		salvo.jammed(1)
	end
end
