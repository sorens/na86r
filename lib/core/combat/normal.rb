class Combat::Normal < Resolution
	def self.resolve( source, target, salvo )
		# iterate over the number of items in the salvo
		for i in 1..salvo.number_active
			roll = Random.new( Time.now.to_i ).rand( 0..100 )
		end
	end
end