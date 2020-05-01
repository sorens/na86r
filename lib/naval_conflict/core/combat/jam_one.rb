class Combat::JamOne < NavalConflict::Resolution
	def self.resolve( source, target, salvo )
		salvo.jammed(1)
	end
end