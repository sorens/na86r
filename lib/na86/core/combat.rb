class Combat
	def self.surface_attack(  attacking_fleet, salvo, target_fleet, params={} )
		params[:resolve] = :normal if params.empty?

		case params[:resolve]
		when :normal
			Combat::Normal.resolve( attacking_fleet, target_fleet, salvo )
		when :hit_one
			Combat::HitOne.resolve( attacking_fleet, target_fleet, salvo )
		when :miss_one
			Combat::MissOne.resolve( attacking_fleet, target_fleet, salvo )
		when :intercept_one
			Combat::InterceptOne.resolve( attacking_fleet, target_fleet, salvo )
		when :jam_one
			Combat::JamOne.resolve( attacking_fleet, target_fleet, salvo )
		else
		end
	end
end