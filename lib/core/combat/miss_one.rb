class Combat::MissOne < Resolution
	def self.resolve( source, target, salvo )
		salvo.misses(1)
	end
end