class Combat::JamOne < Resolution
	def self.resolve( source, target, salvo )
		salvo.jammed(1)
	end
end