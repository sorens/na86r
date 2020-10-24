class Combat::InterceptOne < NA86::Resolution
	def self.resolve( source, target, salvo )
		salvo.intercepts(1)
	end
end
