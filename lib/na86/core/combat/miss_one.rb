class Combat::MissOne < NA86::Resolution
	def self.resolve( source, target, salvo )
		salvo.misses(1)
	end
end
