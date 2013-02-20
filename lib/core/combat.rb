class Combat
	def self.surface_attack(  attacking_fleet, salvo, target_fleet, params={} )
		params[:resolve] = :normal if params.empty?

		case params[:resolve]
		when :normal
		when :hit_one
			target_fleet.units[0].apply_damage( salvo.ordnance.damage )
			salvo.hits(1)
		when :miss_one
			salvo.misses(1)
		when :intercept_one
			salvo.intercepts(1)
		when :jam_one
			salvo.jammed(1)
		else
		end
	end
end